From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Tracing kvm: kvm_entry and kvm_exit
Date: Mon, 25 Feb 2013 11:18:04 +0100
Message-ID: <20130225101804.GC2790@stefanha-thinkpad.redhat.com>
References: <1361550867.51279e13338a7@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:47180 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758011Ab3BYKSI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 25 Feb 2013 05:18:08 -0500
Content-Disposition: inline
In-Reply-To: <1361550867.51279e13338a7@www.imp.polymtl.ca>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mohamad Gebai <mohamad.gebai@polymtl.ca>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org

On Fri, Feb 22, 2013 at 11:34:27AM -0500, Mohamad Gebai wrote:
> I am tracing kvm using perf and I am analyzing the sequences of kvm_entry and
> kvm_exit tracepoints.
> I noticed that during the boot process of a VM, there are a lot more (2 to 3 as
> many times) kvm_entry event than there are kvm_exit. I tried looking around but
> didn't find anything that explains this. Is this missing instrumentation? Or
> what other path does kvm take that doesn't generate a kvm_exit event?

Gleb Natapov noticed something similar when playing with the perf script
I posted here:

http://permalink.gmane.org/gmane.comp.emulators.kvm.devel/104181

Perhaps there is a code path that is missing trace_kvm_exit().

We didn't investigate why it happens but the unexplained kvm_entry
events only appeared at the beginning of the trace, so the theory was
that events are not activated atomically by perf(1).

CCing perf mailing list.

It would be interesting if someone knows the answer.

Stefan
