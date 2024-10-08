Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8320D218596;
	Tue,  8 Oct 2024 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427122; cv=none; b=V+2YBhhhr/GpbSbygMKltf9VGf4MxM4vO+3ztenUa3DtWlRHFZZ4fzptfyMH88RtbCRiUKTAj0wVAC5EoZHsZCf0c17v7sQd52bILXkp+ZNNVn3t8bNl/cPIavm/awdEje5VItLA823/D4zSdMmnzgK9IHytb/8E/C1dgk0daKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427122; c=relaxed/simple;
	bh=R4s7bdL4TN/Dk7rqy2FARS7dOHWyRfaaOtooebE4K78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hY9AufXpR9iWB5xrP612CJzoRYXB32FiX74HV1b1kmL/3aHai7WLWZ2yWvyTE2RSNuLJRLWhV/JLmuiBtaHuAMl8pQoZEl/YpItXWFAJEJLAqTAw3HNCfEmBfdD4eXm7VsIDvLyLAWKdchwEr7A1EIBnNgsVEe28bNhxXAoKWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtQixc9l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtQixc9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A916C4CEDB;
	Tue,  8 Oct 2024 22:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728427122;
	bh=R4s7bdL4TN/Dk7rqy2FARS7dOHWyRfaaOtooebE4K78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtQixc9lKEl08XIss7QJIFGiZrzjMtbnhJWMO1SRa0mL3J2VQzlpX2hmHKVmLbpNH
	 yMoBc3HVEPK3HV7vD3FBEI/w2BRcYRFaYYZZitKTq8plUJX/LRJ0Yb/eQI6ygxWp3o
	 K2djWkrLnoev9LTUtGBm3r+gZWgCDe1Pm1ZCzfGae6rzTmN5PA8hmy9hXcAmTjftf/
	 n0Ij+epRf5atXU66dYzIt4p+Dktz0dA5iisfH0CYvnqhxYVzABiuFgUA/ZKYgme2D+
	 PraGRabOBTNI2wNb47TQo6wNBhckBvGgQ73e7JV0cfovDyS5pykKa2QcsHh/9qgMQB
	 wFjIRCPIsLu2w==
Date: Tue, 8 Oct 2024 15:38:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/8] perf stat: Display "none" for NaN with metric
 only json
Message-ID: <ZwW0b8km5DnaOETr@google.com>
References: <20241004234120.1495209-1-irogers@google.com>
 <20241004234120.1495209-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004234120.1495209-4-irogers@google.com>

On Fri, Oct 04, 2024 at 04:41:15PM -0700, Ian Rogers wrote:
> Return earlier for an empty unit case. If snprintf of the fmt doesn't
> produce digits between vals and ends, as happens with NaN, make the
> value "none" as happens in print_metric_end.

Then it could be "NaN" or is there any other case?  But probably "none"
would be more generic.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-display.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 5402998881c4..e392ee5efb45 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -609,19 +609,22 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
>  {
>  	struct outstate *os = ctx;
>  	FILE *out = os->fh;
> -	char buf[64], *vals, *ends;
> +	char buf[64], *ends;
>  	char tbuf[1024];
> +	const char *vals;
>  
>  	if (!valid_only_metric(unit))
>  		return;
>  	unit = fixunit(tbuf, os->evsel, unit);
> +	if (!unit[0])
> +		return;
>  	snprintf(buf, sizeof(buf), fmt ?: "", val);
> -	ends = vals = skip_spaces(buf);
> +	vals = ends = skip_spaces(buf);
>  	while (isdigit(*ends) || *ends == '.')
>  		ends++;
>  	*ends = 0;
> -	if (!unit[0] || !vals[0])
> -		return;
> +	if (!vals[0])
> +		vals = "none";
>  	fprintf(out, "%s\"%s\" : \"%s\"", os->first ? "" : ", ", unit, vals);
>  	os->first = false;
>  }
> -- 
> 2.47.0.rc0.187.ge670bccf7e-goog
> 
