From: Gleb Natapov <gleb@redhat.com>
Subject: Re: Tracing kvm: kvm_entry and kvm_exit
Date: Tue, 26 Feb 2013 18:32:54 +0200
Message-ID: <20130226163254.GA26996@redhat.com>
References: <1361550867.51279e13338a7@www.imp.polymtl.ca>
 <20130225101804.GC2790@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62278 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932643Ab3BZQdD (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 26 Feb 2013 11:33:03 -0500
Content-Disposition: inline
In-Reply-To: <20130225101804.GC2790@stefanha-thinkpad.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Mohamad Gebai <mohamad.gebai@polymtl.ca>, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org

On Mon, Feb 25, 2013 at 11:18:04AM +0100, Stefan Hajnoczi wrote:
> On Fri, Feb 22, 2013 at 11:34:27AM -0500, Mohamad Gebai wrote:
> > I am tracing kvm using perf and I am analyzing the sequences of kvm_entry and
> > kvm_exit tracepoints.
> > I noticed that during the boot process of a VM, there are a lot more (2 to 3 as
> > many times) kvm_entry event than there are kvm_exit. I tried looking around but
> > didn't find anything that explains this. Is this missing instrumentation? Or
> > what other path does kvm take that doesn't generate a kvm_exit event?
> 
> Gleb Natapov noticed something similar when playing with the perf script
> I posted here:
> 
> http://permalink.gmane.org/gmane.comp.emulators.kvm.devel/104181
> 
> Perhaps there is a code path that is missing trace_kvm_exit().
> 
During guest boot there is such path. If instruction is emulated entry
is reported but exit is not. What we saw with perf was different though,
It was during normal run, not boot, so emulation cannot explain it.

> We didn't investigate why it happens but the unexplained kvm_entry
> events only appeared at the beginning of the trace, so the theory was
> that events are not activated atomically by perf(1).
> 
> CCing perf mailing list.
> 
> It would be interesting if someone knows the answer.
> 
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
			Gleb.
