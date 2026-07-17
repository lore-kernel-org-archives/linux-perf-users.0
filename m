Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3281223702;
	Fri, 17 Jul 2026 01:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784251890; cv=none; b=AG9Mj5ReGjFLen4P6BMGTu6JxnqlapQUQThKQ9vcu+NGl+hO8GZ1lbZ1wJwr2g4tn1uMl2knygE96irymGrVNSlUgtZ1C6aMSTSgLSIomySG4LHyQ6ch/XmmQ8k5HSL64WJpyIFqKrSZi5xFxO06ra6trs+2iC+BfS1yuzhiucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784251890; c=relaxed/simple;
	bh=UIxwAAmoVsZn5Fbr8KWBRp4W6eJ2HPpBihHrGJFMfCg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hDkFbEnnLljqnXpQHwdKTnDHp8YpEHf0BPFtCPxpxbiVsbjDcZbRiQDd+Q+2YUJyBsd4MUBueJ6NRlZugKttlwnWN98f5gOUTw+iB2KaDIU8SX7ZoE8Z3q0VlhUp5Le+kB6+KDPArD+Udohwirsa4rUsjBgQDzqp5HwGDactlOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LV+k9OLp; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LV+k9OLp"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2Uble4eKSJ85c3t6x1O5pOpNQXmBoa/HjvVuLqjsAGw=;
	b=LV+k9OLpQRwIJszukFxoni9lA8wRHWzF3x34dv6pDh+/+Yd7Fw8xamvZN2xb/8Hr2dzcIjn1G
	Y4QO6lmRLEUhGHjLnn3V0F22aCbQJXVZwRhohKbB+9OqR+GOFboQq86zMZCfRY0ZKjsmk/9OA4D
	seNVJGRI4yBgHJY6p3tbcKY=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h1XF71wtkznTts;
	Fri, 17 Jul 2026 09:21:47 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B2D54057C;
	Fri, 17 Jul 2026 09:31:21 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jul 2026 09:31:20 +0800
Subject: Re: [PATCH v2 1/4] ACPI/APMT: Use stable device ID
To: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>,
	<mark.rutland@arm.com>, <catalin.marinas@arm.com>
CC: <ilkka@os.amperecomputing.com>, <bwicaksono@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>
References: <cover.1784213435.git.robin.murphy@arm.com>
 <f7eb9a4cfea4cd6f8d87f3c2501438d484807d27.1784213435.git.robin.murphy@arm.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <330cb52a-2277-81c5-10ba-9e049e5562e5@huawei.com>
Date: Fri, 17 Jul 2026 09:31:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7eb9a4cfea4cd6f8d87f3c2501438d484807d27.1784213435.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/7/16 22:56, Robin Murphy wrote:
> The APMT node format includes a unique identifier, so we can use this as
> the platform device ID to give userspace stable and identifiable device
> names, rather than auto numbering dependent on how the table is parsed.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@kernel.org>
> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> v2: Handle and warn about unexpected signed overflow
> ---
>   drivers/acpi/arm64/apmt.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
> index bb010f6164e5..91fcdd289e63 100644
> --- a/drivers/acpi/arm64/apmt.c
> +++ b/drivers/acpi/arm64/apmt.c
> @@ -76,10 +76,12 @@ static int __init apmt_add_platform_device(struct acpi_apmt_node *node,
>   					   struct fwnode_handle *fwnode)
>   {
>   	struct platform_device *pdev;
> -	int ret, count;
> +	int ret, count, uid = node->id & INT_MAX;
>   	struct resource res[DEV_MAX_RESOURCE_COUNT];
>   
> -	pdev = platform_device_alloc(DEV_NAME, PLATFORM_DEVID_AUTO);
> +	if (uid != node->id)
> +		pr_warn("Unexpectedly large UID 0x%x, truncated to 0x%x\n", node->id, uid);
> +	pdev = platform_device_alloc(DEV_NAME, uid);
>   	if (!pdev)
>   		return -ENOMEM;

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

