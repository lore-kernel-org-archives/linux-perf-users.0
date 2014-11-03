From: Yogesh Tillu <yogesh.tillu@linaro.org>
Subject: [RFC PATCH 1/5] Application: reads perf cycle counter using perf_event_open syscall
Date: Mon,  3 Nov 2014 20:34:01 +0530
Message-ID: <1415027045-6573-2-git-send-email-yogesh.tillu@linaro.org>
References: <1415027045-6573-1-git-send-email-yogesh.tillu@linaro.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:65091 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbaKCPI1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Nov 2014 10:08:27 -0500
Received: by mail-pd0-f169.google.com with SMTP id y10so11731273pdj.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Nov 2014 07:08:27 -0800 (PST)
In-Reply-To: <1415027045-6573-1-git-send-email-yogesh.tillu@linaro.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: tillu.yogesh@gmail.com, linux-perf-users@vger.kernel.org, linaro-networking@linaro.org, jean.pihet@linaro.org, arnd@linaro.org, Andrew.Pinski@caviumnetworks.com, mike.holmes@linaro.org, ola.liljedahl@linaro.org, magnus.karlsson@avagotech.com, Prasun.Kapoor@caviumnetworks.com, Yogesh Tillu <yogesh.tillu@linaro.org>

This patchset is for application reading perf cycle counter using syscall
perf_event_open. 

Signed-off-by: Yogesh Tillu <yogesh.tillu@linaro.org>
---
 app_readcounter.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 app_readcounter.c

diff --git a/app_readcounter.c b/app_readcounter.c
new file mode 100644
index 0000000..5363dd4
--- /dev/null
+++ b/app_readcounter.c
@@ -0,0 +1,83 @@
+/*
+Application to Read perf cycle counter using perf_event_open syscall
+
+To Run: pass randon number to create busy loop
+e.g.: $./app_readcounter 64
+
+*/
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/syscall.h>
+#include <linux/perf_event.h>
+
+static int fddev = -1;
+__attribute__((constructor)) static void
+init(void)
+{
+	static struct perf_event_attr attr;
+	attr.type = PERF_TYPE_HARDWARE;
+	attr.config = PERF_COUNT_HW_CPU_CYCLES;
+	fddev = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
+}
+
+__attribute__((destructor)) static void
+fini(void)
+{
+	close(fddev);
+}
+
+static inline long long
+cpucycles(void)
+{
+	long long result = 0;
+	if (read(fddev, &result, sizeof(result)) < sizeof(result)) return 0;
+	return result;
+}
+
+/* Simple loop body to keep things interested. Make sure it gets inlined. */
+static inline int
+loop(int* __restrict__ a, int* __restrict__ b, int n)
+{
+	unsigned sum = 0;
+	int i=0;
+	for ( i = 0; i < n; ++i)
+		if(a[i] > b[i])
+			sum += a[i] + 5;
+	return sum;
+}
+
+int
+main(int ac, char **av)
+{
+        long long time_start = 0;
+        long long time_end   = 0;
+
+        int *a  = NULL;
+        int *b  = NULL;
+        int len = 0;
+	int i,sum = 0;
+        if (ac != 2) return -1;
+        len = atoi(av[1]);
+	printf("%s: len = %d\n", av[0], len);
+
+        a = malloc(len*sizeof(*a));
+        b = malloc(len*sizeof(*b));
+
+        for (i = 0; i < len; ++i) {
+                a[i] = i+128;
+                b[i] = i+64;
+        }
+
+        printf("%s: beginning loop\n", av[0]);
+        time_start = cpucycles();
+        sum = loop(a, b, len);
+        time_end   = cpucycles();
+        printf("%s: done. sum = %d; time delta = %llu\n", av[0], sum, time_end - time_start);
+
+        free(a); free(b);
+        return 0;
+}
-- 
1.7.9.5
