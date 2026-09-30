Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022131.outbound.protection.outlook.com [52.101.96.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC26B51CF6A;
	Wed, 30 Sep 2026 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792984; cv=fail; b=exKYAaNuXWt4y9/fkErPnT9Ap+3OzmtZs8m0gAUNONopwrexqLYXYdHLUa1TiORCM0VCcJvLgoJbVpjQCK9280ZfRpAHHvyzrdK0t1Q4IvP4+VAIHxRTwKi/0DTDQdtKHT4PxnW60R3ObBUS4x3w8mbFx/u8JFE2s8Q89ccHwRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792984; c=relaxed/simple;
	bh=wVx2qXHaRTU1IKcAv11gTtpQGVfiBKzCpwrx96R25wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=srbGvMaaAa1AwzCK2ocSsCCaUACk4BgU11jZ7CdCGIJxDqKpMMBhZtWn5uiFBoWk1M3Mgl52Je83teNdDaNKL2c1awlD8lOYVvyWLg9c27kdzYceoOPEb9x/UHIYUpBvoMx8r56UlCJZLslKcDdpu4anlcAWZkKofMo1BED0V0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXOPRX3qAL/l7Eu9+0z9klSpyi9NKHi+NROmbeO1gifrsTLG/ohcwvp0cwFPYwwRST7L7Elxhdxr6cwygm78C1kGiEB5CWpQuVxY3tvFzDSjcQZjncVDZgUap8f0ej9R+TvCJ5n0GV6zIRgJIMakYygPCvVUrI4ofN2dYk5J7YO8L4hBwcKnBggzqxNbAl78iPcEbyAbAXiWKg/jLCNos7YltD8WX9gFmxtR6xdXk6I9klbwXsc1UPU4nApOffBPfJMAuX4U9z0YnvjUb+XSph5ke1vPXYEAqoGHlCJTTaRT+BsLansShJyKYpqOV5j583H+0gobdd2NCXXv28OAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=/XssPJKnat1+7KbOjBfVN24WhTrzbioymzobP4ji3aw=;
 b=xRBjLgoZ3GuFTv/VSv80ZaM2wcjEVWejn9JP48XK4r1tc3e725dOZb2Whx5e6KYGrI98e7fosbnPU6UgshrEo2GTo/0MjPrHAvZzjL7UffqGOwoJbmuq+SGWP3Tdrd+TJsh0LKOBhAi8kaGl7fvE/Rm0zzcWPNbozCoPMqub4Gy5R8/EUICZnfxRSciTHESXEBNy3WM1ce4YtXnHK1YS1AvZEB78EJBc9CeqxjbC2V9HqePUjdUMljT8KcSFKGi0lB/xOpeikggSJLOnfphB+QCh1oBlS843z/FicGkxt9oVCNBpFvFHf3Mz4nirAOkQrPXTgTf3x/ysIP9uQrKoSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6532.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 18:29:37 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 18:29:37 +0000
Date: Wed, 30 Sep 2026 14:29:33 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, 
	sean@ashe.io, steve@abita.co, rishil1999@outlook.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 perf-tools-next 0/7] perf trace: Validate payload
 bounds across augmented argument beautifiers
