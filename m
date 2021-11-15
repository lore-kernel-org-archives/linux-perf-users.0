Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A9DC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 09:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B6A630EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 09:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhKOKB7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 05:01:59 -0500
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:34913
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229456AbhKOKB4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Nov 2021 05:01:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAKt5dpXTqEEUHHBZfW8XYp7H9A1Bcvsy2XJpl78t+M8Euh7wkwBWm6MryxK9DJfOeBhdjqMUY1yg29CUxCZB/yiqbNU89AaOddjWN0R7yL3D7ClGNuaji1EL8JA/3lpDcua7jrfywzEH1bS3BSPnrXZDAvgTK6WYgS+6nZ7eyx4wy/Uhr+saz3qXyYzh56kwYaBJmMLM5mMsiDoYQr16Jp/oAAfSqOFU0FnMR0n4afcSqGaa/oVE+ZZHTnJbB0t2jVYJ56si23DIa4CkB8mSzUi8m2bovaW7mTKeEBRX54fWPzMuWLFcaESPMkPaGefzCrziJrJTbKOBhxCeAnsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liH80Na9eQj/S+12Z/QHXRQwJhXbUZr4QQ50yo7As8w=;
 b=W+E42to3TjsxjkdHw0NAUImMzJSN0mlmFE00bSZ4w67MaUdJ3RS51D+jO27GPo2aL179/058Op7n9FSzGaZjZxs50V5sUXVtL3mm32JSjjGCm+iWVdDMyLJBAVQH2OUotRn9K/JIDJP0c+IJTd69QhmA3hw6zx8vEmoWxabfnPvjfDrV3TWQhsTPACJcmHSjcr55NauL91N1DkZmA43NzYfz53mmpB5qOD9RqhO4oN73oWf+ZYYvc1S+HiHgUGWkLSWHQKeLbcJ3fqJXeslHIDvVOgutxb+lowBQaMT61kbvUKh1Qy9kiTDVnTcp4SLdjHOerzetZaTlkUBBwOuQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liH80Na9eQj/S+12Z/QHXRQwJhXbUZr4QQ50yo7As8w=;
 b=OlSRj3CUdSXO+S+S3L3U9YNqHXAnBIfJ+fZe1zrGEaSRjU2YRXmS2rmbFSfbr7qOTN6ycQqfPR/fj+tolctsu7dva0Ld67EjxpmuxI5gT6IjP8USN0HO5gKAMBr3rgs0CYzA+bPUoICPV2qXOlcFH0O7/0bxTUwrQgKLlgWH3JY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB4788.namprd12.prod.outlook.com (2603:10b6:408:a3::19)
 by BN6PR1201MB2531.namprd12.prod.outlook.com (2603:10b6:404:b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Mon, 15 Nov
 2021 09:59:00 +0000
Received: from BN8PR12MB4788.namprd12.prod.outlook.com
 ([fe80::9037:903e:25fd:51cb]) by BN8PR12MB4788.namprd12.prod.outlook.com
 ([fe80::9037:903e:25fd:51cb%5]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 09:58:59 +0000
Message-ID: <9dc5cb10-2faf-a17b-ad4b-a22dbe688209@amd.com>
Date:   Mon, 15 Nov 2021 15:28:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH] tools/perf/x86: Use alternative format for AMD raw
 events
Content-Language: en-CA
To:     Jiri Olsa <jolsa@redhat.com>, acme@kernel.org
Cc:     ravi.bangoria@amd.com, ananth.narayan@amd.com,
        kim.phillips@amd.com, rrichter@amd.com,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
References: <20211111125646.581021-1-sandipan.das@amd.com>
 <YZE8SDkzq0OMcmhS@krava>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <YZE8SDkzq0OMcmhS@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::21) To BN8PR12MB4788.namprd12.prod.outlook.com
 (2603:10b6:408:a3::19)
