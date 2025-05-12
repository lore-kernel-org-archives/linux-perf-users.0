Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAEB11712;
	Mon, 12 May 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044083; cv=fail; b=dURkiZHVtW7aUgbydBS6Lt+FARlX97DpA4mJs4Mxb8P7Fuz4gCaTNCsSJBL1Eo5Lfz3kfDtODPJWln7Ms62AJZRzm+dXVTOfCeQ1Emjldkkw+1v18u7MLwgzuokJqBZUWEK+Oc8FBCgQAOANQ9k6i9McG1MnrBXrvOJPuBqAnS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044083; c=relaxed/simple;
	bh=en6tQ73HrRWLBsqrDKVSYS6c4GAu9A9LxDegS3s+F5E=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p9CH7GvlRtclAo8xs0XA6pBWRfv4kULQLow+QaD0/Hl5IdEiYkKGPokl+TiGAtBmDW63ynA6HC7irVhx2IBBTw3VqmqEWevUYUlvcZ8vvguwRMAk779jwsIftZWC3OROKUz7bI6FlLQ8t3hIZsciv8pc+ZQAVVGnNofelC9qlCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FhrAqY5a; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FhrAqY5a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXXQk3qqk3yLuQE/LWLbaq79/CyXsp+q+5fJsEtY6lhQWlsr/c3DM9sJNig5nWyS8MJXm+oafjGbNoce0ka+BKmaneUlstxu1Bj2b+yT8CuZcgqucksxdXAptLgBGWoEWNj9zf+sfueNLLbcWPqf3oMh76QxZm3RSqOMkq/QuZiZ3jJHCRHJhkjg9vYUgrE5Tf7ofTgrsBoKbc1newBy6c6pI3CRWTCd3osKT+zu/j7ZHXXyzwSKiZL+3e6qs1EDIe00FKiEMY6XqbpQ3O5rRvYxnlrRk+JW5AFz2BQPyeDyq4ha7Uc49UtyD6jonpKx5iCndJ+/ujsJH4O51e2Grg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3T36J6H90NnoLN+u1r0t+1zyMQQrgXNv9i6249hYDs=;
 b=fmWc8uiG1JjnwUsxEtWCJJaXhM+E+klNsjSsEESSXhIqebKlKHSlzg7HKkdGVxLWn+GfNaF2VtdFN0E/1pk/vO/NfQXYfhjUeiEvuOSjql++wN75fyJhfbMwOPATMLxc8kDC4ZXATLr7yD3bgyGi2FdGlT3ZGr4u32dM+M5QqME3lbTnrvB3BiXe157+WcYk7+MjxB/k6yD0h+5nP3LQPIUoMP8kbG0IyYDsC9cvRE3GFWd8s8xxSiY4/Gs2vpG6lBesmLB/hYWzpT34UIH56XtRfZyRFHdd1xFELSc4mZ6nrb4eyLBS3PtYvE6EFPsuqErbaI2VMH48SkEf8cCE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3T36J6H90NnoLN+u1r0t+1zyMQQrgXNv9i6249hYDs=;
 b=FhrAqY5ajEA2xO3UA8Dfj0FLaiALP1ABOWUUehKnL5/EFFCZ54JXaeOff2wrm6A2SenXyn7v6b6bxVFVkF9XGuqof8HGbrr+/OQ84Q5Hj6OY30J9eW9I92sXi5E9ysOZH19/UIuxM1Mwv2xWeZB6aD3BYkIGot7AygXA7TBFt5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 10:01:19 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 10:01:19 +0000
Message-ID: <7beb0d9e-8707-4421-a88b-cc494ef1e880@amd.com>
Date: Mon, 12 May 2025 15:31:11 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC/PATCHSET 00/11] perf mem: Add new output fields for data
 source (v1)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Leo Yan <leo.yan@arm.com>, Stephane Eranian <eranian@google.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250430205548.789750-1-namhyung@kernel.org>
 <33984b44-ae3d-4fbd-b918-07289a3f1d8a@amd.com> <aB4qpAc2GThyGaqg@google.com>
