From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: [RFC 1/2] KVM: Record instruction set in all vmexit tracepoints
Date: Fri, 22 Jul 2011 12:46:52 +0100
Message-ID: <1311335213-4148-2-git-send-email-stefanha@linux.vnet.ibm.com>
References: <1311335213-4148-1-git-send-email-stefanha@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161]:49227 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608Ab1GVLrU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 22 Jul 2011 07:47:20 -0400
In-Reply-To: <1311335213-4148-1-git-send-email-stefanha@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: kvm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Avi Kivity <avi@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

The kvm_exit tracepoint recently added the isa argument to aid decoding
exit_reason.  The semantics of exit_reason depend on the instruction set
(vmx or svm) and the isa argument allows traces to be analyzed on other
machines.

Add the isa argument to kvm_nested_vmexit and kvm_nested_vmexit_inject
so these tracepoints can also be self-describing.

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
---
 arch/x86/kvm/svm.c   |    6 ++++--
 arch/x86/kvm/trace.h |   12 ++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 475d1c9..6adb7ba 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2182,7 +2182,8 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
 				       vmcb->control.exit_info_1,
 				       vmcb->control.exit_info_2,
 				       vmcb->control.exit_int_info,
-				       vmcb->control.exit_int_info_err);
+				       vmcb->control.exit_int_info_err,
+				       KVM_ISA_SVM);
 
 	nested_vmcb = nested_svm_map(svm, svm->nested.vmcb, &page);
 	if (!nested_vmcb)
@@ -3335,7 +3336,8 @@ static int handle_exit(struct kvm_vcpu *vcpu)
 					svm->vmcb->control.exit_info_1,
 					svm->vmcb->control.exit_info_2,
 					svm->vmcb->control.exit_int_info,
-					svm->vmcb->control.exit_int_info_err);
+					svm->vmcb->control.exit_int_info_err,
+					KVM_ISA_SVM);
 
 		vmexit = nested_svm_exit_special(svm);
 
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 3ff898c..4e1716b 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -486,9 +486,9 @@ TRACE_EVENT(kvm_nested_intercepts,
 TRACE_EVENT(kvm_nested_vmexit,
 	    TP_PROTO(__u64 rip, __u32 exit_code,
 		     __u64 exit_info1, __u64 exit_info2,
-		     __u32 exit_int_info, __u32 exit_int_info_err),
+		     __u32 exit_int_info, __u32 exit_int_info_err, __u32 isa),
 	    TP_ARGS(rip, exit_code, exit_info1, exit_info2,
-		    exit_int_info, exit_int_info_err),
+		    exit_int_info, exit_int_info_err, isa),
 
 	TP_STRUCT__entry(
 		__field(	__u64,		rip			)
@@ -497,6 +497,7 @@ TRACE_EVENT(kvm_nested_vmexit,
 		__field(	__u64,		exit_info2		)
 		__field(	__u32,		exit_int_info		)
 		__field(	__u32,		exit_int_info_err	)
+		__field(	__u32,		isa			)
 	),
 
 	TP_fast_assign(
@@ -506,6 +507,7 @@ TRACE_EVENT(kvm_nested_vmexit,
 		__entry->exit_info2		= exit_info2;
 		__entry->exit_int_info		= exit_int_info;
 		__entry->exit_int_info_err	= exit_int_info_err;
+		__entry->isa			= isa;
 	),
 	TP_printk("rip: 0x%016llx reason: %s ext_inf1: 0x%016llx "
 		  "ext_inf2: 0x%016llx ext_int: 0x%08x ext_int_err: 0x%08x",
@@ -522,9 +524,9 @@ TRACE_EVENT(kvm_nested_vmexit,
 TRACE_EVENT(kvm_nested_vmexit_inject,
 	    TP_PROTO(__u32 exit_code,
 		     __u64 exit_info1, __u64 exit_info2,
-		     __u32 exit_int_info, __u32 exit_int_info_err),
+		     __u32 exit_int_info, __u32 exit_int_info_err, __u32 isa),
 	    TP_ARGS(exit_code, exit_info1, exit_info2,
-		    exit_int_info, exit_int_info_err),
+		    exit_int_info, exit_int_info_err, isa),
 
 	TP_STRUCT__entry(
 		__field(	__u32,		exit_code		)
@@ -532,6 +534,7 @@ TRACE_EVENT(kvm_nested_vmexit_inject,
 		__field(	__u64,		exit_info2		)
 		__field(	__u32,		exit_int_info		)
 		__field(	__u32,		exit_int_info_err	)
+		__field(	__u32,		isa			)
 	),
 
 	TP_fast_assign(
@@ -540,6 +543,7 @@ TRACE_EVENT(kvm_nested_vmexit_inject,
 		__entry->exit_info2		= exit_info2;
 		__entry->exit_int_info		= exit_int_info;
 		__entry->exit_int_info_err	= exit_int_info_err;
+		__entry->isa			= isa;
 	),
 
 	TP_printk("reason: %s ext_inf1: 0x%016llx "
-- 
1.7.5.4
