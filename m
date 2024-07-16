Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06F63C7
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721095611; cv=fail; b=RaawVbV1EBRaYctpjrjZp0lzVx/qOVMCtYN+9kT2XjJwxUx0LnRfU61xUufIL9HiFIv0ahcQVdYY+6kyaTuTd/RphMcLOW2yyq0UGIrEJR3jQqCLtOkOH9G5LBg/+FkTmVYNnw5hlsvLQKFNdxMYOoc11UZKFb79pCVJuvrqxTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721095611; c=relaxed/simple;
	bh=4UXtTb8Svpmh+JF2hHGfgzmYSWk5WVe9TTvrJ3k186s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZHrWnHxIiJAYDQ7xp4Pw9n+reh5/vd1kqHi3jWmZc/qYYDe8qES1rCIshjnYNhbsOXU33jmTtp3mIzsnquOzpXTw0ZYpxKRrPZgM5SiccBUssOGfpy9ap+TROwxHG7IKGxeJAIuWnUUoO5yENqennHjyefy/GHtIbWcvxRvHvtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OMEKgYjg; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OMEKgYjg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tj+HzRYZaqWOeq1+z7pKrfUsW7iIosZYt3TCP51ipTrOs6gnhSZjiKyrbLOo8wShAla50gSnF94bcyK+6aJKkUOy3BWb7RztO39wMn3JbAyTHr1bCDgfXywFfMXwrF08x9UmTIpCv6Fq1nr1xpxSctTQumQUMTtJABeS1UQVCB2hYhgI/GgPxAzoIuRzMBDb/dqR/F4rW54a5t8CXkQvh2r9rBWEdAVvlym5yJQQAf7j/ccvMNc5AXbp2wkwsd1cAzdeC6i/Ov+tp4CnjEh51zs3VgqDWk9CaX76LEun5eveDUm5oJecDZ2LlRwqzPd2MXxmAPkseBHVD1M5K36XqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duPTRzzjN9P/+5yCkZEta5cFddTSZ0hxNKl+PvEWbgs=;
 b=aTvbnqX/sVk2Imj4ZIeQoCq1tnS2gZlV6gsacihb72InZzUSmapcBXq3/e4S3WH+i5KcT4n5KCtZoNH0+wJmRGjDe4ynZczD8tbiT/3PffoezL9HkxIwgZGYWfN8q1PHOL/uBGM9w0Xi3ZgkD+y8XqdBxf9rFGbj18v9wLwO60hzHXMk3A+HoR7StIwtAwBpIUpAptCYFhap2N5Y/ATmJW1SXe8Fz39Sbm+L8NDM7nHmAOKgD8+m4EUZUwqBv1us3gc/4Tx/zZ+Vif71IdYQD4BwY6s6zQ+6Bh/+70jKO7iuj12bcvRwTKSNJNpPxqUE6bZhvVzdgyd0dhkiwg7NKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duPTRzzjN9P/+5yCkZEta5cFddTSZ0hxNKl+PvEWbgs=;
 b=OMEKgYjgO757x6GYh6fnJ384gWm1ewdek5Hf+Vi0OAdeI0AFzYzLYSPtsXPvC2YO9xyJ9lHv+9V6iRLokB5yzMtxsS8+oXO4hHRPsuzkeEJCvVDZhnQCXr6JD5jTPEB/mrhqgN/s0LyUjDu+67GI9YuuXM6HniU13r0C5QTe4LPdw6m4lrH0xnT6xP4UeF4WaYjJrCXjyriUzOMpOuDANZuHBkMkjHFSK0IZrm47ejc/1H4n9iPVpFq2ock9zR2mP/PTzGIxef2Bs/AwYR0Pm79GVNgPYU7yTBSGh5ylp/oNqB5ecQrrkfH10Ohy2WwnFwUboXvunY9kAOMRTnnBkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 02:06:46 +0000
