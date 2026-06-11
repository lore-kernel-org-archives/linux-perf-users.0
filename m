Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBA030B53C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168331; cv=none; b=EpJbw3nDFfVkWioRqK0rigiyu3evLk+JkKDYbQx3G771jvO+ylD0efsbWL6Ifpeqsvig3lGPMT9+AWIPvQM6BcpgJta5AA0CVodhY7ZqMCHSlb5/Om41kBGFZYEL98O2JyFutqnshDYBmIP0mAeBssoO8jnbEy+CTqa8rTOACX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168331; c=relaxed/simple;
	bh=HXGH2nyrVfIZnUpKXgLXmBtS3wqwT+RiEdAxLjpSzp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iedgY5YS1GN8U6YqaHkzOKrG3EMPvUqLF2WXIkssPKNTLzgXB68+/yAUqeUi+IrjXwWX9YzAvCo5l50xY7AXg0FiOfFX+ON488n/I9hAkQOeqVlFe8MtmBWaERDKBTsmSWjiQu/ejOLU7//P3suZF57cinERL3xRGD7cELVPcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ey7G4djO; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ey7G4djO"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68c3421b009so1051118a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781168328; x=1781773128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JsKqgp1n6AXmb14SRj6QHkb3JGSi6WYvxFs7FRLG/FY=;
        b=Ey7G4djOoUEN/WBNRMch+qptOkqBdzus5Jej231XBHMJxEKt8KshZRm+Ra3L6d6Rqm
         nzZ52H9DbcVIh2Z259LGUptacQbF1HHwPBXikKZp/POGiqPukC0/S3txcL+7lUKNTcT4
         dAhP2GtkmojktDobUq3TAN4xE/ooZ201dYuS6qXXgBw9h2ej77S/gKlY2roQ4gsSWDv9
         cfGwHT5RjXep0B1oGkWUgPW6ouPnpBto5e85X7KDa4H4+hIGCiMsQOhT74lPHSXNn3rO
         BibYfW6c9pm4GHlvQK/44X+gxicFQuZVuTHuNOvlxHR6ruA+QNSqdKiOD9pow36cO79f
         VR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168328; x=1781773128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsKqgp1n6AXmb14SRj6QHkb3JGSi6WYvxFs7FRLG/FY=;
        b=TezjL0lXz1qWZjf2RXJjsUVCrwq+9hb+EvcsxvWcbRS0czBm/mA8PFjFqHHKxxMZHv
         I8lHqi40XTyOxfyCrC6c53g74T+vAzFheBKUWVDgIP6qHvHNIfT7DcaBcpM3CGNJpx/0
         AttbgQhB48LzHj1mgNYJ0lQGkE0oWV+6+zJjYI8G06uYaGR0hJsLZtTkCxgvR7r7G5vM
         BSfOf1Hqi+6a6F4HQZptesbIZkRCe4eM0t6J/iLRsaZYcQ0qKeQvLrIwNEc66M78ZxGf
         69qPILpe1bpRBjUfmp+Ga6k3JpTZEe5zM3KMPcJvNomsvXl3yLd6s9PpPcKduK9bMpnB
         yPaA==
X-Forwarded-Encrypted: i=1; AFNElJ8t+KuJBi5J/9W4xTxTT6AR72y/gddxGeK3ZnrBvC+oXkiA5y9bK4/UylmB3A/uaKoEl4p8L6pijCJQfj/QGmKx@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHtvno5nCNGeezPeHKAcfVwvSjZe1ReFlYoj8T4HT1jaRg3t5
	mJ4d3oebu+QcyBqW3n4iX8rDu00Ma0MluqyVD9dybNyDOYNXBUzzUS4iyas+fNUWbMQ=
X-Gm-Gg: Acq92OHVJ69VGKkmGrLgTsR79IX5lo96stSafPJPIov6AKJ50V0U69JZ4DTQtP9m9Qv
	6oE5NKdyWXWWUakGTwAAcdmRBzeiP1kNpz+1R3bPsRYIHlJYrwvT+YmXOoTiuqg4yfodHHhbLwg
	5XmTuCw6l2dPJ3NK2Rd5N54dSubFFhvNWhIY0CtZ5F1XMWUSUVWpY59sBLJ2B7dHsxfPmdLwkgl
	KzeuQTtIAUwIEMl3EGseXxPVoqLTgnGnD79tk4enkMyBUGcABEmbeveA28EnPRS6Kebnj4o7kHl
	14wfZ/9kJNRky6oYl7hKNGS7/FcSy2H6Glv2ZrcloTUXN33eIjeVakcTmCp4QoAWY7lAirjlUo5
	7f7oaOXHGBEEPyO/VvNb3Mv6u8OG3HNqaUNNs2aMKn71Hm3A4+EQsX5InxijfKlsqjQLVmdM1HW
	eCaLQkHGQp1HqewAc5jaSdgAMPcWtsC2jejOnYEjw=
X-Received: by 2002:a17:907:3d4e:b0:bdf:b9fa:6683 with SMTP id a640c23a62f3a-bfc77004697mr82172666b.14.1781168328106;
        Thu, 11 Jun 2026 01:58:48 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm10683893a12.0.2026.06.11.01.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 01:58:47 -0700 (PDT)
