Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30D1CAAF;
	Fri,  4 Oct 2024 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002682; cv=none; b=SlEJ+BtfTtFDSDQ5xE2Is7UWt1HcBGDsD66lpPMGFSKM/p8WYhmlFo4CWK7t9NkK4FuWdoNEp+BWaY6nL2F+WqcBPC/RgeuU2F2LkJgV2Yi7b/IGmp609A35dlRka8EJWqNdTXcOLa/ikoaA9ke9LHMDyBX0aDQPwFZsIThYISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002682; c=relaxed/simple;
	bh=A1WCzbPjHO2ZeoKcWWlqBK7vgVaDlWdDUk+OkFLJU4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odoaEuSU1YsGl/tD8RZL6f93eMZ2ppvCE2KLjqBdg2msCcD512xRFaRdR6VrkT+TC5YGs0aE4WWEc01FWhBCychhBl3ve8kbUeQnCkguLoSYeQUJcIRRobVIZQB0Vd7WfVNYUpEa4/k7R3m+08bciO0xz4klHZuf/6gSxFF4AjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mP0NWcIM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mP0NWcIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60D9C4CEC5;
	Fri,  4 Oct 2024 00:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728002682;
	bh=A1WCzbPjHO2ZeoKcWWlqBK7vgVaDlWdDUk+OkFLJU4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mP0NWcIMCK9P6isHubJChB+2WKHg2yP4inI90hYbg3xTcB+Rbk3k1F8V4rQsn9KUe
	 2foK6t3y4sNqqbdHOZjDhBQzQY48QM0qnGQJZEWJX1WcpW5NUoqg/Dq7zXaoyCrhd/
	 SQCXIHKImxzfa+Mq2AGUoReRdTdXzPOruGob4LzDgI7cSHmGJpTV0kwNUOpduBlE4X
	 OKurgnDj9gq6/FXK7XzFyYdZeXrOFyInF3bcsrlG675wf+Ax020T2YnXILiNInYtJc
	 /xjncPlXeCyg7E6vdU3JQOKQ8L1v0U1VoGYAobT6X45NCedafEqB9ilZwT84nh8Ayq
	 d1gqfJrFyobQw==
Date: Thu, 3 Oct 2024 17:44:40 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yeo Reum Yun <YeoReum.Yun@arm.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"a.p.zijlstra@chello.nl" <a.p.zijlstra@chello.nl>,
	"mingo@elte.hu" <mingo@elte.hu>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"james.clark@linaro.org" <james.clark@linaro.org>, nd <nd@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] trace/trace_event_perf: remove duplicate samples on
 the first tracepoint event
Message-ID: <Zv86eKWFcSOnzS4J@google.com>
References: <20240913021347.595330-1-yeoreum.yun@arm.com>
 <20240926085118.0a823138@rorschach.local.home>
 <GV1PR08MB10521EC72BDB730710F3973D4FB772@GV1PR08MB10521.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <GV1PR08MB10521EC72BDB730710F3973D4FB772@GV1PR08MB10521.eurprd08.prod.outlook.com>

Hello,

On Tue, Oct 01, 2024 at 08:48:45AM +0000, Yeo Reum Yun wrote:
> Gentle ping in case of forgotten.
> 
> ________________________________________
> From: Steven Rostedt <rostedt@goodmis.org>
> Sent: 26 September 2024 13:51
> To: Yeo Reum Yun
> Cc: mhiramat@kernel.org; mathieu.desnoyers@efficios.com; a.p.zijlstra@chello.nl; mingo@elte.hu; Mark Rutland; james.clark@linaro.org; nd; linux-kernel@vger.kernel.org; linux-trace-kernel@vger.kernel.org; Peter Zijlstra; Frederic Weisbecker; Arnaldo Carvalho de Melo; Namhyung Kim
> Subject: Re: [PATCH v2] trace/trace_event_perf: remove duplicate samples on the first tracepoint event
> 
> Can one of the perf folks give me an Ack, and I'll take this through my tree.

I'm not sure if we want to support freq mode or period other than 1 for
tracepoint events.  But it looks broken apparently, so

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> On Fri, 13 Sep 2024 03:13:47 +0100
> Levi Yun <yeoreum.yun@arm.com> wrote:
> 
> > When a tracepoint event is created with attr.freq = 1,
> > 'hwc->period_left' is not initialized correctly. As a result,
> > in the perf_swevent_overflow() function, when the first time the event occurs,
> > it calculates the event overflow and the perf_swevent_set_period() returns 3,
> > this leads to the event are recorded for three duplicate times.
> >
> > Step to reproduce:
> >     1. Enable the tracepoint event & starting tracing
> >          $ echo 1 > /sys/kernel/tracing/events/module/module_free
> >          $ echo 1 > /sys/kernel/tracing/tracing_on
> >
> >     2. Record with perf
> >          $ perf record -a --strict-freq -F 1 -e "module:module_free"
> >
> >     3. Trigger module_free event.
> >          $ modprobe -i sunrpc
> >          $ modprobe -r sunrpc
> >
> > Result:
> >      - Trace pipe result:
> >          $ cat trace_pipe
> >          modprobe-174509  [003] .....  6504.868896: module_free: sunrpc
> >
> >      - perf sample:
> >          modprobe  174509 [003]  6504.868980: module:module_free: sunrpc
> >          modprobe  174509 [003]  6504.868980: module:module_free: sunrpc
> >          modprobe  174509 [003]  6504.868980: module:module_free: sunrpc
> >
> > By setting period_left via perf_swevent_set_period() as other sw_event did,
> > This problem could be solved.
> >
> > After patch:
> >      - Trace pipe result:
> >          $ cat trace_pipe
> >          modprobe 1153096 [068] 613468.867774: module:module_free: xfs
> >
> >      - perf sample
> >          modprobe 1153096 [068] 613468.867794: module:module_free: xfs
> >
> > Fixes: bd2b5b12849a ("perf_counter: More aggressive frequency adjustment")
> > Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> > ---
> > Changes in v2:
> >   - Fix build error.
> > ---
> >  kernel/trace/trace_event_perf.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> > index 05e791241812..3ff9caa4a71b 100644
> > --- a/kernel/trace/trace_event_perf.c
> > +++ b/kernel/trace/trace_event_perf.c
> > @@ -352,10 +352,16 @@ void perf_uprobe_destroy(struct perf_event *p_event)
> >  int perf_trace_add(struct perf_event *p_event, int flags)
> >  {
> >       struct trace_event_call *tp_event = p_event->tp_event;
> > +     struct hw_perf_event *hwc = &p_event->hw;
> >
> >       if (!(flags & PERF_EF_START))
> >               p_event->hw.state = PERF_HES_STOPPED;
> >
> > +     if (is_sampling_event(p_event)) {
> > +             hwc->last_period = hwc->sample_period;
> > +             perf_swevent_set_period(p_event);
> > +     }
> > +
> >       /*
> >        * If TRACE_REG_PERF_ADD returns false; no custom action was performed
> >        * and we need to take the default action of enqueueing our event on
> > --
> > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 
