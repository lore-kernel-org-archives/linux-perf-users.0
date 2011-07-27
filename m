From: Avi Kivity <avi@redhat.com>
Subject: Re: [RFC 0/2] KVM: Fix kvm_exit trace event format
Date: Wed, 27 Jul 2011 15:59:21 +0300
Message-ID: <4E300BA9.8010202@redhat.com>
References: <1311335213-4148-1-git-send-email-stefanha@linux.vnet.ibm.com> <4E2FFAC8.7080309@redhat.com> <20110727125506.GA21024@stefanha-thinkpad.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42160 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231Ab1G0M71 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 Jul 2011 08:59:27 -0400
In-Reply-To: <20110727125506.GA21024@stefanha-thinkpad.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>

On 07/27/2011 03:55 PM, Stefan Hajnoczi wrote:
> >
> >  trace-cmd has a plugin API (and a kvm plugin) that you can use for
> >  this, and I expect perf either does as well or can make use of one.
> >  I don't think it's useful to complicate the print format description
> >  further to support our weird use case.
>
> The problem with relying on a plugin is that every userspace application
> (currently two that I am aware of: perf and trace-cmd) has to add
> special-case kvm code to work around our crappy format.

Move the plugins to tools/trace-formats and install them in 
/lib/modules/$(uname -r)/tracepoint-formats/*.so.

> With these patches we at least get back to an event format that is
> self-describing - no plugin necessary.

There will always be special cases.  Look at how trace-cmd formats the 
kvm_emulate_insn event.

-- 
error compiling committee.c: too many arguments to function
