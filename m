Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB632AF11
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381776; cv=none; b=BdKLdi/CCBJIYNa4COCu24Z+k6RGDAnmi10Q72NEz3YFH09STomKYaLoZHpk00jEpmZFtI/FIzunGRRlmH4x29IR6Nh6mEOEuGMgdZS9GAk5xVy618nwkF4+9ouMV96BzJo7z/GqJDl/pKoS+tULIPRw19/rv/HWyYrbepbPp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381776; c=relaxed/simple;
	bh=DnZeCmqI2dyzpeY2FjAbXFvocOkEz76+OxjwEMKGOI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWAZsBwFZTxWnya8swe7FwBXLtIJnlMJGFsIWIuFDXbwasePIIH+nA/8Lb3aVdkxD0f+rc8dqZuE/kXWI2tbFpwCBA0iZELjnZ+70DkyZjyO+N3pSoY1gY+lXgrj5kNRQu95lHJC1hc6Ev3hzZecatYJMq2XZKjAj7IkAHaf8Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n0LrH7mX; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n0LrH7mX"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e9b9fb3dcso1511260e87.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721381772; x=1721986572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DsZBXW6WgrAGryG7gkuIwjrF77KOyGscbpByOvNZN18=;
        b=n0LrH7mXaEaP+0YmEERB093KTwPECOs2JpsXDBTCz57AH1YzNkJUsuGtRbtdX/sRmY
         S+WvdTfT+sxZ70BdPWQRGOuiWaI8wSdBNeahTnM6GgoBn2QPcdwQtyPGvHK+5x0MP8Zi
         p00rEqQ2wMl2JhINodIZussILmT7Z2U5iabUfdLWU6dTDv6qBQ2tchSQFMcW+NCDpfV1
         DnRHILWSB/Rb/JEdS7HWN/2dDN+4HNGKRDbmodzVgyvJOn6eCgQn2lBKWdq79Zsn4AJ+
         ru2THjLNgG2S7yIvJqJ2f86TpcgWENXiAyWJ1Y3hr7OrDsXR4xMwx1n+angYJhOMR40V
         Etgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721381772; x=1721986572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DsZBXW6WgrAGryG7gkuIwjrF77KOyGscbpByOvNZN18=;
        b=QXtJ2feAHFLxBEa1jiNYl18RkQaKgieCZosCPGqWcJ9IPoe6ORPFvWsoWk0ZMNpvB7
         4Omokj1LAKUv/ONGVByPdSdyIXVi1jUmYYl+2BEJJFBbzk9aQRGrlQvbt/b31fE0Eqr5
         6M1bezYKniqH0dXof/H7qyCwHLlNCFjX0rtVxQFZUY43mV9NJ2xNXgNIw1aeN9YKlnJ+
         B2SaX42pSBdhTSfYxD8b801nLHd+7bLfnSQdlTnp9ZufjGOU77UyKUr+EWtLLOucI6DF
         PlE+RFUYsMt5hW1sHMV/K58GZkpKVkhxj2uvbKOXQfUUUhQzg/2gSWIsBhQpqEw9Cz9D
         jc6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIKf9rUu9q+URmWrXVV1X0t6GaFTbPfM1bEcfEhGJlUojoHeZuS9GT78+x1lThZYFRAVSdMnAvOTWb2Ov+dydGFz4Y+Ema3BTVRNVoUQVO6w==
X-Gm-Message-State: AOJu0YyZ6an93Q97BS3QkpdpWnS/brgBL6owMI9aWD0ZoakBbXpBj6vR
	tmbiQ8cRjUAYTDtTspCWZBt/5SakvM5V5ui3u9WI6dX5V3Y6aawMxpzlZJTBrn8=
X-Google-Smtp-Source: AGHT+IGMi/4+EVLJ8XGN6IcunIoRlm0OtHgjmb84ebMvmTR6Z4ZDK8fU6GgHxIBYoARE+eaGq8AJIA==
X-Received: by 2002:a05:6512:6c4:b0:52c:825e:3b1c with SMTP id 2adb3069b0e04-52eeaeac222mr3722744e87.26.1721381772158;
        Fri, 19 Jul 2024 02:36:12 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e47csm44243675e9.29.2024.07.19.02.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 02:36:11 -0700 (PDT)
Message-ID: <e355cee6-92a7-4265-ac59-731e1adee970@linaro.org>
Date: Fri, 19 Jul 2024 10:36:10 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/17] perf: cs-etm: Allocate queues for all CPUs
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
 <20240712102029.3697965-3-james.clark@linaro.org>
 <CAJ9a7VgUXpOo7we8v8mCMDWNtCGsHmBi5tk8YA-MeNhHk59zLg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAJ9a7VgUXpOo7we8v8mCMDWNtCGsHmBi5tk8YA-MeNhHk59zLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/07/2024 2:24 pm, Mike Leach wrote:
> Hi James
> 
> On Fri, 12 Jul 2024 at 11:22, James Clark <james.clark@linaro.org> wrote:
>>
>> From: James Clark <james.clark@arm.com>
>>
>> Make cs_etm__setup_queue() setup a queue even if it's empty, and
>> pre-allocate queues based on the max CPU that was recorded. In per-CPU
>> mode aux queues are indexed based on CPU ID even if all CPUs aren't
>> recorded, sparse queue arrays aren't used.
>>
>> This will allow HW_IDs to be saved even if no aux data was received in
>> that queue without having to call cs_etm__setup_queue() from two
>> different places.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/util/cs-etm.c | 76 +++++++++++++++++++++-------------------
>>   1 file changed, 40 insertions(+), 36 deletions(-)
>>
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index f09004c4ba44..1a95c4bb898f 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -97,13 +97,19 @@ struct cs_etm_traceid_queue {
>>          struct cs_etm_packet_queue packet_queue;
>>   };
>>
>> +enum cs_etm_format {
>> +       UNSET,
>> +       FORMATTED,
>> +       UNFORMATTED
>> +};
>> +
> 
> Minor Nit: Could this...
> 
>>   struct cs_etm_queue {
>>          struct cs_etm_auxtrace *etm;
>>          struct cs_etm_decoder *decoder;
>>          struct auxtrace_buffer *buffer;
>>          unsigned int queue_nr;
>>          u8 pending_timestamp_chan_id;
>> -       bool formatted;
>> +       enum cs_etm_format format;
> 
> and this be introduced in the previous set? Avoid a bit of churn?
> 

Yep, I'll move it

>>          u64 offset;
>>          const unsigned char *buf;
>>          size_t buf_len, buf_used;
>> @@ -697,7 +703,7 @@ static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
>>
>>   static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>>                                       struct cs_etm_auxtrace *etm,
>> -                                    bool formatted,
>> +                                    enum cs_etm_format format,
>>                                       int sample_cpu,
>>                                       int decoders)
>>   {
>> @@ -706,7 +712,7 @@ static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>>          u64 architecture;
>>
>>          for (t_idx = 0; t_idx < decoders; t_idx++) {
>> -               if (formatted)
>> +               if (format == FORMATTED)
>>                          m_idx = t_idx;
>>                  else {
>>                          m_idx = get_cpu_data_idx(etm, sample_cpu);
>> @@ -749,7 +755,7 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
>>          d_params->packet_printer = cs_etm__packet_dump;
>>          d_params->operation = mode;
>>          d_params->data = etmq;
>> -       d_params->formatted = etmq->formatted;
>> +       d_params->formatted = etmq->format == FORMATTED;
>>          d_params->fsyncs = false;
>>          d_params->hsyncs = false;
>>          d_params->frame_aligned = true;
>> @@ -1056,16 +1062,11 @@ static struct cs_etm_queue *cs_etm__alloc_queue(void)
>>
>>   static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>>                                 struct auxtrace_queue *queue,
>> -                              unsigned int queue_nr, bool formatted)
>> +                              unsigned int queue_nr)
>>   {
>>          struct cs_etm_queue *etmq = queue->priv;
>>
>> -       if (etmq && formatted != etmq->formatted) {
>> -               pr_err("CS_ETM: mixed formatted and unformatted trace not supported\n");
>> -               return -EINVAL;
>> -       }
>> -
>> -       if (list_empty(&queue->head) || etmq)
>> +       if (etmq)
>>                  return 0;
>>
>>          etmq = cs_etm__alloc_queue();
>> @@ -1078,7 +1079,6 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>>          etmq->queue_nr = queue_nr;
>>          queue->cpu = queue_nr; /* Placeholder, may be reset to -1 in per-thread mode */
>>          etmq->offset = 0;
>> -       etmq->formatted = formatted;
>>
>>          return 0;
>>   }
>> @@ -2791,17 +2791,6 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
>>                  if (err)
>>                          return err;
>>
>> -               /*
>> -                * Knowing if the trace is formatted or not requires a lookup of
>> -                * the aux record so only works in non-piped mode where data is
>> -                * queued in cs_etm__queue_aux_records(). Always assume
>> -                * formatted in piped mode (true).
>> -                */
>> -               err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
>> -                                         idx, true);
>> -               if (err)
>> -                       return err;
>> -
>>                  if (dump_trace)
>>                          if (auxtrace_buffer__get_data(buffer, fd)) {
>>                                  cs_etm__dump_event(etm->queues.queue_array[idx].priv, buffer);
>> @@ -2918,8 +2907,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>>          struct perf_record_auxtrace *auxtrace_event;
>>          union perf_event auxtrace_fragment;
>>          __u64 aux_offset, aux_size;
>> -       __u32 idx;
>> -       bool formatted;
>> +       enum cs_etm_format format;
>>
>>          struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>>                                                     struct cs_etm_auxtrace,
>> @@ -2985,6 +2973,8 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>>
>>          if (aux_offset >= auxtrace_event->offset &&
>>              aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
>> +               struct cs_etm_queue *etmq = etm->queues.queue_array[auxtrace_event->idx].priv;
>> +
>>                  /*
>>                   * If this AUX event was inside this buffer somewhere, create a new auxtrace event
>>                   * based on the sizes of the aux event, and queue that fragment.
>> @@ -3001,10 +2991,14 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>>                  if (err)
>>                          return err;
>>
>> -               idx = auxtrace_event->idx;
>> -               formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
>> -
>> -               return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx], idx, formatted);
>> +               format = (aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW) ?
>> +                               UNFORMATTED : FORMATTED;
>> +               if (etmq->format != UNSET && format != etmq->format) {
>> +                       pr_err("CS_ETM: mixed formatted and unformatted trace not supported\n");
>> +                       return -EINVAL;
>> +               }
>> +               etmq->format = format;
>> +               return 0;
>>          }
>>
>>          /* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
>> @@ -3200,7 +3194,7 @@ static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
>>           * Each queue can only contain data from one CPU when unformatted, so only one decoder is
>>           * needed.
>>           */
>> -       int decoders = etmq->formatted ? etmq->etm->num_cpu : 1;
>> +       int decoders = etmq->format == FORMATTED ? etmq->etm->num_cpu : 1;
>>
>>          /* Use metadata to fill in trace parameters for trace decoder */
>>          struct cs_etm_trace_params  *t_params = zalloc(sizeof(*t_params) * decoders);
>> @@ -3208,7 +3202,7 @@ static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
>>          if (!t_params)
>>                  goto out_free;
>>
>> -       if (cs_etm__init_trace_params(t_params, etmq->etm, etmq->formatted,
>> +       if (cs_etm__init_trace_params(t_params, etmq->etm, etmq->format,
>>                                        etmq->queue_nr, decoders))
>>                  goto out_free;
>>
>> @@ -3256,6 +3250,7 @@ static int cs_etm__create_decoders(struct cs_etm_auxtrace *etm)
>>                   * Don't create decoders for empty queues, mainly because
>>                   * etmq->formatted is unknown for empty queues.
>>                   */
>> +               assert(empty == (etmq->format == UNSET));
>>                  if (empty)
>>                          continue;
>>
>> @@ -3275,10 +3270,10 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>>          int event_header_size = sizeof(struct perf_event_header);
>>          int total_size = auxtrace_info->header.size;
>>          int priv_size = 0;
>> -       int num_cpu;
>> +       int num_cpu, max_cpu = 0;
>>          int err = 0;
>>          int aux_hw_id_found;
>> -       int i, j;
>> +       int i;
>>          u64 *ptr = NULL;
>>          u64 **metadata = NULL;
>>
>> @@ -3309,7 +3304,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>>           * required by the trace decoder to properly decode the trace due
>>           * to its highly compressed nature.
>>           */
>> -       for (j = 0; j < num_cpu; j++) {
>> +       for (int j = 0; j < num_cpu; j++) {
>>                  if (ptr[i] == __perf_cs_etmv3_magic) {
>>                          metadata[j] =
>>                                  cs_etm__create_meta_blk(ptr, &i,
>> @@ -3333,6 +3328,9 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>>                          err = -ENOMEM;
>>                          goto err_free_metadata;
>>                  }
>> +
>> +               if ((int) metadata[j][CS_ETM_CPU] > max_cpu)
>> +                       max_cpu = metadata[j][CS_ETM_CPU];
>>          }
>>
>>          /*
>> @@ -3362,10 +3360,16 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>>           */
>>          etm->pid_fmt = cs_etm__init_pid_fmt(metadata[0]);
>>
>> -       err = auxtrace_queues__init(&etm->queues);
>> +       err = auxtrace_queues__init_nr(&etm->queues, max_cpu + 1);
>>          if (err)
>>                  goto err_free_etm;
>>
>> +       for (unsigned int j = 0; j < etm->queues.nr_queues; ++j) {
>> +               err = cs_etm__setup_queue(etm, &etm->queues.queue_array[j], j);
>> +               if (err)
>> +                       goto err_free_queues;
>> +       }
>> +
>>          if (session->itrace_synth_opts->set) {
>>                  etm->synth_opts = *session->itrace_synth_opts;
>>          } else {
>> @@ -3487,7 +3491,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>>          zfree(&etm);
>>   err_free_metadata:
>>          /* No need to check @metadata[j], free(NULL) is supported */
>> -       for (j = 0; j < num_cpu; j++)
>> +       for (int j = 0; j < num_cpu; j++)
>>                  zfree(&metadata[j]);
>>          zfree(&metadata);
>>   err_free_traceid_list:
>> --
>> 2.34.1
>>
> 
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> 
> 
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
