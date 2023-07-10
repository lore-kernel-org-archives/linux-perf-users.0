Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13310EB64D9
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jul 2023 04:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGJEF2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jul 2023 00:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGJEF1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jul 2023 00:05:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F8BE0
        for <linux-perf-users@vger.kernel.org>; Sun,  9 Jul 2023 21:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnCHXjSpO6M1aXV7KW1tK12VDJdetnnZuQdY1m41XqIDehBUzLwNZz/6hOr6LTpP9caNYm2bz4QIDhYE+HNrQA8oL5rXLxuZ6yWilhSp3lpgzk+2pKeH1z7XwnUnwFc7I+1A9Z6jRNipiw/zbbu0mGkBE0eR95birxgFYuebMcnYNYqIUrfnAmWcwCM1v9alH5DPfh8b4DTnp5FGT0B4OrIaFlJHFIGkpkhjhZYZOSg1BKEV3FUojRWe3VC4mXz85X/LEVvvVdyEv7Zdx5A3nlv7xIljEX3wocQufNF5GoJIr5qkUTuBU6QlqLHN3TG0+Y+vbx14yMsjKzmhMgSGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5gHld12YMmiIIMZUkJDFlYotKQOSl4ght95tSJ04gc=;
 b=Cd+szBb0/FUnsUp9n4ptXsYWM6VfXobkZA9RKvj+m1lF3gXA6HJC8iesQ14t9tMLFo13Pyq46hOfPWZSiTb4pBphPabE/4fgy+bxLJyOjTTp1cTrmwAWdyKUwp2+tU8GZhVIlKuZoM5RNe3BLWzmp8icqgc5cEtndvske0dbtxGuHgwQJOubakSMhepRZfe7O/T4hdUOyfJsL47XcswOa41bu8RAqFFiHvgV0yxwEhPaOI1SpvOaXXn6v5svQDzGzmrlhzMcJapDA6bG7SCwbcVdm2kfsXdTqRQSzOe7E/pfQOz2IPYrHzjrnR3kRleLwRVVU1w8ozmutoDY0qMYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5gHld12YMmiIIMZUkJDFlYotKQOSl4ght95tSJ04gc=;
 b=CVLKbu5cB7rfiWyKm9kecEGWTtLUeLCZKQXZxbL/nuXUNgGEjtQAeO4oQAKO56Q7KHH6sPcIx3cDVors4sgz8G2KUSJzu5X+Td+33bb/AI4VuOMtudz/FSqaoehlhUJEkoRJ6oyQsuhcelg54k5B+2r5ecl5jCwthFigpdnalX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 04:05:23 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::c4e6:4e87:551a:7731]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::c4e6:4e87:551a:7731%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 04:05:23 +0000
