Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70662AE96;
	Thu, 16 Jan 2025 04:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737001307; cv=fail; b=o53wIurDxbdNMxifONsU9u7/DqnQGc/+11faIaRRR5PyF+bA/9ijVAzisPdHl+ypZXPjVV/S0Gv75W+jU0oT0sWHcbOL80cyQw8JgUEbtxcigtAtAX2aaserkwYHvWrZh4i3dtQIYi/BzV2VSYAfDWT7AfalamYod6uB5OVU+oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737001307; c=relaxed/simple;
	bh=q4bRVhNM1T5auuX6qx6mrK5Zbfsb8YkVKXU6OeIYUTg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dAyxekrdC9/zAeJkP9A5hmND6cJMCuU5i745EAIvSXqdkDfXWEl9gwL7jq/LqsenZcfeBU63qP/eDpGw41HJCRYUqHUOqPFlq0S7MGcBD8tPrI6vUUvwj3sAA1TE0CWtMdBnECn3ZDI0GRipxrM7xXCxu5BowvinAVSx9qAEn/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wje4MYJo; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wje4MYJo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wA7zs03WQLZIN9oOfXtcHhNQtVyt7/iiAZK+HI10eODUju2/gGFQO+zaBdODfJ2XYIi6pk8sl5fOY/CH2G2hLQRaG+pVWoOW/wt+YVyjtjIwpix2h3nXIQXfyzfhmPd1NDwYqoWwH+dfjM3BRLq0+Y2v2jCgWeE7Efij3cmvgz1/yFo9IYoLtCMdukPqlGZCt3rlvUX0VxMuPEh/lqfL4f2dRFg1NdxrqzqXjxMVijuZRu6sRm04DyUxU2aARCbAwThfEv5sfOwqEPyRwCtZjaq32JjiKZTnMT/zOeoNryt2D+iyG15l5RfhqRK4UQ+rFZwwHKJzaS9TMcvxSMKByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIqbXBxm8Dm2TzSt6pHvwmP5Phi9Wx26XlLpsCnzqgU=;
 b=aM4P6/CFmPeAvJdsEv+MWDS6kFbDsJX1bNRAWDeDf+twTZUi6eln/EdsS94TtZJPv9rMWFz4wZ6gbEMGd1BI/n2blAYaHKScdgEKAeHs+aKAiiODMwjRin7Y4sMBpkQzv89uKSzhe2Te3/Q4bgC7Ld9WpLKe4Oin/fTZkG3b8AXN36VSlotLzrm6218vaq7Og7ePMRd0RZqDUKOjHAM2E+JSzt5/OB95v2emzcfSeTuz7Cv79R0LPsgH+MNKdIkfsLhwXBoDQFpOYfluBnfFuWor1e+hHQ2m6z+mMyQukQZ1SNX0LP7LA3xGL2zJfeUv2+3TUbdItv9to+IjU8zYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIqbXBxm8Dm2TzSt6pHvwmP5Phi9Wx26XlLpsCnzqgU=;
 b=wje4MYJo9uq8/zDknbhxHj/gaMkVgdcxvyHePDJYW7CicfUPELsKyS12Xg6Z251OERRyl/EbqJ3tX//lpnHWZw3AqO21Y+e/Tbp77rx/LoBL+4Ip83OoVJflu5OJwrKkTDx7VGDkHTmq9hHA+EfnM28RNrPHPQ1Jos2fLUJggY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 04:21:43 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8335.017; Thu, 16 Jan 2025
 04:21:43 +0000
