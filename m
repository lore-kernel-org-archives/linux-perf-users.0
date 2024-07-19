Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6E983CD5
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721396751; cv=none; b=ax+IQKS+gZKp7g2vavpmC0A9gjy7jvP/4Hwpu9fhER3k42VUOGTRUT1yzvS8/hzS0a9NItZehb+EpO0tGbJ72oWvkVMs+MqVdkhfEJoX68zP1bjY+zsfDBUzVDVxnq7XTvwBLP1y+qoctMBJhki7Uh4WirKnXpRZyXS+P/6yuEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721396751; c=relaxed/simple;
	bh=GjySNPFrKifZ10GOJGBKmNbh/w6vmd7/dNemFTybewA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAuoWz3RkJZ/KtlmqmY+xKZHP8lE9hh8rHHBkobUBOui1nFnfCR7blAMNiTSH0EzFPM/CALd4DC0V+TRDnUWAc+1lWuThMqqZtd9ddDvYGVQH0aRmOftFaAb+dPjnJr1llI3aLU8rCiD3FtyqhigfTo9TUUpx4QGNuk2TVEK+3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z6mRSLNz; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6mRSLNz"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7928d2abe0aso2153327a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721396748; x=1722001548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q6DEEhmg3Ja8v8Rv8CzrLy7ke/9Hd5uw1xozBhzNHkw=;
        b=Z6mRSLNzZMvFeJBJK10q9jwCzjKzJe/dCx45eEqFtFLNLQwnPAtZkNJ1PXwV20k8zG
         PZANsfGcU3VM9N2uVc8sNWPn8brYMs8ouuSXSFwl0jPhLPyW8BIgOcZCmI+ZXh8evd7l
         jbLlJDzdrVmGysD5lfJheR7HqRmwWyE2sklXlOgleVoBP0si9GQzHRTYgfjv4xPqkR2N
         CW6scUmVNE0wbQFBvomNcT9q2+hmeWb1p8fwwOKiEkxxke3h2s2nNxvohPvuIHZSkDJ/
         ikJMgKX4tIqoxmmzPNXt1idU2XPveIUzXQwji398w2z97SzCi3apAyAURKrRx1q5D+8m
         lB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721396748; x=1722001548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6DEEhmg3Ja8v8Rv8CzrLy7ke/9Hd5uw1xozBhzNHkw=;
        b=ptQlV6WLASxqz4JrrDD0MxBqJOPGYeIWzFMblfxex+3RLSbg+1WeyF/qhGwE6VTf7+
         lf0FhQgQt9kYh+W7v9p3Pf2dtCA9kYHafOcGMuiyl7bdQ6c0dnL5LZX6gwc1CdV0R/UY
         Abuv9qbSwauiKBv389aat5bTPVp5cKZGZDz93eHmvMygpdmz5wQh9fp2mBcFsH3gcq/y
         wp1pOKV86HjRLVa026qcyU5YF45I8+rGFEw8HbNreO2to2lre+0NQPbbi/c88cdFjhyQ
         AawExKRAwWV+FriQDdmIz1RW7xPcZk7MG5+0ptfmGULPmcUE2dWMFgNg2yRh6qtfcBYo
         Kc2A==
X-Forwarded-Encrypted: i=1; AJvYcCX1wzResPmmflhdrA/l4E73IBIfMhl1TJ7wmFLGdYL1yXEq6pZ+bXd05xsQsbKUhDqFHnccrEIdeYRtaCx7GBh9bpiAKbv02eWruq73p5+uMg==
X-Gm-Message-State: AOJu0Yxw6johHCusSO1ZYTyA04A/jW1hzpXj8NnT2vfkpMnehbCcsEcv
	EEqpN2x4mpKoa51U0Rf11xZj7YPHmFsxEcSK3Mss4IctrmQMjcs9v23obIXJ6VFhXsrmDGUo5TH
	ChQFJVxmHFdKyeKFYLnnoNeBIGyJJkZTdN+iZug==
