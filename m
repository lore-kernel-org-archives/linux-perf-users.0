Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF9EC49EAB
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Jun 2021 19:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D454E6140F
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Jun 2021 19:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhFXTI0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:08:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:40240 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232694AbhFXTIZ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Jun 2021 15:08:25 -0400
IronPort-SDR: uGYjZ+ofxejniPV0NPrmdZBs7EaNtAG8CkT616d/FytDZl6i2hk0jo2etzaHZYzqkRSWj77pUA
 3EQZXVbR6WCw==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="229131708"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="229131708"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 12:06:05 -0700
IronPort-SDR: +1qitdYIQ0Xfmc+/A1mpr/8L6W9RRsXrLC6NdDuRbiiVd4LpIO1K9y+mYuvXPjhfMo0ZaZjGLh
 zLMkHSKmps6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="639887905"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jun 2021 12:06:04 -0700
Received: from [10.212.160.234] (kliang2-MOBL.ccr.corp.intel.com [10.212.160.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A802058060A;
        Thu, 24 Jun 2021 12:06:03 -0700 (PDT)
Subject: Re: [PATCH] x86: eas should not be NULL when it is referenced
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     13145886936@163.com, tglx@linutronix.de, bp@alien8.de,
        x86@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>,
        "Antonov, Alexander" <alexander.antonov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210624070442.34291-1-13145886936@163.com>
 <40e66cf9-398b-20d7-ce4d-433be6e08921@linux.intel.com>
Message-ID: <f313e0d9-b18e-5dd8-cadf-ee0a689f20ea@linux.intel.com>
Date:   Thu, 24 Jun 2021 15:06:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <40e66cf9-398b-20d7-ce4d-433be6e08921@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


Oops, forgot to add Peter.

On 6/24/2021 3:03 PM, Liang, Kan wrote:
> 
> Hi Shengxian,
> 
> Thanks for the patch.
> 
> On 6/24/2021 3:04 AM, 13145886936@163.com wrote:
>> From: gushengxian <gushengxian@yulong.com>
>>
>> "eas" should not be NULL when it is referenced.
>>
> 
> I think the NULL pointer dereference of eas should not happen, because 
> die is -1 if eas is NULL. But the whole error handling path looks fragile.
> 
> We already fixed one issue caused by it in commit ID f797f05d917f 
> ("perf/x86/intel/uncore: Fix for iio mapping on Skylake Server")
> https://lore.kernel.org/lkml/160149233331.7002.10919231011379055356.tip-bot2@tip-bot2/ 
> 
> 
> Maybe something as below?
> 
>  From 3de81ba3b04262ef3346297d82f6c4ffb4af7029 Mon Sep 17 00:00:00 2001
> From: Kan Liang <kan.liang@linux.intel.com>
> Date: Thu, 24 Jun 2021 11:17:57 -0700
> Subject: [PATCH] perf/x86/intel/uncore: Clean up error handling path of 
> iio mapping
> 
> The error handling path of iio mapping looks fragile. We already fixed
> one issue caused by it, commit ID f797f05d917f ("perf/x86/intel/uncore:
> Fix for iio mapping on Skylake Server"). Clean up the error handling
> path and make the code robust.
> 
> Reported-by: gushengxian <gushengxian@yulong.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>   arch/x86/events/intel/uncore_snbep.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c 
> b/arch/x86/events/intel/uncore_snbep.c
> index 7622762..6d4a5a9 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3802,11 +3802,11 @@ pmu_iio_set_mapping(struct intel_uncore_type 
> *type, struct attribute_group *ag)
>       /* One more for NULL. */
>       attrs = kcalloc((uncore_max_dies() + 1), sizeof(*attrs), GFP_KERNEL);
>       if (!attrs)
> -        goto err;
> +        goto clear_topology;
> 
>       eas = kcalloc(uncore_max_dies(), sizeof(*eas), GFP_KERNEL);
>       if (!eas)
> -        goto err;
> +        goto clear_attrs;
> 
>       for (die = 0; die < uncore_max_dies(); die++) {
>           sprintf(buf, "die%ld", die);
> @@ -3827,7 +3827,9 @@ pmu_iio_set_mapping(struct intel_uncore_type 
> *type, struct attribute_group *ag)
>       for (; die >= 0; die--)
>           kfree(eas[die].attr.attr.name);
>       kfree(eas);
> +clear_attrs:
>       kfree(attrs);
> +clear_topology:
>       kfree(type->topology);
>   clear_attr_update:
>       type->attr_update = NULL;
