Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E74C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Nov 2021 08:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbhKXIEZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 03:04:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232944AbhKXIEZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Nov 2021 03:04:25 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO7HLnc026789;
        Wed, 24 Nov 2021 08:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pa9nXzRMlG8thI4bC+/EFpLYmgwn0p2lmoO1w9AlEaI=;
 b=ePozwjrAdngzPMwCDWBgvds+aBDdCiNjgkho8lNfG/XAznKrEvd77xXWJSddOEQ4k2Pp
 ISXfgje8YarvfkVZ+bnOScaRG0LV82WvQvz79yq/eBIyTA9Bd0BFYXy6dBsHELEYduyM
 yDp0h2fY3Dxv9FtTY1vKpAIVp7IiEdMYibEsoWQIUMN7WDDsFklB1WOE6OQf5sRDlOSq
 VHdJhhCP94FBZguzOc+jlecI6GsE0hV4hBcUGakEaLcv6hhvXNsAYx/p+poGxXc7K9ww
 1O+64LYWiM7q3Ve+DYlSpJIPTwqdN0zMkOf04QZ/M6NU2wu0zsmq7zmIznY7d/K2JYN4 TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chgvfrrtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 08:01:00 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AO7sRBK006948;
        Wed, 24 Nov 2021 08:01:00 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chgvfrrsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 08:00:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AO7lCvB009983;
        Wed, 24 Nov 2021 08:00:57 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3cernaxqpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 08:00:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AO80rL532440676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 08:00:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B42211CC50;
        Wed, 24 Nov 2021 08:00:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A49611CC38;
        Wed, 24 Nov 2021 08:00:48 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.71.39])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Nov 2021 08:00:48 +0000 (GMT)
Subject: Re: [PATCH 2/2] perf tools: Improve IBS error handling
To:     Kim Phillips <kim.phillips@amd.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>
References: <20211004214114.188477-1-kim.phillips@amd.com>
 <20211004214114.188477-2-kim.phillips@amd.com> <YV8uQVnMnnMd1Led@krava>
 <8a8583dc-5a5d-f107-8ef0-6be96e2f9095@amd.com>
 <fdcfec83-01c6-5e25-5b99-dac05287fdae@linux.ibm.com>
 <74e17a71-98ff-e0b1-61d4-d37992b1ae15@amd.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <f095bebf-77d5-94c7-5787-13a6f38867cc@linux.ibm.com>
