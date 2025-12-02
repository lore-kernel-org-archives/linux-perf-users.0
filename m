Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878BA2AD35;
	Tue,  2 Dec 2025 04:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764650316; cv=none; b=oeS65VFEldS3bAQw2LMp+rWgLOo99i2wxKHM+qEN6vD7F/gLEt3jepC/Lp0DQEs02ClpG8fZ/raA1x1D2frR6Y7paETbri/00Vg4L2TOQ6hGN97ot4ymurAcgsI4dS1b4XtpnUeE91EEF0CVVsBav67/AeAtCz1MrDqeut8hqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764650316; c=relaxed/simple;
	bh=0DCMLy3KrX5PCDMHp+B0e/4Ig/8La16G/9FRp5SM+aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZCJb49HKQl1O8moROXE94HYSQFA2RJL7pQqZ0h6GUjwzt40muzdyC6ux/E2OSL8naZjF9AWiZ0FSMuLcHfLTBL9uRusRufs5C/qP2qe6/G4HdbqMHsH4jATvmzBIf7I5BWowWCnpDbqu3l8f9Nl0zR//Nz7yLkflAU/eoQuRMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4j1swzP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4j1swzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7069FC4CEF1;
	Tue,  2 Dec 2025 04:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764650316;
	bh=0DCMLy3KrX5PCDMHp+B0e/4Ig/8La16G/9FRp5SM+aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4j1swzPa+Zslb0dwC43DU/dAT7tW4BP7Oa4Ti9w7YyfgRQQxLGa/gWjIKrTVB1Yl
	 BUuwWjob0xAEtY7/xhjxl+S09/G68lXDo84Bweoq+3lJF4wikBu7lUlTxvR8eRiqc/
	 JZtXIXKGCEx5N2zsYCG2SWTtGEEXCB/iJtFgz1PWWnQtjmekUIAa3Q+M0AUCu/Ch2Z
	 mttp6wQ9SIR3VRsMvgqVD61/IxoOtryZKLPWce0v/7zt6qGf+RWADczlmUuWdQvBOD
	 dsomYJVJDaog2sirDiRjWvXnB/w4ohlHHChr+dkLix1i4SfbcjhGqAR3MaXtNABp6S
	 htoI7fh1panwg==
Date: Tue, 2 Dec 2025 05:38:30 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] perf stat: Allow no events to open if this is a
 "--null" run
Message-ID: <aS5tRnf801Sm3z8P@gmail.com>
References: <20251201230904.290733-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201230904.290733-1-irogers@google.com>


* Ian Rogers <irogers@google.com> wrote:

> It is intended that a "--null" run doesn't open any events.
> 
> Fixes: 2cc7aa995ce9 ("perf stat: Refactor retry/skip/fatal error handling")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 5c06e9b61821..6410115ed9c5 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -923,7 +923,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  			goto err_out;
>  		}
>  	}
> -	if (!has_supported_counters) {
> +	if (!has_supported_counters && !stat_config.null_run) {
>  		evsel__open_strerror(evlist__first(evsel_list), &target, open_err,
>  				     msg, sizeof(msg));
>  		ui__error("No supported events found.\n%s\n", msg);

Note that without the cpumask workaround patch I sent 
'perf stat --null' still segfaults on perf-tools-next 
even with the above patch applied - I suppose that's 
expected, right?

Other than that:

  Tested-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
