Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E905B20B7E9;
	Thu, 10 Apr 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274427; cv=fail; b=JS8KheNEJ8bGrU4YkXu0kxj46Lt0C0RlA1fafZ47csJAmGkCHm4lELNh5glepaTNt0MFuiwN33418F91HkRuhODTsYtl32IXExIDhJMkU2YpQ2MEx3B60YE5vD8OMf9dsHRLFuyxhkrUyuMIw8aUrxwNFaO1KX0G2hVQi6hReI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274427; c=relaxed/simple;
	bh=oDYnnqUama8ua0DnW2XbYYbbZNUfx0Q52cuT26h9xxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hIw5inF0IL8cqDp3D6ReuPAKVMkvkED2ydVMTweRVL0q5Mis23OpiN9/1/aXTD0U1T9d5n14OLTnDH4tgVz1cBBionqCPs4KepognSaM0qroJkEZO79FoVRLegK6u/Ut1M/FWp0Z+1jTQvljAuf4mtC5LiNyJi6Y4sfqFVnFDR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=40duJJud; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="40duJJud"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cym0G4V8zvtKDp4J2pbFhdl1JrkuIcZiumzOfFuVpL76sPzohu/wrdxKIxNCEylSLRuTOR5kidcCt0ZtQ7til3RWOg2vlU4HJUhR02q442MS3HGEz87cOM8vd2xB8Mc7TbmvtZY1Lqgf+kG6ucMjPrj6S0TbkOT+RX6b4OX/mV7hTqdlCo85vo2jRJZd1krlqdFoIYVzg/epQ/EgAenJBR/kr9H3NCP7QNdiWqs5sqInXusvc3FSScE4j3/EPXxZ6nJen4kDsQ3zRKga0eg2fslx5G1GZmh+gDD6Z8wy5HNG6Dov4JoJTf3MWGySMTU6Er3JxECuV3WpvMGtKtWSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acQ4mRaWBw28V5Uh9QX3DNjSzqH24ztLIG73T99SIA0=;
 b=UzQboY2Q4NqKKsWijO2+vj1/UTPi9eN126T895G9KLHcRWyRU384UsoQsCoBY8gGyNElaY9cH44WIbAV+/aeOMPZhGZ6KGZlWPj7nIWzyKZ0LkSb13NRocigv4PN/HiVg1H7osmvg//75gmLTE7dPvj1v5cXYhreX3kZXn9KPYhF49VdFl6gQC1CUaoOEf+PufXg6uo2pGcnz0L/WGKiFrFop4d7KaMhl28RRjRXyeTaPU1VcZialIU2a+md96Z608xls+KSxZ9UZ3qMnVA4PStqAIMFsDFEIvF1HhzJclsAIFaTLn1c/DlXfEMzrXLxyx+1IkWHvhD2jzG8v8wR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acQ4mRaWBw28V5Uh9QX3DNjSzqH24ztLIG73T99SIA0=;
 b=40duJJud9nPU258QdUTu6rPpihNacONjarUlwrvV4ozXaRNYI7CIAtMADLpczUrat32yqh5Fd5wNSU+aTjfhs68yPY2qunCZv+sh8Q3M98IDIDwh4oDwxzCBC+C6H1ek76vb4Dlwyn6gMmyemwg1pbVBk7o/e88f98OpsamDsNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Thu, 10 Apr
 2025 08:40:22 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291%6]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 08:40:22 +0000
Message-ID: <083586a9-8717-4cc5-aab1-a7f40e6e8621@amd.com>
Date: Thu, 10 Apr 2025 14:10:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] perf/x86/amd/uncore: Use hrtimer for handling
 overflows
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, eranian@google.com, songliubraving@meta.com,
 ravi.bangoria@amd.com, ananth.narayan@amd.com
