Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D78C4708D
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Jan 2023 13:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjAFNFS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Jan 2023 08:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjAFNEt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2023 08:04:49 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C6E718A9
        for <linux-perf-users@vger.kernel.org>; Fri,  6 Jan 2023 05:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDTE/1fYr6fHcucADeAvjSHWfZ351qGhF3jf7HaAyfpj+wVgZNmhF9Y+tYpLfBnaIiQu7OMBPIEEr1rI/XRBmDreXmXHQb+4WKdpPNYcvKtSYtVpoKoXKTlw6gRRICETRlDtcif2BtuikbOvXzmvISSlKfLdUHmRSonuhNTewaJq0mjU5a8GrdCT5Chy7ntxhsnpiyLbcuMbFTm8Uu+XtqYNzbpwmLDvySZS31nNK9/gj1VwdGW7vj55NYZVfKBBFoT9Gi70DTph8Fb6xqvDfl0CtX3/JiuFk2mqqzPZe8U5XhN8v9ZjQOb636LgKkt58+4nSy3Zhqs3A9Ram7I2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FC/3ACOQXy51M63ac+DgPkg5O+6V6mcZcGsDAKLYbmw=;
 b=KPKQr3mqNYRFgz9ycqNFiCaECJw2gRrjLyVbSGZnK8OBQtR1WK+KIHwIBtpfW8Qgkxoui3ThcnEQL6hcKG+bWF5IWmBuWqwyq2yYJxDQxetxdu7zqmaaYRguHUwESdK91lwnJoF8DsCQjasNyH1qAr95MFgZowV6sqZPQjn/qYkKY7wczz0XyO21CAcSdAw/NUbiOPQ5621eAmUpIlOfWqWFXH2Zv8mHH+pucsQGata4qrPVVCC3jOqM52JgZoilm5AUOYg8Ss7mCdruXVF/cdnSg5DUzk+5IrnCJxVl6PYgcdJHjzEqvUtUP80TPxl/m7AS7xSmGinD0CTzi2k08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC/3ACOQXy51M63ac+DgPkg5O+6V6mcZcGsDAKLYbmw=;
 b=xhBZiJXcTjyLowv73wxS2qSvIiQkwJoLARRYo8joCXRk+JEgw+StvONmduS+/MTNnASCBKU9HGDE6W2S+ZS5diLbmhG+dMEjIKaPGm9pmR3fEUqOlQgWa3TzKbHSXf32VgBI9Er3M291AIPPHxiaqoXf5aUb8Bi+H1QipzamG1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 13:04:42 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 13:04:42 +0000
