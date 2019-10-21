From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/57] libbeauty: Hook up the x86 irq_vectors table generator
Date: Mon, 21 Oct 2019 10:38:02 -0300
Message-ID: <20191021133834.25998-26-acme@kernel.org>
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

I.e. after running:

  $ make -C tools/perf O=/tmp/build/perf

We end up with:

  $ cat /tmp/build/perf/trace/beauty/generated/x86_arch_irq_vectors_array.c
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

Now its just a matter of using it, associating it to tracepoint arguments named
'vector', all of which can be correctly used with this table, for int args.

At some point we should move tools/perf/trace/beauty to tools/beauty/,
so that it can be used more generally and even made available externally
like libbpf, libperf, libtraceevent, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0p2df4kq1afrxbck4e4ct34r@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 8f1ba986d3bf..1cd294468a1f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -546,6 +546,12 @@ x86_arch_prctl_code_tbl := $(srctree)/tools/perf/trace/beauty/x86_arch_prctl.sh
 $(x86_arch_prctl_code_array): $(x86_arch_asm_uapi_dir)/prctl.h $(x86_arch_prctl_code_tbl)
 	$(Q)$(SHELL) '$(x86_arch_prctl_code_tbl)' $(x86_arch_asm_uapi_dir) > $@
 
+x86_arch_irq_vectors_array := $(beauty_outdir)/x86_arch_irq_vectors_array.c
+x86_arch_irq_vectors_tbl := $(srctree)/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
+
+$(x86_arch_irq_vectors_array): $(x86_arch_asm_dir)/irq_vectors.h $(x86_arch_irq_vectors_tbl)
+	$(Q)$(SHELL) '$(x86_arch_irq_vectors_tbl)' $(x86_arch_asm_dir) > $@
+
 x86_arch_MSRs_array := $(beauty_outdir)/x86_arch_MSRs_array.c
 x86_arch_MSRs_tbl := $(srctree)/tools/perf/trace/beauty/tracepoints/x86_msr.sh
 
@@ -686,6 +692,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(perf_ioctl_array) \
 	$(prctl_option_array) \
 	$(usbdevfs_ioctl_array) \
+	$(x86_arch_irq_vectors_array) \
 	$(x86_arch_MSRs_array) \
 	$(x86_arch_prctl_code_array) \
 	$(rename_flags_array) \
@@ -991,6 +998,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(perf_ioctl_array) \
 		$(OUTPUT)$(prctl_option_array) \
 		$(OUTPUT)$(usbdevfs_ioctl_array) \
+		$(OUTPUT)$(x86_arch_irq_vectors_array) \
 		$(OUTPUT)$(x86_arch_MSRs_array) \
 		$(OUTPUT)$(x86_arch_prctl_code_array) \
 		$(OUTPUT)$(rename_flags_array) \
-- 
2.21.0
