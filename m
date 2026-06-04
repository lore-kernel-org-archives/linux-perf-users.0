Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159F944CF22
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583099; cv=none; b=TB+DPs/pw4tOjJxxjGCOwWazjwpmaFweBvEm6zf8ySja7Im2vTdtC9UYaca06swhbbQB6+0DYAk7qNjP3AXqFOFrsQ0xQRok/0gP/p1X70nhyXMcV0OJgZsUKTm8bZTLr80pNAI2/pTdXGz/lSY4XFNLYzPkxLPYngNtACaEhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583099; c=relaxed/simple;
	bh=kW1IRODNTFzINY71PmCcfMDVMre9LRLXWfvGt2lzIPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCGPYCEEqKc7s29eoi4xlf73t/w2mfX/KLI2f3YW5wXkzEz96KILhV/wT6Tt7JoC70dhb4a/Wr2M+qY5rPGFfvEAQyg6zxXKjxvkM+ljNHAJEE4QxA7EBTPBL6rQt/bc+KBnN6sCIkM+CPgWZj+Er8hn4KGamvklZDPJ9rZnmbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v59MgY0k; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v59MgY0k"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bef1e6423e7so85287166b.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780583095; x=1781187895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSVB+NeLUKsDZxroUTRNw7PnqK1gg8UhLVVWefTCNJI=;
        b=v59MgY0kaG0fZJdsi0xR5/xFZZlT1Gyqvp1g7AzwXFQ1wQibYvZvScnM4kjVZvlLhO
         dJhNuEB5QCezMe6/eg50YSw0xxvxdcpvNf/3qDyYeu8LTPTSuI0IdGs/gNsIInxO5SE2
         iBe2dNxSv14Wm0fcq7EaB8bTOXOC6a5uG6twcweAHkm6bY6HyTwDohdxpUK2ai0LQY64
         L+Tvexmc4PfgZjPvvF/46J8zfhc5c3/ohyG5Vx0rCVepFFA1qywr+6ZkZPLh3FvocjFs
         gAFmEsUSmub967tEidTzjznujRY56ZZ/nJrda5GZ2GolsrQK9pFw/WXw0mDtYas4igkn
         O4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780583095; x=1781187895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSVB+NeLUKsDZxroUTRNw7PnqK1gg8UhLVVWefTCNJI=;
        b=Q9ZBzpy8vnFJftkm1zYH5I3OK+0yBx4jI7D1SHNjAv0FXotlvkfc2JwKHIrQeHwJFQ
         6O/6A2TCBd8t47WPhDagN1I083zItaUflnwmd4/9cs+IAIEDWJabCVJCNA45V5C+MdiF
         3z2e/mrpksUobCt0th348OSpkAJjXKPxV/rbM66/Zgpa43o7mdFEzz0LXz8cdPfrVsdl
         Ask591QuQY546zcquzJuk1XYGe3WxzbSdgdu6fWtpc8HEKiNEaSu2/hT/fZIe6IYvDXk
         bQptg5w7BngjkmlwzbFPh85B5NgNwt80sbQnRRrOoUF9+9ftD+q+GATy1qR7Hi7+My2B
         JRLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qelaXoBdecHFzIOBEByRCd9KbIr4Z/arITgCQBijwo2pqEPSdjmed4Os/sOFwTyKr106uJ7L4vVkZWohTbPJm@vger.kernel.org
X-Gm-Message-State: AOJu0YyKr3DOr6crMgcXaJMdsNZhGLxgtmfpa00nnZzD3eK29ZPPoeoN
	UQed/fuWVE/naVEYKuCbwoEuX/roeB4rTJa0tAEX4Qc+xAH/XeDVjq5ue9Az4xpZgRk=
X-Gm-Gg: Acq92OH1XQKZ3QwsvcOhYDk5Bm/npwfnj6UUpSbf1qdY7IewsvNJrcN+Qrzpv37oFxm
	uPPHsyCHD31xx89CnC4GPdT1bX+d9Z3FQEX4pfna6y7v0q61YKKYe2oNJAZ9rwTqE5W94WqQ32v
	Ce/jhY0WhdC9wvjQqINyYqgBJCpLsOyClg+QJ/1wszpHyQX7EDwZima6V9EwkOOe/aDA0jJ6Bsg
	lMRUFB1PUCChMyZ1eKLhfPGLv+VnRdv5JwPhGZMMjTH7VzgQOnR2ooj/xGiXkH/2Zg+OMSQzheV
	R1nEgwNFVdlkL7Vh57sosYev/NXeMRP6k5bh+8WPpuTuuChOV4Q5rg+xp6GxDOthBQCNpwgRkWA
	EtziJ7dsRri+un+aIEUuT8oS0z3nM2ifkEyBuiWsvayQkt5A2pJGrBb3MEHAKOvzOlhgMux+r8r
	9qTW2gsCmNKyb7MD2JxZbidREpp69m34u9Y1A7StY=
X-Received: by 2002:a17:907:aac:b0:bee:875d:af12 with SMTP id a640c23a62f3a-bf0a5a47089mr294470566b.0.1780583095348;
        Thu, 04 Jun 2026 07:24:55 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054dfe3aesm309536866b.37.2026.06.04.07.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:24:55 -0700 (PDT)
