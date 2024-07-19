Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5479949
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386162; cv=none; b=iaAdUxmkqt7Ey75oq2KUrtVPGUVYNPuUNuBnSkcOPZjctUiSo4h5PnlW7KZcoLjWpd3UyRwR7NQOSPm4J8Zb9/tkeUaKD6P6QTMJOvTQ3vNfBFMsAP6vQoSFKY+8yHNQq09Gko3UfH4Up+L6uXpCgbK3PoWP9eJ3Ne50zKbYX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386162; c=relaxed/simple;
	bh=63/UiEcrKRTGvbeha8Yi9JnSS+2P44c9xvzt2bmeEi8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L9H3egunrMW2dsYX4BgiTeBVSivLiuVNc06FJV4oskZieBVilceNTytTPdfd67ToJDquC3Qn5P4HcVoRUet1b4gZpuM5H3O+wtjl16rJWUqcsIOHe3Bmz6TyOMsvZNNvbPXbcoZGcvsOZZnVJNiA8zWDcNWbggWdxxYkypOFVIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JqxaiNVi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JqxaiNVi"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-426526d30aaso11801685e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721386159; x=1721990959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MR1nNJwEx0Ncv0OjFeMZT+1maG8vE5Sihuegti2P7uo=;
        b=JqxaiNViV5rdPiyXypniRMJGQRVtvmvA4C8DZ3yImgcTMhky0FXzSHCFueizyXyegq
         ssd1UYOEK5jmYQ1s8wR0zJc99ay7g893dSWEKiarl4a1H5MsPDfVoVQtEA6wCawQmgHa
         /ExGdyCqeRzzLIumzXB33sEC2lfVRiVAe2kQzTD5G1pOoEFAGIt/krTF73YeDYnM/Tmh
         pFLjEPzWwUDu4dvNTwhXkJ3lAk9AWt79wPvhfuUArMHo23COnp9sJwHy6AZy2GH1lbKC
         MW/7DwI3iqLfN3cehvdHPYBITImgmDF0KEWnaYDOEESVwqUKUXrqkfPwB+zvBEu1S/qI
         /eFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721386159; x=1721990959;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MR1nNJwEx0Ncv0OjFeMZT+1maG8vE5Sihuegti2P7uo=;
        b=qKnHiC0FOUn71lp3jnr43kmU/pxsNZCS9PqhuVc8bSLYk6b3ZcR/mzDX5/RN0ZiWMI
         b0jPYLkBMWImZzFI3xUG57Exf9m7ctRgIOFERqnyYFaUOnbXPUwAUmSN6ogtuQoquidc
         r7b1gKdbYVEHGQiVesACJ4h8TbfHqOn1Hkq0O6dJ9iZYUCi0KqzTLqAvZ1y3hTmbfkTC
         uDRMQj9vvCbDXf7p4eLxU+vx5z4Tf0DDAsD8XAP223coGWhdAODc5QExbJpv7uppYFXA
         4XvH6N0D2HpWHBTV9I1ctejGmAePaatX5gPNJ76MEZ1TyhK0cG399hf4RhxRHNWq3DTI
         j1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVkDJPHQdDmRMcWi3xpAetsec95TvNnxoAVdkqzV92GP7akjLywjuy42vx8oCDxmgKpXYN1dFAUiFcDN1kstQowo/m3Quk5I2JG7sC0QuetKw==
X-Gm-Message-State: AOJu0YwWug4VO7ZB7tU7IhqMiQy0Z2E+lfhQ5BBpg7JakoxSDky+XhMx
	4KmaSfPIf2VeG/cHFXVg4KbA+oF8gFjxIrYvmTU9FJ6SS0OM+4N3LqYAxn3gX50=
X-Google-Smtp-Source: AGHT+IGSqGYMg1gMwCDpi4ynTGwlmP5ZaQazBLsPaVqrVPIrE/EA+mkS/S9m12GX65ty/Yq4oVn5LA==
X-Received: by 2002:a05:600c:3556:b0:426:59ad:bbb3 with SMTP id 5b1f17b1804b1-427c2d42a0amr55242215e9.32.1721386159024;
        Fri, 19 Jul 2024 03:49:19 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6901a35sm19693625e9.19.2024.07.19.03.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 03:49:18 -0700 (PDT)
