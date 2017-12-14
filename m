From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/34] tools arch s390: Do not include header files from the kernel sources
Date: Thu, 14 Dec 2017 14:42:44 -0300
Message-ID: <20171214174247.16841-32-acme@kernel.org>
References: <20171214174247.16841-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214174247.16841-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Long ago we decided to be verbotten including files in the kernel git
sources from tools/ living source code, to avoid disturbing kernel
development (and perf's and other tools/) when, say, a kernel hacker
adds something, tests everything but tools/ and have tools/ build
broken.

This got broken recently by s/390, fix it by copying
arch/s390/include/uapi/asm/perf_regs.h to tools/arch/s390/include/uapi/asm/,
making this one be used by means of <asm/perf_regs.h> and updating
tools/perf/check_headers.sh to make sure we are notified when the
original changes, so that we can check if anything is needed on the
tooling side.

This would have been caught by the 'tarkpg' test entry in:

$ make -C tools/perf build-test

When run on a s/390 build system or container.

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: f704ef44602f ("s390/perf: add support for perf_regs and libdw")
Link: https://lkml.kernel.org/n/tip-2xgv1ajv2xzcaasqjgxf09na@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/s390/include/uapi/asm/perf_regs.h | 44 ++++++++++++++++++++++++++++
 tools/perf/arch/s390/include/perf_regs.h     |  2 +-
 tools/perf/check-headers.sh                  |  1 +
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 tools/arch/s390/include/uapi/asm/perf_regs.h

diff --git a/tools/arch/s390/include/uapi/asm/perf_regs.h b/tools/arch/s390/include/uapi/asm/perf_regs.h
new file mode 100644
index 000000000000..d17dd9e5d516
--- /dev/null
+++ b/tools/arch/s390/include/uapi/asm/perf_regs.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
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
index 100bc6eff314..f81ca508700c 100755
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