Content-Language: en-US
In-Reply-To: <aB4qpAc2GThyGaqg@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::12) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ed09ef-c2b1-4b30-b131-08dd913bf0e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dk1BajNxUjBoK0h3dzlTM0ZtV1M4VFFRcnBrd0p1Y2Q0VE9DRisxSHJkaVR5?=
 =?utf-8?B?clR1cHdWZ2E3WkNwRW84RmR4TWVUOUN5bDZTUjArNGNkQy9VZmJOLzcrSWN6?=
 =?utf-8?B?SkZnRlhEZlNxU2tRU2pwSHdtM1ZscXR5MkdDbm03YVBxaWc5bk54NU1ZYzM0?=
 =?utf-8?B?ejhyaGIwOVFOVHZ2blpSVnpBVlBNL1BVN0VrY3VPQ1NUNWVtR0ZwVzcyTzJi?=
 =?utf-8?B?b29DTjBHWG96VzBuVmNsNldOSDNibDY2cDM1TkhZL3RRVVMwRkl0dVNpZzNy?=
 =?utf-8?B?dHlMT1NtNXZQYU93akhaZXIxbWQvekJHWnpMbFdHMmhDWWhNQVVyQ05SNHg1?=
 =?utf-8?B?Vm5aQ3VmM0h6VW54cTRDdXZtVmxwOHFSc2w5NThxcFVRNytTVkdZM2VER1FI?=
 =?utf-8?B?MGl4K0lpU1dwREFCeW1SRmpOZzVZNHR2Rll5OHlVSXI1cnJJWUQvT2dra3Aw?=
 =?utf-8?B?Q3RCY0lmVjU0bmdIcEdMNTB4R1JlUDFlem5nNGpqN3l0Y3BVL3B3dW1lTTJK?=
 =?utf-8?B?dWtReFl0Z2FlT05ISG1xK1RpRGQ2RmZRSG4wc1VTWXVBWDJWNUJnSTdiektO?=
 =?utf-8?B?N2FUcFRjWXhObGdtYUd2d1dJSGh0TkpVVGE3TnJRa1RmY0prTkhFMVpkZ09p?=
 =?utf-8?B?a1FsYkE0N0pCYkhrOWRtb1UxM01GcXVxMmg1SC9rYUpxZzh1d1plNU5xcW0z?=
 =?utf-8?B?T2kzTzc5SzhmZFkzcFpIZDV3VENMbmwvM0FqeUxRUUNDcy9wM2tIdTU3ZHp0?=
 =?utf-8?B?TW1YRVVYc1V0ZGpuN2REVVJqNVhGbitQVFhDckdUMmdjL1c1RXN5RUMrcHdl?=
 =?utf-8?B?UE9kN1NnMm5nbHgvS2F5L2NZcVRwMmJ4NzN3eHJYMnZzMjRGazZsNzN3bWlD?=
 =?utf-8?B?Ym9DRmxzZnRxQi8vbVlKZEY3aFcvRVBpNGxrVXdRbDc4TUNHNU0rTmlPdUFr?=
 =?utf-8?B?YVZEbFJXb2cvTFFScFBRdFJsU2x6NGNsaWVud3R5WDk1K3lFMWYzeWExdVlw?=
 =?utf-8?B?eHpzVHZMUGFyV1R1RjlCSlZUTEl1Nm50MGNoZTZjNXFxSGlTaFVyL2k0SXJE?=
 =?utf-8?B?MzVRSGxDRXBiMkdXQmpFTmY0QzRaaDU4SktNNkk0U0ZoLzdzclFTa1NWOHU3?=
 =?utf-8?B?V0VIeFo4blZiMTM4Y3M3YlVFV3J5bjR1SkhEQWdLY3lVdXMvTzNVdktVNFRP?=
 =?utf-8?B?ZWFzSk56YXZlZXE3d2hxKzdxZFpNRkZSdy9oWjgzNFZkaGF3VWxzWFFlSVFZ?=
 =?utf-8?B?RGI5Z016OGpVaGNhRURlNUgrdHM1K1V2NVFMZWVYdjMyQ2hRWDU4YWNCWmhK?=
 =?utf-8?B?T0NUR245MzNxTFNqdCtJQ0RKNzVBN25xajRxSWxHTHJ0UXhqWU9YK2JoMXho?=
 =?utf-8?B?Q1ROajVQNXhIRDZTNzNZWEZjcllaNlR4ZFJ4NU4yVllLQzJMSWZ5MFhZYkY0?=
 =?utf-8?B?VHQ5eFpZL0lVaHVTYVR2cmtldGlWSk1mQlY1MmJiN25BbnZmK3hYeVdUQ1Jh?=
 =?utf-8?B?d3Q2eWZsbmlZM1ZreFE0K05lVjY2U1NDOWpGSndrTTkxSlNuajBsbEJ2d2RO?=
 =?utf-8?B?S2dZL3NhcTdLMGhVcUhYbTlkeVhsYXByVGE5RXF0WFB5K0RoWkkyYU03NXFP?=
 =?utf-8?B?UlNqSU0xekN1cFBFcWE0TXlIU203ZDEyRGpoMWhubmlmREw0MTBDS2duaDEy?=
 =?utf-8?B?WGNBcU5LQUhLZHgxTE54cExjVHFzUTNLUTZjZ3lZOWVSK283M3ZkcEtwUzlS?=
 =?utf-8?B?eDRSNlRISm5mRW5mM1JDSDZIVkpUbFBhQzNzMlh2QWN6bTkzS1FJVXdQV1J2?=
 =?utf-8?B?OENKd05oNHBOOE1sWE1hejloTWRuTFZjbmNLdDVOU2hZYmI3WVh4c1FDZ01W?=
 =?utf-8?B?dW1TMmZGVkZVK29NeTFEQnZNakVTT2VvbmJZVm1wZUxQeFA3Tmp4dGc4bks1?=
 =?utf-8?Q?vLKEyYt8uPY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emlacUk0cGdlNVJDV29yWnBIMVBrMHNyL1F0L2EyU21ncS9hcU0wUXZVNTJ0?=
 =?utf-8?B?N0VRZEJ1cFZRejVWdG9YTGR2eElvK3ZNRk9iWDJKNGpPRFNoUmlFOUs5TVlW?=
 =?utf-8?B?bmw5aDNubVBYUjA4UlZvUWxNR1cyTTJoUFhEd2luaDcrdE9ndTBPYnpRQmRm?=
 =?utf-8?B?UkhoUyswbzJ1bGpHN2tDMWhOakNGT3oyU0ZDQnVUTGo0ODRkbWJHbllmNUdZ?=
 =?utf-8?B?c2g3ald6cDlBYkJLQkt6NzFHcE1EQUU2Y2Y5MVdxaGNKQ2tMWnEyZlJzNi9n?=
 =?utf-8?B?aGM2RVlzTzlRZnV6Rmd4YUY3VmVETThxbGwxbjRqYlVzS2UxUzZ2UUVaSkR3?=
 =?utf-8?B?Rm9CbEFZTzdEYWpYNGl6a21oQjZDQWFiV1ZKTDJRMWUrMUwrRDFxS0h1V3dS?=
 =?utf-8?B?ekx5NmN4SmVxSUI0dDYrcEwwc2JBdC9sWFdNYnByN1l3WUZsdlBOZlJCcCtQ?=
 =?utf-8?B?eGQ5ZEFHVHlTQkxNbWg0NS83eHhWSWJnSXNkVnY5d0ExT1prNjZvSmxBaStB?=
 =?utf-8?B?TFdYZXZaTG9SVHhtemttSnlrNElScm4wYzNBZEZ4STJQMGJIdEJab0lndTEz?=
 =?utf-8?B?UFZ5dC9NNEkyWE5GYWN0Qmc3S01xN3NFQWdONFk4Z2xRSWRTdkkyRFJnYUpa?=
 =?utf-8?B?VjFiT2krZVFDeFFNTi9TNmVpQm41ZnpoZExHMUtzcENHbVRuZDZod0FWUmpo?=
 =?utf-8?B?cEQxcTE0cXJjbEQwM3ZNZ2tXTjdlbDJrTzl1YjV5amNzOGJoNTNjdFNvNjYv?=
 =?utf-8?B?SFNJRU9mWm5SdVE4b0JQRlV5cnpMeDVocEVDNGdwRnpBN3pLRVNkbWhlaUps?=
 =?utf-8?B?RWM3UFdUcVNUT0pvSzNLUkJJNkh2QSt5QndYcEpYNDJWV24xUGt6YUtVK1ds?=
 =?utf-8?B?S2Q4MFdSdjdrS0RlQ2NGcHN2elNJQVRWSkQxMUR3cVJEc2diQ0ZwRG53cjFi?=
 =?utf-8?B?Q0tNSmRLaTIrVFRxWW1TandEcVBGWGExa09OT1ZkN3grN0YvWE5QVlFBeFp6?=
 =?utf-8?B?RHhRWVlaZE5GcXU0NVlGUUZ5dXdVbGR0SUpXbWhXMWV4NTAzbVROMnRiajBj?=
 =?utf-8?B?ZEdJSmhlVVY4dWsxV2Q3MDlQalpKb2pPVnlkZFdKQkRvSUNSYlNVOFN3UEFy?=
 =?utf-8?B?cmREMS9aYVVkTU9OMWZsQTc0K0hEdllYUzRPV1krVkFYYklrZmdRR29Qd3M0?=
 =?utf-8?B?TStIdDJSWWk5UUdYUVE4RzRuR0VhUWdjbWQ0MHkzZkVycXhmS05tNHBvOEdj?=
 =?utf-8?B?UjZZY2I3eXNpR016NFN6R1gxRlRZS2dXZkRYY21IRm4zTHordXh6ZXV4N084?=
 =?utf-8?B?QUhXRWJJMVZzSFI4TklseXNRZGpMMkNyU1NTZzZFM3ROSUMyMC9RQW9iK2ND?=
 =?utf-8?B?YzZmZ0hMSXhvNjRXVzJ2Nnp2MFI2Q2dtMERZTWhxemJ5RzMrbE4vMUxXalU0?=
 =?utf-8?B?WEMyVFlJdjlPRUNRcEhPUVI3UThZZFN5STJQblRVUE1IV3REbE5WN2hyOHhS?=
 =?utf-8?B?VGVOY0pMMEVYRUx3ck5tWmI5NWgvUFJLNVlVTk1TWG5xMEhGTWRzN0MwclFk?=
 =?utf-8?B?MnhsVURaN1ZObVZCTjdMbEtEc1BQR0YzQmJrazVUSGFhSlVqVmFHdGtYT24w?=
 =?utf-8?B?anREb3BtRnBYbUFuNDV2a3FxVFZ2dGRVSEowZUx6aGVSWmJjZDVzTjVwWGk3?=
 =?utf-8?B?a2NQeVBPdzRLTHZxandXaXJMdVovSVVFeHU5MjFJMElWdjdQNjJEbHFuL1cv?=
 =?utf-8?B?SlJhSGpuZVY0YWp0S3NNMHhMWTM1T3BnU3VoNHpRa2k4NENsWjlpc20wbGdv?=
 =?utf-8?B?WDNXUUp1OE5mYUJ3eXZKSnA0Qjl5R2g2eGhsS0hOOUxsTVNBUUlYSFh2M2dD?=
 =?utf-8?B?UVNWTEtIOW4rV28zdUlkdVVBdkhOOTRJNXhNdE9TRVp5Q1VYU3JXUnczaXd2?=
 =?utf-8?B?dG85eUNnSXFRVDNIVW10a2xzRE1aRmpRdXR2SVp4UjY4SVJsVWcwZWNadUo3?=
 =?utf-8?B?RENzNWhHYnZvb1RzMVJpTUhoTWdOb2lDelJzRDVLUkltNlJsdmxZVDc2U2pi?=
 =?utf-8?B?YTF6N01pTzh2SGo2OVNDNjUwa0p4ZjU5TFk5OFpnOE1wTTQ4UEpmMnFWZFdi?=
 =?utf-8?Q?FAgrHEYFSd2eeL1CS3SbXXKnL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ed09ef-c2b1-4b30-b131-08dd913bf0e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 10:01:19.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubvB7FFzR0VRkQ4d4Lxp/5lvsNhYHl6k/sH/TNDV8bNv5cGc2m4iyrsR/6Abqz0TZY8AIEAE1TlkGG8Dm4w06Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049

