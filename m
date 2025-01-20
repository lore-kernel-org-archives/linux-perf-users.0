Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1957B191F95;
	Mon, 20 Jan 2025 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737373390; cv=fail; b=TyfbmSRnLR9E6Se1qs0mBtHTpDtFFw+HerPCLBFzhCoK4GaqvTVDo7EWbBPogBPX7hPucHQEbpqFtm6x56/IcgPxvhSDHGlvlhaTLUQvcAWZYomn+JCXt/8F+97FyujGjUnhjuHshfMfz+Hz1Ws1EFgflHgZJZwSroE2wULZfAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737373390; c=relaxed/simple;
	bh=BvjMv/zvp2UW0GzPVb/qE6TvbW81xdCB1hNwTfMQ2OQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sDPPC4ZyLti0LobaGdD3om800pcPCC7MxwSqTG3UN89mpUeb+12184Z+vdmyh6ktGJ14N1tlt3ZphPQWw4XiFixgEIXqDcdtSHHiavKyjJ7jaIS/OUVl15wbfXgrN7vdfKJAl6d3P18LLUj6WhI5d03ju6Wzpq1ug2LQ5aPl/Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=41nwtNlO; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="41nwtNlO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1kFh2rrl9tizDXtZrH/nH0A+jZ1eK3rDt9czkTgfizHPEdqSpaIeNllTRU1UbhWIyCoR4UAc+2drm4FsEqucQ10379oBkBclIlCmHqf70uYQfpaLq2l3Cu44F+wmrUS9YW576niJ0+73/bKaOYNMFthRk+6mm1QN3Uy+u6QS5xLKs31TFmd5fx+jAhENMph03fwzEkmSqKf2QQinF+TjCBKRkUnjoS1kIqpTJINBuE+cfT8myqb8HOEB1IL46CnJxdT8nLqtJaptp5f0QyA/mz2qf6OmzvWNVrkjDGTwe4Wchlg4EspJB+vZF4g2J/MI0GQj652mcyKNcz1rvbi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPm4E3c+Op+Jr7hgAfIQNQMZRPmYbT3q0RuNfsl0X9s=;
 b=ljIixZDt5I73R/2Xh9aINFKUiRG1MjyEwMLj3iL3I5v/Q5PUNSjql+yKtjIG+nuizb5B9Q/uQrOK2RSMYJWp6LXZjQW4Kipz7aYxjh7WemRnqfCLWy2uZy4MS7ZW4WmU7VOoLvykGNfxzf6Hv5j+O14ObPDGRiyZOjG6XnD91HycdFy/FLZG7fhw9OK8ObkTtagsYvEQ2bUTEENW88e+IGq4SLN+7YTisK+aV1h0LQ2GGKRXOsiNmN5yD3EnGfPnwbOkbD/GZo59tPdNwKTb7e7xsvPjokx6YAD0cDqVx5zRI2NyQy67D/FcXnWAf94pa1A0p+U3eTIExh2ThLVW3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPm4E3c+Op+Jr7hgAfIQNQMZRPmYbT3q0RuNfsl0X9s=;
 b=41nwtNlOo0jSmTDFFA153ky9fLF4lKC1vHaOVg0schVPfS7SGQa13OueQPTE4xuz4kxhUIaErTfnJjEpi3l4ny4zBWu+LU0PgzL4IdQjwqRGptm26AZlaI/ByOXbHtGS2/AMzFZhzsdgQ8GJgj2aojI+z29JkNbvb8olWgRJV88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Mon, 20 Jan
 2025 11:43:03 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8356.010; Mon, 20 Jan 2025
 11:43:03 +0000
Message-ID: <1276efa0-488c-448b-adf8-b002c77179f6@amd.com>
Date: Mon, 20 Jan 2025 17:12:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] perf/x86/rapl: Add core energy counter support
 for AMD CPUs
