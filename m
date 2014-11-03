From: Yogesh Tillu <yogesh.tillu@linaro.org>
Subject: [RFC PATCH 4/5]ARM64: Kernel: To read PMU cycle counter through vDSO Path
Date: Mon,  3 Nov 2014 20:34:04 +0530
Message-ID: <1415027045-6573-5-git-send-email-yogesh.tillu@linaro.org>
References: <1415027045-6573-1-git-send-email-yogesh.tillu@linaro.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:42698 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbaKCPIp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Nov 2014 10:08:45 -0500
Received: by mail-pd0-f169.google.com with SMTP id y10so11686119pdj.28
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Nov 2014 07:08:45 -0800 (PST)
In-Reply-To: <1415027045-6573-1-git-send-email-yogesh.tillu@linaro.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: tillu.yogesh@gmail.com, linux-perf-users@vger.kernel.org, linaro-networking@linaro.org, jean.pihet@linaro.org, arnd@linaro.org, Andrew.Pinski@caviumnetworks.com, mike.holmes@linaro.org, ola.liljedahl@linaro.org, magnus.karlsson@avagotech.com, Prasun.Kapoor@caviumnetworks.com, Yogesh Tillu <yogesh.tillu@linaro.org>

Kernel patchset to enable vDSO path for reading PMU cycle counter.

Signed-off-by: Yogesh Tillu <yogesh.tillu@linaro.org>
---
 arch/arm64/kernel/vdso/Makefile     |    6 +++---
 arch/arm64/kernel/vdso/vdso.lds.S   |    5 +++++
 arch/arm64/kernel/vdso/vdso_perfc.c |   20 ++++++++++++++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/kernel/vdso/vdso_perfc.c

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 6d20b7d..4fde490 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -5,7 +5,7 @@
 # Heavily based on the vDSO Makefiles for other archs.
 #
 
-obj-vdso := gettimeofday.o note.o sigreturn.o
+obj-vdso := gettimeofday.o note.o sigreturn.o armpmu.o
 
 # Build rules
 targets := $(obj-vdso) vdso.so vdso.so.dbg
@@ -43,8 +43,8 @@ $(obj)/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 	$(call if_changed,vdsosym)
 
 # Assembly rules for the .S files
-$(obj-vdso): %.o: %.S
-	$(call if_changed_dep,vdsoas)
+#$(obj-vdso): %.o: %.S
+#	$(call if_changed_dep,vdsoas)
 
 # Actual build commands
 quiet_cmd_vdsold = VDSOL $@
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 8154b8d..8cb56e0 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -90,6 +90,11 @@ VERSION
 		__kernel_gettimeofday;
 		__kernel_clock_gettime;
 		__kernel_clock_getres;
+		 /* ADD YOUR VDSO STUFF HERE */
+		perf_read_counter;
+		__vdso_perf_read_counter;
+		perf_open_counter;
+		__vdso_perf_open_counter;
 	local: *;
 	};
 }
diff --git a/arch/arm64/kernel/vdso/vdso_perfc.c b/arch/arm64/kernel/vdso/vdso_perfc.c
new file mode 100644
index 0000000..c363d64
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vdso_perfc.c
@@ -0,0 +1,20 @@
+#include <linux/compiler.h>
+
+int perf_read_counter(void)
+    __attribute__((weak, alias("__vdso__perf_read_counter")));
+int perf_open_counter(void)
+    __attribute__((weak, alias("__vdso__perf_open_counter")));
+
+#define ARMV8_PMCNTENSET_EL0_ENABLE (1<<31) /**< Enable Perf count reg */
+
+__attribute__((no_instrument_function)) int __vdso__perf_read_counter(void)
+{
+int ret = 0;
+asm volatile("mrs %0, pmccntr_el0" : "=r" (ret));
+return ret;
+}
+
+__attribute__((no_instrument_function)) void __vdso__perf_open_counter(void)
+{
+asm volatile("msr pmcntenset_el0, %0" : : "r" (ARMV8_PMCNTENSET_EL0_ENABLE));
+}
-- 
1.7.9.5