Received: from PH0PR12MB7840.namprd12.prod.outlook.com
 ([fe80::dbe7:2850:c5de:b17f]) by PH0PR12MB7840.namprd12.prod.outlook.com
 ([fe80::dbe7:2850:c5de:b17f%5]) with mapi id 15.20.7741.033; Tue, 16 Jul 2024
 02:06:46 +0000
Message-ID: <34327425-80c6-4346-95c9-fa15f9381e1e@nvidia.com>
Date: Tue, 16 Jul 2024 10:06:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/arm64: Add coresight test
To: James Clark <james.clark@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 james.clark@arm.com, bwicaksono@nvidia.com,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, linux-perf-users@vger.kernel.org,
 coresight@lists.linaro.org
References: <20240710062732.18999-1-jszu@nvidia.com>
 <ZpAeZjNJLesSJqm1@arm.com> <12a84dc1-ad94-4546-ad3d-72f3e0b0bfab@linaro.org>
Content-Language: en-US
From: Jeremy Szu <jszu@nvidia.com>
In-Reply-To: <12a84dc1-ad94-4546-ad3d-72f3e0b0bfab@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:820:f::7) To PH0PR12MB7840.namprd12.prod.outlook.com
 (2603:10b6:510:28a::16)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7840:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: ebaaa35d-0bcf-4d50-2ef8-08dca53bf1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnR6TU42OFF6VXhIS0MzQXpiRWFxVDRRRGVFUWN2QlhaL21RR1o5ZmQ5WS9S?=
 =?utf-8?B?S0V3VDZBRm9oeXhYUFBkaHBIUHFlL01RUXpUcTl4eTBNektYbWxuR0hmTUsy?=
 =?utf-8?B?Y0JQY1FrcTRhL0VHVENKY1pQVjNZSC9HWTFFWlJXUnI0enJIb1JHOEprRzZQ?=
 =?utf-8?B?TC9aL1NuaEpSUTBNaWIwbjd1R3NnNE9iMkxtVWlScm0vMVlRcXJIOTJ4dzd1?=
 =?utf-8?B?RlNrY0NERzVRbjlET0pxUXpTZG5zSjNmckdSdE1aSk9tcGZEYTdENGpGR2VD?=
 =?utf-8?B?ZDBFMlJ6anJQOXJ3UjBhdXk1YXZRNG1pRmp2QkYzam1FV1JIcityQnBUNEJz?=
 =?utf-8?B?QTlPdnUzczk3VUsvZDc5V0d6WFEwV2VyZFJ4UWFCdys0c1k4VEp4aWcyaExM?=
 =?utf-8?B?Y1lDTzhJSGVRdnVxSzlvbmVWaXpqOFVyYjJSSmV0NFQzSERWcXgxTFk4aXRa?=
 =?utf-8?B?OWtsYVRMVW0xVEFDc0ZYSzZvUTZvUmxUZ3IycXBZYUhmZktEWFhadjVQcFhl?=
 =?utf-8?B?SXA5YnpGVWJmdEJ6L2RZUzBZRmEzYWRRVUxQZXdRRDNOWDE1Q3hGY2dubUNC?=
 =?utf-8?B?NU9QR3paNzYxWjZ3TC9FTFZxUXZXcjVIYUU2UGVaY3FFVDloOVBCQXFyamVm?=
 =?utf-8?B?S1h3eTJ3NVFHVEV0QUxkb2p2T3lHNHlkKzEvcnRsU1JET2tnSlJoMzlzSkhI?=
 =?utf-8?B?QkIrR1FqbzRyTVR5NzRIdEFCYkMwN2NhMzcxV1pDMUVoMzJmcEdobDBRcll3?=
 =?utf-8?B?MUxIUlpSaENHY3l1M2FkYlc4dXNFM0ZDdnppa240WHRtQUZ5SHpEUWIvNkJM?=
 =?utf-8?B?WFF3WkQrTEFiYXVVSGxVRVFNWWFwYUhEUmhLcE5Ndk5SWW1PVURHQU5KZEFR?=
 =?utf-8?B?ZSszck1DbU9kNGtGSERVcHN1Y3lMODJUNjVjZkVYbnVuZnZqQ0UvYnE1MStO?=
 =?utf-8?B?dnNhZ0VZWGlJQXZvZVQzWmllb1FJR1hHRjRsMkVYRERQSTFqcTZZN011OEFL?=
 =?utf-8?B?bzJHOHFhcUl4ZlRmTmJQbTJsemFPcXhHcmp2a3lGSHhmT3oySG9rL0o1LzZX?=
 =?utf-8?B?OHBXcERsemJEcGthclh0T1g5azNWUDNYZmJPRzg2UW93TlRNakk5WTlONFNY?=
 =?utf-8?B?N1lhRW4zMUJjVm1zZW5vVkRQSC8zYk5nazVDbVZZTVdTdlpzTFY5dFJ4cVFG?=
 =?utf-8?B?bzNiN2xxMEk1VUpEMVlBUjM5Q0QvU3JUN1hJYy8zRFBzS0hXWFNOUVMwbE9p?=
 =?utf-8?B?dnllWmJGbXlHa09OUElyanp5ME9rL3dMa2VmazZQTW5ybk5sNHBCcWdJYkZx?=
 =?utf-8?B?ZHUzZkRncStoYmc2WXZWMXhSWWVaM25kTTM2Z0x1NlJXb2IzQ0JnbDA4Y1JM?=
 =?utf-8?B?Q2djRVR2bU84V0o2T0Zja2YzYWx5TWJuNnRZUVM3dzI5VHM5YmVWck5lK2pU?=
 =?utf-8?B?MmFjSEdWcWZ2Z1hZaHU1NFIzcVNqUStRdlFZclJCSlRTaW1DaDFpTnozc2w3?=
 =?utf-8?B?YjhCblhDUndoeVVndUVqK2x1VFA0Yk5HTVd3TkpUelpZNFQrVVFweUk0czdU?=
 =?utf-8?B?Rk9TcktDMWxNajdrWXB4OFhtTkJzakw1NUhzS2JHQkZLZGp3OHNIemFJSXA1?=
 =?utf-8?B?cXJxdFcxVDd0a3MwV1ZzdSs2Zk1YOU1ycklpMzV5akVmWnE1RmVPMng0YmZF?=
 =?utf-8?B?OE1wMzFCOWZ3MEp3YW1oL1dUUG1XbzFuY1M3aEZVM3NBL2R4M0NoamVsVmpr?=
 =?utf-8?B?T3YrVVkrd216RXkyTHk0SGYxWWVObk40bFR1cGducVlTQkI1SXl5Y0poYWFB?=
 =?utf-8?B?ZC9EZklLOTdjTHA1WlNOQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7840.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akVBUXhlTXVPNzM3TE12QzNxa3pWMmdkWFEzdUN4b1N6aWpEdmFoMkFTMUZk?=
 =?utf-8?B?YUJaWmpHMHJNRDVRM3d0VENqREl2UW8rZkhoa2prWDRCZUQ3bHNyci9QT212?=
 =?utf-8?B?N3M2UjZwaGZPSjd6VjJlYmY5cGtTSlo1eXJTVmduNnpSaXk4cDJkRmxXZ0d3?=
 =?utf-8?B?M0RicHl3MVdvRU9ZSmQvby9UNnBYc3B5VHkwNUJiZDhIZHo1amNaeDhuaCtw?=
 =?utf-8?B?RWw2STZwNVNpaXBMc3FYWEJQVXEyL2o0R1F3M3E5bC8vL04yTzFhYU9HNitk?=
 =?utf-8?B?dDhMRUpRdUpaZVk4SVVjM2M3ckNSNEJqVUlxSFozK3Q1LzdmTDBzb1NVcS9U?=
 =?utf-8?B?bUZUOXJEK3VVL2M5UlozT1NnOTdoMndPMm5aT1M3ZEo3cFRDaUl2OFVZekoy?=
 =?utf-8?B?UTZsT2FxY25PTkNEczQrUDV3TGVOZVIwR05rbkFQYjA1MlVDQkhNYnU3NGFF?=
 =?utf-8?B?TjQzdUdCZWpHbE1tSWNQSUlTZG9NSjNoQ0o2NkYzSVFKSTZQb0taUEZ4K1Y2?=
 =?utf-8?B?WUJBTlhSVjh0cjVjMXRkQ09zeWdsVGxHS3FMSnFJWGlHbklsN0xjbDhXRHdt?=
 =?utf-8?B?UElsaUR0WEJNaVJZR3BhZXQ2Y3RiZjFtTjc0M3FxLy9tU3hrdXRQOHhLVm5G?=
 =?utf-8?B?R2FaTUhkN2R4MVlNK0NiYkNqbXVZUEZoQTdwVG9BYnFGR3o5cVlEdndxS1N6?=
 =?utf-8?B?NkJSM0R6N0lzSVdDYUJseW9ad3JaYVpIOXJUU3E0b1psWTVKNy9VSjJBMmtt?=
 =?utf-8?B?NDBsOTBNNGpVMFdyQ0d1eDVMWkczRjE3R2luOTZMMXVISnpDejRiV1FlOHVp?=
 =?utf-8?B?T3lyNHNzWStNVmZvOWltL1d3Uzl5RlJUT01iTyt1MFdjcGdiWFg5Qk5Vdzd5?=
 =?utf-8?B?SHZnU254NEJTckZSUTczb1FCWEQ0Zk9QMjFGZ1d3eHZ5OEV5bUtjbFhOYkxq?=
 =?utf-8?B?RTR1allPTUVCanlnSmxrb3dzb2Q4Q2ZteTlDY3dVTHBadWp4VDRFMWhSczcz?=
 =?utf-8?B?anEvcWRoNUJVYkl0S2xjM3Mxbi81cDNiaFYwT0ZUeVUxc0dyaVZLaStOT3B0?=
 =?utf-8?B?eWI1cXlRSnZ3Wm9ncmhXQSt0OFlqT3RseE1IcnArTHkrYzVNWjA5cExYQkNT?=
 =?utf-8?B?c1lqejBNRitnNVBReHliUHVBOWxJakNLbFB6Ti95dVNycU9ESGRtb0tiWXBT?=
 =?utf-8?B?MlR4c0twNk84eUEvcjNjSktsUUlySWErcXhlaFBXY1lXWnBzZlF6MkZhcUlS?=
 =?utf-8?B?YUZqOUtoYXl1VXB1VE5BM3pBUXlIRFNzTmw1Z05MaWc3elRWMTUxWUJ0UTE4?=
 =?utf-8?B?U0ZEVS8wRDJPZEhmclA2NDJIMTdUTGRnZWw5MTYvTklMMk9kWFAvdU1DVzVq?=
 =?utf-8?B?dGdlM2tscWtZSHB4cFRqVUJwMHBwQWR4Q1d1aFhyQk1tQmoybDF3eW1Hd05S?=
 =?utf-8?B?ZmRPK2NmQ29SaERlWTl5b2JCaUE5Szl3K0l6THdES0YwRnEyTVRZaVl5RFhi?=
 =?utf-8?B?YVpPT1Y0SVpLdk5UL0lSTjE2cDZ4UjFIODNRakpaeEZja0xSYlNVdksrUDU0?=
 =?utf-8?B?UjREUjh2SGtDbUpuQlBmOGordEI3Z1BQR0I5amZlMnc3c3RFd1ROMWJjbmRu?=
 =?utf-8?B?UmV5bzg4Zk50YkhTeHhrcU9QNkVKY0EzK0hNc0kvd3VMZFVnNGpHaTJwOFJV?=
 =?utf-8?B?VnQ3ZnJ5NEZKMVNnT21xWEtjRFp4Z2Z5MGs5bXpMaGFoTFZEUkZ0Zm5zUVdG?=
 =?utf-8?B?OGZrMk1CRTNjUS81U1FuSW9YeGNBTkRCNEZNeXcvcmZoclR6ZkswWUFOZXdp?=
 =?utf-8?B?c2NmZ0hUZjlwQVo4bmpVQ3c0VkZZYnRjRVRrUFVkcGp0U0pzcmxzeGxlTzdQ?=
 =?utf-8?B?UCtpcDU5bTd5Y3pyK0pGZGpZWjBxMVdEYktieGlaWHJrOEhtenk1eWVoT2lH?=
 =?utf-8?B?bC9rU0dGL09wb2kvVDNkQzJzbTM5ejNzSktKc3F2ZjViOE9uc2I2dlNWWnh1?=
 =?utf-8?B?cER5WWcxWTEwNndhQjlORFc0Q09PdVE5cHA2a3NwMlRDWWJPbHk1T3pyV3dG?=
 =?utf-8?B?eHBUNHozVmY2ZWNmRXVwUVVEVk5UUVk3SlF5RmFPdTkvUnpXekZpWUI4eWFn?=
 =?utf-8?Q?TO54=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebaaa35d-0bcf-4d50-2ef8-08dca53bf1e9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 02:06:46.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mT+NHIH274kZ7s59FDb6qi1Hnvyzmh6ArhGtGVuZ9QrXo2RFuVCUErbr6VGgCwIW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459

