Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB65C433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 13 Mar 2022 11:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiCMLrd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 13 Mar 2022 07:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiCMLrc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 13 Mar 2022 07:47:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD8FBD2E5
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Mar 2022 04:46:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dr20so28057708ejc.6
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Mar 2022 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SNsfX6wln/iQL4CsXHtqy5uLaiZcRM+kpipJSHZHotM=;
        b=RH+PJQm/x3npaBw/R4u5uDMz0f0LtTeLm1pKlQX5fVTe6snDFfb4eDS3RYinyujcfe
         9dz1Vdgb4vAYAHmH+LjAjCLrgsB7Tq8gQsMGaoDI5ghh9GuzdOseM0Fcdj8CmTMmeBip
         N9ppEmSUmr5iRceWB/3wbudfjgywIDKeJNDhHXJ5grMT2DrLlq1cSV28k5WXMQyLDCU+
         kd/RxCSBtnpSLZbBVKYbe+rJBvPVk5jSsiIaDjp9c1BNiRQQ+Kqu1nm6BxEzphpLU4n0
         auA7hmdCR1R6jhNbfDSLKXzSqXSdhu5cYZiNyiKl/UorLTXp7knfbpva1PBkE1q7lTNv
         XoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SNsfX6wln/iQL4CsXHtqy5uLaiZcRM+kpipJSHZHotM=;
        b=XjyI6sqZGmxcENhQd174+SZ6P7tPQINlZtj+3ibnvc5iCFFr8GpgUganqwrdKeA3tC
         5elJ29LZWF6jorj+q6SqkEiMNiKCE41CAnJOl1IBvEeDlOrOt4UjcmbgX+dbd8+X+KWy
         xAHu93ANlHVItegMxEFnoAgji+Beu6cAMH4L9kW2B0Y1pEjP2gkTZcGQi8rvnQ/nMHhy
         f0NF3BNV/7YiMCCqOsyWDj5dhI4Xw592buMpMIldfadbmhHI/90iMY36tI1n/39gM+hR
         J+6lnLe+ElleIsR9t74MBvFq8/LGgGFG1cZK4+jIHTJm1E455lvKvqTTqH32sS9l1q2q
         0/Yg==
X-Gm-Message-State: AOAM5329cZgLD0O7tSeHu1yLhLG2C32YAPfB9Ls/egF79jk2DitniZH9
        gmk3WMr283+lMP0ESeDg8l4taQ==
X-Google-Smtp-Source: ABdhPJzJ/N17qvR13uZ6XVSwq9RGXE9kwxkLwEBFjrbS7zYS17/ZDSz97M0O9LOpJoAzfq3Ny3yV2g==
X-Received: by 2002:a17:906:6a81:b0:6da:d7e5:4fa with SMTP id p1-20020a1709066a8100b006dad7e504famr14731162ejr.223.1647171982918;
        Sun, 13 Mar 2022 04:46:22 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id qp3-20020a170907206300b006da96b87e9csm5357885ejb.181.2022.03.13.04.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 04:46:22 -0700 (PDT)
Date:   Sun, 13 Mar 2022 19:46:15 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, benh@kernel.crashing.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>
Subject: Re: [PATCH v2 1/2] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <20220313114615.GA143848@leoy-ThinkPad-X240s>
References: <20220221224807.18172-1-alisaidi@amazon.com>
 <2733b4a4-dd73-0b71-5309-e2bf0cc70d4c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2733b4a4-dd73-0b71-5309-e2bf0cc70d4c@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ali, German,

