Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040413D291
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309059; cv=none; b=S0sN9AoNIiWaxKEohGw7Ty+x43DqyOU+BNIrCdimy25w6TjJCrD1+Y2BFQ6epkYi60sEX5Vw9BuqVhEE5kEe4aFwtn9ViRPUf8KtE4a/KMWg3zEPrhLDb7vEjYev42fbIQzXhiSY+UVTSfd72C4TzaYTdYS4V/NX2fSjE2eIRCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309059; c=relaxed/simple;
	bh=1LahpwvX/aap+45jqiwywoHlsspS0Ageqd1+bbxxZoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rc8RTOEIgFlYVTggRtv587nZUMiwKwynrZFJN79i6X9ODm+IvEKzlPFuFOtJnEoGSmOEUGydwltIaxb8Ea1ZNQXT5LvqSjUvtvKOQ/EIS+vF4sb5Y5wKt3L0F7fmeREneTk9p3fbF3OLeUmZ66vAP0OYg2a23LaAFUvvmOQlRhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TDw8Cf4j; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDw8Cf4j"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d437791affso405449eaf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721309055; x=1721913855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pI4EM9F9Vsjhha9/smfeT9DRVOc8Np1Ay0JHrwmT9cc=;
        b=TDw8Cf4jZzMw+lEsfmis584FQ/49XOoXfuRYq3GKkhD7HiiKl/nmAefkHhUBTDuVvA
         tSYDiXTT7rfM7Iif8fkeTwjrZ7cuWdUbNfNkETMeaLBOVlSeuYXZUxF+E2HbMDWCSdpr
         knKQIWwQuGx1UFyHGhf4H71YCL4uG4sLV/LHSsIF+NEXjFBBh69pYuWqbriwVAHQebzm
         ARdD4/9fsI4ajnMqKuicDeJP++5itZzQmiqHS4NB+QH4OIDZ+Regbrv1q+ZBonBNB+ak
         KNw4V3HLKdWuRs8vNIHqjxfKl96C8leQVwPpAJevKmNi5EERzY1a3Ik7bEai6qTj8+wG
         vlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309055; x=1721913855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pI4EM9F9Vsjhha9/smfeT9DRVOc8Np1Ay0JHrwmT9cc=;
        b=DZORCq8GiKuNVGUM47DWrW/dKxG6/7cc8I+Dwx71PZAcjvSvB/8WX3TsQPjswv+yGZ
         MA+WTuhc8nBjZaAxmuFKHH/E0AElq0sDJt2Nx/QM52uCdXBmo9nd5dkyZa5e7zJMBIxC
         le8dpItwMIGvD187f48MM97dxHsd3hUXyEV+ZjV4WAzuxCxzr07/IGffQpxoAmq0oebL
         viepHESb5FqOeIe7Kq66OlQebX31y3aeO8jOw1kcC0sf1V5LjZFriVovbFP9KV5J/s9P
         Uk5BTCiJM09J8iie5jNLb3t0oX9v4X7zVOWwQB1k6Y4twwZtHye8S5dxSkc8DEuIrKT3
         GSew==
X-Forwarded-Encrypted: i=1; AJvYcCXCH95rrT8xkA7kq6lDQQmXsWlg37LhQftM/lyEclD8g1i25tAHpDHcc3S2jbsWxv65qQrIjstLOpzHBXu5ZJDLNo5Cz6biQ8bbKwKMm4SRuQ==
X-Gm-Message-State: AOJu0Yyb28cup9UflQRGpBwn6CI+QnNkef9oydti+tMWuSvpQinjv7rV
	DgwaGZ9iN8b5e7Cs6uS9A2coEjfCKuasdOMc//WrlCt+gcc1JBnInVyvfOrLfiB4f5wJfmmwG13
	vJr460iXdiY7S+yiY4wAkpfC86xxux1yOUVwcbg==
X-Google-Smtp-Source: AGHT+IFOA8pbDs9AjQjuDkxcP4ox7Ic6CmL3oc/sQbTdYSIUtEV8JwM3zhsLlo8wjj89Fgb9UB8WXeWqpLWlysxhRCc=
X-Received: by 2002:a05:6870:a91d:b0:258:3455:4b02 with SMTP id
 586e51a60fabf-260d9289bf7mr4158254fac.51.1721309055471; Thu, 18 Jul 2024
 06:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-3-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-3-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 18 Jul 2024 14:24:03 +0100
