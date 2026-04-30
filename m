Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1737419A;
	Thu, 30 Apr 2026 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546535; cv=fail; b=SGaF8c4D/GSmIXQ3ERnSWQHw+uVNZNJFiUXC9aNY8xJskHAxZsW+TI7MGDw0KVmQ8ItDykZEMxUL4MQf2n3mK0w89OZwYXfnNlSCq7CVVKsEv/SW7SRPnvEMtEdhpn41T+OhKZJqPyOzIYPJMcahX9jGcd+dDZHIRg7GUVxG/SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546535; c=relaxed/simple;
	bh=Lj5/DDfqi+FVlkRl1+LKzcQ60QsmyedbF9NMWfp+UmU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Q/Idy2KGi1dARMgZOkU3qxUgZkdKWL/SGBLbEY2cb40EQ1vV28sKub1QzLJBNAMEHN9tdKLoIuR427byT+vtDiEMZmosK3vA1AurwlLHvc8/+1MauaO+EndQziA2YUNtO+TQkyV8Cvkd6Cn6S8WTARNpyGul/GPfYlMVyZnxtH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=tQo7iXz4; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="tQo7iXz4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOEKZNVjmFcoR8U+jNrh9bJvcsL32BWnybtAtXFjqsxW+AJfu5JQAvxfVpJLYnr/P9C4J9pnsVKm72G5whNOGDBAYUWvJTfk+IMX6RP3gKejSH6K0f0oW1JJK5pRDtgDJyG7SUVifW5idxUICvzmbbTPufA6aJ/yLPPin74er2k5LzGAbJWkYUp2aPcdasS4sLuHN/OEoORO2Qg5ZXNiUrTwF0xjmDJijkLd9d6SiFOM5WjwMFr5lpYCnYuQ7lM5P8YUPmH3Z9ZCklKLPj3Yc+UIvHaR+hS85OwoA3XPDkWkX00ROt12UFAzXCe+kbNt4eAkN5EHcNrFcHkKHGkacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxBmVz97jKbetP62PPg5L2eyo/FPq/I9IiGQrioGeW8=;
 b=hJ8dSMuMs+7c3vNWGvsm8jjSlgLqvf+f0XSe/G8FgNHL7uZUAyaw2LrdRLka72fAvkWgJid0BMWOxXurRUabBxKG+kMIpRAWUqL4AE1+TuhUdxk1f7byhV8yvWrPtwLqQ//S9S9yVSj9y8K2NbKQ4iJkYsMmDSqWV5xpQA8rqDZGEIOwucifT3yT6pYhx7bX/zfKth7mgU/1c5hOZ/mlAkVvFGGbwGSm8Pw/roecgbzJgFhsvqgGzQ60uXQpv6+Z+3U+RZETmr7/aclPEo6Aa55tuSbTmoGesv7Z4wdisvtz/JrE9PmV6XEVBYBo8zJ8TjUT0yWprx8OzTj94lqfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxBmVz97jKbetP62PPg5L2eyo/FPq/I9IiGQrioGeW8=;
 b=tQo7iXz4wJw+90h6lECIa1QEYwvEhXJJXMrU49Jd0eUOLeUTZkI0I21odepcOP0RxJR98zSsy1plvS9beOcsAuYIUxtwx/Z4wKbF08D4sNPAT/PcIIaU1X3cpkutYGpUxr1acLDxyIIWy4gMIin6XauXEmY0Qbcl8Bx3m+eDT483FoX50bKGPyCSSR+eXYGvXA5eAKX9Xy2IKcPMTi3dQNWhVaXgjk7eGRRbGTYHCfH4T7bnDd/scp8Edxyb2bXAI/r5+Yycx0bcBp5r6xdfxbelFaiO7zoUopxTXv3y+Vvw2GpVQ9nBdKQ6aTdFp/JBVzvPPZh98boiuIzfRSGWXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:336::8)
 by DB4P189MB3117.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 10:55:29 +0000
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884]) by PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 10:55:29 +0000
From: Fredrik Markstrom <fredrik.markstrom@est.tech>
Subject: [PATCH v2 0/3] arm64: perf: Skip device memory during user
 callchain unwinding
Date: Thu, 30 Apr 2026 12:55:12 +0200
Message-Id: <20260430-master-with-pfix-v3-v2-0-bd526ec04a75@est.tech>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABA182kC/x2MQQqAIBAAvyJ7bqG0MvpKdBBbaw+ZaFQQ/j3pO
 AwzLySKTAlG8UKkixMfvoCsBNjN+JWQl8Iga9nXrdS4m3RSxJvPDYPjBy+FhnSjlevUYA2UMkQ
 q5r9Oc84feGrd6WUAAAA=