To: Koichiro Den <koichiro.den@canonical.com>
Cc: peterz@infradead.org, mingo@redhat.com, rui.zhang@intel.com,
 irogers@google.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.dei, gautham.shenoy@amd.com, kprateek.nayak@amd.com,
 ravi.bangoria@amd.com, x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
 <20241115060805.447565-11-Dhananjay.Ugwekar@amd.com>
 <uv7mz6vew2bzgre5jdpmwldxljp5djzmuiksqdcdwipfm4zm7w@ribobcretidk>
 <98f6108a-3a4f-4ad1-8f0a-a03264f7a2d7@amd.com>
 <6ljdgok5zostmu4uxixwh3idgrrtodul4bjvujvwjfda427snu@3vxczriucb6m>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <6ljdgok5zostmu4uxixwh3idgrrtodul4bjvujvwjfda427snu@3vxczriucb6m>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::9) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 96bcfb42-c899-4f8f-3485-08dd3947991c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2ZRTnlkZmI0QVpZWVdEN3FDNldwdkhUeTZZK0RzSXdMM0J6cGEvK0NHMGQv?=
 =?utf-8?B?S1ZMVTZpZkhvMGZEeS9MTm9PNmVDSG1FQjBjWVhCQ09pM1VPczdqd0FVZUdr?=
 =?utf-8?B?c3lXbUQvSlVVOHBTYnlZUDltWDBQK1pNUTZia29nQ0o2NDZVRDY4YXM4WVkz?=
 =?utf-8?B?V05Ga1VYdjVEeHo4QS9nb1BpUlpPMnlKZGR4aFRhdGJFR21MdkZmRkVuV2hn?=
 =?utf-8?B?WHNPN0JhMDhHYzRXeTcwWmxSbmtPYUZQazYvd3JSc0NHb3h1cWluaktGRUVv?=
 =?utf-8?B?WnAvMjdLa0NhS0V4Skt6MFFOc0s4SHRYTlhlWlpIV2owa1hEYWVuenZOMEcw?=
 =?utf-8?B?akN3UXVyVEJRaGtFWWRsZWlPazIwVTRtLzZrcDFuTDh5bmswSER5YXdnRFMy?=
 =?utf-8?B?VittZWZ4TmVEblgyNU05RXlSbGFqWDYzSDc4QzhDM2hTZUVWVE1HZTVxbU9U?=
 =?utf-8?B?akwyaWtQRW1zbXA2SUhlWVUweXc5SHYyRDNreGdyaGdoa09VOFQzV1hPZzNk?=
 =?utf-8?B?ODBCY2hPM0dQMTJYcElSNytOdy90L0ZlSEV1Vko2Z2JnQ2VFdDZjVXM4aW5a?=
 =?utf-8?B?bkdIcFhXVFdzNyt4RVhxaUg1VjRWcU1pMEdJeXNuWllLSGFvcVpuYW1xcE8z?=
 =?utf-8?B?VkMxajdTR25NNEtEcFZUb1FsM1VFa3BjeTQ4ZTNGUEsvRXFwaENwVVBXMmRx?=
 =?utf-8?B?eWJNc015VmNFd3B3R1dwVHplNm4wMVhVT2d0dVBzUXVhQkF3S0RSWW53blcw?=
 =?utf-8?B?MzkyK0RReUQ2TWJzd0VnV1o3Y1lGOGR6OFVXc2VSdlFmODZXbHdncUU0M3lG?=
 =?utf-8?B?TUlocUFsYVBNWUxQNDdCbzg2cTM0d3BWSXR3d0JXRGd5UjJ4T2twT1JYejNZ?=
 =?utf-8?B?cnJld202bHZiYkltSWNpaldUdG5iZk1LZk9iM0tSWmN5Z2tSTnFuWTB5ZmRi?=
 =?utf-8?B?alFwejBMbUV4TkxuNmdDT2hZZ1NBclNWUG1rWVoybUNqaWphbHdJb05jeXA3?=
 =?utf-8?B?U0FKYStUUU4wZnk2YWNjY09xU2RiL0RkZlRkVVV3dmlBQnhDaERGdElmZzlV?=
 =?utf-8?B?WEFHS21xT2hoaUlYaWhJUjk5NXFBaE5lRllXRWZCQWxqeGlZNTE4NnpEYzBy?=
 =?utf-8?B?MWtVa2V5dmU2NlRGTTNpeUpxazE4RzlkV0Z4WjJmYUEzb3NKbURFWlpqa09n?=
 =?utf-8?B?bGFSWW9zUmlTdkVJN1NGc2tYMEo2VUZVOWFqV1d1WmdNbDMxTDM3Q214UWlL?=
 =?utf-8?B?MlVnL2EvOUtRVElUOUcva2J6V2lvMW1TWTFxRm9KQjh0ckpoMFluQ2NGelFC?=
 =?utf-8?B?R1lLMDlLTGF4dGNFQWxabkR1Tmx5WC9yUlhhUWRyYU94M3B4dlFyekdxNUhR?=
 =?utf-8?B?U2hGWHUyWTdCNk9md0tTWUg2Sy96SmtvOVVkS0hqN2hyNStLZDhrWUxGaDMx?=
 =?utf-8?B?VU0wOGJCbit6WTN4RHdFVmE4bm5WeWtza2lmVmxCa3hBTjNBT0hWdW5UMFBi?=
 =?utf-8?B?blg3N2NBaXBFMnRDb0ltK2MrYWtrY3ZEa1VteFM2YUVlRzFuWFFiSTFYS1R6?=
 =?utf-8?B?eTdpOU03ckVYT0VZY3Z6YTdQOGxxUmtuZ0FwbTJDMmxyKy9TWU9GY2FoSUJy?=
 =?utf-8?B?NThDSDRhOTJsL2l6bTY4MlFNTEM5cm5NTUw5amlIQ3hNVi9PTlVtOXNOYzFi?=
 =?utf-8?B?c1VSK2JRLzNHOFFncktPb1pKZ2JCN0xWcVJubkVOOWxxakRYUzJUR1pPR1Qv?=
 =?utf-8?B?OVJ2MDVaVE5KV3pnVlA2RGhPRkJLM1NJd2hrRXlkaW5DYWgvUGQ0ZDl2Z1FH?=
 =?utf-8?B?V2RRK0lTZE40OWdEbUFtalBSTnM5U3EySHlxVHlHMXBsUmM3UTV0NTExQmw5?=
 =?utf-8?Q?ASplOTEfh7gqe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0lNNDBEbjJVWDA4Y0xyRjZ0R0MzaktDWmdYWngyVnZkS05UZlBvTFhDeUpw?=
 =?utf-8?B?dGhVYlFLTHlQWTRrZFoveTIrK25JQjkvUjVyWGkrTjRiMFRhTXVGejU5QTN2?=
 =?utf-8?B?NmtPa1dlSU1jb2JIUFIrWEFJZzd0dXlzM2dqeXVtUlBFcVlId3lGa1JNZDBa?=
 =?utf-8?B?a1VrZmhRbkY1d0dBN2dHc2NJY294Q0ZOK0Y2YjBEU3lkOGNSSVNiOHZ1akVO?=
 =?utf-8?B?V1pOVTFTV1h1OXFYVmcwbHRSMnhzaTJkWlZrUUd2UGFYZ3EyVzdJa2wxVHIw?=
 =?utf-8?B?aExPOUY0MlpMMXMrbGZhMVFlL0cwMVlLeE01L1BPRENBaWIvM1VXbWhyeEJP?=
 =?utf-8?B?YnJaVFlYL1diM0g0RHoxUEFTZFRaM3lUeXBETW9lSXpOS0xUSnpFaE04V3gz?=
 =?utf-8?B?NWhndE4xVlp1Z0hYMFd3UWFRZnhWWHpnR3IvTm5vcnhyK0RzdEpnWkdWMWlM?=
 =?utf-8?B?TFhiSE9RSXJFeGIrTkpCVXpmSGtzLzVIbkFmaXUwUmo1a0g4dE9MV2M2VWFt?=
 =?utf-8?B?VW5BRjIzcFFvK25RUy9KNnpxSzgxcHM3V0d1RForQ3pPQzdac0U2SHMrSkx3?=
 =?utf-8?B?QXE1RWE4eW5MMGE2SDhXa0JJaXdqbHNGZ1JDc3RFRnU0clFrZ1dPQUJ0MWlI?=
 =?utf-8?B?MGZ1eXErMUZoOXRQendzdEU1NEFnWVVqVmFONER5dmNqMHlJTlpmaEFMZHJQ?=
 =?utf-8?B?OGxRSUNyN24xUENFV2t0S0N5Mk1sMjNtTSswVFI2NjVJbzlIdHNhVUN3VFNQ?=
 =?utf-8?B?Tnh5ZndZUWRMeFpibXVxUEo4Y3cvVm0ybTBiaHI5TjJZZmtEYjFmVFE2cEdt?=
 =?utf-8?B?WUVUaHJQdDZMdW1wQXR0NFhnWlYzenV5RFJQOFplMEF0NGNRalg0NTNCdkx4?=
 =?utf-8?B?RlpjblE5bDJuR0l4WjVNMk1KRmFZMU1mcFZLc0RBZ3NydUJBTmdSczJMdmhG?=
 =?utf-8?B?WU9rcitGRlNUVnhuVnNHWFRsWVRteHQyMkdNYktkcHErMkFkRnhrVStuNnZo?=
 =?utf-8?B?VmYwUUd0Q1ZYb21BVGREYkJJV1JuY29hMll2VDR2RXVWbEpnb0VQT1BhQUtw?=
 =?utf-8?B?ZHNsSXRpY1h4Ly9mWEhSbklOMUdKU2Z3Z3NrejJhZFp4c0ZZV0w2cXJBSjUv?=
 =?utf-8?B?bEFnM2tYeDlockQzOHMzaVlCWFNQT2ZBNGVJWUMwUVhoUE9GaWhZSm1CVUlm?=
 =?utf-8?B?LzJyS0QyOVVjdFJybCtEZVU0RjYxWk1OODBnSW5ldno0cjY1NkhneEhlUzZT?=
 =?utf-8?B?RlFsL09DL3IzbkhEbzl5dWhrT01hSnFLeGNBR0VpN2pHSEM2a2FIUXl6SmF1?=
 =?utf-8?B?bVNhbDJ2bEVaUE9qMk9TNnczN0o2NDVuRVBzalY0ak5kbmlTbUMrQVcvdGJZ?=
 =?utf-8?B?MkFsbkkyWEpnVTZhRHBnK012SnJzODZGYWJwZEswWlRDTU9iOVo0bnVoYzhK?=
 =?utf-8?B?NmNUSk5GZEU2RFUwOUgvVEFYYVVMdlFiRG9OZkg0QS8vcU1KbDcrQ3A1UHA5?=
 =?utf-8?B?cFlSQnB0U1V1YUlzVFhzY0owa0VjbkZMVFhhU3hUS1p0YlRhT0VXWVJOVjIr?=
 =?utf-8?B?L1E4eXBaMWd5UFJ4OVVvSVNkM1p3VFEvMk1LL1NNcEMrUEkwVmVwUmg3Vmty?=
 =?utf-8?B?WkM4UjVEOUJodDlIQS9JM1J4enNUSkNrVkM4WlZQY3dZRm4xNE10Uzh0NWV3?=
 =?utf-8?B?aHhMMEVXVG9rR2taUm1EN3pkRVZoekxoTzNoN2hobmlYY1Y5UWlwaGxHbzdD?=
 =?utf-8?B?dCszUm5FdEFpNExQSmhCSXRkbExWMi91TmZjeVVCbWhEVHRiRWhDOC9jTFBh?=
 =?utf-8?B?RmpEVFNRWjVuMlNDbFJaUWhlakZ0UXZ2dlZmc2ltSk5oa1NpZjRydEtaM1py?=
 =?utf-8?B?Q284Z1crWklXeTFzZnRnQzRVWDlra0RFYUg5OVRtNjV2RVluWk4zclphbUkr?=
 =?utf-8?B?WGVPZVRQTVBFcjVBa2FRdDdCWm5uRDVtNHdvU2FxRTNTRlRyNi9WOHJ1b0tn?=
 =?utf-8?B?RW11QkZKNVVma0UwWWcxL3IwSEY4RGpKa2VwMVNMMkFjckx4N01JQmowTmxS?=
 =?utf-8?B?TmNMbVViakk5NjdnTWRoZytLUXh5OXRwQ1Z1QUdmS2VOY0YwN2NXSW1meVpL?=
 =?utf-8?Q?D8wXrfTjMTEvMLdeY5EL9p5sd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bcfb42-c899-4f8f-3485-08dd3947991c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 11:43:03.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkoQa+qTDyEC0myrDR/MmYD28OgUdUcuberKr7m9h3nOI3uh1b40KydKCASENPF4vgMwlH3cYHYKm68UuCp0fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648