Hi James,

Thank you for your reply.

James Clark 於 7/12/24 5:01 PM 寫道:
> 
> 
> On 11/07/2024 7:03 pm, Catalin Marinas wrote:
>> On Wed, Jul 10, 2024 at 02:27:32PM +0800, Jeremy Szu wrote:
>>> Add a script to test the coresight functionalities by performing the
>>> perf test 'coresight'.
>>>
>>> The script checks the prerequisites and launches a bundle of
>>> Coresight-related tests with a 180-second timeout.
>>>
> 
> Hi Jeremy,
> 
> On the whole I'm not sure running the Perf tests under kself tests is a 
> good fit. We're already running all the Perf tests in various CIs, so 
> this is going to duplicate effort. Especially with setup and parsing of 
> the results output.
> 
> There is also no clean line between what's a kernel issue and whats a 
> Perf issue when these fail.
> 
> And thirdly why only run the Coresight tests? Most of the Perf tests 
> test some part of the kernel, so if we were going to do this I think it 
> would make sense to make some kind of proper harness and run them all. I 
> have some recollection that someone said it might be something we could 
> do, but I can't remember the discussion.

The idea I'm trying to pursue is to use arm64 kselftest to run as many 
test cases as possible for ARM SoCs across different designs and 
distros. I believe it could provide an alert if there is an issue, 
whether it originates from userspace or kernel, similar to how perf is 
used in other categories.

