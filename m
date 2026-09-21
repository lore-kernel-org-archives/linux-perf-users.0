Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180201A5B9E;
	Mon, 21 Sep 2026 05:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967501; cv=fail; b=EQIzhrFDwybDhuVPDVTy3SpuhWekdxzCjsclKJlnU52UcceRZGCwFhPxw6kzacnQUi8ZqhE2kL9nL65NrLod2weiOkds5Wr/Cgi58r1x/Mbs1uYyeoEW6GI1NWIuyn9uJRxlJgIXtZPlWJX899ZXZwjTpXW6ZtP84+EZnqAJ0u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967501; c=relaxed/simple;
	bh=1/HSJ2sCsRvYUHdo9tFplKWvFpApV0VZzMlc2yC438Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y94kxGrZJsOwAhwdanw6L4qfftD1yHS/xUVfHRcvwsODtRc7jCY6Xg76Vmvcn4ClfNLYWObG/UWmaNDmtA6lKqtBPLyM5DqGDyshkuSdVSAa5FNavCQnhIfkS1AF/HY/SGvYdtGhgPMEzNyjIQD1u+2bQGO+i9vME+6S0HvIhD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wiUYqawR; arc=fail smtp.client-ip=52.101.52.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wiUYqawR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBG6SgrY72zvIaF7vFP/yizHaE0nOk5yQSRhOLfcriDnL69B6o5Pk/+ROnx+rOlsnc5W2oBlcGtyLVor8EG2ky+lTsncwZvg9QrrRQWkNuGDT+V4KlCdziMkT9VTh8bSZZUrFky4McomvuBa4xtR4o0BtpS2LXZoBSuayVb8e/1CubcPW3+YU7v8PBrhjyWK6Cbl1bfHyWL+XrBbdok0WYVb0DI4ipNmurgJWxlVD4UkPexQMG2a5vbHXoeqB9c3FsEMGb+axcK/W9R5OBr/ctMU2nqhy0iMtC31x9edFUhPk/tyVOkWEwFbAUK6I2NAH6kf6miuNZzuNDxBo4NRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOrdePHYnU7ac4eWjHC37mbtvSHxuG89TqC4wgiFlkw=;
 b=u5uwrrlImnAgzhddheEw6qnd2H+gaGFWsO49a+x0C5Frg6pH+Wc/3lhvGqCYFb32Ehn+UNjnrpL1mwUVi2aEIDZhWeNqIx6TKnedK1mvvbs02F4OxM1M2WB1RGMxJdLkEjEhygi7/WEwLAAaG0Ph63xOt5RzNdV05FnZGv7g3qiW7fj6fLcU6/Sz4Bu4+4nKfpPqCJ3zC/uwf4afVUz8+r0X3NHEpGbslcBPJlTVNkk99MdqVEiEsEctPN81Q+VTj8mWRBG0nItMiaVlqYI4fgiEfdX08cKGiDIz0N4wF/bm8VC3la9iBXyNYUG+4lruE69A04YBHr36wFYZRz/ixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOrdePHYnU7ac4eWjHC37mbtvSHxuG89TqC4wgiFlkw=;
 b=wiUYqawRMVLTKAueTFawsS++DDQ6NdPUQA8IfWicJNVlsMm1FySVC81cvSUHkjz3IrrVb+Vp/WzXiOfuLV+5Jw5G445gro3QxUWn4HGKJBsRTdz16xlt65yOx30JKnk1i1OZX/fM2XZtxVkJoJR6loFEEPIi2AB7CYpHw2Uy1Lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 05:11:37 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 05:11:36 +0000
Message-ID: <727ec541-3bee-4e78-806d-587ca9261d51@amd.com>
Date: Mon, 21 Sep 2026 10:41:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: x86/pmu: Don't retry a counter whose config was
 rejected
