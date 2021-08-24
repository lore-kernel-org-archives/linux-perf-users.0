Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5D4C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 08:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48FB61265
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 08:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbhHXId5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 04:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhHXId4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Aug 2021 04:33:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F395C061757
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Aug 2021 01:33:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fz10so2340918pjb.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Aug 2021 01:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ouOeyDc3aSw2ttQWfhuFrNhi5j7yvihXCkxymVosTeU=;
        b=q/NyY9IJESWuWCz2JeSkn8ea6QHGy8+BPKy/YhqrCgniKl/4pdEZXJ/Pl0L8MktMRZ
         TVcslodnOwEdWL1W/XhoPRcmZzNIRzWBfe+pKWAlMRZxq53us7oR9eQ9bbnFTx7DzzZv
         TJ5eJSnmA6rp4Uh793OXGzGyeQ6m497rXy7KYveqJGnBZ35qT/7nHf5IbPOJltlPRmPn
         rokqdpVinZI8gBqjFqFh1Hh6ItUO2ck0xLU9C04xyylCBdjrLpl+6hPhUkRrEpsGUyx/
         94/ZqtS6Y8C6DW9Y4lcjpJR2RES6xF9EUIQlhBIsf71dkfKMKQXjo876mbWdev+HcFG3
         cyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ouOeyDc3aSw2ttQWfhuFrNhi5j7yvihXCkxymVosTeU=;
        b=NsYZDZ+zOw4KojhBkwwSl1AJSOf/c1X8v13pb6NA3ImEbAo7WSGjLeNOqFZDrcrVL6
         qTPgYmmmdz5oUBfAAUSd7lvK4aoPT4SRkxDO9xVQVxCYdp4RfL0haP2mrcmzEETyQLyX
         o7LGpAx42cpuZFnOfOx0aRYMpHrc+E9DR5glaOcoNoj6v08Wq4frA2w5L6vl0llN+RJJ
         3IQVBi8UGXAh35YTfhHAJDArgaWMn/Qmja3AfAlsAJ7GtXz5UEWpQxoyUL1FIlh5VV+T
         m4H7cLcxqIekEmWHaGNbktxfwhHfM1PAqvyp/+vUuDJMHo0eE66AG8+uMSLGcmaS2swK
         Ji0A==
X-Gm-Message-State: AOAM530J4VSTJ98U9CzkKtmb84QRuazTBWYscIxt8bSFlomzR7uWd9Mn
        GL0YelgtqV+R5dqJxDtNdZqoJw==
X-Google-Smtp-Source: ABdhPJxtiX7muCMgbhWL1ju+4hwwUf6t6QjJMfoeP2mGGhpjjeGolC1636sgbL7zNSknJRizPVKRIw==
X-Received: by 2002:a17:902:c643:b0:130:eab4:bd22 with SMTP id s3-20020a170902c64300b00130eab4bd22mr18378180pls.13.1629793992485;
        Tue, 24 Aug 2021 01:33:12 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id n11sm1715327pjh.23.2021.08.24.01.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 01:33:11 -0700 (PDT)
Date:   Tue, 24 Aug 2021 16:33:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, mike.leach@linaro.org,
        acme@kernel.org, suzuki.poulose@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] perf cs-etm: Create ETE decoder
