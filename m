Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64105C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 21:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3794E61108
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 21:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhIIV7a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 17:59:30 -0400
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:26560
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236164AbhIIV73 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 17:59:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aowYjgXPwnnq8Cfk70IVx6Yz7oGPO6hhlix+6Y1N0B4hN4O4g8cuHgKyCOYCj/eKcWQhgUwq5Wg5ZI08HJDTXBvEpkwebX30FbahWQF99ENIr6v8xnbNU+wgFDdyo+zH8nxx0ABaeVYp9fdlkCN299GdDIc8PVEW8287sws35FoOMK06SwCp4cXYJ+DnWxgsEkgQO6+C8B6vNDpP7m9cij7z8o4hx4CAd799Q1IaZMWz9/WV58/898M7Ku3qChtPokxgZAtGCCzVo+M/F/881gu7zCQeeaBG91ptvPYFLi37KiYaL3GunEW2cohQh1FHgZtZ8KivDg2RjJZawcEVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=X+gcyVVVVD3P/ZJvexYPosKmsK07h1RmfWlNxlH+/z4=;
 b=N5xBefvF49tHriJqMIVj23qwl7CNIFxTfMQemnrj+b9iptMoUYTfqTasD0SUFUZmtzUYxmLtwLMNSVrf9avrjqLjkPV586z1UKjV9eQkyTWjR6p1S58cdQApATiGpXIa6M82BGsQ1I1nddbibXobGTfxBeNBOWUC8/ZdieVGPkmpdNSzizrlnjGLuGrG1w6cZ6HVmdSnbPxQcAG8646fT+Zp4M2c5Cublm/0p3iTseGVubt/HumEiYFdW/VmD25agv2gDqcyokZESJnd9vijxiO3WPxIg+exBDIMhTw3NHm7vZrPJQ2jP5t5WhY7aaSMCyThduFL0qDjQ0hKzXSspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+gcyVVVVD3P/ZJvexYPosKmsK07h1RmfWlNxlH+/z4=;
 b=jc2kaCvnk65EHbYGlBeBGv5CNgnV9QheiZGvjUDE6wbUtE60SbP0Uav/QaebBvIe3jQVDxb1DDYkRt160kQh362GEEj+IplJN0xaNnQagP1CJ7OzqvBEZl0FF0D/ZOge+5QOrByvy0EOC4qrPMr++47tBCHDdomjDQ0whyXpcMU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN6PR1201MB2497.namprd12.prod.outlook.com (2603:10b6:404:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Thu, 9 Sep
 2021 21:58:18 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::6d16:4fff:445e:6329]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::6d16:4fff:445e:6329%7]) with mapi id 15.20.4500.017; Thu, 9 Sep 2021
 21:58:17 +0000