To: Luka Absandze <absandze@amazon.de>, seanjc@google.com, pbonzini@redhat.com
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 dwmw2@infradead.org, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260920155453.10836-1-absandze@amazon.de>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260920155453.10836-1-absandze@amazon.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::8) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: faac9b98-4cfc-4473-0293-08df179ecfc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|11063799006|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EdWG1braF5ryB1n8r9bS4UIG58Y8uF275z2rqpCxj0RLUy0sOEhNQFGcRck18D/PUb0Hloie6lkIjD1IVPjPqo135Wf22Fk5tInDEmGDA+2WUy0vk2S0TWlMo5R8OSB3AVEP2M06dyo/eSGgENbTEyo+oNfX//Z2OSCNwJGjIQ7Ln0MkHyE4loXwEljN+iuPdq5P48PxdnUHetqqlzE3ku+zg2ZcF9F2IkzOWtv0QRn+fXrfOwAWL1j+W5zzeDkQouWPMBlPRaPSMjFl+oIS/GoUm4jLqCJA3xKgJo/u8apckkeJxjMk4irLsLzJqh23rF7lZMtPFTf3q7GozSsD6P10i+bgfFaf1eBZ2qlmkYfPoChwGSb9/hM7fcgWibT2jz27dxfsFb2eREUfaFOB1ZPVEQqslCMDdKXll1NQ0ysnpg5J6H/kWyjoVOsI0wNliYO1fhAxYS3Uj5NGqKXGP4Sv6VedngmuttK7AcKMmKQhO6UaI3WlQ3F8Fw8pGPsg7q4/mplBQMSYWGxlPl0hGfZoN98fsHlRQy0b5Sbgaz6OGhtcYteleNSASVZJDrbiSYf3uBZtRmYhxSoaeLr1UYKKyiFlos8pl/y6dFJS+I9SDDwHUSSSquk6+BAdGCyVl+kUxKE0xfElcHNUqLIFuCim/8qAoVDjxXvdqZQGfPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STJ5RjkrdGI2U1Q2OWU1cGdEUkxTdmZHVlRGTmFnekFBK3RrUFEzdzZJUnB3?=
 =?utf-8?B?UmhRaW5LQXRuRGZGQXQ4THlrS25rS2k1VDQvR09BWmdBN0JmZWZJbzRGREg5?=
 =?utf-8?B?NmNNeklORGZsTzFMTGNycTF3TWJZR25SOE8zVE5kSCtBUEdkWmdIKzlISmUw?=
 =?utf-8?B?eVk3OW5oUjJxdndadGttV25HWm9acm9jRWx2dXpHUEZUcWNBdXluZ1RCU2Ex?=
 =?utf-8?B?ZEhxWU9YSThRNFIza2dBenl5TnpYZVVmWE9DdmtiNk1Ea1k5cU5JSElKWlRD?=
 =?utf-8?B?SGhqS3RSL2tGbGY1akJ1WjA4UXRuV0FmakZFU3FCTUUwc29xZDJKOTBFOS96?=
 =?utf-8?B?WGdscVlRN3NFNzFwbzRjOElsQ0ZGb2tnMWsxOG5mTzdUUHFzYk9HaXh2TUpY?=
 =?utf-8?B?ZEVldWo5VnMvd3dTbWpjKzd0WHN4ZVF5bjRVNGRuZVhmMG9lN3hYZUtMSWdM?=
 =?utf-8?B?dlFQYUV2KzdUdnRaaklQcFpQZXd1dndGY2FTZ1g2QTBPL0N1bjNwRUorM1hE?=
 =?utf-8?B?UkhLTWh0ZUw2S1E1bDVSeHQrMWZhbkt4d0haV255ZHY4bENtRkVYVUJlZEZL?=
 =?utf-8?B?MWw4R28zV0JJclN2TzM0THluKy9qaUIzM0RSdE95UGhLb1hUWjZLSkJsNTZq?=
 =?utf-8?B?WWxFY1ZTZmMyTFlzT3VRZCtrZ2VUL1ZPSUJscExUbXQxbDZsNDd3bjk4Y3FC?=
 =?utf-8?B?b1RDN0gvdkxBR2JJQVVpaldsN2s0eXlDdTd4TXp2bnE2N3RIS3N5U0NPNmQr?=
 =?utf-8?B?ODUwMDlxM0hwZXQwUzZYUG1xTURNVktDMmhnVEhRS3A5TUNSK2NxOHFsajVq?=
 =?utf-8?B?R0pEcUw0UG1yb09SbkhYeFNFT0F6QWdmSGFXVVBTRlE5RGlQbUJlZEFYb3ow?=
 =?utf-8?B?a1A2OVArb21TZWVocmFRUmFWcXpoQWlTak9MZGpCM1V4SjkvQkJhaEY0elo2?=
 =?utf-8?B?WDR3YTRLL1h0SzFjaklyVllNR1dUL0VRUE9UaHhUWnJJS3VKVnRrUWZHeWxR?=
 =?utf-8?B?a3FUbUR2Z3I5dTVoeTBYOUJhUEFlZjdqUjJDTjN2NFU2REVNdk5yNkw5VE9H?=
 =?utf-8?B?V1dZVzgrMjZGaHRFbTRja0VnTyt2RnRZVk5Lc2hwRC9Vbk9kMmd1ZVVlVVNW?=
 =?utf-8?B?RzhYTnJYN2RwRDhwWnRoc0JNM3JJMk8vbGY5Mkxja0pQQTNUWkVNdE9FZkFT?=
 =?utf-8?B?Z1FZVjMycjhZaFJDVzI0NmtYcjZDYit4SHFlR0RuSS9YclBDblFRSFNySzB6?=
 =?utf-8?B?TVZBUjVVeUVSbEZYaS8wblFrOUhJRlBCRFR3cFZlWW02MStETnljeVYwWi9O?=
 =?utf-8?B?QVZrak5pVVFzTjIrUnRMY0RuVWlrQWp2VkZ3b1BKSnRacHBCMFdqQnU2L2gz?=
 =?utf-8?B?NEdobVBtVE03bXhpUWdmOU5qSU1pMmJBMmp5K1hCTWZXYUJxQUI2dUdKUGJh?=
 =?utf-8?B?K25JRnF4aE5XWTloWjllOUZybkU0aGRBclZYZ2pXaXFraTZaVW4rYldUSU04?=
 =?utf-8?B?WXB3STA2QWZwVHdPOUl1MHVwdW9MNHZqS3dTNzQrZVN2bW5MSGh3K0ltSkZP?=
 =?utf-8?B?WW50MmREZzd6bnRGRktIOWtIOUk2UHQ4NDRISlhDbzdGU05rZVZkNGRBUmI1?=
 =?utf-8?B?djkyeHNvY2RrQzBrb0dGd25GVnVKWmZuK2dlaVRsVDRCMVAwdENCZjh4NnBh?=
 =?utf-8?B?Wi9LTHBKR25iamd6a1JYNmtPbUgvUkQxWk84NzZKdjcxdCtVbEg1UitkdzhH?=
 =?utf-8?B?cXMvTFVrc3dzNFhYZXB4dzVOMzRNVGVlbFZ2MThsZFd4NmR5SGVMU2lDWnZ6?=
 =?utf-8?B?WG5TWlA2TkpWVW84dGJPNUEreCtsVks3a1BCZERtREE3RjgyU1I4Mk9FZHEz?=
 =?utf-8?B?RGgrekRERVJJdFRKZkxPOUtHWHI4Q1I5Tm9aLzIxbEhnS3h2ZW5iOFdyemdt?=
 =?utf-8?B?RU1BdjdyY2tjazB0ZFROY29DZVN0RElYcGVveVJFYTZSVldNYyt2Q0sxbU13?=
 =?utf-8?B?dkh1TmRJcXFPdlU0TUZoU0JJbno4UXl5U2pod2NzdlBPWW85a3hIdk1CVGl6?=
 =?utf-8?B?N0JURE84SHNrSjhJMkpLY3NyOTN5S2VTeGpobFVlaGVHT2pqc1JaRzZMRGFy?=
 =?utf-8?B?bEdVNmp2OTBsNkFJMmlsby9rRWZwYkFXazc4K1dXVXpHSVhVNkRSaW43UWdK?=
 =?utf-8?B?UUJNYVluejlqUGdzT2ZIWnk4WFRsSGpSdGw0ZC94aHNDWnJQZFp2Y0NtdDRk?=
 =?utf-8?B?N005aVAvN0krYUY1ZW9zRnYwcjZneHNCQ2FQVlgzLzJzWGpiRFRBc0x1VEt1?=
 =?utf-8?Q?mSig/kzsE2VgyGcOVJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faac9b98-4cfc-4473-0293-08df179ecfc2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 05:11:36.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFwYRYVoXATavNLzv7NMJVj/MVwPZNoyRsJLKLAXHl94A3DSh3alUKCNf4ziwppg3ccbgioHkRWSDA6Q5QhA9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493

