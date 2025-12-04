Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B933F8D6;
	Thu,  4 Dec 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764853059; cv=none; b=JuVR7TNjQvp2pbLQRK1DaEU5WcO/vQtCmClY4w7vH46Mc7sS5J8BPfT6Y7YffNk7mnQ3QKTQUrk5qbZt2My4u/wqIAVS64I0iwXQAmEsvnXBAFeP9a9P7h42D++FUHah3BKt/sbXMZkGNyC3dv+q3nbV0fbc9p9TWyna4JKflgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764853059; c=relaxed/simple;
	bh=6oJ71qc9X+HXC0PEDnuWIagZEXd+3wIWI0hJhmlQWxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCZ/NPaV5Q+ejPLtGWqIaJwz9UU8JDDZgVxyYRyBX7SHU+gAz0Va+SolD2b1/DEqujDt/WaLih8ZLrFhFeKbt1PaLadvBOVs3hE4dIhxQmQj3sJFAozRqE4RbBECTaBJYopRQUZlPgaQoKKre4//wWrj/ZjqZt3/HIwJe46PAnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59344339;
	Thu,  4 Dec 2025 04:57:28 -0800 (PST)
Received: from [10.163.49.196] (unknown [10.163.49.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E5763F59E;
	Thu,  4 Dec 2025 04:57:30 -0800 (PST)
Message-ID: <fb3b495a-3e04-417f-a674-e1753fd85177@arm.com>
Date: Thu, 4 Dec 2025 18:27:27 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/19] coresight: trbe: Refactor status clearing
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
 <20251201-trbe_buffer_refactor_v1-1-v1-5-7da32b076b28@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-5-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/12/25 4:51 PM, Leo Yan wrote:
> If the driver does not clear the status when disabling the trace buffer
> unit, stale state will carry over to the next enable, though the driver
> clears it again on enable.

There is no problem now ! Because trbe_enable_hw() calls clr_trbe_status().

> 
> Explicitly clear status after the trace is disabled in the interrupt
> handling and when a perf session ends.  Keep the status for spurious
> interrupts for continuous tracing.

But is not that the behaviour already without this change ?

clr_trbe_status() in trbe_enable_hw() ensures that no TRBE session can be
started without first clearing the existing status. Still wondering what
is the purpose of this change ?

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index e426991e2c2c398a9d3982e9d0f7f542e404cbab..9e565122816949b37b8ff5e4ba04cfbc317c6f25 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -629,7 +629,6 @@ static void trbe_enable_hw(struct trbe_buf *buf)
>  	WARN_ON(buf->trbe_hw_base < buf->trbe_base);
>  	WARN_ON(buf->trbe_write < buf->trbe_hw_base);
>  	WARN_ON(buf->trbe_write >= buf->trbe_limit);
> -	clr_trbe_status();
>  	set_trbe_base_pointer(buf->trbe_hw_base);
>  	set_trbe_write_pointer(buf->trbe_write);
>  
> @@ -1036,6 +1035,8 @@ static int arm_trbe_disable(struct coresight_device *csdev)
>  		return -EINVAL;
>  
>  	trbe_drain_and_disable_local(cpudata);
> +	clr_trbe_status();
> +
>  	buf->cpudata = NULL;
>  	cpudata->buf = NULL;
>  	cpudata->mode = CS_MODE_DISABLED;
> @@ -1151,6 +1152,10 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>  		return IRQ_NONE;
>  
>  	act = trbe_get_fault_act(handle, status);
> +
> +	if (act != TRBE_FAULT_ACT_SPURIOUS)
> +		clr_trbe_status();
> +
>  	switch (act) {
>  	case TRBE_FAULT_ACT_WRAP:
>  		truncated = !!trbe_handle_overflow(handle);
> 

