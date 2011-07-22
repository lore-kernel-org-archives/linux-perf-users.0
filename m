From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: [RFC 2/2] KVM: Use __print_symbolic() for vmexit tracepoints
Date: Fri, 22 Jul 2011 12:46:53 +0100
Message-ID: <1311335213-4148-3-git-send-email-stefanha@linux.vnet.ibm.com>
References: <1311335213-4148-1-git-send-email-stefanha@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1311335213-4148-1-git-send-email-stefanha@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: kvm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Avi Kivity <avi@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

The vmexit tracepoints format the exit_reason to make it human-readable.
Since the exit_reason depends on the instruction set (vmx or svm),
formatting is handled with ftrace_print_symbols_seq() by referring to
the appropriate exit reason table.

However, the ftrace_print_symbols_seq() function is not meant to be used
directly in tracepoints since it does not export the formatting table
which userspace tools like trace-cmd and perf use to format traces.

In practice perf dies when formatting vmexit-related events and
trace-cmd falls back to printing the numeric value (with extra
formatting code in the kvm plugin to paper over this limitation).  Other
userspace consumers of vmexit-related tracepoints would be in similar
trouble.

To avoid significant changes to the kvm_exit tracepoint, this patch
moves the vmx and svm exit reason tables into arch/x86/kvm/trace.h and
selects the right table with __print_symbolic() depending on the
instruction set.  Note that __print_symbolic() is designed for exporting
the formatting table to userspace and allows trace-cmd and perf to work.

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
---
 arch/x86/include/asm/kvm_host.h |    2 -
 arch/x86/kvm/svm.c              |   55 --------------------
 arch/x86/kvm/trace.h            |  106 ++++++++++++++++++++++++++++++++++++--
 arch/x86/kvm/vmx.c              |   44 ----------------
 4 files changed, 100 insertions(+), 107 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index dd51c83..582c3b7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -634,8 +634,6 @@ struct kvm_x86_ops {
 	int (*check_intercept)(struct kvm_vcpu *vcpu,
 			       struct x86_instruction_info *info,
 			       enum x86_intercept_stage stage);
-
-	const struct trace_print_flags *exit_reasons_str;
 };
 
 struct kvm_arch_async_pf {
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 6adb7ba..2b24a88 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3899,60 +3899,6 @@ static void svm_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
 	}
 }
 
