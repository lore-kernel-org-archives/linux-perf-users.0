Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A081372;
	Fri, 13 Dec 2024 07:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734073661; cv=fail; b=Hcg2j5RoYdUvQPQPanK+b0EaRtyOZGPdjf+/RCj1xUorsfbh/DyXX2AOWtbXGEzjvF0Z6lLSfld9Hi/9ht01fmNtPZqDIo7IoheWOWAyt9g7wowntNfsbEkugDic2rfkb2WX1uaw3DsBf6SlwtKInTESW6IxZCEnbVMYEaUw+5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734073661; c=relaxed/simple;
	bh=L1rLYFY3gMDsJi0bFdLToXOL79lYyfasV6CEnVtGme0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rXfiVUfyVmkvegWhQl7xal/zGtoTjvZUnZjbV98aHzVei0FQmgFf7cw9efK83w+llFaLZJRbptN8/31jYKKZcAjBEfdP3TAkn4IKrIBTTA8TcoG+kbl1SGYj756oBe4VrL8s0IZw5OQJwQom1z10QFFLWC1BlEVkVNBUHph+dg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=esk9/4K5; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="esk9/4K5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOUzw2zr0da5YWYvsetoVjCuCFshx1XEPPWXJB0M6eNdtI0227/TB8w2rNvPiM4V6mdmnWaty/b8kSmIUhYEWBOKexaGGR9H0VcWX1p5tc8F4yBUUOuA3zwhU1SkkJ+P6cXRr1FNxGehZtEXMWuYFN8C1CKOHb1trR7QmL5n+v+I8Bre2I8AvSt7PSgDYhUrgQG8SgssvgxxMopt3O9XzLgUPnhgWu/0CMflw+JVLiLAJIufCHmLkm2MjBD0t60mWrrFG/3UDlgnGluiC29atE3vG6E+eaGntIjYAB+1K6FL+y7K9TABd9N9hH204eURwm/vi/NS+jObz4Qv36yChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yQJY01BloitbLUEaqMk3OxlF9WcF0Kkx1QnvXE/zBk=;
 b=oFAVVLS6yHO4A5xBu58QuvLCT2PXcAaX8jpze3F2leqoHY38wwjAgjvR5XxOoRaWiZ/e80Kwr9criTucKWFzbNd1RBN/JWoCMEHiNb78d+PoX7o+MOb8+N+60Wo50mG4XG8GhO62JJYuTiegsQMQyw5VPlRSA0grwtgHQfytsLOpUKqveOkpJnNnRUtj2qxJcsetbAiJpalHX/ScpJ+WfFQqVDEIeRLRudXRzrRFnk3YMFUkeQABiK0EUlAW05Iwtu7KT08dN82XP9X4BndSLTtU3uVjkpOj2J7p3uzA2UIJjRjy48SqNX74q891dw+yzaF3xizZjBmqrT6nWH9/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yQJY01BloitbLUEaqMk3OxlF9WcF0Kkx1QnvXE/zBk=;
 b=esk9/4K5SbQXe4DulTrydzOiQrvj9kr5wpUalXwaKZzgpage0UND+bxPHCCPs3Nkd9bvI1td29POO5z5pvQUW5z7W/4Cq3OLNkHdFM90Msm6JpLkw4wp+X/ueC7aMsLygpznoqcG5I0e4caIEGyELrphf1Y3rv+/nJ6LhXjM6U0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 07:07:38 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 07:07:38 +0000