Message-ID: <5f2c62d4-1bfa-458d-847e-095979a4bf54@amd.com>
Date: Thu, 16 Jan 2025 09:51:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [UNTESTED][PATCH] perf/x86: Fix limit_period() for 'freq mode
 events'
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, eranian@google.com, irogers@google.com, bp@alien8.de,
 x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, santosh.shukla@amd.com,
 ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250115154949.3147-1-ravi.bangoria@amd.com>
 <62c13793-f4b4-4e2e-b6bc-0de2427ea93e@linux.intel.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <62c13793-f4b4-4e2e-b6bc-0de2427ea93e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001AA.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::10) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 081ce301-14eb-4d28-4a4b-08dd35e5483a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUs0aklqT2hEZnpocUVQSFlpL0dOcVVRc2NWSEY4TmtVMVM1N1dRWVRwOCtx?=
 =?utf-8?B?N2QyLzhtamRMRHo5YTZzVGw2Q3R4aGVNd1UwTUxKem80YlNTNGsvOUFyTEJx?=
 =?utf-8?B?TjN3SllmNG82TlVZNGVCZTNnc1dlRFNUN1ZBVzRXYUZSVW5qdHY3R21MdlZv?=
 =?utf-8?B?c1ViZ0dHNjJ0SGlYQTd4dWx1TDNOSk9nc0JvSjFsMzJlM3piWXZBRmJlZFZB?=
 =?utf-8?B?ekJRK0RNWHY4T2ZTdHNFZUJUYTMySzBYY3I4eFFDc2paVUFhV0UrTktQcC9X?=
 =?utf-8?B?dFJQbFY5TnZTQ1l5ZW5Pa2dTQ0t2dTU4dUdjcWxqbm5VSEpnUzBrc1F1dmJh?=
 =?utf-8?B?eXdQQW1zS2pURFQwWEhBdGc5M2Y5MWtWaVNaUGkxdEgxOVVNZ0VzSVRjSG53?=
 =?utf-8?B?Tkk5S1E2WGwrakhmcHVSamhaaC84WEFPMFhCakNNaHh4VWRpYjF2UGNHTnBy?=
 =?utf-8?B?VFB3M29MUkI2M1RLR1BPN2hWdlROQ3ExL21KdnRHbHN1UXBxSzhqYml4MGVL?=
 =?utf-8?B?VFc5Z001ajBvM2FBNzFmSXRwdjFHNExQMWFTU3JDVVpDNmR5UytRM3R1b2pD?=
 =?utf-8?B?MXljUDVBcUZOTEZORmRUd1h5YXRRNCsxanUxMVBSTmtTMUxQTDNIbHMwOCtF?=
 =?utf-8?B?ZUEzM3FwdTlFTkpFVXFhdW5JZmp3Y29YRXpqTDd6R1dPRy9KSmFNN09hT0JR?=
 =?utf-8?B?RzJwNTNWeGd1UGp6VnMwRzkwSDcrSWo3NEtHazRFWExINTVTQjhCREthVUlE?=
 =?utf-8?B?WVVlY3VGZ2Vza3pXd3hpR29KdXdpK2NTamZhRnQwSUV1TEJaLzdHY1l2alFj?=
 =?utf-8?B?d1RDN3VCNFlBNlNDMGhpUWZCR3NSUnNCdjBDWDQ3SjJ0bFZydmlUb2VCYjAw?=
 =?utf-8?B?c0sxRHF1U3ZhUUx0d09YbUNLZmVZS0RhcmFVQXBLNERrMFBaUzdJcDFHaTRH?=
 =?utf-8?B?WVp3NElNUFpkTDJhMUFzTjdSemgxaTVWWWRDa1FKdldmUjFpUU5Oc3Rxdkd3?=
 =?utf-8?B?YjhZMlJCMzh5bkRXNExUeERhL2UvQmxYNHVBYUNZVE9oKzlGTG4wQm82QzZV?=
 =?utf-8?B?MzZaQ2tEaWVFMkVweUZaZDIrc2pIS1RoR0xQVkVFeXltajZvS0Iwbml5Rmd3?=
 =?utf-8?B?ZWx6NTJEK1RickRCOFkvdmZzM0dhUGRqRktQZFBYVm1BT2lGM2d0U09RQURT?=
 =?utf-8?B?b1JLOFdkdmM3bEptbDRSb2FiKy9mOGo5ZlFVWHhOSURic1FVbXY2WmZMd3ox?=
 =?utf-8?B?ZWx3Unl0THhaNUZZK3p2Rm9peVlKMEI3b0pTeUxzcklPaEhHMFBnOXN2Qi9z?=
 =?utf-8?B?TncxOG5hSG5XVkxKdWtCTG9tTGRCb1BoYk5aVjZicTlmMUw1V0I5U3FvU2RM?=
 =?utf-8?B?UG54d2VQV2p3NWEvaVljS3NGeDdrUVVOQ29pMWFjUXRoK0l0dzc4VG91ZGM3?=
 =?utf-8?B?L0Nra28vZFVJUEt3RjRDVDlqMjdWNkNQMW1LdVZiRFdtN2I1ZTk3OEN2WkJh?=
 =?utf-8?B?Tk1IeTVycVdyK2RGajZQY0FBcmdnMjMzajNGcTJXSWRqUm5EM0VsejJaK1dX?=
 =?utf-8?B?Z0hYRWNBUFdtcFlTY1gwbmNpSlBFOW1WYnk2OC8xWGtUME9JN0IzWmE5V29y?=
 =?utf-8?B?dU1jU3dDUHJaSThRWUZIU2c5NFdHMFh1c3BjVkQxY09kQnJMYm5DNGxrNjlQ?=
 =?utf-8?B?d2pMVWVzOTd5R2Q3MThrdFlNUHYxUDFlZDI2cWpVMFNDQlNIZS9DTUNLdlpp?=
 =?utf-8?B?alhVK0c5dlBveXRTYlNLbUJwNmwwZDNxYkFaem9VTktzSFhUcGZqL1BBaUdt?=
 =?utf-8?B?a3dhdEd5Z3NDRUVmOXZKZWNFQjdXbXhrb0pNeGttWVFQNDFlZDVZRGV2Z3JE?=
 =?utf-8?Q?tehSbvoEQeRxW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U000bHVsSFBxV3hVdjU3Y3Z4QStkZ0U4WkhOeTBHcVcrSWw0d0JSa3pZMnNC?=
 =?utf-8?B?ekpCK3AwdVR5bWxjQmE3Uk05cktvbWFIR1NlaFl5aGtuc242eTcySE9kVnBD?=
 =?utf-8?B?OEpjSldyN3d4NDh2SVZjZTFmWU9TOGJEMlhwOUhEVHYxMTBUbWZXb0Nqdi9U?=
 =?utf-8?B?bm1NTDQrK0Y0NkVXbENiajdXUzhSTExTMEtkYmJTNW1wOC9qMEpCMHZMbG9P?=
 =?utf-8?B?TGlmVVhqcHcxZGg3UHdnSUZZcEp6RWdhQ1NGY0pmMk8vRG1MYkMxRVhZS254?=
 =?utf-8?B?R3VhUzZHSVNQb1Y3WHBsUHJOUmE2ajhRVWlBS2tjbVVJL3o3TExBd3pNc0dj?=
 =?utf-8?B?T2tvUko5bGsyS2lhVTZPM1BCKzZCZlc0YVQrZDhZbTRPK0ZoaUNHQWdpSUx3?=
 =?utf-8?B?bndwM0x2RDRqWnU3WEdhMUsxZDV0OXUrN0NLakF3UEZ4Mm1OREJteHZsNGFS?=
 =?utf-8?B?RXdZRnBHenk4WWNJNHNaWlEwN011QXgrWDBSbGRaZHVyVFVuL2J2RjBCVTBX?=
 =?utf-8?B?L1J1dy9ZRnFQQkNhVjRUSlVXUFoydTVvQWxUR1dvL0dMSjFMZFkvZVNvY0NW?=
 =?utf-8?B?NGhLNHlvZDVTc0U2aE8rU01XWWlmanNZQVZFd28yUklZNVUxWlRaTVJkcHdr?=
 =?utf-8?B?R1l5MDV5ZlBFeXhiMEdieWN0dDdzcFhlakFJWTNjR0NNT1dQL2lpcC95STdu?=
 =?utf-8?B?UXpvbTUyZ0IwQ1VwQ3hzclo3aGxZbG9WZUEzVVZ5YmZCamJXUE8rRGZycUFw?=
 =?utf-8?B?VGI5RFgxTHpsQ1VrUW84YVA3c29DTm9DYWo1aThDTXdDcE43dlQwMytmUUV5?=
 =?utf-8?B?ZDdyMC9UdHFPYnovZkU5OEZPL1M1U0VWMndmTGI3YXNhLzBhUVFjRzdtMmxY?=
 =?utf-8?B?ZjRVTVNMWkZ0MDdoR09MeGduelpBNDVadDhPWk8zM0RWM3djd1diTkYyR21W?=
 =?utf-8?B?alJhYXJFSzBaSVlyMTArR09YK0JpZFNNSzEyeHlFdHFmT096WVJrODVYTWlZ?=
 =?utf-8?B?bVcveGc2VktESTF2dHRVc3VlT01LY0d0bHdCWXFuSkdFQ0F5SkY2NjY0cUJl?=
 =?utf-8?B?LzlJK0tNWXdrRVhFYWoxazJKRG5rKzhBRzcvM0ZLQzlYSEF3RFZSLzR1Z1BI?=
 =?utf-8?B?aDZwUU1oSFFvSStqeWVTY1ZxR2NaazJkSWxGSVRPVTZlcnRhVk1vUFlCVUlE?=
 =?utf-8?B?N1dTdlljYnFvZ2xEZ3l6SlVBc0hzZTFqR0dSblhYZTlRTDJXV1VVTGxKYVJS?=
 =?utf-8?B?R1ZNWFdXcjBRWWtpYzc2eTRYZE5ndEppc2doVDFldm5UaHNGT1ZIVEQzdDNo?=
 =?utf-8?B?ekwvb2k2bmUwelhLeEE5MXRQa2pzdDhoajNEeGtHdS84YUY0UWhMVFhFV0Va?=
 =?utf-8?B?NDNCSWIxdHZTalBkeCtFUXh4dDFoRU1lUFp1U3JCNTB3RHBuTGpvNHpmZUJM?=
 =?utf-8?B?ejJ3MzZvVDEyR05yeXkwV1JVVndtNFRLN0FaUUVWSElFcEgrZnVPc09wSlhz?=
 =?utf-8?B?VGtVY2hBV0RSTUpQYi8xOGtrRnB6TGhKQUFnTlhDVWRyRHhCdjJwWUp4M2Ri?=
 =?utf-8?B?bFBwZTVMeXQxMWRENktlUTd3ZVlXOG9ZVUFJSmRndlMweUszdzErMTloVUpM?=
 =?utf-8?B?bzllWkZmTFZsZXlNejRUUVAvdmZwRGxEV29HVVdJS1dpL1NkaHpra29sRUJU?=
 =?utf-8?B?RlduQS82S1MzSHF5OEd6ZnM0L1NBLzdIeWRUZWJ5UU5McXlhVkFjSGNzYjJC?=
 =?utf-8?B?Rzh4TFY5MmFOdzlPeHBzODA1Y1pHaWZkQmFEc29CTklzem5wMEZSQ1BSMTZk?=
 =?utf-8?B?R3FJMkZnSHAwYmROODNPQUMzRjFHUFVWR1h2MDAxc1JOTld0VWpSa0FHZ3VX?=
 =?utf-8?B?cDhmS2dkZlpKVnp5em12NkgrVUJwZUpoWTNGS29jbkJYOWtGWEkzWUJXYXpV?=
 =?utf-8?B?ZWhyVHZLeTRYamV1aWMzeGxWU3l1OFVtZ3lvM3JSZ1hyUm9SM1daK0ZhRXdo?=
 =?utf-8?B?R3dPZlRFcHErNlNLN2xVZ2ZydlN6VVJMbUZQRzRtZFhldm96eHRQbDF2T2sy?=
 =?utf-8?B?ZWR2cEV6UkFXcXJBQ0xGYmZYREkyYmIrTzNLOVp5OE4zajBVY1lNUXE0dkJM?=
 =?utf-8?Q?FAHCTTFnynZLlCK58+yfUUz5r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081ce301-14eb-4d28-4a4b-08dd35e5483a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 04:21:43.6805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XikwqfSsr2VFcVqD4gd7FAEOVrAcOtKC0bbVyfofwPeF+OIjHsPigSQAbEgR5vgRC/CKBDTolgEdUgbRR3YYeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414

