Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021129.outbound.protection.outlook.com [52.101.100.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F96C2C11E4
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 01:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941733; cv=fail; b=MvEKwkL6y4FC+xedGQKxF3d4WjbS+St2m6/V2RiYCQ6r8UDER0KjwuYyWysQsTZ0JPWC0akjNcZFC1t1QhFT4ua/W0djuSNskKKtaY+FMe+zJJLhGlBahK3sIZPkHot0OCY3IPs427YKE+fxzzAqAOVHGqsMnatH1nYeWARQySo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941733; c=relaxed/simple;
	bh=zm612myW/MgIY6fYm3g5tFYZP67MqV02ylk/OPeHqMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PkfetOdnwZmRjaFZumjSBPrQo9Ga0M9tFW/e1ZN2yYEFiqh6zcj/v8mt2zSe38EZiQMtNEhNYwIUWTZgX0A2VvgcYlSp4hlnyj780aOIZXwi5ANf2MHIhQFwHdbUkp6M1Ng5kFRhMmwUWT2CDMZFGbkrTXeKkV8AvnHk2LLJ0Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DA5DF7zB5EOkzLy6Chh3sNt5g0nqyuuzBSjNyeZrIOUHX4GhWz0R1dbdz8toZymEQinMyTyjM3KqqjFqClMesg3XdSpkv0xuVLX2Oxt1tkfzvL6jaJyy2VyqD6983xbgHcnjQM03Ms/PdWw2qTfHqEZujHszMYAjWvdUANT2aPyLrcCWW3Jo4G/OXD4p4i09Ai7FVqAGOG9Zteuu0ty/kiumWnvVlp30vLlvqsB+FpIG6PRWKUHoxb9RudZlErSkheNN+AxFwebSChZ9jVbf2P2kILQM6uToPqAxYsovJE6uQXYKpSzSu/3MXBoWIJCqaHUXIeILpDktsm+aVbdCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Ln0hmnlEKfuPSu1lTiomM9zkMLY6ZzHftXw3DgMAckY=;
 b=ouiaOyYlbxnZ8NFeeOPTHXLXRVGLGicJBPhuPU5bdap1HDx36Nh09cCE1sj0eecjUv6BbaCsX/mVpnLVAeWR4/jMElu5avb8BF+QzCu/2kxcV//+54WkfCCYT82+i9YmG9g83n1eZp7N0AohVUesaAsAstqzC9pod3Wmmz800vnA6ncvMJHjDv9M5fSEJMOAFsyrRCZUWr9/jZi7OYf097N/KIY/QEUgfofEauyOFsibWhFVgmLKh2aS7ciTzGaWdCco7nNQ9HZr1eQUlPSrvAuPyj36UEaJFwNiwlDQXsXLyz/gkALypII0pu7h+CuqGcnte5qSZtS7fmPFAfMzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB3284.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 01:35:28 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 01:35:27 +0000
Date: Tue, 13 Oct 2026 21:35:23 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v3 1/5] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Message-ID: <3dmx4cetvt5g3ixrd3j2wkxnqhjsuxhskcllt5h5czlesesoto@f5luok566pva>
References: <20261012003016.263063-1-atomlin@atomlin.com>
 <20261012003016.263063-2-atomlin@atomlin.com>
 <sashiko-outbox-167529@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-167529@kernel.org>
