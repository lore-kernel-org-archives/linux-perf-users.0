Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573653DFC8A;
	Mon, 27 Jul 2026 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148718; cv=fail; b=p4/qA9toAb/WicKKcXPLMOTOTiwTMcg726xzfi8TGiomVuIQbBe8BfYPUjYVkfJ7FptkEjkCo1Ez+ut/b7dNwyefgYwdDoK2JF+UbGNFZkyIdL52pE4bN9mOqCbuSS1n+cIoej9MURWfhzxNkY3s0jRt9OIdlpN8AoOv1XIcBY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148718; c=relaxed/simple;
	bh=gYkIfP5VfZiqRvynuFJOeepRV9AxF7nZNEpjJIGG9K8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OtF/YOCBtTKcsARsmNanunfZGBEyERE+dg1pFcbSGcdzn8kxt5117u0nUqQfQRb38KeQLi+AWF5AAC7CgHU4I68BhnVHiG14uCnCKy+mc6t9qJQzKVq8YILahZH9VX3kRtN/8GhPu3iWHrQ46cddeCaRmxTp0eeI42/HGL++t+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aAto3MuL; arc=fail smtp.client-ip=40.107.209.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aAto3MuL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ma3NzOpDlGHX2QU2HIdsa3F/4zrQNcL9aqtOARLabiZjhPjZ/STNbdtzQCHgqNrm4Au/iK1TOE9n/eopYc+Yq/lewUj6G29UJ3YK/J318/aaikmpwriBClKkRPE3/BMThpwErCX4QrAgm1wVsvGmWiLEWCK2YO3hVvR6sv/mBve88eOoctYPapzaHWsqoEUWhT/klPIQIAzhFD+0hRjpN43DgnBE5APKsFzejHVCL7siXgbfSccJKCSrfzuASQQ+XvlPVOHiOcVoRxdqj/ClioyeIjkVtbvSyyRnqmW4pndQJb64+eNDNZy9b4MepKpKm6M2koiiZowBMAuAUgdvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvILWDWhCWGS/Buz3oDd//qhtaHIJ/QC6wkfKcV4Hac=;
 b=IRwMA8DrEvxzhD38BU2ia0byyzNt9Km6GwfrfH2PhP9+9BAl+NWPw5KXlSjjud3I3y85/fCMyyA/MKZ5afmqBhVw7IcWRSC0HFerkDwXeUlV191peDIKuJeIOLwq9uoqgjcgSdmSMqMr6xgdX7bhvDawUB2JAf6AxYmnV8ohnMUHkLiQA/YqqVoopA6cirytE7f8TIH01PJxpw7YMOV9Wj4wC77LTmwbW6iuTTT2czTWZgMwqaJ+q1kW7i7sxC5tQo17iWMHYNmInP3Ns5nmDHgJ6c+E0Yj9iqF1MGmpJDGsxTVnrH9VlXeSfQGjUeU/BQkYGtUHSKqUl7V4xXeklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvILWDWhCWGS/Buz3oDd//qhtaHIJ/QC6wkfKcV4Hac=;
 b=aAto3MuL+Dp++4ljEWX9hqYGzRRbbLynT9l5Jam5Dd+bg7GOyUfZJ1zqH9otdGgE3eFq/4lKzfwcxYELdNTcKqOHYDdLrOO9oPmmqy3Pm9ajNYEDYPDc7jzuB6CxW0SYD+bV13DqlPbprP+kUptNIqC72DxzO++egTqeTwjtXls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 10:38:34 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0223.013; Mon, 27 Jul 2026
 10:38:33 +0000
Message-ID: <7e10f25d-dd4f-4df1-9d40-c9d890641ca4@amd.com>
Date: Mon, 27 Jul 2026 16:08:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/events/amd/iommu: Fix cpumask of IOMMU events
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@kernel.org,
 bp@alien8.de, hpa@zytor.com, iommu@lists.linux.dev, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, sandipan.das@amd.com
