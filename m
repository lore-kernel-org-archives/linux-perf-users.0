Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367C0C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 31 Jul 2021 05:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D216103B
	for <linux-perf-users@archiver.kernel.org>; Sat, 31 Jul 2021 05:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhGaFsm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 31 Jul 2021 01:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhGaFsm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 31 Jul 2021 01:48:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D796DC0613CF
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jul 2021 22:48:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q2so13551902plr.11
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jul 2021 22:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a3dNkIIp38nvkTRD/9A8BOia4PgC9NHj5E0SHTp1uJs=;
        b=ex/2YtFohxbozZZsAdn2AsScrqJMX3YTgSe2VfRzS1yNfL61V1ta1tGpLqPE9F0Nv2
         DAeFvc4FWGO1HVTCsM+dJV+XWvyVBRLKDYhhXXwGl/fcDjbNc7IeLbkpgkOWdqzny0eE
         JGG784LgzKen3+HrEWDOBbPi0ya8tb19JKmiITUCNT9j9tyQv6f0uTRUOnUtr5sB2Fyo
         29dAgnCDWdTxNYYRw24Pz/RErSszgAATULdPPEjrp7mjwhsr/DBkexocrySNQf/YCsxg
         x1vro4VP/8nbYZm9vwXFjSOfGzORLR3Z8wImu3RhtewDayBESxgBkmNnu/iLf6z55WcG
         B8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a3dNkIIp38nvkTRD/9A8BOia4PgC9NHj5E0SHTp1uJs=;
        b=DoSQIEfzpVbRjgKm3E4q1WvBYZASLpX3Ly4Kp/lJSgV2nM14ELrQU8O1vSRBbTHWEo
         Djy1NaXUvMjM4wSZkMuUFWK79f82cJE59HPGEazRMqKV2vx0QRxTopvkoOCZwGlBkPVJ
         oasjdbcxExdoqBmCo7z16twx4+PbSL5g9BqKbvQlOTR3w94J4yG33SS9Ck9qdYVvrbID
         WYmNXXgdfXQgIk7b/6OQ9XvVSD67dvnEORGlqOkm+HqUjtkok9WLey/+1/n1wqNKwTu+
         d1UMuezrNchk4YZdGF3XonwxHusdKHQvyhGoJTGQlSRmVV1NZPK+2EaFQIJnbp9pCzvz
         5+3A==
X-Gm-Message-State: AOAM531Pc8LaBZV93r4tOc67qmEF1ifA8Llf76Fnn2owKH/sA4+tKvfB
        qj4yyqPX7I6hxf0KH+vc9jmQNA==
X-Google-Smtp-Source: ABdhPJw1w3uBdCqt/BL/+R66U5TcSLB4x3xh6OYqTQqp+wn4oe4R6q8Ixhqc2OgrHwZl03xpsywUKg==
X-Received: by 2002:a63:f1b:: with SMTP id e27mr5100355pgl.314.1627710515270;
        Fri, 30 Jul 2021 22:48:35 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.43])
        by smtp.gmail.com with ESMTPSA id l11sm4560840pfd.187.2021.07.30.22.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 22:48:34 -0700 (PDT)
Date:   Sat, 31 Jul 2021 13:48:22 +0800
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
Subject: Re: [PATCH 1/6] perf cs-etm: Refactor initialisation of decoder
 params.
Message-ID: <20210731054822.GA7437@leoy-ThinkPad-X240s>
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721090706.21523-2-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 21, 2021 at 10:07:00AM +0100, James Clark wrote:
> The initialisation of the decoder params is duplicated between
> creation of the packet printer and packet decoder. Put them both
> into one function so that future changes only need to be made in one
> place.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