X-ClientProxiedBy: BN0PR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:408:142::8) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB3284:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f0f9c6-614d-4172-f1dc-08df29936cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|10067099003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2gkoNOMOS0wV6UPbZEohUMixhv11BqEXDOiMQI3wX+zD09BwnR68qy5VEw8CR6aUg23c06KP1MuFcykkCpC04UiAUS4HGxmkpjUlAxND6fEVxmFeWlDT8Fo7S7iH3IsAVh8Cik9rRL/x2Iqs6C+nVVIuveo7ogwzWV+qiDVa4nQcqT6rzXKvniSLTQSBIZrZY9dmdHlV3tG0ubxVrtcDVU6zlS9aCFHCxi4xDfLdZMwKvQn3km5KnPSr1jwr1l4HXBsw60MkyFllwp7ahYYBJEv6B0tqAizex0CYqaGGgxZm4QFgeorvlCqvvmvhnau0dHG3ZQHSq557DAYFjqhTCtMDJwUjtEAAylQIN8aaLLMxGPk1ovgclsAnvVJO9W1OnKuOmzboDcXlzKplQOhT90+sWixTm5Ge93Htouxq0tvJLqYfMGX6ftSXY6Q7GPl2vHjIIP1OZh2K+Ytjokc5tXXGGD1WACphis1tCbhlAG9Kbs+QsOoPwL53v8jmLb//N8JA+wYcAn5oahjcZlBEE8FXM5ko0PW2DoaNZlSYICN0gvKSqBPMlRx9fW0GWoBCC4r+Dex1RKVHtylEslnx+kzN1Srin1DUoMKLNAk5pJaokDDUmTi1db0GPNJvO84Jsl5tf5C8bol/wotxN+ocEV+PLG19tNPjOHYGBNs4ZVY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHZyTWFNMU1LdEY5a01DS3dkbGhTY2Z0QkZoSUNITmR1cjJOUnhnWWdJeTdG?=
 =?utf-8?B?OHppYStIdHpPOHZGYlRIMkUvRS9EU3Z6dEFWVmZGK3pzQUsxaStYQjlwWS9u?=
 =?utf-8?B?b2ZKaEJ0Q1BCSHhPbmxzVHIzMGhsYkxISHlPdmVuSjZPei9lMzRzTWROZWta?=
 =?utf-8?B?S1NtNnFvdUhiekFVK2IrSFlLdWExRGJGRmtVeURUU29wK011Y3NPbVBsczlT?=
 =?utf-8?B?RVZ3MUFJeVN3VmxEdG9HN3ovWldzYVkzbGJoUTBoMnVzTDFsT0gvUVpva0x2?=
 =?utf-8?B?dVZTbnlubXRqRHkrR0IrZnZqZitSbUNVVC80SUxsYVpQZXR5QW5uSGtOZU5C?=
 =?utf-8?B?bVBCSzhkODM5bldyUjR5WFkzTTZXL2Y1V2s0NG5HZFU0N0crdSsyOW9ZL1B3?=
 =?utf-8?B?T0J0SmdYY2RYSk8wbGZnL29wUHY5bkVNRGR0R3VUZm1zUHR3czAzOUdzKzUv?=
 =?utf-8?B?c3BoblNqdi9zU1RwZldsZGdiNmpHQVVlMHpMb1BJS3lxVXpBbmQ4WTk1SSt6?=
 =?utf-8?B?YUJaSEg2MUoxaTROR25jeDM2NHMyRC9RdFlsSHFOSW5BeDBCVU1GQ0R1YUR1?=
 =?utf-8?B?VjYyR2ZkSlord0RLZ1ZSRkMzYU12K3JUK2hOTEk2UGtFdlJqOUZjWENIMVpk?=
 =?utf-8?B?REZ2VkE5YytHQ2paM3FXbHBHZnF5aUlJMTJWbjNYdFVCajhneldZTnFpSCtZ?=
 =?utf-8?B?VVdUSllHTm5ZdXJ5cnhBcC85RzZkODFwYis5OUdkbzlJOHQwSzdBU0N0SWNu?=
 =?utf-8?B?b3FzamdydFZPakVsaFBEVmhjKzFnMndKT0ZkckhydkhXUW4zVGhPeEFTMlN5?=
 =?utf-8?B?Qyt6SFhJakhHYk93ajZzOVVoa0FtWU5iaE5mRXY3bW1sdWpHWjllSHU1SUp5?=
 =?utf-8?B?QjZJZGhES3FPSzdHRWF1MVJqbzhGTk1ESk41c1VPNDJRZ05MRkp0d1ZERzRV?=
 =?utf-8?B?Q0k0aVM2Q1ovYjBrTWFpeXFRYjljMlhSdlhwY05NNmNBTm9aTkNKcUQrNGd2?=
 =?utf-8?B?Q3F0eVRjUmxRbTMrN1QvbFE4YVpDdFk4VHFtTVJPeWxrQVpLQjdVaVhjZWZw?=
 =?utf-8?B?MXY3ZzBWbGlZSjBGcGJUS09sUGtCd21YR1RPUGQ0YjBkS3pzUit4NkFGbWZH?=
 =?utf-8?B?WTgzcVRUQW00cXR4aUZiSEsyQ0FjRkE1YVhFNTRtVml6OC9YZTM3c0p3TzdN?=
 =?utf-8?B?WDFsaHhkZ3ZVQmFFektJVkJwR1RDSC9WbVE3R2NGQWFvVm1sRFljSnFEUkpi?=
 =?utf-8?B?TWt0WFAwOUJYMHJVZFBXWTl4WDAzdWxjcWpMcnI5R2JlSk5BVTNXSlFuQk5Q?=
 =?utf-8?B?bjA5dTFnZmJwWngxUFRMQTdtUnZwNmdINGdlMjlwZzBrNjlEa0pKMWhJRnlR?=
 =?utf-8?B?cEllSTJrd2E0bk16NGJEckhjYk1NZCtETFZLNEN0b3A0d1BQRERlRkFFYkYw?=
 =?utf-8?B?c2dxdVVLOE5rUTZ4MlZVbHpQNlBIS3J4K2FGdTFJOXk4Z3MwejdFK3JyNy9n?=
 =?utf-8?B?OHBueTFjMHZkam9RVDh5ZTlMeGYwcUQvdWgyd2hqdVpDSzdneCttUE0zQ1I0?=
 =?utf-8?B?UVV0dWdNTzdhNnFQUHhWQUpOSmwwZm4yem5zeWNoakhwT0wyV2NOQ2RySisy?=
 =?utf-8?B?b1F2RkFjSkw3bnhxR2lwUysvbDAyVU9MRzZiY1NCcnlpa1l3QUFKck11WFp3?=
 =?utf-8?B?K21SQVVScGZLOHM0Zkp4V3RaamthK2pvUHhtV2dkNFdyZ2Z0Slo2QzAvRlp3?=
 =?utf-8?B?Rmp2dldVNWUxbHZWazdGek1rQXE5Sm1yRW0wMUM3NlJNUGFCQzhYdzhlbHRO?=
 =?utf-8?B?eTBnVU9aL0FkdW10eEw3elNYZ3YyeU5MK1hRRUFkb0hNZk81ek0vZTJWOEM5?=
 =?utf-8?B?UTNWUXI3WkxMc0plNUxqZmtEYVR6WjFIOGJ6R3RDVzdYb3NsejJuT3l6MGVQ?=
 =?utf-8?B?bVVsUWNVY00wdUVDb2tRVUI0OWtDdnkyUzFtU0RUaHE1MktXcEZFRGgyc0ZP?=
 =?utf-8?B?TDBSUGZIa3IwYm5xKzVMUS81eDJ6TFpCZnFjMGV0NFNoTFBDaWFKWHlkR1Nx?=
 =?utf-8?B?UEJ6Wk8wRDNZdW54cmZUWE9yOXV3WGhPN01BNTRISENEQzl4bTRJZnQ1eW5G?=
 =?utf-8?B?N0crYUQvT2xrclZOTXpFZDJpcmJLT1FxMC9oaDFrRnl5S1crSXhZMWhxK1hT?=
 =?utf-8?B?VzhqRGYyNXlxZjcvVEZNSXdkVGFrdXhLYTNGeWpuTHA1ZGZTY3ZxK2ZqSVhD?=
 =?utf-8?B?a3JTN2pIMDdhZkxIN2o2SFpnRUtVa2ViaWhHNFByZXhSMHJvL0lEMExVNlFX?=
 =?utf-8?B?Q2RIV2JzWmJJSU56KzJaeWg2cDZoMDhMdXlIckJOcTZCdGt2OVlVdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f0f9c6-614d-4172-f1dc-08df29936cea
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:35:27.6304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Bg0giD0FMro+N6NJMi/zq8fCVESNLcFJ9eb++j97zZQCAUAySaAC/foxZLQWgJUsHe2gSC8DIKE6/lz9IteRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3284

