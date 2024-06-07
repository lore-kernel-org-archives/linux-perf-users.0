Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA215B560;
	Fri,  7 Jun 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758149; cv=none; b=uoWqMgLET+b8W/b/NZCrXIMcOb9BSHRnayuGgKhGsZm5XTfxFfYxMgQZmvWjXJzPA+Sf7VUB1U0XgPtDaNSjtRBknjBxfGRg5UE+5vyLuydnj+JYwTdJ9iKmBBUlXcE8Db3YJQoNUb1l9GCOn5uy+P4s8DC9kuaurlck2+8dKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758149; c=relaxed/simple;
	bh=31GgexcteAy46BdiICGggudKV8D+FokS7DSvMVT7yok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuwPutMR6i4Ye5vxjnpXEJuXRs2i83m5XcntAwPEfqFNcO8SG4u+zgjo9HpKxk5G7l0uJRpFeixxMofjgouaankwJW0AeNmCQ5r50hl8hSOLBJvzfuHp7fBMAoItjm2FmIBtN2T8cKkbH5WWAJ03q1TY/UTwp0xKgZN7O3y6/hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WI2MUsWC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WI2MUsWC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ZzObR5/1jE9DdcDpWjXbNWcgdEcBTpXaM/gqNaC7VGg=; b=WI2MUsWCJkZGHu+Q33zOJ1mGPG
	4MIV0wLr7AmDzyLxLfgUcACeHawlsvhMn93b4qzygEFaSOdvwU3qr0AAS0aYepybmoIi9qe/eGAUN
	dXnAOM1FcBs0YvX4KqTFwdYDPq1yKBoLdtululSnYmBLP7XwgTnnzeq7OiwWw81rBJ1b1ih46OOmE
	wF/zstvost3Spxsuhrzkx66D4phT7r04/ZI8khoIBDCLlWvp7QGPC90tYWfLsh163QsSeuxqWlKWh
	gYilPwJRusNvM+ZleWwmxEZWvcPUHtvBIi7JGqYaMfhGVCX1Upq6SXg0Yfr1y+CssEeQQ7OiVVVXP
	ClDSTRZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFXMP-0000000613W-1ZoM;
	Fri, 07 Jun 2024 11:02:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8DFAD30047C; Fri,  7 Jun 2024 13:02:14 +0200 (CEST)
Date: Fri, 7 Jun 2024 13:02:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ben Gainey <Ben.Gainey@arm.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"acme@kernel.org" <acme@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	James Clark <James.Clark@arm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v7 1/4] perf: Support PERF_SAMPLE_READ with inherit
Message-ID: <20240607110214.GQ8774@noisy.programming.kicks-ass.net>
References: <20240606144059.365633-1-ben.gainey@arm.com>
 <20240606144059.365633-2-ben.gainey@arm.com>
 <20240607093254.GN8774@noisy.programming.kicks-ass.net>
 <451afb8eb03f1519c482a84a6c1cbd1e62222988.camel@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <451afb8eb03f1519c482a84a6c1cbd1e62222988.camel@arm.com>

On Fri, Jun 07, 2024 at 10:16:15AM +0000, Ben Gainey wrote:

> > > @@ -3532,11 +3544,18 @@ perf_event_context_sched_out(struct
> > > task_struct *task, struct task_struct *next)
> > >   perf_ctx_disable(ctx, false);
> > >  
> > >   /* PMIs are disabled; ctx->nr_pending is stable. */
> > > - if (local_read(&ctx->nr_pending) ||
> > > + if (ctx->nr_inherit_read ||
> > > +     next_ctx->nr_inherit_read ||
> > > +     local_read(&ctx->nr_pending) ||
> > >       local_read(&next_ctx->nr_pending)) {
> > 
> > This seems unfortunate, nr_pending and nr_inherit_read are both used
> > exclusively to inhibit this context switch optimization. Surely they
> > can
> > share the exact same counter.
> > 
> > That is, rename nr_pending and use it for both?
> 
> Sure, how about "nr_no_switch_fast" ?

Yeah, I suppose.


> Sure, presumably you are happy with just calling
> "perf_event_count(event, false)" everywhere it is currently used,
> rather than renaming it to something shorter and keeping the two
> functions?

Yeah, there aren't *that* many instances. Your current patch already
touches them all anyway.

> > That is, I would really rather you had:
> > 
> > static inline u64 perf_event_count(struct perf_event *event, bool
> > self)
> > {
> >  if (self)
> >  return local64_read(&event->count);
> > 
> >  return local64_read(&event->count) + local64_read(&event-
> > >child_count);
> > }
> > 
> > And then actually use that argument as intended.
> 
> 
> Fair point.
> 
> I was trying to avoid the 3 subsequent uses all having to repeat
> "from_sample && has_inherit_and_sample_read(&event->attr)", which feels
> a bit of a pit-trappy. 
> 
> I suppose I could pull that into a "use_self_value(from_sample,event)"?

IIRC they all originate in a single location around perf_output_read(),
that already has the event and could easily 'correct' the semantic
meaning by doing the above once or so.

> > 
> > > @@ -7205,13 +7232,14 @@ void perf_event__output_id_sample(struct
> > > perf_event *event,
> > >  
> > >  static void perf_output_read_one(struct perf_output_handle
> > > *handle,
> > >   struct perf_event *event,
> > > - u64 enabled, u64 running)
> > > + u64 enabled, u64 running,
> > > + bool from_sample)
> > >  {
> > >   u64 read_format = event->attr.read_format;
> > >   u64 values[5];
> > >   int n = 0;
> > >  
> > > - values[n++] = perf_event_count(event);
> > > + values[n++] = perf_event_count(event, from_sample);
> > 
> > ...observe the fail... from_sample != self-value-only
> 
> By fail you are referring to the difference in names?

The difference in meaning, one is from-sample, the other is self-value.
Per the extra condition squirrelled away they are not equivalent.
