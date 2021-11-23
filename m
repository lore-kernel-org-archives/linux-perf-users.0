Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454ECC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 15:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhKWP3P (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 10:29:15 -0500
Received: from mail-mw2nam10on2087.outbound.protection.outlook.com ([40.107.94.87]:14708
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231838AbhKWP3O (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 10:29:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkKanN4//r9uksOUmgZn5/PzzeHjT+9sPJ1/5yflG/vCzRhZUu5XhksD+29VJwHK4LE8ZEylO1jfFvWZyNVpyJpddrvMJsxo02iSeYna9Ylj2oqHMh4coAUD4i9ndVGZSYa5jTnRgDql6R47F1qvncZroO53AVquDwpguY5AIPTt+bLOE7C4aprZfaD0QfS5FMWIg2RBP53w0aOnyQPUrpb7VtCrZYCgVXqalVxSVxON4lZC1JOyoOWzMjuY/Et9Vg8ltlQoHi1OLaIW7R4PZHrfhd/aApTQEYi5+jXZ2VcGmk8RAaKe+646rkjOfHnrqXYoEvS25TWvu1cFGHP8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AGr3Nbi9ATdpK2RZAiU7YyaQ5pCVJWid/uYHVDIlio=;
 b=ecu6bgtIA1aGdp3hgwasfAM/uwrfM0E3xO89XAS/2M8dZztv1vwk7+dWgVj0N8Reac1ObaKUdt/aZ+CGLGI+btLmzeNu+/OMSkNhuepXU+VIiHLwCiI7l3OJbAbggU9+DKO7uYimVMlQPS46mb3Ipfb0hee1kS8fHMDynE2Sa2co8nAcYPBkHf893y6fVtOOzlysu5gre9PHRyW7J+EyK82e1m3xb4vnWI1NKnYqHq+buh8BBiNthwTudRCv52T6zrG2lRQ0coJ8FU3LVaLPAGeC+TDYsYMqi0uupxG7ujN56HGGDYIYoh48gIlnvcICPeBq5wVsy+gpkqaXDGH8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AGr3Nbi9ATdpK2RZAiU7YyaQ5pCVJWid/uYHVDIlio=;
 b=kPITYSy9UBZlcU6TTWxUKEIixS3FXU3lm5FBJhq2hryB5NK/fz26QAYeacclbUFNd6ArAL7ZBAr89ltprT48CLThcQu3jqRGtswIaj8T8SA2GUYuteZowopcUzGXAL77Hc2vGaqPxYdtnZPScX1g15mPhgG/FNifx/6pWHil1n0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3188.namprd12.prod.outlook.com (2603:10b6:408:6b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 15:26:03 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4713.024; Tue, 23 Nov 2021
 15:26:03 +0000
Subject: Re: [PATCH 2/2] perf tools: Improve IBS error handling
To:     kajoljain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
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
From:   Kim Phillips <kim.phillips@amd.com>
Organization: AMD
Message-ID: <74e17a71-98ff-e0b1-61d4-d37992b1ae15@amd.com>
Date:   Tue, 23 Nov 2021 09:25:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <fdcfec83-01c6-5e25-5b99-dac05287fdae@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0010.namprd14.prod.outlook.com
 (2603:10b6:208:23e::15) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [IPv6:2603:8080:1540:87c:d0a9:4fed:e4da:5122] (2603:8080:1540:87c:d0a9:4fed:e4da:5122) by MN2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:208:23e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Tue, 23 Nov 2021 15:26:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a768fbee-d415-445c-60d0-08d9ae958f51
X-MS-TrafficTypeDiagnostic: BN8PR12MB3188:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3188A9EDCE4F6AED9DC717F687609@BN8PR12MB3188.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knu9VK0qNUwDHxgwVH3k+vZX64pWyUzuAF1U+1LIF/w653AySsVhztoFo2a7/C00RgT/SgrrJWs6PWSM1xxK/ubdUcIvhV4dBAvYyj9M5iX4E6CvL2UtjqlEB5rdOGGByoKo45Eue8wc/5iK8kslLdecpXbPppST1OjpCpV67dL9JWQ8BeL0t+WBGCLStkXKI9+NuO0ap3Z3e2uoLTXzWo9idMF7MBOsB39ABSmtzbLglK3antO5aJ09PjW4xvmdE44jMgkluom943u/wNtFygiPuOmpVkFUBcHNf41u8RXqoDn/9tzu5fMVv0rGrG/c5u+FxriDU/LyDtGFaJxw67YjnG35idU9m+rCwwGLI4DaAmYopVJTblKpfmnpUrNS5Jxxoh7YHNDFDJEo75giqKQ6aYJqcFWkUEcIbp31LdiUTevLdg5+ACRwugWCLHzkFFyr4f0fu9/jhzCNx2faeJBi3YZRIpeShhEK3VPI2dH/JkjOvDxckETu1d279aktLkKNvNzzM2yjb2o+QKUi9e6Uk3rgiXYQ9XiIJaoMRr9uxP5lgedhxikapR9zSpcfL7/mEtwuVuzi+qbMtjuqxDIpRX5blROaZ3lY3i5GRcijFsCUI1Vt2XZbmb62N0I+M68NtbCOatlwNRZc95ZchLT/v6Yo1Nb0UJklBdUD2HqIQ/Plf/l8XtDqRJWc9spg10qD+oFhdX6JRYx3VG6nTg2JzdPDYsrIPabYJdefydmNCIcoZqwTrPXpvX5NvGkv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36916002)(4326008)(86362001)(83380400001)(44832011)(38100700002)(6486002)(2906002)(53546011)(7416002)(31686004)(2616005)(8676002)(186003)(8936002)(31696002)(110136005)(316002)(54906003)(36756003)(66946007)(5660300002)(66556008)(508600001)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akhhRWlEcys2YkJJRk9NWDBCQmRaTENHS0dselM2d05Da3BvRE54bnNmTnp5?=
 =?utf-8?B?Q1NDQ1dJcnRMREVFT1hUQzdhaFR1MS9RVzdNbEpjZUQ3Unh2MkpoSk1hREly?=
 =?utf-8?B?TkE3Sjlwcmc5LzAzY1BGa1M4RzlFa1pLbGZQY2ZhVnM5UTVYVitpMFF5dkxj?=
 =?utf-8?B?TWxDV3FwN0F5MHlVMTRtZS9hcnY1VXk4cnBhaVVGUDF6eWZnWEVBeDl3MjMr?=
 =?utf-8?B?L3pSQm1MRS8raXlpSHNVZk1DOVRhOW1QT3lPVmJiNWFJQTFVZVJ6TmxWWFJt?=
 =?utf-8?B?R0VHYU9zb1dMcjFXeW4vQ1RveXVSRWtkalZ3djQzdytBL2dQaE9rTFBCbHVF?=
 =?utf-8?B?akV0TXJoZTV5RnVJdEVFT0ljRWRzSjZ0UWk5L3czUzR6VzRjcGNHdkp6Q0pQ?=
 =?utf-8?B?ZTZXRmhLdkZpQnByMmpnb0FvZ0RYMTFuaXBRaHUzMzVnanllUjhEMTgwUVo2?=
 =?utf-8?B?U1pzMXdrZnpid2ZSZjRUTmEvQzJQL21EaFlZYVRZQWZWZ2JuMVRFTm81REMw?=
 =?utf-8?B?VUE3eE9NMlcyd0U4bTNiejRnWmlhRlArTTgzb3pPSHZNYldqbDBoZmUvZmZZ?=
 =?utf-8?B?OVdkblNFbVV3Njg5b1FrMEwrblNycHZIb1RKWGR4YWNmdWNVbjc0Y3dsM0tV?=
 =?utf-8?B?S2xJenJvbkdtQnJ0b0Fab0szb1U2V1RJMU9PRkMwZEtVdWx3Mk9ZS29JNzRw?=
 =?utf-8?B?TTNJMGZuZVZBL3ozU0JhM2NySHc4VmZDYUVrTTQzLzFSWEMxcjJEZEdyN1Y2?=
 =?utf-8?B?SzlRd1FOTkh0aXl6TjZQeHpJTk9wdDVacCtrQVVzaFFubkQzMVpYMnVxTHZk?=
 =?utf-8?B?dXpKV29NbXA3R2pqc1J4a3Y5TXJzbnR0ZXJ5RnA5ZzZzUEVSaUNSSzF1R2Ru?=
 =?utf-8?B?MmRWRXNNNGY4WmxUcE0xaitiT0dMaDJvbk9mZURudXM2aENUYmZyR3g1NXdk?=
 =?utf-8?B?QVRHRWF0MUtYa1FvbU1ZMUM4Wi9EU3R0bHU0V3Q2eTFua1BCd0F5dFVBaGpu?=
 =?utf-8?B?dElEQmFZdkw4eU1rcENSdUUrTy9jR29GMnpJWWJMK3ZVTmxRb0JMVmZOeUd6?=
 =?utf-8?B?Y3pZeExURlhMeDZROFRiR212THpIV0J0UGRrMGNDckF2cWlEZzVOelJNSWU3?=
 =?utf-8?B?RCtlakdpYWVRT2x1QkZweS9mYTdoRWREekN0aWNBbEd6QlUrUGIyVjBEcDAy?=
 =?utf-8?B?REh4SmFVa1VybXNsV0FHc1BuTHF3cUZKS29sdzliVWIraklNc1dINGVzdHBk?=
 =?utf-8?B?TUhvUk1mWlZGWFdKd1BwM1EvTjBDOGgvclNrVmVwcEtBaXBNbEkwYU5VT2xp?=
 =?utf-8?B?K2wyZjBHWUtJVXVDU290VHNnc0Q5V0lETk0rSmtvOXJhdTJEeGV3cG9LdGY5?=
 =?utf-8?B?alhlVFU3U01tQXhrWHpmdjluYlZ1L0E1Q2Zwc2xxaGU4SmhDZzRSalVGRy8z?=
 =?utf-8?B?VTZLUXQ3SVJqZTZIbmZiSDBBL095YkZhR0RBVUlYbHZXNm9yc1F5ajNKbXJu?=
 =?utf-8?B?aW5IbngyUXZJWm1Odmh5ajl6OHUvVnBTRkI2VlY0SW5QdmZEUHlXK1lrb3JO?=
 =?utf-8?B?NlE3NXFMem1GY2NsdXJteFBGT0tuUjVNejJ6RHUxa3ZQbTNXbjR0MW9EeTZG?=
 =?utf-8?B?T24xQUxvbEtpUUhQR1B4dHpKYkhqOEhDVU83ZVA1MWpLcVgxT0dTUElETGdp?=
 =?utf-8?B?Uzk2aXg0dHRGeGJaRjBIaER3eGkrU2cxRjJGamF0cVR5cjkwdHFXeHFmVjRj?=
 =?utf-8?B?dXNrc01KMUdjTWg3SGJlMFdoUmxDbEZweXAvbDVqR2xQemM4YjFMUGNxZmo5?=
 =?utf-8?B?MmlGTnpMS2lZWnExRzE3WmF1SzBweXhXRnhLazhEbUxzUXBpOEd2WThPRmts?=
 =?utf-8?B?MGFqQjVGQXFaaFFGS2xDNU4wQTY3QndZZjJocDd0bUlWVDNNR0VnM1Myek04?=
 =?utf-8?B?NXZNekhpVUxpZWRIOXlrYy9oWkFNa3FOYzcvQWpFMllhWUxjS1VUeEMrTk9l?=
 =?utf-8?B?OVR6elF5VlpjNzYrbjVRMmVWTG9zVWJKSkc0WkNjTHZCTkxkMWw1WnppenB6?=
 =?utf-8?B?SGo5OEhNcG9PVUgrN2VqbkU5ZVRkekVQc3FwbTRJU3N4b3REQXdPSDJHc2Q4?=
 =?utf-8?B?VmdwQ2ZJV2l0QXNtRlRocXZ2Y1hGNmcwbXdFdkwxRWlYbElGVFVxOTk1SFBP?=
 =?utf-8?B?NkdTR1BGRGZ6RzZDS1YvbVNvcHFnMzl4dFRmeURlYXk3enFvb2tQUmJLR3Qz?=
 =?utf-8?Q?LiekRLHcAsGjTZtSaZ+qS8Hu3yYc1HZmiWivPcDOrY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a768fbee-d415-445c-60d0-08d9ae958f51
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 15:26:03.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaGWkrnzA4duatc904Brw27MwOkp7FYy/fiyssAmNA4QAYv0kJp1tcefxgAj0TrQTKnR9MZbLQyQLIchutSJyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3188
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/23/21 2:40 AM, kajoljain wrote:
> On 10/8/21 12:47 AM, Kim Phillips wrote:
>> On 10/7/21 12:28 PM, Jiri Olsa wrote:
>>> On Mon, Oct 04, 2021 at 04:41:14PM -0500, Kim Phillips wrote:
>>>> ---
>>>>    tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>>>>    1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>>> index b915840690d4..f8a9cbd99314 100644
>>>> --- a/tools/perf/util/evsel.c
>>>> +++ b/tools/perf/util/evsel.c
>>>> @@ -2743,9 +2743,22 @@ static bool find_process(const char *name)
>>>>        return ret ? false : true;
>>>>    }
>>>>    +static bool is_amd(const char *arch, const char *cpuid)
>>>> +{
>>>> +    return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid,
>>>> "AuthenticAMD");
>>>> +}
>>>> +
>>>> +static bool is_amd_ibs(struct evsel *evsel)
>>>> +{
>>>> +    return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name,
>>>> "ibs", 3);
>>>> +}
>>>> +
>>>>    int evsel__open_strerror(struct evsel *evsel, struct target *target,
>>>>                 int err, char *msg, size_t size)
>>>>    {
>>>> +    struct perf_env *env = evsel__env(evsel);
>>>> +    const char *arch = perf_env__arch(env);
>>>> +    const char *cpuid = perf_env__cpuid(env);
>>>>        char sbuf[STRERR_BUFSIZE];
>>>>        int printed = 0, enforced = 0;
>>>>    @@ -2841,6 +2854,17 @@ int evsel__open_strerror(struct evsel
>>>> *evsel, struct target *target,
>>>>                return scnprintf(msg, size, "wrong clockid (%d).",
>>>> clockid);
>>>>            if (perf_missing_features.aux_output)
>>>>                return scnprintf(msg, size, "The 'aux_output' feature
>>>> is not supported, update the kernel.");
>>>> +        if (is_amd(arch, cpuid)) {
>>>> +            if (is_amd_ibs(evsel)) {
>>>
>>> would single 'is_amd_ibs' call be better? checking on both amd and ibs
>>
>> Good suggestion. If you look at the later patch in the
>> BRS series, I have rewritten it to add the new
>> AMD PMU like so:
>>
>>   if (is_amd()) {
>>       if (is_amd_ibs()) {
>>           if (evsel->this)
>>               return
>>           if (evsel->that)
>>               return
>>       }
>> +    if (is_amd_brs()) {
>> +        if (evsel->this)
>> +            return
>> +        if (evsel->that)
>> +            return
>> +    }
>>   }
> 
> Hi Kim,
>       From my point of view, it won't be a good idea of adding so many
> checks in common function definition itself.
> Can you just create a check to see if its amd machine and then add a
> function call which will handle all four conditions together?
> 
> which is basically for:
> 
> +		if (is_amd(arch, cpuid)) {
> +			if (is_amd_ibs(evsel)) {
> +				if (evsel->core.attr.exclude_kernel)
> +					return scnprintf(msg, size,
> +	"AMD IBS can't exclude kernel events.  Try running at a higher
> privilege level.");
> +				if (!evsel->core.system_wide)
> +					return scnprintf(msg, size,
> +	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using
> -a, or -C and workload affinity");
> +			}
> 
> and this:
> 
> +            if (is_amd_brs(evsel)) {
> +                if (evsel->core.attr.freq)
> +                    return scnprintf(msg, size,
> +    "AMD Branch Sampling does not support frequency mode sampling, must
> pass a fixed sampling period via -c option or
> cpu/branch-brs,period=xxxx/.");
> +                /* another reason is that the period is too small */
> +                return scnprintf(msg, size,
> +    "AMD Branch Sampling does not support sampling period smaller than
> what is reported in /sys/devices/cpu/caps/branches.");
> +            }

IIRC, I tried something like that but carrying the


struct target *target, int err, char *msg, size_t size

parameters made things worse.

> So, incase we are in amd machine,  common function evsel__open_strerror
> will call function may be something like amd_evesel_open_strerror_check
> which will look for both ibs and brs conditions and return corresponding
> error statement.

The vast majority of decisions made by evsel__open_strerror are
going to be common across most arch/uarches.  AMD has only these
two pesky exceptions to the rule and therefore IMO it's ok
to have them inline with the common function, since the decisions
are so deeply intertwined.  A new amd_evsel_open_strerror_check
sounds like it'd duplicate too much of the common function code
in order to handle the common error cases.

Kim
