Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23CE1494C1
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721777396; cv=none; b=q+b59wqAcz141m4voyngcqs1EoRSacJQKjNvSNgEE4SN7jTkHtHl1EcEfcSyDCweVkcb9SEOmgw9WI9wsFr0+tqfRnIX9tmdxyQw0f7nOOmJPKoPidCIuSaQMZjNkHcD96tKK+n2ytcDvOSOqxeD9brod1RxbKWJ2gemHuWqpyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721777396; c=relaxed/simple;
	bh=b0x5mj9KP1x+QJx+Frnnr7/pOxpSCu28Z/yHzVUr+dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIkkunZDGtay2w41YRi8jeLtxzNoNGwOaA/URV54a9V/FmraGgbowAPKdcLZuKIFkkC6Pgs1ulwFt05I9/8kReYX6byCJ8G3n9gwr1bfpyeOVkMZRIVSjrJ7n3n5HGnEReVG1lzwXQw2yYTfHfewAdWt2ooEqyNAyEDKbA32NKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dx6AiVAG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dx6AiVAG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721777395; x=1753313395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=b0x5mj9KP1x+QJx+Frnnr7/pOxpSCu28Z/yHzVUr+dE=;
  b=Dx6AiVAGn0UYybRWnRhTmcvERm/8J1FLOZAmfag7s5C9t3R7BxLUzFDv
   9grbS0XLngPlQseiz0Tbn6/4G+YBI25ocgmZ273/FMuOflLAvYwpW1dsc
   kKILlouakIfBoip8xkTZaBl2h+025Rn7899crqSLIfOjek4G9fN/yApWn
   Irgpi5i+uglzozSw/+RFl7HD5I1KCltFJqXQGSI1wOtrb4difEah8+HRX
   ztBx21+UKZb7rxzzB9MkflR+GkglktYtwoTMaTZXWSdw0LCFIrwy1K0/F
   ZcEHsMuDYsIs6FAxlcet1265KdbQlOXetQE1mHNu37Nc1EUENtUx6q7Ui
   g==;
X-CSE-ConnectionGUID: cVDAIkN0RiiOueCv/IK6qQ==
X-CSE-MsgGUID: DuVJK9z7QYK+g1yEIrrZKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19576468"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="19576468"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 16:29:54 -0700
X-CSE-ConnectionGUID: D/qcAyHaTXmYuncp35JDsA==
X-CSE-MsgGUID: yq++oxMERZmwiMj+pydyPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="57218145"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 16:29:54 -0700
Date: Tue, 23 Jul 2024 16:29:52 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6 3/4] perf script: Fix perf script -F +metric
Message-ID: <ZqA88FMUcDFwrobi@tassilo>
References: <20240723204834.3617647-1-ak@linux.intel.com>
 <20240723204834.3617647-3-ak@linux.intel.com>
 <CAP-5=fU8=gTatcHkvN8jv72_dJvaAb3FE+pnWB2LSN=SM0dRxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU8=gTatcHkvN8jv72_dJvaAb3FE+pnWB2LSN=SM0dRxw@mail.gmail.com>

On Tue, Jul 23, 2024 at 02:32:33PM -0700, Ian Rogers wrote:
> On Tue, Jul 23, 2024 at 1:48 PM Andi Kleen <ak@linux.intel.com> wrote:
> >
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
> 
> I don't follow this. Samples have CPUs but you're associating all
> values with CPU0. Why not just use counts and aggregation properly?

Why use something that is not needed?

It's not needed because the CPUs are not interleaved because the code
is just processing a single group which only has counts from 
a single CPU. And there is no need to output an extra index for the
count because the sample already has all the context.

If it was extended to multiple groups it would be needed, but it's not 
clear how useful it is. The benefit of the feature is that you 
can get the metric at a very fine grained level -- only for the time interval
since the last sample.

Doing it for multiple groups means you would do some level of
aggregation over longer time periods.. You could handle more complex metrics,
but would lose this very fine grain benefit. If you want that it's probably
better use perf report's time slicing feature instead of perf script.
That one currently doesn't support metrics though, but probably it
should.

> > @@ -2325,6 +2330,20 @@ static void process_event(struct perf_script *script,
> >                 fflush(fp);
> >  }
> >
> > +static void check_metric_conflict(void)
> > +{
> > +       int i;
> > +       /*
> > +        * Avoid conflict with the aggregation mode used for the metric printing.
> > +        */
> > +       for (i = 0; i < OUTPUT_TYPE_MAX; i++) {
> > +               if (output[i].fields & PERF_OUTPUT_METRIC) {
> > +                       fprintf(stderr, "perf stat record files are not supported with -F metric\n");
> > +                       exit(1);
> > +               }
> > +       }
> > +}
> > +
> 
> No idea what this is doing. What's conflicting with what?

The conflict is between the -F +metric setup and processing STAT*
records in the perf.data (as generated by perf stat record) 
The later uses AGGR_NONE which is a conflict.

> >
> > @@ -3785,6 +3810,8 @@ int process_cpu_map_event(struct perf_session *session,
> >         if (dump_trace)
> >                 perf_event__fprintf_cpu_map(event, stdout);
> >
> > +       check_metric_conflict();
> > +
> >         if (script->cpus) {
> >                 pr_warning("Extra cpu map event, ignoring.\n");
> >                 return 0;
> > @@ -4088,6 +4115,10 @@ int cmd_script(int argc, const char **argv)
> >
> >         argc = parse_options_subcommand(argc, argv, options, script_subcommands, script_usage,
> >                              PARSE_OPT_STOP_AT_NON_OPTION);
> > +       for (i = 0; i < OUTPUT_TYPE_MAX; i++) {
> > +               if (output[i].fields & PERF_OUTPUT_METRIC)
> > +                       stat_config.aggr_map = &(struct cpu_aggr_map){ .nr = 1 };
> 
> Assigning the address a temporary rval to a global variable seems
> wrong to the point I'm surprised it compiles. Accessing

AFAIK gcc keeps the local around for the function, but you're right 
it's not good code, especially with the buffer overrun.


> stat_config.aggr_map->map[0] will lead to reading beyond the end of
> the value and presumably read uninitialized memory.  Compiling with
> EXTRA_CFLAGS="-fsanitize=address" should complain about all of this.

Good point, but I doubt the address sanitizer would have caught 
it because it doesn't really track the stack.

-Andi
