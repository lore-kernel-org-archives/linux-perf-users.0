Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3793C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 16:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F1561391
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 16:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhKRQyy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:54:54 -0500
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com ([40.107.223.71]:20584
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229580AbhKRQyx (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Nov 2021 11:54:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFHXsHtLFcBX1vnEJbgu/QNs9VdDiJRV80DRTTZB8Hh30/rio3TR4+WIPRE7YosWMWPCXNqszY2n9m9ukaqEQaMGxAeosbAmBQsXrLnTf0x8ENQ88q7w11whfzJsML2GtKRiqnW/0Sy7DBM0E7gvfplapdnx2GD4af1SDJEeD2gZ1zFt7OaYpIY7McZHMhVElbpQ1bOzFbF1S7qeEx6b6dvwukmuvljNasQn6UIfxmJzmntk/dpUIiXFICIa+TcyxySBJcKUWKH4LePLk04HliL6qbD55mqEN0RTTl7yGvNfFtCcmtxYsHJr5lZ29OfvJ1OPn3W1F96i/xQFTVEMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vn0OkTalGiRwo+Fm+XY7vWoxG7dC3OZDqYa52IwOF2Q=;
 b=kCsb1mrJ/f0rZGiWBPwdZtTrELscu9/5XILeZuG5twXPzjysULGPqa1n0/roEP1j8MqqkkPfBlsbmIquuCcUnl3+/x9kNNIfWrb/OttEK7R0HIbDIJyRvkaz2NosTIHPhYLiIwsmvCpWzzJUokY9+41/9LMqy0udb5pTIJli4ORY9x9m34a/ojWLswrNYvf7RK63iKd/o0/ZDEZquJUbLqtW3Vd3KaGHRhP2FPUWEg+m6dMkLSdu1L/SsIZgGnlyvTPyHvRZ8Mo8JAJGbJ5entXoNx6zQxWGLdiQKlrvz6RBXSa3OH8EKuGWDtZGAFlYdIDvi1ox3Wf0JYu5ZD88pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vn0OkTalGiRwo+Fm+XY7vWoxG7dC3OZDqYa52IwOF2Q=;
 b=gfArEf/1Nh1EPcwFYqiyYFbx0TYgNbMdJD8LX5lBNNPt4HlyhtnWoNxNx0X5aS5CrDhyCSeqvS4yZ6ktcoM+2hbUb9j/dnglhv57EBThlEpXPzTwlafUZwGBqA+B7g8U9wqhd7Pw1vNrm5oKFwos49otHzYwuQX5EeWzcbakOFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3011.namprd12.prod.outlook.com (2603:10b6:408:4a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 16:51:50 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 16:51:49 +0000
Subject: Re: [RFC PATCH] tools/perf/x86: Use alternative format for AMD raw
 events
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     ravi.bangoria@amd.com, ananth.narayan@amd.com, rrichter@amd.com,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        kajoljain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
        acme@kernel.org
References: <20211111125646.581021-1-sandipan.das@amd.com>
 <YZE8SDkzq0OMcmhS@krava> <9dc5cb10-2faf-a17b-ad4b-a22dbe688209@amd.com>
 <bdbd0a4b-6221-ed90-0882-47248112ed3d@linux.ibm.com>
 <301c0693-f982-1769-6e3f-8b77a4201a69@amd.com>
 <783c4cbc-667c-b6d0-fb05-5250e444d9b2@amd.com>
From:   Kim Phillips <kim.phillips@amd.com>
Organization: AMD
Message-ID: <51cff547-4f13-bfa2-f977-75d51f0ce2ae@amd.com>
Date:   Thu, 18 Nov 2021 10:51:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <783c4cbc-667c-b6d0-fb05-5250e444d9b2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:208:2be::23) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [IPv6:2603:8080:1540:87c:fedf:2f0f:c0e6:d56d] (2603:8080:1540:87c:fedf:2f0f:c0e6:d56d) by BL1PR13CA0198.namprd13.prod.outlook.com (2603:10b6:208:2be::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.18 via Frontend Transport; Thu, 18 Nov 2021 16:51:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f89b319e-047f-4e45-9a12-08d9aab3b6ca
X-MS-TrafficTypeDiagnostic: BN8PR12MB3011:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3011B85F75B2C62B7BFFAAB4879B9@BN8PR12MB3011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZGvtHZ++DXGAMR4++48PpfaIANWydOGMTJ8WD4mNV85uvNq+FfFUTgzNiLzR9vQ4wQ1s7asPAPDo/8D1FIuWwBtgtXLq/cYkKVCtqGyvbV+hYK3P+G10q6zC+bWln3V2UMuKQnQ4wxGAQhjF9jnQLzdR2BiTjhTzacuJySKZx5GujPol6Zgbz5TC8cvQ5o8p8NQt1/EEv9JtweI5Ndykb1fbxy1BggqK/2YQJX08ZXkWHBtZ1op0nPBf6O4saDGGrwgb7boq5uhQAT3oLa9wXmu/GMvI99UdgB8x9tBBLp5xPpSaeIdDpULvKzMwBIARfdxMEnAqOMC0etoMXJ5pVWJi2jC5reZYyb+EzK2sayOe+xRboQ3JLUErvEGCi9WjIC9/E8B9BLPy/2L5yidwnzbogAEMrGoSR+Ek25Ti5IgXExUcNYnVS8rktfcEPbupUvc70MZntBKFGOz3Pw0c+Z5ZVd+wsmc+jki3wjyuOESuK+FzGbOJad1jBLGbFCdhQsLJymB9CQc3kyXsBXm+dbMf3Jcv1vzFpuiRv/wv79HjXqdwHYRDqIcZ8aRqVf/UvbQmUIzY/KBvhqISqUhOR+uFamaXd0PWs/YqNwijbXurf6FQueCqdhJKS2FqKcKqc0fCaQXwr/gp41v0YOr0hb9C9XrfttJIgAFJhXPvSwNgUua606Jlu397959Y7AQyEjP57aPfJiS8GEaLRa+rNH1K0bxjri+VB03yGP5trw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(53546011)(38100700002)(6486002)(2616005)(6636002)(44832011)(37006003)(508600001)(66946007)(54906003)(83380400001)(8676002)(2906002)(66556008)(6862004)(36756003)(4326008)(86362001)(31696002)(36916002)(31686004)(5660300002)(186003)(316002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bENMK1dtdmtSK2YzOThLYVlFOUFrU1ZmRWtTQVlPVW1LYUJ6Vmw4cXhuOE43?=
 =?utf-8?B?R2czUHV6QS9pVW94NXBsNzAxb1hYSUVkTHQ4VWdpUXJzYThXWVk1cXlYKzNC?=
 =?utf-8?B?Qy9ySGoxTDJ2WEFuR21vVG9tTnppNGJwaXFyUUk0NmNUdG0zSHlKYVJKRTFB?=
 =?utf-8?B?OFdydy9GaWZKSDFXTUhTaUFYbmZ2R0JBajN4ZHloSUVLaHFYWUhwVlRFVHg4?=
 =?utf-8?B?aHlrK1BKL2JmSUNWU1FFNk1GZWFqdTYxYktpeVFCaXR5TFNXZXBTWmg1d2RD?=
 =?utf-8?B?bUt1MmRkZU9wSTdFUlVMOG9PTVk1UUd4NitZVDZJSFU5ek9lSFNSYUpvRnVY?=
 =?utf-8?B?OVNodFNIbnlkalMvRlpkMVVoNC9yVWl5dHJoTVRhMHZ6c0d5OTFpUDJMazJB?=
 =?utf-8?B?eWh1YWpEeCtPWEU2M2MxOHAyQ3VZeG9CU3BKbTBxOHBGNDRMVFJOR0tTb2Jk?=
 =?utf-8?B?bHF5ZGxkMitpNzQ2K0VTL0ZnZXhWd2NmV3RSNnRJRU54ZXZoYzBJM3RXMWlh?=
 =?utf-8?B?Q0xIRlhGdDNXVXdRUUlRWjBqM1FCVjFzOVNHczVZV01qTFd0QVB5RzM3dWky?=
 =?utf-8?B?Q2Y1NjhyUFM3a1dIY2Q4N3NieEhQNHJqeTZ5N2paSENsd3VZcndicndLek9p?=
 =?utf-8?B?NzhOOXZlQk5mWjNSTU1CRmVCN1loQXZvNStoeUJDTC9KMG9GZFBoaFcvZkZs?=
 =?utf-8?B?cUxOV080d2cyMFE0WDE0Y2RDdnN4cnpuUUxqSjdOQjZSQnVYMWdSNVRMRG5t?=
 =?utf-8?B?cC9HVUxrZjRMdTJTazM4czJhTlJqYzlyYjFPbzkxR24wMnFoNHZWSmlINmdX?=
 =?utf-8?B?REQ4TUNSSmxPdkhCYnJnWU10QzJ2THRXWHlKU2lWRFFIdUplUnIrdkJvNkdN?=
 =?utf-8?B?Z2FDS1h6WUVydlBHbjdBNHoxRWJyQjRpU0szTCtJNUlOaUx3TlpXcEtzK284?=
 =?utf-8?B?d3BYZHB3ek9sNUI3ZHJGU3lnb1hQNmNrUkRkSkl5WWNSSzhMYmpqeXdZYm44?=
 =?utf-8?B?cFVDbnREUUVDL0dvMzBPL0c1b1ZZQUxDS1orYmQzdDlDc2ViUm0xUEpOK2tk?=
 =?utf-8?B?OEJBcjV6QVNwYnh6Q0VpQllDZXQ1aWlOZGV2cXV3RXI3ZHNFZTVzMjZBRUt6?=
 =?utf-8?B?ZDNRdVM1MEhSdDJnWGFkV0VBYVRUVW9xaTdMSTJRQktQWFZ4SGJ4RzN3VWk1?=
 =?utf-8?B?TmZ3Tm0rNmNKamtXK0VYM1Z6dUZoS1Z6bjhBY0xnZ09pSUJUQmpRd2V0WFZq?=
 =?utf-8?B?eTNLL3lHTkFhV1ZLUUNTTzZHRFljbkFMOGloNkJidm5iR3Q4OC9kclNQdUU1?=
 =?utf-8?B?WENXenVnQzhUZnc1cUVaVW9DTkJaSkhvdUtoVG4wY3Fna2xIYTVabzhva1Rx?=
 =?utf-8?B?QXN5N2F1dFVPU01HR1BIQ3hTMDhhMk55dnkzTDh3Ni8vU292S0NPRmN5R01k?=
 =?utf-8?B?emZsdVM4b1Izbk1mQXF2Z3l6YVA0MWdZZ0c4c0ZMNnhFWFF2Z3REWDdDdVFm?=
 =?utf-8?B?emFaTXQ5VEg2REtNV04xdXhrR1dhNTBYOVV2NTFaSU54TlNScnkzczc5aThX?=
 =?utf-8?B?Y2ZwLzRycHJDZ2RvdzY4RE9KOGoxby8yL0RUT09HcnhpQ3h6a0hLbEhXd3BU?=
 =?utf-8?B?VCs3dkdIbGxsWVZ3b3dpOW1ZSE00cmdEdnoxNWNsYURYZHJjWEt5a045bFJG?=
 =?utf-8?B?dlVaVDVwSzJOeXZkU0tGTU81R2QyQ29mc083OE1ic0psa29vN2xnNG01SlhG?=
 =?utf-8?B?YUlsck5tb0J1cEtLdVVZWmlKWTBUSzhLUm5tR0ZlMG9SeUhjVGIyUnYwcUdy?=
 =?utf-8?B?QTBQZXM3dHppR0ZVVGg4QVd0RUowaWk0R1k2UTVNNGFXdGQ0d0NQMC9BZEVk?=
 =?utf-8?B?ekJTa0xWNUI0ZlE1VU5aL1BtRWoycXNFTzRHUFZIK3A5ZXVmTmVjbWhqekto?=
 =?utf-8?B?WlNsWWxnWFZrYkpVYTJLWkMvaTF3MEh5eW1JWUtWaFFQY3VBSm9xZndlMVJs?=
 =?utf-8?B?cnlNcmtydHBjSU5CNlZEb1EwdkZTTXVWZ2h6S3lZUHNqdWM4UEdya0pnYUcr?=
 =?utf-8?B?Q1ppS1lXQUQ3ZjRpaUplMjBaVjVRakpJZ2pLQ3dROEMwUUR3UDMxUC9hMFNV?=
 =?utf-8?B?b0lUUlQxcHE5N05GS2ZDSjBBOHJtVXhoc3BGTml6WXQrMkxWRExITkxXUngv?=
 =?utf-8?B?ZzMrSlpmT0s4NUF5TmhOeFRtU3JzdXpsZlFXMmFHZzR2Qjltc2tEdkV0ZEI3?=
 =?utf-8?Q?E/PSzstwTAH3kDybXw64pZxD7LkmyYGbB2X7w3UGdI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89b319e-047f-4e45-9a12-08d9aab3b6ca
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 16:51:49.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0ECM3iONtNg3l7s/sld40ldruC0UEosK/yvRWRKoCxECcyy4ge2/pJa4CX+Knaq1rTNUJeEsyBMcqIQjmWaUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3011
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/18/21 1:28 AM, Sandipan Das wrote:
> 
> On 11/16/2021 9:31 PM, Kim Phillips wrote:
>> On 11/15/21 10:38 PM, kajoljain wrote:
>>> On 11/15/21 3:28 PM, Sandipan Das wrote:
>>>>
>>>> On 11/14/2021 10:11 PM, Jiri Olsa wrote:
>>>>> good question.. I see raw events as a way to put to config whatever
>>>>> the user wants and IMO adding changes/quirks that silently changes
>>>>> config could create confusion and angry users ;-)
>>>>>
>>>
>>> I agree, making quirks in config will only going to confuse users as
>>> It's against the encodings we had in
>>> /sys/bus/event_source/devices/<pmu>/format/*
>>>
>>>>> I'd think that if user is composing/using raw events then using
>>>>> directly r100001f8e is not such a big deal?
>>>>>
>>>>
>>>> Sure. Some of the confusion may be due to the fact that the man pages
>>>> for perf-{stat,record,top} state that raw events are "eventsel+umask".
>>>> While that is technically true, it does not describe the encoding
>>>> scheme (/sys/bus/event_source/devices/<pmu>/format/*)
>>>>
>>>> Would another option be to update the man pages with a reference to
>>>> these sysfs files when describing raw events?
>>>>
>>>> Something like:
>>>>
>>>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>>>> index 2d7df8703cf2..5dfdfeba594b 100644
>>>> --- a/tools/perf/Documentation/perf-record.txt
>>>> +++ b/tools/perf/Documentation/perf-record.txt
>>>> @@ -30,8 +30,10 @@ OPTIONS
>>>>
>>>>            - a symbolic event name        (use 'perf list' to list all events)
>>>>
>>>> -        - a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
>>>> -         hexadecimal event descriptor.
>>>> +        - a raw PMU event (eventsel+umask) in the form of rN..NN where N..NN
>>>> +          is a hexadecimal value representing the raw encoding with the layout
>>>> +          of the corresponding event control register as defined by entries in
>>>> +          /sys/bus/event_sources/devices/<pmu>/format/*
>>>
>>> Do we need to specify (eventsel+umask) in the raw event description? As
>>> the format/fields totally depend on PMU and umask name convention is
>>> specific to one arch.
>>>
>>> Can we just update it to:
>>>
>>> - a raw PMU event in the form of rNNN where NNN is a hexadecimal value
>>> representing the raw encoding, with the layout of the corresponding
>>> event control register as defined by entries in
>>> /sys/bus/event_sources/devices/<pmu>/format/*
>>
>> The r notation is for the cpu pmu only.
>>
>> The triple-digit 'NNN' is what's most misleading for 12-bit
>> event implementation users, such as AMD's core PMUs.  It
>> tells users 'see your processor's documentation's triple-
>> hex-digit PMCx18e event?  All you need to do is make that
>> "-e r18e" on the perf stat/record command line.
>>
>> So all notions of what size of parameter 'r' takes, esp. 'NNN'
>> should be removed IMO.  Perhaps an AMD/12-bit-specific
>> example can be provided.
>>
>> I had thought that the shorthand command line r spec alone
>> could be modified to be smarter and more accommodating
>> for conventional rUUEE users migrating to AMD/12-bit,
>> which AFAICT is not what this patch does.  I think it
>> modifies even the  cpu/config=0xNNNNN/ specification,
>> which, granted, is bad.
>>
> 
> Sorry I didn't know that events could be programmed with "config=...".
> Thanks for pointing that out. For basic '-e r...' usage, modifying
> parse_events_add_numeric() and leaving parse_events_add_pmu() as is
> should take care of it.
> 
> I thought about using the same fixup for the pmu format i.e. cpu/r0xNNNNN/
> but as you rightly mentioned, it breaks when using cpu/config=0xNNNNN/.

I think we'd be breaking compatibility with changing -r,
even if the two (0x100 and 0x200) event bits used for most
three-digit AMD events are being masked.

Shall we just add an AMD-specific real-world 0xE0000UUEE example
to the {stat,record} documentation to clear the mud?

Thanks,

Kim