On Wed, Mar 02, 2022 at 11:59:05AM +0000, German Gomez wrote:
> Hi Ali,
> 
> On 21/02/2022 22:47, Ali Saidi wrote:
> > When synthesizing data from SPE, augment the type with source information
> > for Arm Neoverse cores. The field is IMPLDEF but the Neoverse cores all use
> > the same encoding. I can't find encoding information for any other SPE
> > implementations to unify their choices with Arm's thus that is left for
> > future work.
> >
> > This change populates the mem_lvl_num for Neoverse cores instead of the
> > deprecated mem_lvl namespace.
> >
> > Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> > ---
> >  .../util/arm-spe-decoder/arm-spe-decoder.c    |   1 +
> >  .../util/arm-spe-decoder/arm-spe-decoder.h    |  12 ++
> >  tools/perf/util/arm-spe.c                     | 106 +++++++++++++++---
> >  3 files changed, 104 insertions(+), 15 deletions(-)
> >
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > index 5e390a1a79ab..091987dd3966 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > @@ -220,6 +220,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
> >  
> >  			break;
> >  		case ARM_SPE_DATA_SOURCE:
> > +			decoder->record.source = payload;
> >  			break;
> >  		case ARM_SPE_BAD:
> >  			break;
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> > index 69b31084d6be..c81bf90c0996 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> > @@ -29,6 +29,17 @@ enum arm_spe_op_type {
> >  	ARM_SPE_ST		= 1 << 1,
> >  };
> >  
> > +enum arm_spe_neoverse_data_source {
> > +	ARM_SPE_NV_L1D        = 0x0,
> > +	ARM_SPE_NV_L2         = 0x8,
> > +	ARM_SPE_NV_PEER_CORE  = 0x9,
> > +	ARM_SPE_NV_LCL_CLSTR  = 0xa,
> > +	ARM_SPE_NV_SYS_CACHE  = 0xb,
> > +	ARM_SPE_NV_PEER_CLSTR = 0xc,
> > +	ARM_SPE_NV_REMOTE     = 0xd,
> > +	ARM_SPE_NV_DRAM       = 0xe,
> > +};
> > +
> >  struct arm_spe_record {
> >  	enum arm_spe_sample_type type;
> >  	int err;
> > @@ -40,6 +51,7 @@ struct arm_spe_record {
> >  	u64 virt_addr;
> >  	u64 phys_addr;
> >  	u64 context_id;
> > +	u16 source;
> >  };
> >  
> >  struct arm_spe_insn;
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index d2b64e3f588b..e0243c2fed5f 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -34,6 +34,7 @@
> >  #include "arm-spe-decoder/arm-spe-decoder.h"
> >  #include "arm-spe-decoder/arm-spe-pkt-decoder.h"
> >  
> > +#include <../../../arch/arm64/include/asm/cputype.h>
> >  #define MAX_TIMESTAMP (~0ULL)
> >  
> >  struct arm_spe {
> > @@ -45,6 +46,7 @@ struct arm_spe {
> >  	struct perf_session		*session;
> >  	struct machine			*machine;
> >  	u32				pmu_type;
> > +	u64				midr;
> >  
> >  	struct perf_tsc_conversion	tc;
> >  
> > @@ -399,33 +401,103 @@ static bool arm_spe__is_memory_event(enum arm_spe_sample_type type)
> >  	return false;
> >  }
> >  
> > -static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
> > -{
> > -	union perf_mem_data_src	data_src = { 0 };
> > +static const struct midr_range neoverse_spe[] = {
> > +	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
> > +	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> > +	{},
> > +};
> >  
> > -	if (record->op == ARM_SPE_LD)
> > -		data_src.mem_op = PERF_MEM_OP_LOAD;
> > -	else
> > -		data_src.mem_op = PERF_MEM_OP_STORE;
> >  
> > +static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
> > +						union perf_mem_data_src *data_src)
> > +{
> > +	switch (record->source) {
> > +	case ARM_SPE_NV_L1D:
> > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> 
> I understand mem_lvl is deprecated but shouldn't we add the level bits here as well for backwards compat?

Thanks for pointing out this.  Yeah, I think German's suggestion is
valid, the commit 6ae5fa61d27d ("perf/x86: Fix data source decoding
for Skylake") introduces new field 'mem_lvl_num', but it also keeps
backwards compatible for the field 'mem_lvl'.

> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> > +		break;
> > +	case ARM_SPE_NV_L2:
> > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> > +		break;
> > +	case ARM_SPE_NV_PEER_CORE:
> > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;

For PEER_CORE data source, we don't know if it's coming from peer
core's L1 cache or L2 cache, right?

If so, do you think if it's possible to retrieve more accurate info
from the field "record->type"?

> > +		break;
> > +	/*
> > +	 * We don't know if this is L1, L2, or even L3 (for the cases the system
> > +	 * has an L3, but we do know it was a cache-2-cache transfer, so set
> > +	 * SNOOP_HITM
> > +	 */
> > +	case ARM_SPE_NV_LCL_CLSTR:
> > +	case ARM_SPE_NV_PEER_CLSTR:
> > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;

Seems to me, we need to add attribution to indicate the difference
between ARM_SPE_NV_PEER_CORE and ARM_SPE_NV_LCL_CLSTR.

For ARM_SPE_NV_PEER_CLSTR data source, should we set any "remote"
attribution as well?

> > +		break;
> > +	/*
> > +	 * System cache is assumed to be L4, as cluster cache (if it exists)
> > +	 * would be L3 cache on Neoverse platforms
> > +	 */
> > +	case ARM_SPE_NV_SYS_CACHE:
> > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L4;
> > +		break;
> > +	/*
> > +	 * We don't know what level it hit in, except it came from the other
> > +	 * socket
> > +	 */
> > +	case ARM_SPE_NV_REMOTE:
> > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> > +		break;

Just curious, is it possible that 'record->source' combines multiple
bits?  Like we can get a data source value with:

  ARM_SPE_NV_REMOTE | ARM_SPE_NV_REMOTE

> > +	case ARM_SPE_NV_DRAM:
> > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> > +static void arm_spe__synth_data_source_generic(const struct arm_spe_record *record,
> > +						union perf_mem_data_src *data_src)
> > +{
> >  	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
> > -		data_src.mem_lvl = PERF_MEM_LVL_L3;
> > +		data_src->mem_lvl = PERF_MEM_LVL_L3;
> >  
> >  		if (record->type & ARM_SPE_LLC_MISS)
> > -			data_src.mem_lvl |= PERF_MEM_LVL_MISS;
> > +			data_src->mem_lvl |= PERF_MEM_LVL_MISS;
> >  		else
> > -			data_src.mem_lvl |= PERF_MEM_LVL_HIT;
> > +			data_src->mem_lvl |= PERF_MEM_LVL_HIT;
> >  	} else if (record->type & (ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS)) {
> > -		data_src.mem_lvl = PERF_MEM_LVL_L1;
> > +		data_src->mem_lvl = PERF_MEM_LVL_L1;
> >  
> >  		if (record->type & ARM_SPE_L1D_MISS)
> > -			data_src.mem_lvl |= PERF_MEM_LVL_MISS;
> > +			data_src->mem_lvl |= PERF_MEM_LVL_MISS;
> >  		else
> > -			data_src.mem_lvl |= PERF_MEM_LVL_HIT;
> > +			data_src->mem_lvl |= PERF_MEM_LVL_HIT;
> >  	}
> >  
> >  	if (record->type & ARM_SPE_REMOTE_ACCESS)
> > -		data_src.mem_lvl |= PERF_MEM_LVL_REM_CCE1;
> > +		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
> > +}
> > +
> > +static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
> > +{
> > +	union perf_mem_data_src	data_src = { 0 };
> > +	bool is_neoverse = is_midr_in_range(midr, neoverse_spe);
> > +
> > +	if (record->op & ARM_SPE_LD)
> > +		data_src.mem_op = PERF_MEM_OP_LOAD;
> > +	else
> > +		data_src.mem_op = PERF_MEM_OP_STORE;
> > +
> > +	if (is_neoverse)
> > +		arm_spe__synth_data_source_neoverse(record, &data_src);
> > +	else
> > +		arm_spe__synth_data_source_generic(record, &data_src);
> >  
> >  	if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
> >  		data_src.mem_dtlb = PERF_MEM_TLB_WK;
> > @@ -446,7 +518,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
> >  	u64 data_src;
> >  	int err;
> >  
> > -	data_src = arm_spe__synth_data_source(record);
> > +	data_src = arm_spe__synth_data_source(record, spe->midr);
> >  
> >  	if (spe->sample_flc) {
> >  		if (record->type & ARM_SPE_L1D_MISS) {
> > @@ -796,6 +868,10 @@ static int arm_spe_process_event(struct perf_session *session,
> >  	u64 timestamp;
> >  	struct arm_spe *spe = container_of(session->auxtrace,
> >  			struct arm_spe, auxtrace);
> > +	const char *cpuid = perf_env__cpuid(session->evlist->env);
> > +	u64 midr = strtol(cpuid, NULL, 16);
> > +
> > +	spe->midr = midr;
> 
> I think this midr setup belongs in the arm_spe_process_auxtrace_info callback instead.

Yeah, arm_spe_process_event() would be invoked for multiple times for
processing perf events.  arm_spe_process_auxtrace_info() would be a
good place to initialize midr.

Thanks,
Leo
