Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38481C8611;
	Fri,  5 Dec 2025 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764908894; cv=none; b=aTyuOSyLxduroEcDY2AcqSe/D3AJ9smlT7mmOg0gZAT/VGrtMghUqSl0QyVm7DGBZEpUFmSChO2OfmGzZ8DI6+jjCZPv4tE5L27TAJfWOHe0mTLBIQcEle+HDSR8eFD7/yLfAAvOYO+0FPkhMx9KtXWhTZ7tw8PlMCGgoYbIK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764908894; c=relaxed/simple;
	bh=8LBgmqq210KuzfI74JltUwaLtb/3OZ0EGUFgS4I0DfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=geeG6pOcCMTuEYNWeZijQ02GbGGLkZ1dTK4fPUKH1jvhiLIpIq/f9e7ez3Ay8/tfAKTvmwTcBUwUda40BmR/aWQBbKQEGYuioQz+LxHazfuN7ozCe73jnOqJZvSVQ0NvBgpyvSYTc/WLXF4JxFS1ZdolXyVxyIlTxGh0bCJRsWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8378339;
	Thu,  4 Dec 2025 20:28:04 -0800 (PST)
Received: from [10.163.52.42] (unknown [10.163.52.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DB043F86F;
	Thu,  4 Dec 2025 20:28:06 -0800 (PST)
Message-ID: <5f6bcd93-b565-4b10-9a2d-6851141e5dbe@arm.com>
Date: Fri, 5 Dec 2025 09:58:02 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/19] coresight: trbe: Use PERF_AUX_FLAG_PARTIAL instead
 of PERF_AUX_FLAG_COLLISION
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
 <20251201-trbe_buffer_refactor_v1-1-v1-8-7da32b076b28@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-8-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/12/25 4:51 PM, Leo Yan wrote:
> When tracing stops, there is no collision with other samples, so using
> PERF_AUX_FLAG_COLLISION does not accurately reflect the trace state and
> may mislead userspace.
> 
> Use PERF_AUX_FLAG_PARTIAL instead to indicate that tracing stopped and
> the record may contain gaps.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index b06885a08e082fd34f68d9588518807b5c47c86e..0caa4a6b437a3aa39fc6bcc72a23711b54f7c598 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -669,21 +669,14 @@ static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *hand
>  	}
>  
>  	/*
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
> +	 * Mark the buffer to indicate that the trace is stopped by setting
> +	 * the PARTIAL flag. This indicates to the user that the TRBE trace
> +	 * collection was stopped without stopping the ETE and thus there
> +	 * might be some amount of trace that was lost between the time the
> +	 * TRBE event was detected and the IRQ was consumed by the CPU.
>  	 */
>  	if (!is_trbe_running(trbsr))
> -		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_PARTIAL);

This is interesting. So there is a no possibility for the records to be
overridden in the perf ring buffer and incomplete record is all that can
happen when TRBE is stopped, without stopping the ETE first ? Could both
of these scenarios might be possible as well ?

>  
>  	if (is_trbe_wrap(trbsr))
>  		return TRBE_FAULT_ACT_WRAP;
> 