Hi Namhyung,

>>> The name of some new fields are the same as the corresponding sort
>>> keys (mem, op, snoop) so I had to change the order whether it's
>>> applied as an output field or a sort key.  Maybe it's better to name
>>> them differently but I couldn't come up with better ideas.
>>
>> 1) These semantic changes of the field name seems counter intuitive
>>    (to me). Example:
>>
>>    -F mem:
>>
>>      Without patch:
>>
>>      $ perf mem report -F overhead,sample,mem --stdio
>>      # Overhead       Samples  Memory access
>>          39.29%             1  L3 hit
>>          37.50%            21  N/A
>>          23.21%            13  L1 hit
>>
>>      With patch:
>>
>>      $ perf mem report -F overhead,sample,mem --stdio
>>      #                          Memory
>>      # Overhead       Samples    Other
>>         100.00%            35   100.0%
> 
> Yep, that's because I split the 'mem' part to 'cache' and 'mem' because
> he_mem_stat can handle up to 8 entries.

+1.

>  As your samples hit mostly in
> the caches, you'd get the similar result when you run:
> 
>   $ perf mem report -F overhead,sample,cache --stdio
> 
>>
>>    -F 'snoop':
>>
>>      Without patch:
>>
>>      $ perf mem report -F overhead,sample,snoop --stdio
>>      # Overhead       Samples  Snoop
>>          60.71%            34  N/A
>>          39.29%             1  HitM
>>    
>>      With patchset:
>>
>>      $ perf mem report -F overhead,sample,snoop --stdio
>>      #                         --- Snoop ----
>>      # Overhead       Samples     HitM  Other
>>         100.00%            35    39.3%  60.7%
> 
> This matches to 'Overhead' distribution without patch, right?

