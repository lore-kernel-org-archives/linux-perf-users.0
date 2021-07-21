Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA72C12002
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 16:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C227A61242
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 16:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhGUPYy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhGUPYx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jul 2021 11:24:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF58C061757
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jul 2021 09:05:30 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d12so2579508pfj.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jul 2021 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CGpixdwO7S1rtC4H5PLra/JF15vH5Z2FO/vDmyJkJCY=;
        b=zy/yk5PdgpZ09jUzAIhm6OJ/jZVUOLlg3DrvB4ZhRyXKQ8IJPDCay3t57CzO7CNFph
         cPQ8TiYVKrWPE3zEsGC7HJzMarSeTSoNnumeO7mF/D2wnviQiYbIvrG+7sJuilZo0TiX
         MIwwcyil7lfV20bZK6J4vuQZQ1uKJ47OxZ+tXQsSmdZEoW6XBozN/0Px2XLut0pFlLhW
         3ipGtwgJhJ4xjCpPXJ9fyJzhBLOlkjEPvdVTVmj3nC8YHoObOMyv6Ichpe9hHRzmJMSA
         9DdgXDkG/FVCt08zJDMsqzCr1vH9xqETYfk+hnU6fv1g1rRkYtgXHE40aWSCKOMa8HvF
         zNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CGpixdwO7S1rtC4H5PLra/JF15vH5Z2FO/vDmyJkJCY=;
        b=ehcCUSJ6AbvamITTDJWHX0tUxTH6GGTRN39YmP/WmF0otrf5tUADfH6Ja/VzxG6YDy
         P/dUAOFoYmEo91sFe6bTf/pY+9yBH8LfYx0xsubykR6np0DkBSgSZov8be6CdAH9nZEc
         Uq6OERrjpfK4p0dFMFMGBslxH5pg5EnpsmmUhvAspPtgTClthSGCpU6gWZMWIgVsuYMC
         RYHmNWSx1DP2jFhhnWIU7OKf+N6kD7984KFmjphyLGiVgCpoNL/SEPZVhAnX/NC+s7JM
         Vy+kLBAqCk/MnLAwXJCH+37tQpdRLJKI6fUvOPt9uu5aOxLlU/coLIRtdWhrb8Fmj6f2
         clQg==
X-Gm-Message-State: AOAM533am5IzVB9kcKNJmJZ53vLHINfn12Jg7p15Y7SiIcpXRDvpqP88
        7okRzJyyN341X573GSLAfAASIQ==
X-Google-Smtp-Source: ABdhPJxWoDOsxiyBezzrV73RXSCqJWMdMtgO5FSvBKjrjA1h1cvQFu6ROZ2dOE8hLSRB3qKxKGXhHA==
X-Received: by 2002:a63:67c5:: with SMTP id b188mr37038490pgc.333.1626883529937;
        Wed, 21 Jul 2021 09:05:29 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p24sm31234336pgl.68.2021.07.21.09.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 09:05:25 -0700 (PDT)
Date:   Wed, 21 Jul 2021 10:05:23 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, coresight@lists.linaro.org, leo.yan@linaro.org,
        al.grant@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] perf cs-etm: Pass unformatted flag to decoder
Message-ID: <20210721160523.GA2377909@p14s>
References: <20210721150202.32065-1-james.clark@arm.com>
 <20210721150202.32065-7-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721150202.32065-7-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 21, 2021 at 04:02:02PM +0100, James Clark wrote:
> The TRBE (Trace Buffer Extension) feature allows a separate trace buffer
> for each trace source, therefore the trace wouldn't need to be
> formatted. The driver was introduced in commit 3fbf7f011f24
> ("coresight: sink: Add TRBE driver").
> 
> The formatted/unformatted mode is encoded in one of the flags of the
> AUX record. The first AUX record encountered for each event is used to
> determine the mode, and this will persist for the remaining trace that
> is either decoded or dumped.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  4 +-
>  tools/perf/util/cs-etm.c                      | 53 ++++++++++++++-----
>  2 files changed, 42 insertions(+), 15 deletions(-)
> 

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Arnaldo, please consider adding this set to your tree.

Thanks,
Mathieu

> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index ed1f0326f859..9c9039ae6989 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -687,7 +687,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>  }
>  
>  struct cs_etm_decoder *
> -cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
> +cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
>  		    struct cs_etm_trace_params t_params[])
>  {
>  	struct cs_etm_decoder *decoder;
> @@ -732,7 +732,7 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
>  	/* init raw frame logging if required */
>  	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
>  
> -	for (i = 0; i < num_cpu; i++) {
> +	for (i = 0; i < decoders; i++) {
>  		ret = cs_etm_decoder__create_etm_decoder(d_params,
>  							 &t_params[i],
>  							 decoder);
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 760050ea936d..f4b2bff533f3 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -461,13 +461,14 @@ static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
>  }
>  
>  static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
> -				     struct cs_etm_auxtrace *etm)
> +				     struct cs_etm_auxtrace *etm,
> +				     int decoders)
>  {
>  	int i;
>  	u32 etmidr;
>  	u64 architecture;
>  
> -	for (i = 0; i < etm->num_cpu; i++) {
> +	for (i = 0; i < decoders; i++) {
>  		architecture = etm->metadata[i][CS_ETM_MAGIC];
>  
>  		switch (architecture) {
> @@ -488,7 +489,8 @@ static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>  
>  static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
>  				       struct cs_etm_queue *etmq,
> -				       enum cs_etm_decoder_operation mode)
> +				       enum cs_etm_decoder_operation mode,
> +				       bool formatted)
>  {
>  	int ret = -EINVAL;
>  
> @@ -498,7 +500,7 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
>  	d_params->packet_printer = cs_etm__packet_dump;
>  	d_params->operation = mode;
>  	d_params->data = etmq;
> -	d_params->formatted = true;
> +	d_params->formatted = formatted;
>  	d_params->fsyncs = false;
>  	d_params->hsyncs = false;
>  	d_params->frame_aligned = true;
> @@ -720,11 +722,17 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
>  	return len;
>  }
>  
> -static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
> +static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
> +						bool formatted)
>  {
>  	struct cs_etm_decoder_params d_params;
>  	struct cs_etm_trace_params  *t_params = NULL;
>  	struct cs_etm_queue *etmq;
> +	/*
> +	 * Each queue can only contain data from one CPU when unformatted, so only one decoder is
> +	 * needed.
> +	 */
> +	int decoders = formatted ? etm->num_cpu : 1;
>  
>  	etmq = zalloc(sizeof(*etmq));
>  	if (!etmq)
> @@ -735,21 +743,23 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
>  		goto out_free;
>  
>  	/* Use metadata to fill in trace parameters for trace decoder */
> -	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
> +	t_params = zalloc(sizeof(*t_params) * decoders);
>  
>  	if (!t_params)
>  		goto out_free;
>  
> -	if (cs_etm__init_trace_params(t_params, etm))
> +	if (cs_etm__init_trace_params(t_params, etm, decoders))
>  		goto out_free;
>  
>  	/* Set decoder parameters to decode trace packets */
>  	if (cs_etm__init_decoder_params(&d_params, etmq,
>  					dump_trace ? CS_ETM_OPERATION_PRINT :
> -						     CS_ETM_OPERATION_DECODE))
> +						     CS_ETM_OPERATION_DECODE,
> +					formatted))
>  		goto out_free;
>  
> -	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
> +	etmq->decoder = cs_etm_decoder__new(decoders, &d_params,
> +					    t_params);
>  
>  	if (!etmq->decoder)
>  		goto out_free;
> @@ -777,14 +787,15 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
>  
>  static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  			       struct auxtrace_queue *queue,
> -			       unsigned int queue_nr)
> +			       unsigned int queue_nr,
> +			       bool formatted)
>  {
>  	struct cs_etm_queue *etmq = queue->priv;
>  
>  	if (list_empty(&queue->head) || etmq)
>  		return 0;
>  
> -	etmq = cs_etm__alloc_queue(etm);
> +	etmq = cs_etm__alloc_queue(etm, formatted);
>  
>  	if (!etmq)
>  		return -ENOMEM;
> @@ -2430,8 +2441,14 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
>  		if (err)
>  			return err;
>  
> +		/*
> +		 * Knowing if the trace is formatted or not requires a lookup of
> +		 * the aux record so only works in non-piped mode where data is
> +		 * queued in cs_etm__queue_aux_records(). Always assume
> +		 * formatted in piped mode (true).
> +		 */
>  		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
> -					  idx);
> +					  idx, true);
>  		if (err)
>  			return err;
>  
> @@ -2678,6 +2695,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>  	union perf_event auxtrace_fragment;
>  	__u64 aux_offset, aux_size;
>  	__u32 idx;
> +	bool formatted;
>  
>  	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>  						   struct cs_etm_auxtrace,
> @@ -2745,7 +2763,9 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>  			return err;
>  
>  		idx = auxtrace_event->idx;
> -		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx], idx);
> +		formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
> +		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
> +					   idx, formatted);
>  	}
>  
>  	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
> @@ -3034,6 +3054,13 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  		goto err_delete_thread;
>  
>  	etm->data_queued = etm->queues.populated;
> +	/*
> +	 * Print warning in pipe mode, see cs_etm__process_auxtrace_event() and
> +	 * cs_etm__queue_aux_fragment() for details relating to limitations.
> +	 */
> +	if (!etm->data_queued)
> +		pr_warning("CS ETM warning: Coresight decode and TRBE support requires random file access.\n"
> +			   "Continuing with best effort decoding in piped mode.\n\n");
>  
>  	return 0;
>  
> -- 
> 2.28.0
> 
