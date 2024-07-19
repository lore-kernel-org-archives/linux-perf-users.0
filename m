Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B984A3E
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386102; cv=none; b=iFL3MKx36STXriGtRF1LH9qbQ21fSuIlimvdm+gOKjwnvDEyHNaBW7tF7aR3N8U5FAK60jNuVmh25STh4wk89poNoatx1u9dicrcyS5mOPHb5sr0qDVUi5YQWqQW911DCMu5TaqK1AaqTguUEc390ldNGVe767zpfo30c1xGCfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386102; c=relaxed/simple;
	bh=MTkLtnrdT1NP01vhZ4e7zwQFJkGZtPhOcNSPQ6LOAZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKz/COa784WKgPewWMcrYgEWvL+ByDl3oEaNszhrjcFOtU3nimfyoxnJXLsF0svx4lOS2DmBBBlhQk0ApwF9bLdnsyHqWiXitSUBwWcrYpwotaOO2gAnCIzEurcAFJ/i7XkyrlSeuF1bGqOl+4KZ7a+cFL21du26WzGbcNaAxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GlDZECOz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlDZECOz"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3684eb5be64so435432f8f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721386098; x=1721990898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QT3Oxgygqz6ZnVlMJNzc0vXkjCOv7tAU8CrJxx5mcsc=;
        b=GlDZECOz1pAjwTIAzKUwxZEiLoL7nSIG5jZhyIVeo4xfPpU8lPfMgqD3aC8QHSWJYp
         53vtqUHLlW2ZtXT69uNpzOKkTE1kkzyNvJWcOTqiL4klRATG5e/EKCuey4v6pRFzgGdA
         Iu9tRPc8RA209/CfLzkNy9Z770sZKnAAQWuVk+JiaqlOvXyGne4/qRuWx97ovlmjoAVI
         K7Z/oP74hwWdoUAe1MlY8KCoJR+b0vw3Cj8MrYCx5N5V5XS1f6iWYM4mltFNaoAqkcSs
         83Ec9feApAUtdybt5pLXflHfgPAASdf4zw6R16HOsLajfgLC6wdXznGFTqwn0l+GULnj
         NF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721386098; x=1721990898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QT3Oxgygqz6ZnVlMJNzc0vXkjCOv7tAU8CrJxx5mcsc=;
        b=jqZ5PeRN0MYtnpXjodTf18NpIpY+ZCcrV+k4f9NdLeesRHcIYD4dkuPcH3TOZqZvaa
         /PFC7j1ex5M6K1Kpn5musKAPvxqzgyeovdKfUs3X0+ey6+MAzyh2Nl2azmRaGUOL2IOw
         7NZOffKr8STU92KLHNAGxzuUBCKJyvjrXgc+WOkUk9PQag+kVHEUuAHcPsdPZcS4A/W3
         W+T85AcmCElVc/0qmRiNH0KS1K6fW4R7neBnAO3d+o6Qw8lNkbw5w6kRs1ukan7zOnHW
         c3MMtUoOwBeM4PjcY9kARq5u8KPlfxyR/MgaO7GbxaXzVcyybcXT+5lJCMlnsH9tbldD
         rCMw==
X-Forwarded-Encrypted: i=1; AJvYcCXPo7BWuaUZPzgbOc3eGzHwhf9XFpqIAdEdqcy3euAwc4zv3VrHDDUvG+c29xvgagBCCftF09gq6zXhuqb5mKLHzGDaW+X1zDOE3K4Vn1vTDw==
X-Gm-Message-State: AOJu0Yy8iFmjPd8DNZzTQo/NXe2lXMjsSdXuXU9HThs8FOimA3tSrgsy
	LF6geGEEkxYfS3rk8XE4zTCEr89t1CKtbMNTHzd3QB8AOEe6Fu7axK6jqM4sD3M=
X-Google-Smtp-Source: AGHT+IEPLg6lBUWym3tbn1u+RGXEOjf/HSA685NgRWZptIEUhp6cgruntzO8Q2ovSFfYC8ZzHwKZ2g==
X-Received: by 2002:adf:e386:0:b0:368:87ca:3d85 with SMTP id ffacd0b85a97d-36887ca3dbcmr157013f8f.29.1721386098278;
        Fri, 19 Jul 2024 03:48:18 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878694ba0sm1255324f8f.61.2024.07.19.03.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 03:48:17 -0700 (PDT)
