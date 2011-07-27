From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: Re: [RFC 0/2] KVM: Fix kvm_exit trace event format
Date: Wed, 27 Jul 2011 13:55:06 +0100
Message-ID: <20110727125506.GA21024@stefanha-thinkpad.localdomain>
References: <1311335213-4148-1-git-send-email-stefanha@linux.vnet.ibm.com>
 <4E2FFAC8.7080309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162]:44501 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab1G0MzY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 Jul 2011 08:55:24 -0400
Content-Disposition: inline
In-Reply-To: <4E2FFAC8.7080309@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>

On Wed, Jul 27, 2011 at 02:47:20PM +0300, Avi Kivity wrote:
> On 07/22/2011 02:46 PM, Stefan Hajnoczi wrote:
> >In practice both perf and trace-cmd are not happy with the new exit_reason
> >formatting expression (omitting the details and split across lines for easy
> >email reading here):
> >
> >print fmt: "reason %s rip 0x%lx info %llx %llx",
> >            (REC->isa == 1) ?
> >            __print_symbolic(REC->exit_reason, { 0, "EXCEPTION_NMI" }, ...) :
> >            __print_symbolic(REC->exit_reason, { 0x000, "read_cr0" }, ...),
> >            REC->guest_rip, REC->info1, REC->info2
> >
> >perf script says:
> >
> >   Warning: Error: expected type 5 but read 4
> >   Warning: Error: expected type 5 but read 0
> >   Warning: unknown op '}'
> >
> >kvm  2696 [001]   289.850941: kvm_exit: EVENT 'kvm_exit' FAILED TO PARSE
> >
> >trace-cmd says:
> >
> >   Error: expected type 5 but read 4
> >   Error: expected type 5 but read 0
> >   failed to read event print fmt for kvm_exit
> >
> >kvm-2696  [000]  1451.564092: kvm_exit: [FAILED TO PARSE] exit_reason=44 guest_rip=0xc01151a8 isa=1 info1=4272 info2=0
> >
> >I'd really like to make perf and trace-cmd just work with kvm:kvm_exit.  Any
> >suggestions other than improving the parsers in the respective tools?
> 
> trace-cmd has a plugin API (and a kvm plugin) that you can use for
> this, and I expect perf either does as well or can make use of one.
> I don't think it's useful to complicate the print format description
> further to support our weird use case.

The problem with relying on a plugin is that every userspace application
(currently two that I am aware of: perf and trace-cmd) has to add
special-case kvm code to work around our crappy format.

With these patches we at least get back to an event format that is
self-describing - no plugin necessary.

However, since the event format parser in perf and trace-cmd is not
powerful enough to handle the ternary operator together with
__print_symbolic() I guess the parsers need to be improved.  It's not a
special-case hack for kvm.

If I have the time I'll try to make those parser improvements.

Stefan
