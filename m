Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399F83D0D5;
	Fri, 13 Dec 2024 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734053980; cv=none; b=fa+3TcW2wZtvA/aCrZEi7lfstzQ3TEf0KK7mUNU6GpGJ3aV27DBnb0HFzDfqfV+OKCpKZMSW9Wi2XF7A5BM/IBWjp9XNuKZMYo2mfDiu9ukyJoB79ULvgCqUc4dVO6M43IbbKBIWNcoZB8P6GzWPSiyCM8najU0322zOXDRkzC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734053980; c=relaxed/simple;
	bh=x0Bq7X6GE2Lfhay2QQ2KLcM4IyBanclt9tX5/BtS8w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xzw/uRqMXMiJQGt+ArysZv85727RrfIwoiHWXGkGkaFyhntr1clqCIys8gfL0AmjwjtDoKwhjOsnHquayQOvrMzKg39c6tjw+U1doE74ZOJWb2NsSq65fTEFSkBHnY+Nf6mTQFLLPFYTq2W0Z3LZtupG2cGH5pjHhVQAG1CdyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UU3VsCP2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UU3VsCP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573ACC4CED4;
	Fri, 13 Dec 2024 01:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734053979;
	bh=x0Bq7X6GE2Lfhay2QQ2KLcM4IyBanclt9tX5/BtS8w0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UU3VsCP2SCmMvz7u+ry4q2SWfbMg5BpiLo7nlhAZO/L+gDFLVEUuOTIF15wrXpUrI
	 +WLLQFF2ysu3kx96u15iNIgDsjJ4JitZ6r2rvNdLisHpdACKU8znn0+VM+bUZoxMW3
	 CCKgWs9auUpBwlrM/VPkBiAqmWzklV+VSoqLAf/4Wc576P27QjBQ3+LNm1xnivhAaQ
	 3HQFCg6Y/VoUegMoe4T92Vai7+69PfrTjH0pTh/F04pvG4/pWTYfIU3X4DWFui+cGJ
	 azKOIu/vSthQ5nXtOkHm1T7V5h7t4VDQwXgXvpGtPMop/Cku8lJxRgnbdkCc5j/Gv/
	 qO1kWRoewaD4g==
Date: Thu, 12 Dec 2024 17:39:38 -0800
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
Subject: Re: [PATCH v2] perf test stat: Avoid hybrid assumption when
 virtualized
Message-ID: <Z1uQWmq3KAQx1tA3@google.com>
References: <20241212173354.9860-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212173354.9860-1-irogers@google.com>

On Thu, Dec 12, 2024 at 09:33:54AM -0800, Ian Rogers wrote:
> The cycles event will fallback to task-clock in the hybrid test when
> running virtualized. Change the test to not fail for this.
> 
> Fixes: a6b8bb2addd0 ("perf test: Add a test for default perf stat command")

I cannot find this commit.

> Signed-off-by: Ian Rogers <irogers@google.com>

Other than that,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/shell/stat.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> index 5a2ca2bcf94d..da42427bb077 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -163,7 +163,11 @@ test_hybrid() {
>    # Run default Perf stat
>    cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles  " | wc -l)
>  
> -  if [ "$pmus" -ne "$cycles_events" ]
> +  # The expectation is that default output will have a cycles events on each
> +  # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
> +  # can fall back to task-clock and so the end count may be 0. Fail if neither
> +  # condition holds.
> +  if [ "$pmus" -ne "$cycles_events" ] && [ "0" -ne "$cycles_events" ]
>    then
>      echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
>      err=1
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
