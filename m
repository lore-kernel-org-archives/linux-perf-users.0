Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC775C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 16:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C95163219
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 16:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbhKPQEa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 Nov 2021 11:04:30 -0500
Received: from mail-bn1nam07on2087.outbound.protection.outlook.com ([40.107.212.87]:53636
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238635AbhKPQEX (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Nov 2021 11:04:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghcV6fX0OqqKrFqUDBS1lp+J3u3nja5I9Tq2ddZ3o4yMD939I5KzmC61manbHiHUqRsfZKzgxX7F8A0YzJPjXbC3HG88MzZ6N0iPsjp0GeZQusfuBK0nubZcdTB87RxE/7vXYQG+Ep54uzzlWBDNJ/9Y/8igoeumlwm2DmET3qicdgHJ1iBEzmaiLmZPjxwXflAN1RgSK00UW5joOs2QVsEPaR6mahfUFDqjEgeS1dS/kVozpdvU1ym7h+EdptJMEDuu+JlJCwieG36b2d1lrMbOQSRUy/2CHwnmdUDODineRZVKft34jMLjiXMMo64le6I/WWQVVzqpBbTgu6r4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVNjACHGUX/DqpNzxCRd3S83mjiHbmYqg5eKV3SCkY0=;
 b=JeQDTOVHuiciH5rlN5c353aUimCF8JZgiPIJ30aaCGFf7D904pTCJVk11xIgmLirFnFs66NnGbC3OMwVfLNtV4xsK09VW7rkutyLPvb6cXnE3YHmdxi3rUXTcdNi92N/y6fxnJluR3xy2Vga8+eolSq27ueZwVBrmKGBxc+rV1sgQh80IwXFh6IlpYHCuGuYWYIHIKYuqZJpSYlQBbg8KnH0m+2e5Ws+d+gh5octuIdCE+1PDdF82RkUrp5pULqvy+xKZ6jnhUV8+Kr3778fKuknrkGWY52BmMx/7AAleby6qPtulGOjrsoP6MGgaNK3/jbrMiOTPv76kB97KVoNYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVNjACHGUX/DqpNzxCRd3S83mjiHbmYqg5eKV3SCkY0=;
 b=X10ujXAAe/tNm6QBewXL8v/pMK0QIgl24NtGrzehvzRdQEAH7x+W8w6NADHQpZXrQ4J2piNsqtjY3CItfhNeVJdozBns27QthL4SEpWVxhu+j2AvM4YKBmY+Invp6cB35/7uG4cXugZahaWjXNyYj4rlbPJnSP5aKJjNoWqLhsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN6PR12MB1715.namprd12.prod.outlook.com (2603:10b6:404:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 16:01:23 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 16:01:23 +0000
Message-ID: <301c0693-f982-1769-6e3f-8b77a4201a69@amd.com>
Date:   Tue, 16 Nov 2021 10:01:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH] tools/perf/x86: Use alternative format for AMD raw
 events
Content-Language: en-US
To:     kajoljain <kjain@linux.ibm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Jiri Olsa <jolsa@redhat.com>, acme@kernel.org
Cc:     ravi.bangoria@amd.com, ananth.narayan@amd.com, rrichter@amd.com,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
References: <20211111125646.581021-1-sandipan.das@amd.com>
 <YZE8SDkzq0OMcmhS@krava> <9dc5cb10-2faf-a17b-ad4b-a22dbe688209@amd.com>
 <bdbd0a4b-6221-ed90-0882-47248112ed3d@linux.ibm.com>
From:   Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <bdbd0a4b-6221-ed90-0882-47248112ed3d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:208:32e::28) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [10.236.30.70] (165.204.77.1) by BLAPR03CA0143.namprd03.prod.outlook.com (2603:10b6:208:32e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend Transport; Tue, 16 Nov 2021 16:01:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6bdab48-b8ea-477d-a48a-08d9a91a5603
X-MS-TrafficTypeDiagnostic: BN6PR12MB1715:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1715EDEBB0C449D06E19010E87999@BN6PR12MB1715.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qDO6uXGtLnz8r7hkKeGFNxcThmI0P3NeW0TRS1W7e9eEkqwdn7omI7ovO+JEyBXrjlRT8/c/qBBGdCRERYtpCpsbw6YGG+jN8rsRWw+d0PPzRwFIRarpDnYyII9wHjxz25hzHrnN1mTgW95VWXu+Ub3dMPsWKliMYGevrRgwZOW4T2G5i7dT8L+H3WDp5/tYTuxrX/yS72mlnzjLZYKAgu7Ovibw4Aff/xqRmjtNdl/3W9JAftPg8gP0VWoxeUgY1x/8vWuv+BJ+qrlpNGnSUyAkgPi92UdGr5n29FuEtBEQKnrJjLzDAiJw8Y6GEZ3qAlsW1RcRJxR4bq+DAe+sZfj5GGR/9kYumAZJEKnlLNhhGSIDqwwl6GFv13GYZxMlUl5iEkTyt+HvH+punjknl9N5/2cbF3lRTjRiDv3HDhCIKIkzYR/EjwS8K8KcspaH33amp7+EZGH1f8fOd2lagJ3zza/z+5qCt9dUS1zhWJYo1cP7U0t0dQeChwTZWkXb6E12y8a+Ikruff/ZYP38A1FG/Vf5WOUwDhz2mzCO+U2Hd356K1mZgUtkPeeQTlyl5SmU74cro647Lmbf+TUFDKDxNVs81VtsdkcpoilMESynIVlAol4KJB+VvMI23IRvUiCVzXEnY/L2a1VIvykktFUN5UXgxsmDwlnoeNQsXCWE3FU4dx0W2y+K4WnIzkCCDrmAKOvajgqz9VPUSYsDMAJlkFuwqY5AWAhy8sdqwg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(36756003)(31696002)(66946007)(44832011)(6486002)(2616005)(66556008)(26005)(66476007)(956004)(508600001)(83380400001)(2906002)(316002)(38100700002)(16576012)(110136005)(8676002)(186003)(53546011)(4326008)(8936002)(86362001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUMvSmE1eDdXZ2pUK1E4b2I4NEN5am00M3lid0Fad1Q5ZHVUWWZraTk2TTlu?=
 =?utf-8?B?V3RNemlhWmZJNXpiZHpVdytQa08rbThiSmlkN0xlWkhVNFNSeEo1dDdaSWNU?=
 =?utf-8?B?eUM0SkFMUjBBaU9wOVpuMHQrTkY3aFVOMGVNSHpIMjhYdEtRZFVRMXNhWDZ2?=
 =?utf-8?B?NkVQKzdUdWlwd1FBaXJwaTk0VWZaUDEzajdwWXphZW5lR0lacklrbDJhVlVh?=
 =?utf-8?B?NVNaREVvcXJUVFJXWlBDdWVBOWZmUXpIanFKMTZMWDlpRlpncnNKZHJ3UkpQ?=
 =?utf-8?B?TllPZHh5dXFiNHViNEIrWW56ZnBtZWQxMFV1R0djTWZzVUQ5QkVQbXBaclp1?=
 =?utf-8?B?L0Jvbm9wQjQ2a3NueWh4NDA2eUMwQSt5M3RwZHFaQ2NiU1lTOFA0ZVNxS3pl?=
 =?utf-8?B?ZmE1K2V1M29CdXdidXZ5QlF0ZllLV1ZxN2dicG1SNDJTVXBMNndPOEJ1OXVS?=
 =?utf-8?B?QjBTdE95b3c4WXN6L0dGMlVCSG9WWkxPVytQM3ZpQVhFZ2c3R3k1ZW1WN0hu?=
 =?utf-8?B?bnZEU01vZGdnK3JqNHVreng3K2s0YUc4ZkpEL0tQYWQ2LytGNnhxK2dDL0d5?=
 =?utf-8?B?RSt1NEdBTlo4T1k3bHlHb2JndFN4bW5XMXJYRkkzNFRIV2pMN2tCMVBrZW53?=
 =?utf-8?B?V3F6dGd1ZmU1aytPSU82NFphNUVxSkxWWmtoRldUYW9lNEM0VFROeDF6TG0z?=
 =?utf-8?B?SGlFTVQvVmxRd2Q0OEU2NTZUN2tzWlN2THp6MXdRRHVYRG9ieklXVENCbUtp?=
 =?utf-8?B?RkUybHMxTU1GZ2tEcnowUEFPRnJ5Y2NzTFVucU1Cc2dTbjJPbk9vd2lQS2lQ?=
 =?utf-8?B?b3lNb1Jkb1JmVjFBd3NBTldScHBBNWwxRlQ4dm5mUE1xZEpvejJ6NGJQN0w1?=
 =?utf-8?B?Nk9HMXhrQ1VUY0VxR1dpNmU2YU1ycnRpdDVONEtmRVo3M0gvZE1JNHFzdFdj?=
 =?utf-8?B?cVM2VTJ4MVRMdWx6RjUwUzUwaTJSaldjNGtaOUVjcFc3alAvak9zS0liK3VK?=
 =?utf-8?B?d0lPMjh6eW9oa0dycVNMcVp0dUVKMEN1NTR6bDBQUmYwbVhUQjdiTWxUL2Fp?=
 =?utf-8?B?SjBOMlRhNk92ZEtsVS9oR3hyTmhBdGNYcDVBVjJ2VkdDcUpxejMyM3hoU2gz?=
 =?utf-8?B?T2lVWXR2R1hIK0RweCtOOEwzTzZEMkhFWVYrUUplY01KTHFVLzBwTWtLRXZj?=
 =?utf-8?B?QUw0bGJRL0tBWTkrNjVCTHcxamhZMGZteHhnZ1lTZ0VoUm5ndHZyOEN4MitR?=
 =?utf-8?B?VW5paE1WNVBYL2cwY09mYTFjcFVvVC9qTFpqOGI2WVFBMXYvT3ZZU3ZQOVd6?=
 =?utf-8?B?bzZIak9Db2x4VUdzRW5NNWdSMC9WUzZ5bXd5SWllRTJMeFA4Tk9KVGJxQlM2?=
 =?utf-8?B?RExTNzUzUHNrc3cxNExaYXVFc0RtOUNQc2tCUER5dEt0SzZraDFnVWxxNmp5?=
 =?utf-8?B?RGxkdlBJbTd5NWRVUGpkdHdYNHdLZ3NVcXdjNG5wc3NSVGNYaURhMTV6alJ6?=
 =?utf-8?B?RmhrRTZ0NFB5bkxKd1hIaGpUY1JNTlU1WW9kamt1T2QwelRVWmtLMHc2NFhK?=
 =?utf-8?B?OWY3S2tZRkRUL0J3MWh6U3VPRlFJdmJPZkpKVG1URUtEUUJHd1JtOHlFd2Vm?=
 =?utf-8?B?c2JqTjh1c2VMM0JHdzB0LzZ5WTMrYjJLcVo5R0RkYnZiMmIzR3ViQnpzTmgz?=
 =?utf-8?B?YW1Yazdlek5Ua2RSdFVXbFZicEdIaS8wdDlHMW14RTJ6NVFUTER2V2xjbTFQ?=
 =?utf-8?B?V3dIVWsyUkF6Z3V1TURkSXlpRDFrTmRRZStpejBLR3BOblBEdjdCMXEwczVE?=
 =?utf-8?B?TFZ2TUlLaDJEUi85ODRHeDRsTDBjZERxZVJpL2srK0pxNEtWN09XT2xUMHBm?=
 =?utf-8?B?alNEazlCZElmRmU2RWNlb2F5dmtpUFE2V3N6S1dLczkxMmlOT3hiblNJdmJG?=
 =?utf-8?B?Y1NvOVpSZVlhcko2YXBnVkNEQ0p1d3J6bkFUcmoxTXBaaVBucnd6R3NyQmNh?=
 =?utf-8?B?NW90Rm9NN1NxTUVBR3AzdkEzeXVwM0xtUWNEUDJqYVZNMStRY3FUOTAwMVBL?=
 =?utf-8?B?ZEQveXNWZFc3U0VHZWxjYlg0Lzd1b2NHTkdBbFhTL0p5d3dHanZYWVYzdEsz?=
 =?utf-8?B?ZmtQZjV2bU81MXhKNStCZkd0MFVyVzVFTkIrQ1orZ2UwY2k0WUNTU1NSeU5z?=
 =?utf-8?Q?ik5hpQpOE4QwSTwE+n1+r5I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bdab48-b8ea-477d-a48a-08d9a91a5603
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 16:01:22.8488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVBzmVqHCzwCA6kjp5pgmb1Me1U42UB0GLLxtatAGzet0Zq+AVW/nafKxyBe4CayG5UjPTyBrXRK9sChLCsprA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1715
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/15/21 10:38 PM, kajoljain wrote:
> On 11/15/21 3:28 PM, Sandipan Das wrote:
>>
>> On 11/14/2021 10:11 PM, Jiri Olsa wrote:
>>> good question.. I see raw events as a way to put to config whatever
>>> the user wants and IMO adding changes/quirks that silently changes
>>> config could create confusion and angry users ;-)
>>>
> 
> I agree, making quirks in config will only going to confuse users as
> It's against the encodings we had in
> /sys/bus/event_source/devices/<pmu>/format/*
> 
>>> I'd think that if user is composing/using raw events then using
>>> directly r100001f8e is not such a big deal?
>>>
>>
>> Sure. Some of the confusion may be due to the fact that the man pages
>> for perf-{stat,record,top} state that raw events are "eventsel+umask".
>> While that is technically true, it does not describe the encoding
>> scheme (/sys/bus/event_source/devices/<pmu>/format/*)
>>
>> Would another option be to update the man pages with a reference to
>> these sysfs files when describing raw events?
>>
>> Something like:
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index 2d7df8703cf2..5dfdfeba594b 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -30,8 +30,10 @@ OPTIONS
>>
>>           - a symbolic event name        (use 'perf list' to list all events)
>>
>> -        - a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
>> -         hexadecimal event descriptor.
>> +        - a raw PMU event (eventsel+umask) in the form of rN..NN where N..NN
>> +          is a hexadecimal value representing the raw encoding with the layout
>> +          of the corresponding event control register as defined by entries in
>> +          /sys/bus/event_sources/devices/<pmu>/format/*
> 
> Do we need to specify (eventsel+umask) in the raw event description? As
> the format/fields totally depend on PMU and umask name convention is
> specific to one arch.
> 
> Can we just update it to:
> 
> - a raw PMU event in the form of rNNN where NNN is a hexadecimal value
> representing the raw encoding, with the layout of the corresponding
> event control register as defined by entries in
> /sys/bus/event_sources/devices/<pmu>/format/*

The r notation is for the cpu pmu only.

The triple-digit 'NNN' is what's most misleading for 12-bit
event implementation users, such as AMD's core PMUs.  It
tells users 'see your processor's documentation's triple-
hex-digit PMCx18e event?  All you need to do is make that
"-e r18e" on the perf stat/record command line.

So all notions of what size of parameter 'r' takes, esp. 'NNN'
should be removed IMO.  Perhaps an AMD/12-bit-specific
example can be provided.

I had thought that the shorthand command line r spec alone
could be modified to be smarter and more accommodating
for conventional rUUEE users migrating to AMD/12-bit,
which AFAICT is not what this patch does.  I think it
modifies even the  cpu/config=0xNNNNN/ specification,
which, granted, is bad.

Thanks,

Kim