It's good to wait for Mathieu's review, I reviewed this patch and it's
good for me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 99 +++++--------------
>  1 file changed, 25 insertions(+), 74 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index ed1f0326f859..30889a9d0165 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -227,55 +227,6 @@ cs_etm_decoder__init_raw_frame_logging(
>  }
>  #endif
>  
> -static int cs_etm_decoder__create_packet_printer(struct cs_etm_decoder *decoder,
> -						 const char *decoder_name,
> -						 void *trace_config)
> -{
> -	u8 csid;
> -
> -	if (ocsd_dt_create_decoder(decoder->dcd_tree, decoder_name,
> -				   OCSD_CREATE_FLG_PACKET_PROC,
> -				   trace_config, &csid))
> -		return -1;
> -
> -	if (ocsd_dt_set_pkt_protocol_printer(decoder->dcd_tree, csid, 0))
> -		return -1;
> -
> -	return 0;
> -}
> -
> -static int
> -cs_etm_decoder__create_etm_packet_printer(struct cs_etm_trace_params *t_params,
> -					  struct cs_etm_decoder *decoder)
> -{
> -	const char *decoder_name;
> -	ocsd_etmv3_cfg config_etmv3;
> -	ocsd_etmv4_cfg trace_config_etmv4;
> -	void *trace_config;
> -
> -	switch (t_params->protocol) {
> -	case CS_ETM_PROTO_ETMV3:
> -	case CS_ETM_PROTO_PTM:
> -		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
> -		decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
> -							OCSD_BUILTIN_DCD_ETMV3 :
> -							OCSD_BUILTIN_DCD_PTM;
> -		trace_config = &config_etmv3;
> -		break;
> -	case CS_ETM_PROTO_ETMV4i:
> -		cs_etm_decoder__gen_etmv4_config(t_params, &trace_config_etmv4);
> -		decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
> -		trace_config = &trace_config_etmv4;
> -		break;
> -	default:
> -		return -1;
> -	}
> -
> -	return cs_etm_decoder__create_packet_printer(decoder,
> -						     decoder_name,
> -						     trace_config);
> -}
> -
>  static ocsd_datapath_resp_t
>  cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
>  				  struct cs_etm_packet_queue *packet_queue,
> @@ -629,9 +580,10 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  	return resp;
>  }
>  
> -static int cs_etm_decoder__create_etm_packet_decoder(
> -					struct cs_etm_trace_params *t_params,
> -					struct cs_etm_decoder *decoder)
> +static int
> +cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
> +				   struct cs_etm_trace_params *t_params,
> +				   struct cs_etm_decoder *decoder)
>  {
>  	const char *decoder_name;
>  	ocsd_etmv3_cfg config_etmv3;
> @@ -657,31 +609,30 @@ static int cs_etm_decoder__create_etm_packet_decoder(
>  		return -1;
>  	}
>  
> -	if (ocsd_dt_create_decoder(decoder->dcd_tree,
> -				     decoder_name,
> -				     OCSD_CREATE_FLG_FULL_DECODER,
> -				     trace_config, &csid))
> -		return -1;
> +	if (d_params->operation == CS_ETM_OPERATION_DECODE) {
> +		if (ocsd_dt_create_decoder(decoder->dcd_tree,
> +					   decoder_name,
> +					   OCSD_CREATE_FLG_FULL_DECODER,
> +					   trace_config, &csid))
> +			return -1;
>  
> -	if (ocsd_dt_set_gen_elem_outfn(decoder->dcd_tree,
> -				       cs_etm_decoder__gen_trace_elem_printer,
> -				       decoder))
> -		return -1;
> +		if (ocsd_dt_set_gen_elem_outfn(decoder->dcd_tree,
> +					       cs_etm_decoder__gen_trace_elem_printer,
> +					       decoder))
> +			return -1;
>  
> -	return 0;
> -}
> +		return 0;
> +	} else if (d_params->operation == CS_ETM_OPERATION_PRINT) {
> +		if (ocsd_dt_create_decoder(decoder->dcd_tree, decoder_name,
> +					   OCSD_CREATE_FLG_PACKET_PROC,
> +					   trace_config, &csid))
> +			return -1;
>  
> -static int
> -cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
> -				   struct cs_etm_trace_params *t_params,
> -				   struct cs_etm_decoder *decoder)
> -{
> -	if (d_params->operation == CS_ETM_OPERATION_PRINT)
> -		return cs_etm_decoder__create_etm_packet_printer(t_params,
> -								 decoder);
> -	else if (d_params->operation == CS_ETM_OPERATION_DECODE)
> -		return cs_etm_decoder__create_etm_packet_decoder(t_params,
> -								 decoder);
> +		if (ocsd_dt_set_pkt_protocol_printer(decoder->dcd_tree, csid, 0))
> +			return -1;
> +
> +		return 0;
> +	}
>  
>  	return -1;
>  }
> -- 
> 2.28.0
> 
