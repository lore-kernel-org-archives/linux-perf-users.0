Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FDAEEC0
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721384527; cv=fail; b=Yuw8bte43+Ofl7IUhpf2oGXF0cyM8vw5MgsboLbsVJiasus2ZKuA+dUrDzAZqfkb5qzZhE4O96W3dQPGC7ir9z6VpCUbKG9eKyo4785M/Mx/D8D7+jY4wpero+p8t95bn8IHfI1AaiCqAoVcB6L/t7moMUWhz3tyKLPeztWL/9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721384527; c=relaxed/simple;
	bh=1R0Gqgkb4k4i+FSQce1V1cdQ6mvCPR1ukxcCxTrXnwU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B0CGiKNRMvJ9qHKqITa3tTxWAQnUl/5cO4gHV3yjztuQA2l8wkyxoXbbJlABw7SwzY8yvmmXDA5qGm1cDauMgD9TEIhpwHAJIVjImesiZEsJeFEC+ingk6PbbF0B6IhJ8nOkipDIup+75/jspcGJ0dowHcmlTKBdmMgJ3AJHl6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lfwUm3aW; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lfwUm3aW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEkJ2XFvu8wyRsXs5C3wsE+eXfhYmPyHxYsOOBHGadYFtE9i9+npm9/B0qTT8L5+H8AN1r4g+BNnUM1QlMbQp7vlS15rda6gqj3hyqyIz23cnzkl1n7TWbuk8mqMLcm/h8i2+dge97og3lcFEqb4Odz4IW487yU7h/85XJ2bXuPZvSB/2kdFp2yDW0okvfD+Vzz0rsSXMseZlWOHsn+iliCmRFO8/cA7Su1rAWuHvXmCZyvatdfL6Kp2+9eHo3PTiMoYeGQBeaIKqUhB2ogxbWQo2R+RSqfEv9NZmhySn9cwCqvYMWr+K5q+o/MMyl5DVOAX1AW9ll0gYK4N45hGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vA4i9VeEcWLxWF8rFHMlnK2gTPcKMgMzoUBqYHWYESI=;
 b=iEAqYn6urS2fVtV/9PbHFHX1o7mjuroNkhKODHDM/kzSjYFn87PYdUYst3xe6Zof4K0uiqDMbwlTfnqOQPLTVplWA/aVShLLlpIdpncoZtijotDsc/SG4Ez/P8b8tXetfLRSC8q9WcYulCRarfB7hcucRHHx6Pt6xyeqQEEojLvAaSCw7ZVVkn19nkI+e6KZq/k9NuNrlW661oMKJ7YWEQumI2LZHcp1RK8+brsoPtVEbUQ5sY18ep8NPIGGGetJ+UhfnV6+DdAtj0QM2QAKgG4fcAG86l1ZAgnRvllK279Az/mq/hGsHn7Myx+q8dFrR8sCB3iDcbqKcL7yJpY6qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vA4i9VeEcWLxWF8rFHMlnK2gTPcKMgMzoUBqYHWYESI=;
 b=lfwUm3aWyMH2YxeVCzObo4goyH9TjaXBF3utdpSCIzdxTFpF7yK4X8N9DbGkLI35rS2LzXChSOF5d+JWRxTiJLvqBb1vrPvYgWRoYYn36b/UaCzxPh7ttWTlbBD/TlQLltKT196FkHptjPRrQIpirSnnkj2zgRRJWWBJlkDx3fooNqHRpf7ZTv4gUp1WIttWZuFP5++42xvCJa/HBFaMyeB3Imr6K88nX8HuMFRYqkhyJ3fpujvqDdIeXZ4JyKqQ3xODz8+ZCAAsgPR9rLLkjFIzfPv0Oz7zn5cQ+jraD24bUtFha25C175PD5DPtFont2mxnLyfMKGhmibOD4hXhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 10:22:01 +0000
Received: from PH0PR12MB7840.namprd12.prod.outlook.com
 ([fe80::dbe7:2850:c5de:b17f]) by PH0PR12MB7840.namprd12.prod.outlook.com
 ([fe80::dbe7:2850:c5de:b17f%6]) with mapi id 15.20.7741.033; Fri, 19 Jul 2024
 10:22:00 +0000
