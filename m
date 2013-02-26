From: Mohamad Gebai <mohamad.gebai@polymtl.ca>
Subject: Re: Tracing kvm: kvm_entry and kvm_exit
Date: Tue, 26 Feb 2013 11:24:46 -0500
Message-ID: <1361895886.512ce1cee4edd@www.imp.polymtl.ca>
References: <1361550867.51279e13338a7@www.imp.polymtl.ca> <20130225101804.GC2790@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20130225101804.GC2790@stefanha-thinkpad.redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

I did the same experience using LTTng where the events and counters are
activated before launching kvm. So the problem doesn't seem to be with the
activation time but rather with tracepoint instrumentation within kvm. I will
investigate on it but if anyone has any kind of explanation it would be
appreciated.

Selon Stefan Hajnoczi <stefanha@gmail.com>:

> On Fri, Feb 22, 2013 at 11:34:27AM -0500, Mohamad Gebai wrote:
> > I am tracing kvm using perf and I am analyzing the sequences of kvm_entry
> and
> > kvm_exit tracepoints.
> > I noticed that during the boot process of a VM, there are a lot more (2 to
> 3 as
> > many times) kvm_entry event than there are kvm_exit. I tried looking around
> but
> > didn't find anything that explains this. Is this missing instrumentation?
> Or
> > what other path does kvm take that doesn't generate a kvm_exit event?
>
> Gleb Natapov noticed something similar when playing with the perf script
> I posted here:
>
> http://permalink.gmane.org/gmane.comp.emulators.kvm.devel/104181
>
> Perhaps there is a code path that is missing trace_kvm_exit().
>
> We didn't investigate why it happens but the unexplained kvm_entry
> events only appeared at the beginning of the trace, so the theory was
> that events are not activated atomically by perf(1).
>
> CCing perf mailing list.
>
> It would be interesting if someone knows the answer.
>
> Stefan
>



