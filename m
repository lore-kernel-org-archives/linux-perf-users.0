Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA05C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 22:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B968761181
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 22:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhKRWsq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:48:46 -0500
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:21856
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232460AbhKRWsq (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Nov 2021 17:48:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtnlCZpLdHeq909q619M/XdKot4Is98CY/esqzn7ioM2L/sU7jIZ0VkpBJMXlL/TT92K8bVr/fw5V04jyPp9iree1z/mNo1oZd55wQbn+ITIRLG6h3uJD1ffi9w9wS5IOniTMvDMOMEpZSteHAohM+aj6BCMQw6J8h3SoN0wP+JoZQpY58fWHBYXdYS2ksMHkHG9ZE6ux9ubAuQGzjKqVsByrVXCjoSPhLQ+ourXGepmh9Mzb5s3JVAsbubV94aT+70NO/IXL0NUmvgCS4iWYXKOJEjbjf3Lbvsx02b8McG1zzX2UrV4j73+EGR+0F60FSkRm36z7nZOX4SC/979aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPtRnakaDZY+S2PvrbGBxwghN3JsRPSfDGzIQwcLK3s=;
 b=d/cvKCFPkdXWENPbBoXVv1kVXjqdPbqufRbPplSF5HsCtvEb2QmGjZUb3MQBPu7Yspgdqm51GJ/jhtJcjJpggz5Kv68UZ78v7r+kR4Hm+t4Aop4ZPwxhpAQhE3Zzu+D4/xTTzr+Uu70eLbBjo/Ic49NtEvaxRyNV3f+OAf1I0yjjyLFGajXHgSFcN5nRy1pAGoXYung8O614wjsO6ycIIpyl21iV3Ak3bGjRxSJzonnu6qWgkh58C8tSlOAM2mvWf/Vj0k2vFvB2NNfVU/iGkdLIiE2yMyPTEoaCmNpjmpCapPF+F9eric3wnB8fnCCg51LzP7vf5wxlEKcuFpZ69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPtRnakaDZY+S2PvrbGBxwghN3JsRPSfDGzIQwcLK3s=;
 b=jDb6qiBgaGn6IKolRE7kwRjVOceiZHVXIgqfx04YrKF5nBG/TK0R7pI9/eWwMS6CEq9gloSDbLppoqhbyXYsGbsG6lJd/QvSP/vArugBT9crUNEv1ajk53AKUdOEryi7C4cATjUvJqf1/6Y8LszcY2KL9iMbMssJSTbHOF5o3/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3137.namprd12.prod.outlook.com (2603:10b6:408:48::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 22:45:37 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 22:45:37 +0000
Subject: Re: [PATCH 2/2] perf tools: Improve IBS error handling
To:     Jiri Olsa <jolsa@redhat.com>
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
From:   Kim Phillips <kim.phillips@amd.com>
Organization: AMD
Message-ID: <073f5ae0-0d1d-bbeb-acc6-a10ba2376908@amd.com>
Date:   Thu, 18 Nov 2021 16:45:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <8a8583dc-5a5d-f107-8ef0-6be96e2f9095@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0063.namprd15.prod.outlook.com
 (2603:10b6:208:237::32) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [IPv6:2603:8080:1540:87c:fedf:2f0f:c0e6:d56d] (2603:8080:1540:87c:fedf:2f0f:c0e6:d56d) by MN2PR15CA0063.namprd15.prod.outlook.com (2603:10b6:208:237::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Thu, 18 Nov 2021 22:45:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1d8c0de-13f1-45ad-486a-08d9aae5233a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3137:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3137AB435D9385210A12342C879B9@BN8PR12MB3137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5i0yWVRct47HzAsJdc76LC6sHI+pIXCvV86dqHJ0yGbX3GXfF+If/24j7vloocGuPZUnz0zROciBiO22fCtZAC+qDODwircr3R9Lh+gfpkCbggLBcdOb4NSaMJ1SPU6MrBH5BqE1mxsK0/HOcfE6dpzvFvpgdrhWJwCmtayHrQDklfiP1acczgQ8/X5lz8Xrygbopp880Qka9rUw3vYK1RTuuCV4CHPw44uk+9h0uL7y5Zxsn8cFH9MXAB1Se2J0TsU3qyvdUK5Use3X+enBl9TDpsPS4zemq2wr638Utxc3xrjXNjAQzUwEAYKh0VOO1csKWwLW9pmIDCG3pI41hSxGMWhiC0r8wU3ddSW284qYo0mSQZpZ1DJBqxpFKFPjzp8oqJNlubr3r5viYfqPbXVs6p2k2nGV98AfybhavFxnIlvfcRXSqhfGEijTN2qblmX9wJmWtPJLD73lvbwA6YwKenCqoKSgrXvzzB/P8cLRrDdi/nDLBKuA4XJLY7curjiKMS/jzwhgcHYNQTneQpZZYZKCPL3QY2jDkb7wVmS1Mllum9Y5SnTP0suaPf2YlOU4tQnd4q6IDV+pdWMaI1FUf9cN4XX6/FDAe6XFvxpZuDbiBJzjFAd88D9sSG/yOBOAwY5wFO0Zuzer32XP+dqKPqLDiIBV9IDkIa1T9eRbykAtcL0lnG8n0cuKR5qUgm1by0qLdVX46imdg1IT5YRJr/cndBW/zc37M21rny9yVxMzTOmGoDblg4THFvT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(6916009)(31686004)(2616005)(83380400001)(38100700002)(36756003)(186003)(86362001)(5660300002)(7416002)(508600001)(53546011)(66946007)(66556008)(6666004)(54906003)(8936002)(4326008)(66476007)(44832011)(8676002)(31696002)(316002)(2906002)(36916002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1IxTUdNUVZXL2ZPNW9wV1RTbXVZNFJnMSs1Yk1MakIwYnQ4eTZnOWkrbVEw?=
 =?utf-8?B?TWhDaEdBL3ppRlpXamM2eVBsQWEwem1OdzNDaGtNcGtpakdpREsxS25PdXov?=
 =?utf-8?B?TTJqRXVibGFwaFVYTU5jbWh4VEpzcDRGL0JESjdESEJlTEsrSXF6dTFBR1Fq?=
 =?utf-8?B?RndWWERxTGd4OGN2RWlkNWMzbFV2amNwcVRFTW1LeXhzRUtrYUg5Um1YcENk?=
 =?utf-8?B?T3R5NFlxSURWMks5NnZOYm1ianE1dXlScVJyRXM3M3ltbytjS0FWTXJmbjJQ?=
 =?utf-8?B?V2diaUorOVZnd3p4akJBemJhRkIyT1hvcVAxNzlzTUowRzNyYlUvZUpSaW0z?=
 =?utf-8?B?YzUzTGlMR2luSWdMZUlyRzVSd01HWHJHKzFYQjF2bGhrUno2MDE1ZldmRnVB?=
 =?utf-8?B?aXZQMjNrbGhzaXB3Rm8zM0JWb1N1bmtPS0xZV2ZpNFJ3SDFjTENjZC95QVNp?=
 =?utf-8?B?OWs0ZzZJeE5IcXpDa1hjOUppQlJRR0lxL2F6aU91bkFxcURMN0I1Q0NOSjN1?=
 =?utf-8?B?VzNnMkRzeGxHOE9uZVd0aENWNExGVHIxWGg4T09hMXlCZlZwRld1bm1vR0Q0?=
 =?utf-8?B?UzhuSjMvZllFQWZXSVZJU241aDBSMGY3Z1JyMU02b3JXUk9CYS9LZkI4NEpE?=
 =?utf-8?B?NThWOHMyNC9jWS93VTRWcXVMNmxiQlA3NE5jOHNLcTZmTVJRQ0h3OWNvK1U2?=
 =?utf-8?B?Z2JNRzJhd2p5NG1PcU5rN2hDVllhWFhCZ3R5Zm1sMVhTV1ZCbklmcG1HUDVO?=
 =?utf-8?B?b1l3VzlxWmE2NVNJUEVhMi82N05ZVTNmUmJ3Z2loRGp5bFpPaERZM2luQWs4?=
 =?utf-8?B?Z0dVcmxDTFZNSEN3UmRTdXJvRFJhdmxyaXhhUm1icWdEb0JuMFNTYnorWVli?=
 =?utf-8?B?aG5NVDBYKy9YVDlkVG9zK0dyWWk0Z1g2Ryt6QjJZTkh4NVBkMitibDlWakE0?=
 =?utf-8?B?d2hQR2FHbjdCcThmQnBYdmRMNkZaRUNUZHBpSC85TUxURHZGNXovN0FUSFp3?=
 =?utf-8?B?MXFwa3VFNHJZcGo1STZyTlZDY1o4VzN3N1R4V0p5eFA4Y1p1NGRHbjVWcnd5?=
 =?utf-8?B?cEVGZWJQamFsL0dZbWxwUkNnc3dNaStncnRQZ0pCbGVQeURGdm82eVFZQmhD?=
 =?utf-8?B?emh4MWR0Q21XaGZyQUoreU5GNHlaS3VnNEF3QUlVMy92QkRuZnlUczdWQzBZ?=
 =?utf-8?B?Y2lNcTFQdW9hYUZ1QzFHRmRxcmRXVWExd29nZitzM3p2NXBDYnlnaisrNFlr?=
 =?utf-8?B?RldjRzdNRmFIdlpFUU40Tyt5a2plVjJFZlNQNDA2NzFwUW9ZMmZXQ3gxc0lM?=
 =?utf-8?B?Y3hhWTRqL0JvTEN4WHo0aEY3OXNDdDFENEVCWUR1SjdtdDQrNlNoNTA5NHV5?=
 =?utf-8?B?MVNQWFp2TlhCUGJIRS9lSG9Sa3g5bGp3UVdqdkNqdGJJSFI5UGFTczBiVkx0?=
 =?utf-8?B?L2lYc1pJdlUrTUZ0Si9oQWRLN3Y3OVFxeGdvTGVqLy83MXR2UThmeHZRa01G?=
 =?utf-8?B?ZnorTEtabFIzV1FEemx0QjJQT21rdjB6aU5iMzBoODBZbGd4bmxHMVJNekhm?=
 =?utf-8?B?K2hsekp0Ni9vcFlJeEQ1dHF3VEI4cllZQmJBMDczeHRDZGplM1NwNVNzY0JV?=
 =?utf-8?B?RlhwSndFNzBXRHNSOWZUL3NBNWwrMysyZzFudHl6aHdCTy9JMExiTUszdTZQ?=
 =?utf-8?B?RW9VS1VmcVpTa1cxK0VOWkdvM2Z6M2NGcW1XRGF3dWlLNnU1Q2lYZDNUUmZn?=
 =?utf-8?B?MFl5b29BZGVxamR5U0ltcDlLRzdGNHdtcnJBSXV4UkhIS2NENG5FOVFaVm0v?=
 =?utf-8?B?a0JoYnl2cnVxYVBGejltOTVUazI0T1ZiWnZTMzQ5ZkpIeW9oZVFEVFFzMjdh?=
 =?utf-8?B?clAybC95aCtiKzRXandBZS9qYjRZOHIwZ2J4eWE2Nk42SGx5YUxaQS9SdlNY?=
 =?utf-8?B?SWJ5THdQZlVwZTJZaVh6ek1LdDkwVUthTzRsYnBmaFJlVHE5YXZtQkYzb3kx?=
 =?utf-8?B?OUxsdzl1ZTNtUTFXUDZucmEvaUR0RDJvc3FyZktZYkQrTnl5UGRyb0loNHpE?=
 =?utf-8?B?bnF2M2pJQUQwQ1hySFFySHlYU2t4QzRTOENRS2ZxMjBZaFRWTHpwdWVnTk9O?=
 =?utf-8?B?WCtMSGN6Qjk0akxtSmRrWklvTm9CNm5STlNja1VwK242SCtkNndkK1dLL1g2?=
 =?utf-8?B?R0FsZVFZWGI4NXhoeDY5OE4zaWhtUFVFbTNjVGxuNFZ6L1hSMDJYYVpwQlUw?=
 =?utf-8?Q?2aRoqXPxbb034eovxa8IIDwRRRejS3/KKXJsbVWzhQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d8c0de-13f1-45ad-486a-08d9aae5233a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 22:45:37.0447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1KUtGq77vSvTI9puSV3n5yIR0zjy7P0eKUOJlcjsdQ2RTYZCn+U/yA4gjc0YM9cEQvgRKMnW9mu6Ufy+Nr3ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3137
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 10/7/21 2:17 PM, Kim Phillips wrote:
> On 10/7/21 12:28 PM, Jiri Olsa wrote:
>> On Mon, Oct 04, 2021 at 04:41:14PM -0500, Kim Phillips wrote:
>>> ---
>>>   tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>>>   1 file changed, 24 insertions(+)
>>>
>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>> index b915840690d4..f8a9cbd99314 100644
>>> --- a/tools/perf/util/evsel.c
>>> +++ b/tools/perf/util/evsel.c
>>> @@ -2743,9 +2743,22 @@ static bool find_process(const char *name)
>>>       return ret ? false : true;
>>>   }
>>> +static bool is_amd(const char *arch, const char *cpuid)
>>> +{
>>> +    return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid, "AuthenticAMD");
>>> +}
>>> +
>>> +static bool is_amd_ibs(struct evsel *evsel)
>>> +{
>>> +    return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3);
>>> +}
>>> +
>>>   int evsel__open_strerror(struct evsel *evsel, struct target *target,
>>>                int err, char *msg, size_t size)
>>>   {
>>> +    struct perf_env *env = evsel__env(evsel);
>>> +    const char *arch = perf_env__arch(env);
>>> +    const char *cpuid = perf_env__cpuid(env);
>>>       char sbuf[STRERR_BUFSIZE];
>>>       int printed = 0, enforced = 0;
>>> @@ -2841,6 +2854,17 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>>>               return scnprintf(msg, size, "wrong clockid (%d).", clockid);
>>>           if (perf_missing_features.aux_output)
>>>               return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
>>> +        if (is_amd(arch, cpuid)) {
>>> +            if (is_amd_ibs(evsel)) {
>>
>> would single 'is_amd_ibs' call be better? checking on both amd and ibs
> 
> Good suggestion. If you look at the later patch in the
> BRS series, I have rewritten it to add the new
> AMD PMU like so:
> 
>   if (is_amd()) {
>       if (is_amd_ibs()) {
>           if (evsel->this)
>               return
>           if (evsel->that)
>               return
>       }
> +    if (is_amd_brs()) {
> +        if (evsel->this)
> +            return
> +        if (evsel->that)
> +            return
> +    }
>   }
> 
> Below is the full proposed replacement patch for patch 12
> of 13 of the BRS series.
> 
> Another option is to have the is_amd_{ibs,brs} functions
> call is_amd() themselves, so the if (evsel->) code could be
> unindented by one tab, would that be better?

No reply, so guessing not.

Arnaldo, can these two patches be applied please?

Thanks,

Kim
