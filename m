Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020084.outbound.protection.outlook.com [52.101.196.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1122E7373;
	Sat, 19 Sep 2026 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777870; cv=fail; b=aBimibBOoqnN5oqapgkqCk8mJnzA1oSKdRyuJZDZQCweeWAgbvGcpGnhvlkniNMztPLIX8DzP09B3vTYnB9KKxSOYZ+fOT+MydueE14erAn4K7eK2HXxdCuToUTWM4tqOfE+uJT2KR6o7zXsCH8xZDz3rPCpy6tnghH/LqIf8PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777870; c=relaxed/simple;
	bh=gX7R/YewjCb874kthU9Iqm5NatUG74z6YNEsmALZnyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NccYzoBoI+2UaSzJrxhHdKutoiwyUI/hGqpkjquH6f/gByovxJ7Q8aAP2Nx/wm/6uq44hxniDQxNZEpvh/ArMN4P3FidsPWBFIkrEcMOYLsWqE1RVFtokUPsmQ3X8BLYPScoojmrghtHg3s0vgJy5D/GnmupdfHkObQa1ix5UXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCVs2OoKxHwfyQe6OmphPaee/a8GMZBr1CCOMrpEPi59MrLwRjaTTzfF4zgFLRqeHzCGijR7XM8TnQxylKXaIIXL5Q6uqlkdiQ7/hjpvRsuHfPIzJIULkPohon10PaMWOPcsblAMuy+HSPnapIqv8r7g439sGHZfcEoBkjqKluDYt96AaY/JWmEIzDYTLnfawXGhcJL4saR6CvNRW7Uw/hEaCMVVpPDTWHQiHjmMyfxqLnKPRrV4dLwLGaAu6Kos9GwqQbHbzRIgd3v5GvR9+/rtTjQObOQ50RfiMYs8JnQWkaFPFqGsyyNeQLLLclY5MV5gewN95UBUhn3tu08GoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=URtYWL6WFSrpAsoKXxsNhNdXCiMRijS6IJRYH9Ep++c=;
 b=LaSdD1H0+/AOingPI54XBJ68JbPl1YHO6s3B4MpVk/WR1fqULQ4+UmW/WVBxi7/CTmVV+Ua+WWOManA2gypNzCVxKv1R3fQ7B6giFrsVFus74Sfdsu0ZZrmxrh8PSIhsCvJqa9Q1uJgv/NQECcMGAvFv/lhvHHIh/WBm9Lq6Na7GVDsOneEiESfmZE9/U6dS2aqfjgZA7JNU4pgk/J+Lx8b73hPKJTdjgdaLZ90AmiaYP2s13xL430zt8O56BZXXcPFwITm9SY9T/js1amzUsZEdLDJ0eP8HH0Y+ISZA451wkIc2GWkHmjB687mP7IWnVMCQxk9PrFIn7gfVGQegtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB6598.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 00:31:04 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 00:31:04 +0000
Date: Fri, 18 Sep 2026 20:30:55 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, 
	sean@ashe.io, steve@abita.co, rishil1999@outlook.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 perf-tools-next 0/6] perf trace: Validate payload
 bounds across augmented argument beautifiers
