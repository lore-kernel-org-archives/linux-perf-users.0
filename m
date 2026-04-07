Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AD323C4F3;
	Tue,  7 Apr 2026 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539470; cv=none; b=pvCmKcrG6kTriSUEf8waEpb3o5wwGk84x9r3OMmFwC/nnQZE1n4zfqjplwAVAJOzs1/1wY7KO4cYtkCwvO3WgM7ab3cmecHDEF5PGefzfJDHdehKmtFIJF6Ediejf2FfelhJYPf54EhEG7tQxD92vX0NRyRk+AW0X4nFdzLpZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539470; c=relaxed/simple;
	bh=6iTBhFVvRIKuLAwtkyBTlDpsQpz/JhlEaPJi/bZKteo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxeAlxjDJSD+l63dMGmGznpms8BKtnR+0WvmGxemCLK09jU5FNEnun2k/SZIK2y7DRkkNbsoq90XAb/PotW4MkSYLvsbS2FS/E0qV2/+mgV8Rzwn3OCkNhd/vtvu45SGlOTlQGci1FARCKmARC5pBiFJJbIWZ8tTeG7ntF8PAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDXZODfW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDXZODfW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371A8C116C6;
	Tue,  7 Apr 2026 05:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775539469;
	bh=6iTBhFVvRIKuLAwtkyBTlDpsQpz/JhlEaPJi/bZKteo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDXZODfW+jjiUdFWISNlY1ygzj4IP/RFvdeZKLSlYCZzqU3zHznO7Xl+pur24Fv/o
	 qhjtze+gsabs7Gm3nMhORiL2e6oMIUNPFztTIsJNBBRSHCvj0FPPq/hjNg1kjMQhSQ
	 VU+cngXFD+0zYGraK1zcmvhg/MI4gFqtbPP/41wSfUjfyCkd7EgwaYHGBFdm/Yr1vv
	 igef9ito44YgSeA4XCQL3Bs0g9FcDjWnziwW48BBGL592p+eI5zRX2kEjbbMWSKG+f
	 yvWSmpya/shUDgP1ZcPR/5vbNcwWdREliwLHgeHPoVjPjEm6uePhVnyg2Ts46ErKFn
	 q0d5Jhet5KSNw==
Date: Mon, 6 Apr 2026 22:24:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Stat std output match 2 metrics for
 stalled-cycles-backend
Message-ID: <adSVC2UqC6IO3Z3Z@z2>
References: <20260402220406.983248-1-irogers@google.com>
 <adP4dyKNTz3LjFmt@google.com>
 <CAP-5=fU50qG6BB+eG=EkE55Hn+rFPBPeHe9P=0hYdACQ=yviUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU50qG6BB+eG=EkE55Hn+rFPBPeHe9P=0hYdACQ=yviUg@mail.gmail.com>

On Mon, Apr 06, 2026 at 11:25:49AM -0700, Ian Rogers wrote:
> On Mon, Apr 6, 2026 at 11:16 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Apr 02, 2026 at 03:04:06PM -0700, Ian Rogers wrote:
> > > Seen on ARM, the stalled-cycles-backend event can be given as the
> > > event for both backend_cycles_idle and stalled_cycles_per_instruction
> > > metrics. Make the metric match sufficiently generic to allow this.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/tests/shell/stat+std_output.sh | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
> > > index 9c4b92ecf448..5a6bda436dd4 100755
> > > --- a/tools/perf/tests/shell/stat+std_output.sh
> > > +++ b/tools/perf/tests/shell/stat+std_output.sh
> > > @@ -11,9 +11,12 @@ set -e
> > >
> > >  stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
> > >
> > > +# For event_name[i] expect to see event_metric[i]. 'stalled-cycles-backend' may
> > > +# match both 'backend_cycles_idle' and 'stalled_cycles_per_instruction', hence
> > > +# matching "_cycles_".
> > >  event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
> > > -event_metric=("CPUs_utilized" "CPUs_utilized" "cs/sec" "migrations/sec" "faults/sec" "frontend_cycles_idle" "backend_cycles_idle" "GHz" "insn_per_cycle" "/sec" "branch_miss_rate")
> > > -skip_metric=("tma_" "TopdownL1")
> > > +event_metric=("CPUs_utilized" "CPUs_utilized" "cs/sec" "migrations/sec" "faults/sec" "frontend_cycles_idle" "_cycles_" "GHz" "insn_per_cycle" "/sec" "branch_miss_rate")
> >
> > Is this used for partial string match?
> >
> > Then I guess "frontend_cycles_idle" can be covered by "_cycles_" too?
> > Also as we have "/sec", can "cs/sec" and "migrations/sec" be removed?
> 
> When we see the event at index 'i' in the event_name array, we check
> the corresponding metric at index 'i' in the event_metric array. So
> "cs/sec" matches the event "context-switches" while "/sec" matches
> "branches". We could weaken the "context-switches" event to match just
> "/sec" as a metric, but it seems better to leave it as "cs/sec".

I see.  So it's index-based and the metric names are different on x86
and ARM.

> 
> > > +skip_metric=("tma_" "TopdownL1" "percent of slots")
> >
> > Why is "percent of slots" added as well?
> 
> Seen on ARM, the metric names lack an easily catchable prefix like
> tma_. Its part of the fixing this test for ARM, but could be called
> out more in the commit message.

Right, it'd be great if you could explain the problem clearly with an
example.  Feel free to consider me knows nothing..

Thanks,
Namhyung

