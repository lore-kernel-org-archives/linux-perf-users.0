Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0EE2853F8;
	Tue, 24 Feb 2026 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920731; cv=fail; b=VW9qFSgSj+TvNwtYTK0KnPdwjTWffyNoeXkdX48hSbzWn2jRDzVyubzOzdw2EI8pOQlgSoxmGt0r5N7qIkjAu3Ty2awN4ChzL3A+zZAvMPyJ1SGmwL1GjLdMlzCTDrrQGXnXBBuqAiTXQvPrHBUJC05Qi/YGYW2uHrkkESdvK1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920731; c=relaxed/simple;
	bh=SUxkQyOnBnqJ4drmJXpb+vijmCX+BoI7Y+SSwKCKDJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ijgvJ9AmEs/Lzd51NAVdMmAodKGTpoGQqCox3HSkZFQbb7q19fcN3Y6zzQNwJoMECTuFfH2mKD43In0p29XUz7zRq36bkbIW+AABtVp2mr6D9zkeomlE7DSh4QleCianmVkoyPb7tubr2oOp6k5xjZkDJyoM5lx+XWlk/QR+Jjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lXSjZGpP; arc=fail smtp.client-ip=52.101.48.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lXSjZGpP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWFNceNOPxfsm3RTb1P+kTLDmr8z4FFGI/BUiFzeapnJ1pBCm1d9OElo1eAiiPBr6cQQcu7++r6sIDUrPSZorfhoyr1vrYJTIueatr8xIdYoZejsMqNtlCyVLNdtmZZF6RONRNdpbkZ4WH0JCCrFukcnDTMe0sVDpqS6wg4Ifi4Ovvl/RSnnzeV+A9Qhzb/hL07/kAcLjf2ExVQJEM39FdjTfiMgVA9wrG3JMnFEZ3ctCUp8H4muUp+mC3ERRWmaVQl2SFDz1UVyKGgALkm2bxhW79BLhYE8PpdDMqdqrZNp6tcwsje1TWRPN02CnMjvEFO4USGSLO0DFZYv2BRXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQPHkQR1MH7MYaK4WIjPbJvh0w6z6NrXhwk5cWhvEwQ=;
 b=sLMfwv5deOVOF4o0l2XtrRy5iPc8XUnQo6Ec4ZMWx6/+Z3amr0xXIrBWRGPcmNqK5TWSRaIpoe0awuDwOF4h5o546Y5FpAxUBncoCZzh7vpGV5UmcMxFEp3ijJwDLfTpP0sWbnaRvzOhqblydhJ6iS7hc+0pyaA+j8CBROpfrQEhRvrdHDhqfGgRENQSAfgqdJtvC4AsIJuejqdbPtJ6JLNvEYxuSGvxrOvi/s+8fpceZtURwICUA9q+uiaYQey1sthkhGwmRVLKq42Og+pT5uu/s3tt0TgAqyL2eh34V7Z2GyrMv8OO21I/aY2yzfLG5r/Bg1RW2wN5Y3JneO2atg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQPHkQR1MH7MYaK4WIjPbJvh0w6z6NrXhwk5cWhvEwQ=;
 b=lXSjZGpP5L6m9fMKzJMGPReBDPAiwqm0Gcq4rmFPurJyuNsiOSf0WeOakv3y3MV69pEHfI6KtTNHr0TtM+XGPd6MD4JKEXsIU2GkVwA4M9aR/b0GASFTrBkbxKu++N612rjV2biygIQMOwJV+Wz7iITf6/skvyTn0sCF4Qe0WTs=
Received: from PH7P220CA0062.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::28)
 by BN5PR12MB9509.namprd12.prod.outlook.com (2603:10b6:408:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 08:12:05 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::81) by PH7P220CA0062.outlook.office365.com
 (2603:10b6:510:32c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 08:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 08:12:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 02:12:04 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 00:12:04 -0800
Received: from [10.136.44.195] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 24 Feb 2026 02:12:00 -0600
Message-ID: <c9771902-39da-430f-ab2b-ba953d9ba79e@amd.com>
Date: Tue, 24 Feb 2026 13:41:54 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] perf/amd/ibs: Account interrupt for discarded
 samples
To: Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>, Sadasivan
 Shaiju <sadasivan.shaiju2@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260216042216.1440-1-ravi.bangoria@amd.com>
 <20260216042216.1440-2-ravi.bangoria@amd.com>
 <79e0c820-e934-47a1-abd-3612e82b310@redhat.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <79e0c820-e934-47a1-abd-3612e82b310@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|BN5PR12MB9509:EE_
