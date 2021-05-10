Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6704C433ED
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 May 2021 02:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889826128A
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 May 2021 02:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhEJCQL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 9 May 2021 22:16:11 -0400
Received: from mail-bn7nam10on2065.outbound.protection.outlook.com ([40.107.92.65]:20833
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230078AbhEJCQK (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 9 May 2021 22:16:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FA0LOeSyb0AZGMnGs+F2mTIlofZhGor9wVKNfzzdy9Zd8XU109/w0z8j2/DdB1Kday6NTIEq8HhXY2munvQvJCHLHxOyNQgtNCZsml4ZNwfTh3nBIdDNNFIedmoVW28muhIKEcuniBkVAqbmZxgvvcPQ6nd5cLheNOHxFoQTpfnc+q9X9PN/eZ+1RdMx0dlT/7Li1+jU0LqybpgwSqhdv94RGZZzhenBFHxS9+Na6bSBjWOqZvMNNs1rUqy4//py1NnGCtmrbGdr7N7d5InVIdrNqt7tPRdxF+QmZAJzZrTSipxdcqgW3h609gy0B0H3KrTducfEqQdYOwiy7XyNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMFTCxwarX2uPLoLJ/MmbG1RxtNFbMoR476de9YSlnA=;
 b=fq+unMuvF66HE5cZqYJ1EJdIRLdQiGvC1dPMIdjAKx/lDu7R3d9mk/j39hqEd5c0RX5gXesolWqPO7bMGUWTwJWJtDHijdODrqjhd4KBGd0Shgkm/R9rEHa3jT/xScHU/IQStuqLt5d+0DgqQhIh2vmckc/w/gJOLuVoign9AkUDqfBxxzMHh4MfXHsmIC3OcGppt6sbZvckgLovIt2yjIgVZbmErm4pyfvxnL13SwuWVSgif5H+B7aYwK2SX1P6gjo16ZiW+FQo7ShhnIpPEIi9HCJfviVcs3lLmuFtyy9qpiGej4kGB1ApPn87qaszmIVz2O0/AET3rMPa/tuXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMFTCxwarX2uPLoLJ/MmbG1RxtNFbMoR476de9YSlnA=;
 b=rdYnyrsYth27oiNWF/woqGEnKeSYHfVrTSVGr9s84zcDaz+eDNSt9+vytbo/90nn2GRaT8LwNzDUlbNU/rTC5CIwfFzGJnJc+FGv9Nd4DWRzjygHE9EbL2CgMIeVuK6Xwc/kgriTdgZPtyAXsCkSwGSb8YWYZFyE+k85kjXkyGA=
Authentication-Results: live.co.uk; dkim=none (message not signed)
 header.d=none;live.co.uk; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30; Mon, 10 May 2021 02:15:04 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::7de5:b531:897d:5e75]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::7de5:b531:897d:5e75%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 02:15:04 +0000
Subject: Re: [PATCH] x86/events/amd/iommu: Fix invalid Perf result due to
 IOMMU PMC power-gating
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iommu@lists.linux-foundation.org, mingo@redhat.com,
        joro@8bytes.org, Jon.Grimm@amd.com, amonakov@ispras.ru,
        David Coe <david.coe@live.co.uk>
References: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
 <YJEWWbEeDm0rUyC+@hirez.programming.kicks-ass.net>
 <e9769da5-3d2a-6e86-8ebd-feb00b567bba@amd.com>
 <YJE6eCyHtIONCJet@hirez.programming.kicks-ass.net>
 <ad67d625-9e59-2216-0f2a-88635a212595@amd.com>
 <YJKYAiC8GiiFPrWk@hirez.programming.kicks-ass.net>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Message-ID: <f9ccf3b8-5ce2-53f5-e8c7-0ab7dc0a4ae0@amd.com>
Date:   Mon, 10 May 2021 09:08:04 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <YJKYAiC8GiiFPrWk@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.89.247.160]
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.10.3.158] (183.89.247.160) by SG2PR01CA0180.apcprd01.prod.exchangelabs.com (2603:1096:4:28::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 02:15:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7453297-8b4b-4cb9-ba2e-08d913596c86
X-MS-TrafficTypeDiagnostic: DM4PR12MB5327:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5327F9ACD0C54DECC4E36293F3549@DM4PR12MB5327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGuZXuioWlKcDsXtth3n36O0/vkOAvaG3YkLjklvS6St4tf/mc3JaJxq0Sm4h3fGJs5wbGj5FmXpN+JeUXt8SiCSZCys2BZcitxycg15iuAkku72bhKkBVZMSYaXXO0xnP8ad663mETnzRtwkCT28ibUC8IcZL52m06G+DGfS7js6YziE83Oeab4Z/gvkthjtbsvFEb6NUiVPAKFbz6q1yTJoVM7UltCF4rFjr7EIwXgNqGSPi8hcgZLQBsRdjvCc+L1/WFomDI8ofn14j/un4kZ86MY27pU/0hfLTqqrGli4FG/riSVmqf4Zq2xlxz2raulDqMvKhp59oV0ih+9j8BELS6+5cXNF+ql1m+LeibNeaw4qxRNoQ6mLsCblYFYXXiD18N/XZIhoZv/RVL22BEx30d+aDippqh+NgRy32BJN/Xzb6JddnYn8VjsWw/2o+J4uUHq9LS2hunb6WqXVE7WdxDeBKC3HK4WwQbBJKN0WZQA6v+Qmh1KyYWOVpSRTuR7o5Z0/z8MP0WwRcVzWa7lelEe/dtqsnIn+ifK6/+AwdeAoG3BNfprhP9V0ByQurE7OjuBOODJHr1iDdL5lkb9O59WFcfemNt5V7HSdWjIQQS5J+uAgb5O22cr1w9s1xNwgYgSzB4xKv0SpkmLlLV6xK/zvpbm0UDmKETvG6Z0EenH+x4FZfH5/IhRl+ou423Y5F3OKxHJMJUfOXnoGVYomwL9dIqXNYCBTsfca/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(83380400001)(6486002)(4326008)(478600001)(66556008)(34580700001)(66946007)(66476007)(31696002)(16576012)(956004)(38350700002)(38100700002)(2616005)(316002)(36756003)(186003)(8936002)(26005)(8676002)(52116002)(16526019)(53546011)(2906002)(5660300002)(6916009)(86362001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eGM5SWpHcFhpRHhkaXJFSFpFZGhvZlVLZDJwdVQ0R2U4NWNmdWtGWURrWkJk?=
 =?utf-8?B?QVUrT0RSeEFSU3FacmJHVnd0NjNPdFZHRDhSVmh6UkxiQitTelVEd2VQQXFp?=
 =?utf-8?B?WGc3SldHZVM0YVZtVzl1cmFWUXZVaU55K2RIWkl6UXpkNEsrdlQ2cXNhL0Nj?=
 =?utf-8?B?NGRKaGlHSHdLcWdRTjlrbkgrSXdGUmQrVmhOYzQ3UEw1cVd1a0I2bVp3c29v?=
 =?utf-8?B?ckJhRnAyTC8rYmpYTHZoVld6TEp0SytVZUJySys5VWJ1M0lYbGpmNHBGcjVo?=
 =?utf-8?B?UVJlUE9kVW5xMkxVVDRoY2VZYUZOaDY5ZU9BamNZMmFwM0EycU8rV3ErS2ly?=
 =?utf-8?B?NUNJWWZTWXlieHBBZEhuVEE1OWNveTZ4VTJ0eDMwLzFqSWpaK2UwKys0M0I2?=
 =?utf-8?B?OUtwcWQ2MFFNKyttdXhXOFNYdXYvZ2dqUnc0U3NDWkVxZEE4UjFtak1NL2hX?=
 =?utf-8?B?Lzk3R0REanJ3aDN0THJJaGo3Z1ZvTHRieUl5eDg2N3UwQTBndWJUUjd5OGt3?=
 =?utf-8?B?MXBDQlhnM0lxSkFwTDZ0RDUrQWJYNlRLSlRud1QvTktEYUdnYk1kR0FrL1B0?=
 =?utf-8?B?eTJob3FjU0kybEFkYk1qTmJHYVNlK0xQUC9tMHRaTEVFYmZiVUxmZS9uNm04?=
 =?utf-8?B?NzNFSllSYUU4cCtNdFhYOFpzckYzL1dsWG9YRnBaQWN0b0Y5ckQzZDNncmpp?=
 =?utf-8?B?d24xSVF1M1VzSno3UGNUa2Fqc2I1OEgzVS85dGtvUldvQTBjRkJWTkVVTXQ0?=
 =?utf-8?B?eFYvc1E3WmNONjQwMVlDbEwxTFBRTVdrNG9MbklyMFVHT1N1bnZJRWpYY09y?=
 =?utf-8?B?Zm53ekFLaFQ2V3VKSHFTN3ZPNUJIUk1JK2ovNHp0ZGt3OGtocnhXU0tPTzlT?=
 =?utf-8?B?WGx2NVpuWHNKQkxnVkVpTEkrQ2E2Yko2S1FtdVllVE9KS2QxMzZPMm1hVVR6?=
 =?utf-8?B?M2EwMkxIalJQQXk1RmY2SjZqOXZTZ2FiM0hBU3Y5ZGVQL2tEeXlOaXkyQml2?=
 =?utf-8?B?d0kwdERDa2Z2WENCM2MzdUF0MlN2Und1bmd1QUUxMDlzSC84OTdDWDRubjVi?=
 =?utf-8?B?SjFKRU5tWkt3Y1BrVFJOYnVNN1RqNjFVTnFyLzVleFRWVllzdjRTbm1taUgz?=
 =?utf-8?B?S2NYb1JqdHF0YXpselVRN0JjKzJ4VnRKNDFFMERTUjN2WjBZa2lmWHhDMEJn?=
 =?utf-8?B?NU5wVWVDMVc3WDcvRGY5aWVMOHVZSk43dU56S21XaEdVTGlLbE1lSHhqQVlm?=
 =?utf-8?B?TXp6UEFUOHVHeERmZW9IS0tOMnRNSE1xVnJzVlRyQk5ZaDBTK2lUT1N1c0JN?=
 =?utf-8?B?RWZMZk9xT2FRMmdTazdKU201V3hnQVcwSFhQN1J3S0N1aHB0bG0weFI0UjVN?=
 =?utf-8?B?ZGVqQ2hUQW55ZVZkY0UvYzF3ZEljK2xSWHZHSnlyMGgzejE1dFZ6MkZVdjZ0?=
 =?utf-8?B?UFhJYW0yZlhpdWdiWGR3YXhCRXlUaUtKM0V0WEpvR3VNSG1RaW9qMWJ5MnlU?=
 =?utf-8?B?Q0hPZjcrWGxTeDJLNnN0V0F1dWRJTGF3YWJCRHpmZHVNMVdxbzNsU2x2NWEv?=
 =?utf-8?B?U0xoaDMxcHpXdlVobVErZ2Jub0kyWklXZk1LMzlUaXI1a3BYa1BybGZoOW11?=
 =?utf-8?B?STgwNXU4bXR0VjM2NVZ0WUN6b2MzaEgxYzNoZm1OTWJDRGZuUG9KS3NTT3cw?=
 =?utf-8?B?V2owbCt4NkptTE9DR0RjOEhuUXhVMnlGUnliVXpycUFrdzZYTVNBV21wVllQ?=
 =?utf-8?Q?sXiQVBHmpqrJvAwRUADxa1fffyqsB24lADf1BqZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7453297-8b4b-4cb9-ba2e-08d913596c86
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 02:15:04.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qe32OQMJyjaLxcMzpKzeH9o1CkKBR306uUxrLYviGwbwwSUiRGy7d/gEnUnoqwZgJTVBMrqVrxxVkNr/8TZOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 5/5/2021 8:05 PM, Peter Zijlstra wrote:
> On Wed, May 05, 2021 at 07:39:14PM +0700, Suthikulpanit, Suravee wrote:
>> Peter,
>>
>> On 5/4/2021 7:13 PM, Peter Zijlstra wrote:
>>> On Tue, May 04, 2021 at 06:58:29PM +0700, Suthikulpanit, Suravee wrote:
>>>> Peter,
>>>>
>>>> On 5/4/2021 4:39 PM, Peter Zijlstra wrote:
>>>>> On Tue, May 04, 2021 at 01:52:36AM -0500, Suravee Suthikulpanit wrote:
>>>>>
>>>>>> 2. Since AMD IOMMU PMU does not support interrupt mode, the logic
>>>>>>       can be simplified to always start counting with value zero,
>>>>>>       and accumulate the counter value when stopping without the need
>>>>>>       to keep track and reprogram the counter with the previously read
>>>>>>       counter value.
>>>>>
>>>>> This relies on the hardware counter being the full 64bit wide, is it?
>>>>>
>>>>
>>>> The HW counter value is 48-bit. Not sure why it needs to be 64-bit?
>>>> I might be missing some points here? Could you please describe?
>>>
>>> How do you deal with the 48bit overflow if you don't use the interrupt?
>>
>> The IOMMU Perf driver does not currently handle counter overflow since the overflow
>> notification mechanism (i.e. IOMMU creates an EVENT_COUNTER_ZERO event in the IOMMU event log,
>> and generate an IOMMU MSI interrupt to signal IOMMU driver to process the event.) is not
>> currently supported. When counter overflows, the counter becomes zero, and Perf
>> reports value zero for the event.
>>
>> Alternatively, to detect overflow, we might start counting with value 1 so that
>> we can detect overflow when the value becomes zero in which case the Perf driver
>> could generate error message.
> 
> Urgh.. the intel uncore driver programs an hrtimer to periodically fold
> deltas. That way the counter will never be short.
> 

Thanks for the info. I'll look into ways to detect and handle counter overflow for this.
So far, with the current power-gating, it has several restrictions regarding when
the HW counter can be accessed, which makes it more difficult to handle this.

Thanks,
Suravee
