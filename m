Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F88EB64D9
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Jul 2023 14:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjGDOs1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Jul 2023 10:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjGDOsX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Jul 2023 10:48:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC411703
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jul 2023 07:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhFrOS1DWkeFiIGfPAxHEpc9ag7XrN35q2E6E5a5uGcxkGMKDOz//ktTycHYlyaJKxTSq5iRgvSWNHkGc5B3BjSb1HdzWiujdbqMHMGy+lnr+x1EuwwtaQ2xeTYKXR2Di10cbsVLJYSEYt6Uw5ylRbbX+dyw8aLkhaKilufUZMjnqbZCZHp7R4nN0+AZV213e8PEKK96ceWx4oaaosVRA1GWoJwgb4PBJMjOmB/Z6jVKEPqW59gJMaENyK87LGzAMRH7XCIfv4SLMT1+rLE5mtlehbRyyGBFITRnf00/uXsvrpIVLFoy9sHaEPMCfzYTMzfeWZDxbZKNNTlRtSc6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDVvawpl9/NLagBfc25lyGJ2pQ6+kUl+wyYwdXs7mhY=;
 b=YcEnjggAix5n6KAZWb1eAC+k5rasvy4NYuzWVR623Arzb1uRpoC6eKMl6OrG5ai/FKZ2LLNEfd4CK9o5vgRoKl8WowfMqEBwIt1zsOoKXQu0uRmSP94hfvhMW+f9mSEoAEFPZGSpCqWITInbFSTcebokp5nk2yWIlTMh+KOOeIsUCpRV0T+wr0SHojQnp1TY3ywg7c3IyhN2LeHWD5qnvugOiaFFMgwTDFjbXGsy0IHDXrB7W65/5GuqnifSdcU6b3ed/0IIyYaiKQitGt4j+kUe+1qosg1g3VO4r2wOL2FcbjcjZ2eOln6q+n7u1rKtZ5XpQYqoeJ5fFj2AFrzq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDVvawpl9/NLagBfc25lyGJ2pQ6+kUl+wyYwdXs7mhY=;
 b=LTP5H72BBUyzInISW3ZvetSNmZRnQcMc7UfU//9yCtBVRRLUeGYopMr6BjLhFjjnLtVlnMTPad4ZlAHlvcA6rUEVM15DNWQOmWnDq9xkTCleJcxopS3YIudhaooIisR/IGAiH0tSPCGlQywsGv028H2B64y/3r7swCOPZk37tMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 14:48:14 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::c4e6:4e87:551a:7731]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::c4e6:4e87:551a:7731%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 14:48:14 +0000
