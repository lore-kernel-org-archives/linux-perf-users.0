Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC513D3B3;
	Wed,  4 Mar 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637809; cv=none; b=A8V+vHkQ++7qkcths/WWLwC7Ge9kwfHuTaKIAVM/ti+eS+qP46XS5gT1C3/hqpDD1YJz3fA+3NOYohekBwiS4KRLTQJKyEW7bufYtusJrvssPRd3PxkSVtK36530X78B5uNLJ17m8KlsppDaBFnF1ih4zTx93YRG/Jvxf1pX2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637809; c=relaxed/simple;
	bh=rcjc/DA9gZY+Ogl3TohfVN9fersicpZ7aCs8n2GZi48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoAroLiBHLV3Ygm9qVioqlJAzXO10hJT0iqw3qArnDv1c9byFR4fLUnwZRNwxDMlIsoMC2xa3I7Ht5O73TmHgv05JAeuVxLfIdgSOe+UScdeoI2x8s1/1n7o+PVBfk1rXsUFXSD2yHJvnXJ7qhl1Rg/1RJU8Mft+jMeQ6jiqQT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eFxzQUT2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eFxzQUT2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rBmkKRMNxTQxuyqVoa4xSqzsld5mG9Xsk1fSIhA25UI=; b=eFxzQUT2exJ2k6tOjjObiTVqAH
	xJN7Jj3DyfxAmk6SXAFeo1KyeLcCGDfWDtURHnA/kL7UmDI8jphHayTzyI/jNukh0fIoSlm8ctToc
	D1pPsmzw6ed2X6SedrFc1+s2/ENIjyuVRLfxbJMiZCndzmmWjh0BZ0nClNEw43v+daBiqRCZdkKE8
	i7I2wqpBXnkqOV85Ntaxk2LKgfzc5oQ3/QRrQM0KbccQsEaegUkTeaYuismzKnZxT64QwRZvDgIFE
	5Z3A91MWYw3gMcgse7FWY+i8eh9vvNnYeShbVcW/AE5+yztBJF+JbZ+arG2ExvW1MMnE4eOoW2MeG
	ZYGLlZPg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxo4E-00000004vOB-0h2g;
	Wed, 04 Mar 2026 15:23:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A7344300666; Wed, 04 Mar 2026 16:23:16 +0100 (CET)
Date: Wed, 4 Mar 2026 16:23:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: James Clark <james.clark@linaro.org>
Cc: Thaumy Cheng <thaumy.love@gmail.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v3] perf/core: Fix missing read event generation on task
 exit
Message-ID: <20260304152316.GO1395266@noisy.programming.kicks-ass.net>
References: <20251024170543.11201-1-thaumy.love@gmail.com>
 <1e6337ec-d4a0-420b-bd7b-0fd2b6fee620@linaro.org>
 <20260206152907.GQ1395266@noisy.programming.kicks-ass.net>
 <61e544ab-d9b9-454e-9dd7-65625d9be126@linaro.org>
 <20260303142948.GA3698720@noisy.programming.kicks-ass.net>
 <f0a5192a-7b6a-4c51-87e9-fc1dbf4d37df@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0a5192a-7b6a-4c51-87e9-fc1dbf4d37df@linaro.org>

On Wed, Mar 04, 2026 at 11:26:10AM +0000, James Clark wrote:

> > @@ -14564,11 +14556,21 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
> >   	 * won't get any samples after PERF_RECORD_EXIT. We can however still
> >   	 * get a few PERF_RECORD_READ events.
> >   	 */
> > -	if (exit)
> > +	if (exit) {
> >   		perf_event_task(task, ctx, 0);
> > -	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
> > -		perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);
> > +		guard(raw_spinlock_irq)(&ctx->lock);
> > +		list_for_each_entry(event, &ctx->event_list, event_entry) {
> > +			if (event->attr.inherit_stat) {
> > +				if (task && task != TASK_TOMBSTONE &&
> > +				    event_filter_match(event))
> > +					perf_event_read_event(event, task);
> 
> Doesn't this only work if you happened to have an event opened on every CPU?
> Otherwise you could get rescheduled onto a core without an event and the
> event_filter_match() will fail and you'd drop the sample read for that exit.

Yes, absolutely. But that is more or less what you get.

So perf has per-task buffers and per-cpu buffers. For a simple per-task
profile, the per-task buffer works fine. However, if you want inherited
tasks, they can't all emit to the same buffer -- this would be a
scalability nightmake. So in that scenario you have to have
per-task-per-cpu events and make sure everybody emits to the local
buffer.

If you 'forget' to create an event/buffer for a particular CPU the
task(s) can run on, you loose events the moment they end up there.

There just isn't much you can do about that.
