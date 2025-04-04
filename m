Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D5D166F1A;
	Fri,  4 Apr 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790074; cv=none; b=FU67pk8Qz1EzUqoMzKHH4PIxpo6IJ3ZV6YMIWSur2KC/IR9KqcJrXfzpC+53n18oZQNXje1vZQEO/P45trlX8aK9oPBNnUNLGxUSxvcB6bZRSUT19w5P87WMPyKqu8VFPms8KXcdmFd9WBoVnsVr1qoVTghv/H8kASdf30F6/Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790074; c=relaxed/simple;
	bh=5A4Gil0R3dVEPHFfgjiq6p1ds6V6qLfy5+KX6+GMF/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrT48d13sfzjdKimYon9/X/MBVheCGexlcouk9uQrO2/TIhq3GVmTDo3+r5WbtrCnYHgwz0upXbe1sEjahk8mLmtohFWLIQ0tqlQBULYxWFTyDxYsKstzYFyEAyzig3B+1xex/oFHFWGnqgR80IbNaKd5W2M45mfC8Wrsl9cJcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExMOkc60; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExMOkc60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B191C4CEDD;
	Fri,  4 Apr 2025 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743790074;
	bh=5A4Gil0R3dVEPHFfgjiq6p1ds6V6qLfy5+KX6+GMF/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExMOkc60NdrVXR4jPCihV69dKydt9eN8FSPvK54VLyKPLUISUWSMJOBglyFpK0BD/
	 8sccD5soDSobTkk3WTykxuWlMQHCAp/kllnVFt4FByNSj6AIgtRRptCaHLBavGoe4M
	 M1eewQ2Bx7ozT4Wskj2S0fJLumOhQOPTDebHqia/GJDJUne3Qqu69O6qf2PVecicG6
	 e3nuNGUFHaaOegyFnrttPJ9FmJkJ2ShELEOI4om2/PVG2xOG6ethbJ+atWJSQKsBvh
	 lWiDJSxbuh1eRqj5XD2TIePU5aNuLAGdf+E233EGcn/109W2QuBFturZ8cWtnPmb8u
	 IRUpQfrxbpt9g==
Date: Fri, 4 Apr 2025 11:07:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf pmu: Avoid segv for missing name/alias_name in
 wildcarding
Message-ID: <Z_Af-KAKuOlqALH6@google.com>
References: <20250402211301.4153441-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402211301.4153441-1-irogers@google.com>

On Wed, Apr 02, 2025 at 02:13:01PM -0700, Ian Rogers wrote:
> The pmu name or alias_name fields may be NULL and should be skipped if
> so. This is done in all loops of perf_pmu___name_match except the
> final wildcard loop which was an oversight.
> 
> Fixes: c786468a3585 ("perf pmu: Rename name matching for no suffix or wildcard variants")
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/pmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 31f1e617eb20..d27bdf421c19 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -2060,7 +2060,9 @@ static bool perf_pmu___name_match(const struct perf_pmu *pmu, const char *to_mat
>  	}
>  	for (size_t i = 0; i < ARRAY_SIZE(names); i++) {
>  		const char *name = names[i];
> -		
> +
> +		if (!name)
> +			continue;
>  		if (wildcard && perf_pmu__match_wildcard_uncore(name, to_match))
>  			return true;
>  		if (!wildcard && perf_pmu__match_ignoring_suffix_uncore(name, to_match))
> -- 
> 2.49.0.504.g3bcea36a83-goog
> 
