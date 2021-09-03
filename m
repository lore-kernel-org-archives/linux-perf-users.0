Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FE1C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 09:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0AD6069E
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 09:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhICJJ2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Sep 2021 05:09:28 -0400
Received: from foss.arm.com ([217.140.110.172]:39082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348753AbhICJJZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Sep 2021 05:09:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B15FD1FB;
        Fri,  3 Sep 2021 02:08:25 -0700 (PDT)
Received: from [10.57.92.220] (unknown [10.57.92.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 756B23F694;
        Fri,  3 Sep 2021 02:08:23 -0700 (PDT)
Subject: Re: [PATCH v2 4/9] perf cs-etm: Save TRCDEVARCH register
To:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, mike.leach@linaro.org
Cc:     acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-5-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <44a386f9-7c02-2004-9e81-7c19cd9ce623@arm.com>
Date:   Fri, 3 Sep 2021 10:08:22 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210806134109.1182235-5-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James

On 06/08/2021 14:41, James Clark wrote:
> When ETE is present save the TRCDEVARCH register and set a new magic
> number. It will be used to configure the decoder in a later commit.
> 
> Old versions of perf will not be able to open files with this new magic
> number, but old files will still work with newer versions of perf.
> 

The patch looks good to me. There are some minor style related comments
below.

> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   tools/perf/arch/arm/util/cs-etm.c | 49 +++++++++++++++++++++++++++----
>   tools/perf/util/cs-etm.c          | 16 ++++++++--
>   tools/perf/util/cs-etm.h          | 10 +++++++
>   3 files changed, 68 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index ecb6fa55a210..e3500b79d972 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -47,15 +47,17 @@ static const char *metadata_etmv3_ro[CS_ETM_PRIV_MAX] = {
>   	[CS_ETM_ETMIDR]		= "mgmt/etmidr",
>   };
>   
> -static const char *metadata_etmv4_ro[CS_ETMV4_PRIV_MAX] = {
> +static const char * const metadata_etmv4_ro[] = {
>   	[CS_ETMV4_TRCIDR0]		= "trcidr/trcidr0",
>   	[CS_ETMV4_TRCIDR1]		= "trcidr/trcidr1",
>   	[CS_ETMV4_TRCIDR2]		= "trcidr/trcidr2",
>   	[CS_ETMV4_TRCIDR8]		= "trcidr/trcidr8",
>   	[CS_ETMV4_TRCAUTHSTATUS]	= "mgmt/trcauthstatus",
> +	[CS_ETE_TRCDEVARCH]		= "mgmt/trcdevarch"
>   };
>   
>   static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
> +static bool cs_etm_is_ete(struct auxtrace_record *itr, int cpu);
>   
>   static int cs_etm_set_context_id(struct auxtrace_record *itr,
>   				 struct evsel *evsel, int cpu)
> @@ -533,7 +535,7 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>   		      struct evlist *evlist __maybe_unused)
>   {
>   	int i;
> -	int etmv3 = 0, etmv4 = 0;
> +	int etmv3 = 0, etmv4 = 0, ete = 0;
>   	struct perf_cpu_map *event_cpus = evlist->core.cpus;
>   	struct perf_cpu_map *online_cpus = perf_cpu_map__new(NULL);
>   
> @@ -544,7 +546,9 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>   			    !cpu_map__has(online_cpus, i))
>   				continue;
>   
> -			if (cs_etm_is_etmv4(itr, i))
> +			if (cs_etm_is_ete(itr, i))
> +				ete++;
> +			else if (cs_etm_is_etmv4(itr, i))
>   				etmv4++;
>   			else
>   				etmv3++;
> @@ -555,7 +559,9 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>   			if (!cpu_map__has(online_cpus, i))
>   				continue;
>   
> -			if (cs_etm_is_etmv4(itr, i))
> +			if (cs_etm_is_ete(itr, i))
> +				ete++;
> +			else if (cs_etm_is_etmv4(itr, i))
>   				etmv4++;
>   			else
>   				etmv3++;
> @@ -565,6 +571,7 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>   	perf_cpu_map__put(online_cpus);
>   
>   	return (CS_ETM_HEADER_SIZE +
> +	       (ete   * CS_ETE_PRIV_SIZE) +
>   	       (etmv4 * CS_ETMV4_PRIV_SIZE) +
>   	       (etmv3 * CS_ETMV3_PRIV_SIZE));
>   }
> @@ -607,6 +614,27 @@ static int cs_etm_get_ro(struct perf_pmu *pmu, int cpu, const char *path)
>   	return val;
>   }
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
>   static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr, int cpu)
>   {
>   	struct cs_etm_recording *ptr = container_of(itr, struct cs_etm_recording, itr);
> @@ -640,7 +668,18 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
>   	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
>   
>   	/* first see what kind of tracer this cpu is affined to */
> -	if (cs_etm_is_etmv4(itr, cpu)) {
> +	if (cs_etm_is_ete(itr, cpu)) {
> +		magic = __perf_cs_ete_magic;
> +		/* ETE uses the same registers as ETMv4 plus TRCDEVARCH */
> +		cs_etm_save_etmv4_header(&info->priv[*offset], itr, cpu);
> +		info->priv[*offset + CS_ETE_TRCDEVARCH] =
> +			cs_etm_get_ro(cs_etm_pmu, cpu,
> +				      metadata_etmv4_ro[CS_ETE_TRCDEVARCH]);
> +

minor nit: It may be nicer to have a helper function like we do for 
etmv4. i.e,
		cs_etm_save_ete_header();

to keep the code consistent.

> +		/* How much space was used */
> +		increment = CS_ETE_PRIV_MAX;
> +		nr_trc_params = CS_ETE_PRIV_MAX - CS_ETM_COMMON_BLK_MAX_V1;
> +	} else if (cs_etm_is_etmv4(itr, cpu)) {
>   		magic = __perf_cs_etmv4_magic;
>   		cs_etm_save_etmv4_header(&info->priv[*offset], itr, cpu);
>   
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index f4b2bff533f3..d540512a3c96 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c


>   		for (j = 0; j < total_params; j++, i++) {
>   			/* if newer record - could be excess params */
> -			if (j >= CS_ETMV4_PRIV_MAX)
> +			if (j >= CS_ETE_PRIV_MAX)
>   				fprintf(stdout, param_unk_fmt, j, val[i]);
>   			else
>   				fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
> @@ -2943,6 +2949,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>   
>   			/* The traceID is our handle */
>   			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
> +		} else if (ptr[i] == __perf_cs_ete_magic) {
> +			metadata[j] =
> +				cs_etm__create_meta_blk(ptr, &i, CS_ETE_PRIV_MAX, -1);

minor nit: I would prefer the arguments to be split into the next line,
rather than moving the function call to the next line. i.e,

			metatdata[j] = cs_etm_create_meta_blk(ptr, &i,
							      ....
						
> +
> +			/* ETE shares first part of metadata with ETMv4 */
> +			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
>   		}
>   
>   		if (!metadata[j]) {
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index d65c7b19407d..08b84c21f065 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -76,6 +76,14 @@ enum {
>   /* define fixed version 0 length - allow new format reader to read old files. */
>   #define CS_ETMV4_NR_TRC_PARAMS_V0 (CS_ETMV4_TRCAUTHSTATUS - CS_ETMV4_TRCCONFIGR + 1)
>   
> +/* ETE metadata is ETMv4 plus TRCDEVARCH register and doesn't support header V0 since it was

minor nit: comment style.

	/*
	 * ETE metadata...
	 *
	 */



Suzuki

