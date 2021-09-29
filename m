Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D7DC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B8061390
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 15:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344991AbhI2PPI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Sep 2021 11:15:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:15333 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344939AbhI2PPI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Sep 2021 11:15:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="224617572"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="224617572"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 08:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="520863532"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 29 Sep 2021 08:13:26 -0700
Received: from [10.209.78.119] (kliang2-MOBL.ccr.corp.intel.com [10.209.78.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 637FC58097E;
        Wed, 29 Sep 2021 08:13:25 -0700 (PDT)
Subject: Re: problem with 'perf script -F weight'
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <YVNq9av/3Lwmom4T@krava>
 <732928be-f438-120f-7c9f-685630147495@linux.intel.com>
 <YVQCy2yEK00XbWAq@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <70d0b651-4cd6-6f6c-247e-b01067155418@linux.intel.com>
Date:   Wed, 29 Sep 2021 11:13:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVQCy2yEK00XbWAq@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 9/29/2021 2:08 AM, Jiri Olsa wrote:
> On Tue, Sep 28, 2021 at 05:35:51PM -0400, Liang, Kan wrote:
>>
>>
>> On 9/28/2021 3:20 PM, Jiri Olsa wrote:
>>> Joe reported broken -F weight in perf script with (on x86):
>>>
>>>     # ./perf mem record
>>>     # ./perf script -F weight
>>>     Samples for 'dummy:HG' event do not have WEIGHT attribute set. Cannot print 'weight' field.
>>>
>>> the problem seems to be introduced with the WEIGHT_STRUCT change:
>>>     ea8d0ed6eae3 perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT
>>>
>>> which enables WEIGHT_STRUCT sample_type on x86 instead of WEIGHT,
>>> and leaves 'perf script -F weight' in the dark
>>
>> Right, I missed the support for the perf script. Because the default perf
>> script worked. It didn't ring the bell. :(
>>
>>>
>>> I'm not sure what the fix should look like.. should we allow user
>>> to use just 'WEIGHT' sample type? or is there a way to get original
>>> weight from 'WEIGHT_STRUCT' data, so we could fix just perf script?
>>
>> Just fix the perf script is enough.
>> Could you please try the below patch?
>>
>> (I probably need to split the patch into two patches, since it fixed two
>> issues, one is this error, the other is to print the instruction latency.
>> Anyway, let's try it first.)
>>
>>  From 99443f49a6236ef6e3bea3930792967a7863f753 Mon Sep 17 00:00:00 2001
>> From: Kan Liang <kan.liang@linux.intel.com>
>> Date: Tue, 28 Sep 2021 13:57:18 -0700
>> Subject: [PATCH] perf script: Fix PERF_SAMPLE_WEIGHT_STRUCT support
>>
>> -F weight in perf script is broken.
>>
>>    # ./perf mem record
>>    # ./perf script -F weight
>>    Samples for 'dummy:HG' event do not have WEIGHT attribute set. Cannot
>> print 'weight' field.
>>
>> The sample type, PERF_SAMPLE_WEIGHT_STRUCT, is an alternative of the
>> PERF_SAMPLE_WEIGHT sample type. They share the same space, weight. The
>> lower 32 bits are exactly the same for both sample type. The higher 32
>> bits may be different for different architecture. For a new kernel on
>> x86, the PERF_SAMPLE_WEIGHT_STRUCT is used. For an old kernel or other
>> ARCHs, the PERF_SAMPLE_WEIGHT is used.
>>
>> With -F weight, current perf script will check the input string "weight"
>> with the corresponding sample type. However, the commit ID ea8d0ed6eae3
>> ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT") didn't update the
>> sample type for perf script. The check fails with a new kernel on x86.
>>
>> Use PERF_SAMPLE_WEIGHT_TYPE, which supports both sample types, to
>> replace PERF_SAMPLE_WEIGHT.
>>
>> Also, print the instruction latency for PERF_SAMPLE_WEIGHT_STRUCT type.
>>
>> Reported-by: Joe Mario <jmario@redhat.com>
>> Fixes: ea8d0ed6eae3 ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT")
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/builtin-script.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index 6211d0b..fd73bbc 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -459,7 +459,7 @@ static int evsel__check_attr(struct evsel *evsel, struct
>> perf_session *session)
>>   		return -EINVAL;
>>
>>   	if (PRINT_FIELD(WEIGHT) &&
>> -	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT, "WEIGHT",
>> PERF_OUTPUT_WEIGHT))
>> +	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_TYPE, "WEIGHT",
>> PERF_OUTPUT_WEIGHT))
>>   		return -EINVAL;
>>
>>   	if (PRINT_FIELD(SYM) &&
>> @@ -2036,8 +2036,11 @@ static void process_event(struct perf_script *script,
>>   	if (PRINT_FIELD(DATA_SRC))
>>   		data_src__fprintf(sample->data_src, fp);
>>
>> -	if (PRINT_FIELD(WEIGHT))
>> +	if (PRINT_FIELD(WEIGHT)) {
>>   		fprintf(fp, "%16" PRIu64, sample->weight);
>> +		if (attr->sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
>> +			fprintf(fp, ",0x%" PRIx16, sample->ins_lat);
> 
> this will add extra number to weight.. should we add separate column
> for that -F 'insn-lat' ? users expect just single value for -F weight
> 

Sure, I will send out a patch set to LKML for review shortly.

Thanks,
Kan