Right, it does.

>> 2) It was not intuitive (to me:)) that perf-mem overhead is calculated
>>    using sample->weight by overwriting sample->period. I also don't see
>>    it documented anywhere (or did I miss it?)
> 
> I don't see the documentation and I also find it confusing.  Sometimes I
> think the weight is better but sometimes not. :(  At least we could add
> and option to control that (like --use-weight ?).

this and below ...

> Also we now have 'weight' output field so users can see it, althought it
> shows averages.
> 
>>
>>    perf report:
>>
>>      $ perf report -F overhead,sample,period,dso --stdio
>>      # Overhead  Samples   Period  Shared Object
>>          80.00%       28  2800000  [kernel.kallsyms]
>>           5.71%        2   200000  ld-linux-x86-64.so.2
>>           5.71%        2   200000  libc.so.6
>>           5.71%        2   200000  ls
>>           2.86%        1   100000  libpcre2-8.so.0.11.2
>>
>>    perf mem report:
>>
>>      $ perf mem report -F overhead,sample,period,dso --stdio
>>      # Overhead  Samples   Period  Shared Object
>>          87.50%       28       49  [kernel.kallsyms]
>>           3.57%        2        2  ld-linux-x86-64.so.2
>>           3.57%        2        2  libc.so.6
>>           3.57%        2        2  ls
>>           1.79%        1        1  libpcre2-8.so.0.11.2
>>
>> 3) Similarly, it was not intuitive (again, to me:)) that -F op/snoop/dtlb
>>    percentages are calculated based on sample->weight.
> 
> Hmm.. ok.  Maybe better to use the original period for percentage
> breakdown in the new output fields.  For examples, in the above result
> you have 13 samples for L1 and 1 sample for L3 but the weight of L3
> access is bigger.  But I guess users probably want to see L1 access was
> dominant.

