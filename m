Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32D17D2;
	Fri, 14 Mar 2025 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741935878; cv=fail; b=fyHZGhgDjur/7pVLxwZ7qWefDseDVHXFur/zO7UHEaYYIC8rl7yRXERqrsb8zm2Pkx6vheYkpzHeaiRUZP1kwM2MmJtXPZ6/+jD7fvEqGeZ2EVZn3v1sVXcaczI3hW/CsnADf+pfysBSM2nvY9GXn0RmVqm6bp/8Eephirev31I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741935878; c=relaxed/simple;
	bh=MCsYRxuYP4GLhy3zxhoTiXxHM1ocXnWJTvZwivA7yf0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i+5pqUHW5EjjrXyhJDklO3CpSeR+96k5Mpx8RQSt1WECz7ehUicbCWkCrdxR8NxuT7TT+N3NFnFYhFm8lhAnWwolwVYLSsuiQtNELmELJdUv35vAbOJqTLB5S9MyhBGca1G9JlwPPNi7ucZmGIDPcQkxlEr/keTWZG+ROWwAzoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T51wbYf5; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T51wbYf5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTwj1d6MzI8pe7khVVlwQ68ge8svWCYr3Gz6/sEcM6w2p1nSZytw27OUrIKaRKAF0a7PBIxLsew+AEkuh/qmINU8w037C6llixHpCGjwLICpkj0yRQ8SgRicR0vHjqKBKU01qk8TgGkSEoLO0x/Y5rgZc+Uus1iKnNLtupoVH2LLNcxeh6YqO1eFNBBAV/FhS8ApLbcmMOTlwlqioqNOIqaQ46JajEUy0i1G7EDjEJyxU8yDlEnURVrpZXvlifUfOKiBNm0g7mTTosbAdLPMu2q0/fGP78tJKrTUHMosf1SVKlUrDk7TZ7MeK+FPfjr3AP3QAupJIVK6ttwjL0mMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oi6U45Y0HMYCm9f77drNN7aGqi8k1tC8dfli2k31ugI=;
 b=QvtGPN6pKeye7/GyXgN/QvGLremJ5zL72wDKjuq9CVcX513fwDAPXMy+GITbM4PoqhrUAevTMGxsKpkrJWLgIzG3gT5tASlTT1TlZbj8XJ5wQpgtn8VhKysXoSzGJGkn7vGizFHDMIRIKE7GCtlkpm3s+2G0vues7s+oykaCmv3ogrz3JoDq+htFlA8JHsIadXNWUiKx/JVQfjZGne6dWsJdaNRL2uoSOAtHFPZf3ZUKJ2dd05pLgoRmbox98wr/7DrKRFnPlQ8RHoLY5CYf7t3twckUGTp/uCzPHyVc3PRKSt9eE+z3Nn4FMHTCr5k3C5OlOVXbkOpm4hhZDSjY2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi6U45Y0HMYCm9f77drNN7aGqi8k1tC8dfli2k31ugI=;
 b=T51wbYf5ky8wQY5WU8MeFy9jzGmpt//aMlNzDqKWQPgGFKYEUh+pmDFtG7quLcWZpoxLHZJeGrsZuVTT2iEq64kBF79H9BJT0EgxAl7UN5yWXRf0Z738fgTb22ycNnG0Qj+4OlB9CiE7n3sVEfxcbOgdzxL7jbR+rNiNTf2jzWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 07:04:29 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 07:04:29 +0000
Message-ID: <0259da8e-abe7-4d07-96e5-948f7685c2a1@amd.com>
Date: Fri, 14 Mar 2025 12:34:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf script: Update brstack syntax documentation
To: Yujie Liu <yujie.liu@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Martin Liska <martin.liska@hey.com>, James Clark <james.clark@linaro.org>,
 Leo Yan <leo.yan@arm.com>
