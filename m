Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A935CB86
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529523; cv=none; b=Saw0bkP3cyb+8PHCwKbCzps/MhwgBK/FKeQ2GUixhHepSVGM7ck/EVPp1eLzY9LeFIoyKjyAuPZiMm6s+e0+mYb8ZyYVBf2sppHn5sdRsqrpSPeyNA+tfmB0Jv6D+m39ILkmb7bZXrIqLQ/17tnmNchLBjNOAfn6EYZal2Zfaqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529523; c=relaxed/simple;
	bh=pGl/kZ1b1tTn1QvB/GIdxOXtR59IJaYALLQQ2raUNN8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAaPTqjQatemiwZdBsQf+jEH0pwGTlF+pAXCXQVRSzIw3JD9ionFXj3HPsR/elVEPmSzDrGXB09dQmvnNgYScOD/TiLT5AVoVInvGSig2cdqGnTvLlr7IzhLEWtuR09F8SybDwc3dOB+vLcvy9EskS/hXV0VWY07Rld90gk2hH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0qn623cczJ46Yd;
	Tue, 27 Jan 2026 23:58:02 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 696134056A;
	Tue, 27 Jan 2026 23:58:38 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Jan
 2026 15:58:37 +0000
Date: Tue, 27 Jan 2026 15:58:35 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Yushan Wang <wangyushan12@huawei.com>
CC: <mike.leach@linaro.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <peterz@infradead.org>,
	<john.g.garry@oracle.com>, <shiju.jose@huawei.com>, <will@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <liuyonglong@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <wangzhou1@hisilicon.com>
Subject: Re: [RFT PATCH 1/7] perf stat: Check color's length instead of the
 pointer
Message-ID: <20260127155835.000011c9@huawei.com>
In-Reply-To: <20260126123514.3238425-2-wangyushan12@huawei.com>
References: <20260126123514.3238425-1-wangyushan12@huawei.com>
	<20260126123514.3238425-2-wangyushan12@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 26 Jan 2026 20:35:08 +0800
Yushan Wang <wangyushan12@huawei.com> wrote:

> Color string returned by metric_threshold_classify__color() is never
> NULL, check the presence of *color will always return true.
> 
> Fix this by change the checks against length of *color.
> 
> Fixes: 37b77ae95416 ("perf stat: Change color to threshold in print_metric")
> 
No blank line between tags.

Fixes: 37b77ae95416 ("perf stat: Change color to threshold in print_metric")
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>

Some of the scripting run against the kernel uses that lack of blank lines
as a heuristic to identify what is a tag vs other similar looking text.

Thanks,

Jonathan

> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
> ---
>  tools/perf/builtin-script.c    | 2 +-
>  tools/perf/util/stat-display.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 62e43d3c5ad7..9fe90f564c69 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2100,7 +2100,7 @@ static void script_print_metric(struct perf_stat_config *config __maybe_unused,
>  	perf_sample__fprintf_start(NULL, mctx->sample, mctx->thread, mctx->evsel,
>  				   PERF_RECORD_SAMPLE, mctx->fp);
>  	fputs("\tmetric: ", mctx->fp);
> -	if (color)
> +	if (strlen(color))
>  		color_fprintf(mctx->fp, color, fmt, val);
>  	else
>  		printf(fmt, val);
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 6d02f84c5691..91c0c1020f4e 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -474,7 +474,7 @@ static void print_metric_std(struct perf_stat_config *config,
>  		do_new_line_std(config, os);
>  
>  	n = fprintf(out, " # ");
> -	if (color)
> +	if (strlen(color))
>  		n += color_fprintf(out, color, fmt, val);
>  	else
>  		n += fprintf(out, fmt, val);
> @@ -607,7 +607,7 @@ static void print_metric_only(struct perf_stat_config *config,
>  	if (mlen < strlen(unit))
>  		mlen = strlen(unit) + 1;
>  
> -	if (color)
> +	if (strlen(color))
>  		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
>  
>  	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);

