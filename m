Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA61C07E95
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B2B6113A
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349817AbhGSWgt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385461AbhGSTAs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jul 2021 15:00:48 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70489C06178A
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jul 2021 12:32:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d12so17439012pfj.2
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jul 2021 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kcNZ/XE6xPDuF3u3ajPrSNsiNkSWt/dpU0wB6i8pSgg=;
        b=H+YZ2LRHc1EK4Ihx0pQXR5M6TMgWaov1OLiHhzilMHFZYQGzGrid+x3koK2RhDXBge
         fd8U6o/kZ8jiqEev4sfgKTwwxg0945l29NryEXTF4qwtjCKw1MuTRIRA9G08DJCWjOGu
         PZWLYdpC/CHPZUun7TyBF9l+NtoImwhpqhcZX07mz138q/3fhgTg+KyUDLXDLP35jKSX
         b2SZRT1QpaEQrtlrnLPMJZ9YsWQxYItXIYfJf67JuDTG/uILAQz3JroU31wDSabviwdh
         eGyrxQx6k5gKFtaJ/3WCl6z/8aJqva/VMeC+yE2J8pqFkPO38VVvOYCe5qHyZOpbD5Ao
         uGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kcNZ/XE6xPDuF3u3ajPrSNsiNkSWt/dpU0wB6i8pSgg=;
        b=sh17kAmIHVcBXNAvNHxHhz6Rl0xDeX9p0qDjIz6G0+oactI2p0xP4KINTYpEGHAy5d
         twIGLncIFxoxvl/yH14VTrCsKwooUMv6iL0IHlDWg5p7dzxDe60f1dsqUb3Fa4auQY98
         eHvQM8tareb4bd4BUfwcYvcv+P2NRJny57BvZ4GuKYZXcI/IKiv2LGHaruADMKdg0VPd
         vHenxa9LhBAQoN8gdVJzZ+wh+a27NWUH8NwWRd0kuwezdWn+OSQx8XWjop0gNAThMfm5
         ihuV8v7zywmIjCDKzsbP10d2i3titRdQjho9WWNiLq0BuCkMsuytSRo/TEI0YccHFWkr
         RQ4Q==
X-Gm-Message-State: AOAM5332ncQ4MhjdmPO8+bE/iih+Z0oG/CZ5aVetufDfhXPXcggHGo8b
        eaEpZF/zzJvKp/CCFU4R0/hLyg==
X-Google-Smtp-Source: ABdhPJz3hw3TMu3EsXfdCJpfVGBnQysNmXwi0/aJJenGo1f4wqdszSyEfEAupio8TDGx1G6MAEh/0A==
X-Received: by 2002:a62:6101:0:b029:326:3166:8b0b with SMTP id v1-20020a6261010000b029032631668b0bmr28065521pfb.4.1626723596644;
        Mon, 19 Jul 2021 12:39:56 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id y8sm21635325pfe.162.2021.07.19.12.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:39:54 -0700 (PDT)
Date:   Mon, 19 Jul 2021 13:39:52 -0600
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
Subject: Re: [PATCH 5/6] perf cs-etm: Use existing decoder instead of
 resetting it
Message-ID: <20210719193952.GF2255168@p14s>
References: <20210713154008.29656-1-james.clark@arm.com>
 <20210713154008.29656-6-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713154008.29656-6-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 13, 2021 at 04:40:07PM +0100, James Clark wrote:
> When dumping trace, the decoder is continually deleted and recreated to
> decode each buffer. To support both formatted and unformatted trace in
> a later commit, the decoder will be configured in advance.
> 
> This commit removes the deletion of the decoder and allows the
> formatted/unformatted setting to persist.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  tools/perf/util/cs-etm.c | 37 +++++++------------------------------
>  1 file changed, 7 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 2d07e52ffd3c..760050ea936d 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -508,14 +508,11 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
>  	return ret;
>  }
>  
> -static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
> +static void cs_etm__dump_event(struct cs_etm_queue *etmq,
>  			       struct auxtrace_buffer *buffer)
>  {
>  	int ret;
>  	const char *color = PERF_COLOR_BLUE;
> -	struct cs_etm_decoder_params d_params;
> -	struct cs_etm_trace_params *t_params;
> -	struct cs_etm_decoder *decoder;
>  	size_t buffer_used = 0;
>  
>  	fprintf(stdout, "\n");
> @@ -523,29 +520,11 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
>  		     ". ... CoreSight ETM Trace data: size %zu bytes\n",
>  		     buffer->size);
>  
> -	/* Use metadata to fill in trace parameters for trace decoder */
> -	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
> -
> -	if (!t_params)
> -		return;
> -
> -	if (cs_etm__init_trace_params(t_params, etm))
> -		goto out_free;
> -
> -	/* Set decoder parameters to simply print the trace packets */
> -	if (cs_etm__init_decoder_params(&d_params, NULL,
> -					CS_ETM_OPERATION_PRINT))
> -		goto out_free;
> -
> -	decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
> -
> -	if (!decoder)
> -		goto out_free;
>  	do {
>  		size_t consumed;
>  
>  		ret = cs_etm_decoder__process_data_block(
> -				decoder, buffer->offset,
> +				etmq->decoder, buffer->offset,
>  				&((u8 *)buffer->data)[buffer_used],
>  				buffer->size - buffer_used, &consumed);
>  		if (ret)
> @@ -554,10 +533,7 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
>  		buffer_used += consumed;
>  	} while (buffer_used < buffer->size);
>  
> -	cs_etm_decoder__free(decoder);
> -
> -out_free:
> -	zfree(&t_params);
> +	cs_etm_decoder__reset(etmq->decoder);
>  }
>  
>  static int cs_etm__flush_events(struct perf_session *session,
> @@ -769,7 +745,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
>  
>  	/* Set decoder parameters to decode trace packets */
>  	if (cs_etm__init_decoder_params(&d_params, etmq,
> -					CS_ETM_OPERATION_DECODE))
> +					dump_trace ? CS_ETM_OPERATION_PRINT :
> +						     CS_ETM_OPERATION_DECODE))
>  		goto out_free;
>  
>  	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
> @@ -2422,7 +2399,7 @@ static void dump_queued_data(struct cs_etm_auxtrace *etm,
>  	for (i = 0; i < etm->queues.nr_queues; ++i)
>  		list_for_each_entry(buf, &etm->queues.queue_array[i].head, list)
>  			if (buf->reference == event->reference)
> -				cs_etm__dump_event(etm, buf);
> +				cs_etm__dump_event(etm->queues.queue_array[i].priv, buf);
>  }
>  
>  static int cs_etm__process_auxtrace_event(struct perf_session *session,
> @@ -2460,7 +2437,7 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
>  
>  		if (dump_trace)
>  			if (auxtrace_buffer__get_data(buffer, fd)) {
> -				cs_etm__dump_event(etm, buffer);
> +				cs_etm__dump_event(etm->queues.queue_array[idx].priv, buffer);
>  				auxtrace_buffer__put_data(buffer);
>  			}
>  	} else if (dump_trace)
> -- 
> 2.28.0
> 
