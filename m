Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B597C433ED
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 May 2021 11:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189626101D
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 May 2021 11:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhEDL7h (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 May 2021 07:59:37 -0400
Received: from mail-dm6nam12on2080.outbound.protection.outlook.com ([40.107.243.80]:52673
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230043AbhEDL7h (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 May 2021 07:59:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkRefpfrpwZ9luqJp7VOy1O+3pInWlXljKe/GCQOHgd7FEVPBFOS4P6PfJTkFuiKlKX9vQ171whkQX3vFG8lGvPQ6Rg6rZN/yXYQoYSf/1qBTVTflzGbMmnG+ky5VozikWVk6QSr1q1C+3YIZQ9TJYDGckoV0THoz8MhZoeHQB85SCcZclwVz0pM7ID7OhTPEY2NTCALqQNBQLsbCYna/H2YjRhInZ2SJoTwvdPZoeDIgHijbzenI5PtH0C4RUby58yR8X5eJELnhtel5CCKzVLDBxvmh53GhyqbxS0N2GXLLX0ohCir714Nk86Cl96S1XgKR9hAspg/y21tLfBKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tzYVfEGrIihOK6Aj/NLGijsB/mFALQ+bVcsN9vORRU=;
 b=j5lKOpk8bXfW951Cm5jpRq6Pr0TQU360EMn3rvDvhZ1SgqS62h5nH7oS0i8VtT8K6iTr1k4kTTQbPFdCIAWtpzJ3THVmRtGNZjsxQSxJHu2JunTHFcF6f7psTW67UmYBKHXK1Zo7+CjDwHo5O+JRBJQEeiuxDIMD6YGG8SXCexHCxbU2sZaaSTuLDvgTItkG4VKIwBS51slcvo5KJc8Ctkk+yuiVhpG7lMWN0NDhRQEnkQ0oisnrC2iHq5NGsX6bVrGaClnHyuhzXHlIeF6sxnNV0hxAWac/teSOUkHy4XsngKEEdNhPXD2xSTx4KX63+X6MCUJb9bWQ2gKj6SljiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tzYVfEGrIihOK6Aj/NLGijsB/mFALQ+bVcsN9vORRU=;
 b=ZF3sWELeKGcpbWN2E2l1rIEFEtJNmB1GjydmzEC4mTgJgv2tn9YbESvsP3cCm9qNFEH8SsLRn370pJf5IWFsHQ0/oN1r9AZd/uYuZiACxTi7b00jK7Ld7qVQ3gOHebAsxbt5OIxU3cOIrqudQHM1jIQmX9vYbbAL8IMPL6HN28k=
Authentication-Results: live.co.uk; dkim=none (message not signed)
 header.d=none;live.co.uk; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Tue, 4 May
 2021 11:58:41 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109%5]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 11:58:41 +0000
Subject: Re: [PATCH] x86/events/amd/iommu: Fix invalid Perf result due to
 IOMMU PMC power-gating
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iommu@lists.linux-foundation.org, mingo@redhat.com,
        joro@8bytes.org, Jon.Grimm@amd.com, amonakov@ispras.ru,
        David Coe <david.coe@live.co.uk>
References: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
 <YJEWWbEeDm0rUyC+@hirez.programming.kicks-ass.net>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Message-ID: <e9769da5-3d2a-6e86-8ebd-feb00b567bba@amd.com>
Date:   Tue, 4 May 2021 18:58:29 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <YJEWWbEeDm0rUyC+@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR01CA0055.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::19) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.73.101] (165.204.80.7) by KL1PR01CA0055.apcprd01.prod.exchangelabs.com (2603:1096:820:5::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Tue, 4 May 2021 11:58:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97b469d1-852a-491a-0a3a-08d90ef3f556
X-MS-TrafficTypeDiagnostic: BY5PR12MB4292:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4292D87E249C68800FA49EECF35A9@BY5PR12MB4292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Gopf+735EibW7furwHdW6V0cco12lCby9lLGEk5whNgAgCPzScYkU0BF+TkqBuY3Mk9O+GS2wQJiNZBmdjO7Z5bD92S20NzpKjWSvkZ3B5a2FoZgB407cvVZLQJK96TA0gt1A3qvnUqHV3jJdCf6LIZFnyjpQjTmxxVMUFw9i/9iBl6w4xPWwOgAtRB/fp84DgUYFQEpMsBULalABXQ1BXuA8WpGG5EJLpsDZdbpKndBdVNE+nIjzdUcoy+9NDfzZhAKZb32RUJt8WDC96LqWAw5sgOHO32IOD7lC9P5zvPHdinzqWDr6+8LwGHbudYZy9zYOZ87FtEuLCtnHS4+JGPd1bzMRknELUkzKhnkHqFePtqDujb8zZP8mXAwQJhZnUrrXT7X33JWkmrXxCr/+ZZ/bTe9LiGeyomoeTjy8NyChn3LzETiLtkOe25vnw1bsOn99Vimka/nJAhZ1nJ0LzCcGSzBSVFI+AMvirbT9k2HmOZWj06fjI4JtPw4dORcJuXIb5dR2fPvMeeCIbbmqCZ6htgdCEXulqTtpUOopn8AY7AAiygOFxl6vKzdgXjYDSl3QbzWElkLX3xBvG6m7/jphnGf/bdt3VadJ/a28N7r0uasZF7BpW/eUQnpdMcJ2Mq8zrfu9hQhIbpmJoMexWpAM7Wb3F3uKgKwXzidD0K09YRCDXAPXeXVIf2uDU4OhIIh6KeAAQLg0v95kE7bwNiU2irfA++lkECE45BO5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(6486002)(2906002)(5660300002)(16576012)(478600001)(8936002)(316002)(34580700001)(8676002)(31686004)(4326008)(956004)(66556008)(66476007)(38350700002)(38100700002)(31696002)(53546011)(86362001)(6916009)(2616005)(4744005)(52116002)(6666004)(26005)(66946007)(36756003)(186003)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NHoxejExeTJhTGx3YnhMcmo0bit2OWRZU0pBRTllUHpRWEcvRHkxc09GVjl3?=
 =?utf-8?B?RWNIMzZzZ0dDS0VleVp5VGExdWJtdTlnRlNhb0Voa3NVYml4SmxKRS83dzc0?=
 =?utf-8?B?RVRUNkhGK3F3dndDQWtBTk5nb1A0Z2xSMWZORE5sZVJGWmVYUFg1ZkVpMjZF?=
 =?utf-8?B?UXh2Sld0WVV5Z0JraTlXUTNMc1N2a0s4WklCUldJNzZaTUZLekhTWmJ0Z0Rh?=
 =?utf-8?B?czB4QkdTeHpsckM2cXFGYm1mR05GenU3WWFyellUaDh4NDh5SjZBMHROY2lt?=
 =?utf-8?B?V3pXU2pUOC94aGZkR0NCb3Z3ekFFN3QzRUFJU3Vid0ZLY0x0WkhCVEwrR0J3?=
 =?utf-8?B?bE1udFpCNHpxYm9GU2FOQVdUZzJ1bkhlU2tXd05SMFIvTDQzMk5zY3IvakxV?=
 =?utf-8?B?TUtBcXNDeHVlQ0RVeGpmdWdDVG91V1UwbGZkUFZQd1ZBZDBLT3NSdVFCcTZu?=
 =?utf-8?B?NFJ2cnZibnBycDlna0RjREJIVHdVSDlZakJmeGM0bHE0L0MraE4xaVNYZFgx?=
 =?utf-8?B?TkExSmgzS0ZVS2Nub2c3YzVzbzYwbkxQdFVXK1JjUjZ1VEMxK2ZyVEd2WnlR?=
 =?utf-8?B?TGpTTklxSUJvMXM1L2ZydmJidGxXNVFvcjBtd3dlVFozOXBzRU0rSVhZcjl5?=
 =?utf-8?B?TysxdDJrczV4K3NFNWo3WVR4K1ZxNWttQ25Ld2d4eEVuMTRyRU1qWnJmTm9p?=
 =?utf-8?B?d1hwUlJ1OURtbm5GSUc2SFBIQ0lSUjVNRXZ4U0d0d3JSNEVHWnZwdkpyb0hX?=
 =?utf-8?B?MnAzbXVaNmNxby9zcGxSSnpMNVluSVRrU05qVlN4YmNhMms3ZklYTGp2akRj?=
 =?utf-8?B?T1R4cGJ4cEduY3dOeTZoaTJzdFJLM1dxdTdqdFN3ZWxjVDNIY3MyeVVtTEZ6?=
 =?utf-8?B?M0NNSXdWVUN1bGVCR2hXSCsxTy9tRUxta1Z1V01ROEFpZ0xvL3MrTjh1d1ZW?=
 =?utf-8?B?Y2o5UVE1RUhoRDF0cVNaVGl6MW9XbGpxRW5hZHdiY1BpZFdpcmUyc1pTTHFa?=
 =?utf-8?B?NFNkVVZsQTZhdUR5OHZGSVNVT2YwbnB5MXF6UGtPVVJWNjNZcFBXYkN4Mm1G?=
 =?utf-8?B?elpGQ284WHJDOTRGWXp5MEhLRWZsV2M3NW1aS25hRDcweEM3Nk45SVQzOVZC?=
 =?utf-8?B?QXdJQ1RDRTNYYnNZT3VBUzdwVnlld0lUUU9VSjcyMlR0aDNiUFc0anRaOW1M?=
 =?utf-8?B?YktBYktuL3RMUlkwc1czQnBDVnZTU2tEZVdBUU0rODFiZmpEZUFoNW1SQjZZ?=
 =?utf-8?B?N1pDa09GMTJmZzRWdGhsY0Z6Nzk5RlNmUzk1N0lwV0lndTAwRjJLbUtJdnJN?=
 =?utf-8?B?aHRPQ1UvTFFMNDNjYUtBQmJGU3R2UVFwUk1jZ0ZFYXlMRFFvRlhEM2hFZDF5?=
 =?utf-8?B?TkdCUUlYL1pkWVBicnpLblQ0bUoxOG16YnBiUm0rcmc1T2l1Q3gxaHQyanlN?=
 =?utf-8?B?dk9FV1czKzN2VWhtNlhFWGM4TGpleDYwVFFQeDNGNWk5Qy9jd0NPVWpHczVN?=
 =?utf-8?B?RzlmaXIzNUJtWmFNdlhxeUo3VUJLS2FqdVdjUUJVUXRjMnE3a1R1S0RjaHd4?=
 =?utf-8?B?dmlCbkZ1Wml2TzRDZ2Z3cWZXU2dMQTNiU2tHMXJoTkgzRzlsUnQwcVdRNEk4?=
 =?utf-8?B?RkpuSXRYaWF3eUN6V0xYUFpTSEkxdDdtL1dWa2d3NnZvRkhCeERuVVJHREV0?=
 =?utf-8?B?NEhDOGtkVG83SldES3RVbDgzOTgzWER0QkQ5Q3k1bkhhWkhEcVdSaEVEY1lH?=
 =?utf-8?Q?y6fP7UFSlCZJB7M77RhT5m4H/Mtb2ak6T0IjyRz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b469d1-852a-491a-0a3a-08d90ef3f556
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 11:58:41.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7CsGeWLt4LJETfFWgfI44gagVWh85NPltVSU3+ORZo/bSdFAnAfuVk0wdoD83717VVbM93tVukJKelzJBcaLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Peter,

On 5/4/2021 4:39 PM, Peter Zijlstra wrote:
> On Tue, May 04, 2021 at 01:52:36AM -0500, Suravee Suthikulpanit wrote:
> 
>> 2. Since AMD IOMMU PMU does not support interrupt mode, the logic
>>     can be simplified to always start counting with value zero,
>>     and accumulate the counter value when stopping without the need
>>     to keep track and reprogram the counter with the previously read
>>     counter value.
> 
> This relies on the hardware counter being the full 64bit wide, is it?
> 

The HW counter value is 48-bit. Not sure why it needs to be 64-bit?
I might be missing some points here? Could you please describe?

Thanks,
Suravee