Message-ID: <ucvt4ef5oocjdvdsum4fpqonuxc4hkaqwlxs75c6pgktkqpale@7vgwczn5kce2>
References: <20260907015140.363076-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260907015140.363076-1-atomlin@atomlin.com>
X-ClientProxiedBy: CP4P284CA0017.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:128::19) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7585f7-eb57-4267-03f5-08df15e54996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7Xa3p/ptLMyR10p6zUSNYOA9m/atWrCr/lKLGWwIWns4CcgYKKFpA9S6YiPUPXEdS17Ir0JjYzob04swz4152UC9AykjahILQ/C7nlAO3XbU91BLbTdSWMo4h3JWrhyd4kmJL+BS1rrS8rUZQFPHPbzqe5lT0JgA4GD4u9Xa/egI3FHobBbCZ2nC4nGEMj/waHE+0hcfSZeQ1Q4rC/m51G2UgPvYTfzPd20vku1hzv3BWLfuk7wWnVjBX1Q4x1OINXCh7VBakbMH8jKBPtw8CN/Q543Ua/cyIX6PL6Mb/CkBole15cT45ISXNy8HV6BpjM2LlPPPzpmBJlK95aLia94b4alARSfLdZg242vXt5YixwtQpWjDKmce2RrDQyeREWoJXtjZyolUebrPCpGa+lTxthEdEvYUwuqLpypuDhvK1eI4A2V9QzfibPrDZGGgvJhEZu5EZLxO8L/HZ8NyYqrV08iFagwveZk726ge3jbKtb88ohJ701OMYQtJiTY9jB9mngReL4mVXBx8fsoabuU3xZsTw0RJbFHpFmM9ahmCswwycwNz+xOqlOrJeu1dXgOzUFBymKnZZ+BqT/FshUAK+C6IxvxfKdTMeF4QPvA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVV5ZkMzdDNsN3NlT21wOER6LzhXdlZuSkYxMTVvWkhhMjJid1lnSnlrdGdt?=
 =?utf-8?B?bTQwU2FWQitOdDkzTjdaTlh0amZ2YmdhMVFiaExYbDY3ejhDT2NIR3RSOXJl?=
 =?utf-8?B?cW82TjFrVEI4RWVzZTFjb3E1WEZkSy9yRk9PTXc1a1hEc1plVWppdlh4cWo5?=
 =?utf-8?B?VGh5VTRKSmdFbC9pVXFEa3R0ZmRoZnpoOFovV2xsd2cyTkdGODU5em1mWjZu?=
 =?utf-8?B?VFQwUUhJS3NJaDM3N3hhVFZqZTUvUTVnTnpvTmNlZG5WVk10WHBhdzBzR3NT?=
 =?utf-8?B?eTJYZUxuRGJ0dU5yaWEyZjF1NnFDTFlPdTc2RUU3V1dKelpxWThiR29PZzBB?=
 =?utf-8?B?dEhHY00wWlBIUmNsZThMaFZLdUVRR1JqRWJVM3pJLzA4S1RyZ1B1OVRxRXlO?=
 =?utf-8?B?Mm5FWnIwQ3ZCY1NsWHdtK2FEWDBFVlhNNUtVRndENFNPVHQ4eUdaTHJhZnQr?=
 =?utf-8?B?clFQeXpHTXJzSk9ONFBQdy9JcU1IbFlxcmU4UFNKUW51c1V2QlRFTWF1OGcr?=
 =?utf-8?B?dFhaREhMMzdUOC9wRnRSV2xkWlJ4bm4wdWpkTnV3b2lYQ043SEY0RWFETVBs?=
 =?utf-8?B?cUU3Y3ZGS1hxdk1OQTZQZ1I2eVpENC9ZTUpleW1VcjRoTVI2MzFKRHFLTGpU?=
 =?utf-8?B?MDVpbzdJM09sRWVicUh6Y2FybXlmeW9oV0xkaHJFUjhSWUZHcTV4R0dUNEw2?=
 =?utf-8?B?OHVmRUo0K21zbSt0ZmY4Tzl3VWhUdlFyUXFFK1ZDYkdsdDRCY2QrbVEvcjBQ?=
 =?utf-8?B?amM4OTNZbHZzN3pMZW9mWDRWTGN3cGwvS0I4bGZJM3BZUU9WRmx5aWNMRWRz?=
 =?utf-8?B?K0NXN1JFMEt1TXNTUThRNTlOWURaVmhGcWFBKzMweWxnNzBDZWRPWVNSYWdU?=
 =?utf-8?B?dHllY05XOEhlV05HVVA0c2MyQ0N3cTJMcG1OQ0FKSmN5cURUQTVGbG5jT3Rx?=
 =?utf-8?B?VUhiVjlRUjZsdzltMjkzQWhwOXpaTDZrRTJCOFRuTlFQTlZIQmRHMkdoTnhC?=
 =?utf-8?B?MlE0ZVR2UzlwWnBlNUhBVkoxbk04U3dkcWtTeEJXSWUxbURjTGwwb1d0aEdn?=
 =?utf-8?B?UHRCK05teFIrWmZ6cldYUTZScngydE9rdVJNTHh0dWo0Sm0yN3NVd2tYdVNG?=
 =?utf-8?B?NmRMeWc0ZE05dnI4em1VbEIwVEdBTmdJanlZblUwNDlCOG1wTW9zRHVFSGQ4?=
 =?utf-8?B?NVRMSUhzUVRaVHVBYTFwM2NiR1VZN2xCa1BWY3gwbUl5Y1VURFNwbnFla2Jl?=
 =?utf-8?B?Z2NVZkxRc1B0czdndTNxTlZLU3dFMVdnbmQwNzd5UjZLdm85ejl1cEtCQnpt?=
 =?utf-8?B?RlFwRkJOdWt6U1ZlQSsxWFQ3WWdWSitYR3licUtzWFZkRmliaTdyUUoxejlh?=
 =?utf-8?B?R2t3RkhpMm00QVV0aFR5KzJ6WjFnMS8yVE5DQmN1UnpVRWExUHMxL2gyWk41?=
 =?utf-8?B?bEhJSnlNY0N6QnJtb3YwL25lMUYwTUpuTVc0ZGc2UFNNQnZScm4zVnFVdVhN?=
 =?utf-8?B?bFVjNFd6QWtKTE9qQVJDeTZSeDg2aEY5S3A2eitjVUpwV3NHNVlhcWh5S2pm?=
 =?utf-8?B?TVRnZkxMNXROODJ4azJIZGllNGgrWi9aekNoZ0lMckxKWUQ3UkRlTk53Y2k2?=
 =?utf-8?B?SEwrWFl3bS9namkzZlMxV2tVNDJtdThVT0V4Q3dIUm94WHhORyt1WXRYb1J0?=
 =?utf-8?B?L2dGb0NmTWYrcktwT3dIbW5SUno2WjJMcDlmWlc4cTF1MTAxMmIwdGkwVjFk?=
 =?utf-8?B?QkxXdU5jakpOQUFGMkpycG4vZ1Z0WFRCMEZkd3FVeVRqMXNWUHRIN21ZOU81?=
 =?utf-8?B?UmhHeUhVMEQ4TWlTUUttSUZjMno4RkloMDVOSitrM3NPSTBLNEVXZnl3QXBC?=
 =?utf-8?B?N3dWYXhPRnlGUlZTeUxnUjBhZFI3R1BqUE5qcGJQMmpQYkFqbDU5a1Nkd1BS?=
 =?utf-8?B?a3pUdzV3eXlvUXpnUi9jYjZZWnZkYnZrS0NJVTd5SGVPZk9SRGtKZm5zSk81?=
 =?utf-8?B?ZGYxNThnWDNGMm9YZEs5TUFTSzZPU1lhcFBtbVJNZDljV0J0R2xIWmNRdzQ3?=
 =?utf-8?B?bnN1RUdlbXFPU2I5b2lkYmN4KzROQjVRbldaSFpYUGlHdFdXbmFEQkRCOFd5?=
 =?utf-8?B?bWptRFIyWHZnVWFOcXpjckxBMVNEMm5OTUNJUUsyczZ3d2NCYWs0U0pzUFpo?=
 =?utf-8?B?T1pWQjNNUjFpcGZmQzRVczB3L2dlL1hydmdVZzhBenlXdk9ibCtJV2lnbWUz?=
 =?utf-8?B?V3BCclZaaTNHUmFxR0EwWG5OMHZmRnBxelZmNzMvSnlyRzJWSG1LRmlCMXc5?=
 =?utf-8?B?L1NOMm1EQ28rdzJsaHJjQWxqN21VZExLUWFnTTc1WGJ3Tmt6TkNPZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7585f7-eb57-4267-03f5-08df15e54996
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 00:31:03.8822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8Ll3fa6SwWJku9dJ9X9IjZVNE8WkAkNZUAV6+DabY7yqXJ/E/9Y1+uiakxZcFgC6UNHkCsCil0c9r9KRJsxkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6598

