From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/69] perf trace beauty: Add a x86 MSR cmd id->str table generator
Date: Fri, 11 Oct 2019 17:05:17 -0300
Message-ID: <20191011200559.7156-28-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Without parameters it'll parse tools/arch/x86/include/asm/msr-index.h
and output a table usable by tools, that will be wired up later to a
libtraceevent plugin registered from perf's glue code:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh
  static const char *x86_MSRs[] = {
 <SNIP>
  	[0x00000034] = "SMI_COUNT",
  	[0x0000003a] = "IA32_FEATURE_CONTROL",
  	[0x0000003b] = "IA32_TSC_ADJUST",
  	[0x00000040] = "LBR_CORE_FROM",
  	[0x00000048] = "IA32_SPEC_CTRL",
  	[0x00000049] = "IA32_PRED_CMD",
 <SNIP>
  	[0x0000010b] = "IA32_FLUSH_CMD",
  	[0x0000010F] = "TSX_FORCE_ABORT",
 <SNIP>
  	[0x00000198] = "IA32_PERF_STATUS",
  	[0x00000199] = "IA32_PERF_CTL",
  <SNIP>
  	[0x00000da0] = "IA32_XSS",
  	[0x00000dc0] = "LBR_INFO_0",
  	[0x00000ffc] = "IA32_BNDCFGS_RSVD",
  };

  #define x86_64_specific_MSRs_offset 0xc0000080
  static const char *x86_64_specific_MSRs[] = {
  	[0xc0000080 - x86_64_specific_MSRs_offset] = "EFER",
  	[0xc0000081 - x86_64_specific_MSRs_offset] = "STAR",
  	[0xc0000082 - x86_64_specific_MSRs_offset] = "LSTAR",
  	[0xc0000083 - x86_64_specific_MSRs_offset] = "CSTAR",
  	[0xc0000084 - x86_64_specific_MSRs_offset] = "SYSCALL_MASK",
  <SNIP>
  	[0xc0000103 - x86_64_specific_MSRs_offset] = "TSC_AUX",
  	[0xc0000104 - x86_64_specific_MSRs_offset] = "AMD64_TSC_RATIO",
  };

  #define x86_AMD_V_KVM_MSRs_offset 0xc0010000
  static const char *x86_AMD_V_KVM_MSRs[] = {
  	[0xc0010000 - x86_AMD_V_KVM_MSRs_offset] = "K7_EVNTSEL0",
  <SNIP>
  	[0xc0010114 - x86_AMD_V_KVM_MSRs_offset] = "VM_CR",
  	[0xc0010115 - x86_AMD_V_KVM_MSRs_offset] = "VM_IGNNE",
  	[0xc0010117 - x86_AMD_V_KVM_MSRs_offset] = "VM_HSAVE_PA",
  <SNIP>
  	[0xc0010240 - x86_AMD_V_KVM_MSRs_offset] = "F15H_NB_PERF_CTL",
  	[0xc0010241 - x86_AMD_V_KVM_MSRs_offset] = "F15H_NB_PERF_CTR",
  	[0xc0010280 - x86_AMD_V_KVM_MSRs_offset] = "F15H_PTSC",
  };

Then these will in turn be hooked up in a follow up patch to be used by
strarrays__scnprintf().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ja080xawx08kedez855usnon@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/trace/beauty/tracepoints/x86_msr.sh  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 tools/perf/trace/beauty/tracepoints/x86_msr.sh

diff --git a/tools/perf/trace/beauty/tracepoints/x86_msr.sh b/tools/perf/trace/beauty/tracepoints/x86_msr.sh
new file mode 100755
index 000000000000..831c02cf0586
--- /dev/null
+++ b/tools/perf/trace/beauty/tracepoints/x86_msr.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+if [ $# -ne 1 ] ; then
+	arch_x86_header_dir=tools/arch/x86/include/asm/
+else
+	arch_x86_header_dir=$1
+fi
+
+x86_msr_index=${arch_x86_header_dir}/msr-index.h
+
+# Support all later, with some hash table, for now chop off
+# Just the ones starting with 0x00000 so as to have a simple
+# array.
+
+printf "static const char *x86_MSRs[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x00000[[:xdigit:]]+)[[:space:]]*.*'
+egrep $regex ${x86_msr_index} | egrep -v 'MSR_(ATOM|P[46]|AMD64|IA32_TSCDEADLINE|IDT_FCR4)' | \
+	sed -r "s/$regex/\2 \1/g" | sort -n | \
+	xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n\n"
+
+# Remove MSR_K6_WHCR, clashes with MSR_LSTAR
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0xc0000[[:xdigit:]]+)[[:space:]]*.*'
+printf "#define x86_64_specific_MSRs_offset "
+egrep $regex ${x86_msr_index} | sed -r "s/$regex/\2/g" | sort -n | head -1
+printf "static const char *x86_64_specific_MSRs[] = {\n"
+egrep $regex ${x86_msr_index} | \
+	sed -r "s/$regex/\2 \1/g" | egrep -vw 'K6_WHCR' | sort -n | \
+	xargs printf "\t[%s - x86_64_specific_MSRs_offset] = \"%s\",\n"
+printf "};\n\n"
+
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0xc0010[[:xdigit:]]+)[[:space:]]*.*'
+printf "#define x86_AMD_V_KVM_MSRs_offset "
+egrep $regex ${x86_msr_index} | sed -r "s/$regex/\2/g" | sort -n | head -1
+printf "static const char *x86_AMD_V_KVM_MSRs[] = {\n"
+egrep $regex ${x86_msr_index} | \
+	sed -r "s/$regex/\2 \1/g" | sort -n | \
+	xargs printf "\t[%s - x86_AMD_V_KVM_MSRs_offset] = \"%s\",\n"
+printf "};\n"
-- 
2.21.0