Message-ID: <7c7e9337-bbf7-43f2-9b67-aa175b0c1b56@nvidia.com>
Date: Fri, 19 Jul 2024 18:21:54 +0800
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
 <34327425-80c6-4346-95c9-fa15f9381e1e@nvidia.com>
 <b940e617-22b3-495b-a97e-42aad45f0ed6@linaro.org>
Content-Language: en-US
From: Jeremy Szu <jszu@nvidia.com>
In-Reply-To: <b940e617-22b3-495b-a97e-42aad45f0ed6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: OS0PR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:604:24::23) To PH0PR12MB7840.namprd12.prod.outlook.com
 (2603:10b6:510:28a::16)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7840:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 99da8c70-0fb5-4c5e-2849-08dca7dca05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDl4U09mWHh2UzNETHBDYnQyUzJRMXdOZzBLK3RPeURWZlVXak1VQkJWNzNo?=
 =?utf-8?B?Z0RvZXlwU0NzZzIvbEpOb1Z1Z3l1V1Nuc04wUkhNLzVEQ0p2eGRXV1h3UkJZ?=
 =?utf-8?B?eHU2Ty9xMzZSL1RjbDVJd1h3L0NTcC9kdjUvR0VsN3htMnFTbElDemUxUUx6?=
 =?utf-8?B?NDhUYXA5MEtZR3JoWGUwelJiODBlY0F0ZVkrZGJUYktFMWRsdVhFaEg2N1d2?=
 =?utf-8?B?dkg2SkF0d0lUejZhSStsUmZEemhDSTFNL2hQTnJkR0VJYXVtMEEwZHBUOFY2?=
 =?utf-8?B?UkpxQzFxcWpTNUhNSjBaalE3MVFsb0dnTzB5UHFEelMzamU4Vi9yUmxPYjRP?=
 =?utf-8?B?ZnRXREsxZXlnaFJ0RjhGSlpZNlViUXdFTHhVTmlYSmkwZnZlN0lWeWs3bVJU?=
 =?utf-8?B?VXhUVUQ0Z2JwdFFGWXp1dVVWVitoNi9DSnlicEVwV0NlVnc1eUVyWis2amZy?=
 =?utf-8?B?N0JibS83c2VKL2U4ZE9kdnBxazVveExoc3k0VUo3cWVOdWNWSmNqU1duc0NC?=
 =?utf-8?B?QWZ0Tkt0bGdpUk5xcWd5bStLZys5UXVxNzBVdnpFZ0ZSZ2U1TFdCRDVWNUZZ?=
 =?utf-8?B?bnRVUkJMell3MmFxZFNCWTl4K0VmcW02alQ5K2Q3M2NaQmxCL3RpQXEwRlla?=
 =?utf-8?B?a2VROTBGMVVuN0ZPeFdEelpnaURHek9mdFB0djNFVDY4dEttZmZkM21yZ3Rk?=
 =?utf-8?B?Zjhqdjl2b3lEa1pMc2ZDajB1OG1va0YxQVhFMHVmU1FpL0pJYmdXNGw4akwz?=
 =?utf-8?B?bGpja21HUHRwKzdOaXZ3ZFJVTmh4M0RqVkIrN2luUWliaVdTUWxHaUUwRU1l?=
 =?utf-8?B?eGI0aFlWcklWQ3FhWHlqeVoweGdOK1NpRFBpSjl4dHVLUW15SnVQcmhGbG5u?=
 =?utf-8?B?V0UwQ0xSRDM2Y2ZJV3F2QUdnbDcyVUdHTHdRVk56UUYrSHl0d3lGc3RaVmFH?=
 =?utf-8?B?YlVaZldUcGY4SVVsSlBUTWpSaTN2amRqbUNReXpWQi9WMTNaYXpFM0J2bUpU?=
 =?utf-8?B?ZDZSY0RHU01ocm5JZTlCRHNpaFR3bWJCQTZsSmdGRlVOeW5pOHVHYjdKSDI5?=
 =?utf-8?B?Qjl0M3hsV3dILzJ6ZFpuZnlXZy9xMDdoWGVLZVZVc1FCR1F4TE90Yy9pOEpY?=
 =?utf-8?B?blBlbGNncW1PcGdrQ0I2d3VMWEtrb2RtTmhCSkFVcWhZNkVEeFp4ZHQ3Mzg3?=
 =?utf-8?B?RkV6cjJxWTdTVTZDUGNIQXV0b2xxb0d5M2dsUW95RmRIaUR5M3BlMUs4OURQ?=
 =?utf-8?B?aFlJU1VTZWtzWndDeE9hUHhSTnh5QnpXbkhtdERrQkdDUWpITUkyRExQU3Iw?=
 =?utf-8?B?RUN3RXhpYkplRElPb0xwaFI4QkIzZVZIWHRFT3VMcVhLM1gyaUhsZ2ZxelQz?=
 =?utf-8?B?eE5VMjZmR0hvWGROVzIwZVpqcUg1Y0wrdU1MOXk1RjhCRHlpaHhuWUtEWFpP?=
 =?utf-8?B?cGlNcE8vcWU2dUR6SlZNaS84ZGhGdzFqejF3dlhpR3BwOVFaZW9jdlI3NHhK?=
 =?utf-8?B?RVgwbGVQOS9sVC8vU0E4UFp3QWQ3anpkVTkxOWNKWlVMdDhvdjVFZ1R0anJY?=
 =?utf-8?B?NU5hOEVpSllMTzFPMGpQY0ZKNVRwOTJhVXlhZ0FTRWFiWFVpUGVHeHVlVjNN?=
 =?utf-8?B?WTcwakJmL0FiNnozVll4TGR3Rk0vOHBDaG9HUFhGMWJmMlNFSHE0aFNzTG9P?=
 =?utf-8?B?SCtPUlVEN2djS3l2Q2dzbDgyNzlIcnlLdFpxUS9kUSt3T2FFRk1UWUg5aU1Q?=
 =?utf-8?B?MXRsaVRNeXFWc0FYMjNzOC95S1RCb0hQeGJyZHU4eGJsS2E3YnYyM2hyclRO?=
 =?utf-8?B?cXY2T0lTYTBLVTQvY1JMdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7840.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXZzZEJBVm5sNFIwVS9RRkpjanBZRDVDa1dLckJaZXlSNVBRV3JQbWhubERi?=
 =?utf-8?B?eGd6SXgvaVNiK2xXbUx4d3N1d1RxUFJYb3FIdlZrQ1pweXVibFpUVjkzSVFa?=
 =?utf-8?B?QTVqUVRFT3Bva01SKzR0N01Vb2hwTWlRUGg1eDhOMEJyVk9sZ2xXSlM5c3Fo?=
 =?utf-8?B?SU1ZMDFqSHR3RFhIcHM5aXRkNitlQ0JBUmJXSjVvQWdTcmFZVkpIS1pBOTFr?=
 =?utf-8?B?aUVNd1BsNkx3a0hyU0Y0T1Awc3phSnhiWFRJQUdhZVd4YXhuREhkL0I2KzMw?=
 =?utf-8?B?WStTZW1sditBbTByVFFHNldZNkpmV1J6MnhHbTQ2VkxXRmRRNUNteHRHbjc0?=
 =?utf-8?B?Q3hwUEtFNzBLWEdtTHVLTjBWNHA1MTNRcWRWWGlyYVd5MkVJSkNiS0dDRnZB?=
 =?utf-8?B?K1pGSjlIMkREeVhYSlgzaEZ3OURWQm0ycThiWDV4SXFyUzJaSnhBMnY1R0dy?=
 =?utf-8?B?VFl3TWgrLzBUV1RXVzdwOTlmMk03TmgxdDFucDdmVW9yVmx0cSt0Z0FYaHJ5?=
 =?utf-8?B?V0d4K2psaUFEZElLTXRjR2RMa2pkeWw0SWZNTVpBcXhpbFJnZ1FSUzk1K3FJ?=
 =?utf-8?B?TGJOTEg2ZmtkMGpqVEdwdGVpbTRuNys2OU1XN3E5bHN3U0M4M2VpaExoTHNj?=
 =?utf-8?B?T0pKSnJtUHh0blA5K1l6blRPaWxudEg2a0NIbHJoTEtuaVpLVGowSTkwOWNO?=
 =?utf-8?B?Vkc0SXdXY1JQQmRmb09ROGttdmFxSk54cXJwcFJIbVRicFRyUFY3VVBzbFA0?=
 =?utf-8?B?cHBOcldWN29Pamh0RXU2U2tXcjV1eEhVeUdHdklxSi8vNUoxa1FiSjRYZGFQ?=
 =?utf-8?B?eWhwd2V4aTVMeWp5czhwV3FzQjJhZUhyc3NwczAzNFFoRFJKRi8rTU9oVkla?=
 =?utf-8?B?RUkzUUFwTjlDK2FJR3dUekRlaTIxUUxXK1hvYWFBczJZMHhJSWxoRVVQVjZD?=
 =?utf-8?B?WWhiQUxsWWtHdm9lREV2blp2VkxhaXBmZ3ZqZWg3MlNJOHpyejNqeXFiMThV?=
 =?utf-8?B?Z3M0RlpHZnNEbnBOVmNBSUNVR3kyN252VFhlNHBaVEowbE9yNUVPeFhrQ2Vy?=
 =?utf-8?B?VTUxVHVESlZneWRNUWZWakRsOHU5RVljdldpRThtajNqNHpxZjg5RUZhenpS?=
 =?utf-8?B?TDI5NGF4b09MRjE5OEpOQjJqdkEvaE1IbE50TmFUendSaVhUNithNW1QUUtN?=
 =?utf-8?B?OTVGTmhMVFp1SmViTXNsRWFvK3dwR0R5elU2Yk5jelJxMmFlYTZ0ZnJybU1T?=
 =?utf-8?B?WVZMMisvZ1FpVk1iSnJMT1FuSDdySnlQdUNGcklYQ0dET2xaeU9iWlZGY3FG?=
 =?utf-8?B?cXlyNy9VNnR3Z1RZeStwbWdac2QxUGdMZG5LaWtVOENLR2Z0RGN6clRoYnV2?=
 =?utf-8?B?VmtmSHBWMHZwRkx5a2lEK29BeGU5TCtVNWFxdWJlV2RzNmJYdVVLOEM5c3U4?=
 =?utf-8?B?S29MRmw5LzNLY2o4dm92SWZWbjc0a012THUwRVFSUitoU1VOb0FwRlJmdW9K?=
 =?utf-8?B?UHZVYlExSHFJZlpZTzAyY00yMURJRUtDVlc0TUVOVnA0TzJQLzVBWHlZNW1M?=
 =?utf-8?B?TWtLQ3JXamo2Y0FIdUFwOWpZL0VDbDV3aXlGSE1jV0FweDVuZXltQmc3WDM5?=
 =?utf-8?B?UmhNYzlBb1B1TWdjWjFjVFdzUlFZbjVWWURqNXRUQTVNcWxhWitCUGJHUlpT?=
 =?utf-8?B?dTBVTzVzN0lNaXc2YjFBMFJrUVg4eXFOUW9rbVcrWGJUYjdHeS9QSFJaK0xJ?=
 =?utf-8?B?eVRKS3RxS0p0b0ZsYzlqVTVTNVpaSzAybE1xRDNIMEs5dEI4b1NZek5DWkFP?=
 =?utf-8?B?bXBJWG1TdlJlRUtmZHlHN2VGMFhVZmkrdzdNNmRVUUY3QkFmdHpnZy9lb1p4?=
 =?utf-8?B?SVgvN25uZFNTMG9Ua3ZFZEJrQ1ZZd01WZFdnVXNocmdYYTVaaHdZaTV4aFpk?=
 =?utf-8?B?TkdFeDR5ZEJ2Y2t1RHVLQTRva2xSaDJQa3hqZ2hrUmJFa2VFUWhGMjBPTXNZ?=
 =?utf-8?B?c3pmeHUvcUtkZVB4b0Z5OVlkVGFtZXJjejUyd1l6YW1XVkNEZWVLd2U1VWVz?=
 =?utf-8?B?QW9HazFoTTVxU0RqR0tNQUtQWGNjbHRDMW5hdnFXUGdsWGFRRkxUMVZxbndr?=
 =?utf-8?Q?4zuA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99da8c70-0fb5-4c5e-2849-08dca7dca05f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 10:22:00.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60b1zf1COr/d52VqzciqsQazqzgL5LxukQ0pFqVOTGB+IeB6TvtFv7ixiO9gC5GJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369



