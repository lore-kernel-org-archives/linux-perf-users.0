Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD94C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 31 Jul 2021 07:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B4D76103B
	for <linux-perf-users@archiver.kernel.org>; Sat, 31 Jul 2021 07:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhGaHYB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 31 Jul 2021 03:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhGaHYA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 31 Jul 2021 03:24:00 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E87C06175F
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Jul 2021 00:23:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d1so13784308pll.1
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Jul 2021 00:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7fkVzKDDdB5ciccGz8WNKx4R+t9Y55ppmvsJPTgVCdg=;
        b=NckWYzXKfTi9kEIAKJOhrIo3M6tpwPxt+ROY+K/gfaHT21uFGCSnfMXGewzvX5dYqN
         /y8qd7lKCmA57Q0iQ4gwyhoI+k6BAq8A1UnQBW9U1NyDVbtSFZz/W+WN0qiGIr1A/lNN
         VdFr66XxuNTz0xJCgMo6PyJGaPzPRpgEAMDBW3BEN6bzgoReatyjynU8mPaezbYT4UAE
         EDB0T+Bo/4Zpoi7dnuPq+ZTXVdIwWQkL/bWzPGTFMtU76RcoABWnDWyLA8Hx9hecWMha
         tIqZhXyDA3yJL/aSJG4GMSJ92ncxFhIhihJrrZw7/eltFa9EfedeNGC90eZq3JjZy3bp
         oRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7fkVzKDDdB5ciccGz8WNKx4R+t9Y55ppmvsJPTgVCdg=;
        b=Tm/YQFZVCdnJJaqm5erGKedZ63cBg4flCoIIPBDfn2jUP5niv50OVuaXu8rCTfa6Wb
         nFMiE/DzBku2MIhbKdmzRP421k3MWWr+dpye+tdeLOCtN/LqN+WxQGdh/SpeoXGut3dz
         1rhG16a5iyPM1ffxq5m5PK0TFcPqUer2DidrjNCJ/u1a+4hvE1F8cnBEteroFRunZCRH
         rzKLKM2Eea84L/wlqSLUMB91d/gPBoMr5ku2IRY5Kom0ag7/ajN57N3VwkcpZkWoatZs
         nu721jiiccw0S1PMS6dp6d+O8k0TlRzzvofUFftg6v89TO29tUGgDs5/51H1DkeWsEjo
         4afA==
X-Gm-Message-State: AOAM530yKUiGCNk+YGP5BUBkXNVeueVbm42NB5ODNaDRh4S7hdlZcsgk
        UvNIGRfSBwNxAcsEpaW7lVLl+w==
X-Google-Smtp-Source: ABdhPJxaQv5aHD/kXjEbohL6OOfgDJfMyEF/DzG1gkekq580OiefpeY2lu7WIUPlfJsFhyCNfKQQ/A==
X-Received: by 2002:a17:902:a415:b029:129:5342:eab7 with SMTP id p21-20020a170902a415b02901295342eab7mr5610431plq.26.1627716234492;
        Sat, 31 Jul 2021 00:23:54 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.43])
        by smtp.gmail.com with ESMTPSA id g12sm4255707pfv.167.2021.07.31.00.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 00:23:53 -0700 (PDT)