>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index c75c482d4c52..924aa35676d3 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -629,10 +629,22 @@ int x86_pmu_hw_config(struct perf_event *event)
>>  		event->hw.config |= x86_pmu_get_event_config(event);
>>  
>>  	if (event->attr.sample_period && x86_pmu.limit_period) {
>> -		s64 left = event->attr.sample_period;
>> -		x86_pmu.limit_period(event, &left);
>> -		if (left > event->attr.sample_period)
>> -			return -EINVAL;
>> +		if (event->attr.freq) {
>> +			s64 left = event->hw.sample_period;
>> +
>> +			x86_pmu.limit_period(event, &left);
>> +			if (left != event->hw.sample_period) {
>> +				event->hw.sample_period = left;
>> +				event->hw.last_period = left;
>> +				local64_set(&event->hw.period_left, left);
>> +			}
> 
> For a better start period, I'd prefer the below patch.
> https://lore.kernel.org/lkml/20241022130414.2493923-1-kan.liang@linux.intel.com/
> 
> The limit_period() check was introduced in the c46e665f0377 ("perf/x86:
> Add INST_RETIRED.ALL workarounds"). For my understanding, it's to check
> the !freq case. If so, I'm thinking something as below.
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 79a4aad5a0a3..6467ecc65486 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -630,7 +630,7 @@ int x86_pmu_hw_config(struct perf_event *event)
>  	if (event->attr.type == event->pmu->type)
>  		event->hw.config |= x86_pmu_get_event_config(event);
> 
> -	if (event->attr.sample_period && x86_pmu.limit_period) {
> +	if (!event->attr.freq && x86_pmu.limit_period) {
>  		s64 left = event->attr.sample_period;
>  		x86_pmu.limit_period(event, &left);
>  		if (left > event->attr.sample_period)

LGTM.

>> +		} else {
>> +			s64 left = event->attr.sample_period;
>> +
>> +			x86_pmu.limit_period(event, &left);
>> +			if (left > event->attr.sample_period)
>> +				return -EINVAL;
>> +		}
>>  	}
>>  
>>  	/* sample_regs_user never support XMM registers */
>> @@ -2648,6 +2660,9 @@ static int x86_pmu_check_period(struct perf_event *event, u64 value)
>>  	if (x86_pmu.check_period && x86_pmu.check_period(event, value))
>>  		return -EINVAL;
>>  
>> +	if (event->attr.freq)
>> +		return 0;
>> +
> 
> The ioctl(PERF_EVENT_IOC_PERIOD) can be used to set both freq and
> period. But according to the implementation, yes, the
> perf_event_check_period() should be only for the !freq mode.
> 
> If so, we may change the generic code.
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f91ba29048ce..a9a04d4f3619 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5960,14 +5960,15 @@ static int _perf_event_period(struct perf_event
> *event, u64 value)
>  	if (!value)
>  		return -EINVAL;
> 
> -	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
> -		return -EINVAL;
> -
> -	if (perf_event_check_period(event, value))
> -		return -EINVAL;
> -
> -	if (!event->attr.freq && (value & (1ULL << 63)))
> -		return -EINVAL;
> +	if (event->attr.freq) {
> +		if (value > sysctl_perf_event_sample_rate)
> +			return -EINVAL;
> +	} else {
> +		if (perf_event_check_period(event, value))
> +			return -EINVAL;
> +		if (value & (1ULL << 63))
> +			return -EINVAL;
> +	}
> 
>  	event_function_call(event, __perf_event_period, &value);

LGTM. And you can remove the if (event->attr.freq) check from
intel_pmu_has_bts_period().

Mind sending a proper patch series?

Thanks,
Ravi
