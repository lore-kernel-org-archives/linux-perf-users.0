Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB52C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 14:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBCC61948
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 14:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhFYONz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Jun 2021 10:13:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:31447 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbhFYONz (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Jun 2021 10:13:55 -0400
IronPort-SDR: dKRdloxFPRB34hDLR5J6p0GLTWFpx6tuMrifuil8S4Z8NnrRCtQirLyFb4QhQmZTpPFWEfVWwd
 VHtchbre9Ciw==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="187364188"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="187364188"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 07:11:34 -0700
IronPort-SDR: aIJApmKyt7GrSCUnqHMTUlwlmG1DSBQKfI4ZHaTBXnskDAxynnYC3IDvU2Z3aBriXSXFcBDbIx
 ffR9veJkE3iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="407397304"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 25 Jun 2021 07:11:34 -0700
Received: from [10.212.190.24] (kliang2-MOBL.ccr.corp.intel.com [10.212.190.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8F7D158060A;
        Fri, 25 Jun 2021 07:11:33 -0700 (PDT)
Subject: Re: [PATCH] x86: eas should not be NULL when it is referenced
To:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        13145886936@163.com, tglx@linutronix.de, bp@alien8.de,
        x86@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210624070442.34291-1-13145886936@163.com>
 <40e66cf9-398b-20d7-ce4d-433be6e08921@linux.intel.com>
 <f313e0d9-b18e-5dd8-cadf-ee0a689f20ea@linux.intel.com>
 <f3e4b37b-ff84-ac4f-ff56-f03313a22cda@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <7d4862ae-7ac6-11e8-5c8d-74610eabd5b5@linux.intel.com>
Date:   Fri, 25 Jun 2021 10:11:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f3e4b37b-ff84-ac4f-ff56-f03313a22cda@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 6/25/2021 9:33 AM, Alexander Antonov wrote:
> Hello Kan,
>> On 6/24/2021 3:03 PM, Liang, Kan wrote:
>>> I think the NULL pointer dereference of eas should not happen, 
>>> because die is -1 if eas is NULL. But the whole error handling path 
>>> looks fragile.
>>>
>>> We already fixed one issue caused by it in commit ID f797f05d917f 
>>> ("perf/x86/intel/uncore: Fix for iio mapping on Skylake Server")
>>> https://lore.kernel.org/lkml/160149233331.7002.10919231011379055356.tip-bot2@tip-bot2/ 
>>>
>>>
>>> Maybe something as below?
>>>
>>>  From 3de81ba3b04262ef3346297d82f6c4ffb4af7029 Mon Sep 17 00:00:00 2001
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>> Date: Thu, 24 Jun 2021 11:17:57 -0700
>>> Subject: [PATCH] perf/x86/intel/uncore: Clean up error handling path 
>>> of iio mapping
>>>
>>> The error handling path of iio mapping looks fragile. We already fixed
>>> one issue caused by it, commit ID f797f05d917f ("perf/x86/intel/uncore:
>>> Fix for iio mapping on Skylake Server"). Clean up the error handling
>>> path and make the code robust.
> I didn't catch why does the current error handling path look fragile?
> Are there cases when it works incorrect?
>


I don't think it causes any severe problem for now, e.g., crash, because 
current code checks die before the dereference.
But I think it violates the Linux kernel coding style (one err bug) and 
may bring potential issues.

https://www.kernel.org/doc/html/v4.10/process/coding-style.html

Thanks,
Kan

> Thanks,
> Alexander
>>>
>>> Reported-by: gushengxian <gushengxian@yulong.com>
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>> ---
>>>   arch/x86/events/intel/uncore_snbep.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/events/intel/uncore_snbep.c 
>>> b/arch/x86/events/intel/uncore_snbep.c
>>> index 7622762..6d4a5a9 100644
>>> --- a/arch/x86/events/intel/uncore_snbep.c
>>> +++ b/arch/x86/events/intel/uncore_snbep.c
>>> @@ -3802,11 +3802,11 @@ pmu_iio_set_mapping(struct intel_uncore_type 
>>> *type, struct attribute_group *ag)
>>>       /* One more for NULL. */
>>>       attrs = kcalloc((uncore_max_dies() + 1), sizeof(*attrs), 
>>> GFP_KERNEL);
>>>       if (!attrs)
>>> -        goto err;
>>> +        goto clear_topology;
>>>
>>>       eas = kcalloc(uncore_max_dies(), sizeof(*eas), GFP_KERNEL);
>>>       if (!eas)
>>> -        goto err;
>>> +        goto clear_attrs;
>>>
>>>       for (die = 0; die < uncore_max_dies(); die++) {
>>>           sprintf(buf, "die%ld", die);
>>> @@ -3827,7 +3827,9 @@ pmu_iio_set_mapping(struct intel_uncore_type 
>>> *type, struct attribute_group *ag)
>>>       for (; die >= 0; die--)
>>>           kfree(eas[die].attr.attr.name);
>>>       kfree(eas);
>>> +clear_attrs:
>>>       kfree(attrs);
>>> +clear_topology:
>>>       kfree(type->topology);
>>>   clear_attr_update:
>>>       type->attr_update = NULL;
