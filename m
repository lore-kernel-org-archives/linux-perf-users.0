Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049A3A55;
	Tue,  2 Dec 2025 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764711698; cv=none; b=CvcxrCu8hKLtC91qFnuFfroSaxEi7F0QuPvx5nfHbanvWh6GeskA6UFWIkZvqowPSwgU2shDnE2/3W+vw22I7J85Ut0vlSrIVlSeyuWr6y9PCv8yJkWsOM2UbUpP9WD7LjMo+XTCSuJwEUCoz9qpTRTq3cVG+jzCaSaE98jHDz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764711698; c=relaxed/simple;
	bh=UhGL7tivNaKLyL6jfvj5V7LIBPFip+SvjX4CjIXLAEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1j6FFCII0nJX7FGnSZef9Cu58iY22jCyKFGoenaPbkPlGfeb5554H44t4M+1YkJCgJWfXymM8rNKkfIazIJ16MaQiN918kc3tOgAlPaDgEQKNI3TtYjlXh97RnntLW1Ykgm2oHC0xfTFNJwXJR+omShQAK3BTqAq0pxoywCE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALUV6kU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALUV6kU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46822C4CEF1;
	Tue,  2 Dec 2025 21:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764711697;
	bh=UhGL7tivNaKLyL6jfvj5V7LIBPFip+SvjX4CjIXLAEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALUV6kU9k/X1fI3CNVC07h12IZXB9+L7HHbfxJqJC+Tux4F8rjkDMq259AfPaJu4D
	 Xu2e/QZH28N2mTrpuHiO9f9JUPJhFd0LlOgG5shHpyCse/9etOre2MYUQZStvCRPcK
	 wTcx05U1iu8wYr4gUlyJOOuozNZPV0Ji6qf+5n7vlh5HoDF4gKNiEoUKeFZDA2fu29
	 GmLEvSs3AUlg0wbiB9IDS1mlZwf79yib7UerGKsmxY/Z+I9OjcVBUtVdoZZ4s8UWzz
	 gaPlYEhK8gUB82hxpFsbvzYFRptJzFs6HN/vJvGmY14yb6PmRzk5XVNLs+eFp2nvrS
	 LjWFZPblKCKLw==
Date: Tue, 2 Dec 2025 13:41:34 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Fix hybrid testing of event fallback test
Message-ID: <aS9dDvCWO9BdMmna@google.com>
References: <20251201231136.293248-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251201231136.293248-1-irogers@google.com>

On Mon, Dec 01, 2025 at 03:11:36PM -0800, Ian Rogers wrote:
> The mem-loads-aux event exists on hybrid systems but the "cpu" PMU
> does not. This causes an event parsing error which erroneously makes
> the test look like it is failing. Avoid naming the PMU to avoid
> this. Rather than cleaning up perf.data in the directory the test is
> run, explicitly send the 'perf record' output to /dev/null and avoid
> any cleanup scripts.
> 
> Fixes: fc9c17b22352 ("perf test: Add a perf event fallback test")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../tests/shell/test_event_open_fallback.sh   | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_event_open_fallback.sh b/tools/perf/tests/shell/test_event_open_fallback.sh
> index 9c411153c01b..9420a7557c13 100755
> --- a/tools/perf/tests/shell/test_event_open_fallback.sh
> +++ b/tools/perf/tests/shell/test_event_open_fallback.sh
> @@ -6,24 +6,9 @@ skip_cnt=0
>  ok_cnt=0
>  err_cnt=0
>  
> -cleanup()
> -{
> -	rm -f perf.data
> -	rm -f perf.data.old
> -	trap - EXIT TERM INT
> -}
> -
> -trap_cleanup()
> -{
> -	cleanup
> -	exit 1
> -}
> -
> -trap trap_cleanup EXIT TERM INT
> -
>  perf_record()
>  {
> -	perf record "$@" -- true 1>/dev/null 2>&1
> +	perf record -o /dev/null "$@" -- true 1>/dev/null 2>&1
>  }
>  
>  test_decrease_precise_ip()
> @@ -49,7 +34,7 @@ test_decrease_precise_ip_complicated()
>  
>  	perf list pmu | grep -q 'mem-loads-aux' || return 2
>  
> -	if ! perf_record -e '{cpu/mem-loads-aux/S,cpu/mem-loads/PS}'; then
> +	if ! perf_record -e '{mem-loads-aux:S,mem-loads:PS}'; then

I think we need to either keep the trap handler or convert all perf
record commands including this to use -o /dev/null.

Thanks,
Namhyung


>  		return 1
>  	fi
>  	return 0
> -- 
> 2.52.0.158.g65b55ccf14-goog
> 
