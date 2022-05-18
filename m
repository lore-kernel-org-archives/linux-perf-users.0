Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC12C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 08:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiERIP3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 04:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiERIP2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 04:15:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FCA81990;
        Wed, 18 May 2022 01:15:25 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L35Ls2Fqlz6H7nv;
        Wed, 18 May 2022 16:12:21 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 10:15:23 +0200
Received: from [10.47.24.102] (10.47.24.102) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 09:15:22 +0100
Message-ID: <28509191-3a45-de6d-f5bc-a8e7331c0a9e@huawei.com>
Date:   Wed, 18 May 2022 09:15:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
To:     Robin Murphy <robin.murphy@arm.com>,
        Nick Forrington <nick.forrington@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
References: <20220510104758.64677-1-nick.forrington@arm.com>
 <f523b0fe-1262-c1e5-c587-15842ccf0fcf@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <f523b0fe-1262-c1e5-c587-15842ccf0fcf@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.24.102]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 17/05/2022 15:32, Robin Murphy wrote:
> 
> On 2022-05-10 11:47, Nick Forrington wrote:
>> Add Performance Monitoring Unit event data for the Arm CPUs listed
>> below.
>>
>> Changesets are dependent due to incremental updates to the common events
>> file and mapfile.csv.
>>
>> Data is sourced from https://github.com/ARM-software/data
>>
>> Nick Forrington (20):
>>    perf vendors events arm64: Arm Cortex-A5
>>    perf vendors events arm64: Arm Cortex-A7
>>    perf vendors events arm64: Arm Cortex-A8
>>    perf vendors events arm64: Arm Cortex-A9
>>    perf vendors events arm64: Arm Cortex-A15
>>    perf vendors events arm64: Arm Cortex-A17
>>    perf vendors events arm64: Arm Cortex-A32
> 
> Obligatory question over anything relating to the above CPUs being in an 
> "arch/arm64" directory... ;)

If we were to add to arm32/arm then the common event numbers and maybe 
other JSONs in future would need to be duplicated.

Would there be any reason to add to arm32/arm apart to from being 
strictly proper? Maybe if lots of other 32b support for other vendors 
came along then it could make sense (to separate them out).

thanks,
John