Date:   Sat, 31 Jul 2021 15:23:41 +0800
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
Subject: Re: [PATCH 5/6] perf cs-etm: Create ETE decoder
Message-ID: <20210731072341.GE7437@leoy-ThinkPad-X240s>
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-6-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721090706.21523-6-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 21, 2021 at 10:07:04AM +0100, James Clark wrote:
> If the TRCDEVARCH register was saved, and it shows that ETE is present,
> then instantiate an OCSD_BUILTIN_DCD_ETE decoder instead of
> OCSD_BUILTIN_DCD_ETMV4I. ETE is the new trace feature for Armv9.
> 
> Testing performed
> =================
> 
> * Old files with v0 headers still open correctly
> * Old files with v1 headers with no TRCDEVARCH saved still open
> * New files with TRCDEVARCH open using an old version of perf that
>   supports v1 headers
> * Coresight decoding results in the same output if there are no new ETE
>   packet types
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 29 ++++++++++-
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  7 +++
>  tools/perf/util/cs-etm.c                      | 49 ++++++++++++++++++-
>  tools/perf/util/cs-etm.h                      |  1 +
>  4 files changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 60147c908425..37bc9d6a7677 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -127,8 +127,12 @@ static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
>  #define TRCIDR1_TRCARCHMIN_SHIFT 4
>  #define TRCIDR1_TRCARCHMIN_MASK  GENMASK(7, 4)
>  #define TRCIDR1_TRCARCHMIN(x)    (((x) & TRCIDR1_TRCARCHMIN_MASK) >> TRCIDR1_TRCARCHMIN_SHIFT)
> -static enum _ocsd_arch_version cs_etm_decoder__get_arch_ver(u32 reg_idr1)
> +static enum _ocsd_arch_version cs_etm_decoder__get_arch_ver(u32 reg_idr1, u32 reg_devarch)
>  {
> +	/* ETE has to be v9 so set arch version to v8.3+ (ARCH__AA64) */
> +	if (cs_etm__is_ete(reg_devarch))
> +		return ARCH_AA64;
> +

Based on values used in below change, I think we can unify the ETM
versio number like:

  ARCH_V8R3 : REVISION, bits[19:16] is 0x3
  ARCH_V8R4 : REVISION, bits[19:16] is 0x4
  ARCH_V8R5 : REVISION, bits[19:16] is 0x5

>  	/*
>  	 * If the ETM trace minor version is 4 or more then we can assume
>  	 * the architecture is ARCH_AA64 rather than just V8
> @@ -150,7 +154,22 @@ static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
>  	config->reg_idr11 = 0;
>  	config->reg_idr12 = 0;
>  	config->reg_idr13 = 0;
> -	config->arch_ver = cs_etm_decoder__get_arch_ver(params->etmv4.reg_idr1);
> +	config->arch_ver = cs_etm_decoder__get_arch_ver(params->etmv4.reg_idr1, 0);

Can we always pass the value "params->ete.reg_devarch" rather than
directly pass "0"?

> +	config->core_prof = profile_CortexA;
> +}
> +
> +static void cs_etm_decoder__gen_ete_config(struct cs_etm_trace_params *params,
> +					   ocsd_ete_cfg *config)
> +{
> +	config->reg_configr = params->ete.base_params.reg_configr;
> +	config->reg_traceidr = params->ete.base_params.reg_traceidr;
> +	config->reg_idr0 = params->ete.base_params.reg_idr0;
> +	config->reg_idr1 = params->ete.base_params.reg_idr1;
> +	config->reg_idr2 = params->ete.base_params.reg_idr2;
> +	config->reg_idr8 = params->ete.base_params.reg_idr8;
> +	config->reg_devarch = params->ete.reg_devarch;
> +	config->arch_ver = cs_etm_decoder__get_arch_ver(params->ete.base_params.reg_idr1,
> +							params->ete.reg_devarch);
>  	config->core_prof = profile_CortexA;
>  }
>  
> @@ -598,6 +617,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>  	const char *decoder_name;
>  	ocsd_etmv3_cfg config_etmv3;
>  	ocsd_etmv4_cfg trace_config_etmv4;
> +	ocsd_ete_cfg trace_config_ete;
>  	void *trace_config;
>  	u8 csid;
>  
> @@ -615,6 +635,11 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
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
> index 11f3391d06f2..9137796fe3c5 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -37,11 +37,17 @@ struct cs_etmv4_trace_params {
>  	u32 reg_traceidr;
>  };
>  
> +struct cs_ete_trace_params {
> +	struct cs_etmv4_trace_params base_params;
> +	u32 reg_devarch;

As we have said, can we directly support ETMv4.5, so that it can
smoothly support ETE features?  If so, we don't need to add a new
structure "cs_ete_trace_params" at here.

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
> @@ -65,6 +71,7 @@ enum {
>  	CS_ETM_PROTO_ETMV4i,
>  	CS_ETM_PROTO_ETMV4d,
>  	CS_ETM_PROTO_PTM,
> +	CS_ETM_PROTO_ETE
>  };
>  
>  enum cs_etm_decoder_operation {
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 68978f6707a8..870073bce670 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -460,11 +460,44 @@ static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
>  	t_params[idx].etmv4.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
>  }
>  
> +static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
> +					  struct cs_etm_auxtrace *etm, int idx)
> +{
> +	u64 **metadata = etm->metadata;
> +
> +	t_params[idx].protocol = CS_ETM_PROTO_ETE;
> +	t_params[idx].ete.base_params.reg_idr0 = metadata[idx][CS_ETMV4_TRCIDR0];
> +	t_params[idx].ete.base_params.reg_idr1 = metadata[idx][CS_ETMV4_TRCIDR1];
> +	t_params[idx].ete.base_params.reg_idr2 = metadata[idx][CS_ETMV4_TRCIDR2];
> +	t_params[idx].ete.base_params.reg_idr8 = metadata[idx][CS_ETMV4_TRCIDR8];
> +	t_params[idx].ete.base_params.reg_configr = metadata[idx][CS_ETMV4_TRCCONFIGR];
> +	t_params[idx].ete.base_params.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
> +	t_params[idx].ete.reg_devarch = metadata[idx][CS_ETE_TRCDEVARCH];
> +}
> +
> +#define TRCDEVARCH_ARCHPART_SHIFT 0
> +#define TRCDEVARCH_ARCHPART_MASK  GENMASK(11, 0)
> +#define TRCDEVARCH_ARCHPART(x)    (((x) & TRCDEVARCH_ARCHPART_MASK) >> TRCDEVARCH_ARCHPART_SHIFT)
> +
> +#define TRCDEVARCH_ARCHVER_SHIFT 12
> +#define TRCDEVARCH_ARCHVER_MASK  GENMASK(15, 12)
> +#define TRCDEVARCH_ARCHVER(x)    (((x) & TRCDEVARCH_ARCHVER_MASK) >> TRCDEVARCH_ARCHVER_SHIFT)
> +
> +bool cs_etm__is_ete(u32 trcdevarch)
> +{
> +	/*
> +	 * ETE if ARCHVER is 5 (ARCHVER is 4 for ETM) and ARCHPART is 0xA13.
> +	 * See ETM_DEVARCH_ETE_ARCH in coresight-etm4x.h
> +	 */
> +	return TRCDEVARCH_ARCHVER(trcdevarch) == 5 && TRCDEVARCH_ARCHPART(trcdevarch) == 0xA13;

I think this is incorrect.

Here should check the bit field "REVISION, bits[19:16]".  If it's
field value is >= 5, then we can say it supports ETE.  I checked the
spec for ETMv4.4 and ETMv4.6, both use the same values for the
Bits[15:12] = 0x4, so the architecture ID is same for ETMv4.x IPs.

Thanks,
Leo

> +}
> +
> +
>  static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>  				     struct cs_etm_auxtrace *etm,
>  				     int decoders_per_cpu)
>  {
> -	int i;
> +	int i, num_params;
>  	u32 etmidr;
>  	u64 architecture;
>  
> @@ -477,7 +510,19 @@ static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>  			cs_etm__set_trace_param_etmv3(t_params, etm, i, etmidr);
>  			break;
>  		case __perf_cs_etmv4_magic:
> -			cs_etm__set_trace_param_etmv4(t_params, etm, i);
> +			/*
> +			 * If devarch was saved and shows ETE, initialise ETE decoder. Otherwise
> +			 * ETM decoder will still be able to decode a subset of the data. The total
> +			 * number of params is number of params saved + common block size for v1,
> +			 * see cs_etm_get_metadata().
> +			 */
> +			num_params = etm->metadata[i][CS_ETM_NR_TRC_PARAMS] +
> +					CS_ETM_COMMON_BLK_MAX_V1;
> +			if (num_params > CS_ETE_TRCDEVARCH &&
> +			    cs_etm__is_ete(etm->metadata[i][CS_ETE_TRCDEVARCH]))
> +				cs_etm__set_trace_param_ete(t_params, etm, i);
> +			else
> +				cs_etm__set_trace_param_etmv4(t_params, etm, i);
>  			break;
>  		default:
>  			return -EINVAL;
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 52d82dce9d59..514083819657 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -203,6 +203,7 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
>  					      u8 trace_chan_id);
>  struct cs_etm_packet_queue
>  *cs_etm__etmq_get_packet_queue(struct cs_etm_queue *etmq, u8 trace_chan_id);
> +bool cs_etm__is_ete(u32 trcdevarch);
>  #else
>  static inline int
>  cs_etm__process_auxtrace_info(union perf_event *event __maybe_unused,
> -- 
> 2.28.0
> 
