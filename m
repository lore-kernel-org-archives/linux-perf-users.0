Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABD930FC12;
	Tue,  2 Dec 2025 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676822; cv=none; b=JxohEFoET1+NRYTViP8A8NPAw+attG/cGy5GXLCq7rAtrXwup6OCjZA4w5OOCOK7fUHy0+EVzx9wg1HwR+fIQtW9l41HM+ZcT1EkH+o79CvWSLlRLgJ48S3nUaaXsNciUzk0AkC8nyjZpzkQhGgzy1gLuhMFr3PgCnLzS5+x0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676822; c=relaxed/simple;
	bh=qnbgHoX7q845SE3oV7zwM1m0h+S7KaWQi9i+BujRzMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l85UHZk3I+nUruXxuBvsP4Rtsee+8GQdmKrdE6U0rIxslB2del5IOQll5jinQKyFFVSP5p3S9pCfJW40zEKOqq1VWBqo0aLF366orH0ybhlpCCASN0KzeyJTSDMlKtPSdEpk/A3xyw6KQsDyURh4YoRwvs4Wggj9bYG4DOcH/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C2D6153B;
	Tue,  2 Dec 2025 04:00:11 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C13823F73B;
	Tue,  2 Dec 2025 04:00:16 -0800 (PST)
Message-ID: <be0b9b11-19d6-4d8c-910c-17773a4a2df0@arm.com>
Date: Tue, 2 Dec 2025 12:00:15 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/19] coresight: trbe: Always check fault action when
 updating buffer
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
 <20251201-trbe_buffer_refactor_v1-1-v1-10-7da32b076b28@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-10-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/12/2025 11:22, Leo Yan wrote:
> The current code checks the fault action only via the IRQ status bit,
> which is unreliable due to possible hardware latency.
> 
> Move the fault action check out of the IRQ status condition.  This also
> causes the buffer size to be calculated for non-WRAP and fault cases,
> which is fine since the write pointer is trusted for the calculation.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index f56ecdeaa6596afb440e4d53732e08a85f9bf89d..e579ea98523c24d23a0cd265dcdd0a46b52b52da 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -806,7 +806,6 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>   	enum trbe_fault_action act;
>   	unsigned long size, status;
>   	unsigned long flags;
> -	bool wrap = false;
>   
>   	WARN_ON(buf->cpudata != cpudata);
>   	WARN_ON(cpudata->cpu != smp_processor_id());
> @@ -858,21 +857,11 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>   		 */
>   		clr_trbe_irq();
>   		isb();
> -
> -		act = trbe_get_fault_act(handle, status);
> -		/*
> -		 * If this was not due to a WRAP event, we have some
> -		 * errors and as such buffer is empty.
> -		 */
> -		if (act != TRBE_FAULT_ACT_WRAP) {
> -			size = 0;
> -			goto done;
> -		}
> -
> -		wrap = true;
>   	}
>   
> -	size = trbe_get_trace_size(handle, buf, wrap);
> +	act = trbe_get_fault_act(handle, status);

Also act is valid only when there is an IRQ ?

> +
> +	size = trbe_get_trace_size(handle, buf, act == TRBE_FAULT_ACT_WRAP);

We have certain assumptions in trbe_get_trace_size(), which may be
broken with this change.

e.g., if we get a fatal error, we don't detect that the buffer is empty
and may trigger a WARN_ON() on systems with CPU erratum as below ?

>         /*                                                                      
>          * If the TRBE is affected by the following erratum, we must fill           
>          * the space we skipped with IGNORE packets. And we are always          
>          * guaranteed to have at least a PAGE_SIZE space in the buffer.         
>          */                                                                     
>         if (trbe_has_erratum(buf->cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE) &&
>             !WARN_ON(size < overwrite_skip))                                    
>                 __trbe_pad_buf(buf, start_off, overwrite_skip); 



Suzuki


>   
>   done:
>   	local_irq_restore(flags);
> 

