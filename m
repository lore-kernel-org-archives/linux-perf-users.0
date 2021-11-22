Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B7EC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Nov 2021 16:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbhKVQy5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:54:57 -0500
Received: from mail-mw2nam08on2048.outbound.protection.outlook.com ([40.107.101.48]:58753
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238381AbhKVQy4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Nov 2021 11:54:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VP0tC7WH9bKKFSLLAyeGt84Vw+qfd0nXxP87drheD4pV91FH3W0dx7J8TMSBmgQ4AzmbenJi0WidYdvRF9TLc20K17aYK/I4kLEEv8nW2lXVDg4leWHZZU3fzODxLjpQZ02xlajgA7oi+cbDpnDR8ANAZVQrHLv0DWdlGmF6QYGrPWyPJBdjnaPQO8mbU0ss4wEzNizEo2QBbzJFR0AZZvzb1nOx2xIrhBSh/czj23tr37n17axIKFFUCVrXEh4Z5uWdBKn3T6m4YBee8uKUgBCI9nhEJluJ5tCwQrsFd1aKeqNS7R8OOAJIb+ufd1NZ+cpmIB49u/AtYuHPwzNgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saTaZBKDUI90E0aKl5OuZBl8G2Ae45FkiSuxc0uyqBg=;
 b=B7Ev6pZLFxcYnvEq0xTrsmzNBsRxpfC8aaXqMFqlYwlbb0/DnC3zm8bhQcoT/jVGv96CnhU0xoXPNA55Ov9jQiV+mIvOu/8emLS/qD5dGVpbpDFTnenM4CGMiepvUu/eI3ct9KkE0iT8Qlyd4rZwnN1w+thhOB4xwPQy1IhI3Fcfmn9TfwnZ5lVbkZnlvBYDdDLY5RHiVIJA0lpRLryM1cDMRTZCDFSc5drVjlapOOlPRFKW/Jl/DtzQkTj7hHGruMY5OM0cQnE7MUAyHKtxDu8AaMigAxVpZT+YAURIJz3pqLWB7Zx6C8PhPWTifM6h9c9XYlecY1e+rmcVcj7OOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saTaZBKDUI90E0aKl5OuZBl8G2Ae45FkiSuxc0uyqBg=;
 b=h+9dgI6FcdQq7SEY9KsJ+vUOENDpOuRA0x0OOn5BdKaUld2ZHub67SpOikawHwHRgWmiW3BnKGyIj155jX1mRYaK0/n+cXPeOTe80h6UYcvZ/i4xVBJxXklEZINx6xjUnc5crfMp2FqIKeTXeMAJ18NaWsEOcIlXoTe/mhMF5wM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN6PR1201MB2497.namprd12.prod.outlook.com (2603:10b6:404:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Mon, 22 Nov
 2021 16:51:48 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 16:51:48 +0000
Message-ID: <8fde297d-880f-c13d-b42c-be9f554ccb20@amd.com>
Date:   Mon, 22 Nov 2021 10:51:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/2] perf/docs: Add info on AMD raw event encoding
Content-Language: en-US
To:     Sandipan Das <sandipan.das@amd.com>, acme@kernel.org
Cc:     santosh.shukla@amd.com, ravi.bangoria@amd.com,
        ananth.narayan@amd.com, rrichter@amd.com,
        linux-perf-users@vger.kernel.org, jolsa@redhat.com,
        kjain@linux.ibm.com
References: <20211119111234.170726-1-sandipan.das@amd.com>
From:   Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20211119111234.170726-1-sandipan.das@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:207:3c::34) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [10.236.30.70] (165.204.77.1) by BL0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:207:3c::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Mon, 22 Nov 2021 16:51:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3388e636-5d3d-46e5-7c6e-08d9add85fba
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2497:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB249723ED3CDA974CBA12B160879F9@BN6PR1201MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2OCSu0u4xPiagoe/prYJ+qnzqObgciI5OVp2KeY5xr9WDhLjjt3fSQdvI774Riui7wh5+0hu/i8EUFGx2hu+dCwgQQyIA7v711Rh4k9q6mbFp14cCfS3AXNdDcuIBT7Fskl+l4WWKVfjarcrXmCV4GFGMUgNGV/9rXdiLBAiM4uB1adpyZr/08VN2PC3J/ZcoWW2rX/oMTRSJhVIa0+CD5KFvR1z0Xq2+EeDQtqOAKLhLRxWnGUzK9uvAPKY0/VWgH27cEl5A9zHdteag0ryft8sIadZElWqPQU1uA38ZYt/KT5HUmROWKLdc8MQe1bFyI8LzH49uw0PVHy3TXGpOiGTUWBd4ToFEISnKpl+UhSf9YvjN8KtSu4MzroMLi+jGmAYTVa8jn3WBmTjrdF8nm4FdftM7jQQ3NgH6os6DwX8T2dwQ1Uxx8oitpQ+1aL9jv/qeezrPOL2MxmiTWb8/36whseGes2if6Qo2cyiwArzHgOWH7wqm9acmV8j4ZkYXrMJoxMFbOEOTn70VGPLEc7JVguFx/RadiDKgxNg4M3rSVtyRQ/etfacqm+lBULuiEpFto+zZ8XdTVAaQ/4ZBSm8TiA9KF2aPop0wC3aD+Am8uMSSfFD6pY3vuDgBwhz+uIDchVVP4EQjdEF7h92R0+54LeddCO0obDbFgnU29z5Kkf9k6g+aqPjL3YXEsAo0wciBvEJfL/lhX30l9hrt+MAQZjwdKzt1QjYmZtJS7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(2616005)(956004)(86362001)(16576012)(6666004)(66476007)(31696002)(44832011)(8936002)(66556008)(186003)(53546011)(4326008)(2906002)(5660300002)(66946007)(38100700002)(508600001)(36756003)(6486002)(8676002)(83380400001)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDFtdHE2aWw2czkxdHhkSkxRS1liMnAvYjBRaWhBQlJ1LzJyaVRsWUFaZUVy?=
 =?utf-8?B?dTN3Q3JtVENYc2U0R2tJTGJOMGZ1VmlZQXRCdDM2dDdNWnVSUi9wZEpSeDJv?=
 =?utf-8?B?UnhFZzVmTmZFOFNNY3IrcGZPUTZiQW9teWYwaGlnSkJxbVdDbzByYUgrQWlk?=
 =?utf-8?B?bjYzblFZMzNEMVlSSmltSk0vVHhFWEV2YnFwV05NcHY0dGh1VUt4RjdDOS9p?=
 =?utf-8?B?VXJxQXZnRlpRY0lNRjJEMWJwY0t2dWp2UWQrL25oOWVkckp5YXhtMDRKK1Nv?=
 =?utf-8?B?YWtJdXRoc0hBTXpORTVxZHJ0QmlXb2FsZ0lvUnBubWtYVVozRGVFMjVjRFlF?=
 =?utf-8?B?UXROdUtJVnVQRThvbzNsSmEvVS9VTHhrTXhuVVhsQkUyam5BYVU0NDNIMnBP?=
 =?utf-8?B?dEJKMWxsVUoyUXZPUXNMVXpEemJ5SEhpRmo4L25kMzBiNmdVYW1WU05DODJX?=
 =?utf-8?B?Z0FteEVyNVpud21ncU9OT0VLaS9ucXZYM003cmIwb2l2SnlwYlJyc1RheE1H?=
 =?utf-8?B?YW5hNGs0L1VwcDc1WG5wWDkvWVlWTGQ0OVZNVVZ3clZUV2dnWm55UU50WGFJ?=
 =?utf-8?B?MitXQ0ZqM20wOXI3UzdRUmhwTzV4dndQT2puK2ZSdkZIUktQMnNOVDMrSHc3?=
 =?utf-8?B?dXVJZThTQnZUN0JRQXphbXluNHlQNS9iMkV0QTJjdERaR0xodEZtbFRWb21o?=
 =?utf-8?B?MHlhWDd2akpnczlSNGlIZVBjK1BuUGl4ZW9DbjVvTnlHWkhDS05qa1VqbytN?=
 =?utf-8?B?SDBCS1hLWEQ4YzNmWVhiTzVqczczM0Y3RFpJZndaeS9LM0xPb1Q5QW9WL1pZ?=
 =?utf-8?B?VGJsS0NjZzhzeHdHOUkvWU5wNTVHbCtRdkN4dkJzSi9Bb2FIS2pSRDB1WlpZ?=
 =?utf-8?B?SmF4bG1ZQjRadDhEbHhGRTJXa3dTelZ3clB5TExFeHdacXJDUzVJbzVLOXNN?=
 =?utf-8?B?VWJBNk45ZWwzbHBlZWxSek43NjIwS1R3bEtBa1hNMWQ3V1o1VHdSS2NlajBj?=
 =?utf-8?B?NE9HV3BtUzVFMjhyNktlS2xia2xyRU80ajRuaTNUaHhkQnJJVy92WUZjMmU4?=
 =?utf-8?B?ZVQ4NzNYbEx6OENDL3RvYkRPdmNpdzEwQ1lUUTVQeWNOUHNFWkx3WWY2alZm?=
 =?utf-8?B?eEpKaWtodWpBWkhkWEZyQ1BFQXlKRE1WdVRQV2EwWUh0YU5YbmQzQlU3ZU4x?=
 =?utf-8?B?elV6SnFJdGVJT3hwdm8xNERraGRoY3NxMXhMbXZ5N1R2dlBMcmQ4L0ozMHRs?=
 =?utf-8?B?K1dQSUJPc2o5VEdDZHg5U1ltWGt1VW5KMHd1VnhCMHVTb0xuVVNSemIvTXZv?=
 =?utf-8?B?Q3Z1Z091WVplQzVWN2FZZ0RaaFZLL0ZrOURiMi81QzlVZ0JDRktyaWNIVTRM?=
 =?utf-8?B?SnRPcVJWWTBJdk5qOWZVOGlic09ZY01xNkNORXBScXZhR0o1MkxjYm9kL3Zk?=
 =?utf-8?B?NGVTbjNZbHRWdUJGTzRxR29pR1J6TXpBVEt5ZFN3eWsxcElaVm0zZ3FETEpB?=
 =?utf-8?B?eXA5VGFNUnJvZnZpcGNRQmRhZFFnOHhzVEk3SlZvRjJZQ3Y5RUdZM3JwWmRB?=
 =?utf-8?B?Z1RFWHkwdVRoaCtuenVDOHllN0dxbCt0bEJrUVc2bldoUUI3SVh4amFLZVJh?=
 =?utf-8?B?ZnJBZFJxU1ROeFVtODBqMUpRbFJLV0dKdkhHUmprS2NFS0I5SHBGd01kdzY1?=
 =?utf-8?B?Z1hzelNnSmpzMEJTdXJvbkFkZ1BQcE1hU1FqUkZ2K0ZxamVVWHpxOWxuNFh0?=
 =?utf-8?B?ZzV6ZDhvdW9RaEFVUWtDb0dMcDMrZnVscEVVUWdkRTlNdENveFJXNkVGb0xv?=
 =?utf-8?B?bGtJYlRPZ0gremMzUk5IT2wybm1hVGR0TVl4ekZ2cHhpeGkyYVNMbkZFOGNZ?=
 =?utf-8?B?T2N0emtyMGVlS2VEaXlEUGcvczBWTFJyaURRbzQ0OUpwb2hQek9Wa0p4Rk12?=
 =?utf-8?B?Y0ZvdTFrR1AyU0JtTDdiU0RPSTBHRVMrMDdwK2R3THh3RVBGYkdUQ0VZODlx?=
 =?utf-8?B?dytGNS9jSmt3dC9ENmUrZFFvaVVUL1FLK0N6Q0J4Q2ZyWXlxbUlrNlNDOXMy?=
 =?utf-8?B?d1hKVGpvcU42L3kvUFRzUjJRdkpkNXEvY3BnSnVFQ0dURWFCaHRYbkZ4QlZk?=
 =?utf-8?B?T2Q2TThqdWxvMEVTL0dybEFXUTJUVUQ3L1dSb2U3a3Q2SDIvcG0yTnlEYmN1?=
 =?utf-8?Q?qRK0ztjY76KyM5Dz4trk53o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3388e636-5d3d-46e5-7c6e-08d9add85fba
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 16:51:48.1613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEECiSbqqW5CuPvXzB0KRjaoljQ++4XaaXtkwbIJlKUzJhCJEYiZblAGWm1Tn7n5htLpsv3ZjwU8XftEhslVDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2497
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/19/21 5:12 AM, Sandipan Das wrote:
> Processors from the AMD Zen family have events with event

