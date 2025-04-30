Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989FD21D3F8;
	Wed, 30 Apr 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003746; cv=fail; b=aNg6fAjZcxL65lYw0H+Zh5JYPrL37QDAMmbXo1tJwQJWZXUZ51iFRG16IWGlWbWlbqG+wzbClaR6Di/ctUxH5Rn5tCM5UJsNrLtJJodzOvSbZ/w0FwVccspMyT+8stWIYm+XsvZGRKzAI7gdl2H8qlgc3l+MMTQcJJXrnq8a+oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003746; c=relaxed/simple;
	bh=blTocDIxGONn6VZ+SoN859of5K/QPjBtW1YcnyoaHjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jl+07Qr0qaE3kHi/F7nGzEL4M3/NCBDTIrFiTf12a5b7EwsLrSm8j62LNgYMl1icvTK2t3cSaPODZELHex7uhVYDtdiVcBSnZU8SKQhHEaIJBKO3qWmJmqUqNwTUr0+jN24lr5IU0GPriREcJw7KfCFbvtKV7lRcwgV8iSik1i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BSViij7u; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BSViij7u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6e6MKWZ4caKdhPHB4/39lIxZn3FI596oIotB5G0Vh6RQiO9YK42ipMngaaVPtANxFdg8GbtLzt7ArSvBUQKdaw+3V3v9FginRecG5Xa8FNjklYXoLg0Dt7Xqhj65/PEvQ7gRTGVTm9X5jtPsFV88SHg1c9xE26NvOOAn/ycdRqCf1S4lz81nEhIurQ7ytoYTLZXEOIsxpmpTBZnh853Im2RZaSvnNEoztDO62S8TN8d+XbQ7HY3UNUSPT5q3RtkccJ1DPtS0SJw4vxEOFkxHq6AwrRzzRpXnM4hcCF20GnvFoeTbXG37h7cLwhsENLrCRgku/X7mKu0O9gXmdkzMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2/w+Is32IyIl2SgoI8w+rwTT5eRdEbNnc6USKguSu4=;
 b=ibtUvKCIN/GlZqWnklw0TlVIwZLE3EgrryfZ1XVOfoVyEgusmDeB2KdShvNQ0SHZ2Z5+jhavdBXapF6ESIRODADuck6fNR7V6y6Q5FLjFx3MUZk3QvSlWDEt+bwEkVp3IYvynCVUby8TBBq3bn9EekYnGKYvyK39nAsmbldnnqw1dXcIkpxRSEG/8gBc/i6on6LP8RE1P5w29cC1pTiq11aAejyKacCsqhbU1d0gpMb0A8TPG6njAmy9YHU2YWt8QK/LQGSaJYEVsY7IOG2IU7zPCffTPtAsM9KHWk6W8fpil5/DiiQLih0rMsSAiu2bQsuoYMCXzLmDhNJtH5x7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2/w+Is32IyIl2SgoI8w+rwTT5eRdEbNnc6USKguSu4=;
 b=BSViij7urUXSs5l4edqy+V+txnHZb50R1fJ+A0Cl98WeCH1vfwKmjanbsMqSX9B5T4J4g6cuH6GUjZOvX5XBNLJBkGfC6HpNOj9hqqv4k1Tgp9MP9auqWWLBbZ+wKPR/GirEvSD/wr43aYTvNxg7r1ZJ4v1jr3gL+PoCkgedCS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 09:02:20 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 09:02:20 +0000