Subject: Re: [PATCH 0/3] perf report: Add support to print a textual
 representation of IBS raw sample data
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20210817221509.88391-1-kim.phillips@amd.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <c4979e5c-13b8-0311-0660-355551ce45f2@amd.com>
Date:   Thu, 9 Sep 2021 16:58:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210817221509.88391-1-kim.phillips@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0028.prod.exchangelabs.com (2603:10b6:804:2::38)
 To BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [10.236.30.70] (165.204.77.1) by SN2PR01CA0028.prod.exchangelabs.com (2603:10b6:804:2::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 21:58:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d33f935-59c1-49ad-942b-08d973dced25
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB24970D37D156012291EF2A4B87D59@BN6PR1201MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1L3dF5IrCTgVjAiXXXlc7Sh1DWWTYtiRGXccO1iCJUKVRjb1+UyUzuXWn6hmwBpY+M99/zU6cZ/XyD1kXVU9BG5MZRRgIEVWCexxjxCTi6Qbr2mxe8DuTsFxdkhQHMqX/O8KRIqSmgUZFLmtcUGrjD6xv/nu4kryE/Dsu6FZpEhAXJBi3uOFcV6X6yXkX5yjWLcpjb2CGqhIWLcggv7VdTH3poccmlZirBNmDtl47/WiwsOzTDDSUWt6pn53iSgcSBGzbpcacUjFol3jJbcIkFBR1LZUkX4m2cncZRLFTJTaIFYo/h7lF1QYbb72Wcy6WH6WGu1xMQVTbp2HJfaGBDJjGUTqeLofoGcAaWRBJ4lZBDx9fZfW7WwfeJHLMgnoPA8sKVdRKQLhWFwMbjq9f5KFn4klljfPRJMwlTaloJCCIL+QD4HAEtqG0gWSFToLTsplMNnH2WnFiR1FD4O9fGd5Ijd9HOlNPEGiX+0XJSVX7nOEysIJ9Cb0y1pLGD+6uWeigPngZCfOB5RzXmJYUA00NRWXra+bluwXvxSSeTX/O6Estnbq5JJKGb0Bdz5IrzX8q7GOcq6GPddiKZiVLYKNyFXITZeRULl0xzOz1ncifcwUYbBYRGVhJfmJpCIEPzX2ravWw3ewVSdbrqHMxDksKkDTgP7+Rw9W89YNsARgW53BalVM7Xdqr+0DYNYpD5VYRMcp1qEhb2GbP9aIHGUOLHsQCyZlIrzEFbE7+1A1inRFkWAANAVFy6Hc4FA0hLFRI/Uk3XcejA6KON3WsPOq9HcqNzO+pZuPYSxOYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(66476007)(66946007)(38100700002)(6486002)(478600001)(66556008)(6916009)(44832011)(8676002)(86362001)(8936002)(53546011)(7416002)(31696002)(16576012)(956004)(36756003)(316002)(4326008)(26005)(54906003)(31686004)(186003)(966005)(5660300002)(2906002)(83380400001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1d3Q2xEcGQyd3l6azc4bnhYQmI2dHk1a0JxM3pQMkViM1RBSHM3ZG1GUmRh?=
 =?utf-8?B?d2grNEhsdFFXQTh5U3JkVTdERk9WOU5wYWxpRXhUVGVOVkMva3EzK00vMEla?=
 =?utf-8?B?MUd0RlZ1ZjJxZ21BQjNnYjhQcnNUT0lkQzZtTkVCdXpnYWJaTzM0T1ZrZFJz?=
 =?utf-8?B?aitLbmZQZFdKWUUwTHQvVDllTDlMUkloV3JmY2V4cEpNTSt2WjFIZTkrMnlj?=
 =?utf-8?B?aVNjMVc4K0Y4UWxBdU96TGIvTHAxWjA5MGNnMHJ6bUdzQjFpMjh4SVlrekVQ?=
 =?utf-8?B?aE03TjZBSEwwblQ5TmhHY3ZnelF6M1Jrd3hxVnU0YUtPUmZnYk56MUk4aGJQ?=
 =?utf-8?B?MEFyZXhxTU5qQXFkZXFGamlrSHQwdFVjM01lQjFoUldvNldLQ01ZaVlFRWtU?=
 =?utf-8?B?b1MvSTRWMTB0SFZFL2tQL2FnK2E0RlNScnEyN3J4OVlXVm95Y0Z6WVJ1TmhR?=
 =?utf-8?B?Q1Z0UVdQMVQ5WGx6Q3NhUS9NcGUrUGM3SHZ0VHdDWmQ1QXZKMnExOC95aUhX?=
 =?utf-8?B?U29uSnZoWmJEZEtLb0NWQnc1by9qNG1uc3QwYXhQaEhycVQwYWJmdlcxNW1J?=
 =?utf-8?B?WkNJektnNm9naVo1ak1LNnVibUkxU296T1J2YWd5NnZ0c1pBNjZNN04wOXBr?=
 =?utf-8?B?dkg4TWQycmxXL3lFY3JkTTc0ZytpK2JJazFRMjA3dXpmWVJQWGhlNjQ1dkJQ?=
 =?utf-8?B?T0JtSDc1Ti9uWXdkU1B4bUkxZ2xkUjdGeDdnNnRsWXp1WUdXY2VBWjdidGxT?=
 =?utf-8?B?Y0Y3NVhIa2ZZdldsdDFDeWcvT0pZa1dIekV0WGVmK2FrNEJTamE2c2ZvMmhi?=
 =?utf-8?B?VGVrai93U0RGcWVncTFhQlIyUUFWUlpnYnZDbExzTmc5a3MraGZDUTZPbEVB?=
 =?utf-8?B?T0FJVVc5c3IvRmZPQVkrTXJiRjNxWTZzUlVHUVJraEFPQWVwR1NFczN4dzZJ?=
 =?utf-8?B?aEcwbkRwSVZlZDZEOURNU294MkJSekRQSERUUFJJMnAvVHdPQ1duWmlrZS9V?=
 =?utf-8?B?R3VsZUx0NnJ3OE1iekJUNWRySi9tY1lOTXZBeGViUWxFVVN1Yi9nOWtFZTZp?=
 =?utf-8?B?U3VYTTJGTVovcmZCcXF4dVBLaEpEU2FLQStZeFZ1ODdGYTVrU1VNc1l2cWdh?=
 =?utf-8?B?YWEycldhQkc4Wk1EazNJWU9MN3dyOFgzaGdTOHpVUndaV1o0bEJZY1JPRndz?=
 =?utf-8?B?SkpQeDl6S2QrSDlyZ3VmcGRKMUwwSEJ0ZUd0MUY0YmdIWHNDN3VVYXo3YUYw?=
 =?utf-8?B?WVh3ckZBVU9jZDZuaGl5S1piT2w5S3ovRWc2QXg5N2lIcDVQdTBtNVhQellF?=
 =?utf-8?B?ZDlTTDRNcTRGenIvOCtwUXNFMThQU1AzNldGUkJYN2wxNDBjUzJBMm5LL1I5?=
 =?utf-8?B?elM1Qjh2NkNJZ0FBVHVCc1pTWkFZZE13allUNlRxSGNpaDR4cmZxTDBwVGd2?=
 =?utf-8?B?SXl0aVJEUFZyUkdpWVgyMTNrTll5ZEVXMHBWZVFWNXRodXZsb1RwN3phL2ZM?=
 =?utf-8?B?UWYrVGcxNEMwR01iMkptUHhtam9Fc3MyNWs2aVVCcy9GWDFVTjk0bE5wTS9O?=
 =?utf-8?B?SGFPTTRLRE5RaEhWRDY0d005Rjhoc0tyZGJ2T04vWm1ubFNFTXo2MUZsOGZi?=
 =?utf-8?B?UTNQam1kY1libkdSN2hvM3UwbGJHNlg5WFJndUU2UXc3cDY4ejIzUzJWSjJp?=
 =?utf-8?B?TWJpdlZYVkhIQndsM2xjMU5PMWs5YXg1WGtRNC9VYlQvaUYyY2g3ekc2OU5v?=
 =?utf-8?Q?Cz+Sv6wQ669GUdoF1hxuBYPbFc8pCE85M80EIyC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d33f935-59c1-49ad-942b-08d973dced25
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 21:58:17.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xadRg5wTBekZpDipl4SxFJUf98u3xgE5MbecMnuMt54an1ebBErBtAAtNiLg/MGZGk8/dxnPnYIMaNXXYYam0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2497
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

Can you please take a look at applying this series?  Its kernel-side 
dependent series has already been applied and is in Linus' master.

Thanks,

Kim

On 8/17/21 5:15 PM, Kim Phillips wrote:
> Hello Linux perf tools users and maintainers,
> 
> The first patch in this series prepares the perf tool to support
> retrieving cpuid and pmu_mappings data when in report mode,
> information that is needed to accurately decode IBS data.
> 
> The second patch adds a header file tools/arch/x86/include/asm/amd-ibs.h
> from a separate kernel-side submittion [1].
> 
> The third patch allows the tool to print a textual representation
> of the sample data recorded by IBS.
> 
> [1] https://lore.kernel.org/lkml/20210817221048.88063-9-kim.phillips@amd.com
> 
> Kim Phillips (3):
>    perf env: Add perf_env__cpuid, perf_env__{nr_}pmu_mappings
>    perf report: Add tools/arch/x86/include/asm/amd-ibs.h
>    perf report: Add support to print a textual representation of IBS raw
>      sample data
> 
>   tools/arch/x86/include/asm/amd-ibs.h | 132 ++++++++++++
>   tools/perf/check-headers.sh          |   1 +
>   tools/perf/util/Build                |   1 +
>   tools/perf/util/amd-sample-raw.c     | 290 +++++++++++++++++++++++++++
>   tools/perf/util/env.c                |  78 +++++++
>   tools/perf/util/env.h                |   5 +
>   tools/perf/util/sample-raw.c         |   8 +
>   tools/perf/util/sample-raw.h         |   6 +-
>   8 files changed, 520 insertions(+), 1 deletion(-)
>   create mode 100644 tools/arch/x86/include/asm/amd-ibs.h
>   create mode 100644 tools/perf/util/amd-sample-raw.c
> 
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Robert Richter <robert.richter@amd.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-perf-users@vger.kernel.org
> 
