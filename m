From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/57] libbeauty: Add a generator for x86's IRQ vectors -> strings
Date: Mon, 21 Oct 2019 10:38:01 -0300
Message-ID: <20191021133834.25998-25-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll wire this up with the 'vector' arg in irq_vectors:*, etc:

Just run it straight away and check what it produces:

  $ tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
  static const char *x86_irq_vectors[] = {
  	[0x02] = "NMI",
  	[0x12] = "MCE",
  	[0x20] = "IRQ_MOVE_CLEANUP",
  	[0x80] = "IA32_SYSCALL",
  	[0xec] = "LOCAL_TIMER",
  	[0xed] = "HYPERV_STIMER0",
  	[0xee] = "HYPERV_REENLIGHTENMENT",
  	[0xef] = "MANAGED_IRQ_SHUTDOWN",
  	[0xf0] = "POSTED_INTR_NESTED",
  	[0xf1] = "POSTED_INTR_WAKEUP",
  	[0xf2] = "POSTED_INTR",
  	[0xf3] = "HYPERVISOR_CALLBACK",
  	[0xf4] = "DEFERRED_ERROR",
  	[0xf6] = "IRQ_WORK",
  	[0xf7] = "X86_PLATFORM_IPI",
  	[0xf8] = "REBOOT",
  	[0xf9] = "THRESHOLD_APIC",
  	[0xfa] = "THERMAL_APIC",
  	[0xfb] = "CALL_FUNCTION_SINGLE",
  	[0xfc] = "CALL_FUNCTION",
  	[0xfd] = "RESCHEDULE",
  	[0xfe] = "ERROR_APIC",
  	[0xff] = "SPURIOUS_APIC",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-cpl1pa7kkwn0llufi5qw4li8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../beauty/tracepoints/x86_irq_vectors.sh     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100755 tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh

diff --git a/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh b/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
new file mode 100755
index 000000000000..f920003723b3
--- /dev/null
+++ b/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+# (C) 2019, Arnaldo Carvalho de Melo <acme@redhat.com>
+
+if [ $# -ne 1 ] ; then
+	arch_x86_header_dir=tools/arch/x86/include/asm/
+else
+	arch_x86_header_dir=$1
+fi
+
+x86_irq_vectors=${arch_x86_header_dir}/irq_vectors.h
+
+# FIRST_EXTERNAL_VECTOR is not that useful, find what is its number
+# and then replace whatever is using it and that is useful, which at
+# the time of writing of this script was: IRQ_MOVE_CLEANUP_VECTOR.
+
+first_external_regex='^#define[[:space:]]+FIRST_EXTERNAL_VECTOR[[:space:]]+(0x[[:xdigit:]]+)$'
+first_external_vector=$(egrep ${first_external_regex} ${x86_irq_vectors} | sed -r "s/${first_external_regex}/\1/g")
+
+printf "static const char *x86_irq_vectors[] = {\n"
+regex='^#define[[:space:]]+([[:alnum:]_]+)_VECTOR[[:space:]]+(0x[[:xdigit:]]+)$'
+sed -r "s/FIRST_EXTERNAL_VECTOR/${first_external_vector}/g" ${x86_irq_vectors} | \
+egrep ${regex} | \
+	sed -r "s/${regex}/\2 \1/g" | sort -n | \
+	xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n\n"
+
-- 
2.21.0
