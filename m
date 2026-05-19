Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29543DEFF7
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177622; cv=fail; b=ORgBjhbPzb9twyGkIeEzXRVEOjGFjYVmFTvXyQHVjmusA4VU39S56ZLQt+dL0V/t6cLIfo9RQg8rrI2LGGlS+sjh1Ej3Myf5JAV469nzN3/DtZe2J9QN1UD9Rtt7+S7wtuavgh4A+XWAJkMSTRVoPdwdeeKpDOs1h2WY7M1iuQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177622; c=relaxed/simple;
	bh=VGjhU1M2/+wrLmemzZLRc4m2wCRsI/+dWLy9aIN4+xE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SRijYqy+mydJSCjfrHgSafpMXN9hU+0foJiDeO1/+DpmhZ7hwG6ajakLZ3oIOW4l7Cv1iu5rgcp3uKhq85HrAN376XDXJ9DfRUd6VFTPGlbACfn0w/T9Cms/dzjQzXx+YESbx/3fltsbwGoaHJK68JDJlHFCHpE/7e9IzFBmHv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=chkZJGP2; arc=fail smtp.client-ip=40.107.208.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="chkZJGP2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DowfjTYvczUeqy0llW2P55CZxovcziDfvG+6npYlTv7D38Dq02gI0DGoUcrG8bXHD9gWjObvvvYQHEFvmjuTxeAwDjpyUt/zcs0T4GTsL3C/X7i4+/8yVbO8s+GspVAhNCKoNnM6Zb74wZhi1ygUbzUzFvcBj/VnKjD0TDdbmCiIM3yqpY6sDecT481DYYRbdPqO6emaz7b+FWpXBUOqFRKvm0kybuCZQRxJg+fy89iu1H3KXL6sxV7rI7P07sxnSwihg2TtgU5UJm10LEddgnhSw+juzgpkzUTRDJRIwBetohl5ZOxct0kl3Z8evBQtAGItrbneeo5zUsMv/d2hsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwYBtYXjnozUlRTOceDtsT1F8xP1UEF45UNztyeBmbA=;
 b=Lkp4X1r+E2LQyEC5960pwswY7ynYK9axdGU35sdBVYg0X8Wb/NJz2iRSezG/e4k0dv/GBYZIFr4NagkdNeGeLtl+93oDUbj7ZGM4970NdZlio3juTHrJKXISwnDJcovdk6TBkxdzqCzFAfwXIbfNuoRQh/RUOTSSDfuoJdmcohS564kk5biQYExiBzK9k+DSUqCGgJhQCbVuP1C03LcX91O8Ul0Mf9hirF2N4McJEg7QDeiwAWw7gDkcq1+FOdXbaus13rLocReVzQ6bbutLjQnIuPAjX6IylETlyERsK8BEOSN+sEkevNzcrNSZn+TVZts2mP29DImJhVcFXH0HPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwYBtYXjnozUlRTOceDtsT1F8xP1UEF45UNztyeBmbA=;
 b=chkZJGP2+aYESR9quTECbc/wAEiol4NIXgJLT43wARgQ/jl2OJUONg9QAwIGAvYHh+Z32l9cXwcEhvBZ4cOSORHUr8Q0zct4+5MET5qVLigf4gGABQyWCRpnchVpdsi0Lysq6btMK18FzNkKSQXmjlzuNlMhKiau4aa1nYM07+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Tue, 19 May 2026 08:00:18 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 08:00:18 +0000