Message-ID: <26262a1f-de49-41de-85bf-0640c6cc6bd2@linaro.org>
Date: Fri, 19 Jul 2024 11:49:17 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/17] perf: cs-etm: Support version 0.1 of HW_ID
 packets
From: James Clark <james.clark@linaro.org>
To: Mike Leach <mike.leach@linaro.org>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com,
 gankulkarni@os.amperecomputing.com, leo.yan@linux.dev,
 anshuman.khandual@arm.com, James Clark <james.clark@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
References: <20240712102029.3697965-1-james.clark@linaro.org>
 <20240712102029.3697965-7-james.clark@linaro.org>
 <CAJ9a7Vgz-rP6kGLLo2RR_qSZ3dhBT+=E8S=z1Hj6pfwOYu06Nw@mail.gmail.com>
 <ef5e7351-5f62-444a-b930-4dc2feb9f10d@linaro.org>
Content-Language: en-US
In-Reply-To: <ef5e7351-5f62-444a-b930-4dc2feb9f10d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/07/2024 11:48 am, James Clark wrote:
> 
> 
> On 18/07/2024 2:24 pm, Mike Leach wrote:
>> On Fri, 12 Jul 2024 at 11:22, James Clark <james.clark@linaro.org> wrote:
>>>
>>> From: James Clark <james.clark@arm.com>
>>>
>>> v0.1 HW_ID packets have a new field that describes which sink each CPU
>>> writes to. Use the sink ID to link trace ID maps to each other so that
>>> mappings are shared wherever the sink is shared.
>>>
>>> Also update the error message to show that overlapping IDs aren't an
>>> error in per-thread mode, just not supported. In the future we can
>>> use the CPU ID from the AUX records, or watch for changing sink IDs on
>>> HW_ID packets to use the correct decoders.
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>>   tools/include/linux/coresight-pmu.h |  17 +++--
>>>   tools/perf/util/cs-etm.c            | 100 +++++++++++++++++++++++++---
>>>   2 files changed, 103 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/tools/include/linux/coresight-pmu.h 
>>> b/tools/include/linux/coresight-pmu.h
>>> index 51ac441a37c3..89b0ac0014b0 100644
>>> --- a/tools/include/linux/coresight-pmu.h
>>> +++ b/tools/include/linux/coresight-pmu.h
>>> @@ -49,12 +49,21 @@
>>>    * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
>>>    * Used to associate a CPU with the CoreSight Trace ID.
>>>    * [07:00] - Trace ID - uses 8 bits to make value easy to read in 
>>> file.
>>> - * [59:08] - Unused (SBZ)
>>> - * [63:60] - Version
>>> + * [39:08] - Sink ID - as reported in 
>>> /sys/bus/event_source/devices/cs_etm/sinks/
>>> + *           Added in minor version 1.
>>> + * [55:40] - Unused (SBZ)
>>> + * [59:56] - Minor Version - previously existing fields are 
>>> compatible with
>>> + *           all minor versions.
>>> + * [63:60] - Major Version - previously existing fields mean 
>>> different things
>>> + *           in new major versions.
>>>    */
>>>   #define CS_AUX_HW_ID_TRACE_ID_MASK     GENMASK_ULL(7, 0)
>>> -#define CS_AUX_HW_ID_VERSION_MASK      GENMASK_ULL(63, 60)
>>> +#define CS_AUX_HW_ID_SINK_ID_MASK      GENMASK_ULL(39, 8)
>>>
>>> -#define CS_AUX_HW_ID_CURR_VERSION 0
>>> +#define CS_AUX_HW_ID_MINOR_VERSION_MASK        GENMASK_ULL(59, 56)
>>> +#define CS_AUX_HW_ID_MAJOR_VERSION_MASK        GENMASK_ULL(63, 60)
>>> +
>>> +#define CS_AUX_HW_ID_MAJOR_VERSION 0
>>> +#define CS_AUX_HW_ID_MINOR_VERSION 1
>>>
>>>   #endif
>>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>>> index 954a6f7bedf3..87e983da19be 100644
>>> --- a/tools/perf/util/cs-etm.c
>>> +++ b/tools/perf/util/cs-etm.c
>>> @@ -118,6 +118,12 @@ struct cs_etm_queue {
>>>          struct cs_etm_traceid_queue **traceid_queues;
>>>          /* Conversion between traceID and metadata pointers */
>>>          struct intlist *traceid_list;
>>> +       /*
>>> +        * Same as traceid_list, but traceid_list may be a reference 
>>> to another
>>> +        * queue's which has a matching sink ID.
>>> +        */
>>> +       struct intlist *own_traceid_list;
>>> +       u32 sink_id;
>>>   };
>>>
>>>   static int cs_etm__process_timestamped_queues(struct 
>>> cs_etm_auxtrace *etm);
>>> @@ -142,6 +148,7 @@ static int cs_etm__metadata_set_trace_id(u8 
>>> trace_chan_id, u64 *cpu_metadata);
>>>                        (queue_nr << 16 | trace_chan_id)
>>>   #define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
>>>   #define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
>>> +#define SINK_UNSET ((u32) -1)
>>>
>>>   static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
>>>   {
>>> @@ -241,7 +248,16 @@ static int cs_etm__insert_trace_id_node(struct 
>>> cs_etm_queue *etmq,
>>>                  int err;
>>>
>>>                  if (curr_cpu_data[CS_ETM_CPU] != 
>>> cpu_metadata[CS_ETM_CPU]) {
>>> -                       pr_err("CS_ETM: map mismatch between HW_ID 
>>> packet CPU and Trace ID\n");
>>> +                       /*
>>> +                        * With > CORESIGHT_TRACE_IDS_MAX ETMs, 
>>> overlapping IDs
>>> +                        * are expected (but not supported) in 
>>> per-thread mode,
>>> +                        * rather than signifying an error.
>>> +                        */
>>> +                       if (etmq->etm->per_thread_decoding)
>>> +                               pr_err("CS_ETM: overlapping Trace IDs 
>>> aren't currently supported in per-thread mode\n");
>>> +                       else
>>> +                               pr_err("CS_ETM: map mismatch between 
>>> HW_ID packet CPU and Trace ID\n");
>>> +
>>>                          return -EINVAL;
>>>                  }
>>>
>>> @@ -326,6 +342,64 @@ static int cs_etm__process_trace_id_v0(struct 
>>> cs_etm_auxtrace *etm, int cpu,
>>>          return cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
>>>   }
>>>
>>> +static int cs_etm__process_trace_id_v0_1(struct cs_etm_auxtrace 
>>> *etm, int cpu,
>>> +                                        u64 hw_id)
>>> +{
>>> +       struct cs_etm_queue *etmq = cs_etm__get_queue(etm, cpu);
>>> +       int ret;
>>> +       u64 *cpu_data;
>>> +       u32 sink_id = FIELD_GET(CS_AUX_HW_ID_SINK_ID_MASK, hw_id);
>>> +       u8 trace_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
>>> +
>>> +       /*
>>> +        * Check sink id hasn't changed in per-cpu mode. In 
>>> per-thread mode,
>>> +        * let it pass for now until an actual overlapping trace ID 
>>> is hit. In
>>> +        * most cases IDs won't overlap even if the sink changes.
>>> +        */
>>> +       if (!etmq->etm->per_thread_decoding && etmq->sink_id != 
>>> SINK_UNSET &&
>>> +           etmq->sink_id != sink_id) {
>>> +               pr_err("CS_ETM: mismatch between sink IDs\n");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       etmq->sink_id = sink_id;
>>> +
>>> +       /* Find which other queues use this sink and link their ID 
>>> maps */
>>> +       for (unsigned int i = 0; i < etm->queues.nr_queues; ++i) {
>>> +               struct cs_etm_queue *other_etmq = 
>>> etm->queues.queue_array[i].priv;
>>> +
>>> +               /* Different sinks, skip */
>>> +               if (other_etmq->sink_id != etmq->sink_id)
>>> +                       continue;
>>> +
>>> +               /* Already linked, skip */
>>> +               if (other_etmq->traceid_list == etmq->traceid_list)
>>> +                       continue;
>>> +
>>> +               /* At the point of first linking, this one should be 
>>> empty */
>>> +               if (!intlist__empty(etmq->traceid_list)) {
>>> +                       pr_err("CS_ETM: Can't link populated trace ID 
>>> lists\n");
>>> +                       return -EINVAL;
>>> +               }
>>> +
>>> +               etmq->own_traceid_list = NULL;
>>> +               intlist__delete(etmq->traceid_list);
>>> +               etmq->traceid_list = other_etmq->traceid_list;
>>> +               break;
>>> +       }
>>> +
>>> +       cpu_data = get_cpu_data(etm, cpu);
>>> +       ret = cs_etm__insert_trace_id_node(etmq, trace_id, cpu_data);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       ret = cs_etm__metadata_set_trace_id(trace_id, cpu_data);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>   static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 
>>> *cpu_metadata)
>>>   {
>>>          u64 cs_etm_magic = cpu_metadata[CS_ETM_MAGIC];
>>> @@ -414,10 +488,10 @@ static int 
>>> cs_etm__process_aux_output_hw_id(struct perf_session *session,
>>>
>>>          /* extract and parse the HW ID */
>>>          hw_id = event->aux_output_hw_id.hw_id;
>>> -       version = FIELD_GET(CS_AUX_HW_ID_VERSION_MASK, hw_id);
>>> +       version = FIELD_GET(CS_AUX_HW_ID_MAJOR_VERSION_MASK, hw_id);
>>>
>>>          /* check that we can handle this version */
>>> -       if (version > CS_AUX_HW_ID_CURR_VERSION) {
>>> +       if (version > CS_AUX_HW_ID_MAJOR_VERSION) {
>>>                  pr_err("CS ETM Trace: PERF_RECORD_AUX_OUTPUT_HW_ID 
>>> version %d not supported. Please update Perf.\n",
>>>                         version);
>>>                  return -EINVAL;
>>> @@ -442,7 +516,10 @@ static int 
>>> cs_etm__process_aux_output_hw_id(struct perf_session *session,
>>>                  return -EINVAL;
>>>          }
>>>
>>> -       return cs_etm__process_trace_id_v0(etm, cpu, hw_id);
>>
>> Perhaps leave this as the final statement of the function
>>
>>> +       if (FIELD_GET(CS_AUX_HW_ID_MINOR_VERSION_MASK, hw_id) == 0)
>>
>> this could be moved before and be
>>
>> if (FIELD_GET(CS_AUX_HW_ID_MINOR_VERSION_MASK, hw_id) == 1)
>>                 return cs_etm__process_trace_id_v0_1(etm, cpu, hw_id);
>>
>>
> 
> Because I was intending minor version changes to be backwards compatible 
> I have it so that any value other than 0 is treated as v0.1. Otherwise 
> version updates will break old versions of Perf. And then if we added a 
> v0.3 it would look like this:

That should have said v0.2 ^

> 
>   if (FIELD_GET(CS_AUX_HW_ID_MINOR_VERSION_MASK, hw_id) == 0)
>     return cs_etm__process_trace_id_v0(etm, cpu, hw_id);
>   else if (FIELD_GET(CS_AUX_HW_ID_MINOR_VERSION_MASK, hw_id) == 1)
>     return cs_etm__process_trace_id_v0_1(etm, cpu, hw_id);
>   else
>     return cs_etm__process_trace_id_v0_2(etm, cpu, hw_id);
> 
> Based on that I'm not sure if you still think it should be changed?
