Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2860EC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 07:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1026E61269
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 07:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243448AbhKRHbs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:31:48 -0500
Received: from mail-bn8nam11on2084.outbound.protection.outlook.com ([40.107.236.84]:7777
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242809AbhKRHbr (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Nov 2021 02:31:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgJJTj6dS85gVxUNZXVC9BPMWlT5KSVENKqSsYL9eu9VR0d0M7xLWM/zJk+KaJ2thEc7sL6M8f28YpbHr6DJxUpnljYRVrdcRHq4+rgmIYULzU+tP3OiKRODEEJ9gb4yGUkmUnOSEu8qG01yhm10OnqlYw1ioa225df4Vl6KUr/QKdHcMqY2hwj7Ib9JlRruund8ReacN1vsNJI6OoVizKTP1V18z9g41LM7xiA0nVymMNL87QNVGYa7e6QOKV5zbIO5WsDgIYYqe2e2Yth589gq1x0HPOKAmXgesbQ13TluH47J43ABW7ZSWEEkekEL/V/vTcAjYnnsYZoEVgL7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuXi8ZvOF14qh4JABDD1Ct8spkACfiIZ9UAKzq196uU=;
 b=GxhPfr6Uj+mVUlMxxvtCS8ppl+b1ZUHN4bQqoq41E6N9JH6F2K2Er9HxlxMREZb2qnTcWwjTFhl/Il561JvKx7/uhV3+Kmz7wVCP/t5cA68pXQrOgdCtq01tgYWQqGCaYbhKKDed0bPY+WDiRbZc2gnYBRbSiZTJbEx3n+O01+ceQ6ERx+RmwAsuwN/xMkHfSWm+wok2NPYSx8FqW4CiyGMe52dhpHqdWz3yZ/uL5L9U49GfprtRmxeO3dCljv3ebgsp4SIxcbQxfD+SD8WohRqvsuttuxpC/A9nU9CqjujKRWgJ/AvyCyC6iifSFOa7lxu8XYVEBvE20SSHI1G9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuXi8ZvOF14qh4JABDD1Ct8spkACfiIZ9UAKzq196uU=;
 b=s0vwdVOp7vwQQk8MWy5nauVoF93+XVBDBHBZ0yk69PtU8Yg9+UOW3OmWHn0npZ3V2E4hhysuYvevwMP+iVf5eBsmsFYjb7c8hNOM/Igb4FK3Xu//HG39YJfocS/1hgxYIPF4zmNRqJCf2e1+DOhLJAD01Y7Q/e1gFK4pJNaaJzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB4788.namprd12.prod.outlook.com (2603:10b6:408:a3::19)
 by BN6PR12MB1234.namprd12.prod.outlook.com (2603:10b6:404:1b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 07:28:45 +0000
Received: from BN8PR12MB4788.namprd12.prod.outlook.com
 ([fe80::9037:903e:25fd:51cb]) by BN8PR12MB4788.namprd12.prod.outlook.com
 ([fe80::9037:903e:25fd:51cb%5]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 07:28:45 +0000
Message-ID: <783c4cbc-667c-b6d0-fb05-5250e444d9b2@amd.com>
Date:   Thu, 18 Nov 2021 12:58:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH] tools/perf/x86: Use alternative format for AMD raw
 events
Content-Language: en-CA
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     ravi.bangoria@amd.com, ananth.narayan@amd.com, rrichter@amd.com,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        kajoljain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
        acme@kernel.org
References: <20211111125646.581021-1-sandipan.das@amd.com>
 <YZE8SDkzq0OMcmhS@krava> <9dc5cb10-2faf-a17b-ad4b-a22dbe688209@amd.com>
 <bdbd0a4b-6221-ed90-0882-47248112ed3d@linux.ibm.com>
 <301c0693-f982-1769-6e3f-8b77a4201a69@amd.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <301c0693-f982-1769-6e3f-8b77a4201a69@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::33) To BN8PR12MB4788.namprd12.prod.outlook.com
 (2603:10b6:408:a3::19)
MIME-Version: 1.0
Received: from [172.31.153.141] (165.204.158.249) by BM1PR0101CA0071.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 07:28:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dafd9b8c-abfb-467c-955a-08d9aa650da7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1234:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1234D0743F42436183A61E848B9B9@BN6PR12MB1234.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24ar3IT/WfmqLrAI7IMshN5kkxqCwn1UBfjQo/l0qkZfZoBM2V7E3JL50me0Wpk3oumYWT6Mg9h6I0rUzg2wS2xDq/lf7w1PAtsfaclGJLJhN3zIdwoUPhWPWvqJylPcEQYHd4XuXIrc/wtbBeQ3BX8nSGNDAAhJt3HXyfZhzRmzGUNdVwcyKudH3/VL446SkldHsCNU+ksARTHyNKmujMys1wyYeWidhahcqUmCqVZxJ7ZnfsWCnmdfazHGT1cBiLYMdqcfJykk17A++11ynbjcFpfXGcZxI75P/hVGq7k5M4in8XDzp2aPndfyI6K+egj+PneRD6R6vAjZ8kxfeVmAQOH6MzXOCAetg1SClyOS2mQmHFw4sMSzRWmrkNZdKr8yM6IIIIm2DFbdPWS+UioE8VVqcj0My1Ps550lURT9PQbHOrsNKQz7gO2gUG8j+FSrh7nrF+Cc7AJ5PNFg6lACniXlqaFyB6L7+ToO23CosjwsPIfgh5ONO8YWMlV/OibQ9c5jHATo5jZLiMFzAMimzNl6c5QnlwNQEPH2xo2PWn2PJ9cPfVGhtsEs2ZA4lPERX7SSpUUTiRv9T31oebYAHqoDujZEBi6zspLMRmGDZ6CxbQH2LrlFg+w0xEIGcl59uZk/nfXvIW8GUNYXxNyTmqJFEtOj3+d+Gwhjc5U9q2OtOOB/272WDvv1EIjNUdxHR4OfdjlOVLpvQ2AUyvTwTm5Bj7xt/hZvMX6+MRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4788.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(16576012)(8936002)(38100700002)(4326008)(316002)(2906002)(508600001)(36756003)(37006003)(6862004)(86362001)(54906003)(6486002)(26005)(31686004)(83380400001)(44832011)(186003)(66476007)(53546011)(66556008)(8676002)(6636002)(66946007)(956004)(31696002)(5660300002)(6666004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDdkcXp2VFdnRXVGVytlcHV4MXN4UHVIV09JREZ0WHdLTm5KeGdhbDAxTzQv?=
 =?utf-8?B?aVlNMlVKa2FRbnI2QUZKOG5yU0FJZllqQU9WWGlGRGNXYXJyblVtYXI4MDRW?=
 =?utf-8?B?UnRuQUZMM1hzaVpIRGdCU2Z6MzRGMUxxMjQ2Z05IL1lsa0gxeHFJQ0xrT1RU?=
 =?utf-8?B?RThObGNWQ2VWR21wQlA0U2pEbHZuVlY5aHFCSVhhaVZwU2dqbG9tRmxlRmdw?=
 =?utf-8?B?Tk5rMzZYWjNPOU9VbzhyNUZmYjZZdnBDZVh2cHJ0Mms4WnJMdFVKSkxUVGdC?=
 =?utf-8?B?SllKZ1ZWM0VwMzhUbVBPWG9Bb1pMNGUrV0lHL2N5eWxtajlzS1hFcFAxNXBD?=
 =?utf-8?B?cGsxNW0yMEJNK1lwQS9uRlcySXo5dWx5Y0RTc3RJR2p5SUE2aHZXU3hreHFj?=
 =?utf-8?B?aERBbjB5cHRucFExNmhCTzhxcXpqMEhKSy9DSUZQTGs5Q0hKb0JkLzdTbGkr?=
 =?utf-8?B?RG9HK3puWWxvYjA5OFZxTG5wMm45N0JpZkZuLzFwRUZOcXVKSU15cVRRVzY3?=
 =?utf-8?B?aVdLaDdWa0tpWk1sNUNvb1Z4cUdrMEVHZ2hwMXY0TnNoa1NVVHdBKzJ5RkN2?=
 =?utf-8?B?eDhCV2VJUjM3Mld3ZnI1K0s0czBzRVlnNEFWTFZoV3gyT0VSNFlFNjYzMTla?=
 =?utf-8?B?cWpITGJmK295NWZuNDI2RVJLaU84QmdHVUhJaWZRWHZUeEM1WnVoV0dMenhW?=
 =?utf-8?B?L04yVGN6UmhzN3JHNnFlU0VLQXJZUjVNaWhoMDBmSDFrNnp3SWMwZXB0N3JD?=
 =?utf-8?B?M2lmVGpZYnRBQmVZeFFETWRHSnJNeVJzTkp6SUpoMWdMaGx6MnBsUHBTV3ZK?=
 =?utf-8?B?dUhub3JlV0w0WG1PSEx1RkJHRUJybDFBYTA5SFlOZXRhMnd5M3g5YWduTitp?=
 =?utf-8?B?Ri9UWFh5TWo2VnFIRy94VnNtOHRZb01GY1N1VlEyNWNlNUVCNmNwTHQ2YjZh?=
 =?utf-8?B?ejJYcytBcTJYSy9SOVR3VkVUUGNmWSt4U1JiWnJ6WXpzT3kycUR1RGxGVE9R?=
 =?utf-8?B?Ui9XMHd0azJvdzgyUWQzMXpSdkVLSGRaQVhpOTFIa2NKK1RTYUFQWlM1VjNY?=
 =?utf-8?B?eDBrMXZuUVhhajE0Qk4wS2VrMGt0V0ZTY2JhUTRlUGJOMkg4alFLOUt4QWdF?=
 =?utf-8?B?ZTNraTU2c0E5c3pKcHJjTEhPTHowUk9YYVNxblEzc1ViQ1ZIbG5pZG1zWHpu?=
 =?utf-8?B?dWdIeDVUTlhZT0R0K09XTnpFdXhLWTkrR3I3aTdMTC95RTA5V2NTMmd4UFQr?=
 =?utf-8?B?M2hlT3dnQkxvd0sxNGh4RHNmWElhVGxXVkZjU1RXeXhVcmY3RVZnbk53WGd5?=
 =?utf-8?B?TTNqRGF4eVJ0d0wvUXJmK25nOEZ4MVphSngrQTZQMDBwY1QvTUV4TTFFT3h3?=
 =?utf-8?B?VzNpK0wya0JSUS8reVVLWmFWa21xVVRKMGwyNlRGeDdySXNKaTRLNmNiRTdE?=
 =?utf-8?B?bktBaU94SHVhOUgxSG5jMHJ2NEVuYk1pQ0IwQnlpRjh1NlkzM2kySk5LMUxT?=
 =?utf-8?B?bzF6bGJyQmVGMFlGZlNqRmttSWdTOVpuWmpBWk9aWmVUQ0lSTWUyMmtEK3ZF?=
 =?utf-8?B?TWVtRnZ2SFhEaDRLWjFLZVQzWk96OWg1d2xCUmwwL3BmeTVQVVFlcGJQOGtw?=
 =?utf-8?B?OVArNkZFci9kaldOb2IzMkxLaklFYUhKRHNlK3VIdVZ5cGN0emNQSnhMbUIr?=
 =?utf-8?B?ZnBHbVZTU1ZUU2NOKy9icy9TSWlrRkFPL2N5SW91S2ZPMzRyZ3lQNjIvNDAz?=
 =?utf-8?B?cHBCMjBOSUE1b3BUVWZabzNwTy9hdTZkUWxiVCtydmRocUUrTnl1em1ZNHdT?=
 =?utf-8?B?aFA5OEd1M1I4eTJodWk0WFc1MzM1V0dqV2E3eXUxN3IwVlovVFNFQ3NrU2FL?=
 =?utf-8?B?RmR6MUlEWHVLZVJob0F0N2Nkb1lPTDJZbytqWDY4M2Myam5vMHNDN1puUEVU?=
 =?utf-8?B?UXdNMUpuRHlSVFdqZCtTM0dialErYVo5d3l5TVRBQ01JUlNoV0Q1WXhUSjhr?=
 =?utf-8?B?OEdoZHJ3aitlUUxSWjNUV1JrWHNneUVsbGl4cms2bWFGeWw3M2Q3QUZhNTkz?=
 =?utf-8?B?aHJwV0RnU3hrK1lZNkR5S3lXMXd0VEoyT3RVbjd4U29IOGIrK3RZYWtCb2Vz?=
 =?utf-8?B?NWd5OGZJT1prZUMyNUNSeUV5NlVLVjhPSytUdUhpL21mY1ByTkhOeHZPZEJV?=
 =?utf-8?Q?jfdjA8s2tsB7Eoh82d5LC6s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafd9b8c-abfb-467c-955a-08d9aa650da7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 07:28:45.1049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xc7QOROety482++8/kfTAKn0FF4fawy5dVsRSM47kk4d9u8FkRgsF4eTBy7gAA6oXZMGZS0XIs5hXPS/QtI7vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1234
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 11/16/2021 9:31 PM, Kim Phillips wrote:
> On 11/15/21 10:38 PM, kajoljain wrote:
>> On 11/15/21 3:28 PM, Sandipan Das wrote:
>>>
>>> On 11/14/2021 10:11 PM, Jiri Olsa wrote:
>>>> good question.. I see raw events as a way to put to config whatever
>>>> the user wants and IMO adding changes/quirks that silently changes
>>>> config could create confusion and angry users ;-)
>>>>
>>
>> I agree, making quirks in config will only going to confuse users as
>> It's against the encodings we had in
>> /sys/bus/event_source/devices/<pmu>/format/*
>>
>>>> I'd think that if user is composing/using raw events then using
>>>> directly r100001f8e is not such a big deal?
>>>>
>>>
>>> Sure. Some of the confusion may be due to the fact that the man pages
>>> for perf-{stat,record,top} state that raw events are "eventsel+umask".
>>> While that is technically true, it does not describe the encoding
>>> scheme (/sys/bus/event_source/devices/<pmu>/format/*)
>>>
>>> Would another option be to update the man pages with a reference to
>>> these sysfs files when describing raw events?
>>>
>>> Something like:
>>>
>>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>>> index 2d7df8703cf2..5dfdfeba594b 100644
>>> --- a/tools/perf/Documentation/perf-record.txt
>>> +++ b/tools/perf/Documentation/perf-record.txt
>>> @@ -30,8 +30,10 @@ OPTIONS
>>>
>>>           - a symbolic event name        (use 'perf list' to list all events)
>>>
>>> -        - a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
>>> -         hexadecimal event descriptor.
>>> +        - a raw PMU event (eventsel+umask) in the form of rN..NN where N..NN
>>> +          is a hexadecimal value representing the raw encoding with the layout
>>> +          of the corresponding event control register as defined by entries in
>>> +          /sys/bus/event_sources/devices/<pmu>/format/*
>>
>> Do we need to specify (eventsel+umask) in the raw event description? As
>> the format/fields totally depend on PMU and umask name convention is
>> specific to one arch.
>>
>> Can we just update it to:
>>
>> - a raw PMU event in the form of rNNN where NNN is a hexadecimal value
>> representing the raw encoding, with the layout of the corresponding
>> event control register as defined by entries in
>> /sys/bus/event_sources/devices/<pmu>/format/*
> 
> The r notation is for the cpu pmu only.
> 
> The triple-digit 'NNN' is what's most misleading for 12-bit
> event implementation users, such as AMD's core PMUs.  It
> tells users 'see your processor's documentation's triple-
> hex-digit PMCx18e event?  All you need to do is make that
> "-e r18e" on the perf stat/record command line.
> 
> So all notions of what size of parameter 'r' takes, esp. 'NNN'
> should be removed IMO.  Perhaps an AMD/12-bit-specific
> example can be provided.
> 
> I had thought that the shorthand command line r spec alone
> could be modified to be smarter and more accommodating
> for conventional rUUEE users migrating to AMD/12-bit,
> which AFAICT is not what this patch does.  I think it
> modifies even the  cpu/config=0xNNNNN/ specification,
> which, granted, is bad.
> 

Sorry I didn't know that events could be programmed with "config=...".
Thanks for pointing that out. For basic '-e r...' usage, modifying
parse_events_add_numeric() and leaving parse_events_add_pmu() as is
should take care of it.

I thought about using the same fixup for the pmu format i.e. cpu/r0xNNNNN/
but as you rightly mentioned, it breaks when using cpu/config=0xNNNNN/.


- Sandipan