On Mon, Oct 12, 2026 at 12:41:36AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Can this print uninitialized heap memory?
> 
> Earlier in this function, strbuf_init() allocates the buffer but does not
> explicitly null-terminate it:
> 
> tools/perf/util/strbuf.c:strbuf_grow() {
>     ...
>     buf = realloc(sb->alloc ? sb->buf : NULL, nr * sizeof(*buf));
>     if (!buf)
>         return -ENOMEM;
> 
>     sb->buf = buf;
>     sb->alloc = nr;
>     return 0;
> }
> 
> If the very first character read from trace_pipe is '\n' (for example, from an
> empty trace line), linebuf.buf is passed to fprintf() as a string before any
> null byte has been written to it.

So, when strbuf_init() allocates memory via strbuf_grow(), realloc() does
not NUL-terminate sb->buf[0], leaving it uninitialised if an initial
newline is processed immediately.

This will be addressed by explicitly initialising the buffer with
strbuf_setlen(&linebuf, 0) immediately after strbuf_init(&linebuf, 512).
For example, following the pattern in tools/perf/util/pfm.c:

    strbuf_init(&linebuf, 512);
    strbuf_setlen(&linebuf, 0);

This guarantees linebuf.buf is a valid empty string at offset 0 while
preserving the pre-allocated capacity.

> [Severity: Medium]
> Does the removal of the stdout error check cause an infinite loop?
> 
> The original code explicitly checked if fwrite() failed to gracefully exit
> the polling loop if stdout closes (for example, when the pager exits or
> when piped to head).
> 
> Because trace_pipe provides endless continuous data while tracing is active,
> ignoring the fprintf() error forces the tool to endlessly read trace data
> and discard it, never terminating.

Indeed it does. When trace_pipe is active, read(trace_fd, ...) continuously
yields data regardless of the stdout state. So, relying solely on (n <= 0)
never triggers EOF or broken pipe detection.

This will be addressed in the next iteration.


-- 
Aaron Tomlin
