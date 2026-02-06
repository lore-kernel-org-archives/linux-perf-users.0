Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EA12C2374;
	Fri,  6 Feb 2026 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770415820; cv=none; b=lEmlrxN1j0fLm4w8T9DBj4rj5GwM3cWACofqhY68tk/FdTYrSfZJl80h5TzhT1V5wpoaBNskgO4MSB+gEJCR1NUKPtpOc1HwSvKwGrGJ+tMj//A2Anskeuw4k/rVqqlkgZSzVz6lsNIwnY6y/8NA7MtSGitg/R8z8W5DGmwsJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770415820; c=relaxed/simple;
	bh=59RiEZducaab4Ut0oK2YX9CJM7vHpLHjETpHtt4QdEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdXBHpeSyuD44kRRCbLiMRUdVqUXdgnKnhHfn6K0P+PmsutbDXFcN+m3OxatAFr1F8sWjtMyEjnYddXgtDJoLY3yuZBshN6wzZLHyyw1Mfgrrv+QDBboDqRrwVj6Fqe0z5C05y/Wk7nr18UdSPsTb/62Ps8ynzUNR3z5an6YFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uci+cVn9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uci+cVn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9195C116C6;
	Fri,  6 Feb 2026 22:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770415820;
	bh=59RiEZducaab4Ut0oK2YX9CJM7vHpLHjETpHtt4QdEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uci+cVn9MF5Klpmoz8hOE3S/b0cBNEKz1d5OAp+mCYgAKthZ3AsTpRv/AdBqBkIsQ
	 ecwIslLN0yOHMBjajH4GKARhtRBVCwF+jf+/JTRQFL6MWUCarfo2RZzXSCFrh4BaFG
	 tbZRMHodPs6wuJJmj+9PK1FMl+mSK9noj4TFs5KdAXwHZwm+0dp40Cao1/HZf77A3P
	 65mp0mCdIsBaxOaWYHUHTjN7gGvN3c+ECUnJ255ZkM0DIkNghwXJ8K01iTGoRtHDpT
	 MtsreQ4iq+/IZwHuemkAl2U98Qw9u1YlnFuaQtxAGrGjQ/dEbR++GhiEVMJ9bvSp9V
	 0r6p5uy4WWuzw==
Date: Fri, 6 Feb 2026 19:10:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Zide Chen <zide.chen@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	thomas.falcon@intel.com, dapeng1.mi@linux.intel.com,
	xudong.hao@intel.com
Subject: Re: [PATCH] perf tools: Refactor precise_ip fallback logic
Message-ID: <aYZmyNz1tJ9u-y5s@x1>
References: <20251022220802.1335131-1-zide.chen@intel.com>
 <CAP-5=fUKH8Qw9t173G4HP-UzujUKJrLPPmkDSjBs=2YzV=9LHA@mail.gmail.com>
 <aYZl2evOTebsTIxZ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYZl2evOTebsTIxZ@x1>

On Fri, Feb 06, 2026 at 07:06:21PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Oct 23, 2025 at 09:14:17AM -0700, Ian Rogers wrote:
> > On Wed, Oct 22, 2025 at 3:14 PM Zide Chen <zide.chen@intel.com> wrote:
> > >
> > > Commit c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
> > > unconditionally called the precise_ip fallback and moved it after the
> > > missing-feature checks so that it could handle EINVAL as well.
> > >
> > > However, this introduced an issue: after disabling missing features,
> > > the event could fail to open, which makes the subsequent precise_ip
> > > fallback useless since it will always fail.
> > >
> > > For example, run the following command on Intel SPR:
> > >
> > > $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
> > >
> > > Opening the event "cpu/mem-loads,ldlat=3/PS" returns EINVAL when
> > > precise_ip == 3. It then sets attr.inherit = false, which triggers a
> > > kernel check failure since it doesn't match the group leader's inherit
> > > attribute. As a result, it continues to fail even after precise_ip is
> > > reduced.
> > >
> > > By moving the precise_ip fallback earlier, this issue is resolved, as
> > > well as the kernel test robot report mentioned in commit
> > > c33aea446bf555ab.
> > >
> > > No negative side effects are expected, because the precise_ip level is
> > > restored by evsel__precise_ip_fallback() if the fallback does not help.
> > >
> > > This also aligns with commit 2b70702917337a8d ("perf tools: Remove
> > > evsel__handle_error_quirks()").
> > >
> > > Fixes: af954f76eea56453 ("perf tools: Check fallback error and order")
> > > Fixes: c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
> > > Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > > Signed-off-by: Zide Chen <zide.chen@intel.com>
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> 
> Fell thru the cracks... Still applies cleanly.
> 
> Thanks, applied to perf-tools-next,

So I saw the rest of the thread, removing it...

- Arnaldo
 
> - Arnaldo
>  
> > Any chance you could help with a test case that covers this? The
> > fallback logic is spread out and easy to introduce subtle bugs into.
> > Just having a test case that does ` perf record -e
> > '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls` and checks the
> > output for EINVAL when the events are present would be useful, as then
> > we can make sure this doesn't regress on SPR and later. Something with
> > more generic events would of course be better :-)
> > 
> > Thanks,
> > Ian
> > 
> > > ---
> > >  tools/perf/util/evsel.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index ca74514c8707..6ce32533a213 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -2714,12 +2714,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> > >         if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
> > >                 goto retry_open;
> > >
> > > +       if (evsel__precise_ip_fallback(evsel))
> > > +               goto retry_open;
> > > +
> > >         if (err == -EINVAL && evsel__detect_missing_features(evsel, cpu))
> > >                 goto fallback_missing_features;
> > >
> > > -       if (evsel__precise_ip_fallback(evsel))
> > > -               goto retry_open;
> > > -
> > >  out_close:
> > >         if (err)
> > >                 threads->err_thread = thread;
> > > --
> > > 2.51.0
> > >
