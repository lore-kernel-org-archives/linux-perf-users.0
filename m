Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A76030F80B;
	Mon,  8 Dec 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765197772; cv=fail; b=sXK1EKbA2dZGkyIKi8Esz2wxaIJt5nfM46q1P0ZfAeHRoHpZiOWY6EF5VQt2ilCuMqqgxNaz9cEfjotGt3pSWMBwMk97MXc2BqC6yKkQuIzNJDmDF4WxmFV6ZDcAKVsvgvVymifwkk7/Dkdh8joud69oj3paKLTGGozQfz7X3hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765197772; c=relaxed/simple;
	bh=lrPfI4DTbFbz9BhdlJQ+D8Fw3JbXSsPw/nkfEx0q1dk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SrbtUMv3LB1ghpRsATsfzripotQCJUU5WkTIdak12AMtQn9dm6VQYK0qD3JN2EtRImrMwUVjRNNvrZHvcSrXIJ8lU5372a2hiwEMRkldy0DnSNiGD9E4FusYU95EJSULxw/nVVJH9o5MVnA+P0VxA1fzV/HZaCgnUP0OWs//Wso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WE4/Uyhj; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WE4/Uyhj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZRV6IEe5S6R3ETqc2L8NWzcxv4amYrCjLJxIdbuLEdB1qkJOl1Et8RXeMdZenP2Lzpi8iJHkbaJT0zEZ9caV2ih21ZLqvQ5EnH1aw7rP0qiv4q+itu1+7aQubhOR3zCJLwO93wbQXpMmlYNpyH4gSYjeBczirp05DpdZkOjos0+tDhwsbSXu5JtojYVHdwgvZWMfTmuGmo/p9va8Cy3k2d0qEqpXVDB4O7hPpdU+Okxh9Gw/McnWqgk7SnNWcJJksph6+gkI/+ONleW4iHQJhQ7ctNuWpbS63BDvGguiacG1tFoCLnGriwgQ1cvnGmBqkvBFGFuDh3YPI+UvONKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJqP+IvtN8fCab3dXXYGrgBSbHjmeY+0Vc09Aj1zzeY=;
 b=xdVU4d5cx0T7JkgR0yjIfT+toH4g3zsq1+hmP5sG7SdGSnvgWXzwJd8Bm6IZ6f0x3bJiUg0UDowimjqJADSLqg/6z9PHc5+c4eu1S0keBzf/9sp70OcIsgzWsIdnvmD7x5gWmjHzHl2DsGRe+2m+/zDExOl6NJf22+gfrrFE1M8oy3Ty7pPn9+LAMsZLqYZK2Kbwjk7sSJXw8mkDhXnFkjwCJlZqZaI/uX1YHyRs533hhVfGWPRIPpQJIr7H9do1jKXBMW2HLdKwJRp18NepCG8rfl5d5Az2Zsn9V5PoEnxtKmjGdUPBw82GYYFWHFOk4yDF0GYMwE82D1B4owXEGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJqP+IvtN8fCab3dXXYGrgBSbHjmeY+0Vc09Aj1zzeY=;
 b=WE4/UyhjCsGn/2BcnUR65xGBfysB/r0O5GsIRP5sWO8U3xW5LpMWhVv4x9urCnPQoxw5h1yuAE7lE1CAgD5YGTNw2F0EmC8dRsi1T1GwNE5MXPiAtuDJpgTdznbN4q9VP1K5v7NInf7ZVy7Mfg2tCtRv2X6jfL+RbimDYfGvrKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 12:42:47 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 12:42:46 +0000
Message-ID: <93e25001-a175-4ef6-8456-3cc45e53d3ff@amd.com>
Date: Mon, 8 Dec 2025 18:12:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 18/48] perf jevents: Add br metric group for branch
 statistics on AMD
