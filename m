Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E351A8403;
	Wed,  8 Jan 2025 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736365982; cv=none; b=Ir01mRJZgOxlJoKYWGHr4q/iphgZXWmgsYdh1z15oflgOlTniqdty5moa6RkGGPoR+t4wgO+AboxFRH37eMwyKi4fguxLXXF3cM63G69TDuZGcHlFtLpMqcnk/UIiqcjrxmGgYToa6hSLlC3RHrtbCJGF7mWUW1WCKe7FE2SkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736365982; c=relaxed/simple;
	bh=3uWJkyH+6vsMrmyuAEnrQcZeMnRpcWUw160MsdlvX+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUiRmc6254rnoRU+1hQHsgTb9BH7vZQk/tkaSH7rG0ePyBMw/gTvH5o8FjgirE+oBRaOzTcID2cOYx1dVX89ienY+knVLabvbKFkxMexKIPtm6CFDwY3fJbDJHFvMdxXZGCGZwsbnWcaTmGfR37q/dtEgKiBN83grZ12vosqkgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7Nx+kPn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7Nx+kPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09AFC4CED3;
	Wed,  8 Jan 2025 19:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736365982;
	bh=3uWJkyH+6vsMrmyuAEnrQcZeMnRpcWUw160MsdlvX+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7Nx+kPnsayveIjuIECkrT/lI/OOZ3T6ReDbwpyi37MfzAZs8RYohKiNcTCcvY20V
	 N0idzPM+pKCpPjZEIyuOcwUbmfIxs40Ii5D1lwJclwLPIACFZr+qi5C2Mewg4kf3Lc
	 JUfW3g5z8jK9QjwbD+JbshPuDKJeMT9uvmvdh63gNJuZi6mF4E5CS4fokf6Oxz8eoI
	 KqXKNEv8/Yqi0ZQShtrC2JJPi/S7ZZnfvYVQ7WvERQFrhWKH5DqWlZWZSyB3QpBn7y
	 c9S44Ynojc9rayTvBSNEdVIdPMRpUOhGkb750zqFSvFDDQHgtGal4zsYztOzsqH1Rs
	 FE9JU/zHPULuQ==
Date: Wed, 8 Jan 2025 16:52:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] perf test: Update ftrace test to use --graph-opts
Message-ID: <Z37Xm6sM_UQfHOxW@x1>
References: <20250107224352.1128669-1-namhyung@kernel.org>
 <20250107224352.1128669-3-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107224352.1128669-3-namhyung@kernel.org>

On Tue, Jan 07, 2025 at 02:43:52PM -0800, Namhyung Kim wrote:
> I found it failed on machines with limited memory because 16M byte
> per-cpu buffer is too big.  The reason it added the option is not to
> miss tracing data.  Thus we can limit the data size by reducing the
> function call depth instead of increasing the buffer size to handle the
> whole data.
> 
> As it used the same option in the test_ftrace_trace() and it was able
> to find the sleep function, it should work with the profile subcommand.
> 
> Get rid of other grep commands which might be affected by the depth
> change.
> 
> Cc: Thomas Richter <tmricht@linux.ibm.com>

Hey, I think we should convert the above Cc: to:

Reported-by: Thomas Richter <tmricht@linux.ibm.com>

As I think you became aware of this situation from a patch proposed by
Thomas?

I'm also CCing a few other folks that were CCed in Thomas patch, also
CCed here.

- Arnaldo

> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/ftrace.sh | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
> index 2df05052c324a21c..c243731d2fbf67aa 100755
> --- a/tools/perf/tests/shell/ftrace.sh
> +++ b/tools/perf/tests/shell/ftrace.sh
> @@ -67,11 +67,8 @@ test_ftrace_latency() {
>  
>  test_ftrace_profile() {
>      echo "perf ftrace profile test"
> -    perf ftrace profile -m 16M sleep 0.1 > "${output}"
> +    perf ftrace profile --graph-opts depth=5 sleep 0.1 > "${output}"
>      grep ^# "${output}"
> -    grep sleep "${output}"
> -    grep schedule "${output}"
> -    grep execve "${output}"
>      time_re="[[:space:]]+1[[:digit:]]{5}\.[[:digit:]]{3}"
>      # 100283.000 100283.000 100283.000          1   __x64_sys_clock_nanosleep
>      # Check for one *clock_nanosleep line with a Count of just 1 that takes a bit more than 0.1 seconds
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
