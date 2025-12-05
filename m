Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192A929E114;
	Fri,  5 Dec 2025 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764907845; cv=none; b=tf4i4OUSTefncHYQaNonw/SVCtWr+d5Mr0ilU9n8GJuehrKnKtFrs+EGyU8OX03vmDF1gtUR/MGuNxBm53kcnkGtRoyuu55U3AswEzeyrktR5SaEuXJTFFXnieitop6WIh+XtRKWYIF//MdxcLdiKmcHC4M7tla6la5i5wiQKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764907845; c=relaxed/simple;
	bh=WDF95vTuws43VAxfueBfcDSoFWlOX3Aj0E1GG87bGG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALhx/IoWVYWRP6oUvIypRxZRHPFIfCNZKZ2q21q57AQ4wEh8RpFGGlh/vazb9mePKU43FYdABRqiLfH/PstBIUdJrBVY6ZQmqpjw/oOb7juNjF/XV3f4Im093gpoLOhhZRvOfsgPbRulEA+M2umGpqPE1zQ7rEodJ0QQwzF+pFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A61F7339;
	Thu,  4 Dec 2025 20:10:34 -0800 (PST)
Received: from [10.163.52.42] (unknown [10.163.52.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C7D03F86F;
	Thu,  4 Dec 2025 20:10:36 -0800 (PST)
Message-ID: <ae63c69c-eff9-4665-a9a6-d395e61bea86@arm.com>
Date: Fri, 5 Dec 2025 09:40:33 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] coresight: trbe: Refactor syndrome decoding
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
 <20251201-trbe_buffer_refactor_v1-1-v1-6-7da32b076b28@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-6-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/12/25 4:51 PM, Leo Yan wrote:
> It gives priority to TRBSR_EL1.EA (external abort); an external abort
> will immediately bail out and return an error.

This is an abrupt starting for a commit message without giving context.
The rationale for the change needs to be explained rather than details
of implementation.

> 
> Next, the syndrome decoding is refactored based on two levels of
> information: the EC (Event Class) bits and the BSC (Trace Buffer Status
> Code) bits.
> 
> If TRBSR_EL1.EC==0b000000, the driver continues parsing TRBSR_EL1.BSC to
> identify the specific trace buffer event.  Otherwise, any non-zero
> TRBSR_EL1.EC is treated as an error.
> 
> For error cases, the driver prints an error string and dumps registers
> for debugging.
> 
> No additional checks are required for wrap mode beyond verifying the
> TRBSR_EL1.WRAP bit, even on units with overwrite errata, as this bit
> reliably indicates a buffer wrap.

Should the errata related changes be done in a separate patch instead ?

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 60 +++++++++++++++++++++-------
>  drivers/hwtracing/coresight/coresight-trbe.h |  8 ++--
>  2 files changed, 51 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 9e565122816949b37b8ff5e4ba04cfbc317c6f25..28e2bfa68074f19ccaa4a737d00af577aea818fe 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -643,29 +643,61 @@ static void trbe_enable_hw(struct trbe_buf *buf)
>  static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *handle,
>  						 u64 trbsr)
>  {
> +	const char *err_str;
>  	int ec = get_trbe_ec(trbsr);
>  	int bsc = get_trbe_bsc(trbsr);
> -	struct trbe_buf *buf = etm_perf_sink_config(handle);
> -	struct trbe_cpudata *cpudata = buf->cpudata;
>  
>  	WARN_ON(is_trbe_running(trbsr));
> -	if (is_trbe_trg(trbsr) || is_trbe_abort(trbsr))
> -		return TRBE_FAULT_ACT_FATAL;
>  
> -	if ((ec == TRBE_EC_STAGE1_ABORT) || (ec == TRBE_EC_STAGE2_ABORT))
> -		return TRBE_FAULT_ACT_FATAL;
> +	if (is_trbe_abort(trbsr)) {
> +		err_str = "External abort";
> +		goto out_fatal;
> +	}
>  
> -	/*
> -	 * If the trbe is affected by TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
> -	 * it might write data after a WRAP event in the fill mode.
> -	 * Thus the check TRBPTR == TRBBASER will not be honored.
> -	 */
> -	if ((is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED)) &&
> -	    (trbe_may_overwrite_in_fill_mode(cpudata) ||
> -	     get_trbe_write_pointer() == get_trbe_base_pointer()))
> +	switch (ec) {
> +	case TRBE_EC_OTHERS:
> +		break;

No message for this ?

> +	case TRBE_EC_BUF_MGMT_IMPL:
> +		err_str = "Unexpected implemented management";
> +		goto out_fatal;
> +	case TRBE_EC_GP_CHECK_FAULT:
> +		err_str = "Granule Protection Check fault";
> +		goto out_fatal;
> +	case TRBE_EC_STAGE1_ABORT:
> +		err_str = "Stage 1 data abort";
> +		goto out_fatal;
> +	case TRBE_EC_STAGE2_ABORT:
> +		err_str = "Stage 2 data abort";
> +		goto out_fatal;
> +	default:
> +		err_str = "Unknown error code";
> +		goto out_fatal;
> +	}
> +
> +	switch (bsc) {
> +	case TRBE_BSC_NOT_STOPPED:
> +		break;
> +	case TRBE_BSC_FILLED:
> +		break;
> +	case TRBE_BSC_TRIGGERED:
> +		err_str = "Unexpected trigger status";
> +		goto out_fatal;
> +	default:
> +		err_str = "Unexpected buffer status code";
> +		goto out_fatal;
> +	}

Just wondering if it would be cleaner to add a const char * based
static array mapping these EC/BSC codes with above error messages.
 
> +
> +	if (is_trbe_wrap(trbsr))

But what about TRBE affected with trbe_may_overwrite_in_fill_mode()
is that still being taken care of some how ?

>  		return TRBE_FAULT_ACT_WRAP;
>  
>  	return TRBE_FAULT_ACT_SPURIOUS;
> +
> +out_fatal:
> +	pr_err_ratelimited("%s on CPU %d [TRBSR=0x%016llx, TRBPTR=0x%016llx, TRBLIMITR=0x%016llx]\n",
> +			   err_str, smp_processor_id(), trbsr,
> +			   read_sysreg_s(SYS_TRBPTR_EL1),
> +			   read_sysreg_s(SYS_TRBLIMITR_EL1));

Right - comprehensive TRBE configuration register dump when a fatal
error happens.

> +	return TRBE_FAULT_ACT_FATAL;
>  }
>  
>  static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
> index 45202c48accec7c86ba56130e2737bc2d1830fae..d7f7cd763c0c7139cf322b7336ee563073e3bea0 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.h
> +++ b/drivers/hwtracing/coresight/coresight-trbe.h
> @@ -35,9 +35,11 @@ static inline bool is_trbe_enabled(void)
>  	return trblimitr & TRBLIMITR_EL1_E;
>  }
>  
> -#define TRBE_EC_OTHERS		0
> -#define TRBE_EC_STAGE1_ABORT	36
> -#define TRBE_EC_STAGE2_ABORT	37
> +#define TRBE_EC_OTHERS			0x0
> +#define TRBE_EC_GP_CHECK_FAULT		0X1e
> +#define TRBE_EC_BUF_MGMT_IMPL		0x1f
> +#define TRBE_EC_STAGE1_ABORT		0x24
> +#define TRBE_EC_STAGE2_ABORT		0x25

Please do mention the document source for these new EC codes in the
commit message.

>  
>  static inline int get_trbe_ec(u64 trbsr)
>  {
> 