-static const struct trace_print_flags svm_exit_reasons_str[] = {
-	{ SVM_EXIT_READ_CR0,			"read_cr0" },
-	{ SVM_EXIT_READ_CR3,			"read_cr3" },
-	{ SVM_EXIT_READ_CR4,			"read_cr4" },
-	{ SVM_EXIT_READ_CR8,			"read_cr8" },
-	{ SVM_EXIT_WRITE_CR0,			"write_cr0" },
-	{ SVM_EXIT_WRITE_CR3,			"write_cr3" },
-	{ SVM_EXIT_WRITE_CR4,			"write_cr4" },
-	{ SVM_EXIT_WRITE_CR8,			"write_cr8" },
-	{ SVM_EXIT_READ_DR0,			"read_dr0" },
-	{ SVM_EXIT_READ_DR1,			"read_dr1" },
-	{ SVM_EXIT_READ_DR2,			"read_dr2" },
-	{ SVM_EXIT_READ_DR3,			"read_dr3" },
-	{ SVM_EXIT_WRITE_DR0,			"write_dr0" },
-	{ SVM_EXIT_WRITE_DR1,			"write_dr1" },
-	{ SVM_EXIT_WRITE_DR2,			"write_dr2" },
-	{ SVM_EXIT_WRITE_DR3,			"write_dr3" },
-	{ SVM_EXIT_WRITE_DR5,			"write_dr5" },
-	{ SVM_EXIT_WRITE_DR7,			"write_dr7" },
-	{ SVM_EXIT_EXCP_BASE + DB_VECTOR,	"DB excp" },
-	{ SVM_EXIT_EXCP_BASE + BP_VECTOR,	"BP excp" },
-	{ SVM_EXIT_EXCP_BASE + UD_VECTOR,	"UD excp" },
-	{ SVM_EXIT_EXCP_BASE + PF_VECTOR,	"PF excp" },
-	{ SVM_EXIT_EXCP_BASE + NM_VECTOR,	"NM excp" },
-	{ SVM_EXIT_EXCP_BASE + MC_VECTOR,	"MC excp" },
-	{ SVM_EXIT_INTR,			"interrupt" },
-	{ SVM_EXIT_NMI,				"nmi" },
-	{ SVM_EXIT_SMI,				"smi" },
-	{ SVM_EXIT_INIT,			"init" },
-	{ SVM_EXIT_VINTR,			"vintr" },
-	{ SVM_EXIT_CPUID,			"cpuid" },
-	{ SVM_EXIT_INVD,			"invd" },
-	{ SVM_EXIT_HLT,				"hlt" },
-	{ SVM_EXIT_INVLPG,			"invlpg" },
-	{ SVM_EXIT_INVLPGA,			"invlpga" },
-	{ SVM_EXIT_IOIO,			"io" },
-	{ SVM_EXIT_MSR,				"msr" },
-	{ SVM_EXIT_TASK_SWITCH,			"task_switch" },
-	{ SVM_EXIT_SHUTDOWN,			"shutdown" },
-	{ SVM_EXIT_VMRUN,			"vmrun" },
-	{ SVM_EXIT_VMMCALL,			"hypercall" },
-	{ SVM_EXIT_VMLOAD,			"vmload" },
-	{ SVM_EXIT_VMSAVE,			"vmsave" },
-	{ SVM_EXIT_STGI,			"stgi" },
-	{ SVM_EXIT_CLGI,			"clgi" },
-	{ SVM_EXIT_SKINIT,			"skinit" },
-	{ SVM_EXIT_WBINVD,			"wbinvd" },
-	{ SVM_EXIT_MONITOR,			"monitor" },
-	{ SVM_EXIT_MWAIT,			"mwait" },
-	{ SVM_EXIT_XSETBV,			"xsetbv" },
-	{ SVM_EXIT_NPF,				"npf" },
-	{ -1, NULL }
-};
-
 static int svm_get_lpage_level(void)
 {
 	return PT_PDPE_LEVEL;
@@ -4225,7 +4171,6 @@ static struct kvm_x86_ops svm_x86_ops = {
 	.get_mt_mask = svm_get_mt_mask,
 
 	.get_exit_info = svm_get_exit_info,
-	.exit_reasons_str = svm_exit_reasons_str,
 
 	.get_lpage_level = svm_get_lpage_level,
 
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 4e1716b..911d264 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -2,6 +2,8 @@
 #define _TRACE_KVM_H
 
 #include <linux/tracepoint.h>
+#include <asm/vmx.h>
+#include <asm/svm.h>
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm
@@ -181,6 +183,95 @@ TRACE_EVENT(kvm_apic,
 #define KVM_ISA_VMX   1
 #define KVM_ISA_SVM   2
 
+#define VMX_EXIT_REASONS \
+	{ EXIT_REASON_EXCEPTION_NMI,		"EXCEPTION_NMI" }, \
+	{ EXIT_REASON_EXTERNAL_INTERRUPT,	"EXTERNAL_INTERRUPT" }, \
+	{ EXIT_REASON_TRIPLE_FAULT,		"TRIPLE_FAULT" }, \
+	{ EXIT_REASON_PENDING_INTERRUPT,	"PENDING_INTERRUPT" }, \
+	{ EXIT_REASON_NMI_WINDOW,		"NMI_WINDOW" }, \
+	{ EXIT_REASON_TASK_SWITCH,		"TASK_SWITCH" }, \
+	{ EXIT_REASON_CPUID,			"CPUID" }, \
+	{ EXIT_REASON_HLT,			"HLT" }, \
+	{ EXIT_REASON_INVLPG,			"INVLPG" }, \
+	{ EXIT_REASON_RDPMC,			"RDPMC" }, \
+	{ EXIT_REASON_RDTSC,			"RDTSC" }, \
+	{ EXIT_REASON_VMCALL,			"VMCALL" }, \
+	{ EXIT_REASON_VMCLEAR,			"VMCLEAR" }, \
+	{ EXIT_REASON_VMLAUNCH,			"VMLAUNCH" }, \
+	{ EXIT_REASON_VMPTRLD,			"VMPTRLD" }, \
+	{ EXIT_REASON_VMPTRST,			"VMPTRST" }, \
+	{ EXIT_REASON_VMREAD,			"VMREAD" }, \
+	{ EXIT_REASON_VMRESUME,			"VMRESUME" }, \
+	{ EXIT_REASON_VMWRITE,			"VMWRITE" }, \
+	{ EXIT_REASON_VMOFF,			"VMOFF" }, \
+	{ EXIT_REASON_VMON,			"VMON" }, \
+	{ EXIT_REASON_CR_ACCESS,		"CR_ACCESS" }, \
+	{ EXIT_REASON_DR_ACCESS,		"DR_ACCESS" }, \
+	{ EXIT_REASON_IO_INSTRUCTION,		"IO_INSTRUCTION" }, \
+	{ EXIT_REASON_MSR_READ,			"MSR_READ" }, \
+	{ EXIT_REASON_MSR_WRITE,		"MSR_WRITE" }, \
+	{ EXIT_REASON_MWAIT_INSTRUCTION,	"MWAIT_INSTRUCTION" }, \
+	{ EXIT_REASON_MONITOR_INSTRUCTION,	"MONITOR_INSTRUCTION" }, \
+	{ EXIT_REASON_PAUSE_INSTRUCTION,	"PAUSE_INSTRUCTION" }, \
+	{ EXIT_REASON_MCE_DURING_VMENTRY,	"MCE_DURING_VMENTRY" }, \
+	{ EXIT_REASON_TPR_BELOW_THRESHOLD,	"TPR_BELOW_THRESHOLD" },	\
+	{ EXIT_REASON_APIC_ACCESS,		"APIC_ACCESS" }, \
+	{ EXIT_REASON_EPT_VIOLATION,		"EPT_VIOLATION" }, \
+	{ EXIT_REASON_EPT_MISCONFIG,		"EPT_MISCONFIG" }, \
+	{ EXIT_REASON_WBINVD,			"WBINVD" }
+
+#define SVM_EXIT_REASONS \
+	{ SVM_EXIT_READ_CR0,			"read_cr0" }, \
+	{ SVM_EXIT_READ_CR3,			"read_cr3" }, \
+	{ SVM_EXIT_READ_CR4,			"read_cr4" }, \
+	{ SVM_EXIT_READ_CR8,			"read_cr8" }, \
+	{ SVM_EXIT_WRITE_CR0,			"write_cr0" }, \
+	{ SVM_EXIT_WRITE_CR3,			"write_cr3" }, \
+	{ SVM_EXIT_WRITE_CR4,			"write_cr4" }, \
+	{ SVM_EXIT_WRITE_CR8,			"write_cr8" }, \
+	{ SVM_EXIT_READ_DR0,			"read_dr0" }, \
+	{ SVM_EXIT_READ_DR1,			"read_dr1" }, \
+	{ SVM_EXIT_READ_DR2,			"read_dr2" }, \
+	{ SVM_EXIT_READ_DR3,			"read_dr3" }, \
+	{ SVM_EXIT_WRITE_DR0,			"write_dr0" }, \
+	{ SVM_EXIT_WRITE_DR1,			"write_dr1" }, \
+	{ SVM_EXIT_WRITE_DR2,			"write_dr2" }, \
+	{ SVM_EXIT_WRITE_DR3,			"write_dr3" }, \
+	{ SVM_EXIT_WRITE_DR5,			"write_dr5" }, \
+	{ SVM_EXIT_WRITE_DR7,			"write_dr7" }, \
+	{ SVM_EXIT_EXCP_BASE + DB_VECTOR,	"DB excp" }, \
+	{ SVM_EXIT_EXCP_BASE + BP_VECTOR,	"BP excp" }, \
+	{ SVM_EXIT_EXCP_BASE + UD_VECTOR,	"UD excp" }, \
+	{ SVM_EXIT_EXCP_BASE + PF_VECTOR,	"PF excp" }, \
+	{ SVM_EXIT_EXCP_BASE + NM_VECTOR,	"NM excp" }, \
+	{ SVM_EXIT_EXCP_BASE + MC_VECTOR,	"MC excp" }, \
+	{ SVM_EXIT_INTR,			"interrupt" }, \
+	{ SVM_EXIT_NMI,				"nmi" }, \
+	{ SVM_EXIT_SMI,				"smi" }, \
+	{ SVM_EXIT_INIT,			"init" }, \
+	{ SVM_EXIT_VINTR,			"vintr" }, \
+	{ SVM_EXIT_CPUID,			"cpuid" }, \
+	{ SVM_EXIT_INVD,			"invd" }, \
+	{ SVM_EXIT_HLT,				"hlt" }, \
+	{ SVM_EXIT_INVLPG,			"invlpg" }, \
+	{ SVM_EXIT_INVLPGA,			"invlpga" }, \
+	{ SVM_EXIT_IOIO,			"io" }, \
+	{ SVM_EXIT_MSR,				"msr" }, \
+	{ SVM_EXIT_TASK_SWITCH,			"task_switch" }, \
+	{ SVM_EXIT_SHUTDOWN,			"shutdown" }, \
+	{ SVM_EXIT_VMRUN,			"vmrun" }, \
+	{ SVM_EXIT_VMMCALL,			"hypercall" }, \
+	{ SVM_EXIT_VMLOAD,			"vmload" }, \
+	{ SVM_EXIT_VMSAVE,			"vmsave" }, \
+	{ SVM_EXIT_STGI,			"stgi" }, \
+	{ SVM_EXIT_CLGI,			"clgi" }, \
+	{ SVM_EXIT_SKINIT,			"skinit" }, \
+	{ SVM_EXIT_WBINVD,			"wbinvd" }, \
+	{ SVM_EXIT_MONITOR,			"monitor" }, \
+	{ SVM_EXIT_MWAIT,			"mwait" }, \
+	{ SVM_EXIT_XSETBV,			"xsetbv" }, \
+	{ SVM_EXIT_NPF,				"npf" }
+
 /*
  * Tracepoint for kvm guest exit:
  */
@@ -205,8 +296,9 @@ TRACE_EVENT(kvm_exit,
 	),
 
 	TP_printk("reason %s rip 0x%lx info %llx %llx",
-		 ftrace_print_symbols_seq(p, __entry->exit_reason,
-					  kvm_x86_ops->exit_reasons_str),
+		 (__entry->isa == KVM_ISA_VMX) ?
+		 __print_symbolic(__entry->exit_reason, VMX_EXIT_REASONS) :
+		 __print_symbolic(__entry->exit_reason, SVM_EXIT_REASONS),
 		 __entry->guest_rip, __entry->info1, __entry->info2)
 );
 
@@ -512,8 +604,9 @@ TRACE_EVENT(kvm_nested_vmexit,
 	TP_printk("rip: 0x%016llx reason: %s ext_inf1: 0x%016llx "
 		  "ext_inf2: 0x%016llx ext_int: 0x%08x ext_int_err: 0x%08x",
 		  __entry->rip,
-		  ftrace_print_symbols_seq(p, __entry->exit_code,
-					   kvm_x86_ops->exit_reasons_str),
+		 (__entry->isa == KVM_ISA_VMX) ?
+		 __print_symbolic(__entry->exit_code, VMX_EXIT_REASONS) :
+		 __print_symbolic(__entry->exit_code, SVM_EXIT_REASONS),
 		  __entry->exit_info1, __entry->exit_info2,
 		  __entry->exit_int_info, __entry->exit_int_info_err)
 );
@@ -548,8 +641,9 @@ TRACE_EVENT(kvm_nested_vmexit_inject,
 
 	TP_printk("reason: %s ext_inf1: 0x%016llx "
 		  "ext_inf2: 0x%016llx ext_int: 0x%08x ext_int_err: 0x%08x",
-		  ftrace_print_symbols_seq(p, __entry->exit_code,
-					   kvm_x86_ops->exit_reasons_str),
+		 (__entry->isa == KVM_ISA_VMX) ?
+		 __print_symbolic(__entry->exit_code, VMX_EXIT_REASONS) :
+		 __print_symbolic(__entry->exit_code, SVM_EXIT_REASONS),
 		__entry->exit_info1, __entry->exit_info2,
 		__entry->exit_int_info, __entry->exit_int_info_err)
 );
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index e65a158..e26629f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6241,49 +6241,6 @@ static u64 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 	return ret;
 }
 
-#define _ER(x) { EXIT_REASON_##x, #x }
-
-static const struct trace_print_flags vmx_exit_reasons_str[] = {
-	_ER(EXCEPTION_NMI),
-	_ER(EXTERNAL_INTERRUPT),
-	_ER(TRIPLE_FAULT),
-	_ER(PENDING_INTERRUPT),
-	_ER(NMI_WINDOW),
-	_ER(TASK_SWITCH),
-	_ER(CPUID),
-	_ER(HLT),
-	_ER(INVLPG),
-	_ER(RDPMC),
-	_ER(RDTSC),
-	_ER(VMCALL),
-	_ER(VMCLEAR),
-	_ER(VMLAUNCH),
-	_ER(VMPTRLD),
-	_ER(VMPTRST),
-	_ER(VMREAD),
-	_ER(VMRESUME),
-	_ER(VMWRITE),
-	_ER(VMOFF),
-	_ER(VMON),
-	_ER(CR_ACCESS),
-	_ER(DR_ACCESS),
-	_ER(IO_INSTRUCTION),
-	_ER(MSR_READ),
-	_ER(MSR_WRITE),
-	_ER(MWAIT_INSTRUCTION),
-	_ER(MONITOR_INSTRUCTION),
-	_ER(PAUSE_INSTRUCTION),
-	_ER(MCE_DURING_VMENTRY),
-	_ER(TPR_BELOW_THRESHOLD),
-	_ER(APIC_ACCESS),
-	_ER(EPT_VIOLATION),
-	_ER(EPT_MISCONFIG),
-	_ER(WBINVD),
-	{ -1, NULL }
-};
-
-#undef _ER
-
 static int vmx_get_lpage_level(void)
 {
 	if (enable_ept && !cpu_has_vmx_ept_1g_page())
@@ -7039,7 +6996,6 @@ static struct kvm_x86_ops vmx_x86_ops = {
 	.get_mt_mask = vmx_get_mt_mask,
 
 	.get_exit_info = vmx_get_exit_info,
-	.exit_reasons_str = vmx_exit_reasons_str,
 
 	.get_lpage_level = vmx_get_lpage_level,
 
-- 
1.7.5.4

