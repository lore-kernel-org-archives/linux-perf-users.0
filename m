Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6261C9DC2;
	Thu,  3 Oct 2024 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993636; cv=none; b=KS52T6CMISI5Q/RsX+uM1MZQy8MsDIfY4+j+hthYoY8kWzBkIcC+t9xw4e3k0JMgeBFO45ihNlEqYucX4yjk9M9nmk0vnAZN4dpONeNG42HebJNMGRXLCnKY8SFxh/mWFTqm8N/CFnDMs2lT/PGijLJH1hf97f9cy1966S8JfDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993636; c=relaxed/simple;
	bh=xOjSyMsBh5IGBGcZ4RMgGN36DzY919SWbahZJt1TSns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj84ng2zb4Ln21GySgQpwIxOU26p44o6Mw0mg1jmBDVi/s8gojvFN2h3xrGNMc2qnC1yUHcsTA7WTX7Id329Qw6CdWkSyuIF+dFgAFN+bF5Zi6rq9t6uV9Tanl+vWYR6hhITvxlwF/Ov8xhZPJ/7pXGFVbd9cGrNJ1VGSCjCjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtYS0Jdr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtYS0Jdr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FE4C4CEC5;
	Thu,  3 Oct 2024 22:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727993636;
	bh=xOjSyMsBh5IGBGcZ4RMgGN36DzY919SWbahZJt1TSns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtYS0Jdrlmc1x9aK84ZK6EH4sMeXUYh0WfMcSwcu0jIWqpEhhCTG5v/luq3XzIU/q
	 miQTWE8ZPIXmrsEwADqdYWEB9L4SP4lZD5o28ne+UMQmhC1dLmyMR84LVsMfiT2UHZ
	 7wYhwZp/uwYyxVjuvA2VpnFecTq04T/c77r47B+yHpK204qyaQHF/vEIkitsgLsdwK
	 DOqe7nCFY0CeTRtOyDJEBKSMDEVM29Chy82pqQJ7p+OMDGCWls5BApnX4TJaJXrhCq
	 JWSKghU2bjHz1twtkCTav523E33tOzGy6DxJR9VZxIbWypt6LCDaoJd8C3/qrQS8ZX
	 n+wb0FEiRoD5Q==
Date: Thu, 3 Oct 2024 15:13:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
Message-ID: <Zv8XIZAwfoTtzOl4@google.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
 <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
 <Zv3ek7aBkQo0Z9To@google.com>
 <CAP-5=fUjLhGw4SmMTH_H2=1OwRDrY04RL6+C=DdQ=VSgXk8JZg@mail.gmail.com>
 <b0695ef6-8a59-4550-8a33-9afb25c93f48@linux.intel.com>
 <CAP-5=fXutWptEKZKNvLXvXXpuDoMje6PiOxMuF872xoMjtumGQ@mail.gmail.com>
 <Zv7KHGQx0y3rAGWx@google.com>
 <690ddcd6-276a-4b7b-bd21-fb4ef2349990@linux.intel.com>
 <CAP-5=fU7_RqcG+YO4C=FP_cy__eSd=ieJ_pOe4J-s2zh=sybsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU7_RqcG+YO4C=FP_cy__eSd=ieJ_pOe4J-s2zh=sybsw@mail.gmail.com>

On Thu, Oct 03, 2024 at 02:26:29PM -0700, Ian Rogers wrote:
> On Thu, Oct 3, 2024 at 12:45 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >
> >
> >
> > On 2024-10-03 12:45 p.m., Namhyung Kim wrote:
> > >>> If the algorithms cannot be changed, can you please give some
> > >>> suggestions, especially for the sample read failure?
> > >> So this is symmetric:
> > >> ```
> > >> if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
> > >>   return -1;
> > >> if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
> > >>   return 1;
> > >> ```
> > >> That is were lhs and rhs swapped then you'd get the expected comparison order.
> > >> ```
> > >> if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs) &&
> > >> lhs->core.leader != rhs->core.leader)
> > >>   return -1;
> > >> if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
> > >> lhs->core.leader != rhs->core.leader)
> > >>   return 1;
> > >> ```
> > >> Is symmetric as well.
> > >> ```
> > >> if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
> > >>   return -1;
> > >> if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
> > >> lhs->core.leader != rhs->core.leader)
> > >>   return 1;
> > >> ```
> > >> (what this patch does) is not symmetric as the group leader impacts
> > >> the greater-than case but not the less-than case.
> > >>
> > >> It is not uncommon to see in a sort function:
> > >> ```
> > >> if (cmp(a, b) <= 0) {
> > >>   assert(cmp(b,a) >= 0 && "check for unstable/broken compare functions");
> > >> ```
> > > I see.  So are you proposing this?
> > >
> > > diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> > > index 438e4639fa892304..46884fa17fe658a6 100644
> > > --- a/tools/perf/arch/x86/util/evlist.c
> > > +++ b/tools/perf/arch/x86/util/evlist.c
> > > @@ -70,7 +70,8 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
> > >                 if (arch_is_topdown_slots(rhs))
> > >                         return 1;
> > >                 /* Followed by topdown events. */
> > > -               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
> > > +               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs) &&
> > > +                   lhs->core.leader != rhs->core.leader)
> > >                         return -1;
> > >                 /*
> > >                  * Move topdown events forward only when topdown events
> > >
> > > Dapeng and Kan, can you verify if it's ok?  My quick tests look ok.
> >
> > I verified the above change. It works well.
> >
> > Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks for the check!

> 
> Dapeng's comment should cover replace the comment /* Followed by
> topdown events. */ but there are other things amiss. I'm thinking of
> something like: "slots,cycles,{instructions,topdown-be-bound}" the
> topdown-be-bound should get sorted and grouped with slots, but cycles
> and instructions have no reason to be reordered, so do we end up with
> slots, instructions and topdown-be-bound being grouped with cycles
> sitting ungrouped in the middle of the evlist? I believe there are
> assumptions that grouped evsels are adjacent in the evlist, not least
> in:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n2106
> Does cycles instructions end up being broken out of a group in this
> case? Which feels like the case the code was trying to avoid.

I got this:

  $ sudo ./perf record -a -e "slots,cycles,{instructions,topdown-be-bound}" true
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-be-bound).
  "dmesg | grep -i perf" may provide additional information.

Thanks,
Namhyung