James Clark 於 7/17/24 10:48 PM 寫道:
> 
> 
> On 16/07/2024 3:06 am, Jeremy Szu wrote:
>> Hi James,
>>
>> Thank you for your reply.
>>
>> James Clark 於 7/12/24 5:01 PM 寫道:
>>>
>>>
>>> On 11/07/2024 7:03 pm, Catalin Marinas wrote:
>>>> On Wed, Jul 10, 2024 at 02:27:32PM +0800, Jeremy Szu wrote:
>>>>> Add a script to test the coresight functionalities by performing the
>>>>> perf test 'coresight'.
>>>>>
>>>>> The script checks the prerequisites and launches a bundle of
>>>>> Coresight-related tests with a 180-second timeout.
>>>>>
>>>
>>> Hi Jeremy,
>>>
>>> On the whole I'm not sure running the Perf tests under kself tests is 
>>> a good fit. We're already running all the Perf tests in various CIs, 
>>> so this is going to duplicate effort. Especially with setup and 
>>> parsing of the results output.
>>>
>>> There is also no clean line between what's a kernel issue and whats a 
>>> Perf issue when these fail.
>>>
>>> And thirdly why only run the Coresight tests? Most of the Perf tests 
>>> test some part of the kernel, so if we were going to do this I think 
>>> it would make sense to make some kind of proper harness and run them 
>>> all. I have some recollection that someone said it might be something 
>>> we could do, but I can't remember the discussion.
>>
>> The idea I'm trying to pursue is to use arm64 kselftest to run as many 
>> test cases as possible for ARM SoCs across different designs and 
>> distros. I believe it could provide an alert if there is an issue, 
>> whether it originates from userspace or kernel, similar to how perf is 
>> used in other categories.
>>
>> I'm not sure if all perf tests could be counted in soc 
>> (selftests/arm64) category such as some tests may target to storage, 
>> memory or devices. I 
> 
> Could we not put the Perf tests in  .../selftests/perf.sh, then it 
> doesn't really matter which subsystem they're targeting and we can run 
> all the Perf tests?
> 

