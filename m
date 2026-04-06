Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31EC1D45E8;
	Mon,  6 Apr 2026 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499385; cv=none; b=uGYOQtdkg+OwW7FFK2tfFatyof4DnovSvqa2HMmkfkfxP52FQYDphN/k0t6a5Yh3FU+nyNzNtkB7+AUMDlJx+czwP8MNWtA4oUciHT+zI3oEf39haFbdTgZh1njLZOD2l7dRmjV0lfDwrOCSMju7Rr51aF/cY36XfwO7qAaxOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499385; c=relaxed/simple;
	bh=aRogYrVY/Sxjp8HogFq1zAA2nGzIDaCKZLBTe2n1PO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJGTvzkoeVIHe673zpddD0K8I732UoGINhlhUiwHjKeMe1Ox0iZ2246qpPIUinH4LhQlEOrUNenfbyZYgx5fDmLxqEPO0Dy4jT/TIdSTimQVF0WwFR4j/cE4R50cf0BnQXtzwFUTGO2dp+IZWG+jITY5CIKBjP0MmirxNKV+FOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWx5iZ80; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWx5iZ80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCA3C4CEF7;
	Mon,  6 Apr 2026 18:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775499385;
	bh=aRogYrVY/Sxjp8HogFq1zAA2nGzIDaCKZLBTe2n1PO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWx5iZ80VJsyTX8RN9qEBLz1Ha0lFoPfnMIGxq0IYNOQyj4ijAWcO+elDPz0E+P78
	 q1rhkjDBojKFPLbQm1zuGD73O2skFEOQTTJXaGYbmL+TBU3T+A5HhmCC3mUXUkMLMb
	 f8hlv71EgwPwPbNZgTOIJO2/ymYStYss7DtMEe1Q0IXJ3zX5sZNBCRi15/dDZli8Bo
	 MgG/PX+7ZE+oje+Oa0aUpQ3IjkDf27/DlOv5obW2pSHVkvasonO6XdHKGYt2HDQ7aQ
	 zWzJl4Oc+qRk7ZgXeKe746yd2DcSDW5R0nLUGY1VFyVcUPKT6W7SLgtupLzsb8m6f6
	 AlcDjwD0a4uGQ==
Date: Mon, 6 Apr 2026 11:16:23 -0700
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
Message-ID: <adP4dyKNTz3LjFmt@google.com>
References: <20260402220406.983248-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402220406.983248-1-irogers@google.com>

On Thu, Apr 02, 2026 at 03:04:06PM -0700, Ian Rogers wrote:
> Seen on ARM, the stalled-cycles-backend event can be given as the
> event for both backend_cycles_idle and stalled_cycles_per_instruction
> metrics. Make the metric match sufficiently generic to allow this.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat+std_output.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
> index 9c4b92ecf448..5a6bda436dd4 100755
> --- a/tools/perf/tests/shell/stat+std_output.sh
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -11,9 +11,12 @@ set -e
>  
>  stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
>  
> +# For event_name[i] expect to see event_metric[i]. 'stalled-cycles-backend' may
> +# match both 'backend_cycles_idle' and 'stalled_cycles_per_instruction', hence
> +# matching "_cycles_".
>  event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
> -event_metric=("CPUs_utilized" "CPUs_utilized" "cs/sec" "migrations/sec" "faults/sec" "frontend_cycles_idle" "backend_cycles_idle" "GHz" "insn_per_cycle" "/sec" "branch_miss_rate")
> -skip_metric=("tma_" "TopdownL1")
> +event_metric=("CPUs_utilized" "CPUs_utilized" "cs/sec" "migrations/sec" "faults/sec" "frontend_cycles_idle" "_cycles_" "GHz" "insn_per_cycle" "/sec" "branch_miss_rate")

Is this used for partial string match?

Then I guess "frontend_cycles_idle" can be covered by "_cycles_" too?
Also as we have "/sec", can "cs/sec" and "migrations/sec" be removed?


> +skip_metric=("tma_" "TopdownL1" "percent of slots")

Why is "percent of slots" added as well?

Thanks,
Namhyung

>  
>  cleanup() {
>    rm -f "${stat_output}"
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 
