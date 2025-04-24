Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022118.outbound.protection.outlook.com [40.107.193.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C11AC43A;
	Thu, 24 Apr 2025 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516552; cv=fail; b=S8B9Ano/b0pTtctY+R1IGN8oLFF9/kRnBnUrp9wud/Qm2h2pjDTdXUWqCgZiEjaaFrX5VkoJi07yNu9dl94gYCopKovRWnTBc/0dSK3pD9b10k1An5yIf/CZbKpg0Cq2gtzaG59Fvh9w8eTMIbRh44Xh5LhsC+ZAzKC1Ba8pOL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516552; c=relaxed/simple;
	bh=nhAIdxRDy9OSv/J3ruj11W+/1zzOCoi+RhRvvuelVUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qukme7A607Ol4oMtIOIU/ppMsr6ez2A0GvGojGkKSBk95LML1qQKE7H6W83EoAEGRi3M22n/B9MRxi0N/BdUtk0hCyWnvL2+NK1zhlQ55I4N5ZXuI343kVB+tColgFfeSTGS/Zg+AnXzYYgI0fSEdqRvNon96JP5pO8geEBdWno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=G2u+E+6c; arc=fail smtp.client-ip=40.107.193.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="G2u+E+6c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAr9Hzb/PNsmUKFXEH1YzEhnjSHaHt8aLaJTuFgPCapO+/0Z1CR0l5pjwerjX+p4q7MX6n3hky5zIfOgAQs5w7tm8xErgLpneX4rKzkr224bDb6FMn6qJFaGW97VtjxOzv/8d3NinA+nzpsvAKw7piSYRnBAGWuHHW7Uv180ZqEBtxYTzJ6Qccqrjw8GCU+9QS4RumS/9d3UubpOWaqGyEwHdors/X26WreQNPDhwtLbbLNiTaFbd4lmcHF1Ep5C9q+6Ol4Ds7kluqlJufDxsTMi+lNmKCUJXS0J6gUcMMWtP36fZ9ufTa3xgXDxz5gglZ76qnDzclI9Zpi3m25d5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjMS3U4JdfKFPtSc9mNrVFywYEd6aVz0Et5kbuTnCns=;
 b=PAXVuN1srmwwmELJx09EIdrchJ8ONQhU2cs/AqQgVaXj61y2HP1+GK4fz6gWDbqk2gH4y9ePUK4sh5tu5dP7esAULP+8ah8tPeY1O0tzEBjGr3Xqx0YvnivXHM+YVQMXObB5pKW6JdevuUSmXsR9dsnR21JOL3iEJepnbP2HdAOE9iZLg1DWEICAGWbIDiP3ocSniUBXbSbFfhCJ3fuyZ2JZGjxPA4bVXKjquIn1wcprl/SKbQnxb8d4PEmbQFkdlq8cw0WkMgpRQwIZILxmhxwgR+sugvzdsoo71sdcQB5JCAcr2S5YWfDPvWmLLy2md3EingTFR/LNyD4BlLBDNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjMS3U4JdfKFPtSc9mNrVFywYEd6aVz0Et5kbuTnCns=;
 b=G2u+E+6crgNhQbHxmSzhY52ckZttj8RE8l+AQ34MLzm0vkybaj8Bo9pXWM4kBAkp+WKoTQfo17aRwXiZ8MwMeoK4WJg8Dx6QUKYiNC61T4hPTdatzO4VB9JIe8UW5zs88/7PuoY4+6bnl7DvAwrTDWdWpoQEyBeaBSccRl2HC9qK2fwddU7oHOWxD+6iuZr127fyUdca7MRqpSeIl26ozPdkvrIkA6Sppf0UQ6rzjBYRUSU1K7o9+1zjzsPE2nQtG6cGrGfrAgrFufqph4AT5FrwNfPdLHYtqQkg2XsFNbux/FOQ884mQcg+58RVNaBzILwZbteiNfkeNADvU9C2Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6661.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 17:42:20 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 17:42:19 +0000
Message-ID: <2fe98d8a-1165-45ac-b539-d597dd1bbcaa@efficios.com>
Date: Thu, 24 Apr 2025 13:42:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] perf: Simplify get_perf_callchain() user logic
To: Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, "Jose E. Marchesi"
 <jemarch@gnu.org>
