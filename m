Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8021C160;
	Thu, 26 Mar 2026 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774564652; cv=none; b=qRo5bupYloVHxspnsyXtyDsTfkJydq/xyUAuPbI4ff88Xd77RhN9tS3PXa4lszVetIQuyA+YK43S7TbZcW9bUSfDU9vkEHUaQE+LC64dp5brL+QGUjZaTEs7sy/AiaUK75Yua7dvF4v/icpEECuZHLu8z2FoGfMochu8WgDxtFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774564652; c=relaxed/simple;
	bh=xBPsYXKrihhZTtuticuwUsxl47Z18kQT0bgBIgJNn8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8xMh2MthDE4V/aLQc9QplGXuUvg0ZUUBWlPpJslJOcgrTl0T7iSWLK8qKNBLfQpi71uy8U/L8ew68wqWzs/kqAmWDVFATnm319w7fJ310GlChngmLYzbtgQjHpiROHZZEpkfsq9Qwubu1vQvXK+hF2jFpmwNkbw8MDCXCrSWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrGS9ChW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrGS9ChW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEA1C116C6;
	Thu, 26 Mar 2026 22:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774564651;
	bh=xBPsYXKrihhZTtuticuwUsxl47Z18kQT0bgBIgJNn8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LrGS9ChWaxGzsohyRK1x1Ovaxdl82n6V5opnbQ5DEtByBeowV1tnJhspqhI1xybWg
	 Qd3u9xgEKUh2PbaMRZCP0s1tDf66/JbYOenK93kis6lYcYGVtzcSCskNV/KSlnZ4ck
	 5KmOrsfU2I5t+Zuua0hmssBMEgcqXBiKrSBDmbb5E7eWFcZRgpXr55l/PCw8B9OE0F
	 7j4lrUui6FyjXjzU6SHR9G/B3VFQKgtB4Qu2tuuNwlGq5IhXpfKgY5BMId7/9Pphi7
	 C/+jbQ3iimfGPTZmUtQGrnBCY46EyGNgMzYVO1BzRWR0msxlFybfd7vKgwkFleWeIR
	 zMETRXRqRyKuQ==
Date: Thu, 26 Mar 2026 15:37:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf tests task-analyzer: Write all test files to
 tmpdir
Message-ID: <acW1KYl5x8W8SUO0@google.com>
References: <20260321061624.811157-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260321061624.811157-1-irogers@google.com>

On Fri, Mar 20, 2026 at 11:16:24PM -0700, Ian Rogers wrote:
> Writing to the test output files in the current working directory can
> fail in various contexts such as continual test. Other tests write to
> a mktemp-ed file, make the "perf script task-analyszer tests" follow
> this convention too. Currently this isn't possible for the perf.data
> file due to a lack of perf script support.

I don't know what you mean by the last sentence.

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/test_task_analyzer.sh | 37 +++++++++++---------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
> index e194fcf61df3..cc74b03477fe 100755
> --- a/tools/perf/tests/shell/test_task_analyzer.sh
> +++ b/tools/perf/tests/shell/test_task_analyzer.sh
> @@ -3,6 +3,10 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  tmpdir=$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
> +# perf script report only supports input from the perf.data file.
> +perfdata="perf.data"

I thought you want to use a different file name.  What's the point of
adding a variable here?


> +csv="$tmpdir/csv"
> +csvsummary="$tmpdir/csvsummary"
>  err=0
>  
>  # set PERF_EXEC_PATH to find scripts in the source directory
> @@ -15,11 +19,10 @@ fi
>  export ASAN_OPTIONS=detect_leaks=0
>  
>  cleanup() {
> -  rm -f perf.data
> -  rm -f perf.data.old
> -  rm -f csv
> -  rm -f csvsummary
> +  rm -f "${perfdata}"
> +  rm -f "${perfdata}".old
>    rm -rf "$tmpdir"
> +
>    trap - exit term int
>  }
>  
> @@ -61,7 +64,7 @@ skip_no_probe_record_support() {
>  
>  prepare_perf_data() {
>  	# 1s should be sufficient to catch at least some switches
> -	perf record -e sched:sched_switch -a -- sleep 1 > /dev/null 2>&1
> +	perf record -e sched:sched_switch -a -o "${perfdata}" -- sleep 1 > /dev/null 2>&1

I'm not sure why it's needed.

Thanks,
Namhyung


>  	# check if perf data file got created in above step.
>  	if [ ! -e "perf.data" ]; then
>  		printf "FAIL: perf record failed to create \"perf.data\" \n"
> @@ -130,28 +133,28 @@ test_extended_times_summary_ns() {
>  }
>  
>  test_csv() {
> -	perf script report task-analyzer --csv csv > /dev/null
> -	check_exec_0 "perf script report task-analyzer --csv csv"
> -	find_str_or_fail "Comm;" csv "${FUNCNAME[0]}"
> +	perf script report task-analyzer --csv "${csv}" > /dev/null
> +	check_exec_0 "perf script report task-analyzer --csv ${csv}"
> +	find_str_or_fail "Comm;" "${csv}" "${FUNCNAME[0]}"
>  }
>  
>  test_csv_extended_times() {
> -	perf script report task-analyzer --csv csv --extended-times > /dev/null
> -	check_exec_0 "perf script report task-analyzer --csv csv --extended-times"
> -	find_str_or_fail "Out-Out;" csv "${FUNCNAME[0]}"
> +	perf script report task-analyzer --csv "${csv}" --extended-times > /dev/null
> +	check_exec_0 "perf script report task-analyzer --csv ${csv} --extended-times"
> +	find_str_or_fail "Out-Out;" "${csv}" "${FUNCNAME[0]}"
>  }
>  
>  test_csvsummary() {
> -	perf script report task-analyzer --csv-summary csvsummary > /dev/null
> -	check_exec_0 "perf script report task-analyzer --csv-summary csvsummary"
> -	find_str_or_fail "Comm;" csvsummary "${FUNCNAME[0]}"
> +	perf script report task-analyzer --csv-summary "${csvsummary}" > /dev/null
> +	check_exec_0 "perf script report task-analyzer --csv-summary ${csvsummary}"
> +	find_str_or_fail "Comm;" "${csvsummary}" "${FUNCNAME[0]}"
>  }
>  
>  test_csvsummary_extended() {
> -	perf script report task-analyzer --csv-summary csvsummary --summary-extended \
> +	perf script report task-analyzer --csv-summary "${csvsummary}" --summary-extended \
>  	>/dev/null
> -	check_exec_0 "perf script report task-analyzer --csv-summary csvsummary --summary-extended"
> -	find_str_or_fail "Out-Out;" csvsummary "${FUNCNAME[0]}"
> +	check_exec_0 "perf script report task-analyzer --csv-summary ${csvsummary} --summary-extended"
> +	find_str_or_fail "Out-Out;" "${csvsummary}" "${FUNCNAME[0]}"
>  }
>  
>  skip_no_probe_record_support
> -- 
> 2.53.0.959.g497ff81fa9-goog
> 