Message-ID: <20210824083305.GE204566@leoy-ThinkPad-X240s>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-8-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806134109.1182235-8-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 06, 2021 at 02:41:07PM +0100, James Clark wrote:
> If the magic number indicates ETE instantiate a OCSD_BUILTIN_DCD_ETE
> decoder instead of OCSD_BUILTIN_DCD_ETMV4I. ETE is the new trace feature
> for Armv9.
> 
> Testing performed
> =================
> 
> * Old files with v0 and v1 headers for ETMv4 still open correctly
> * New files with new magic number open on new versions of perf
> * New files with new magic number fail to open on old versions of perf
> * Decoding with the ETE decoder results in the same output as the ETMv4
>   decoder as long as there are no new ETE packet types
> 
> Signed-off-by: James Clark <james.clark@arm.com>
>
> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 20 +++++++++++++++++++
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h | 12 +++++++++++
>  tools/perf/util/cs-etm.c                      | 18 +++++++++++++++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 12cee321fbf2..3071e5deddcc 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -156,6 +156,20 @@ static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
>  	config->core_prof = profile_CortexA;
>  }
>  
> +static void cs_etm_decoder__gen_ete_config(struct cs_etm_trace_params *params,
> +					   ocsd_ete_cfg *config)
> +{
> +	config->reg_configr = params->ete.reg_configr;
> +	config->reg_traceidr = params->ete.reg_traceidr;
> +	config->reg_idr0 = params->ete.reg_idr0;
> +	config->reg_idr1 = params->ete.reg_idr1;
> +	config->reg_idr2 = params->ete.reg_idr2;
> +	config->reg_idr8 = params->ete.reg_idr8;
> +	config->reg_devarch = params->ete.reg_devarch;
> +	config->arch_ver = ARCH_AA64;

Just a nitpick: if we connect with patch 02, it implement function
cs_etm_decoder__get_etmv4_arch_ver().  We can extend it to a more
general function cs_etm_decoder__get_arch_ver(); this can allow us to
have a central place to calculate 'arch_ver' for different archs.

I understand your patch doesn't want to mix things between ETMv4 and
ETE, either way is okay for me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> +	config->core_prof = profile_CortexA;
> +}
> +
>  static void cs_etm_decoder__print_str_cb(const void *p_context,
>  					 const char *msg,
>  					 const int str_len)
> @@ -603,6 +617,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>  	const char *decoder_name;
>  	ocsd_etmv3_cfg config_etmv3;
>  	ocsd_etmv4_cfg trace_config_etmv4;
> +	ocsd_ete_cfg trace_config_ete;
>  	void *trace_config;
>  	u8 csid;
>  
> @@ -620,6 +635,11 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>  		decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
>  		trace_config = &trace_config_etmv4;
>  		break;
> +	case CS_ETM_PROTO_ETE:
> +		cs_etm_decoder__gen_ete_config(t_params, &trace_config_ete);
> +		decoder_name = OCSD_BUILTIN_DCD_ETE;
> +		trace_config = &trace_config_ete;
> +		break;
>  	default:
>  		return -1;
>  	}
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 11f3391d06f2..0102ece5ca3e 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -37,11 +37,22 @@ struct cs_etmv4_trace_params {
>  	u32 reg_traceidr;
>  };
>  
> +struct cs_ete_trace_params {
> +	u32 reg_idr0;
> +	u32 reg_idr1;
> +	u32 reg_idr2;
> +	u32 reg_idr8;
> +	u32 reg_configr;
> +	u32 reg_traceidr;
> +	u32 reg_devarch;
> +};
> +
>  struct cs_etm_trace_params {
>  	int protocol;
>  	union {
>  		struct cs_etmv3_trace_params etmv3;
>  		struct cs_etmv4_trace_params etmv4;
> +		struct cs_ete_trace_params ete;
>  	};
>  };
>  
> @@ -65,6 +76,7 @@ enum {
>  	CS_ETM_PROTO_ETMV4i,
>  	CS_ETM_PROTO_ETMV4d,
>  	CS_ETM_PROTO_PTM,
> +	CS_ETM_PROTO_ETE
>  };
>  
>  enum cs_etm_decoder_operation {
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index d540512a3c96..e5649e9ea140 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -460,6 +460,21 @@ static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
>  	t_params[idx].etmv4.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
>  }
>  
> +static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
> +					  struct cs_etm_auxtrace *etm, int idx)
> +{
> +	u64 **metadata = etm->metadata;
> +
> +	t_params[idx].protocol = CS_ETM_PROTO_ETE;
> +	t_params[idx].ete.reg_idr0 = metadata[idx][CS_ETMV4_TRCIDR0];
> +	t_params[idx].ete.reg_idr1 = metadata[idx][CS_ETMV4_TRCIDR1];
> +	t_params[idx].ete.reg_idr2 = metadata[idx][CS_ETMV4_TRCIDR2];
> +	t_params[idx].ete.reg_idr8 = metadata[idx][CS_ETMV4_TRCIDR8];
> +	t_params[idx].ete.reg_configr = metadata[idx][CS_ETMV4_TRCCONFIGR];
> +	t_params[idx].ete.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
> +	t_params[idx].ete.reg_devarch = metadata[idx][CS_ETE_TRCDEVARCH];
> +}
> +
>  static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>  				     struct cs_etm_auxtrace *etm,
>  				     int decoders)
> @@ -479,6 +494,9 @@ static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>  		case __perf_cs_etmv4_magic:
>  			cs_etm__set_trace_param_etmv4(t_params, etm, i);
>  			break;
> +		case __perf_cs_ete_magic:
> +			cs_etm__set_trace_param_ete(t_params, etm, i);
> +			break;
>  		default:
>  			return -EINVAL;
>  		}
> -- 
> 2.28.0
> 