I'm not sure if all perf tests could be counted in soc (selftests/arm64) 
category such as some tests may target to storage, memory or devices. I 
could replace 'arm64/coresight' with 'arm64/perf' if it makes more 
sense. I believe it could help users verify functionality more conveniently.

> 
> Ignoring the main issue above I've left some comments about this patch 
> inline below:
> 
>>> Signed-off-by: Jeremy Szu <jszu@nvidia.com>
>>
>> I have not idea how to test coresight, so adding Suzuki as well.
>>
>>> ---
>>>   tools/testing/selftests/arm64/Makefile        |  2 +-
>>>   .../selftests/arm64/coresight/Makefile        |  5 +++
>>>   .../selftests/arm64/coresight/coresight.sh    | 40 +++++++++++++++++++
>>>   .../selftests/arm64/coresight/settings        |  1 +
>>>   4 files changed, 47 insertions(+), 1 deletion(-)
>>>   create mode 100644 tools/testing/selftests/arm64/coresight/Makefile
>>>   create mode 100755 
>>> tools/testing/selftests/arm64/coresight/coresight.sh
>>>   create mode 100644 tools/testing/selftests/arm64/coresight/settings
>>>
>>> diff --git a/tools/testing/selftests/arm64/Makefile 
>>> b/tools/testing/selftests/arm64/Makefile
>>> index 28b93cab8c0dd..2b788d7bab22d 100644
>>> --- a/tools/testing/selftests/arm64/Makefile
>>> +++ b/tools/testing/selftests/arm64/Makefile
>>> @@ -4,7 +4,7 @@
>>>   ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>>>   ifneq (,$(filter $(ARCH),aarch64 arm64))
>>> -ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi
>>> +ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi coresight
>>>   else
>>>   ARM64_SUBTARGETS :=
>>>   endif
>>> diff --git a/tools/testing/selftests/arm64/coresight/Makefile 
>>> b/tools/testing/selftests/arm64/coresight/Makefile
>>> new file mode 100644
>>> index 0000000000000..1cc8c1f2a997e
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/arm64/coresight/Makefile
>>> @@ -0,0 +1,5 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +
>>> +TEST_PROGS := coresight.sh
>>> +
>>> +include ../../lib.mk
>>> diff --git a/tools/testing/selftests/arm64/coresight/coresight.sh 
>>> b/tools/testing/selftests/arm64/coresight/coresight.sh
>>> new file mode 100755
>>> index 0000000000000..e550957cf593b
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/arm64/coresight/coresight.sh
>>> @@ -0,0 +1,40 @@
>>> +#!/bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +
>>> +skip() {
>>> +    echo "SKIP: $1"
>>> +    exit 4
>>> +}
>>> +
>>> +fail() {
>>> +    echo "FAIL: $1"
>>> +    exit 255
>>> +}
>>> +
>>> +is_coresight_supported() {
>>> +    if [ -d "/sys/bus/coresight/devices" ]; then
>>> +        return 0
>>> +    fi
>>> +    return 255
>>> +}
> 
> The Perf coresight tests already have a skip mechanism built in so can 
> we rely on that instead of duplicating it here? There are also other 
> scenarios for skipping like Perf not linked with OpenCSD which aren't 
> covered here.
> 

