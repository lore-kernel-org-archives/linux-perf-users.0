Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D120B1F5;
	Wed, 25 Jun 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842256; cv=none; b=j1U0RU+wN5/lcFFa7Bbis5ePIebhjWFGWmnnxfJLKKpNIf2B52TqlDqwxvpsJQF/OOnI7Ngmy+0SB0OTu4XyL8sgFNpEja9zudBJWsBcsemw3dqpqUEqEZWp1b8Idah+14eEQbmxfNngD8VJbLF2lTK9nVjfq7SB4KgMtjdPPn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842256; c=relaxed/simple;
	bh=pA6AN/QOJCqYiTeXqHuNyLe6FnEevkEXQQfKn57rhd8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9r3utWZsLDRcUiQ2FtkX2bh31EMc8yDaqsisvfSgm249KKvA9jvRKQTrIF06f8fCqOdm+PA1yiNKZG6E05vp2cA0TbeQqfJQOj6R3MnhbLSyZnwY0CULYVuQyyt0YWSX3GSjm+tZamfgozBLLMzFHI127nJwza754+r/+6V9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRwqF6dPRz6DKpF;
	Wed, 25 Jun 2025 17:04:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A0DC11404C5;
	Wed, 25 Jun 2025 17:04:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Jun
 2025 11:04:12 +0200
Date: Wed, 25 Jun 2025 10:04:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] perf/cxlpmu: Remove unintended newline from IRQ
 name format string
Message-ID: <20250625100410.000055a3@huawei.com>
In-Reply-To: <20250624194350.109790-3-alok.a.tiwari@oracle.com>
References: <20250624194350.109790-1-alok.a.tiwari@oracle.com>
	<20250624194350.109790-3-alok.a.tiwari@oracle.com>
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

On Tue, 24 Jun 2025 12:43:39 -0700
Alok Tiwari <alok.a.tiwari@oracle.com> wrote:

> The IRQ name format string used in devm_kasprintf() mistakenly included
> a newline character "\n".
> This could lead to confusing log output or misformatted names in sysfs
> or debug messages.
> 
> This fix removes the newline to ensure proper IRQ naming.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/perf/cxl_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 8998c0a2f3a2d..5a475a5a1f095 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -873,7 +873,7 @@ static int cxl_pmu_probe(struct device *dev)
>  		return rc;
>  	irq = rc;
>  
> -	irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_overflow\n", dev_name);
> +	irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_overflow", dev_name);
>  	if (!irq_name)
>  		return -ENOMEM;
>  

