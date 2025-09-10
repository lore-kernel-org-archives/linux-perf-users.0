Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE37334720;
	Wed, 10 Sep 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521800; cv=none; b=Mf5402+KarNWW67lvap8YYoNc4DNWcWyyTVY4OC2QfVrmUULvjG/OCWuc0Gmk1BpfaIWuF+4kAKZ9uHKa1LJz/uFAe2GP+w0Hj//3uEHlPaM7pxA2a63gzsDi10SZZZwmzNNxKRFU5q8MYNWguka+Ym4i8jUYDqiwP/gBDSCbr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521800; c=relaxed/simple;
	bh=G+3Hqb6r+jcjnpPnT84mRECnpBIh44RzOZQD9R2LhtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuKKEka7m2ukdixv72AjGwCa1LZxrCYWIOjjKMQueMzV+Ot6NPV75k4k2K0WuXCJMF1bRdeXHbWUShbJroR6TeanDW8CvXhxu1aF1vJP1pY8kl/q2PIXK83WyyGlvwwWARMLJ/0Ys4EZFmv6/CyVF8PL+DHMP2VfVy3cKsFkfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E63716F2;
	Wed, 10 Sep 2025 09:29:50 -0700 (PDT)
Received: from [10.57.5.181] (unknown [10.57.5.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 43A673F63F;
	Wed, 10 Sep 2025 09:29:56 -0700 (PDT)
Message-ID: <0c675681-e15f-4b94-b567-6545ac4cfa06@arm.com>
Date: Wed, 10 Sep 2025 17:29:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] perf/arm-dsu: refactor cpu id retrieval via new
 API of_cpu_phandle_to_id
Content-Language: en-GB
To: Alireza Sanaee <alireza.sanaee@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org, dianders@chromium.org,
 james.clark@linaro.org, jonathan.cameron@huawei.com, krzk@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linuxarm@huawei.com, mark.rutland@arm.com, mike.leach@linaro.org,
 robh@kernel.org, ruanjinjie@huawei.com, saravanak@google.com
References: <20250905161830.37-1-alireza.sanaee@huawei.com>
 <20250905161830.37-7-alireza.sanaee@huawei.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250905161830.37-7-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/09/2025 17:18, Alireza Sanaee wrote:
> Update arm-dsu to use the new API (of_cpu_phandle_to_id).
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>   drivers/perf/arm_dsu_pmu.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> index cb4fb59fe04b..8f76bd94349c 100644
> --- a/drivers/perf/arm_dsu_pmu.c
> +++ b/drivers/perf/arm_dsu_pmu.c
> @@ -591,17 +591,12 @@ static struct dsu_pmu *dsu_pmu_alloc(struct platform_device *pdev)
>   static int dsu_pmu_dt_get_cpus(struct device *dev, cpumask_t *mask)
>   {
>   	int i = 0, n, cpu;
> -	struct device_node *cpu_node;
>   
>   	n = of_count_phandle_with_args(dev->of_node, "cpus", NULL);
>   	if (n <= 0)
>   		return -ENODEV;
>   	for (; i < n; i++) {
> -		cpu_node = of_parse_phandle(dev->of_node, "cpus", i);
> -		if (!cpu_node)
> -			break;
> -		cpu = of_cpu_node_to_id(cpu_node);
> -		of_node_put(cpu_node);
> +		cpu = of_cpu_phandle_to_id(dev->of_node, NULL, i);
>   		/*
>   		 * We have to ignore the failures here and continue scanning
>   		 * the list to handle cases where the nr_cpus could be capped

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
