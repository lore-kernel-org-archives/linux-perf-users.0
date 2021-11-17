Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA58DC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 04:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F59B61BF9
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 04:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhKQEeO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 Nov 2021 23:34:14 -0500
Received: from mail-sn1anam02on2056.outbound.protection.outlook.com ([40.107.96.56]:16462
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229632AbhKQEeO (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Nov 2021 23:34:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMKpTIhtZ+2/sHsYL7DQpvGQeeZsxEnQ376jQze8ffznMThn93glUYz6tx7cIDge2u29wf2nTYTdLPCeSddtha84YjFSW63DC0AmzAbhKG+0zaHiyYnstlBWla3vmVdVjxpFfjSDcgHFPDSWQKlXzr+56UH2SKv7PipCC08Yai2vwogRIiYd/j6XEQYxM0N8yVg7gvXHPTvg6kv+quHZPHgV8+6yhjvK3SqIWRkVzu5rszlgGSZ7GP/k3I3jmQBXuCuohw2UH+ExPng85Ag3SZsCGbucjIDPrTg3lIXvKGwam7fBu+rsJSm7ZgwK3dDoLp5YPYkmJhaD9Z2RXFdvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlHDB7MKHrf3soPVBu3BbKWgsz3z97QXhIT1flBpHJM=;
 b=EH9n5YtyC7zhIjwSjTY4cWmRMxKn3EYvYJpPfiU0VFCqEarmT64NHRFeARV9jssOuwGN+7fCNZb5JYKlx0Hl7DCnr6zduniGhWPU37c+ouZAX45eZZ0X/BfOCzap/ohHzhYvYD2oqFJBeloqf/vMX1n3bqox5T8Jcco6PQO0OBTwI5tHHiE5bKA/7DUoWUs9nzusgVHWVguQWa/Ybdu0oJ4x2fbbr+yDumVcUAXTzGgU3XdBFDCDNqNsqSb7Aper8lzvlGbXA9ELFlpXXfMDJpWbLAFtLg5ZwyLHvn6T0YlGvO9Q3XxgzzVO9SGXNJ8aZeHezxZJCTCn8351O+HUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlHDB7MKHrf3soPVBu3BbKWgsz3z97QXhIT1flBpHJM=;
 b=M3EE7lqQQZwy5Vg7F8PrdaBH70rWyHsM29D0tIQsxwJIduhOnlVpkvQpeJghLyZcO7jvGAjfjs3SqVYra+pWRJhc4IZgI9buOgWtuB8GPLXvRiX2oE7fST3R3xdjg4nbLYrnSVxXrqX5BgH0msMBtg3h98rKPwU+LkdxlQkeU04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2654.namprd12.prod.outlook.com (2603:10b6:805:73::28)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 04:31:14 +0000
Received: from SN6PR12MB2654.namprd12.prod.outlook.com
 ([fe80::906a:a3c6:9f9a:5fc6]) by SN6PR12MB2654.namprd12.prod.outlook.com
 ([fe80::906a:a3c6:9f9a:5fc6%5]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 04:31:14 +0000
Message-ID: <3136ff3c-9b5a-383a-efc5-43b3d174765b@amd.com>
Date:   Wed, 17 Nov 2021 10:00:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC] perf/amd/ibs: Move ibs pmus under perf_sw_context
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kim.phillips@amd.com, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, santosh.shukla@amd.com,
        sandipan.das@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20211115094838.3359-1-ravi.bangoria@amd.com>
 <YZJB5FVHpzhwFMtZ@hirez.programming.kicks-ass.net>
 <7ee6951e-eda1-7872-4158-e3bbb9eb31b7@amd.com>
 <YZJNZRuXjND9zqjL@hirez.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YZJNZRuXjND9zqjL@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::15) To SN6PR12MB2654.namprd12.prod.outlook.com
 (2603:10b6:805:73::28)
MIME-Version: 1.0
Received: from [10.252.93.92] (165.204.159.242) by PN3PR01CA0133.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:bf::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 04:31:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29400ac3-9c8b-4985-f2d6-08d9a98316d3
X-MS-TrafficTypeDiagnostic: SA0PR12MB4461:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4461F8C035E46F15E8A7DFD5E09A9@SA0PR12MB4461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90DBbRFM4Q8R6ftm2s00bDFOszfQzWPURH4Uvz9t+52la42g5mx4WNBjSU5Jbgbd3NlQo+dM7JE7P2h3WMUdyxvPi1ZD4zS9yVJ3KG/Qsy9ImiYtAc4WKERYGhRC3jxuBSlNZa4F8CbgxyHB+nMFniE7wKMJrmct9vMJf7x9110gg3hUNWI2qFkf+x3vJLwJyRB9nZNPb0cW+SF42FLhpB2A+LPFjhGrEFkySmBR1PWIGIgyQdKSXywJD/ndM5pYiyQ5BeHeHNOC+Asgb2wutksnFj1GvFXmqyrV61QKfGyL3jMxRk7h0tYjxhUUcIgL3sneWO7Uf6Wy+W3mGZETpMZkSd88ZqbsF/Jgl7/IGiBEZV0hCyl8Zd2c9Rm5vGTNt1wjwF+U/+qx/pIfnMDe2T6cgeg8vFhDgUzU2t0vZWJL0sbFVJY/eNuxdt1obbLiGpdYU6t/L1r8Lt8jpUPYsYs2nJuPppjZiRsliA19EW83pHvaps0C/hEL8EvvJGfeZVk1WwvKAKueMOJZaVZp/qDWtQtlzomG8uh4Qs91dY8hiJXjphmcGiMeBwPgx0x39e/NUipmGldDESo8p1l1i8qYukfL5JOwDHKaidE+MRAubWnnEoYwcHs6DlGfK4sWpmR1SN2TL1Of8Qw6OW1ZNrB6FAEmh7wTsimGiYLl/kKuyttKteoYGiJpyeTDKaakr0U7IvLk2EyygCHjuIt02IuU1+wVNefuXEWRTFXtn0dGIyaPt2PyfiuPWbJpUcVWfZ0w49GAW8TCI1hjDXz95YXL4frPCSmeElyaEjd/VhT8e2B1DOcie61+q4kDD5zFg8j8Qj4IV+l5zL//kum17Bt1Ztg6sxH3nPLZMNRJPn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2654.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(8676002)(66476007)(6666004)(66556008)(53546011)(508600001)(186003)(956004)(2616005)(44832011)(6916009)(86362001)(4326008)(966005)(26005)(6486002)(45080400002)(8936002)(36756003)(31686004)(38100700002)(83380400001)(31696002)(5660300002)(7416002)(2906002)(316002)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkNhNDN5ZWIxcmNpMmMzcnZHTjhJUEhoOWl2UHd5SHFkMC9wWW9TMi9FUGZ0?=
 =?utf-8?B?ZmdjYlQrTG5CRitCRFZ4UjFJcTNuTmlPSE85QkpWYmJ3MnEzcnRYQVphUXRi?=
 =?utf-8?B?cTFmUzREMDI3ZTFlNzFXZndxRkt0TmVvYjBzeXNrdjRQL2tMZ0RFUVNTYnFm?=
 =?utf-8?B?OFg1ejBsckRRYkkwT1RDK0VtMkp1WkhpU3JIWllMUjdvamVETENBRk9ZTWNp?=
 =?utf-8?B?MkRCMU9sbjV6YTV5RHgvT0dFV0YvOXdqcWpjWi8yZHpZbkUzQmRSYXNjTWRF?=
 =?utf-8?B?WWZWcEhpRDNQNFpKSnlOb21FNGErWmhXYkRnbHEyeGM0TURPTE16Y1FSTlpQ?=
 =?utf-8?B?N0liQ1V6TkxZampmdklCd1NGYUNLcUN0YWh2cnBGUzZ1OGxVT0x4bXF2ZHBy?=
 =?utf-8?B?VXd3dmJuM3pTaEhGN3ZpdVAvMTRVYjA3TjQ4Mk80L0V0TlFvdWlnZStRT1Jv?=
 =?utf-8?B?M2Rld3pnYTYzMis5dzNFQlRrTzZWY1V3Z3FDWENXUVo5SXlpL3hybmdQNEpt?=
 =?utf-8?B?M0pHdTNTLzRjUlFIcDBkWTAvWlJTWXF4TWg3bktaUjBnVmtkYW5LQmRMcUR5?=
 =?utf-8?B?S21ldlBFaGJCUTRveU1IYVlsZWhwOVFBbzM2WTQySDhXeWhxZ2FLNE14Rldq?=
 =?utf-8?B?TDcxYlJWdkRYZXNITnBZMm12SFdNdlNPZ1pNVFA4YkU5L1VXWmJPOGw5KzBh?=
 =?utf-8?B?ckRzaHNqUnVJZmZWeXRjK05CSmw0Y09JejBWcmgvalVmeWJRRjFGOEg2QlZv?=
 =?utf-8?B?cm9yQkUvQmlQTEV6cURKQTZkT1RuUlpzcm1jZWRHcjUvekZnOXN5VmRVSUky?=
 =?utf-8?B?UUgrd0o5UmlJQ2cvcTVpNnExQk9SbVRweklRMUcxeXUzS1lRcS9scWhNQVRZ?=
 =?utf-8?B?dTgyOFl6aWRTQzJhcnljVGViWXptRkgwMnBraHhqYUxpMG55d0VuMmR0WCth?=
 =?utf-8?B?UWdOdUhmQVpmYzZsYm1wQWNxWUF1RkNSOEhWakErQ05ZMFFQU1BaQ1ByZmxv?=
 =?utf-8?B?NzVyS29JNUJGUnJQa2xRMUZwS0FyRVhHalFtR1orazJnejBZbVF0N096M29h?=
 =?utf-8?B?SFJpWVV3ci8xMHY5UitTazlEMDR1c3ZRTnYyM3hqTFN1Q2xyWW1iVmxWOEhW?=
 =?utf-8?B?UlIzMXVLS0piOSszdVk0dWN2V05ncEZtWUUvN09EbHQrS1ZuOUpuSU9BdUgx?=
 =?utf-8?B?NGZLOWxtU3VhMVlsOTljeElQZjJyNVlRRm9nZVYzSHFqKzdCeHp6ZE0vNzdv?=
 =?utf-8?B?SnZxU3V3WDlwSDRlUUlQV28zdHZLaUhwZ1dBMVU5UkdURndpZVh2ODZDVFNW?=
 =?utf-8?B?R1JkU0RFT2xUdDc2eVNzb3ZkeXVucWNyck4ySGVVUTFyOE9DK2craUdqTXJI?=
 =?utf-8?B?Vyt6dkd6S0pkZDBLUWllUEl0UWh1OGVSV2JLSTN6QzRBQnVySXJSWnhXSWlF?=
 =?utf-8?B?bEVqNzNCUzZ1MjFFTWxlQmpVMjh1U2l3OExXOVJ5Z2VZNFRyRTJRblk3Wm54?=
 =?utf-8?B?ays3c1NRTHNyV1drWXo3NlBpa21PL2djSWJGN2FtNGNTdXBBQjZFZkJyN0pT?=
 =?utf-8?B?M3pPRmltcXdnaTEwT2o1aUV2TlNrR0NJeFVNN05RZ093NkVzUTIvVUhTMW9R?=
 =?utf-8?B?WVFFSk41SFJOVjNIK3JidFZwdlV6OW1XWWRmWEsrSUg5RlBoM2hMUDFRK2pv?=
 =?utf-8?B?Vm05and6aGhsL2NGUjdRdTV5M3FCVWpqb2hUQU10VnNlQTJkTGg3OFg2Rmlp?=
 =?utf-8?B?Y1BFWEFvZERKS2h4SzRIWWxwSWhCK1UreFZIbmw2dDBQWEV5OWQ0T21telQ0?=
 =?utf-8?B?MlVJSUhQUy9UdU5VK2hJdXhrL0FyQkI2aEREN2FlTW82QW5QbkRMVWhhSVN1?=
 =?utf-8?B?WERYRnhrYXpISGJIOWV2Uy9CRGNTVW5wTnRvY0pvUGpwSUoxcGVaR2IzUG9J?=
 =?utf-8?B?MXQ2SGlzV29uS0hTUm9rbDRCYWExcFVjUHB6Wm1UK1ZIQnlFTkVPV1crYmNv?=
 =?utf-8?B?RHlLanhaUjdEZlFIMGJYMW9yTFFpWTgxZmlneTBuem5wTUtqdUNPcWs1MVhw?=
 =?utf-8?B?WXl3ODZEWXJ3cjB3Mlh1UTMvelc2VE0ybHh0ejNUcXFMUDJ4ZFB2WURIYXVl?=
 =?utf-8?B?LzJJNTYyS0l2U01KRjJKcTNLQklBTkFPNTBqVDh4bjZDVFJMeWFRMi93ckds?=
 =?utf-8?Q?A00L95TQH36/y8p0kNcxPUs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29400ac3-9c8b-4985-f2d6-08d9a98316d3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2654.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 04:31:14.2932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFuP+rY95fQOSLOZ2DqWBW7NzqhZzmrA+cGZa2gTnjzTZwbj5tNv4ef8BjLWYM7us78pEdvbC3txmVt5AWdykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 15-Nov-21 5:37 PM, Peter Zijlstra wrote:
> On Mon, Nov 15, 2021 at 05:31:21PM +0530, Ravi Bangoria wrote:
>>
>>
>> On 15-Nov-21 4:47 PM, Peter Zijlstra wrote:
>>> On Mon, Nov 15, 2021 at 03:18:38PM +0530, Ravi Bangoria wrote:
>>>> Ideally, a pmu which is present in each hw thread belongs to
>>>> perf_hw_context, but perf_hw_context has limitation of allowing only
>>>> one pmu (a core pmu) and thus other hw pmus need to use either sw or
>>>> invalid context which limits pmu functionalities.
>>>>
>>>> This is not a new problem. It has been raised in the past, for example,
>>>> Arm big.LITTLE (same for Intel ADL) and s390 had this issue:
>>>>
>>>>   Arm:  https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20160425175837.GB3141%40leverpostej&amp;data=04%7C01%7Cravi.bangoria%40amd.com%7C8b30ce7e52c0414dc65e08d9a8307149%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725748302455206%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=59fepiNH9du3ZR0owjPcquQ4YLc%2B8hE74H%2BpdnQggQY%3D&amp;reserved=0
>>>>   s390: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20160606082124.GA30154%40twins.programming.kicks-ass.net&amp;data=04%7C01%7Cravi.bangoria%40amd.com%7C8b30ce7e52c0414dc65e08d9a8307149%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725748302455206%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=cSEGVgRbClDXeGJmEuGr1P8YXSIvhx%2FxbQjmdydQiuU%3D&amp;reserved=0
>>>>
>>>> Arm big.LITTLE (followed by Intel ADL) solved this by allowing multiple
>>>> (heterogeneous) pmus inside perf_hw_context. It makes sense as they are
>>>> still registering single pmu for each hw thread.
>>>>
>>>> s390 solved it by moving 2nd hw pmu to perf_sw_context, though that 2nd
>>>> hw pmu is count mode only, i.e. no sampling.
>>>>
>>>> AMD IBS also has similar problem. IBS pmu is present in each hw thread.
>>>> But because of perf_hw_context restriction, currently it belongs to
>>>> perf_invalid_context and thus important functionalities like per-task
>>>> profiling is not possible with IBS pmu. Moving it to perf_sw_context
>>>> will:
>>>>  - allow per-task monitoring
>>>>  - allow cgroup wise profiling
>>>>  - allow grouping of IBS with other pmu events
>>>>  - disallow multiplexing
>>>>
>>>> Please let me know if I missed any major benefit or drawback of
>>>> perf_sw_context. I'm also not sure how easy it would be to lift
>>>> perf_hw_context restriction and start allowing more pmus in it.
>>>>
>>>> Suggestions?
>>>
>>> Same as I do every time this comes up... this patch is still lingering
>>> and wanting TLC:
>>>
>>>   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20181010104559.GO5728%40hirez.programming.kicks-ass.net%2F&amp;data=04%7C01%7Cravi.bangoria%40amd.com%7C8b30ce7e52c0414dc65e08d9a8307149%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725748302455206%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=sn7QOMMjrzsbBsvdEAPttouujDel0JuDptIFMHkm3Q0%3D&amp;reserved=0
>>
>> Thanks for the pointer Peter. I have looked at the patch and it is quite complex,
>> altering the very way perf event scheduling works.
>>
>> I don't dispute that is the right 'fix' for the issue, but do you think adding a
>> new perf context can help alleviate some of the issues in the interim?
> 
> And take away the motivation for people to do the right thing? How does
> that work out in my favour?
> 

:-) Understood Peter. I will take a stab at making your patch upstream ready.

Ravi
