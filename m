Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797C165F03
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Aug 2024 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722623192; cv=none; b=ZR4mKJMkS6kdNVd7HR2bg6oG5WGgOmClocp5oiQG6ahTPrddY/6D1aw0CRYu5N++jPjfwQCxSdrEXRqls1AYGVNL+aE6D4oARo48VB7aPdfNK2vAz5iQC+DEk7Cb28Rt+dPsUeWIV8SBzyp0c23KQWKHAIsoTb2fq9alLG7STZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722623192; c=relaxed/simple;
	bh=QHVuIGobu/uFlrgbPzN3kBTmYf5lEpcAjz9UZZ+P7gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zv5lsDkTp1IfzD4dE8950Ht3uo1pWPbq2Q4pVahRt7tCE/1cZ6SBp2Ebiz4ZZdKkYkws/aR/EQl3rX9QTzpRSn7en2vLVe5O0SR3fsjaVIOh05ymLPbagsuAJxhRuEv+QuRvmiW/F84Acpj3HoLpibNsF2vw/TGZfD9JHOj/OAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkVX+qmm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkVX+qmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C462C32782;
	Fri,  2 Aug 2024 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722623192;
	bh=QHVuIGobu/uFlrgbPzN3kBTmYf5lEpcAjz9UZZ+P7gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkVX+qmmv7ypDlbIZq14gL/nNOUmlqGcUU7rJNr4DXRxG3VUxXrRNhAxHqhikGGSv
	 CV4HU77Ug6lZrQdXNVA8ktSKvrzJ/3N5hbTb1VSWhEGKz+8nxLtvi1g8690D7JEkhZ
	 IlF1fKSeVHoPIX2nNgCJdOPOzgMLEk28MhStm5iJSVB5KJYIREVYT6HhtuGI+tlp6r
	 eXp+yNyH/lTvCAMrqo/a8OtqxtV1c8ngCutyEwhMP4mc/xFC8PYYm0MUYWR5ADSSe8
	 Pdv6TNAqKg1HYyo8K76AGxDHoct0ektUD1vMpyDGP+jj/0yffGIZ2x51aupZ9wq7Xn
	 Cz5qseYK825pQ==
Date: Fri, 2 Aug 2024 11:26:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 3/4] perf script: Fix perf script -F +metric
Message-ID: <Zq0k1pRHZWB4N94a@google.com>
References: <20240724190137.3810429-1-ak@linux.intel.com>
 <20240724190137.3810429-3-ak@linux.intel.com>
 <ZqLuWGKZjdUrkd0L@google.com>
 <ZqqRTKW80JJpNpRj@tassilo>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqqRTKW80JJpNpRj@tassilo>

On Wed, Jul 31, 2024 at 12:32:28PM -0700, Andi Kleen wrote:
> > > @@ -2132,13 +2131,17 @@ static void perf_sample__fprint_metric(struct perf_script *script,
> > >  		evlist__alloc_stats(&stat_config, script->session->evlist, /*alloc_raw=*/false);
> > >  	if (evsel_script(leader)->gnum++ == 0)
> > >  		perf_stat__reset_shadow_stats();
> > > -	val = sample->period * evsel->scale;
> > > -	evsel_script(evsel)->val = val;
> > > +	val = sample->period;
> > > +	/*
> > > +	 * Always use the first storage because the groups are contiguous
> > 
> > Without leader sampling we cannot guarantee groups events fire
> > together, right?
> 
> Yes. I'm adding an explicit check for this.
> 
> > 
> > 
> > > +	 * and there's no need to handle multiple indexes for anything
> > 
> > Actually I think this is a behavior change that you changed the
> > aggregation mode from NONE to GLOBAL.
> 
> Not with leader sampling because the group is contiguous and output
> after its end, with all the previous values forgotten then.
> The other cases don't really work anyways as multiple people pointed
> out.

Right, but we cannot prevent people to do that..  Maybe we can disable
metric with a warning if leader sampling is not used?  Or at least add
a comment in the code that it's only intended for the use case.

Thanks,
Namhyung

> 
> > > +	 */
> > > +	evsel->stats->aggr[0].counts.val = val;
> > >  	if (evsel_script(leader)->gnum == leader->core.nr_members) {
> > >  		for_each_group_member (ev2, leader) {
> > >  			perf_stat__print_shadow_stats(&stat_config, ev2,
> > > -						      evsel_script(ev2)->val,
> > > -						      sample->cpu,
> > > +						      evsel->stats->aggr[0].counts.val,
> > > +						      0,
> > 
> > Like I said to Ian, we should pass a proper aggr_idx here not just 0 to
> > support correct aggregation.  For now I think only possible choice is
> > AGGR_NONE (for cpu-wide record) or AGGR_THREAD (for per-task record).
> > Then it should be an index to cpu or thread map.
> 
> Given the above I think that is not needed.
> 
> Full aggregation for metrics over longer period would belong into perf report,
> not here.  perf script is only to get non aggregated metrics.
> 
> -Andi