X-Google-Smtp-Source: AGHT+IHj7uX+1Re/rIAYxBvigyoyeQGRk9F0raS6FKUXjFDmNWxKntMHg6PQf2i+kUZS8oSEapT4/bKdOJe8lE0sWx0=
X-Received: by 2002:a17:90b:4d84:b0:2c8:f3b5:7dd1 with SMTP id
 98e67ed59e1d1-2cb779d0b7dmr6684082a91.16.1721396747944; Fri, 19 Jul 2024
 06:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org>
 <20240712102029.3697965-7-james.clark@linaro.org> <CAJ9a7Vgz-rP6kGLLo2RR_qSZ3dhBT+=E8S=z1Hj6pfwOYu06Nw@mail.gmail.com>
 <ef5e7351-5f62-444a-b930-4dc2feb9f10d@linaro.org> <26262a1f-de49-41de-85bf-0640c6cc6bd2@linaro.org>
In-Reply-To: <26262a1f-de49-41de-85bf-0640c6cc6bd2@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 19 Jul 2024 14:45:36 +0100
Message-ID: <CAJ9a7VhL18eWFw6T6HdrhbY_v8oeyuzM62D1w1CO1Psumb-EBQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/17] perf: cs-etm: Support version 0.1 of HW_ID packets
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com, 
	gankulkarni@os.amperecomputing.com, leo.yan@linux.dev, 
	anshuman.khandual@arm.com, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fair enough - less worried about the ordering as the final :

else
     return fn()
}

where there's no unconditional return at the end of the function. The
last else looks redundant to me. More a stylistic thing, not sure if
there is a hard and fast rule either way

Mike