Message-ID: <CAJ9a7VgUXpOo7we8v8mCMDWNtCGsHmBi5tk8YA-MeNhHk59zLg@mail.gmail.com>
Subject: Re: [PATCH v5 02/17] perf: cs-etm: Allocate queues for all CPUs
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

Hi James

On Fri, 12 Jul 2024 at 11:22, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> Make cs_etm__setup_queue() setup a queue even if it's empty, and
> pre-allocate queues based on the max CPU that was recorded. In per-CPU
> mode aux queues are indexed based on CPU ID even if all CPUs aren't
> recorded, sparse queue arrays aren't used.
>
> This will allow HW_IDs to be saved even if no aux data was received in
> that queue without having to call cs_etm__setup_queue() from two
> different places.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 76 +++++++++++++++++++++-------------------
>  1 file changed, 40 insertions(+), 36 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index f09004c4ba44..1a95c4bb898f 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -97,13 +97,19 @@ struct cs_etm_traceid_queue {
>         struct cs_etm_packet_queue packet_queue;
>  };
>
> +enum cs_etm_format {
> +       UNSET,
> +       FORMATTED,
> +       UNFORMATTED
> +};
> +

Minor Nit: Could this...

>  struct cs_etm_queue {
>         struct cs_etm_auxtrace *etm;
>         struct cs_etm_decoder *decoder;
>         struct auxtrace_buffer *buffer;
>         unsigned int queue_nr;
>         u8 pending_timestamp_chan_id;
> -       bool formatted;
> +       enum cs_etm_format format;

and this be introduced in the previous set? Avoid a bit of churn?

>         u64 offset;
>         const unsigned char *buf;
>         size_t buf_len, buf_used;
> @@ -697,7 +703,7 @@ static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
>
>  static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>                                      struct cs_etm_auxtrace *etm,
> -                                    bool formatted,
> +                                    enum cs_etm_format format,
>                                      int sample_cpu,
>                                      int decoders)
>  {
> @@ -706,7 +712,7 @@ static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>         u64 architecture;
>
>         for (t_idx = 0; t_idx < decoders; t_idx++) {
> -               if (formatted)
> +               if (format == FORMATTED)
>                         m_idx = t_idx;
>                 else {
>                         m_idx = get_cpu_data_idx(etm, sample_cpu);
> @@ -749,7 +755,7 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
>         d_params->packet_printer = cs_etm__packet_dump;
>         d_params->operation = mode;
>         d_params->data = etmq;
> -       d_params->formatted = etmq->formatted;
> +       d_params->formatted = etmq->format == FORMATTED;
>         d_params->fsyncs = false;
>         d_params->hsyncs = false;
>         d_params->frame_aligned = true;
> @@ -1056,16 +1062,11 @@ static struct cs_etm_queue *cs_etm__alloc_queue(void)
>
>  static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>                                struct auxtrace_queue *queue,
> -                              unsigned int queue_nr, bool formatted)
> +                              unsigned int queue_nr)
>  {
>         struct cs_etm_queue *etmq = queue->priv;
>
> -       if (etmq && formatted != etmq->formatted) {
> -               pr_err("CS_ETM: mixed formatted and unformatted trace not supported\n");
> -               return -EINVAL;
> -       }
> -
> -       if (list_empty(&queue->head) || etmq)
> +       if (etmq)
>                 return 0;
>
>         etmq = cs_etm__alloc_queue();
> @@ -1078,7 +1079,6 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>         etmq->queue_nr = queue_nr;
>         queue->cpu = queue_nr; /* Placeholder, may be reset to -1 in per-thread mode */
>         etmq->offset = 0;
> -       etmq->formatted = formatted;
>
>         return 0;
>  }
> @@ -2791,17 +2791,6 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
>                 if (err)
>                         return err;
>
> -               /*
> -                * Knowing if the trace is formatted or not requires a lookup of
> -                * the aux record so only works in non-piped mode where data is
> -                * queued in cs_etm__queue_aux_records(). Always assume
> -                * formatted in piped mode (true).
> -                */
> -               err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
> -                                         idx, true);
> -               if (err)
> -                       return err;
> -
>                 if (dump_trace)
>                         if (auxtrace_buffer__get_data(buffer, fd)) {
>                                 cs_etm__dump_event(etm->queues.queue_array[idx].priv, buffer);
> @@ -2918,8 +2907,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>         struct perf_record_auxtrace *auxtrace_event;
>         union perf_event auxtrace_fragment;
>         __u64 aux_offset, aux_size;
> -       __u32 idx;
> -       bool formatted;
> +       enum cs_etm_format format;
>
>         struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>                                                    struct cs_etm_auxtrace,
> @@ -2985,6 +2973,8 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>
>         if (aux_offset >= auxtrace_event->offset &&
>             aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
> +               struct cs_etm_queue *etmq = etm->queues.queue_array[auxtrace_event->idx].priv;
> +
>                 /*
>                  * If this AUX event was inside this buffer somewhere, create a new auxtrace event
>                  * based on the sizes of the aux event, and queue that fragment.
> @@ -3001,10 +2991,14 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>                 if (err)
>                         return err;
>
> -               idx = auxtrace_event->idx;
> -               formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
> -
> -               return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx], idx, formatted);
> +               format = (aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW) ?
> +                               UNFORMATTED : FORMATTED;
> +               if (etmq->format != UNSET && format != etmq->format) {
> +                       pr_err("CS_ETM: mixed formatted and unformatted trace not supported\n");
> +                       return -EINVAL;
> +               }
> +               etmq->format = format;
> +               return 0;
>         }
>
>         /* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
> @@ -3200,7 +3194,7 @@ static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
>          * Each queue can only contain data from one CPU when unformatted, so only one decoder is
>          * needed.
>          */
> -       int decoders = etmq->formatted ? etmq->etm->num_cpu : 1;
> +       int decoders = etmq->format == FORMATTED ? etmq->etm->num_cpu : 1;
>
>         /* Use metadata to fill in trace parameters for trace decoder */
>         struct cs_etm_trace_params  *t_params = zalloc(sizeof(*t_params) * decoders);
> @@ -3208,7 +3202,7 @@ static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
>         if (!t_params)
>                 goto out_free;
>
> -       if (cs_etm__init_trace_params(t_params, etmq->etm, etmq->formatted,
> +       if (cs_etm__init_trace_params(t_params, etmq->etm, etmq->format,
>                                       etmq->queue_nr, decoders))
>                 goto out_free;
>
> @@ -3256,6 +3250,7 @@ static int cs_etm__create_decoders(struct cs_etm_auxtrace *etm)
>                  * Don't create decoders for empty queues, mainly because
>                  * etmq->formatted is unknown for empty queues.
>                  */
> +               assert(empty == (etmq->format == UNSET));
>                 if (empty)
>                         continue;
>
> @@ -3275,10 +3270,10 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>         int event_header_size = sizeof(struct perf_event_header);
>         int total_size = auxtrace_info->header.size;
>         int priv_size = 0;
> -       int num_cpu;
> +       int num_cpu, max_cpu = 0;
>         int err = 0;
>         int aux_hw_id_found;
> -       int i, j;
> +       int i;
>         u64 *ptr = NULL;
>         u64 **metadata = NULL;
>
> @@ -3309,7 +3304,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>          * required by the trace decoder to properly decode the trace due
>          * to its highly compressed nature.
>          */
> -       for (j = 0; j < num_cpu; j++) {
> +       for (int j = 0; j < num_cpu; j++) {
>                 if (ptr[i] == __perf_cs_etmv3_magic) {
>                         metadata[j] =
>                                 cs_etm__create_meta_blk(ptr, &i,
> @@ -3333,6 +3328,9 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>                         err = -ENOMEM;
>                         goto err_free_metadata;
>                 }
> +
> +               if ((int) metadata[j][CS_ETM_CPU] > max_cpu)
> +                       max_cpu = metadata[j][CS_ETM_CPU];
>         }
>
>         /*
> @@ -3362,10 +3360,16 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>          */
>         etm->pid_fmt = cs_etm__init_pid_fmt(metadata[0]);
>
> -       err = auxtrace_queues__init(&etm->queues);
> +       err = auxtrace_queues__init_nr(&etm->queues, max_cpu + 1);
>         if (err)
>                 goto err_free_etm;
>
> +       for (unsigned int j = 0; j < etm->queues.nr_queues; ++j) {
> +               err = cs_etm__setup_queue(etm, &etm->queues.queue_array[j], j);
> +               if (err)
> +                       goto err_free_queues;
> +       }
> +
>         if (session->itrace_synth_opts->set) {
>                 etm->synth_opts = *session->itrace_synth_opts;
>         } else {
> @@ -3487,7 +3491,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>         zfree(&etm);
>  err_free_metadata:
>         /* No need to check @metadata[j], free(NULL) is supported */
> -       for (j = 0; j < num_cpu; j++)
> +       for (int j = 0; j < num_cpu; j++)
>                 zfree(&metadata[j]);
>         zfree(&metadata);
>  err_free_traceid_list:
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
