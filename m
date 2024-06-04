Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC61EB48;
	Tue,  4 Jun 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506055; cv=fail; b=nAn+2q3cmXpoa3uOtBIlFq5Rqs/Rcx0ts11xkihmRa6EIFoAGc+qtQqPV7eT9FPCOKIq0m5bzuiotVBWslAV+uhMM+hHlwrC+rJh/IxfMacmnpK6OUImbnCr2ToCA7UFkNc0Cx37TFd7ZpfdIhug31O6CDtARuEeJOgLLUHXqLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506055; c=relaxed/simple;
	bh=bmltw6SRYGQl+f0/AfdmPB1vnIzxewM+HfqbQBnNKhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q5DAXBKHqj+FIz1nYrE2axmyQ+b0F2TxxMZto5kBIUY4f0EYxNLjqaO1SnIAF66aAsDxUf3kJ3V9JndykapA9km7GSTa10ogIpnhyFfh3/L+G64cWeW3vxwk/5zSz9y0YhDwMhMq9wxLeTWboKeM/kHM7MCk4IOpYCqFNThy28g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pT4yZtbY; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pT4yZtbY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVRE+FWTxdLreNsRwnrB2Z5wDXc+CPrL5Ev4zWyb8mqz4TuQZuxCQJhysgMMWabL4iAnmsaLxESdNO1NxGQFGA9T1f3Rxp1b9q/am1Xrh9acxkF5N4kZI3z3EecPQzhf2b0ornT/RqLflr9d59b2t/FnhSoUTdxrusQ6CBPDpYQFLtdTRVRJfDmUcDdYI+tU2z/4amhHfpEvNQoBAwTv1McZQrODZCnoIbOtBHo2u9YO21oGXRF4SWtZB4azzS55mlkZIgCe0U9MoFpJtcJauA6LEKX8jQhq12J2etFaoG6Y9JbozLFAqg2ODAbSVH/NZzPkzPnvSg2Q3m9vNl6ewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmltw6SRYGQl+f0/AfdmPB1vnIzxewM+HfqbQBnNKhg=;
 b=RLFcx7bd2cWYAbezre8bF6dSKZoUCZOIbowioPJjLXqlxA6yGHvK6EY5ZCACwUuDBx6NGlI8kHaKA4ZC1tz6X/tapoF/DNv0iX+4m7FROKFLGpAA/99SscP3tkMQW1NlSs2pKxbrXHStM23ntwToYy/sOjhnJ7h3hYcM8IIiWFL9WUPo/622t88lp0cRtVfiZTEDKaRdzCHmtVHGIO3WVYmoMyJwND+Ivigm49st7D7Tt12FFV1qlwraDxgNMkHJ/mpO4XkOb4qVTtl+kWaT1ZekciTKqFK54Mkyx50QRkBWYkcAyjHVkLwsDLN3AbbmxDqtxNciePv9v42ffsN1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmltw6SRYGQl+f0/AfdmPB1vnIzxewM+HfqbQBnNKhg=;
 b=pT4yZtbY3YR38TdVA6CxIr0uOV75Eb99s26UPnBPUFgKn3FsPIWVzhGxZeNMNPu+sNgH8p/xG8BM0ShpzIDn4XRtc0vNe8aSEBgQdBbbnjhTd+myYRrAOsgRVWTojMKREvsfBmY3brfgvwiD0zN68xMflvvgJWNC0qsz2g9ijJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 4 Jun
 2024 13:00:47 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.7633.018; Tue, 4 Jun 2024
 13:00:47 +0000
