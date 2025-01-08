Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC971F12E3;
	Wed,  8 Jan 2025 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736335018; cv=fail; b=nx374CrILY+m2ZWcWb1DkEjxaPCJYaEYITYVsZWZBG7/p+NNAvnf8Fkit1GxADvdUt7EqcmEQ6l0gugKWA/zE5hUfIVmwB0X/gMFoLSNPOGyzYX1V29LYJRX+OsB//iiNL0COxjBMfjH0x7rR6glBgmrioEv/biTuDyeNnGjAz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736335018; c=relaxed/simple;
	bh=k+w6ApTX8duwfTKPqOoM4FQmp8TuhTnv5esLL7TxcrE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sjVBA8a44s8v2etDcbpzjj1u9py7y5cy8pBOn6q5iAnRN9+TeCJxZC7DFojlFsDQ81yVF8r8KANaFy/EJWY+Obg4hB4CtZkZXUFUHhX5j9LlG68MmEjDfCNQy7Nn+waXtNnupp9SStRyxpAyAYR2giDPA/ZJM1DNtcw/dEvx1G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qCZGhVdK; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qCZGhVdK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvP/RwBRWjKZtUdmHs/54MmQ59pR2felCy4oLjwC65V4fzWGpgnOIxyactrmyj2p2haJDV6Or2yPZN7gmaqGv5w0e4jUPEkUOri7h1rMO5yxeuy3BHywrwlxNsWT+8+rCzeLXdMLUgs9OwVgrz9wpjigmkGLvXzFFSW5W3LLVBgkECfY7QcZTEnrkiWRuhurHbeBMptkqRFepqcMA1UurxFk44St67jjb+u0egxESxvpFK4DzhBFRo3Qx5E0AipldC0a2K9UOKMsB07kAV4f/MpuS3QTQ5way7x3xZQxMlkBgKBFs6SeWcoLt8Yne3jb1hJLE+WN0Lk1GEM/N3LOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6cvUf1uoMm7bVXaoLHguOWneG7sI+Sjrm9d9lH5It8=;
 b=c1/OMQ81mLNsnwIGw1gxle59IbT5SC2QvVd+8oG5qvwn2QuYgw53EdEFfS5sk+s211ZczvjSiMagsI5pxsXCtL2VlHwu/ieK7MhshB2pNRPBQQCKFGubHI/vtPEPTZvMdDXwJ/G7Ls5obTDsjWuceXdIePbeFeNvuyoNkXg9CzG5JTVItT9WKaiejV5gMYpAh3oZCNE6At1fUaycXQb80boDPQTfQK08I52kjO8uV+H6tbygy/BlaoNjx6+wVdiwOIw7d6xut4EdXHgTix+ulPwoCtkHF1/NavxhqjTjO4vA9ojymgPo+R2l9QMHUGmeDADGGdZAkdjK8HFZMaosTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6cvUf1uoMm7bVXaoLHguOWneG7sI+Sjrm9d9lH5It8=;
 b=qCZGhVdKdzQ0cUzF7wbHWtEAd++TImsjkt8r71Mmgm93WlTC32eLEWHr/ahmqobHEKMlQSXLmSJirSXt62tYqXfnprFTuAPBcHrPWVxtmQXSDYo9rxktH6qFQDZKumWIy4GQ2RQM3C1POAdcJ6lcsPIoah0njAKPf5r3u00ZaJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB5856.namprd12.prod.outlook.com (2603:10b6:510:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:16:54 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 11:16:53 +0000
Message-ID: <586512b3-661d-4cdf-912f-fcd53c095896@amd.com>
Date: Wed, 8 Jan 2025 16:46:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] perf/core: Introduce pmu->adjust_period()
 callback
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, namhyung@kernel.org, acme@kernel.org,
 eranian@google.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241210093449.1662-1-ravi.bangoria@amd.com>
 <20241210093449.1662-9-ravi.bangoria@amd.com>
 <20241218135229.GE2354@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20241218135229.GE2354@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: fefd21b4-b6bd-4843-20df-08dd2fd5f49b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXVCQ0hDTUUzUlExNDhsVWo0RTFjTk45MTFvdDcyVnJWNlBKSC80U2ppVzBZ?=
 =?utf-8?B?VXpmRy9CeDJST2t5MUhsclFXSjc3RldWc3loYW9qYmZnWCszSkk1ZWtIMkhL?=
 =?utf-8?B?Q3B1bGVQbzZ0VGZ4eHVGSnB4WDVjbkJnTjkza1Q2bVVESi9lUktnUnUxUkNJ?=
 =?utf-8?B?M09qMnBHZnZsSmE0UFdJS1U1UjBOWm1naVk0d0NRdHdqTTV6UkkwY2RiQnRT?=
 =?utf-8?B?TXo1U2pyQ0lHSE1LRFRiM0FNcDc3S2NydWlyRHlXM01pN3BUT2tkM3BHSi96?=
 =?utf-8?B?NGRjZlQrQ3lWVkRQSXgveG5ZMDVWbTlyVUZic0ZvNk0zTlcyTWl0UDRCZGtT?=
 =?utf-8?B?M0wvYlJtL0s0Z3RmdkZxWmo1U2RwUGM0dEthYmJONEVYdUdubzBRSTc5VVRH?=
 =?utf-8?B?L09DbitCQU55K0ovakg4eVlKTDAvWlh3QUY3TEM0OXE4SXpMYWE5U2RjN2xW?=
 =?utf-8?B?d2ZiTlFrbCswR25HZlltdTVCbHRsNWo2TjBqck95WFRQY3JWcXdFMmVKV21K?=
 =?utf-8?B?VkNDdlB1UHlTQ25GWmpiaVZxZE9KditHQTVpdDdsQmNMNUpaWld5ZTJYR252?=
 =?utf-8?B?ZDV1b2pLcWZjMmtGT1pUeXZ0eGJXVjlZL3NkWUxnMldsejZPZEJhZExOMC9H?=
 =?utf-8?B?dlVLMWx5QWJVRll3TXowNzFpQlFyQTc3b29xSHJJOWM0YVM5bFJSM1dpY3kw?=
 =?utf-8?B?TVhPaEduMys4ZkVIU3NxWTZxSkx1Q3NpTG9HQlBaSzlVdXBoQXVjWDlXNmZ3?=
 =?utf-8?B?RG9uNzlYWkU0QW5rVlpWUjIvSExMVjdrUzlIaUlCNHk1bVJCbzJkNUVyUENz?=
 =?utf-8?B?OVlzdkZWSEQrOVhGK0RyOWtkN09WTDF4RGx0T05kc2FTUW9yczJYOHZYWDdz?=
 =?utf-8?B?UG9SRkJTQzg0eERnMTJzQVJwdndlbVNaaEhYaER4WCtPMlVtcG5tOHlleXFI?=
 =?utf-8?B?dlFGa3dRQzFhZE1MK09qazVPVnFaUkZCQTFoNHZWcGR2RXRtR29LbnRtQjdj?=
 =?utf-8?B?UURYOXRQdnp4RGlDb1dSZlZ2YWRpWklLRityTktDSHJhclM3dU1uNTJkSnNM?=
 =?utf-8?B?RFFTOUxuVFpHL2dVT1NudzR0T3NrNlEyZndkTCt6RjZKZ1JFdk85cEsxQVdG?=
 =?utf-8?B?SnR1WWtEbktMdkN3dW5OSzF3VmxrUEEwZnJMYnpZZ1BsbnVHYWVMZ2VzaXlq?=
 =?utf-8?B?MkNaSFlmbWV6S2loM24rR0o1UU4wTTZESVRpUFpmZ1V0M1pXTkNRTS9jTW5B?=
 =?utf-8?B?RmtjczU5N3d2cFo5Q2wrWmRKbHdDYUNjYlQ5VUNvOWRPZVZqVkhiMEQ1aEtH?=
 =?utf-8?B?SU9aSERONDlBNHRwQmlic01XbFJ4ay9hc1FybW5mRytSRHhVSU0vekhVTHpY?=
 =?utf-8?B?THZUZXBHdUJyUTlQV0FZWGE3V0d4Qm9wMlpMcjVxcFZrT0trbGo2UGl4eEdv?=
 =?utf-8?B?TUppL2gxRnFYSFRNR1gvMjVLaXdsYnZhVGJTK21wR2hNZHpTNFZZN3prelk0?=
 =?utf-8?B?T2gvRjY4eVhJWUladGcyd3VteFVKb3FFS3N5UVdybHFsWWI1RjdWSExqc3Ba?=
 =?utf-8?B?MC9Ka1hhc1UxaDl5eHA0QU5HYlJZMlBDN3dWVU5obHZGUUZqNnhJUWp4eUdM?=
 =?utf-8?B?QlVwTXZqSmgxb1FyMWxUdHF6MTV1VGZoaUcwbnJIeElrTmlnaEk0eWdGOGVJ?=
 =?utf-8?B?ZDBBRnVEZGYrWlNJeTkvSjBpS2FQT2VXYmtWTXVFN2JaQnprTmZSZWxhU2NI?=
 =?utf-8?B?MDZVQ25NQ3NBeHpoL1VmK0krQ0tSdlpsVEZWSXlsaFVxNlQ0MVlHeTR4Ujl3?=
 =?utf-8?B?NmFOT3pvVUdWQzc3V1kzQk1Qbml1UzU3ZWowWG1TQVU0WS94b01TTHE5Mzk4?=
 =?utf-8?Q?c0o4xmwYr8juq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1lkT3dWTlBoZzBTVlNaVUR2UGZZaGNVUW1uTDBCbzNKcXVUM1lEOWZCbjAx?=
 =?utf-8?B?dUhFNk9KNnJOallFZVBmbkEvMjc0NkhLa29heUhBQzh0OWNaSy9UQjNlZTdy?=
 =?utf-8?B?cEp4ZU9KcCs0ZmxuWERmSkxZd05nYXVCSW9jbHRSTzZTaVo4a1VnMDVqK3ls?=
 =?utf-8?B?UkJYd1NHVmY2aitITVE3cjUvcDV1SkQ3Y2hrV2crWWJPRi9mR0FpRmRBK3Vl?=
 =?utf-8?B?cC9OZ0NpeDB2NUdsZmR6NmFhQi9ER3VoNmxRK1lza3F1a0dhdlJuU3JjZUgw?=
 =?utf-8?B?Qi9kVFlUU0FlZ2FHamRjUU9PV3pPME5pMEVsVjhhSDNWR24rWVJLTDdXdUJO?=
 =?utf-8?B?S1VSc3cvb2tGSittSllmS0k3U0syZHZwd1JnQS8vU0RMcUVnMHB3eE43ekQ2?=
 =?utf-8?B?aEEzaWFVbUk2bkxMamZoNXBDaEYzcVRxS0gvVXFWVS9GNEhOa2tyam5RSyt4?=
 =?utf-8?B?VUQxWkY4L0dZSExTSHZkVWxnMW9wd2thR3VTSXloWkR1Qkh2ZFByNGtjMm9n?=
 =?utf-8?B?Zm56OTRFL21pUlpjRkE2bWlsN2MrZkZXSXRGT0hYWWNlUjBhZzVxTzNuaVls?=
 =?utf-8?B?OFNnOUR5U0xrTEZkTUUxSXg3RXRDbzh3NU5KNXRRS3NHeERMVlpuNzAra2lY?=
 =?utf-8?B?dEpET3JMVWJ4YTIzeTFJQjR5cUNtZS82S3k2Ukk2cExabGRYQS93VWI0dS9D?=
 =?utf-8?B?WldXZmdqQitrRHdwODE0VUFZck91L0Npd0xabWUvbnVUWms0VTFHMjhjL05K?=
 =?utf-8?B?a3FBRGk1cStXdnpCOFRiV3pvZFpWTzJmRGtDQkp6Ty93by96TnBia1FhSGFr?=
 =?utf-8?B?UDhLM0pyVFpaS0lwUTdKb2xHSHIvcVJvT1NZZGl3a0tUV2NZZ2xZN1MrVGJx?=
 =?utf-8?B?RkpOMXlKOG9ZVzBLMFkzS0NtNVh3ZWRuc3MwU1FrNG9DekdndzN5ZjZ4Y1VT?=
 =?utf-8?B?eGxhZTNhLzJpVGJJMXZXQitsNzloajMrcDRGMU4zNkw0ZkFlRHhVelFTRU9D?=
 =?utf-8?B?UVJ5SlJKZUFlaXN3MlBSdXBrMXRZVXlFcDJhbC9CeDF0bmEwNVVLZE5yajBu?=
 =?utf-8?B?eDEvLy9QUlRtcWIvRzd1YTd3eHN2SklabVF0dzhaUkhZK0xaRjdUY3BEYVdq?=
 =?utf-8?B?ajhLcFRGeGdTalljNG83Rm5tVFBBTHRjdktuaHAxUWlpV2F2dXNyUjBWd0hS?=
 =?utf-8?B?S2xKeTlqb0JVMkVMY2pTRGkyRnRhTFc0c0FjT3ZJM256eHVEWFlUZHlBem1q?=
 =?utf-8?B?ZEdOOGx4MkhXMzBrYW1kV1BXNis4K1l3L3dEdjJac0pSMVR3bXhmOWtBbzJO?=
 =?utf-8?B?Wm5yRXIwb2ZRZytSTlplYkNKZEtBUnV2M0s1NHNwMk1ERTN1ZG1rVHlBTjFk?=
 =?utf-8?B?UmFHTyt5cEJkREp5SHBxWm1PaThucVhQOGE4QldKMWFPdWIvQ1JkdUtZYVUz?=
 =?utf-8?B?ZDJwd0dmZ0hkRzZ5K2R3WW43OUo1NzFZN2MvdGxab3NNcFZLL2R6aFZDMnh2?=
 =?utf-8?B?UGs2Wm1MdVIrM01PaUxPMXJ6SkdTOFRlSjBSaFJTajFtTEdRTW9qY0xzN3Fs?=
 =?utf-8?B?ZFQyM0pZNnlyNkRiMGtDQ1JsRHhLUDE0eEVlRWJzaHZxT1BjclRHQkRpR3hk?=
 =?utf-8?B?K2xFZ2wvS28rYUYwTXVYbTQ5eGJIUlAzaWN2MzF6NmFrUDdIZVdXeG9sUzZR?=
 =?utf-8?B?K1Q0SUVub0lEUDhaTjBoZm5TdDNXZWpFSXRZVGIxQzAxVmNBZ0tlTGZSRkxl?=
 =?utf-8?B?ZFQ1bmRoZ2dUUGdKTVlKclkvTlVNL3lvQ2RScE1VYUFYZFhHc2gzMFlnMHpu?=
 =?utf-8?B?ZU44ZkdUa2VYTUZQQ2xSS3RrcjFBS0twVmNJTlVyUmdGd1R1QmJ2VytYZVB6?=
 =?utf-8?B?QnlyL3U2c0RGblFsSWVZV2tJWHVyU1hPbS9zMzJZWTJDNG56cE13Y0VFbmQr?=
 =?utf-8?B?WTBaemMyTTJLUEs3dU1hY2FyOW83Ni93UTNQZnhGM2dQd0NkcUJTYm1pZWgx?=
 =?utf-8?B?dm4wTGJxMVh1M01UOGxMZWpiUWtvMG14bnFqSFlXMUJMOTNwQjlqWkZnczAw?=
 =?utf-8?B?YXJhbm5lSEFNVFRqKytTVG00MjUwdWZVYmRWaUJxS2UxL05IeVJRc1dxQTFP?=
 =?utf-8?Q?z2SRcqmDKEfdypdtV+qoiZQek?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefd21b4-b6bd-4843-20df-08dd2fd5f49b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:16:53.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DA9hvcWRXEo5pvUtNLow9VIpVkmqXlcF1tNGCk6dcqAs6eVsGUjeRmxDMG9G5AxAV49X1xRXL1wM7QO42fBA4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5856

On 18-Dec-24 7:22 PM, Peter Zijlstra wrote:
> On Tue, Dec 10, 2024 at 09:34:47AM +0000, Ravi Bangoria wrote:
>> Many hardware PMUs have constraints about sample period. For ex, minimum
>> supported sample period for IBS Op PMU is 0x90, the sample period must
>> be multiple of 0x10 for IBS Fetch and IBS Op.
>>
>> Add an optional callback adjust_period() to struct PMU to allow PMU
>> specific drivers to adjust sample period calculated by generic code.
>> This will ensure the sample_period value will always be valid and no
>> additional code is required in PMU specific drivers to re-adjust the
>> period.
> 
> And not a word about pmu::check_period() and x86_pmu::limit_period() :-(

Let me collate them. Will respin.

Thanks for the feedback,
Ravi