Message-ID: <fxcirpx4xbhwbxko7isnmwvmrzht5ni6j2vtpc3tkjdcwwm76o@7w5nu57ysjdz>
References: <20260919005530.728615-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919005530.728615-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN9PR03CA0481.namprd03.prod.outlook.com
 (2603:10b6:408:130::6) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebb41cb-ef1a-4ad7-2928-08df1f20c825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IK73AfXSfhmkKpFu4LYCMJP7QwAB7nmgZt1AYuA5Iq/wUAM6TwqlNlXbmwxNkh547uGvEXb1tBDnP6QZ0cZIT41WK4XxhISBBF82gcvsgaIVFIzFNsDljS/nbaciHvPwuxW+K9AmUo2ua0xRSLPZAFHpdHy4uD8XaDsAxVX2TxlXoe/TOKdCdQBzpIWEgq4FezOcQ9MO0yZEFWCTyiyI7f0rogiWHDrrcMtfy6SOJk+z7slc5LRlsvBns9QhhgOIJEbtJpTA9xH6+hWGjT0BTkBpEG1JwppPoyOyJ+UL/TyfktaKi/+kTZVTchrWpbkcz4WK7DtQJO4pKkGxUrOySlmppet8wXgQqMCvIBRkORTvhcOTxVnXi70H6lBjiKItl/27rAZUHTzkOJdkK5s4F+HPGZg0QQnpPAmQhcv/yt20O2BjpG+owwDre8xUnpqQiRdt4vtbJz2qM+8O5EeqtI5B7tOYsTJR0akbmvMj32u9US4wb8U1zBg82RO0gcd13DwftL4j0v0M7xle/e0qay9zlv7C99EhvdNwb+8ku+sJWVDhtoRBdWArXSLUNCBJGMkjyJdHxXGs8wKA2h6eupcBYPFwQlwiGJygC00LfSHwaitBazDsWfmJcHPcLK021ZJ3YjpsM0QVJpAS3UbSktLMr/1ikJkEqnHdwcQkel4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVZxMHVycllKMy8yalN3SmNBYkNxdUFLNUJWT05UMUEzVm9QeUliM09SaHhF?=
 =?utf-8?B?NVdqUklpNlZGTktJVTkzM0pnUUw2RDNSUEhqTHJWTHJZbEVQYXNhUkRqb1Q0?=
 =?utf-8?B?SEJtWUcxN0lSN1VlM2ZKTFZ6eGdUcjNmOTJUS01adkppUUh5SXltZkI2VXNl?=
 =?utf-8?B?NVA5MmI2Und0amVNWjFGWkRKN0hCTmZMWnRBM3VMMGo2UGF1YnNzaGljQlQ2?=
 =?utf-8?B?S25xaUgzcVF0NmN5Tjh3a1VhV0oyeDdob3hwQTZWKzVPTmxKaEhKUUhEUUho?=
 =?utf-8?B?S3ZXRmhtb1BtN2VSMVZiUlhQV1ZQdG8wQ1hhWU51OHFqQWxXUGZoWXowcWZv?=
 =?utf-8?B?MytSRlg3c3pvVHFNOU9IZ2Ixa1dzNjcySVdmbjFscUJLNnk5ckN4aFMxWmNm?=
 =?utf-8?B?QVgybTFSWEt0ZjQ0K0I0ckdKMDRwZHRKd2RicHVXYm9TbTNyK2REUW1lN2h0?=
 =?utf-8?B?THNPRERiSkNUOXBwYTJKK2NoMG0yN000enFrTGNDelJ5TG82Sy8yZEVpR3N0?=
 =?utf-8?B?VkVLVWNjSDdxL0JuaWhjN2V4bEVWRTRDL01LR3JOaEJEL0E4QmIraUM3NFVu?=
 =?utf-8?B?NXRUOHdFT3g1VnFtSityRmd3Z1RPSnpoNjFHU1c2Vk1GT0k5SmlFa0VoNG5u?=
 =?utf-8?B?NTgrcHBmMjhPaXgrd0FNcHhDcU1LRVYrSHJ6dFJZNFQ4eWM3dURJc0xhY010?=
 =?utf-8?B?eXdRNnY5bGs3c0h6QWREZFF1QysvaXFLL1VOMUFaZWM5VHhwSmhteHJFUmVW?=
 =?utf-8?B?Mm5MTXpXNnFZRU1ldVRHU0VsQXBYUVVxQVk2a2IrUlAvWUJQd0VJZWtkc1Er?=
 =?utf-8?B?dDZnOFlkcE5CdkhXQTdYbUs4Qzg3MWc3Yk5pYnZnUW9CSVFoU090ZC9PNEd6?=
 =?utf-8?B?K2ZaT2VzY29qTTEvQ1l6MHZaM3dkZlROUjhtb3VCNEpVc1U0T29mb25PWkhq?=
 =?utf-8?B?U05OblFXQXZIVXlHQWN3d2xhMGdWR1VFNElUY1dDQmc3NE9XbnlDakFGR0pH?=
 =?utf-8?B?SWJSUzlIeFk2bTBML3BKR1RWN0Q0U3hMMk1MakllOEcxcGV1WjB6U00rWVZ2?=
 =?utf-8?B?UGdlZUw2cG1jTUVjZ1ZyUkVlT3F1d3RudGsyNWVRaDZyQlhvRHRzU0dQeUlm?=
 =?utf-8?B?VWhNSThDMTI2MkRNbUtQdE0yZ1FNRFdSOTZ1QTVwQXFkNlhZcGNOY1dXMVJi?=
 =?utf-8?B?VG1CQjhyK1VDblNsb3U4RWJWRmRyQS91YkwzUXlPanZKZWpYa1VRN1h3Ly9v?=
 =?utf-8?B?R1k2MlZTS3dNeDBMSkY4QjVNanZaeU4zYWx3NmY0NzRMbXVUQTVuVnBQdXlV?=
 =?utf-8?B?ZWo5WnJIdjBmc0JwRmFhbTVFdE9XZ21CbTE0czBnNVdaT1VSWFpNVUdodFZY?=
 =?utf-8?B?ZDlQbGtXRHpuRUdCNkE2eWJ0c3hpczZjd2ZiTHpHU1pmeVY5TW1JZTVwU0U2?=
 =?utf-8?B?dGUvdFJQR1BaN05aQ0diQnBOUmJVNHdPNFZQNzdqYk94ZXF6UzRITU5NbUFJ?=
 =?utf-8?B?Q1pOS0tneEVxVFo4R0NLZ1VGQ2l6T0hGNXdRSithZWJEUFdJazJUNzVFNDI5?=
 =?utf-8?B?TjRUMTJhTXFSTWxGNkFQMEI5alI1eCtlK0VpbVNkb0czT2VIOWYwWEc4WTdU?=
 =?utf-8?B?NnFQOGc2djcrN1QrKzVXOEpSU3hraHd0NllEbHYvTjNOQjN4SDBqb29EemNE?=
 =?utf-8?B?RTBXa29sODFKT2l6TjFnTEdVTWZud0RFdldTL3ZlbFhnN1c2OVhtciszSXZO?=
 =?utf-8?B?ZXhqRDI5cmNEVGUvOEl3THhvL3NIK0lQbGtPY1pES0l1S215TUNrcEVhcDB3?=
 =?utf-8?B?Ymc3SklLUURqdDBUbmZSRlkxWUdpMzBSdjNSb3Y3M2dGT2plblR4RlQ1U3Uz?=
 =?utf-8?B?em5UalRGOW8vbi8wVE5seWhOdWQ3UWpLa1NUc1ZkOG9aRFM0aG85WVNlUVJH?=
 =?utf-8?B?K0pvUTFEdy9mMTdRYnNTTW1kazBpWVFrVlMvOHMvMjc3c0pvZDhrZHJvVnU4?=
 =?utf-8?B?Q3pENWQzWmtqSzEvRDRKL1hyZVdCWVB4ekdCVVMzN0NHQzRKTnlRUXhnOEVB?=
 =?utf-8?B?VE5NN1BuMmdIQVVCUTI2TGhKYnhibTdQRHVsRzI2eUMxTDljd0pQM0pvNTY1?=
 =?utf-8?B?a3NNVExkbWsxMXpuY1ZJMWdORmxpa1NOZkYyUlk2ZEVwMURhQUlrckU0eWlK?=
 =?utf-8?B?SHE1aEhpKzdmWVNYMVhyWXRoZlltZGlVQnBxdnFPRGFtS2pFd3RCYm1xMElz?=
 =?utf-8?B?dlVaZzg5TXE4MFQ5MFdqWFNDSWRHdzdHY1UxQW5vV2xzUSt4SG4ybmNHc2lD?=
 =?utf-8?B?Q2UvZEU2KzZjNkVNc29TSWpFUTNaMmRSbUZxL05zT1NlbzBZeUVVZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebb41cb-ef1a-4ad7-2928-08df1f20c825
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 18:29:37.1503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSh0A1q7FMDIC+3kPnWDXtBELJQfMlKGydJdiG93SGnxmYWtVswEvG6Jn8VNTMkN4s1S6LCZuANWsxfrjDu3Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6532

