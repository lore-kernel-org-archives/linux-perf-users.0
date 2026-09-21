Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547C0357CE8;
	Mon, 21 Sep 2026 05:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967437; cv=fail; b=rkUK0l/sQelHjR5yT6DobL9BJ0TIFjQwZ78gqFd1d66ZQa1oJK8QGpJEn/er3SPfZH+zGU9+Z8jnENzQlazICa6RG9k+/qSJD7BGiNZGAO5XrllFXAUfWSgBytliqhbGpZQfhEhc/vOCCZjXSf8T6smyHJ5CFjZqrYdiJ6e8WLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967437; c=relaxed/simple;
	bh=1/HSJ2sCsRvYUHdo9tFplKWvFpApV0VZzMlc2yC438Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JftcTq1o1LFnMCMpUtrinc962Km6BxMvlwilEimAWbzs1CekFuj3Y3SA7Zx22RQt3ga2rlToy4WM6+xQBGOJKJyBXxK9AatHbcWIJD8cPhMy/GBUwSg5+8NsRnVUFqlPWaIX3uFCi9O/vDuUjM3YITl0TprM3C1BZ+bAe/7aG0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L9Ev+Wom; arc=fail smtp.client-ip=52.101.53.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L9Ev+Wom"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZC97eELKEs5m5h3FPrXlbPN2RSmASc6WmrtlRknN558c3mScoCzKW7dSqfxV7SQJRZ2EViRKnN9cf72P84KepFn1gyEj8ySvOLfKZvGcwFZZqB6vTWkhsvjjXxctOFs+kRHGiTGk7y2I3yi1ZPuq8GC/dTxsUO3SPe9lpcTOUlvXrwWF2uyy6bkVOrqrsSn8SPDSqFKqf4VJPYWrp7JBwTqBN0iVmMfaAbbuVmOa3buDP7dhb7b1MMbEYd0XBf+JbcGP0cqtgq1xI1QG55s3gQJlQj6IUnA3vR1pWnS1bErhuZnf6qj1D7Ba87irzfL4YAXqUzf8G3tQA4poG0lGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOrdePHYnU7ac4eWjHC37mbtvSHxuG89TqC4wgiFlkw=;
 b=TVSaWfTifwC+XrSYiX4rE4CgdPS9zzvZ2gzQFn826iP7IupEx4U40EWTttwAu70ShF5pLAcaYMxXiYTrcEHHscaOF78Q9CVLUYNNZ/b7U3KtKP2PF544e/il3KF0azKKBBhy5k9AAa2nCYnKTvsgDqtq8ySC7XNG18q+BMfFE5iVLTsO5GidhLwvsjnNfslhhADWnO46/uJ7w04/vInheu3TrJOV8UcMWcxgcfm0BYOiQWIPDHFvqnM0eHhfcIZeQIiPeC7QqFp9WXE8cjP27jRM82NOYiDflptFKaDsJmVJnSCw/5A+x2DdRr4DXvtYMQ88kuzMbUC/sgHuaKrh9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOrdePHYnU7ac4eWjHC37mbtvSHxuG89TqC4wgiFlkw=;
 b=L9Ev+WomEwp2ZhXJd8I9b6bxRaM2eTH4JKF1LDHVwh2DCrtw7MG9SGX5Z5Vy+tROAc/J0/uAucDY4hV4CXryybHf24W8mA1QnI0SltipIiL+ny8Bv2mqk+WWzuhnoqi/jQCMgreCzBUtrPyJtholwiDF8KntN6rTU/fhgC7jTH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 05:10:31 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 05:10:31 +0000
