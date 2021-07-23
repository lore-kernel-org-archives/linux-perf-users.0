Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC51AC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 20:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD96A60ED7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 20:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGWTfq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 15:35:46 -0400
Received: from mail-mw2nam08on2072.outbound.protection.outlook.com ([40.107.101.72]:45440
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229530AbhGWTfq (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jul 2021 15:35:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnLe8uH/m50VatriNYtb8YFB2A3wYmv0aMspZ5w0NJoI+UBC71Db5xqB2PT5gGMJuEXrRHbqb7ZEJe4T4m4WG4f5m0AD4mxvfWeQ7vVoKmnI+Lqlz7LBbserQuIqFz75qRPnXsRu6qd6DsGh1rlb4JkukkBRfZ/ob5Edb0DOZpZevNebKqAK2AsBocfdAs/w9/CmNI3ZcSDBmVb639OjhuEX/icOvg3KxzWQmjxafabtRtARP0hyAi8jv86nen4frHO1I4sEy7sao/ThrziEEgP04fayPN/bQwiJsaj0IowpApA7VEsZr9X2SAekEaZEcbMOGAPcdO+6Z8Hc5nxU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcWd0v5gC0karVo1FQwqHuRF9BjcXiz8RX5N7PZwq4g=;
 b=Rn2ziLaIc4KX3dOcKUbm0M0Kd+5x9t2vhiMA2pnQQ5+2wouiejYNFu97fcn34AYHIkjmoK3gttSYLF/gOPBksv5NxE25+8tTeJAAyqR9LNAHvyGwWMCsmWya/PKpMjZRwuhhnJq1yO+jdwseLqoYh9QE3IVmOP3bys2A4ibKpDlp51f/mEvCmVGAXXr5fErj8nUHgVyya7PqaF1TnLYefiDdsoskjawZ+7MqX9VqjXFSw8Mj0Amk3+jGDrDX7gPW3x5s08fWP/3XgsJAoKKUMdqb75yVxGGvpR19s4+4My0CoTPo59s7il8kkGqh0aPrzmf72IH1oadWf8Hcfl4RsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcWd0v5gC0karVo1FQwqHuRF9BjcXiz8RX5N7PZwq4g=;
 b=24T2TC2sMV9RCn8qY6tLSBV8wSZsPH40BAFyylLGL0xRipl9xEvBBBnqVwIFweOR85YmpoGsQ5lkdBjPqsWGqB7r6MM0aioOMhWo/f2I+kkxC1GAMhPDKxCro/KA6y4Ff+abdSPPEHy5OXyqhLFwWtwZlgjntbO/GHuKCN+nUAs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN6PR1201MB2496.namprd12.prod.outlook.com (2603:10b6:404:a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Fri, 23 Jul
 2021 20:16:17 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::6d98:68b7:bb66:c697]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::6d98:68b7:bb66:c697%4]) with mapi id 15.20.4352.026; Fri, 23 Jul 2021
 20:16:17 +0000
Subject: Re: [RESEND PATCH] perf/x86/amd: Do not touch the
 AMD64_EVENTSEL_HOSTONLY bit inside the guest
