Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E19A17BD6
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454352; cv=none; b=VhZUEBo/V2kDfpbTXOfZ0kkGnz+Gj6UTDZOaUD5Ou6N/RuZSRZ/CfpCGSEhH4qmqRAHoMqBj52NiYBb/9AuwAMQ9OLKzGvw8dTqFVJb3YWXPYdVSR4a/Imo/xFJtxNASNKv7sLgha49ifJybuAqy7sZ+0thUsFak0sJCYorO7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454352; c=relaxed/simple;
	bh=Z16JQ9uNiZlViC9jcWcHKpuEFghd50mWKIqFG3OMff8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6dyM6RnF1ZUHhQcyQLjbASGXcNCNgO6fc/EJ5cXbdWL3yZZSzFv9u6qvMHftiHE2X7TIfa8trwtmNfXGPDCeC7CpV2F6xHm0FWmnoy9c1rPUzopK1x83I7mtB+ipKjuN3Lr5M4hH+0zBESQ3s2FNBK7jcFS6dTGEQhGzWSL2vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RK+KYWOa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RK+KYWOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722454351; x=1753990351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z16JQ9uNiZlViC9jcWcHKpuEFghd50mWKIqFG3OMff8=;
  b=RK+KYWOamOsIJFfNbJxNQqYuUc0/sr2SiQy8422GOeHTYaw31bufKGB+
   8kZ43f4yolsK7a5G3Ywlv/06849uDPnAPdEb7NH8+kYmsUW7h8SViTCbf
   YevfBS+HLsN/jZd3MDSlBw93DSyxWtrXXzoE5R7IRBcGxiSoXln1A82IR
   Bizhxw+AssHnT41TV8AL7tY3rac5RRkN4llnrSRN4aNj0mRZxmeSF0JV6
   vpvGh4cSTwH4tw1zWE6osbWM0zY6CA3cOcY9+TsMB0yq95Ntq+yPmYQF6
   tr6/sVyBQzid268iRojonG2jYgG1ESv5GVScJ58v3T7F0EN9eKtsfi5LG
   g==;
X-CSE-ConnectionGUID: FHw7JmgeS/i3DUmZsMADfg==
X-CSE-MsgGUID: nq0TgiAqRwCU+HEayA/A6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31510613"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31510613"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 12:32:30 -0700
X-CSE-ConnectionGUID: mxm2jiZjSPWe4jOHIvJB8Q==
X-CSE-MsgGUID: hSK8di8oSQqaEBFdVXJLiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54706136"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 12:32:30 -0700
Date: Wed, 31 Jul 2024 12:32:28 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 3/4] perf script: Fix perf script -F +metric
Message-ID: <ZqqRTKW80JJpNpRj@tassilo>
References: <20240724190137.3810429-1-ak@linux.intel.com>
 <20240724190137.3810429-3-ak@linux.intel.com>
 <ZqLuWGKZjdUrkd0L@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqLuWGKZjdUrkd0L@google.com>

> > @@ -2132,13 +2131,17 @@ static void perf_sample__fprint_metric(struct perf_script *script,
> >  		evlist__alloc_stats(&stat_config, script->session->evlist, /*alloc_raw=*/false);
> >  	if (evsel_script(leader)->gnum++ == 0)
> >  		perf_stat__reset_shadow_stats();
> > -	val = sample->period * evsel->scale;
> > -	evsel_script(evsel)->val = val;
> > +	val = sample->period;
> > +	/*
> > +	 * Always use the first storage because the groups are contiguous
> 
> Without leader sampling we cannot guarantee groups events fire
> together, right?

Yes. I'm adding an explicit check for this.

> 
> 
> > +	 * and there's no need to handle multiple indexes for anything
> 
> Actually I think this is a behavior change that you changed the
> aggregation mode from NONE to GLOBAL.

Not with leader sampling because the group is contiguous and output
after its end, with all the previous values forgotten then.
The other cases don't really work anyways as multiple people pointed
out.

> > +	 */
> > +	evsel->stats->aggr[0].counts.val = val;
> >  	if (evsel_script(leader)->gnum == leader->core.nr_members) {
> >  		for_each_group_member (ev2, leader) {
> >  			perf_stat__print_shadow_stats(&stat_config, ev2,
> > -						      evsel_script(ev2)->val,
> > -						      sample->cpu,
> > +						      evsel->stats->aggr[0].counts.val,
> > +						      0,
> 
> Like I said to Ian, we should pass a proper aggr_idx here not just 0 to
> support correct aggregation.  For now I think only possible choice is
> AGGR_NONE (for cpu-wide record) or AGGR_THREAD (for per-task record).
> Then it should be an index to cpu or thread map.

Given the above I think that is not needed.

Full aggregation for metrics over longer period would belong into perf report,
not here.  perf script is only to get non aggregated metrics.

-Andi
