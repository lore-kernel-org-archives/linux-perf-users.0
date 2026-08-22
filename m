Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020087.outbound.protection.outlook.com [52.101.195.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E680538D407;
	Sat, 22 Aug 2026 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434588; cv=fail; b=XTuGi9OaBzSqJXgEeT7GOaNthVJaL0al7KtCynOB/HetRL69++91s0PxZRtmMYeT5phmdjdh79gqvC7axp0DaXxuooJqXPNH72zt9AuaKcDwDoMNsn5T4+PoW2HGDuscmmayb1MU6YdGsn1fBOhyxHZ6Sqzo5QHg0xGI6f57lNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434588; c=relaxed/simple;
	bh=lC50M0B/T0fBw59oI5w18H8A8cjguqxVZ29DLoJmGnY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PhJrkrZw5j8z75CMcHNJhEfYtlhj4KWfCTaQmr0YSCveHzFE6pOoE38f3zXXrf80IMppwRHkz4bv5CroMHthpd7wPHV849pC4nCtDKcnEyZvEAbHxtN2nI+Xyj6Zz6GyYum2CEC3MJUT1MACf1Ra9rZA2zXbK7gprjCHIsg1FkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwzcIAaWWqTbKgPRqGI7otE9sSQFC6DB5YM3yJZbDtf3NM0maHGpk1JsopUjhDTZuuPkHzL1GcAPH8E1/q87tSCGlBZlVLvwrwSdnGilMuk5LzwYzVnTVCdH2GvoXX+rqS6ctk9hXUu1E6oTqjxW4XpQmJIFC0MTwq3EQycRzV+OWT3sEPywSZ3FXtW83RNSdBWAZqjayQMLs3r+UuIgOdZYMIaoCm50KtUBO8x6vDKmUSGe+0saK4GaTEiM66Lk/575GNXwp/jhs9L/In1jQZgFGarAtFv3gtyOC9KFMzy8zbHVRd8LYfPwukJ4SK4k4B1R4dRgTJUrsYEt0200kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=cFfzplKEtNj7mazUSSYNIkry3LcOHlce8Pd4CtOjc5k=;
 b=nC08vEYl7HbRWT4h8LB1jn3YPh3CtYtzohgWhiOV7SHBcRXjDSsYQ8PGxvVANr9aYwZdhi01Ol9JDpky6t/Z5AdPMPIBLeyA5BXmSE2s9Lka7keS4nLIwJ4i3bWh320qIYSZy772vFWKHS3zbjjTJhcC/+98AaepWGppnm2LaYqM9LBAp6/e7nbWmMhAoQDo76HYWn83xBQOdY25NANXv6Rn9BmY2MBq1pqz6qhvr4IierUYiS9LEFKXvmSbHxh2oz9rGRknrmnIKo9Yzk/ECdkRIUmdhD8E6IoL7eOFwOSy1lgxf+PLe3VIdbjFJU2F8M9OAVuCZH85/gLfqWpYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB3193.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 21:36:00 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 21:35:59 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	howardchu95@gmail.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	chjohnst@mail.com,
	sean@ashe.io,
	steve@abita.co,
	rishil1999@outlook.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v5 0/4] perf trace: Symbolise kernel virtual addresses and function pointers
