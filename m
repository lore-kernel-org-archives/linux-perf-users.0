Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C919C54E;
	Tue,  6 Jan 2026 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737206; cv=none; b=t6eenfnTdOXbVSXGVe/sww9KFZoxz3uNd/2B1fJEpAtA5q36l6vtnmRM3/uMmVV+QbQ8rWbfo0zV2waiLE3tWefeJtC70ObXzYocFW27jWDuUxakWC6qBs0gkomTL7LmK0JzJvIscz0iEs3Bflu3c9lS+2QwpO8R6t01+rOMzI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737206; c=relaxed/simple;
	bh=/AERRJCX2sWTHkNrIC8C3qkMc2/aOHGO9gggfiwsXEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWoBiNjUkH4PdGHG2vs+YPxg1W1B5kTtGtIIbpr7n5Rcu2+fSCMC7yj9ys670Wqh3FblLkDZKsC2b9zEzQB7HJGp+H9Z2kdv+bfX6wBeGCxgdrs4k4uGO9EUSDtu/ZFo+LFeH7S2TLYGDh+XCmp6m8EchKSqXpwz8cZyBD+Yq1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx4LJyRW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx4LJyRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C70C116C6;
	Tue,  6 Jan 2026 22:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767737206;
	bh=/AERRJCX2sWTHkNrIC8C3qkMc2/aOHGO9gggfiwsXEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mx4LJyRWKDXAXjm0CvOhHgUOBjR/lOyJXdS3qKu2tSDjpI7E6NsJm4ofc5fs5VjKj
	 lbToeP4udbWBXkKt6MlRYclTjHVbKj6O07P8VEO03u0a/KqxKq1sQl5TO0fOTcGdEP
	 5eYJUmvQueCegwCGP2yWcGuNgVZiYGhJp0GO6qBXSQnQUKYKB44EA+fv0I6+RVoE/2
	 Psk8wuSmbePFz78fN+DR1/ofQi7GdUzWAY9IohB9euQVzQx120i682UeFMOr2mtF0/
	 zSMxU+8KQc+aQl3TM9RkJPplbkPNNbP7dS6cbivJPMa8wa9LISHDwu3SgLCmPgaQv1
	 f3rt9WIFrgwkw==
Date: Tue, 6 Jan 2026 19:06:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test java symbol: Additional libperf-jvmti.so
 path check
Message-ID: <aV2HchAKw8gDc74m@x1>
References: <20251205190135.210864-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205190135.210864-1-irogers@google.com>

On Fri, Dec 05, 2025 at 11:01:35AM -0800, Ian Rogers wrote:
> If perf is built into an output directory then so is
> libperf-jvmti.so. If `perf test` is run from that directory then PWD
> needn't also be that directory meaning libperf-jvmti.so won't be found
> and the test skipped. Add an additional check for libperf-jvmti.so in
> the same directory as the perf binary for this case, this avoids the
> test skipping.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/test_java_symbol.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
> index 499539d1c479..63a2cc9bf13f 100755
> --- a/tools/perf/tests/shell/test_java_symbol.sh
> +++ b/tools/perf/tests/shell/test_java_symbol.sh
> @@ -22,10 +22,13 @@ cleanup_files()
>  
>  trap cleanup_files exit term int
>  
> +PERF_DIR=$(dirname "$(which perf)")
>  if [ -e "$PWD/tools/perf/libperf-jvmti.so" ]; then
>  	LIBJVMTI=$PWD/tools/perf/libperf-jvmti.so
>  elif [ -e "$PWD/libperf-jvmti.so" ]; then
>  	LIBJVMTI=$PWD/libperf-jvmti.so
> +elif [ -e "$PERF_DIR/libperf-jvmti.so" ]; then
> +	LIBJVMTI=$PERF_DIR/libperf-jvmti.so
>  elif [ -e "$PREFIX/lib64/libperf-jvmti.so" ]; then
>  	LIBJVMTI=$PREFIX/lib64/libperf-jvmti.so
>  elif [ -e "$PREFIX/lib/libperf-jvmti.so" ]; then
> @@ -34,6 +37,7 @@ elif [ -e "/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-gen
>  	LIBJVMTI=/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so
>  else
>  	echo "Fail to find libperf-jvmti.so"
> +
>  	# JVMTI is a build option, skip the test if fail to find lib
>  	exit 2
>  fi
> -- 
> 2.52.0.223.gf5cc29aaa4-goog
> 
