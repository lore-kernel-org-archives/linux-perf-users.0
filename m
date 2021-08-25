Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3FCC4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 10:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFE661103
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 10:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbhHYKOY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Aug 2021 06:14:24 -0400
Received: from foss.arm.com ([217.140.110.172]:47660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235904AbhHYKOY (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Aug 2021 06:14:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31D7331B;
        Wed, 25 Aug 2021 03:13:38 -0700 (PDT)
Received: from [10.57.42.52] (unknown [10.57.42.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 307CE3F66F;
        Wed, 25 Aug 2021 03:13:36 -0700 (PDT)
Subject: Re: [PATCH v2 7/9] perf cs-etm: Create ETE decoder
To:     Leo Yan <leo.yan@linaro.org>
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
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-8-james.clark@arm.com>
 <20210824083305.GE204566@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <a677e5b6-ebef-039b-29df-b5ae6608d588@arm.com>
Date:   Wed, 25 Aug 2021 11:13:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824083305.GE204566@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 24/08/2021 09:33, Leo Yan wrote:
>> +static void cs_etm_decoder__gen_ete_config(struct cs_etm_trace_params *params,
>> +					   ocsd_ete_cfg *config)
>> +{
>> +	config->reg_configr = params->ete.reg_configr;
>> +	config->reg_traceidr = params->ete.reg_traceidr;
>> +	config->reg_idr0 = params->ete.reg_idr0;
>> +	config->reg_idr1 = params->ete.reg_idr1;
>> +	config->reg_idr2 = params->ete.reg_idr2;
>> +	config->reg_idr8 = params->ete.reg_idr8;
>> +	config->reg_devarch = params->ete.reg_devarch;
>> +	config->arch_ver = ARCH_AA64;
> Just a nitpick: if we connect with patch 02, it implement function
> cs_etm_decoder__get_etmv4_arch_ver().  We can extend it to a more
> general function cs_etm_decoder__get_arch_ver(); this can allow us to
> have a central place to calculate 'arch_ver' for different archs.
> 
> I understand your patch doesn't want to mix things between ETMv4 and
> ETE, either way is okay for me:

Hi Leo,

Yes that was one of the previous comments from Mike that the logic only applied
to ETMv4 so I made it v4 specific. The other arch_vers are fixed at the moment.
If we get a new one that needs changing depending on some config we can try to
add a generic function.

> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
