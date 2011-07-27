From: Avi Kivity <avi@redhat.com>
Subject: Re: [RFC 0/2] KVM: Fix kvm_exit trace event format
Date: Wed, 27 Jul 2011 14:47:20 +0300
Message-ID: <4E2FFAC8.7080309@redhat.com>
References: <1311335213-4148-1-git-send-email-stefanha@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49582 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099Ab1G0Lr3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 Jul 2011 07:47:29 -0400
In-Reply-To: <1311335213-4148-1-git-send-email-stefanha@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>

On 07/22/2011 02:46 PM, Stefan Hajnoczi wrote:
> Currently both perf and trace-cmd cannot parse the kvm:kvm_exit trace event
> format.  This patch is an attempt to make formatting work without changing the
> kvm:kvm_exit prototype.  Since this event is a core KVM operation, no doubt
> there are existing trace analysis scripts that rely on it and I don't want to
> break them.
>
> Patch 1 adjusts vmexit-related tracepoints so that they can be fixed too.
>
> Patch 2 replaces ftrace_print_symbols_seq() with __print_symbolic().  This
> means all information necessary for formatting the exit_reason field is now
> part of the trace event's format.  In theory userspace tools should now work.
>

Thanks, applied.

> In practice both perf and trace-cmd are not happy with the new exit_reason
> formatting expression (omitting the details and split across lines for easy
> email reading here):
>
> print fmt: "reason %s rip 0x%lx info %llx %llx",
>             (REC->isa == 1) ?
>             __print_symbolic(REC->exit_reason, { 0, "EXCEPTION_NMI" }, ...) :
>             __print_symbolic(REC->exit_reason, { 0x000, "read_cr0" }, ...),
>             REC->guest_rip, REC->info1, REC->info2
>
> perf script says:
>
>    Warning: Error: expected type 5 but read 4
>    Warning: Error: expected type 5 but read 0
>    Warning: unknown op '}'
>
> kvm  2696 [001]   289.850941: kvm_exit: EVENT 'kvm_exit' FAILED TO PARSE
>
> trace-cmd says:
>
>    Error: expected type 5 but read 4
>    Error: expected type 5 but read 0
>    failed to read event print fmt for kvm_exit
>
> kvm-2696  [000]  1451.564092: kvm_exit: [FAILED TO PARSE] exit_reason=44 guest_rip=0xc01151a8 isa=1 info1=4272 info2=0
>
> I'd really like to make perf and trace-cmd just work with kvm:kvm_exit.  Any
> suggestions other than improving the parsers in the respective tools?

trace-cmd has a plugin API (and a kvm plugin) that you can use for this, 
and I expect perf either does as well or can make use of one.  I don't 
think it's useful to complicate the print format description further to 
support our weird use case.

-- 
error compiling committee.c: too many arguments to function