References: <cover.1744184837.git.sandipan.das@amd.com>
 <f3a7703c22e6734f0d1bf34bc56be3124f818a8b.1744184837.git.sandipan.das@amd.com>
 <20250410082041.GY9833@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20250410082041.GY9833@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::34) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 976302dd-a27f-471c-4d12-08dd780b54d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akJLMHp5L2cvemM5NEtoZDB1ZXZOVEtiYVluYXB4L2t1NDl0OE5XdHE4Njd3?=
 =?utf-8?B?NEE4SzhLT1F5YmpwUGt2S1pIekVFNzgzY0x2RXVpY1ZFWG9XcnZ3NU5tUmlZ?=
 =?utf-8?B?czdjNFhLaGl6Qk16eFFqeXZ5aStoemlWT3M2ZDQyeVpHajlyTjRGMWFiM2JM?=
 =?utf-8?B?OCs5OGtUTytOcDNINUxzd3lZeWJpdmxWK083dkVQWVA4WkVNRkNOZmxSMUl1?=
 =?utf-8?B?aERlbjZ4dFU2RE9SNDkzNUFqb2hmUDIvekR6ak5hb3dBdXVpL2UzNUxrUWU2?=
 =?utf-8?B?c3AyeE9hb0JDM0ZKd0lTSG5LSkY0bWRuNFh1NlBNelc4bUtYQjgvN0EyYmI5?=
 =?utf-8?B?c1hJc0FyVHovRHp6NmppSlg2TXcwcVd0Ti9LMkY2Z21XeW4vTkM1SlJpVEdR?=
 =?utf-8?B?UDRKcjFQN0g3SXV5WEJ3cTJ0TlFzOGJLNWJIRDF0bS96UFQrdzBpMERuQ21Z?=
 =?utf-8?B?NEJqTExxcExJcnFGY1JrelpoUGUrSURpQ056WUVKa1JtNEt2VHNJV0xUSGtC?=
 =?utf-8?B?UHcvYXFNR3htVVN1WWpNWmljd0lndFhpQzh6RzE0ZlhYa2ZnV0hHMTN3c1lE?=
 =?utf-8?B?WUJDK2RDOHhNOFFnaElFRU44SmFyWHhJVTNzMEQwY1lXSmJ5T2Z1cTVNbWlW?=
 =?utf-8?B?c1lTMkIrOFdnVVJoQ05nNVduSnk0QTR4NXhGZHg3MkVDM3lUVmJSZWtDQUJr?=
 =?utf-8?B?YXhPamFMN0ZDL1lab1JSV2ZNL2pNdlF6QXU3SDdaRHlMeFBtNWtmM1NTNDQ5?=
 =?utf-8?B?OFR1ZW1oU2owUnQwNTJ1NUZmR0hkMC9sdTdCSElEaXJ5cTNsaktFSno2WGxI?=
 =?utf-8?B?dU1FQ2hWM1RoeFNYc05kbCtyMjNWV2VtWk1JZ3RFVTZ5cnpOemJ0SVVKRWpp?=
 =?utf-8?B?QzNBWCt6OHBkRS9MdnFEVVJDSFdYU3N6ZnA0VitiM2VUZlVrVitLZ05ZRnRS?=
 =?utf-8?B?YmxXWFJidWNqMGtKd0Z1Z29ZUm5LRWVnQjBMME96WjAwNk9lV0I5YWZPS3dF?=
 =?utf-8?B?ZVU4UWdmWWQ5aG9kTlV1bTN5WENFMVcrYjA4TnRzR1VWZzFhbXpQWklYYmNQ?=
 =?utf-8?B?cWJvNmtVbW1qVm5ZTGkrZVhNdEd2cnI3V3JkSlcxa3NuWmlKaEk3VU1iOFdj?=
 =?utf-8?B?RUVVRjd2S3hBN1ZsNndvQ3dRWEtnN0psbUx6TnRRQ0twcmlsU3R2S3NzaEJ0?=
 =?utf-8?B?cFBvYjJ6ZGlxSUx3QUNTaEFWQU1HNUFoRmp6VmoyRDBnNFBiUTV5NjJlY0pR?=
 =?utf-8?B?TlBOSWlmTTc4V3NoSlRUQkkxYUs0K3NCeGZUQm1aYTk0d014N0pSUzE1MmtU?=
 =?utf-8?B?YnkyMndkMkY5MXdrbDlNL3RYc0swQ3BhNitVK2FaSVdxamo2UDRyOWsvaURv?=
 =?utf-8?B?OVp1Z08wTU1aK0RxK2ZBSVpjaTQzSGxpNm51QnljdUdCTFRvWmxsWjlKTjdE?=
 =?utf-8?B?cWVEenlBdEtJU0lEbWRRc2RGbjQ4Y0hOR3lBczlRQWxCbWc2bWRHRW82SC9V?=
 =?utf-8?B?Y2o4bWxsSE42VDdvTm5ZTWRWNndyUVRPbitjTnM0ODIxMTIxWlp1Uk02YmJU?=
 =?utf-8?B?TGdPTHRzZC83TXZSbkRaekNuQmtDTXJRZ2RnWnNlVytFSlZyeXNtT3dYMzA1?=
 =?utf-8?B?Yy9iR21iR091ZUdhQTlMbWdEa0NRN2VWZExEV1hkbmlFUnV1NlM4UmdKUUM1?=
 =?utf-8?B?KzdWMzBDRmk0eERHOGNmVFVOcjdzMXdJVDgxYm5mU2s4eWVuYlVha1Q0R0xQ?=
 =?utf-8?B?RGVTUGZFUFhqV3gxMzZ5UkdlenVnV0trQWJyUTdKOWlLWm1TNVVnVWVxa2ZS?=
 =?utf-8?B?QytaQ1FHYmRta1Zrd1RuVG5BZk1xcFpacjBGNnBGdjQ4RDAwK2NvWTU4STRZ?=
 =?utf-8?Q?W+F553/+GLzw2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEF0SzV6dWcrYk8rSG5EVm00VlFvV2o2clovUUJINXlsNkVHRG52amtVTnBX?=
 =?utf-8?B?ZGVISVlUNnhwWm9BNTNCZytOTTJRc2t5aUtXUXRqdWtQbk90V1Q0ZXJHNEJq?=
 =?utf-8?B?RnRpU0s2Z3dQeHMwVUZmMHhFVGx0SlA2TnNtc2g5cmFBc3ZvVlVPOGpYOHF0?=
 =?utf-8?B?YWRpczJCWmdPMEFGSjcwV1ZWK1M1bFZpM3JCSXloUUpYTnUxWmp2UFR1bzVU?=
 =?utf-8?B?MFl5eFUvaG1DWm1FdDhPYkZtcExpbVhEdWhWc0FWWmFtT25LUkJkS0lhRGQx?=
 =?utf-8?B?YjBPNEs3b01IVkFINlVHYjRjSmtpOWpnYjZiWEFIM28zbzVnd0E0U1RuQ1lN?=
 =?utf-8?B?Y1ZSTFBpOVdocHRYMmtmaGE1Y2ZVZHh5UGg3U0lJQXZJbXhIdDNBZ0F6VlBY?=
 =?utf-8?B?WUExQUxXN3c5SmcvYUhlVmRySWh2emRDMklDTWQ1MTVRVFJ3Z3JSWkNueWZq?=
 =?utf-8?B?ZFFVSzZva1BmODkxRHZRTFBERVRiMW1LbVhxSSsxZmhyb1N2bnQrV1ZRN21I?=
 =?utf-8?B?eWw1Yy95dmZvTlhFWmsxU1RGZWpNQVFXOHR5cmFPbnNheU44U3p6MktYVWNZ?=
 =?utf-8?B?R2h4UFFRU1hKNTdHOHdhWC9yNmFva05lZHRFeHp5ZUpjTVJFMkcrM0Rqdy9T?=
 =?utf-8?B?UTVtc3BHZmU3S1VuQUtkbXAwem5qeWJuOGgzdGphZ1V5Yyt4cWlEM2FTMVlO?=
 =?utf-8?B?Z2FwZzE4RHVYUEwzdGkzMTg1OEpoSkpwbDFCZmk0ZWpuVFVwelE2RUtwb01Z?=
 =?utf-8?B?RzhHaGI1VkdWanRqV3VxUGRsUERUd1VNaXplSXQ3ajhJdVFGYmFLSjJSbW1K?=
 =?utf-8?B?bCtuZ25yZW1ZLzhsc21EWHE4RFYrTE8yUklwQlBmV2JGd05PVHRNTVAzOHNq?=
 =?utf-8?B?Z1JMSjNyL0VWTmdEaHpTQldvdVVnREdOS2VZYnJTa0pnSG9KYkcrUi95ZitP?=
 =?utf-8?B?a1ZEK0V3VkQyampnUTBpb2pjRFJzRGV4UkJkR0VKV1J1MFYvd0YrSTczZ0JZ?=
 =?utf-8?B?ck5SdlRXYUFaaUpmMWZXRUNjc3MycURmcXNSN0FuZkZPOEhGQzQ1c21qM1Qr?=
 =?utf-8?B?Qk1ic2RIZXhVM3p1TlBoSkFrcDVVK3hDVGwyanZNSFZsbGo4R3BBSU5CQ3Bo?=
 =?utf-8?B?dVc0TmlXZTFNd2huY3RVaXZxZ0t6QjIyZ2dxOHRSWXJnOHRIbXIvQmF3S3p2?=
 =?utf-8?B?U1F0VzVVdENKbG9uTlExWmM3VGFkYXUra0ZZVGU4VkxIbVRqMGNQcVp2a2VQ?=
 =?utf-8?B?MGllcmtnTDdUY0VkcFJ6c3NMdlJoNHRkeGJmYXRlNGV2SG82RkNBc1FLNDIw?=
 =?utf-8?B?OVFDazJOaE8zT2JLK2hZY1MwSzhQWmJrSEh3QlAwVElCMk1rblhZdCtTWS9t?=
 =?utf-8?B?Mkp3bXZ5a2dUbWZJT3BBdTF2YWRmaEUzU2U0Sk82K0paVEl2THN2VVlFbVN4?=
 =?utf-8?B?d1F1aHpNWHI4emtpc2RtUTllbG9vSXNHbHBOWlFMaGFWdzlkRHJRWXVSQTB3?=
 =?utf-8?B?c1ZPQ0ZFTVlCdkNuUDVZSFpRc0VNWFJOd1pKb3NiWWFLREVrQmVWbENHaVJD?=
 =?utf-8?B?b2U4N1ZKeE1HREQvSW5lRnFSTmRmMldRZCtwTFg1Mk1pUGlDeGVzcTM3Nlpj?=
 =?utf-8?B?YnppKzBFV3pxNG1BdFNvWGtKUDNQclluUHRVMjNkanRuTjVQL2M2bDU0TkJP?=
 =?utf-8?B?aHdtR1hpNUNlZlNFNTVaNjFmUVZXaDZUMWdWb3VVRVBEdU5qbEs1MTZIUGRy?=
 =?utf-8?B?YjFvL2NLLzBhRDAxbWJHUXJuU3FXdk54UDJXcVZrVVQrT1JHbkpvUkRWTng2?=
 =?utf-8?B?ZSs5bGMzK3dONVpxa3gwN3dBWEZwYVNWQXhERnBwL2tVei9oSzBKSFFkS3V6?=
 =?utf-8?B?WG1HZGNhaHo1M0JBaHViZWFYOHc0OTFId1l5TFpyVk1KamZ6YUFsK2szcXJt?=
 =?utf-8?B?OHZzU0pqdStsZ2tNdmhPa0JBMXlsdFd1cElSS0xZMzV2MU1oYm1ZS1RWd3lK?=
 =?utf-8?B?eXlicHVmUFJCTHFhOGlzNTFJLy9mYytvdjFPSmRFQk50YzhwdXJzWGxLVzAx?=
 =?utf-8?B?dTlJRE9IejVXdVZoTm9OYlhOdzZ5OStnSE9JdXFyRXowOTRGaDFaMUMvRFNq?=
 =?utf-8?Q?B33wYFk0w23R9eD1H0Z1Th1/P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976302dd-a27f-471c-4d12-08dd780b54d7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:40:22.3700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CH7Lk+5DlScMBQZFGolOGxak+vDJofYHEd7dY8to6bm/CJQypIlPtVbustPnkjYcZJyWWYXiLwOSfZ4jDgb9Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742

