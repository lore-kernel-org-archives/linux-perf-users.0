Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACEE57305;
	Sat, 11 May 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715442544; cv=none; b=Qs//GCHTAmDWx3yQ4rp3qRKwLy0E2ZgQPCzE2Q98eonagZ6nL0UMxD/Rdd2Vo2FMR+fn9sn2LgLpS0HeRn/YSbGKgDOiwgui1dC0SH7NF/2umqRDM75w2z28mRk+8by1f/kspbfv8mRyoHKH3xZodYsVNcFO4S4lnWOQlXi6puw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715442544; c=relaxed/simple;
	bh=Cm1dSG6MFIbUqrUXRgsTNAD+XiHdp/ahM5v138B4wow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfinXMnAZnKIi5aUGFvraas9VafG6Q7sLz3RGC5mUTkygA6QwRqNwQ8ejErysngznrnm1OIlVbi5ozWs9k+ukOo8nLgDa9Sn/56gxw3VbllBEtqBrlIhSHKW89N5mycUzb5zczKBdTb5tO3hqzzXUYmwTG8jqNksu93Yo4JuTMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwQeR67N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwQeR67N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F3AC2BBFC;
	Sat, 11 May 2024 15:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715442544;
	bh=Cm1dSG6MFIbUqrUXRgsTNAD+XiHdp/ahM5v138B4wow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwQeR67NSwanr/FdzIgRlmm3DJjber7CmXWuEUkHTrmU4QGkg8OKN8xWU4d51YblI
	 FetJoqrP/9m9dDs13bd5XoA74bqqIdWEFEfHmKGkIjlELDzGinwuEJqndD8S0euzJH
	 cEQRgcsqVC+SH9Ko+FrHCIRinqNj1nEKCeZrYXtrGaRaAsT3vmntzdsLWrCslkcME/
	 wY5834wwRHPB/nof5JfQw4hVlUKtvLAwtATxdIETJt5k1VUOoB8V+9xbsEWeZ552a6
	 JRQrr1hqclYxvObcNkS02PSRQlIGHqDXmSfSjb9b3heQ2hrCWcqhNAANDJubVu6fez
	 FsmsXIcY1WqJQ==
Date: Sat, 11 May 2024 12:49:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yicong Yang <yangyicong@hisilicon.com>, Kaige Ye <ye@kaige.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Don't display metric header for non-leader
 uncore events
Message-ID: <Zj-TbLTORdPRlyHC@x1>
References: <20240510051309.2452468-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510051309.2452468-1-irogers@google.com>

On Thu, May 09, 2024 at 10:13:09PM -0700, Ian Rogers wrote:
> Achieve this by skipping events that aren't metric leaders when
> printing column headers and aggregation isn't disabled.
> 
> The bug is long standing, the fixes tag is set to a refactor as that
> is as far back as is reasonable to backport.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Fixes: 088519f318be ("perf stat: Move the display functions to stat-display.c")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-display.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index ea11e3437444..bb6bbb821b5a 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1251,6 +1251,9 @@ static void print_metric_headers(struct perf_stat_config *config,
>  
>  	/* Print metrics headers only */
>  	evlist__for_each_entry(evlist, counter) {
> +		if (config->aggr_mode != AGGR_NONE && counter->metric_leader != counter)
> +			continue;
> +
>  		os.evsel = counter;
>  
>  		perf_stat__print_shadow_stats(config, counter, 0,
> -- 
> 2.45.0.118.g7fe29c98d7-goog
