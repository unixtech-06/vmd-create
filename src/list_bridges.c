#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFFER_SIZE 1024

int main() {
    FILE *fp;
    char buf[BUFFER_SIZE];
    char command[BUFFER_SIZE];
    char bridge[50];
    char vether[50];
    int bridge_found = 0;

    // ifconfigコマンドを実行し、出力を読み取る
    fp = popen("/sbin/ifconfig", "r");
    if (fp == NULL) {
        perror("popen");
        exit(EXIT_FAILURE);
    }

    // ifconfigの出力を行ごとに読み取ります
    while (fgets(buf, sizeof(buf), fp) != NULL) {
        // ブリッジインターフェイスを識別
        if (strstr(buf, "bridge") != NULL) {
            sscanf(buf, "%s", bridge);
            printf("Bridge: %s\n", bridge);
            bridge_found = 1;
        }

        // vetherインターフェイスを識別
        if (bridge_found && strstr(buf, "vether") != NULL) {
            sscanf(buf, "%s", vether);
            // vetherインターフェイスのIPアドレスを取得するためのifconfigコマンドを構築
            snprintf(command, sizeof(command), "/sbin/ifconfig %s", vether);
            FILE *fp_vether = popen(command, "r");
            if (fp_vether == NULL) {
                perror("popen");
                exit(EXIT_FAILURE);
            }
            // vetherのifconfig出力を解析
            while (fgets(buf, sizeof(buf), fp_vether) != NULL) {
                char *inet = strstr(buf, "inet ");
                if (inet != NULL) {
                    char ip[50];
                    sscanf(inet, "inet %s ", ip);
                    printf("IP Address for %s: %s\n", vether, ip);
                    break; // IPが見つかったのでループを抜ける
                }
            }
            pclose(fp_vether);
            bridge_found = 0; // 次のブリッジを探すためにリセット
        }
    }

    // パイプを閉じる
    pclose(fp);
    return 0;
}