Date: Sat, 22 Aug 2026 17:35:54 -0400
Message-ID: <20260822213558.704018-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0431.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::22) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB3193:EE_
X-MS-Office365-Filtering-Correlation-Id: 761dc478-1eb1-4c5b-404c-08df00955b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sTeP8VoaNrviMjUbpBQGyWJpmp3mYRUDhmixTRvFLOkcQTAICel0yko2NeUWWbWXD3kTSS3WcSTGXOhE7FrPlJVC0icL4PuntnlrxlJk8kBM37Jjbp1O6BRhmiKi9o8doxAXD+HJpYCCGB/dJonqbrSZArjExRAHKyIosxhGNPmlJX2Cy+FxXnDA3U2hNIKGL0Yru2Xtk5a1qLQLo33NAeW3kwJaSkNmmRDDkI56OTJmUgLi7Pq9gVna5DaXdyUJ+yoOZwbh2kiL1odxJaeZB23KYX6zGRo90W4Nksg0NezbCspvHzdRd5g/oAudxnK+7DQyYHqOm6FUTSbGlnvcxVpGS3LVz4je2wO8o1NeQO53DcNjbULnuQoC23Mk83AY/zsK4EIs4WPLHcP3DA52FN/WZZ3Kp803M8jZOgR7q7JbZMPgwpGAGpQSV8W+A3Mvn+YY/O44AVFkLbCUDhxi6qLOiy7gaLqmCiAn0jLyL1S+X8Ffl3/jDLxZ90ebNoalsadZCzdctlnwSDap2BRltJyiGOPeAu5WitI4XsQ8vTKpw5CdvmpPgs+4Q8A0TTZGla7jNRUpEnnoHp62Y4q4xXgqRxzqq1hWU/9+oFbV2OMoDqgVW1+VVMFDI48tSYf4iZKtj3c94wSMAJkElX/JMyGKPZDU+gPC3oJj/8jg+DQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9F5+ykmd3NkO5+fACYliTCUFVkB+cp0xnXBWN5sARZgRWqK/4nKhaJordqIY?=
 =?us-ascii?Q?9RJkEmZ0CfX9N7ndO6yIKXmWKPWWqbkoh4ugPeLohCjw5cK39NElhJay5Dyj?=
 =?us-ascii?Q?WiOPTW9T1yfGvXlvLlt/pZeslqIhVgmFIgt9AdO3hBjuLHJUwSbgIgmJnkWm?=
 =?us-ascii?Q?8IE/8PJj2DtdlN4V91z583vj2+2ppxBSOKq4RW+lR5/edinjska4rTW1AC+q?=
 =?us-ascii?Q?No0Na//6FnIRRPtXYap9OFN0UzJ+/JuRkFbdOSWGILyTc1KfkDCzyuHxxY82?=
 =?us-ascii?Q?5PmFaHDO8DA7SLfz//Xhvz5/01Mozb62o3OnB2edy439ovfSCr8/AFFM1976?=
 =?us-ascii?Q?u7PXruxpTbQvxYLmaymJhTV+ouX376/1T6PK/oUGOA8zk1U1+NtTpL+VSIpl?=
 =?us-ascii?Q?sizhSAM+PUOQRdRxKHP9ERthXO6JPMMnAqoNoRAYy7XR8t4ZoXeOErQhtxdr?=
 =?us-ascii?Q?IAylRzUkoxBld6D4NGx/OJaVbjvH1qj/tEoN+EEErB669oZ9W2dr9LkdFowF?=
 =?us-ascii?Q?Tj56HZl74eDr4FUKZSSnowZMF2Cbq/UkBx3MuA1d0c9y+SgLJxFiWj+tuIf0?=
 =?us-ascii?Q?y8plfDmFaj9KfTtevHgQn9ZsoR3EUD6v/qtrjqJNXB/TpDcOuIpIyVs8yyAk?=
 =?us-ascii?Q?VpE+8fOXVlyUozvVBPcFg7wBJ68Lttuc5ztBBJ5eneqhGeARGiFdaToJf1aZ?=
 =?us-ascii?Q?TvbzQIY1GxeMt3zrKgoEtyctnVbAg3r6k3xADlw2w2bnTzSQypHp6z6uH7nP?=
 =?us-ascii?Q?oYYxpKxa8HcAqnN9knb2n0aLrP8efyLAKSngBgyUgQ+kD2FObPGPVG480nEg?=
 =?us-ascii?Q?IPhM7QucpMl1GH+A9nn0CJ3A4fNSgnpSuJ+AwLtt2xDvozP1Z0uDOf0GT5YW?=
 =?us-ascii?Q?y3MSrFc9mZZbXuTH11QzpGd6YGLf6tPu3sWMckLM2AdGghy1QtayqFFiFLxE?=
 =?us-ascii?Q?fizVslEl1fE308g728HwB169uFvCS448cgLqr65W7amu/2CGQqP9l1SPynR7?=
 =?us-ascii?Q?CYNY6Jxv++PKkfCEttEJmjcAYX2jl+3qruMd7VW7GxpZG4beywaQtG9uWM7m?=
 =?us-ascii?Q?3B4XK4dUhAEkEeoDlCFIb62ZI+A9SEo3HjuX92J1ROoiKluR26jozEvfMfR+?=
 =?us-ascii?Q?wKpudQixVGVShKduKPylalMpo94dqipS2uksJYmef2kUHuu78hkyN/Y+SI5y?=
 =?us-ascii?Q?QO2EcAGxDtUU7MLW3I8WB2nHUTDZET1q3jIfSNOd6Z8b3OVCLaDzS7Za6vsG?=
 =?us-ascii?Q?EElY6+hi9zeT2QaII3g7hEJsX/8YoWs8h+jTutGIhLqfIqlswFE3/cNbgILa?=
 =?us-ascii?Q?10ZV4eoq9AieBotkwjM6+VMuoaHkmlv2bsGCvZC+rO+IOpGAHPBdvlz3C7xI?=
 =?us-ascii?Q?6MXAC61BxYWd5XbO7mwo4r97FGcy2Z4LyhZTkHxbPB1Q6aKIFyyRJhEIjN00?=
 =?us-ascii?Q?jyWKb1lnijQZ04FL4HglrEa6oFEdagOi5ext40V+UH2fFOpc44GSRI56evBs?=
 =?us-ascii?Q?Y469xbECBHL/GEeCQoJBp4xOLuT9oqSljHhs/3SyYTmtCO0WQWDdlJLetBLS?=
 =?us-ascii?Q?4/POlhv8EOWJ0eZMT1c1ErWWh5ptFXONmB3PsZXITAcpRWvLA4bmdIr8LZ37?=
 =?us-ascii?Q?tR+48dNxR4R03/7qcccUtP7SyEPawzbmkE9o9iPOLEPS0iVA7vne0E5xCeuN?=
 =?us-ascii?Q?q3dREfTTVjQL3TJ7QHs06gCP3pIHIMwKYUjXi56f6U/hi9Ne?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761dc478-1eb1-4c5b-404c-08df00955b68
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 21:35:59.5604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQf3EU1H7YCQEB2GOT4k9/6/72oO1B9s1JfCCFor7Unarn/KJSVdcatGdYP98TIINfrfypoKvop9k9qmr0xpCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3193

