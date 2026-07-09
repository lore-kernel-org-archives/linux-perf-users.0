Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72953D7A18;
	Thu,  9 Jul 2026 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579655; cv=none; b=hz0xFqq6YQz3sVkjAKh1EleyZwU5ihE3qfRa85RdCyRS6vAUE23h7U028shCs9r8W2cNUoULOwcK0KFzDDttczRbA/bj09Db3KgoUGVyTraUr1yt+zo1leN6vNiKdF5NGsoI0FeJCnlhPuQe9aaAvVO1X6EedZFBYw9ou+56LuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579655; c=relaxed/simple;
	bh=MdU/wNVVBYqXc42Pab5uoBjN2kX6B6qAfeErF943Jbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwcuANpBi8qr8gs4v9j1nW2WWWta44g7RogYLV6LtzTr/fBnLoZASXTEj+5UkArcCect0qmrZA8ZrxMx+A8AJ/wjDMUJIiGhXRYTGV+xIO+3Y9Xt2sxSjwJNSNOLgchDLF0nX1vEJjz/Q07m9SDeYr5MuUxWsAW7tDuF6qHoiPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCRNvTHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCRNvTHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A731F000E9;
	Thu,  9 Jul 2026 06:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783579653;
	bh=VAS7h2YmHQEjz4IwBx3vm3tL7iezOxoJk/jcErcJPr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RCRNvTHOYYSSwrV6GgGqMP6SMW4XeWAKZGNT/BaL7Ri6+dN8P2QVxwmh0MpyG8xKT
	 iPNWlbGekeiDCCOCoDN+Cn/y+x+GT6b4ozsh+pxbAIhUIuaKujG4qKTTXn1CGmVJmW
	 GOFzbz4yGcYyT9HGPm7ffwwk2CCNeGt/WkGe7eW7mOLhEoHljptHVIaKvuPMyA/ElN
	 n/hAvLSzLtEU2htsEWw1rPFjeopfXzXO6DWjRbjrk+kL9o43AXw58L1VlPv0K5QIKB
	 5Ockemxbzi1LCjb6sKZyf3lsucZB0Dx4SVy2UbuVsIVo5xKB75HtSNJTcAruzCx+Kp
	 bj56HgWLjT06A==
Date: Wed, 8 Jul 2026 23:47:31 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 10/21] perf annotate: Deduplicate overlapping ARM SPE
 events for data type profiling
Message-ID: <ak9EAwRizNby2Tvu@z2>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-11-wutengda@huaweicloud.com>
 <20260701040606.2C96B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701040606.2C96B1F000E9@smtp.kernel.org>

On Wed, Jul 01, 2026 at 04:06:05AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Invalid union access causes severe type punning, false positive event dropping, and logic failure.
> - [Medium] Unprotected dereference of potentially NULL `evsel->name` causing a segmentation fault.
> --
> 
> commit 21f6f127e80c94aececac4065deebfce02da27b3
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate: Deduplicate overlapping ARM SPE events for data type profiling
> 
> When data type profiling is enabled on ARM SPE, multiple overlapping
> events are synthesized for a single sampled instruction. This patch
> implements automatic deduplication in process_sample_event() by retaining
> only the "instructions" event when data type annotation is enabled and no
> explicit itrace options are configured.
> 
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > index 69cb72b2082a6..46b2bd3fb2013 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -283,9 +283,22 @@ static int process_sample_event(const struct perf_tool *tool,
> >  				struct machine *machine)
> >  {
> >  	struct perf_annotate *ann = container_of(tool, struct perf_annotate, tool);
> > +	struct evsel *evsel = sample->evsel;
> >  	struct addr_location al;
> >  	int ret = 0;
> >  
> > +	/*
> > +	 * ARM SPE synthesizes multiple overlapping events (e.g., l1d-miss,
> > +	 * tlb-access) for a single sampled instruction. When data type is
> > +	 * enabled, counting all of these overlapping events would inflate
> > +	 * the profile and distort the data type statistics. To avoid this,
> > +	 * deduplicate by retaining only the comprehensive "instructions" event.
> > +	 */
> > +	if (ann->data_type && !ann->session->itrace_synth_opts->set &&
> > +	    event->auxtrace_info.type == PERF_AUXTRACE_ARM_SPE &&
> 
> [Severity: Medium]
> Since event is a union of all perf events, does checking
> event->auxtrace_info.type on a PERF_RECORD_SAMPLE event read the sample data
> payload as if it were an auxtrace type?
> 
> If a normal event's first 32-bit payload (like PID 4 when PERF_SAMPLE_TID
> is the first element) equals 4 (PERF_AUXTRACE_ARM_SPE), could this falsely
> match and silently drop the event?

Right, you should not access event->auxtrace in process_sample_event().
You need to find other way to detect if it's processing an ARM SPE
synthesized sample.

> 
> > +	    strcmp(evsel->name, "instructions") != 0)
> 
> [Severity: Medium]
> Could evsel->name be NULL here if the event is unnamed or if we are
> processing a perf.data file missing the HEADER_EVENT_DESC feature?
> 
> Passing NULL to strcmp() would cause a segmentation fault. Would it be safer
> to use the evsel__name(evsel) wrapper instead?

Agreed.

> 
> > +		return 0;
> > +
> >  	addr_location__init(&al);
> 
> [ ... ]
> 
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index 552f063f126e6..e027e3b200bfb 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -403,6 +403,7 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
> >  	event->sample.header.type = PERF_RECORD_SAMPLE;
> >  	event->sample.header.misc = sample->cpumode;
> >  	event->sample.header.size = sizeof(struct perf_event_header);
> > +	event->auxtrace_info.type = PERF_AUXTRACE_ARM_SPE;
> 
> [Severity: Medium]
> Writing to auxtrace_info.type modifies offset 8 of the event union, which
> aliases the sample payload.
> 
> If trace injection is used, does perf_event__synthesize_sample() subsequently
> overwrite this offset with the actual sample payload (such as sample->id),
> erasing this magic value and breaking the deduplication entirely?

Right, please don't do this.

Thanks,
Namhyung

