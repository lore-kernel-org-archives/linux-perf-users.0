Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020124.outbound.protection.outlook.com [52.101.195.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397C01DD866;
	Sat, 25 Jan 2025 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737807729; cv=fail; b=panDDKEeILhLLp8DKu+W6ggA4I0SqyqymSHqaqabWSkXSxUAgErM48G9BW065XdGC+jlHAABHNPbLHYpbHKejwTNBvpP8SzD0tSH8Q6MTFN8Z2fCAbdzeDPfoaV2AfGn0bwGrxk1u9LWRJQVAaowfajjx6maYArVx8fS12RzT6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737807729; c=relaxed/simple;
	bh=Ef//BmffQ7E1Z8JDOSiBKxn8feBe91PRi9Uo3fZu9zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BCh4GETCTCB8T/HOkFrX08YWdFUKtFu6509pIRZ4Q1MAkBZ51MmYVSWN+PzC7zH/LKmr0qL+yf3pED7zlRk0lFTOXrbs15J1h5W2PEi+HAHtjd26bfnHcopNChMmzwFd/DMOAayIBp0S7sqvYgAiyRDSN4UlgzUUISld7xwXG5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfIpkkOwXx1Y3iiYIsf248ynnFO0WXbAsyM58PNi3Z9ht7SZfLXULxEMLt3cHGgi42vWT8DE2K1NkuUYYbAoo5Btsn+3maoFaar4anzZefRHUCKhNP89nmpL7H6pZY/SXpbH/ccccWHmNV8rsAoXKgGie1fJ3mY4GHq6lOOfYMZA43Mklx03fKX22kfCGqi8uP4jOYoGhJCRegLoIOfQsmByN0HgrU+L30pCPpqRfS6TLxLf5g7jppP0tFN++vDbR9Me1iCBHGrB9ZdhyNrh13IGPjE9q09y1MvTSZErKHPE94vJn3ktqDWwzaz8dO4S/W6JOhZMngThyp8EWKvh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fHK5i84VjD65tBVC27HljWlX9eV76jTMO+P/z/Tcn4=;
 b=GApTT2OJeMsjmJcwGgOLBS+zm7hUBJnFYd982Mdu+bo0nSoswd3yCDVG7KKKpUzFZRHLKxzDhWZy8j4u/Mn1bKnIdZyC8o6o+bf5RFyKXZc4UXNJQmDnKLgGrxVG+A+FhDp9WBj1y0lM2dSiWYfmm/vFJIOEWYU7u3q5NlsLiK8m4RLE9IKdzh5HhxJfrxSthJ09kJ1F/UtqvYWIsTmQb/x6cODl9G7d18n6yrS/y3aM6JCmbahz7QgCidRtUPLWXC0/rX6XcIAxreNScrNtQmOWLJqpElBFSdhhDkl+6Khxf1nQ4s+SoMAso/7AHSSS8QUCEaV5IygrmssuqCLodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB6297.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Sat, 25 Jan
 2025 12:22:03 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%7]) with mapi id 15.20.8377.021; Sat, 25 Jan 2025
 12:22:03 +0000
Date: Sat, 25 Jan 2025 12:22:02 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Introduce --no-advice option when a new
 event is created
Message-ID: <uibg6kd2pnpy4ckfxqnrar5a53dfgjfd2dgigbsve3fbanen7k@7hylru3wrn3o>
References: <20241214193452.16627-1-atomlin@atomlin.com>
 <Z5Ld5irdG--_Efgl@google.com>
 <oqon532hz5nktpgilvpmvd5ywuasppbkfw2f6z5gjluyzo62ow@n7ynrou6uykm>
 <Z5PP3vPpYOccGWIv@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5PP3vPpYOccGWIv@google.com>
