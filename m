Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020113.outbound.protection.outlook.com [52.101.195.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AA83F484D
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013873; cv=fail; b=iz1akiVHjXFJtuMq/ICIvDomWzUyquHPC11KeA0aVdghpDLif2LHcf5OYM0YDurnutAFW6VFsOyuPa8Oo4cuM8snNAI8M1loZOixXPS595S0RKMiM1zPEmqFGAjOTqRlbgjiHTLGkSM0HCLHjRVQrgJxhra6zXeouZFEfm4JQxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013873; c=relaxed/simple;
	bh=gonV6BaZDK5IuCRqZjBRRiPT8iZFdhVFIRMwyYa+N44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hr17dLzSTMNu5OrgnCpF6ijcPP/sNMQNtt6Pf+lLHIXF6/nKQqXzJ1DBgqQxQzzj65wV5tkQL6nto5Bjot5a7yFEWxBKpoOzjIK1btL7XE+0QdNmXnW5WKUuRlL8YTgdp1hsxJpMyNqFp/u3VZwtj+hQpyNJwKdMI+fMn+xJAps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFOF8UOZGXQfnvaRxkSeg+60pTH5U/8YzFdNatxyICcfsaXXIaGD3ZM80ZjV4aELE15oiF0ou6TE1hE6MvvjuktVT1LPkbjkFFIdiySKP9HmUvR3Da7ce8CYpt7r0Cj9/yOH0YxMg5XsX11w61qSAQDbaFjawOq7moUN5PxBQ5AY+pG8Psz6W9bc/8Vw3V0jE0y+VfKg9NcOl2tu3zhE2k4c1gjFfwHkIflTvPZAgzNm8BUyhZyaR8l1HKp6TfWDOEIw2BvjzGa/gtM6KrP1Onr9Xw33iKhd6TsjF6ZZQfRRQxBXUr3NUK+BZOFBzwQfCpah+NslJOL7Iz93HDJWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=iNas7qVf0Nn79rdxYVr8Uq8WvsgXghxR90lvaa1swXQ=;
 b=JB9MayvN659u0IX2WyZxAi7z0o1m2GSgtg3ianILvwgMFKSWzX2asiDLMtdLKAQZt9PGTkB+27Pvd/yCxxJ36xb9vqD4b6Kw9q3KPbieo6Y4XyUzJo8biSFzH815rg2dFDPesSK3iKWx5leA0q2i4fB8HaBztNxU1CtEhNhpKmTYBonkfdhkzTaLKnRRjTa0KX5wY85hrtWC+igU7HCEDAufqnHTkXGUbG7xd/RXi1FnsrNxEj6U7Zzcordhnwfm/9ZMViFUplxX6+MOJk07xiNxKwAI1gXx+pUuD8e8QSRU9Oniuz1BMCIH0vnEd6fWaA4hfFMXqKWk+ipOjOVz4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB4063.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:179::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 21:37:47 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 21:37:47 +0000
Date: Wed, 14 Oct 2026 17:37:43 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v4 3/5] perf ftrace: Support display of
 inlined functions in function graph tracer
Message-ID: <npcqm2oyip3u7dakwbvgnhwidcswzybrq4ztc6ycrewocwxkfo@ywsqvcgjt4kx>
References: <20261014161457.373253-1-atomlin@atomlin.com>
 <20261014161457.373253-4-atomlin@atomlin.com>
 <sashiko-outbox-171531@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-171531@kernel.org>
