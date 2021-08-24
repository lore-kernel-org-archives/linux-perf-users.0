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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EEDC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 07:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBE461371
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 07:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhHXHP3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 03:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhHXHP2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Aug 2021 03:15:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E45FC061757
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Aug 2021 00:14:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h1so7768352pjs.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Aug 2021 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MrRkC8qGUuY24F6KWlQC1yV+fYoQkLUA+kQ6aXhUuX0=;
        b=fbjlz1U5Bb6io7pRS7Fk//UaFGJBNZedamjYcAqdSOXc40MqVv8+T6qM8RZXl2VCBI
         ugg9liz+h0ZmA214fQASGBY6z37mphicwpDvlE/Ovts1iPXxoUyDvAbgeN8n+m05VMwr
         ZKDGDZK/aJaOEbQasDkgXTjTJAFjFAcc1z3e4FLE4HDzk+vRaU7rU91IGGdhllobJZ6Q
         2rvACO38tXenblmz9iCH2WzyGfZ3gLGxpBqMZ18d+5mTqYWM0oi6kdCPXMFAfplUtlmE
         TPJfr682BcJ2bJQaGflRm/TCQLNmSPdsE4FIU97hWPapFJMk88kHpJjHkrt4AONfWDtx
         7bCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MrRkC8qGUuY24F6KWlQC1yV+fYoQkLUA+kQ6aXhUuX0=;
        b=pbs2IHtdwQ5iuGltwkG2b+q+Ki4D1h2ikREhk5nnZ6OX0PVb4hXHaj0HThQqu1y8x8
         DR2G35iJKQkmm+1bMmKQjF64TTDYvLAPyX99fTGPE37nG8Fd9hofZkdR5m4MEzVZzUkt
         9MyPBXqDysGBEY3uTw1I5au752o8XNnn7UFNivl4QnFHSUrl+vqVi+RWLJDhyFcE4G7f
         3ERftwtZJsmkv+LSZC+pV0ulnziKBiImsI2DE9SwbwFRHG5wVupO9drtY78MgowdtGKV
         xRMYgEI53QND23evHWu2yJFL/8lRh56wpuNOFLjREw9i6lTnm0MVZdNe6Z6tT1QAcw8r
         epQQ==
X-Gm-Message-State: AOAM533QSbDwtSrX83kKm2xNDQbmLpjoNwTeoNZrzHJgW9h4W+XDoPyE
        siflQtNiKwxobc++GVYJaXZ/+A==
X-Google-Smtp-Source: ABdhPJzmL1mw/OL0SAsHEV+KAjkzS/kBfEax53hkkKv6btPqNqxMgWknCtnlwo7c7tb6DqTm8A7UfQ==
X-Received: by 2002:a17:90a:1f44:: with SMTP id y4mr2956140pjy.51.1629789284550;
        Tue, 24 Aug 2021 00:14:44 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id r9sm18362296pfh.135.2021.08.24.00.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:14:43 -0700 (PDT)
