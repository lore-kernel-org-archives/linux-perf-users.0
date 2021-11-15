Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5FEC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 12:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B78617E3
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 12:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhKOME6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 07:04:58 -0500
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:42081
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230438AbhKOMEv (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Nov 2021 07:04:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ineHndxbbRjDNEn8PUXx7/U728+T/KpHSaOjcRDAKN5gAwbXlAszviF0cXMNKpGih2QhVk9z1J5dfc8y1mCb+8Yj7EnruFtdzOtum5Q1AVz7Ra9kWcLmg+ZMITB0gUrNBspKkO6nl4LIE8s+GaOZ41cavq5dB6fZgCgmwtChaZckPX8FbMlz5jUrXzT3Os+t7fognkuzuKLnjkonkWaF1ahBknNuCcHWmNT/FjLVB1md4ThiSLwlcBSkPNd0CRfbQJu/pfA74EKzZYHDYmZJFftHltPvZgCfKoEUibhirfYCumGzpU7Gxd1pMroALuEq202uiBKaYbeGgW52aYFhEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jay/sxUrvqXb7RccsxlqOVWjE6dgyMzpsLQ8IPJ7EWo=;
 b=fIRNFO3Tu8xQTWHQDff/DCilus+1tXNhWhwn5ckhVSXvyI6vdYM+ChyqU/MMUNY4thrHux1b47h8LBAzAyzgXR5urElO8+pKZ5p7sSqv7t8v3GhrrtI8gkRuD40VIPgARVgfCIoH4rz00ei4k0sp3SVrQQL8VgEDT7XtmaHwcr0PHUwexqvbapdf+N0Q2l3C4eX0l0s7n3lw+32Xy5MLPwRFgiZxGnBm+yd3cl8BPoHmhHhq+2oCiGAXnzHl6egYq8EvhiHakIARXJF285EybPyL+UMnoaS9Hfu2CuUi3jMaS9jxCRa79AdHTudoccBkBxt5riwOKShOTmloT+UZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jay/sxUrvqXb7RccsxlqOVWjE6dgyMzpsLQ8IPJ7EWo=;
 b=qTQjCEOAWSl5zdZ58qEs8WqlQ4etw7cXakhv4lRqllSQtyqOHZ23bVHi1G5/3HqXk+JlY50kACDsWcF4u3Gj1k1lyaRlq8h+f5vGu03tvy4Y2/MkZ+hMGBEExzWj/0CqhGYvD+X+j2odUlBBEQHkIUIetwvAWyiQmrHd+iYmJgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2654.namprd12.prod.outlook.com (2603:10b6:805:73::28)
 by SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 12:01:38 +0000
Received: from SN6PR12MB2654.namprd12.prod.outlook.com
 ([fe80::906a:a3c6:9f9a:5fc6]) by SN6PR12MB2654.namprd12.prod.outlook.com
 ([fe80::906a:a3c6:9f9a:5fc6%5]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 12:01:38 +0000
Message-ID: <7ee6951e-eda1-7872-4158-e3bbb9eb31b7@amd.com>
Date:   Mon, 15 Nov 2021 17:31:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC] perf/amd/ibs: Move ibs pmus under perf_sw_context
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kim.phillips@amd.com, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, santosh.shukla@amd.com,
        sandipan.das@amd.com, ravi.bangoria@amd.com
References: <20211115094838.3359-1-ravi.bangoria@amd.com>
 <YZJB5FVHpzhwFMtZ@hirez.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YZJB5FVHpzhwFMtZ@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::25) To SN6PR12MB2654.namprd12.prod.outlook.com
 (2603:10b6:805:73::28)