Message-ID: <ad973496-eb18-44ad-aec9-a28ae2af2224@amd.com>
Date: Mon, 21 Sep 2026 10:40:24 +0530
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
X-ClientProxiedBy: MA5PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::10) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c27c7bf-1e43-4761-b961-08df179ea8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|11063799006|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UuDnMOkAOhLVB5OofmJOsxChcnaT+pROiGMSdm2j9xMYEedjr3tXadqZMzT1vZnW/bZC+zjB6MtHAnck2Jz/aMEzq4ON0iIdu7IrpTlQrz9zDcNyTLoRdI4sVkTPzf6BctOmeCqIgMDMjTTvSZK93Croulv3ztmiZjF+XsTSObFKpXrKhWTuNqa5YZKfUM8BbAPyCqikogRSmuSyxAmK5AvwJSSO6KjhO5HgZW3AjI4Iaoz9G4I9IpsrXB2i0+XCJ5Mnl1Zoxrg48zqf8RpPRQrzXalXVSDyCpGDhsPGwivvklDJ7m2mIAzp9QCTK2+a4nY2had4S+HYba2eGhOfnXG35akMsiuPDj/N8VtrptUmPVp2vr52fO1ZDVcGNgDhGq7k+955FkKFHlgVb0rSkpxYgIFMwpMoGNU7th8PYuol1eVkSZJs/3nm6U/4yIS6aMlksopyG9a5xVa2RSmoc2s970BBoh5uX4O44+caKDqgxhIlQQyVa6Qy/89DOZj11MYhb1wfH/fRQ9VVIkvhlCsrfgbhep9LkrRItWXQFyCZ0ZaztYdcD7RqBwMlJM05y8Sg7SKN0N+/U2K63lC913OuVqIHlnhAkV90wCZZwvDzs+BpjbtXTBFvxDrThTgHzfpvsrMlx9kQV+xiGx0orKS6bLo8ksoVj6b+j+LDb7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVNjQUFnd21qNm1IR09Gd3lsUUwxMVk2Q25PUlQ2cmpHTEtrNU5sek4waVFY?=
 =?utf-8?B?MjZzQjhibVFhM0RncUNSeWNEUUNoOStjbGZrN0ZLQ1JLbTh2aTJDSGVmMjVa?=
 =?utf-8?B?aVNHWm1uVmFYdkxxUTBHUlFaNWlLTTlhOTNlVmRpaWZlYXR0bXdnTWNEemJa?=
 =?utf-8?B?djFsZmxWWExwVy9jemFGazJnRzFUMUptODg2UHhYUWlJbnR5THI5SzlZVUcr?=
 =?utf-8?B?UlZFSXNLVlZuQ3lweDBYemlTdTcxWUhkM0x4UHQ1UG9EQlBUSWRyWExZZFZX?=
 =?utf-8?B?bkxmQW10dEVIQmlFd3B0YWJPVzB1dTQyMDliODE1eEx3ZnNvQmVDOERYNVQz?=
 =?utf-8?B?ME1JeXBVdXVYSWxjeVJzV0l3L3I5VXMrSUtWMVVHb3NYRjJ1NCtiaHFtWi9q?=
 =?utf-8?B?ZXh4UHdSYUNKZFFxcHhOdlJvRHFHN1dHdjFCTjNRRWM5VjJBaXhrckdPaHZI?=
 =?utf-8?B?SkVNcnpxS1YreXd3SVlCdFY2RFNSZGxXV2hsc2p2RS9RemxhbEhJMDNWWjJU?=
 =?utf-8?B?NSt5VDczK1h6eWQ1RUYxRWErTSsxRzlBSTQreW5jMHMzZDMwaXFFQkRPejhn?=
 =?utf-8?B?RWVsKzk1M0JPYnJvL2tzbTNmdUZxYzBob2ZLaUx4VkdvejdSTmZPaGxvODgy?=
 =?utf-8?B?L3dPKytxRjNEaWFUMHNFYzBjUDVldW9SY2tXSklqbU4raFI0ZmlQaGt4ZFBJ?=
 =?utf-8?B?c2oyTUdzRHF6TG9QdGw0VzA2NDcvdWlHVnV6Q3JFdm9hd2N6WUUrT2NKampl?=
 =?utf-8?B?YU0zWm1tejBleGhmb04yQVNTYldONCsxaWpmaXZwRGh3R28vNWk5NmJpNndJ?=
 =?utf-8?B?cWdGUzFvTDhJbk5lUE9RWVhDd2hBYU9vZ0c4VGo1UUNlajdMRVdHSEp0SzVW?=
 =?utf-8?B?WGE0T2tyaHRWWjNxRmsxaHVVRjZIaXF1M2hlUENKNFZ4dys1bVVSdkw1ODN1?=
 =?utf-8?B?QUtYblprSmcxd3NUSCsyL0ZKSEFoazBiVWRjdEpaYk83K0ErYUxJU3djbE5I?=
 =?utf-8?B?MGFPdDBrNEFDakFWMlpJVVNqYW9HOW41b3BYU3E2eTBKeG8rZklqVXV2aEJq?=
 =?utf-8?B?bVZTSnVjMmQweXpNNnRoSmF5T2hORzQweWdCMXdoWGZWeUlUTmw3VSthNW1V?=
 =?utf-8?B?TUVLYTYxSjNTc0pQZVBNRFc1YWxCTmk3WUZiOTZwUjIycFBESnEzMm0vdGxo?=
 =?utf-8?B?ZWtUSllVQ1hjejlEeERlbW9OaVdoSWhSLy9vMDh2T29qMVZqN25ZL29Zc3Zm?=
 =?utf-8?B?aWpxdU5UQkgrTEVoK0R1Z05VRVZGM0I1VXB6RzNuL0FnU2svZWg3RTZDRlFJ?=
 =?utf-8?B?RUxFWGRxejUxTmU0c3BEeGhWcVFrQkJLVFV1dzlITWJoeklzT3VyL0Voa0d4?=
 =?utf-8?B?Z3F2U2FISFNpd2g3SXhjVmZkY1pWYmM5YnJ5WlhkZEFIaGU5RlI3VXJpcGpF?=
 =?utf-8?B?MkVONFNqd21VamJyeFlOaG95YS81b3hiRWl5eFVqbURTSGduSWVnNTY5Qzhy?=
 =?utf-8?B?amhESklGaXV0UVIraFk5cWtEaFBxYXBoRjlIalgrRmRqaVUyOEdISEF3NG1j?=
 =?utf-8?B?U3RFV0V1dlBNWEpvdW11M0ZHSFVRQXl1aE9Jcml1dExJaGp4QWJRU25Ccnl5?=
 =?utf-8?B?aFk5SThvclZLcWQvTlZOWFQ3clNNTm90R3JVTTNSMk5xN2xhNmEycWFCbHR1?=
 =?utf-8?B?R3NuZmtCbk8yT0grNDJUZm1BWVYybDkrMnF5WE5hYzFQVkJZU2JsN2dHV1hL?=
 =?utf-8?B?cGY2WWgvblE2UDFsU1BsR2hVby9SVmpmUUZvOUVUUkVFWHBEdHMzd251UlFv?=
 =?utf-8?B?K201YWRmZDA1NTFncDV2MGVKcDZkc2NIcCtRMHFFbzdFaGJocVZkeGR1alhB?=
 =?utf-8?B?T3FxWHJyK2Fldks2ZFdOR3BKeGlGZUhUNHdncTdQcFlVSmRDcG9leWo3ZzJD?=
 =?utf-8?B?NGNBSkVSODlKdlI4VlpNVEg4aUdJQ3Mzd0wzY1Q2a2w2KzV4VzNoOTRKZ2Fo?=
 =?utf-8?B?Z0g5TysvbWZRMEpUTzVpTjN3dGRBT1RMZnhxZ2cvN2pGaDh2SkR4TFRoLzdv?=
 =?utf-8?B?SWswQThFVTYrRUlzNzFCN2hDVStTU3JxTlp2ZDVESFhSNVc2V3JVcGlSMUlk?=
 =?utf-8?B?d3VlZ1NocGdqZHZVeHU0SzZBWGZXQUhNejBsc3VnSlpnS3dkeGNKcTF4eDl6?=
 =?utf-8?B?bVZyUTkwUjRTS0lqdkluMUdyTkhUMUJEV0FlY1NsRVRxMCsvOTlNMjEvbHdR?=
 =?utf-8?B?QThYcXVsMkVBekY1dXJQanNuVHR4cGdCbnZkU2dkZHlXazNhQWxzTUUvMVFO?=
 =?utf-8?Q?z+gH2DMEki3OKwrT0f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c27c7bf-1e43-4761-b961-08df179ea8f7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 05:10:31.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YC9Kqhdpv9ZaiAm7A8ktpOxQONO5dfiq1unCHX2i13ICMPhdqbJM3hSmTjMWnCqvX4bCRXiXaKy13wrPlWjljQ==
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