X-ClientProxiedBy: LO4P123CA0484.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::21) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 7799e424-1a11-458e-78a9-08dd3d3adfff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vkg5WmU0T0I2b1JzejVrY0tGeXE2TGpwSzdEVTJVa1h6M3NSUVBPc1F5YWlh?=
 =?utf-8?B?ZkozYWRLMTNPOE9KNWtFUWJYbEZpMm5CekRkenRpR0IrL3dmRTRPZEl6OWV2?=
 =?utf-8?B?OTM3QU1sUXV5eDNnYmUybmdZQjRIOU8wK2JMSHlWbmlpZThWS29vVkJrYkhZ?=
 =?utf-8?B?K3Z6WmdENGQxR28vZCtwdTl6S0F5MjlqeUc0ME1PZmp6Vm1OWWxpdWNZY1JL?=
 =?utf-8?B?TjBtY3JUVzUxYUJzUGlZUFBOWGpOTGV6UHljWlpVeS9CbkQxYnJkSkc3SWZZ?=
 =?utf-8?B?cnZtSDdsc2E0YUlLNENhbStSN0wvY3RuWEFZTUNJMGw4UVN1M0kveXNKU1A0?=
 =?utf-8?B?M2xCN2xPMnduRHFrdEpKL1dhNmU3TjNCSlB6SkluMnA0T01CZytaOUhxNFls?=
 =?utf-8?B?WHI0R1YvdWNIL3JRMVJpZTYrZndMcUpkaVo2NTNjN25DY0NBdzZqUFJUektz?=
 =?utf-8?B?N0h1QXhia1hGL1ZBdkF2ZzVORk1YL3E5UDdjN1psNmExTmF6RmZ5eGo4WFNQ?=
 =?utf-8?B?c3JXTkFhMU8vcjVqZmM0ZDl4V0dydVhjZnphZVQ3dVNpaUFSRE43aEg3YUNw?=
 =?utf-8?B?OTUwRk9IN0REb2tib1dXa0NMQ2dST2dRRUYxVGFjUm9tTk5uWHB1MWNnencv?=
 =?utf-8?B?OU9jWVZyRmRjc284Zmp1NllkRHY0YmhXSEJiVHRpckl1RWhaZ3JEaXdNcS8x?=
 =?utf-8?B?bytBNmZLM1JsNmNBb3h3STcrSXBPakQzZFp6TjBmaVhVVk9oMW56a09FTzRX?=
 =?utf-8?B?U0pjZTU1ZUhoVjl4aE16R2dSOHJtOTZFRk1JcHNVaHZ0VTRBRjlPMi9KcCto?=
 =?utf-8?B?UGxjZExTNjZKS2Jwelh0MVhOY25FeXRtenZINHZBS2V5cFFkcEcxUnp4Sjln?=
 =?utf-8?B?YVdTTnV5bnhaWDZKdytvSHM5aVMrODRxZ2M1OTU1ODFXSmZjY3lndDFvQkN6?=
 =?utf-8?B?TkNVL1hwbDRCeUlzTSt4cjM5TzJnRW9xWDFGcGFXeUpPOWdHeEUyZEZpSUFv?=
 =?utf-8?B?OEtKSlowVU1iRWY5ODRHQ2RFS29PNmd4U2FaVG5zbEIyaSt0TnV2UlZGUlMv?=
 =?utf-8?B?cTJCODBVd3Qxb3Exd1I0cXJFN0dwSkNBRGFvQmttOUg3SWpnT3NzcGdTaEs4?=
 =?utf-8?B?ZnM3c3g3bWRlREIyUFZHWWVKYWdOR0tOT3k0bW4vWXVKa0Fad25qek5JVXJ6?=
 =?utf-8?B?OEQ5RzRBZWQxa2d6TnBEcGdBZ0VpVkZrYlV5c2dyMjV4cVF5Q2ZDcUZkK2Rl?=
 =?utf-8?B?dEdiaG9PcVYrZUFraDlzdFk3ZExsT3ovZEFrRW5VcWplbGh4WDJUR0tqSU9L?=
 =?utf-8?B?NlFSYUdyY2FVS3FPL1F3U0RWd2E5Z25TRVpyMkdidms4U0JaWUxNekZYOVRC?=
 =?utf-8?B?TGJYNlJDNkoyNEFRVXBTQUM0RzMycjhPL0pYcTl2TTZIR1o2azNDZ2VOV0Vy?=
 =?utf-8?B?ZUZoRlRPNXVLM2JNK2ErQUNNcUUra3lDM0tVSGkxVDJhY1NEUHdaajRrUXU4?=
 =?utf-8?B?TXF0bGRLS3R3dGZlTk5HaUdad1AxckhnclRGeWN3cVlWbm12NXhEYXpoZWtu?=
 =?utf-8?B?VHJLeUlnSHZXNEVZME1lbjBKSk9BUlg3aFRmaU1MUE5xaVRzZ09VN2pyK0t5?=
 =?utf-8?B?d09hbGtrZ1lnVE9nQW9URTJWd2szNnlSN3E1dVdDQVRuTWNUSHFxaU85bW9h?=
 =?utf-8?B?L2ZvTlBPZ0YweUkxT05pS2orRnYwZ0Z0UG9xRWxESXRETklPcEc4MUxmSTlM?=
 =?utf-8?B?VGJiR05kQ25yRnpjaWVZSWQ4NHZlN21ubUM2aWpxYUcrdDBTbkM0RXhHSURw?=
 =?utf-8?B?S3JDSWM1RkU2b0FuNEloVXlubWoxdXhOODN3ZjVoNUE1eng3czkwRkVnd0lX?=
 =?utf-8?Q?gRqABuFRvgdOM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTQ1RTEvNS9IYThvcWlMVlpzbEtSMGN3cFJnQ2RDZXk5NHN5VnVuZG9SYi9p?=
 =?utf-8?B?b2prWGw5K1U5cUw3QjlXOWw0MC9KYTB2UWtQb2VOc1BBeVFzVWNhRUsxMHUw?=
 =?utf-8?B?dTBQVVRYM0dzbFQwNnVaWkVFaHU2MSs1Z3lLQlY0OUloTkJkMHYzcGJ3MnV4?=
 =?utf-8?B?SllRYktYZ29PUUdxRzdWakNyUnI0UFJJMDNZZkFtKzFkQmgwM2V4OFpKaGFL?=
 =?utf-8?B?cnhZdENZTWZYMi9NZmw5dFl4S1k4bnpwMjAwQUM5ajV5aU5TeXRIZklPZEVq?=
 =?utf-8?B?N3pLcCsyRG1EK280REI2UkpYZ3lPWDRsSkZ2Z3JTU0lSYmh0RVNudmJ4YUVq?=
 =?utf-8?B?dklzckRhZlI1SnFLcGVucS9yYWw5R2VBdFZUS3FJVS90b0lsWk5BRWYzT2hI?=
 =?utf-8?B?R2x2b2VLU2tqblByUmdFVGQ1N0hTdEtNa0Fsa0JvMXE5NW1HZ1NFakFIRDZY?=
 =?utf-8?B?M3VxcFhiaTBsaXRRUW5aSzdLckwwZEZvMDRhbzR6ZEl4eG15VlQ5Mm1vTEJI?=
 =?utf-8?B?QTcycXhDL3p4ZmRHYkJvZXFNMlFCTW9xQ3lrMXY2N0VWR3YzODd6MHowSGow?=
 =?utf-8?B?R0hpMkltOUR1NUxnVFA4SCtDNEk4bzVEcEM5NlFJWjR3VVFURjdVMC9WZHRo?=
 =?utf-8?B?bVFRZWkvZGo0cFI1SEV2Z3ZSa05KMit3Mm5sQnl3V2d2YU5ib3RtM1AvTFAx?=
 =?utf-8?B?SFRoTHVCZnNHd1VvVmJWTTN4bGFWRVc0SThpMG9wYUlCV2EzREloRTlZUkFj?=
 =?utf-8?B?b05jY1BLUTRYb0pKcDNoQ0NRVWlTS1ZwQzVCOG5iQ2NjUk5LRk1Yd0hkNWJm?=
 =?utf-8?B?VnNKdzFpL1BhRTVzOWFFUFUva3ljZURjMDFpS2lFOTlOSlBvNmtYUENrZ3h3?=
 =?utf-8?B?cDBSYkQzemZEZStHbUpaL0ttZkh5WngrbW1FSmg5YlNvenFhb3huaTY5U1B4?=
 =?utf-8?B?NEVoWTJycldwSDFCK1AvZ0ZrNWhBNkhxM3hwQ245dGJyVElXSmQ5RWkrZmZ3?=
 =?utf-8?B?ZlVSR3FMRUloeXBhS2FYYXplTzFoZXdRMnFURi9IN3FnOTRKZHFCUUhXcCtI?=
 =?utf-8?B?ckZ4UHYwMTZ4Q1VGZmZablVUVEtSeVEzRWd1dFZyUWxLWVcrbkVDMTBVbmV6?=
 =?utf-8?B?VlRaVkZPMEI2TnZvaEhKc09VcGdxYnAybHNHRm1XOE5CclFBS1BudTQxdVpT?=
 =?utf-8?B?NVFiMDlwcE5mNmNTNGVtZWRMOVN2TkdrcVFpKy9RVDFXRC95LzJwZjBXUGJN?=
 =?utf-8?B?anhlSllhV2FwZ2VXNHdBUzN4UWw5cHRwS1lzSnFsMmg4ZkN4U1ppb2ZIdFND?=
 =?utf-8?B?T1NhbmQvV0c1cVNMT3p6V2N6MUlGVkV5aC9JUjhhMlkxY0ZmTDNoSFBmM3dV?=
 =?utf-8?B?VEZTaEMvUHh5R3Z1dEdMWEpwZWl2dXBqcVJSSlNsb1BtQUJMWkwyUjFCV1g0?=
 =?utf-8?B?N3J4d2VwbmRadnZ2N2tHTTVUOG1FS3Zjdjl2cUlkd0REblpZT1BrMTZNYU5N?=
 =?utf-8?B?Z21UMzZtaUJGZ09Nbzl0UkRRNHovT1BPczgvWlNtL1hjZTZDZzFxQW9FL2po?=
 =?utf-8?B?d25jM3MvbWZDc2V2a0Q0TXhjSW1rTHA0NW90eVZ6M2tiQnhvb3IzK0pYMGRl?=
 =?utf-8?B?MTFESkVhZERwamROTmpGZzNJREdBLzdFTGVKRjc3Q0R5V1dRREprT1Q1U0lr?=
 =?utf-8?B?MGRDUWkyZG50dXgyMGZPUGNMcHpsT2hnam90RVdUTTJjU0ZZZWhuUDlkeXZL?=
 =?utf-8?B?VXBxVXZqVXJDYmFDK2FuUFIxV2MrMU1GOVV6ZGdWY1pNcjQwdWkwNS9tajZv?=
 =?utf-8?B?bmZCZlErMmFQc3FiZmVlVWdLV0hvU1FqdlhaaHM4Q1pGcitmaitSRkk3bXVz?=
 =?utf-8?B?eUdrK01RWGE3K0ZsK2RXdU1jcE1FZWhVQmR5RTBCTHk2VVhNbTR1a3NzU05E?=
 =?utf-8?B?c1RnQXJ2aW4xaThYWFlXOENDZjZrSmFVWDIyMmZ5Q2JWSElJK3NoQ1oveDZ4?=
 =?utf-8?B?c2JTZk5zdzNuaDZKcUJwWEJiLy9aSS9zcDFleks3OUxSbzZyeUJFNDhGM2VK?=
 =?utf-8?B?dXhsZUd3TnU0c0JCb0c3YWd0VHpZUnZIS1RvRVE5Z0IwVXc3RStHbVFEMkhW?=
 =?utf-8?Q?Hl8jlCpJUJYo0YysMn4OkUjaN?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7799e424-1a11-458e-78a9-08dd3d3adfff
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 12:22:03.2967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pnnSZaEoNhZoUfERb2P8MsFZ6wMNiiWzIi57F/OJL8nRfrEzpmZhGbipFu3a+llpVVPPzo5TUraOo9/4FaJZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6297

On Fri, Jan 24, 2025 at 09:37:34AM -0800, Namhyung Kim wrote:
> Sounds like you may want -q option to suppress all output and check the
> exit code of the command.

Hi Namhyung,

I will prepare another patch.

-- 
Aaron Tomlin
