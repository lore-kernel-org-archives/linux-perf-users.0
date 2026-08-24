Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020115.outbound.protection.outlook.com [52.101.195.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D4311977;
	Mon, 24 Aug 2026 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578294; cv=fail; b=IPsSR6Z2J5f5oOhtyISKus6twTsijm4TV3FzTrOMw08ZS+o3MXXNfEA6u9tsUlhuYqskEWerX0dPUh98KPEBar4ZdJHA5jqrZiTKz5dUiGjlgx7uZ1ah844X244eD4OQTHPPb+6WI/N0AjvXY2FtqB7N8bWuDmfSC4O+cQkRoj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578294; c=relaxed/simple;
	bh=JN/W1z7FRAJjtZ7X+x/q5clLAsNcV6KO7XKsQBrV0fc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nyi70tOD6dy3NNbljZjOOOTdQAukhK6TEehjXJgJcH68MgVoz9/w4kAhL7WCcbyjqwL/Jzc4AqHKXGDcoQMSo7v9y41YKsC0I0TUaxt6FQ4IZo3nJwMQJnxbuFU2tR5xugt27NQiW0vzBaEv/WnPT/6E5CE0DH45zOZVzOkQcmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWrjohsK3VbTf6aqlNghvJluNPK930l47ciXfiz8vCPylgirWFk0sJ1a5PJYrmE7qOkKvegWLvJGlaKK3NWSiUCPu5Om407mUPTqpq+DmFH8oIHrghqn/vUdOlbBL1WbHcmz8hgiqTeN8mZ92jebTcLnagNevvlLPRxhm8WTJYg4MNZGoTk/3hXK3Rg+XfWqVTEYx+twKqfNPU3b8GGCEYd/d3cIi+yDxjBGNeqs/jhNdyn8WOT2TG+QPzuAQfUrCEITvv213gmyd6GEqPqkBEfhGuYIUdaZj/liOjLrKZjvzwzHUOFX5u+iXsU9uQ0ytiaxsACwJwi9vQ/GlrDK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=BIeUNn5jyJDqXaIemwOPwS3eGibpoxaY+3/EtZaummc=;
 b=H7lX7URfQZmlGvcZEjb0P2+wknLPFbLAQ3bKJlZBcCG6xS77QdFYRNqPRrn6sUPcXNGUUFlUuVsWq90V1XuCJf/tGxKN19PxwwDNBlwJwrbJHbxv8dMdq2wB7cypefMWOrEQfnAKezxZeP8kb1kCfUxoNFouI8kdeUxiKfkftCca9Idk2HRmcZLjXEpqAS3Yic9BBzbILsCZZpjOzWEF8V3wGKjFBENnbZoY3rj58CtHOwA4XUpjbOcViY7qX13KxrvJewIk2GCIuH09OXB9Rcm7LRFPZ2X+BEojHjAlOtKoRlrHUiQWUlAbJJu0Fmot1gbB2swRFhnTPMx8DPDvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8950.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:271::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:31:24 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:31:24 +0000
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
Subject: [PATCH perf-tools-next v6 0/5] perf trace: Symbolise kernel virtual addresses and function pointers
Date: Mon, 24 Aug 2026 09:31:17 -0400
Message-ID: <20260824133122.751733-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0108.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::23) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9b1cdd-a900-47e1-d4c8-08df01e3fe0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	kXEA8IOCNdi0BO6X/HmoHrHpxicljW4RcT16RRMqSmgWapEhQNkldZ8fGhrJgUVslixDtra464LB1Z5/+hwTN7ujlSu9leWphtYWjBtTOinN2WimzIWT9QCV/GMmkcHo8jDCHQavC1Xn/TwdxiBPcwUGVCt1NlIM3kXGVecbKyvLVcISByzmxBfI61EkpyFXKj7QGCATc70euWt7kSQeMjr1zwRd8gJhEIuInjscpQbBkIizZigKISVqBQ1WD7u5yKTmIInxohGiB8/N7A0kSOFkHQwMOI0kvh41t4piay3mt6cwjE6yuW7Dzn3hGJpLJ4Rql180CoA3r74QX+BNXK2w8VD9n+DoEN2KHyrWPNCqY3KhzUvyrxNNVqyQ/QBPAw5AjvPdagUe0HliMCeXDFRKQlr/fnkBHR0G5NBaVyT6hYFVYOiPQrzkPYVU8W+e6PDfRk3Ia8VufRfBdbTSGVKVJHCL8gxh3aiLJ5kwS5sijX7hGFen87qar3f1r7uIdpmoOd1+X+NuwGWF3WalJD/Uagcm1imXbYTLvBXgTpNGJhtVlQSZS1J9kjDXph7hVfDZgzbO1CnMO+iD0qqz6fpBXNd3cb3pInBdsR2W3Z/6Cjh+byMyf/GHNhOIJFnVyBfhSZJTHClzyGInl5bQphD5MAKvo1Pi8N10fwDMmJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jZNO6ZoRaq1/1AdXeJz6HX9w9vKCRQ5SuU7BH5WxHle0A4Ekh6wItrYUJ7yD?=
 =?us-ascii?Q?V6GB5uhZr3rdR9zzEV83+WCG1+TxIrVZNQPsmaZF+J/uedWCHagRZrK2GIEr?=
 =?us-ascii?Q?giKDQNHLWEz/eJWhmA2krYqtejxoCXujVBiYSVV/MhcgXbIJAhNnrQAPbNEq?=
 =?us-ascii?Q?H/vosDzCZVsqs2LNCtrY6Ssdd3Op7PS9cYwGaATr9Gdm+sSPcoN62N/KPvyk?=
 =?us-ascii?Q?nnnPYMolsIc+VnPeUesBodoQUGa0VP/xJ1DrX7FTmI6sdNZ60AsMGeeI6SG4?=
 =?us-ascii?Q?EeRWZQY4mr96c8gDEd8/7Ukm06K1/LDWa1SiEpAjm+tBnAJpCjqzStTQyDPG?=
 =?us-ascii?Q?64f39RpnYw+roswG9wtumXQcJnLJ2y440MSRmcqkQwFGsC+LzqonTGm4+Fqp?=
 =?us-ascii?Q?wUNo3LWAAOpWshsx2a9dlt9ssOcCyVB04FLoqbUKaIDfhZvRkEf9p4mbRWZS?=
 =?us-ascii?Q?c04HD9GhjyYbevHCyt0Ba2adY31awjnIOininKA0hFv1SlKHCF95A5JZGaPY?=
 =?us-ascii?Q?tG6YDxuTDH+bTULirBSiS3LUYnkVr8lYP2ojmATwhBgQMllaP7PsKP2ljN7c?=
 =?us-ascii?Q?nSgkpQowLnLgQqHCkDheZYJzq5hygFPFaIBEZKS4Xnuuq67yVjawXlpwI8Ka?=
 =?us-ascii?Q?wwsUSQcNCBeoS2avgd3TROZm0qSWTfQvwwI8I1/v9d4ZqR1LfxRUlP7IVAw2?=
 =?us-ascii?Q?OaU1kx/MAvu3YisbsSHw/HPazFvAfZUSUMhyFSEvKUZawCMhOMBkTB2fMWzq?=
 =?us-ascii?Q?YnZ7qJiwjckvhZ0usJDfyYbmyx5HNcmzi81OqT2cdnEHQkhSBKJB6KejdxLB?=
 =?us-ascii?Q?v5rVgEVGxlH9IVZnLrMZabQmBr/2HPf51qcIWzSIZnF8mRKO0C9hFqoL/nIX?=
 =?us-ascii?Q?LNm0j/cy/hrhekcnNPPCemxYcD54P0Ci2Ox2E0+ChLVGixjw4kKnAhtriZz2?=
 =?us-ascii?Q?jAXQPSgSkc82AQCdgvUO+FrPrur7IKbLjJ0ti/wuA2snoJmLLkdJ1dq3EN+V?=
 =?us-ascii?Q?conUKJIvjyT/XcB+xlqjLxqz/lPHM+dK0+SyZJPEa6fbC7jbLe3s9Z/Lozru?=
 =?us-ascii?Q?0Yp+CV4/3pKxbYqwU4I0CNP6QjHi2I7KiaIVweMkHNBKi0zGf2qqWF1ZM4yO?=
 =?us-ascii?Q?RgwiwOznh8o+EmLpsXXv8Dt/ZE6VGVKkkZvJR1cvptCwHU36/B8TG/bZFyC3?=
 =?us-ascii?Q?qooyh8sj+6V8mHEhGENbAJQg56tYwwt3InFbyKPFa6Uf0RWacQJmgC1sBchw?=
 =?us-ascii?Q?EwVB4Vd5fO/4OMIzT1Cda/F3u21sVnn55jGp+W171pU2/60Uh9lD1W9JREO5?=
 =?us-ascii?Q?SX8D7WhWq7kwEY6QXBuUlxNZEJ6hXRRft0PvVXFE4EDMsg1MfPmjMV2ue47s?=
 =?us-ascii?Q?rIPf6Jc9E13+tIYr63SKKBA2el2KGM72GuAfRw1fsrbY1jZGNp31rD/g2HVS?=
 =?us-ascii?Q?zMK62y2APJcaplcxihsmeq/mkJqQ/CeOnYctSuwRw/gFe+Asy9hCg5ma4fPf?=
 =?us-ascii?Q?9SwESph5d0I6mgs6WI6F0jYx3PeH11nofcgX54yNwu3fgvVfhBEyUEQKlZft?=
 =?us-ascii?Q?Owsx/EiplT3Gy23RM/eO6CcPwIM8xqLMAGrDhD7V+coTvd1r/PzYaWGIRyO8?=
 =?us-ascii?Q?b9dCZi7RTmYVLJ3ApyRELZxmBIU7LZEQjoHEDKhqwZLB+BLxSuSSAlFmnG9k?=
 =?us-ascii?Q?vahYF57tLKYhr1pl0/MIn9qdcnutdIn8sZFuGMUmiXfAdWxz?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9b1cdd-a900-47e1-d4c8-08df01e3fe0a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:31:24.2730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jud/8G8CdWR5MqEeTc2sOK1KDDBF+aBYT0oQ8aaTkI0sj0GDJV1Q+CmYQeEMm4UWqDHdIRth6xiOT+4aqpm57w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8950

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

