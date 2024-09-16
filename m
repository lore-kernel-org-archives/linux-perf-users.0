Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B72CA6;
	Mon, 16 Sep 2024 04:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726460309; cv=fail; b=mdOXf2mEgOv7qnLhr2gQb/+hGolzMYYNIo0COnC58+Z2lutVa0n01GMtkSSzoPu19s3ph90H+y+cpRj0qoj8421m1bcKoBJriS1TdGp14S9CU0hmgp4w/zpTe8icJGnOZbpRDlf/nsOoII1QYWh2pa2vkGjn0pBEQz6s8+C2uQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726460309; c=relaxed/simple;
	bh=/R4KBk14vlFtgEB2xjohvys0H7aE6AALVtNN20AhOHQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YxQSKFQjAN6cL8ncbhXfMph5uSCekXszb6XzFjceFPUiYVx/wjUxrjOGTqNTWb2jNSNCrDqHdriLEMf79w2NPusqp/J06/Qoyc/p1Omj8FOwUeMlrPdKPOaUbonLKzFJk4QjFtM/34dQA0TekAWXbEvQxHDoNt4x0qZh9GVpbGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fRXPtuGM; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fRXPtuGM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTak8e2EhW0KsDP7vlQZN0dH88QMpj8q5d6Im3qLIbg0EPv2FmAYy86yyvfO4cvI7FXGpSrX0KM7k9oYtMEn3WqCIiX2gdrm22Nqc/sL/nLNAN13VmCXJ8tHmc5qbE/nFvF6Dmq0G78Ud20H+/GmAZJvyY5eKga0+QGu/eBer3UIVORlP9e9UH3CScwoHZd9zfb7cGr3HHMRSu/MXWFTygmC/Z41fr1ERsRj1LSR4/h0D9d2b+jWIT6H1IyzeqiuCfVALIfm6PstIoMPJyf+VRsSyxr0ekO6NLHPSr3rBjziuokZZKGlcKs0kXbUwrN9nUmc7qapNA9KKe5RQg4pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3jRrge9AplsHcWMgoddm68iAX/GRbmjPsFbn6vepvQ=;
 b=KKbscm9j8q6oa1Ri8lp2fzFIlVhiFmbD83Gp+HUVEr6X/CA5dILhNklATxuj3SbX1glvTGV31Zt/JfdNFj1bbHCbZ+V+X1R7rFw3QCUfxWy8PZOqRmkfMzJV+vZC4qQywbz/XzuYUtZIdi7/GkpJNtJP+DUHuG86YZnMD+eMkguygDG1Gz85XX2kFFw7FVEMJP4ExcRP1E3HBa7RLM0Mp+sH/lgrKORNNusFqUgmPbXZoyyq9w4h5ZsdATZtedckGiSoXfUyoD1TICqFVIppErQPtDdqs4v0pE1YGg4L84ChGRob1hVmuaFhKY0KMnmmLFgPvHHgmsF2E9Vcs4r9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3jRrge9AplsHcWMgoddm68iAX/GRbmjPsFbn6vepvQ=;
 b=fRXPtuGMYuuBL/oHK9WJo2vBjOs+LGpaICk0vAZOsHCPKAEGzT578Ey2+jJtTarEIxMlQ53axzHqQ0oOAVmm2l214jG2SBtvKBXJQUyoivrXaKbjTDqDzgCcNAZMwEPZsyrHR86QHu52WSAwBUhNn2m2Qk9vE6tQI6Vk/X29vUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Mon, 16 Sep
 2024 04:18:24 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7962.017; Mon, 16 Sep 2024
 04:18:24 +0000
Message-ID: <ef56c1b3-5ff9-48de-bfbf-88c99b44695a@amd.com>
Date: Mon, 16 Sep 2024 09:48:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Add per-core RAPL energy counter support for AMD
 CPUs
