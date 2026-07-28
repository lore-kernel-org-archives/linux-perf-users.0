Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CDF23909F;
	Tue, 28 Jul 2026 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258829; cv=none; b=YP345EXmNVFAEuUojrvF3VOREwAz1HdO6Nit60ykHQYSyteLT1kinD1GrezJd4w54JSO/W9aSKkvRVvQXt/JXmpEJ+AnNgZ2sSmBvHQfxqm4PncHkcsKEQkEutrTB2SIadJD1lJnLMy4CRFeP4oLEjWaeiqnhRyCYBczhHryGrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258829; c=relaxed/simple;
	bh=floiWPiCs23VBi14a9hCKNP+Gw2OuPuAAW8WjYIJhGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+qpKDx8tbVcjjwkbKOYKkfGkfjHEiZ4exg7fhtPleqf3hQJJ1EC6ztJZ6auvid+Bit0Oq1igpIWVta4TKQSsaYm0hLP3pza/PhvMYQSMjOPQFPQuIO0NNCJZKAtodYaNM9NupgidpddY8qWle2exwwO37J6AU0J00Pz05m0FbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuOZT/gc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuOZT/gc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6531F000E9;
	Tue, 28 Jul 2026 17:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258828;
	bh=sKF2JB8nJu7uRvnXy2GtPNV3qzGScxKuhuGQwQEYhoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YuOZT/gcsUD4P7wQllcUGeF5Y024oqFHULsNLody8tSMAeiDJ2EiiO99sCzu2Udib
	 ynPDgjCiziEtOMS5SZYsE5Vg/iolYoeedUdKqDN2Q3JhCcE/sjGf5srGRMA1gkIOIL
	 dgEYuZjn/1wwiNMFfobJ60DYacxELdXb5fIezeHiYOmr88sp5+1MyYB6DGAMkPGYPR
	 xncf/I+03MS3i8VUziEyuS5t/5DbSJMdP+8OhmF1ncZYq+28b7E9/xmHlMciFRC/EV
	 d9bzCllor2MxY4NV8HB5LlRsFTLQqWGyWfRwBTXMW+uYNFdxiixUPz/Ysu/ZSeoTw8
	 0X5+eJvfJ9lcw==
Date: Tue, 28 Jul 2026 10:13:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v2 2/6] perf mem: Add support for printing
 PERF_MEM_LVLNUM_L0
Message-ID: <amjjSlWIQRA64qSy@google.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
 <20260714004359.179451-3-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714004359.179451-3-thomas.falcon@intel.com>

Hello,

On Mon, Jul 13, 2026 at 07:43:55PM -0500, Thomas Falcon wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Add support for printing PERF_MEM_LVLNUM_L0 in perf mem report.

What's the L0, by the way?

Thanks,
Namhyung

> 
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 2 +-
>  tools/perf/util/bpf-filter.l             | 1 +
>  tools/perf/util/mem-events.c             | 5 +++++
>  tools/perf/util/mem-events.h             | 1 +
>  4 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 178f483140ed..b54032efe41c 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -212,7 +212,7 @@ OPTIONS
>  	The <value> can be one of:
>  	  <number> (for any term)
>  	  na, load, store, pfetch, exec (for mem_op)
> -	  l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
> +	  l0, l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
>  	  na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
>  	  remote (for mem_remote)
>  	  na, locked (for mem_locked)
> diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
> index 6aa65ade3385..1be9df6550fc 100644
> --- a/tools/perf/util/bpf-filter.l
> +++ b/tools/perf/util/bpf-filter.l
> @@ -131,6 +131,7 @@ store		{ return constant(PERF_MEM_OP_STORE); }
>  pfetch		{ return constant(PERF_MEM_OP_PFETCH); }
>  exec		{ return constant(PERF_MEM_OP_EXEC); }
>  
> +l0		{ return constant(PERF_MEM_LVLNUM_L0); }
>  l1		{ return constant(PERF_MEM_LVLNUM_L1); }
>  l2		{ return constant(PERF_MEM_LVLNUM_L2); }
>  l3		{ return constant(PERF_MEM_LVLNUM_L3); }
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 4e490f9cd348..4fd48fd20055 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -391,6 +391,7 @@ static const char * const mem_lvlnum[] = {
>  	[PERF_MEM_LVLNUM_L4] = "L4",
>  	[PERF_MEM_LVLNUM_L2_MHB] = "L2 MHB",
>  	[PERF_MEM_LVLNUM_MSC] = "Memory-side Cache",
> +	[PERF_MEM_LVLNUM_L0] = "L0",
>  	[PERF_MEM_LVLNUM_UNC] = "Uncached",
>  	[PERF_MEM_LVLNUM_CXL] = "CXL",
>  	[PERF_MEM_LVLNUM_IO] = "I/O",
> @@ -831,6 +832,8 @@ int mem_stat_index(const enum mem_stat_type mst, const u64 val)
>  		}
>  	case PERF_MEM_STAT_CACHE:
>  		switch (src.mem_lvl_num) {
> +		case PERF_MEM_LVLNUM_L0:
> +			return MEM_STAT_CACHE_L0;
>  		case PERF_MEM_LVLNUM_L1:
>  			return MEM_STAT_CACHE_L1;
>  		case PERF_MEM_LVLNUM_L2:
> @@ -915,6 +918,8 @@ const char *mem_stat_name(const enum mem_stat_type mst, const int idx)
>  		}
>  	case PERF_MEM_STAT_CACHE:
>  		switch (idx) {
> +		case MEM_STAT_CACHE_L0:
> +			return "L0";
>  		case MEM_STAT_CACHE_L1:
>  			return "L1";
>  		case MEM_STAT_CACHE_L2:
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index 5b98076904b0..daa22748f9fe 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -109,6 +109,7 @@ enum mem_stat_op {
>  };
>  
>  enum mem_stat_cache {
> +	MEM_STAT_CACHE_L0,
>  	MEM_STAT_CACHE_L1,
>  	MEM_STAT_CACHE_L2,
>  	MEM_STAT_CACHE_L3,
> -- 
> 2.43.0
> 