... I'm also not sure. Logically, it makes sense to use weight as overhead.
Also it dates back to ~2014 and nobody has complained so far. So I'm just
being pedantic 🙂. For now, how about just document it in the perf-mem man
page and leave it. Attaching the patch at the end.

>> 4) I've similar recommended perf-mem command in perf-amd-ibs man page.
>>    Can you please update alternate command there.
>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-amd-ibs.txt?h=v6.15-rc5#n167
> 
> Sure will do.

Thanks!

------------><---------------
From 7e4393ab7b20f8d89a5dece08fdd925e3e50b15a Mon Sep 17 00:00:00 2001
From: Ravi Bangoria <ravi.bangoria@amd.com>
Date: Mon, 12 May 2025 06:22:57 +0000
Subject: [PATCH] perf mem doc: Describe overhead calculation in brief

Unlike perf-report which uses sample period for overhead calculation,
perf-mem overhead is calculated using sample weight. Describe perf-mem
overhead calculation method in it's man page.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/Documentation/perf-mem.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index a9e3c71a2205..965e73d37772 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -137,6 +137,25 @@ REPORT OPTIONS
 In addition, for report all perf report options are valid, and for record
 all perf record options.
 
+OVERHEAD CALCULATION
+--------------------
+Unlike linkperf:perf-report[1], which calculates overhead from the actual
+sample period, perf-mem overhead is calculated using sample weight. E.g.
+there are two samples in perf.data file, both with the same sample period,
+but one sample with weight 180 and the other with weight 20:
+
+  $ perf script -F period,data_src,weight,ip,sym
+  100000    629080842 |OP LOAD|LVL L3 hit|...     20       7e69b93ca524 strcmp
+  100000   1a29081042 |OP LOAD|LVL RAM hit|...   180   ffffffff82429168 memcpy
+
+  $ perf report -F overhead,symbol
+  50%   [.] strcmp
+  50%   [k] memcpy
+
+  $ perf mem report -F overhead,symbol
+  90%   [k] memcpy
+  10%   [.] strcmp
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-arm-spe[1]
-- 
2.43.0

Thanks,
Ravi
