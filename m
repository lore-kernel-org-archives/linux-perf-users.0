Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA9480953
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584159; cv=none; b=X8NxbClQNrThCk0Nelbm4hFqaEGSTRSRSqm3RUdhW+am9zgHQ7HEWn11AuagNnynwuh0WULm4mO8v2QofRr+cwzZoc23S3P7XOHt71ic1Qph9jZ3CjeLFUVaZXTQatJCgT7uDils3A277Dt4A+fNl1I3/TnrKtblhRWEevLUIRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584159; c=relaxed/simple;
	bh=+sbXqzAOyLIu/zNID1vjMOzH7sY4vGw7+hGNuBsI2m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUv4iSuebYShLEVLd339GiVu0JpYvUAHqoQNVZTenLgH/WQMmdkmyutbxlzWcGThbO/Lu3sNQ6J26MIJEdHK1jynVPIl/o75AlnnLK94sB9QzpzuLjp3CaO+nVr0qjY0+cYL6FD4/5ny2ecxlGnUJljbBSHemtyFpgN5eXuvaJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eK/RRfg2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eK/RRfg2"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bec449cf976so109443466b.2
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780584156; x=1781188956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzy4dDaqdwgJy1YaxSLyN1whQK6qSsoGcP13HMyFB64=;
        b=eK/RRfg2hK2kwK+IvIm+s6Xb/TYsKkLXlrb5lbchScyhL7+4dJ84xuHgUEaYRIzrJt
         Q+JI3kl7yK1cF5AsjATepSB+nNIpkwAfzakQP11op4LKMI7Cp0Bx52nXOcKzZnN2ntop
         RHqvz/ohv/lB1DpYdmLb25iv5oWmspP5wjP5Kvvu6oDlNzfcLj1KXTqPkmuRS2lPDaGS
         TJFn+GY2WVGOxo3YIyyAoRcPUDE8y2AaksCUvuHs/tayl/EECn7VNjRgr83w67lAwg4W
         O+22XktN1wUzFoj2gW/4ihXG6XakBA+Ja8K8oD7VCc4f5J/6kajaR/MV65ey2iP2XfsV
         b4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780584156; x=1781188956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzy4dDaqdwgJy1YaxSLyN1whQK6qSsoGcP13HMyFB64=;
        b=fzVaPUzC4P6bk2AGI2psLR3oY2jZkTbUG498cZzN6nslTgXKgRpiBf/RF589gGTo1R
         EhjZqGf5d1oiAC8EnsTEZiMIJflIaIpaTW0+Ge6X47U8DJU3lLmLRdLss3lHO5qM0QM0
         QX01LPSpQwWdFsjgTcJbXtLxTARRiegFevWjkv1fDkWPWco5z6agEUl1y6fe+qxbrxHn
         Y/UYhZLKeKjY9YzELWHE7i0jJxr2XlQIdzs/IQn1AnW9Fp1GQe9X+t+IEWC99J+5Pgmq
         PnI26s1Rd2fhWX/H3mtbsTiYrvEoDM2nOAauwfaKb4ejDJOqckGLBlcfZKworkj/UKy3
         eLDw==
X-Forwarded-Encrypted: i=1; AFNElJ9GVXma0j6wCFfqkDL15qkj+JmJkxysyhhwFIl2icTie03pncOFEwqW9QL0zHFRa2vUNjNUhwS7YfNzMSiX5NYS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfp0eny6GmbDZLQ2ul3LqTHufkYULrKAjBQiSn+/+ty5ev1F4g
	Qr+S4gyHx4sYlDDKoOqlErFKf/2jh/22S+QtNmYuE2zUWgf7LZVVOryjprZiKxlUgw8=
X-Gm-Gg: Acq92OHkNWRsLKKNlRJ0z91XBC+EntPOD+Xmn9lNgbAzCHpyO5CvWh9TE2wyHSkXg8/
	RFGztKkPHU+A8lSqkjt36dRLsTWqjygVi+C/3pGfsZGBlEm4taPeynz7ztJOXwzn2AtiJx9bKxk
	2vAzySfDBDAq05/soV+zrYvPt0Nd2llwoOZsYaHv9P80BO8nJn5avBvrBNxh+bppojWtD28Bt/y
	n5SlWUpzOsBRDAk8d/RneRgkLgKIKMOtTUJo5oZsPV2IqumLTg5CyfJ6v9N333dt882mI2eZ9Mt
	UuzkCAXY+TkthRK64gOjYaghdUj2jiYqSBpZXYXHlXCHcnEO9ewE3dL5q+0gludQ9mKYo6CO83W
	uwgXS6k3jcBvhvskrSCMFq6/v+UNCu/RoyKe672PBQnl4/ZsKPEDtO9HJMlCe3L1OB00/6ZuO9s
	y3RcpgpxvsbGTUezwinb+EdjxaVF32yr3e2Z5uZqg=
X-Received: by 2002:a17:906:7950:b0:bee:c371:4f43 with SMTP id a640c23a62f3a-bf0aab1b743mr505787266b.26.1780584154501;
        Thu, 04 Jun 2026 07:42:34 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0517721c2sm306900366b.3.2026.06.04.07.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:42:34 -0700 (PDT)
Message-ID: <fbe0a097-ced7-44c6-ada1-01c3e9c1d7e7@linaro.org>
Date: Thu, 4 Jun 2026 15:42:32 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] perf cs-etm: Filter synthesized branch samples
To: Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linux.dev>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>,
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
 <20260526-b4-arm_cs_callchain_support_v1-v6-6-f9f49f53c9dd@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-6-f9f49f53c9dd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/05/2026 5:59 pm, Leo Yan wrote:
> From: Leo Yan <leo.yan@linaro.org>
> 
> CS ETM currently emits branch samples for every decoded branch when
> branch synthesis is enabled. This delivers redundant info when users
> request only call or return branches.
> 
> Add a branch filter derived from the itrace "calls" and "returns" options.
> When no filter is set, keep the existing behavior and emit all branch
> samples. When call or return filtering is requested, only synthesize branch
> samples whose flags match the selected branch types, including trace
> begin and end markers.
> 
> Before:
> 
>    perf script -F +callindent
> 
>    callchain_test    9187 [002] 599611.826599:          1 branches:             main                                                     ffff83312258 __libc_start_call_main+0x78 (/usr/lib/aarch64-linux-gnu/libc.so.6)
>    callchain_test    9187 [002] 599611.826599:          1 branches:                 foo                                                  aaaae3ed07c4 main+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>    callchain_test    9187 [002] 599611.826599:          1 branches:                     print                                            aaaae3ed07ac foo+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>    callchain_test    9187 [002] 599611.826599:          1 branches:                         do_svc                                       aaaae3ed0794 print+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>    callchain_test    9187 [002] 599611.826599:          1 branches:                                                                      aaaae3ed077c do_svc+0x14 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>    callchain_test    9187 [002] 599611.826599:          1 branches:                             vectors                                  aaaae3ed0780 do_svc+0x18 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>    callchain_test    9187 [002] 599611.826599:          1 branches:                                                                  ffff800080010c00 vectors+0x400 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826600:          1 branches:                                                                  ffff800080010c24 vectors+0x424 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826600:          1 branches:                                                                  ffff8000800114dc el0t_64_sync+0xd4 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826600:          1 branches:                                                                  ffff8000800114f8 el0t_64_sync+0xf0 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826600:          1 branches:                                                                  ffff800080011528 el0t_64_sync+0x120 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826600:          1 branches:                                                                  ffff800080011538 el0t_64_sync+0x130 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826601:          1 branches:                                                                  ffff800080011568 el0t_64_sync+0x160 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826601:          1 branches:                                 el0t_64_sync_handler             ffff80008001159c el0t_64_sync+0x194 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826601:          1 branches:                                                                  ffff800081829110 el0t_64_sync_handler+0x18 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826601:          1 branches:                                     el0t_64_sync_handler         ffff800081829140 el0t_64_sync_handler+0x48 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826601:          1 branches:                                     el0_svc                      ffff800081829194 el0t_64_sync_handler+0x9c ([kernel.kallsyms])
> 
> After:
> 
>    callchain_test    9187 [002] 599611.826599:          1 branches:             main                                                     ffff83312258 __libc_start_call_main+0x78 (/usr/lib/aarch64-linux-gnu/libc.so.6)
>    callchain_test    9187 [002] 599611.826599:          1 branches:                 foo                                                  aaaae3ed07c4 main+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>    callchain_test    9187 [002] 599611.826599:          1 branches:                     print                                            aaaae3ed07ac foo+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>    callchain_test    9187 [002] 599611.826599:          1 branches:                         do_svc                                       aaaae3ed0794 print+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>    callchain_test    9187 [002] 599611.826599:          1 branches:                             vectors                                  aaaae3ed0780 do_svc+0x18 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>    callchain_test    9187 [002] 599611.826601:          1 branches:                                 el0t_64_sync_handler             ffff80008001159c el0t_64_sync+0x194 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826601:          1 branches:                                     el0_svc                      ffff800081829194 el0t_64_sync_handler+0x9c ([kernel.kallsyms])
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index b31d0dd46a45dc365edd7c2f9e9b2eb077ca23db..8d98e772ecb307381b5ed1b4bbc4056e8779b261 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -71,6 +71,7 @@ struct cs_etm_auxtrace {
>   	int num_cpu;
>   	u64 latest_kernel_timestamp;
>   	u32 auxtrace_type;
> +	u32 branches_filter;
>   	u64 branches_sample_type;
>   	u64 branches_id;
>   	u64 instructions_sample_type;
> @@ -1596,6 +1597,10 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>   	} dummy_bs;
>   	u64 ip;
>   
> +	if (etm->branches_filter &&
> +		!(etm->branches_filter & tidq->prev_packet->flags))
> +		return 0;
> +
>   	ip = cs_etm__last_executed_instr(tidq->prev_packet);
>   
>   	event->sample.header.type = PERF_RECORD_SAMPLE;
> @@ -3442,6 +3447,16 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>   		etm->synth_opts.thread_stack = session->itrace_synth_opts->thread_stack;
>   	}
>   
> +	if (etm->synth_opts.calls)
> +		etm->branches_filter |= PERF_IP_FLAG_CALL |
> +					PERF_IP_FLAG_TRACE_BEGIN |
> +					PERF_IP_FLAG_TRACE_END;
> +
> +	if (etm->synth_opts.returns)
> +		etm->branches_filter |= PERF_IP_FLAG_RETURN |
> +					PERF_IP_FLAG_TRACE_BEGIN |
> +					PERF_IP_FLAG_TRACE_END;
> +

This changes the default "perf script" output quite significantly and 
will possibly break people's workflows. synth_opts.calls is true by 
default but synth_opts.returns is false so we lose all the returns that 
we used to have. Not sure if the new behavior is more consistent with 
other tools so we can justify changing it? Personally I think including 
returns by default made more sense, and it's a more literal 
representation of the flow.

itrace.txt says the default is "all events i.e. the same as 
--itrace=iybxwpe", but I thought the default was branches? At least for 
Coresight it is, so I'm a bit confused.

>   	etm->session = session;
>   
>   	etm->num_cpu = num_cpu;
> 

