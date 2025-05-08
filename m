Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2652CA9;
	Thu,  8 May 2025 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746677574; cv=fail; b=Eozuips/f1udskV0TS5hf6ZKAIwu+Sjb9r4FYmqMslUWZcPD2c71GHpWJF0xhJdjrqfDm3X8O548trC9mXrSqqx1sJRKuoHasacrrRnFC5cvEkoBwMEUScyBlKe0Ef2SrQDSnxY7ofBBK8kzjdg7xwEcooysyaJdo3u0UONAKdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746677574; c=relaxed/simple;
	bh=8OuRIuLblCLp1G2XQl2+E6Q5HbiTuaFHH48TXfHVvKY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PgmgkCaG/8n/eW1KyNLmCWwPoCLVPQFE32Lh82tOW64ApCV7kc0+/9jWsdloE+GWcHNRHOgglX9pP0iX1fYqsXwiRdVd+6iqdaBIEN29P8mmOXR7Sm33rvB2wqC0t60ldI+oBAjzzZMkKzcnl+w5Nh3fsvt+MUajX4TD0X7ZvCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t63ot4Ko; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t63ot4Ko"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvmDcTJfW4eJ+tSWHyd+GHvWSZLbGxPx9P0hl6Qr9BeTNpcSVX3qLrIHl4yxTohznvNR/iehMOIoGASThaBSnQSqM9gQFxkCDpd+HzcbL1Qh+68GNyRaj9QWG96ZtXgfQzdRaMdT0ECx9H84H+ezyi7NN2PHDFW2KaFIX74DaKMx9IzXHW/7TIF12Oi8lXcWKRuLcQJiGa9U/fgzyWzRL0d7HHuraIqSGEWhV+NgeFoxjlxJLWrAuiy23vFuv0zXUurPqH7sdDZ4JElPSYjaHn6Jh8txAHtrFmdddqxpO0A/DX6t6nuro1Qgj4ot+9hnxZmdxaDfQl1kH8kmMuWauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXbwS4eH7ef1tn4okb9yaKscovdMRAQ9c0FjJ51FUso=;
 b=xkyHeeQ4/NUbF1ObIRQzub3DBr7VS16fam8a9Qh048pKKdWEE3vMZT2rJfHt9milaGS1aklQ7aF3JkNPpfswzQvphEGzyJslnsqDfPaPAagiEPyZWhw8qS6t+zPc3CpCTbySJ9N+7V0QDzZPuThvwqwlkWUIgjsYxrqsi9ruItu0YTD3V0BZM+4rGxdUUJr/t2zrsFz0JSZpuxGpAtrMpoTC+jCSAthRy2sz0A/mBixZ4WUFjfM3osMdUbyLCPairUvfPmTg4b7D7Borpo6+r9yu2f3ZnZX8lWa1mYV5t7HtVkphO56TWGEiUNr1zYyWHcmtmbBhWuxXak5rcMyHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXbwS4eH7ef1tn4okb9yaKscovdMRAQ9c0FjJ51FUso=;
 b=t63ot4Ko0hCXI85ZMYGt8WNpWnCX1oCeR526oV4e1l41ZBjYwahkKosjrSHPgTNxV03JDQRAnwVlFz4zaCzIVvNnJCvjW9Qv8hBXjrzBwnEraQ8J9FJL4weI5GW2GzAeNlH98CScljx7A3/t3HoEBJ5L7t0ShMSBX08tYMYtRuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 04:12:49 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8678.028; Thu, 8 May 2025
 04:12:49 +0000
