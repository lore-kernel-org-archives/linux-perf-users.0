Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2026230BCC;
	Tue,  2 Dec 2025 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764674153; cv=none; b=WInLUlf42pYS9Q0zUJq/I+YjxCdHPcY/LEAfUKcXOqAItEPNBnq6sat0d5RJGA5iW+hT0wVAiVm/hhVkXKs4c6w58Ir5szn1B6JE/mZK+/LlEytsi0S+Uoa9+AjRlBmwiTI0vV5aOItEdinxN6hNeZp6iXnoQ3fsnSUPk2pT8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764674153; c=relaxed/simple;
	bh=WSEJzl1j2tTTgzwThrIiKa9lLp0ynX/suh89k99F5HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6qgx2pj7DR0oLiRog4ONsu4Kr1skp13fhBVtCnQWF6uYkV/E//5uXr+jLltwePFcngBIyF6iWcRUvpEjPqPvzW/WEmjwMQgXVlivtnZRgWb8zcy712CGdtamaXKKbfgvZ6Z7ILjZ+Qvufl3VmtgF+iH/sB2cItBzzZ7TqUN6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF76E153B;
	Tue,  2 Dec 2025 03:15:43 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DD7F3F59E;
	Tue,  2 Dec 2025 03:15:48 -0800 (PST)
Message-ID: <e315b489-2ebf-4ab6-8a60-347f1b1dca16@arm.com>
Date: Tue, 2 Dec 2025 11:15:47 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/19] coresight: trbe: Refactor AUX flag setting
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
 <20251201-trbe_buffer_refactor_v1-1-v1-7-7da32b076b28@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-7-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/12/2025 11:21, Leo Yan wrote:
> Rather than spreading AUX flag setting in different functions, use
> trbe_get_fault_act() as a central place for setting the flag.
> 
> Later we will support WRAP mode with continuous trace, so the WRAP
> event does not necessarily cause the trace discontinuity, change to
> check the stop status instead.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 38 +++++++++++++---------------
>   1 file changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 28e2bfa68074f19ccaa4a737d00af577aea818fe..b06885a08e082fd34f68d9588518807b5c47c86e 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -265,25 +265,6 @@ static void trbe_reset_local(struct trbe_cpudata *cpudata)
>   	write_sysreg_s(0, SYS_TRBSR_EL1);
>   }
>   
> -static void trbe_report_wrap_event(struct perf_output_handle *handle)
> -{
> -	/*
> -	 * Mark the buffer to indicate that there was a WRAP event by
> -	 * setting the COLLISION flag. This indicates to the user that
> -	 * the TRBE trace collection was stopped without stopping the
> -	 * ETE and thus there might be some amount of trace that was
> -	 * lost between the time the WRAP was detected and the IRQ
> -	 * was consumed by the CPU.
> -	 *
> -	 * Setting the TRUNCATED flag would move the event to STOPPED
> -	 * state unnecessarily, even when there is space left in the
> -	 * ring buffer. Using the COLLISION flag doesn't have this side
> -	 * effect. We only set TRUNCATED flag when there is no space
> -	 * left in the ring buffer.
> -	 */
> -	perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
> -}
> -
>   static void trbe_truncate_event(struct perf_output_handle *handle)
>   {
>   	struct trbe_buf *buf = etm_perf_sink_config(handle);
> @@ -687,6 +668,23 @@ static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *hand
>   		goto out_fatal;
>   	}
>   
> +	/*
> +	 * Mark the buffer to indicate that there was a WRAP event by
> +	 * setting the COLLISION flag. This indicates to the user that
> +	 * the TRBE trace collection was stopped without stopping the
> +	 * ETE and thus there might be some amount of trace that was
> +	 * lost between the time the WRAP was detected and the IRQ
> +	 * was consumed by the CPU.
> +	 *
> +	 * Setting the TRUNCATED flag would move the event to STOPPED
> +	 * state unnecessarily, even when there is space left in the
> +	 * ring buffer. Using the COLLISION flag doesn't have this side
> +	 * effect. We only set TRUNCATED flag when there is no space
> +	 * left in the ring buffer.
> +	 */
> +	if (!is_trbe_running(trbsr))

Is this really required ? There is a WARN_ON(is_trbe_running(trbsr))
above ?

> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);

Also, setting this would unnecessarily mark COLLISION while stopping the
TRBE buffer normally (when called from arm_trbe_update_buffer), when
there is no WRAP event ?


> +
>   	if (is_trbe_wrap(trbsr))
>   		return TRBE_FAULT_ACT_WRAP;

Couldn't this be :

	/* Move the big fat comment here */
	if (is_trbe_wrap(trbsr)) {
		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
		return TRBE_FAULT_ACT_WRAP;
	}

Suzuki


