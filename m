Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB8219BA6;
	Wed, 30 Oct 2024 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248952; cv=none; b=OdleNha1RYxKl+DGaWh6v5G8TzPr0MzdHx1MRWaP2dPcQW4p3ksutvJ8pnG1HBbTxp+CGg5+mK0VpZHxasYIEJ+HHxbk1HH7IEjkdkxIeag2GpbadDrx9pYyUcQhohvnWQGhu6c2aoT0xcfdCBo2Bf22iGrxjbK7RtCeDiY1Kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248952; c=relaxed/simple;
	bh=pXAF6AnxY0RujwSB1XYQZWN8JJ7glJkPBbknjWYeZdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K665iipea6KS+D4cwAvG/8LYHFs8WXH6ltQhJfBC71uvXwZ9cWGEejTREAxhf+eISG1g63HTA6uDg9JMdp+J+EbqwjwITrPg8U3OyGIY9kl70ayTES0AWs+m6/nwCwAZalxATnTONnbxYiQ+LzMV18xTIvGm/Q6l6P2gpmpyiXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQyQnIP6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQyQnIP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90112C4CECD;
	Wed, 30 Oct 2024 00:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730248951;
	bh=pXAF6AnxY0RujwSB1XYQZWN8JJ7glJkPBbknjWYeZdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQyQnIP6kXHr7T/6KhOp7WF6icZAJZU4kZAb/wDJIqVIJy5ykDvvh6y79NviPelTK
	 PeRtnM/CuHEW/kwNFtgJpszDlb05L0tgDpkXIVwNNk3mHorr/5EW1s0KUprsc84ZUJ
	 pXz2+OtQtjZ1EnxSN+j8T3ySFF2eqQQCAtCv8fb+qMxOkjwRKtXwFF+kIrxkhFvRiv
	 +8Qw4YT4AtLqI7rpfsXgYw3svW0t8E+O86TNIVjCYadOK4E1nEdulhGKwE6pLhP1Ff
	 CvmQI4yOyZPqSPwJwZe9aRoeFTNhpYMMVwyiK+I1s2FnpmMZPVcHcZZbZ1jz3P9Zbg
	 Fr44P5ylktuLw==
Date: Tue, 29 Oct 2024 17:42:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org,
	tim.c.chen@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf stat: Also hide metric from JSON if units are
 an empty string
Message-ID: <ZyGA9cjrtbE_eWik@google.com>
References: <20241025090307.59127-1-james.clark@linaro.org>
 <20241025090307.59127-3-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025090307.59127-3-james.clark@linaro.org>

Hello,

On Fri, Oct 25, 2024 at 10:03:05AM +0100, James Clark wrote:
> We decided to hide NULL metric units rather than showing it as "(null)",
> but on hybrid systems if the process doesn't hit a PMU you get an empty
> string metric unit instead. To make it consistent also remove empty
> strings.
> 
> Note that metric-threshold is already hidden in this case without this
> change.
> 
> Where a process only runs on cpu_core and never hits cpu_atom:
> Before:
>  $ perf stat -j -- true
>  ...
>  {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/branch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00, "metric-value" : "0.000000", "metric-unit" : ""}
>  {"counter-value" : "6326.000000", "unit" : "", "event" : "cpu_core/branch-misses/", "event-runtime" : 293786, "pcnt-running" : 100.00, "metric-value" : "3.553394", "metric-unit" : "of all branches", "metric-threshold" : "good"}
>  ...

I guess you're talking about "metric-unit", not plain "unit", right?
Then please update the subject line to reduce the config.

Ian, can you please review?

Thanks,
Namhyung

> 
> After:
>  ...
>  {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/branch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00}
>  {"counter-value" : "5778.000000", "unit" : "", "event" : "cpu_core/branch-misses/", "event-runtime" : 282240, "pcnt-running" : 100.00, "metric-value" : "3.226797", "metric-unit" : "of all branches", "metric-threshold" : "good"}
>  ...
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index a5d72f4a515c..9b7fd985a42a 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -506,7 +506,7 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
>  	struct outstate *os = ctx;
>  	FILE *out = os->fh;
>  
> -	if (unit) {
> +	if (unit && strlen(unit)) {
>  		json_out(os, "\"metric-value\" : \"%f\", \"metric-unit\" : \"%s\"", val, unit);
>  		if (thresh != METRIC_THRESHOLD_UNKNOWN) {
>  			json_out(os, "\"metric-threshold\" : \"%s\"",
> -- 
> 2.34.1
> 