Patch 1 fixes a pre-existing error handling issue in btf_struct_scnprintf()
where negative error return codes from btf_dump__dump_type_data() bypassed
the error check and erroneously advanced the augmented arguments buffer.

Patch 2 introduces the syscall_arg__scnprintf_ksym() (SCA_KSYM) beautifier,
which resolves virtual addresses via machine__find_kernel_symbol(),
formatting them as symbol_name+offset (or "NULL", with a graceful
hexadecimal fallback upon lookup failure).

Patch 3 updates event format initialisation in
syscall_arg_fmt__init_array() to automatically assign SCA_KSYM to non-array
tracepoint fields typed as function pointers (such as typedefs ending in
"_func_t" or "_fn", or function prototypes matching "(*)"). It also
registers common function pointer, callback, and callsite field names
(e.g., "action", "call_site", "callback", "caller", "caller_ip",
"callsite", "cb", "fn", "func", "function", "handler", "location") in
syscall_arg_fmts__by_name[]. To prevent misclassifying enums or 32-bit
integers on 32-bit architectures, helper guards (field_is_ptr_sized(),
field_is_enum(), and field_is_plain_int()) ensure SCA_KSYM is strictly
assigned to pointer-sized fields and 64-bit scalars while allowing enums to
fall through to BTF pretty-printing. It also removes the legacy
trace__field_is_ip() hex override in trace__fprintf_tp_fields().

