From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/5] perf events: add support for realtime clock
 attribute
Date: Sun, 20 Mar 2011 21:05:28 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1103202101270.2787@localhost6.localdomain6>
References: <1300647277-8431-1-git-send-email-daahern@cisco.com> <1300647277-8431-2-git-send-email-daahern@cisco.com> <alpine.LFD.2.00.1103202000500.2787@localhost6.localdomain6> <4D865A3E.9040605@cisco.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D865A3E.9040605@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org
List-Id: linux-perf-users.vger.kernel.org

On Sun, 20 Mar 2011, David Ahern wrote:

> 
> 
> On 03/20/11 13:08, Thomas Gleixner wrote:
> > On Sun, 20 Mar 2011, David Ahern wrote:
> >> +
> >> +	if (sample_type & PERF_SAMPLE_REALTIME)
> >> +		data->realtime = ktime_to_ns(ktime_get_real());
> > 
> > That's going to live lock on any sample which happens to hit in a
> > xtime_lock write locked section. I knew why I suggested adding
> > tracepoints to the timekeeping code :)
> 
> Hmmm.... Can you give an example of when perf samples could be generated
> with xtime write locked?

NMI triggered samples can hit at any time.

Any tracepoint which we might add to the time keeping code inside the
xtime locked regions. And I don't want to see a restriction there.

> What are the rules for when ktime_get_real can be invoked?

Outside of xtime write locked regions.

Thanks,

	tglx
