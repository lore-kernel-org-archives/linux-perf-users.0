Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB13D23AB95;
	Tue,  2 Dec 2025 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764677428; cv=none; b=lC1Ccupw/rr+rgsTSpgZJE2vrjZk1N8/xivMjowfMgmaY9ukegNqVo2wqf4Cx/H6EOc1undo5n2zLi2kvAKyONlkypHM+th+QzHNF+sBUfSZKxdfmskDbQxe/EffhutSKjoHtjjs8gpDhQtjYa8EB/0LZWBnwh7gLGXbIzMGgtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764677428; c=relaxed/simple;
	bh=Qjr0/vs9CbyXuF11tWaTWk8pvjRPEfUCMz2A0yd9owM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQNwhi81ClRgi2kzE2wrWBg2GO3EWVZPBF/n8jETNmc3+WWytdbcpaHQSLSrlZ6NJTzUGx+gFHOcP2oyGt+o8tw40PUZSr/+g2ey5t98W2l8xR11ub3XRdWIffFqAAzlku+D8SURpn9POHGpWTrIgU4lz9BfuFqFXxPF/ARO+bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3456153B;
	Tue,  2 Dec 2025 04:10:18 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BD723F73B;
	Tue,  2 Dec 2025 04:10:23 -0800 (PST)
Message-ID: <47da45df-b75f-46e8-9839-97d869b43afc@arm.com>
Date: Tue, 2 Dec 2025 12:10:22 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] coresight: trbe: Add static key for bypassing
 trigger mode
To: Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-15-7da32b076b28@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-15-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/12/2025 11:22, Leo Yan wrote:
> To avoid complexity, if any CPU in the system has the fill mode erratum,
> the driver will not use trigger mode, it simply rolls back to fill mode
> only and apply the workaround on it.
> 
> Add a static key to control trigger mode bypassing.  During each CPU
> probe, the key is enabled when the relevant erratum is detected.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 941aa46e9b11f60c707eb40093964de454a3fd83..8390d0a8fe23d35945610df15f21751279ee37ee 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -17,6 +17,7 @@
>   
>   #include <asm/barrier.h>
>   #include <asm/cpufeature.h>
> +#include <linux/jump_label.h>
>   #include <linux/kvm_host.h>
>   #include <linux/vmalloc.h>
>   
> @@ -147,6 +148,12 @@ struct trbe_drvdata {
>   	struct platform_device *pdev;
>   };
>   
> +DEFINE_STATIC_KEY_FALSE(trbe_trigger_mode_bypass);
> +
> +#define trbe_trigger_mode_need_bypass(cpudata)		\
> +	(trbe_may_overwrite_in_fill_mode((cpudata)) ||	\
> +	 trbe_may_write_out_of_range((cpudata)))
> +

Please make that a static inline function.

>   static void trbe_check_errata(struct trbe_cpudata *cpudata)
>   {
>   	int i;
> @@ -1306,6 +1313,14 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
>   
>   	dev_set_drvdata(&trbe_csdev->dev, cpudata);
>   	coresight_set_percpu_sink(cpu, trbe_csdev);
> +
> +	/*
> +	 * If any CPU cannot use trigger mode, bypass the mode globally for
> +	 * consistent tracing behaviour.
> +	 */
> +	if (trbe_trigger_mode_need_bypass(cpudata))
> +		static_branch_enable(&trbe_trigger_mode_bypass);

You only need to enable this once, not for every CPU.

Suzuki


> +
>   	return;
>   cpu_clear:
>   	cpumask_clear_cpu(cpu, &drvdata->supported_cpus);
> 