It's also from prior to "Zen," possibly from the first
AMD x86 PMU incarnation.

BTW, "Zen" is a broad term to describe the new generation
of core microarchitectures.  "Family" in x86 speak usually
refers to a number, as in the Family, Model, and Stepping
number triplet.

> select codes and unit masks larger than a byte. The core
> PMU, for example, uses 12-bit event select codes split
> between bits 0-7 and 32-35 of the PERF_CTL MSRs as can
> be seen from /sys/bus/event_sources/devices/cpu/format/*.
> 
> The Processor Programming Reference (PPR) lists the event
> codes as unified 12-bit hexadecimal values instead and the
> split between the bits is not apparent to someone who is
> not aware of the layout of the PERF_CTL MSRs.
> 
> 8-bit event select codes continue to work as the layout
> matches that of the PERF_CTL MSRs i.e. bits 0-7 for event
> select and 8-15 for unit mask.
> 
> This adds details in the perf man pages about using
> /sys/bus/event_sources/devices/*/format/* for determining
> the correct raw event encoding scheme.
> 
> E.g. the "ic_tag_hit_miss.all_instruction_cache_accesses"
> event with code 0x18e and umask 0x1f can be programmed
> using its symbolic name as:
> 
>    $ sudo perf --debug perf-event-open stat -e ic_tag_hit_miss.all_instruction_cache_accesses sleep 1
>    ------------------------------------------------------------
>    perf_event_attr:
>      type                             4
>      size                             128
>      config                           0x100001f8e
>      sample_type                      IDENTIFIER
>      read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>      disabled                         1
>      inherit                          1
>      enable_on_exec                   1
>      exclude_guest                    1
>    ------------------------------------------------------------
>    [...]
> 
> In raw format, it may be programmed incorrectly as:
> 
>    $ sudo perf --debug perf-event-open stat -e r1f18e sleep 1
>    ------------------------------------------------------------
>    perf_event_attr:
>      type                             4
>      size                             128
>      config                           0x1f18e
>      sample_type                      IDENTIFIER
>      read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>      disabled                         1
>      inherit                          1
>      enable_on_exec                   1
>      exclude_guest                    1
>    ------------------------------------------------------------
>    [...]
> 
> When it should have been based on the format from sysfs:
> 
>    $ cat /sys/bus/event_source/devices/cpu/format/event
>    config:0-7,32-35
> 
>    $ sudo perf --debug perf-event-open stat -e r100001f8e sleep 1
>    ------------------------------------------------------------
>    perf_event_attr:
>      type                             4
>      size                             128
>      config                           0x100001f8e
>      sample_type                      IDENTIFIER
>      read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>      disabled                         1
>      inherit                          1
>      enable_on_exec                   1
>      exclude_guest                    1
>    ------------------------------------------------------------
>    [...]
> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>   tools/perf/Documentation/perf-list.txt   | 36 +++++++++++++++++++++++-
>   tools/perf/Documentation/perf-record.txt |  6 ++--
>   tools/perf/Documentation/perf-stat.txt   |  6 ++--
>   tools/perf/Documentation/perf-top.txt    |  7 +++--
>   4 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index 4dc8d0af19df..9c54c0566fda 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -94,7 +94,7 @@ RAW HARDWARE EVENT DESCRIPTOR
>   Even when an event is not available in a symbolic form within perf right now,
>   it can be encoded in a per processor specific way.
>   
> -For instance For x86 CPUs NNN represents the raw register encoding with the
> +For instance on x86 CPUs, N is a hexadecimal value that represents the raw register encoding with the
>   layout of IA32_PERFEVTSELx MSRs (see [Intel® 64 and IA-32 Architectures Software Developer's Manual Volume 3B: System Programming Guide] Figure 30-1 Layout
>   of IA32_PERFEVTSELx MSRs) or AMD's PerfEvtSeln (see [AMD64 Architecture Programmer’s Manual Volume 2: System Programming], Page 344,
>   Figure 13-7 Performance Event-Select Register (PerfEvtSeln)).
> @@ -126,6 +126,40 @@ It's also possible to use pmu syntax:
>    perf record -e cpu/r1a8/ ...
>    perf record -e cpu/r0x1a8/ ...
>   
> +Some processors, like those from the AMD Zen family, support event codes and
> +unit masks larger than a byte. In such cases, the bits corresponding to the
> +event configuration parameters can be seen with:
> +
> +  cat /sys/bus/event_source/devices/<pmu>/format/<config>
> +
> +Example:
> +
> +If the AMD docs for an EPYC 7713 processor describe an event as:
> +
> +  Event  Umask  Event Mask
> +  Num.   Value  Mnemonic                                        Description     Comment
> +
> +  18EH     1FH  ic_tag_hit_miss.all_instruction_cache_accesses  Counts various  Use umask=1f to count
> +                                                                IC tag related  all instruction cache
> +								hit and miss    accesses
> +								events
> +
> +raw encoding of 0x1F18E cannot be used since the upper nibble of the
> +EventSelect bits have to be specified via bits 32-35 as can be seen with:
> +
> +  cat /sys/bus/event_source/devices/cpu/format/event
> +
> +raw encoding of 0x100001F8E should be used instead:
> +
> + perf stat -e r100001f8e -a sleep 1
> + perf record -e r100001f8e ...

Would it be better to have an example where
the most significant hex digit of the unit
mask were different from that of the triple-
digit event, so people's eyes could easily
see where each go?  I'm talking about
those two '1's..

> +It's also possible to use pmu syntax:
> +
> + perf record -e r100001f8e -a sleep 1
> + perf record -e cpu/r100001f8e/ ...
> + perf record -e cpu/r0x100001f8e/ ...
> +
>   You should refer to the processor specific documentation for getting these
>   details. Some of them are referenced in the SEE ALSO section below.
>   
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 3cf7bac67239..43d945e12d97 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -30,8 +30,10 @@ OPTIONS
>   
>           - a symbolic event name	(use 'perf list' to list all events)
>   
> -        - a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
> -	  hexadecimal event descriptor.
> +        - a raw PMU event in the form of rN where N is a hexadecimal value
> +          that represents the raw register encoding with the layout of the
> +          event control registers as described by entries in
> +          /sys/bus/event_sources/devices/<pmu>/format/*.

r notation is for the cpu pmu only.

>   
>           - a symbolic or raw PMU event followed by an optional colon
>   	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 7e6fb7cbc0f4..0f279b5498e4 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -36,8 +36,10 @@ report::
>   
>   	- a symbolic event name (use 'perf list' to list all events)
>   
> -	- a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
> -	  hexadecimal event descriptor.
> +	- a raw PMU event in the form of rN where N is a hexadecimal value
> +	  that represents the raw register encoding with the layout of the
> +	  event control registers as described by entries in
> +	  /sys/bus/event_sources/devices/<pmu>/format/*.

same here.

>           - a symbolic or raw PMU event followed by an optional colon
>   	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> index 9898a32b8d9c..21028910561f 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -38,9 +38,10 @@ Default is to monitor all CPUS.
>   -e <event>::
>   --event=<event>::
>   	Select the PMU event. Selection can be a symbolic event name
> -	(use 'perf list' to list all events) or a raw PMU
> -	event (eventsel+umask) in the form of rNNN where NNN is a
> -	hexadecimal event descriptor.
> +	(use 'perf list' to list all events) or a raw PMU event in the form
> +	of rN where N is a hexadecimal value that represents the raw register
> +	encoding with the layout of the event control registers as described
> +	by entries in /sys/bus/event_sources/devices/<pmu>/format/*.

and here.

Thanks,

Kim