X-MS-Office365-Filtering-Correlation-Id: 243ee1c0-b242-4c60-480b-08de737c658c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlBpc2ZHQWpNV05Sb3F6TEtpdmlzMDV5UXNHdUF3ZHFuVFE4Q2REOWRoSk9I?=
 =?utf-8?B?WlFpdzlEbEcxS2hWMkR6eE13UXNtNE9CQmxHOGZ0d1hqaWExTHBMa0ZvWDBK?=
 =?utf-8?B?aUdrQVcwYW5YMVVwTlpCa29zOEgrNFdHRFMzNFFQYU1sTGRCa2FTMWZXMDI2?=
 =?utf-8?B?TDJGWFVKb2hSQWIyS09pTWJXVThIL2Q1alN5RUhYRlV3QlBIWTZSdWZQM3lI?=
 =?utf-8?B?RXd0MVBlZW1EbXJwcUt2aGh5andXYmc5NmNlTUJHUmhnK29YamlxK3k3M3JO?=
 =?utf-8?B?MkZUUFovQXFsdGhrQkJpZDgwTVVqcGlJbERqaFJSa2N0Siswa3ErWkRSSm92?=
 =?utf-8?B?bENiWCszaDZudUw4WUhvN1dWSTVuc0ovUnRoMnEwUlJGT0gwYkxoR3YxWFQ0?=
 =?utf-8?B?Zm54MVdsMXNaUnBzTFJlQ3Jjam5jVCtDN2Y5Zk5GU0lzenFxWExtZUJyd2pU?=
 =?utf-8?B?eEVzQkUwYmJ5U1M1a1hwekowdTRWUC9YclkwSHorVWV0SnlFK0xDYmNHcDll?=
 =?utf-8?B?SExmVTNYK096cStJdjZOaDZkT0ZBU3lSU2M3bkhqdkpXaERSek1vaXllbFdB?=
 =?utf-8?B?Tjh0QWJXcmoxWFdVdmNTVXJxT3UrV0RNQ0d4R21mUmVEU2Y4RHAzYmFZbG9Z?=
 =?utf-8?B?VG03YkJobnBya0QvYjVYMnpNRTVxUGNRQkFoMTJSVnE3TWNMcWV0aUhVemc4?=
 =?utf-8?B?bmIyWHRjODFSZ3VBOTV5eURwVHQ3TkZuWFFTYnJBSmVvY0VQL2NnS3owQXhN?=
 =?utf-8?B?bm12WEk5b0RUanE3S09LZFFHWW5UYjZTZnBBMmx0ek45d0RYLzYycjc4TFNM?=
 =?utf-8?B?b3g3bGl0MTh1dU9aWk5jU29nNkZUb243N0lTMWtrd0FPR0xvbUNIUlV1ZUk1?=
 =?utf-8?B?dktDZW1ZVzdoMWEyZmNlUlQ1QzdmVm0wUkIvNkUrZ1JYYVVGc1AyM2tDbHlt?=
 =?utf-8?B?dm9ldElSZDVzdlEvb2xpNHI1NlNyMmRoQzFuTDNsRjNOTTFsOVcyL1V3dVRX?=
 =?utf-8?B?bGRlZGVKS00zamxPLzlTR0w3WTNYYm5mTTZwWWt0d2RYUnZwSnRPSXRQbGRV?=
 =?utf-8?B?VGFYMlZ1VW9xRzFibFFvQzk0S3QwS3J4cDNoOVB5NlNlL2VtdktWb25PYW1K?=
 =?utf-8?B?WmdsektkRXZXZU5nYmorU2ZURHEwMGlSTWV0ay9pbEVzaVdYeFlUWTVXa1hl?=
 =?utf-8?B?MGZvdHg4bkhSTExPR2YwUWtkSzJXeUJpUDZsT3QxVWt5cXhBN0xXQWIxRE1D?=
 =?utf-8?B?RGxPTHoyamFMTDRaa1kxQzkyTXJENlFwQ0RBejNibG1XaHU5anVlVXQyWlI1?=
 =?utf-8?B?clN2U2JsQVhLSUkxaS94djBpNFkyeHNOdG9IbVlwNDM3L1FJS01SK056cUlm?=
 =?utf-8?B?NmVuR0FjMTVHYTlVaEU3T2lxTVJZdkxYdWFmd1NZYzhpajgzYXNKRG1sbFpX?=
 =?utf-8?B?cElsNGNaakRBektxSU9RTE9qaHZ2LzNGSTNEMlhUelV3UjJNd05WUUt0c01O?=
 =?utf-8?B?VDBPcERKQlVrcDNQcGk2UmVKdFpPaDFtQzA1QjFrR2dDeU82cUFoRlBCRXhy?=
 =?utf-8?B?bTB4TUhuM3FibmtXOFZKRTdNL2ErOUk2Y3M5Q1ZVV2RsZ1EvRTJwaGpxcW1p?=
 =?utf-8?B?RGtIb0o1bllSaHlUazZ4cTY1T3lyRFdnUGxYaGl6RkMwWGtXZEdxL1NvaldM?=
 =?utf-8?B?RGhPVmxTOFEzMTd1dHREdXBHKzNZUFZtck1Vb2QybmdGMFIxOWo4UXFBM0k5?=
 =?utf-8?B?VkFSMmEwMmdmWHh6TGpKenRtNHYzeVpwVXJCcUx0NkNCZjVKRkwzbGdXR3Zs?=
 =?utf-8?B?eEZjT3Y0LzBVWkFDSmI3UFBUZ1ZNZkkwaGltU2tQSUxpS0kzRVA5N29nd0gy?=
 =?utf-8?B?NmpJSEFkcndwRFA1RGhOaWRuNVV3Z2R5UXY2cUJDNWVBRDYzU2tmNjJudUVp?=
 =?utf-8?B?UkcraVdmb1RURmFkVVNnVGNibHpvUXRkNUFtMEZTZ21UM2xjbGhMc0JJb3cx?=
 =?utf-8?B?WmpYdi9RK3dENVlTTm91OFNFM2dja2FoQXhYODBtelNMUXVJTkpSM3ZidzBt?=
 =?utf-8?B?R1NIUERNenQzL1FxYjR3RkFuWVh3NnJpVmdyLzZ6VitUK3ZScm5GMnJ2dmhH?=
 =?utf-8?B?UjJvdUJmakFSeDkwakIxYUN2bTlaTVRsK0lhMVRMakdObHZlSVZPS0xJczlG?=
 =?utf-8?B?dy9pN2pJR0hGazdJTEt4Z3NWRWRWTWVhYkd3cm0zbUhaZWZSVkNTRTV4MXly?=
 =?utf-8?B?d0Z3N3ArbmVzSEhtYklBK3FBempnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5gQxRB7I2bNzfYsKJpfGUtV3OR+KU0r8MnyHolNYYEsN3DK+p8KFhz8OFkk732AJ64aVYDVJpBBASd3oOXShQ6Hd0V3/6+eqRnG6uWrv9D6ZOf1y7FPrFUi4XGy7MGWo04suka9x3a4MYdkxFLnk3UUSQksP4CmIX3cQ4tMlrxDTjvuCTsFJQWQTGBFXi26qpsmbtHk0yBQu/W2Lbui8kepBuADeOYrxnGSBy6zwinNAm8abkWnNlyxndk4L7ty3oJAzjSTSFjCfWN3CCB8wEE3asw3+u8s/6v0ksWhGfYX4CqSo1IvZVZHFrD8kCk8gzEDHMoUDktLb9XKYXgRuDjDsstCIw6UZDrfghlTYl33jL4PRcnXfvt/dv3pCRKKSBgdu0tZIR4U/PTyWAsR1s981B64xEqE9yBrUQdgV75LKItuLMAoCxbT4tz29sjzE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:12:04.9131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 243ee1c0-b242-4c60-480b-08de737c658c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9509

Hi Michael,

>> Add interrupt throttling accounting for below cases:
>>
>>   o IBS Op PMU: A software filter (in addition to the hardware filter)
>>     drops samples whose load latency is below the user-specified
>>     threshold.
>>
>>   o IBS Fetch PMU: Samples discarded due to the zero-RIP erratum (#1197).
>>
>> Although these samples are discarded, the NMI cost is still incurred, so
>> they should be counted for interrupt throttling.
>>
> 
> Maybe worth tagging
> 
> Fixes: 26db2e0c51fe83e1dd852c1321407835b481806e ("perf/x86/amd/ibs: Work around erratum #1197")
> Fixes: d20610c19b4a22bc69085b7eb7a02741d51de30e ("perf/amd/ibs: Add support for OP Load Latency Filtering")

Yes, makes sense.

Ingo / Peter, Please let me know if you want me to respin.

Thanks,
Ravi
