Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C654422425B
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529684; cv=none; b=XIXndpHDMwt00aAlRgN5iOZMJhSCSh8d/N7rQ4v8YXCmWGm8u0hAujqO3HUZltZBpyJKjZ5auM6SayzWPB0EcL7zZEXmQMC4S+Ig3yCfOcpZsDpC19VplW3sy4QopYnWXAx61md3UU1hxLluGWN5st81gBjbuxJSMMhjpcVmf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529684; c=relaxed/simple;
	bh=S4QHnB4xM59GcaJRCDxqr/69wvVWQhiHtWaLzEKkcL4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCRZtE49Tgj7qVl+E3d6unB4ZDPqoH7jgd3YwvL2cXcUaMPcuB6OTJQgI8xdfqOT4eFNfKahQCGBThgwjx4J11+uYeuo0bGRbmJSWMvMDsbcOSC8moWWCAkG8UN/XaK0tpObSXtfarGpM+4ESZQDZ/WkMiZVGYPZR7s6S8YDKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0qrD5pBGzJ46Cf;
	Wed, 28 Jan 2026 00:00:44 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id E929B40569;
	Wed, 28 Jan 2026 00:01:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Jan
 2026 16:01:19 +0000
Date: Tue, 27 Jan 2026 16:01:18 +0000
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
Subject: Re: [RFT PATCH 2/7] perf stat: Save unnecessary print_metric() call
Message-ID: <20260127160118.00001692@huawei.com>
In-Reply-To: <20260126123514.3238425-3-wangyushan12@huawei.com>
References: <20260126123514.3238425-1-wangyushan12@huawei.com>
	<20260126123514.3238425-3-wangyushan12@huawei.com>
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

On Mon, 26 Jan 2026 20:35:09 +0800
Yushan Wang <wangyushan12@huawei.com> wrote:

> Patch [1] removed the second branch of iostat_run, and changed num to 0
> since it is the default behavior. But during iostat_run, default value 1
> of num is required to avoid print_metric() call later.
> 
> Set num as 1 to avoid redundant print_metric() call that causes
> unaligned blank printed.
> 
> Fixes: b71f46a6a708 ("perf stat: Remove hard coded shadow metrics")
> 
> [1]: https://lore.kernel.org/all/20251111212206.631711-8-irogers@google.com/

Use a Link tag for links, but don't add them when they just point to the patch
you already have as a fixes tag.  Just refer to it as "The patch listed under
Fixes".
> 
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
> ---
>  tools/perf/util/stat-shadow.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 9c83f7d96caa..9439baf8002f 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -319,8 +319,10 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  	void *ctxp = out->ctx;
>  	int num = 0;
>  
> -	if (config->iostat_run)
> +	if (config->iostat_run) {
>  		iostat_print_metric(config, evsel, out);
> +		num = 1;
> +	}
>  
>  	perf_stat__print_shadow_stats_metricgroup(config, evsel, aggr_idx,
>  						  &num, NULL, out);