Message-ID: <d10f0677-e7af-963e-faed-5228fd70b3fd@amd.com>
Date:   Tue, 4 Jul 2023 20:17:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: perf-tools-next: Request for testing hybrid changes
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
 <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com>
 <a3958a0c-092f-b609-e2ea-0d35fddd4375@arm.com>
 <CAP-5=fX8Nwtra=EgRNh3Ybp+N0BKp4Cw=0uRS9ZCdPyGF4R_bA@mail.gmail.com>
 <f1cfdc5d-19df-5d71-15c4-59af06dd3d28@arm.com>
 <CAP-5=fXwdc4VK=6dEoD4V0Jp+unYghWYTfbN4ER2aYd9R52W1g@mail.gmail.com>
 <01bc8040-92ef-cf8b-967a-6782989ecf33@arm.com>
 <CAP-5=fVkRc9=ySJ=fG-SQ8oAKmE_1mhHHzSASmGHUsda5Qy92A@mail.gmail.com>
 <6310725b-cc30-49e4-d405-ed2d5f31b404@arm.com>
 <cc134bea-dbe3-cf41-4769-440b8c69e9b4@amd.com>
 <10d4d4b1-5611-3276-2422-c297f0530ce1@arm.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <10d4d4b1-5611-3276-2422-c297f0530ce1@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0219.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::13) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: 42be0565-f538-4f76-6019-08db7c9db224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOk5C5vfhRukMFABUVktBu7KFfK8455X9P5heR/LX2S4oQXuEwNqU2fFAKym6Nvw/07T3IMtuuVtYQ9uAa8aWbLfY18oh9F+M90JeYTzbbeh1ke9D+TCB+P5nSLMNtF9nBS/RWBHy7xpwZarP0oQw+q10NZWSTNsbjKr7qmH1r2qZIOXKAQVgxi1rI7S9jBpZoN45kaywhZJy48o/+fLyHguC4ve1SAmOZUgUSKu6AkoI+eLNS/lWf1zTvUNCs2+QRkodaGYnqG/LkcLQJApBXOzpRmkJY/PXTVFr3hXZGoCzdzDSwT98HTOo68jb8QEBpPrlFTDt5H2IQ1Ie2m6kpFmR9awvTQJKhS4an7Sq1E1By6ZAy9WgOX9hv0vWnpeji95esuioF+1qI7RcAbstAA5O38fta+1oEuUicz6Vj4Y/fgCcoeHcrpYvzppg05ZCl6DBkJbwLzH3aSVVbUbPA9AUo9gopKJHrsDi/FI4Cjn0XXI8goCYifujIY5KZYfzc4CxJqByVi3IFBtm/bkmHi2rb1T2iLObfal7fn0vJM2SVQseDeiGTT8aweVAHpkyQec6wy56BYHbvpb1LfR1y3/6p/B79Y7IATO/rhpGiH0ROucP+L7V+4o1CiAIu5CI7+f7KgvOj5X+QNgWG0qnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(38100700002)(2906002)(6486002)(8936002)(110136005)(54906003)(8676002)(36756003)(41300700001)(44832011)(7416002)(6666004)(478600001)(5660300002)(53546011)(66946007)(66476007)(6512007)(186003)(26005)(86362001)(6506007)(66556008)(316002)(4326008)(31686004)(966005)(31696002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em85ZGlxZ0hnTkQ1ekp6YllMZmljVytNZnMrd1UzL3FSWmdrSzdWLzczM3pH?=
 =?utf-8?B?bWQ2OVM4WFV3RXVRZ1ZWLzNtQU9XSEVJQVdCbGVhVzhqSjVvYURCN29BcUVl?=
 =?utf-8?B?VTQ5b1B2Sm5CRjBGT2lFbXRUTWZIaXRReFNHQkp0aWtRd0VDNEhuY1R0dlln?=
 =?utf-8?B?N2tYTmFaYXdvUS92RTU0MDRSTDk2aWZYcHpBVTZZNnBLdjkwTFNNaXphL0lU?=
 =?utf-8?B?YUZzMnYyY3J4UEhnekc0c1FCa1ZMSjI2Q2d5RXAzMllVSjlrOE14V1REMENP?=
 =?utf-8?B?TENQYnkxN1ZTNEtxVXpUdWRueHQyTFRUM0Z0SFhWSVNwdzdWNVFZOGpiM3RH?=
 =?utf-8?B?Mko1OHlDRm1HZ1FLUFh3RUhOY2FOTnVwbnBLT0llRG1yV2l3ZFVPZ1pmdVJZ?=
 =?utf-8?B?cCs1N1c5c2lFa1JDN2l5dlZRSlhGQ05oZW5pRDVpRzVGTjhsbzhVRG1mQklL?=
 =?utf-8?B?N1Njc25MZ003enJycHJkNjMvYUw0TFJiNlVxOEpyUS9Vd1ZaeFNEUW5abDYv?=
 =?utf-8?B?QkFrQU9wTXhZVTRzcXFQYi91L3JVL1hIT014SzloOTlYUmlzcG8zMm4rdHNC?=
 =?utf-8?B?eVJFOEhNTkRZUndIMWtNeXFDWFpJMFpoN3laY3dzTGs2WUlqUzNJWnZkN0dI?=
 =?utf-8?B?cGlMcWNJYlo3ZkhyalBjeEM0cEhXOHlUNlZ5ckRvYzlETU1tZ1BwTkpkR1Fx?=
 =?utf-8?B?K0VWNnNkV1dmUDcrZVRTWERYcWtHTlBlZGRUVnFNam9GeE1tekhMZlp2ajRF?=
 =?utf-8?B?Qm83M2VDNm9VVTlMbUI2M3VzalY0K1o4b1E4bXUxaFM2TjVFUHdITWpXT3B5?=
 =?utf-8?B?OXhRNmNnalBtKzM4RFA4WXBocWwzUEhEU0Z0Z2NLWGo2VHB0b2lBMEh2VC9T?=
 =?utf-8?B?WGZjeERwQXVSenJKWG1RSUYrN2FMOWpFZ2VTUnRzRFBmN3Q1NUZocGpINlhh?=
 =?utf-8?B?T1pLNlhFRy96b01HRjhudm8xMFFac011Rk5OYmZ3OWY2YVhJTDdwN2lhMTZI?=
 =?utf-8?B?NGE4VVdFZHhKQXRtVW5xRk40Vk43Y3F3bHlKMnZURE5EZjhNNS9zYXk5MTlW?=
 =?utf-8?B?Z2hSem5Nb2MwbjZuK1NlK3NIcXNsK2dXZENLU2Y5QlB5T0lGYWYrSS9ycmJ2?=
 =?utf-8?B?Y09uR2Zqc2hxNk1wcENaM3VqR0ZOM3NjaWFqV3RJaDZEcWNrZG1xZlNnWlFH?=
 =?utf-8?B?bFFnd2dyejd3NWlVemVwL1lkdkhDSDhPYkVzR3V1dDJkYUdkdlB6STBmOGtI?=
 =?utf-8?B?VUdxVVh0SlJJRERUZndqTkx4citvcE5acGVWQnJiUFRmVU5ZYlVoK2t4OEVS?=
 =?utf-8?B?aEdLaHV0RWozU21HTTR4U0w1UTR0b2xOOEFmWEdNOFdKSmcrMUZ2MWpydXQv?=
 =?utf-8?B?L09KYzJVbmcxQWNqYzMxRWphc2xSSXJFZTJtdUZ5amt0OFJFV0RIbWNkU1Iy?=
 =?utf-8?B?OCtRMi83M1J4WHBQd1cwSlJJSmRSdkZFb241dXlEYnE4LytjTGpMOFc2bzlM?=
 =?utf-8?B?TEltaHRlSktodUorUUdOMjRLS3ZaYk9xTmlURkFVTXJMeWFsa2ZUaTZ4V1Bv?=
 =?utf-8?B?bncvTGxobDhJaXArbElQQUdBS2dHOU9ML2N3ZXRhajJ4bG05OW84cnh5RkVW?=
 =?utf-8?B?VGR3TnY1L2VpZm9vbU5wMDdRWFJFT1d3cUZIOEcwVUNPSWZXRjM2MTFlakdq?=
 =?utf-8?B?UFFqQlNDTVlMaW9pa21SelpvNzJ1Yjd6QzBZSmVsUUx1K0k4MWFWTGNpdU9z?=
 =?utf-8?B?cDVoM3lZQzRyS1JzcGtCbUZVMmpRYTlhdVZFR21yTWNFWHc4QVEyZGZOR3cr?=
 =?utf-8?B?RnhMNVNoR2J3MFFIM0FkQmJDd29NeS9GUGJFUkdjOVBnZ2lROFllck5UaVBG?=
 =?utf-8?B?QlVITFZYTm44cXNna21NQnFwUWZtWUxkdTk2eFVDRUVLaW0zQWVvTHU0b3ps?=
 =?utf-8?B?ZW5hWEdtSFNLelY0MVl0ekU0Sld1K21wNklpY3FYNkg5Y1FVb1UzalQybHBv?=
 =?utf-8?B?ZW1nUTE0a0ZwY0tSckdtZ0IvQUZtZGlPc3BjMTBSbDdLRW52amFYT1EzUS9E?=
 =?utf-8?B?N0JvenpUd09MUGlBZ3hVcnF3T3FqZVpZTWk5Yk1Ldm1ndHZ3TmE3Z0NMSkJw?=
 =?utf-8?Q?Sq8DJg4ghQloDILelpDbGMN21?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42be0565-f538-4f76-6019-08db7c9db224
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 14:48:14.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njaY2yXaj6QSGs7k9mBzdLxgQyGMz+w3tV9OAuh/Z5Qee5kcnQSGy0k37pnA/8cJXKhbgSiXmFtdGw7D0Ys1mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 04-Jul-23 6:14 PM, James Clark wrote:
> 
> 
> On 04/07/2023 13:33, Ravi Bangoria wrote:
>>>> For heterogeneous ARM PMUs I believe this is exactly the path taken to
>>>> cause the perf_event_open to fail. The resolution is to add the bit to
>>>> the PMU's capabilities. I believe doing it here will suffice:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/drivers/perf/arm_pmu.c?h=perf/core#n877
>>>> So:
>>>> ```
>>>> .capabilities = PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS,
>>>> ```
>>>> becomes:
>>>> ```
>>>> .capabilities = PERF_PMU_CAP_HETEROGENEOUS_CPUS |
>>>> PERF_PMU_CAP_EXTENDED_REGS | PERF_PMU_CAP_EXTENDED_HW_TYPE,
>>>> ```
>>>> Now strictly speaking you only need this in the case of heterogeneous
>>>> PMUs, but that's the case for other bits here and I don't see special
>>>> case logic...
>>>>
>>>
>>> Hi Ian,
>>>
>>> I tested the above and it seems to work fine on Arm so I will send it
>>> shortly. Some of the legacy perf stat use cases are working better with
>>> it so it makes sense to me. I also don't see a reason to not always do
>>> it even for homogeneous PMUs. To be honest I don't see a reason not to
>>> remove it as a capability and have it as the default behaviour
>>> everywhere? It all happens in the core code so I'm not sure adding it
>>> per PMU device is necessary, but maybe there is a reason?
>>
>> EventSelect on AMD is 12 bits where upper nibble is passed via config[35:32].
>> i.e. it conflicts with the semantics of PERF_PMU_CAP_EXTENDED_HW_TYPE. So,
>> please don't make it default :)
>>
>> Thanks,
>> Ravi
> 
> Ah, thanks for the answer. It's a bit late now but I wonder why it
> wasn't added as a completely new argument to perf_event_open. That would
> have avoided that. Is there a difference between adding a completely new
> argument and adding a new argument by stuffing something into an
> existing field.

My bad. let me take my words back. I forgot that perf uses generalized event
codes for PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE and does not use actual
raw config.

Anyway, I think there is still a bit of ambiguity with this code. For ex,

  type = PERF_TYPE_HARDWARE;
  config = 0xU00000002;

counts instructions for 0xU = 0x0 / 0x1 / 0x3 / 0x4 / invalid pmu `type`,
otherwise perf_event_open() fails. See below simple test:

$ cat test.c
#include <linux/perf_event.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/syscall.h>
#include <unistd.h>

static long
perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
               int cpu, int group_fd, unsigned long flags)
{
        int ret;

        ret = syscall(SYS_perf_event_open, hw_event, pid, cpu,
                      group_fd, flags);
        return ret;
}