Message-ID: <fb6f17b7-8ee1-4197-afb6-923b372965c2@amd.com>
Date: Fri, 13 Dec 2024 12:37:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf script: Fix output type for dynamically allocated
 core PMU's
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241213003609.564709-1-thomas.falcon@intel.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20241213003609.564709-1-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::14) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c713c6-8757-4a8b-38d1-08dd1b44d38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzFMQ095Vi9OOUZ6VThzOXBFRnZ2WTdvZkQxRzBrV2hSUzcvRithVlFLc0t6?=
 =?utf-8?B?OGVYMUxwQlBRaDE2NDVFcjdOMEZnR2xROTFIb3NEcCtUWEFlMS94OWdFcm1L?=
 =?utf-8?B?ZXRlYmNwQVZmcGxITXVOS3I1ZHNmbEJyL29JVW1MSDAzMnptMkZFam5qV3Ro?=
 =?utf-8?B?YnBGbXhEdjBmSzk2YWlneDE5cFdmWi9kK2piUkVXYjJISXd1NVZRZU5oa09N?=
 =?utf-8?B?QksybmxLeWdZMEFwckswM1NkZXZXaTNMN0owY2N5V3YyQ0h5S0Q0NVNTZkxP?=
 =?utf-8?B?dW5DMGlDMzczVUFmMElwLzRkRGF4RndsOVEwMmVoZFFHWTNXYS8zTWZTUEUx?=
 =?utf-8?B?bzk4YUVxa1hxM1VoNkk4VytwWXNpR3UxN1Nab1dwTXQ5QTYzNTJoNXNWNnda?=
 =?utf-8?B?YjY5MjhDQ3ZKUWh5UHJsN3BkTnNyVW93Z0dnbVBKekVzelU3RmMzRk82YjRn?=
 =?utf-8?B?RmdEdkE2UCtScG9maTNENlpJK3NNVWIzVkJMV29ZVVVhZTNVbUJGbUJLSjdi?=
 =?utf-8?B?Zjk4Y08wVXJKOEowcGJQUVVoUXdiUC9wRjNLWGNWVm8rNU52MGNVZGY3Q3Zr?=
 =?utf-8?B?NlZjbEtPVVNGcDhzV1FTbitNV3VNQUhCbjdrNkEyQzhJTFEyNExVT0VGSUtG?=
 =?utf-8?B?eVRUai9EdlJVT0pLalQyMmNpdDZPYmpCMDdmUUcrNkcwL2UrU2JCMjZ0TzlD?=
 =?utf-8?B?UndWaEhxQ0dhY05uOHpVa1k1ald4NG5rdFQ0REZFM1lPZVFOYmF5MVJFcDdy?=
 =?utf-8?B?bk9SU3duaFhWcW54RWxISllIZXArMXlZYlc3TDZRbHlSTzZSWWpCdmR1ZUQw?=
 =?utf-8?B?c21kSHFqMWliRUVkTXpUTGFCcmt2bWRqSTI4WmJGQnZVNWhnS3dmbFdId3Jp?=
 =?utf-8?B?Rk1tUGVQSy9kcDhIanVVWFJ6d0phb3k5amFnYTFwV3Z0dXZ4VWlkTEwzTHEz?=
 =?utf-8?B?THRlTVR1TWQvdENJNGhEY2JJSHNVbW1OWXJWN1dnTjBqNWE3Z0xJYmFUeWVQ?=
 =?utf-8?B?cStHTnc4Q29LaTN1c0x6TnkrbkxMWHgxdjZPUC8vU0U2aC84VGp6K2JETWZM?=
 =?utf-8?B?a1A3MVZOZ3B1UTI0TWhwSi9ldmYweHo4K2QzZklSdXl3K3JMcUtkRzVwRjRI?=
 =?utf-8?B?WFhjaDVJa2ZtemNJbjE1TmpnQnhRZHg4SEZnWDJQYWVLWFhsY3ljUmQvbmMz?=
 =?utf-8?B?M0FoaUlMOEp5YythTDJPQ0xmcWVac3lwUDlsMXBNckdyMnZhUWN0TVYwYXgr?=
 =?utf-8?B?eWx0NW04eG11bmR1U1ZZdStlVlVsa3BScG1IWldWZENHMlVHVDlxMGtpeWJX?=
 =?utf-8?B?Y2dhSWYwWEV5L2luMVBrTTZsVjJrRzJKUU5WRmJBeHFvL2pJa0Rudk15MUI1?=
 =?utf-8?B?ZklSeCtEWnF1aHd1OVBuZU9sMzVENjVRc01xWFZ3MnR5UEFQYSs1RDVzQk9B?=
 =?utf-8?B?TjJMbnV2anZZRi9QdkNaR2Uxd21NRmw5MW5iUGd6S2JtaXdld2F6cVZkQkdP?=
 =?utf-8?B?RkRCSGdMd21QYjZvMytmRUlBeGlaaWlUVnhnRVdRbkg3Ti9IYTNLdmlycmVD?=
 =?utf-8?B?a1dXNjBiN242YUVyZm5kU251WFJLbUVkeVBjQUdVTjRkVnkxcGp6Vk82RU9T?=
 =?utf-8?B?c01TNFpSczFvM0llQ1FSOVpjckRMOURKZHFuTTJjbGYyT2UvZVhkdWI2QTVo?=
 =?utf-8?B?d1cxakhEcmtyNzJoYzNwMDc2OVltbys0R0J2bkFvdG90a0lkRURVZW5GZG1X?=
 =?utf-8?B?cDVpc2poUlk0ZHFyZnFsOWtQQ0JqM0lFeXRNQ1BSUHRZTFMzbHpCc1J2L0hs?=
 =?utf-8?B?aFpiNmVrRHRnU1pEdzZRaUpHRWlVeEo1eWVkeGl6VGpEbmhBczNCV2xNbjEx?=
 =?utf-8?Q?XpPO1G3HIXM5Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDJPYVFVSUl1bUtISGJQS2FqRjM2OUZpS1p2S3dnRTFrVFJPVU1Od0MrYVNz?=
 =?utf-8?B?T0Y3MWFQbFNIVmpzTktaNTNqakwxMDJhSURodWQzYlVDRktmT1RLUWNBLzBs?=
 =?utf-8?B?V05KMFNjRDNTOXR0eVBmY1BFOTlxTUdQY1NWSGx0VmhmSUgxeUlqajdzOFpR?=
 =?utf-8?B?R3Q1ejFvSGtRTEpJbCttT1NIRW9VelBwTUEraTcyNTlsQ3QvOHRkdXZQNmxE?=
 =?utf-8?B?MEw1c1ovV3MxcklaRlp5QVFUUmp6Vk1mY0NFOXAxUkJBbHk2akFDc3BCYmNu?=
 =?utf-8?B?NUtHcGVvV0lDeENDYWxTK3g3VDhUZ1lWZzBaVmdUZnAyU1pjZ1lwcHNYT29W?=
 =?utf-8?B?T0pwOXdCYTgxUTcvNE9ZK200bWZDdTUvbXJ0Q0NCYTBsUDY5U2FadmljQWxF?=
 =?utf-8?B?d2I1aGkyc3haRzBzaVVVQ3FKOEdHTElpMVZLbVdsVVg3RzZVMmllUTZha3Va?=
 =?utf-8?B?bGt6Z0w1eDZja0JZWW5uQlo3U0Jkd1lDWDdwb21HcGZFeVlMa3lzRmFMZWd5?=
 =?utf-8?B?NlJNbm1NdHVkVy9TelhzZzZ3cmFpaEcwNVVuemsxUjg3QWNBNUM4SG9RUVVQ?=
 =?utf-8?B?ZGcrc0RMNEhrck9WNWZ4VG0yRE1iT3NWVHRYN3lsQ0E1dmhWTEFCY3hVanBy?=
 =?utf-8?B?NldPWHJoZUxpK3prVkNHR05RLzJGc2ZJUk9QQ2NOMDNYTktjTTNGVjJHRmFm?=
 =?utf-8?B?WE9zTHJvNGlMWHF4MitxZXNIOW1zOFBwbm9wVDFzZnhZNEI0WHEvcmNkeVlE?=
 =?utf-8?B?UzZsZkhDSXpjY3NnVEZhUkptYlUvanZUc0RXK2J5Qlh4NXYzWXI1QlFFTG12?=
 =?utf-8?B?c3ZKZWE4MUo1dHc3c1NhekFIbHc0NCsyN3I0U3UvOUk2ZzJZZzFLSC96THhx?=
 =?utf-8?B?dTFJejN2V0h0SDRTM1pJbGVIQ3lVMUF1dWhLZG8rWStYRWxBelpCalFTQkhV?=
 =?utf-8?B?cGxnQlRobTZ1NnlDTU5wZlRhM1BZKzZsTE5PZmhhbjJ5VGhLci9kUlM3UDNx?=
 =?utf-8?B?NkdiVjNVTXNCeXJiR3dRT1NPS0llZ2lqRFNUUlNUZ2hOZ1M5Qm1FNjJSL2h0?=
 =?utf-8?B?UTh5Z1Z2SGN5bFM4MnZzckVISU5SYmN0OHIvaXhvckRRNDBJWnVxSmc1aUZM?=
 =?utf-8?B?d05PYUJwNVczcjJ0V0VzMk5ja1NuN0Jna2pmOXJabTBVcEhVTVI2S3o0eWJk?=
 =?utf-8?B?RHZWc0ZSRlZHRTQxNWh2aEFFYnJYOWxkYmtOY0xzTGhYdjdzdUcwT1Q0aGFi?=
 =?utf-8?B?U0x3eWxEZE5YMFprOVJGOGVaUW11aUxHMUxjWHd3K1ZqRXo4dnExU05uWkI4?=
 =?utf-8?B?cFUrTTg0aWtVNW9lRElmQzRQR09KazEvaGVoemxWcVNvSFQ2aEFqRGtOMlFI?=
 =?utf-8?B?ME1udmtqUkwxUWpzanV4S0MwdTc5b0pSSldLeVZMd3pPTjNpUjhMQkdYakps?=
 =?utf-8?B?WUppYmZlS3QrQUo4cFhOYWNiTzI3b3JhMUp0cTYxRlRKUjFXWFRJMkxrN2N3?=
 =?utf-8?B?WXZYOWl3ZldOdS9ZTWRZSDVlOU5idDlCSWdqeHhSdGhpNkJNSHBLaE1DTGxB?=
 =?utf-8?B?UlJoeU1pZUFKNnBDMkMrUzIwdmVPWGhqTlk4NnQ5TUJGdThpYjlhZWMxaEps?=
 =?utf-8?B?d09RVWlFcHZ4ZHJ0ZFcwNTdENU9BUjA4UVNhQi96VG0vZTZQMldMaWtZenJk?=
 =?utf-8?B?ZHRQU2tyTUxiWG4rK3Bob05HMDY4aHFkWnVhcGNua0kwMXV1R3JGVWpManBO?=
 =?utf-8?B?UllDZEltTStBdXoycU9STFBBUUIwS1VWNTVudTZzdDFBWU96TUN3YW9rSXcx?=
 =?utf-8?B?SHg5aSs5T1AvUzRKcEhLZDV2dlVsRGV1MDFtUHp1blFlK2VMSFBmc0NkWThB?=
 =?utf-8?B?azI1Z2lDODJodVlaV2NSWW56R2tUTjhpazUrTEdiSFd6dTdBUlU3ZTdIeHFR?=
 =?utf-8?B?L0Z6cTBDY0xnL1FhcStKbDJpcXFucnY1OXltZ1Q3L0QwL2FNaW5zS2hnR0tj?=
 =?utf-8?B?RmJtdWNhY1dwbUU5VEhSN3NNbytlSzBhUmtTYU8vVFhNY2d5clB5d0tBNFMw?=
 =?utf-8?B?emRWZ3RXb0VaQVNhUXFWbHVPSFpxZmJnS0NUUDhVWW5lbWR4OEFRWU9tWGVP?=
 =?utf-8?Q?U1F0rVqmaZedhczJjujOXBs62?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c713c6-8757-4a8b-38d1-08dd1b44d38b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 07:07:38.0858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVJ/JIxza+xKtUp0th9MxlFTAq165HcG9lLFKeXdV5rQn9/42E0QtSR5vZ2q8LhDRbRAQGlOBOsMj2shFs49zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402

Hi Thomas,

> @@ -386,6 +386,8 @@ static int evsel_script__fprintf(struct evsel_script *es, FILE *fp)
>  
>  static inline int output_type(unsigned int type)
>  {
> +	struct perf_pmu *pmu;
> +
>  	switch (type) {
>  	case PERF_TYPE_SYNTH:
>  		return OUTPUT_TYPE_SYNTH;
> @@ -394,6 +396,10 @@ static inline int output_type(unsigned int type)
>  			return type;
>  	}
>  
> +	pmu = perf_pmus__find_by_type(type);
> +	if (pmu && pmu->is_core)
> +		return PERF_TYPE_RAW;

Minor nit ...

output_type() seems to be getting called a lot. For ex, for a perf.data
with 4530 samples, output_type() was called 181246 times when I ran
"perf script". IIUC, this pmu lookup is unnecessary for homogeneous
platforms? If so, can we make it conditional?

Thanks,
Ravi
