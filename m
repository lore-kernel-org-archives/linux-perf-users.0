From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/30] perf tools s390: Do not include header files from the kernel sources
Date: Tue, 28 Nov 2017 12:02:20 -0300
Message-ID: <20171128150220.5064-31-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753832AbdK1PD6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Nov 2017 10:03:58 -0500
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Long ago we decided to be verbotten including files in the kernel git
sources from tools/ living source code, to avoid disturbing kernel
development (and perf's and other tools/) when, say, a kernel hacker
adds something, tests everything but tools/ and have tools/ build
broken.

This got broken recently by s/390, fix it by copying
arch/s390/include/uapi/asm/perf_regs.h to tools/+arch/s390/include/uapi/asm/,
making this one be used by means of <asm/perf_regs.h> and updating
tools/perf/check_headers.sh to make sure we are notified when the
original changes, so that we can check if anything is needed on the
tooling side.

This would have been caught by the 'tarkpg' test entry in:

$ make -C tools/perf build-test

When run on a s/390 build system or container.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hyhmnjiblphb9vv9czmjobcn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/s390/include/uapi/asm/perf_regs.h | 43 ++++++++++++++++++++++++++++
 tools/perf/arch/s390/include/perf_regs.h     |  2 +-
 tools/perf/check-headers.sh                  |  1 +
 3 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 tools/arch/s390/include/uapi/asm/perf_regs.h

diff --git a/tools/arch/s390/include/uapi/asm/perf_regs.h b/tools/arch/s390/include/uapi/asm/perf_regs.h
new file mode 100644
index 000000000000..7c8564f98205
--- /dev/null
+++ b/tools/arch/s390/include/uapi/asm/perf_regs.h
@@ -0,0 +1,43 @@
+#ifndef _ASM_S390_PERF_REGS_H
+#define _ASM_S390_PERF_REGS_H
+
+enum perf_event_s390_regs {
+	PERF_REG_S390_R0,
+	PERF_REG_S390_R1,
+	PERF_REG_S390_R2,
+	PERF_REG_S390_R3,
+	PERF_REG_S390_R4,
+	PERF_REG_S390_R5,
+	PERF_REG_S390_R6,
+	PERF_REG_S390_R7,
+	PERF_REG_S390_R8,
+	PERF_REG_S390_R9,
+	PERF_REG_S390_R10,
+	PERF_REG_S390_R11,
+	PERF_REG_S390_R12,
+	PERF_REG_S390_R13,
+	PERF_REG_S390_R14,
+	PERF_REG_S390_R15,
+	PERF_REG_S390_FP0,
+	PERF_REG_S390_FP1,
+	PERF_REG_S390_FP2,
+	PERF_REG_S390_FP3,
+	PERF_REG_S390_FP4,
+	PERF_REG_S390_FP5,
+	PERF_REG_S390_FP6,
+	PERF_REG_S390_FP7,
+	PERF_REG_S390_FP8,
+	PERF_REG_S390_FP9,
+	PERF_REG_S390_FP10,
+	PERF_REG_S390_FP11,
+	PERF_REG_S390_FP12,
+	PERF_REG_S390_FP13,
+	PERF_REG_S390_FP14,
+	PERF_REG_S390_FP15,
+	PERF_REG_S390_MASK,
+	PERF_REG_S390_PC,
+
+	PERF_REG_S390_MAX
+};
+
+#endif /* _ASM_S390_PERF_REGS_H */
diff --git a/tools/perf/arch/s390/include/perf_regs.h b/tools/perf/arch/s390/include/perf_regs.h
index d2df54a6bc5a..bcfbaed78cc2 100644
--- a/tools/perf/arch/s390/include/perf_regs.h
+++ b/tools/perf/arch/s390/include/perf_regs.h
@@ -3,7 +3,7 @@
 
 #include <stdlib.h>
 #include <linux/types.h>
-#include <../../../../arch/s390/include/uapi/asm/perf_regs.h>
+#include <asm/perf_regs.h>
 
 void perf_regs_load(u64 *regs);
 
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 77406d25e521..e5170038e446 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -21,6 +21,7 @@ arch/x86/include/asm/cpufeatures.h
 arch/arm/include/uapi/asm/perf_regs.h
 arch/arm64/include/uapi/asm/perf_regs.h
 arch/powerpc/include/uapi/asm/perf_regs.h
+arch/s390/include/uapi/asm/perf_regs.h
 arch/x86/include/uapi/asm/perf_regs.h
 arch/x86/include/uapi/asm/kvm.h
 arch/x86/include/uapi/asm/kvm_perf.h
-- 
2.13.6
