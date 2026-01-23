Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC41FDA61;
	Fri, 23 Jan 2026 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187041; cv=none; b=DFwSXNVYc9MOzKSdQnaGkTjRVnBBDLgrYOGBfZ5zh7uPm2CFityZuanyHVLKwhutkucM1UZXJZRmEovWj7d7h8WnyWX10ZK27/lRy/93rkVVT9SWPcYJ1Rn5OgGKMMLZEbrFxs+UYdR/KSpejbY9lezr+PkUjVMaqZrtGGcY8uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187041; c=relaxed/simple;
	bh=DftR4T1uI2oTETrluEtFHnlpyIzKYljoNx8xqC6kZAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKWlod/TBTJ65Zy96Err0Xfzj2B4M/hMtY4fdkGZcqWgQ+P42a+HiMjraXsRmLleIfi3L6KZxAq1SxR3PUda4cmPHaFggbQHCbRy1dd/67jH4aK0Kmi7WucG+tc4sLaDjedk39exbQTaGrSareD8Mg7J7EVZDRzDKznFJ5G6rU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL1rEY4Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL1rEY4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62544C4CEF1;
	Fri, 23 Jan 2026 16:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769187040;
	bh=DftR4T1uI2oTETrluEtFHnlpyIzKYljoNx8xqC6kZAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cL1rEY4Z+77gf7VUEQlUvsmubHzGoj3ntLAKbdo8X0JD1HEitB3twbc5Pl4J2GTzp
	 lythQGpvjXWjLX/54Xr7oNsAmfFW+PVsDtCpdGaRAQHfscWZ6gr5MPekR3OHtszClV
	 5nyYxly5jLLt9ulNxAEtwLYUU+2rcgWUQAACsLg6zAqMPrGWepI2i738ItIgUxHDZ5
	 Ggy0eRe3HheIutQBzuOw4zgAfrcPsPpOT4AEPd/1sQjvdfHrHYn9NGrR3ekLDewu4+
	 7aWqw8oxRySqUBFtUaV2xgHFWL5EowTI+ch3/81YTpJ7eA2ivlhif9hqDQru+Y+m/8
	 dxnWOYL0NDv0g==
Date: Fri, 23 Jan 2026 13:50:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf tests sched: Avoid error in cleanup on loaded
 machines
Message-ID: <aXOm3bctXs8i6cfC@x1>
References: <20260122175337.591403-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122175337.591403-1-irogers@google.com>

On Thu, Jan 22, 2026 at 09:53:37AM -0800, Ian Rogers wrote:
> The stop_noploops function will kill the noploop processes that are
> running for 10 seconds. On a loaded machine they may have already
> terminated meaning the kill will return an error of no such
> process. This doesn't matter and so ignore the error to avoid the test
> terminating in the cleanup.
> 
> Fixes: 0e22c5ca44e6 ("perf test: Add sched latency and script shell tests")



Thanks, applied to perf-tools-next,

- Arnaldo

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/sched.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/sched.sh b/tools/perf/tests/shell/sched.sh
> index b9b81eaf856e..b9637069adb1 100755
> --- a/tools/perf/tests/shell/sched.sh
> +++ b/tools/perf/tests/shell/sched.sh
> @@ -53,7 +53,7 @@ start_noploops() {
>  }
>  
>  cleanup_noploops() {
> -  kill "$PID1" "$PID2"
> +  kill "$PID1" "$PID2" || true
>  }
>  
>  test_sched_record() {
> -- 
> 2.52.0.457.g6b5491de43-goog