Message-ID: <81db69cb-ca86-45c2-b768-cf588c634270@linaro.org>
Date: Thu, 11 Jun 2026 09:58:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] perf cs-etm: Filter synthesized branch samples
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
References: <20260611-b4-arm_cs_callchain_support_v1-v7-0-1ba770c862ae@arm.com>
 <20260611-b4-arm_cs_callchain_support_v1-v7-1-1ba770c862ae@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v7-1-1ba770c862ae@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/06/2026 8:56 am, Leo Yan wrote:
> From: Leo Yan <leo.yan@linaro.org>
> 
> The itrace 'c' and 'r' options request synthesized branch events for
> calls and returns only. For perf script the default itrace options are
> "--itrace=ce", so CS ETM should emit call branches and error events by
> default.

You need to update test_arm_coresight_disasm.sh to pass --itrace=b for 
both tests now because it needs every branch, not just calls. Should 
probably update the documentation and examples in arm-cs-trace-disasm.py 
too.

With that,

Reviewed-by: James Clark <james.clark@linaro.org>

> 
> CS ETM currently synthesizes a branch sample for every decoded taken
> branch whenever branch synthesis is enabled. This produces redundant
> jump and conditional branch samples.
> 
> Add a branch filter derived from the itrace calls and returns options.
> When neither option is set, keep the existing behavior and synthesize all
> branch samples. When calls or returns are requested, emit only branch
> samples whose flags match the selected branch type, while preserving trace
> begin/end markers.
> 
> Before:
> 
>    perf script -F,+flags
> 
>    callchain_test    6114 [005] 331519.825214:          1 branches:   tr strt jmp                           0 [unknown] ([unknown]) => ffff8000803a3a68 perf_report_aux_output_id+0x50 ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff8000803a3a74 perf_report_aux_output_id+0x5c ([kernel.kallsyms]) => ffff8000817f4d88 memset+0x0 ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   jmp                    ffff8000817f4d8c memset+0x4 ([kernel.kallsyms]) => ffff8000817f4c00 __pi_memset_generic+0x0 ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000817f4c1c __pi_memset_generic+0x1c ([kernel.kallsyms]) => ffff8000817f4c44 __pi_memset_generic+0x44 ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000817f4c4c __pi_memset_generic+0x4c ([kernel.kallsyms]) => ffff8000817f4c5c __pi_memset_generic+0x5c ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000817f4c5c __pi_memset_generic+0x5c ([kernel.kallsyms]) => ffff8000817f4cf0 __pi_memset_generic+0xf0 ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000817f4d30 __pi_memset_generic+0x130 ([kernel.kallsyms]) => ffff8000817f4d68 __pi_memset_generic+0x168 ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000817f4d78 __pi_memset_generic+0x178 ([kernel.kallsyms]) => ffff8000817f4d6c __pi_memset_generic+0x16c ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000817f4d78 __pi_memset_generic+0x178 ([kernel.kallsyms]) => ffff8000817f4d6c __pi_memset_generic+0x16c ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000817f4d78 __pi_memset_generic+0x178 ([kernel.kallsyms]) => ffff8000817f4d6c __pi_memset_generic+0x16c ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   return                 ffff8000817f4d84 __pi_memset_generic+0x184 ([kernel.kallsyms]) => ffff8000803a3a78 perf_report_aux_output_id+0x60 ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000803a3a98 perf_report_aux_output_id+0x80 ([kernel.kallsyms]) => ffff8000803a3b04 perf_report_aux_output_id+0xec ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff8000803a3b1c perf_report_aux_output_id+0x104 ([kernel.kallsyms]) => ffff8000803a38f8 __perf_event_header__init_id+0x0 ([kernel.kallsyms])
> 
> After:
> 
>    callchain_test    6114 [005] 331519.825214:          1 branches:   tr strt jmp                           0 [unknown] ([unknown]) => ffff8000803a3a68 perf_report_aux_output_id+0x50 ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff8000803a3a74 perf_report_aux_output_id+0x5c ([kernel.kallsyms]) => ffff8000817f4d88 memset+0x0 ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff8000803a3b1c perf_report_aux_output_id+0x104 ([kernel.kallsyms]) => ffff8000803a38f8 __perf_event_header__init_id+0x0 ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff8000803a39c0 __perf_event_header__init_id+0xc8 ([kernel.kallsyms]) => ffff800080105258 __task_pid_nr_ns+0x0 ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff80008010528c __task_pid_nr_ns+0x34 ([kernel.kallsyms]) => ffff8000801d5610 __rcu_read_lock+0x0 ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff8000801052b0 __task_pid_nr_ns+0x58 ([kernel.kallsyms]) => ffff800080192078 lock_acquire+0x0 ([kernel.kallsyms])
>    callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff8000801923f4 lock_acquire+0x37c ([kernel.kallsyms]) => ffff8000801d6da0 rcu_is_watching+0x0 ([kernel.kallsyms])
> 
> Fixes: b12235b113cf ("perf tools: Add mechanic to synthesise CoreSight trace packets")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 5e92359f51a7cb87a26866ae71466fcce809d551..c2b0f98ceee7671d0e98cfe5673c6f4ec19707a5 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -70,6 +70,7 @@ struct cs_etm_auxtrace {
>   	int num_cpu;
>   	u64 latest_kernel_timestamp;
>   	u32 auxtrace_type;
> +	u32 branches_filter;
>   	u64 branches_sample_type;
>   	u64 branches_id;
>   	u64 instructions_sample_type;
> @@ -1681,6 +1682,10 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
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
> @@ -3517,6 +3522,16 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>   		etm->synth_opts.callchain = false;
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
>   	etm->session = session;
>   
>   	etm->num_cpu = num_cpu;
> 

