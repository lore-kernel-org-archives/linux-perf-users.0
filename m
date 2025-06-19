Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D0A1E7C2D
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750351508; cv=none; b=DeKASJrQ+moTeRRNTeTVBzHEc6/XakSsIPPhaRPXxV5TMIG82WCN161a976N/4HGDeak2Qn7g/iSTYgUDm+v1Nbkxz3legWjUrLtWFafQGy6sQKRAIAgHSloF6hWk83cF2JeGL8JZ0r/qHW5hEazHMg3ePb31Cwv79kbYhHjsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750351508; c=relaxed/simple;
	bh=PnYzffbMbjltXKVrpgkmPVsW+sDEJLig1i5KOpSt17s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trPtki8xjtOqvb3mUKT3bOa7ALoTRRNT0RevHWUrsQFbXQYumTyFqDVGRnk3V/vJlWLRj7IwNP9pMUUdpQ58YyNqio3thz8S2+fIzjAR59yDephnddRbwoRmIomPQ+y8djJFSiK6NqjSqv8ryxAz5zc3XQBLYh1r890wctlGmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 257D61063;
	Thu, 19 Jun 2025 09:44:46 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A83C3F66E;
	Thu, 19 Jun 2025 09:45:05 -0700 (PDT)
Date: Thu, 19 Jun 2025 17:45:03 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 03/12] perf arm_spe: Correct setting remote access
Message-ID: <20250619164503.GJ794930@e132581.arm.com>
References: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-0-6faecf0a8775@arm.com>
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-3-6faecf0a8775@arm.com>
 <5c88ba9f-2627-486c-84d1-2a721ff9ffcc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c88ba9f-2627-486c-84d1-2a721ff9ffcc@linaro.org>

On Thu, Jun 19, 2025 at 02:53:37PM +0100, James Clark wrote:
> 
> 
> On 13/06/2025 4:53 pm, Leo Yan wrote:
> > Set the mem_remote field for a remote access to appropriately represent
> > the event.
> > 
> > Fixes: a89dbc9b988f ("perf arm-spe: Set sample's data source field")
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >   tools/perf/util/arm-spe.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index d46e0cccac99a36148b4daa37f2bf2342e6b47ef..fdef6f743cf3c76b1dcdd57f5a2c297642fdd21a 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -839,7 +839,7 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
> >   	}
> >   	if (record->type & ARM_SPE_REMOTE_ACCESS)
> > -		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
> > +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> 
> Should this not avoid overwriting mem_remote if it's already set by
> arm_spe__synth_ds()? We do that for mem_lvl above.

Here it does not overwrite to zeros if the 'mem_remote' field has been
set. It is harmless to overwrite 1 if it has been set.

I will add a condition for consistency.

> We also still set mem_lvl = PERF_MEM_LVL_REM_CCE1 in
> arm_spe__synth_data_source_common(), if it's not right it should probably be
> changed there too.

I will change to PERF_MEM_LVL_NA / PERF_MEM_LVLNUM_NA in
arm_spe__synth_data_source_common() for remote socket access.

Thanks!