Patch 4 extends BTF pretty-printing in trace__btf_scnprintf() with
btf_is_func_ptr() to automatically traverse BTF type hierarchies (including
nested typedefs and qualifiers) and route kernel function pointer arguments
to SCA_KSYM when BTF metadata is available. It strictly enforces a single
pointer indirection limit and validates type signatures against extra
pointer asterisks to prevent multi-level pointers from being
mis-symbolised.

Patch 5 adds an automated regression test script, trace_ksym_beautifier.sh,
to verify kernel symbol beautification across both virtual address fields
and function pointer fields.

Changes since v5:

 - Introduced patch to correct error-checking in btf_struct_scnprintf() to
   prevent erroneously advancing arg->augmented.args on negative error
   returns

 - Added helper functions field_is_enum(), field_is_plain_int(), and
   field_is_ptr_sized() in Patch 3 to guard SCA_KSYM assignment from
   colliding with 4-byte enum or integer fields on 32-bit architectures
   while supporting 64-bit scalar addresses (e.g., u64 caller_ip)

 - Updated btf_is_func_ptr() in Patch 4 to enforce a strict single-pointer
   limit (nr_ptrs == 1) with early termination on multi-level pointers,
   and added a type-string pointer check in trace__btf_scnprintf() to reject
   function pointer typedefs with extra pointer indirections

 - Removed test_ksym_btf() from trace_ksym_beautifier.sh in Patch 5,
   refocusing the test on verifying SCA_KSYM symbolisation across both
   virtual address and function pointer fields

 - Link to v5: https://lore.kernel.org/lkml/20260822213558.704018-1-atomlin@atomlin.com/

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

Aaron Tomlin (5):
  perf trace: Fix error checking in btf_struct_scnprintf()
  perf trace: Introduce kernel symbol beautifier for virtual addresses
  perf trace: Auto-assign kernel symbol beautifier to function pointer
    fields
  perf trace: Enhance BTF type formatting to symbolise kernel function
    pointers
  perf tests: Add shell test for kernel symbol beautifier

 tools/perf/builtin-trace.c                    | 250 +++++++++++++-----
 .../perf/tests/shell/trace_ksym_beautifier.sh |  38 +++
 tools/perf/trace/beauty/beauty.h              |   3 +
 3 files changed, 232 insertions(+), 59 deletions(-)
 create mode 100755 tools/perf/tests/shell/trace_ksym_beautifier.sh

-- 
2.55.0