Message-ID: <ef5e7351-5f62-444a-b930-4dc2feb9f10d@linaro.org>
Date: Fri, 19 Jul 2024 11:48:16 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/17] perf: cs-etm: Support version 0.1 of HW_ID
 packets
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAJ9a7Vgz-rP6kGLLo2RR_qSZ3dhBT+=E8S=z1Hj6pfwOYu06Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/07/2024 2:24 pm, Mike Leach wrote:
> On Fri, 12 Jul 2024 at 11:22, James Clark <james.clark@linaro.org> wrote:
>>
>> From: James Clark <james.clark@arm.com>
>>
>> v0.1 HW_ID packets have a new field that describes which sink each CPU
>> writes to. Use the sink ID to link trace ID maps to each other so that
>> mappings are shared wherever the sink is shared.
>>
>> Also update the error message to show that overlapping IDs aren't an
>> error in per-thread mode, just not supported. In the future we can
>> use the CPU ID from the AUX records, or watch for changing sink IDs on
>> HW_ID packets to use the correct decoders.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/include/linux/coresight-pmu.h |  17 +++--
>>   tools/perf/util/cs-etm.c            | 100 +++++++++++++++++++++++++---
>>   2 files changed, 103 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
>> index 51ac441a37c3..89b0ac0014b0 100644
>> --- a/tools/include/linux/coresight-pmu.h
>> +++ b/tools/include/linux/coresight-pmu.h
>> @@ -49,12 +49,21 @@
>>    * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
>>    * Used to associate a CPU with the CoreSight Trace ID.
>>    * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
>> - * [59:08] - Unused (SBZ)
>> - * [63:60] - Version
>> + * [39:08] - Sink ID - as reported in /sys/bus/event_source/devices/cs_etm/sinks/
>> + *           Added in minor version 1.
>> + * [55:40] - Unused (SBZ)
>> + * [59:56] - Minor Version - previously existing fields are compatible with
>> + *           all minor versions.
>> + * [63:60] - Major Version - previously existing fields mean different things
>> + *           in new major versions.
>>    */
>>   #define CS_AUX_HW_ID_TRACE_ID_MASK     GENMASK_ULL(7, 0)
>> -#define CS_AUX_HW_ID_VERSION_MASK      GENMASK_ULL(63, 60)
>> +#define CS_AUX_HW_ID_SINK_ID_MASK      GENMASK_ULL(39, 8)
>>
>> -#define CS_AUX_HW_ID_CURR_VERSION 0
>> +#define CS_AUX_HW_ID_MINOR_VERSION_MASK        GENMASK_ULL(59, 56)
>> +#define CS_AUX_HW_ID_MAJOR_VERSION_MASK        GENMASK_ULL(63, 60)
>> +
>> +#define CS_AUX_HW_ID_MAJOR_VERSION 0
>> +#define CS_AUX_HW_ID_MINOR_VERSION 1
>>
>>   #endif
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index 954a6f7bedf3..87e983da19be 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -118,6 +118,12 @@ struct cs_etm_queue {
>>          struct cs_etm_traceid_queue **traceid_queues;
>>          /* Conversion between traceID and metadata pointers */
>>          struct intlist *traceid_list;
>> +       /*
>> +        * Same as traceid_list, but traceid_list may be a reference to another
>> +        * queue's which has a matching sink ID.
>> +        */
>> +       struct intlist *own_traceid_list;
>> +       u32 sink_id;
>>   };
>>
>>   static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm);
>> @@ -142,6 +148,7 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata);
>>                        (queue_nr << 16 | trace_chan_id)
>>   #define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
>>   #define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
>> +#define SINK_UNSET ((u32) -1)
>>
>>   static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
>>   {
>> @@ -241,7 +248,16 @@ static int cs_etm__insert_trace_id_node(struct cs_etm_queue *etmq,
>>                  int err;
>>
>>                  if (curr_cpu_data[CS_ETM_CPU] != cpu_metadata[CS_ETM_CPU]) {
>> -                       pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
>> +                       /*
>> +                        * With > CORESIGHT_TRACE_IDS_MAX ETMs, overlapping IDs
>> +                        * are expected (but not supported) in per-thread mode,
>> +                        * rather than signifying an error.
>> +                        */
>> +                       if (etmq->etm->per_thread_decoding)
>> +                               pr_err("CS_ETM: overlapping Trace IDs aren't currently supported in per-thread mode\n");
>> +                       else
>> +                               pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
>> +
>>                          return -EINVAL;
>>                  }
>>
>> @@ -326,6 +342,64 @@ static int cs_etm__process_trace_id_v0(struct cs_etm_auxtrace *etm, int cpu,
>>          return cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
>>   }
>>
>> +static int cs_etm__process_trace_id_v0_1(struct cs_etm_auxtrace *etm, int cpu,
>> +                                        u64 hw_id)
>> +{
>> +       struct cs_etm_queue *etmq = cs_etm__get_queue(etm, cpu);
>> +       int ret;
>> +       u64 *cpu_data;
>> +       u32 sink_id = FIELD_GET(CS_AUX_HW_ID_SINK_ID_MASK, hw_id);
>> +       u8 trace_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
>> +
>> +       /*
>> +        * Check sink id hasn't changed in per-cpu mode. In per-thread mode,
>> +        * let it pass for now until an actual overlapping trace ID is hit. In
>> +        * most cases IDs won't overlap even if the sink changes.
>> +        */
>> +       if (!etmq->etm->per_thread_decoding && etmq->sink_id != SINK_UNSET &&
>> +           etmq->sink_id != sink_id) {
>> +               pr_err("CS_ETM: mismatch between sink IDs\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       etmq->sink_id = sink_id;
>> +
>> +       /* Find which other queues use this sink and link their ID maps */
>> +       for (unsigned int i = 0; i < etm->queues.nr_queues; ++i) {
>> +               struct cs_etm_queue *other_etmq = etm->queues.queue_array[i].priv;
>> +
>> +               /* Different sinks, skip */
>> +               if (other_etmq->sink_id != etmq->sink_id)
>> +                       continue;
>> +
>> +               /* Already linked, skip */
>> +               if (other_etmq->traceid_list == etmq->traceid_list)
>> +                       continue;
>> +
>> +               /* At the point of first linking, this one should be empty */
>> +               if (!intlist__empty(etmq->traceid_list)) {
>> +                       pr_err("CS_ETM: Can't link populated trace ID lists\n");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               etmq->own_traceid_list = NULL;
>> +               intlist__delete(etmq->traceid_list);
>> +               etmq->traceid_list = other_etmq->traceid_list;
>> +               break;
>> +       }
>> +
>> +       cpu_data = get_cpu_data(etm, cpu);
>> +       ret = cs_etm__insert_trace_id_node(etmq, trace_id, cpu_data);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = cs_etm__metadata_set_trace_id(trace_id, cpu_data);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return 0;
>> +}
>> +
>>   static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata)
>>   {
>>          u64 cs_etm_magic = cpu_metadata[CS_ETM_MAGIC];
>> @@ -414,10 +488,10 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
>>
>>          /* extract and parse the HW ID */
>>          hw_id = event->aux_output_hw_id.hw_id;
>> -       version = FIELD_GET(CS_AUX_HW_ID_VERSION_MASK, hw_id);
>> +       version = FIELD_GET(CS_AUX_HW_ID_MAJOR_VERSION_MASK, hw_id);
>>
>>          /* check that we can handle this version */
>> -       if (version > CS_AUX_HW_ID_CURR_VERSION) {
>> +       if (version > CS_AUX_HW_ID_MAJOR_VERSION) {
>>                  pr_err("CS ETM Trace: PERF_RECORD_AUX_OUTPUT_HW_ID version %d not supported. Please update Perf.\n",
>>                         version);
>>                  return -EINVAL;
>> @@ -442,7 +516,10 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
>>                  return -EINVAL;
>>          }
>>
>> -       return cs_etm__process_trace_id_v0(etm, cpu, hw_id);
> 
> Perhaps leave this as the final statement of the function
> 
>> +       if (FIELD_GET(CS_AUX_HW_ID_MINOR_VERSION_MASK, hw_id) == 0)
> 
> this could be moved before and be
> 
> if (FIELD_GET(CS_AUX_HW_ID_MINOR_VERSION_MASK, hw_id) == 1)
>                 return cs_etm__process_trace_id_v0_1(etm, cpu, hw_id);
> 
> 

Because I was intending minor version changes to be backwards compatible 
I have it so that any value other than 0 is treated as v0.1. Otherwise 
version updates will break old versions of Perf. And then if we added a 
v0.3 it would look like this:

  if (FIELD_GET(CS_AUX_HW_ID_MINOR_VERSION_MASK, hw_id) == 0)
    return cs_etm__process_trace_id_v0(etm, cpu, hw_id);
  else if (FIELD_GET(CS_AUX_HW_ID_MINOR_VERSION_MASK, hw_id) == 1)
    return cs_etm__process_trace_id_v0_1(etm, cpu, hw_id);
  else
    return cs_etm__process_trace_id_v0_2(etm, cpu, hw_id);

Based on that I'm not sure if you still think it should be changed?
