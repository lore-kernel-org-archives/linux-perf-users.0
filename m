Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536C2C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 31 Jul 2021 07:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3564060F35
	for <linux-perf-users@archiver.kernel.org>; Sat, 31 Jul 2021 07:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhGaHa7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 31 Jul 2021 03:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbhGaHa5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 31 Jul 2021 03:30:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96701C0613CF
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Jul 2021 00:30:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j18-20020a17090aeb12b029017737e6c349so10685401pjz.0
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Jul 2021 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kSNKB+kmbgBYJ1Q8z9Uq//UNcxJ7DIMVm50TIPIqVKU=;
        b=Mr0JF04848TXJdyJe3khV1b0+Zm5Mv0nf24VDSk7miUSp/v/jFE0Z6w320s0+t2UEF
         S/XWOCrQVGotq89AkzGx+M+vvzdsDdO7aeQZkQX4LTejvSXhx+GqGvp72AmAV/kOm6tj
         ketjBFI2sxurkkxUTlP3kMC+FUR7IY4oZEMnRkr5Fozsz0DJqwTVPehVjCROzGBOS6le
         OA0+R9pE08vtCVBn54H9Y+KtrT5cP6HXm/5jzZpVRArtv8xK4BEBxRVBOqPNAV9Ikeco
         wMFnMaN9b/FB6v7G+DtvGRvkdE4Ou1A/IzvL2JTCBFYlS3rG1094RHtgTMAv5OZpN0PA
         y29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kSNKB+kmbgBYJ1Q8z9Uq//UNcxJ7DIMVm50TIPIqVKU=;
        b=qUYRjilU3Ue/DteEXUzXrOL8uDNZvoZqK39Fr72KCyGahmeKb/FId64dcIlBW/dpAP
         Xf8FvD7JbRLYEiYu+H9klJmiK2XZzNxDb8APsBF6wzVQI92O5xJyITPws7G6H+v+jTCr
         cCQJ/CJPt5Ti3RSOHsAf/yMU5dWpUOWnn6B6WGZVawrag6vQZWzvzssqftG+T8rOdArp
         a/H+ogbuDeaDPcDU4GLV6n+OzlIQyLKMh/CoExt0HHIdX6ONTYcAk4Nuca8b7gzWqCU4
         wIVEz8qCqjdfXtTi67GeN4yBVrFn5WHJZwwvMOSs/S0G+hSncvHkkeiP7Ec2X4NTMKWy
         bBjw==
X-Gm-Message-State: AOAM5318u4QSFo+nRM02ONXYNE5p6tXVaf6W3prvjeoY+ea9MlmY2x7P
        BawdnRmkflvfqGeV1qw8NlqO8g==
X-Google-Smtp-Source: ABdhPJx2AVScM6BIHUPFeXAZ9AfLfsLbZjfP9RBCUtqDt4XHBmTYQU65ehyNafCHaOtpQM5q8A9yrA==
X-Received: by 2002:a17:90a:394c:: with SMTP id n12mr6899236pjf.45.1627716650006;
        Sat, 31 Jul 2021 00:30:50 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.43])
        by smtp.gmail.com with ESMTPSA id y28sm4687389pff.137.2021.07.31.00.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 00:30:49 -0700 (PDT)