To: Oleksandr Natalenko <oleksandr@natalenko.name>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, rui.zhang@intel.com
Cc: eranian@google.com, gautham.shenoy@amd.com, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
 <12511146.O9o76ZdvQC@natalenko.name>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <12511146.O9o76ZdvQC@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::12) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: e2173638-acf3-4ff6-7255-08dcd6069b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTdET1F5RmlSYkZwRVFaT3RvenBtdnd5QnphMlI4WmlkQW9MbzVoR0Jkckxq?=
 =?utf-8?B?OFJaTzNBWTJnYy80eDhOc0lLSzE2YlRwUjNCa2VXTy9sYlMxUlNhYjF2UkpN?=
 =?utf-8?B?WHVZcXVsSlRhaEJWTTJqZjRacFd2WXhkaksvbGs4anNTdzZtNkdYWG42a3ZZ?=
 =?utf-8?B?WWNxcUNscE1WMDVJWjhlUXBIVE1xK3o4NGozdmY0UTc5TUVWd1JzWVJHRlEv?=
 =?utf-8?B?M0JDYURxSEpaZkxybFByTTVibHE4cHFISEorZHZLbW9zWGxuZFZpeU9Xajdm?=
 =?utf-8?B?QXE4bzZsUmtYYmhzSDFiS3JSekdyZXFSZ0ZRMEJoMTlNUGJhaHhVSDAyb2s2?=
 =?utf-8?B?S3VJUGhuUGpnZjVlYUsyODV0eXJHMEo0UnFYZWVZakd6SzBDRlZEdTdseUU0?=
 =?utf-8?B?Vy9malp6N3JXYTZGODZoZzhITHFBdWxRTVI0YzRlN0RuY2UyWlhCb1RXdENO?=
 =?utf-8?B?NzJKbmYwODRiN3JBaU9OQ2tYTEJZeHB0bGszMFdvQnh3MlJKN0ZFclRiU3Zi?=
 =?utf-8?B?N0xqaE1VUFptTklqaUpxWkFBMGRGdGEyWm1EYXNTTXRyZW9NZDNnYlRrYmlJ?=
 =?utf-8?B?MnFBZDhoWGRycUZJV1dzTzZ2Q2ZkK0NYS0xGTXhwNkpOcFA5NnROcno5azZi?=
 =?utf-8?B?M05oVTFBVTg0Rk4vSUFNZ3hoUEg1Qk05cXhiMHpDTkpkQnE3ejlzZVdzcDBu?=
 =?utf-8?B?UG9JUlNGS1lLVEs0OVJqZU81WU8wQ1hONXZuZmdsaDRBT3lVdEJRbHRLZkpw?=
 =?utf-8?B?RTNuZnAza2hFZSsrcExwTk1mSXJVdWZZc2lHU3pFQ0x0VzNMakY2VDNSRDlP?=
 =?utf-8?B?M1ZLMlFhWUxLNldGdWl3a1luQk1hQWRiRkNVZEZsR1kzSmFQWmJSUzZ0N2NB?=
 =?utf-8?B?NmVrcFFLclNNU0dld2l3Mlp2V05NUjEyUkFsM25vajVTK1dGLzRpWEdIdkhn?=
 =?utf-8?B?MVRkcFhCY2U3cHNha243NVA4VmVJRzUxU0lJa0RpUTJKVlVaeE84Z28yeENR?=
 =?utf-8?B?Mk1NaDh6a0tXaU5rTUNqVHZjMitaVHRJZ2p2OEs3R2lCaXcydXBES0U3RW9J?=
 =?utf-8?B?NTFUM1VXcFdyS1FrNnZLdVdnZU9zUnZ3eGl5bnoyWUlXSllxWno1RHRxZERj?=
 =?utf-8?B?RTVYcXMzWEZseVE5blVGRiswVWRlbHFUajA1QmhHVCtQcGZqZFNKbllybGo4?=
 =?utf-8?B?NXFReG13dXo1TERuRWNsWlRaM1hSMnAxemNSUGd5aFNTK2E0M1pwbmxLaUJo?=
 =?utf-8?B?ZFYrMWNWMHdTaXVrVDhXbVMxbFZXb29FYzVVQnQxUjZIR0hLa1ZrTS80TWxq?=
 =?utf-8?B?OGJ0ZGxTZ3l6dW1JZDZjUHU2d1E4R1EvZjhPUUVQdmJRTi92eEpuS3pKdUFu?=
 =?utf-8?B?N1NZZjFtbzRDc01vUGxnazV5TG81UWFDTXhDT2IwSW9rMDM0ZFZzSGwxRXM0?=
 =?utf-8?B?aWhISW9yS2tOeGZrWmlyOXZSMXBtOTRxdytIeVBuUERmYTlySWJ0QVBwTjNG?=
 =?utf-8?B?L0NMenZxKzE4MnZMSmdmN215UGRzcmxBUmZXWHV1TGFGOW14czVWTWFVTm5Z?=
 =?utf-8?B?UUZKYmhHWEVzeTdmUmZmcWc5VEV1YzRWR0w0cSsxbEw4d2NHcjlmNDl1RGh3?=
 =?utf-8?B?bVl5aHBFU3hyeStGVEFLbFd4aVRORmZGaWpwNHJNNlRvVFgrNkJIUTNTMFZC?=
 =?utf-8?B?VmVoRVluQ3VPMjRXeWRiZ0hFMmlJODNubnVWWEt1d0FaWkxoc0x0VlZQS2Ir?=
 =?utf-8?B?ckxYVE5IUXpQczlKUE5DWFErUkh6Z1lkbXFPNERzWVJTL1U2c3JoSkNIMzQ3?=
 =?utf-8?B?cjdhdnppN2R0alBqa2xZQWpyUjJtN0VkTFM4N0kvUWJtNEJudVFsRWlBQ3dX?=
 =?utf-8?B?MWxod1I1cEpUQ3dzOW5sZng5cVorby9SUm5JUnJubGdOaWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dldrSkd3RXdQTlRFWkN5dUFtYWNweHlBN2RlMURCLzI4dlk3QTh1M1MwcVJB?=
 =?utf-8?B?ZUd3dUFUUE0vM1Q2TXY0RWJ3UmgzdGdya2IrTnJ0QkFPWWd4b0xlKzllekV6?=
 =?utf-8?B?TTZ4MWpFdy9BdHB0SHQvYjNBRWpick5helhSdWdyZEZRQ2NueEkvMnV3TVIy?=
 =?utf-8?B?ekcyOFdBM25INTFWQnZKa2ZuK1RyTGV2T3ZhY1BFajc0cEVEZExQZ25yOENY?=
 =?utf-8?B?d1RzejNHRlNrRmN5SE5HZWRlZERtMktnVVBXUU5aUFRJMXNRM3Q0ZWNScXpH?=
 =?utf-8?B?b2JhcW5yeUJsYlMrUEdkMVEvUEloU3BVd0xKUlFvNVZvSUUyamMwMzNlUWN3?=
 =?utf-8?B?cHFzTE9UVWVBUTE3VEUrazVJNTZIZFVvaHBmNXJvN3ZrUUdZaXd1SE1vMys3?=
 =?utf-8?B?SUtzM0xRTnZ5RTROQXo0WE42Z0NScEJZNkxkYStZb29VOS8rWEUvL0lZZzN3?=
 =?utf-8?B?R2JiRW9XMXE2NVJZWlFsckdRR1pkZG0yb21GV3F6d2Q1YmhlWFhGQi85SlV2?=
 =?utf-8?B?TDBMdUViakhLdm9CR1RLWDVsenhwM0pHM29QWHlKb2syajZCVzdTcmpVYnFV?=
 =?utf-8?B?WHRBS0wyYWFIdHBaVFdUbysrWEp1ckhLL3pBQXd2VUFYOHdUZjYvZm1XWVp3?=
 =?utf-8?B?QWhoeXhkTVB4dW1KWFJZT2tuK1pGcmt5Q1ZuMHlBU2FPL1NoUENwZmc5empu?=
 =?utf-8?B?T3NyeXZUQkd0VklOa01kNnMxKzNMWXh1eUpyMHVROUE2MDNnOU9xTGtHUm1G?=
 =?utf-8?B?OUFCN0pyZDRzZkhEUGQ3Q3JLM0I4RVJDdk5UWndOVGQ1Z2ZFV1dITEVteUsw?=
 =?utf-8?B?QUZudzhOSWN2RHhaMjJiK3V0TTVpMXVEeWRIUlYwR05DaDlBV1NLb1dwV29I?=
 =?utf-8?B?Z2huZlFXRS81cCs0b3R1dkVhYWFWQjBHODJqbzdQOVAyQ3MrWk1qTkRnejla?=
 =?utf-8?B?cXhZRklxbFI3SUVEU3NYREtsNzdHQm8wZ1Z2dUZ5VEpwOTBEY1p0VFRSMytX?=
 =?utf-8?B?VzJkUnFUZ3cyblg4d0NJTUsySTAwa3ZUdllCdytWSkJBL0xtN0E5NkZKeGw2?=
 =?utf-8?B?T1N4Nko1MDl5MjVjdFhzaVIrQnMrMG9KYWNCYnZKeExUeFFRVkJRaUpWQnR3?=
 =?utf-8?B?U2EveU40RWtTSVRnTjlHR2ZOc3l4a2NoWTIrejQydHFBdE0yRzBYRmpYOTl2?=
 =?utf-8?B?bmk2anlQTUFzMk9VMG55dnVJb1dJZEQ4eEJiYTJPNmNRcjBOSUdhamVBZHlk?=
 =?utf-8?B?ZmhxUFhOcExyVVdMWFRTTUpDNDZndFEzcGNab2EvWFFmYXhEN2htZlU3c3ZF?=
 =?utf-8?B?QUVhOVFLZ2Y5SDZ5Q1RGU0VpY2JocDU1ZWRPTDJ1elp6OGxETzhxZ3ZLd3ov?=
 =?utf-8?B?RVBTWWMzdGI1ZFlzZ2JnQytnMkRFdVNHQXJ0aFQrRmMydWJWamJnbTZhMUli?=
 =?utf-8?B?enB1Y3czN0kra0EvRmRUeVg0VUdGTVRXenBHNVlCSW9FcjF4cU1nN054Y3cy?=
 =?utf-8?B?NklleFNNUWxqSTgrU2tGRkgzUlNUVzQ1eTJkaDUwMW1BaDdWTG0ySWdLaVh0?=
 =?utf-8?B?Y25NeGRhN1FKUTVHc255OHNRQUlXU0pKNi8rTkYwdVZlTHFVMmVvdmJqVWRI?=
 =?utf-8?B?eUQyMHNwVCt6UW5NR29lSHZ2Tm53Vnd4TjAyMG9PZmRUdjRQZVkrd2Fna2Zq?=
 =?utf-8?B?c2lzS2xUSXNPUHZ6NnpETy9KM1IzVEJBczZqWEZYdmZ3Y2xpTGFKa3QwVERK?=
 =?utf-8?B?RkVuUFZxK09GbVhweUVOL3YzT0U4anlpN3Jya3RmYjA1aEFUNWZSMHRwR3JM?=
 =?utf-8?B?elhWWGx4YU5sek0rNVdXeXpIS1FJc3hvakxQT2psRTRLb3l2NnVrYmlLNTha?=
 =?utf-8?B?ZWwxU1ZOSFVlclM2bllPNTFneE04czJrb21DTzlZcEVrN0NneXVtMGZxY2Rn?=
 =?utf-8?B?SWlaUFpPWnlRUW5pMUpsa080NjhBZ3pJdTFrN2VRVDVCTDJ6VTJBd2creGgz?=
 =?utf-8?B?RnRmbStEM1czeXNQZXFrY1ZIUytUU3FDTnpEZlR3eXZnTEFJRVh2SW5oMEo3?=
 =?utf-8?B?NDkzUDdJYnlPNjFUaG9Iam5wZ3crVXhHOW01NWpOT3JSY2F6eEZPS0IwMmtB?=
 =?utf-8?Q?X78ArgEhTo3YC7ay+52k9pO8s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2173638-acf3-4ff6-7255-08dcd6069b30
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 04:18:24.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baPhv2uVLXa5HFxI6+3vIDCmN7R1+JpkWvxYOzUDFlHf/v8y4IOyXFXTdJ34ZXhmzQFnhn4hnPdW3wuRA+9MMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288

