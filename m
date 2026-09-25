Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2F2405EB;
	Fri, 25 Sep 2026 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333465; cv=none; b=GjJaynwBIoz1HIDYz3Q1H2Ohrv7D5uPJCba1YZJ6G7GiPl9hKpj+gFdIrVNOj0qCLuLi8k5J4/4qtiWarmT4gnlMAIAHaKwlYCOEmbbFEQYy/ti+2D31fw7nGrW65vOFhILMUvFGHB7GbdcUqGttOF/JyOg0c821tz1g/W2iJQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333465; c=relaxed/simple;
	bh=oLsgY+bF3fx/W/q+dDJcMMTx8xKORxT1jid72GxzCtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYupYMjgJxAoPrl0B0k+LMej5esb45MjAo9iG3HQc3J+mNogoS/Wbo0rHuX/GQsuvkmhFBv12rkqVbu4Hs63COvwkmYECbjue9X6TWphkCijm5BFY8VNkkZaro8Dd6Sqs9JN0Q2rviIn7g0gWaWgRqq4ANp/K8YAffb1rGjk+Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+Ft4a38; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+Ft4a38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2022A1F000FF;
	Fri, 25 Sep 2026 10:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790333463;
	bh=LyEydqPksXsYj6AbfejZG1cH8ynnPbjamYR1P8JfFyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K+Ft4a38LCNWmJ1fGUPYPXCjFfZRjKu+djbqtVrfeCAKu9NXG1HTvGV7Du0V4l6td
	 Iy5irzkfrGlCBr+Q75/cEjcXExKF6tLUUQl+B1meElgHVrcjT171x2RF2twxG7mFDO
	 JWnT+ryMn1T3GSxlFIB7P1U2YTErxBc9kPUyh4YLf0fCUWcsOBYToZuPNo4Va03Joe
	 iiAJDyllWIV8H4PzdARQPPohb7XkbyUIGq59y8tjbsmv6Iw4yUhkR/o/Ja2yKa/L6M
	 9CKiyaVqbugQJ/Ry41ShgyBhv7bVtpsHkEKkfNKpGSpz1qRGc/cty7nbGYD8RnBQGA
	 sIDuZKiqPiD9g==
Date: Fri, 25 Sep 2026 12:51:00 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf test: Fix errors when deleting data in perf
 record tests
Message-ID: <arZSFPy-dEIn0lGZ@x2>
References: <20260923215255.3329181-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923215255.3329181-1-namhyung@kernel.org>

On Wed, Sep 23, 2026 at 02:52:53PM -0700, Namhyung Kim wrote:
> perf record with multithreads would create a data directory instead of a
> file.  But the cleanup and retry logic expect a file and try to delete
> them with 'rm -f' which would fail.  Add '-r' flag to remove directories.
> 
>   rm: cannot remove '/tmp/__perf_test.perf.data.ZVHTw.old': Is a directory
 

Thanks, applied the series to perf-tools-next, for v7.4.

- Arnaldo

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/lib/perf_record.sh | 2 +-
>  tools/perf/tests/shell/record.sh          | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/lib/perf_record.sh b/tools/perf/tests/shell/lib/perf_record.sh
> index 2b9e11b66dc7a801..a95fafb8b6fa8b40 100644
> --- a/tools/perf/tests/shell/lib/perf_record.sh
> +++ b/tools/perf/tests/shell/lib/perf_record.sh
> @@ -30,7 +30,7 @@ perf_record_with_retry() {
>    fi
>  
>    for duration in 0.01 0.1 0.3 1.0 2.0; do
> -    rm -f "${perfdata}".old
> +    rm -rf "${perfdata}".old
>      ${cmd_prefix} "$@" -o "${perfdata}" ${testprog_base} ${duration} > "$logfile" 2>&1
>      local record_exit=$?
>  
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 4a4931cb5ba91849..cf8ba3d3411b0bcc 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -39,8 +39,8 @@ default_fd_limit=$(ulimit -Sn)
>  min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
>  
>  cleanup() {
> -  rm -f "${perfdata}"
> -  rm -f "${perfdata}".old
> +  rm -rf "${perfdata}"
> +  rm -rf "${perfdata}".old
>    rm -f "${script_output}"
>    perf_record_cleanup
>  
> -- 
> 2.56.0.rc1.310.g51773c2048-goog