Message-ID: <a16868a5-c42d-4432-bc91-74778b789ab6@linaro.org>
Date: Thu, 4 Jun 2026 15:24:53 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] perf cs-etm: Support call indentation
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
 <20260526-b4-arm_cs_callchain_support_v1-v6-5-f9f49f53c9dd@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-5-f9f49f53c9dd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/05/2026 5:59 pm, Leo Yan wrote:
> From: Leo Yan <leo.yan@linaro.org>
> 
> This commit supports the field "callindent" to reflect the call stack
> depth.
> 
> The branch stack is used by both call indentation and the last branch
> record, which are separate features. Use a new flag "use_br_stack" to
> track whether the branch stack needs to be recorded.
> 
> Before:
> 
>    perf script -F +callindent
> 
>    callchain_test    9187 [002] 599611.826599:          1 branches: main                                 ffff83312258 __libc_start_call_main+0x78 (/usr/lib/aarch64-linux-gnu/libc.so.6)
>    callchain_test    9187 [002] 599611.826599:          1 branches: foo                                  aaaae3ed07c4 main+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>    callchain_test    9187 [002] 599611.826599:          1 branches: print                                aaaae3ed07ac foo+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>    callchain_test    9187 [002] 599611.826599:          1 branches: do_svc                               aaaae3ed0794 print+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>    callchain_test    9187 [002] 599611.826599:          1 branches:                                      aaaae3ed077c do_svc+0x14 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>    callchain_test    9187 [002] 599611.826599:          1 branches: vectors                              aaaae3ed0780 do_svc+0x18 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>    callchain_test    9187 [002] 599611.826599:          1 branches:                                  ffff800080010c00 vectors+0x400 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826600:          1 branches:                                  ffff800080010c24 vectors+0x424 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826600:          1 branches:                                  ffff8000800114dc el0t_64_sync+0xd4 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826600:          1 branches:                                  ffff8000800114f8 el0t_64_sync+0xf0 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826600:          1 branches:                                  ffff800080011528 el0t_64_sync+0x120 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826600:          1 branches:                                  ffff800080011538 el0t_64_sync+0x130 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826601:          1 branches:                                  ffff800080011568 el0t_64_sync+0x160 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826601:          1 branches: el0t_64_sync_handler             ffff80008001159c el0t_64_sync+0x194 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826601:          1 branches:                                  ffff800081829110 el0t_64_sync_handler+0x18 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826601:          1 branches: el0t_64_sync_handler             ffff800081829140 el0t_64_sync_handler+0x48 ([kernel.kallsyms])
>    callchain_test    9187 [002] 599611.826601:          1 branches: el0_svc                          ffff800081829194 el0t_64_sync_handler+0x9c ([kernel.kallsyms])
> 
> After:
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
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index ea2424175558ddc0a6f20a9de6c30f377facdc52..b31d0dd46a45dc365edd7c2f9e9b2eb077ca23db 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -66,6 +66,7 @@ struct cs_etm_auxtrace {
>   	bool snapshot_mode;
>   	bool data_queued;
>   	bool has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
> +	bool use_thread_stack;
>   
>   	int num_cpu;
>   	u64 latest_kernel_timestamp;
> @@ -626,7 +627,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>   	if (!tidq->prev_packet)
>   		goto out_free;
>   
> -	if (etm->synth_opts.last_branch) {
> +	if (etm->use_thread_stack) {
>   		size_t sz = sizeof(struct branch_stack);
>   
>   		sz += etm->synth_opts.last_branch_sz *
> @@ -1505,7 +1506,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
>   	    tidq->packet->sample_type != CS_ETM_RANGE)
>   		return;
>   
> -	if (etmq->etm->synth_opts.last_branch) {
> +	if (etmq->etm->use_thread_stack) {
>   		from = cs_etm__last_executed_instr(tidq->prev_packet);
>   		to = cs_etm__first_executed_instr(tidq->packet);
>   
> @@ -1914,7 +1915,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>   	cs_etm__packet_swap(etm, tidq);
>   
>   	/* Reset last branches after flush the trace */
> -	if (etm->synth_opts.last_branch)
> +	if (etm->use_thread_stack)
>   		thread_stack__flush(tidq->thread);
>   
>   	return err;
> @@ -1977,7 +1978,7 @@ static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
>   {
>   	enum cs_etm_pid_fmt pid_fmt = cs_etm__get_pid_fmt(etmq);
>   
> -	if (!etmq->etm->synth_opts.last_branch)
> +	if (!etmq->etm->use_thread_stack)
>   		return;
>   
>   	cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
> @@ -3438,6 +3439,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>   		itrace_synth_opts__set_default(&etm->synth_opts,
>   				session->itrace_synth_opts->default_no_sample);
>   		etm->synth_opts.callchain = false;
> +		etm->synth_opts.thread_stack = session->itrace_synth_opts->thread_stack;
>   	}
>   
>   	etm->session = session;
> @@ -3489,6 +3491,10 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>   		etm->tc.cap_user_time_zero = tc->cap_user_time_zero;
>   		etm->tc.cap_user_time_short = tc->cap_user_time_short;
>   	}
> +
> +	etm->use_thread_stack = etm->synth_opts.thread_stack ||
> +				etm->synth_opts.last_branch;
> +
>   	err = cs_etm__synth_events(etm, session);
>   	if (err)
>   		goto err_free_queues;
> 

Reviewed-by: James Clark <james.clark@linaro.org>

