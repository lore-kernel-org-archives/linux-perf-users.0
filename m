Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021119.outbound.protection.outlook.com [52.101.57.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D18C139578
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880390; cv=fail; b=A7mfn9PGB4j+0+KIiM7CFq8axSeDurHN7z7cbrMB4BuOmJeWaoIuRfiuBzaMJDoJvNI4Pwv8ZjjcTxDu/l7Wl1O8xj0U8jMWfntrTaF5fCgxy37SCBMgXtneki96JhOy7qkcPI1+fgpYT3HRgRiaglHJ/FRqOp1nfNcL7h7Ls7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880390; c=relaxed/simple;
	bh=k2aZJVUCIJHe+8jz3ItsN1m9+0Sl1q62JKy0L7coIVc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A52trkVzSIzsWNg9SiWNUVBws4XW+RYNa9DDYUSOjTFup3IpIY+0u6gjzHuuYm6G26556+uk1Oe8l0zpwTBdrqyCoVa8v3HlutrYLo9RA+T9fb80JarFIK67gXye6r+zomCCeqA8sQFI95aJfkIcvvTDT3XYuq/tWQF0Z/HZUaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=SjErVWVq; arc=fail smtp.client-ip=52.101.57.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="SjErVWVq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UElcSTp1dbK4dW//aMQ9ldBKx+r5D2UBhUnbwVsdSD+Ulyvf8Ueb7O+0wFBR6A0HgFORONkXZVBb/61DxBioybBkrUTnzosJmxKIGGsFvhtCniX7izWosJdN1VtGBowpnkU1ty5EdZ2yvwjnjjEJYAadsNM7wFPvQ6xOMCXkCqmntPWdwhb5p2jDYxQQ0TK4GgMA03GsaXKc0oLkChxvGxz3KwHfatV4quDdrZMeKFz20rn5ROCqZPaZ9ZHp3DZ6Msrn7D9LpDLQSx01Ib8VUaLwU6A3r7X9L9XrWxmBTlefmeYs2QzHivbK1tza1ic4ZtzF5HR7jG15Aqi13osz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WRPYX7MaViwK2WmILpsnT7whw57MzDGF4DSLL1vJ/o=;
 b=jPeLmhRYVQgJA48fkYIbXIYHhKlEZ+tnQsKZZjHHFUG72cgkxWA9yNDOpalL0+PSCO/2qXl/Csf0Prgda6SuWKIiItcMugvMa0H/gUx++AyxBUbTe6cNwq28i9CLX4dVgm6hGztXdseGJ2aJfgQYhr1hHKNFTglV8hL2m9UincoV2JGcXQsNy3mKNZ8RYaAlO4jyLHebUrj6rhE8gDV5J0svn/NuyODc2l+O4EoYDxSo24e9sCrEs7ybtmU8VNA+NuELUdoDxosZbZ9UfIrlsamW04veLd/RlmZOC2YyAKRH/npwwtGYHhywTXOc6bCmEgq0oeMr38n3VpWwWzMkYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WRPYX7MaViwK2WmILpsnT7whw57MzDGF4DSLL1vJ/o=;
 b=SjErVWVq52xfLDRuJYCp10N/c8/Kj1VVgB4Qg4yPwj0CGBKqFxahv6dSZokvrGvaHiJv7RCeynuhAV8GwX0pfGH5oVbfTQa6olqG6FjPV0+wKajQRIrmv79PXFkbNNGRjDQuzjr++iInPcrWXX1X7yHnz/EhRBNLXokrkEknQXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 BL3PR01MB6868.prod.exchangelabs.com (2603:10b6:208:353::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Wed, 28 Aug 2024 21:26:25 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 21:26:24 +0000
Message-ID: <9dd13ded-4030-410a-b214-523108653274@os.amperecomputing.com>
Date: Wed, 28 Aug 2024 14:26:21 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V4 3/4] Add map pgoff to python dictionary based on
 MAPPING_TYPE
To: Leo Yan <leo.yan@arm.com>, james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
 <04a8a735c1a3794c64f1687fc8963d5713807b95.1724820993.git.scclevenger@os.amperecomputing.com>
 <cfd4455b-9583-45dc-a723-ef67e0fc3457@arm.com>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <cfd4455b-9583-45dc-a723-ef67e0fc3457@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0161.namprd05.prod.outlook.com
 (2603:10b6:a03:339::16) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|BL3PR01MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4faa92-27eb-4c87-e5e5-08dcc7a811ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djBGYUJEWWU2QWUvcHdqdXZzSlRKN3dzY0xteDN6YnBHVEdjdnNNc2Z5MFVw?=
 =?utf-8?B?STd2bVMzbEZSYUdQMXlaQmp2dnM4d0NlYklNMzB2L0I0aHlVbVVNTm5Ub3Bo?=
 =?utf-8?B?R3NyTFl4KzVUazZyYmJ2Si9vc2Rqb00rWGFpdmo5bCtqZW9PWUNKZmtKczg1?=
 =?utf-8?B?eWtNbFRVNGJDNGZBWTFHcWMzNnk0aXRJQ2JudVdsYlR6YTRoWXI4cCs1b1p0?=
 =?utf-8?B?dVQ2OW1ZTGZDMi9QaU5sbnJaTllGMzhiQUtKTXNCUE5JTXNiUCswRGVmNmpY?=
 =?utf-8?B?RGZOblJaZ0dpbnFYTDRjS01VY0pRRUZqdEVVMzJrVGVyVVlhcDZRUzZWR2Vq?=
 =?utf-8?B?Rk5ycDhLT2dDbkY1THRidjRGR3lVdm9pZmN2bitpTmU2MFRnaStEZ0k0Z0Vi?=
 =?utf-8?B?VHIxai91Q0RZSy9qZXcva09JWStUZ0ZSclpXc3VLbElLT25lSkRNbkUrenZy?=
 =?utf-8?B?U3RzZFpzejZmcXNyWGsyajVLc3hnbnFyZTc2MmhFblhabGh3amQvNGVSMW1p?=
 =?utf-8?B?ODZhRlc2SklNMzBiNm9ya0ZjWDBFNVdER29ZZFZaQ1RsMEIvOVowajNQekJM?=
 =?utf-8?B?WnlnSWd5dzBlWkJpTmdhZ1FuUkd0b09oNXRSWEtPdVlxSFJFbEZyeC9sbnZO?=
 =?utf-8?B?Q1dpMHBGWEMrRHRmTWt5RlZtNkhnckU0Qmp4ODJvVDhIZFF1cy9GU3BQQTlT?=
 =?utf-8?B?aC9pbXdEcnZ5Y2RZanVzSTh3RHBHQ1M1UEFYSkw4N21VN2dUV3BZR3JsOFlv?=
 =?utf-8?B?dEp4TVdLQ0tNZEIyTVFpY0YxTWJGU1p0aGhqZmY1M3hKYkNYYXhINzd5RXNF?=
 =?utf-8?B?RVJSb2U4NGZWRjQzQXJvb0dwUlc2c29yamxlSXZWMWwvOUVtR1VwUnIyelQ4?=
 =?utf-8?B?b0lPMENXZkpnMTRvaFliVTU2SHhoTmU5R1dPeVgrMnVUNEpqZlNTUUdPMTA3?=
 =?utf-8?B?alNCZkI5b0VCUUZrM3E3TThRaFQzaG9GQ2hSZG9jZmpvMU9iQ3ByRFVRalU3?=
 =?utf-8?B?L1QwYWdHR1hCZ3ZFcWYwcXNnR1ZXc2tJOUw0L2d6YVZDdzRvRnJLMllMVkVh?=
 =?utf-8?B?TkpXaEtPQ09tSlJHNE0vZVhtSUVSUmExRFdFb0ZpZUVyZTNkTDQ1Umh0L0VF?=
 =?utf-8?B?WHV6SGtadjJZNnVwdk1PYXhieDFvbXZ2Q3ZraGZtZWdsNUFucE5mQjl0cjcw?=
 =?utf-8?B?MVFXR21MbTFMbDdWRVhyQlJ4STRaTHp5STBnUlkzRWFQdHBEckN0NjZuSGhO?=
 =?utf-8?B?eml5TFJzWnBOcW1nSE80QXhtSTd3ZFY2SXA1a0dWVUVpNW0vRnZoU3Q3NGZH?=
 =?utf-8?B?T1FvWW1Celh1Y1NYSkdzUU9SMWNRc09hdVV5b2NZSEpHeTNPQVpmaGJXeC9q?=
 =?utf-8?B?OFp1Ym95djJnMy90VkZCblJRdEdvdE5mQlltN2lQWGtJL0doNEFHOEpGOWlZ?=
 =?utf-8?B?enFLc1pZYXdBeWlzZkNKOVQvaUdrSVV5b2NsdVM0YUxkRVQwMjdVUDVKcEhy?=
 =?utf-8?B?dzRYYU1Tbks5d3BEbTh1L0FaT0JZZ2hMZG1lZTVuSXlyUFozOTdyVnJYejBU?=
 =?utf-8?B?NHV1ZDlSOVlrVzRHMzkzZ2tUb3djNGZ3RlVjQ2owZ0dhM3hoRUlUVGRTTVh1?=
 =?utf-8?B?NUVUeUs2TityUHRNa2tKREJNcUxTb3YrZ2pQSTRpVmFHOUZqSnJGdWVuYUxS?=
 =?utf-8?B?cnB5aTcwZGs0NWlKeHdReHByNXJaM2NVN1VLTWRaR3duYmRNVjdoUHovZ0lt?=
 =?utf-8?B?Vmp1WEZxMjhYL2VCSUNOUUI5VnBjamJQWnpSMlkvWENkaFZNZlBVY1hyNWlh?=
 =?utf-8?B?TEIyNVhMNWM5NGhsUFlEZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2lWdklrUHZvOWUxeVZ4bDBVV2xRbXRFWkVBOTlSY0NraFVwREF0WWhKVlI4?=
 =?utf-8?B?TVdVSy9lRU1uMkltRi9wN0N4ZjkyUXBnRnZ1YnljSDVTbVFxWnREL1ljNlA0?=
 =?utf-8?B?N0JvYUFKdU9FRlhuV0djK2hTbGJvc2t6ME9hVmVXcncxSXFyYUlhZnlnLy83?=
 =?utf-8?B?RHFWVkdMeElSVGJkRFBCUjA5OXd3bEpaVWlOaUpSalRVUDlUNWFTV2RUcDFL?=
 =?utf-8?B?dVoydUM5dXk3a3JlQW5rZUplU2hjSG9CQ1dET2YybEdmNXR2eCttR3hrN1gv?=
 =?utf-8?B?ckJKdFVRNlE5Y1l2bFk5YStEMEhWbmJaVlZDU3Bob2l1VldEcThyWE9IY2dl?=
 =?utf-8?B?QmRTMXl5QXU0cDB2ZVUxc2xvNkhJVWtsbFVlSzlHdlA0ekRXLzU4TjRYQ2lm?=
 =?utf-8?B?WkZBOGxnQlBoenZHUm82cm5RUXpOVXdsRU1jZ1dKa0E2Q3hkWlltR1JqSGxq?=
 =?utf-8?B?VnZZdmJPMXc4K21zZXZuMzJ2dFlLdWV6M0J2c0phUmRmbDM4c2ZZR0R0UlFR?=
 =?utf-8?B?ZG9iQ25ieE5ScTVmdHc3TzVyMUM3Tlh3VnVMS0pFSFRZT2ZRUFlXUHhBMXVx?=
 =?utf-8?B?RkQzMk9IUi9kL01tcXR5OXd0YUxjQ3RPazFEUVNlMjQ2K3R5TmZxQWJGMHFj?=
 =?utf-8?B?K2tmK3dTeGViY1lYREV6QUJBYUlpS083eGpaM1BDaXpJOG5qdC9yc3g3Unpi?=
 =?utf-8?B?c1N3ejZqK1BmbGlUU3FoNHA0MGRqTDRrcUpmaGVrOVc2VHc1QVN2MHJJU3VV?=
 =?utf-8?B?TkhERlpaeUM4VTBNb1hCUjF0OWhtUmlNcFozdlRQR1RlR3BmemM4YktSU3Bx?=
 =?utf-8?B?Q2NUOS82TlB0SjZ3QWxQaS8xbHJLNE1zRnVwVUw0OElqUEluTzVHaE5SdWJp?=
 =?utf-8?B?ZnhtNGl6MzV4eHpoZnBGb1N0K0xMVGZhSzdYWEkvTmtNeTFEMmZHY3p6YVlq?=
 =?utf-8?B?T0k2c3VjU3JBb3lmd2g3Wm5xdkN5dFlrR084WUxYSjVRSmxndnhJM3lGSTVL?=
 =?utf-8?B?YUgwemdqOFhwVElHS3NjL1NJN3FaZSszeDNKcUt5WEU1Z1lONGkyTUlVc2RB?=
 =?utf-8?B?Ym8zRXpRVlBBRGYwbC83MzdMR3N4OS9HRkdrWEhQUllzcHFOWmMrNUtObFdO?=
 =?utf-8?B?SW9QOEtMSVBFTE01OWNvV3NueWNMNXc3SVRaR29NKzFkNHlBQW93cnNsYlRs?=
 =?utf-8?B?OTVDUmNPZVRaTmVGQWo1dC9GSWY3RmUwaStTYXFFSUw3K25tZklqcis3aThB?=
 =?utf-8?B?bktmSmxaMXFhaUhqUWtYcXZvNXpnTG9xWElCR2xsc2RsaFlKbjFteGNnRkZo?=
 =?utf-8?B?Q1FpeUFTQ1BkaWo4T2xWMlhMMEtpOUhzb0NBeUxMSmI4QXdIK096Z1ZiQStq?=
 =?utf-8?B?OEI2UEhWNXdYbytJNFVvaW1xeDlJdmVpb29RT0VRYWVYOTdJY09xWWc0UGVF?=
 =?utf-8?B?Z1BHNDFFdko4cjY1UE8zSWgxM0ZITEphaVVBeENyd1JsM21GdHNJNnBnVGJN?=
 =?utf-8?B?TVdrNjBvZzFNL01MZFFUVDZraVRmQk5KRXFMZkVSUjl2WHNSaDRoa3U0YUZq?=
 =?utf-8?B?cWY1Y0tlVVNrUXJyRGs5Q0xPNVBkZnRRSHRKWElPakYwQ29meUt4bXRQdXRl?=
 =?utf-8?B?RS9MYXI0M3FmYzYyNmRwN2xhSjB1eXBLMnV6Tm93b3pDaGRZSmVSbVJReC9O?=
 =?utf-8?B?SmdCUXF3SzB4NTlwcHNsbllLQVk4Z3NlN3JSL0EwNXplWlRhVzlQaVoxQXZo?=
 =?utf-8?B?RWJjY2hGcVhXQWtMYlgzZUlwSzdUdU1ycW5oSno3cFd2bFBqRFRUMFdwV3g0?=
 =?utf-8?B?NVJlTFFBRG1VdXRWd0hEWS9naXlpK2lFTXVIUGphUmdKU1pZN216NEZsNHpF?=
 =?utf-8?B?TU1saDEvdWcyVWRNSWJDZythRnp0SDEwam50VW1IcjVnVzhrQkxKZkRKVUdz?=
 =?utf-8?B?Q2orK1hIdFVPenZyT3pxSVVUK3pTdmlJQmNGOFB1V09BYUtYQjh6RDFTTi91?=
 =?utf-8?B?S3h4NVJlRTI2dDQ5MHRWcWNIQ2xmYUxXN1RGcFYyUk1LdWlkWmRtV2lJOERx?=
 =?utf-8?B?bzFhVW1wNlpEZWxmZkRINEhveEZxc3VpYW1QRWVydCtXcTQyYUpIMFVkU0lF?=
 =?utf-8?B?OVFUYndLcEpkQ1lEWEdHU2FJa2ZFN1FabmJBU25zbndENmlRenVyTGxzdnc5?=
 =?utf-8?Q?7Ke+hX3eZR8xq2vTiP9CMgI6yXKBK5QxcvpSjf0SmAbR?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4faa92-27eb-4c87-e5e5-08dcc7a811ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 21:26:24.5843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oJlCzgBOqeAQALVBTONPQOeT50EMYQRczDz7ZODQMvAQAT9fpK+mhDCVVeL8xcZEuwBj1RlNhlaHGC92ikO+wb3S3Ahj+Pf8q/qFpT+4Ogaxa/ETjZhcQ8IKkJGld3F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6868


On 8/28/2024 1:44 AM, Leo Yan wrote:
> On 8/28/2024 6:09 AM, Steve Clevenger wrote:
>>
>> Add map_pgoff parameter to python dictionary so it can be seen by the
>> python script, arm-cs-trace-disasm.py. map_pgoff is forced to zero in
>> the dictionary if file type is MAPPING_TYPE__IDENTITY. Otherwise, the
>> map_pgoff value is directly added to the dictionary.
>>
>> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
>> ---
>>  .../util/scripting-engines/trace-event-python.c     | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
>> index 6971dd6c231f..b8da0ea5e55c 100644
>> --- a/tools/perf/util/scripting-engines/trace-event-python.c
>> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
>> @@ -798,7 +798,8 @@ static int set_regs_in_dict(PyObject *dict,
>>  static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
>>                             const char *dso_field, const char *dso_bid_field,
>>                             const char *dso_map_start, const char *dso_map_end,
>> -                           const char *sym_field, const char *symoff_field)
>> +                           const char *sym_field, const char *symoff_field,
>> +                           const char *map_pgoff)
>>  {
>>         char sbuild_id[SBUILD_ID_SIZE];
>>
>> @@ -814,6 +815,12 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
>>                         PyLong_FromUnsignedLong(map__start(al->map)));
>>                 pydict_set_item_string_decref(dict, dso_map_end,
>>                         PyLong_FromUnsignedLong(map__end(al->map)));
>> +               if (al->map->mapping_type == MAPPING_TYPE__DSO)
>> +                       pydict_set_item_string_decref(dict, map_pgoff,
>> +                                       PyLong_FromUnsignedLongLong(al->map->pgoff));
>> +               else
>> +                       pydict_set_item_string_decref(dict, map_pgoff,
>> +                               PyLong_FromUnsignedLongLong(0));
> 
> Indention is inconsistent. Please keep the same format.

Corrected.

> 
>>         }
>>         if (al->sym) {
>>                 pydict_set_item_string_decref(dict, sym_field,
>> @@ -900,7 +907,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>>         pydict_set_item_string_decref(dict, "comm",
>>                         _PyUnicode_FromString(thread__comm_str(al->thread)));
>>         set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
>> -                       "symbol", "symoff");
>> +                       "symbol", "symoff", "map_pgoff");
>>
>>         pydict_set_item_string_decref(dict, "callchain", callchain);
>>
>> @@ -925,7 +932,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>>                         PyBool_FromLong(1));
>>                 set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
>>                                 "addr_dso_map_start", "addr_dso_map_end",
>> -                               "addr_symbol", "addr_symoff");
>> +                               "addr_symbol", "addr_symoff", "map_pgoff");
> 
> This dict variable is for data address parsing. For alignment the naming, here
> can change it as "addr_map_pgoff"?
> 
> Please note, from my understanding, this renaming will not impact the
> sequential change as the python script should only use the dso dict. Please
> confirm at your side.

Renamed as "addr_map_pgoff" to match local call convention. The dso
dictionary is not affected. See V5 patch series.

> 
> With above changes:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
>>         }
>>
>>         if (sample->flags)
>> --
>> 2.25.1
>>