Message-ID: <33984b44-ae3d-4fbd-b918-07289a3f1d8a@amd.com>
Date: Thu, 8 May 2025 09:42:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCHSET 00/11] perf mem: Add new output fields for data
 source (v1)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Leo Yan <leo.yan@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250430205548.789750-1-namhyung@kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250430205548.789750-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::33) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4a4839-31d8-48b3-ceb7-08dd8de6980f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzV3QXZ6ak1UY0JuVlJJR2ZuTWlxcXYrRlZEZnUxUUpNZXhCQnl1eHM0MElC?=
 =?utf-8?B?eW9wZVprWXh2V3FZdGgvRVJTK052ZTFiWVVIbXVBNUJIU00yUk1lNGN5TEZt?=
 =?utf-8?B?L1FpOFZjM2lYUTdEYUhieDlYWFc4aUJTazVlaENobjBvRy85NjVtSG51aGhT?=
 =?utf-8?B?bjg4aWZ0Z1hodWcySDZLUlljM1NUbGZPdkNIWTNTNTF6Qm03QVJhb0FmcWJn?=
 =?utf-8?B?eno0OTdsRUVRZ2VYOTdjNHFnc08rVDliTklHdzVPLzZyNGZzUm1pb1hrOTVL?=
 =?utf-8?B?d0tlSHZ1Ri9LcDBqWThmQ2hRaVp1ck92SEl5RzBaRTJ5WGhrNDJaYWV4eGlT?=
 =?utf-8?B?VlhaemVDamFXOXY4RC9DN3poUEh3a2hRTEhvaElERmRDV1BnbGZQNGJVVnJ6?=
 =?utf-8?B?NFVseUFPeG9VcVdJWUdWdUtraG81cjhjNk96WnFXS2RzM0JlV3dJMDJldWUr?=
 =?utf-8?B?SHFsd2hzRXhydDBzSWhoMEdDaGVmT0Qyb3RHdHlQYVIzblQvQmhwNlp1RlE3?=
 =?utf-8?B?bWRZemV0a2t4NlZaZFBXd09yU2ZuekY4Q1BYMlZjVTM5ZXFFa1JhcE9ITmtL?=
 =?utf-8?B?SkdIMm45dHVGZ1ozK0pnbStXTXdMS0NXWHhUVW14VkI2QWdzWStyb09pUWg0?=
 =?utf-8?B?NkZ3WERTUXpvWEpZWFhDWGluM0o2bFlSQUx4WmlQNkNHOGRGaFFCZURNSUYy?=
 =?utf-8?B?U2VPenZZL2swaWdVd1NKdi9UbmxJVnpNbmxMZjJtRmkyNDc5KzY3R2JIT2l4?=
 =?utf-8?B?UEswa3loWXRadlIwdVRuRWNMNS9CV0NwbytkRTBSOFFkOVlrNHNwcHpVWVNl?=
 =?utf-8?B?UnVSTUkza2pUeWRpM2w5Mmt3MTRYdUlpQUFGUjlvblpCNStZMlZFaktBVGV3?=
 =?utf-8?B?alBFTVVrWUpNZ3J4V1lzVEIycEIwVnNkcThGT2pKQm0rRFo0SVVzY3M0UnRB?=
 =?utf-8?B?TkdLMTB0ajBoRjVaMHRXSXkzdllibWVwTkdBUkdTT0VKaisyTVdMQm1pdHpI?=
 =?utf-8?B?NEdQQmRlbW1ZSXRQbDNRNDl3OGhrMDdBczhvN1RFYzY5dk03RnVVRmVkaktE?=
 =?utf-8?B?N1pKZjFIb1dGRU9CbTNvTHdiKyt6NmFaelV4Y2Qwb3c0NzZDVmVHRUIvbUU4?=
 =?utf-8?B?ZVNhMUlPY29lUUVRUjBaVnJqZzgxWTFjeGRNVzNBTDBSSXV3eE5vUWV0NmRx?=
 =?utf-8?B?cC9PUVFLWUhvbkhzT1NPV2c3ajJhWW9yNmdaUWxNSUVWWmlLMGxWZUJvUEFX?=
 =?utf-8?B?UVgraGg2U2ZmNUI3bXkwUnVoOWpMS0p4Q3NNdTNCVHU2NVphTTBGME1vR1g1?=
 =?utf-8?B?bFp1QTBTaGQ4RHhiMER1WStCUmdrN0xqSFJLT1EvN0lqS2tsOU9NQ1R0Tnk1?=
 =?utf-8?B?dXV1cUM5YjU2eFFiWDc1WkhyakpzRGlHWmM4aVhzZ2J6YlU4bEVHNSswZHl6?=
 =?utf-8?B?ZnAzVnV3T3k4M01oMmh4U0Fta0VzcnNqWnV1YzlmU2c2dFVlZ1JPU1ZyVG9v?=
 =?utf-8?B?TE01Qmc0cnFuRFdOai9hOVhzSWFLejJxT2lWb0hiNkd1M2dqYmRqWVNYYkxW?=
 =?utf-8?B?ckxBZ2RXVHFNZFRqS2owZHFraU5PRmNGT0ozTVMwRmRZcHpqZWxmMDNrSU95?=
 =?utf-8?B?ckxjckxuTHFqSkFLNjN6L2NuaWdsQ29RUW1qY2lZc0lLdEZjTENLODUySEtK?=
 =?utf-8?B?ZitLaTM5bkZsZTRjUWZsZm13RGRnSWNoK3hhQUdISGdTTmRJTE9mM0JjNmRZ?=
 =?utf-8?B?OE5Kdno0R2hDamxZaU1jSkJRcCtpZUVCcTJTcDgvQ0VaVElzcVFSQ1FLMzRy?=
 =?utf-8?B?K2xtT2UzNTAvVERURkVNRmlzVGJ0enVPRHlHa2VCU0wzbS9CalFXNDRSL0ZL?=
 =?utf-8?B?TE5xbFl6K3QyMlZiV2FnRitETDcvUG9XN2owekJtd3dRNFlVYmFtNktDN0pY?=
 =?utf-8?Q?Em8K70C/ZOE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXFxSTZKNkpOSXU3eGZpVmZpNlZnOEt6U21yazFlc1dBUDczQjIrM3hzWUlB?=
 =?utf-8?B?K1NFVlIwMFVINFVZNk50S3lNc2hTUUFYTGlXMGpCcWQrNWRNOGtVZkFabzY1?=
 =?utf-8?B?NndpR1gxMndLNm05NU56MEl4cnc3d2NZbnRaVDZPelhyemtBczBNQ0ZHMVNJ?=
 =?utf-8?B?aUREd0ZOOFRScGNMK29TaHk4TmZGOGlQNmZUUDFrQmxLYzZYZytnSFh6YWhx?=
 =?utf-8?B?VGlWYXpOVlgvUUJ3MEtqbEc2K1J4ZTArRlFYcHhCM2pGNjI0UkRpTU9OdmU3?=
 =?utf-8?B?TUFDOTFvcHcxclg1RWw0R05QUkRFVHc5aVRoVFRBaWN3NFIzdEc1TnRWM21D?=
 =?utf-8?B?QmpVdGFNR3FjeEJ6dGFlVUxPVlF2NXEzcHJ5L0tMZkFpVUIyUFhXQTN0M2lE?=
 =?utf-8?B?c1drNDZZNzdGSFJnbWxMRU93WjdmZGhVZ092dVNTV3pWZW9OUEdyYVNaMGY1?=
 =?utf-8?B?cUJ0N0dHNzNycENXR0JLNGxBdXd1YWFwQk8xSWh3TDRueDBiYXZ2WkN3eDU0?=
 =?utf-8?B?eGpuM0ZXYi9BS3JrU3R0OE1YUG43SEtGM2VoRUg4OUd2dFZqblpLalRlalFM?=
 =?utf-8?B?UG9zaXJGRCtYNDdiZHZvckZnVTNDc01JbFgyb0RCQkZ3TWJhanJsTjNNcFRE?=
 =?utf-8?B?YW14aW5UY21UMkJhUU05Y2pza1A5MVFlcTVyTDk5bVdnazRRdHg1eC9rVHhR?=
 =?utf-8?B?T0ZaQXc5TTl6TVpuMkpmaDJGVldqNHpTYlh4UGltNnVUVWdzc0RDS3hKZnVJ?=
 =?utf-8?B?d3J1U2h3dTQ4ZXNaQi9adkEwL0VPQTEzOTNkNE9EUVlkZ095ZGZ2eUF3UUJp?=
 =?utf-8?B?ajd1eHdZQ1ZYYVJNcENGckNYczc2VDlRaDRRRlEwSkR5Sk1TeWV4Rm5qcm1W?=
 =?utf-8?B?VmdIYmE3Y3dYOEl5Q1YzcXBtMXhScG52VkFQemJJWHlCczVZb0c4Q245Y09W?=
 =?utf-8?B?NXFqMUF1eENLVWo4NTM4OXMreStCOTVYUHZqZCtFZzJtNE9taEx2c2h1WXM3?=
 =?utf-8?B?MSthakt2aGpxWUQyMXNQM3Q1ajZCaFFISmZqQWEwN2VReUYrSUxTcm1OTHl2?=
 =?utf-8?B?Q3NyNlZ0MlY0UGhpb0grQmxzdXpnbVVMN2t2d1RKRFZGZGdFU2Vadk1aTUQ4?=
 =?utf-8?B?cnhjSUZoOVBqMHptRUplcDlJb21YQlg5REVlclhMMG80QWwyQjBqeWtSVnp5?=
 =?utf-8?B?SUsvWVYrWVVKQUMvMWFWbVVGaGhXTDNvTTJPMDJ1OVZZdm5hbDFFS05ENVdu?=
 =?utf-8?B?aURRbUl1VUpjVVAwMTRlQ3Joc2F6TmRNSmRLTTRYYlE2SEIwSmtLc3RBckVF?=
 =?utf-8?B?bG9XZjJ5VzBSL2wwMVpqb1J6K1dna2JnenZHY2F3VlhTVHZjZFdySkVZbXZU?=
 =?utf-8?B?c3Q1MzZYYmRMQTRXVmUzbTZhanNsak5sZkE1RlNtT2w1LzJOWk9rOVJwNWZo?=
 =?utf-8?B?RUpaT3p3K2JpQWxxY005b2xabzRPWHBwK3BKR0Y1OXhmdXo0SHpka0JSUm5C?=
 =?utf-8?B?WVNzZTlmRHVOa2d0OVJaNWR0ZHFqMlU5ZnlFOS9sTWtHSEpqSjVCUTFIM0ho?=
 =?utf-8?B?VDFoYUlPUjA1N1hNNlM4eVhVUi9UL2hBZ1cwaEk4RVhaRGhXRjRVbU15V3h1?=
 =?utf-8?B?S2NqMnJFcHB3UXBhNFpkNlNOcjFUK2RYOVhyVC9EV2RxaW52em1TM2drV2Ew?=
 =?utf-8?B?Uk5EWXB6Q0VPamVUQ1FCcUhxeG92SmczMDJ6K29qbmV1UDVWVDBGN0l5OGdQ?=
 =?utf-8?B?Z1dFRWlnS1A5Uk1UYytxcU5MZVNnN3hRRU8xaTQ4SzNKTTJiVUUzb0VsRDdZ?=
 =?utf-8?B?d3h4Z1RjaDIvNzBkOVdDdHA3dTdvVGZFektFbnJTM3B3MkxnUlpWcGt2VGNo?=
 =?utf-8?B?SmRGWlhkY2Z1U3YvQzhXZVZDbGZiMkJMbnZPVUJSbDAyeVhKT25oOXNHZVM4?=
 =?utf-8?B?L0xPL3BLMVZiMlowYXpod2ZnNHRqV090V3VKSEZJVXcvWWtBbGNXVHpDVkt3?=
 =?utf-8?B?UnpodUEra2RFZjdIQXQvWmx1SjZPdEVHdzhkWEVybW5OcjZZSEdvZ0xCVCtS?=
 =?utf-8?B?NDJSUURVa0NZcVZ5TlliVjhQR0pkdWRBNTRnb0szQVhvY3owcEVOeUFEWWd5?=
 =?utf-8?Q?ZvdGrtPbqmF8raIyogDKk9v9w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4a4839-31d8-48b3-ceb7-08dd8de6980f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 04:12:49.3292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A95P/ZmaCOUbuVNb8l4DfVv6SjOVyTszlAFkNehAAy6OU56BYFsMT+1WWtnBuQe4FzacRfRn5AivgIhCGrzdLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550

