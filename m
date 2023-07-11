Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DD5EB64DC
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 Jul 2023 10:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjGKKSd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 Jul 2023 06:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjGKKS0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Jul 2023 06:18:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14690DB
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 03:18:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EED082B;
        Tue, 11 Jul 2023 03:19:06 -0700 (PDT)
Received: from [10.57.29.69] (unknown [10.57.29.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86D6D3F67D;
        Tue, 11 Jul 2023 03:18:23 -0700 (PDT)
Message-ID: <1eb50ae1-8c7c-7108-d9e7-0422752c4d9d@arm.com>
Date:   Tue, 11 Jul 2023 11:18:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/5] perf jevents: Match on highest version of Arm json
 file available
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>
Cc:     namhyung@kernel.org, acme@kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
References: <20230710141903.1595312-1-james.clark@arm.com>
 <20230710141903.1595312-3-james.clark@arm.com>
 <a35179ad-bb62-113d-3a7e-da4d2ec3c0b0@oracle.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <a35179ad-bb62-113d-3a7e-da4d2ec3c0b0@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/07/2023 17:56, John Garry wrote:
> On 10/07/2023 15:19, James Clark wrote:
> 
> +
> 
> 
> Hi James,
> 
> It would be good to cc some additional people and lists.

Hi John,

Resent a v3 with the normal get_maintainer list. I did this with the
first one but it bounced and for some reason with the v2 I reduced the
CC list. Not sure why really...

> 
>> Currently version and revision fields are masked out of the MIDR so
> 
> Do you mean variant and revision?
> 

Yes that should have been variant. Fixed in v3, thanks.

>> there can only be one set of jsons per CPU. In a later commit multiple
>> revisions of Neoverse N2 json files will be provided.
>>
> 
> 
>> The highest valid version of json files should be used,
> 
> What exactly does that mean?
> 
> So it seems that you have CPUs with matching MIDR except variant and
> revision, but have different events, right?

Yes. In this case we changed how a metric is calculated in N2-r0p3
because the workaround that was needed for r0p0 is no longer needed
(CPU_CYCLES should not subtracted from stalls for topdown metrics
anymore). But it would also support the case where the event list was
slightly different between versions.

> 
> Then to solve that are you saying that the highest version of the JSONs
> should used, upto and including the same CPU version (???) - correct?

Yeah pretty much. It's highest version of JSONs starting from
(including) the same CPU version, up to and not including the next
version of JSON files provided. If only r0p0 is provided then all CPU
versions match.

So if these JSONs were provided:

 r0p0  -  r0p4  -  r1p1

Would match these CPUs:

 CPU   |  JSON matched
 ------|---------------
 r0p0  |  r0p0
 r0p3  |  r0p0
 r0p4  |  r0p4
 r1p0  |  r0p4
 r1p1+ |  r1p1

> 
> The cover letter doesn't mention anything relevant :(
> 

Hopefully I expanded more in the v3 cover letter.

Thanks
James

>> but to make this
>> work the mapfile has to be reverse sorted on the CPUID field so that the
>> highest is found first.
>> It's possible, but error prone, to do this
>> manually so instead add an explicit sort into jevents.py. If the CPUID
>> is a string then the rows are string sorted rather than numerically.
>>
> 
> Thanks,
> John
> 