MIME-Version: 1.0
Received: from [10.252.93.92] (165.204.159.242) by PN2PR01CA0170.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:26::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 12:01:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 506d23c6-58bf-4809-9e8f-08d9a82fad5d
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:
X-Microsoft-Antispam-PRVS: <SN6PR12MB28144F494FAAD92B81036F38E0989@SN6PR12MB2814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AIAE5Bb33iAUt/EbkptKpYDKseSdm8hX4qectCeh6R9YuxtPInGcAHqO8cNDU0MPrYffUR56IZ2IAQq32DziZ7mSE4nPmHWmPdK9YDQfjV++9hFgCwTwoC1sU7n9gWlw+wFPt4F6pUGhYLixgNF7RcjpDGUZSmldy9F5heeKdDaVMrsk46DYHPObTLp0aa+1kC5GHtv7L0c8TIjgMUB6VJonYBtIrXrCEsz9C023KnWM/RDfd6ilbT67zBYjFiOWtUDjlscL5ViNAG4Xrx61oTSBzc1yXTiR6+2i1dXwCbfBWX8LNmDvuVp9iDFH+Qkoy7Fw7mUCqKsBoC6tysZ6kgDqXo9jvvFMzgLs77YeK5OMv6AoinO7eZMqx3Gz8m8w+dkgIVeuo7CJe4ynsSNSqBCLrTLmlC9jvQp6UFWki9dLl9/0TXl27LZkrr6zrJp/+PgesJZbwfqDWTi4EVLYAWIbWyJtBFHk1WA43FOlxYEnRZZroNu02KPgLQqQsAhWUniar8yGSFYhw0o6FIJmpXe9LijaZeueaFk2QkkhnqevpZa7tqD/oWwo5BuFbVl3drsZPTQJsuFtwaCZ7YApi0Ulh54vJnC8bq/wQImM7oKv//YbwiFjnjfnr7TBfDWhTcjjFC1XBipT+xDJhFu2BhyU2JEl4xdUigZq5hGQgr3L6KB+mAfeuX6IL3q6odqgyoEQDI1gZhg7CwweVu/CNs9LkbkPYdx9M9GehxfKNRaV/tH0MKgqdCeXH8uhhgeehKre8CrNWRMlHyLVNXE9iGka1Db+RbXvJfvUkVe34LR6sU8SwnTEVVZot58vgEgSL2HtC5hHGND3VLozap1o+CsX2ksr3uxTxKidZSuvIlY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2654.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(6916009)(5660300002)(66556008)(86362001)(66476007)(36756003)(8676002)(66946007)(31686004)(2906002)(6666004)(26005)(7416002)(53546011)(956004)(186003)(6486002)(4326008)(8936002)(16576012)(44832011)(508600001)(966005)(2616005)(83380400001)(316002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUgram5PWU1uWG4xTmprTmJhQ29Cc1A2OVUzaElHQkx0SU9uQmlQaXE5YWQ2?=
 =?utf-8?B?dmpaU29nNFl3enNFMzlJYmRWbzJhdzNRMm9zcEFGREJrSkhpaEt0VzcvTmlF?=
 =?utf-8?B?bmdnU0lZeXZWUmpnVmc3RXFtdmcyUW5Sa3hnWEFkTFhMcGhTVnplOUNWWVVx?=
 =?utf-8?B?TjFsMnNHOFFsWTlmTHB1eVBZMEZoc2Vzc1lTZlJ5Qk5pMHpDd0x5M1VUYmpZ?=
 =?utf-8?B?UTBPT0ZzRWhvSU1xemxDRkNiZDdJbGtpbUdVVFBmaFpyZTcvMTZQYlZ0M2pr?=
 =?utf-8?B?TVltZW1vZFBCbHNnMnFMcTNUQmQ4V0w3dWtVY1IwSjNJNEJMdzRYLzV6R25V?=
 =?utf-8?B?dHhmNzJvalN0Z3UwQWY2dm5pTWFta05xWExFUFhtR3J4QUtBV3lRSGNLb01u?=
 =?utf-8?B?VkFIZU1acnp6WDVHLzJVVEJlNHpiZm1ERmxUV3BUL25pUEI4TWtjQ1ZYNktr?=
 =?utf-8?B?WXp6UEI3T0cyd1IvLzVQNXhaanNtTll5MWtjaHlmclhMTmdKNmhEdFRMMHRC?=
 =?utf-8?B?UFFFVytPNE0yWXRyWDRkbXB4WlpXdnBwcDg0NWxpUy8vTjdYUG9qcG9zVTBI?=
 =?utf-8?B?cDZyTStxTXNjZ1BmYW1RRHJuY3BxczdKRUVTTXdQR1BMRUxxTE1LaTVHSEtq?=
 =?utf-8?B?TmxYNFY0ZGVMN0FQZEd3NnFGZjZJRjNRUWFUNUh6ZTVPZDd1YVdGc3daY3Bt?=
 =?utf-8?B?ZWUrZDAwdGpkcXlnUjQva3NPZnBLeU9XMGp5NGtZTG9HS0d5ZUhCYzJLUU9M?=
 =?utf-8?B?QzQ5eEMxczRSamJuQWFMcFd1dG5yb1dZZGMvdTBOUE5YaDRnbTRuU3NhSWh1?=
 =?utf-8?B?eFRyTm9aUHM5dmsrMmROK1JVNHZ5dGdPS3JFdUtvSitQRkZEYnhZUFZ0YWFo?=
 =?utf-8?B?dTlYc0xNeTZGWE1IbWNONjYvL0g2b0FXeGxwUXIwdnRmSGZkdFhadFJaZlZi?=
 =?utf-8?B?QkJqT0ZDTTBUcmpoWm9oeERBVlgvTmFrbWQwNjZyNStMTjMrc29NdndsUzhY?=
 =?utf-8?B?dWJKRWJXc1NocnhBUVMvUlF1WVgxaTRUdm42Y3ZBaEJaOWhmek5ENDg2bnlM?=
 =?utf-8?B?WFNBR2ZlVlVvMUxiYWJIdGJJM3VObTZweFMwOEVTeDZjZFlPZit3YndZaHZt?=
 =?utf-8?B?WXlYOFI2YmxJbnkwNHl0ZTJOb3hBQUxmUno1bHF0ckFtcGZRMGgrMkxFTndM?=
 =?utf-8?B?anlremlSM3IzWXorZ0pPTGRrSUZJM0xsOVU0VERLa3QySGovVElsUEVqd0t0?=
 =?utf-8?B?UzRRRW5LQ1VsS2dDbVZDOTZ5OXhydk1vUHpqRVYybG1IL1NsZ2oycy9FNnFK?=
 =?utf-8?B?djRPcjc4ODJKOVh5cXozQm9pR2preHpqQzdLWWVOSCtBSkV5YldVdTBzUStt?=
 =?utf-8?B?cndYSnZRQ0l5U2lVMFNDK2xkMm80ZDMxMWh0VHd0TjdwYVZoMllXUVN5Vkwz?=
 =?utf-8?B?bEVCZE9kSVMrVExDSFNYdXZ6UVdBWktncVF5Z0dhSnZrSFI1RW9ES0g5N1Nw?=
 =?utf-8?B?WVNDSmppbkprZFBFZUQwNHY2a0pvb3FBbjR3UGY3bFZqU1lFb3NJU3Y0ejhR?=
 =?utf-8?B?em1BdHZsV1ZVZEIyaUtodTFjV05LbDBVcThZdi9mendodkJuMDhqN3FEVUFy?=
 =?utf-8?B?VlRtdTRFcVlxWDJBZ2NteXRxYjg3WTdVWnlhT1puL1Zqc3VLWitHLzhJRTgx?=
 =?utf-8?B?bnp3cWNZamtMR3BjQTd6WWdzZmJaQi9SdUdKTHQ0SkNVQk1xMlJwZlhhNStw?=
 =?utf-8?B?d3hYTnQyaTdJdEtOQkx2V2c4eWoyQWJzQlJCMW05d2NtWWZGOUJTbDZ2R0tR?=
 =?utf-8?B?ZXdnTXlzd1VmQkFSU0c1eXVuY1lMRnRiSS91ZWt4UVNCY0xyWS9LZWxxQk5O?=
 =?utf-8?B?T21hazhyTURrT0c1Y0tNVU83NFFWYkhLdlYxTTZ4OVIyMmpkOVU5SUNoaHh4?=
 =?utf-8?B?SEszS2FXbmZVOWhYWmNjUmlpV1lrK28zaVFpVTl0QndNVHdvVDN4diszMW10?=
 =?utf-8?B?K09HU1BLUVJvSWk0UW5hNkpJYUpCdEg0eGo4Z3lOcFk1cEw2by9hbkNYV0Yz?=
 =?utf-8?B?UndCaDFrNGpiMHIyMVVVWmNYaUVZZWhhaDhCenJqdDdaMUJjUGJUbmlHK0Ex?=
 =?utf-8?B?N0Q2VXZzNkd2WE1PS1RCbUpEdW1lVDJLbEpva2tkWjJDOXNmbEdGS09UcGtT?=
 =?utf-8?Q?yxTdLGKhkVm1UmEYeB+ohsQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506d23c6-58bf-4809-9e8f-08d9a82fad5d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2654.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 12:01:37.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7tv2I0DtTWEUYyvsjCGnSaxg/3vIJiC6xLXzpS/MEgl3GIVeeUCTm2Sy4/MJsPUSoBg/J6cCj4t/Ykb+sKdsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 15-Nov-21 4:47 PM, Peter Zijlstra wrote:
> On Mon, Nov 15, 2021 at 03:18:38PM +0530, Ravi Bangoria wrote:
>> Ideally, a pmu which is present in each hw thread belongs to
>> perf_hw_context, but perf_hw_context has limitation of allowing only
>> one pmu (a core pmu) and thus other hw pmus need to use either sw or
>> invalid context which limits pmu functionalities.
>>
>> This is not a new problem. It has been raised in the past, for example,
>> Arm big.LITTLE (same for Intel ADL) and s390 had this issue:
>>
>>   Arm:  https://lore.kernel.org/lkml/20160425175837.GB3141@leverpostej
>>   s390: https://lore.kernel.org/lkml/20160606082124.GA30154@twins.programming.kicks-ass.net
>>
>> Arm big.LITTLE (followed by Intel ADL) solved this by allowing multiple
>> (heterogeneous) pmus inside perf_hw_context. It makes sense as they are
>> still registering single pmu for each hw thread.
>>
>> s390 solved it by moving 2nd hw pmu to perf_sw_context, though that 2nd
>> hw pmu is count mode only, i.e. no sampling.
>>
>> AMD IBS also has similar problem. IBS pmu is present in each hw thread.
>> But because of perf_hw_context restriction, currently it belongs to
>> perf_invalid_context and thus important functionalities like per-task
>> profiling is not possible with IBS pmu. Moving it to perf_sw_context
>> will:
>>  - allow per-task monitoring
>>  - allow cgroup wise profiling
>>  - allow grouping of IBS with other pmu events
>>  - disallow multiplexing
>>
>> Please let me know if I missed any major benefit or drawback of
>> perf_sw_context. I'm also not sure how easy it would be to lift
>> perf_hw_context restriction and start allowing more pmus in it.
>>
>> Suggestions?
> 
> Same as I do every time this comes up... this patch is still lingering
> and wanting TLC:
> 
>   https://lore.kernel.org/lkml/20181010104559.GO5728@hirez.programming.kicks-ass.net/

Thanks for the pointer Peter. I have looked at the patch and it is quite complex,
altering the very way perf event scheduling works.

I don't dispute that is the right 'fix' for the issue, but do you think adding a
new perf context can help alleviate some of the issues in the interim?

Ravi
