Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BAB23370F;
	Mon, 27 Apr 2026 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328988; cv=none; b=quic/i2a0SNaQFS67QGGus8LHDXaQC0UbV2MtBe758et+NFvYTHILucxALQ4dER/Q3nkALQUv79IrrqXeI+NrqDiIQglxWgJ3lm4WUvnmgdUtZMf0cPdnnGPIFy8riG2RGrKutN2qti4xd5C2xfjCZAl4GBPPqe7cdV0Xo6bfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328988; c=relaxed/simple;
	bh=iU22FgFOoc+IVSUXKeNIx7CZzII7DGcebdj9jjN89GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCS5tfj+uBruD8iTXnvKL1B5vqURK3iX4w9zqh7U3AmwxSDAsi2+u2ocfMY+Ym6xeXKB49vO2l7NRsk2bFE93nFB8pQvrq7a63NcIBXz1EkiMIhRokebSrWq/3pxNye82SG+x13f4yjGxB9UC1G3gSxvBfvjP8eSNPIXGVKjYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwGctQJ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwGctQJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E153C19425;
	Mon, 27 Apr 2026 22:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777328987;
	bh=iU22FgFOoc+IVSUXKeNIx7CZzII7DGcebdj9jjN89GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwGctQJ3+p1CCyxVgwAD6Q8ZYuspCd3s3zx0Xh6+LNKbwwj7MqaG3JJKEyCAXP8Xp
	 zK/p7QPt20WJl46C8HLD5Yi2cfrKfXroaYnQtB1rKCdTqmIFJGD2vMSdy+v6Xwo9wE
	 A5/4YM/dm0v1dtca4hRwMD+z1Us4pCloegsVT1s7/XceXUz/fg1rsKYT8/bmmPxQiJ
	 YwHwL/X0gJLLDKVFwLUawIAmXN9RMNashWd5huoRg8Vj9pYpFVRDxWYcJCb1Bspnvu
	 8egSzrjnDcLfX0d1AG7HDIEdMv6J8pWmBNL7Bz6k6UA/0DjCdDibRvB3uyekLe7RRN
	 +KQ46hOwWH/Bg==
Date: Mon, 27 Apr 2026 15:29:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf test: fix nanosleep check in the ftrace test
Message-ID: <ae_jWY54Umgr6gDN@google.com>
References: <20260427090225.794482-1-martin@kaiser.cx>
 <20260427090225.794482-2-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427090225.794482-2-martin@kaiser.cx>

On Mon, Apr 27, 2026 at 11:01:41AM +0200, Martin Kaiser wrote:
> The perf ftrace test case runs
> 
> perf ftrace profile --graph-opts depth=5 sleep 0.1
> 
> and checks that the output contains a *clock_nanosleep function with a
> count of 1.
> 
> This fails on a risc-v system that uses musl as its C library. musl's
> nanosleep syscall wrapper uses either the nanosleep or the
> clock_nanosleep syscall.
> 
> Filter for sys_*nanosleep to allow both syscalls.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/shell/ftrace.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
> index 7f8aafcbb761..9f6e590f6437 100755
> --- a/tools/perf/tests/shell/ftrace.sh
> +++ b/tools/perf/tests/shell/ftrace.sh
> @@ -71,9 +71,10 @@ test_ftrace_profile() {
>      grep ^# "${output}"
>      time_re="[[:space:]]+1[[:digit:]]{5}\.[[:digit:]]{3}"
>      # 100283.000 100283.000 100283.000          1   __x64_sys_clock_nanosleep
> -    # Check for one *clock_nanosleep line with a Count of just 1 that takes a bit more than 0.1 seconds
> -    # Strip the _x64_sys part to work with other architectures
> -    grep -E "^${time_re}${time_re}${time_re}[[:space:]]+1[[:space:]]+.*clock_nanosleep" "${output}"
> +    # Check for one *sys_*nanosleep line with a Count of just 1 that takes a bit more than 0.1 seconds
> +    # Strip the _x64_ part to work with other architectures, strip the clock part to support
> +    # C libraries that use the nanosleep syscall instead of clock_nanosleep
> +    grep -E "^${time_re}${time_re}${time_re}[[:space:]]+1[[:space:]]+.*sys_.*nanosleep" "${output}"
>      echo "perf ftrace profile test  [Success]"
>  }
>  
> -- 
> 2.43.7
> 
