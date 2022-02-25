Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6842AC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Feb 2022 03:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbiBYD60 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Feb 2022 22:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiBYD6W (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Feb 2022 22:58:22 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE6C194166
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Feb 2022 19:57:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8IlXRdD2Nyl5UpfJwnx0zXK415BRTtbZ/85c0JJ0onEYCpov+PS1OBqT7D9B51dFTivWCFSS3sFyNQP2gMrzw40b82IjKdvPpAImViQ4E7znljh0M5scDDN0c9BVgeHnYxOCW4Dq/aAoIqlkOPAmavZtZ0SrqPRKvh0ndZmr7MBfa/QbE7ptHXO0eX1vyVwB5sRSc3z00nNHSdRdoOLccJcK3M48x/b1PbDsjxOhJhJKn1xyoFpTKQQukE/Wrn+Lgf+3S/CrDQQ6TTl5WghCuQW22ai0jSQkz3hcdgqVLabcwLPzptGCdpF7PdrNnofzt4TMTAENeYxnOwCrcP8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rvuc2nqDejTD0rOuqEj1wujCJ0E5vzfGj5mldHFUUKI=;
 b=PJ5vC1KtgCy04VDum+vrtHS2gudjGWZe/5qu5OL4EqteIk2gfzGiR7CLpeddsHMSeygsrvKovQD3y3Sbs9NuXE7aTjbSa4D3m5ir2G5RVVwhu18OUM6r6nPkBDaQJc6j3N53bgvOMzqcnr1aN6U3uf2klQxVqBTxXlfN31omK8XeG79Kf0AXaV9zkobonYfCv9SYewQWHWKRUhsYu+xBMvVPuXLj2btsqDX1P2DJHb/PHvzmYPsfpJ/b0e5ooaARqMg4xojneDldQ2yHEbhlXCSgEMclLnqx1WQMi+URVnxFEmHTGClwjs3QDQXl8FeCFhv/PeJNr8TFrnUeBsD1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rvuc2nqDejTD0rOuqEj1wujCJ0E5vzfGj5mldHFUUKI=;
 b=LMfhmauQCvBUZYTkHmoKPvIQBfGF7LRuA1S4DEdazmWF8DXfWmuLmND2zf/G3v0YT9/b6Yf89A7RTBQ53Q/eW2qF3wXYEykGgu1f/mJMBa9jrlsh40cs20lh0Ida4AIn7UXbMbsntMiIGyYjOATiEj31LXceimx68mTaHXvPvDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15)
 by BN9PR12MB5353.namprd12.prod.outlook.com (2603:10b6:408:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 03:57:49 +0000
Received: from MN2PR12MB4045.namprd12.prod.outlook.com
 ([fe80::5d32:210f:12da:7aef]) by MN2PR12MB4045.namprd12.prod.outlook.com
 ([fe80::5d32:210f:12da:7aef%4]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 03:57:48 +0000
Message-ID: <448fc962-5d6c-8b50-dd89-375b9656fd88@amd.com>
Date:   Fri, 25 Feb 2022 09:27:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: AMD Zen2 l3_misses event
Content-Language: en-US
To:     "Mor, Omri" <omrimor2@illinois.edu>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <CDD3A5B9-9B64-44DD-8705-6382913C8A10@illinois.edu>
 <08584f75-b829-1833-deb2-ed202bf1874e@amd.com>
 <27A01005-B5A6-43ED-A5C8-7F42AA2DD9C0@illinois.edu>
From:   Ananth Narayan <ananth.narayan@amd.com>
In-Reply-To: <27A01005-B5A6-43ED-A5C8-7F42AA2DD9C0@illinois.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::34) To MN2PR12MB4045.namprd12.prod.outlook.com
 (2603:10b6:208:1d6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b9acfb6-58dc-4b26-3ebe-08d9f812fc3f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5353:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5353E6BFEFE2E09BE10493D2853E9@BN9PR12MB5353.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LOGv2eLwAN5LcT/st7ztoE38+1/841nCZ7qbFpPK2EVckjqIIV7gIAWvtHfFeV+7UPQ78aF5pHRIcrkvF6hijzekOgsPl66tjIwFriYjdW2R2sYNeTUTztzbCS1aVaj1boHADWChchOAnFgFSUlwwswU5VVYeUoH6xlbLARjXhp9O1rYw6+VNSND86XeUMoQYb3p5Itwb0LVpoH14kEEa3J4xV12uVrTH0jID6orZ9j5DDoZf41pXZOu8J23mlnuROwJU11+vX5NeI9lJ7KO1/cO0mBelEgGbwOfScHoXhQ/6rDPyLmQQoeQMtGvB699O8qPiqVR427rUt+dQ9QC+fE1ansGY7etXPKVTJPpwlhhyw0W64jSgxxYKV/BCi0a6tudyT2+YMriyeBifkAdyfDwCftp5FWPx4SujLstqr8fjwv8stz9ORUiOqEAmQdlKxjlCd2RUr2nioMPS34oPpsB0582UU9ErYM1QUudLQQaAeNRqdVcWQQZArlO2s8NnbpkYkc3Ci3r7fMPsqv3dpdLcu4uux4fg27tcuLpDKwwH9phdeBp18a4NS/IhRPbgs893qyS5i9PFdCMKjsc3e8g1WjeBjUaQyjuPNZL3PH0XhWt+0HYkvwvYsHePAQbHljL33aA2umDDxg3kfWOPQ46maniELvXqiu5kObH8GvjkBgcAJy3TjiiRBuzg5Ruzx0sotG6c+ClMlS4c4IHfYzUQG+Xmt1rEFWbXAQJr0AVpZ912Zfnfg7lgrsbBmT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4045.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(2906002)(6916009)(6512007)(53546011)(6506007)(6486002)(508600001)(316002)(31686004)(186003)(26005)(83380400001)(36756003)(2616005)(86362001)(31696002)(5660300002)(6666004)(8936002)(66476007)(66556008)(66946007)(8676002)(44832011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmZIVHRIc3d1OFBKTll0YlFXUFcrVFVtejl1STV0WHJqRHQ0WnNRWVU0dHNp?=
 =?utf-8?B?Vkl5RFBSeloyUy9VSm51MDdKQjEzWU5ZQkJYZDBQQU9DL2liU00zbDZVenRh?=
 =?utf-8?B?ZTFJM0RpTFRQVFR6eWxUYzVJZ2lTWXYwZC9GRE1JMThxMXBlVGkxalVQalRl?=
 =?utf-8?B?YVJqbFpSQkFZdW5iOEtXdmtxOHZCdlNmQ2M4ZHFnUURIMGdxcG16bExqcitx?=
 =?utf-8?B?ZCtjaW5tMkluMnRUanJlZFdlcnY0VmtJYXlUTHZ6WGZMbjc3NWx6WG1LSGZv?=
 =?utf-8?B?MFBia1k5dmN1NTA5Z1dtZ01oVzVCcTlLU2NKTnBBVkFhb1BXUXpNbVhrNG5k?=
 =?utf-8?B?cnhWa1pTUnYvc2RkOXkwVCs4UjhWWjBHOE1iSTBtTmVobk4wNElNSm9UNzRZ?=
 =?utf-8?B?OXBVSkZmOTQvT2x5MncySVRBOEsybVFPU0R0YlVSbkNWc1VtSy8rVWcxTGF3?=
 =?utf-8?B?ZmtMVjZSRHRNeHN5RDdobm12S3hrNkppUU9ZeEdvRTBYWksyRFVXT0JaZXdY?=
 =?utf-8?B?V1Z3WFhmSGpWMDBNa2srbXFoQTBXMWhneTh6b3FWMmVqN2Vxc3J0NUNmM3Y5?=
 =?utf-8?B?Uk9WcWhPTzJTRitRMVl1TGNPL2FveTlkSXpOVWpGUXVXUk0xRC81VXluOTUv?=
 =?utf-8?B?QU9BSnBjRzJxZFFuNCt0MDlZeVVCSEFncE9oS2h6bGRLSmorR3FibEQycEpV?=
 =?utf-8?B?UFlUV0RENnBUYnpXYW1sdzBSSXFMei80YURaZnhiWm5MVzJsd3VreThyN1dM?=
 =?utf-8?B?eFRlRDJMUk5VSzNZWm1DOEJnTDRnZnVwMU9WZUYwM0d0RURQcHJoTTl0S2Z5?=
 =?utf-8?B?MVFNL1NVbUQ3MlNwYTg5WEVqd3RjbEd3TGU0OTQ2RVI1Y2Z5WG9QR1k2c3hY?=
 =?utf-8?B?NEJGMkJlUENjZUVSbFQxVDdydmVqalFqcEdwMnBQTlNRTW1Rd1NZVzU1N0dO?=
 =?utf-8?B?dEZ0UTR4MDFDaTFCOEhaSXNpbUFIejdiN3dncmdRRzFXdmVvNU9sQ3QrdjdI?=
 =?utf-8?B?SFN3d2RlZzM3a2xmNU5hS09mbDltNFBYQzZXbXJCeTdkblBrUjVlT0xvRDBC?=
 =?utf-8?B?cVhPK3BZb1doRnh0bHNhYkV4R0kvMEtsdmtRMXFxa3l5UGdjQ3ZUTjZWMnlv?=
 =?utf-8?B?K3B6dHZaMUg4Y3ErQ2gycFR0UEE0THorWmtXeERiSDdPd2QveXhzV2FtV3U1?=
 =?utf-8?B?dHB2RUxscXRnZGxNQmJIMDZwRWJMT3ArdEtZTEsrYlJnaUQ4SDF0QTduTHBw?=
 =?utf-8?B?SzdSMWdYTWJid1M5TUhzQmJDYlJmOGM3YXJEQmMxd0J3QTY3SUZkdWZJTFRm?=
 =?utf-8?B?S2ljc256MWk4djNCWFg5T3hqemU2VGlKK0Y1dXdKM3FGUXNySnNjb2xuK1hM?=
 =?utf-8?B?WGVDaGpkVFNWZWppYXdGSkJ6WFJzQk04eDhEUUUwMnhBL2xTdmdCQ09PaFkv?=
 =?utf-8?B?bWhFNENWRHN3N3BKMmpURzVPcDdmQVAxMlNFZVQzSGZUcVZjayt5TlRjUUFP?=
 =?utf-8?B?aWJWeEF0eitXbmtQU2NMMnpvdUZlY0lUaVhIbEVyOHdBb2NQZ1NtWUdMd21s?=
 =?utf-8?B?T1MxZlA4RFZlVnVNWTdyaGZ6MFlPcVJ2NFZBVlZxNlhMYXYza0tYVlhFR0Q3?=
 =?utf-8?B?b0FOQ2lWdnMraHNoMWFCZXJkQWUvbEZsTUwwUk5nRnpQM1F5OVNORVFmYUts?=
 =?utf-8?B?UklGN1k2cDhJM0RpNE5RNTU5cTV6QktkbWV1WVY5eE4weEs5VTZxeVAwS0t5?=
 =?utf-8?B?d2prK0hNT20raEl3ZXFCU3ZoNnBtYlJITHU0amFWb0F5ZEFCYThpMy9iSHFV?=
 =?utf-8?B?V05LYWZPbEFkRlRia1FRK2w1QXdiQ3J5ZTBuRVRoSVNzVnIrUDlrd0I3TElk?=
 =?utf-8?B?WnNhajZmZWFZVkR5bkJ5a2I3c1lJdWpNSWNDMW1UU3g5TGVYMUc5NWNVcDlj?=
 =?utf-8?B?dzBjQVRnWVlxMm9EWVB4RURpZFV3ZHA0SGVPSXh1d0pyQi9EMm9uRGpuWTBu?=
 =?utf-8?B?TDFqZEtVbXI3cmp4eVpuaGNrWFEycVJtNUlmdTJ6UTkwNU1tTGdWN1BZamNH?=
 =?utf-8?B?N0RzTWpCRVdzZERZdG81bTh4UlBoQklYd0NUUFdiRDJ4dytZVFl3YTIvY1lY?=
 =?utf-8?B?RkY0cDRrM3BFSWVPL0NUYzh6R2tBc3ByZ250dlZHZUVVVXNBN0NkM1ZmYXVD?=
 =?utf-8?Q?68085/ZFL4OSW6xyAAB0+tg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9acfb6-58dc-4b26-3ebe-08d9f812fc3f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4045.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 03:57:48.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTzmYbFPdaGMFTVI5wjgzDLN4a7+4IqDrKt5WeRggyIADF1VW+Czd47/M+KxJ+9uBWxlRBTeJc1GV00hq7tPEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5353
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 25-02-2022 02:28 am, Mor, Omri wrote:
> Hi Ananth,
> 
> I had already been referring to that file, but had been looking at discrepancies between it and tools/perf/pmu-events/arch/x86/amdzen2/cache.json.
> tools/perf/pmu-events/arch/x86/amdzen2/recommended.json:
> 	l3_accesses	= 0xff04
> 	l3_misses	= 0x0104
> tools/perf/pmu-events/arch/x86/amdzen2/cache.json:
> 	l3_request_g1.caching_l3_cache_accesses	= 0x8001
> 	l3_lookup_state.all_l3_req_typs		= 0xff04
> 	l3_comb_clstr_state.other_l3_miss_typs	= 0xfe06
> 	l3_comb_clstr_state.request_miss	= 0x0106
> AMD PPR recommends measuring "L3 Cache Accesses" with 0xff04 and "L3 Cache Miss" with 0x0106, though this depends on which revision of the PPR; a different version recommends measuring “L3 Miss (includes Chg2X)” with 0x0104. The difference between PPRs probably accounts for the differences between the values in recommended.json and cache.json. I suppose I’m trying to determine the difference between what these PMCs measure.

Each family can have subtle differences in events due to various factors.
I would not be able to comment on events that are not in the public PPR.
I'd recommend depending on commits that came from someone at AMD.

The event discrepancies across the different files may need a separate
review.

Regards,
Ananth
