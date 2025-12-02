Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6FF1C84D0;
	Tue,  2 Dec 2025 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764677158; cv=none; b=sYJcNmQqs+LP8hVzXVYX91fozusy7G8ADZges9WeCRzQX18OEXrGyng07RzMKi2JFRzBQRncLKnQ0jFgjAvBrIB6Ja1Ubu7c6meCYYs1kUHemJNNUGQbxfSWG2jZcYpuqm34ZJcR2jbYrF8HdTLWT/Q5t/pcw9Joj2TrGiasWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764677158; c=relaxed/simple;
	bh=sG7WFU/OD1svEa2lelp0NJaeRMKsedmy2aTwpvbN6a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYxgBMfVkmL0X7l9aX0Ss5dZtONOpp/1cLExCiXATVxRwlR2klMaWueDw0Jgccnf/UUzQrqlmi9oMu6J/uLtmWFWZ9/kevF5LDMuMLmO3wuJL8vZC01+2bCKbSdEcLm3IKp/u0fW5b9jlL1404P97jmvIhevDmP96pQKwdmvYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89A23176A;
	Tue,  2 Dec 2025 04:05:48 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D19F13F73B;
	Tue,  2 Dec 2025 04:05:53 -0800 (PST)
Message-ID: <cca13ee6-83d9-4478-ace0-1e7bedf79d0e@arm.com>
Date: Tue, 2 Dec 2025 12:05:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/19] coresight: trbe: Apply overwrite erratum for only
 wrap event
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
 <20251201-trbe_buffer_refactor_v1-1-v1-11-7da32b076b28@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-11-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/12/2025 11:22, Leo Yan wrote:
> The overwrite erratum occurs only on wrap events, so apply the extra
> wrap condition check in the workaround.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index e579ea98523c24d23a0cd265dcdd0a46b52b52da..2600af12a8fb94bb8c74efda2a101aacd01b0b34 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -714,7 +714,7 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
>   	 * 64bytes. Thus we ignore the potential triggering of the erratum
>   	 * on WRAP and limit the data to LIMIT.
>   	 */
> -	if (wrap)
> +	if (wrap && trbe_may_overwrite_in_fill_mode(buf->cpudata))
>   		write = get_trbe_limit_pointer();

This must be trbe_may_write_out_of_range() ?

Suzuki


>   	else
>   		write = get_trbe_write_pointer();
> @@ -736,7 +736,7 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
>   	 * the space we skipped with IGNORE packets. And we are always
>   	 * guaranteed to have at least a PAGE_SIZE space in the buffer.
>   	 */
> -	if (trbe_may_overwrite_in_fill_mode(buf->cpudata) &&
> +	if (wrap && trbe_may_overwrite_in_fill_mode(buf->cpudata) &&
>   	    !WARN_ON(size < overwrite_skip))
>   		__trbe_pad_buf(buf, start_off, overwrite_skip);
>   
> 