On Fri, Sep 18, 2026 at 08:55:23PM -0400, Aaron Tomlin wrote:
> When pretty-printing augmented syscall arguments in perf trace, raw payload
> data captured from BPF programs is passed to various argument formatters
> via struct syscall_arg.
> 
> However, when processing malformed, truncated, or untrusted perf.data
> records (e.g. truncated reads in BPF ringbuffers, cross-architecture
> replays, or crafted sample records), the payload can be shorter than
> expected or contain invalid size fields:
>     1.  Dereferencing augmented_arg fields before validating that
>         arg->augmented.size is at least sizeof(struct augmented_arg) can read
>         past the available buffer.
> 
>     2.  Passing augmented_arg->size to formatters or loop counters without
>         bounding it against the remaining buffer can cause out-of-bounds memory
>         reads.
> 
>     3.  In multi-argument syscalls (e.g. rename*), calculating consumed bytes
>         without 64-bit alignment advances arg->augmented.args to unaligned
>         addresses. Furthermore, calculating consumed offsets without bounds
>         checking can overflow signed integer bounds or cause arg->augmented.size
>         to underflow, advancing arg->augmented.args out of bounds and
>         corrupting the parsing state for all subsequent arguments.
> 
>     4.  Type/family-specific beautifiers (i.e. BTF struct dump, sockaddr,
>         timespec, perf_event_attr) can dereference structure fields without
>         verifying that the payload contains sufficient bytes for the target
>         type, or trust embedded size fields (such as attr->size) that exceed
>         the actual captured buffer.
> 
> This series adds comprehensive upper-bound and payload-size checks across
> all augmented argument beautifiers in perf trace, enforces 64-bit pointer
> alignment when consuming multi-argument payloads, and ensures extensible
> dispatching for address family formatters. If validation fails in any
> beautifier, it cleanly falls back to printing the raw pointer/hex value.
> 
> To facilitate clean, conflict-free backports across active LTS kernels,
> each fix is isolated to its own commit.
> 
> Changes since v2:
> 
>  - Expanded the series from 6 to 7 patches by splitting the string
>    beautifier pointer advancement and 64-bit alignment logic into a
>    dedicated patch
> 
>  - Added a new patch to round up consumed payload bytes to 64-bit
>    boundaries using PERF_ALIGN(), matching the alignment produced by the
>    BPF tracepoint probes (sys_enter_rename*) in
>    augmented_raw_syscalls.bpf.c
> 
>  - Reset arg->augmented on buffer overrun to prevent corrupted parsing
>    state from reading out of bounds on subsequent arguments
> 
>  - Validated payload size directly against arg->augmented.size instead of
>    reading augmented_arg->size, which is unpopulated by the BPF tracer
>    (sys_enter_{clock_,}nanosleep) and contains stale per-CPU map data
> 
>  - Refactored af_scnprintfs into a dispatch table associating each
>    formatter with its minimum required payload size (.min_size), preserving
>    extensibility for future address families without hardcoded conditionals
> 
>  - Used offsetof(struct sockaddr_un, sun_path) + 1 for AF_LOCAL rather than
>    sizeof(struct sockaddr_un) to correctly accommodate variable-length
>    domain socket paths
> 
>  - Validated payload size against arg->augmented.size and payload_size
>    rather than reading uninitialized augmented_arg->size
> 
>  - Validated payload size directly against arg->augmented.size instead of
>    reading uninitialized augmented_arg->size, which is unpopulated by
>    sys_enter_perf_event_open()
> 
>  - Verified that when attr->size is specified, it is at least
>    PERF_ATTR_SIZE_VER0 and does not exceed payload_size, preventing
>    out-of-bounds reads in perf_event_attr__fprintf() caused by malformed
>    records or TOCTOU mutations during trace capture
> 
>  - Link to v2: https://lore.kernel.org/lkml/20260907015140.363076-1-atomlin@atomlin.com/
> 
> Changes since v1:
> 
>  - Expanded the original single patch into a 6-patch series in response to
>    reviewer feedback from sashiko-bot regarding similar bounds check
>    omissions across other augmented formatters in perf trace
> 
>  - Added new patch validating payload bounds and consumed offset
>    calculations in syscall_arg__scnprintf_augmented_string()
> 
>  - Added new patch validating payload bounds before byte traversal in
>    syscall_arg__scnprintf_buf(), isolated to ensure an independent Fixes:
>    tag for stable backports
> 
>  - Added new patch validating payload size against sizeof(struct timespec)
>    in syscall_arg__scnprintf_augmented_timespec()
> 
>  - Added new patch validating payload bounds and family-specific lengths in
>    syscall_arg__scnprintf_augmented_sockaddr()
> 
>  - Added new patch validating payload size against at least
>    PERF_ATTR_SIZE_VER0 in
>    syscall_arg__scnprintf_augmented_perf_event_attr()
> 
>  - Link to v1: https://lore.kernel.org/all/20260906011132.279321-1-atomlin@atomlin.com/
> 
> Aaron Tomlin (7):
>   perf trace: Add upper bound checks for augmented BTF struct printing
>   perf trace: Validate payload bounds in augmented string beautifier
>   perf trace: Align pointer advance in augmented string beautifier
>   perf trace: Validate payload bounds in augmented buffer beautifier
>   perf trace beauty: Validate payload size in augmented timespec
>     beautifier
>   perf trace beauty: Validate payload size in augmented sockaddr
>     beautifier
>   perf trace beauty: Validate payload size in augmented perf_event_open
>     beautifier
> 
>  tools/perf/builtin-trace.c                | 45 +++++++++++++++++------
>  tools/perf/trace/beauty/perf_event_open.c | 23 ++++++++++--
>  tools/perf/trace/beauty/sockaddr.c        | 35 +++++++++++++-----
>  tools/perf/trace/beauty/timespec.c        | 15 ++++++--
>  4 files changed, 91 insertions(+), 27 deletions(-)
> 
> 
> base-commit: 02f6847e1822714a4201b87e42f92b0d43e8549d
> -- 
> 2.55.0
> 

Ian, Namhyung, Arnaldo,

Please drop this series from consideration in favour of Ian's series
"[PATCH v6 00/26] perf trace: Fix BPF filtering and make tracing tests
non-exclusive" (specifically patches 4 [1] and 5 [2]).

Ian's series covers the same vulnerabilities using a consolidated helper
function and addresses the unaligned packing in the BTF augmenter.

[1]: https://lore.kernel.org/lkml/20260928182605.3649015-5-irogers@google.com/
[2]: https://lore.kernel.org/lkml/20260928182605.3649015-6-irogers@google.com/

-- 
Aaron Tomlin