Message-ID: <c4c5c3cb-f1a8-84ee-0dc8-8be0d63c820d@amd.com>
Date:   Fri, 6 Jan 2023 18:34:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [BUG] perf kmem: Broken because of missing tracepoints
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
References: <b5f82509-41d7-7598-6ec2-fcfa74c7ddaa@amd.com>
 <Y7b6cmRE/+5HJLCa@kernel.org> <Y7ewMG+0YKp9pgud@leoy-yangtze.lan>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Y7ewMG+0YKp9pgud@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::16) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SJ0PR12MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd9575e-46d4-467c-0c0b-08daefe69336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0rQqzjteCVP3aSjAmT1lT6DIFUNwtCOjJO5wf0zmxdQ1fepAT2KSMdGbOlMzZKkE/rI19J9mASgFtP/kgf3+x6mUEErS04ovnIgguOM/siXXvBewvOvPoxVl303Jp/dHc0DFO7Jd71oFYgmg0mB2sbGf7A2/DfcRu7VsOihQ0VDidYCAJ8RGQ1uN39m8f3phCAxphcmtUarO3awOLVsfCm6Uy8+tlgyFSgF19H07is7CdTjZMWt1E96kuH5McOTK2jqWyp7YQoidUgZAIrRRMlvGalhTWHs9uNBrQYsBHIvCveWy9QLR4WGUlpKq/TgQyd2m8hKtH98YrLUAYvynwkNWEpxAdPO0x5CtlMIE87N85HV12auU2adCO5G+1HXXBJG8gqVzc9sSJEP+xk5OI8yFaFr1TdUKZVZb6X2pH74DwDTuv7Z7XF2Vh1Js4wjYlpiB7NSXLtH1b/k+Vo/OvI8nIEYhfWYVPDCNKyS51zAlv8xqhhqj3naKhXLYecEB1wIZB44W59qkOwFxqOldDdjyKSuTInOR4KMDeX8+cgDjgnmGhM88HxRes2etG2qsG3r6FY6y+tE0J7mxIRIkoMU0ORLjy6WixlxgSN9WDGmdfdkanlUkdQ0JgMAD+NGWYQx3Sj4PyP+AlZrlHztKYrdGvu56mG4uJ2O+5ijZ/JrmC7qG699x+dsZ5FgVshTs1rvuBgG2f2y3DVX0h2Ya9XNtmrTUEllEOyDCfd09PQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(2616005)(83380400001)(31696002)(86362001)(38100700002)(316002)(36756003)(54906003)(31686004)(44832011)(8936002)(4326008)(53546011)(110136005)(66556008)(66476007)(6512007)(8676002)(5660300002)(41300700001)(66946007)(6666004)(26005)(186003)(478600001)(6486002)(2906002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUozZWlKZVhNTlk2am54bGY3NW90S2RhNURoQjloTThBRUpBUklkY3BORVRS?=
 =?utf-8?B?RTBjWklycnJyZThGcUQ5ak5lWFgwZHZBNnVSQnJPMGFOTE9Oc2RyaUxqeUs2?=
 =?utf-8?B?NlhTeWhsY0pKbnQ5Tzd1cUMvaDJSM1UxdjRkQjBXYW9iTHlzMnV1ZWpiNStC?=
 =?utf-8?B?ZjM3eGpoVXRXQ3FzYUViUUFIOGl3RnUrYlBDUkVHZDlXaDZHTDZGam8vOTBh?=
 =?utf-8?B?NFU4OVRIVEhkbThaS2sxTml0bTYvaVVxdS8rTTJXNEl2WjNsM2xnNTMvbC8z?=
 =?utf-8?B?L2xxQmUyZUVLL0tCOTdYY3pNRllNNXo1RDd6VWpUdVBGQUtvMUgrODZJVEY3?=
 =?utf-8?B?VkhGT0NnanlndHliTS9zcm00Zmp4SjMyOTNvYTFBN3FmSGI1K3JHSFQ1Z0JG?=
 =?utf-8?B?bzc3UkpUemFlU2JDbWVaWFNyTEdSRVJNdHNKditNQzR2YVZsMHFyTE9kZkZS?=
 =?utf-8?B?U0F4Tm5ycnc1OUs4bTJwVHhON2trTjB5UkJFM1h2Z3JoRjl0RmRJU0xBekRH?=
 =?utf-8?B?ZkMrVXorWVh6NS9EdVVHR3UwVCtPeklQOThmblU2ZW1wTlVZb3VUd3pvdmxj?=
 =?utf-8?B?MHZmZ2hRclFtNzkzeTVnTENHaVJaUW1RVzJYNDFjSDJOYWYvWFdHd3RCZjVB?=
 =?utf-8?B?NUZmOHFFWDEzUjZGeUlmVzd1OWZzRWc3RWZuaktEU1g2M1JGblp2VEdUbmFt?=
 =?utf-8?B?ZUhFMThUa2owYzNFdmx2TmRmb0szZVVxT3VRcmVTV3pzcFU0RWtpTkdsNkNH?=
 =?utf-8?B?NUFuc0d1bGF3aW9IUVg3cnBXY3dNR2V0VFFLQjRhMGYvOU5yQU51K0V2Uzl5?=
 =?utf-8?B?S3hlWnFCam1zci9sNjFIV0tzNWhFQU1CYjY0L09KeEZXcFFSSU81VlFBcGUv?=
 =?utf-8?B?YTBVdG8rcWprZXVpWFNncUNDZTdsS3puRzlWVTMwNm9TTkxBU2FLYUEwT0la?=
 =?utf-8?B?cXhaSjBZL094VEt6ZzNTam9YeFdOTk5SOWxNRXUwTGtUalJaSzF2WVNWOG9V?=
 =?utf-8?B?MUlWZFZSZG5vaTFxbXAycTlpY3U2VUE2WnFybjQwcmtRNVEvZ2hvWGhlUVk2?=
 =?utf-8?B?NDZ3NEpwN0FBVUdtUjIwZzlmVysrQ01ka0hPQ2pVdEVnS3NvM3NmUFBtU0NS?=
 =?utf-8?B?c1VCa3g3M2FHcVo4K08wTVJ6dHRGeWFNUFkvMEErQUNzSVVWL3BJaWo1b2Vz?=
 =?utf-8?B?R2oyWTQzaTYyenN1ZmpiTnNIU29WSjFmQ3ZvMUZhRFhLZFVmT1VnVmE1RmFp?=
 =?utf-8?B?QW1hdHpwZnBHdGJDN2dFbFVhTEcweHh6ODZRYlFSOTBQbTM1ZjM0SkVPQXdE?=
 =?utf-8?B?ZFU1bkJIZUlTUUw1SzdLL0doOTI4UmlzWkFSbGJDKzFzL1J0RG9jNXNqWkJM?=
 =?utf-8?B?dGREQjY4alZzTmFaVFl0TkdqMWEyUmR6QU5LUWl3aUNkdTR0RnJ4bDZiY1Yx?=
 =?utf-8?B?aDBEd1ZyUHAyTFF2ZlV3MU5jTDdmbmkwY0JKeExiSTJ0dEF1MzJDZlg5Ni8w?=
 =?utf-8?B?STIwY2J1WTFlaDJHUm5CazdnWHVPbDJXUHZTVUYxWFgrUGF5bmR3Ym1mUlFJ?=
 =?utf-8?B?dElPZDAxcU9OU1BybjBPaUxOZlRZeDdOS1llOVRZYjVEaWd2NkNFNmw3Mkgr?=
 =?utf-8?B?c0c2NnJWYXdiSjg4bDBMQ2FpSlorU2lEdWpjQXl6OTVXWmdsSi9SQ0dEK2dx?=
 =?utf-8?B?bFozVFVuRXhFdFEyamRQYzBuNk9rQ0k0eWNEWWJuWi9XN0dtbmd1NWVMcVhj?=
 =?utf-8?B?UEsvSG5hMlFKNFpCN0VJN0xYaDdFc1IzZ3pXTjNTaFU5cU54R1RNMmUyZzlQ?=
 =?utf-8?B?VDIxb2dxSnJmZ2hUdFdtRTZzZnQzMXpycWhML29Xa296MEwzRWNQYkt3YTYz?=
 =?utf-8?B?K254Mzd2Y3E5UlVqTTFpS0N6akowa3p4Tjl1TUU2MHhxV0xVLzVLeHVqSnVG?=
 =?utf-8?B?bFc1M1hldWdKOXB4WFJ5ekpwU24zTmJ6UGJwUXBRWGNwRzAvYmNTaEhBdElG?=
 =?utf-8?B?akh2VGRUN1JHMFZyTzlZMlIrSTRQQ1RWaUVhYUp0NVo1Y2lYdU43VzlrOFds?=
 =?utf-8?B?RWFRbHFsZm5hcGtNbjkzbDg3Zk1rdytUZmp1MEJqYkU3OHphc1k2emlhNXVR?=
 =?utf-8?Q?lDOJy2oJWfejQM0DbujVpUobo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd9575e-46d4-467c-0c0b-08daefe69336
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 13:04:42.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLQ5GUZKe+rmL4WbYN7+82aqjxKna5Z+1sTv5th19n/jR8vpbDjifdI4ZKfgeYQ1EKhYT4oI+0GrE3juZHNlyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 06-Jan-23 10:52 AM, Leo Yan wrote:
> Hi Ravi, Arnaldo,
> 
> On Thu, Jan 05, 2023 at 01:27:30PM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Thu, Jan 05, 2023 at 07:03:25PM +0530, Ravi Bangoria escreveu:
>>> Hello,
>>>
>>> Two tracepoints, kmem:kmalloc_node and kmem:kmem_cache_alloc_node used by perf-
>>> kmem tool were removed from kernel by commit 11e9734bcb6a7 ("mm/slab_common:
>>> unify NUMA and UMA version of tracepoints"). This causes issue while running
>>> perf kmem on latest kernel:
>>>
>>>   $ sudo ./perf kmem record
>>>   event syntax error: 'kmem:kmalloc_node'
>>>                        \___ unknown tracepoint
>>>
>>>   $ sudo ./perf kmem record
>>>   event syntax error: 'kmem:kmem_cache_alloc_node'
>>>                        \___ unknown tracepoint
>>>
>>> Haven't got a chance to debug further. Anyone aware of this?
>>
>> I didn't notice this so far, would be good to have a fix soon.
> 
> I looked a bit for the issue, so wrote a fix and verified on my
> Arm64 machine.  Please let me know if this works for you or not,
> thanks!
> 
> From b7d26f5543401924ae4ad93daeba66cd7d58eb39 Mon Sep 17 00:00:00 2001
> From: Leo Yan <leo.yan@linaro.org>
> Date: Fri, 6 Jan 2023 11:16:27 +0800
> Subject: [PATCH] perf kmem: Fix tracepoints breakage
> 
> Commit 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of
> tracepoints") removed tracepoints 'kmalloc_node' and
> 'kmem_cache_alloc_node'; the tracepoints 'kmalloc'
> and 'kmem_cache_alloc' add an extra field 'node' to present the
> memory node to be allocated and replace the two removed tracepoints
> respectively.
> 
> The commit introduces ABI breakage, both for the dropped tracepoints and
> for the updated tracepoints.
> 
> To fix this issue, perf tool removes the support for the tracepoints
> 'kmalloc_node' and 'kmem_cache_alloc_node'; for the two updated
> tracepoints this patch reads out the new field 'node', if its value is
> NUMA_NO_NODE (-1), we doesn't take it as a cross memory allocation.
> 
> Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Fixes: 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of tracepoints")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Thanks Leo. A quick test shows it fixes the issue.

Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks,
Ravi