When inspecting kernel execution flows using perf trace (e.g., when
monitoring workqueues, delayed work items, timer callbacks, etc.),
tracepoint payload arguments containing raw kernel virtual addresses are
currently rendered as hexadecimal values (e.g., 0xffffffff81234567).

This requires manual symbol lookups against /proc/kallsyms or vmlinux to
identify the underlying kernel function being executed.

This patch series enhances perf trace by introducing kernel virtual address
and function pointer symbolisation using perf's native symbol engine
(i.e., machine__find_kernel_symbol()).

    Before:
      workqueue:workqueue_execute_end(work: 0xffffffffab2f1420, function: 0xffffffffa8046b50)

    After:
      workqueue:workqueue_execute_end(work: 0xffff8ac2c420f270, function: wb_update_bandwidth_workfn)

Patch 1 introduces the syscall_arg__scnprintf_ksym() (SCA_KSYM) beautifier,
which resolves virtual addresses via machine__find_kernel_symbol(),
formatting them as symbol_name+offset (or "NULL", with a graceful
hexadecimal fallback upon lookup failure).

Patch 2 updates event format initialisation in
syscall_arg_fmt__init_array() to automatically assign SCA_KSYM to non-array
tracepoint fields typed as function pointers (such as typedefs ending in
"_func_t" or "_fn", or function prototypes matching "(*)"). It also
registers common function pointer, callback, and callsite field names
(e.g., "action", "call_site", "callback", "caller", "caller_ip",
"callsite", "cb", "fn", "func", "function", "handler", "location") in
syscall_arg_fmts__by_name[], guards SCA_KSYM to pointer fields and
pointer-sized non-array scalars (evaluated using the trace's long size via
tep_get_long_size() to support cross-architecture analysis), and removes
the legacy trace__field_is_ip() hex override in trace__fprintf_tp_fields().

Patch 3 extends BTF pretty-printing in trace__btf_scnprintf() with
btf_is_func_ptr() to automatically traverse BTF type hierarchies (including
nested typedefs and qualifiers) and route kernel function pointer arguments
to SCA_KSYM when BTF metadata is available, with negative caching to
prevent redundant BTF scans.

Patch 4 adds an automated regression test script, trace_ksym_beautifier.sh,
under tools/perf/tests/shell/ to verify symbolisation across both default
kallsyms and BTF routing paths.

Changes since v4:

 - Added a non-array guard (!(field->flags & TEP_FIELD_IS_ARRAY)) to the
   type-signature heuristic in syscall_arg_fmt__init_array(), preventing
   array fields matching "(*)", "_func_t", or "_fn" from erroneously
   receiving SCA_KSYM

 - Replaced host sizeof(void *) check with tep_get_long_size() to support
   cross-architecture analysis of 32-bit trace data on 64-bit hosts

 - Added deterministic workloads to trace_ksym_beautifier.sh to prevent
   indefinite hangs on quiescent systems

 - Replaced csd:csd_function_entry in test_ksym_btf() with
   timer:hrtimer_start to ensure test reliability on both SMP and
   uniprocessor (CONFIG_SMP=n) systems

 - Link to v4: https://lore.kernel.org/lkml/20260821204930.679027-1-atomlin@atomlin.com/

