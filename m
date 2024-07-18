Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A613F428
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309072; cv=none; b=UcDh5MjiFEjJi94SofMFLoAglHuFVXcPJSoBwOlozbMR3FdZJp71CxePAyhZaknrL/WdzRuSeZTx0sijfSutqomRb/NyaDIzVqSb78MOiao/qNCWbXk0Iz23x5YGu/BE0TPkBJdy7rSGXnK96kDCD5FHX++IjSQcqsTjeQhx8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309072; c=relaxed/simple;
	bh=sQdUyUflChED37G9I5udnUkU7wbW1NNSKdggCRd7JuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogx8voX8uCO5yFd6Jq9FQefW0aePkqt6EroxC+zwt/wncXcXcgA6qzOLhDSa1rjkUtIWmO9Fs4cH9MhFcRPXI2Ge3a7f9dhm1MZI1feZ1nHzPZcGFE59YfpdL+7+bw1g9A+5GNd0zQM3Zv0gOt3eyO8vbbFhg8bgbG2fdJ89eKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=clJAC5qf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clJAC5qf"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70af2b1a35aso570120b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 06:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721309069; x=1721913869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5/nDkwWOKsyKTm/bM7rzI+TE2l1M41qAiWETlSQcopg=;
        b=clJAC5qflBsfcKMXVCTwNqj/A4o5pIiOQ/naRftzjVcJW3inpu8PMAuEsR5fRun2VZ
         VrH7k9HdJ3fx/S2qFRpg00nQB0HuPe8qiyMxjjnlV2YM3kzGkKRYmprC89vKEhvaK0nm
         g3DUtamsPE41AIwTjmQUMX/evoXbi0HpoENxkyEbtTubPOUxt8P6mogRMZRvlETf+xQF
         5z0CBBKCxzfB09apGnwYimPb/FEjYk/A8c6abCVINhu8hMuY8p4iikqpiZwDnmChcW7a
         ktweqpZxkn27sUB0kGDwxQnj9J0ujaWrZCYJJSjY27eJs3q7R4hRgyu9qDSeMLGnJhPX
         8SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309069; x=1721913869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/nDkwWOKsyKTm/bM7rzI+TE2l1M41qAiWETlSQcopg=;
        b=H+ZmcFvmAlmzGaC1dfxB7ahOWf24qvyqbzb56QoWuScCZhQT9Bpv44m6O2xsrZbJXN
         /TlJZNu9ef+ba2IqHWoIyYL23I/sJ8+XnYOJwQqxX+xKtJmAc4ZfoAlS492rp9zgbBHf
         iXShIGCUfouCEA/nG4Zxbt9ZW6g8DE92dyKvAVWVFmdsCLcqka4xRXYzgH8ScMTaBp1Z
         Uxjvjq5U0gDyGziDnI1v8wRgD5UjgpG+XJY3rvA79D64zpxZ1su7m4kmuHIVwM5mWerg
         qYYz/Wx+nwlVVkzVjS/Fn/QYR3VXkXMTaPyngEURxPDAyL/6NkgSvpipM7Rqa6y3qfT8
         iQCw==
X-Forwarded-Encrypted: i=1; AJvYcCW1oaV751aQQRV0VCLsW6eHyg1HD9hMe/DNGGqYBCfS2On04HSf6fkxcVL5MpqzRVC4tMi7s7dNPy95e61Mfk/955QWGco+vxGYRUsHJWF0eg==
X-Gm-Message-State: AOJu0Yw6Lc/T8yYNx2+Ohfj2gqTugRD6FlXFsqll/aTzeiovIVTFAC2q
	tY1sRc/AqVKKZB0hGZm0sTX3b3O5gZkPweKgSBHvGWRnEzgjUFqC5vUtIP9pZ1uogP1guQSoNFA
	rS2eadEnVVtBQFuHrkjx6Fod0/fCUT9Uj7qpiGw==
X-Google-Smtp-Source: AGHT+IG7xPruEKEfjt2r16+5Ow/8qdH4ipfvVqxuMlOULWD+poX9/fl030acZ6AtDiRKrWULbGyF92CcZJMb5CHcRJ4=
X-Received: by 2002:a05:6a00:190b:b0:705:c029:c9a7 with SMTP id
 d2e1a72fcca58-70ce4f20bccmr6351983b3a.15.1721309069327; Thu, 18 Jul 2024
 06:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-5-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-5-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 18 Jul 2024 14:24:18 +0100
