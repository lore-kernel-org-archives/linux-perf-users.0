Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5526CD342E
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Sep 2023 03:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjISDZg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Sep 2023 23:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjISDZe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Sep 2023 23:25:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71621132
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Sep 2023 20:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zs1a6jAx2Y+IyPqbnR+GxM1BVd6c7Hyo5TXgAn78ySINlv6UjlNAHx47dC/8sB9v8cMCNTlvfgrDigmkxcqdDSwLg1kxU3tra+MQ+qEdelDiuh+OHXdafUruIJgIAVqW/fOXsG+10SVFrUizM2F9m55prqglbR/R8i7GMqa0GokEdUP0Pm+PbGHqHErjl/F1WQnUULOjaejKVq7SJwX6hn+U1Dls7eAkQirOjYZuydlFLHlSow7VXIuvkaz0hKbbXKvc+jWJPzLA8jvzHeIlO7XjeQAgifuGmzNBOQB4do3WKltQKPR5lmIu8z5KYEwIYw2G74F+AR7gbYe50ZOrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjuKEQhU0bYh/gKTVnF9ahiobRS4NXPDZH3IzuHIvwc=;
 b=dy1tzV8EMtGFf/PKKj63inJjnreAuDTKpNxGFJec448UyqARW53JEktVW7+SRMskjkSXtWoPhHMCHTzDVDwl4/2NEEkWk2ytzjpbg3U8S00KRtv66UX0RqpyVP4utjHA3yCszSy3A3VnJTv/QnxjyzaRIi/ITRMhYKS0Ux5QpCC5n5BRC/5eS/zDtkO80zHzDtH1cC6JUkt5GFiVjW094R9mp6Kkz/N7h+WfcLWuy9wq1zeKV4aSKtzAh+lfRhkVJzdt33uUHHr2c9P9NPfqT8ydOXTNYOMusXizuhqw2TeqRgLfq+kjuH74B3SoUpY9Q/acSi9RP7QlRY8LwMWLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjuKEQhU0bYh/gKTVnF9ahiobRS4NXPDZH3IzuHIvwc=;
 b=hXhfC7/qSIunpKvraqoSAe5I9CS4tC2GepIswtjg49+5EHCyhzBxkI9/fNQ7mxuMVl6Ww6O1S/C8SCZGp2Zyc+JUUV1fYfUYOexxsoroStgQMPNuatFSa40v6lwkNhVDAjtKgqpDiy4gRAXwJaxdp3+KzZVXz9hwMfIwQBRHd8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 03:25:22 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a4ed:10a6:876a:10d7]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a4ed:10a6:876a:10d7%3]) with mapi id 15.20.6792.024; Tue, 19 Sep 2023
 03:25:22 +0000
Message-ID: <29ffaacb-c224-6895-a6f0-138683dd3faf@amd.com>
Date:   Tue, 19 Sep 2023 08:55:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf test: Remove event_group test for events in multiple
 PMUs