X-Change-ID: 20260427-master-with-pfix-v3-ae7173f538ca
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Santosh Shilimkar <santosh.shilimkar@ti.com>, 
 Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Nicolas Pitre <nico@fluxnic.net>, 
 Fredrik Markstrom <fredrik.markstrom@est.tech>, 
 Ivar Holmqvist <ivar.holmqvist@est.tech>, 
 Malin Jonsson <malin.jonsson@est.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777546525; l=3196;
 i=fredrik.markstrom@est.tech; h=from:subject:message-id;
 bh=Lj5/DDfqi+FVlkRl1+LKzcQ60QsmyedbF9NMWfp+UmU=;
 b=LdC/3l1x6uU933sVwb4nEs3pNzOVnoGsXx6ZpO7jlaTsk4yLONmlipYuXElMPhUD0Awl4SwWt
 q1p6PGcKTb/BZ9tr7cWryORvc2qhSGwNfVhWAkbKszz7f1Asy1E5a4S
X-Developer-Key: i=fredrik.markstrom@est.tech; a=ed25519;
 pk=0a8IXHEgAX55JPS8VZfTf1sDp7q/oAOf459tDQd40Eg=
X-ClientProxiedBy: CPCP307CA0009.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::16)
 To PAWP189MB2611.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:336::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWP189MB2611:EE_|DB4P189MB3117:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2ac3d3-235f-46d5-5ac2-08dea6a6fde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	qwIHn/D66THcfeK8ySk5/MIczjeZxeT91tN7iq/+m/SKUAAC6+QwZOJJCmwlE35l7p9lsn4Ctt9EKHb2Q+tsRFA1wLtY9PgIYEoVoC6iRS0d1jnWarUIxArKkR/7mNxAxz/Q5O2FkUtJVAII0e6sxpxeCUE4jw4ZEymFPIOLQEJ9HCAB9DlQ0ReFgJ2TiLabt3KojtJS4Zy7XLx7v0s6fS8p841JlHSnvOOhTGpfJsl3iH0W/qr1EWDxamGJSkhuIpPD0xfCObtefxdG8wC9oUSZhoU0+3mNig8lorFHWP0JSraer6oFa5LYBArIfw7DS6L7wA99SSD0Xgl2Ob+D55D9aad14nOK2SBWGInaJFeH4j5bgd99j/8BKhcNN2Dt819AjH8NI/3Nck3g5DaxZtH0ynAYu+ECLC1/t/vuLM+0a8KUJDA0MqOAi1pnvrmWBsyovr8Hcl8eLfKrch/zyMxnl/x7CmR/oHLKWFAnmrx+OQSubSk2s6P6h6pCMNmScByAEsgocNrz0r8KKwEclzsOtr+E30aMN9Y4I8yhEafRAcuiAf35U0NpYQeHqPlFjFkqxYp3r3boVvtW5ytElbkGJa0kEY36Vmco5e0pBrbjOluBfSiFxBx+wvSaaZlaEjCaYmm+EZyYEVawhSTQzyZXO1Q3rMVuR5Xk/q658ZGBOCo0mhuD8OISLbB9VOR67erGipypxPLQJsXPZQCevm8CR5crNaznSdOnw74QdwGKS+hILXLB5iwIQ6cqa4NRzvouN7fU4L1ptFxpoBR4Cg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWP189MB2611.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnM1OXdnSW9HeWs5bEd3ekdoK2tPQlZtMkgvMmp2bnZKZm9MazdaZnM1aHRy?=
 =?utf-8?B?YksrREVXb1huazVEd0x2eitTY3pJaWxVZThaL3VWTzM3NGVkTEhQNFRYajcx?=
 =?utf-8?B?VkxQU1JjeklFeFMyK0tFdVF2Y0NiclZxeXdXUkN3WDlpTlBzd29KeG10TUly?=
 =?utf-8?B?Y05RMHh6a1NSVTU3SEFLQ2orZWprUWRTcC9zSTBLMVFiVjN5NHMvWXM3a1Bw?=
 =?utf-8?B?ZzlBRXhUdjZkamUySi9mYk1BNHkrWTJscE1vN2orbHZxL2NycjN1Ymh1Q0dM?=
 =?utf-8?B?N0MxZ0QwbkE4TzR5RGJRRlRBSGJ1R2M5VklqTHRXOFRpSzBKaDA0SE83c1hW?=
 =?utf-8?B?eS82RlR1emtrSklTZjRxdEw1TURGdzZVTFMxdGhwM29tZFY1NmJKdGhYN0hE?=
 =?utf-8?B?SEJmUDVsN3hNT1FyV2s3NC9mbUFuRVJvcEplNG5WZVl2dzVrdk8waDJBZWJO?=
 =?utf-8?B?eHEzRkZ3WmRnMkNFbEZKVmFxczVqU3lIVUZFT0ZpK0g2QkxlWDhmbVVxd2NV?=
 =?utf-8?B?YUhHM2g2YWpCTjllcm1TcTJ1dkszekFSYlY2Zm1lWWZPTTgvVFRLbjNXWDNV?=
 =?utf-8?B?bW9BcDNCVVFSR09KV0lzL1dka0JEK1NTV2JtTlF2U0tEUk52anFqMWhMenh5?=
 =?utf-8?B?VGNxdmZubElNN0NhRUduZUxBWmJlYkNrRDZnNUs3Umtab2FJVStXRzdaK2xr?=
 =?utf-8?B?cHVXMjFmSHBGZC8rSzJqSUNDZWtNZWpUM1BUU2swM1RqU2E4bUNDUFJ4UlhB?=
 =?utf-8?B?aEVQTUZMTDZYUXVQYlYwemIyb0dTL1h1WnNreE9OT0hMTjA2NEJlajFNaTRP?=
 =?utf-8?B?VU42aEFndlVXLzhrOWJwM0hTWVhxdWpzR0ZNWHJRQ2JDRzBIa3NHYWVoeHRM?=
 =?utf-8?B?cDBJMEU5dDVZTzNFcGN5SWt3YkFCZHJMc0ZTZ0FCREFQNjlUOXowZjcyblVK?=
 =?utf-8?B?Z2JYTkY2ZHAyZmUxejAxRVZtRUJyYlN0allmQmdyMmE3eUo3VWl3N01aVFp3?=
 =?utf-8?B?QTRncGJKenFLV3dhdVNBV1paZk9Qd04xUFZOK1pYSm5sQjBVZkVxV1pha1Fl?=
 =?utf-8?B?b0VRSS8rTEFUQ2JFU1FYZEdDVE4vZWltalMreUJYaDhIUjFQMGhWWEFFSjBS?=
 =?utf-8?B?c25jbjJTNjd5RkVONHdXSXdLSWo0YkpyZHZ1bHpRT1phM3IwcDVFV2lUbFd1?=
 =?utf-8?B?S1pKU3ZhKzYwUkgyYnhNMDhpSk95V1BGd2xzM1RtMUZpakp0bnBRbkZvWVVu?=
 =?utf-8?B?MXZaTnIxb2tYd245cGlEblNQYjB5VjN5Mk4wVURPYXQyTXh3Y3BIVlhXbkJ4?=
 =?utf-8?B?RDJwNHcxUGRaeERXUkFYWHJOQmNyZzBWZTNxK2VkRFhHLzNBWDBpcWpHWDFW?=
 =?utf-8?B?a2tkV2c1UlkrT01GazY1SEFudUhIdFlYNXAzc0h6OVVWV3dISVVPTE9HR1lj?=
 =?utf-8?B?bDE1dXhqNnpHcDlwSitBRGYrZC9zcGwzd0RreGxqKzhkMDRnQjZuQ3ZDY3FJ?=
 =?utf-8?B?WkxFSDZFSXdxZkpaS2tYSUw2dS9vVGUxUTJFSGJNd0dBZFNYV204MStXTkNo?=
 =?utf-8?B?WFJwaHRsUGYxcjd2NVZiTk54Sk9uU2FuTW5QSmNLTk1PUUl3YXlmRXlla211?=
 =?utf-8?B?L1prWHp0MVkyMVZwSHFTeDZYUW81QTVkS1RoUXhvYzVFU1oxT0R5T2pCbjRT?=
 =?utf-8?B?TDJsZm90OFhsSlR0R2piUG5CMUttUUxDV204VXdrYUZaRnFVT01TOC92ZVo3?=
 =?utf-8?B?MUMvSjdoRkZodFR4SVYra3VGREE4RlJ2SG1zRXhKeklBSG9VU1duRWIvOVBY?=
 =?utf-8?B?aU5MN2dabmVhOTdYc2s1aTNwL3AyTkRTUCtPeEpHRkpNaUVyVDlIb2N1ZFd1?=
 =?utf-8?B?T21JMWlOK1RNNGFnbGJQUlBqMEl5UXRIMUtFRUJqZnZCYkdCVkwreStXVmlC?=
 =?utf-8?B?cjErTFdhSkpFNWtBWW9CYUVMMFVNTmhoTThWT2hpZ0JWa01wWkg5RjBDZUx4?=
 =?utf-8?B?TXlqdmFMQXJQbHRkUE9neUJRSmlpWDJQeWxQMzJ0dEhlQjdHK1ZLeVhBMjVL?=
 =?utf-8?B?VFFEamkvQU10dkFUVTBTeGpCU1ZFdTRkZXBmRTBFWS8xTmVncTVlRjllYlpi?=
 =?utf-8?B?VXVPTEVJS29xanYxSWNzV0k2Z1AwRldOMi9mTnBVcVAzOGRUa0NzcytkRXIr?=
 =?utf-8?B?VDl5eEEvWGtkNDJwM2RNc0t2Um1XVkZQRDVacHZ6cTlZbW5pY0pRd2YrZjFy?=
 =?utf-8?B?RjRieHNKLzU3eElEazY2UHovZzNCRjZ5ZHQ4YkJ6bG9NaDRQWDFZRi92STYw?=
 =?utf-8?B?MUZyMnZVQU1PQnY0Z0QwMnRDcGVSRjlXaWtZeUwxOU1PU1JoVm9uRlpxWE1P?=
 =?utf-8?Q?+bEi+6jiEhq5GvN6eUXEqN4NU8DTatIXbmZncjOGdsbKj?=
