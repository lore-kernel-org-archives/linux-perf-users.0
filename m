Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50223EB64DA
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Jul 2023 12:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjGDMo6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Jul 2023 08:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGDMo5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Jul 2023 08:44:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A898EE70
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jul 2023 05:44:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0023C14;
        Tue,  4 Jul 2023 05:45:37 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87E793F663;
        Tue,  4 Jul 2023 05:44:53 -0700 (PDT)
Message-ID: <10d4d4b1-5611-3276-2422-c297f0530ce1@arm.com>
Date:   Tue, 4 Jul 2023 13:44:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: perf-tools-next: Request for testing hybrid changes
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@gmail.com>
References: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
 <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com>
 <a3958a0c-092f-b609-e2ea-0d35fddd4375@arm.com>
 <CAP-5=fX8Nwtra=EgRNh3Ybp+N0BKp4Cw=0uRS9ZCdPyGF4R_bA@mail.gmail.com>
 <f1cfdc5d-19df-5d71-15c4-59af06dd3d28@arm.com>
 <CAP-5=fXwdc4VK=6dEoD4V0Jp+unYghWYTfbN4ER2aYd9R52W1g@mail.gmail.com>
 <01bc8040-92ef-cf8b-967a-6782989ecf33@arm.com>
 <CAP-5=fVkRc9=ySJ=fG-SQ8oAKmE_1mhHHzSASmGHUsda5Qy92A@mail.gmail.com>
 <6310725b-cc30-49e4-d405-ed2d5f31b404@arm.com>
 <cc134bea-dbe3-cf41-4769-440b8c69e9b4@amd.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <cc134bea-dbe3-cf41-4769-440b8c69e9b4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 04/07/2023 13:33, Ravi Bangoria wrote:
>>> For heterogeneous ARM PMUs I believe this is exactly the path taken to
>>> cause the perf_event_open to fail. The resolution is to add the bit to
>>> the PMU's capabilities. I believe doing it here will suffice:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/drivers/perf/arm_pmu.c?h=perf/core#n877
>>> So:
>>> ```
>>> .capabilities = PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS,
>>> ```
>>> becomes:
>>> ```
>>> .capabilities = PERF_PMU_CAP_HETEROGENEOUS_CPUS |
>>> PERF_PMU_CAP_EXTENDED_REGS | PERF_PMU_CAP_EXTENDED_HW_TYPE,
>>> ```
>>> Now strictly speaking you only need this in the case of heterogeneous
>>> PMUs, but that's the case for other bits here and I don't see special
>>> case logic...
>>>
>>
>> Hi Ian,
>>
>> I tested the above and it seems to work fine on Arm so I will send it
>> shortly. Some of the legacy perf stat use cases are working better with
>> it so it makes sense to me. I also don't see a reason to not always do
>> it even for homogeneous PMUs. To be honest I don't see a reason not to
>> remove it as a capability and have it as the default behaviour
>> everywhere? It all happens in the core code so I'm not sure adding it
>> per PMU device is necessary, but maybe there is a reason?
> 
> EventSelect on AMD is 12 bits where upper nibble is passed via config[35:32].
> i.e. it conflicts with the semantics of PERF_PMU_CAP_EXTENDED_HW_TYPE. So,
> please don't make it default :)
> 
> Thanks,
> Ravi

Ah, thanks for the answer. It's a bit late now but I wonder why it
wasn't added as a completely new argument to perf_event_open. That would
have avoided that. Is there a difference between adding a completely new
argument and adding a new argument by stuffing something into an
existing field.