To: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Benjamin Gray <bgray@linux.ibm.com>, Caleb Biggers
 <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>,
 Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Jiri Olsa <jolsa@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Samantha Alt
 <samantha.alt@intel.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20251202175043.623597-1-irogers@google.com>
 <20251202175043.623597-19-irogers@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20251202175043.623597-19-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::16) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: e78f2def-6068-48c0-0bbe-08de365749af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1k1MzVFNTFVZFNZNm5GQWNjMGd2Zlk2RWxWQm42RGREM2phTUM1OFhiZFpH?=
 =?utf-8?B?bnlYczVXUmhmL0IxQndzRW50WXNnYVE3UFk5Z3J3dHZxYnIzNzJ0am5MM0dm?=
 =?utf-8?B?VEhwUVAvUW1tYjBSVVhabUIrUk5CMVJMaEczRlFTTzNyenZjTm1iTnJoVWhO?=
 =?utf-8?B?UXNhTHhDT1B0TE1Nb0pIOVJqa1RnSmdCejBrT0tLRGpselQvejJCMFg1YXJp?=
 =?utf-8?B?YWZMY2V1NkxCaVBMa2lDbi9NeTZYSzh0UWt6TWxrQkoyWnhUdnZIaU1IcUZm?=
 =?utf-8?B?VjM2cjVGOE1nR0d1MGMvSitUbWh5ekxBMkF3eTE2TmljaGVna0RXUjJUMVNn?=
 =?utf-8?B?eEJFQUYxaEFjSU9iQjdQdkEvY1ZUdWJTeEE0T0htOERqb3EzbVlHeEtTUFZV?=
 =?utf-8?B?UUVnNG14N3Z3SEgzSnJXUlR5NFBHUG1IRXpCc2J4SUQ4RHozaDBkeTM0ZnlT?=
 =?utf-8?B?aGlodjN2ZUc1eW9SVnJmZkZXelhablBtOTNDd3JwTm0vMDkvMzFBNGYxU2Zy?=
 =?utf-8?B?bXlWZUl4czJiTUJobVZEczNwNWNBNExNL3JaU2tzWkpzS28xUGdpMWpOTmpE?=
 =?utf-8?B?YWRRQXJFSmtLZFpNZTVkN28wTnR5bm13ZmlBaklDN09NdEtaYVR1TG1rMmlS?=
 =?utf-8?B?TGlidStTMTMyUkptYzZub09GRVBkSEdVakl0M1BXK2dSTm9hSlN6dVhSaktB?=
 =?utf-8?B?VXo1bjBCTThwR1FSbURoWTJEQUxiV2cxbmtubHZTeDNOS1pPSVJ4SFJ2VlZm?=
 =?utf-8?B?S3FqNENPQlRRdDlNaG1KenMxa1VRcHlJOEQ0NkFXRHVGSXZkK3BmWjZQR3RN?=
 =?utf-8?B?VmgvUmoxZFNENlltSWJqZ2FTVE5QKzFSZDJSTzdoZGVNQnArd3VvNUIrVklN?=
 =?utf-8?B?T3hYbDhOS1Z4TmtnM2dyalJpUGRPdGZGV1NINmpDaFNMUmx4SEpWY01LbExn?=
 =?utf-8?B?N1JXdCtPR2orNEp3dkhXZ0lUMS9ueUlvOXZpMDlEam81dlRMbkxBVWlZdmlx?=
 =?utf-8?B?VWZnbVJDVStKY1V4bkNocXByL3V2Y3VDUnhIRi94bU84eU5YdFoyaFY4YThT?=
 =?utf-8?B?bmx1MFloR3ZNK2toN1g4dHMrVWZNMVZWdEpkc2tLRjlINEZiSUsvMFZkcHdK?=
 =?utf-8?B?ZzBsdGtxdWhXRVJyKzJqbmp4U2RWSm5zYXlFUktlWUprYks1WlVyZUptenhk?=
 =?utf-8?B?cHo3clRHaFk0RjN3aVdUVDlzdlZPLzg5UUZ6WE1MUnVpblBYVElzVWVwTlVC?=
 =?utf-8?B?Skw1YWZDNkw3VHNwblp6TSsrZUgvdjFXbHFSS3UxTGphb3dYQWpMaTJaWGNE?=
 =?utf-8?B?S1JwNnk3c1NZYmZoWHNDRVdGWlpadGl4V2VvYmx6bGVTN3RQVytUYVVGYVcy?=
 =?utf-8?B?YzNPNmJrS1BGcFU1S1NTTEFTUmVMemVVMGR0QmxUdjdsZVJxK1pNOHhpY3RD?=
 =?utf-8?B?cC9xZW9lZEhJWTN2R1FuTmhXTXo2MEVzaTdpbEJsdVZOd01TTVhodWxQOUpR?=
 =?utf-8?B?Q1ZYTHJoR2E0dlNPbjd3MWExalFDUWRub3RBbFIxNlEzd0o3TThqdjZsWGY5?=
 =?utf-8?B?Mk9TSzIyRmU3aWs3bVJiN1J6dDJDTmRKOXZPL3QzMkhFelNBUm9scjI0azVn?=
 =?utf-8?B?T3pVYzVhL2NDUU1sQkF1cjlZdWE1V0J4NHFyZk0xRzFSazVWenMwQnZFb0Fj?=
 =?utf-8?B?ZmpxMjZXT2xBRTI2ZWxTV1FhREJ0Vk5NeCtsZENaNURSK2tiR2xWek9OWTZV?=
 =?utf-8?B?U2Vyc2IxUFRPOGxvWTEyQjlEWXpmb0R0OWdsc0RKbXRrajBUUGJNdXcrSWRD?=
 =?utf-8?B?V3hIVmlubmE1YW1yVFNqYU5xUXhvZ2xOWmpDUjgzUzNYTDQ1a1BIMXRLNVAw?=
 =?utf-8?B?bFRleWhlMEM3TVhwb1FjVkEvTVlkVXlNSDNsUElQYWkwcVB6eXJaTTZBM1Zo?=
 =?utf-8?B?b0o2RlRldWljZWdkakpDaWNCazMrZ2kxakFXMDBLQUcxZEhNMmE2Z1BLdlJj?=
 =?utf-8?Q?c+bdSnGBt48tav4BikLi/Lg4W/puwY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlA1cW1WYkhtS1Y0UGdwaUc5aXpleTZhRGYzQXRYclZnZ0JlbmRnZkd2dTZC?=
 =?utf-8?B?cTg4cHRiblJIL3BtTExXZDJmeWZkQUtUWFBGTlRxdnpESStxY0RMb0tEa1px?=
 =?utf-8?B?RENFRHNGSmNVUVo2YXFrcUhDM3J2SHpHZ2ZSMWxzU29tR2syOEx5cGNaTkdn?=
 =?utf-8?B?YXVIM2VoUEZyQUk2VEZ2MnhCQ0sremF0KzNHVzN2Mk1qem9mZ1pLUHNqa3Nr?=
 =?utf-8?B?bGRWc1A3UFlNV3BqL0IzK3R3c3dXYUJ0cktabnFsVlVnaXYxbTlhb2w3eE1T?=
 =?utf-8?B?K1g5N20wZHRQbkpNOTBvaDg5TFJWZTV4dUtxUTRhNWZTczBmRjcxVTVYR1Ja?=
 =?utf-8?B?bUFhT0lWT3lmK1dSdTZTbjJBN20wbVBILzREZHFNYkFKeFhVZTh1MitVRE1a?=
 =?utf-8?B?azlCUFhNYVdYcjhmY2Z0aFU5M3VnQ1Fsd25zbzkrWnFGME5aVWdUQlNWVFY3?=
 =?utf-8?B?cWQ1V0ErWmdlSVZmZnNaOHJGTkpZdHBMVXBXZE9tSGpUVXlVYm9aUFoyYjlr?=
 =?utf-8?B?LzZDS3Q4NjR6WU01cmxrZUIvZGxtVWZpTm9MdmJJSWZmaUVNSWRjaEQ1YitO?=
 =?utf-8?B?S1d5dGZQWjNnNDI1NG9MSDVTdkdzZVZjUFQvTzc5MXZXMG91Skd2T0pBQjMv?=
 =?utf-8?B?V2JnZnc4cEZGemgzRWdNRG1uUXZpV08rZ0tQbVBibCtVWVlGT2N1ZURFLzE2?=
 =?utf-8?B?Wm9lV29uRENOeGlMNW80blpvVzdBNVVjZHpJUFhNUTNvZkhWaU9xNWpnS1Zy?=
 =?utf-8?B?Wko2TDNkQ2hweDBjUDBJbTFHUWFlRXQ2cmdZWndJaVd5Wk9ZMFZHd2FpaU81?=
 =?utf-8?B?YXZBN3BIMGdWaFVGRENDSGYzZFZWQ3cyUkxZSlhmU3ZOeStKblU3ZEVZYWxp?=
 =?utf-8?B?L0hISU9WUEdzTzZtdnZYVlVGZURiZGkvQXBqeU9FQUVpK0doczFnZDlmblU5?=
 =?utf-8?B?amhYTFVjSk1weEZ1LzY0c0l0STZuTzBOR3ZrY1V5VGI1REpSQVAxQlFZYlNm?=
 =?utf-8?B?VU43YUxyQWVtMDBMdkNzZklWR0Rjbk1OZCtEbVk4ODIxZjRxZStsQXplMlBw?=
 =?utf-8?B?ZDNWeGdYcHp1bkVCM0J6WVNuV21QRHI0a3RMMW54NzdUeENTTmJxVTRlL3Y4?=
 =?utf-8?B?eDZGVUdPaXQ4R0k1Vm1jUTN4RnBWMHlYREhYcXJDN0NMUUgzeHByRjd1bVBR?=
 =?utf-8?B?ZjQwVEttdW82b3VoSlRkT2xuaUhhbmF1UEpvcEhOekdDUWxKYnpsMnBZS09I?=
 =?utf-8?B?NlZPNUk2SE1DQUx0TXNBeUYxejhrR29SUlFIaXdtWU51N3N0cEZzS0ZlYWF0?=
 =?utf-8?B?MGRTa2VPeFUxNEszNnJpR25SdjFUVmZEY1pacGFjdjlaMGlKNk43ZHhzSWFY?=
 =?utf-8?B?ZUVyemkzdkxGNDFvTXRsRjRzM2VqSTJNY1ZaNHJPMzVZU1Q0Q3dheGR1Y3FV?=
 =?utf-8?B?UjloTTVrZ3RNMythUG8wSWZHbDliaHpsTDhkSDZyYVVWNzNSQ2diVWJmT1hm?=
 =?utf-8?B?dG1vSStJZ3lVQStkUDhCMEx4WDlLSmxFeUFHVVVFbzNlV1NCVkRzVG1jRjhX?=
 =?utf-8?B?Q0kveWNXT0pTU3JEWWlzbVNJcW1xYkYzSkRiYkx3bzJpWmUvL1VWVGExdlQ4?=
 =?utf-8?B?bldiQ014d0pBMW1yT3JLSlVMb0NxaWovc0JXdU1CVGRjbmlMRXZrVytaZjJr?=
 =?utf-8?B?UVpTWklqR25PU1J1N2o1VW9lUlI4YzdYVklyKy9YZTBhcVA5TS82VmxmN2g5?=
 =?utf-8?B?Vm51M2dYbXpWZ25XMEwvVlkvUU9LemZISnpreHFmYkk3ZTlvTFZ1VGhPWS96?=
 =?utf-8?B?cVA4WWZwM1MwdnFQRDR0ZXIrMS81cjFRS0VYUWhTNVpYeTRQRkNUeCtkNFdv?=
 =?utf-8?B?UGc3VFVaekRTeEV6WTdibUZEdUZ4bTJoQW1HR01kdzZEOTNiRnQwRERlTWZF?=
 =?utf-8?B?eTVKNUJPb0Y4MG5WWUpWS3pMZDBYWEhvL3g0YXdsdzJNV0FMWk1DcXh6enRr?=
 =?utf-8?B?RTg2OUQ4YzdhWXJZUE10NUtzNmpDS0NneE5kb1ljd3VsUVR5NGZudkxBdm9z?=
 =?utf-8?B?SkxMTjZtR3A3WWxlMCtwRmREQVNvTlIzeFJETktQYmt3cDVYYWREWHAwaGVH?=
 =?utf-8?Q?1t5ZtxjblkXtEf9wh2TBptc6R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78f2def-6068-48c0-0bbe-08de365749af
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 12:42:46.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EfRT58xh0EubfBWdOAtr+dT+RgWoRx2MJGJLdOfRaotF/Jz9wsrXiIjSFfiyOw7s36woRVu1dzANNEurkI1eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783