X-MS-Exchange-AntiSpam-MessageData-1: 9K1uUANy9PGKPl4mIVDe8SXyTRbY/HG3BzM=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2ac3d3-235f-46d5-5ac2-08dea6a6fde6
X-MS-Exchange-CrossTenant-AuthSource: PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 10:55:29.0797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYdGjhNk0sU1nO9onZ3gtDSSOQKsLx0oFVjcnV3ipy2th8nrSmNwsrBk02zZlVfXfnemx4oVAmycQG3LJO/BZuX4ikr5z4V+2epLpfH58o4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P189MB3117

Perf callchain unwinding follows userspace frame pointers via
copy_from_user. A corrupted or malicious frame pointer can point
into device I/O memory mapped into the process (e.g. via UIO or
/dev/mem), causing the kernel to read from MMIO regions in PMU
interrupt context. Such reads can have side effects on hardware
(clearing status registers, advancing FIFOs, triggering DMA) and
on arm64 can produce a synchronous external abort that panics the
kernel.

This series adds a guard that detects device memory before each
frame pointer read and skips the frame.

Patch 1: Lockless page table walk checking the MAIR attribute index
          in the leaf PTE to identify device memory types
          (MT_DEVICE_nGnRnE, MT_DEVICE_nGnRE). Follows the same
          pattern as perf_get_pgtable_size() in kernel/events/core.c.