X-ClientProxiedBy: BN9PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:408:f9::14) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ce17c5-3a7d-47c9-44e8-08df2a3b6378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	mFJxUsPY5YtFlbH6+APABAR5GgSSoxw0s7IW3EUOhHfMIbySK6eYyh2QI63zGDM8GrbuPdLTKbbdULQPHlLGoVfpwXpwFcWZsjhQeazaNYjZJEHseobujVXqjwc0mw7ZlmBlsScMWhewkW3Q09aHxYcmAGp6K3wcW6GJ30AzceHFKC3r/zq8kl5hr8edw26XJulRlhFLVa2dE03s/pzEyCaLR1dfG+URP2WYIRoENCGq8xRSYnTpr8aOwEuqGujM+wuv4pldWwAyh80+W7N6k8TvUSmaypzbcyblqC4BUE5e0ggqG9O2CuDqjP10ObibNCaXrN7CaroW9VQLs0BHGCLdR6zxsE7mEVIMt3q+yu2XCHS8B4vKQn60jT/IfqHyg+B5AB4QtH2uPFYR3CaXu3sw9+rDRTiVUXOvhyGqQutzKoYQb+apAqXuFMe+sirFYPzme7zSdIzvyRRHgNdCOPETyS5PQNpI+TSG1k6PK58Z+SBJdfRm34G6SfD8WpVljFOpXlJEAxliyXrrOPv80wKxt9TfBzGHpKgQiZzcX3UuyHTHutZbqdoT/hJK4RqWCY/O7hbw3rUt6O0aA977ImsgCYSIYusbpMa8qIA0H6g3FMUuDXgjodW82N+B9ouYZF/pBubGYjk6mxZwdFDvRnDAqSysoaWJEzdw1qQZ6Lw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGc1WFNlV09tcXR5cXpPTTVoam1xWWVGRmVzcmRLc09uUGNmRmtrVFVxNldB?=
 =?utf-8?B?ckNNODQxZ3lzUW92M2d3ekFacWpYV3JSOWErNEEvVnhqeVdjdGdUd0g1Qkg4?=
 =?utf-8?B?Rm02TGFOeDF5RGFBcFFIS2FURzRqanNzdHRYMU9XNUdiK3hXV3NkTDlQdWtT?=
 =?utf-8?B?Y2JwcE5OQys2Q1FGSlBkZGRDd3o3T3BTdHhlVjlkeDl0c2MwMkVSZVJ2eGRr?=
 =?utf-8?B?MllYd3RxSHdxQU5MQ3F6Q1NEVVdVMUxFZlRiNU9EdWxzZThWa3FnbXBmZy9F?=
 =?utf-8?B?dmMxWnlmUGRyQWRRSlQ2NytTWlpvTU9acDFCa0xjSjNhZFgvYVBOWEJ3Tkxi?=
 =?utf-8?B?SkI1TzNjZ3BaOG5rRll4eUp2QStxMWdCck5ZazZacTdxSGJvVTl2S0xCbzFX?=
 =?utf-8?B?WGYzeDZCZm4yUDhHSzROVHNZTFZFOWk0UjVWWFpyM05LNlNFK2pTVWlzclZy?=
 =?utf-8?B?RGVUdTRsYThtdmk0TFpqTzZOTHVaYTREcEpzdlNFZ2pFUWVYcnJVRmRVVVNy?=
 =?utf-8?B?YkN2RmNsaGErYXN4WmZDeGVuSGdKVlBERHVFOW1XRThqc28xczROT0hPMDd5?=
 =?utf-8?B?aUtCdkhwMFFuSkxBU1ZpZTdzaEx1L3ZSUW5wV1VvM04ydWhyRWZIUWtVNXov?=
 =?utf-8?B?ZkhDWk5mMi80UEZTakFpMHlOZ2RhS213bTk4OTZ0U2F3VWxvNkVxdEtoTE00?=
 =?utf-8?B?b3RLQ1M0SkZ3SFhYWFE1VUpVODdPNXhxNjdpckhTWjJ2NHpBR1NDWjRwQVhu?=
 =?utf-8?B?VDcxV3pGSS93OVkvTk5WdzZtS2dXVDJnNnMwd2lNWjNlOWF2ZVhvSzJCTk9i?=
 =?utf-8?B?aXVOUjA3Nk9TRXBScUNna0ttVFRvNXNPSXM1SFJ3eFlVemdYRGE1bkNSUlA1?=
 =?utf-8?B?UmtlUld3R1dnREFmYURvSndjNm9STENTZmF2cElWUWFEdmw0Zy8xeElWWVIz?=
 =?utf-8?B?aWxZTDNKbWpVdDBSZkwyMkUyU05WOEFwUDJZeHVsa1NhNENocG9PTXczcmZ4?=
 =?utf-8?B?ODZzc1NUMjJPR2FMekpGa3VMUXBCcjBCR2N5QWJTSFdURVBlb2hLakEzQVFo?=
 =?utf-8?B?bkc2Y0JEcWd1ZDVCRmVpdGVXYVZiR1hEVm9DUmVoV0pyeEFnajZSYmVTWTJ2?=
 =?utf-8?B?L1ZkZ1gxWGJJZ0ZNa0RDSUVhTFVVMU9pa3pLakcyMTZ4OVpkczB1ck92VkMy?=
 =?utf-8?B?MzJLRGpmNVpYNFh1TVpuOHBKWjlSN29JSUxrNnp0Y2x6bjVjR1poTGt1Z1dO?=
 =?utf-8?B?VDhZT2R5ZDhJcHZiTUtmQlkxKzVqZjhpajdyMVZ0YThKeG43SXpLdnJmNmRv?=
 =?utf-8?B?V1RudTdjamcyNHVhdC9zbWw3T3lKQWpRUnN6YTVqUmt0Rm1GcHJET2lwbWdt?=
 =?utf-8?B?RjRqbmtjc3dvYVlabVo2R2FoNzVzVWtFSjZQQnk5d3ZYa3BmNnhnd1lVMDBV?=
 =?utf-8?B?WGtmODBvNUpaVE5kUDIrM21ZU3hTRlRrSUdrUVpsL0Q4TW5oZGVqcDliNXlw?=
 =?utf-8?B?U1R4dGg2bzRFR1Z1L0dGZFR4TTJtTDlEQkpqc0doNFdQMnRFR2h2djgrSytC?=
 =?utf-8?B?Sjk1MkY4K3NrZllqdkZHL3hBSEF1UnhZdEQxL0RLY2JVN3Y5dGxQNThDdi9r?=
 =?utf-8?B?WUp6Nmg0aTk4ODNrb3kvcHF0NXZlSy9SdEIzdmVoams5eHVzNVdvV1gwZzJZ?=
 =?utf-8?B?ZTVpNEZ5eXA3Rmx3U1F3cW1VK01wd0dzRktUUExNVGlRKyt5b0ZIeENmbTcw?=
 =?utf-8?B?RkV0eGdYN3BwQWRqcDNOQ1YwMjNhbFErdlMvRWxoTjNBYU5BM2pDZGNEN3M3?=
 =?utf-8?B?N2RTbWxyMXI0dTgxQmpMRllqVzhHY2dyWEZCZm9OU2d5ZHdsU28zeThOL3ha?=
 =?utf-8?B?bSsrMHQ1VDZjNU5oaGtCWnZWbENzL1Y1ZG5FUFMvc0ZmRWNzMEJVTzVJaFB4?=
 =?utf-8?B?SjhKNjJPUWU4dmNqQ1pXdEc0c2JKcjVrL0RtaW9vaVlSSEtpM0pXM293SllN?=
 =?utf-8?B?TlE1RkY4aVJTb2l1QkRNcmdNdGZZa3JVQ0xYN051UFVOMDZRWU9KUDYvNFJ4?=
 =?utf-8?B?VnR2bmJScWFxM2VBM0tEWnNGcmVoaGVrUktrTjQwbVRXMWJ4WWJzVzJ5U294?=
 =?utf-8?B?SzFpdHplcGpXaVlDSFJCSDAwUWVmRE5LMWFXVnBlWE5ibkE5a2FOaCtOdGlu?=
 =?utf-8?B?d0IvdTI5TG9JMkd1dTZxS1YyREpjTitjQU5MZlFjQzJQbUpIUXVTaGkvNE90?=
 =?utf-8?B?U0p3RDlkUUZsZnArYUNtbFVnUWdZVTBLMGNLODVwYXZ6WkFWOVZuVVljUlJB?=
 =?utf-8?B?akMwb1VzdGVqK0g1ZnkzOTFjNWVBekVNZWc1cWR0WklxYjBvYnQvZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ce17c5-3a7d-47c9-44e8-08df2a3b6378
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 21:37:47.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bOz7UhvY0r0osSTxRt25Mwbt1L0opD8Ar0a8tiqWCs6uSMy5BaJ8ZrtehNbapRNB/9Biki/zgf486CBfWY3Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB4063