Message-ID: <4bea7b8a-9ff5-4ae9-8154-57ec7377ee4e@amd.com>
Date: Wed, 30 Apr 2025 14:32:12 +0530
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
 <aBF5UWrxvYgbnxde@x1> <aBF7ZarWJvzeDKqF@x1>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <aBF7ZarWJvzeDKqF@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0038.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b8b909-2fe7-4976-3916-08dd87c5b6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXFwOW05d3ZSV3JZZktLYWdRUUJ3ZVh2LzlPZyt6a0UwREFMRllJMEUvd1pJ?=
 =?utf-8?B?MlRvRWJxdGcwM1VlSDJwWmhJUG9sUTd2T2JIQ3Fxb0tFclV2bmh4Q3FXaWR5?=
 =?utf-8?B?ekVjYitLOE5wRU9GV1IrQ0tvdkxMRy91RUpXRjRRL3J1ZlpsSW13TllSN21a?=
 =?utf-8?B?ZmtUM3JMVzRxY3pIdkFTVmVNRm03dDRPaWx3eGpDR3psRGUrMmx4dWFSdmJ0?=
 =?utf-8?B?dDA4OFhGb1I1Y0g0Ymtrd0ZKY1p4Q0YwQ0dTa2dsRHNjNUFodFRrSXZ3T3Js?=
 =?utf-8?B?VUNuVTF3T28xbmQrVERtT1JYOUJJVzRKY0hudFJLMzJyaGZ5ZWpNZThGV0hq?=
 =?utf-8?B?MW1UYWNPNC96M0JvNjJqUkJVRW5DNW51dFh4ekh2Y01oWXZXVHNFQ1ZJeURV?=
 =?utf-8?B?OC9LcndqRDNESXowZ1UyQnlVYlZjcDVvVW1Wc1pDWHhGd0J1MFFpN2lnZ1hl?=
 =?utf-8?B?bG9qZEVvaVJSWGxZa3FQMkorN3FOQVc5NGk1YjA1Tk8zcmlzSWZvdG9PcitZ?=
 =?utf-8?B?cVFKUVVvcXh6clNidFNjTExraGpIelVVOXJubURJcTU1UUJURTQ4VEFhWU9D?=
 =?utf-8?B?SUNmSGxWSU44RWx6blo5WmNSSVZ4aUZUZjZ0alFrQTF0cmw0UXFicVFKVzRC?=
 =?utf-8?B?ODVsaXJEZ0wrSVR5Uy9qZGNZbFRsWTUyMFE2dTVEbXlHenlhOFVMTm9nY1J5?=
 =?utf-8?B?Tlg1Q1MyVXIzcE9lN1ZiRk5yc3FBM3puY1JVc0lMUjcrd2pNRkk4Z0gvREdW?=
 =?utf-8?B?QktZQmtIbnpXdkhzdDh3Y3VXZW5LQkZTMWE5YTZHa2VVOVgyaVFlNFBJaXVi?=
 =?utf-8?B?VEV0NmhEQUxRRWdRUHVZN256R042WFZvaUxKWmRFZXRhZXNzNW1jOWRPVWg5?=
 =?utf-8?B?R01paVR2QWpVcmV4ZFd2dnhNeWl0L1c2ZVdpTmg0bFFNcGNKS0lXV3VLS3hS?=
 =?utf-8?B?UHEzL2ZBMkNLYjE5RnZNM0Y0OGFVVVkyVVJQMUhsMHVsMEI0L0Q0dUVVK0hM?=
 =?utf-8?B?Vi9taUpTSUJDSlYrQTNBWldOYjcrdkFGRitjaWo2WHhIUW1xSjAvSVNwaHpI?=
 =?utf-8?B?dFAyUlhUOUUyaWFicGpCbGtRK1VnNzZWNTJSeHNLbEZYYzdFVlZKZEI2bC9L?=
 =?utf-8?B?Q3BYRWdVQ1hhak41TEZpWXdrdytTbUhZenBRYlFiSm1WemJodFBHMVp3U0lE?=
 =?utf-8?B?am9VK0JnUXlPeCtDVDVDZVhHYUpZVmxYVkFXVHFkcnJ2WHlJakVaeVBxU0Rs?=
 =?utf-8?B?L05IRFpPSkxLWnBjQTVscmwrRU1rbDIrNVJDQytEbVlOYVJub2c4aGI2UFlq?=
 =?utf-8?B?NGxETU9IU1QzUzJYQW8yOE5ZRzFMMks5VFdTWkYwZWhub3IwTGFKYVFuN01r?=
 =?utf-8?B?c2tDUGJyVTFSM0cvV1llV1l2M2ZiaTJsWTk1eUFkTHdjVHlHdWxnMU84Qiti?=
 =?utf-8?B?M095aWhiVGlFYVR1OXplNnA3NnJYb1hER00wb2dSR0p6YXQ1aFRzN0NxZ0xO?=
 =?utf-8?B?MlUvK1V2K0cvMmhOcUNsbWxUbWIxMXNycVVtRnVBVFhlMTVpUnR6RXBKZUN4?=
 =?utf-8?B?NHlSU0I1anMvbmlMano5dThFREozd0o2aEdESTJaMnBoSXVNRzUrM2FJZmli?=
 =?utf-8?B?K29LNlJOV3NiL1NnWDU4N1o0bXR4RWkvZGsrM3IrRjUydjlRMVdRS2ZhMVY0?=
 =?utf-8?B?YkYwd0NDMXRGdy91S3lLdnFFZWxNUGgyWnJsamYraGh0TTdkcFdUKzFXYzVZ?=
 =?utf-8?B?RkhPd2JVYm5QRFE2SDB1UTV2VHJqUVdtYUJaaThrTjBuMlk2UGhPbXNRTFpM?=
 =?utf-8?B?RTVkMGNhNHVFMEdsSnRRdFJIMHpSWCtzNERiVGFhNTdGL0RvRGpjbmdMcGxT?=
 =?utf-8?B?ZHdZSDdMYzVIbEU5SnRSVld4RTREZ0UzcmI3eFJiOEkwOGNUL01nR3FlcHA0?=
 =?utf-8?Q?lzDl2glbf7s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjhjV29lVWFsUmFLZmcrYmVRN1RaSGE4R1NsUGJqUE5QTHpKMU9sT3Q3K3No?=
 =?utf-8?B?M3JTNzA1YjR5U2JGZGZOajlTZ3ZuaGJSQmw0TTBGQ2lqalhLUkNrUS9BbjZS?=
 =?utf-8?B?YXRrUGFPa2x3UEtqb0s2OU0zWDczODhSSFl3QVFDZm96c2dacG1HbkxUbVR2?=
 =?utf-8?B?ems1dEFHWGloL3ZKcmFpci9MTSsydmN3VUFHZFd6OHN6UkFKS01PN2lhZnNC?=
 =?utf-8?B?WWh6bXdTM2krdllIZ0RISFVmUzkxeVBYZk00ZW5mcVNFVU9NU3FITkwyT0Fi?=
 =?utf-8?B?TThtUXF3dEVOS0l4aFJXQXhTbXNFekdPTUxnckpKMjRGa3NrRDRvdDZoUnNH?=
 =?utf-8?B?Nk9udVBoR0dqaSsveDE2SEVHbXZMS2NuM0NwRzM5eEgzNVluNVVlQlBIQzNM?=
 =?utf-8?B?aDVId2Y2aTdFd3ZRSFRWVWw0K01yTmt1N0ZaT0hZZWRvVjBBZ0xEWjFhRmZF?=
 =?utf-8?B?UXZaQ1Q3c0UrK0hzcGpTQitMdk15dGdIQThxZ1REUjlhdWZTTHdyUmRWQldG?=
 =?utf-8?B?L3FwSXZJOTNmaXRsMXdjUEk4KzFXcnFmbHorQldNSzNyeXhDOHFNbGY1YVR1?=
 =?utf-8?B?bmZhNXp3QlZVcUJySXB2Wk9pNTBLU284RENCMFNobzNSNHRSdGk4NXB1NWJC?=
 =?utf-8?B?clNONUN3RGdwTGZxV0hwdy9HK2RUcUc3cy91bzcrWmFPb0xHb2pUd0dZVUls?=
 =?utf-8?B?UWh2VTFjTzFkQ2RkRVZ4ekRNWXBPcWNYV2ZCSXVWdXR4Q29BWkRVTmtJeEVr?=
 =?utf-8?B?cWd1bUdEcjZiYnFPc2l2Wk9nUWdjQ0cyUFlUNzgyV0RKZlFuYlBWc205eEhD?=
 =?utf-8?B?dkk3WFNNN3ludEV6RUlUdUlqcnZnT3JoVkFMVUFIR2pCejRwZ0MvcXpqSnp5?=
 =?utf-8?B?RFEyNGlNemNOTkpHdmovMEttSVlwNXFmMWhnMmlOd2xDZThwVVRSVXV2Wk9y?=
 =?utf-8?B?M3pWOStEUkRtamMrUlphbUJkdDZnMVFWSnVYUDlpR3lRcjBNc1lENlJLdWxR?=
 =?utf-8?B?WVdRLytYQ3NOWUZIbGpYS1d4ditkZWJDbFlzNlBJZEhnUzlUM3NOUkRTajNL?=
 =?utf-8?B?OFlJWmdSNklYWkxpUjZ6WENEQmhvYzB3MlRZdTZSQ1ZTNEhRYkV3YmIzT2pJ?=
 =?utf-8?B?aEdKTi84VWdUczhJVy9yVDJxclZsQVRvWGUvTHQ5MW14Ylo0TUYzSDh0eXha?=
 =?utf-8?B?Q1BRQ01pR2J0Y1Y2N3dENDNudVo3azdkZ2x6RjNCV1VBSTZUeEdXdG1Ca2tn?=
 =?utf-8?B?L1dITURPQll1UDBzOTczRExQWmM3aXRZdzFwNVk1VmE5Z0pJak1Mbng3eFFa?=
 =?utf-8?B?SWN6THhKUzhhOVFkV1kvVDBlVXJ3ckErcGg4Nmk5NEJWRWd1YXUxNVpqUDEy?=
 =?utf-8?B?R29IS3FGc2lnbW14Z3plREFTRGI0cHI2R3RhdS96a3ZrM3pLWjlBdG1Pd1Vj?=
 =?utf-8?B?RWtuMHIzT1F2NTc2dDJHc244RFo5amxsNDhTR0NsYkV5L3FyOG5YaUlQUnNI?=
 =?utf-8?B?WUxMQng3VHdKbnd6LzBIUW1scnFnclhrVE80VEZiQXhPVzQzQUp5NUhNaFRn?=
 =?utf-8?B?bkdIelYzQ1ZGeisyWUxuZ0lMVHl6UlBvMUhxVEpvN1ZHVmZSSlFlZC9lcWQ3?=
 =?utf-8?B?R1FPT20vTHBiVWI0RXBYekpFcTZYVnBIMnFiK3h1S0dDZlc0Vm1EVzh4MEFs?=
 =?utf-8?B?bmJsTVhXejQwUjRIb3dHRjZqS0IrS3JiamV1aS9rNmg0enNuTFNVZi84TmtT?=
 =?utf-8?B?U08va0VING5HWjY5YmdlaFFIdm1aM3RsbkVCS2VkYjdPSktUdkZmZGl6T2Qy?=
 =?utf-8?B?Q0NNZEpXTTR0K0ZnT2NYLzFPdU0zOXlEYk90ME5GcG5PYnhvMVZmMis4Z3Fn?=
 =?utf-8?B?N2NSeHBFVGIxTUlJRUxGc0ZrTTZKZWNoalF6enV4MEJhSjZXTDBTMG40ai9J?=
 =?utf-8?B?Q1pIZlNia2U4ekozZ3BEYTYvcllMeVljTFFSM1o0V1ZmODJGZ1RvcHZ4WFFi?=
 =?utf-8?B?OFd1U2NYUzh2KzJ4S1JtTUxiZm1zYzU3aHRvdk9TOTJBcHZqQ0kvN05rMEpZ?=
 =?utf-8?B?aG9xK1dqRDRpSVMrWWpUM2pqOUw5Z05oTCsxc2Z4R1VYZTMvYkFvZlNpaTlk?=
 =?utf-8?Q?uJgef6gwDULmn/+8u9xRksqCC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b8b909-2fe7-4976-3916-08dd87c5b6e3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 09:02:20.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /t95Pnos8KHbOS0grdg0R95iwj+GzFm873BzffqNvNkKupkIKZJrmnkf9o9neMRvIhlMwbVbYtg7Vaq1edsQMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452

On 30-Apr-25 6:52 AM, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 29, 2025 at 10:13:53PM -0300, Arnaldo Carvalho de Melo wrote:
>> Adding the patch below cures it, still need to test on a Zen 5 system.
>>
>> These issues were just in the regression test.
> 
> BTW, all is at the tmp.perf-tools-next branch at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

I tested with few simple perf mem/c2c commands and it seems to be working
fine.

Thanks,
Ravi
