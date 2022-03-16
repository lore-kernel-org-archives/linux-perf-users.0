Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B5CC4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Mar 2022 15:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbiCPPOk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357975AbiCPPOL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Mar 2022 11:14:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 462066C1D6;
        Wed, 16 Mar 2022 08:12:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 100031515;
        Wed, 16 Mar 2022 08:11:58 -0700 (PDT)
Received: from [10.57.6.128] (unknown [10.57.6.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FB673F7D7;
        Wed, 16 Mar 2022 08:11:54 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] perf mem: Support HITM for when mem_lvl_num is
 used
To:     Leo Yan <leo.yan@linaro.org>, Ali Saidi <alisaidi@amazon.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, benh@kernel.crashing.org,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org, yao.jin@linux.intel.com,
        Nick.Forrington@arm.com
References: <df73fb93-3892-6713-8ebe-bc57a861ec5d@arm.com>
 <20220314183721.3198-1-alisaidi@amazon.com>
 <172ce478-b539-2aa4-0470-1b96c6b8169b@arm.com>
 <7b3aaa4d-5194-a729-f8ad-d55ada7fa58f@arm.com>
 <20220316124208.GA310478@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <1637567b-42df-57d5-2987-939ffbf451ef@arm.com>
Date:   Wed, 16 Mar 2022 15:10:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220316124208.GA310478@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 16/03/2022 12:42, Leo Yan wrote:
> On Wed, Mar 16, 2022 at 11:43:52AM +0000, German Gomez wrote:
>
> [...]
>
>>>>> I had a look at the TRMs for the N1[1], V1[2] and N2[3] Neoverse cores
>>>>> (specifically the LL_CACHE_RD pmu events). If we were to assign a number
>>>>> to the system cache (assuming all caches are implemented):
>>>>>
>>>>> *For N1*, if L2 and L3 are implemented, system cache would follow at *L4*
>>>> To date no one has built 4 level though. Everyone has only built three.
>>> The N1SDP board advertises 4 levels (we use it regularly for testing perf patches)
>> That said, it's probably the odd one out.
>>
>> I'm not against assuming 3 levels. Later if there's is a strong need for L4, indeed we can go back and change it.
> Thanks for the info.
>
> For exploring cache hierarchy via sysFS is a good idea, the only one
> concern for me is: can we simply take the system cache as the same
> thing as the highest level cache?  If so, I think another option is to

For Neoverse, it should be. LL_CACHE_RD pmu event says (if system cache is implemented):

* If CPUECTLR.EXTLLC is set: This event counts any cacheable read transaction which returns a data source of 'interconnect cache'.

> define a cache level as "PERF_MEM_LVLNUM_SYSTEM_CACHE" and extend the
> decoding code for support it.
>
> With PERF_MEM_LVLNUM_SYSTEM_CACHE, it can tell users clearly the data
> source from system cache, and users can easily map this info with the
> cache media on the working platform.
>
> In practice, I don't object to use cache level 3 at first step.  At
> least this can meet the requirement at current stage.

Ok, I agree. I think for now it is a good compromise.
Detecting the caches seems like an additional/separate perf feature.

Thanks,
German

> Thanks,
> Leo