Message-ID: <005aa032-e1a0-4301-87e9-f28608c09332@amd.com>
Date: Tue, 19 May 2026 13:30:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/events/amd/iommu: Fix cpumask of IOMMU events
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260517114026.6817-1-vasant.hegde@amd.com>
 <20260517121248.0E501C2BCB0@smtp.kernel.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260517121248.0E501C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0358.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::17) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c99596-6ec0-471b-2007-08deb57caa91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|4143699003|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YDrgOMDSI6s4qw2VSpi13xbK2oCdLjDhO5kYNWX3ui3aD8M4gNlr4KuonJJPeMioBr0itbvhjq2uME5LqiWajaOIr/J7xDhWDc2WF6VJesj8Ks6GS3pbqpWjlH+5azzSCiyNFUoTaJP6lbhKtas2JG02MC9Ygg2A6tXcx00fgqbzDpjxjAABYVIBZklhvXoBARzprIOzeaS1usbJ7h9lO4ckIPqH0XflyvqEFin0O4X4P0qU08CI05v9fp3A+RhbifZ5mFuymPxT+TIe2Su5v7Xg/yGMWoDVNc1sE2as547AYmiQwjidEu/lOY6JQfY7p8PwhOUXmiXqqddfKLcQORRIFHKr1kjuzG/pURJKhj9Yd91tllKsIm0OsMsMwF6lQIPyoYeSncOZTMIQhTf4dc8parv+im1Pd3s06i5jAz+UBX7baaJqKKQG3NgasPN4bDo9GeuTe6bedisOKpAISeG/vuWi76nFzzgkQXFaJMLFJLFcJyJUnZHXDI5Mrq824cuTZJnR0NkP2h2OgcIH2yZZXVgiUzJ1vJySJJy7/1R80laLqBLHMk/q6unbLrFYFUBRfp2AAJI8zdRg2W9M+fg5rdwiWzO12S7rPdgxGME6RdGQOmYIn4FPC5+BTYwqyE43KuNV43vSVdlkfijuGHL/sqLOStQQzURFJb3lwkOI5DjL5rQPXXWbI+/6f+3t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4143699003)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFVCenZ2bjRid3pxdWVzaVdNQ21CZmJycmFvZjVmM2FTSzlrRlJscGIwNS95?=
 =?utf-8?B?UE0wUEdMemhBVFRnVU5Ga0xNRmNNYVU3Q1FPOUVrd0o0bGdQQUYxSExUZy9Y?=
 =?utf-8?B?Q1N3MlFsbDB4MmJvUFVPVkc5VmR0MUllUGR0SmlMcWM2YlBkeDRmbDU4amFs?=
 =?utf-8?B?U3dWVUs0dTIwRmpVQXJPTE5saGVNV2RRRTBRY1RQUUdCRnBVK09qU3RzUktD?=
 =?utf-8?B?NURCeVp5TzRLZi9lUlJNMldldFl1VzMyZ1dlNm1pcDFEZDlqTjFTdUdyMVlv?=
 =?utf-8?B?V3NqVWZ0SmY4UE9HNWRTc1h1ZDg5c2RWV3dqMjIvZ044eklsRC9iRUk4TGQv?=
 =?utf-8?B?UVhhNVV0TXVadTFiM0E4azlqUnNzbU1sL0Z1MVM4MTRveEx5Vk1OTzlhMDEx?=
 =?utf-8?B?YURQVTRpRkp1eGovY3FNQVBBNTU2amFHZGJFYVBGY3hrWHBQMFF3WXgrZEt1?=
 =?utf-8?B?cU1tWUFWRGYza28rRlFvVW9tdFgvTDh3UlFwTkR0bHVPbnJYVEtJbzVuQXVY?=
 =?utf-8?B?NE1YUmpSWG96cCt0VXV2anV4MjVaSzRwVFNKb1BjdlVtblhkRDI5ekw0WGJY?=
 =?utf-8?B?a0gyWXE1VEYwQ0IrMHVHdW0xdFIwN1hHL2pSRlBLZTV3TlhLbGp6dUhJQ2NC?=
 =?utf-8?B?ajFURnRibUJXajh3NDJKQ2FwZUUrS1dqbmhYbW1zbTMzaGphRG0yOGUvcEUv?=
 =?utf-8?B?NzhKcXNJMk16THBNeitRMGRmTjYvSXZkNWpjQWZQUUswdmRmaytDUFBQRGRq?=
 =?utf-8?B?NUM1VHh6TmlDSC9VL0hqRkRtNlB3dEdWOEtKZGFIcG5MU0Eydjc3c202Zldr?=
 =?utf-8?B?REpoWnk5UlBFMVZOT0Fua2pUVUJ3eSs4UW1Hek5WS1hLT2NPcFlGN215NVRS?=
 =?utf-8?B?dzdsSWtkNUNIcVVaWHNTN3QxTUoxR1A2TTk2Y0FhZER1MDEvdTdnaGloVFMz?=
 =?utf-8?B?LzdUUFc2SVM2b2pRWW9aSFpIK3ZpNjlvZWVHS0RwMGtNV1o1MmtnY3ZibFdz?=
 =?utf-8?B?Z1FHc3RoUWNGNDl2RWNRMUk0cERTdWVRRGRCZFB6b1lER1ZTeEhCQm1Vd2hk?=
 =?utf-8?B?M1NkVWhTaW5tbjN3a0lrY0lmVGxkbHRrdTBidmU3aUdJZ3RZb0haNzM4YTBT?=
 =?utf-8?B?ajZyUlNiTWpwY2pSR0tkZGVpKzJGSGNQakh0ZWszb09TbldEUENmeFFwSTg5?=
 =?utf-8?B?MzFPR3RDbkt6anFaa09TM0pra3AwSDFMS0Zib2ZMSGVESGM5OU9FN1M1OGJL?=
 =?utf-8?B?ZFJnbkpEc0tXTEZkK0dzRFd1U2lyVEhKbXluTWU2RHN4alpWN2tOdE1EcHhl?=
 =?utf-8?B?T2FwcWcxWFZ2NU9pSjN6akhqYzNzWlRUYmlTVXdYcktjamFMWlU0SklBWHlT?=
 =?utf-8?B?ZnFNZjU2UGtud0FUS1RhNGYxb2FxVHZoUXlCVnErUDVIRXowY3h2STBPWTV4?=
 =?utf-8?B?bm9XdTEyQTE4cTFtZVJnemhKR3h0d0JmbmhmQWF5K0tqeGIzc2R0NUlObnBC?=
 =?utf-8?B?SjNMZ1c0YUQwWTB3Njkxb2w4SjhHdThsSlAzTW0rRG55TXd2WVBQZlRKakNI?=
 =?utf-8?B?RERFZWU5Q2xWOXVuM3hyWXJpVkJyNm9UYTExQVRtMUp2R3I1cU5JZVhHa3JZ?=
 =?utf-8?B?dzZQMG14eFJSamFZcFEydjhIU2pPbGRaNk93M1BXdExsN1ZNVjJVZ09za1JO?=
 =?utf-8?B?T0Z0MlkvMnNJeU5LRjdrT2Q1NVdTZVY1QmJiUTFWVXJzY2g1b2RxRHRBL21V?=
 =?utf-8?B?ajhXazNxOHgwOHNNc2RUTGpNUDkrVEdiMTlWUDEvcG1XN0ZmeFpjVzFKWWZI?=
 =?utf-8?B?YkxLcjc3REsvcTQwN0Uyc241SENtZUxLL3Nwb2x0c3djR01hRkRUN2tqbWJm?=
 =?utf-8?B?T3dla3Jsd0xYVGxrSG90N1llamtHdldKNTdLVTBtVk9hbFJwdEV4cUpNUTk0?=
 =?utf-8?B?Sm1wMU43Wm5QSjgwUlJBSlN4dlM0NHNCYno4ZTdsWis5cTloNDJBY3lzZ2Yx?=
 =?utf-8?B?ZEE5RWtaZDExVXlnWVN0Mkt5dHdYVm9IaU1oNWd4L3c2MC85ZTBveHRBRFYx?=
 =?utf-8?B?U01lQXNwQkRtVDQ3MmtLZTJyamxpVzgxdERsdzI3WW9rYmJJL2w0V1RyNnhz?=
 =?utf-8?B?Q1BOcTlLVjY5dHJCdkU3bUh1WmhOMGx3STNadXlFWjRIZmpEVnp1dUo1dENp?=
 =?utf-8?B?T0xsd2pnZHVObnFhVjBVZGhoemRNSDZXR01ZWmhnUTBYRlBRZkE3UFZKVlVU?=
 =?utf-8?B?clhIRVJKUjFmbXAzalpwZG5PMWxid2RDb01PR0lMcVNRd0pJYjBrZzIzKzl1?=
 =?utf-8?B?NzVYN1lONEN5MXJqMWdvZzF0cGpWTWJBMnBhdDBtVk1iSENqQXZPZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c99596-6ec0-471b-2007-08deb57caa91
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:00:18.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRFCdaZ5iR8+u/a/Z7FhyUA4neVC43oArpUoGBq7UjjDQE40IuBRA3Tycos7BXo+XxhCP1vXadtl0Z0s4fyE3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327