Date:   Sat, 31 Jul 2021 15:30:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, al.grant@arm.com,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 6/6] perf cs-etm: Print the decoder name
Message-ID: <20210731073037.GF7437@leoy-ThinkPad-X240s>
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-7-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721090706.21523-7-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 21, 2021 at 10:07:05AM +0100, James Clark wrote:
> Use the real name of the decoder instead of hard-coding "ETM" to avoid
> confusion when the trace is ETE. This also now distinguishes between
> ETMv3 and ETMv4.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 17 +++++++++++------
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
>  tools/perf/util/cs-etm.c                        |  4 ++--
>  3 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 37bc9d6a7677..177c08f5be8d 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -37,6 +37,7 @@ struct cs_etm_decoder {
>  	dcd_tree_handle_t dcd_tree;
>  	cs_etm_mem_cb_type mem_access;
>  	ocsd_datapath_resp_t prev_return;
> +	const char *decoder_name;
>  };
>  
>  static u32
> @@ -614,7 +615,6 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>  				   struct cs_etm_trace_params *t_params,
>  				   struct cs_etm_decoder *decoder)
>  {
> -	const char *decoder_name;
>  	ocsd_etmv3_cfg config_etmv3;
>  	ocsd_etmv4_cfg trace_config_etmv4;
>  	ocsd_ete_cfg trace_config_ete;
> @@ -625,19 +625,19 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>  	case CS_ETM_PROTO_ETMV3:
>  	case CS_ETM_PROTO_PTM:
>  		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
> -		decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
> +		decoder->decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
>  							OCSD_BUILTIN_DCD_ETMV3 :
>  							OCSD_BUILTIN_DCD_PTM;
>  		trace_config = &config_etmv3;
>  		break;
>  	case CS_ETM_PROTO_ETMV4i:
>  		cs_etm_decoder__gen_etmv4_config(t_params, &trace_config_etmv4);
> -		decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
> +		decoder->decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
>  		trace_config = &trace_config_etmv4;
>  		break;
>  	case CS_ETM_PROTO_ETE:
>  		cs_etm_decoder__gen_ete_config(t_params, &trace_config_ete);
> -		decoder_name = OCSD_BUILTIN_DCD_ETE;
> +		decoder->decoder_name = OCSD_BUILTIN_DCD_ETE;
>  		trace_config = &trace_config_ete;
>  		break;
>  	default:
> @@ -646,7 +646,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>  
>  	if (d_params->operation == CS_ETM_OPERATION_DECODE) {
>  		if (ocsd_dt_create_decoder(decoder->dcd_tree,
> -					   decoder_name,
> +					   decoder->decoder_name,
>  					   OCSD_CREATE_FLG_FULL_DECODER,
>  					   trace_config, &csid))
>  			return -1;
> @@ -658,7 +658,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>  
>  		return 0;
>  	} else if (d_params->operation == CS_ETM_OPERATION_PRINT) {
> -		if (ocsd_dt_create_decoder(decoder->dcd_tree, decoder_name,
> +		if (ocsd_dt_create_decoder(decoder->dcd_tree, decoder->decoder_name,
>  					   OCSD_CREATE_FLG_PACKET_PROC,
>  					   trace_config, &csid))
>  			return -1;
> @@ -790,3 +790,8 @@ void cs_etm_decoder__free(struct cs_etm_decoder *decoder)
>  	decoder->dcd_tree = NULL;
>  	free(decoder);
>  }
> +
> +const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder)
> +{
> +	return decoder->decoder_name;
> +}

Maybe can consider to place this function into the header file with
"static inline" specifier.

Either way, this patch looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 9137796fe3c5..fbd6786baf99 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -99,5 +99,6 @@ int cs_etm_decoder__get_packet(struct cs_etm_packet_queue *packet_queue,
>  			       struct cs_etm_packet *packet);
>  
>  int cs_etm_decoder__reset(struct cs_etm_decoder *decoder);
> +const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder);
>  
>  #endif /* INCLUDE__CS_ETM_DECODER_H__ */
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 870073bce670..bb7957afd9cb 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -564,8 +564,8 @@ static void cs_etm__dump_event(struct cs_etm_queue *etmq,
>  
>  	fprintf(stdout, "\n");
>  	color_fprintf(stdout, color,
> -		     ". ... CoreSight ETM Trace data: size %zu bytes\n",
> -		     buffer->size);
> +		     ". ... CoreSight %s Trace data: size %zu bytes\n",
> +		     cs_etm_decoder__get_name(etmq->decoder), buffer->size);
>  
>  	do {
>  		size_t consumed;
> -- 
> 2.28.0
> 
