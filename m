Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C58628641B;
	Wed, 25 Jun 2025 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842010; cv=none; b=q8TgGPplZ5gayXdXlgg9rtaFiMxdXG8Ns7ARgIQScCjAODQrn/ugH4psLGHIPaja/HG5zEzjnv/BXq/QoArhSvutSpcW2o8VIgsOu7YTXQQ4SKAKI/yjvnsqLLL9fkpGvzq3QEwdqC8eZkPHmwE2dD7PM+zmohIhPwyRLDzsFbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842010; c=relaxed/simple;
	bh=GWXcQ4Nz79x8qBwbvgGBWE7L/NrUxcYy1iTic/UeGKo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLTN7xJ6Z80OYAjZ3pBoo4vUmQzVPV6teng+aofBAd5mHyuM9tZ4wUBE5aTbJ07MXwbyT6anNob27tHev8n0Y7zWEItpmDrSB6N0FeubHogmxGkUo8cPgAOH5zX/wBzRkGEVj59enFah6XCkcZnPM2SQiyM6sHUVoUSUpcq80eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRwjg2gmgz6GFDR;
	Wed, 25 Jun 2025 16:59:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CBF24140432;
	Wed, 25 Jun 2025 16:59:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Jun
 2025 10:59:32 +0200
Date: Wed, 25 Jun 2025 09:59:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] perf/cxlpmu: Fix devm_kcalloc() argument order
 in cxl_pmu_probe()
Message-ID: <20250625095930.00004f6f@huawei.com>
In-Reply-To: <20250624194350.109790-2-alok.a.tiwari@oracle.com>
References: <20250624194350.109790-1-alok.a.tiwari@oracle.com>
	<20250624194350.109790-2-alok.a.tiwari@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 12:43:38 -0700
Alok Tiwari <alok.a.tiwari@oracle.com> wrote:

> The previous code mistakenly swapped the count and size parameters.
> This fix corrects the argument order in devm_kcalloc() to follow the
> conventional count, size form, avoiding potential confusion or bugs.
> 
> Previous usage:
>   devm_kcalloc(dev, sizeof(*info->hw_events), info->num_counters,
>    GFP_KERNEL);
> 
> New usage:
>   devm_kcalloc(dev, info->num_counters, sizeof(*info->hw_events),
>    GFP_KERNEL);

Too much detail! The sentence above would have been enough given
we have the code change to see how it applied.
> 
> Previous incorrect order could lead to unexpected memory allocation
> behavior. This fix ensures correct allocation of hw_event structure.

It doesn't actually make any real difference.  Look at the implementation
of devm_kmalloc_array()  What it does is make it harder to reason about the
code and for that it is worth fixing up.

Anyhow none of that really matters.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/perf/cxl_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index d6693519eaee2..8998c0a2f3a2d 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -834,8 +834,8 @@ static int cxl_pmu_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> -	info->hw_events = devm_kcalloc(dev, sizeof(*info->hw_events),
> -				       info->num_counters, GFP_KERNEL);
> +	info->hw_events = devm_kcalloc(dev, info->num_counters,
> +				       sizeof(*info->hw_events), GFP_KERNEL);
>  	if (!info->hw_events)
>  		return -ENOMEM;
>  

