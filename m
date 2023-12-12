Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35017A22D
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz2u2JcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE528C433C7;
	Tue, 12 Dec 2023 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702400309;
	bh=rrQWZ1A81N+xvoxlWniD06E/uf4RebN93UVgpZ9UCHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pz2u2JcWtMwrPBOxKXqS5CSu0XZDIJUcpx3rew6Rr5hah/eToJesFI+2XOrGEDrph
	 Hftk7ZjYlwGRt9zGLEuqNKf21wO467cTLOLd790xfH0pmuTvecSD55jIjyiEj49naE
	 a+1hOcPS36IFSosaWqE+aEKOG+ZzuswY4aHCyQh1O93jUn0ZgSemYf6uXQpNCR75ky
	 U1cE6O1Ed6Q0PPLZZd+KHL7g1D9CdShda9XpscBudBV1zUdJ9JrBNEmZ084BczjbtS
	 GK43eSBRssOGNo474ZWtDxByhyO7ZQJTc1GcWofm/Ypn0khu15KYsWv0O6dyIcXqlE
	 PJGPdUKvmpScg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id CAD74403EF; Tue, 12 Dec 2023 13:58:24 -0300 (-03)
Date: Tue, 12 Dec 2023 13:58:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: irogers@google.com, namhyung@kernel.org, mark.rutland@arm.com,
	maz@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
Message-ID: <ZXiRMDJpz3l27u7g@kernel.org>
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org>
 <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
X-Url: http://acmel.wordpress.com

Em Tue, Dec 12, 2023 at 10:56:15AM -0500, Liang, Kan escreveu:
> 
> 
> On 2023-12-11 4:13 p.m., Arnaldo Carvalho de Melo wrote:
> > Em Fri, Dec 08, 2023 at 01:08:55PM -0800, kan.liang@linux.intel.com escreveu:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> perf top errors out on a hybrid machine
> >>  $perf top
> >>
> >>  Error:
> >>  The cycles:P event is not supported.
> >>
> >> The user_requested_cpus may contain CPUs that are invalid for a hybrid
> >> PMU. It causes perf_event_open to fail.

> > ?

> > All perf top expects is that the "cycles", the most basic one, be
> > collected, on all CPUs in the system.
 
> Yes, but for hybrid there is no single "cycles" event which can cover
> all CPUs. Perf has to split it into two cycles events, cpu_core/cycles/
> and cpu_atom/cycles/. Each event has its own CPU mask. If a event is
> opened on the unsupported CPU. The open fails. That's the reason perf
> top fails. So perf should only open the cycles event on the
> corresponding CPU.

Great explanation, please make sure it is present in the fix, i.e. in
the v2 you mentioned.
 
> >> The commit ef91871c960e ("perf evlist: Propagate user CPU maps
> >> intersecting core PMU maps") already intersect the requested CPU map
> >> with the CPU map of the PMU. Use the evsel's cpus to replace
> >> user_requested_cpus.
> >  
> >> The evlist's threads is also propagated to evsel's threads in
> >> __perf_evlist__propagate_maps(). Replace it as well.
> > 
> > Thanks, but please try to add more detail to the fix so as to help
> > others to consider looking at the patch.
> 
> OK. For the threads, the same as other tools, e.g., perf record, perf
> appends a dummy for the system wide event. For a per-thread event, the
> evlist's thread_map is assigned to the evsel. So using the evsel's
> threads is appropriate and also be consistent with other tools.
> 
> I will update the description and send a V2.
> 
> Thanks,
> Kan
> 
> > 
> > - Arnaldo
> >  
> >> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.org/
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>  tools/perf/builtin-top.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> >> index ea8c7eca5eee..cce9350177e2 100644
> >> --- a/tools/perf/builtin-top.c
> >> +++ b/tools/perf/builtin-top.c
> >> @@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct perf_top *top)
> >>  
> >>  	evlist__for_each_entry(evlist, counter) {
> >>  try_again:
> >> -		if (evsel__open(counter, top->evlist->core.user_requested_cpus,
> >> -				     top->evlist->core.threads) < 0) {
> >> +		if (evsel__open(counter, counter->core.cpus,
> >> +				counter->core.threads) < 0) {
> >>  
> >>  			/*
> >>  			 * Specially handle overwrite fall back.
