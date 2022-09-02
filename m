Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DBCC54EE9
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Sep 2022 08:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiIBIEf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 2 Sep 2022 04:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbiIBIEe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Sep 2022 04:04:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEA0BBA7E;
        Fri,  2 Sep 2022 01:04:30 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJr5W5vh6z67Vdy;
        Fri,  2 Sep 2022 16:03:43 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 10:04:27 +0200
Received: from [10.195.34.23] (10.195.34.23) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 2 Sep
 2022 09:04:26 +0100
Message-ID: <c17d8229-6029-3fd6-1ce5-f406962eae8f@huawei.com>
Date:   Fri, 2 Sep 2022 09:04:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] perf vendor events: Add missing Neoverse V1 events
To:     Nick Forrington <nick.forrington@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        "Mike Leach" <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220901151804.294823-1-nick.forrington@arm.com>
In-Reply-To: <20220901151804.294823-1-nick.forrington@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.34.23]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 01/09/2022 16:18, Nick Forrington wrote:
> Based on updated data from:
> https://github.com/ARM-software/data/blob/master/pmu/neoverse-v1.json
> 
> which is based on PMU event descriptions from the Arm Neoverse V1
> Technical Reference Manual.
> 
> This adds the following missing events:
> ASE_INST_SPEC
> SVE_INST_SPEC
> SVE_PRED_SPEC
> SVE_PRED_EMPTY_SPEC
> SVE_PRED_FULL_SPEC
> SVE_PRED_PARTIAL_SPEC
> SVE_LDFF_SPEC
> SVE_LDFF_FAULT_SPEC
> FP_SCALE_OPS_SPEC
> FP_FIXED_OPS_SPEC
> 
> It also moves REMOTE_ACCESS from other.json to memory.json.

Any specific reason why? I see that neoverse n2 and a76-n1 still use 
"other" json for REMOTE_ACCESS. Nicer to be consistent.

> 
> Signed-off-by: Nick Forrington<nick.forrington@arm.com>
> ---

Apart from above:
Reviewed-by: John Garry <john.garry@huawei.com>
