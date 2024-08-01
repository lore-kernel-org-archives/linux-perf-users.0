Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BEB1AC43D;
	Thu,  1 Aug 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524111; cv=none; b=Bv34PUXqoRIaf/88rl+6SVWCCJPbgYi3KH+J52B5whxvHE2tWS0occGGdjyPervPfmVapIolq4QC4+L3jsnCrlGfPBg13uWyULiBZBCtXAwg9pXBz+AQz8AxKBf8brjFbFrjuiGOlKrR9YySbsmufA33hJIpAP066EuUIgO3lyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524111; c=relaxed/simple;
	bh=4D66ZFfdTaFPbraxPKqxwI5q4Kcto82QPbSd8auBREg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzDrGs++1H3hQrre6lC2dNJvqOAmCTCqJTUZqacs3oOfldldQ9FBq67RklaqGtsMILVJCuIkOSz1EXRfyk7oC4NWO2jHYcmrNYW3Qc0Mi5cfe1BWHcSEXFgFhnMZn5VIN78rfM89lNZHrXOZrMBf6vvXmLS/hOypq0ah2ob4F+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6cDatTB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6cDatTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33DCC4AF0B;
	Thu,  1 Aug 2024 14:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722524111;
	bh=4D66ZFfdTaFPbraxPKqxwI5q4Kcto82QPbSd8auBREg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6cDatTBruDjgy+/KCDj13FWc+9DxAy/WvGso3eE/uhWJoy9dDG+VKoWJtXygE6ZU
	 ePIFx2ScxCCCIogNylCerc/7jLSrNBupJ6C2j7FggVueo1Cjid008/bFhK5R+TDheq
	 8iOVBl2yf0mRMr9sTdfuCZJqRUf8e5eHXtz1JpUCBaiKEwCKMzqwew5A0zPUEHrRv8
	 IZD1/nma6A58b2A+T5lJVFoMugNV+JXgzNX0HPTUG53ZRWh5fiuUEml2RWRpSRsR43
	 KLRFeRo1cfjeYXXxX8AJZShWEYPrePBV16IS+XXis610XQI/acfiUhO1w3ht45rNfo
	 1BinxFItSucaQ==
Date: Thu, 1 Aug 2024 11:55:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf python: Remove PYTHON_PERF ifdefs
Message-ID: <ZquhzFuhYWbpZCRE@x1>
References: <20240731230005.12295-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731230005.12295-1-irogers@google.com>

On Wed, Jul 31, 2024 at 04:00:05PM -0700, Ian Rogers wrote:
> When perf code was compiled one way for the binary and another for the
> python module, the PYTHON_PERF ifdef was used to remove some code from
> the python module. Since switching to building the perf code as a
> series of libraries, with the same libraries being used for the python
> module, the ifdefs became unused as PYTHON_PERF is never defined. As
> such remove the ifdefs.
> 
> Fixes: 9dabf4003423 ("perf python: Switch module to linking libraries from building source")
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied to tmp.perf-tools-next,

- Arnaldo

> ---
>  tools/perf/util/evsel_fprintf.c | 2 --
>  tools/perf/util/mmap.c          | 4 ----
>  2 files changed, 6 deletions(-)
> 
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index 8719b3cb5646..c2c0500d5da9 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -107,7 +107,6 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr_details *details, FILE
>  	return ++printed;
>  }
>  
> -#ifndef PYTHON_PERF
>  int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  			      unsigned int print_opts, struct callchain_cursor *cursor,
>  			      struct strlist *bt_stop_list, FILE *fp)
> @@ -248,4 +247,3 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
>  
>  	return printed;
>  }
> -#endif /* PYTHON_PERF */
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 122ee198a86e..43b02293f1d2 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -230,9 +230,7 @@ void mmap__munmap(struct mmap *map)
>  {
>  	bitmap_free(map->affinity_mask.bits);
>  
> -#ifndef PYTHON_PERF
>  	zstd_fini(&map->zstd_data);
> -#endif
>  
>  	perf_mmap__aio_munmap(map);
>  	if (map->data != NULL) {
> @@ -295,12 +293,10 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, struct perf_cpu
>  
>  	map->core.flush = mp->flush;
>  
> -#ifndef PYTHON_PERF
>  	if (zstd_init(&map->zstd_data, mp->comp_level)) {
>  		pr_debug2("failed to init mmap compressor, error %d\n", errno);
>  		return -1;
>  	}
> -#endif
>  
>  	if (mp->comp_level && !perf_mmap__aio_enabled(map)) {
>  		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog
