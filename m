Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844362D4B55;
	Tue, 24 Jun 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775810; cv=none; b=WuKcWsl0/45TsHvfj1b8j0dJGHUG3vBCz2nYdAfetPcyz3U2GKhK/+tA3+8qOqqPN66QufBR4XbajBoi7hXBumaHp7LeRHoXTlKCFzJsoq59pUK7Il/hxQL+oNF/HuiYy5J0P3CA/xp6qW6EusenJXCaDlNTCUEBG9XNBNSUZOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775810; c=relaxed/simple;
	bh=F1HaTKznDSbNVS9L0eecuOL+TvQ5pAd0p7rkrKv3EeA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXJ/iMWg2sEJqCCBTeJvkPkXFMi/Ie3flqOIjCUZwz9i6YtSfQnWxoV3CgCREvbDVOiVVXHURluAfyRTOYYenkT7OQhbq7bMkvuzkyKe1yWvQZPoOXFgCkguSOJN2IFFgQazUDWFM/oYwPuVgguk1e0KFDXwSiv6kF2YGhRcAMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRSDd5wsJz6GFCQ;
	Tue, 24 Jun 2025 22:36:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 227691400CA;
	Tue, 24 Jun 2025 22:36:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Jun
 2025 16:36:45 +0200
Date: Tue, 24 Jun 2025 15:36:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf/cxlpmu: Fix allocation argument order and minor
 formatting issues
Message-ID: <20250624153644.0000084f@huawei.com>
In-Reply-To: <20250623184415.42751-1-alok.a.tiwari@oracle.com>
References: <20250623184415.42751-1-alok.a.tiwari@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 23 Jun 2025 11:44:11 -0700
Alok Tiwari <alok.a.tiwari@oracle.com> wrote:

> Correct the argument order in devm_kcalloc() to follow the conventional
> count, size form to avoid any confusion or bugs.
> Also fix a formatting issue in the devm_kasprintf() call by removing a
> stray newline and fix a duplicated word in a comment.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Hi Alok,

This is a bit of an 'and' patch which usually means it should
be split up.  The devm_kcalloc() is a fix (sort of anyway)
which the others changes aren't.

All the actual changes are good, I'd just prefer this as a little series
of patches that do one thing each.  The first being the devm_kcalloc()
parameter ordering.

Thanks,

Jonathan



> ---
>  drivers/perf/cxl_pmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index d6693519eaee2..fb0b29f149807 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -113,7 +113,7 @@ struct cxl_pmu_info {
>  
>  /*
>   * All CPMU counters are discoverable via the Event Capabilities Registers.
> - * Each Event Capability register contains a a VID / GroupID.
> + * Each Event Capability register contains a VID / GroupID.
>   * A counter may then count any combination (by summing) of events in
>   * that group which are in the Supported Events Bitmask.
>   * However, there are some complexities to the scheme.
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
> @@ -873,7 +873,7 @@ static int cxl_pmu_probe(struct device *dev)
>  		return rc;
>  	irq = rc;
>  
> -	irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_overflow\n", dev_name);
> +	irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_overflow", dev_name);
>  	if (!irq_name)
>  		return -ENOMEM;
>  