References: <20260517114026.6817-1-vasant.hegde@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260517114026.6817-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0053.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::18) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 23bd99a6-fe6d-4aa8-1de7-08deebcb3530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|921020|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XtrX4Gem9bi/NB2BD8UeWRzciPthc4YWPT/WNT6jO3e9i2mQaGTLcnWC/PGn0NfJkk0siskV2H3eM80mG0n6NkSc6ZOx7F3RO7ivFd2d1PXx4l2bHU/eG90HmY+NHceFiLyugahjHTt+e/XmNhIc3jrrbECYqMO7/J59CigYLNMZICe7t62+3AQKW5uNfnDE1w8u+kj73LYHlQdIApk7DVlePCCIuxU063SXDkOnMfFC2/pEdIKgSuAeSIptA1FYyXw7Oa4RJ6AIsXHIN2ac9YE9Z0VdtnxlLLjhNch/l+dG1bV61t25yp5WYlboaHCj9nkl1YLPgnZGfxOnLtq4BVXoCJBnGtqWZMHrYmW6cFLVRVXKIKsWAAVtu6wlVizCfmFFYu+BHyfeHItFRpWNXwfsiBmLxO5TgdvnSRu5nlvvMZTMZPe5zLAMVq3a8SSHIP7mTPvzM4a0/YxEwbV3JAeXlaijVqkjzyGnfnlENO1DQnPJWg+Jsit3qjQLDnnFq7zzx4IAuBsiALg/WqLs8d5tMcvNhFvzw0QUh+zWF2jRRYv/NG29aKrT0Sk0+i6lWG5zDut+5oBvG7tAjAMOjcaIZnwtvxRpH75h5QPFQFUq4TPzg1D6U71GP6dfn/hZvZaqTFR0QW9TqN+LNaLxb4BV1DNbk0lN22HV8rHM/NRHXsjQ+MFFCSHzGukbOgsUPKhSyjrkPH0Q7c0WZhbgRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(921020)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3BEemJSUTRPUVUya3IwTk83dVRCbU5kRDIxejlaRVRaSHB1cTNWWWxCcnJn?=
 =?utf-8?B?RnhHVzUyb1BZWUpDNHUvQ29MbCs2MmZPWU55N1N3amRRZmFnd1dBK0pmazg2?=
 =?utf-8?B?MFZUVUQrMGRIUlNYVTJ3ZVBVTVNVWmZvMnM1Ui9UaFkybEZ1T2FGcFZiZEpM?=
 =?utf-8?B?R09iRGdxMW45bnJvbTdnYU9UYXBUUlFTYThmNmJCei9QdUxsWmJScmhUanBT?=
 =?utf-8?B?K3RJSEVGT0xkN0MvWmdJRDI1bTQzNmlvMEtCWU1wZE1TQ2dPWW8xc2NHNUlo?=
 =?utf-8?B?OFdFRXNQTDFPZ1RuK0RQTmVzbzR2MGw3TGxHblFrbTVQR1J2SmlFNWpSY3dw?=
 =?utf-8?B?d291WVY4cms2d3Y1RUx1amk1Sm9xM0xMSWlvYWxkM0hxQmZZL3RiQy9RUkFP?=
 =?utf-8?B?SUZWY3VsenhrbVluMm91bGVGaTNiK3hhTllZWk5HVmF4akhqb1RNS2QxT2pG?=
 =?utf-8?B?UGZ1S28xOXRHWFhQUjNZU1ZURnZHczcwMmhBYW40NVZLd0c3WGJrTFlyL3dr?=
 =?utf-8?B?Mnl4SWVtczVVQ1U1ZjQ0QTlUclh3VHB6a0pKMGxaUCt2ZkZsUHU3clVpRUcr?=
 =?utf-8?B?KzhNMkpZUjAyb3JwOE4ycG1HNXM5K2Q1c3IzZk1OQWxNRlJQYnRHVUs1aVBR?=
 =?utf-8?B?OVRvSXQ0d0laNVFBeU5SU3RtRTNQNXdEajVhUDRKSGlhQXJOZkE4cFhzMy9U?=
 =?utf-8?B?L0IwbEthS2JvV0RLMy9uOExQQVVXTmplZURaRmJvWmJWek1aODNSWlBXam82?=
 =?utf-8?B?anFNQlJadVJvNXhCYytjaHMrenBjRE5VcWVra2hvUy9Malp3QXA2MHFDTEVR?=
 =?utf-8?B?aklESnl0VGcwdHpyYUFYMGlpOFltV2owQVRTc2pPcytWM080WHpwQkpTUlNh?=
 =?utf-8?B?Y1VQTjRiN2tWU1NzVkROL0VNR3RKU29zTjZnUTlnV1FBTW1PY2hLcUNmbDFF?=
 =?utf-8?B?YkdxS0gzRkc1ZFBTMFJ3SGEzdmtGcCtWblBrb2FGVWd5dSs0bVJLT0RxVUVp?=
 =?utf-8?B?d1pKMURLZG00enNOZVBUdzhoRzRZT0JhRERCMW5GR3doajIxMnQrR3N3NU1i?=
 =?utf-8?B?TmhVdy9XTGZ0Q3Ixb2dPQ0pzYkgxMzF6WlQzRnJ3c1JodThDL2hJTHh4T0ps?=
 =?utf-8?B?QkV0SXoyUmY3MDlnS0o1Z1N6ZXpRSFIxSWx2aWNjSGthYkRaVlFqcVloMUVi?=
 =?utf-8?B?SEd1aFhqZVNKdk52bEpEb3BOYlhxNjRKYnlFRXhDNnRmazVDV2lLT1pZVGpt?=
 =?utf-8?B?UnAwREV0dlBQczh1MUZJOVVxUk13b1VMbFFOVG5OTWVyV2RKMzdUVlpqbHEy?=
 =?utf-8?B?aHd0VFVTZmk1Rks0TVRmZUtlNDdYdzdnazZFNFpkUmd2ajZNelFLWnVuS2xG?=
 =?utf-8?B?TnJzY3JibE9YcDVZZHcwK2RaRFdYdFRMNkc5TGRVNkt0SkRxVzA3MWdGdXVv?=
 =?utf-8?B?a016RHpzcVJRd1NDK2FLTGQ5ZFBjbG5Vb2YwSHVvdVdDaGRseHZvOEpuc25i?=
 =?utf-8?B?SGRDVUpoQ1orbThaQ1BYUXhUWFhwS2ZxWHFYVlJsTUFpVDREMWJUVUdYY0pX?=
 =?utf-8?B?bzM2K2ppT09uZjMyVS9wcFRKN0dwL3hmOWNRSnZVa3pBZGJMeFhsNzNJNld5?=
 =?utf-8?B?N0l2Q0hxRXozL1lGRFVWcUd2Mm5rSjdVSnZOeFNhK3hTdUNnRTYwaFJ1WDRx?=
 =?utf-8?B?RnhoUHJScHczeFJtQmxWWHJhNDRtbnplamJEcFJjZ2M3Z29hZ2x4bUY5RHVZ?=
 =?utf-8?B?dGRMdm13Q1hlSURuN3JWT0VWRHJwZ2tuRElFblAwK1lQT3diZCsxOU55ODc5?=
 =?utf-8?B?ZjVBK28vbkJFSU9ZQ0tRdmErN1F5Q1kxdzZRaWY2c3hWT0NqLzI5UHViK2dN?=
 =?utf-8?B?MlhwK2JYdHVpOE42VXBGTEhaWkFZbVp0cDdXWndwWHZNRDdzNTNEMFdnaTFu?=
 =?utf-8?B?S0Z5RENsRWtnSEQzelh2eTFJdXBRYVZrRlR1cDV2eUFDTEtuUHM3UjVBRlhL?=
 =?utf-8?B?R3Jib2tJNzNnODJNSlBueGRuWFppeUZGL25qYjE1ZVVha1hvdGM1UzRJREVx?=
 =?utf-8?B?ZW44OEp6TnlJUUVJdkZvMEQvcVM4VUk2aWFFOGVHTHVuS05rblBHdU5qSlFD?=
 =?utf-8?B?YThPK04vMGoyNTFqOXZPUEJJL3lhRGZiS1hxRFVRSWRJWW9pUFlPZW1WcC90?=
 =?utf-8?B?TUlhSWZLWVNpTUhwVHJhQiszU3AzTXNzNjVKV25LQ0JDWENJR3h3dW5tYTR2?=
 =?utf-8?B?bDJrckhuRVpvcFJFVStBRlFKOVVFWEg5c250WnkzNkNFN01EaVlDNDBXMUgv?=
 =?utf-8?B?eGttcDhGSzBrRDBoV3c4NlFRN1Zwc3Y1T2hqZU1NdlQ2akFoMmU1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bd99a6-fe6d-4aa8-1de7-08deebcb3530
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 10:38:33.8137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzi6q603XWz+P4busSy5agWFSisEx2upChtljkL6JfammWP55iGmgOrOnhP5ZBze47kpNdZKsvE+IfDW2Q7H/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192

Hi,

On 5/17/2026 5:10 PM, Vasant Hegde wrote:
> IOMMU performance counters are accessed via MMIO space. Currently IOMMU
> PMUs uses a single global cpumask (iommu_cpumask) shared across all AMD
> IOMMU PMU instances. This prevents collecting per-socket numbers
> (ex: perf stat --per-socket).
> 
> Fix this by adjusting cpumask based on IOMMUs NUMA node.


Can you please review/pick this patch?

-Vasant