References: <20250424162529.686762589@goodmis.org>
 <20250424162633.048002581@goodmis.org>
 <20250424163607.GE18306@noisy.programming.kicks-ass.net>
 <20250424132800.49160c2e@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250424132800.49160c2e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0178.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::7) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: a539c781-8048-44a9-bb66-08dd83575c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXNPbEhCSFQ4L2NkTzA3VGlINXp2Q2dDd3RrZUZ3ZUtlNjVZVlZ6SjIzNUpZ?=
 =?utf-8?B?NDBZQm5pNlhOR3NEZTF1VlZVejYyRUhzeFZDalNqdjRjRTJ0Y1FpbzlpL2t1?=
 =?utf-8?B?cnJ3aE9RRWwyYjk5QXBRbWJoQ0dYNGpIRW5sdHVUZzZEb1hiK3VrRGtoWFds?=
 =?utf-8?B?dTZQS2tBTTlRK0RQbXlUS3JSZjI0VlAzclFsWWpnRjhiVWRsbkdnaEVGc0VZ?=
 =?utf-8?B?RUVjYU5MWVliR2dTd0JtcTNybE9iOTkyWU10dkhXVzYrK3pRSDltank2S0Z1?=
 =?utf-8?B?UCtodXYzWE8yczBSdVoyeGV5akZXSDJ3Vk9ranJTQTU4VjlPcGxVYTlpcHd6?=
 =?utf-8?B?eGlYak04RnlCRjA0YkJHNHc3clJMZXRtanNqcGhjNUxuTSt1SlhKV2xUdjJD?=
 =?utf-8?B?MUNQZnQ4cUxmSk5hNGJCVSt1czlBb1B3UFlrWG16NGRhcDh6RkZTS1NZTTM5?=
 =?utf-8?B?UU96bEowSlFLN3hja1lYMGdCTHdtZ3RZWHpINFZrSGlSSFkzL2FBMWFJRUt3?=
 =?utf-8?B?NVdZSkpzMnl5UkZ1R3E1MlBjZGl6aHJJL3NVQWdEY1lsWGdxWFBSQStob3VY?=
 =?utf-8?B?VnRMUUtsQks3RkdXS1B3dUlhVWRtUURuNUZGMDZwMmRlVmNWVnRMaTRRNy9H?=
 =?utf-8?B?T2MzRDhSZkY5ejFobXAzRTdydGI5MHRVWVJlZmo4cE1PU0xIMnplU0F2TzBj?=
 =?utf-8?B?VkNNLzlOZ1R6MHN5TzJYeTZvRGVoK1ljbEZKL1pFakJZVEk0T0lhaTVKVXJ6?=
 =?utf-8?B?VHFwYU1ITUE3SmdJbnNRck5yZUNEM2NwdkNhbWVjaUMweThhWTNjVER4MzI5?=
 =?utf-8?B?bHRRcjcycXVxL24xNGRCRTNWWmdtaVFwRFIzN0pKTWFrOSs0VjVEb0pRQlpX?=
 =?utf-8?B?cG10VDhuNkt4MHdjZWFYeXNnb3c0SldvMGlIci80eUZkVEVqSFlaS3djUE9Y?=
 =?utf-8?B?c1YwKzcwM0dmV2RGS0lBQURMR01IRWJ1cHRGOTRXKzhTaVlzc3RuYSt4Y0ho?=
 =?utf-8?B?TG1xZVg0MjFQbllLQzQrRjV3cENSemFHdG1FRFRJUThqcTUrZWx0Nnd1bHMr?=
 =?utf-8?B?QUROVWlFN2pTNWJFOGozL0ZGTnFGRHVsa29OeGN4VlZ4OU1hM3JSSU85QlFz?=
 =?utf-8?B?QTV2TnZzbWdONnJhMUJ4SWl4blVxdG44TWJvRFZmSG1vUmFqM1c3YmVkOGx6?=
 =?utf-8?B?ZjNVVVNvSkc2YWRqclNxR2wyTFlvV2IzNElPWDdPMFQwZXZtbW14OFFpdnB3?=
 =?utf-8?B?N2xKZmVLMmhIYmM5U3ZncDJzdENPdGZrbEoxbDhIaFVLUUg2RDhFaWZhYlln?=
 =?utf-8?B?SlpxZGpCbkxuKzQveEwvMjE1bzFIMUJDc0tsM1RkQUoxUXJTVXJJZTk0SWtD?=
 =?utf-8?B?Z2ZBdTY3RE9aVHFVWnFLc1RpZEJ5bHpKcy9peG5PbkZYSVlMNHlxcG5qanY5?=
 =?utf-8?B?V1lWRmNPV08rYzFVVmJNTy8zLzFxeGtDMzdKOVNxV3FLbUdmbDBQTlZHZHpm?=
 =?utf-8?B?YVJoTTFTUW84OVQwTEVOS2pHSCtzY21hOVEyeUJKb2lsNXFPdHpVbStNR2ZV?=
 =?utf-8?B?ak8wbTBFOWJYTHEzWExhOVFTV2Zqc0dpdk11bnI1S1Q4Z1ZTNFJieGVUQXpE?=
 =?utf-8?B?WUJOVHZjRC9FRG5hT2xLeEMvQUQvZ1NaalhXNm45bEJLb0V0MmE2NThpN2Ju?=
 =?utf-8?B?U1d2WEozQ3piUndBOWw4Vm8zbGJQZk1VSWwyZFordGFzKzc3MEEvc3hpQ1d6?=
 =?utf-8?B?eTVaNnF1UjlEeTBHbzc0Q2NJb2xWNEkzV1JiUEdSQ3hBRlpkREFyNjV2MzA3?=
 =?utf-8?Q?GrE/Dp3O0uu4f1blpo3qpLvmOhbnyG26Ff28s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dldpRGlDRG1BVkMxRkYrTWhWODNxTlkrOC9IQ3BULzV3ZDdSQ05WaUs1WkY2?=
 =?utf-8?B?K3AwdW9SdVc1M1hjbnV4azlTRXZVaThpY25NTGJZUUpIYTRyMUwyUmJOYzEr?=
 =?utf-8?B?aTdoTXFKV1Y2RmlkYStpa1hhVTN0UkV3ajBRZVV3NGUyaTY1VEJkc3EvUXNN?=
 =?utf-8?B?MnBCQm1hUjU2Y01OeFdyMTZSMHptZFNXTzZtUmZMKzZVMnMwQmh5cE10SWk5?=
 =?utf-8?B?bVdTb210TlQrc2pwRTRpaXlBRVBia29iejAzZWhocWxQcXp4WVJLbnZqaHE4?=
 =?utf-8?B?cVM3VmhPTEhxcDZCVTZJR2o2cFVKb2xQU1UrUVRTbjVjNVRDMFRiRTJOb1ov?=
 =?utf-8?B?MU8wb3BmRDVnOUdBVXZ3ZlJVenEwRVhjc3dzN3dqWmpMSUVwdVlxOXRZNFRu?=
 =?utf-8?B?MGQvZUlSbklRbWU3aXZvUHAzekJKbmRnNGJhQm5odlM5ODNDY3FGenR6TmFK?=
 =?utf-8?B?bWFNL1g4VUpFeVhyWWZMRjJTbU5XZko0NWJ1K2hFYytpSW1FM1VaM1pnQ09W?=
 =?utf-8?B?YXlBU1ZxUzQ0MDl3RmEyWGQzY0pBcHN0cmNhSmZwSUFGK1U2R3pHT0VvWlQr?=
 =?utf-8?B?R0hwb2d6M0MzS2l0cGVCVkZpaGpvZkc4QTMzMk9oNnpHaEd5TTcrT1FVOENs?=
 =?utf-8?B?b0xka1F4RHkzR1cyZ1d3bFBWQm5PaVQ1K1BxVlRZVVdsd0x5RkE0NlVoRVl4?=
 =?utf-8?B?RGNFbmxWa3JPOG42RXdvWldoeGlQWUNPREI1aWoyZmlWRHJTU1RXaUFYRlVM?=
 =?utf-8?B?d1dqa2dOVk0xUnRJRnh6MDQwSzBkQlRxOUI5MzVxYUEwWVZ1ZVY1QXdrRHpQ?=
 =?utf-8?B?dXgrMnI5UWJsR1dPN21idDhOZWhtNFBoME15RzliWGpjVVNidE43UmZyNkJr?=
 =?utf-8?B?S0pMTFhuNWpUR3hjK1htOXBFRUpaWUZWZmYrN2M0d3ptalY5VmRqOFJyVGZW?=
 =?utf-8?B?d1poZllpdmVEdHVYdnhXTjBNZ0NSdEtCbmJ3L2Z2TnVqdE1GWnBGUGROVHZt?=
 =?utf-8?B?TUlZREM5YUkxWkxLSk1xM2FPemdNb0dDVFg1OVhPdXJzWk9qR2dUbjg4ZFlP?=
 =?utf-8?B?WGVBOGQ5bnltVTdUbkUycGRNV2dCTGwxWkptT3B6MVBKcktOazlkcU12eEQ4?=
 =?utf-8?B?UFlmTUtvSEVUeTgvOW9rNzhjV1lzTmdxRWxsNXNpWTFLcWdTSVhsQVZFMnhs?=
 =?utf-8?B?bG5vdWhXd2lQbXVnZU9NUEdhQWN2TXc5UTkrV05tMkVJbG5RN3hiandMWWNr?=
 =?utf-8?B?a1ZmS0lFKythNi9PNUVBZVJKaGxpZ2NqeTRZVURmTjVWNWlDQUg1UTQ3UGVw?=
 =?utf-8?B?cXVjTWUyRFRIdVFBZWZrMlAzeHJrby93cmFXUGorMzFMbGVoUnZNZEowcmlE?=
 =?utf-8?B?NDR2eWMxSTBBMld0UXlWRVIrQWErVnY5SUZvRHhzTlFoWWQvUlI4NFFQWkdD?=
 =?utf-8?B?MFJHejdibktkcjJQL3Ztd2VWWEZsamxBWkt5RllVVkZjZXNubDh4OXg3aUs3?=
 =?utf-8?B?cyt6VVdlQkZ1dVRtSGRKcHBwZGdVTFpsUTZxUUpWY1l1cmIrdkF3ZExBTmdY?=
 =?utf-8?B?amNadVRMb2d3dmZKalNZaUs3SXJoR1F5UGRnY1V0SHJzWkR2cXhBdlVLVDJ0?=
 =?utf-8?B?dElMUjVmU1pFV2o1RGdQaVJ0bFVTRnhGcE5DbnhRcE5UV20xRUNRZVlKaFdv?=
 =?utf-8?B?UUJ2eCtqQlNMbHNHVFFqc082QkdoL2xwd3A3dnhQSllDai9NcS9pcEZ0UEVQ?=
 =?utf-8?B?R2dLbVE4OWxZWGxDdUc4OTFQaEZpUVd5Ry8zeU5LSjNrTkZHRGRvZnlzWkJW?=
 =?utf-8?B?b3lhZjhkKzRYZWxmaklWTWtDeUZWV0liZEVEZ2htQzBVNHhONi9MNElFd21i?=
 =?utf-8?B?S3pMdGdjTVpKamRoL2JtY1FNTXIySFRBdjBRSXc5U08vTVVHN1RFSTJUZmNs?=
 =?utf-8?B?MFpmd2xVay9nZmFGb3ZtVUF2anhDcFhnSGxJczRyTkhDaHZST080WEtkVTZS?=
 =?utf-8?B?UWVMN0lXWkpRai9RcGZ0Wk5mZGYzVVMvZDZqTFVTSTZaTWVCbDltdGZhay82?=
 =?utf-8?B?T1hBTzczWWpqWkpwbVB6S0k5ZTYrSk1mQXBNWDBxMzZsejh5Zm5hdG9jTW1o?=
 =?utf-8?B?SW1SN3Y3WjlYbUZhOUxyVGpFM3VncjlBS2JZN253ZE9EOERwQ3hKbHdGK3Qy?=
 =?utf-8?Q?eDsBJwh/42bqan3e5wmko/8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a539c781-8048-44a9-bb66-08dd83575c94
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 17:42:19.8239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rq212Kvxv4QcWlD9SwNMY/yDemTSsTydK1bUI8IvMbIEprC4dcSpaDyCEj2nyusduLsf/Xb4mS5VROdIj4t/8G9Xg7Y+FyasaU74rMbaAqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6661

On 2025-04-24 13:28, Steven Rostedt wrote:
> On Thu, 24 Apr 2025 18:36:07 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>>> +++ b/kernel/events/callchain.c
>>> @@ -246,22 +246,20 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>>>   
>>>   	if (user) {
>>>   		if (!user_mode(regs)) {
>>> -			if  (current->mm)
>>> -				regs = task_pt_regs(current);
>>> -			else
>>> -				regs = NULL;
>>> +			if (!current->mm)
>>> +				goto exit_put;
>>> +			regs = task_pt_regs(current);
>>
>> I'm thinking this might be one of those is-kthread test written as
>> has-mm, and they're broken.
>>
>> Notably things like the io-uring kthreads do have mm.

Can a kthread such as io-uring have user_mode(regs) == true ?

> 
> Would there ever be a case where:
> 
> 	current->mm == NULL && !(current->flags & PF_KTHREAD)
> 
> ?
> 
> That is, do we still need to check for current->mm if it's not a kernel
> thread, or can we assume it exists?

The case I'd be careful about is if the code can nest over exit_mm()
(e.g. interrupt) after it sets current->mm = NULL.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
