Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0ED31E83E
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585634; cv=none; b=pzsLQ83KSDbLE0cwr4pojMvGwuYSa+7ReYVoDKk046kBcznbbBcI/7di/sSK8tCXo/Zt+oeLceIDoLEbqBr2iYNe9bAOigH5prdfHI25QLrVVgYGA5xHUzMx6ZSRp7nVB1JWfwPjcOtILl3w0FAaQuYhxCBrbCGiCtm/qliSZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585634; c=relaxed/simple;
	bh=b1fL+m+Q/nw6Yf3Fs2YOyL3tvgUf/fTIuqUtoxSl7Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMBjafJeY3FwFLpVUyIzNejgwphiPJ8ARyKCqZlcvVSxSFkzAhfvfgMShFMMbl1G9oKPYFm3ViFvzQED3xsWJMzJixKaOnQnl9sboStmGT/zVISdctUjFG8IGETJezkL2JgTQBx8Z74JlGKCXBOS+8frghtW7A6mfDb4f4JjsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u2OjjvHl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2OjjvHl"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so1322190f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780585629; x=1781190429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzCx8oZtOKJy0MwZJ9vxD1WducBZjFeqqellDoQ+O60=;
        b=u2OjjvHlnnVn5EOW0TVvtuRpz9pg/z6ZiYZoqfyNDnMm0orxt3ckbvsEAXukKXcQN+
         RMd2fCo/PAVavETYnLIHZbqQ+4SaYv/LgBSZHwz8DXd3XVHIpGruxreBOOCFdhsPGKhD
         CT0y/oYMST3nmEGzrOLQxkn5abJUCSZ8YFCSrDIzCqjRcAX5uTkhOuKFQDITeh7x++Wj
         EjzkLQ7jEuXbRtTpwQsPRSgOOY5XWGx5Jfxw7Ei4pKkrhYknZZbt7uf6oxoj9L2whpri
         RxjCLo+W+/sqKxLgeyUwhAaT/Pailg/b4uejtIAPfgHjdfUjpDcc+qau4Dn39uW2rZ36
         gRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585629; x=1781190429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EzCx8oZtOKJy0MwZJ9vxD1WducBZjFeqqellDoQ+O60=;
        b=g6fzzidEy0Fxvu1ulcr5s5ZthOW0GDDFezVAqaSI1kGFst++GWpblOIMGi0v4a8mqz
         ZBLZUSoXZL4/tVm6hSnHVEMahXjkJvSb11PlcdDf1GBiZTh/TKx0sHlddB2LvGFgEnQM
         CVimPGxlDOMtW9Z5O7/5+Y6WiATKvFBVqeCiF/9aYf19LVMuPS4YxJgwpMece2GdsevH
         mB4zovTPpqQp7jWSF3BPXF9YlJMyksqi/t7pODB3iKxWYiy3TRePPIgfjK+uEXYavD7g
         2F/PwvEpAsHOJq3QFZOv2f24TH5aQN8i6VxahAW/WpdyHfMVIGM3lBTUVNPK8rklPQZk
         Mtaw==
X-Forwarded-Encrypted: i=1; AFNElJ9rH4/QQGOQazr8/WlIAjOtVLg5z+XUe+tlaaQNzToDYwZcwTey1YVdO8BaAw0cqKfhPRmv09J7iLbBqWVAbbt4@vger.kernel.org
X-Gm-Message-State: AOJu0YyhExYzckQYR/OrMDl5/dOH8P36Ffg2SboKE+siTTa5y0EQUAON
	JRB/ZpRowA7COkYPn/xV+I1RkAnFGXKA0PHxxie6+6BD6CNv2bPILBLKG+YVDLj63As=
