From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 51/63] tools include arch: Grab a copy of x86's prctl.h
Date: Tue, 18 Dec 2018 19:07:21 -0300
Message-ID: <20181218220733.15839-52-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need it to generate the tables for the 'code' arch_prctl's syscall
argument.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-vu890pi18fpd4eyz61cazckj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/prctl.h | 17 +++++++++++++++++
 tools/perf/check-headers.sh             |  1 +
 2 files changed, 18 insertions(+)
 create mode 100644 tools/arch/x86/include/uapi/asm/prctl.h

diff --git a/tools/arch/x86/include/uapi/asm/prctl.h b/tools/arch/x86/include/uapi/asm/prctl.h
new file mode 100644
index 000000000000..5a6aac9fa41f
--- /dev/null
+++ b/tools/arch/x86/include/uapi/asm/prctl.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_X86_PRCTL_H
+#define _ASM_X86_PRCTL_H
+
+#define ARCH_SET_GS		0x1001
+#define ARCH_SET_FS		0x1002
+#define ARCH_GET_FS		0x1003
+#define ARCH_GET_GS		0x1004
+
+#define ARCH_GET_CPUID		0x1011
+#define ARCH_SET_CPUID		0x1012
+
+#define ARCH_MAP_VDSO_X32	0x2001
+#define ARCH_MAP_VDSO_32	0x2002
+#define ARCH_MAP_VDSO_64	0x2003
+
+#endif /* _ASM_X86_PRCTL_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 9531f7bd7d9b..10d97dc632da 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -21,6 +21,7 @@ include/uapi/linux/hw_breakpoint.h
 arch/x86/include/asm/disabled-features.h
 arch/x86/include/asm/required-features.h
 arch/x86/include/asm/cpufeatures.h
+arch/x86/include/uapi/asm/prctl.h
 arch/arm/include/uapi/asm/perf_regs.h
 arch/arm64/include/uapi/asm/perf_regs.h
 arch/powerpc/include/uapi/asm/perf_regs.h
-- 
2.19.2