Date:   Wed, 24 Nov 2021 13:30:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <74e17a71-98ff-e0b1-61d4-d37992b1ae15@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AAPNts8oBqWVWo2QzUej6oYjQN5-Ky9I
X-Proofpoint-ORIG-GUID: AZ4xGN0K4_p-lptSxfBOBUsjBvt7dfAE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_02,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240042
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 11/23/21 8:55 PM, Kim Phillips wrote:
> On 11/23/21 2:40 AM, kajoljain wrote:
>> On 10/8/21 12:47 AM, Kim Phillips wrote:
>>> On 10/7/21 12:28 PM, Jiri Olsa wrote:
>>>> On Mon, Oct 04, 2021 at 04:41:14PM -0500, Kim Phillips wrote:
>>>>> ---
>>>>>    tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>>>>>    1 file changed, 24 insertions(+)
>>>>>
>>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>>>> index b915840690d4..f8a9cbd99314 100644
>>>>> --- a/tools/perf/util/evsel.c
>>>>> +++ b/tools/perf/util/evsel.c
>>>>> @@ -2743,9 +2743,22 @@ static bool find_process(const char *name)
>>>>>        return ret ? false : true;
>>>>>    }
>>>>>    +static bool is_amd(const char *arch, const char *cpuid)
>>>>> +{
>>>>> +    return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid,
>>>>> "AuthenticAMD");
>>>>> +}
>>>>> +
>>>>> +static bool is_amd_ibs(struct evsel *evsel)
>>>>> +{
>>>>> +    return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name,
>>>>> "ibs", 3);
>>>>> +}
>>>>> +
>>>>>    int evsel__open_strerror(struct evsel *evsel, struct target
>>>>> *target,
>>>>>                 int err, char *msg, size_t size)
>>>>>    {
>>>>> +    struct perf_env *env = evsel__env(evsel);
>>>>> +    const char *arch = perf_env__arch(env);
>>>>> +    const char *cpuid = perf_env__cpuid(env);
>>>>>        char sbuf[STRERR_BUFSIZE];
>>>>>        int printed = 0, enforced = 0;
>>>>>    @@ -2841,6 +2854,17 @@ int evsel__open_strerror(struct evsel
>>>>> *evsel, struct target *target,
>>>>>                return scnprintf(msg, size, "wrong clockid (%d).",
>>>>> clockid);
>>>>>            if (perf_missing_features.aux_output)
>>>>>                return scnprintf(msg, size, "The 'aux_output' feature
>>>>> is not supported, update the kernel.");
>>>>> +        if (is_amd(arch, cpuid)) {
>>>>> +            if (is_amd_ibs(evsel)) {
>>>>
>>>> would single 'is_amd_ibs' call be better? checking on both amd and ibs
>>>
>>> Good suggestion. If you look at the later patch in the
>>> BRS series, I have rewritten it to add the new
>>> AMD PMU like so:
>>>
>>>   if (is_amd()) {
>>>       if (is_amd_ibs()) {
>>>           if (evsel->this)
>>>               return
>>>           if (evsel->that)
>>>               return
>>>       }
>>> +    if (is_amd_brs()) {
>>> +        if (evsel->this)
>>> +            return
>>> +        if (evsel->that)
>>> +            return
>>> +    }
>>>   }
>>
>> Hi Kim,
>>       From my point of view, it won't be a good idea of adding so many
>> checks in common function definition itself.
>> Can you just create a check to see if its amd machine and then add a
>> function call which will handle all four conditions together?
>>
>> which is basically for:
>>
>> +        if (is_amd(arch, cpuid)) {
>> +            if (is_amd_ibs(evsel)) {
>> +                if (evsel->core.attr.exclude_kernel)
>> +                    return scnprintf(msg, size,
>> +    "AMD IBS can't exclude kernel events.  Try running at a higher
>> privilege level.");
>> +                if (!evsel->core.system_wide)
>> +                    return scnprintf(msg, size,
>> +    "AMD IBS may only be available in system-wide/per-cpu mode.  Try
>> using
>> -a, or -C and workload affinity");
>> +            }
>>
>> and this:
>>
>> +            if (is_amd_brs(evsel)) {
>> +                if (evsel->core.attr.freq)
>> +                    return scnprintf(msg, size,
>> +    "AMD Branch Sampling does not support frequency mode sampling, must
>> pass a fixed sampling period via -c option or
>> cpu/branch-brs,period=xxxx/.");
>> +                /* another reason is that the period is too small */
>> +                return scnprintf(msg, size,
>> +    "AMD Branch Sampling does not support sampling period smaller than
>> what is reported in /sys/devices/cpu/caps/branches.");
>> +            }
> 
> IIRC, I tried something like that but carrying the
> 
> 
> struct target *target, int err, char *msg, size_t size
> 
> parameters made things worse.
> 
>> So, incase we are in amd machine,  common function evsel__open_strerror
>> will call function may be something like amd_evesel_open_strerror_check
>> which will look for both ibs and brs conditions and return corresponding
>> error statement.
> 
> The vast majority of decisions made by evsel__open_strerror are
> going to be common across most arch/uarches.  AMD has only these
> two pesky exceptions to the rule and therefore IMO it's ok
> to have them inline with the common function, since the decisions
> are so deeply intertwined.  A new amd_evsel_open_strerror_check
> sounds like it'd duplicate too much of the common function code
> in order to handle the common error cases.

Hi Kim,
   Sorry for the confusion, what I meant by adding new function is just
to handle these corner error cases and not duplicating whole
evsel__open_strerror code.

Maybe something like below code, Its just prototype of code to show you
the flow, you can refine it and check for any build or indentation
issues using checkpatch.pl script.

So basically, in common function we can just have 2 calls, first to
check if we are in amd system and second to return corresponding error
message, rather then adding whole chunk of if's which are specific to amd.

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ac0127be0459..adefb162ae08 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2852,9 +2852,40 @@ static bool find_process(const char *name)
        return ret ? false : true;
 }

+static bool is_amd(const char *arch, const char *cpuid)
+{
+       return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid,
"AuthenticAMD");
+}
+
+static int error_amd_ibs_brs(struct evsel *evsel, char *msg, size_t size)
+{
+       if (evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name,
"ibs", 3)) {
+               if (evsel->core.attr.exclude_kernel)
+                       return scnprintf(msg, size,
+       "AMD IBS can't exclude kernel events.  Try running at a higher
privilege level.");
+               if (!evsel->core.system_wide)
+                       return scnprintf(msg, size,
+       "AMD IBS may only be available in system-wide/per-cpu mode.  Try
using -a, or -C and workload affinity");
+       }
+
+       if (((evsel->core.attr.config & 0xff) == 0xc4) &&
(evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK)) {
+               if (evsel->core.attr.freq) {
+                       return scnprintf(msg, size,
+       "AMD Branch Sampling does not support frequency mode sampling,
must pass a fixed sampling
+          period via -c option or cpu/branch-brs,period=xxxx/.");
+                /* another reason is that the period is too small */
+               return scnprintf(msg, size,
+       "AMD Branch Sampling does not support sampling period smaller
than what is reported in /sys/devices/cpu/caps/branches.");
+               }
+       }
+}
+
 int evsel__open_strerror(struct evsel *evsel, struct target *target,
                         int err, char *msg, size_t size)
 {
+       struct perf_env *env = evsel__env(evsel);
+       const char *arch = perf_env__arch(env);
+       const char *cpuid = perf_env__cpuid(env);
        char sbuf[STRERR_BUFSIZE];
        int printed = 0, enforced = 0;

@@ -2950,6 +2981,8 @@ int evsel__open_strerror(struct evsel *evsel,
struct target *target,
                        return scnprintf(msg, size, "wrong clockid
(%d).", clockid);
                if (perf_missing_features.aux_output)
                        return scnprintf(msg, size, "The 'aux_output'
feature is not supported, update the kernel.");
+               if (is_amd(arch, cpuid))
+                       return error_amd_ibs_brs(evsel, msg, size);
                break;
        case ENODATA:
                return scnprintf(msg, size, "Cannot collect data source
with the load latency event alone. "

Thanks,
Kajol Jain

> 
> Kim
