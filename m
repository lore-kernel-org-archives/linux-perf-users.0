Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C24B1428E6;
	Wed,  7 Aug 2024 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057796; cv=none; b=VQ//pvOLgkzNVaprt41znukG8YYJDK3j4DPFNUfRz8xLu1toN8FSqwlZesu3NizHaLBQRJ634H5teP//67chmJ513LEv+EzE8aDiLZUXaLLoqtzLDQoKxvu56cwKlZX4McxEhT9XcI8p/NPNTf3uRWnq1VSAh0xg38bIQFspfOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057796; c=relaxed/simple;
	bh=Xji/ATx10iwZfKisohudZjN5LAal7yhXNA5ZtAAIh+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAOBOp5Fpk2CX6eL8jB471qXVTaI79vEfBXQKjMvPdvdnYU5Uc8XczzUGB3mXooGh/kNpCimiHfNjyeUhlfdyQMsZR49GM1MLsli8bGzzSiXolI48emKO6caigaZVs3ivhpycNSISCniVIhMygxPklC2woFaaVy+h9agAEXu0qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bsDX5Y4w; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bsDX5Y4w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TUImU5qAYykz6ldY6pOIccN64e/13Blmc1VBBfsV0vc=; b=bsDX5Y4w9mAzMi/5nx0awTF4CN
	hh0pdhc/uZr0gyl0XkchdWWjwoWnj/U4NBd+tYsGq0jhSmjKK61EJ2FLdaZQcZryjU5K6GaK8DHIY
	ocm26uLaMjVC+XLa5/cSzZlq0HPPyZ1d8gIOPvnaLqMRw7U6TzTTZD/lGfc3yJE8gmHi1TuF5wWZR
	1XVztRGbitxcC9iSSBBwry/RJQ8GGjLW81aSo3ov3OJnc4IbPD/GSebqovMT6IcpgolAspoJVUbWH
	XDol7DyYKnfE/34y1FC6L2rOACr5yq38tBxVovR88lEBsOirehoAGO0UV8+hUWhbqRTQVqXRIEnqy
	RTLGsGkA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbm2E-00000006gJD-14G9;
	Wed, 07 Aug 2024 19:09:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4A75830033D; Wed,  7 Aug 2024 21:09:21 +0200 (CEST)
Date: Wed, 7 Aug 2024 21:09:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] perf: Add context time freeze
Message-ID: <20240807190921.GE31338@noisy.programming.kicks-ass.net>
References: <20240807112924.448091402@infradead.org>
 <20240807115550.250637571@infradead.org>
 <b38cc358-8e46-48bd-88c0-ff4b8db6bd15@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b38cc358-8e46-48bd-88c0-ff4b8db6bd15@linux.intel.com>

On Wed, Aug 07, 2024 at 11:17:18AM -0400, Liang, Kan wrote:

> > +static inline void __perf_ctx_unlock(struct perf_event_context *ctx)
> > +{
> > +	/*
> > +	 * If ctx_sched_in() didn't again set any ALL flags, clean up
> > +	 * after ctx_sched_out() by clearing is_active.
> > +	 */
> > +	if (ctx->is_active & EVENT_FROZEN) {
> > +		if (!(ctx->is_active & EVENT_ALL))
> 
> Nit:
> It may be better to add a macro/inline function to replace all the
> (ctx->is_active & EVENT_ALL) check? For example,
> 
> +static inline bool perf_ctx_has_active_events(struct perf_event_context
> *ctx)
> +{
> +	return ctx->is_active & EVENT_ALL;
> +}
> ...
> +	if (ctx->is_active & EVENT_FROZEN) {
> +		if (!perf_ctx_has_active_events(ctx))
> +			ctx->is_active = 0;
> +		else
> +			ctx->is_active &= ~EVENT_FROZEN;
> 
> It can tell very straightforwardly that we want to clear all flags if
> there is no active event.
> The EVENT_ALL may bring confusion. It actually means all events, not all
> event types. The developer may have to go to the define and figure out
> what exactly the EVENT_ALL includes.

I'll push this on the todo list. I'm running short of time before I'm
taking a holiday and need to also spend time looking at the sched_ext
thing.