On Sun, Sep 06, 2026 at 09:51:34PM -0400, Aaron Tomlin wrote:
> When pretty-printing augmented syscall arguments in perf trace, raw payload
> data captured from BPF programs is passed to various argument formatters
> via struct syscall_arg.
> 
> However, when processing malformed, truncated, or untrusted perf.data
> records (e.g., truncated reads in BPF ringbuffers, cross-architecture
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
>     3.  In multi-argument syscalls, calculating consumed bytes as:
> 
>             consumed = sizeof(*augmented_arg) + augmented_arg->size;
> 
>         without bounds checking can overflow signed integer bounds or cause
>         arg->augmented.size to underflow. This advances arg->augmented.args
>         out of bounds, corrupting parsing state for all subsequent
>         arguments in the same syscall.
> 
>     4.  Type/family-specific beautifiers (i.e., BTF struct dump, sockaddr,
>         timespec, perf_event_attr) can dereference structure fields without
>         verifying that the payload contains sufficient bytes for the target
>         type.
> 
> This series adds comprehensive upper-bound and payload-size checks across
> all augmented argument beautifiers in perf trace. If validation fails in
> any beautifier, it cleanly falls back to printing the raw pointer/hex
> value.
> 
> To facilitate clean, conflict-free backports across active LTS kernels,
> each formatter fix is isolated to its own commit.
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
> Aaron Tomlin (6):
>   perf trace: Add upper bound checks for augmented BTF struct printing
>   perf trace: Validate payload bounds in augmented string beautifier
>   perf trace: Validate payload bounds in augmented buffer beautifier
>   perf trace beauty: Validate payload size in augmented timespec
>     beautifier
>   perf trace beauty: Validate payload size in augmented sockaddr
>     beautifier
>   perf trace beauty: Validate payload size in augmented perf_event_open
>     beautifier
> 
>  tools/perf/builtin-trace.c                | 36 +++++++++++++++++------
>  tools/perf/trace/beauty/perf_event_open.c | 19 ++++++++++--
>  tools/perf/trace/beauty/sockaddr.c        | 35 ++++++++++++++++++----
>  tools/perf/trace/beauty/timespec.c        | 19 ++++++++++--
>  4 files changed, 89 insertions(+), 20 deletions(-)
> 
> 
> base-commit: 02f6847e1822714a4201b87e42f92b0d43e8549d
> -- 
> 2.55.0
> 

Kindly disregard this iteration, as per Sashiko [1].

The observations regarding uninitialised augmented_arg->size reads, arising
from the fact that several eBPF probes in augmented_raw_syscalls.bpf.c omit
populating this field from the reused per-CPU map, are indeed entirely
valid.

Likewise, the points concerning dispatch extensibility and variable-length
path handling in the sockaddr beautifier, alongside potential TOCTOU
discrepancies in perf_event_open, have been taken on board. Additionally,
regarding the suggested inclusion of <stdbool.h> and <stddef.h> in
sockaddr.c, these have been intentionally omitted as the requisite types
and macros (bool and offsetof()) are already provided unconditionally via
trace/beauty/beauty.h.

[1]: https://sashiko.dev/#/patchset/20260907015140.363076-1-atomlin%40atomlin.com

-- 
Aaron Tomlin
