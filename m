Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE19C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 May 2022 15:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353533AbiELPwy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 12 May 2022 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346693AbiELPwx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 12 May 2022 11:52:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AA013B8C1;
        Thu, 12 May 2022 08:52:51 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KzbnZ4KLDz685gj;
        Thu, 12 May 2022 23:49:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 17:52:48 +0200
Received: from [10.47.25.226] (10.47.25.226) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 16:52:47 +0100
Message-ID: <1062b28d-9c7b-89fb-d3bf-519f84029b96@huawei.com>
Date:   Thu, 12 May 2022 16:52:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
To:     Nick Forrington <nick.forrington@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        "Will Deacon" <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Leo Yan" <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20220510104758.64677-1-nick.forrington@arm.com>
 <YnqJwMfi/bcDmN4H@kernel.org>
 <b1081013-2cd9-f223-8125-d7e51d784f90@huawei.com>
 <eec03f0d-d491-511c-d9b0-694c6d527b38@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <eec03f0d-d491-511c-d9b0-694c6d527b38@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.25.226]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 12/05/2022 14:01, Nick Forrington wrote:
> On 10/05/2022 16:55, John Garry wrote:
>> On 10/05/2022 16:50, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, May 10, 2022 at 11:47:38AM +0100, Nick Forrington escreveu:
>>>> Add Performance Monitoring Unit event data for the Arm CPUs listed
>>>> below.
>>>>
>>>> Changesets are dependent due to incremental updates to the common 
>>>> events
>>>> file and mapfile.csv.
>>>>
>>>> Data is sourced fromhttps://github.com/ARM-software/data
>>> Waiting for reviews to merge this.
>>>
>>
>> I'll have a closer look this week

Generally this looks ok:

Reviewed-by: John Garry <john.garry@huawei.com>

If you are feeling particularly helpful then you can add support for any 
events missing to pre-existing core support, like a57-a72.

Thanks,
john