References: <20250312072329.419020-1-yujie.liu@intel.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20250312072329.419020-1-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::22) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|BY5PR12MB4034:EE_
X-MS-Office365-Filtering-Correlation-Id: 27be5d96-6930-469e-9e65-08dd62c676d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGZsVmxjYk03eTNiS3hoSk5DN3J3OUNjR0d1bkNFakw5ZDRMVGUwWlBRY1ha?=
 =?utf-8?B?WFJvakdPVFVVVEZKeit4THU2V3RQRFJCQzYvVVQ2T3ZZVUwrYlhmcUZWTHo5?=
 =?utf-8?B?S1E2dFBwRUo0cGN2L1NHNTB5N1RuRExsTG9OVWZHOTJHbjFGUjM3enlTMWVm?=
 =?utf-8?B?azNXaGR1bmhrcjUvRDJ2VEtyTE9qRmJJN2pEU3dEdmQyMXNIV215ejNWeGx0?=
 =?utf-8?B?RGgrRmFZcTZ1QkF0WUY1T2xEbHVzdUdFSDA3MFYvZHpSd3ZuNVd1Q3NlOVJ1?=
 =?utf-8?B?RUtjeXdSMUtqaVRpbmlrMXkxQVB1Q09nN1ZtZU8xUU41eFB0c3ZGTUg2U2Zn?=
 =?utf-8?B?ZEpwS3o4ekRENUdSZGlZU3JXMjdHTVJtRDZvYytETGlremRLQ1lyUDYwWnA0?=
 =?utf-8?B?TE5LNUpZMHpETEdDc1RQNEc1NlBFMEhQZTZJaHlFOXAza3FQbjhaWGU4UGY0?=
 =?utf-8?B?Nno0MmlBMWJZaXhEL1RpOGQweEtndFVuQWlnVjlHbFNCYWpGYjFpc2tZRmJ2?=
 =?utf-8?B?bzlxcnY1TGJ3M2NBY3hqOHlVVDBBVUQ1SDllaDNjNVhmS2w2STdCVFQ0YUx3?=
 =?utf-8?B?TlNEMG9Xc3pteDJjV1ZxRmo5WUsrK3Jwby9KcUNoTUJCc1ovL2pmd1F6cWdp?=
 =?utf-8?B?UWlqS1RRYUwydDJRU3AwVHl4STlrRDZ6Mm1RaWloRVo2MU5tNXRJdkNpbWwv?=
 =?utf-8?B?NnlEM3p4eXprTlAva1dkNEg3LzlsMjVGRFo3UzRBMkhsSURvaWxNbzh3czJy?=
 =?utf-8?B?Q1RqUXMrcm1jM2Z1djZPb1dKWFJaZGpJQlFWclg1cnVvOEN4MXBJNDJTWEVQ?=
 =?utf-8?B?VzRqVjdiTlNTQmNFMng1Ry9ZYjl2eW1PWnJGTnlsVG95U3ZocUdsa0RpcUZP?=
 =?utf-8?B?MjRyZzNHUHpTam1aSnd2cWdQUUhMTUpPQXNLSVNndC93N2ZHOTNFZzVxWWpR?=
 =?utf-8?B?bHkvWENEVXViWHpiN0dHQml0N041ZFFtRUdtT1NwQytUUkdFQWlBMWVvMTRH?=
 =?utf-8?B?dDZEY1M2VjV0SERHUGZicXFOTEdwdEk1bE5IMzFma3EvS3psOG4zc0xsK294?=
 =?utf-8?B?NlNGNnlmK3Q2WW13UnBFTngxeWJkUC85aU5JM2FGMVJXbkl2L3JjUHV3ZmZx?=
 =?utf-8?B?cndyTTBOY2tsL2xGdldQM3F1MUJ3V3pTQUFZVm93N3E1VldwS3Q1VFFxSFdj?=
 =?utf-8?B?TGVobGkwT0gwZFdobTRGTU5TS29Fc1BIL3BGWGxBdjZER0t2czVQQzFwMFda?=
 =?utf-8?B?N1BoVWVUaW5zOWpFT3FBSG84Yjdua2FZQUYzK1FHNDhMY1NIY0JqUHR2b05H?=
 =?utf-8?B?bTgyOWk2NTJPaGg0YUJEVUFYdStLOEFicXBhUE9QejY5Uk1McE55NVRVRGJR?=
 =?utf-8?B?Q2piR2ptYlc0QUNnazFNMVBOVkF1d1gwOGVBc083WC9wdXltQnhUN3RRVWdZ?=
 =?utf-8?B?UWg4V2I5U0RSUkdHWTQ1NC9CK2NOUExacmNVVHgvOTQ3aTZVVzVnWkgyaEha?=
 =?utf-8?B?L0s4ZEpTV1kwdG5MeFdYaWtuSjAxWkRPYS8wcUZ3MHRZa2h5Y09peHdpKzg3?=
 =?utf-8?B?MDBDbjlKamlvM2hCUjcrVFpCMmwwSUZNS2ZuejE1bzRWaTVLZTl5Qm9kd2Rj?=
 =?utf-8?B?WDZqOHk1Vkl5c3NqdW9hSWE1OExsQlR4TkFCdDFjVlZ0ZENmNTNJRlYrT2RU?=
 =?utf-8?B?RzhoZ09KQTVMelhUclFnVDhCc2dxaXNIWHRzT1JBSVo3UnlIR1VLek90eHVi?=
 =?utf-8?B?ZjgvTU1hZkU2YmJlTHBLTXNPSHo0Zk1GdWU4ZXNzRHpQYTl1djVvd1Rua3lp?=
 =?utf-8?B?bStRMkNxQ1AvQW44eERzdm5CM3I4bHQxZHIxQ3FRaElzT093Rm9ST3Z5ZDRq?=
 =?utf-8?Q?me3HLWARerKMd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXhvdWhCQ2E0S2lXUy9aNGg4Rm1oZHdpbFFqUnNIRHRzUlVoQUNWVGJzc2pX?=
 =?utf-8?B?Y0ZZQlZCaG5adEI5VTJnUnJtRGdlUnZoOFh2eWhwUThMZkdCWEtkWDVYdUlJ?=
 =?utf-8?B?R2l3ZkdwMmp2S2EwSEVaQnlCMS9YUWVtNGg5Q3YyZ3ZHcENXYjBZWmxueHpZ?=
 =?utf-8?B?TXJ6OW5FeStmYjVVcUZQLzRYaG1GUXdObEVhS3BnNEFINzkzbkhEUkVWaWtO?=
 =?utf-8?B?dE96Q2d0YithMUV4alE1THlURUVURUhsMkxHMGNFUWFsSWJwczlIOGJDekNL?=
 =?utf-8?B?ZFNiYWZUNjhOUFp5TzFFbTRzSnFGN21EMnNxcGNjbE90Z29aci9HaTJNTS9Z?=
 =?utf-8?B?M3draUcyRnd5YlYrOHlBMVNKWC9rUUJjdWVmemIxVy8wQ2JrZ041SGVUOENY?=
 =?utf-8?B?elh6ek5kWS9SVE8yU3lRNi9IYXpLbXEycjRpUm9PZHNpa2dyTlQ0bUJFenNE?=
 =?utf-8?B?OThVaXZ4N256VWIyRFBnNE9peFJncUZvbTdrS3dtdEdaMlh1eC9qQ3huVDRu?=
 =?utf-8?B?Ym1ZVXJ3VUJiT29pd2VORzhnd2duc3RHZm9wdEZXNFVwbnlUL1lNV1o0U2hh?=
 =?utf-8?B?ZVhFUHNtQkV2SXkzMWtMUExVK21qNlhXUnFzS0ZlaHVhYXE1Nlk1YnFHYnJo?=
 =?utf-8?B?UFVnQ0FiWEJFdXdQRjEyWGRkeG5WWGtiZUpMTzI3Y01OVHVLTTU0blJEd0dx?=
 =?utf-8?B?RXlrU3Zjc3lsS0hTazZiYTZyMjZYSm5ISnYzaVFhTk9tOHFhOEwxaXlvc0dr?=
 =?utf-8?B?d1JJZGNNQWFTbWw4VGY1R1BlSFJxakpqaWMzMDY5MVp4R0dNTytlNVBUMW9M?=
 =?utf-8?B?cTBoSzlDZ2hXSkRYNVFIYTFyTDZ4YTVjdTN5VUhQTXEzQ3BReTV2a1IrWS9G?=
 =?utf-8?B?SHdNRWlXRGl6OEFjMm5Hd1RldjdGTG9iMlVwZ2IvMC9mYktCWXNobi9ubUFT?=
 =?utf-8?B?Z0pwRVExd3ltdGd6Njg1MEd1eGxuNnJvcnZQZ1F1Rk42elpHa2J1RmVpRnlz?=
 =?utf-8?B?MDM2RU56YlJaSXBzVDhteTI4clR6d0F5Tys0MjAzMDE1Mkh6ZkhRaGI4YmFt?=
 =?utf-8?B?Q3hHbmRHQ1VON1owZ05qcWF4aFJob0hEVlpMMThDVVlHakNDTk85bW44Nnpm?=
 =?utf-8?B?RzZmSkRoRlVoalJIUlR5RFJhcHllRXdvbWRTZlBvZzFwb3o2UTRkWkh3WTRq?=
 =?utf-8?B?ZjFkVDA5K3BUR0ZoNS93bzQ3Yk5waE9kWnNZZ0VDUEJxeHVNQ21VVURJRWFD?=
 =?utf-8?B?TmJwazBUZmxPM1I0anF4cXlOczJva0lMdnFmRHhBdC9QSWFLV1p1Y2FkcVRD?=
 =?utf-8?B?QUppajlwNEgwN3NHUVlnakNncnhZWlpJem1mSzRHSXJROUhITHRMMXo4akNI?=
 =?utf-8?B?SFRKb3NyTXZlejRBNnQvYWNUTHY4eWYxYkFpUGVsQVd1eHk5UkcrY2Q5WDRz?=
 =?utf-8?B?dS9McnFXaGhqSEpmOGtIc1hnc3ZIL0Zwa0I2dGVMRFREQmVHeXkzN2FldlJE?=
 =?utf-8?B?cXA3OGowakVaWkwvc2VRYXA5MTBQRmZHamwzVkFNQ3hLdFRueXJhdmE1MTE1?=
 =?utf-8?B?RkhjTXIwRFlIWXZOWWdTUUE5empsZE5WUm1FUVRqSUdvQjNZVVYwNGlYN3Ju?=
 =?utf-8?B?Z0JNcU1IbjNkSU93ZGNTeXEwam1iRTFyL2dCNUZYTStUYVVDN2w2TXF0OW80?=
 =?utf-8?B?aWtUdXdWbTZwU3g2eEVCTFJDbUIvVXRaZVRLajh6MU5tSllMR1VpbnNWOWhi?=
 =?utf-8?B?NzB0bDJqK2Rhcy9rcFdhNlZPVEd0RjF2WEFrNXdpOWEycUtDc0ZZa1JnR2VD?=
 =?utf-8?B?TEpGalZmYXFuQS9DaUhoUE41Qk1mZFpLaFgyb0tjcjVYWkhWRWVKNUxxQlJz?=
 =?utf-8?B?ZGlJREphcUFEZVp0aDBiRGYwSFBsSG5MdUlEV1dHYkZNVjU3YjhjMFpTSEZz?=
 =?utf-8?B?cEpiY08xcjViVVppWmU0NWlISXBBQWtHdS9oU2Y1d29ua0RWaHM3V2xRZmhJ?=
 =?utf-8?B?d3hSMWR1SnJkZkNYbkU3Mk5sbDd1V3R4REZBZlpjNzJ1NkZOL1FGbllOdXJF?=
 =?utf-8?B?YzRFNVVKRlYxN1dsVTFlNVp1TWlNajNvMmVTbnVsTE4wRVBmbGdiSGdXVm5K?=
 =?utf-8?Q?qGAV5GqCDAzBffWdDqPNsOH3o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27be5d96-6930-469e-9e65-08dd62c676d8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 07:04:29.7353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2P19BR/CbMxVe9UENFgupsGwLQrDW6rizwTYXANFGj/sl18f0TPqqRkBaPVw2gmSW3qCdV7wkkhvQpsvjVQqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034