Will it return the different error code to indicate if it's failed to be 
executed or the coresight is not supported?

>>> +
>>> +if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
>>> +    [ "$(id -u)" -ne 0 ] && \
>>> +        skip "this test must be run as root."
>>> +    which perf >/dev/null 2>&1 || \
>>> +        skip "perf is not installed."
>>> +    perf test list 2>&1 | grep -qi 'coresight' || \
>>> +        skip "perf doesn't support testing coresight."
> 
> Can this be an error instead? The coresight tests were added in 5.10 and 
> I don't think new kselftest needs to support such old kernels. This skip 
> risks turning an error with installing the tests into a silent failure.
> 
> Also as far as I know a lot of distros will refuse to open Perf unless 
> it matches the kernel version if it was installed from the package 
> manager, so we don't need to worry about old versions.
> 

The idea to skip it here is because I thought either a distro (custom) 
kernel doesn't enable the kconfig or the distro built the perf with 
CORESIGHT=0.

I could make it as an error and put it after "is_coresight_support" if 
it makes more sense.

>>> +    is_coresight_supported || \
>>> +        skip "coresight is not supported."
>>> +
>>> +    cmd_output=$(perf test -vv 'coresight' 2>&1)
>>> +    perf_ret=$?
>>> +
>>> +    if [ $perf_ret -ne 0 ]; then
>>> +        fail "perf command returns non-zero."
>>> +    elif [[ $cmd_output == *"FAILED!"* ]]; then
>>> +        echo $cmd_output
> 
> It's probably helpful to print cmd_output in both failure cases.
> 

ok, will do.

>>> +        fail "perf test 'arm coresight' test failed!"
>>> +    fi
>>> +fi
>>> diff --git a/tools/testing/selftests/arm64/coresight/settings 
>>> b/tools/testing/selftests/arm64/coresight/settings
>>> new file mode 100644
>>> index 0000000000000..a953c96aa16e1
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/arm64/coresight/settings
>>> @@ -0,0 +1 @@
>>> +timeout=180
> 
> I timed 331 seconds on n1sdp, and probably even longer on Juno.
> 
> It doesn't need to run for this long and it's an issue with the tests, 
> but currently that's how long it takes so the timeout needs to be longer.
> 

ok, will extend it to 600.

>>> -- 
>>> 2.34.1
>>