Message-ID: <95c7f055-667a-4a56-8cb8-a4a8a83b8cfe@amd.com>
Date: Tue, 4 Jun 2024 18:30:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: check event before enable to avoid GPF
To: George Kennedy <george.kennedy@oracle.com>
Cc: harshit.m.mogalapalli@oracle.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 ravi.bangoria@amd.com
References: <1716990659-2427-1-git-send-email-george.kennedy@oracle.com>
 <75f6aba1-8ed6-4ef8-8811-de40ae40be90@amd.com>
 <1e14ca4b-6e3e-4d57-acec-bc3ee2bed6ed@oracle.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <1e14ca4b-6e3e-4d57-acec-bc3ee2bed6ed@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::18) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: cb43fe11-424d-4eca-6916-08dc84965a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFk0OEtROXB6UUJXeWR3ZzFFNWo1TnVQbXIyUC81eWR4ZXJNYkYyZTNoS3Iz?=
 =?utf-8?B?S0x6QmxhM1hrbWF6MzVmMnRjeHJTRzkzRXFxbkxQVmtTK0xBK0lNSmIyQXlH?=
 =?utf-8?B?cU85TFNYeUNTRVBiUUtTOEorRkZPNHBmcUdGUmJZTTFYazZvRjhWUVpMOVgv?=
 =?utf-8?B?dTdvbXl2RjNISlA0NitmSUEzMVp5Rkl1anhudy9sa1JUdVdyY25McWlCYklK?=
 =?utf-8?B?MWEyUTJJbWNaVFN6aGNOOGt2TndiM2tSWTVpbmVBSzQzWFhPQTdiVENRMFFm?=
 =?utf-8?B?V2dsRGc1cW5Vcy9Bemx5ZWRLNnRrbWUwZWwvZzRaOXhreXJRSXFHRGJVOTlq?=
 =?utf-8?B?aUtsVHNiamhtZ2U3KzFLSkZqQVpKM3cyNm1PekpMbmVnL2Z2UlkvTGl5Mi9O?=
 =?utf-8?B?NCs0enM5bWJ5RExoOG01dXpDTlJPUzlqNHlSSy9uem9QbU9TbkpVOVgvMnFz?=
 =?utf-8?B?N1FEUDc3R2Z5TDVGTnNOTCtBYkJUQXlTTHNBNi8xTDh4Snc0UDVLNjZNalpw?=
 =?utf-8?B?cWhDckg1OC9mUjF4Z2NrbE9YaWhqU3RCZHpoeExMd2tvRDRhNGliN3djZGQr?=
 =?utf-8?B?bXZyVDFDYTNWRUtCanZ5dHBWa1R0UUtsTS83Vy9RcVhRS09ETnBjTjdjM0dF?=
 =?utf-8?B?N1RkWmY1bm13dWRtSlg5amVUQnIrZnBWQXVQdXh4L0pNalZTNzFLM1puWVpR?=
 =?utf-8?B?ZmR1c2NzaVJkTWo5MTBTNjVacHptWGRkM3lGNUxuUXI4aEtxb2dGb29ZazRm?=
 =?utf-8?B?MnRPWno3WU8vMVJvT0RKMys2NkYxV1dWdlpteG5WakxSTkxVenEzWGpMV25H?=
 =?utf-8?B?STdMSUtQNlFMeFFTcTArVHAwUmtvTVVOQVlES1dGSm5ub1Exc3VVRkg1SExR?=
 =?utf-8?B?NmdhKzYxdlE2M2tRc1M3Z3pqSXBlY3hKZzRYYnIrc3JmZ3RudmtXdmtFOXhW?=
 =?utf-8?B?QUdBME5YTFhNQnArMzNWVm1XcE9Fc1lZMGFueXMxczJMYkdJMGt6OTh2eUpQ?=
 =?utf-8?B?dVZ2VWQraThJcFlidEdwakUxUkJ2alV2dmx4MlVsUGdRUlBpVzV5K3BLMm5r?=
 =?utf-8?B?Uy83ZWs1SHoyLzg4NFRJVnRnaUZjdmZqZWZYZUc5eTU1MzlJZzVhWmNsaFZk?=
 =?utf-8?B?dzFGcjBOOTEyRHVMOUF4R1c1Ky9DeTRGRTMyV1ZTZE1kcnlrUFdXNFhqRGVB?=
 =?utf-8?B?eFlrV0NEMXR0MG1IeEtDYmR2d2xabWdsdUVsN1lWMFBRbTNyWURmby93SGZz?=
 =?utf-8?B?dk1kUXVtNzhCZER4R1ZtUmFZc3I4OEhOdUxLc2pnZzVKVmJmaWJ4RldkQnZC?=
 =?utf-8?B?Y29GNTBKWFVXN3JKZXdKVjdmK3Nab0RzVklVckgvUks1TzFiNmZuTW5mWGlQ?=
 =?utf-8?B?ZlpKRkU3Zm1IN3M5aFlsYWJNVW5OZFRtaVNvYWVodUJ3dVdnbUFaTGRyeXJh?=
 =?utf-8?B?YUFUZS9lUEpoM0JPOERuY3BFd3llYTRCQ2ppVTBNMUhJbFF5dFBpeDdaMGN3?=
 =?utf-8?B?NEVlZjJKUXFKWm0zWUtLOWgzUTJRNi9VYXAzTm5tMUNaQlhmME0xMUhkQzR0?=
 =?utf-8?B?SVgwb1Y0MDA4NkVpOWcrT05SVldyWDNFMktvNWl4SGJNbTZpMEh5ZkVySUFu?=
 =?utf-8?Q?OrH0P0gkamIC0W9Ehzu49Gq3eRj608JX/Mh262YbBofk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXFORUVza1dMd3pSdXRaNTZKYUtiS1gybVJtZkwvdC92OUREWVUyOUppc096?=
 =?utf-8?B?dmNjK1VsQjRVSVVRRVJYWitmcWJ2VEhmd3RlRG1MTkErOTU5MjhQdkZ6KzZm?=
 =?utf-8?B?NGVtenB6QjlYYU1IUkNFQmI0SHZmUEZhOE1uSW14RGFXQ0VqeXVIemVWWnA3?=
 =?utf-8?B?akdyZWlCM2lrQk5OdHlocDRUNXVMUXJoSEIrYWw4a3QraC9DMGs2S21CSndM?=
 =?utf-8?B?eGViVWgvZTBvWlZyNTZ6cDFRRURmRnQ0UkNDRWdEdnh4aGNFSDFxdy9kMTMz?=
 =?utf-8?B?NGF1NUFUdE0zaWJWUDBCeVpnRFZJdnN2S0o3bHA2cnp2ZDA5OGRIK0JvZDZn?=
 =?utf-8?B?Q0kwQU4vZDBWR0x3ZVN2bWtUY1M3Qy9OZEFURXZucnBxbkc5VE1OZjBXWG8x?=
 =?utf-8?B?Qm9XS3hhRG43K3A0d1Z6WDJ3WGFLdjNqZm00TVc2dFZzMWRnWHMwZHJMSEpZ?=
 =?utf-8?B?RXVvYzhaYmErSlA1UGJ4bUo3TjBWcTVER0g3YjhvQVZ6MHk1WDE5SmNlSXFZ?=
 =?utf-8?B?UWpUL0J4aU80ZEttd2NXcXd4S0JNc0ZwaFY5NjR0WENNU1hpdzVFOUdvaWpP?=
 =?utf-8?B?RWlVYmpNL05rZ2I3Rk9lUVhXQzhIUmovMlZLcFY1ZVB6MjV5cjhkNllwYVZn?=
 =?utf-8?B?d09wWEFIQzZJZmVBU21ydHVRd1hFdTVCMXZlRDFBOWMreHUrTWwweFM0QTdU?=
 =?utf-8?B?RE1VNFdjOHBndmEyMVF0dHRMb2VnOFdYWW1KZXgvaHJKUTlGQmFOZ2JUNzBw?=
 =?utf-8?B?enJNMHlwZ2x0U1kvQ2QwL20zLzJPWmN2Uk9qMHcvNEh1cmVMYm50ckdNNFFj?=
 =?utf-8?B?Ry9lbjVTMFluSU9GaC9LeXExQkdwaXBuMHVzelNWR0RZU0dDM0ZHTkFiS2lE?=
 =?utf-8?B?WnJ0M21XZHlwTGp0bWY0MThoM0NyNTNUS0xUNTNENkpFZlI1MWJkbGg2YTl2?=
 =?utf-8?B?ZzBrYUU3NWZLRmdMUk43VzkzaUhmMW9GZkFVcSt5aG5qODYwM0Z4SVB1MkVt?=
 =?utf-8?B?V2ZZcXRGdHV0SDFzdTdiS1paRmlBTzF3UXZybG41Z2FjUytoejRMa01VZTlI?=
 =?utf-8?B?Ujk2cXdibWZZQnN0N3ZUSFVIaEFnR2gvTnlWTFhxZWpnQjYrcW1CSUlUUEhJ?=
 =?utf-8?B?K1YrL0xoUlFPOXd3MHR0UWpBL2ptc3V4bXRUYjErd1RvL2duOTZHK0VZb3hE?=
 =?utf-8?B?OElFVXZiODhFb3RPanoyMnV0U1lyVHJhN1JxUUI3L2ZzekhUQ3Y0VlZUSjVD?=
 =?utf-8?B?UFlaZFhBQmE5SFJ3S2sreDZxVGxFRzNjdTRHdXhJajhrdjBUNUlRTUovcnlp?=
 =?utf-8?B?bm1BamcyenZ0K2p6YU9CcVJQWW9udEd3OVowZHgzZkN0OWFLODdOa0YwZ0JE?=
 =?utf-8?B?RXg1aUJESUdxczRHS3RFNG0zT2RXcDRUQnVxMHozY1dzWkMydUdYQ3F1d1lF?=
 =?utf-8?B?NVFCQTVaZkVHdTRyV05hMjIza2tmelptTXc1d1ErSURHdE50NnlWM0l0NFdI?=
 =?utf-8?B?R3VjRVdlVTZOM2xyUjNxTC9VdmtxSktWcHlSa3UvTXFHc1hkc000VHV1UE5s?=
 =?utf-8?B?eS9JM0pvaVlmbjBPQ3ZpQktaR1J3VHFScExtTjlZWktGZUJLM3FJU3h3Kzky?=
 =?utf-8?B?U1BLQjBGaW1objQvWDM0NU9nSjhZQ1BpdjkyOTMxcjJuR1lhMmlQS2dlaG82?=
 =?utf-8?B?QWQ0VDFrOEFWdW04MVlwb3dDdDNTa1ZEem9TY2hpOGxyblhUTWFrZFhpOGhm?=
 =?utf-8?B?UnNlajRYeTFtN2pneHVoOWRWLzhERDBDR0czSFo3SUpMQ2Z4RjRZTzNIM2Yv?=
 =?utf-8?B?bmN0OGNJSE9ydzA4eXVKbXZvazIwdkZVc1VrcFpzaEhxaWlrNDlsV2hDRjEw?=
 =?utf-8?B?bGFXSlJMQjQ1T1ZPVWNUUDFOVUtFc2JjbUZVV1hDVFcwaS9tcHBDanRpS1hR?=
 =?utf-8?B?RGxhRGlGR3NuVzZtUFd3T1d2NFgvdEI1VlhBbjUxK0VidzQ5UGIzOUtJQmND?=
 =?utf-8?B?NW1uQzhFZzNxUEVyNXorS3djSlBxV3ZLaDczcTNneEtjbXJCK1FsY1Y3aHJG?=
 =?utf-8?B?Ym1KV0ZhWXNRV0JXY1IwVkFMODV5SFRBS2llTXdFaHN2d2JReGFCcy9pTU81?=
 =?utf-8?Q?Ud4w6Ya8DAjuVA6ztmODgAil3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb43fe11-424d-4eca-6916-08dc84965a3b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:00:47.7209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tEW7ZlchKdyqEtBaTmMtICdzoKQZh3yi/25VQ6m8Fzvck4zPpkuJ8a0PZevEv7uU82L8VmOpbTRDaj34jHTHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044

>>> Events can be deleted and the entry can be NULL.
>> Can you please also explain "how".
> It looks like x86_pmu_stop() is clearing the bit in active_mask and setting the events entry to NULL (and doing it in the correct order) for the same events index that amd_pmu_enable_all() is trying to enable.

Right, so how can it disable the exact same event which it's about to
enable?

If it's happening because of some race condition, we need to find and fix
it. For ex: https://git.kernel.org/torvalds/c/baa014b9543c8

>>> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
>>> This appears to be an AMD only issue.
>>>
>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>> Can you please provide a bug report link? Also, any reproducer?
> The Syzkaller reproducer can be found in this link:
> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u
>>
>>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>>           if (!test_bit(idx, cpuc->active_mask))
>>>               continue;
>>>   -        amd_pmu_enable_event(cpuc->events[idx]);
>>> +        if (cpuc->events[idx])
>>> +            amd_pmu_enable_event(cpuc->events[idx]);
>> What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
>> before amd_pmu_enable_event(cpuc->events[idx])?
> Good question, but the crash has not reproduced with the proposed fix in hours of testing. It usually reproduces within minutes without the fix.

It does not reproduce with the patch because that if() condition makes the
race window smaller?

Thanks,
Ravi