To:     Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, acme@redhat.com
Cc:     peterz@infradead.org, vmolnaro@redhat.com, irogers@google.com,
        kan.liang@linux.intel.com, maddy@linux.ibm.com,
        adrian.hunter@intel.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230918122552.15217-1-mpetlan@redhat.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230918122552.15217-1-mpetlan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::34) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: dd75f973-2bda-41f8-72df-08dbb8c00de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apyKisnhLJRLcOjx61BKBDT4fgrlh3+9qQTgIkOGRac+PugjbApTdcByNY4XaORQa1hMFPfJUzjZK375wJHEcwWJElHhBsd5ICJfWDZJK1mU+1eZIlriIVpRkzaU3O69WNqbkEUcoD07goFcFCCdpRqagInb5k3cpnWxi6c4Q0BScnfYPJGL06zpyoUmD/7yk6O8/yj/XUQmHVcIlcX2uR4wOapilW+KdOb3jb+lgc8O061xERmuurNdV8rhCrpVF8eqngOS7+lf6b/853ttb8l8NTR6fJ3qKuS83WCoAxOjpf34Ksxvp7EUUwJR4fJLK1EnSVuC+yin6GZT/OhbLD85Y+YdnNBOdVDmydC4HhFZvyulHHb+eHbZ8sJwex60tk2ddvBDrnHBHA42aLDWt5fmUjP/v8g0ymar+IBI887V4tv11UH3IgEbF9QpcDR63MLx8TdSC+wGORhmDfderVGCWCPrECxcRIR0qIkl2Wgc2oZvGXbTbvQDHXnpN02sF+6t6ELcGH/BpupmwiXCxZPl8j7fzdt0QFnVUZVQqt4sxd4lmwvnHnEI2AWR1G3NCIBSs3caelKnFfAnlMime9AdR3MfBR4l3HJVojS3L26b98/HwhFU4KAvZPnaq+JtS/83NxXr5eolDPGijK3UIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199024)(1800799009)(186009)(8936002)(2906002)(8676002)(316002)(41300700001)(26005)(66476007)(4326008)(31686004)(966005)(478600001)(66556008)(66946007)(44832011)(5660300002)(53546011)(6486002)(6512007)(6506007)(36756003)(2616005)(83380400001)(6666004)(86362001)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW54MHArOTMrQ2V6bHdxUlNZS1VjUVlxczJ5c3d0WnB5MEk1QlFlQ2ViK2ZK?=
 =?utf-8?B?dXY1eVR4cEhrS1QrZTBsbG43VGJEcTBTRU40WWdJSHI1RHp0KzJWNmNoVjFR?=
 =?utf-8?B?a1p5ZVhPVTRrRGRWQU5XU0pFTjVodEw1MHlhbkNnWHZtZVpJemRKdlFXVmY1?=
 =?utf-8?B?ZlRPbkVzVjdRYTl6UXFmeXE1MmN3OXkxY0ZVYTh0Z1lsRTcxSllJM2Y2OVVR?=
 =?utf-8?B?VW5PL0dmS1dNZWpPdFdiUmJEeVlUTlM3RW51QTNpcFB0Tm5YTlA2NFU0TGlD?=
 =?utf-8?B?c3ZiM3pOVmRPYUE4R1poQVBXOFJHZUQvWG9oK3FHWmwvRjVhUExhMVVBMkFO?=
 =?utf-8?B?b3E5bmJNOXFpVjVOdi8vZEJNT0piWUV3SmUwODJ6SVVuTVpiVHYzNDlRU1Nl?=
 =?utf-8?B?K1djVWhUaGcvaGpVSkkxTjJEQmtuR1k1MzMrQnpPbVRwOVRjSDZobU04R0hQ?=
 =?utf-8?B?eC81YTB0UUl6MUZ4WE9DN1A4YUl5VTNqbi84VDJYSXNRRFBJNUE5TCs0MldW?=
 =?utf-8?B?RlJWamZ1NDMwYnNpdFVRMEYrV0lhNVFDdmlCcjdERW82eXRqYlpjdFZ1R00x?=
 =?utf-8?B?QzI3TzVCVVpKaDhnanNpK3JjSUNSVVFuZW5kaTVsQTV3ZzRJRUVlVTdLUFUv?=
 =?utf-8?B?TW9MYmpLZGhXRmhuK2VPUWtNQTVSUHNBd29yL3Q5UXloVVFobGgxZ1NFV3Ru?=
 =?utf-8?B?TGRzQzUyZlF4SmhmeGp1MkZuR3pGcUdIdGFUc3o5RWtlYkZXZ1NhWmhLaUJR?=
 =?utf-8?B?NWR4V212ODF6dlMreUYzRVEvaWtBemxMdjhTRWRwdW5aL1h2NDBZcnM0eEtI?=
 =?utf-8?B?dDE3TDZFSlBLNmlRa2duTUU4YStoYTNUSGZqbDQzK2ZDdFZyNGdRaDMvVTJH?=
 =?utf-8?B?Zm1yOFRuYnhKZW9md1dPOXRqQmRFenhzaG1HaENBNzBYNVd0cWJEZTV6eUFa?=
 =?utf-8?B?a2JNUWFFMWd0SFpmMWQxUkdueGE0T3A3Vm9tMnJSZUNNQzVJZWxHN2UzR29H?=
 =?utf-8?B?OGFmenZ5L0V2TFFHZ0xuRU50MFNGbGFESXlOb3Q5V1hvWEZlSU1mc2cyQU0x?=
 =?utf-8?B?YXYzaWZmN00rQUNjRmRWMWxVYnhKRWd3Z1VtZlRGVEV6SW1VbDg2clVqUURj?=
 =?utf-8?B?WFo3K3hLVTMrQ0lxejdHTjJnT3lUSFliQmhjNjJOMU0vT3Y1RkluK3ltWm1D?=
 =?utf-8?B?R2RlMUpXMDdZMlI2U1AxaEFZdHdReGZLYzFBRDVEVzB4UkhUT1llNWZJUG01?=
 =?utf-8?B?K1pubk5qQzVURXlFZDhJNElGYzYxQTl2OXJ4a1ZvYkhvNUZrMXp5czNPT05y?=
 =?utf-8?B?dUc5V1BRc0sybG45cHJmYndZNm8xSnBoMjc0SkFiMzhxZDdWZzQ2Mk5sWlNL?=
 =?utf-8?B?c1BuYXlydVJ6b1NxY3g4bmFXUEZrMllDUXhNZW9BNzdLUFMrQmlPZUIyVEs2?=
 =?utf-8?B?L2JLdGUveVVXQUlYU3piOTJKVWl4dTdkcml1T3ZjRytuSWFQS0l4Y1BGUkFN?=
 =?utf-8?B?b1VicU43M2ZCSEQyRG5iQSswQUxibll0MTNTc3k4UEVpVjVNcmZrK1hvUjhz?=
 =?utf-8?B?R2xvVFZKM0FwcjVYU2pSeXF2emJtY1BSbm42d3NRSFJIcDh3cXU2M0hCTGNT?=
 =?utf-8?B?WDg1eCtzeHBZekNxNjRFM250bm5QRGVWdWl0T3BUYUF3UFppUUNSNGdsYjJD?=
 =?utf-8?B?eHRDRGltTWswd3A0TDdIcWxhODh2QzM3disrMkZWa3VHNDZjNWowMkgyOUFl?=
 =?utf-8?B?WnB6Z2R2YXZNdW1zVTFXY2UyeC9yajdKMFliM3FXWTdqMGNDbmJOODJDd0Y3?=
 =?utf-8?B?NkcvL0lxMk45SlUvKzRVaWFHOHFLZTdSaXFEV0gwTkhScEtNaDNpTS9jQlQx?=
 =?utf-8?B?dWhlUUZiVCt4Y1R1SE9GV3lVSXFDZDlvV3dCVkZBQmRGenJ2QkFnK3hjZ0RW?=
 =?utf-8?B?bmIwN0UrenBPdDg2bkVISUlFT1BYbjFvdks0L29rRS9yRUJyTnVLVnkxVExG?=
 =?utf-8?B?ZlJrNVR6VGdJZldrcXJyNFkxektqSld6RmFCVkUzbkZmUTh6ME55SDBSNDk1?=
 =?utf-8?B?QzA2dytobVdtcEd0S0c4MTlRaHZma2dZcGp2QmhmUjRxSlBENXBNMHIyYVQw?=
 =?utf-8?Q?Wi6dCyTKJGuwO5AY7yLyiStAm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd75f973-2bda-41f8-72df-08dbb8c00de6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 03:25:22.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPksUABmsarPfeRZCxbJ3sWXFLDCUlwFFIMEEaGxUB4upQu8x2JGO7p2eRJighq0Ky95IidoJhtMfYCyjjONzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Michael,

On 18-Sep-23 5:55 PM, Michael Petlan wrote:
> The test fails on various environments, since not all the combinations
> of events in a group work. Based on fact, that perf contains code that
> re-organizes events in groups (and also removes groups when it does not
> make sense), I assume that there is no rule an arbitrary combination of
> arbitrary events *should* be supported.
> 
> When an uncore event is grouped together with cycles and cs (a sw event):
>     # perf stat -e '{uncore_cbox_0/clockticks/,cs,cycles}'
>  >  WARNING: events were regrouped to match PMUs
>  >  WARNING: grouped events cpus do not match.
>  >  Events with CPUs not matching the leader will be removed from the group.
>     anon group { uncore_cbox_0/clockticks/, cs }
>     ^C
> (the CPU used is Haswell (Intel, family 6, model 60)
> 
> The test uses perf_event_open() syscall and bypasses the algorithms
> perf tool uses to prevent scheduling invalid groups.
> 
> Remove the test-case then.

Event group of different hw pmus is not allowed by kernel. This selftest
is to validate the kernel code, not the perf tool. Please see:

https://git.kernel.org/torvalds/c/bf480f93856673

Can you please rather fix the test instead of removing it.

Thanks,
Ravi
