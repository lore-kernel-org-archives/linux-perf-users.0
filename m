Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB322F14C;
	Fri, 12 Sep 2025 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712678; cv=none; b=RMLe8I/ixpbFVQ1YUGK6dys4A/HzD8PBdkR+FAHz/2vyOogW3NvwPaf8AjAfVbzornMEzr2RDVReLCzgWlKM/oMro1wSaC7a5RslXoO2GQBYWx2FnA75LZVoUxRY8Tj4+gogoopzQSVwxnE/Jpkawv8d4O8Q9mcWSITAdLYTk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712678; c=relaxed/simple;
	bh=9TERDqn0+X15pemyziSWgElEtDSQeG3yOmJ2tsVV1aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbGut44UbfdAjEDAGa8gCwlLjjWPRV0Rac4FaG8o7bPCB3W89mbhnPGTh6kslrP1pP4cstJDh/gGwhs7EtzJTpc0wbrCFJYR59vcXpjrLWFqMylPqFksclHm2wTJel9NcoSVk6LzUZak4MheImRhz/jpt8iWGLEGGu2G5kEXzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iREMowba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iREMowba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B018EC4CEF1;
	Fri, 12 Sep 2025 21:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757712678;
	bh=9TERDqn0+X15pemyziSWgElEtDSQeG3yOmJ2tsVV1aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iREMowba37peCo9YQa9I8FHr0kMyK5OJaH6mCuzGf+RdMdF6ZKADbNouUnzgZ0ZQv
	 8Op40WBI+63WgZD0sChj/ni4W0lb8nI1ILcnx3TcKmQ+FBLInolnZSF9ZhDDcOYPXC
	 EeczJ3Gh0eCD/6PYXT4CRA5/V0dDP5ImJ3mjGkyhH5Hez3cecM5/RC9jZAYVcYTMmP
	 jACTD+BGn3aUWmT39SL6/km9RlIUU9iXwWRyz7QKk6XoybOZH7EzaYNZzVO30Epz5h
	 k7FugFSLJO55CvssmFMBCbsn43FL9StpZgTUA4d85PG7erA+CU22c2ndzVCWAcVMUW
	 Il8JXINCM4qnw==
Date: Fri, 12 Sep 2025 18:31:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Fix typo - should
 be l1d_cache_access_prefetches
Message-ID: <aMSRIzjysMXxFeVI@x1>
References: <20250909210120.9823-1-ilkka@os.amperecomputing.com>
 <6a24df18-832c-41b8-8226-5dc5b3c9995d@linaro.org>
 <c48690ca-f7d-e711-5b9a-d18c138568d@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c48690ca-f7d-e711-5b9a-d18c138568d@os.amperecomputing.com>

On Wed, Sep 10, 2025 at 12:46:24PM -0700, Ilkka Koskinen wrote:
> 
> 
> On Wed, 10 Sep 2025, James Clark wrote:
> > On 09/09/2025 10:01 pm, Ilkka Koskinen wrote:
> > > Add missing 'h' to l1d_cache_access_prefetces
> > > 
> > > Also fix a couple of typos and use consistent term in brief descriptions
> > > 
> > > Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core
> > > PMU events and metrics")
> > > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > > ---
> > >   .../arch/arm64/ampere/ampereonex/metrics.json          | 10 +++++-----
> > 
> > The same typos are in arch/arm64/ampere/ampereone/metrics.json as well.
> 
> Ah, that's right. The descriptions do have the same typos. I'll prepare
> another patch for AmpereOne and submit them together as v2.
> 
> Cheers, Ilkka

Thanks, applied to perf-tools-next,

- Arnaldo
 
> > 
> > Reviewed-by: James Clark <james.clark@linaro.org>
> > 
> > >   1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git
> > > a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> > > b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> > > index 5228f94a793f..6817cac149e0 100644
> > > --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> > > +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> > > @@ -113,7 +113,7 @@
> > >       {
> > >           "MetricName": "load_store_spec_rate",
> > >           "MetricExpr": "LDST_SPEC / INST_SPEC",
> > > -        "BriefDescription": "The rate of load or store instructions
> > > speculatively executed to overall instructions speclatively
> > > executed",
> > > +        "BriefDescription": "The rate of load or store instructions
> > > speculatively executed to overall instructions speculatively
> > > executed",
> > >           "MetricGroup": "Operation_Mix",
> > >           "ScaleUnit": "100percent of operations"
> > >       },
> > > @@ -132,7 +132,7 @@
> > >       {
> > >           "MetricName": "pc_write_spec_rate",
> > >           "MetricExpr": "PC_WRITE_SPEC / INST_SPEC",
> > > -        "BriefDescription": "The rate of software change of the PC
> > > speculatively executed to overall instructions speclatively
> > > executed",
> > > +        "BriefDescription": "The rate of software change of the PC
> > > speculatively executed to overall instructions speculatively
> > > executed",
> > >           "MetricGroup": "Operation_Mix",
> > >           "ScaleUnit": "100percent of operations"
> > >       },
> > > @@ -195,14 +195,14 @@
> > >       {
> > >           "MetricName": "stall_frontend_cache_rate",
> > >           "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
> > > -        "BriefDescription": "Proportion of cycles stalled and no
> > > ops delivered from frontend and cache miss",
> > > +        "BriefDescription": "Proportion of cycles stalled and no
> > > operations delivered from frontend and cache miss",
> > >           "MetricGroup": "Stall",
> > >           "ScaleUnit": "100percent of cycles"
> > >       },
> > >       {
> > >           "MetricName": "stall_frontend_tlb_rate",
> > >           "MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
> > > -        "BriefDescription": "Proportion of cycles stalled and no
> > > ops delivered from frontend and TLB miss",
> > > +        "BriefDescription": "Proportion of cycles stalled and no
> > > operations delivered from frontend and TLB miss",
> > >           "MetricGroup": "Stall",
> > >           "ScaleUnit": "100percent of cycles"
> > >       },
> > > @@ -391,7 +391,7 @@
> > >           "ScaleUnit": "100percent of cache acceses"
> > >       },
> > >       {
> > > -        "MetricName": "l1d_cache_access_prefetces",
> > > +        "MetricName": "l1d_cache_access_prefetches",
> > >           "MetricExpr": "L1D_CACHE_PRFM / L1D_CACHE",
> > >           "BriefDescription": "L1D cache access - prefetch",
> > >           "MetricGroup": "Cache",
> > 
> > 