To:     Like Xu <like.xu.linux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Richter <rrichter@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210720112605.63286-1-likexu@tencent.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <c49b7e74-5b34-745c-a3dc-55bb2e83474a@amd.com>
Date:   Fri, 23 Jul 2021 15:16:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210720112605.63286-1-likexu@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:805:ca::22) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.136.81] (165.204.77.1) by SN6PR16CA0045.namprd16.prod.outlook.com (2603:10b6:805:ca::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Fri, 23 Jul 2021 20:16:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb160d30-adfc-43b1-57a5-08d94e16ba2c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2496:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2496B1E34CAC6A931C3816E587E59@BN6PR1201MB2496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5IBKucDZhdlPecwGW4IZnEovQDqToXzFT+rjHwy12J80piyrioPt93wttmn2pR67vm0XP1NW+rq5bDelq40hLIYS+0dkAvyfJoS2eqfhdboaYA5xcY+SEIAomUvHUNL5w4dqfuO/4d7NkN0Kr83np1GmTCevvY4SUlnGaDV/CyzDDywXc8TIu3JWOpLNnf74mj3wGx8CtPeQ21eW40LkcXQivKS/HRaBxRRrq7bS4w9nn6e8LenPWa2736xZTHgu0dCF2KCF1iFayZKSw133+7y/gxmDle9X3zbLY+uPnjd/hsypc210TCSzMPPxLRbL/9qj72pvVfajJF/2zGw7jZiOzM7VTrQ1wMvh5AFmMlQeNR0mCF2Wyi5hUudH31+qq7ocb/w3aRk1n2T83Mbt27p7tsZ+Qho1xmNIP4S1C/QoAmZRu7qbYGN+IyXg5lfDPb0DHrV8etEk5rik975gXdudz0tn6ssTxvkhKo6lCAemvO+0/Vhm/OpQag5ssKYLf6wOdNsjLRC+2R7DNAqSD3VzB7wbia8c/iuCFsbkm6SR0BvuUl4uSB9tyiWT3H5Dt7S1We5mqjffLdzCRWeJgvzyRwkB6x9qJDeKH4Sf5CRUiu2RDi25DG9Rqig7dX7rSX/NEEoQTq5YTUbVXisIfzSAG2WlXezrUzuoLhumqsWClNaaZZ7T9NZJotAn0b3anL5xEIuC5XP2UHbu5gZMdpk/mdGsqej2j4r015kv2K87Pc7eorpo4eQ/GbCsmXV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(478600001)(956004)(7416002)(83380400001)(16576012)(54906003)(110136005)(2616005)(5660300002)(53546011)(36756003)(2906002)(44832011)(31686004)(4744005)(316002)(8936002)(4326008)(86362001)(8676002)(66556008)(66476007)(31696002)(66946007)(186003)(6486002)(26005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z01kOE0xNGh3WW1WU2NXUi85UXhJZ0EwQW1Yb3l6NmcwTGxGTDdhV2M5S29B?=
 =?utf-8?B?ekdSQ0NWbk9pN29xRHkralRGeWdFQ2tBN0p2bjREU1NPMEk4UDBsZHlSdFFs?=
 =?utf-8?B?R28vSUNpbHQ1UmNIOUlkcDRRcWNBVTJFRC9oSGxtSmdvOVU1dkhoQXprQy9C?=
 =?utf-8?B?WnpLV3h2MmVOYURuVzFMc050SnlCME1GTTU1UHNobHp1NytxaXF3Vk1PZGZh?=
 =?utf-8?B?cCtSaktvcloyTXk4bStlelc1akxscEVXVzltZlVnYnRMMXJhdzhnQ3pQemwy?=
 =?utf-8?B?dkhldVRiT2Q1RzRKUExhQkl4RWFwV0RVaXI5SjQ0TWVPbHJZb0oxY2Y5eW55?=
 =?utf-8?B?MGRJYTB6ZXV1cm9Vc2VteUdYbk14TUhEbTJ5UUZOVDArUzNsVjJTbDY4VDNJ?=
 =?utf-8?B?c3J1NFRaRG1YUFFnRlpmM0hEbFdMQStic0JVNGp6SU9vellISzdYRzJZTFNp?=
 =?utf-8?B?dCtPQUNza2gyK2lVSEk0enRFNkNMbERwU041SHMvNENJdktUQWZsUDZ5VlE0?=
 =?utf-8?B?Wkh0SjlzUE9wY3p5TkdRM2FGZnJkWVMwM2V3a3l1bDB0RDdwUTVkcjNWamlk?=
 =?utf-8?B?Um9QaHc4dHJnQk9mZ1p4Sit0ZUxiUjdad05FT25TaTdkMnVyczJmQjlhUkpQ?=
 =?utf-8?B?UDR5YWVBNVVtdE9NR1hqVXN5MXkzZmhtSTltdGVYTHhGZmd4NW5uVkxjL2hT?=
 =?utf-8?B?d09sb2JYMmExdzcxVExWVFh2VkhDT2dTQi9VTG5HUUpHYkdQVGJFSFlRQm41?=
 =?utf-8?B?Tk5aYkFTVzY2anVQSk5kV0VDbEVnaDg4ejdlVENkbktXZ0h1N0ZLR2tZdmJ4?=
 =?utf-8?B?K0UwcVdac0FsT1NZVm45UHZCMkVOdVRWYUpoZWs4eEE2bHJPN3ZlY054RlZV?=
 =?utf-8?B?SVNRWFdGTHNFSzhndkVzdjl5ZFNwV1A3MDlrVXdtM1E5ZHZYeFlHc21Ib2JU?=
 =?utf-8?B?U1NBZE5ZSmliTGJjeGZoNTQ4RTVVbUl3Z09QK3lJR3o2bW00Qitrc2FSdTBp?=
 =?utf-8?B?YitjQytvRnNzeXc2NUhpK25EZm9nUjJHRDY1MXlCMkM2WSs3L2IvTHpBM0Rn?=
 =?utf-8?B?dHVYT0xFQmFUVjBoNzRPaTNtK3VZRFVnb3hONnF6czdUWTJNdHNZSnBXcjF3?=
 =?utf-8?B?SmJ0Y2VZZlZONE9QNXNOZDRIRW9BZDRaRlh2cHpONFdNL1pnSWZZR08yYWNQ?=
 =?utf-8?B?WXc4Z0IrNU1VdmFHOFZJYzZPdE51TnZBZ05ySWpRd08yRHhaN2hpOWlqQmdI?=
 =?utf-8?B?SWhsOEtTMDBtRjVmdG5FTE5DT2h2YU9BN1I5Z1FXdm45S1R2Yi9MOVJuUHpq?=
 =?utf-8?B?VXJuYm9pand0clVrcElqT2h0MS9sUkJsQ2UxMHJIN1IrNy9XSzZtUU5TRDZa?=
 =?utf-8?B?bU1EbmZiQWQ2ZmFxbnloVmk4S1dqZTBVMXpyZ1pvMUJHRS82QzRWOHgydTlt?=
 =?utf-8?B?elJzdGdCYzJOSXBXM0doeVVadHRVMDdBbkkraitGOTA4dDEvWE1DWHpBaGxL?=
 =?utf-8?B?bEd6cWt5aWhicC9nTjFIbml3N1lxQ29iQ1ExUEJMV0ZTMmVLaEdOWkVuL3BG?=
 =?utf-8?B?YThTV0RkanMzeEhiV000Q1FUZXJFMWhzdFpWZXdvWEEwRDFJNlhBeTlvdlBk?=
 =?utf-8?B?TEhKbnV6QWhDTWEyWTZCOE1KY1J2cEZhVFhaWTlpbFUrN1lKQU5Ia3JQelBi?=
 =?utf-8?B?d1JNWU9QR2lMekQ5YVZVWlVFZm5jVWdIQWFZY1JZVkszUlZ1ZGZpbTh3c1V2?=
 =?utf-8?Q?626Xntgjuh+ea/DfRYDFfmejeEIdUCxUmegjegB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb160d30-adfc-43b1-57a5-08d94e16ba2c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 20:16:17.0960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yoEgXZWfgFodtwYV1ezLEYDOWAh+j2Vjd3n197QQ7b8DRJ4CQjYsgXcgSgiyyq/A/fOBaNbFXVDQi161vQv2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2496
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

+Tom L., Robert R.

On 7/20/21 6:26 AM, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> If we use "perf record" in an AMD Milan guest, dmesg reports a #GP
> warning from an unchecked MSR access error on MSR_F15H_PERF_CTLx:
> 
> [] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write
> 0x0000020000110076) at rIP: 0xffffffff8106ddb4 (native_write_msr+0x4/0x20)
> [] Call Trace:
> []  amd_pmu_disable_event+0x22/0x90
> []  x86_pmu_stop+0x4c/0xa0
> []  x86_pmu_del+0x3a/0x140
> 
> The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host,
> while the guest perf driver should avoid such use.
> 
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---

Tested-by: Kim Phillips <kim.phillips@amd.com>

If we were to add a Fixes: tag, would this be the right commit?:

commit 1018faa6cf23b256bf25919ef203cd7c129f06f2

Author: Joerg Roedel <joerg.roedel@amd.com>

Date:   Wed Feb 29 14:57:32 2012 +0100



     perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled


Thanks,

Kim
