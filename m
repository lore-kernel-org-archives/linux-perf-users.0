From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/6] perf record: add time-of-day option
Date: Tue, 01 Mar 2011 16:35:14 +0100
Message-ID: <1298993714.5226.871.camel@laptop>
References: <1298865151-23656-1-git-send-email-daahern@cisco.com>
	 <1298865151-23656-4-git-send-email-daahern@cisco.com>
	 <1298989751.5226.863.camel@laptop>  <4D6D0438.2090901@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D6D0438.2090901@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

On Tue, 2011-03-01 at 07:35 -0700, David Ahern wrote:
> 
> On 03/01/2011 07:29 AM, Peter Zijlstra wrote:
> 
> >> +/* add a sample to the event stream based on user request */
> >> +static int perf_event_generate_sample(struct perf_event *event)
> >> +{
> >> +       struct perf_sample_data data;
> >> +       struct pt_regs regs;
> >> +
> >> +       perf_fetch_caller_regs(&regs);
> >> +       event->pmu->read(event);
> >> +       perf_sample_data_init(&data, 0);
> >> +       data.period = event->hw.last_period;
> >> +       perf_event_output(event, 0, &data, &regs);
> >> +
> >> +       return 0;
> >> +}
> > 
> > I'm not quite sure why you need this.. 
> > 
> 
> periodic samples are generated after the specified period. I want the
> first sample immediately and the remainder based on the set period.
> 
> So generically, how do you get the first sample into the event stream
> and let the others happen based on the timer? I need not only the
> counter value but also the perf_clock timestamp that comes from the
> SAMPLE_TIME attribute.

Again, why?