Message-ID: <78044efc-98d7-cd49-d2b5-4c2abb16d6c9@amd.com>
Date:   Mon, 10 Jul 2023 09:33:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [BUG] perf test: Regression because of d6e6286a12e7
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     andrii@kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <ab865e6d-06c5-078e-e404-7f90686db50d@amd.com>
 <CAEf4BzZK=zm9PkUwzJRgeQ=KXjKOK9TENUMTz+_FmU6kPjab7Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzZK=zm9PkUwzJRgeQ=KXjKOK9TENUMTz+_FmU6kPjab7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::22) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 54aa4317-3a1d-4c61-2bb1-08db80fae204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzN0FHCQtPjtkhZR0fiv5MttdLvNHzXJ3sAiXkx2A9lttlcpvUFJ1yG+w50qA4/ny05ARJ3Mo+KyLRjXCY8ZgEEeNO7GNUKRli0X5QuvvD5SZQqWDKsb/eNdqx07VgwQcysrrfjC6sNCeDBjAoW6HMX1r1cMYzgcFYTnlixbwA0droeq5k7WbInop9bWDWNebtzU/HRSI6QuXs4i/nW+1nGB8PMmYAkDKLkfbpDdX44y8vPrKv5LGNsIOCsK+QZ6oiVcnGZQdLrb3fwKJaDidEHkg+Sknvee/rbxhN2xqk0qLS6/PBpoxQEwwGH854292bkN5fvOH2wjG8Q9esQjejMAri5KJwXa6rHs9XkMUDFftl2kEDltxjAKO3KWmVxZKms8zIeh6OskMt+2HUWlUkLTdz9t6WZ1DdP0T8g1UJ8YT8ASNviu8cU02RV3DJkqVqmYyVAe3RRS/f4JSgIdendoVKMeJqPX9PzSHlJSpA3//5jSjEEJlByLxceOYR6mmmURO9OiMshvrEdGErARXDiFNwLYZgYg7n/xKhYvvb3u4Xrw7xjH2LwXhQzPVm/HW7BmuOp0bGjdj81sUfh2BrUUHTBSpxGEsStqDBYBxr3uB2vhMVeZQs50Ur7gE2apkoAYNFjGAAPPdWYzF+oJ1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(86362001)(38100700002)(31696002)(31686004)(36756003)(6666004)(6486002)(54906003)(6506007)(53546011)(186003)(26005)(966005)(6512007)(2616005)(44832011)(5660300002)(316002)(2906002)(66556008)(478600001)(66946007)(8676002)(8936002)(6916009)(83380400001)(4744005)(4326008)(66476007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkNwZTl6blJnN25GWVdmQXY0OVovaUEvSXdHdzBhMGk3bGp6Nlh4NGdjVFA3?=
 =?utf-8?B?K25hYjNKVm44WldTVlhjU1FBeUhQY0dSRm5BQ014K0RtVHJHNlRKL2cvSVVQ?=
 =?utf-8?B?Z0xubk5wOGpydW9kTXJxU0hieTBKclRyOC83a3J6RXo5U2dObUZobnJYSFFo?=
 =?utf-8?B?aWhJVUg5Y3BBb0FZbjZWaFExMG9NVHFrNkF3U1d4U0FyUmRTV21ka2t1M0px?=
 =?utf-8?B?dHNmNVp6b2tBc1UvaEc1WS9tS0hKSFRpMXljekg1NFFOSHVNcHlxazVDVUIv?=
 =?utf-8?B?OXgyYS9LakplRS9qTDR3NVY1OWJ5Q1dPUU8vYUx4YmZOc0hqcDArdFpPMnV0?=
 =?utf-8?B?dDJVNjJyQkt0TGMwL3YxZUIwSlM1dHQvTmJ3UWM0R0lXUGVjSHdjZVY2ZWx5?=
 =?utf-8?B?eGFkUXlvSGppM3ZOcmZObU9VWFdBVEhHMTRZVllPMFRDeUx4MkFFV1kwVEg2?=
 =?utf-8?B?MkhTSERjTjV1VVN2UUJvaWR6UXZocENtcTlBcVBVVEhtMnBqT0pJaysvanZR?=
 =?utf-8?B?VHlPajZsZERjRWl4VjAwL21reXBZVFFnM2dOcmo2cENJY2NFR2RmalNTTDdi?=
 =?utf-8?B?Wm5TRUNGTGMxK2tSem93RTcvNHE2U1Zyd2JoYzQ0aXZ6akFLZHdJeDF2R2gr?=
 =?utf-8?B?b2dyYmVhRXpzQUhWRDNjVmQ2ZUtsMHp3M0lQRUZMb0kwR1FnQVNKYmo5R091?=
 =?utf-8?B?cHhsejdXdEtPUlFtRHpBa0hsVXFkNFladlhUTnNkaGtVY1NjR3lUL3VVc0Q1?=
 =?utf-8?B?VytiZEFYY0I5UyswQ2h0ZGI2R2VjQkpwL2dYZndTOW5FVFdhTG95YWRrVXR2?=
 =?utf-8?B?c0cybTkrNHNwVUFFVFpmT08zd3FKbHVsMTl0UDE2QlJFREllZEV3V1VEeWVP?=
 =?utf-8?B?THJLOU1uSDUxcU9JTVBpaVVEeUlvakQ2ck02YnBFbTAvUytmNHJvandmek1l?=
 =?utf-8?B?VjBxMTJjQ2RzMkdMRkEvZlRFcXM5UkF6SVowWmhoZ1l5dmVVNjJTbXB4Qnlj?=
 =?utf-8?B?SS9Fd3pRUkFkNlhGaExZa01aR1o0R0lyZmhMYlZYWUJZdmo1YXMwcDRnallm?=
 =?utf-8?B?U3lDNUk5ZkRIZDRNbDUyN0lFUG5OOCtqMnpkUUlrWVVVbWx0elVnbW50dEZq?=
 =?utf-8?B?azNlUC9LaVNpRGdzeXZCM2p6VFdEL0M3dmE4akFBakM3Q2x6Y281ZnNheHI0?=
 =?utf-8?B?Zk9xeVJwcEg4YS9YalpLVE5FNEJoeEErT1NUTnI2VUJPQlNuV0VYRXJzZk5U?=
 =?utf-8?B?L2pJR0Vzd1FPTkk5alYxQUtBb1RDVXp3aS9rRFdlOXFWd21qdEEvaXB2YzZ6?=
 =?utf-8?B?Zzd5ZXhGcmwzNFVvQmJOS2dRbXh5NmdzNHR0ZElxUjA4SkFBbXZSUWNVWXkw?=
 =?utf-8?B?NFd5TnVJMHFINjladGFONGZqUHBDYlRVWFpqZ2lzUDIxVDBvSHhZd01LdkxY?=
 =?utf-8?B?VGZPUWV4MkY3YUpkOHFLd1EyZm83Myt5QTJpanNoeCtvZnNOWXFqbUsrU1Mz?=
 =?utf-8?B?T3Vkdy9GajlXaHd1KzV2dlZFZE9KaHloaXhGVzhERi9sSU05Y09WSy9Ja21a?=
 =?utf-8?B?YzZoOHhSbjVxd3BTcURhbU1iODdCMFgvUndKNUJmL2hBc0daUzRNdm84WnRs?=
 =?utf-8?B?YUkwQUVOV2JaNkhtOFQ3cjU5VGwwb29IZm0yc0N0dUtxTjJzNHZNTnRHTmF6?=
 =?utf-8?B?UUVLbWl1Z093Qm1XSVR5UUhVREVVc2M5UCtpRXQyNHlJQU9XL0xKdVJkZTBi?=
 =?utf-8?B?VTBFZjM5MVE5U3VxT2YvTi9KaDJFTy81WDd2cUpJaGpaZFh2UkNONXJ2TTFH?=
 =?utf-8?B?dzZSb2t3ODBNZ3pZRWJtanhMS05GdFF3aFNyR1daRVFBZnRpbE92MG1ONHhG?=
 =?utf-8?B?Zk9wV2k0cmxqbk1Uc1ZXc2NzN2FDazQ5NUJySFdDSDNxMTJxSHZkdXRUc2hY?=
 =?utf-8?B?SU0rV2NuTi8yVGFPWVpGVkUyZVlTdlN2KytWS25kWnkyM2lJeXQ3emFKUjcx?=
 =?utf-8?B?ajlERzU5QXpvbEprZGg1aVVVZDVyR0VyUTBmVzY5bExSUndQMGFCYWdLT2t0?=
 =?utf-8?B?YzBqSExrOStkZGpzN1I2QlpIM1NkT3Z6dDdvUE9kaTVScEZwV1UzV2ZoT1VE?=
 =?utf-8?Q?xLsB07Sj+LBGi4yY8Zr8Va34f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54aa4317-3a1d-4c61-2bb1-08db80fae204
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 04:05:23.0192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFe1usILZPA9RIfVki0x785ClV43MuCtq3HTqfFYRu3g/TfQPpu/fhTK7dmspZaW1oupTVTSO92wWabYk94sow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 08-Jul-23 4:46 AM, Andrii Nakryiko wrote:
> On Wed, Jul 5, 2023 at 9:39 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> Hi Andrii,
>>
>> I'm seeing perf test failure because of commit d6e6286a12e7 ("libbpf:
>> disassociate section handler on explicit bpf_program__set_type() call").
>>
> 
> Yep, this commit would reset catch-all custom handler, which perf is
> setting. I've just sent a fix upstream ([0]). And once it lands, I'll
> cut a v1.2.1 libbpf bugfix release with just this fix on top of v1.2.
> 
> Can you please double-check that this patch indeed fixes the issue for
> you? I tried to do this locally, but for me perf test 42 fails both at
> current bpf-next, with the above commit reverted, and with my fix
> applied on top. So I can't be 100% sure.
> 
> Thanks!
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20230707231156.1711948-1-andrii@kernel.org/

Thanks. A quick test seems to be working fine.

Ravi
