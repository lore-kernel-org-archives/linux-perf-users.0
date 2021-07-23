Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2616C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 06:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E2060ED7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 06:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhGWGPq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 02:15:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:8460 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234004AbhGWGPq (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jul 2021 02:15:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="199088508"
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="199088508"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 23:56:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="471017491"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 23:56:17 -0700
Subject: Re: [PATCH v1] perf pmu: Add PMU alias support
To:     John Garry <john.garry@huawei.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210722014546.11948-1-yao.jin@linux.intel.com>
 <ef8cc210-1a0a-796c-effa-63af590d17aa@huawei.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <6b9fb1dc-5f53-d378-9119-84e991a0c86e@linux.intel.com>
Date:   Fri, 23 Jul 2021 14:56:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ef8cc210-1a0a-796c-effa-63af590d17aa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi John,

On 7/22/2021 6:28 PM, John Garry wrote:
> On 22/07/2021 02:45, Jin Yao wrote:
>> From: Kan Liang<kan.liang@linux.intel.com>
>>
>> A perf uncore PMU may have two PMU names, a real name and an alias. The
>> alias is exported at /sys/bus/event_source/devices/uncore_*/alias.
>> The perf tool should support the alias as well.
>>
>> Add alias_name in the struct perf_pmu to store the alias. For the PMU
>> which doesn't have an alias. It's NULL.
>>
>> Introduce two X86 specific functions to retrieve the real name and the
>> alias separately.
>>
>> Only go through the sysfs to retrieve the mapping between the real name
>> and the alias once. The result is cached in a list, uncore_pmu_list.
>>
>> Nothing changed for the other ARCHs.
>>
>> With the patch, the perf tool can monitor the PMU with either the real
>> name or the alias.
>>
>> Use the real name,
>>   $ perf stat -e uncore_cha_2/event=1/ -x,
>>     4044879584,,uncore_cha_2/event=1/,2528059205,100.00,,
>>
>> Use the alias,
>>   $ perf stat -e uncore_type_0_2/event=1/ -x,
>>     3659675336,,uncore_type_0_2/event=1/,2287306455,100.00,,
> 
> Having a self-test case would be nice. And it's questionable why this goes in x86 code.
>

OK, I will add test cases for uncore PMU alias.

For why it's now only x86 specific code, my understanding is, currently x86 has this usage case, we 
can further extend it to other ARCHs and make it a generic way in future.

Thanks
Jin Yao

> Thanks,
> John
