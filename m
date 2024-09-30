Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B51A2577;
	Mon, 30 Sep 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728659; cv=none; b=m0LdkutliwVGrW18Qnmj52uSGZ6diAazVheEMLojVvjOfjgrOdFbw/3Cds87PTADRKYcx3kDtSNx/NcZqMRY1A+5vfNevlMrShHDjS7V35DM8tnZGA78yu4LTq59EABHZZkGCpKEp6cAG03VO3LqMHxr/bbxWh3CrLTpGhPzE5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728659; c=relaxed/simple;
	bh=RWiC0OjVVQXZ4crBKb728tY3O18WhGqT6RVvtCqER4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5T2oHG/HZRR5JWVn8noiim+m8sExQyIvsaC9kTU1CtZGMwSJpEpK91pu0IBy2IoqFVIQtF3G7W80cXfJCi5aHIfmR6PIRNU/obabRE7QkSAG+jpoQQNOLXmMwN9LeVTJneYmKVXg0ZIqZF0N2iM8p7i8LBfM7GgVTUYIUurgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNV9Sq5+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNV9Sq5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638B6C4CEC7;
	Mon, 30 Sep 2024 20:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727728659;
	bh=RWiC0OjVVQXZ4crBKb728tY3O18WhGqT6RVvtCqER4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNV9Sq5+bBw+BkqbAp5JTb8DJKoca1uB4zqjKqiuag7/HWScTUts7ZY29/+WS7vea
	 QcZW4AC9LKuM0CuVoMzD47g1ybgZGcLZJMJ5NK+485OB4kmyIx4yg05ZsvhYExz2YB
	 L0pb85nJZMgrITJJEIPCim4dyk9a7ZOhNHvLTAoLdt+i9pUbOogu/8TF0uY9R+0Y52
	 tLG2t6rkd64kcpm863LFGELbXmr2bWe9bcpW9AhKm50Nj+BELNhF305sSHz7rUA2W5
	 Vh7JimvMxIvxubh8haAZ5VtD3ARe2dYI09D7sLqXhoPL4L7F6fWx+7x6DmhvJ6atQl
	 vQxqAlWqkWvPA==
Date: Mon, 30 Sep 2024 13:37:37 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 07/10] perf tools: Separate exclude_hv fallback
Message-ID: <ZvsMEaZT9ESTWOxt@google.com>
References: <20240905202426.2690105-1-namhyung@kernel.org>
 <20240905202426.2690105-8-namhyung@kernel.org>
 <8b9d3cbb-99bd-4474-8daf-e9ab36e42a77@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b9d3cbb-99bd-4474-8daf-e9ab36e42a77@linux.intel.com>

On Fri, Sep 06, 2024 at 11:21:21AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-09-05 4:24 p.m., Namhyung Kim wrote:
> > The exclude_hv was added in the evsel__fallback() in the commit
> > 4ec8d984895fef43a ("perf record: Fix priv level with branch sampling
> > for paranoid=2") to address branch stack samples on Intel PMUs.
> > As some other PMUs might not support that, let's separate the bit from
> > exclude_kernel to make sure it can add the bit only if required.
> > 
> > Technically it should change the modifier string at the end of the
> > event name.  ":u" is for exclude_kernel + exclude_hv, so it should be
> > ":uh" if it has exclude_kernel only.  That means the default events for
> > regular users will looks like "cycles:Puh" (for perf record) or
> > "instructions:uh" (for perf stat).  But I'm not sure if it's worth the
> > trouble so I didn't touch the name in this patch.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/evsel.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 1a4f52767942e5ad..c5df45bb74dfc1b5 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -3389,10 +3389,20 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
> >  		free(evsel->name);
> >  		evsel->name = new_name;
> >  		scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
> > -			  "to fall back to excluding kernel and hypervisor "
> > -			  " samples", paranoid);
> > +			  "to fall back to excluding kernel samples", paranoid);
> >  		evsel->core.attr.exclude_kernel = 1;
> > -		evsel->core.attr.exclude_hv     = 1;
> > +
> > +		return true;
> > +	} else if (err == EACCES && !evsel->core.attr.exclude_hv &&
> > +		   (paranoid = perf_event_paranoid()) > 1) {
> > +		/* If event has exclude user then don't exclude hv. */
> > +		if (evsel->core.attr.exclude_user)
> > +			return false;
> > +
> > +		/* Intel branch stack requires exclude_hv */
> 
> I don't think it's an requirement for Intel branch stack. The HV is
> ignored for all X86.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/core.c#n542
> 
> I think it's a generic request for branch on all arch.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/events/core.c#n366

Ok, I'll update the comment.

Thanks,
Namhyung

> 
> > +		scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
> > +			  "to fall back to excluding hypervisor samples", paranoid);
> > +		evsel->core.attr.exclude_hv = 1;
> >  
> >  		return true;
> >  	} else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
