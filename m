From: Yogesh Tillu <yogesh.tillu@linaro.org>
Subject: [RFC PATCH 3/5] Application: Added test for Direct access of perf counter from userspace using asm.
Date: Mon,  3 Nov 2014 20:34:03 +0530
Message-ID: <1415027045-6573-4-git-send-email-yogesh.tillu@linaro.org>
References: <1415027045-6573-1-git-send-email-yogesh.tillu@linaro.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:52956 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbaKCPIj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Nov 2014 10:08:39 -0500
Received: by mail-pa0-f51.google.com with SMTP id kq14so12387150pab.10
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Nov 2014 07:08:39 -0800 (PST)
In-Reply-To: <1415027045-6573-1-git-send-email-yogesh.tillu@linaro.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: tillu.yogesh@gmail.com, linux-perf-users@vger.kernel.org, linaro-networking@linaro.org, jean.pihet@linaro.org, arnd@linaro.org, Andrew.Pinski@caviumnetworks.com, mike.holmes@linaro.org, ola.liljedahl@linaro.org, magnus.karlsson@avagotech.com, Prasun.Kapoor@caviumnetworks.com, Yogesh Tillu <yogesh.tillu@linaro.org>

This patchset contains Test application for accessing perf cycle counter from
userspace using asm.

Signed-off-by: Yogesh Tillu <yogesh.tillu@linaro.org>
---
 README.directaccess |    8 ++++
 direct_access.c     |   65 ++++++++++++++++++++++++++++
 direct_access.h     |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 README.directaccess
 create mode 100644 direct_access.c
 create mode 100644 direct_access.h

diff --git a/README.directaccess b/README.directaccess
new file mode 100644
index 0000000..99e929c
--- /dev/null
+++ b/README.directaccess
@@ -0,0 +1,8 @@
+To Cross-compile application:
+ ~/arm64-tc-14.06/bin/aarch64-linux-gnu-gcc -std=gnu99 -O3 direct_access.c
+ -o direct_access
+
+Run:
+1) Insert kernel module to enable userspace access of perf cycle counter
+2) $./direct_access 64 [ Pass same random number as with test 
+			of perf_event_open ]
diff --git a/direct_access.c b/direct_access.c
new file mode 100644
index 0000000..7a9e9b2
--- /dev/null
+++ b/direct_access.c
@@ -0,0 +1,65 @@
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include "direct_access.h"
+/* Simple loop body to keep things interested. Make sure it gets inlined. */
+static inline int
+loop(int* __restrict__ a, int* __restrict__ b, int n)
+{
+	unsigned sum = 0;
+	for (int i = 0; i < n; ++i)
+		if(a[i] > b[i])
+			sum += a[i] + 5;
+	return sum;
+}
+
+int
+main(int ac, char **av)
+{
+	uint32_t time_start = 0;
+	uint32_t time_end   = 0;
+	int result=0;
+	int *a  = NULL;
+	int *b  = NULL;
+	int len = 0;
+	int sum = 0;
+	int i;
+
+	if (ac != 2) return -1;
+	len = atoi(av[1]);
+
+	a = malloc(len*sizeof(*a));
+	b = malloc(len*sizeof(*b));
+
+	for (int i = 0; i < len; ++i) {
+		a[i] = i+128;
+		b[i] = i+64;
+	}
+/* Open Counter */
+	if(odph_perf_open_counter()!=0)
+		{
+			printf("Error in perf_open_counter\n");
+			goto cleanup;
+		}		
+	printf("\nbeginning busy loop for %s len=%d \n", av[0],len);
+/* Read Counter  with Busy loop */
+	time_start = odph_perf_read_counter();
+	sum = loop(a, b, len);
+	time_end   = odph_perf_read_counter();
+	printf("**********************************************************************\n");
+	printf("Busyloop sum = %d\nTime delta Including Busyloop = %lu [clockcycle]\n", sum, time_end - time_start);
+
+/* Read Counter with profiling read_counter */
+	time_start = odph_perf_read_counter();
+	odph_perf_read_counter();
+	time_end   = odph_perf_read_counter();
+	printf("\nTime delta Without Busyloop   = %lu   [clockcycle]\n", time_end - time_start);
+	printf("**********************************************************************\n");
+
+/* Close Counter */
+	odph_perf_close_counter();
+	free(a); free(b);
+	return 0;
+cleanup: 
+	return -1;
+}
diff --git a/direct_access.h b/direct_access.h
new file mode 100644
index 0000000..f7ac20b
--- /dev/null
+++ b/direct_access.h
@@ -0,0 +1,117 @@
+/* Copyright (c) 2014, Linaro Limited
+ * All rights reserved.
+ *
+ * SPDX-License-Identifier:     BSD-3-Clause
+ */
+
+
+/**
+ * @file
+ *
+ * Performance Counter Direct access Header
+ */
+
+#ifndef DIRECT_ACCESS_H_
+#define DIRECT_ACCESS_H_
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#if __aarch64__ /**< Check for ArmV8 */
+#define ARMV8_PMCNTENSET_EL0_ENABLE (1<<31) /**< Enable Perf count reg */
+#endif
+ 
+/**
+ * Open Performance counter 
+ *
+ * @note api to enable performance counters in system, this function does
+ * enable sequence for respective arm versions
+ * 
+ * @param void
+ *
+ * @return 0 if open successfully, otherwise -1
+ */
+static inline int odph_perf_open_counter(void)
+{
+
+#if __aarch64__
+/*  Performance Monitors Count Enable Set register bit 31:0 disable, 1 enable */
+	asm volatile("msr pmcntenset_el0, %0" : : "r" (ARMV8_PMCNTENSET_EL0_ENABLE));
+	return 0;
+#elif defined(__ARM_ARCH_7A__)
+	return 0;
+#else
+	#error Unsupported Architecture
+	return -1;
+#endif
+}
+
+/**
+ * Read Performance counter 
+ *
+ * @note api to read performance cycle counters in system
+ * 
+ * @param void
+ *
+ * @return cycle counter value if read successfully, otherwise -1
+ */
+static inline uint64_t
+odph_perf_read_counter(void)
+{
+uint64_t ret = 0;
+#if  defined __aarch64__     
+	asm volatile("mrs %0, pmccntr_el0" : "=r" (ret)); 
+	return ret;
+#elif defined(__ARM_ARCH_7A__)
+	asm volatile("mrc p15, 0, %0, c9, c13, 0" : "=r"(ret));
+	return ret;
+#else
+	#error Unsupported architecture/compiler!
+	return -1;
+#endif
+}
+
+/**
+ * Write Performance counter 
+ *
+ * @note api to write value to Performance counter, 
+ * NA for now 
+ * 
+ * @param void
+ *
+ * @return 0 if written successfully, otherwise -1
+ */
+static inline int odph_perf_write_counter(void)
+{
+/* Stub */
+}
+
+/**
+ * Close Performance counter 
+ *
+ * @note api to perform close sequnce for cycle counters in system
+ * 
+ * @param void
+ *
+ * @return 0 if close successfully, otherwise -1
+ */
+static inline int odph_perf_close_counter(void)
+{
+#if  defined __aarch64__     
+	/* Performance Monitors Count Enable Set register bit 31:0 disable, 1 enable */
+	asm volatile("msr pmcntenset_el0, %0" : : "r" (0<<31));
+	/* Note above statement does not really clearing register...refer to doc */
+	return 0;
+#elif defined(__ARM_ARCH_7A__)
+	return 0;
+#else
+	#error Unsupported architecture/compiler!
+	return -1;
+#endif
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* DIRECT_ACCESS_H_ */
-- 
1.7.9.5