Hello Oleksandr,

On 9/14/2024 2:48 AM, Oleksandr Natalenko wrote:
> Hello.
> 
> On pátek 13. září 2024 17:21:40, SELČ Dhananjay Ugwekar wrote:
>> Currently the energy-cores event in the power PMU aggregates energy
>> consumption data at a package level. On the other hand the core energy
>> RAPL counter in AMD CPUs has a core scope (which means the energy 
>> consumption is recorded separately for each core). Earlier efforts to add
>> the core event in the power PMU had failed [1], due to the difference in 
>> the scope of these two events. Hence, there is a need for a new core scope
>> PMU.
>>
>> This patchset adds a new "power_per_core" PMU alongside the existing
>> "power" PMU, which will be responsible for collecting the new
>> "energy-per-core" event.
>>
>> Tested the package level and core level PMU counters with workloads
>> pinned to different CPUs.
>>
>> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa 
>> machine:
>>
>> $ perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 1
>>
>>  Performance counter stats for 'system wide':
>>
>> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
>> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/
>>
>> v4 Link: https://lore.kernel.org/all/20240711102436.4432-1-Dhananjay.Ugwekar@amd.com/
>>
>> v5 changes:
>> * Rebase on top of Kan Liang's "PMU scope" patchset [2]
>> * rapl_cntr_mask moved to rapl_pmus struct in patch 8
>> * Patch 1 from v4 is merged separately, so removed from this series
>> * Add an extra argument "scope" in patch 5 to the init functions
>> * Add an new patch 2, which removes the cpu_to_rapl_pmu() function
>>
>> Base: tip/perf/core(currently has just 1-5 patches from [2]) + patch 6 from [2] + 
>>       diff [3] + patch 7 from [2] + revert [4] + apply [5] 
>>
>> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/
>> [2]: https://lore.kernel.org/all/20240802151643.1691631-1-kan.liang@linux.intel.com/
>> [3]: https://lore.kernel.org/all/8c09633c-5bf2-48a2-91a6-a0af9b9f2e8c@linux.intel.com/
>> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=perf/core&id=8d72eba1cf8cecd76a2b4c1dd7673c2dc775f514
>> [5]: https://lore.kernel.org/all/20240910085504.204814-1-Dhananjay.Ugwekar@amd.com/
>>
>> Dhananjay Ugwekar (8):
>>   perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
>>   perf/x86/rapl: Rename rapl_pmu variables
>>   perf/x86/rapl: Make rapl_model struct global
>>   perf/x86/rapl: Add arguments to the cleanup and init functions
>>   perf/x86/rapl: Modify the generic variable names to *_pkg*
>>   perf/x86/rapl: Remove the global variable rapl_msrs
>>   perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
>>   perf/x86/rapl: Add per-core energy counter support for AMD CPUs
>>
>> K Prateek Nayak (1):
>>   x86/topology: Introduce topology_logical_core_id()
>>
>>  Documentation/arch/x86/topology.rst   |   4 +
>>  arch/x86/events/rapl.c                | 406 ++++++++++++++++----------
>>  arch/x86/include/asm/processor.h      |   1 +
>>  arch/x86/include/asm/topology.h       |   1 +
>>  arch/x86/kernel/cpu/debugfs.c         |   1 +
>>  arch/x86/kernel/cpu/topology_common.c |   1 +
>>  6 files changed, 266 insertions(+), 148 deletions(-)
> 
> With v6.11-rc7 + all the mentioned preparatory patches and this series:
> 
> $ taskset -c 9 dd if=/dev/zero of=/dev/null &
> 
> $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ sleep 5
> 
>  Performance counter stats for 'system wide':
> 
> S0-D0-C0              1               3,79 Joules power_per_core/energy-per-core/
> S0-D0-C1              1               5,65 Joules power_per_core/energy-per-core/
> S0-D0-C2              1               1,26 Joules power_per_core/energy-per-core/
> S0-D0-C3              1               3,18 Joules power_per_core/energy-per-core/
> S0-D0-C4              1               2,06 Joules power_per_core/energy-per-core/
> S0-D0-C5              1               3,51 Joules power_per_core/energy-per-core/
> S0-D0-C6              1               0,77 Joules power_per_core/energy-per-core/
> S0-D0-C7              1               0,55 Joules power_per_core/energy-per-core/
> S0-D0-C8              1               1,65 Joules power_per_core/energy-per-core/
> S0-D0-C9              1              47,85 Joules power_per_core/energy-per-core/
> S0-D0-C10             1               2,49 Joules power_per_core/energy-per-core/
> S0-D0-C11             1              11,85 Joules power_per_core/energy-per-core/
> S0-D0-C12             1               1,75 Joules power_per_core/energy-per-core/
> S0-D0-C13             1               0,74 Joules power_per_core/energy-per-core/
> S0-D0-C14             1               2,58 Joules power_per_core/energy-per-core/
> S0-D0-C15             1               4,67 Joules power_per_core/energy-per-core/
> 
>        5,003391425 seconds time elapsed
> 
> on the following CPU:
> 
> AMD Ryzen 9 5950X 16-Core Processor
> 
> If this behaves as expected, please add:
> 
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Energy reported by core 9 is considerably higher than other cores, which is as expected.

However, can you please post the core_id for CPU 9 just to be sure, also I see that other 
cores are also showing considerable energy consumption(e.g. core 11), are there some other 
tasks running in the background?

Thanks for testing!

Regards,
Dhananjay

> 
> Thank you.
> 