On 5/17/2026 5:42 PM, sashiko-bot@kernel.org wrote:

> 
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] PMU initialization fails for IOMMUs located on NUMA nodes without online CPUs.
> --
> 

Thanks for the review.

> commit ef1363d0a37870d7cf1f1095cd3ebf42cc5a8bdc
> Author: Vasant Hegde <vasant.hegde@amd.com>
> 
> x86/events/amd/iommu: Fix cpumask of IOMMU events
> 
> This commit changes the IOMMU PMU cpumask from a single global mask to a
> per-IOMMU mask based on the NUMA node of the IOMMU, allowing per-socket
> performance counter collection.
> 
>> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
>> --- a/arch/x86/events/amd/iommu.c
>> +++ b/arch/x86/events/amd/iommu.c
> [ ... ]
>> @@ -440,6 +445,20 @@ static __init int init_one_iommu(unsigned int idx)
>>               return -EINVAL;
>>       }
>>
>> +     dev = amd_iommu_idx_to_dev(idx);
>> +     node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
>> +     if (node != NUMA_NO_NODE)
>> +             cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
> 
> If the IOMMU resides on a CPU-less NUMA node (like a PCIe expansion switch
> or a memory-only CXL node), or if all CPUs on that node are currently
> offline, will cpumask_any_and() return a value greater than or equal to
> nr_cpu_ids?

If its CPU-less then put it back to CPU 0? Any suggestions ?

-Vasant