X-Gm-Gg: Acq92OFxYYYXYNLp5IiCuEtvyMkfychMPIyzt+wmpSNgaqYpQx9+kSrGZFbWTwCtVms
	qYVkOatMNgTNiD0uIJNId1ULKE7DqsoE5M3p0y2Gn8885YpBAmFUUovlq8UK8isPAAwnAOM0ein
	tioAGW/++7jy+Dx12jHG6Zgcie2qu5hCyrhbMDY8hS+Bs3sV3uzlmU5R4QiV9gn/BmbCSNJ2G2y
	Z4HDH4y5UM5TZx/yocWXb69IIEJRo72jonZMg9k/NAAH3tnkkrYDPekSyhEVuRioNLkbWP/ZEnZ
	0JBQke14rBNojLHRHDCzFgc+XFXmthBQMbykXNvuaTAZ0I3xflwaa07EhjcC8jfQ/ky7AkToFGi
	8SNNJHoCmnmnBhqrukzyrjs5ulyTY6Xap0MkD1XKce/QVGGRaOpHccJ3i2Qsv6LXZhf5mHZJaB3
	ZIHyL0DuxzdYihOb0ovjOkcPuv7msuyZ/1iusLC30=
X-Received: by 2002:adf:f1ce:0:b0:45e:f7ae:d599 with SMTP id ffacd0b85a97d-460276257eamr4375838f8f.25.1780585629481;
        Thu, 04 Jun 2026 08:07:09 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm16840516f8f.28.2026.06.04.08.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 08:07:09 -0700 (PDT)
Message-ID: <ba6008d5-930e-466a-ade8-7a3fe9f4e306@linaro.org>
Date: Thu, 4 Jun 2026 16:07:07 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] perf cs-etm: Synthesize callchains for instruction
 samples
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
 <20260526-b4-arm_cs_callchain_support_v1-v6-7-f9f49f53c9dd@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-7-f9f49f53c9dd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/05/2026 5:59 pm, Leo Yan wrote:
> From: Leo Yan <leo.yan@linaro.org>
> 
> CS ETM already records branches into the thread stack, but instruction
> samples do not carry synthesized callchains. It misses to support the
> callchain and no output with the itrace option 'g'.
> 
> Allocate a callchain buffer per queue and use thread_stack__sample()
> when synthesizing instruction samples. Advertise PERF_SAMPLE_CALLCHAIN
> on the synthetic instruction event.
> 
> Allocate the callchain stack with one more entry than requested, as the
> first entry is reserved for storing context information.
> 
> After:
> 
>    perf script --itrace=g16l64i100
> 
>    callchain_test    9187 [002] 599611.826599:          1 instructions:
>                aaaae3ed0774 do_svc+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>                aaaae3ed0798 print+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>                aaaae3ed07b0 foo+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>                aaaae3ed07c8 main+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>                ffff8331225c __libc_start_call_main+0x7c (/usr/lib/aarch64-linux-gnu/libc.so.6)
>                ffff8331233c call_init+0x9c (inlined)
>                ffff8331233c __libc_start_main_impl+0x9c (inlined)
>                aaaae3ed0670 _start+0x30 (/home/kernel/leoy/test_cs_callchain/callchain_test)
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 8d98e772ecb307381b5ed1b4bbc4056e8779b261..90e0beb910156093d8bd0f320bb0210aca95dd26 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -17,6 +17,7 @@
>   #include <stdlib.h>
>   
>   #include "auxtrace.h"
> +#include "callchain.h"
>   #include "color.h"
>   #include "cs-etm.h"
>   #include "cs-etm-decoder/cs-etm-decoder.h"
> @@ -85,6 +86,7 @@ struct cs_etm_auxtrace {
>   struct cs_etm_traceid_queue {
>   	u8 trace_chan_id;
>   	u64 period_instructions;
> +	u64 kernel_start;
>   	union perf_event *event_buf;
>   	struct thread *thread;
>   	struct thread *prev_packet_thread;
> @@ -92,6 +94,7 @@ struct cs_etm_traceid_queue {
>   	ocsd_ex_level el;
>   	unsigned int br_stack_sz;
>   	struct branch_stack *last_branch;
> +	struct ip_callchain *callchain;
>   	struct cs_etm_packet *prev_packet;
>   	struct cs_etm_packet *packet;
>   	struct cs_etm_packet_queue packet_queue;
> @@ -640,6 +643,16 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>   		tidq->br_stack_sz = etm->synth_opts.last_branch_sz;
>   	}
>   
> +	if (etm->synth_opts.callchain) {
> +		size_t sz = sizeof(struct ip_callchain);
> +
> +		/* Add 1 to callchain_sz for callchain context */
> +		sz += (etm->synth_opts.callchain_sz + 1) * sizeof(u64);
> +		tidq->callchain = zalloc(sz);

You can use struct_size() to get the size for a flexible array struct:

   zalloc(struct_size(tidq->callchain, ips,
                      etm->synth_opts.callchain_sz + 1));

> +		if (!tidq->callchain)
> +			goto out_free;
> +	}
> +
>   	tidq->event_buf = malloc(PERF_SAMPLE_MAX_SIZE);
>   	if (!tidq->event_buf)
>   		goto out_free;
> @@ -647,6 +660,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>   	return 0;
>   
>   out_free:
> +	zfree(&tidq->callchain);
>   	zfree(&tidq->last_branch);
>   	zfree(&tidq->prev_packet);
>   	zfree(&tidq->packet);
> @@ -939,6 +953,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
>   		thread__zput(tidq->thread);
>   		thread__zput(tidq->prev_packet_thread);
>   		zfree(&tidq->event_buf);
> +		zfree(&tidq->callchain);
>   		zfree(&tidq->last_branch);
>   		zfree(&tidq->prev_packet);
>   		zfree(&tidq->packet);
> @@ -1431,6 +1446,7 @@ static void cs_etm__set_thread(struct cs_etm_queue *etmq,
>   		tidq->thread = machine__idle_thread(machine);
>   
>   	tidq->el = el;
> +	tidq->kernel_start = machine__kernel_start(machine);
>   }
>   
>   int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid,
> @@ -1561,6 +1577,25 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>   		sample.branch_stack = tidq->last_branch;
>   	}
>   
> +	if (etm->synth_opts.callchain) {
> +		if (tidq->kernel_start)
> +			thread_stack__sample(tidq->thread, tidq->packet->cpu,
> +					     tidq->callchain,
> +					     etm->synth_opts.callchain_sz + 1,
> +					     sample.ip, tidq->kernel_start);
> +		else
> +			/*
> +			 * Clear the callchain when the kernel start address is
> +			 * not available yet. The empty callchain can then be
> +			 * consumed by cs_etm__inject_event().
> +			 */
> +			memset(tidq->callchain, 0,
> +			       sizeof(struct ip_callchain) +
> +			       (etm->synth_opts.callchain_sz + 1) * sizeof(u64));

Ditto, but the rest looks good:

Reviewed-by: James Clark <james.clark@linaro.org>

> +
> +		sample.callchain = tidq->callchain;
> +	}
> +
>   	if (etm->synth_opts.inject) {
>   		ret = cs_etm__inject_event(etm, event, &sample,
>   					   etm->instructions_sample_type);
> @@ -1724,6 +1759,9 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
>   		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
>   	}
>   
> +	if (etm->synth_opts.callchain)
> +		attr.sample_type |= PERF_SAMPLE_CALLCHAIN;
> +
>   	if (etm->synth_opts.instructions) {
>   		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
>   		attr.sample_period = etm->synth_opts.period;
> @@ -3457,6 +3495,14 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>   					PERF_IP_FLAG_TRACE_BEGIN |
>   					PERF_IP_FLAG_TRACE_END;
>   
> +	if (etm->synth_opts.callchain && !symbol_conf.use_callchain) {
> +		symbol_conf.use_callchain = true;
> +		if (callchain_register_param(&callchain_param) < 0) {
> +			symbol_conf.use_callchain = false;
> +			etm->synth_opts.callchain = false;
> +		}
> +	}
> +
>   	etm->session = session;
>   
>   	etm->num_cpu = num_cpu;
> @@ -3508,7 +3554,8 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>   	}
>   
>   	etm->use_thread_stack = etm->synth_opts.thread_stack ||
> -				etm->synth_opts.last_branch;
> +				etm->synth_opts.last_branch ||
> +				etm->synth_opts.callchain;
>   
>   	err = cs_etm__synth_events(etm, session);
>   	if (err)
> 