Changes since v3:

 - Added "caller_ip" to syscall_arg_fmts__by_name[] in alphabetical order
   to symbolise instruction pointer fields

 - Guarded SCA_KSYM auto-assignment in syscall_arg_fmt__init_array() to
   only match actual pointer fields or pointer-sized non-array scalars,
   allowing unmatched fields to fall through to subsequent type checks

 - Fixed btf_struct_scnprintf() to only dump struct data for augmented
   input parameters, preventing un-augmented output pointers from dumping
   empty "{}" instead of falling back to hexadecimal pointer addresses.
   Also ensured btf_dump is properly freed on error exits

 - Updated test_ksym_btf() to trace csd:csd_function_entry with --force-btf
   instead of call_site, directly verifying function pointer symbolisation

 - Link to v3: https://lore.kernel.org/lkml/20260820211100.649142-1-atomlin@atomlin.com/

Changes since v2:

 - Populated syscall_arg_fmts__by_name[] with common function pointer,
   callback, handler, and callsite field names ("action", "call_site",
   "callback", "caller", "callsite", "cb", "fn", "func", "function",
   "handler", "location")

 - Checked syscall_arg_fmt__find_by_name() prior to generic pointer
   fallbacks in syscall_arg_fmt__init_array(), and dropped the inline
   64-bit size check to ensure 32-bit and cross-platform compatibility

 - Removed legacy trace__field_is_ip() in trace__fprintf_tp_fields() to
   allow "call_site" and "caller_ip" to be beautified with SCA_KSYM rather
   than being forced to raw hexadecimal

 - Simplified btf_is_func_ptr() to remove the internal pointer requirement,
   correctly identifying bare prototype typedefs as function pointers

 - Prevented pointer enums (e.g., "enum foo *") from being misclassified
   and formatted as scalar enum values in
   syscall_arg_fmt__cache_btf_type(), trace__btf_scnprintf(), and
   syscall_arg__strtoul_btf_type()

 - Added negative caching (btf_type_cached) to struct syscall_arg_fmt to
   avoid repeated BTF searches on every event for unresolvable or primitive
   types

 - Widened btf_enum_scnprintf() to accept unsigned long val, eliminating
   narrowing truncation of 64-bit values to 32-bit signed integers

 - Fixed trace_ksym_beautifier.sh:
    - Quoted "$0" to support directory paths containing spaces
    - Captured output in memory to eliminate temporary file leaks on early
      skip
    - Hardened regex validation to require valid C symbol identifiers and
      reject raw hexadecimal addresses
    - Used '%s' format specifiers in printf to prevent format string
      injection

 - Link to v2: https://lore.kernel.org/lkml/20260816205921.576365-1-atomlin@atomlin.com/

Changes since v1:

 - Fixed reference leak of struct map in syscall_arg__scnprintf_ksym() by
   calling map__put() prior to returning Removed unreachable and erroneous
   entries ("action", "callsite", "call_site", "fn", "function", "work")
   from syscall_arg_fmts__by_name[]

 - Restricted name-based SCA_KSYM auto-assignment in
   syscall_arg_fmt__init_array() to pointer or 64-bit address fields,
   preventing misclassification of non-pointer integer fields

 - Updated btf_is_func_ptr() to fully unwrap typedefs and type modifiers
   below pointer targets

 - Fixed BTF type name matching in syscall_arg_fmt__cache_btf_type() to
   handle leading modifiers and strip trailing pointer asterisks before
   lookup

 - Synchronised arg->val with val in trace__btf_scnprintf() and widened val
   to unsigned long, fixing erroneous "NULL" output

 - Added shell test script,
   tools/perf/tests/shell/trace_ksym_beautifier.sh, to verify kernel symbol
   beautification for both default kallsyms and BTF routing

 - Link to v1: https://lore.kernel.org/lkml/20260815233651.527936-1-atomlin@atomlin.com/

Aaron Tomlin (4):
  perf trace: Introduce kernel symbol beautifier for virtual addresses
  perf trace: Auto-assign kernel symbol beautifier to function pointer
    fields
  perf trace: Enhance BTF type formatting to symbolise kernel function
    pointers
  perf tests: Add shell test for kernel symbol beautifier

 tools/perf/builtin-trace.c                    | 222 +++++++++++++-----
 .../perf/tests/shell/trace_ksym_beautifier.sh |  43 ++++
 tools/perf/trace/beauty/beauty.h              |   3 +
 3 files changed, 207 insertions(+), 61 deletions(-)
 create mode 100755 tools/perf/tests/shell/trace_ksym_beautifier.sh

-- 
2.55.0

