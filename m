Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A6A398FB6;
	Thu,  4 Dec 2025 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764851115; cv=none; b=Zc61lvr3bxJH53P9mcUcRJXsk6CDZfcYdKlcHnCpKkRmy9A2/77ih8Jlsam3VSNrqfnCtwpdldkcRsY9dTmpLy+vFoZjyQ58sauS5bZFhfrMNpGAHe6gEAnuBHgWE0Kn+tf2exk2YYZkJ/zaUJn+x4wwT+DW4qc2HkeRetI5fMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764851115; c=relaxed/simple;
	bh=/332OnwBU3AoRjqy7aPV+3dy4pZZpMiGY+vlyUKDtyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAWELujYgpQLQ3QovWkwEIHAhxAd9LbmTH6FxIhlFwMXehgwyIGwKeDVebvhrLC9mXh1vnKe908t9rwgAQbVhi1UocDKkyY/kRVTIVso9NdlHnwoILAfPp8MuHfKUlIm4Mj2PjhXAfgXan/i30MjdH2v+pVGbQp72HOXulOwOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B108339;
	Thu,  4 Dec 2025 04:25:05 -0800 (PST)
Received: from [10.163.49.196] (unknown [10.163.49.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FD283F73B;
	Thu,  4 Dec 2025 04:25:06 -0800 (PST)
Message-ID: <26841df4-04d5-45d6-b589-e6061db2ad33@arm.com>
Date: Thu, 4 Dec 2025 17:55:03 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] coresight: trbe: Remove redundant disable operation
To: Leo Yan <leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-2-7da32b076b28@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-2-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/12/25 4:51 PM, Leo Yan wrote:
> The trace unit is already disabled when trbe_stop_and_truncate_event()
> is called, so draining and stopping the buffer in the function is
> redundant.
> 
> Remove the unnecessary disable operation and rename the function to
> trbe_truncate_event() to better reflect its purpose.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 0ddb3db0213cf0014e29decfb79da68b0a351b31..2f44e4a65e0ee2b2c8fdd06a51ab01fc57f44a4e 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -284,18 +284,10 @@ static void trbe_report_wrap_event(struct perf_output_handle *handle)
>  	perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
>  }
>  
> -static void trbe_stop_and_truncate_event(struct perf_output_handle *handle)
> +static void trbe_truncate_event(struct perf_output_handle *handle)
>  {
>  	struct trbe_buf *buf = etm_perf_sink_config(handle);
>  
> -	/*
> -	 * We cannot proceed with the buffer collection and we
> -	 * do not have any data for the current session. The
> -	 * etm_perf driver expects to close out the aux_buffer
> -	 * at event_stop(). So disable the TRBE here and leave
> -	 * the update_buffer() to return a 0 size.
> -	 */
> -	trbe_drain_and_disable_local(buf->cpudata);
>  	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>  	perf_aux_output_end(handle, 0);
>  	*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
> @@ -1008,7 +1000,7 @@ static int __arm_trbe_enable(struct trbe_buf *buf,
>  	trbe_enable_hw(buf);
>  	return 0;
>  err:
> -	trbe_stop_and_truncate_event(handle);
> +	trbe_truncate_event(handle);
>  	return ret;
>  }
>  
> @@ -1169,7 +1161,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>  		trbe_handle_spurious(handle);
>  		break;
>  	case TRBE_FAULT_ACT_FATAL:
> -		trbe_stop_and_truncate_event(handle);
> +		trbe_truncate_event(handle);
>  		truncated = true;
>  		break;
>  	}
> 

In arm_trbe_irq_handler() function trbe_drain_and_disable_local() is
called early on before TRBE_FAULT_ACT_FATAL gets handled but for the
other case __arm_trbe_enable() - do all the code paths leading upto
present trbe_stop_and_truncate_event() would have definitely called
trbe_drain_and_disable_local() as well ? If yes, please do call out
those code paths clearly in the commit message.

Besides it might be worth adding an WARN_ON() in trbe_truncate_event()
if the TRBE has not been disabled as now being expected there.