void loop(unsigned long config_upper_32)
{
        struct perf_event_attr pe;
        int fd;

        memset(&pe, 0, sizeof(pe));
        pe.type = PERF_TYPE_HARDWARE;
        pe.size = sizeof(pe);
        pe.config = config_upper_32 | 0x2;
        pe.disabled = 1;
        pe.exclude_kernel = 1;
        pe.exclude_hv = 1;

        fd = perf_event_open(&pe, 0, -1, -1, 0);
        if (fd == -1) {
                printf("type: %d, config: 0x%llx: Error\n", pe.type, pe.config);
                return;
        }

        printf("type: %d, config: 0x%llx: Ok\n", pe.type, pe.config);
        close(fd);
}

int main(void)
{
        unsigned long i;

        for (i = 0; i < 0x20; i++)
                loop(i << 32);
        return 0;
}

$ gcc -Wall -g test.c

$ ./a.out
type: 0, config: 0x2: Ok
type: 0, config: 0x100000002: Ok
type: 0, config: 0x200000002: Error
type: 0, config: 0x300000002: Ok
type: 0, config: 0x400000002: Ok
type: 0, config: 0x500000002: Error
type: 0, config: 0x600000002: Error
type: 0, config: 0x700000002: Error
type: 0, config: 0x800000002: Error
type: 0, config: 0x900000002: Error
type: 0, config: 0xa00000002: Error
type: 0, config: 0xb00000002: Error
type: 0, config: 0xc00000002: Error
type: 0, config: 0xd00000002: Error
type: 0, config: 0xe00000002: Error
type: 0, config: 0xf00000002: Error
type: 0, config: 0x1000000002: Error
type: 0, config: 0x1100000002: Error
type: 0, config: 0x1200000002: Ok
type: 0, config: 0x1300000002: Ok
type: 0, config: 0x1400000002: Ok
type: 0, config: 0x1500000002: Ok
type: 0, config: 0x1600000002: Ok
type: 0, config: 0x1700000002: Ok
type: 0, config: 0x1800000002: Ok
type: 0, config: 0x1900000002: Ok
type: 0, config: 0x1a00000002: Ok
type: 0, config: 0x1b00000002: Ok
type: 0, config: 0x1c00000002: Ok
type: 0, config: 0x1d00000002: Ok
type: 0, config: 0x1e00000002: Ok
type: 0, config: 0x1f00000002: Ok
$

Max pmu `type` value on this machine is 17 (i.e. 0x11).

Thanks,
Ravi
