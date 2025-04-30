Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F87C1EEF9;
	Wed, 30 Apr 2025 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745994834; cv=fail; b=W5Y5zuEFLK1B72O1ZO3S46EQzcAfCW7xJ4nwbE5yvBnfpqqhVJkxtYHA8Lllt2YkStQnqVp5A9xyrph2Mq+9HhSPOCdyvnLGyzPr8XoZomuay2534+X6llrv7NPgMenuLVQQknd3qzzE0zhscsphSN/7bIwGfT8i4qRqT89MnLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745994834; c=relaxed/simple;
	bh=8x0a9cO972VLGGIFJXihBDxihAdVgnN4EBM5yeKmHJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MUm7VrvpfeBUgSifIoAEdtQ9ShUvnZZbB0C5rpxPqUH/T8CJeO4YhftgxCyVNjIWSddkW1PL6k2tp8UrOWbz+pQj+hOhfdZMW0CHIT4SUJCuaQK+gKlQi7UhaSWxOt8HPSs/RgN7iRrG7GOUsXuIHZ0Mq08+4vDHA5kJVMznu0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VPil0d3h; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VPil0d3h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNSrSdkyUrQMVrFWkbB52awpU7o2k9Szw2P8mANUCVB4yuf5K68g25fW7brpmYtUy8kgccV2ihQr1FHUDWV+zMcZjB9zP+p9o6nMJ/Drchn3VMjqADkBxOp29WjPzA9YhZ0sm9geg0tRwaCdhhd6a+QOjz/HTSVSrHJqcZSub8dtF/ne7qFihjSILvI+FVl5DOxz5BZ68L4QKTS5YA5XiUKZqu8KWPIMsCU1P85HXmH/kmZmqS+7EA7bG3TawyFjxaGTTEYCW1ROCU8vKfa0e/vut2FWBDQfMPZOR/otTZvybKYxlUMxy+F0ucmLGi6uoCrxiPONNfsdVaq3Mt9aPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UriQzMwN/gOp8aEeIslM49eNX70wkiES18tsMKu5n2Q=;
 b=t8UAlJfRk0Q8uG7HJoSSa4u5xGn227kKKh/W/1Vvyg9ZRc+g3hnluf13h39MaKZjHIxlzeyN5BF0FKoUva1VGfZ/mSoYESemgnoQx5gqz39a5BAeH1qN+4awmKjhMApkfGBDdL+EFbfXnwEL73ScUs1sziQ2eTucmqY68W9cEhuM21tj7DhvzMnV4mwcOZfMcsqrpbe/fdqdBtoAAaIZHGbepVwMjrELnUBSmPbA/2CaMsxOAdfePDNSPg3kE+6a6mypdom5z4LQc3+ruEUbE0M42SzJtmnCshd6w2DxqgC6b2qCtjhaB/fthBLRb5qBRSxdGDP7jwgp586/mihlxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UriQzMwN/gOp8aEeIslM49eNX70wkiES18tsMKu5n2Q=;
 b=VPil0d3h7ThSOHgzHaKHiQ2vwmUB+fNgQ94yfhbk9crn1UcXmeZm4AcSp38FNwWHIZh7QPUt1aBL/RRJhGg649yEn77SPRMupI+1T4ZpGGDxJiMuO2p2/wrU5Zm0cnu4apBPXIm14w7b43TVS9/lS7MH8JQ2F5r6sLtiGsP9iCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 06:33:50 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 06:33:50 +0000