On 3/12/2025 12:53 PM, Yujie Liu wrote:
> The following commits added new fields/flags to the branch stack field
> list:
> 
> commit 1f48989cdc7d ("perf script: Output branch sample type")
> commit 6ade6c646035 ("perf script: Show branch speculation info")
> commit 1e66dcff7b9b ("perf script: Add not taken event for branch stack")
> 
> Update brstack syntax documentation to be consistent with the latest
> branch stack field list. Improve the descriptions to help users
> interpret the fields accurately.
> 
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
> Changes in v2:
> - Add not taken event (Namhyung, Leo)
> - Change field name from PRED to EVENT for generic use and furture
>   extension (Leo)
> 
> v1: https://lore.kernel.org/all/20250225061736.1698175-1-yujie.liu@intel.com/
> ---
>  tools/perf/Documentation/perf-script.txt | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index b72866ef270b..28bec7e78bc8 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -239,13 +239,22 @@ OPTIONS
>  	i.e., -F "" is not allowed.
>  
>  	The brstack output includes branch related information with raw addresses using the
> -	/v/v/v/v/cycles syntax in the following order:
> -	FROM: branch source instruction
> -	TO  : branch target instruction
> -        M/P/-: M=branch target mispredicted or branch direction was mispredicted, P=target predicted or direction predicted, -=not supported
> -	X/- : X=branch inside a transactional region, -=not in transaction region or not supported
> -	A/- : A=TSX abort entry, -=not aborted region or not supported
> -	cycles
> +	FROM/TO/EVENT/INTX/ABORT/CYCLES/TYPE/SPEC syntax in the following order:
> +	FROM  : branch source instruction
> +	TO    : branch target instruction
> +	EVENT : M=branch target or direction was mispredicted
> +	        P=branch target or direction was predicted
> +	        N=branch not-taken
> +	        -=no event or not supported
> +	INTX  : X=branch inside a transactional region
> +	        -=branch not in transaction region or not supported
> +	ABORT : A=TSX abort entry
> +	        -=not aborted region or not supported
> +	CYCLES: the number of cycles that have elapsed since the last branch was recorded
> +	TYPE  : branch type: COND/UNCOND/IND/CALL/IND_CALL/RET etc.
> +	        -=not supported
> +	SPEC  : branch speculation info: SPEC_WRONG_PATH/NON_SPEC_CORRECT_PATH/SPEC_CORRECT_PATH
> +	        -=not supported
>  
>  	The brstacksym is identical to brstack, except that the FROM and TO addresses are printed in a symbolic form if possible.
>  
> 
> base-commit: b10f74308e1305275e69ddde711ec817cc69e306


Reviewed-by: Sandipan Das <sandipan.das@amd.com>
