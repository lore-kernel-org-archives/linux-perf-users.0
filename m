Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79235245008;
	Mon, 14 Sep 2026 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789345751; cv=none; b=Y3MAWxvU/eDK//hfrOe7CHWvZf3hAl6KM4WmXObW/+lshXIOAKkhOC1yhL5jA4WYbiKgoENI9PyILrfqyur/jSGIu48Ilyef4LosCXzvpqsJ8G55ndNZfYv+R4CS8nfYtTytfDAk+mBth3CM0+/K7CR+osvCSJrSO3sPWLsoyYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789345751; c=relaxed/simple;
	bh=2LmrrtKqx0DXXyXbjkq21GbD2q3pS2lNO6nhmNq8YzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgE+E40nJYYnabRVvHKiusHlgJecmlo5ek4ODPT6qITpruIdkSefaBKEgfQuBetsswQXUmlvY+6dsydfeuy0pCZUHowyVMr7BPPlUdhkZLykJC9hI+f4inX6N1jQPXQZHWvZT3ImFNAShzzKEcs9eekU3Bn5UhZPs+lG9ALZ8KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGS2Tluo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGS2Tluo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F398A1F000FF;
	Mon, 14 Sep 2026 00:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789345750;
	bh=2verzHGUbSQlwV+NjsNUlNVOzYN2XrYArztcxteulgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mGS2Tluoa+6+/qa72vCjJ0Kp2uN7u+GrSlY7sP5lzEXbyHbGrMRP+0MMnVa53zC7Q
	 rnXznkXLMD6zjVUgxZnpWGcIBzQ22AC11TaVjzkPMHYfO6l2aiYRo6cIjP8ELU8dri
	 qkx+HeELGIXJ2jml6EhU1Cv6lL2oKzfoIHW/PPocBzEjRV8o7vVJHSXWwuowGpOd5m
	 o5ww86Xo2O3dCPqlTJgoLFxPWkUtJLrfflu5Nkp7tna9L5gYtxXJ17Z7CUfzjyyFJW
	 p/d0KWdSt7WIK1cHSMuF0sBwQIVQ4xqLoId147prIFK9M98uMIaNSVIxFmodu2IE/d
	 m3xSo4zr4jJCg==
Date: Sun, 13 Sep 2026 17:29:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf annotate-data: Convert type histogram to hashmap
Message-ID: <aqc_0_t27ASNDJVg@google.com>
References: <20260912054706.1475583-1-namhyung@kernel.org>
 <20260912054706.1475583-2-namhyung@kernel.org>
 <20260912055646.034D81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260912055646.034D81F000FF@smtp.kernel.org>

On Sat, Sep 12, 2026 at 05:56:45AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing index increment when hashmap lookup fails in `get_member_overhead` causes histogram columns to be scrambled across events.
> --
> 
> commit 4840a8fb0b1911e5130194633a0b05e4bf3e21fe
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf annotate-data: Convert type histogram to hashmap
>     
> This commit converts the type histogram from an array to a hashmap to
> reduce memory overhead. It replaces direct array accesses with hashmap
> lookups across the annotation components.
> 
> > diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
> > index aa8c89fe2e82c..82667c6ae2e74 100644
> > --- a/tools/perf/ui/browsers/annotate-data.c
> > +++ b/tools/perf/ui/browsers/annotate-data.c
> > @@ -62,12 +62,17 @@ static int get_member_overhead(struct annotated_data_type *adt,
> >  
> >  		k = 0;
> >  		for_each_group_evsel(evsel, leader) {
> > +			struct type_hist_entry *hist;
> > +
> >  			if (symbol_conf.skip_empty &&
> >  			    evsel__hists(evsel)->stats.nr_samples == 0)
> >  				continue;
> >  
> > -			h = adt->histograms[evsel->core.idx];
> > -			update_hist_entry(&entry->hists[k++], &h->addr[offset]);
> > +			h = &adt->histograms[evsel->core.idx];
> > +			if (!hashmap__find(&h->samples, offset, &hist))
> > +				continue;
> > +
> > +			update_hist_entry(&entry->hists[k++], hist);
> 
> [Severity: Medium]
> When hashmap__find() fails (indicating an event has no samples at this byte
> offset), the continue statement skips the k++ increment.
> 
> Will this cause subsequent events in the group to write their stats into the
> skipped event's entry->hists[k] bucket?
> 
> If k is not advanced for the skipped event, it appears the histogram columns
> for multi-event annotation data could shift and display in the wrong event
> columns in the UI.
> 
> Could we ensure k is incremented even when the hashmap lookup fails to
> preserve the correct column alignment?

Right, will fix in v2.

Thanks,
Namhyung