On 1/15/2025 7:53 PM, Koichiro Den wrote:
> On Mon, Jan 13, 2025 at 12:04:43PM GMT, Dhananjay Ugwekar wrote:
>> On 1/12/2025 7:12 PM, Koichiro Den wrote:
>>> On Fri, Nov 15, 2024 at 06:08:06AM GMT, Dhananjay Ugwekar wrote:
>>>> Add a new "power_core" PMU and "energy-core" event for monitoring
>>>> energy consumption by each individual core. The existing energy-cores
>>>> event aggregates the energy consumption of CPU cores at the package level.
>>>> This new event aligns with the AMD's per-core energy counters.
>>>>
>>>> Tested the package level and core level PMU counters with workloads
>>>> pinned to different CPUs.
>>>>
>>>> Results with workload pinned to CPU 4 in core 4 on an AMD Zen4 Genoa
>>>> machine:
>>>>
>>>> $ sudo perf stat --per-core -e power_core/energy-core/ -- taskset -c 4 stress-ng --matrix 1 --timeout 5s
>>>> stress-ng: info:  [21250] setting to a 5 second run per stressor
>>>> stress-ng: info:  [21250] dispatching hogs: 1 matrix
>>>> stress-ng: info:  [21250] successful run completed in 5.00s
>>>>
>>>>  Performance counter stats for 'system wide':
>>>>
>>>> S0-D0-C0              1               0.00 Joules power_core/energy-core/
>>>> S0-D0-C1              1               0.00 Joules power_core/energy-core/
>>>> S0-D0-C2              1               0.00 Joules power_core/energy-core/
>>>> S0-D0-C3              1               0.00 Joules power_core/energy-core/
>>>> S0-D0-C4              1               8.43 Joules power_core/energy-core/
>>>> S0-D0-C5              1               0.00 Joules power_core/energy-core/
>>>> S0-D0-C6              1               0.00 Joules power_core/energy-core/
>>>> S0-D0-C7              1               0.00 Joules power_core/energy-core/
>>>> S0-D1-C8              1               0.00 Joules power_core/energy-core/
>>>> S0-D1-C9              1               0.00 Joules power_core/energy-core/
>>>> S0-D1-C10             1               0.00 Joules power_core/energy-core/
>>>>
>>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>>>> ---
>>>>  arch/x86/events/rapl.c | 185 +++++++++++++++++++++++++++++++++--------
>>>>  1 file changed, 152 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>>>> index 6e51386ff91f..e9be1f31163d 100644
>>>> --- a/arch/x86/events/rapl.c
>>>> +++ b/arch/x86/events/rapl.c
>>>> @@ -39,6 +39,10 @@
>>>>   *	  event: rapl_energy_psys
>>>>   *    perf code: 0x5
>>>>   *
>>>> + *  core counter: consumption of a single physical core
>>>> + *	  event: rapl_energy_core (power_core PMU)
>>>> + *    perf code: 0x1
>>>> + *
>>>>   * We manage those counters as free running (read-only). They may be
>>>>   * use simultaneously by other tools, such as turbostat.
>>>>   *
>>>> @@ -81,6 +85,10 @@ enum perf_rapl_pkg_events {
>>>>  	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
>>>>  };
>>>>  
>>>> +#define PERF_RAPL_CORE			0		/* single core */
>>>> +#define PERF_RAPL_CORE_EVENTS_MAX	1
>>>> +#define NR_RAPL_CORE_DOMAINS		PERF_RAPL_CORE_EVENTS_MAX
>>>> +
>>>>  static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
>>>>  	"pp0-core",
>>>>  	"package",
>>>> @@ -89,6 +97,8 @@ static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst
>>>>  	"psys",
>>>>  };
>>>>  
>>>> +static const char *const rapl_core_domain_name __initconst = "core";
>>>> +
>>>>  /*
>>>>   * event code: LSB 8 bits, passed in attr->config
>>>>   * any other bit is reserved
>>>> @@ -141,14 +151,18 @@ enum rapl_unit_quirk {
>>>>  
>>>>  struct rapl_model {
>>>>  	struct perf_msr *rapl_pkg_msrs;
>>>> +	struct perf_msr *rapl_core_msrs;
>>>>  	unsigned long	pkg_events;
>>>> +	unsigned long	core_events;
>>>>  	unsigned int	msr_power_unit;
>>>>  	enum rapl_unit_quirk	unit_quirk;
>>>>  };
>>>>  
>>>>   /* 1/2^hw_unit Joule */
>>>>  static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
>>>> +static int rapl_core_hw_unit __read_mostly;
>>>>  static struct rapl_pmus *rapl_pmus_pkg;
>>>> +static struct rapl_pmus *rapl_pmus_core;
>>>>  static u64 rapl_timer_ms;
>>>>  static struct rapl_model *rapl_model;
>>>>  
>>>> @@ -156,14 +170,23 @@ static struct rapl_model *rapl_model;
>>>>   * Helper function to get the correct topology id according to the
>>>>   * RAPL PMU scope.
>>>>   */
>>>> -static inline unsigned int get_rapl_pmu_idx(int cpu)
>>>> -{	/*
>>>> +static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
>>>> +{
>>>> +	/*
>>>>  	 * Returns unsigned int, which converts the '-1' return value
>>>>  	 * (for non-existent mappings in topology map) to UINT_MAX, so
>>>>  	 * the error check in the caller is simplified.
>>>>  	 */
>>>> -	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
>>>> -					     topology_logical_die_id(cpu);
>>>> +	switch (scope) {
>>>> +	case PERF_PMU_SCOPE_PKG:
>>>> +		return topology_logical_package_id(cpu);
>>>> +	case PERF_PMU_SCOPE_DIE:
>>>> +		return topology_logical_die_id(cpu);
>>>> +	case PERF_PMU_SCOPE_CORE:
>>>> +		return topology_logical_core_id(cpu);
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>>  }
>>>>  
>>>>  static inline u64 rapl_read_counter(struct perf_event *event)
>>>> @@ -173,19 +196,20 @@ static inline u64 rapl_read_counter(struct perf_event *event)
>>>>  	return raw;
>>>>  }
>>>>  
>>>> -static inline u64 rapl_scale(u64 v, int cfg)
>>>> +static inline u64 rapl_scale(u64 v, struct perf_event *event)
>>>>  {
>>>> -	if (cfg > NR_RAPL_PKG_DOMAINS) {
>>>> -		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
>>>> -		return v;
>>>> -	}
>>>> +	int hw_unit = rapl_pkg_hw_unit[event->hw.config - 1];
>>>> +
>>>> +	if (event->pmu->scope == PERF_PMU_SCOPE_CORE)
>>>> +		hw_unit = rapl_core_hw_unit;
>>>> +
>>>>  	/*
>>>>  	 * scale delta to smallest unit (1/2^32)
>>>>  	 * users must then scale back: count * 1/(1e9*2^32) to get Joules
>>>>  	 * or use ldexp(count, -32).
>>>>  	 * Watts = Joules/Time delta
>>>>  	 */
>>>> -	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
>>>> +	return v << (32 - hw_unit);
>>>>  }
>>>>  
>>>>  static u64 rapl_event_update(struct perf_event *event)
>>>> @@ -212,7 +236,7 @@ static u64 rapl_event_update(struct perf_event *event)
>>>>  	delta = (new_raw_count << shift) - (prev_raw_count << shift);
>>>>  	delta >>= shift;
>>>>  
>>>> -	sdelta = rapl_scale(delta, event->hw.config);
>>>> +	sdelta = rapl_scale(delta, event);
>>>>  
>>>>  	local64_add(sdelta, &event->count);
>>>>  
>>>> @@ -341,13 +365,14 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
>>>>  static int rapl_pmu_event_init(struct perf_event *event)
>>>>  {
>>>>  	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
>>>> -	int bit, ret = 0;
>>>> +	int bit, rapl_pmus_scope, ret = 0;
>>>>  	struct rapl_pmu *rapl_pmu;
>>>>  	unsigned int rapl_pmu_idx;
>>>> +	struct rapl_pmus *rapl_pmus;
>>>>  
>>>> -	/* only look at RAPL events */
>>>> -	if (event->attr.type != rapl_pmus_pkg->pmu.type)
>>>> -		return -ENOENT;
>>>> +	/* unsupported modes and filters */
>>>> +	if (event->attr.sample_period) /* no sampling */
>>>> +		return -EINVAL;
>>>
>>> Hi Dhananjay,
>>>
>>> On linux-next, since this commit, it seems that simple sampling with 'perf
>>> record -- <command>' (i.e. the default event), 'perf top' etc. can
>>> unexpectedly fail because rapl_pmu_event_init() now returns -EINVAL instead
>>> of -ENOENT even in such cases of a type mismatch. I observed that this
>>> prevents evsel__fallback() from falling back to cpu-clock or task-clock.
>>>
>>> Should we reorder the checks in rapl_pmu_event_init() to allow an early
>>> return with -ENOENT in such cases, as shown below? I'm not very familiar
>>> with this area and I might be missing something. I'd appreciate it if you
>>> could share your thoughts.
>>>
>>> --- a/arch/x86/events/rapl.c
>>> +++ b/arch/x86/events/rapl.c
>>> @@ -370,17 +370,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
>>>         unsigned int rapl_pmu_idx;
>>>         struct rapl_pmus *rapl_pmus;
>>>
>>> -       /* unsupported modes and filters */
>>> -       if (event->attr.sample_period) /* no sampling */
>>> -               return -EINVAL;
>>> -
>>> -       /* check only supported bits are set */
>>> -       if (event->attr.config & ~RAPL_EVENT_MASK)
>>> -               return -EINVAL;
>>> -
>>> -       if (event->cpu < 0)
>>> -               return -EINVAL;
>>> -
>>>         rapl_pmus = container_of(event->pmu, struct rapl_pmus, pmu);
>>>         if (!rapl_pmus)
>>>                 return -EINVAL;
>>> @@ -411,6 +400,17 @@ static int rapl_pmu_event_init(struct perf_event *event)
>>>         } else
>>>                 return -EINVAL;
>>>
>>> +       /* unsupported modes and filters */
>>> +       if (event->attr.sample_period) /* no sampling */
>>> +               return -EINVAL;
>>> +
>>> +       /* check only supported bits are set */
>>> +       if (event->attr.config & ~RAPL_EVENT_MASK)
>>> +               return -EINVAL;
>>> +
>>> +       if (event->cpu < 0)
>>> +               return -EINVAL;
>>> +
>>>         /* check event supported */
>>>         if (!(rapl_pmus->cntr_mask & (1 << bit)))
>>>                 return -EINVAL;
>>>
>>> Thanks.
>>>
>>> -Koichiro
>>
>> Hello Koichiro,
>>
>> I tried reproducing the issue you mentioned using "sudo perf record -- sleep 2" and 
>> "sudo perf top" commands on an AMD EPYC system, the commands worked successfully. 
>> Can you please mention which system and which exact commands you're 
>> running that reproduced the issue?
>>
>> My analysis is, if we are running "perf record/top" with the default event, we would 
>> not enter the rapl_pmu_event_init() function, which renders the reordering of the type 
>> checks irrelevant. Regardless, please let me know how I can reproduce the issue.
>>
>> Thanks,
>> Dhananjay
> 
> Hi,
> 
> Apologies for the delayed response, and thank you for your comment. I
> confirmed that just running "perf top" on a qemu instance reproduces it.
> The host CPU model is Intel Core i9-13900K, which is passed through to
> the guest.
> 
> In my case, no pmu for PERF_TYPE_RAW is registered, but the rapl pmu is
> present. Then, perf_init_event() reaches the line marked "---->" below, and
> rapl_pmu_event_init() run, which returns -EINVAL before the type check.
> 
>   static struct pmu *perf_init_event(struct perf_event *event)
>   {
>           [...]
>           if (pmu) {
>                   [...]
>                   goto unlock;
>           }
>     
>           list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
>   ---->           ret = perf_try_init_event(pmu, event);
>                   if (!ret)
>                           goto unlock;
>     
>                   if (ret != -ENOENT) {
>                           pmu = ERR_PTR(ret);
>                           goto unlock;
>                   }
>           }
> 
> I'll look into this a bit more on my side later and get back to you if
> something becomes clear.