Message-ID: <eeae0c3b-7f9d-4dfe-bf98-2c4f79f96187@amd.com>
Date: Wed, 30 Apr 2025 12:03:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] perf test amd ibs: Add sample period unit test
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Joe Mario <jmario@redhat.com>,
 Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Santosh Shukla <santosh.shukla@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das
 <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
 <20250429035938.1301-5-ravi.bangoria@amd.com> <aBE8raTOCVZLfw7J@x1>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <aBE8raTOCVZLfw7J@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0116.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 8554e63c-aa05-4b84-1c88-08dd87b0f7e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzVDRG5JT0ZPMGZIRVcrTTdvMHB2WWtSYjQya0lCTzBDYW51U3BvaUxKWGNm?=
 =?utf-8?B?ZDFrRElrdUtmQnF0cklqQWtDYVp2M0I3dzZCTENGSktHb0IxVEE4Sldwd1hM?=
 =?utf-8?B?YkhqMGp1T1VnWXVOcVNDNWRKOGdhcmJhMGNBZW9jcEwvTHJmMU84dmR0Vmti?=
 =?utf-8?B?VUxxK2JZcEtJRHJMbHNWNGZyb3hmZ0FuV0c2WitOdzlnUC9KWnhJQzl5bUxM?=
 =?utf-8?B?Qi9Wall2dnF1OHB6b01uNDNQMGRjUTFGT0pqZFp3RnFlRE9FOVgyOUVOSzV0?=
 =?utf-8?B?c1puaGdxVk9GMXQvbmhZNHFSYk53Rzk4cE1URUdPT1lqMzdGWm1YSy8vT0dT?=
 =?utf-8?B?S1UxL0ZuazhvaU1kTGQyTmxCNlhHeFRSdUhXblhhd003WEUyTzI5eHgrRnNQ?=
 =?utf-8?B?N3pHVDBlUDBVc3crbGIreXRCMzlQNldrOFpBMkNnSFdxUisxOUc5c0oxc1lG?=
 =?utf-8?B?SVNTSy95L1Z6YmdrYm0vSFQyNFJHcXdaajBqdzAzajZycm8xRjNSN1NRaEQ3?=
 =?utf-8?B?YzF0cDQ4RTFLYnN3Q0ZSdFdlM05qOERJZVFIZmlzV2ZKS051N3hWa0tLMWFi?=
 =?utf-8?B?R0VRSkdTUDNwVEx2MkQ1WFIrTjRuTThKYWx0VXRWU1BhcWN6L3FRQ2lNb0pV?=
 =?utf-8?B?TUN4Y0FXTUVyUUlDYnoxNmtrMHllM3p3WnEvb1JvQVphQmVTNlpUcGRFWk5h?=
 =?utf-8?B?N3h2cU1MVUdsQW5pSzFRcFI1RjgrK3BjUlZEL2NHZXlQM0ZBaUg4MEZ1UTJ5?=
 =?utf-8?B?c3FKYnhXOHcyblp6a0RpTkJDR0ErQ3R3Y2NqN3FIVmpmWmwxeU8weTVhclpE?=
 =?utf-8?B?cU0zeTZLK1hYQzJ2RFlGTVNTMGlEQnpoS0tkQWlmUGJPTklMMWs1WnpacFFI?=
 =?utf-8?B?WkpGOGxHNXhBMkl2a205eklFWnM5UGZrcUE4c2ozazZDN1AwcXpuMDZJYzVh?=
 =?utf-8?B?a2ROTUt6dXFWTXBJNUdmZVJOUm5GU014WWNJek1WWlZ5WndZQzkvMTlsNlEy?=
 =?utf-8?B?Nm10NmpWQVNiY3UrRmRHL2tONmdoYkt3T2tIM2pyN0RyUnk3M1pRbkU0WlFL?=
 =?utf-8?B?aFhYbmtmdmszR2c4bXRra0lVTjJWckV0OWxNem00dHlJNkkyL3ZUNVlGUWZ4?=
 =?utf-8?B?bmg5VU1yUnRhbXB0QmE1L2laZ1hQMEFFZ1FmYXNRc1NKQzFKK0JtTGxodXp3?=
 =?utf-8?B?NlRMZXNqS2ZNWGJQbjhWY2tpRmNsN25JRytBNTBzZEdqQitCNmxXZ0lXUjM5?=
 =?utf-8?B?UEEvUW1SaFhZV1gxOFJoQUVkZ2RoQjF1VWVkd1g2SW8wWjU5LzJ4UVp2Ym5n?=
 =?utf-8?B?SW5TTWJpY3Nvbm1BM3FNV256eTRIdVcwQkpidkdKazE5SXRQUGJBT2FHQmVr?=
 =?utf-8?B?L2MrU3J2aExtaUVYN1RiZ0RQM3dPQUU4d2djaHptZ2prOUVtUGxObDFMYjlY?=
 =?utf-8?B?Q1ZNcEZwc0phd1ltVnduMHBENWk3bWNTVzZPMklLVjg5RFZLMVQzZlcyNUZF?=
 =?utf-8?B?bEQzVCtleFprWG90Vnh6dlRnS0FGL2V3bTVjVk1va2UycktFM3Y4K2dmbUlu?=
 =?utf-8?B?aVlPeksveXdxSlFIK2sxUFZtNjIvUUFML2JaYnNySVVaa3lpdHFiYzRzQ0FR?=
 =?utf-8?B?MEJTZ2ljQXZQbUd1d0dWY3lWVHB1cmo2bERiT2twWUhNU1NxR3JXRnlvUEZX?=
 =?utf-8?B?VVYzcTlOdzhORlFHWktTbnhTa3Z1dXlRRzNmYzZWZEFGS1ZRYndmUDBIVndw?=
 =?utf-8?B?RlFWV096SmlZcFNNZm9Kbkp1Z0lWOGU2R2c4d0gvejVnQ2VtY2dMUVdBak0r?=
 =?utf-8?B?SmlHbXZLT1hUMjduVlRzMi9nUStuWUVtQ0NBbWlJY09xSDZ4ejM0S3JiUERG?=
 =?utf-8?B?UENZdE5GVk56OUdRQXU0S25BcFlhai9wSFZOQldVVUxJVnlZWmNpeEsrdzhD?=
 =?utf-8?Q?61DdOWnUcyo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU9YdWluemVHc2VucFFOL29VQjY5K0lOT20rU3NrNGIrajl1UUh2QWJIZWRo?=
 =?utf-8?B?aVpoVGU0Mm9udkhDMjU5d0lkdnNXU1F0dTZDY3QwMU5nMU5NbTdIY1liMXk2?=
 =?utf-8?B?bXRnOWRQcnExYmd4K2VyZHJuQUZld3dWYjNoL2N4ZTY5dEpHZ3RuMUhsS3VD?=
 =?utf-8?B?WURYNGZlNW01bmlaYkhkUTFmR1k4RTZLVWEva0cwSjhjbEVyNWNBdmZ6ZjYx?=
 =?utf-8?B?Z3FPUFQwcmMvVExzNTZMN2U0aGJ0L3Y3VlZSUC9PdmgvTHFPNUhQYi9HR1gw?=
 =?utf-8?B?L1VEd0pKbWZLc2d4Y3ZMdHlMNUVkcW4xdWZIQk1nbm1MTHpwT0l2Q2lIcU56?=
 =?utf-8?B?Wkd5T0dGOFhnbEE1OXpyWk5sY3Nka01keEVaVWJ4MDEzbWhwWFBRMWczeWk3?=
 =?utf-8?B?VnhLSDVIZExhdmwrNVJyd1N6aXJUYjRNR2hjZjVEVkNOYkczcVZDUlRweVpB?=
 =?utf-8?B?QzVWNnhiVDkycXBLSnFmOStPOFBxMHpoU3JBN01SeW16OTBjRkJtV3NYQk9o?=
 =?utf-8?B?bWRCcm8rZEptZWQ1TkRGQi9SaHFpSnhsTzJ3c29JR1duUmY2bkpTYVlOVFFP?=
 =?utf-8?B?QXBtRjErSmV5Wmt6U25GWXNEakJBVmF2RUR5V0tpUk1USG9mVDEwaTF3bDhy?=
 =?utf-8?B?VEJtbmxMM2YremFEL1V5elBxNExVSm03d0tMem55VDF0YXFKbzVJU3RYN1py?=
 =?utf-8?B?VWlPZFoxS3BGSzdrSnJOSHdMdVIrZzJvMFhkUUg4Wm9mMUtQanRsbmdYOWla?=
 =?utf-8?B?SjhhalBRUURxRi9MUHl0eTZ4K2txWWM0TnBuQVRGUmhleUpqSVVHRWFTdWd1?=
 =?utf-8?B?UjMybmYzZmI5RTVoQUc2b0hxMllOV21ydFUyQU5KWlNxcFZwemNJYXo2L28w?=
 =?utf-8?B?dzQ0N2t0YVErVHN5NUIzdkJDT3ZQWElualR5d21wUm54M0oxQjgvS2xFaGlL?=
 =?utf-8?B?cHlCakJqZzVsOTlBclN3Q2gzYm81dEdsNjNOTjZObkJvOFVXWkwrREdwS1NL?=
 =?utf-8?B?QU1BYnk3azFPdGRLWFFKNjJRSHl1dUxtMGYwY2dMS0l2MGxzTFRVeW5BMm53?=
 =?utf-8?B?YnRrY0txM2JvSU14bkRmN0RGa3VsU0ZTb3gzRUU4Sm9FMjI2MStIc2UxbDB6?=
 =?utf-8?B?VzZTbmpGRmZRZEpnVXRPMXJMV3kvcFNPMWFCWnc4Nm9QR2J2THV6bUhMK1lh?=
 =?utf-8?B?UFBVSXI3TEh1Y2tsZ1hVK3c5MUJjcCtTcjNwZnVYaElnbUNLdHRVVEh4aXNZ?=
 =?utf-8?B?ZE1naW9HRmh5dWVLSmFMNDdKV2I4OFh5aFpISjV0Q3l4SVNGczBsSnplZElH?=
 =?utf-8?B?bW9EWUZNZmpPZlA3bExxSHI4T0xzdmtoZ0ZXOWtmK0RvWTJuVXMvYzNZd3Bv?=
 =?utf-8?B?VGU1OTZhQXRUa1NVUVI2T2UxUllSbWtYa01xQ1F3ZExGR2VIbGkwWDRUNXRV?=
 =?utf-8?B?U3d2Z25EOEMyS1Fxd1pRK2k2NDNVOW8rb1JjVmxOWXQvY0dPYlppSVNHZHZ2?=
 =?utf-8?B?aTNiMWcyb0N1a0FtdGc1QW41MlVINEEvZGx3MVpGR2YxUzlSWXBZQlk5N1U1?=
 =?utf-8?B?YTV0cUozMHVTTnNOWkhnN0Y0aHc3czVJR1F1czYvY05UM3kzMnZGSU11RjUr?=
 =?utf-8?B?QWNVOEdDMXY1WmdtUDk5cVU2TjJndHVlTFQyVDNVUW1MY0RWWGZXMlBvUDBt?=
 =?utf-8?B?cWRBb0c0cWQzclJsOVZNcEtNeTJkY3JCVTJLK0lwYXBWVURXTTgrK1Z6bEV0?=
 =?utf-8?B?SjBESnAwcXUwbHpXVmNiQjNLTktUZmVpZHlzK0k0eEJkSWhEbldFUFMxSGc2?=
 =?utf-8?B?N1VYbDJjaW1JaEk2NEhjalZ1T2c4UTZ2Snp2NDExZExIVVdJOFlJSkhNUjR5?=
 =?utf-8?B?bWY2dk85RDhqMDBQWkMzL0duU3NFUUwyTUNncHJDd2pRLzRjaVZyZ0thbUZ3?=
 =?utf-8?B?M2FWNk5LazhUenUwc2VQZUhqUk5hOE8vNy9UUEY1NmNjc0o5NEpWL2YxRjBP?=
 =?utf-8?B?Y2VyRWZOTi85R1Y4TWhoRThHcDRIcFFoT2l6N0pTVzBTdTc0QUNPendrNHVp?=
 =?utf-8?B?cWtWRTZHSE1Gd1o5ZVl5Zld1SWVacGVRTXlWckhocXZFWFBwWHNycHNRR21B?=
 =?utf-8?Q?YN+i3nH3QwGxY7TAZ5ydW8+J9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8554e63c-aa05-4b84-1c88-08dd87b0f7e7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 06:33:50.3257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ve2DS7LUOnG8Zv38hSsIkhpzDCwzF1cSX+FxEObweX09ofu5TmI+9MNegrj0wqUWQOF3neeD0qeiK3Ny6qkViw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139

On 30-Apr-25 2:25 AM, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 29, 2025 at 03:59:38AM +0000, Ravi Bangoria wrote:
>> IBS Fetch and IBS Op PMUs has various constraints on supported sample
>> periods. Add perf unit tests to test those.
>>
>> Running it in parallel with other tests causes intermittent failures.
>> Mark it exclusive to force it to run sequentially. Sample output on a
>> Zen5 machine:
> 
> I've applied the series and will test it now, but found some problems
> when building in some non-glibc systems, namely the use of PAGE_SIZE,
> that is used in libc headers, even in glibc, its just that in glibc we
> happen not to include that header where PAGE_SIZE gets redefined:
> 
> ⬢ [acme@toolbx perf-tools-next]$ grep PAGE_SIZE /usr/include/sys/*.h
> /usr/include/sys/user.h:#define PAGE_SIZE		(1UL << PAGE_SHIFT)
> /usr/include/sys/user.h:#define PAGE_MASK		(~(PAGE_SIZE-1))
> /usr/include/sys/user.h:#define NBPG			PAGE_SIZE
> ⬢ [acme@toolbx perf-tools-next]$
> 
> So I folded the following patch, see if it is acceptable and please ack.

Thanks for the fix Arnaldo. It LGTM.

Ravi
