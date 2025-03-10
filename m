Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F5D1DF979;
	Mon, 10 Mar 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639413; cv=none; b=k6eLUbd14MVW2nhC73TjtwbCpi11c94QFlifxi3Tnhi7X2JylHDKww9oTXCzN3nITHlqKHNe+1rXJ8OAQHQDZOmfIPvBU8p06NZ7ab8zEdH0l8CVs6OJKYXeWP1jgg+Ztin8N+3hTXiMvJoZFzSCKLQ8Es3QbRjqn5TTbvl6N4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639413; c=relaxed/simple;
	bh=8CPse12cMKqpOcsNkiSbBZYCP75RyjxtQ0+VEneVPcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1qZPbl6hA29IqK97WHyvSdNaDVGz2oTbPtK51sWikGO0qEgKcJjiSqY/9uHSlZBvrPTbkXCur1BiyTDS9rGhotmjmJBAzDEivKWhvN6E1TcqAzlUK0wAQIswlKhEx8ZRfPZe3BZkrdLhbRENdUs2Q9YLIoXhTCPkolWP3DLjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt5RrX+3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt5RrX+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DFCC4CEE5;
	Mon, 10 Mar 2025 20:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639412;
	bh=8CPse12cMKqpOcsNkiSbBZYCP75RyjxtQ0+VEneVPcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qt5RrX+3/6tG2D+eIKmNFgQ7apGzgxqboQaPjxtkRAf4FU2/D/VgbJXJuZpCsNtCq
	 UCPKEcYS2A9Qi53AaLl37T9K5o/LmUHcbmgpws1RUwxlNVGzC5nwOnHo0t4hymZxCQ
	 b6ESvWtVBHKZUKthtvcUk3urB7kjF51lNhyFOGTiINNoxVDOattz+hCKtVN4Dk2RI7
	 px3H58CQvlTYyYYf/Zk4uLK6FVJT2DefcG0j1iDaDTzfgkDOYI9ND89D4WYMDGPnn0
	 aExajhhHFtD4SF9psau5+KjOEhbUh0iEMVk614E/khr0HJLE267C8Bh8twRbJNNzib
	 M0BEwIWVPo0Ug==
Date: Mon, 10 Mar 2025 17:43:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 03/11] perf evsel: tp_format accessing improvements
Message-ID: <Z89O8eaFpltNBtUG@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228222308.626803-4-irogers@google.com>

On Fri, Feb 28, 2025 at 02:23:00PM -0800, Ian Rogers wrote:
> Ensure evsel__clone copies the tp_sys and tp_name variables.
> In evsel__tp_format, if tp_sys isn't set, use the config value to find
> the tp_format. This succeeds in python code where pyrf__tracepoint has
> already found the format.

Here those two fields were introduced but evsel__clone() wasn't update
to clone those:

Fixes: 6c8310e8380d472c ("perf evsel: Allow evsel__newtp without libtraceevent")

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 4a0ef095db92..1974395492d7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -521,6 +521,16 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
>  	}
>  	evsel->cgrp = cgroup__get(orig->cgrp);
>  #ifdef HAVE_LIBTRACEEVENT
> +	if (orig->tp_sys) {
> +		evsel->tp_sys = strdup(orig->tp_sys);
> +		if (evsel->tp_sys == NULL)
> +			goto out_err;
> +	}
> +	if (orig->tp_name) {
> +		evsel->tp_name = strdup(orig->tp_name);
> +		if (evsel->tp_name == NULL)
> +			goto out_err;
> +	}
>  	evsel->tp_format = orig->tp_format;
>  #endif
>  	evsel->handler = orig->handler;
> @@ -644,7 +654,11 @@ struct tep_event *evsel__tp_format(struct evsel *evsel)
>  	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
>  		return NULL;
>  
> -	tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
> +	if (!evsel->tp_sys)
> +		tp_format = trace_event__tp_format_id(evsel->core.attr.config);
> +	else
> +		tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
> +
>  	if (IS_ERR(tp_format)) {
>  		int err = -PTR_ERR(evsel->tp_format);
>  
> -- 
> 2.48.1.711.g2feabab25a-goog
