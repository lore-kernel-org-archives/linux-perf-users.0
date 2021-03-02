Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED275C433DB
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9997964EC0
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhCCFEm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 00:04:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:12211 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578609AbhCBPZk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 Mar 2021 10:25:40 -0500
IronPort-SDR: bW4FfnQgh3ihktPy/M+arrdN3WnxS4kWyhDpYxFXAcuM4tTcxcOgHDaNQvb8Oe3/bK2d6jewvb
 wRe9J3AUJCrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="271855152"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="271855152"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:23:53 -0800
IronPort-SDR: HU0vsqQzXgRuwC/sr7+jTF8HC9Xo43qDRsVxiqxRtRt3PElTVxrAHN1GuXX8PkUn6XG+RnT8zW
 FlRJQEoZu9fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="595827848"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2021 07:23:53 -0800
Received: from [10.252.140.135] (kliang2-MOBL.ccr.corp.intel.com [10.252.140.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6E0C15808BA;
        Tue,  2 Mar 2021 07:23:52 -0800 (PST)
Subject: Re: [PATCH] perf test: Test case 27 fails on s390 and non-x86
 platforms
To:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20210302133119.3325530-1-tmricht@linux.ibm.com>
 <abcf63c1-8a15-14af-b449-77a943c94121@linux.intel.com>
 <7a14f6b6-967f-93bf-a030-44e358374502@linux.ibm.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <785fc599-24c5-6eda-2807-2b79a9d89315@linux.intel.com>
Date:   Tue, 2 Mar 2021 10:23:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7a14f6b6-967f-93bf-a030-44e358374502@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 3/2/2021 9:48 AM, Thomas Richter wrote:
> On 3/2/21 3:03 PM, Liang, Kan wrote:
>>
>> + Athira Rajeev
>>
>> On 3/2/2021 8:31 AM, Thomas Richter wrote:
>>> Executing perf test 27 fails on s390:
>>>    [root@t35lp46 perf]# ./perf test -Fv 27
>>>    27: Sample parsing
>>>    --- start ---
>>>    ---- end ----
>>>    Sample parsing: FAILED!
>>>    [root@t35lp46 perf]#
>>>
>>> The root cause is
>>> commit c7444297fd3769 ("perf test: Support PERF_SAMPLE_WEIGHT_STRUCT")
>>> This commit introduced a test case for PERF_SAMPLE_WEIGHT_STRUCT
>>> but does not adjust non-x86 weak linkage functions.
>>>
>>> The error is in test__sample_parsing() --> do_test()
>>> Function do_test() defines two structures of type struct perf_sample named
>>> sample and sample_out. The first sets member sample.ins_lat = 117
>>>
>>> Structure sample_out is constructed dynamically using functions
>>> perf_event__synthesize_sample() and evsel__parse_sample().
>>> Both functions have an x86 specific function version which sets member
>>> ins_lat. The weak common functions do not set member ins_lat.
>>>
>>
>> I don't think Power supports the instruction latency. As a request from Athira Rajeev, I moved the PERF_SAMPLE_WEIGHT_STRUCT to the X86 specific codes.
>> https://lore.kernel.org/lkml/D97FEF4F-DD88-4760-885E-9A6161A9B48B@linux.vnet.ibm.com/
>> https://lore.kernel.org/lkml/1612540912-6562-1-git-send-email-kan.liang@linux.intel.com/
>>
>> I don't think we want to add the ins_lat back in the weak common functions.
>>
>> Could you please update the perf test and don't apply the PERF_SAMPLE_WEIGHT_STRUCT for the non-X86 platform?
> 
> I used offical linux git tree
>   [root@t35lp46 perf]# git tag | fgrep 5.12
> v5.12-rc1
> [root@t35lp46 perf]#
> 
> So this change is in the pipe. I do not plan to revert individual patches.

No, we shouldn't revert the patch.
I mean can you fix the issue in perf test?
Don't test ins_lat or PERF_SAMPLE_WEIGHT_STRUCT for a non-X86 platform.

>>
>>
>>> Later in function samples_same() both data in variable sample and sample_out
>>> are compared. The comparison fails because sample.ins_lat is 117
>>> and samples_out.ins_lat is 0, the weak functions never set member ins_lat.
>>>
>>> Output after:
>>>    [root@t35lp46 perf]# ./perf test -Fv 27
>>>    27: Sample parsing
>>>    --- start ---
>>>    ---- end ----
>>>    Sample parsing: Ok
>>> [root@t35lp46 perf]#
>>>
>>> Fixes:
>>> commit c7444297fd3769 ("perf test: Support PERF_SAMPLE_WEIGHT_STRUCT")
>>
>> I think the regression should start from
>> commit fbefe9c2f87f ("perf tools: Support arch specific PERF_SAMPLE_WEIGHT_STRUCT processing")
>>
>>
>> Thanks,
>> Kan
> 
> Kan,
> 
> I do not follow you. Your commit c7444297fd3769d10c7ffb52c81d71503b3e268f
> adds this line
> 
> @@ -242,6 +245,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>                  .cgroup         = 114,
>                  .data_page_size = 115,
>                  .code_page_size = 116,
> +               .ins_lat        = 117,
> 
> And this assignment 117 breaks the test. As mentioned before, member ins_lat is never touched
> by the weak functions.
> 

Here is the timeline for the patches.

1. The commit c7444297fd3769 and other SPR patches are merged at 
2021-02-08. At that time, I don't think we have this issue. perf test 
should work well.
2. Athira Rajeev told me that Power doesn't support instruction latency. 
So I submitted a patch which create weak functions and move the ins_lat 
into X86 specific.
3. The patch (commit fbefe9c2f87f) was finally merged at 2021-02-18. We 
should observe the perf test at this time.

As my understanding, "Fixes" should log the commit where an issue starts 
to be observed. If someone tries to backport the fix later, they have an 
idea where to put it.

Thanks,
Kan

