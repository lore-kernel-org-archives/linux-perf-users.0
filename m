Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020122.outbound.protection.outlook.com [52.101.195.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5737475B;
	Thu, 20 Aug 2026 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260270; cv=fail; b=nInN2I5OuzbC1pWblSuZTDnzZnC8+pO3bahzjYjQIJM4v2a1kJhCkc6aDpGclh52YtO1dtnL0bmadBWS2xeeeZY/yUFwLVGL0U7uVOh8siFEJxbs9zNBsBuB9ZolyHusO+wnQLr5OwAtDKSHTIXbNsgtrxbd3TK17P8zI5BKOKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260270; c=relaxed/simple;
	bh=fvO48x0G2b4ZOfb/A1Xvbyq8s2wXwa8CrCiLPNO3m3A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NfoZilm5T/vY6FV649Eb4UOJ5jMch0SRuMEbGq0ZJGDbecWV5qtBOPDzO34xbo41k3k1FOtZAomhkrv8fIzssLWS1+ZNifHJg04AMvSQv03iLA9JPSJsWkPARVPFsmaViRf7XKjOtb7tvV0kKMH9InXW1VXrlZDXG+Cwc7vFxzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7MXb0kdomZXJ7kkBoP9YBrHTRtRwg2JqpwMB0F99KhC9u/099iQhOC76pn/+GS50RLYUZGg8859DjRpvCAalZMRa1O554snFfGTEaxtneblQAA8T9xOhaIRxwvtGWVamhv8c/mFj5afskSGsFllJQd5sRqfbNNCy9MQD1DTqGTDjkcHU155yOtWJxbnVZyuTJPROXPLETkWklxV0dlIz9gqb2r9Ra7bAf9JfzSVpdxA/k0x6uil3jzaL7G40MuvAxTxXIF8YlSDzKxedYHlxxMJZZWaJ28Lt7lDSADhACJtxU74pJEK5wX9H26nKETigVSRgOftda0TYuotmkSCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=viRq3ARgGkOhOvsqMo5yYyyAcHDofvhH10ODyQtlj4g=;
 b=kxRW+ItrIrUN5D5a72gmVrDDlmt0fkv7LIACoUKKqJGNojo2GlUCctCT0ryntl7xRlPeJBMyKqxtXpiTZa/eT9ZJTMzd+LKpY3bz/BwHZ42oQyxJ4ckPVf0RFTA8d4IOax1cnlJ5u9w/u/mzMvCebxMa3TK6dyjWYR8l1JJOHTD4uUR/7ja0ibyzFpk8cu6f2aLjksXK8MqBZKaKFnqns4RraXr21rlWSWA3fpOUjpHyCh1TLpUjygUudl9kKcdU58UkLPhL+XYS6/7reOVeKyBk/glUHTKCUHdOuQNHC6sJAF6w+jY4WM8+RCbOC7HAADBmzwOkokfLN/ViXWtARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB9004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 21:11:04 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 21:11:03 +0000
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
Subject: [PATCH perf-tools-next v3 0/4] perf trace: Symbolise kernel virtual addresses and function pointers
Date: Thu, 20 Aug 2026 17:10:56 -0400
Message-ID: <20260820211100.649142-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0490.namprd03.prod.outlook.com
 (2603:10b6:408:130::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0f62a3-49fb-4bb1-d477-08defeff8afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|10067099003|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	13Vd1uflJbY8kYn1x1tV9mEoh8xTTiOzqJWJA2Nuut+lsL5uRt7fuz0i1REVJx9C05HG5/VDyFQkio13zp0S59HhyCNYnU4nhz2gh1EhjGyTvJjd50eTIYLYe9pPee/Ls5GXp3vVKo+1wqvJMPFoJd4stDb9NuimARx2ZoWCNhLp0T9z88r1VpcKiqRzU6MSB/5Lt5s/5inzOlb7r0+LU0Z/8z/IEw23Lqdv9PWjLav4XoFCXLwqLMBPIjQG2g1zCkl2WYgyKX39ov90OpajLkmT7T4Imeo/DQY1cyYjoBWxmwux1CweSBojLMvsqkiTxl4sgtG/UrE0TrsMxmwJZeJT31gFityDhpu4fu81CyJKVjxXOgUVkkgkcZGIYoySpdJxQrvXRaysNqSIuPlXWAC5vNt2Y2qyL/UbzFc5tPOHuTiS24enc1ffRkG5YazpLttLahpQIdqv/LZPsvK+ntl+B3Bwn2hYPT/eVDxC8gh1WkoRl8c+W/9WtYDsQ5x5q498jAKrwGE0A8NAqaUfpof+YjkKj2CMBpwyjouUVadQyddVSSXRXZacMGajQI2GajF4g2syVYhRv7aFRP8qQww6VT4JssA728MB/UsnlFqMT8KH6iCXxuowZZw+m410QGE86W7WPVf9V5Z6gQGdzN3SuCuH4hysTklCpTqbrco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KBfktMg/Vy3t0sBCv0ux13ubKNqgDTfAlgHz5aDcbRSVL4DWE+8Dvgt9ktV8?=
 =?us-ascii?Q?3BCwg+YChnNhzOUEG7PRNOgrJHRGtngEEV/9d/d8jxWXs+2PFsOXG3iO25Qq?=
 =?us-ascii?Q?IJjeUq5CU/inYritsCGO3lcS8qcnOpM1pkle3S9KNWAqTmD3TJv56XI564v+?=
 =?us-ascii?Q?g2Dbza7pCj0VjA848fpeQtCOMHueivWCpA9GsTs7CsnTOGqUwGCOR7pg76/I?=
 =?us-ascii?Q?3MhDVe/OZsAbxAfjQQQ/+CVv4atQDBisihrrv7B/wFu4e3+Xc8qCZj7++JmO?=
 =?us-ascii?Q?xqqVydqdEcBIFcIjh5S+rthYoYzYrHh9jqeSUj+FRjbF9cX8re/A5D0pGMjA?=
 =?us-ascii?Q?oos+dd74o24uw2QwGlFfUaZJ9V2R3V7wSCmDnOJB4mHt6BGBJM2KX7NcP1EE?=
 =?us-ascii?Q?zFQajsoyk5WCj0Hd/Kd7+nDhv1ypKVHiMP2B43f9jtwnNg0NeW4kvVpH01ug?=
 =?us-ascii?Q?ftKESrGCieNmK4n1/NdPWE1DxzytnPyugfUnHL6Wd4LnRBq2Z2H/u08alL8i?=
 =?us-ascii?Q?q15D5IVMo9zLjDdD1cLlg/CEKAYURfveTzwBjHpfGy+smomuVZ8l65nxeebU?=
 =?us-ascii?Q?VeOpRa9100d9/Y3GH8ZMGZtORDL4/+w89ch5uqsx60WIqXj5vKBqVpKHyUVA?=
 =?us-ascii?Q?my7yTwhT+ON9AGA3owRu9FGq9/BvMm/qweC1h+eBWBWZgNGOMH+cHKynRCbf?=
 =?us-ascii?Q?YNZDPEoU3SdTv/5Hk4l4DjJyJ4R23qcFp1vlKSYXIZqxWSUhJ80Hi5B3rMAd?=
 =?us-ascii?Q?uCGYk47LxXohQylxdwk7sgnbApSwdGG9fwjxnWWtfCjKyAk5yW5sjnwCNxGT?=
 =?us-ascii?Q?KLuExDZ9b2j/buNv9BS4mRCgIeAi+GV58XIuZ1ZuMFuyvBMCic8+zcb9kiNa?=
 =?us-ascii?Q?hzgQB07qLy8734kkDyWV7kqvmRvZOPg/4YEjH5MvfY9pE8uSjlMVxNpffl9i?=
 =?us-ascii?Q?avpkMSww1lCn4EUo5N3c4DvTFKps1kNtZZvWBC16vgcN6BtDHABcvcK/v1MR?=
 =?us-ascii?Q?hzFSS3sIUXPBcD1/9+Qqhp7hBK2wQk5FGjsDVTwYfl/8z2NdNQJhlTU1iHEa?=
 =?us-ascii?Q?I/2lFordnJP0EOCljSMfy9Sg2+BRR40pPLR5xqLcY4ICNlA1q5qofs7mFRNg?=
 =?us-ascii?Q?74vdff2poPjIl6PoB/4+I1vk3Dh31AjjMSbbbB3rQe+FkHZot9/3g1Ex3WoR?=
 =?us-ascii?Q?blU28srNvboI6l7G2t8XDf6LphBjYE9aYuJWITXvqCDa6T5wdRwNN95CIkhy?=
 =?us-ascii?Q?nnfOLMVMJgpUTpkwPgHPjZEGMpPRUsU+rypB+Is4PDtGQz6j9ecD+EV4WPzY?=
 =?us-ascii?Q?cP/72CSYXS0tPJ4C7zJotwKjztd2Wd0ALlhPZzpbjzzLldFmE0pqfl/gejSr?=
 =?us-ascii?Q?baTUUpTnQpel36D7UR/djXHJs8RmeAmysJt94YRUZSoXk/qpk4hcVojkTQvh?=
 =?us-ascii?Q?yJJvzafapu3YLK3SQE7ERcfYdISZ9dQPV16e/GrQ3Yj7h29b7pYERrkcuVFF?=
 =?us-ascii?Q?p+r2VaUYlQZ8sjlxi4ZMRRinD2H/tp6kc9mgYDp+AJRJjrQYMs4GhOjVMxwD?=
 =?us-ascii?Q?z2IiB8d6dkRP09BCeDqBxpe/7MoV/0Ez0XW5rfaWvbLcHRZg+wfDHC8J3DyS?=
 =?us-ascii?Q?yRF4koWPqxorDfrFejFRQcDucpm03QRnuOY9FKwbO5voA7PKKIChBFALOfpT?=
 =?us-ascii?Q?RMXac1kmfSgEa7VQ8lc2eXhSrpkq/8x1VNobnWq/Jg7sMacKImEDRBuj8jtr?=
 =?us-ascii?Q?ZIa45y8jlA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0f62a3-49fb-4bb1-d477-08defeff8afb
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 21:11:03.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXoYySiCXpm5R3uTssE8/22Jx3NXtYTC7DN7oHyj45PXLkdPiEuXeNCMTX4xRENz/Evu0KSIiMFGW1c+i3XUCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB9004

When inspecting kernel execution flows using perf trace (e.g., when
monitoring workqueues, delayed work items, timer callbacks, etc.),
tracepoint payload arguments containing raw kernel virtual addresses are
currently rendered as hexadecimal values (e.g., 0xffffffff81234567).

This requires manual symbol lookups against /proc/kallsyms or vmlinux to
identify the underlying kernel function being executed.

This patch series enhances perf trace by introducing kernel virtual address
and function pointer symbolisation using perf's native symbol engine (i.e.,
machine__find_kernel_symbol()).

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
(e.g., "func", "function", "callback", "action", "handler", "caller",
"location", "call_site") in syscall_arg_fmts__by_name[], and removes the
legacy trace__field_is_ip() hex override in trace__fprintf_tp_fields().

Patch 3 extends BTF pretty-printing in trace__btf_scnprintf() with
btf_is_func_ptr() to automatically traverse BTF type hierarchies (including
nested typedefs and qualifiers) and route kernel function pointer arguments
to SCA_KSYM when BTF metadata is available, with negative caching to
prevent redundant BTF scans.

Patch 4 adds an automated regression test script, trace_ksym_beautifier.sh,
under tools/perf/tests/shell/ to verify symbolisation across both default
kallsyms and BTF routing paths.

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

 tools/perf/builtin-trace.c                    | 187 ++++++++++++------
 tools/perf/tests/shell/trace_btf_general.sh   |   2 +-
 .../perf/tests/shell/trace_ksym_beautifier.sh |  43 ++++
 tools/perf/trace/beauty/beauty.h              |   3 +
 4 files changed, 178 insertions(+), 57 deletions(-)
 create mode 100755 tools/perf/tests/shell/trace_ksym_beautifier.sh

-- 
2.55.0