Date:   Tue, 24 Aug 2021 15:14:36 +0800
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
Subject: Re: [PATCH v2 4/9] perf cs-etm: Save TRCDEVARCH register
Message-ID: <20210824071436.GC204566@leoy-ThinkPad-X240s>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-5-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806134109.1182235-5-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 06, 2021 at 02:41:04PM +0100, James Clark wrote:
> When ETE is present save the TRCDEVARCH register and set a new magic
> number. It will be used to configure the decoder in a later commit.
> 
> Old versions of perf will not be able to open files with this new magic
> number, but old files will still work with newer versions of perf.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 49 +++++++++++++++++++++++++++----
>  tools/perf/util/cs-etm.c          | 16 ++++++++--
>  tools/perf/util/cs-etm.h          | 10 +++++++
>  3 files changed, 68 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index ecb6fa55a210..e3500b79d972 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -47,15 +47,17 @@ static const char *metadata_etmv3_ro[CS_ETM_PRIV_MAX] = {
>  	[CS_ETM_ETMIDR]		= "mgmt/etmidr",
>  };
>  
> -static const char *metadata_etmv4_ro[CS_ETMV4_PRIV_MAX] = {
> +static const char * const metadata_etmv4_ro[] = {
>  	[CS_ETMV4_TRCIDR0]		= "trcidr/trcidr0",
>  	[CS_ETMV4_TRCIDR1]		= "trcidr/trcidr1",
>  	[CS_ETMV4_TRCIDR2]		= "trcidr/trcidr2",
>  	[CS_ETMV4_TRCIDR8]		= "trcidr/trcidr8",
>  	[CS_ETMV4_TRCAUTHSTATUS]	= "mgmt/trcauthstatus",
> +	[CS_ETE_TRCDEVARCH]		= "mgmt/trcdevarch"
>  };
>  
>  static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
> +static bool cs_etm_is_ete(struct auxtrace_record *itr, int cpu);
>  
>  static int cs_etm_set_context_id(struct auxtrace_record *itr,
>  				 struct evsel *evsel, int cpu)
> @@ -533,7 +535,7 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>  		      struct evlist *evlist __maybe_unused)
>  {
>  	int i;
> -	int etmv3 = 0, etmv4 = 0;
> +	int etmv3 = 0, etmv4 = 0, ete = 0;
>  	struct perf_cpu_map *event_cpus = evlist->core.cpus;
>  	struct perf_cpu_map *online_cpus = perf_cpu_map__new(NULL);
>  
> @@ -544,7 +546,9 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>  			    !cpu_map__has(online_cpus, i))
>  				continue;
>  
> -			if (cs_etm_is_etmv4(itr, i))
> +			if (cs_etm_is_ete(itr, i))
> +				ete++;
> +			else if (cs_etm_is_etmv4(itr, i))
>  				etmv4++;
>  			else
>  				etmv3++;
> @@ -555,7 +559,9 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>  			if (!cpu_map__has(online_cpus, i))
>  				continue;
>  
> -			if (cs_etm_is_etmv4(itr, i))
> +			if (cs_etm_is_ete(itr, i))
> +				ete++;
> +			else if (cs_etm_is_etmv4(itr, i))
>  				etmv4++;
>  			else
>  				etmv3++;
> @@ -565,6 +571,7 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>  	perf_cpu_map__put(online_cpus);
>  
>  	return (CS_ETM_HEADER_SIZE +
> +	       (ete   * CS_ETE_PRIV_SIZE) +
>  	       (etmv4 * CS_ETMV4_PRIV_SIZE) +
>  	       (etmv3 * CS_ETMV3_PRIV_SIZE));
>  }
> @@ -607,6 +614,27 @@ static int cs_etm_get_ro(struct perf_pmu *pmu, int cpu, const char *path)
>  	return val;
>  }
>  
> +#define TRCDEVARCH_ARCHPART_SHIFT 0
> +#define TRCDEVARCH_ARCHPART_MASK  GENMASK(11, 0)
> +#define TRCDEVARCH_ARCHPART(x)    (((x) & TRCDEVARCH_ARCHPART_MASK) >> TRCDEVARCH_ARCHPART_SHIFT)
> +
> +#define TRCDEVARCH_ARCHVER_SHIFT 12
> +#define TRCDEVARCH_ARCHVER_MASK  GENMASK(15, 12)
> +#define TRCDEVARCH_ARCHVER(x)    (((x) & TRCDEVARCH_ARCHVER_MASK) >> TRCDEVARCH_ARCHVER_SHIFT)
> +
> +static bool cs_etm_is_ete(struct auxtrace_record *itr, int cpu)
> +{
> +	struct cs_etm_recording *ptr = container_of(itr, struct cs_etm_recording, itr);
> +	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
> +	int trcdevarch = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETE_TRCDEVARCH]);
> +
> +	/*
> +	 * ETE if ARCHVER is 5 (ARCHVER is 4 for ETM) and ARCHPART is 0xA13.
> +	 * See ETM_DEVARCH_ETE_ARCH in coresight-etm4x.h
> +	 */
> +	return TRCDEVARCH_ARCHVER(trcdevarch) == 5 && TRCDEVARCH_ARCHPART(trcdevarch) == 0xA13;
> +}
> +
>  static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr, int cpu)
>  {
>  	struct cs_etm_recording *ptr = container_of(itr, struct cs_etm_recording, itr);
> @@ -640,7 +668,18 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
>  	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
>  
>  	/* first see what kind of tracer this cpu is affined to */
> -	if (cs_etm_is_etmv4(itr, cpu)) {
> +	if (cs_etm_is_ete(itr, cpu)) {
> +		magic = __perf_cs_ete_magic;
> +		/* ETE uses the same registers as ETMv4 plus TRCDEVARCH */
> +		cs_etm_save_etmv4_header(&info->priv[*offset], itr, cpu);
> +		info->priv[*offset + CS_ETE_TRCDEVARCH] =
> +			cs_etm_get_ro(cs_etm_pmu, cpu,
> +				      metadata_etmv4_ro[CS_ETE_TRCDEVARCH]);
> +
> +		/* How much space was used */
> +		increment = CS_ETE_PRIV_MAX;
> +		nr_trc_params = CS_ETE_PRIV_MAX - CS_ETM_COMMON_BLK_MAX_V1;
> +	} else if (cs_etm_is_etmv4(itr, cpu)) {
>  		magic = __perf_cs_etmv4_magic;
>  		cs_etm_save_etmv4_header(&info->priv[*offset], itr, cpu);
>  
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index f4b2bff533f3..d540512a3c96 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2512,6 +2512,7 @@ static const char * const cs_etmv4_priv_fmts[] = {
>  	[CS_ETMV4_TRCIDR2]	= "	TRCIDR2			       %llx\n",
>  	[CS_ETMV4_TRCIDR8]	= "	TRCIDR8			       %llx\n",
>  	[CS_ETMV4_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
> +	[CS_ETE_TRCDEVARCH]	= "	TRCDEVARCH                     %llx\n"
>  };
>  
>  static const char * const param_unk_fmt =
> @@ -2571,10 +2572,15 @@ static int cs_etm__print_cpu_metadata_v1(__u64 *val, int *offset)
>  			else
>  				fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
>  		}
> -	} else if (magic == __perf_cs_etmv4_magic) {
> +	} else if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic) {
> +		/*
> +		 * ETE and ETMv4 can be printed in the same block because the number of parameters
> +		 * is saved and they share the list of parameter names. ETE is also only supported
> +		 * in V1 files.
> +		 */
>  		for (j = 0; j < total_params; j++, i++) {
>  			/* if newer record - could be excess params */
> -			if (j >= CS_ETMV4_PRIV_MAX)
> +			if (j >= CS_ETE_PRIV_MAX)
>  				fprintf(stdout, param_unk_fmt, j, val[i]);
>  			else
>  				fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
> @@ -2943,6 +2949,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  
>  			/* The traceID is our handle */
>  			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
> +		} else if (ptr[i] == __perf_cs_ete_magic) {
> +			metadata[j] =
> +				cs_etm__create_meta_blk(ptr, &i, CS_ETE_PRIV_MAX, -1);

The last parameter is passed with '-1', means the ETE metadata block
uses version 1, nr_params_v0 is not used thus pass '-1' for it.

It is fine for me.

> +
> +			/* ETE shares first part of metadata with ETMv4 */
> +			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
>  		}
>  
>  		if (!metadata[j]) {
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index d65c7b19407d..08b84c21f065 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -76,6 +76,14 @@ enum {
>  /* define fixed version 0 length - allow new format reader to read old files. */
>  #define CS_ETMV4_NR_TRC_PARAMS_V0 (CS_ETMV4_TRCAUTHSTATUS - CS_ETMV4_TRCCONFIGR + 1)
>  
> +/* ETE metadata is ETMv4 plus TRCDEVARCH register and doesn't support header V0 since it was
> + * added in header V1
> + */
> +enum {
> +	CS_ETE_TRCDEVARCH = CS_ETMV4_PRIV_MAX,
> +	CS_ETE_PRIV_MAX
> +};
> +
>  /*
>   * ETMv3 exception encoding number:
>   * See Embedded Trace Macrocell specification (ARM IHI 0014Q)
> @@ -187,8 +195,10 @@ struct cs_etm_packet_queue {
>  
>  #define __perf_cs_etmv3_magic 0x3030303030303030ULL
>  #define __perf_cs_etmv4_magic 0x4040404040404040ULL
> +#define __perf_cs_ete_magic   0x5050505050505050ULL
>  #define CS_ETMV3_PRIV_SIZE (CS_ETM_PRIV_MAX * sizeof(u64))
>  #define CS_ETMV4_PRIV_SIZE (CS_ETMV4_PRIV_MAX * sizeof(u64))
> +#define CS_ETE_PRIV_SIZE (CS_ETE_PRIV_MAX * sizeof(u64))

I went through the patch twice and looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

>  
>  #ifdef HAVE_CSTRACE_SUPPORT
>  int cs_etm__process_auxtrace_info(union perf_event *event,
> -- 
> 2.28.0
> 