Hi Namhyung,

I feel the overall idea is good. Running few simple perf-mem commands
on AMD works fine too. Few general feedback below.

> The name of some new fields are the same as the corresponding sort
> keys (mem, op, snoop) so I had to change the order whether it's
> applied as an output field or a sort key.  Maybe it's better to name
> them differently but I couldn't come up with better ideas.

1) These semantic changes of the field name seems counter intuitive
   (to me). Example:

   -F mem:

     Without patch:

     $ perf mem report -F overhead,sample,mem --stdio
     # Overhead       Samples  Memory access
         39.29%             1  L3 hit
         37.50%            21  N/A
         23.21%            13  L1 hit

     With patch:

     $ perf mem report -F overhead,sample,mem --stdio
     #                          Memory
     # Overhead       Samples    Other
        100.00%            35   100.0%

   -F 'snoop':

     Without patch:

     $ perf mem report -F overhead,sample,snoop --stdio
     # Overhead       Samples  Snoop
         60.71%            34  N/A
         39.29%             1  HitM
   
     With patchset:

     $ perf mem report -F overhead,sample,snoop --stdio
     #                         --- Snoop ----
     # Overhead       Samples     HitM  Other
        100.00%            35    39.3%  60.7%

2) It was not intuitive (to me:)) that perf-mem overhead is calculated
   using sample->weight by overwriting sample->period. I also don't see
   it documented anywhere (or did I miss it?)

   perf report:

     $ perf report -F overhead,sample,period,dso --stdio
     # Overhead  Samples   Period  Shared Object
         80.00%       28  2800000  [kernel.kallsyms]
          5.71%        2   200000  ld-linux-x86-64.so.2
          5.71%        2   200000  libc.so.6
          5.71%        2   200000  ls
          2.86%        1   100000  libpcre2-8.so.0.11.2

   perf mem report:

     $ perf mem report -F overhead,sample,period,dso --stdio
     # Overhead  Samples   Period  Shared Object
         87.50%       28       49  [kernel.kallsyms]
          3.57%        2        2  ld-linux-x86-64.so.2
          3.57%        2        2  libc.so.6
          3.57%        2        2  ls
          1.79%        1        1  libpcre2-8.so.0.11.2

3) Similarly, it was not intuitive (again, to me:)) that -F op/snoop/dtlb
   percentages are calculated based on sample->weight.

4) I've similar recommended perf-mem command in perf-amd-ibs man page.
   Can you please update alternate command there.
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-amd-ibs.txt?h=v6.15-rc5#n167

Please correct me if I'm missing anything.

Thanks,
Ravi
