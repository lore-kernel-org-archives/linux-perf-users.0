Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D82C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Aug 2021 13:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A2160F38
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Aug 2021 13:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhHCNJy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:09:54 -0400
Received: from foss.arm.com ([217.140.110.172]:49464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235635AbhHCNJx (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Aug 2021 09:09:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D76E11FB;
        Tue,  3 Aug 2021 06:09:42 -0700 (PDT)
Received: from [10.57.36.239] (unknown [10.57.36.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0CE33F70D;
        Tue,  3 Aug 2021 06:09:39 -0700 (PDT)
Subject: Re: [PATCH 5/6] perf cs-etm: Create ETE decoder
To:     Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
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
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-6-james.clark@arm.com>
 <20210731072341.GE7437@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <654cf3ae-325b-49c9-a9d0-ebf704a83d6f@arm.com>
Date:   Tue, 3 Aug 2021 14:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210731072341.GE7437@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 31/07/2021 08:23, Leo Yan wrote:
> On Wed, Jul 21, 2021 at 10:07:04AM +0100, James Clark wrote:
>> If the TRCDEVARCH register was saved, and it shows that ETE is present,
>> then instantiate an OCSD_BUILTIN_DCD_ETE decoder instead of
>> OCSD_BUILTIN_DCD_ETMV4I. ETE is the new trace feature for Armv9.
>>
>> Testing performed
>> =================
>>
>> * Old files with v0 headers still open correctly
>> * Old files with v1 headers with no TRCDEVARCH saved still open
>> * New files with TRCDEVARCH open using an old version of perf that
>>   supports v1 headers
>> * Coresight decoding results in the same output if there are no new ETE
>>   packet types
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 29 ++++++++++-
>>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  7 +++
>>  tools/perf/util/cs-etm.c                      | 49 ++++++++++++++++++-
>>  tools/perf/util/cs-etm.h                      |  1 +
>>  4 files changed, 82 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> index 60147c908425..37bc9d6a7677 100644
>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> @@ -127,8 +127,12 @@ static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
>>  #define TRCIDR1_TRCARCHMIN_SHIFT 4
>>  #define TRCIDR1_TRCARCHMIN_MASK  GENMASK(7, 4)
>>  #define TRCIDR1_TRCARCHMIN(x)    (((x) & TRCIDR1_TRCARCHMIN_MASK) >> TRCIDR1_TRCARCHMIN_SHIFT)
>> -static enum _ocsd_arch_version cs_etm_decoder__get_arch_ver(u32 reg_idr1)
>> +static enum _ocsd_arch_version cs_etm_decoder__get_arch_ver(u32 reg_idr1, u32 reg_devarch)
>>  {
>> +	/* ETE has to be v9 so set arch version to v8.3+ (ARCH__AA64) */
>> +	if (cs_etm__is_ete(reg_devarch))
>> +		return ARCH_AA64;
>> +
> 
> Based on values used in below change, I think we can unify the ETM
> versio number like:
> 
>   ARCH_V8R3 : REVISION, bits[19:16] is 0x3
>   ARCH_V8R4 : REVISION, bits[19:16] is 0x4
>   ARCH_V8R5 : REVISION, bits[19:16] is 0x5

Do you mean make this change in OpenCSD? At the moment it understands these
values so I'm not sure if the extra ones would be useful:

	/** Core Architecture Version */
	typedef enum _ocsd_arch_version {
	    ARCH_UNKNOWN = 0x0000,   /**< unknown architecture */
	    ARCH_CUSTOM = 0x0001,    /**< None ARM, custom architecture */
	    ARCH_V7 = 0x0700,        /**< V7 architecture */
	    ARCH_V8 = 0x0800,        /**< V8 architecture */
	    ARCH_V8r3 = 0x0803,      /**< V8.3 architecture */
	    ARCH_AA64 = 0x0864,      /**< Min v8r3 plus additional AA64 PE features */
	    ARCH_V8_max = ARCH_AA64,
	} ocsd_arch_version_t;

[...]

>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>> index 11f3391d06f2..9137796fe3c5 100644
>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>> @@ -37,11 +37,17 @@ struct cs_etmv4_trace_params {
>>  	u32 reg_traceidr;
>>  };
>>  
>> +struct cs_ete_trace_params {
>> +	struct cs_etmv4_trace_params base_params;
>> +	u32 reg_devarch;
> 
> As we have said, can we directly support ETMv4.5, so that it can
> smoothly support ETE features?  If so, we don't need to add a new
> structure "cs_ete_trace_params" at here.
> 

I think with the new magic number change this is more likely to stay,
what are your thoughts?

[...]

>> +
>> +#define TRCDEVARCH_ARCHPART_SHIFT 0
>> +#define TRCDEVARCH_ARCHPART_MASK  GENMASK(11, 0)
>> +#define TRCDEVARCH_ARCHPART(x)    (((x) & TRCDEVARCH_ARCHPART_MASK) >> TRCDEVARCH_ARCHPART_SHIFT)
>> +
>> +#define TRCDEVARCH_ARCHVER_SHIFT 12
>> +#define TRCDEVARCH_ARCHVER_MASK  GENMASK(15, 12)
>> +#define TRCDEVARCH_ARCHVER(x)    (((x) & TRCDEVARCH_ARCHVER_MASK) >> TRCDEVARCH_ARCHVER_SHIFT)
>> +
>> +bool cs_etm__is_ete(u32 trcdevarch)
>> +{
>> +	/*
>> +	 * ETE if ARCHVER is 5 (ARCHVER is 4 for ETM) and ARCHPART is 0xA13.
>> +	 * See ETM_DEVARCH_ETE_ARCH in coresight-etm4x.h
>> +	 */
>> +	return TRCDEVARCH_ARCHVER(trcdevarch) == 5 && TRCDEVARCH_ARCHPART(trcdevarch) == 0xA13;
> 
> I think this is incorrect.
> 
> Here should check the bit field "REVISION, bits[19:16]".  If it's
> field value is >= 5, then we can say it supports ETE.  I checked the
> spec for ETMv4.4 and ETMv4.6, both use the same values for the
> Bits[15:12] = 0x4, so the architecture ID is same for ETMv4.x IPs.
> 

I tried to copy this as closely as possible from the ETE driver. See in coresight-etm4x.h

	#define ETM_DEVARCH_ETE_ARCH						\
		(ETM_DEVARCH_ARCHITECT_ARM | ETM_DEVARCH_ARCHID_ETE | ETM_DEVARCH_PRESENT) 

Where ETM_DEVARCH_ARCHID_ETE is ARCHVER == 5 and ARCHPART == 0xA13. I didn't check 
ETM_DEVARCH_ARCHITECT_ARM because I thought that wouldn't be necessary. If we want to make
the change do detect >= 5 then I think this should be made in the driver first. @Suzuki,
what do you think?

Thanks
James

