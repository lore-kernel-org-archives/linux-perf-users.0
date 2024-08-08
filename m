Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6675FBE40
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148302; cv=none; b=Yge9bpOfLYNb4KAIE4LtTT1kNmrw8puZx6HkRV+wqy7jSBdaMqswYJpXbyqJ1r3B0bgRGqyC0pc2Tctqlyie0nvP4j/IwZMJX/KKFywPX+Z4qL3UQiR77N6bl6FMb67n+yTdWF7MEZhS7qgLLbKG8c48gwbyhC/BF+V89pF8XT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148302; c=relaxed/simple;
	bh=LHy49onU8KSZ6Y0DSMDdQ9sAucLC2/zJmNyOkFbkdRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alIs5I00L9os0l625cUa2ZEvkHlem0981Polsn8h2Po6q9NyoDfGL4A04OiJEBb3nPzinAtADNxBN3tv5bOlxgcB7Lpzzr9t+kL8lsC8mYXdeV4k0Ssr2bu7iwqdxntokyImw/J76aJdt7h0eE/KoQpaGsMXN7YCl9umxq1Vadw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7voRDu4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7voRDu4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148300; x=1754684300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LHy49onU8KSZ6Y0DSMDdQ9sAucLC2/zJmNyOkFbkdRo=;
  b=X7voRDu4tRbn3u860TwrLtG3hLLI7eqp4Pcf65JlrhYAvu2zyNYejFBj
   DdvSNMUV0+u2UWwQL43Ioonw4Q+5/kUzV0y2IhQtcSQYAqtn97yXEXUGH
   44U+O/ObT5ivSNohh+qLmxNdyPUE2HgiinrdtOyBfQdPeH0cc5Xq+scKW
   wVdJItVRohV1CNByOuQFj+1mPaGfqVvpfxrL4/FXl7lpbh1rM2nuL1QIi
   lNrtkVm8zUx+S3Pv7Z/L+v3Gj/CCqxkvaik2MMiU99QlFTcB73SB6lF7J
   deKWDxnY7D550RGSQyGY+xNUuUPQT54/Sf3MLyaAm5o52LOGb4I+DtYQK
   A==;
X-CSE-ConnectionGUID: xwkyZ8AcR+OYm1V9bAZVpw==
X-CSE-MsgGUID: 6mnubX43TzysIsLiv078aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24209401"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="24209401"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:18:19 -0700
X-CSE-ConnectionGUID: ff/9LKvQQnewSfG44yACwA==
X-CSE-MsgGUID: zR0uzkG2QJKyJDFJoWAlAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57891459"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:18:19 -0700
Date: Thu, 8 Aug 2024 13:18:17 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 3/4] perf script: Fix perf script -F +metric
Message-ID: <ZrUoCRu4HGoROUs2@tassilo>
References: <20240807231823.898979-1-ak@linux.intel.com>
 <20240807231823.898979-3-ak@linux.intel.com>
 <CAM9d7ci40WcV=EtsNuNXkRAWc3XHDKzb9OACNUhD5WaqTu5vxg@mail.gmail.com>
 <CAP-5=fVZ0_orgpLcG492WtjW05QWu2Mbnuv=_NKweouVXq2icA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVZ0_orgpLcG492WtjW05QWu2Mbnuv=_NKweouVXq2icA@mail.gmail.com>

> 
> Fwiw, not acked-by me. Repeating my comments below:

Let me just point out that you broke it in the first place.

A little more enthusiasm in handling regressions would be appreciated.

> > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > > index c16224b1fef3..cb63507af839 100644
> > > --- a/tools/perf/builtin-script.c
> > > +++ b/tools/perf/builtin-script.c
> > > @@ -335,7 +335,6 @@ struct evsel_script {
> > >         FILE *fp;
> > >         u64  samples;
> > >         /* For metric output */
> > > -       u64  val;
> > >         int  gnum;
> 
> We're globally assuming properties of events assuming leader sampling.
> gnum shouldn't exist. The assumptions will be invalid when leader
> sampling isn't enabled.

This is checked for now, see the earlier discussion.

> > > +       if (!(leader->core.attr.read_format & PERF_FORMAT_GROUP) ||
> > > +           !(leader->core.attr.sample_type & PERF_SAMPLE_READ)) {
> > > +               if (!printed)
> > > +                       fprintf(stderr, "perf script: -F metric requires {}:S for groups leader sampling\n");
> > > +               printed = 1;
> > > +               return;
> > > +       }
> > > +       /*
> > > +        * Always use the first entry as storage because the leader sampling
> > > +        * groups are contiguous and there's no need to handle multiple indexes
> > > +        * for anything.
> > > +        */
> > > +       evsel->stats->aggr[0].counts.val = val;
> 
> Updating counts needs perf_stat_process_counter to update the
> aggregation. How does sample->cpu given below relate to aggr[0] here?
> This and the comment above are a hack liable to break in anything but
> straightforward circumstances. See:
> https://lore.kernel.org/lkml/20240720074552.1915993-2-irogers@google.com/
> on how to handle this.

Your patch is based on a fundamental misunderstanding on the perf script
metrics use model, see below.

> 
> > >         if (evsel_script(leader)->gnum == leader->core.nr_members) {
> > >                 for_each_group_member (ev2, leader) {
> > >                         perf_stat__print_shadow_stats(&stat_config, ev2,
> > > -                                                     evsel_script(ev2)->val,
> > > -                                                     sample->cpu,
> > > +                                                     evsel->stats->aggr[0].counts.val,
> > > +                                                     0,
> 
> Similarly this hard coded and unexplained constant.

There's a comment just on top of it explaining it:

        /*
         * Always use the first entry as storage because the leader sampling
         * groups are contiguous and there's no need to handle multiple indexes
         * for anything.
         */


> 
> > >                                                       &ctx,
> > >                                                       NULL);
> > >                 }
> > > @@ -2325,6 +2337,20 @@ static void process_event(struct perf_script *script,
> > >                 fflush(fp);
> > >  }
> > >
> > > +static void check_metric_conflict(void)
> > > +{
> > > +       int i;
> > > +       /*
> > > +        * Avoid conflict with the aggregation mode used for the metric printing.
> > > +        */
> 
> Why is it a conflict, why not support aggregation modes?

I thought I had explained that before.

perf script has two touch point with perf stat output code: one is this one
(for metrics on sampling group) and the other is for perf stat record / script

None of them actually support aggregation because perf script as a
general rule doesn't aggregate, it only handles single events.

But the later one forces AGGR_NONE which doesn't work with the mode the group
output uses.

This feature is only to report the metric state for a single sampling period
and group as explained in the original commit [1]

If you want to aggregate multiple sample periods you need a lot the
machinery from perf report, which doesn't make sense to duplicate
in perf script.

[1] https://www.uwsg.indiana.edu/hypermail/linux/kernel/1712.0/04705.html

-Andi