Patch 2: (DO NOT MERGE) Module parameter to disable the guard at
          runtime for regression testing.

Patch 3: (DO NOT MERGE) kselftest that exercises the attack vector:
          maps /dev/mem, points FP into it, and verifies the kernel
          survives perf sampling.

Alternatives considered:

 - VMA lookup (mmap_read_trylock + vma_lookup checking VM_IO):
   requires the mmap lock on every frame.
 - RCU maple tree lookup: lock-free but still a tree traversal
   per frame.
 - lock_vma_under_rcu: sleeping lock, unusable from IRQ context.

The page table walk requires no locks and costs only 4 pointer
dereferences per frame.

Limitations:

 - The MAIR attribute check is arm64-specific. Other architectures
   use different mechanisms to identify device memory and would need
   their own PTE inspection logic.
 - The walk only detects memory types visible in the PTE. If a page
   is not present, the walk skips the frame. This has no additional
   cost: copy_from_user_inatomic cannot fault in pages either, so
   unwinding would stop at the same point regardless.

A QEMU-based reproducer is available at:
https://gitlab.com/frma71/qemu-kernel-tests/-/tree/vmio_perf_test?ref_type=tags

Signed-off-by: Fredrik Markstrom <fredrik.markstrom@est.tech>

---
Changes in v2:
- Added range_is_device_mem() to check both ends of the frame read
- Used module_param_unsafe with 0600 permissions
- Documented TOCTOU race in commit message
- Fixed selftest: O_CLOEXEC, mkdtemp, page size from sysconf

---
Fredrik Markstrom (3):
      arm64: perf: Skip device memory during user callchain unwinding
      DO NOT MERGE: arm64: perf: Add skip_vmio parameter to control device memory callchain guard
      DO NOT MERGE: selftests: perf_events: Add device memory callchain unwinding test

 MAINTAINERS                                        |   1 +
 arch/arm64/kernel/stacktrace.c                     | 116 ++++++++++++++++++
 tools/testing/selftests/perf_events/Makefile       |   2 +-
 .../testing/selftests/perf_events/test_perf_vmio.c | 131 +++++++++++++++++++++
 4 files changed, 249 insertions(+), 1 deletion(-)
---
base-commit: dca922e019dd758b4c1b4bec8f1d509efddeaab4
change-id: 20260427-master-with-pfix-v3-ae7173f538ca

Best regards,
-- 
Fredrik Markstrom <fredrik.markstrom@est.tech>