On Fri, 19 Jul 2024 at 11:49, James Clark <james.clark@linaro.org> wrote:
>
>
>
> On 19/07/2024 11:48 am, James Clark wrote:
> >
> >
> > On 18/07/2024 2:24 pm, Mike Leach wrote:
> >> On Fri, 12 Jul 2024 at 11:22, James Clark <james.clark@linaro.org> wrote:
> >>>
> >>> From: James Clark <james.clark@arm.com>
> >>>
> >>> v0.1 HW_ID packets have a new field that describes which sink each CPU
> >>> writes to. Use the sink ID to link trace ID maps to each other so that
> >>> mappings are shared wherever the sink is shared.
> >>>
> >>> Also update the error message to show that overlapping IDs aren't an
> >>> error in per-thread mode, just not supported. In the future we can
> >>> use the CPU ID from the AUX records, or watch for changing sink IDs on
> >>> HW_ID packets to use the correct decoders.
> >>>
> >>> Signed-off-by: James Clark <james.clark@arm.com>
> >>> Signed-off-by: James Clark <james.clark@linaro.org>
> >>> ---
> >>>   tools/include/linux/coresight-pmu.h |  17 +++--
> >>>   tools/perf/util/cs-etm.c            | 100 +++++++++++++++++++++++++---
> >>>   2 files changed, 103 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/tools/include/linux/coresight-pmu.h
> >>> b/tools/include/linux/coresight-pmu.h
> >>> index 51ac441a37c3..89b0ac0014b0 100644
> >>> --- a/tools/include/linux/coresight-pmu.h
> >>> +++ b/tools/include/linux/coresight-pmu.h
> >>> @@ -49,12 +49,21 @@
> >>>    * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
> >>>    * Used to associate a CPU with the CoreSight Trace ID.
> >>>    * [07:00] - Trace ID - uses 8 bits to make value easy to read in
> >>> file.
> >>> - * [59:08] - Unused (SBZ)
> >>> - * [63:60] - Version
> >>> + * [39:08] - Sink ID - as reported in
> >>> /sys/bus/event_source/devices/cs_etm/sinks/
> >>> + *           Added in minor version 1.
> >>> + * [55:40] - Unused (SBZ)
> >>> + * [59:56] - Minor Version - previously existing fields are
> >>> compatible with
> >>> + *           all minor versions.
> >>> + * [63:60] - Major Version - previously existing fields mean
> >>> different things
> >>> + *           in new major versions.
> >>>    */
> >>>   #define CS_AUX_HW_ID_TRACE_ID_MASK     GENMASK_ULL(7, 0)
> >>> -#define CS_AUX_HW_ID_VERSION_MASK      GENMASK_ULL(63, 60)
> >>> +#define CS_AUX_HW_ID_SINK_ID_MASK      GENMASK_ULL(39, 8)
> >>>
> >>> -#define CS_AUX_HW_ID_CURR_VERSION 0
> >>> +#define CS_AUX_HW_ID_MINOR_VERSION_MASK        GENMASK_ULL(59, 56)
> >>> +#define CS_AUX_HW_ID_MAJOR_VERSION_MASK        GENMASK_ULL(63, 60)
> >>> +
> >>> +#define CS_AUX_HW_ID_MAJOR_VERSION 0
> >>> +#define CS_AUX_HW_ID_MINOR_VERSION 1
> >>>
> >>>   #endif
> >>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> >>> index 954a6f7bedf3..87e983da19be 100644
> >>> --- a/tools/perf/util/cs-etm.c
> >>> +++ b/tools/perf/util/cs-etm.c
> >>> @@ -118,6 +118,12 @@ struct cs_etm_queue {
> >>>          struct cs_etm_traceid_queue **traceid_queues;
> >>>          /* Conversion between traceID and metadata pointers */
> >>>          struct intlist *traceid_list;
> >>> +       /*
> >>> +        * Same as traceid_list, but traceid_list may be a reference
> >>> to another
> >>> +        * queue's which has a matching sink ID.
> >>> +        */
> >>> +       struct intlist *own_traceid_list;
> >>> +       u32 sink_id;
> >>>   };
> >>>
> >>>   static int cs_etm__process_timestamped_queues(struct
> >>> cs_etm_auxtrace *etm);
> >>> @@ -142,6 +148,7 @@ static int cs_etm__metadata_set_trace_id(u8
> >>> trace_chan_id, u64 *cpu_metadata);
> >>>                        (queue_nr << 16 | trace_chan_id)
> >>>   #define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
> >>>   #define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
> >>> +#define SINK_UNSET ((u32) -1)
> >>>
> >>>   static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
> >>>   {
> >>> @@ -241,7 +248,16 @@ static int cs_etm__insert_trace_id_node(struct
> >>> cs_etm_queue *etmq,
> >>>                  int err;
> >>>
> >>>                  if (curr_cpu_data[CS_ETM_CPU] !=
> >>> cpu_metadata[CS_ETM_CPU]) {
> >>> -                       pr_err("CS_ETM: map mismatch between HW_ID
> >>> packet CPU and Trace ID\n");
> >>> +                       /*
> >>> +                        * With > CORESIGHT_TRACE_IDS_MAX ETMs,
> >>> overlapping IDs
> >>> +                        * are expected (but not supported) in
> >>> per-thread mode,
> >>> +                        * rather than signifying an error.
> >>> +                        */
> >>> +                       if (etmq->etm->per_thread_decoding)
> >>> +                               pr_err("CS_ETM: overlapping Trace IDs
> >>> aren't currently supported in per-thread mode\n");
> >>> +                       else
> >>> +                               pr_err("CS_ETM: map mismatch between
> >>> HW_ID packet CPU and Trace ID\n");
> >>> +
> >>>                          return -EINVAL;
> >>>                  }
> >>>
> >>> @@ -326,6 +342,64 @@ static int cs_etm__process_trace_id_v0(struct
> >>> cs_etm_auxtrace *etm, int cpu,
> >>>          return cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
> >>>   }
> >>>
> >>> +static int cs_etm__process_trace_id_v0_1(struct cs_etm_auxtrace
> >>> *etm, int cpu,
> >>> +                                        u64 hw_id)
> >>> +{
> >>> +       struct cs_etm_queue *etmq = cs_etm__get_queue(etm, cpu);
> >>> +       int ret;
> >>> +       u64 *cpu_data;
> >>> +       u32 sink_id = FIELD_GET(CS_AUX_HW_ID_SINK_ID_MASK, hw_id);
> >>> +       u8 trace_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
> >>> +
> >>> +       /*
> >>> +        * Check sink id hasn't changed in per-cpu mode. In
> >>> per-thread mode,
> >>> +        * let it pass for now until an actual overlapping trace ID
> >>> is hit. In
> >>> +        * most cases IDs won't overlap even if the sink changes.
> >>> +        */
> >>> +       if (!etmq->etm->per_thread_decoding && etmq->sink_id !=
> >>> SINK_UNSET &&
> >>> +           etmq->sink_id != sink_id) {
> >>> +               pr_err("CS_ETM: mismatch between sink IDs\n");
> >>> +               return -EINVAL;
> >>> +       }
> >>> +
> >>> +       etmq->sink_id = sink_id;
> >>> +
> >>> +       /* Find which other queues use this sink and link their ID
> >>> maps */
> >>> +       for (unsigned int i = 0; i < etm->queues.nr_queues; ++i) {
> >>> +               struct cs_etm_queue *other_etmq =
> >>> etm->queues.queue_array[i].priv;
> >>> +
> >>> +               /* Different sinks, skip */
> >>> +               if (other_etmq->sink_id != etmq->sink_id)
> >>> +                       continue;
> >>> +
> >>> +               /* Already linked, skip */
> >>> +               if (other_etmq->traceid_list == etmq->traceid_list)
> >>> +                       continue;
> >>> +
> >>> +               /* At the point of first linking, this one should be
> >>> empty */
> >>> +               if (!intlist__empty(etmq->traceid_list)) {
> >>> +                       pr_err("CS_ETM: Can't link populated trace ID
> >>> lists\n");
> >>> +                       return -EINVAL;
> >>> +               }
> >>> +
> >>> +               etmq->own_traceid_list = NULL;
> >>> +               intlist__delete(etmq->traceid_list);
> >>> +               etmq->traceid_list = other_etmq->traceid_list;
> >>> +               break;
> >>> +       }
> >>> +
> >>> +       cpu_data = get_cpu_data(etm, cpu);
> >>> +       ret = cs_etm__insert_trace_id_node(etmq, trace_id, cpu_data);
> >>> +       if (ret)
> >>> +               return ret;
> >>> +
> >>> +       ret = cs_etm__metadata_set_trace_id(trace_id, cpu_data);
> >>> +       if (ret)
> >>> +               return ret;
> >>> +
> >>> +       return 0;
> >>> +}
> >>> +
> >>>   static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64
> >>> *cpu_metadata)
> >>>   {
> >>>          u64 cs_etm_magic = cpu_metadata[CS_ETM_MAGIC];
> >>> @@ -414,10 +488,10 @@ static int
> >>> cs_etm__process_aux_output_hw_id(struct perf_session *session,
> >>>
> >>>          /* extract and parse the HW ID */
> >>>          hw_id = event->aux_output_hw_id.hw_id;
> >>> -       version = FIELD_GET(CS_AUX_HW_ID_VERSION_MASK, hw_id);
> >>> +       version = FIELD_GET(CS_AUX_HW_ID_MAJOR_VERSION_MASK, hw_id);
> >>>
> >>>          /* check that we can handle this version */
> >>> -       if (version > CS_AUX_HW_ID_CURR_VERSION) {
> >>> +       if (version > CS_AUX_HW_ID_MAJOR_VERSION) {
> >>>                  pr_err("CS ETM Trace: PERF_RECORD_AUX_OUTPUT_HW_ID
> >>> version %d not supported. Please update Perf.\n",
> >>>                         version);
> >>>                  return -EINVAL;
> >>> @@ -442,7 +516,10 @@ static int
> >>> cs_etm__process_aux_output_hw_id(struct perf_session *session,
> >>>                  return -EINVAL;
> >>>          }
> >>>
> >>> -       return cs_etm__process_trace_id_v0(etm, cpu, hw_id);
> >>
> >> Perhaps leave this as the final statement of the function
> >>
> >>> +       if (FIELD_GET(CS_AUX_HW_ID_MINOR_VERSION_MASK, hw_id) == 0)
> >>
> >> this could be moved before and be
> >>
> >> if (FIELD_GET(CS_AUX_HW_ID_MINOR_VERSION_MASK, hw_id) == 1)
> >>                 return cs_etm__process_trace_id_v0_1(etm, cpu, hw_id);
> >>
> >>
> >
> > Because I was intending minor version changes to be backwards compatible
> > I have it so that any value other than 0 is treated as v0.1. Otherwise
> > version updates will break old versions of Perf. And then if we added a
> > v0.3 it would look like this:
>
> That should have said v0.2 ^
>
> >
> >   if (FIELD_GET(CS_AUX_HW_ID_MINOR_VERSION_MASK, hw_id) == 0)
> >     return cs_etm__process_trace_id_v0(etm, cpu, hw_id);
> >   else if (FIELD_GET(CS_AUX_HW_ID_MINOR_VERSION_MASK, hw_id) == 1)
> >     return cs_etm__process_trace_id_v0_1(etm, cpu, hw_id);
> >   else
> >     return cs_etm__process_trace_id_v0_2(etm, cpu, hw_id);
> >
> > Based on that I'm not sure if you still think it should be changed?



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