The .../sefltests/ seems for the kselftest framework only, not sure if 
having a new .../selftests/perf will make more sense?

>> could replace 'arm64/coresight' with 'arm64/perf' if it makes more 
>> sense. I believe it could help users verify functionality more 
>> conveniently.
>>
>>>
>>> Ignoring the main issue above I've left some comments about this 
>>> patch inline below:
>>>
>>>>> Signed-off-by: Jeremy Szu <jszu@nvidia.com>
>>>>
>>>> I have not idea how to test coresight, so adding Suzuki as well.
>>>>
>>>>> ---
>>>>>   tools/testing/selftests/arm64/Makefile        |  2 +-
>>>>>   .../selftests/arm64/coresight/Makefile        |  5 +++
>>>>>   .../selftests/arm64/coresight/coresight.sh    | 40 
>>>>> +++++++++++++++++++
>>>>>   .../selftests/arm64/coresight/settings        |  1 +
>>>>>   4 files changed, 47 insertions(+), 1 deletion(-)
>>>>>   create mode 100644 tools/testing/selftests/arm64/coresight/Makefile
>>>>>   create mode 100755 
>>>>> tools/testing/selftests/arm64/coresight/coresight.sh
>>>>>   create mode 100644 tools/testing/selftests/arm64/coresight/settings
>>>>>
>>>>> diff --git a/tools/testing/selftests/arm64/Makefile 
>>>>> b/tools/testing/selftests/arm64/Makefile
>>>>> index 28b93cab8c0dd..2b788d7bab22d 100644
>>>>> --- a/tools/testing/selftests/arm64/Makefile
>>>>> +++ b/tools/testing/selftests/arm64/Makefile
>>>>> @@ -4,7 +4,7 @@
>>>>>   ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>>>>>   ifneq (,$(filter $(ARCH),aarch64 arm64))
>>>>> -ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi
>>>>> +ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi coresight
>>>>>   else
>>>>>   ARM64_SUBTARGETS :=
>>>>>   endif
>>>>> diff --git a/tools/testing/selftests/arm64/coresight/Makefile 
>>>>> b/tools/testing/selftests/arm64/coresight/Makefile
>>>>> new file mode 100644
>>>>> index 0000000000000..1cc8c1f2a997e
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/arm64/coresight/Makefile
>>>>> @@ -0,0 +1,5 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>> +
>>>>> +TEST_PROGS := coresight.sh
>>>>> +
>>>>> +include ../../lib.mk
>>>>> diff --git a/tools/testing/selftests/arm64/coresight/coresight.sh 
>>>>> b/tools/testing/selftests/arm64/coresight/coresight.sh
>>>>> new file mode 100755
>>>>> index 0000000000000..e550957cf593b
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/arm64/coresight/coresight.sh
>>>>> @@ -0,0 +1,40 @@
>>>>> +#!/bin/bash
>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>> +
>>>>> +skip() {
>>>>> +    echo "SKIP: $1"
>>>>> +    exit 4
>>>>> +}
>>>>> +
>>>>> +fail() {
>>>>> +    echo "FAIL: $1"
>>>>> +    exit 255
>>>>> +}
>>>>> +
>>>>> +is_coresight_supported() {
>>>>> +    if [ -d "/sys/bus/coresight/devices" ]; then
>>>>> +        return 0
>>>>> +    fi
>>>>> +    return 255
>>>>> +}
>>>
>>> The Perf coresight tests already have a skip mechanism built in so 
>>> can we rely on that instead of duplicating it here? There are also 
>>> other scenarios for skipping like Perf not linked with OpenCSD which 
>>> aren't covered here.
>>>
>>
>> Will it return the different error code to indicate if it's failed to 
>> be executed or the coresight is not supported?
>>
> 
> I think the exit code is only used for more serious errors. For things 
> like missing tests, SKIP and FAIL it still exits with 0 but you have to 
> grep for the strings. Actually for a missing test it prints nothing and 
> exits 0.
> >>>>> +
>>>>> +if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
>>>>> +    [ "$(id -u)" -ne 0 ] && \
>>>>> +        skip "this test must be run as root."
>>>>> +    which perf >/dev/null 2>&1 || \
>>>>> +        skip "perf is not installed."
>>>>> +    perf test list 2>&1 | grep -qi 'coresight' || \
>>>>> +        skip "perf doesn't support testing coresight."
>>>
>>> Can this be an error instead? The coresight tests were added in 5.10 
>>> and I don't think new kselftest needs to support such old kernels. 
>>> This skip risks turning an error with installing the tests into a 
>>> silent failure.
>>>
>>> Also as far as I know a lot of distros will refuse to open Perf 
>>> unless it matches the kernel version if it was installed from the 
>>> package manager, so we don't need to worry about old versions.
>>>
>>
>> The idea to skip it here is because I thought either a distro (custom) 
>> kernel doesn't enable the kconfig or the distro built the perf with 
>> CORESIGHT=0.
>>
>> I could make it as an error and put it after "is_coresight_support" if 
>> it makes more sense.
>>
> 
> But the Coresight test already checks these things, which is my point. 
> You can grep for "SKIP" which it will print for any case where the 
> coresight test can't be run due to some missing config.
> 

