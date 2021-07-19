Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3367BC636C9
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5BD60FE9
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349748AbhGSWgO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385472AbhGSTAs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jul 2021 15:00:48 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD26C0617A7
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jul 2021 12:33:11 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 62so20175477pgf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jul 2021 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yeVfqvxxhE0mSwx2x3iRUTyGOO2anklSt9RyLFhrvCk=;
        b=Fip8Auo8tlxDnlFNFh5BEBlvGSZnp8VF3pj+w42ROOmD93iRDrEmRvwZ8VZQ9qgy4Z
         /tYZUc7s1AHJEldZtIU9T0/e8ipGJnXIRmP6vROODiOdi3/n1xp5lTZIA52hIg8+oTPe
         FhKDAm6Iqvk8mGJtiATOaVoB2WWEkhzOA64zB+LQ3iD4vkViMXy4P82IsIxslMCLv/D9
         KA43Mp3+2Vwf4bClKdBOqqrUZFw6zNnM6/u2fyNJcUlikGhz3YaROPymUdQyrOrON3RV
         DfzSmCm9ivScdhxdc1AiDnvZFop1gK3UPZT9xlw7lK894YYLTSj9Xcd1NlJ3VyuXsp1G
         o4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yeVfqvxxhE0mSwx2x3iRUTyGOO2anklSt9RyLFhrvCk=;
        b=ikbX6cSeC6k64F6F+zZI6D0acNzzt+XmYxWQReFkOJQpqZnkuC43lT5n3Drnaxpam3
         cWs6oHymJsJYiMvuGvEpaSasRBza6gQX1lyTzdcRWcdwCeKe0O7BevXmeCegtBeAxfUa
         Smj7r7NuBQ6nH3nZeK0yw3h9izC5m53gyQ85Wp3hb5z/3hxE1g4ZzO1kWHX8jZrKsoWM
         /3RNlxynl693cUxNB3pJSH3BShOdmcvh+T/E+mvnfVZGnlraMVXIWsHOOZkkWrkFdLbg
         E8GbKCdEchSyXH/QZerMjEdyFFqZnzZaJLMYVFHv0mVTXHXOw8jgL4l1fBe2PWWNSVPx
         jdiA==
X-Gm-Message-State: AOAM530VAs4nHQ2NWsv5eCNJusEHl3Qi9ORcRw11C9NCj3ogAhQSN7qS
        1TVd7GZ8S7DomUmOubZ4LIi5qg==
X-Google-Smtp-Source: ABdhPJzOqYl644Yog5cEUVP9Cr/d9G8L8UrThuNEvVKHf0Do95W9cUVofTDruJn20qA6CvztxXm1iQ==
X-Received: by 2002:a63:e205:: with SMTP id q5mr26770972pgh.404.1626723651297;
        Mon, 19 Jul 2021 12:40:51 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id js5sm16796502pjb.40.2021.07.19.12.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:40:50 -0700 (PDT)
Date:   Mon, 19 Jul 2021 13:40:48 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, coresight@lists.linaro.org, leo.yan@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] perf cs-etm: Pass unformatted flag to decoder
Message-ID: <20210719194048.GG2255168@p14s>
References: <20210713154008.29656-1-james.clark@arm.com>
 <20210713154008.29656-7-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713154008.29656-7-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 13, 2021 at 04:40:08PM +0100, James Clark wrote:
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
>  tools/perf/util/cs-etm.c | 42 +++++++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 760050ea936d..62769a84a53f 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -461,13 +461,14 @@ static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
>  }
>  
>  static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
> -				     struct cs_etm_auxtrace *etm)
> +				     struct cs_etm_auxtrace *etm,
> +				     int decoders_per_cpu)
>  {
>  	int i;
>  	u32 etmidr;
>  	u64 architecture;
>  
> -	for (i = 0; i < etm->num_cpu; i++) {
> +	for (i = 0; i < decoders_per_cpu; i++) {
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
> @@ -720,11 +722,13 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
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
> +	int decoders_per_cpu = formatted ? etm->num_cpu : 1;
>  
>  	etmq = zalloc(sizeof(*etmq));
>  	if (!etmq)
> @@ -735,21 +739,23 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
>  		goto out_free;
>  
>  	/* Use metadata to fill in trace parameters for trace decoder */
> -	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
> +	t_params = zalloc(sizeof(*t_params) * decoders_per_cpu);
>  
>  	if (!t_params)
>  		goto out_free;
>  
> -	if (cs_etm__init_trace_params(t_params, etm))
> +	if (cs_etm__init_trace_params(t_params, etm, decoders_per_cpu))
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
> +	etmq->decoder = cs_etm_decoder__new(decoders_per_cpu, &d_params,
> +					    t_params);
>  
>  	if (!etmq->decoder)
>  		goto out_free;
> @@ -777,14 +783,15 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
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
> @@ -2430,8 +2437,14 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
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
> @@ -2678,6 +2691,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>  	union perf_event auxtrace_fragment;
>  	__u64 aux_offset, aux_size;
>  	__u32 idx;
> +	bool formatted;
>  
>  	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>  						   struct cs_etm_auxtrace,
> @@ -2745,7 +2759,9 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
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

I'm running out of time with this one.  I'll continue tomorrow.

> -- 
> 2.28.0
> 