On 12/2/2025 11:20 PM, Ian Rogers wrote:
> The br metric group for branches itself comprises metric groups for
> total, taken, conditional, fused and far metric groups using json
> events. The lack of conditional events on anything but zen2 means this
> category is lacking on zen1, zen3 and zen4.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  tools/perf/pmu-events/amd_metrics.py | 104 +++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> index 42e46b33334d..1880ccf9c6fc 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -18,6 +18,109 @@ cycles = Event("cycles")
>  smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
>  
>  
> +def AmdBr():
> +    def Total() -> MetricGroup:
> +        br = Event("ex_ret_brn")
> +        br_m_all = Event("ex_ret_brn_misp")
> +        br_clr = Event("ex_ret_msprd_brnch_instr_dir_msmtch",
> +                       "ex_ret_brn_resync")

PMCx1C7, used by ex_ret_msprd_brnch_instr_dir_msmtch, and PMCx0C7, used by ex_ret_brn_resync,
are not equivalent. I have been told that the now deprecated PMCx0C7 was meant to count
pipeline restarts for reasons other than branch misprediction. Is the intention here to count
such restarts or just the ones caused by branch misprediction or both?

> +
> +        br_r = d_ratio(br, interval_sec)
> +        ins_r = d_ratio(ins, br)
> +        misp_r = d_ratio(br_m_all, br)
> +        clr_r = d_ratio(br_clr, interval_sec)
> +
> +        return MetricGroup("lpm_br_total", [
> +            Metric("lpm_br_total_retired",
> +                   "The number of branch instructions retired per second.", br_r,
> +                   "insn/s"),
> +            Metric(
> +                "lpm_br_total_mispred",
> +                "The number of branch instructions retired, of any type, that were "
> +                "not correctly predicted as a percentage of all branch instrucions.",
> +                misp_r, "100%"),
> +            Metric("lpm_br_total_insn_between_branches",
> +                   "The number of instructions divided by the number of branches.",
> +                   ins_r, "insn"),
> +            Metric("lpm_br_total_insn_fe_resteers",
> +                   "The number of resync branches per second.", clr_r, "req/s")
> +        ])
> +
> +    def Taken() -> MetricGroup:
> +        br = Event("ex_ret_brn_tkn")
> +        br_m_tk = Event("ex_ret_brn_tkn_misp")
> +        br_r = d_ratio(br, interval_sec)
> +        ins_r = d_ratio(ins, br)
> +        misp_r = d_ratio(br_m_tk, br)
> +        return MetricGroup("lpm_br_taken", [
> +            Metric("lpm_br_taken_retired",
> +                   "The number of taken branches that were retired per second.",
> +                   br_r, "insn/s"),
> +            Metric(
> +                "lpm_br_taken_mispred",
> +                "The number of retired taken branch instructions that were "
> +                "mispredicted as a percentage of all taken branches.", misp_r,
> +                "100%"),
> +            Metric(
> +                "lpm_br_taken_insn_between_branches",
> +                "The number of instructions divided by the number of taken branches.",
> +                ins_r, "insn"),
> +        ])
> +
> +    def Conditional() -> Optional[MetricGroup]:
> +        global _zen_model
> +        br = Event("ex_ret_cond")
> +        br_r = d_ratio(br, interval_sec)
> +        ins_r = d_ratio(ins, br)
> +
> +        metrics = [
> +            Metric("lpm_br_cond_retired", "Retired conditional branch instructions.",
> +                   br_r, "insn/s"),
> +            Metric("lpm_br_cond_insn_between_branches",
> +                   "The number of instructions divided by the number of conditional "
> +                   "branches.", ins_r, "insn"),
> +        ]
> +        if _zen_model == 2:
> +            br_m_cond = Event("ex_ret_cond_misp")
> +            misp_r = d_ratio(br_m_cond, br)
> +            metrics += [
> +                Metric("lpm_br_cond_mispred",
> +                       "Retired conditional branch instructions mispredicted as a "
> +                       "percentage of all conditional branches.", misp_r, "100%"),
> +            ]
> +
> +        return MetricGroup("lpm_br_cond", metrics)
> +
> +    def Fused() -> MetricGroup:
> +        br = Event("ex_ret_fused_instr", "ex_ret_fus_brnch_inst")
> +        br_r = d_ratio(br, interval_sec)
> +        ins_r = d_ratio(ins, br)
> +        return MetricGroup("lpm_br_cond", [
> +            Metric("lpm_br_fused_retired",
> +                   "Retired fused branch instructions per second.", br_r, "insn/s"),
> +            Metric(
> +                "lpm_br_fused_insn_between_branches",
> +                "The number of instructions divided by the number of fused "
> +                "branches.", ins_r, "insn"),
> +        ])
> +
> +    def Far() -> MetricGroup:
> +        br = Event("ex_ret_brn_far")
> +        br_r = d_ratio(br, interval_sec)
> +        ins_r = d_ratio(ins, br)
> +        return MetricGroup("lpm_br_far", [
> +            Metric("lpm_br_far_retired", "Retired far control transfers per second.",
> +                   br_r, "insn/s"),
> +            Metric(
> +                "lpm_br_far_insn_between_branches",
> +                "The number of instructions divided by the number of far branches.",
> +                ins_r, "insn"),
> +        ])
> +
> +    return MetricGroup("lpm_br", [Total(), Taken(), Conditional(), Fused(), Far()],
> +                       description="breakdown of retired branch instructions")
> +
> +
>  def AmdUpc() -> Metric:
>      ops = Event("ex_ret_ops", "ex_ret_cops")
>      upc = d_ratio(ops, smt_cycles)
> @@ -83,6 +186,7 @@ def main() -> None:
>      _zen_model = int(_args.model[6:])
>  
>      all_metrics = MetricGroup("", [
> +        AmdBr(),
>          AmdUpc(),
>          Idle(),
>          Rapl(),