Sorry for the delayed response, can you please try the below diff and let me know 
if it fixes the issue?

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index d3bb3865c1b1..4952faf03e82 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -370,6 +370,10 @@ static int rapl_pmu_event_init(struct perf_event *event)
        unsigned int rapl_pmu_idx;
        struct rapl_pmus *rapl_pmus;

+       /* only look at RAPL events */
+       if (event->attr.type != event->pmu->type)
+               return -ENOENT;
+
        /* unsupported modes and filters */
        if (event->attr.sample_period) /* no sampling */
                return -EINVAL;
@@ -387,10 +391,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
        rapl_pmus_scope = rapl_pmus->pmu.scope;

        if (rapl_pmus_scope == PERF_PMU_SCOPE_PKG || rapl_pmus_scope == PERF_PMU_SCOPE_DIE) {
-               /* only look at RAPL package events */
-               if (event->attr.type != rapl_pmus_pkg->pmu.type)
-                       return -ENOENT;
-
                cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
                if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
                        return -EINVAL;
@@ -398,10 +398,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
                bit = cfg - 1;
                event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
        } else if (rapl_pmus_scope == PERF_PMU_SCOPE_CORE) {
-               /* only look at RAPL core events */
-               if (event->attr.type != rapl_pmus_core->pmu.type)
-                       return -ENOENT;
-
                cfg = array_index_nospec((long)cfg, NR_RAPL_CORE_DOMAINS + 1);
                if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
                        return -EINVAL;

> 
> Thanks,
> 
> -Koichiro