Message-ID: <CAJ9a7Vh3kyreU_cHNYh0uc5zD4r7JRPnrzpT3NrXyXmve-dYOQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/17] perf: cs-etm: Create decoders based on the trace
 ID mappings
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

On Fri, 12 Jul 2024 at 11:22, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> Now that each queue has a unique set of trace ID mappings, use this
> list to create the decoders. In unformatted mode just add a single
> mapping so only one decoder is made.
>
> Previously each queue would have a decoder created for each traced CPU
> on the system but this won't work anymore because CPUs can have
> overlapping trace IDs.
>
> This also means that the CORESIGHT_TRACE_ID_UNUSED_FLAG isn't needed
> any more. If mappings aren't added then decoders aren't created, rather
> than needing a flag to suppress creation.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/arch/arm/util/cs-etm.c             |   8 +-
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   4 -
>  tools/perf/util/cs-etm.c                      | 155 ++++++------------
>  tools/perf/util/cs-etm.h                      |  10 --
>  4 files changed, 55 insertions(+), 122 deletions(-)
>
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index da6231367993..b0118546cd4d 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -654,8 +654,7 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
>         /* Get trace configuration register */
>         data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_get_config(itr);
>         /* traceID set to legacy version, in case new perf running on older system */
> -       data[CS_ETMV4_TRCTRACEIDR] = cs_etm_get_legacy_trace_id(cpu) |
> -                                    CORESIGHT_TRACE_ID_UNUSED_FLAG;
> +       data[CS_ETMV4_TRCTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
>
>         /* Get read-only information from sysFS */
>         cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0],
> @@ -687,7 +686,7 @@ static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, st
>         /* Get trace configuration register */
>         data[CS_ETE_TRCCONFIGR] = cs_etmv4_get_config(itr);
>         /* traceID set to legacy version, in case new perf running on older system */
> -       data[CS_ETE_TRCTRACEIDR] = cs_etm_get_legacy_trace_id(cpu) | CORESIGHT_TRACE_ID_UNUSED_FLAG;
> +       data[CS_ETE_TRCTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
>
>         /* Get read-only information from sysFS */
>         cs_etm_get_ro(cs_etm_pmu, cpu, metadata_ete_ro[CS_ETE_TRCIDR0], &data[CS_ETE_TRCIDR0]);
> @@ -743,8 +742,7 @@ static void cs_etm_get_metadata(struct perf_cpu cpu, u32 *offset,
>                 /* Get configuration register */
>                 info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
>                 /* traceID set to legacy value in case new perf running on old system */
> -               info->priv[*offset + CS_ETM_ETMTRACEIDR] = cs_etm_get_legacy_trace_id(cpu) |
> -                                                          CORESIGHT_TRACE_ID_UNUSED_FLAG;
> +               info->priv[*offset + CS_ETM_ETMTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
>                 /* Get read-only information from sysFS */
>                 cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv3_ro[CS_ETM_ETMCCER],
>                               &info->priv[*offset + CS_ETM_ETMCCER]);
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 0c9c48cedbf1..d49c3e9c7c21 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -684,10 +684,6 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>                 return -1;
>         }
>
> -       /* if the CPU has no trace ID associated, no decoder needed */
> -       if (csid == CORESIGHT_TRACE_ID_UNUSED_VAL)
> -               return 0;
> -
>         if (d_params->operation == CS_ETM_OPERATION_DECODE) {
>                 if (ocsd_dt_create_decoder(decoder->dcd_tree,
>                                            decoder->decoder_name,
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 0cd7d3843411..954a6f7bedf3 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -348,7 +348,6 @@ static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata)
>
>  /*
>   * update metadata trace ID from the value found in the AUX_HW_INFO packet.
> - * This will also clear the CORESIGHT_TRACE_ID_UNUSED_FLAG flag if present.
>   */
>  static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
>  {
> @@ -700,80 +699,58 @@ static void cs_etm__packet_dump(const char *pkt_string)
>  }
>
>  static void cs_etm__set_trace_param_etmv3(struct cs_etm_trace_params *t_params,
> -                                         struct cs_etm_auxtrace *etm, int t_idx,
> -                                         int m_idx, u32 etmidr)
> +                                         u64 *metadata, u32 etmidr)
>  {
> -       u64 **metadata = etm->metadata;
> -
> -       t_params[t_idx].protocol = cs_etm__get_v7_protocol_version(etmidr);
> -       t_params[t_idx].etmv3.reg_ctrl = metadata[m_idx][CS_ETM_ETMCR];
> -       t_params[t_idx].etmv3.reg_trc_id = metadata[m_idx][CS_ETM_ETMTRACEIDR];
> +       t_params->protocol = cs_etm__get_v7_protocol_version(etmidr);
> +       t_params->etmv3.reg_ctrl = metadata[CS_ETM_ETMCR];
> +       t_params->etmv3.reg_trc_id = metadata[CS_ETM_ETMTRACEIDR];
>  }
>
>  static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
> -                                         struct cs_etm_auxtrace *etm, int t_idx,
> -                                         int m_idx)
> +                                         u64 *metadata)
>  {
> -       u64 **metadata = etm->metadata;
> -
> -       t_params[t_idx].protocol = CS_ETM_PROTO_ETMV4i;
> -       t_params[t_idx].etmv4.reg_idr0 = metadata[m_idx][CS_ETMV4_TRCIDR0];
> -       t_params[t_idx].etmv4.reg_idr1 = metadata[m_idx][CS_ETMV4_TRCIDR1];
> -       t_params[t_idx].etmv4.reg_idr2 = metadata[m_idx][CS_ETMV4_TRCIDR2];
> -       t_params[t_idx].etmv4.reg_idr8 = metadata[m_idx][CS_ETMV4_TRCIDR8];
> -       t_params[t_idx].etmv4.reg_configr = metadata[m_idx][CS_ETMV4_TRCCONFIGR];
> -       t_params[t_idx].etmv4.reg_traceidr = metadata[m_idx][CS_ETMV4_TRCTRACEIDR];
> +       t_params->protocol = CS_ETM_PROTO_ETMV4i;
> +       t_params->etmv4.reg_idr0 = metadata[CS_ETMV4_TRCIDR0];
> +       t_params->etmv4.reg_idr1 = metadata[CS_ETMV4_TRCIDR1];
> +       t_params->etmv4.reg_idr2 = metadata[CS_ETMV4_TRCIDR2];
> +       t_params->etmv4.reg_idr8 = metadata[CS_ETMV4_TRCIDR8];
> +       t_params->etmv4.reg_configr = metadata[CS_ETMV4_TRCCONFIGR];
> +       t_params->etmv4.reg_traceidr = metadata[CS_ETMV4_TRCTRACEIDR];
>  }
>
>  static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
> -                                         struct cs_etm_auxtrace *etm, int t_idx,
> -                                         int m_idx)
> +                                       u64 *metadata)
>  {
> -       u64 **metadata = etm->metadata;
> -
> -       t_params[t_idx].protocol = CS_ETM_PROTO_ETE;
> -       t_params[t_idx].ete.reg_idr0 = metadata[m_idx][CS_ETE_TRCIDR0];
> -       t_params[t_idx].ete.reg_idr1 = metadata[m_idx][CS_ETE_TRCIDR1];
> -       t_params[t_idx].ete.reg_idr2 = metadata[m_idx][CS_ETE_TRCIDR2];
> -       t_params[t_idx].ete.reg_idr8 = metadata[m_idx][CS_ETE_TRCIDR8];
> -       t_params[t_idx].ete.reg_configr = metadata[m_idx][CS_ETE_TRCCONFIGR];
> -       t_params[t_idx].ete.reg_traceidr = metadata[m_idx][CS_ETE_TRCTRACEIDR];
> -       t_params[t_idx].ete.reg_devarch = metadata[m_idx][CS_ETE_TRCDEVARCH];
> +       t_params->protocol = CS_ETM_PROTO_ETE;
> +       t_params->ete.reg_idr0 = metadata[CS_ETE_TRCIDR0];
> +       t_params->ete.reg_idr1 = metadata[CS_ETE_TRCIDR1];
> +       t_params->ete.reg_idr2 = metadata[CS_ETE_TRCIDR2];
> +       t_params->ete.reg_idr8 = metadata[CS_ETE_TRCIDR8];
> +       t_params->ete.reg_configr = metadata[CS_ETE_TRCCONFIGR];
> +       t_params->ete.reg_traceidr = metadata[CS_ETE_TRCTRACEIDR];
> +       t_params->ete.reg_devarch = metadata[CS_ETE_TRCDEVARCH];
>  }
>
>  static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
> -                                    struct cs_etm_auxtrace *etm,
> -                                    enum cs_etm_format format,
> -                                    int sample_cpu,
> -                                    int decoders)
> -{
> -       int t_idx, m_idx;
> -       u32 etmidr;
> -       u64 architecture;
> -
> -       for (t_idx = 0; t_idx < decoders; t_idx++) {
> -               if (format == FORMATTED)
> -                       m_idx = t_idx;
> -               else {
> -                       m_idx = get_cpu_data_idx(etm, sample_cpu);
> -                       if (m_idx == -1) {
> -                               pr_warning("CS_ETM: unknown CPU, falling back to first metadata\n");
> -                               m_idx = 0;
> -                       }
> -               }
> +                                    struct cs_etm_queue *etmq)
> +{
> +       struct int_node *inode;
>
> -               architecture = etm->metadata[m_idx][CS_ETM_MAGIC];
> +       intlist__for_each_entry(inode, etmq->traceid_list) {
> +               u64 *metadata = inode->priv;
> +               u64 architecture = metadata[CS_ETM_MAGIC];
> +               u32 etmidr;
>
>                 switch (architecture) {
>                 case __perf_cs_etmv3_magic:
> -                       etmidr = etm->metadata[m_idx][CS_ETM_ETMIDR];
> -                       cs_etm__set_trace_param_etmv3(t_params, etm, t_idx, m_idx, etmidr);
> +                       etmidr = metadata[CS_ETM_ETMIDR];
> +                       cs_etm__set_trace_param_etmv3(t_params++, metadata, etmidr);
>                         break;
>                 case __perf_cs_etmv4_magic:
> -                       cs_etm__set_trace_param_etmv4(t_params, etm, t_idx, m_idx);
> +                       cs_etm__set_trace_param_etmv4(t_params++, metadata);
>                         break;
>                 case __perf_cs_ete_magic:
> -                       cs_etm__set_trace_param_ete(t_params, etm, t_idx, m_idx);
> +                       cs_etm__set_trace_param_ete(t_params++, metadata);
>                         break;
>                 default:
>                         return -EINVAL;
> @@ -3211,35 +3188,6 @@ static int cs_etm__map_trace_ids_metadata(struct cs_etm_auxtrace *etm, int num_c
>         return 0;
>  }
>
> -/*
> - * If we found AUX_HW_ID packets, then set any metadata marked as unused to the
> - * unused value to reduce the number of unneeded decoders created.
> - */
> -static int cs_etm__clear_unused_trace_ids_metadata(int num_cpu, u64 **metadata)
> -{
> -       u64 cs_etm_magic;
> -       int i;
> -
> -       for (i = 0; i < num_cpu; i++) {
> -               cs_etm_magic = metadata[i][CS_ETM_MAGIC];
> -               switch (cs_etm_magic) {
> -               case __perf_cs_etmv3_magic:
> -                       if (metadata[i][CS_ETM_ETMTRACEIDR] & CORESIGHT_TRACE_ID_UNUSED_FLAG)
> -                               metadata[i][CS_ETM_ETMTRACEIDR] = CORESIGHT_TRACE_ID_UNUSED_VAL;
> -                       break;
> -               case __perf_cs_etmv4_magic:
> -               case __perf_cs_ete_magic:
> -                       if (metadata[i][CS_ETMV4_TRCTRACEIDR] & CORESIGHT_TRACE_ID_UNUSED_FLAG)
> -                               metadata[i][CS_ETMV4_TRCTRACEIDR] = CORESIGHT_TRACE_ID_UNUSED_VAL;
> -                       break;
> -               default:
> -                       /* unknown magic number */
> -                       return -EINVAL;
> -               }
> -       }
> -       return 0;
> -}
> -
>  /*
>   * Use the data gathered by the peeks for HW_ID (trace ID mappings) and AUX
>   * (formatted or not) packets to create the decoders.
> @@ -3247,21 +3195,26 @@ static int cs_etm__clear_unused_trace_ids_metadata(int num_cpu, u64 **metadata)
>  static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
>  {
>         struct cs_etm_decoder_params d_params;
> +       struct cs_etm_trace_params  *t_params;
> +       int decoders = intlist__nr_entries(etmq->traceid_list);
> +
> +       if (decoders == 0)
> +               return 0;
>
>         /*
>          * Each queue can only contain data from one CPU when unformatted, so only one decoder is
>          * needed.
>          */
> -       int decoders = etmq->format == FORMATTED ? etmq->etm->num_cpu : 1;
> +       if (etmq->format == UNFORMATTED)
> +               assert(decoders == 1);
>
>         /* Use metadata to fill in trace parameters for trace decoder */
> -       struct cs_etm_trace_params  *t_params = zalloc(sizeof(*t_params) * decoders);
> +       t_params = zalloc(sizeof(*t_params) * decoders);
>
>         if (!t_params)
>                 goto out_free;
>
> -       if (cs_etm__init_trace_params(t_params, etmq->etm, etmq->format,
> -                                     etmq->queue_nr, decoders))
> +       if (cs_etm__init_trace_params(t_params, etmq))
>                 goto out_free;
>
>         /* Set decoder parameters to decode trace packets */
> @@ -3487,9 +3440,9 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>         /*
>          * Map Trace ID values to CPU metadata.
>          *
> -        * Trace metadata will always contain Trace ID values from the legacy algorithm. If the
> -        * files has been recorded by a "new" perf updated to handle AUX_HW_ID then the metadata
> -        * ID value will also have the CORESIGHT_TRACE_ID_UNUSED_FLAG set.
> +        * Trace metadata will always contain Trace ID values from the legacy algorithm
> +        * in case it's read by a version of Perf that doesn't know about HW_ID packets
> +        * or the kernel doesn't emit them.
>          *
>          * The updated kernel drivers that use AUX_HW_ID to sent Trace IDs will attempt to use
>          * the same IDs as the old algorithm as far as is possible, unless there are clashes
> @@ -3498,12 +3451,11 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>          *
>          * For a perf able to interpret AUX_HW_ID packets we first check for the presence of
>          * those packets. If they are there then the values will be mapped and plugged into
> -        * the metadata. We then set any remaining metadata values with the used flag to a
> -        * value CORESIGHT_TRACE_ID_UNUSED_VAL - which indicates no decoder is required.
> +        * the metadata and decoders are only created for each mapping received.
>          *
>          * If no AUX_HW_ID packets are present - which means a file recorded on an old kernel
> -        * then we map Trace ID values to CPU directly from the metadata - clearing any unused
> -        * flags if present.
> +        * then we map Trace ID values to CPU directly from the metadata and create decoders
> +        * for all mappings.
>          */
>
>         /* Scan for AUX_OUTPUT_HW_ID records to map trace ID values to CPU metadata */
> @@ -3514,15 +3466,12 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>         if (err)
>                 goto err_free_queues;
>
> -       /* if HW ID found then clear any unused metadata ID values */
> -       if (aux_hw_id_found)
> -               err = cs_etm__clear_unused_trace_ids_metadata(num_cpu, metadata);
> -       /* otherwise, this is a file with metadata values only, map from metadata */
> -       else
> +       /* if no HW ID found this is a file with metadata values only, map from metadata */
> +       if (!aux_hw_id_found) {
>                 err = cs_etm__map_trace_ids_metadata(etm, num_cpu, metadata);
> -
> -       if (err)
> -               goto err_free_queues;
> +               if (err)
> +                       goto err_free_queues;
> +       }
>
>         err = cs_etm__create_decoders(etm);
>         if (err)
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index f4f69f7cc0f3..a8caeea720aa 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -230,16 +230,6 @@ struct cs_etm_packet_queue {
>  /* CoreSight trace ID is currently the bottom 7 bits of the value */
>  #define CORESIGHT_TRACE_ID_VAL_MASK    GENMASK(6, 0)
>
> -/*
> - * perf record will set the legacy meta data values as unused initially.
> - * This allows perf report to manage the decoders created when dynamic
> - * allocation in operation.
> - */
> -#define CORESIGHT_TRACE_ID_UNUSED_FLAG BIT(31)
> -
> -/* Value to set for unused trace ID values */
> -#define CORESIGHT_TRACE_ID_UNUSED_VAL  0x7F
> -
>  int cs_etm__process_auxtrace_info(union perf_event *event,
>                                   struct perf_session *session);
>  void cs_etm_get_default_config(const struct perf_pmu *pmu, struct perf_event_attr *attr);
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
