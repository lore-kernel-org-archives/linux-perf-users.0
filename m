Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2CD279DAE
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902453; cv=none; b=nYWjQDFJEWJeQsC8aRVhM12OYEC8KgMPWECqJIzrUhGvVtu0ZOBNgJ4qfriKKrSuqi6uxxt4k/3QwPcpOJr1b8RuUpiHxsjv3fOAqc6NujdwgPAE4EH893hrAvTewpTOQ161FkMEgLP/PnsFBpyOYkCZYd9ccEhUiKmplP1aK9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902453; c=relaxed/simple;
	bh=6Z29JneREWY4GbPosuQ/5wSZE24ZilLTwTlmwJFfoqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yr2dBuTt47fvtuZ0/e9ESoohBjYUtnZMfG9UlD+26t1HIG8k2ZXbam9s84FBx6m5s2jnH7nwYnd12DB8QrsfYnEZ7zznaWUUtYEAVwQjL9Q9o8O2IMEcc10TSKnnYybzF2FaOhCTFK7PMvRYfYNoFnys9QrsXFp22HlB4CLpJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=efcnx/10; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efcnx/10"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b728a43e410so755079566b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765902450; x=1766507250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJ1e1P6F4CyulVnt004SCDge6FBFbgLQSB8l5Ftm9W0=;
        b=efcnx/10CoNluIfBhwdaNc6cRROIl+JDPS0+C+fsDhFrRa2spsgdxl/oEua21n1PrE
         zTblr64JAhq6jqo79yJ41DdKEqRhVJsrLhVPM3kHVVzH8ZBbb9aibBNMLDl+tzTsqIiC
         DwvI2J/E4Phr8fXW5mmSh/s5yvmOCkHsguKY3vEOHAwFRHg8sncS3Q0pdR1fvdLBid33
         ZzBXNL4R1EeyNtoGsmZltRuDs+4xcPbB/LbFONy/cEqsdgzV8c0jgttkOB6Rzu4ZQ3GU
         oAHs8le3tNtaFQ75MlF7WHNYzwIz+Gte5RpAuqiMTzxf82IpuVMLv4gjPKf8LKeMPspH
         BZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765902450; x=1766507250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJ1e1P6F4CyulVnt004SCDge6FBFbgLQSB8l5Ftm9W0=;
        b=ZWqBiqvlZTi5B8CzWP1f+Z8+tYHAx+knnNptP6d7zvmdxn9ZgDSi5KaD/BmXdlspsp
         SQIRTlhnJa8ZqjIO38ARvtSLa0uZgiaVY6IKXkgd096WYecPEISp0OTeamO8ujOoBn6O
         3lSTooA7kG29x7Fv/Qj0gDOZpxIGPIetPe46+CsM/Bw8dgRSj5bsjHGPuk1qAelVq9V9
         khNKp4VoP2yqtMdZ/bcjF/6jwaBCLiRBWyPE/+FveuZaPnQ6NLbOcbIJPub0aUa1meIK
         z2TxEuWpY//qY4HRgdXkoD8eptCVS06mnwV76ErnCiAjqZZ4Uh5MjOxeEiYyURWYJhKa
         a8lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVje+qj2s87/2zsW5/5p7C5yiua+tGPWsBiRCNH7ZWtBpwc0MCThIfGo+verVlL8Q0M2tKwt7px6PdLqRQCTb6F@vger.kernel.org
X-Gm-Message-State: AOJu0YzacJNZVFDlkNskueE3QXVWCL86VOADd7dmWfdUno5eBjXd1pnw
	S1LMY09AN1bSIpEJAcOWMGIfGjTeqpYFU8Uqj348bqdqMa9vmv8gYtDscJRNRrhGwNs=
X-Gm-Gg: AY/fxX6MbVzhAtnfQIjwJBui6+v4xHLhscHUaCR5WYivLEWIVFnJ7z1hp9pN46ohCfc
	EDEr3wMbdW8ddN4ISi2P6mDX4O4QmibILUvI0IkNQ1kqrqDQ/Lwz0wWD+ZrijyJkxJCaKFfAtwr
	/6buD84VK4143vC0gkNlW5Djp7ZAI3lJm3FNvEMUpMZYtplbekg24ZKKIII+jcfEBA9IZB8Dg8C
	9xdJ2k+BoouudQ08Tj+nqz1IHghVmxam9pTEK51KfhGXqZciDe2/sp6GX8QQQr3F/LL2vdL6O3q
	6g96zr4vn6uFEZQ00ZKxqqHrAG3YEJopN3LfNetOOig2LAh5UXkf3brz1XF9pSvLcM5i0pT2sKC
	CsMlfj7CaVDhBcB29DvNvc5cPADvbirZxcY2bFjHQGhHsIQRmC5UEPR3dtZnx1yWWpE6Vlzr09J
	VbVuUP2yU6kW96+4lbnBvC
