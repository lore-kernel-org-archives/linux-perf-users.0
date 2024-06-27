Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F25131E41
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719528618; cv=none; b=hUBsK0QZWXDHdXneK6NkFAM+sbVzmTkpVTGL6za81cwoK/RY04o8WvnJYOwrUcAN+zyofC/cIe8ev17f6j6ah+CshW+1iY5TU6BqLicHid9Rbt5eeuc4Q2WPGaslNPtj1wyJXoF5hErOEUoSHWcwoYVP2BJIh4KlfxLjLxp6LY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719528618; c=relaxed/simple;
	bh=Ei7xA5VSnehktapd4fdf5EU1IEO0BgQiAe9aS5IoatA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCAMHQhc2QqvaXMoNRyYkCXQT1lbeBCwSDmTSdqSQQjAhLNeNMo7JLkt+kyf7BFHK+6n8xzXE4RFaH7lj6ffaIAwYTSjJVdTtrFtwJUzPBBYyeRA17DLhOBSTYaZuRc8x6Ypz82ccpK8DQnY4yIT5gsQmDDXUDYZINv8JoRgbhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBOOX8Bo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBOOX8Bo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DF3C2BBFC;
	Thu, 27 Jun 2024 22:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719528618;
	bh=Ei7xA5VSnehktapd4fdf5EU1IEO0BgQiAe9aS5IoatA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tBOOX8Bou6qC0NNE0fMQIZqut2bq9wG5A7AqRiwL/J95bLwesAeOWZXr48JIqSOnu
	 XPh2TYCFvNAWQFmyb2qcdlC8goPNDpyUw1EL0EnnD27UKi7RGVzazTKRqncJVVK04B
	 A5MOGKPuwwqHYY4gratQOZD5FVGmv+erYRW90ex5dO7MYekh4iwmdrdWDrAiBQoz1K
	 49/SEG2k0+97JIwh+LeKQvxppF9v/hcscZG8NNEXAJCVn3w58qERWJhwXnQ5bEQeps
	 /e7iLpHQJWOIDNGmheopEPCezump8plVLuWv5654WBTPIP9Nad2YqQvUS3CcGCVm3s
	 nJ7YeFTQOaiLA==
Date: Thu, 27 Jun 2024 15:50:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Artem Savkov <asavkov@redhat.com>, Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf script: Fix perf script -F +metric
Message-ID: <Zn3sqMNljXWqPoYc@google.com>
References: <20240625004232.1852705-1-ak@linux.intel.com>
 <20240626090924.GA56952@alecto.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626090924.GA56952@alecto.usersys.redhat.com>

On Wed, Jun 26, 2024 at 11:09:24AM +0200, Artem Savkov wrote:
> On Mon, Jun 24, 2024 at 05:42:31PM -0700, Andi Kleen wrote:
> > This fixes a regression with perf script -F +metric originally caused by :
> >
> > commit 37cc8ad77cf81f3ffd226856c367b0e15333a738
> > Author: Ian Rogers <irogers@google.com>
> > Date:   Sun Feb 19 01:28:46 2023 -0800
> >
> >     perf metric: Directly use counts rather than saved_value
> >
> > In the perf script environment the evsel wouldn't allocate an aggr
> > values array, which led to a -1 reference because the metric
> > evaluation would try to reference NULL - 1 (for aggr_idx)
> >
> > Give the perf script evsels a single CPU aggr setup. That's
> > enough because the groups are always contiguous, so no need
> > to store more than one CPU's worth of values.
> >
> > Before
> >
> > % perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
> > % perf script -F +metric
> > Segmentation fault (core dumped)
> >
> > After:
> >
> > % perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
> > ...
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.028 MB perf.data (90 samples) ]
> > % perf script -F +metric
> >        perf-exec 1847557 264658.180789:       3009       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
> >        perf-exec 1847557 264658.180789:        382 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
> >        perf-exec 1847557 264658.180789:         metric:    0.13  insn per cycle
> > ...
> >
> > Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather ...")
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> This works, however there seems to be yet another issue on
> perf-tools-next branch that breaks script metrics.
> 
> 617824a7f0f73 (perf parse-events: Prefer sysfs/JSON hardware
> events over legacy, 2024-04-15) changes event priority so on
> my host "instructions" have type PERF_TYPE_RAW instead of
> PERF_TYPE_HARDWARE.
> 
> # event : name = instructions, , id = { 190969, 190970, 190971, 190972, 190973, 190974, 190975, 190976 }, type = 4 (cpu), size = 136, config = 0xc0 (instructions), sample_type = IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER, read_format = ID|GROUP|LOST, sample_id_all = 1, exclude_guest = 1
> 
> This results in evsel__stat_type no longer recognizing these as
> STAT_INSTRUCTIONS.

Hmm.. sounds like a problem.  Ian, did you notice this?

Thanks,
Namhyung

> 
> > ---
> >  tools/perf/builtin-script.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index c16224b1fef3..4aab194b4b1a 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -84,7 +84,7 @@ static bool			system_wide;
> >  static bool			print_flags;
> >  static const char		*cpu_list;
> >  static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> > -static struct perf_stat_config	stat_config;
> > +static struct perf_stat_config	stat_config = { .aggr_map = &(struct cpu_aggr_map){ .nr = 1 } };
> >  static int			max_blocks;
> >  static bool			native_arch;
> >  static struct dlfilter		*dlfilter;
> > @@ -2133,12 +2133,14 @@ static void perf_sample__fprint_metric(struct perf_script *script,
> >  	if (evsel_script(leader)->gnum++ == 0)
> >  		perf_stat__reset_shadow_stats();
> >  	val = sample->period * evsel->scale;
> > +	/* Always use CPU 0 storage because the groups are contiguous. */
> > +	evsel->stats->aggr[0].counts.val = val;
> >  	evsel_script(evsel)->val = val;
> >  	if (evsel_script(leader)->gnum == leader->core.nr_members) {
> >  		for_each_group_member (ev2, leader) {
> >  			perf_stat__print_shadow_stats(&stat_config, ev2,
> >  						      evsel_script(ev2)->val,
> > -						      sample->cpu,
> > +						      0,
> >  						      &ctx,
> >  						      NULL);
> >  		}
> > --
> > 2.45.2
> >
> 
> --
>  Artem
> 
