From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: [RFC 0/2] KVM: Fix kvm_exit trace event format
Date: Fri, 22 Jul 2011 12:46:51 +0100
Message-ID: <1311335213-4148-1-git-send-email-stefanha@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162]:37921 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab1GVLrU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 22 Jul 2011 07:47:20 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: kvm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Avi Kivity <avi@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

Currently both perf and trace-cmd cannot parse the kvm:kvm_exit trace event
format.  This patch is an attempt to make formatting work without changing the
kvm:kvm_exit prototype.  Since this event is a core KVM operation, no doubt
there are existing trace analysis scripts that rely on it and I don't want to
break them.

Patch 1 adjusts vmexit-related tracepoints so that they can be fixed too.

Patch 2 replaces ftrace_print_symbols_seq() with __print_symbolic().  This
means all information necessary for formatting the exit_reason field is now
part of the trace event's format.  In theory userspace tools should now work.

In practice both perf and trace-cmd are not happy with the new exit_reason
formatting expression (omitting the details and split across lines for easy
email reading here):

print fmt: "reason %s rip 0x%lx info %llx %llx",
           (REC->isa == 1) ?
           __print_symbolic(REC->exit_reason, { 0, "EXCEPTION_NMI" }, ...) :
           __print_symbolic(REC->exit_reason, { 0x000, "read_cr0" }, ...),
           REC->guest_rip, REC->info1, REC->info2

perf script says:

  Warning: Error: expected type 5 but read 4
  Warning: Error: expected type 5 but read 0
  Warning: unknown op '}'

kvm  2696 [001]   289.850941: kvm_exit: EVENT 'kvm_exit' FAILED TO PARSE

trace-cmd says:

  Error: expected type 5 but read 4
  Error: expected type 5 but read 0
  failed to read event print fmt for kvm_exit

kvm-2696  [000]  1451.564092: kvm_exit: [FAILED TO PARSE] exit_reason=44 guest_rip=0xc01151a8 isa=1 info1=4272 info2=0

I'd really like to make perf and trace-cmd just work with kvm:kvm_exit.  Any
suggestions other than improving the parsers in the respective tools?

Stefan Hajnoczi (2):
  KVM: Record instruction set in all vmexit tracepoints
  KVM: Use __print_symbolic() for vmexit tracepoints

 arch/x86/include/asm/kvm_host.h |    2 -
 arch/x86/kvm/svm.c              |   61 +-------------------
 arch/x86/kvm/trace.h            |  118 +++++++++++++++++++++++++++++++++++---
 arch/x86/kvm/vmx.c              |   44 --------------
 4 files changed, 112 insertions(+), 113 deletions(-)

-- 
1.7.5.4
