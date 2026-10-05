Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00AC4854ED;
	Mon,  5 Oct 2026 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215178; cv=none; b=k7vvmfYcZsfAbH/rxdGzPCGXUC09jap1GxM3mNU82T/7bkBL3CejT2d7y/LCagtiHeA15va7GxTFiOvcObXVxSdWrl0xNzYsuf1anDD7neZbCyjV9lOZTSpZH6SAeWDwH918dxar1lfJlxp68ZX0joxAto6Z7d9VyCUrTf5g/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215178; c=relaxed/simple;
	bh=xGeq5sjx9eaLEDMjBTfqpruQ01UNAsCYZ0+dN1RMZXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZFrFUFqyUEDdy/9Ov6zYenOG/sPDagGyrxgxUQAFJm5ZObxMrAQ6K8RwddFBlaM/vcXyHjcikAN6h5RbZgfX8yFMieO1guPhpd08LXgv+nQsMsybHp0F7h1DKD5k0PO0Ahuy2KSV8BSYjTiegL8xrBjNRR3Tyhdp25LG9QTtL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KOzJIn+b; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KOzJIn+b"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEDD4152B;
	Mon,  5 Oct 2026 08:46:12 -0700 (PDT)
Received: from [10.57.9.139] (unknown [10.57.9.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74EF93F66F;
	Mon,  5 Oct 2026 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791215176; bh=xGeq5sjx9eaLEDMjBTfqpruQ01UNAsCYZ0+dN1RMZXQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KOzJIn+bGIW6NU1Xx33KHwE/5cj0DOGw8D6P2vU6AiCyEd9gjEZKpAyDDFsJiKR4U
	 uR7cHNQriGaf6hzMGPgFd26YhcjpHY5T+bX9++s+XDiJBKb65r9abfpweJ0M6CbCUK
	 v0RV+vxW/Vr0peIfIesWvkrxuiuFTYoepguQOZ6I=
Message-ID: <254599ef-ace5-423b-bc31-56150909d96f@arm.com>
Date: Mon, 5 Oct 2026 17:46:11 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/core: Return errors from
 perf_report_aux_output_id()
Content-Language: en-GB
To: James Clark <james.clark@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Mike Leach <mike.leach@arm.com>,
 Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20261001-james-cs-retry-hw_id-v1-0-4d45ab46cde7@linaro.org>
 <20261001-james-cs-retry-hw_id-v1-1-4d45ab46cde7@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20261001-james-cs-retry-hw_id-v1-1-4d45ab46cde7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peter, Arnaldo, Mark, Ingo et al



On 01/10/2026 15:21, James Clark wrote:
> It's useful to know if this failed or not so a retry can be attempted
> later. Return the error code or success.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   include/linux/perf_event.h | 2 +-
>   kernel/events/core.c       | 6 ++++--
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 48d851fbd8ea..01d318a4de50 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1896,7 +1896,7 @@ static inline struct fasync_struct **perf_event_fasync(struct perf_event *event)
>   }
>   
>   extern void perf_event_addr_filters_sync(struct perf_event *event);
> -extern void perf_report_aux_output_id(struct perf_event *event, u64 hw_id);
> +extern int perf_report_aux_output_id(struct perf_event *event, u64 hw_id);

This looks a trivial change with minor impact. Are you happy for me to
pull this via the coresight tree ? Please could I have an Ack on this ?


Cheers
Suzuki
>   
>   extern int perf_output_begin(struct perf_output_handle *handle,
>   			     struct perf_sample_data *data,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index d7f3e2c2ecb1..232da3b6f393 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10563,7 +10563,7 @@ static void perf_log_itrace_start(struct perf_event *event)
>   	perf_output_end(&handle);
>   }
>   
> -void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
> +int perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
>   {
>   	struct perf_output_handle handle;
>   	struct perf_sample_data sample;
> @@ -10585,12 +10585,14 @@ void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
>   	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
>   
>   	if (ret)
> -		return;
> +		return ret;
>   
>   	perf_output_put(&handle, rec);
>   	perf_event__output_id_sample(event, &handle, &sample);
>   
>   	perf_output_end(&handle);
> +
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
>   
> 

