Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523FD338F2F;
	Thu,  4 Dec 2025 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764850096; cv=none; b=Pdw9/G88F4lOs+5EW+4Yy50UlLC3Daz5yygRz6sy1dN2d5QEXiW1PUfxYRViF8w5NzKalSObcZ+Q3mE6L7IjuFhNQGYF3SPhjFiyfTnL6NqhmZZCFA6TcSoYqyb2ObLiNjzwDejNnLVXYzb80KORgAwsLLU9c+HCPXUYcWDSSyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764850096; c=relaxed/simple;
	bh=959xcw5yX4PoIuZ/HAOrDU65/YlBQuITaHCDJCCbGpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUF7wixaBSZUJFXCy1zBdkcPcav6bVXCt+5ivUKzURf1pS+LPEhj61dslWbIXkdEr/FXKerUFjZ5REnqRmIqdwaifydxOb4DoiIdc7595so4iB8qiQqAE+YNwEIccVB956ucBpfJCExHfo5Vt+ccmQQ2msqpd5QHEYU06IoEPmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54B28339;
	Thu,  4 Dec 2025 04:08:06 -0800 (PST)
Received: from [10.163.49.196] (unknown [10.163.49.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACBF33F73B;
	Thu,  4 Dec 2025 04:08:08 -0800 (PST)
Message-ID: <9440a191-86af-4eea-b867-8f65131bd701@arm.com>
Date: Thu, 4 Dec 2025 17:38:05 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] coresight: trbe: Use helpers for checking errata
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
 <20251201-trbe_buffer_refactor_v1-1-v1-1-7da32b076b28@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-1-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/12/25 4:51 PM, Leo Yan wrote:
> Use the existed helpers for checking errata instead of open coded

Small nit - s/the existed helpers/the existing helpers/

> equivalent.> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 293715b4ff0eb0abe30f9b477700ca94f81cd4a2..0ddb3db0213cf0014e29decfb79da68b0a351b31 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -723,7 +723,7 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
>  	 * the space we skipped with IGNORE packets. And we are always
>  	 * guaranteed to have at least a PAGE_SIZE space in the buffer.
>  	 */
> -	if (trbe_has_erratum(buf->cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE) &&
> +	if (trbe_may_overwrite_in_fill_mode(buf->cpudata) &&
>  	    !WARN_ON(size < overwrite_skip))
>  		__trbe_pad_buf(buf, start_off, overwrite_skip);
>  
> @@ -946,7 +946,7 @@ static int trbe_apply_work_around_before_enable(struct trbe_buf *buf)
>  	 *  - At trace collection:
>  	 *     - Pad the 256bytes skipped above again with IGNORE packets.
>  	 */
> -	if (trbe_has_erratum(buf->cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE)) {
> +	if (trbe_may_overwrite_in_fill_mode(buf->cpudata)) {
>  		if (WARN_ON(!IS_ALIGNED(buf->trbe_write, PAGE_SIZE)))
>  			return -EINVAL;
>  		buf->trbe_hw_base = buf->trbe_write;
> @@ -970,7 +970,7 @@ static int trbe_apply_work_around_before_enable(struct trbe_buf *buf)
>  	 *     - Adjust the TRBLIMITR.LIMIT to leave the extra PAGE outside
>  	 *       the TRBE's range (i.e [TRBBASER, TRBLIMITR.LIMI] ).
>  	 */
> -	if (trbe_has_erratum(buf->cpudata, TRBE_WORKAROUND_WRITE_OUT_OF_RANGE)) {
> +	if (trbe_may_write_out_of_range(buf->cpudata)) {
>  		s64 space = buf->trbe_limit - buf->trbe_write;
>  		/*
>  		 * We must have more than a PAGE_SIZE worth space in the proposed
> 

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