On 20-09-2026 21:24, Luka Absandze wrote:
> kvm_pmu_handle_event() re-arms the reprogram bit for every failed
> reprogram, on the assumption that the failure is transient and a later
> refresh will succeed.  That is true for contention, e.g. the -EBUSY from
> x86_reserve_hardware(), but not for a configuration the host PMU driver
> rejects outright.  A rejected config can never succeed on retry, so the
> counter is reprogrammed on every PMU refresh for as long as the guest
> leaves it enabled, and every attempt fails the same way.
> 
> Re-arm only for the errnos that indicate a transient condition, i.e.
> -EBUSY and -ENOMEM.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/all/20260916123315.89042-1-absandze@amazon.de/
> Signed-off-by: Luka Absandze <absandze@amazon.de>
> ---
> v2:
>  - Use an allow-list of transient errnos (-EBUSY, -ENOMEM) rather than
>    excluding -EINVAL, and hoist 'r' out of the loop.  Diff taken from
>    Sean's suggestion verbatim. [Sean]
>  - Reword the comment to say "fails on a transient condition". [Sean]
>  - v1: https://lore.kernel.org/all/20260918160006.61816-1-absandze@amazon.de/
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index a7d60c8785cd..03a470c49a74 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -662,7 +662,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
>  	DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  	struct kvm_pmc *pmc;
> -	int bit;
> +	int bit, r;
>  
>  	bitmap_copy(bitmap, pmu->reprogram_pmi, X86_PMC_IDX_MAX);
>  
> @@ -676,12 +676,14 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
>  
>  	kvm_for_each_pmc(pmu, pmc, bit, bitmap) {
>  		/*
> -		 * If reprogramming fails, e.g. due to contention, re-set the
> -		 * reprogram bit, i.e. opportunistically try again on the next
> -		 * PMU refresh.  Don't make a new request as doing so can stall
> -		 * the guest if reprogramming repeatedly fails.
> +		 * If reprogramming fails on a transient condition, e.g. due to
> +		 * contention, re-set the reprogram bit, i.e. opportunistically
> +		 * try again on the next PMU refresh.  Don't make a new request
> +		 * as doing so can stall the guest if reprogramming repeatedly
> +		 * fails.
>  		 */
> -		if (reprogram_counter(pmc))
> +		r = reprogram_counter(pmc);
> +		if (r == -EBUSY || r == -ENOMEM)
>  			set_bit(pmc->idx, pmu->reprogram_pmi);
>  	}
>  

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