Oh, I guess you mean to rely on something like the `perf list cs_etm | 
grep -q cs_etm || exit 2`. Yes, that makes more sense.

>>>>> +    is_coresight_supported || \
>>>>> +        skip "coresight is not supported."
>>>>> +
>>>>> +    cmd_output=$(perf test -vv 'coresight' 2>&1)
>>>>> +    perf_ret=$?
>>>>> +
>>>>> +    if [ $perf_ret -ne 0 ]; then
>>>>> +        fail "perf command returns non-zero."
>>>>> +    elif [[ $cmd_output == *"FAILED!"* ]]; then
>>>>> +        echo $cmd_output
>>>
>>> It's probably helpful to print cmd_output in both failure cases.
>>>
>>
>> ok, will do.
>>
>>>>> +        fail "perf test 'arm coresight' test failed!"

I think I should remove the `is_coresight_supported` there and checks 
the output as a "else" to see if the test is PASS or SKIP. Does it make 
sense to you?

>>>>> +    fi
>>>>> +fi
>>>>> diff --git a/tools/testing/selftests/arm64/coresight/settings 
>>>>> b/tools/testing/selftests/arm64/coresight/settings
>>>>> new file mode 100644
>>>>> index 0000000000000..a953c96aa16e1
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/arm64/coresight/settings
>>>>> @@ -0,0 +1 @@
>>>>> +timeout=180
>>>
>>> I timed 331 seconds on n1sdp, and probably even longer on Juno.
>>>
>>> It doesn't need to run for this long and it's an issue with the 
>>> tests, but currently that's how long it takes so the timeout needs to 
>>> be longer.
>>>
>>
>> ok, will extend it to 600.
>>
>>>>> -- 
>>>>> 2.34.1
>>>>
