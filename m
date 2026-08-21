Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022077.outbound.protection.outlook.com [52.101.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FCD35B63C;
	Fri, 21 Aug 2026 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345380; cv=fail; b=pJxTskCZAKOpaIwqMMaFpDhhfEbUpDfOhrorMdQOpqDt4kOrmFlfXzc//QEE/QBnwwCMAsYsGysSEUEPfSpUnU0BWAhmYrgXbamZhPr3SUxtI+fpeNfQUqdqIAYTkKedHkjrDfDfRu5BlSO4Ngit5zm11zBVhgVXVuzj9H9orF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345380; c=relaxed/simple;
	bh=JZt+lX4JXLkF7evOt6MiOdH/SV9gZ4sxHt0pR6/dpW4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UneauPqtL7wq1w4rkyODQMwFHDCiNv0TeFgvEnUwhN73jbgnrwWLgQ/J2C43z5aUBcWaiBYwPJa2zrNc2aL0kz0zUA/PaIV/X0+GdLDvwNFITki4Xqd5J/o2o2CwjmHpHQBhACqiKRvk5P07R0nJceV8bJ6aI2dvzT+jMFT0T+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpIXmUMNf1wzJhnsnXS4O6wHwv5wjicdQu+R5sGayJCI6YJtl+nIRQ9c0SDY5QdcTtfl3gD5RxMXCOpKLJf0MkeO9t65zXht2/VE7jHvu87RaOVF0gw/dnE1gCYConGn0OXxQeZJwUXLxXD1EixXBqQqF0GkIkP3GgcnxdXvnMm3CKpbHcJgVQfhyBU7Lbevqr6s78IbJQ4yefDQfU1Hca1QBUChyNdFs5h56O1XYWAMzcYknwTn298AS9m1o6uPASgMiqQubYrTJb/Kc19fHVNxk1zUsNfrEd9F+14LfrZDq1qiYneLmzQNkO8HSGcpQ2D6kEsajebEAAehFALqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=jdEIIGuUXAFCeDjKfI3m9H2qcmlcz5+yybgyZxVMoJY=;
 b=ZKhlp6NCqZb2M3vJjY0N+XtaxjyEzMPn3kRhUfjiCAEFa3AZ19Z+xt+K6XuXUk6E+tQ0UUIX7EKWWlMOkY4PdrfSJTTLRDQjaucHrWHKufmo8+45PwDHKWoydXNfM1lJIj8UtIr6jsVYntjtY311hl/iP0RV3inVf/qII0p7Kv2/zZy1froFPsNPqymkWP1UVXtiQ15WMyYLO1jMPE9I8AMdhZ/z0FmGWI9hdhKg8P4G00H80BbDmAAdvgw7t6ZCzVbbX3Ik8B4KryASuJKKlTD3gXqjr9sJhim++Sz/1zhmTPPb7GExOLOx/lRoHw0ZrwYqiumihlbW08ITmMVTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB6104.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:25b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 20:49:34 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 20:49:34 +0000
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
Subject: [PATCH perf-tools-next v4 0/4] perf trace: Symbolise kernel virtual addresses and function pointers
Date: Fri, 21 Aug 2026 16:49:26 -0400
Message-ID: <20260821204930.679027-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:408:fb::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: e25d81bc-8cc9-49fb-5903-08deffc5b4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|10067099003|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mrkpYmTC72CXLHrG/cyBgr7Y1k/vmfsrhVqzOro3PPWwevVJ0k3tIltBQhDN5uSrXxq2Ytzl42BiaPkUVrV/gX+5itwqnswNVJkq6IcjvF/7Hk8vDrXAwUEAikbQ7OVyCIK/uH5BmETr4QtkvCrhPlWJ5n8Fe9Z4bjmNWEfdjXAqWjcRXo6SG777yVOVhDgKp40z2V4gZpxFe4fBblhCkS6B4YRVQZ8uU3npuTZ3WMeATdwhAmuaje/A5s1cvQ3F+OSH2d4c0Ggoy9NLoyXGmPTX3RJP9YwMwxcHLRwMUWlWwZ8oAVkVIbW9Wzz7nawj9LaA7Cmi8XyWFgZsi6bYdbR5QY9kwYU2uJ7aI+d9MpZ8tB6Wl2z6EY4KF+22+m7KwmqfQn+UW4Y3Ki0wj5hhGok3PzuCbNtr1IyFFOdY0U/SAWpoOQwKthf8B+5/iNYottVUOhPk5S1MnDWVugPwulyT6qAvCWJztzfUpItMtpElo7EeA6PQZrdNlaMBehZeNALfx49ZmH8/nGDw0D5UMMEi7DYo5gW8IUb0ivoesweljbqCG5BMmR/k5LQEJ1UjdzfstarjRBqw7MTc/n2H8H4yf+iEsJiBNsMFpAjLhpD4tTAThEtuxRa+HNzfDUEg9v8ZPxFSD7ghadZMFupPfB4K1GUSyflDCqiJPnSRuWo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YuPhKc7RN5A7bflij9kSpG2dUyA9X/36f1wpoDnB5ZYVXFEY89u+u32BamUf?=
 =?us-ascii?Q?w6b3wSW8AWG7otDKpQhvScMd/EEbjU6AkIbI0sqwAmi7iOOwDrwtnLSUcRaU?=
 =?us-ascii?Q?On8YA/NALd0/hg8tnZ4oYx9jX5SWGWttEhbMduuGND5xB2G6wrauWueLZ50I?=
 =?us-ascii?Q?oN9tU8Yhnv0GC+Hygl2lG5+lzh0cErqPAIQGWXqajww4h8kqL7MGgUunI5sa?=
 =?us-ascii?Q?re3NOIAN6zJHZ/tqXJ3vvoQGLa6rt3Ped4DftVeqnrJxgUSWGg8EGwuBhfn4?=
 =?us-ascii?Q?YkFYgDDRYYh/IxIvjR42K0rmVhjbuhvYqMHh1rvAcEDcqLiLewYEHhEZE1ZL?=
 =?us-ascii?Q?vl61mHdm60S9nssP26Ct8W+q8r7zUH5ehoFDp0iIDbYPfhkiUtGFkpdAjfhR?=
 =?us-ascii?Q?C3J+pZ7znycQnvuoLUmmvFu5o+gdboQ5WFcPdK1AV9Qn7Hh0AHG5LO2WH7IV?=
 =?us-ascii?Q?aAT0wYHAOR1hhaMx1U0hU+BwJ2hj6sShxzA4aMq1PeaYDYqKehS0FsVdaUu5?=
 =?us-ascii?Q?0Ed100BYJpSiM2EPQ22TUEn435SZuyHYxP9NTTnD3J6fqtZGI1x2s4FF8C9p?=
 =?us-ascii?Q?cMmdy1KFnJojINeZ0W493HV2tK2SUXOcHWpoAnndR3nfyeOtp6WXPmffK4v/?=
 =?us-ascii?Q?zDXncW4DcJituLOnVmHol+a9fix/uq61EoDGnS8DshWQ4erpR7ge4Puy9t0W?=
 =?us-ascii?Q?LFiXu0Ivct0wJrXOZo/ASQ9IiYkQLmqz51Ku02dgguU8m18ppalU66/f4KwC?=
 =?us-ascii?Q?swnDIEpbVtZnBrusiqqgRbQFHNnDK3rEW9G5GpVSejSx88uLMPUUGFlkPHSq?=
 =?us-ascii?Q?Xe5JwFjk4OLGxIqS1vaviV1WxSuHkf9Pf64gxD4nIF1d9X3d9YFyZpD1Xj1d?=
 =?us-ascii?Q?Mx1vFXcc4DdGWxLK3H6QZRUV5t4tvsLuc2ESJuAsOPmN5CTsMP1wUVoM5nHr?=
 =?us-ascii?Q?SpMD/8IkYEM85trpfp+gZBal8uL2Fq2Tr1v9TOTkXD3BHtKwaTuAELK3zAsB?=
 =?us-ascii?Q?5QaLi8txAP7nMU3svTJaCWjZSw44+SS+uf6XSlCSs+hZlAlizBf7SbkrgV6L?=
 =?us-ascii?Q?SiRrdt+/Zk1bhBzmZgVc9TcCRQF5g2elOI16geB3QVJePMQaLKHLVGvGQMbs?=
 =?us-ascii?Q?7um28kYOjIvPYyun+Gt5p9AM/aGpzHe6LJXqm4hiuWUgUV92OKF8B7kQOBhX?=
 =?us-ascii?Q?xa7j9IUClBO2bHzKee9UwLapJAYc/jyI1YfVlELrwA9Go5/TMJUWeuh91831?=
 =?us-ascii?Q?PAZa4uGgYfd9hrPHW3DTVmnsOT8/XrU0fBtnWesd8vm0CgsCNY9XRHClOpOi?=
 =?us-ascii?Q?LomxV5F03eqENgBEd3lR/5roLG/msKSxlYqXfEWvlOTCbE/cswPYG5b89dlu?=
 =?us-ascii?Q?+L7QRODVaX4GFZg3u2qGHX+hW8Y9l/pxfwDE4nr1Q63Z1SGVmiUo6ZOiAili?=
 =?us-ascii?Q?jv5vGeInXUZrU4e+zFnRmEkCtRLfegEbvpQMPUHTJinAuTIQelXShaA6Uq9O?=
 =?us-ascii?Q?+FBBcRKPTZ/UxgwZCPgZld0A9KpG5gsAfg6BtuX+Zdiv535iXOL7H6NEVXtu?=
 =?us-ascii?Q?nDqQyxMa8+y54BOg+tbw0fmNdpQJ1CPK4yL9KbKJMsA8CIMx6Ik4tHweL4kV?=
 =?us-ascii?Q?aJSpNX8Cgiw8T4fr9JOZHvW4qNwTrKbuJN5cixkpHvZzSBh56BGUSRvXI6P+?=
 =?us-ascii?Q?JUPifnItOl/xPAIiJ1eIDAZNNIvYG7sPFdnm27dBaOx1joD6hEwDe0bZbpgL?=
 =?us-ascii?Q?oKS5QBpNJg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25d81bc-8cc9-49fb-5903-08deffc5b4e1
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 20:49:34.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gKRAyzKyTBbDLS0seGIcZa8X1WxR7+wQ9i7qxioBL8laOoNSvmmIyfzV43QQzS0TmobJkoxlGIdG316l40VKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB6104

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
syscall_arg_fmt__init_array() to automatically assign SCA_KSYM to
tracepoint fields typed as function pointers (such as typedefs ending in
"_func_t" or "_fn", or function prototypes matching "(*)"). It also
registers common function pointer, callback, and callsite field names
(e.g., "action", "call_site", "callback", "caller", "caller_ip",
"callsite", "cb", "fn", "func", "function", "handler", "location") in
syscall_arg_fmts__by_name[], guards SCA_KSYM to pointer fields and
pointer-sized non-array scalars, and removes the legacy
trace__field_is_ip() hex override in trace__fprintf_tp_fields().

Patch 3 extends BTF pretty-printing in trace__btf_scnprintf() with
btf_is_func_ptr() to automatically traverse BTF type hierarchies (including
nested typedefs and qualifiers) and route kernel function pointer arguments
to SCA_KSYM when BTF metadata is available, with negative caching to
prevent redundant BTF scans.

Patch 4 adds an automated regression test script, trace_ksym_beautifier.sh,
under tools/perf/tests/shell/ to verify symbolisation across both default
kallsyms and BTF routing paths.

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

 tools/perf/builtin-trace.c                    | 217 +++++++++++++-----
 .../perf/tests/shell/trace_ksym_beautifier.sh |  43 ++++
 tools/perf/trace/beauty/beauty.h              |   3 +
 3 files changed, 202 insertions(+), 61 deletions(-)
 create mode 100755 tools/perf/tests/shell/trace_ksym_beautifier.sh

-- 
2.55.0