On 4/10/2025 1:50 PM, Peter Zijlstra wrote:
> On Wed, Apr 09, 2025 at 01:27:07PM +0530, Sandipan Das wrote:
>> Uncore counters do not provide mechanisms like interrupts to report
>> overflows and the accumulated user-visible count is incorrect if there
>> is more than one overflow between two successive read requests for the
>> same event because the value of prev_count goes out-of-date for
>> calculating the correct delta.
>>
>> To avoid this, start a hrtimer to periodically initiate a pmu->read() of
>> the active counters for keeping prev_count up-to-date. It should be
>> noted that the hrtimer duration should be lesser than the shortest time
>> it takes for a counter to overflow for this approach to be effective.
>>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>  arch/x86/events/amd/uncore.c | 72 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 72 insertions(+)
>>
>> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
>> index 010024f09f2c..ee6528f2189f 100644
>> --- a/arch/x86/events/amd/uncore.c
>> +++ b/arch/x86/events/amd/uncore.c
>> @@ -21,6 +21,7 @@
>>  #define NUM_COUNTERS_NB		4
>>  #define NUM_COUNTERS_L2		4
>>  #define NUM_COUNTERS_L3		6
>> +#define NUM_COUNTERS_MAX	64
>>  
>>  #define RDPMC_BASE_NB		6
>>  #define RDPMC_BASE_LLC		10
>> @@ -38,6 +39,10 @@ struct amd_uncore_ctx {
>>  	int refcnt;
>>  	int cpu;
>>  	struct perf_event **events;
>> +	unsigned long active_mask[BITS_TO_LONGS(NUM_COUNTERS_MAX)];
>> +	int nr_active;
>> +	struct hrtimer hrtimer;
>> +	u64 hrtimer_duration;
>>  };
>>  
>>  struct amd_uncore_pmu {
>> @@ -87,6 +92,51 @@ static struct amd_uncore_pmu *event_to_amd_uncore_pmu(struct perf_event *event)
>>  	return container_of(event->pmu, struct amd_uncore_pmu, pmu);
>>  }
>>  
>> +static enum hrtimer_restart amd_uncore_hrtimer(struct hrtimer *hrtimer)
>> +{
>> +	struct amd_uncore_ctx *ctx;
>> +	struct perf_event *event;
>> +	unsigned long flags;
>> +	int bit;
>> +
>> +	ctx = container_of(hrtimer, struct amd_uncore_ctx, hrtimer);
>> +
>> +	if (!ctx->nr_active || ctx->cpu != smp_processor_id())
>> +		return HRTIMER_NORESTART;
>> +
>> +	/*
>> +	 * Disable local interrupts to prevent pmu->start() or pmu->stop()
>> +	 * from interrupting the update process
>> +	 */
>> +	local_irq_save(flags);
>> +
>> +	for_each_set_bit(bit, ctx->active_mask, NUM_COUNTERS_MAX) {
>> +		event = ctx->events[bit];
>> +		event->pmu->read(event);
>> +	}
>> +
>> +	local_irq_restore(flags);
>> +
>> +	hrtimer_forward_now(hrtimer, ns_to_ktime(ctx->hrtimer_duration));
>> +	return HRTIMER_RESTART;
>> +}
>> +
>> +static void amd_uncore_start_hrtimer(struct amd_uncore_ctx *ctx)
>> +{
>> +	hrtimer_start(&ctx->hrtimer, ns_to_ktime(ctx->hrtimer_duration),
>> +		      HRTIMER_MODE_REL_PINNED);
>> +}
> 
> So I know you copied this from the Intel uncore driver; but would not
> both be improved by using HRTIMER_MODE_HARD?
> 
> It makes no sense to me to bounce the thing to SoftIRQ only to then
> disable IRQs in the handler again. Not to mention that the whole SoftIRQ
> things delays things further, giving more room/time to reach overflow
> wrap.

Agreed. Will address this in v2 for both the drivers.
