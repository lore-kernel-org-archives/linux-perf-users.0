Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725629;
	b=URdmKwC/lWtdFBILFj1PoJM0tq5gO6fM2eBWYf9/3MKWBr1UMCWXo5oxS1HEsWP1fE1z
	 xIbwQP78KIPYX72Li4gqGAjYtEsak/lbbtWw1lRF4vJlrJ3xl+8Q269Q0/5ouJWVxIHaE
	 uRbIYOxajUXizNSiXvvEVu02L2VbtzwzqyFxWR0QrWWfNUGZkO6zszJdtwVtdsEXrUDv6
	 P/++05Xycjp/nYFPY+GWnp1yVzkOu0mZEai4lvICnbsh8w9IQ6SbTZBYOb86bDz8DXoh1
	 /9QyxqQGIdIB4aQVqIeY0tW93Xz+U6kPg7q71sY/I+aZnb+4ooK5ExyndRwNMNtYJVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725629;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ttj5hGiKjJsfAgbbodOJw/zoBmXktt+aHx1z/2INb94=;
	b=YrzyX5s+FKzRKnnRWeCVj2jqYN63EZurn1UsNHyAbokCH80vsSCsUEi6dIDg3lFcuNMQ
	 BV//Uj3w2b7uLkFzIEUhYco6bqSqzDd8bWTZ0YidVGPCci7f1mFJ+ubBELVCbFDDDte8t
	 nOhbnjqoYqvcjriQO7HTSSDkSaC+jVnulxecac2h6bP1zw0TIioAQffBoaQEjLNYibb/k
	 UuQiHDTSpYth4d1JOMns8ylPgwaJ4DdfwsiFv169Ipj3tM2a5RIuye+6MWUuYQbGK6bve
	 INdvcod6vb99Iil+CKgucbcIeACK+zbij6Lg8yIEn88FfeoXKjfEhVfHkS3mTfKDmBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgMUbLE5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B0A606A324;
	Tue,  3 Nov 2026 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgMUbLE5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D831F000C1;
	Tue,  3 Nov 2026 17:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725629;
	bh=Ttj5hGiKjJsfAgbbodOJw/zoBmXktt+aHx1z/2INb94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fgMUbLE5vbAaTDI/HOr4tMmUFb4Re26b7MNAxPC9axLanzP2MLoUjJ6JL1T1fD4Js
	 qS7kR3xaOnx9i0ebaziG5o4MdyR4W3iAgzEpPnpmBbeN+hmNn5UVIuwYqr1myRYuD5
	 u88r6WzKgvP0l5f1s3+gqSA9qPG8aMN2OowyeyRSg0UcfUl2blTKH5LPo0pi2FPWoG
	 0FKaqNp61MxuImE4MgIHIEWsMDMiN7qKa7Sa2os9YNGWh6QYon0RYku2q5I1Sz2WRs
	 +D7dEr2NQNz/RqDEF/xe/KnAfLUsBw7F/rIr9eeAA8JUsx7LERhkbXicnFQTtpih1x
	 bMyREiz0Yzs1g==
Date: Tue, 3 Nov 2026 09:07:07 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 4/4] libperf evlist: Recompute CPU map when an evsel
 goes system wide
Message-ID: <auoUuw8LSx659T6_@z2>
References: <20261027170415.2815859-1-irogers@google.com>
 <20261027170415.2815859-4-irogers@google.com>
 <sashiko-outbox-186978@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-186978@kernel.org>

On Tue, Oct 27, 2026 at 05:15:19PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] libperf evlist: stale CPUs left in evlist->all_cpus by perf_evlist__go_system_wide()
> --
> 
> commit 03b9925431ed73d3588b37d9c3ef20e7a5b73d9c
> Author: Ian Rogers <irogers@google.com>
> 
> libperf evlist: Recompute CPU map when an evsel goes system wide
> 
> This patch drops the existing evsel->cpus map in
> perf_evlist__go_system_wide() before calling __perf_evlist__propagate_maps()
> so that an evsel added after map creation gets its PMU's CPUs instead of
> retaining the user-requested CPUs.
> 
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 1f210dadd666f..c48425d4933dc 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -834,7 +834,10 @@ void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf_evsel *
> >  {
> >  	if (!evsel->system_wide) {
> >  		evsel->system_wide = true;
> > -		if (evlist->needs_map_propagation)
> > +		if (evlist->needs_map_propagation) {
> > +			perf_cpu_map__put(evsel->cpus);
> > +			evsel->cpus = NULL;
> >  			__perf_evlist__propagate_maps(evlist, evsel);
> > +		}
> 
> [Severity: Medium]
> Does calling __perf_evlist__propagate_maps() on only this evsel leave stale
> CPUs in evlist->all_cpus?
> 
> When an evsel is added via perf_evlist__add() after the evlist's maps were
> created in per-thread or workload mode, __perf_evlist__propagate_maps() sets
> evsel->cpus to the user-requested {-1} map and merges {-1} into
> evlist->all_cpus:
> 
> tools/lib/perf/evlist.c:__perf_evlist__propagate_maps() {
> 	...
> 	perf_cpu_map__merge(&evlist->all_cpus, evsel->cpus);
> }
> 
> When perf_evlist__go_system_wide() subsequently drops evsel->cpus and calls
> __perf_evlist__propagate_maps(evlist, evsel) again, the PMU CPUs are merged
> into evlist->all_cpus, but the old -1 entry is never removed. In contrast,
> perf_evlist__propagate_maps() clears and rebuilds evlist->all_cpus across all
> evsels:
> 
> tools/lib/perf/evlist.c:perf_evlist__propagate_maps() {
> 	evlist->needs_map_propagation = true;
> 
> 	/* Clear the all_cpus set which will be merged into during propagation. */
> 	perf_cpu_map__put(evlist->all_cpus);
> 	evlist->all_cpus = NULL;
> 	...
> }
> 
> If no remaining evsel in the evlist uses CPU -1 (for instance, this evsel is
> the only event, or all other events are system-wide or have requires_cpu set),
> evlist->all_cpus retains the stale -1 entry. When perf_evlist__mmap_ops()
> runs, perf_cpu_map__has_any_cpu_or_is_empty(cpus) then evaluates to true and
> selects mmap_per_thread() instead of mmap_per_cpu():
> 
> tools/lib/perf/evlist.c:perf_evlist__mmap_ops() {
> 	...
> 	if (perf_cpu_map__has_any_cpu_or_is_empty(cpus))
> 		return mmap_per_thread(evlist, ops, mp);
> 
> 	return mmap_per_cpu(evlist, ops, mp);
> }
> 
> In mmap_per_thread(), cpu_idx 0 (for CPU -1 in evlist->all_cpus) matches no
> evsel->cpus, so idx 0 is never mmapped, perf_evlist__set_mmap_first() is
> skipped, and nr_mmaps is miscounted.
> 
> Should perf_evlist__go_system_wide() call perf_evlist__propagate_maps(evlist)
> to rebuild evlist->all_cpus instead of only re-propagating the single evsel?

Hi Ian, what do you think about this?

I've applied the first 3 patches to perf-tools-next already.

Thanks,
Namhyung