X-Google-Smtp-Source: AGHT+IEK6iaFERqvEdHq4Ged5LPvd31mh1w4HuC+BU0D8njB6TOveN15IML8gddkUz7RlIw6lJ98MQ==
X-Received: by 2002:a17:907:608d:b0:b77:1d75:8b78 with SMTP id a640c23a62f3a-b7d23cb3a2fmr1722671866b.53.1765902449781;
        Tue, 16 Dec 2025 08:27:29 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210de23sm16756928a12.28.2025.12.16.08.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 08:27:29 -0800 (PST)
Message-ID: <c8fad013-b022-4037-94e8-1f0536535469@linaro.org>
Date: Tue, 16 Dec 2025 18:27:27 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] coresight: trbe: Support trigger mode
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-16-7da32b076b28@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-16-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/12/2025 13:22, Leo Yan wrote:
> The buffer currently operates in fill mode, where tracing stops when it
> reaches the end of the buffer and a maintenance interrupt is raised.
> However, due to IRQ latency, trace data may be lost during the window in
> which tracing is halted but the program continues to run.
> 
> To mitigate the issue, this commit enables the trigger count to support
> buffer maintenance without disabling tracing.  This is fulfilled with
> two modes:
> 
> 1) Set a trigger count as a watermark and use fill mode to prevent the
>     buffer from being overwritten.  Once the count is decremented to
>     zero, an interrupt is raised for buffer maintenance, but the hardware
>     continues collecting trace data until limit.
> 
>            head            watermark tail
>       +----+---------------+---------+-------+
>       |$$$$|               |         |$$$$$$$|
>       +----+---------------+---------+-------+
>       base `---- count ----'         limit   base + nr_pages
> 
>       $$$ : Filled trace data
> 
> 2) Use wrap mode so that tracing continues when reach the top of the
>     buffer.  The trigger count is configured as "Stop on trigger" to
>     guard the trace data not to be overwritten.
> 
>                watermark   tail      head
>       +--------+-----------+---------+-------+
>       |        |           |$$$$$$$$$|       |
>       +--------+-----------+---------+-------+
>       base                                   base + nr_pages
>                                              limit
> 
>                                      `------->
>       >-- counter ---------'
> 
>       $$$ : Filled trace data
> 
> The modes are selected by comparing the limit with the trigger position.
> 
> An extra TRBE_FAULT_ACT_TRIG state is introduced for fault action, it is
> used to distinguish the trigger event from the WRAP event.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 101 +++++++++++++++++++++------
>   drivers/hwtracing/coresight/coresight-trbe.h |  14 ++++
>   2 files changed, 94 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 8390d0a8fe23d35945610df15f21751279ee37ee..0551ea9b4f8286c156e3c9c7ac94e2ecd3b9dc3f 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -48,6 +48,7 @@
>   #define TRBE_TRACE_MIN_BUF_SIZE		64
>   
>   enum trbe_fault_action {
> +	TRBE_FAULT_ACT_TRIG,
>   	TRBE_FAULT_ACT_WRAP,
>   	TRBE_FAULT_ACT_SPURIOUS,
>   	TRBE_FAULT_ACT_FATAL,
> @@ -67,6 +68,7 @@ struct trbe_buf {
>   	unsigned long trbe_hw_base;
>   	unsigned long trbe_limit;
>   	unsigned long trbe_write;
> +	unsigned long trbe_count;
>   	int nr_pages;
>   	void **pages;
>   	bool snapshot;
> @@ -478,6 +480,10 @@ static unsigned long __trbe_normal_offset(struct perf_output_handle *handle)
>   	if (head < tail)
>   		limit = round_down(tail, PAGE_SIZE);
>   
> +	/* If trigger mode is enabled, no need to use limit for watermark */
> +	if (!static_branch_unlikely(&trbe_trigger_mode_bypass))
> +		goto out;
> +
>   	/*
>   	 * Wakeup may be arbitrarily far into the future. If it's not in the
>   	 * current generation, either we'll wrap before hitting it, or it's
> @@ -495,6 +501,7 @@ static unsigned long __trbe_normal_offset(struct perf_output_handle *handle)
>   	if (handle->wakeup < (handle->head + handle->size) && head <= wakeup)
>   		limit = min(limit, round_up(wakeup, PAGE_SIZE));

I kept wondering how this limit was relvant now in wrap mode. But I see 
it's skipped from the goto above, but that only jumps over one 
statement. Can we have that static branch as a regular if statement 
guarding the limit calculation instead of the goto?

Negating "trigger_mode_bypass" and renaming it into just "trigger_mode" 
might help too. The double negative of "not trigger_trigger_mode_bypass 
goto" is a bit hard to understand.

>   
> +out:
>   	/*
>
