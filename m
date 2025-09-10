Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C8D33EAF0;
	Wed, 10 Sep 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521761; cv=none; b=Hp8PpT/04XuVb01dmq4CMyBT3rQyNAgnvXM42le985+E8xFOUyiDecm7bMGQk1h337COOe9GgA8cg81kCa8gBoFCjx3zxBIAlvJeKzFT1/gfSBUs+W/rg/3WGwC69ZC5QSl90TL4eqcM3FdLLqW1NwXKXFOXpWY7ptkFncTEBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521761; c=relaxed/simple;
	bh=8++QKQRO5BGsyiOoSkOCHVQe6ebaLk8EnvGnuin5O2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7s4jBGG1ihInDgeSZzI0Telxh+dwmHBV1D5IXD+M74xblfRMcmfKpgCTkntwKDdvj1sKmyJ2vPIEiXaAoyoFOXQ+C3rVRP8WEazJruJJVRfvvAy+kDOMjjrzgd8VWEjZd4gTVKUFl3ulGoNWfhueHUcaYFGVjxGJ+vvBY6Ofq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E74A716F2;
	Wed, 10 Sep 2025 09:29:08 -0700 (PDT)
Received: from [10.57.5.181] (unknown [10.57.5.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E74773F63F;
	Wed, 10 Sep 2025 09:29:14 -0700 (PDT)
Message-ID: <ffa7968f-15da-4f59-aba5-43619d3f27d3@arm.com>
Date: Wed, 10 Sep 2025 17:29:14 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] coresight: Use of_cpu_phandle_to_id for grabbing
 CPU ID
Content-Language: en-GB
To: Alireza Sanaee <alireza.sanaee@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org, dianders@chromium.org,
 james.clark@linaro.org, jonathan.cameron@huawei.com, krzk@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linuxarm@huawei.com, mark.rutland@arm.com, mike.leach@linaro.org,
 robh@kernel.org, ruanjinjie@huawei.com, saravanak@google.com
References: <20250905161830.37-1-alireza.sanaee@huawei.com>
 <20250905161830.37-6-alireza.sanaee@huawei.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250905161830.37-6-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/09/2025 17:18, Alireza Sanaee wrote:
> Use the newly created API (of_cpu_phandle_to_id) to grab CPU ID.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>   drivers/hwtracing/coresight/coresight-platform.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 0db64c5f4995..95d46ea08936 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -167,20 +167,7 @@ of_coresight_get_output_ports_node(const struct device_node *node)
>   
>   static int of_coresight_get_cpu(struct device *dev)
>   {
> -	int cpu;
> -	struct device_node *dn;
> -
> -	if (!dev->of_node)
> -		return -ENODEV;
> -
> -	dn = of_parse_phandle(dev->of_node, "cpu", 0);
> -	if (!dn)
> -		return -ENODEV;
> -
> -	cpu = of_cpu_node_to_id(dn);
> -	of_node_put(dn);
> -
> -	return cpu;
> +	return of_cpu_phandle_to_id(dev->of_node, NULL, 0);
>   }
>   
>   /*

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

