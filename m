Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB337329C56;
	Thu,  8 Jan 2026 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767916721; cv=none; b=tCQk/oiJNHDCTEpGwWKDjyAT95Ngg6BPs0ns5rBjxVI/yC3/lUbGzw2zJdvQMTzB3HICd+0VeThnU/QLO7edmf8Q3AfderASjs8kmR0V1M4OPNdD1FCBuqovAtrTnVwpXUh0TdrtaMXrAGOvQdVyLFOXoX7B6df1hWaianHR1UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767916721; c=relaxed/simple;
	bh=N5+QsrVyK9aKwwDqfVuQ8b+wgXlHeo9rjyZsakjqgKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8e8vTBgfjPoFhSChWKCOb7CmDtoZ7p9OF9lh0rdiKjtxj5mFJaOQ1jiIDss/xiLp1OYakoZfvEl/ir+aY76wNSmCjbJFNejFYA/6zX8DCuJx+tqbvxvTYzdKTn5Tz0TVOIFO0bQxD9lKT/Ij7gIR1DmQ+qqADDQwYIjkA64QZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/dy1/1T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/dy1/1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F458C116C6;
	Thu,  8 Jan 2026 23:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767916721;
	bh=N5+QsrVyK9aKwwDqfVuQ8b+wgXlHeo9rjyZsakjqgKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/dy1/1TafZLFnKBst7xyGvznphe69yR3jZuaQi7zAJDUDiUwKocUsoPmcL+1hSsb
	 IhcmU17fHfSe1jO5uGij9YePV48j+R96jZiR6u/AxltHGLZo5L0HiyuUXDGHiejc/E
	 gowQgqofv95g8FWX7liY2GyjnIyVvYhT0UeEg1T3TrnGK1XQKlWZ9SA9hR6DZrR4CF
	 /De6LLLH7CXjLV9thuAp8DAyEoQPXExAuhbTV8qZDX8s2R5jbEg82uFlc/OMiTHILy
	 vr97gikfwaSmRX+1XxqJv9RXX1Adf+4qojhJ0OyfG+9Be5aZ+x9fznDYlqA55HUbjV
	 wMl9NJFi9IDXQ==
Date: Thu, 8 Jan 2026 15:58:39 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf test: Skip dlfilter test for build failures
Message-ID: <aWBEr-PCJS4UEvtI@google.com>
References: <20251219011820.2505506-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251219011820.2505506-1-namhyung@kernel.org>

Ping (for the whole series)!

Thanks,
Namhyung


On Thu, Dec 18, 2025 at 05:18:17PM -0800, Namhyung Kim wrote:
> For some reason, it may fail to build the dlfilter.  Let's skip the test
> as it's not an error in the perf.  This can happen when you run the perf
> test without source code or in a different directory.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/script_dlfilter.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/script_dlfilter.sh b/tools/perf/tests/shell/script_dlfilter.sh
> index 45c97d4a7d5f90e8..7895ab0309b29dd5 100755
> --- a/tools/perf/tests/shell/script_dlfilter.sh
> +++ b/tools/perf/tests/shell/script_dlfilter.sh
> @@ -70,15 +70,15 @@ test_dlfilter() {
>  	# Build the dlfilter
>  	if ! cc -c -I tools/perf/include -fpic -x c "${dlfilter_c}" -o "${dlfilter_so}.o"
>  	then
> -		echo "Basic --dlfilter test [Failed to build dlfilter object]"
> -		err=1
> +		echo "Basic --dlfilter test [Skip - failed to build dlfilter object]"
> +		err=2
>  		return
>  	fi
>  
>  	if ! cc -shared -o "${dlfilter_so}" "${dlfilter_so}.o"
>  	then
> -		echo "Basic --dlfilter test [Failed to link dlfilter shared object]"
> -		err=1
> +		echo "Basic --dlfilter test [Skip - failed to link dlfilter shared object]"
> +		err=2
>  		return
>  	fi
>  
> -- 
> 2.52.0.322.g1dd061c0dc-goog
> 
