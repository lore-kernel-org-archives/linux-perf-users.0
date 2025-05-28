Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806B1E3DC8;
	Wed, 28 May 2025 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436252; cv=none; b=FPwHjQLbnjstCfspyz3UvToxQZych7j7zkJNgkMaB8bAETHNJ6XDMZNZRkU3IGB6qmzwsQ6Z3YhnoOeA4as1cbDNIPVLkFlujRCNcJtYDxcHDaXRbKPozTpKb2D9zVFiuOxcsk+zkQeoX5tG9/+4SV4uzIottQrrTw7GRsG62w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436252; c=relaxed/simple;
	bh=crBVArDH+A3z/R+SIMKBS2QOt2TADWyRrbSjnmFUSHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4SwKwZcKWOS06choqQXBpIFQi7ndxPeW3HwWoLZeCqGXf9cBdi0GJ40oSXfwq5/+XanQcLdAHqNFSCcfFBMrlX2wuxIBgeYwPmTHUhkV9dsxPMTnMsom/cCygvEgb+m2d1eVjzE8QPHVpZ5Mfo6fOcSqXHK8q+034MNklxIVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RihmlOvW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RihmlOvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455D5C4CEE7;
	Wed, 28 May 2025 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748436250;
	bh=crBVArDH+A3z/R+SIMKBS2QOt2TADWyRrbSjnmFUSHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RihmlOvWB26JeWPZ01gn4DDSvN0v/bsJ24ZjWydEYlCtxxDaIKIxV/YNfaabOGB9h
	 OXBFLRKSH6KB0zFiClo9Ueilpp7aV6kPqR1/b8J/v7SJX+lBKu/iqwA+iK3mlhbOWr
	 Lw2qTrBXMlB+JUf69B5AF94nHIS7axSjPl4FYbz6XbMWU+DHd2Qb7q14YopImJ8ygc
	 4VOMlX46DoB9BK+vxIjI0zGNdYzvZ4J0gnIrsqxsByPzYgi+QZzgHXGQ+8UAadQzIb
	 lot4/IFFmFqKL/pyzPnMiPZe/dSH43o5tjFIeEu/7i4PPTLR1ivMEj58tyMa/o1iI3
	 FgD0DyGc2tMlw==
Date: Wed, 28 May 2025 09:44:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf pmu: Avoid segv for missing name/alias_name in
 wildcarding
Message-ID: <aDcFF35JF4002MfK@x1>
References: <20250527215035.187992-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250527215035.187992-1-irogers@google.com>

On Tue, May 27, 2025 at 02:50:35PM -0700, Ian Rogers wrote:
> The pmu name or alias_name fields may be NULL and should be skipped if
> so. This is done in all loops of perf_pmu___name_match except the
> final wildcard loop which was an oversight.
> 
> Fixes: c786468a3585 ("perf pmu: Rename name matching for no suffix or wildcard variants")

I fixed the Fixes: to the right commit, as it seems to have been rebased
and ended up not present on my local repo:

Fixes: 63e287131cf0c59b ("perf pmu: Rename name matching for no suffix or wildcard variants")

⬢ [acme@toolbx perf-tools-next]$ git tag --contains 63e287131cf0c59b | grep ^v6
v6.15
v6.15-rc1
v6.15-rc2
v6.15-rc3
v6.15-rc4
v6.15-rc5
v6.15-rc6
v6.15-rc7
⬢ [acme@toolbx perf-tools-next]$

Or something else:

⬢ [acme@toolbx perf-tools-next]$ git tag --contains 86468a358 | grep ^v6
error: malformed object name 86468a358
⬢ [acme@toolbx perf-tools-next]$ git cat-file -t c786468a3585
fatal: Not a valid object name c786468a3585
⬢ [acme@toolbx perf-tools-next]$ 

further details:

commit 63e287131cf0c59b026053d6d63fe271604ffa7e
Author: Ian Rogers <irogers@google.com>
Date:   Fri Jan 31 23:43:18 2025 -0800

    perf pmu: Rename name matching for no suffix or wildcard variants
    
    Wildcard PMU naming will match a name like pmu_1 to a PMU name like
    pmu_10 but not to a PMU name like pmu_2 as the suffix forms part of
    the match. No suffix matching will match pmu_10 to either pmu_1 or
    pmu_2. Add or rename matching functions on PMU to make it clearer what
    kind of matching is being performed.
    
    Signed-off-by: Ian Rogers <irogers@google.com>
    Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
    Link: https://lore.kernel.org/r/20250201074320.746259-4-irogers@google.com
    Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2. Rebase resolving merge conflicts, add Namhyung's Acked-by.
> ---
>  tools/perf/util/pmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index bc1178234d3b..609828513f6c 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -2143,6 +2143,9 @@ static bool perf_pmu___name_match(const struct perf_pmu *pmu, const char *to_mat
>  	for (size_t i = 0; i < ARRAY_SIZE(names); i++) {
>  		const char *name = names[i];
>  
> +		if (!name)
> +			continue;
> +
>  		if (wildcard && perf_pmu__match_wildcard_uncore(name, to_match))
>  			return true;
>  		if (!wildcard && perf_pmu__match_ignoring_suffix_uncore(name, to_match))
> -- 
> 2.49.0.1204.g71687c7c1d-goog
> 
