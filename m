Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9CE248176;
	Thu, 24 Jul 2025 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388909; cv=none; b=sKAMb4u0IOUs6D24KQs1GIC/ItFUQZJwX5om2IdXEYLrxoB3xpa6OKKvKabTRahqlv+wpn7/yFf38vVtPhU2pATaMBdOsV1bgc9bzBTnlnmPWhIetUl9vLopQgZ/bIxJahouY7oijH+aI3uFBu0aIAKpRhLWU8I0BFGY8RFHJLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388909; c=relaxed/simple;
	bh=jQ1/r2o+P5yZgqoZLt16Twhcc56PABMpbdIco3xgm5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+XzyUCW+s0MJNFFlVCT0sN2GQvU8n7H9eOW4zT0Z1CwxjMueBB+tGbYkbQZvIMBYWXHPPGLOAF88x5S2ZqNIUw4kHwfP1BTMbZcFLbI9Sd48Sq5KsQd8dg5VCWSbN2IMGSwmKAOpAwroa+aaTAUrK1pjWKJvX4FnX1MWRwMuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR8bp5f4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR8bp5f4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1A8C4CEED;
	Thu, 24 Jul 2025 20:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753388909;
	bh=jQ1/r2o+P5yZgqoZLt16Twhcc56PABMpbdIco3xgm5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XR8bp5f46Nka3drwSGlnts6EEqd3+Fs6XEVtr7N9SpyvcEP4WhR53Jsncz10l3IF3
	 iX1SQhoSGa3OR2536o8xXf5vEjzBjDVrqho5MCuD/xwG4C31OJW+blwh51tdk9jeXv
	 Y5EB0ERirqhTqc2ZBxPsSaNNfkHtB3856T1BO+AMAykE3AKXHSPvmqpOYj+dqoiyG2
	 i6qqJdLXnihRzPDJMJhdI3BI1g5dXSDuP/HlLCyoQ/3Q1dLBAwX9/KrtqgTqmteC+v
	 eGCZn0oBJk9EV6+KYXOGPxuYSO42BqMyiOmfHuviC7C/GC591hptxSY3hxJeC7xnER
	 S2rOwz3eaBw7w==
Date: Thu, 24 Jul 2025 13:28:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf pfm: Don't force loading of all PMUs
Message-ID: <aIKXa4LOIq5MyuS7@google.com>
References: <20250722013449.146233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722013449.146233-1-irogers@google.com>

On Mon, Jul 21, 2025 at 06:34:49PM -0700, Ian Rogers wrote:
> Force loading all PMUs adds significant cost because DRM and other
> PMUs are loaded, it should also not be required if the pmus__
> functions are used.
> 
> Tested by run perf test, in particular the pfm related tests. Also
> `perf list` is identical before and after.

I've also checked it with timing.  I'll add this to the commit message.

Before:
  $ time ./perf test pfm
   54: Test libpfm4 support                                            :
   54.1: test of individual --pfm-events                               : Ok
   54.2: test groups of --pfm-events                                   : Ok
  103: perf all libpfm4 events test                                    : Ok
  
  real	0m8.933s
  user	0m1.824s
  sys	0m7.122s
  
After:
  $ time ./perf test pfm
   54: Test libpfm4 support                                            :
   54.1: test of individual --pfm-events                               : Ok
   54.2: test groups of --pfm-events                                   : Ok
  103: perf all libpfm4 events test                                    : Ok
  
  real	0m5.259s
  user	0m1.793s
  sys	0m3.570s

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pfm.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> index 0dacc133ed39..e89395814e88 100644
> --- a/tools/perf/util/pfm.c
> +++ b/tools/perf/util/pfm.c
> @@ -47,10 +47,6 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
>  	p_orig = p = strdup(str);
>  	if (!p)
>  		return -1;
> -	/*
> -	 * force loading of the PMU list
> -	 */
> -	perf_pmus__scan(NULL);
>  
>  	for (q = p; strsep(&p, ",{}"); q = p) {
>  		sep = p ? str + (p - p_orig - 1) : "";
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
