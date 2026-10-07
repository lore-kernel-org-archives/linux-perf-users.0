Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C1141D629
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791389043; cv=fail; b=P5+Y4gC79EowX+WXSxmvZVOc159c7eRUCkl+JSEfAk9bq6B1voYJvi4+Jh69lu2UOZumoAhto76BgJDWHtq530IZqW5YU8WLqG4dLyQrf22oZrPpinczDPGEpLui20Mk7faN2MMmLRI66wqjr7unkJ5ZHRXTvkfiwViiJ2i0PfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791389043; c=relaxed/simple;
	bh=A1EhJNPX7OMeplvHF88xUc+5qdM8HxbUwJDrXBLBC6g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mpVNtSLg+PtlH1lqgCzq4G2qH5aKIrcGdDgk6oBh9v1tDXsi/x34cwwFnJ64c8V1ezXs4bHKaETUKP1IBSiYz9UE3eT8hy5QZpoz5bbFxPPhC7x9rOmr32GwhYMa//UK9nyDEeYweNmxHJ7RqRIePC0O/y8AWTOZhdwb3J70Bvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vT8CtAXl; arc=fail smtp.client-ip=40.107.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vT8CtAXl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QB1zxWp/aCyuW/zM2DWmUHXfomQUiUzggBtSfcRm9CRaw8Jduqcvd8psUXTSqkZO6Sv7oStTwJDqGbMc2qlzYCq3lv1oSTFammzgNzLMm3erBbX8kUtUO/lVcvyOgeFldOrYHkSlKV3pSPOO3gQJ0UkkFzt0oKhlHG3u7dwMa3jHf7wvRPI46Us5aKuARVlFAIUQHVdc7eBwpdAx7/dBBSRM6NbW2mHPolo6xH8qfi8PBqgTCD0N2f+/EAYlyJNJRw6sZh8pNcTfOzy7cy0r68MYQAclk2HiKxfHLhCOGd/nqOIECd0eoECu9cgm2BxecO2RdfC6yWtXE3u+90E+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiU54Xwzzyz9TNTKxWelIBs6buw35ZcAOju1Yr7GMxM=;
 b=nf1c4kBJnue/sydwA0syCvqkVeYYR7mEK/ArbH4qS0x9d1qg0+w3kgTZcDHs5ZBHY146EIhKy/3DUbKvyh5rGCTwtvhEjnfabqp+Qv0c0NGJH7b5sdWTuOZdHOcnAE3k6evbttw1xGGUqFjigLino0+II5Xg/wTXUY+21VOmKcp6YWE0CRlVZ2G7CvYg10EF3XrZUuSd7GwRITzoSW0MBOzCy+iRTK29cNpKYjYpPLWbWJMcGyNzbXsrf9D9IdzYVjjjLLAulnKAUr3vF5szTkwQdAeThBJcnZUE4a5b69tSUW4nXzFxEeiGv7n5biJ08jN+m6dNG4F8hdrUHk17sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiU54Xwzzyz9TNTKxWelIBs6buw35ZcAOju1Yr7GMxM=;
 b=vT8CtAXlJOGun2NmeWImoScfbp/vNRBb61+Hk0DSy0rNAN3V1Xz3F8OvzxXxXAMoltl14kCg6UPqWOTjKJDim+uLtJGazWG5n7epgKN/UTVmmYh6RyEphhwihDDKjJgNaMi53+YVCKkQMrddFCaRDboZgETXyFsq8aiEDolQPOg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) by
 CC6PR12MB283837.namprd12.prod.outlook.com (2603:10b6:170:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 16:03:57 +0000
Received: from DM4PR12MB5721.namprd12.prod.outlook.com
 ([fe80::8fe3:c3d1:a057:fd24]) by DM4PR12MB5721.namprd12.prod.outlook.com
 ([fe80::8fe3:c3d1:a057:fd24%4]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 16:03:57 +0000
Message-ID: <38529f6b-448d-443b-bbc2-182a379cf590@amd.com>
Date: Wed, 7 Oct 2026 21:33:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/uncore: Extend num_umc_pmc to fix UMC
 discovery
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20261007152746.3658877-1-sandipan.das@amd.com>
 <sashiko-outbox-163154@kernel.org>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <sashiko-outbox-163154@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::10) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5721:EE_|CC6PR12MB283837:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb95308-211c-4de5-a799-08df248c9748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|10067099003|18002099003|4143699003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	XvcXm9m50394h0iSG2eDFWb84yd3QRa/OU2ogCs8D00jmTidU1EpyhJIVXyfJtuAXIyWtWUnU9uHwoFdSIXOk2wh+50mFzGXTy4j4ufGejb0RkWvkfpDtpni/zsnbDzzLzKRnB0pE1llKf3JYFocd5tUtTLKLtcLJ5nTQ5l82/hvNfRnBRFUG99jr8KDIR9l7dMdxUnK7UqTDJYzkqxpsjqWZj5aToFc5QkKEPSDH9tbpi1ZXx8QGKaSnMzUkEJ628EuZ1FxLLCgiS9vO+15bbMJPQNzmIuO108T7Vku9rGhGrr+ldFhx6yuJQDVdctVSFk85FutZ2ndKt7XdwDMIlAsEVtcf5L8klrVhnP838p+u+t23+zphaD7YkubNyTFN2x9hXOZxkjU3cREDrC4Tbh2Memac+Uxh61trwzwJSgDqFtXBYBC1PJpWxPpsSwjEp+4KtsjwMVzqcpB3eLeDE0+yoq6JYFzI2N2uh3KHyFobu0t0icB3Xexaxwme5pY5ogvcuufDJ4xHCMyZ/uW09LBfmQUoIj/M77T9UxszejSdytl77bq57XUPhrBSRi8lLoTmyzlP8K9bGorLHTV9G1yjVTmt1kPyOBGGV0qVBN9URrPAptegMvCvcSigt31Xlr5kaPiHJ5eokMos6qtbi2Wrcjf/tORpEP7X8eXsIE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5721.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(10067099003)(18002099003)(4143699003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1diU216UndVUWlkYzJDQXh0MzNDby8yR1FXNzhRVnpiZVZuN0owK2pqMWZO?=
 =?utf-8?B?dnE4MWtrWnozcVRnNVpBVFFEd1NJSHFpRVhVMFhtNyttQlI0RUR6R0EzbVJx?=
 =?utf-8?B?OEU2djdLajNQNlBVMjdPWkx1N1dKaUREUnJRdzduTmNoTDVjMThJTkwzZkwx?=
 =?utf-8?B?T1ZicWM3ZlRENFBQYlhhMjhpUHlHajZWbjh5d2tNRUhwTEhQT2RIWXlvUC9T?=
 =?utf-8?B?RU1obnV2YjhNK1R6NVZKQXkxQlFEMFdqbGpMSU0vWHRIU2RnSkhLUXV3VmRZ?=
 =?utf-8?B?dVh5UU8vUUZWT3FySWU1ODExUXRIVEV2QmR4d3JBNzVSS1VSbkVsZEdFaGJ5?=
 =?utf-8?B?aFU3M1lXUUVsSktOaTFrOXNqcWVWL1hSc3JmYnFqd05DSkY5YXJhYXdtNllX?=
 =?utf-8?B?WVN1WXVFNTNreHdvOEdEUEpUKzF1MzhtZDA5QzRaRVVqSE15empTU1ovTXZ4?=
 =?utf-8?B?R1FyWWVXSEpycEd4cXFQY1BIYlJpZ1JBYU14cG1iUGhHUVEzMjFwTHE4YVBk?=
 =?utf-8?B?QVJNYW9TREh4ZExvWHBSUDl1a0k1aisvYS85WktvRTYzeEZlVkdUVSs5cCtt?=
 =?utf-8?B?MnhtckZybDBPNVVCL2wrc3FVbkJRRWtJcGxNanN3eVR2TllhRFVydkNGMlUx?=
 =?utf-8?B?dllhd3A5RS9JT1kzcUs1TWtFdng2RTQ1OUNRYlF4b3hyaTQxOGNTOHBYR2gv?=
 =?utf-8?B?T2NrNi8wTVlkRWhJN3laZFpkSExiRHdLMnNMdXdQVXJIYVh4cm9UVS9nSVY1?=
 =?utf-8?B?cVVsQVM3UFVZYlI1L09wZVJRbkxYWWZoMUYvb1B0dDVGOS9paEliNVAyQWRr?=
 =?utf-8?B?UUc4RllENWV4OCtoWUdKMHE1ak54T05EOGNjdjl0N3J3VDlzYkp3QXdCRzJO?=
 =?utf-8?B?TTdYNndnKzllb1p3aE85aVpxRE9UUG1rSlRGdEVXS3hWWWhXdExGT2QzeXJQ?=
 =?utf-8?B?c3lsM0ZITlRSQWlTZlJQbFNnS0FHVGpidkxWckNwR3B2a2JYREdPbEhqMWpj?=
 =?utf-8?B?Z2o5UFdYQjdIT2Q2MHY0UHQrOGNFcXZKczlCNmlZdjFzblRXSFpVRS8rNmJZ?=
 =?utf-8?B?WEgzOFBJUGtnQU55aklnem5DT01DbzRvTHZGVExFb1NJQUY1MTZ0Y2FoSlBy?=
 =?utf-8?B?VzRsSlpFOGtDZHY5bmQ3bnJ6amVyNUVLb3FKMy91NThFUnFEYmExQ1JVVDFv?=
 =?utf-8?B?WGlDbkV1bGJmZVRBMytoSmN0Z0FUQ1JBeG5oeE5NVjc0TzRVcWt5VFpvM3V3?=
 =?utf-8?B?d0pPQzhLQmRLM3o3OHVISGxVbjFscWJHd0lWTnRNWDJsby9mQXJqVVhvbFM4?=
 =?utf-8?B?Y1J0clduYWsxeFhxSGoxckl0eVJhZFdwbkRJSzlVajc1MElXQkpHTjIzb0Jy?=
 =?utf-8?B?enh5MzlwWmh1SG9ENkJXTEZHbUxFclJoejN4dmZSVzhJV21nQlZ4VWlWVmw1?=
 =?utf-8?B?Z00xR0VRRGNrR1ZrU3gvQm50U0ZCa2JLYlV0NXJIc1VKVWV4a3dtaXFqazRh?=
 =?utf-8?B?MWZIZDZWWkh2NHV2eXk5MENVVnJvTnltNi95c3VaTzFUQ09abloyd2luUWpV?=
 =?utf-8?B?alV6YjRySDd1ZTQ4SWV4SEJaNmFkZzIxNlNLY1RSdFlacUVrc1MzV1Q1aHJa?=
 =?utf-8?B?Z0xaZkFqL3pGdEFta2libTFtUjV0MmsvdHl4R1gzaEJQK3BqS3laMmk0allZ?=
 =?utf-8?B?YTRUcXNobk9mMGkrQnpOOS9RUDZ2TzFUT0ZNTnM0RnhlSy9vc0JkWW1Xd29O?=
 =?utf-8?B?clZYVXVxUGtsNlVOUDFOVWVLcGRESWpIemVrcFhTdElaR00weVdRK3oxek4z?=
 =?utf-8?B?bGVhZ1hrcWJmYXkvazJNL1g1dSt2VmJSTVRZTm1pUVVoa1pXZlNpelY2RUwr?=
 =?utf-8?B?aUNFeldJcVErYVZyb25oVUFBZDZaSXdoN3JiczFCaTd2dTF6VEw3M2FNd01M?=
 =?utf-8?B?TXpWekcvNzdBUzN3Z0pFSUxSSGcyTG1ub0RiaUdxUTMzVUdMYjlMUWNHM3Rt?=
 =?utf-8?B?ZVBGZEZRSnZoVi9IVGpoanZkUmtpcVJwTzBIWFg2SzBFQjVNZjgvRExHVWxV?=
 =?utf-8?B?VFhNeVJvTHZSQ3Z6aFBqNWJTODZreko1RUd2N1F3NzlTQUZvMlJobVNkM0Ni?=
 =?utf-8?B?S0d5RVVuRGUyek54QnhPVmQxaHlJU3NYd0o2WkVlUWxDMWczMUxNZzA3VzIy?=
 =?utf-8?B?TXh2cXFqUXY2akFRRzZmVlBVMHY1dmhHbnhYaVpqMWdibk1Uand4TCtaK0dz?=
 =?utf-8?B?RTRmeTlJbnU4TEtrZFBsUFlJb25mZFp4T3hKK0xVWUNnM1VDV2h6ZFRhUjhx?=
 =?utf-8?Q?Wx132ECyn8WyLEfEWJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb95308-211c-4de5-a799-08df248c9748
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 16:03:57.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3s4ILnIiof6bDfRAr0U32MlbW8OdrjmWsJPVnE6UdoK96P7EyK06OY3xEMPmpp8J6tFetfopF8za1offHgMzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR12MB283837

On 07-10-2026 21:10, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] perf/x86/amd: OOB write on active_mask via unvalidated CPUID
> --
> 
> commit 00612d17a5d2f57d4e77167b7e9d6303f0e776ac
> Author: Sandipan Das <sandipan.das@amd.com>
> 
> perf/x86/amd/uncore: Extend num_umc_pmc to fix UMC discovery
> 
> The commit extends the width of the num_umc_pmc bitfield from six bits
> to eight bits to match Zen 5 documentation. This allows discovery of
> Unified Memory Controller (UMC) counters up to 64 in fully-populated
> Zen 6 configurations.
> 
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index 1eb13673e889f..d419b26086b22 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -293,7 +293,7 @@ union cpuid_0x80000022_ebx {
>>  		/* Number of Data Fabric Counters */
>>  		unsigned int	num_df_pmc:6;
>>  		/* Number of Unified Memory Controller Counters */
>> -		unsigned int	num_umc_pmc:6;
>> +		unsigned int	num_umc_pmc:8;
> 
> [Severity: High]
> Does this expansion allow values up to 255 from CPUID to propagate unchecked?
> 
> When the field was 6 bits, the natural boundary limited it to 63, which fit
> safely inside NUM_COUNTERS_MAX (64). With an 8-bit width, a hypervisor could
> supply a value greater than 64 in EBX.NumPerfCtrUmc.
> 

Uncore counters are generally not visible to guests.

> This value gets propagated down during initialization without validation:
> 
> arch/x86/events/amd/uncore.c:amd_uncore_umc_ctx_init() {
>     ...
>     pmu->num_counters = group_num_pmcs[gid] / group_num_pmus[gid];
>     ...
> }
> 
> If pmu->num_counters exceeds NUM_COUNTERS_MAX, can it cause an
> out-of-bounds write when starting the event?
> 

Not for real hardware since each UMC PMU has at most 4 PMCs.

> arch/x86/events/amd/uncore.c:amd_uncore_umc_start() {
>     ...
>     __set_bit(hwc->idx, ctx->active_mask);
>     ...
> }
> 
> Since ctx->active_mask is sized by BITS_TO_LONGS(NUM_COUNTERS_MAX), writing
> a bit greater than 63 might overflow into the adjacent nr_active and
> hrtimer fields in struct amd_uncore_ctx.
> 
> Should we cap pmu->num_counters against NUM_COUNTERS_MAX during
> initialization to prevent this regression?
> 
>>  	} split;
>>  	unsigned int		full;
>>  };
> 

