Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78F2905;
	Tue,  8 Oct 2024 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728366420; cv=fail; b=WV7QI6iBklhcuPoQwpRjlikwbIvQPVBufEtfU/m6JL4DOr7dcWLan3NId06DOTFlvwaKzbAlBCOjn2Bh+gvwLz+OBtINGyGNc7S87Q+YMi/D2FEPchNyXcZVUfZd6qnw0Sw0BnEIEtZTAQP9Mwq04uRNSLStvyYUr8VvhJB0Yas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728366420; c=relaxed/simple;
	bh=rr7z/l8cZsWMTc7vso1MONPOmWr3U3YxCdjUZLHL/4E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V17B1jJpcquFNI5rsxcUmuXLltcKrcPigrfzBfw9AmpAs7T48zXKITsID9gTnYVG5Uqi80me1PbTjZ+yMe5dfGUcYE+opHwHu3tyyQ4aA5bqwX3Y+XKnDZYyZ4tX2pSBanplJslTMO3eFlRoZwCP6UB3+rdss8ZIhguVHYNFVyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hszHqI1N; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hszHqI1N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g12EDJiJX7H26khAxyQNB0YIjdvVnPRPJ+2b8OWzw7qEl8BJ1zOmIuyUdYPHVoqKAWeZ7nfBHcN1qFJS1MzuN+16HbRrOG8H1Q8CIuQwVq6Q8vzBwFIFHjtS1IfgDZqBhaQOlVBU7FhWl+GNw0Vnc59G+r40qxNLwrOYIMX+caXpxWP6DNs9pijnQYQphU23sQk09Hg7Vs39Kxh0f11HqVY/G4pJLrSfYYg2S/Va6RuMz0l0FkFJMTCVdqVJU0H4CGILFVOFDYuGMHYaPPiiM8b6xw/JQHbCCzm3x1JPmJ6Zx5DxDeR3vV7T5bvBu5OwegHmlzdDftXsoS9JIZJHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXXilo6R+tjYMSpRM5V6k5Aao8pPVf9U+B4Wg3QyN7k=;
 b=v342AUyJMYUJKpeO3jPwfQO/8R49+1QbWvXqLlNf/pb14qozOFPAn1OTtkS7gd+kyGEzSBvWJMG/UHAPPKn0ZCApP4LX1+uQ1oGoMjRYGM80rrOBY5fmfFe5BNKN6tdSQX/TUZ3jefjX8yOu47bP3rpR9Vtja0J7p1obUn/RxPGJeF0E5ystC1NpfS/k/6iKkETjVI+X33TTshLPYY6yrJ88MBlkvrVpb1ntmsQ65IOk9cVZRzNNPwFhBTse0pG4zIdC90pPLXjYWOljzE8MvjDTiHWWSFcRW8I4DwzcDP+YRJZDAzlyvDfF2u8uSCfJ9UMm1iFgxxCWapTRZexn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXXilo6R+tjYMSpRM5V6k5Aao8pPVf9U+B4Wg3QyN7k=;
 b=hszHqI1NNfr0jEmDCGesuWqJq1ejhxx8qhoGAx53Fo6DQPvDv1Ap6m2dmeP0xT/9BZS7FZFgcDM6tbWOwqVC0AJpuIYpaJca5CcgCQ4KWepAtwvmtoz9XzD0mFt+revWcxfO2yynT+gx2CJleM738r+gsrEt2TsETTTnCMqBGvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA1PR12MB8238.namprd12.prod.outlook.com (2603:10b6:208:3f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 05:46:56 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 05:46:55 +0000
Message-ID: <8a105c37-d403-4967-8862-6e097328c836@amd.com>
Date: Tue, 8 Oct 2024 11:16:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] perf/amd/ibs: Add pmu specific minimum period
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 eranian@google.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
 <20241007034810.754-7-ravi.bangoria@amd.com> <ZwQ2yzLm2yyaYOcJ@google.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZwQ2yzLm2yyaYOcJ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::22) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: d85a37f6-9820-4c3f-df6d-08dce75c9e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWlkNmVaZ0hSdUhUS2Z0VkpIZWxxN3l6V2FlTHNueWNIeHVrS215aVZ5RUpQ?=
 =?utf-8?B?NnlPRFJjMndLNjI0M1pGZkVFTlk3QXJWNFVQY3hMRjI4N0V1Q25TSDFjckpC?=
 =?utf-8?B?OVh5VVJoVFNWUHZiVEdNUStRRStsTUM1bktwY243U0h1NWdNTEF3amFQaEJG?=
 =?utf-8?B?S0VjbFFoeWlnRytiZTRKeXA5K1BFWjFBTEpUTlRsL3dad2NrUTI3UldVcmNU?=
 =?utf-8?B?T1BaVWpTQ0R5TUZYQWJLUlp2R01BNFRzaTdXWUlnVU5PcWVERlF5a1pGU0pC?=
 =?utf-8?B?Z3JhK0J2bEdBRmZ3SlRsejlzS3B2ZlRoMkhpZlp3TXpmSWRVNVFrN3JJZDdn?=
 =?utf-8?B?REdLam9Rdjd2Y0UxS1l0eUFoR1FXL0xkeHJhK2FuWWtpOTMwME9QZG5sVEUx?=
 =?utf-8?B?a00ybVBTWlQvekR5VXB1U0VLeC84K1lvQ2IxYk4vTnBwcnlXd29POVdzd3I2?=
 =?utf-8?B?UktmMTdjdndWOFhCSTFBRlhwVlJMTTVwbWlma0V5bmYva040L1RCYURCeUF6?=
 =?utf-8?B?VjVuNzBkSUtRZWFyNmlLQ2ZzbHNJQ0RGZWhGcFNUUUFlMXExTG9VTDZnaEo2?=
 =?utf-8?B?WGZGeSszNHJlcy9nV0FvSWYrUEVaKy9oU2hLdS9SMEtQVjZPeFpyWmYvS1Y0?=
 =?utf-8?B?a0dsL2lZbVI4dEpibDFJQnUrWjI2VTM0Y09wNThVdWxkM2FDazJtT052K3o2?=
 =?utf-8?B?Y2pYejQ2YmNZZ1BpTUdJSjFmUWI5TXhDSU4yczR6Nk82eGdCdHNsWXZDK3Zk?=
 =?utf-8?B?WTBoRmF6MjF3eW9OSk55cDM4c2w2RUVYU0dwdHB6R2NUek0wYTlZd2VFRGZE?=
 =?utf-8?B?ZEwvQ0diWlIwb1lMNFJXZi9SQk0zNnhFQkdCRHp3V1NGR205K3V3QUg4SmFz?=
 =?utf-8?B?ZStpaGJvZVk2WFFUdXo0Wms4eWRXNmpCeGpObTFvZ296S1RVcVNmNlJtRnZw?=
 =?utf-8?B?YTFPUnE5VVRTaVBycDNNRUhwYkd2UkF5TlZFRGs3SGs3TGwrQ2lNK2xnbEU1?=
 =?utf-8?B?dmZHMGY3YzVGS3ZZcjdxd1hPdHNQQ0Z0TklHYVRVQndINVl6S295N0JCdk1k?=
 =?utf-8?B?N1RvZkhEeDB0b2xFbGM5QkpzbkdrMkJKMjNXL2xWL1o5L1cyUEhWeGFsRHM5?=
 =?utf-8?B?a29NUURXc29sMVRWTTZwTzROZTNnYlFkZzFaRE1qdnd0REczSS9jcVl6Y0to?=
 =?utf-8?B?dmQxeTF4bUM1Myt5VFJCZ1NVZ1pUZFFlUkNaWDRDQ0FxRTA3aGYrOVBod2hD?=
 =?utf-8?B?TlpQSmc3TUMrR0hsOEtPc29tNjAvWkVRSEswV0ZlVFBYeXdYdFhnVGtvZjl5?=
 =?utf-8?B?VklScGFCU1c3cTgwTkljLzRxcTdNMGg1RFJONTkyYXYvanVyYjFrcktReThx?=
 =?utf-8?B?N2xIUGVnTHgvU2dHbFgyaGFSU1NieExoc0UxdkJqek5sWFRMcUdGdlh4YTBN?=
 =?utf-8?B?aFlkcXZIQ0JzZEV5b2RSQWpnUmwzQ1ZVd3dPZDd5aHNscHltUXBiSnd6elBF?=
 =?utf-8?B?dUpGbWtWQ3lERCtBMG10QVZ3UmFURnBGUlgwQWdGRnNCMVlTVjdXaWk2STdU?=
 =?utf-8?B?SWVIaG5KdkhDejhXR3VqRjNtdUFEZytqYVo5amFPUWdvZGFPYjkwcUNISHVV?=
 =?utf-8?B?MDhmekRyNE5kVVpLMHczL3BvbGpKR0xtNUE1enVxSDFQaEtNN0VnbHBETXVu?=
 =?utf-8?B?UWc4MGZzTG92NFJ0NjdmZDFCOUQ3WEcveUxQSFU5Y3lZN1padnJQMk1BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkVUSnRQU2dySktDU3JSdWFuN0R2ODJkd1BvK1gwZDhQbUJJUUdqMHZNSTBh?=
 =?utf-8?B?WWxLM2kyTDFUdEpBZzlTYTlXOHNkUGFoQkN5SjFxc1oyeS9JblJocWNRS3pV?=
 =?utf-8?B?Z2pPL0ZWNEhUYWJVYlErWVpheFRia3hTaklpOSt6SGVpM3YyQllZZ24vcm1I?=
 =?utf-8?B?aGk3UnNRMUJxdmlqeG5FMGZPNUVyVkpUc1VMZDl0aHhLaHBBVjNBd1owU0w2?=
 =?utf-8?B?S3Y5T1c4QkdxTE1iUGVLVXNPOXpQSllYeTMwL2FScHZwdS81OHlJQzNqdGd5?=
 =?utf-8?B?a1dlYUpXTmIrZk50NWxFQ1dzS1RWV2JNTmtCaVc5SVNzR0JwNzE4MnBBYUl6?=
 =?utf-8?B?KzExMThDUFp0N3NNR3dMUG1LbWVqY1A0cldKUWhHYlQrVjVMVnN0eHFLSGRH?=
 =?utf-8?B?MWpFcUI1cTlTKzBTLzN1WEV5MFpzWWkwdzZ0QmthbnZXeTZtSjhmS2xnNGky?=
 =?utf-8?B?SzdJTjE2Vm8vcWpEZnh2b2RqbEhqZXNRMVZQcDdzOG1BVHR6V2dydkZkMVZV?=
 =?utf-8?B?NnFvWDFzT0ZKUERBV0FTaUswZXVoMjBDTUNEU1ZNenkxT3hRWVhyRmJCZ2ZG?=
 =?utf-8?B?cGxtQWd6VTBMR29YQUFvMzl6SWw3SzZhV2JTNHhpQ2NJMnBMcGxKUG5jMEhB?=
 =?utf-8?B?dkVUYnhGVjZ6SDMxdTFKY1cyM1JadTArY1pibmdkelhzdHhYZUorUWJrT3Vt?=
 =?utf-8?B?blRubEJSQ2FnU2pxdUhXQUsxemVMUkFtaDBlODFQN25IUlRUeU8rZjVXV0Nz?=
 =?utf-8?B?WklJbXJSa0UrVVErdnV5MTZhSjNhbjd2OTBHSSsxcXE5NVQ0UXVqN2RjQTR2?=
 =?utf-8?B?cTZ2ckE2U3VHVWhrcXVnbkRDSE13elRoWE9TNER3b3Jnemd0OFBuUkJjZjJZ?=
 =?utf-8?B?Ukh3TlpyMm51cmduM0xibW5ORFRLaW9DRXRxVEJKc0JiTWlISEt4TTdiUHJP?=
 =?utf-8?B?TGFoVE9jOFlqejhsdE9qVlRBNXV4eWZkMndKZm5nd2E4OW9BUmNhbWtvazZq?=
 =?utf-8?B?Zi9MbGd1bGx1RktLWng1OEwyRjlrUmRaY0gweElMWnM4ck84d0FaVTJzdUZB?=
 =?utf-8?B?Qk1oWEdIaUo5ejVGanRyNzBMODk2QUQ4VVFhM0dEcFYvekU5WFVRWGZHWVJh?=
 =?utf-8?B?WUptY0kyL1plRVFlY0pRNzQ0OG5aWlQ5WWRQQ0NxazIremlzMUtIb1dPak1t?=
 =?utf-8?B?Nm9xNjdyUEdobi9VUkloMXFPTC90a1UwSTU5TSt2SlNKLzlSSWsvZklFUWYz?=
 =?utf-8?B?VGVMY0xDM3JOOXFFdnlOVmRhVW5jT0xSWjFRcnlEeU1hc05aWk1DaVR0R0c5?=
 =?utf-8?B?K0p6dWE3MHdaZkVGMUQ5cjhUemNmUVRyWGpGcnNPSy9CLzNNYmU5S3pGTEI2?=
 =?utf-8?B?b2FseEQ4NGk5SEs5VEwzWE9zaE1lL1BrSldXdm1zUzZIWmhVNzhwaWNMNTRS?=
 =?utf-8?B?aWhXeXJ6dlA0N3hvbGdxM0UwZERKOHFoMEc3NGpEYWJHRW5tQnpiWldQMEZT?=
 =?utf-8?B?Sjd6dWhONHZMdUQ4Q2l3WHMrYTE3SURHeUh2SWUzYm05L0M5cG5GRFFRTkNp?=
 =?utf-8?B?aGdsMmZWQTVJTkEyQ3Fvd1BFTERqRFpydEwwOWU5cnc0WHRnL3ZHeDlIWFk3?=
 =?utf-8?B?Q0ZkM2N5ZmxLaDRDbU80TWZXNlNaTWRXNE1wWXJSOGRIc210cENYRno0M2Nx?=
 =?utf-8?B?dThwbVl5R05OOVZNTmlwcEhPUWlsdzZVTkpmN3V2NWZ1RlBKNXIzSEtzVFV4?=
 =?utf-8?B?dTd3UFFJeS9YRDdsb2pXWXRmRGFGY0dCVEVuMGpCd2VCWVlNVzFFazhUY3Ja?=
 =?utf-8?B?RlRKTXFIMkVjZFU2anVwajJPeTZ4cFlyWlhrQnB2eHBIbDM2Tnl1UlpJR09S?=
 =?utf-8?B?OVRGNmxUY1JjcEtxbmNSNm1FVStQb1R4L0pDRHdJM091V0p5dFlQY01Nbktl?=
 =?utf-8?B?WE1nMFFvdVJkRjFkMXlrNW5RTmhmV0FLNEhWcDJtMnpoWU4xSE93U05ieXZX?=
 =?utf-8?B?TEt0UWZEeHJicW1EdEZHVzFxWkloSFliRXV3NWEraUYyanh6dVJyMURzTCsr?=
 =?utf-8?B?OENWQjFhL1Z6UnowOG1IbDZUZDRQNGs4TzhwVDBiQ0srOEtuWG9ZM05pUDh0?=
 =?utf-8?Q?DsMmtWUvhDlZ5PJhh+Ya4U19w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85a37f6-9820-4c3f-df6d-08dce75c9e1c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 05:46:55.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNS3Gnn6OEjYydbNSdZ5u24Fzc6k125TLslKKVCMAmwBIHHpMZvButZaiOdcKrNUUq0/WyRO1kJk4PAK7hizQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238

>> @@ -295,10 +296,14 @@ static int perf_ibs_init(struct perf_event *event)
>>  			/* raw max_cnt may not be set */
>>  			return -EINVAL;
>>  
>> -		/* Silently mask off lower nibble. IBS hw mandates it. */
>> -		hwc->sample_period &= ~0x0FULL;
>> -		if (!hwc->sample_period)
>> -			hwc->sample_period = 0x10;
>> +		if (event->attr.freq) {
>> +			hwc->sample_period = perf_ibs->min_period;
>> +		} else {
>> +			/* Silently mask off lower nibble. IBS hw mandates it. */
>> +			hwc->sample_period &= ~0x0FULL;
>> +			if (hwc->sample_period < perf_ibs->min_period)
>> +				return -EINVAL;
> 
> Maybe it needs to check perf_ibs->max_period as well.

We do allow event with sample_period > pmu->max_period and handle it with
"period_left" logic.

Thanks,
Ravi