MIME-Version: 1.0
Received: from [172.31.37.160] (165.204.159.242) by PN3PR01CA0030.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:97::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 09:58:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e8fdb1e-ae25-4ff1-abec-08d9a81e8b7a
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2531:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2531F47F162410956427A5AF8B989@BN6PR1201MB2531.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BmOwCurCHbof+4uFR47W67b5lFdmie7jEgDMBr40sPy2p9mcG4FhbtQbU16tbh7e/iofISp/clh2tCYSoIZx+OG+eLXO3074kaFqo6PxFjVV9iIF3YrDUkIzc4ddOY6viyHZS3f/PJq6V0lnLOQAz1VyKREgd9mYIAOERBjouJhokNOA3GJK8j5HzCCj/bjwWc7PSQqZf50/ssHMg+6ufOJYi2HT+CXlJbxtFYaflbsTMscvi00vXhASutw6XJZFRQmSdnkE06slPf0QiZ+ou3+AwR7MLEiK+J7Zfj6hEUafkiga7bXvdLg6iP65mYHk29bwJtTgIoSM4Gvx+DI4aAI4EZEMcOo0nrrhQHd81Ty8hh3nHUMD1mewxhuZvh+yarZzj+3/uSncdSWL91d0W7koJ3jxrnyqbLDn2wm4LY770PXnt4QwF3fuHYx6zQVm5nrlsl/IcLwLb7L2PNkReihXA06KAxZ3Vh+sqM9hyWxoeEaVzDL67fJqGqsKuaHfDUDqmBvJDvgFgkuzL6e/QdaPiWEpjZPfdC9IQhJ2MKpHj6DPp/uD4zDFo2YeTuF3GWIEuEz6SXbpWtACLQ2hn/C+Ls/MGzP6yNh7PzThCAo18bnQBUbMw9zzjfF3Wco33sdx/XQEpVVR1EDN6XtDcAtcF8wGiLWvfct3LBrbnZX2KdzhkxwZVWnZ4sab1NUQ6OG3F9qFORjW0fe/WAYs9Kif0XDhnxNQhmGA3vSR1XA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4788.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(36756003)(86362001)(31686004)(5660300002)(508600001)(26005)(8936002)(53546011)(44832011)(6486002)(186003)(66946007)(2906002)(8676002)(31696002)(6666004)(66476007)(83380400001)(66556008)(956004)(38100700002)(16576012)(316002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkNncEZMellESEhqMnV3VGQxR3lZaS9jb3BjZHIwNUg2blkzRjhJTllkbUN2?=
 =?utf-8?B?c3hrUTAxK3JrUk9oWHRoZTV2NEtCcGE1YkRSbVVNNmwvRzllbyszYm1iY3E0?=
 =?utf-8?B?bGkzT1lIc25rUFZOUGhFYUsrNkQza09UcFNHUy9UMWpqV0loNDdrZEhzaTR3?=
 =?utf-8?B?ZnVmbnVnRmZ2TkoycmtBSms2a3ZLTFlJL2VTL2lXRzdUd3cybjdHNTBVcUF2?=
 =?utf-8?B?OUNZc3RtaGZYQWNzei9LNGRHbmVPbXhSYnRwSE94Z3c5cHVydkU5Rm0yQjF4?=
 =?utf-8?B?VEwvNGlkcE1FRFhTbmEzNG5aQTdWaFRBNEgwS1JFUjhYdnAzbU1pWGZwd3My?=
 =?utf-8?B?eFFQWlplbmhlZGVQNWd3ajNTcGV4d3QySXZvWlExSENQdElyQjlOU0JzT0ow?=
 =?utf-8?B?MGZBSTA1anFDYWEwV0R4WVNCSm5WUjdxV0d5Sm1ZTS8vTTNyVDE2SmZlT3VS?=
 =?utf-8?B?Z0VGRHBSSm4zdkVrcEtTS2ZYT3VuQzUrMjR1V1hjTDBZTTR5ZUxzOVh6cFhq?=
 =?utf-8?B?YUNZeHQrc0tDQ1dyaFlRSndMTmptQ285QkpqcFRNODg3U0JOUE1iWFRVdUJj?=
 =?utf-8?B?SWg3Snp0bHQ1VEYyNXpReTFiVTQ4N0pSMStQM2krTHQ1L05Ca1VCcUw0cGtZ?=
 =?utf-8?B?VDdlcDhMWnZUOHpqaDRlT1NqdTNsV0VFZmJNRnB3N1lEUy9CSnVXMzduOW1x?=
 =?utf-8?B?eDFDZUlwRjVZWXhZV1VXWGkxdEtkWWY0Mi8xdjdVb0syZU04SWdGN1J5cHpm?=
 =?utf-8?B?T1Q0NTVkNTFmWGNBN1RhSlllMG4zazJCN212WGJQWWttZC9NQjlORllWdENq?=
 =?utf-8?B?SDFuakcvY3BvTzEwdWZGRkdMbWR5U1owOGhBY0xkQlAyZ0RBWnhGalNuR00z?=
 =?utf-8?B?UW9vTnhNQ2VRUk5sZEtaRTdoZG82bmsxTUZkTWZFZUVKT2o1Vi9KU3ZoM1FB?=
 =?utf-8?B?OFFoVmhudlY1RDFSTzNxOXkyaXI0SmNJdk9FVjNLaGtEMGpvNFRHUzhad3FJ?=
 =?utf-8?B?eit0NVIzNVBYNU9sQ3BZYXQyTjIyTXdSZFFpSDBLQUtHKzlLb2Z0UndrM0R2?=
 =?utf-8?B?QVZkZ3BvNysyMC9RMVNJM0szT0Z3cThQMEdxQXV0VkNtb3o0bTBSVTgwdTln?=
 =?utf-8?B?RGx3bFNyN0tzZ0RDNkR0T3UxbjhTRkh2MUVRNHFDSmNCMzIxbzBZK3JzTmVU?=
 =?utf-8?B?dVc1Tmd3VEtFK0M0RHl1K2I0OFBxTStacXZjRitablJ4ZDRVMDhwZHl1V0xt?=
 =?utf-8?B?K0hvZUYrSG8rQnVzVTNia1dLMlpVbFhicVc4eXROZnp5VTdTYUY3K1JrQkNQ?=
 =?utf-8?B?Lzl2aWJBTnpyZnBBeTB6SHhRVnBQeGhSUy80T3NYZmxyRlJFYTBVN1NJT3Vn?=
 =?utf-8?B?bUNncXB3TXRLeG5iYzVZaDhCWkJBVVgvdVVtTk1kKzVrbTJpTmNsdEdldlNt?=
 =?utf-8?B?VjVsY3lZZVBzR3NXcGdyMy9hOVhlSXRHSnBWS3RNNjlvTmYxTEpqdmpPQzE4?=
 =?utf-8?B?OFBMWkR5WXRYVURadnNvU0JzWkJCcHVKMkg2cWIzSWJDM1BoanV2Unl2eTJB?=
 =?utf-8?B?YUpkZTBrUHExdXpxVWlIOHV1cjhQU0FWdXhRUTF5MXZibzN3TTJSR3BwYXZv?=
 =?utf-8?B?bHM5TG9XMWU1am44MW8rcnp2bTdGekxOTnQwSTRwbXArUE9FdmhuU2NWOEE2?=
 =?utf-8?B?NXo0azlpa3JCdFlsaTU4SGdnc1FLT2wvM0ZYQXNXbmdKa1duN1AvTWFOY0E2?=
 =?utf-8?B?TlBEcGNnay9SU1VCKzI1dVR3dlp5MjdZRnZxYjEraEtBSEpNOVdBSFl2N3RX?=
 =?utf-8?B?WUFUL2E1b1hVNVJGTHg2NUJmNHkzcEtKdVozc3hoUWFpMEJsWDA0aGJxbUxy?=
 =?utf-8?B?aVEyaGRCZWYwaDV0dFk0S2QwK2FVVWFOQVdBNzdKN2pEV2lQYnhHK0pmMXNr?=
 =?utf-8?B?ajN2WHY4MlJnK2ROQ3NaZ3k2THZoMlVWNmtpME5wSTc3Q2xncm9WcERuNzFL?=
 =?utf-8?B?NWlUL2hjbDAyTkN5dHBORFFYbHFaWG9nK2lpL3haRm5QRW9jc0daZTFmZ0lC?=
 =?utf-8?B?azYvZ2svUEhLNG9kMlgxVlVZOUtpV1Q0Tlh1UGFHdDJWTGN4b0d4SmFmT3Ix?=
 =?utf-8?B?VXRDRnhPLzU5d21XRVZaaDZ5V2Vsc0Jud2VCbU9nNGxkc082NzJYQkxXMEtF?=
 =?utf-8?Q?Ofa3EyGhPHoFhUw7gvWMQys=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8fdb1e-ae25-4ff1-abec-08d9a81e8b7a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 09:58:59.7070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4n13pbxjj74KiyYtNjdL72l+edpQTe4AfCpr4XLJhcN2+vPDYZMxCUWaUf+UX6qPKGAq+vKJNIdcNnbOnhBLrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2531
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 11/14/2021 10:11 PM, Jiri Olsa wrote:
> On Thu, Nov 11, 2021 at 06:26:46PM +0530, Sandipan Das wrote:
> 
> SNIP
> 
>> Before:
>>
>>   $ sudo perf --debug perf-event-open stat -e ic_tag_hit_miss.all_instruction_cache_accesses sleep 1
>>   ------------------------------------------------------------
>>   perf_event_attr:
>>     type                             4
>>     size                             128
>>     config                           0x100001f8e
>>     sample_type                      IDENTIFIER
>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>     disabled                         1
>>     inherit                          1
>>     enable_on_exec                   1
>>     exclude_guest                    1
>>   ------------------------------------------------------------
>>   [...]
>>
>>   $ sudo perf --debug perf-event-open stat -e r1f18e sleep 1
>>   ------------------------------------------------------------
>>   perf_event_attr:
>>     type                             4
>>     size                             128
>>     config                           0x1f18e
>>     sample_type                      IDENTIFIER
>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>     disabled                         1
>>     inherit                          1
>>     enable_on_exec                   1
>>     exclude_guest                    1
>>   ------------------------------------------------------------
>>   [...]
>>
>>   $ sudo perf --debug perf-event-open stat -e r100001f8e sleep 1
>>   ------------------------------------------------------------
>>   perf_event_attr:
>>     type                             4
>>     size                             128
>>     config                           0x100001f8e
>>     sample_type                      IDENTIFIER
>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>     disabled                         1
>>     inherit                          1
>>     enable_on_exec                   1
>>     exclude_guest                    1
>>   ------------------------------------------------------------
>>   [...]
>>
>> After:
>>
>>   $ sudo perf --debug perf-event-open stat -e ic_tag_hit_miss.all_instruction_cache_accesses sleep 1
>>   ------------------------------------------------------------
>>   perf_event_attr:
>>     type                             4
>>     size                             128
>>     config                           0x100001f8e
>>     sample_type                      IDENTIFIER
>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>     disabled                         1
>>     inherit                          1
>>     enable_on_exec                   1
>>     exclude_guest                    1
>>   ------------------------------------------------------------
>>   [...]
>>
>>   $ sudo perf --debug perf-event-open stat -e r1f18e sleep 1
>>   ------------------------------------------------------------
>>   perf_event_attr:
>>     type                             4
>>     size                             128
>>     config                           0x100001f8e
>>     sample_type                      IDENTIFIER
>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>     disabled                         1
>>     inherit                          1
>>     enable_on_exec                   1
>>     exclude_guest                    1
>>   ------------------------------------------------------------
>>   [...]
>>
>>   $ sudo perf --debug perf-event-open stat -e r100001f8e sleep 1
>>   ------------------------------------------------------------
>>   perf_event_attr:
>>     type                             4
>>     size                             128
>>     config                           0x100001f8e
>>     sample_type                      IDENTIFIER
>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>     disabled                         1
>>     inherit                          1
>>     enable_on_exec                   1
>>     exclude_guest                    1
>>   ------------------------------------------------------------
>>   [...]
>>
>> It is understandable that raw events must follow the native
>> PERF_CTL register format but it is worthwhile to pursue such
>> alternative formats for usability?
> 
> good question.. I see raw events as a way to put to config whatever
> the user wants and IMO adding changes/quirks that silently changes
> config could create confusion and angry users ;-)
> 
> I'd think that if user is composing/using raw events then using
> directly r100001f8e is not such a big deal?
> 

Sure. Some of the confusion may be due to the fact that the man pages
for perf-{stat,record,top} state that raw events are "eventsel+umask".
While that is technically true, it does not describe the encoding
scheme (/sys/bus/event_source/devices/<pmu>/format/*)

Would another option be to update the man pages with a reference to
these sysfs files when describing raw events?

Something like:

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 2d7df8703cf2..5dfdfeba594b 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -30,8 +30,10 @@ OPTIONS

         - a symbolic event name        (use 'perf list' to list all events)

-        - a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
-         hexadecimal event descriptor.
+        - a raw PMU event (eventsel+umask) in the form of rN..NN where N..NN
+          is a hexadecimal value representing the raw encoding with the layout
+          of the corresponding event control register as defined by entries in
+          /sys/bus/event_sources/devices/<pmu>/format/*

         - a symbolic or raw PMU event followed by an optional colon
          and a list of event modifiers, e.g., cpu-cycles:p.  See the


> perhaps there was some some discussion about this that I missed?
> 

I am not aware of one but may be Arnaldo has come across something
similar before?


- Sandipan