On Wed, Oct 14, 2026 at 04:27:39PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Does this code overflow the buf array?
> 
> The buf array is populated from a fixed 128-byte array (blank_prefix) in the
> caller. The earlier memcpy is safely clamped to size - 1, but this loop bound
> uses the unclamped distance pipe_char - line.
> 
> If a trace line has an exceptionally long prefix (such as from a long comm
> string or malformed input), could pipe_char - line exceed the buffer size and
> cause out-of-bounds writes on the stack?

The buffer blanking loop indeed used the unclamped offset (pipe_char -
line). If a trace record prefix exceeded the 128-byte destination buffer,
buf + (pipe_char - line) would point past the buffer boundary and overwrite
stack memory with spaces.

This will be resolved in the next iteration.

> [Severity: Medium]
> Can this cause parser stack desynchronization on deep call stacks?
> 
> If a trace contains more than FTRACE_MAX_STACK (256) nested frames, the
> push logic correctly drops them to prevent overflowing the stack tracking.
> However, when these untracked frames exit, their trace lines often contain
> bare closing braces, which results in exit_name[0] == '\0'.
> 
> Will this unconditionally match the topmost valid non-inlined frame on the
> stack and pop it prematurely, permanently desynchronizing the stack state
> and breaking inline resolution for subsequent callers?

I will address this in the next iteration by introducing an overflow_depth
counter in struct ftrace_cpu_state. Entries beyond FTRACE_MAX_STACK
increment overflow_depth, and exits decrement overflow_depth without
popping the tracked stack. Only once overflow_depth drops to zero are
tracked stack frames popped. I have also expanded test_stack_saturation()
in tools/perf/tests/ftrace.c to verify that overflow exits do not
prematurely evict tracked frames.

> [Severity: Low]
> Can stale real frames prevent inactive inlined frames from being popped?
> 
> If a function exit event is dropped (for example, due to a ring buffer
> overwrite), the corresponding real frame remains on the stack. When the
> next entry event is processed and we attempt to close inactive inlined
> frames above the caller, the loop breaks immediately upon encountering
> this stale real frame.
> 
> Does this leave the inactive inlines stuck on the stack, corrupting the
> nesting and indentation of subsequent call graph output?

Breaking on non-inlined frames during entry unwinding indeed caused stale
callee frames (left over from dropped exit events) to block the closure of
inactive inlined frames underneath them. This left inactive inlines
stranded on the stack and broke subsequent indentation.

I will address this in the next iteration.

-- 
Aaron Tomlin
