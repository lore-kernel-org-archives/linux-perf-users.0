Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021143.outbound.protection.outlook.com [52.101.100.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB883D3B3;
	Sun, 18 Oct 2026 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291082; cv=fail; b=lQcOMkBrcxJsYWh4WthNBQ3BR0dOANkmgSwRcK4SvEyL9YpJklm/28S0XybOgfBU+O8l2+UH8H6Geo+0ZG1cDeRQh0uhXIAIxenWLgJKlRuhSS0R3cLzEgaESCOfwpCTtdy2vXBkJyumP6HJVTrJbi1WgZkFLlOu+BlgNvUkBAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291082; c=relaxed/simple;
	bh=5FA9VmAYSXJqeathW3iCWeu/bYjxefajNGKbsxRYwIM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sKh1weMJiA5YgxzxHiaNI+rCeJHlnaVS26iccQ1xJwqQeC31E75bAB3tbMLNPZf5jE8TBX3BJqAnCuee6dD+8NxoNbWdpKHwqBNZciF5ZVi8VeoNkrBs7FHrKnIuJJSBpClWgoZ5z6iNTbLGEA1d2ExM+DhLL57Vwu+LpEBm3oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrllaFDGs4s2zSAYhZ3onqHb74nY92jm+rdShlO5VosZCdsaehhXhScJ7YW+ZZEDsmLkaQlx1cJfh8dgt2jz+wMw+Oo2h6/U13DGDyUpGIWWYohyPvTVFxONIqbNsVWW3ObLiL8y7A6sGOoUGh2ozfm2yR2bsC21YNn4u0qwsL5Xpst7dAtvqPwvXW10In/lhrHlEztpw37Zbvr7STWu+bXsRVYi4bVRQWmZQHQIxN2W38Ws5ebuz/vgQw7qbBIVBlpE6xn9R7n49sASjgHAeMeKIb0J/EHQRchxO3F5FGuo5UHrZuDKea7FG8iHQNsSZqddgoeh6LSKryGzF5sBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ZrHaT67nqyzcj9ixKICxrqvbeyUQcjdSci/t0cAIiYM=;
 b=TKp62fvXOUJj51iiPmS300tptQaglHMyFroGyn5qOyLbP8F72ZybI1kiwdII8LKcyg/0MEv1jYRgy/98GnJifkLQ4SciirNl0bw0YXuNR7oYKuO1+8Sz6lggSSvvT9O4emZWFeNjxJKVjtJMl74dCl2PA5mBL8GQYkCS2fkQIkwb4M0sFL3jQaRbgOFAyfIBZvXctwtv0RcZw8uwIDxdARCiwOHM84Qrt8X2QIqdRszlzN6xlqJ9SXnUkW2qbvEvLWg/aF347iYXnE6CarQEEoEntO3wm+HLNKZYHPDEYlYmSjuMjbzYibO4Lz+vkT5lKAm4O/PGVqJUaWnnoGqxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB4333.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Sun, 18 Oct
 2026 02:37:56 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 02:37:56 +0000
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
	atomlin@atomlin.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v8 0/6] perf ftrace: Support inlined functions and display enhancements in function graph tracer
Date: Sat, 17 Oct 2026 22:37:47 -0400
Message-ID: <20261018023753.584873-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: d687cc44-c326-4936-0b3b-08df2cc0d146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|5023799004|261009223027099003|6133799003|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	XdL3JQrV/j3aoEB8/w8sFkorvzMfP/cLvQcUp5Mk5LEdnS5/5WhL5TCZM6ODhItbbgE0WVcDqk5q1XWfGcnRH8LfdbySiQoU4KdsxgcXnFNLrndWHtTfDWOwXSdtDIJRemnwBNvRumYCSxLFoUNrdXm7Bhi0A2qS3vRF2vJD/agVZsi+a8LijDBLUiRctNaGIyOG5QodQHqglzyri+gBz3v5CkKyBzSlfYnDFjMIObKPKf3sqy2DNFlIKwsSY0A07ywhzSJXmjS7PQK4P6JImt3UAPKFK0ygnWR3dVAwaXv2LlRwov8jDEAUxg2SgCpABwMWTnXTfsts5MiZ8yxopJe69CFfsgBh4e5eVgOr80Mps71yPO9X3wI79fKDo8jVVhPQIzi4s3N78yrI9EkiTejsq4oeZqSDrs+6MnngVQGGZoHhynr6wWKdLimV86C7renj8nlRJDZ7Q/C+MHLUoxlCEIq6J+xIQ1vUcP5ojy5x3OM3E5WpLyVK1QNRgMIpddzpK9rNOa4GfpxwJsm6P0dd4gW7SFQN8QqjLmq2z6GHMS8adBAf3kOylcY942xgEdRMctD8VkbttgTPufVqJFyTxtWq3HtWFsuF8toXItHTIXNMbye2iNcT0gfa8vQv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(5023799004)(261009223027099003)(6133799003)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2t2WVPmGYi2eeacnqNRDZ/HKTD6QLPkI5LX08eoth9XtQQjc8PZ7vRj+/VlS?=
 =?us-ascii?Q?9ijBprEthx7GMl5T6m+QxrB4GkjYW1uikWrFLp1w50I82b0LVIvM7/P/7Z9Y?=
 =?us-ascii?Q?4Xj9nyLcOS+LopTMhL07Vq4p4JmSihDXSccwwADdwbbwSL3ldzkDjoYkM91u?=
 =?us-ascii?Q?7DQbn/YdElfnJqSaZTxxA10e6kAcqYZC4Uw9K7BKZ3l1Ixx32s1npiGYjwsr?=
 =?us-ascii?Q?EbGlLteB0FmnIwYOpVgkAE0aqlF9SVZWYVTe2hHJplBKzZJFde7vZSg36gsx?=
 =?us-ascii?Q?eU1t0GgIyAsMpcdOdNhJ6MfGpi3ScHZu1F+m3eTfvGxR2EXXRWLx41yBjJiV?=
 =?us-ascii?Q?GHBQNNBZqCMBU4YCkfnoPMlfo3hPWmaD52YnY8C4/Q5AfWWDi31haWvpvDm0?=
 =?us-ascii?Q?dlzkZGSAZ5nk8w5z3p1KTF9VAictS+8YkN5sAQOlVrPjXkleufLG7K1aMQZd?=
 =?us-ascii?Q?/Q+iqj6lxruygFEDtXGjAqK0Draa9ltGsfgpJ+TRGwPZwLPj78+fqYK4WWe/?=
 =?us-ascii?Q?l7DbqUtuN32rwlEwsRly8+DR0MjX4FFvWLg5M2TND7kvQgBfi+zC0kB5Vn4K?=
 =?us-ascii?Q?j2+4aK8epRCGu/lwvHBQJGkjenNQFLiNwd+HYIUhuxiw57UOU4+Ac3p9tS2K?=
 =?us-ascii?Q?jemvGfbjeHtYBLIQlygUhjUWmS/u9z2N6q1SDj9gcck/DAiZXIQGmYNciyHG?=
 =?us-ascii?Q?LEK4OMvw0LKAA2rzvfb8oz7UEFahMfXT+6N1XsIfsM+mZy7jO9eIdJJRNMGc?=
 =?us-ascii?Q?nzuEHZdR4WbqAKzdTD/gDO1zyU1NiKqpSSP9KyBYTDwizJm630mNQ7a1No6M?=
 =?us-ascii?Q?DtUZcAVT7Tq4NmFM6eT2DcV8jfp2pnMRwxYOiLjb4nkBLAB++snLenR8f7ye?=
 =?us-ascii?Q?hQMZXRyXpmAEnxESo2Rf4l2DWFuXNOIvCLA7YyOzg+EcRI6DlH/17eFabZ+e?=
 =?us-ascii?Q?MEcZBZHDoE8UJlPluiFXIrwLGBSzfFT2X7octmCJDOSoy5awWAfqCyGjpsHC?=
 =?us-ascii?Q?q1H22GVVnfVQJV17n7EJ7jiuWNx7NWdFkHjzVCknYFlMBnamJ/ktWuf1Gcz7?=
 =?us-ascii?Q?kzWYhbaZ5wVc0KpazX/n30ALgiLu/TgAjiHBRD3sr7z/yyYxEu2Ou0i0z7eG?=
 =?us-ascii?Q?wq+rqD8wQMAbviDxexf4Pi4Phcealdsm6zzPzJXXgx3bOdW50+no/06qpcPz?=
 =?us-ascii?Q?7m8Sle3o/40atX7vGT//ar8uMFyVq95aeyM2OeNDJtmDAMzLO5dSjD6Ezn3C?=
 =?us-ascii?Q?6WzIMh4X2vwAkB63vJIBadiqjpcZIXg7OxRGQNOL7R+a/Yu4WnBWDEHsvrAW?=
 =?us-ascii?Q?XKROKxoJzDFFQ+x1pVtWUtbaJ36jecxE8AXKdrNzG6hk/YL/2JkcDBwZq+IT?=
 =?us-ascii?Q?C9kTYwUfe3SuM3+nzTH9TcIJQVkZal5Klv3ggPz7rL1pKd1VyPz74DPPGFo/?=
 =?us-ascii?Q?5gX0o3vsFjaxXhtHCVbMmBkU8195ReH9eezKtiVbgC5LTg34xZbKnhqHrx+e?=
 =?us-ascii?Q?mqQlwQFkw80MHiJ25Z5/vBD/Z3OgxlOpfe4Hd3HBe+2kma7igKcsCbl8ZR8o?=
 =?us-ascii?Q?RWrAS2MdCRSij7X/bM+Q8Kr/OFV2bMivl/dXbArYFEpPc3BLAakmbz9xXgOM?=
 =?us-ascii?Q?Irc2pEhWRMtBB/93XhWIux3Hjx5vYd++0HtGcbN/M+/js32MJ8mlfaTeSxh4?=
 =?us-ascii?Q?/WJ0Nsj5lfNs1uF4UfFOGOtcI7xD8JzC4SVZB2LLvzTuCuxWzafXxKS21qqW?=
 =?us-ascii?Q?WbFav3ywxQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d687cc44-c326-4936-0b3b-08df2cc0d146
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 02:37:56.7509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhtRozKzEcGAoI2HcXPlHOWPP1Lsi0vds8ZnNRlcVggLvg7zNUXyLEEonj5eEJVjXigND5vC0En2RLfIp/sspw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB4333

The Linux kernel's function graph tracer operates at the machine
instruction level via compiler instrumentation
(-fpatchable-function-entry), recording entry and return events for
physical function calls. Consequently, functions inlined by the compiler
are invisible in the resulting call graph, as no discrete call or return
instructions are emitted for them. While technically expected, this
omission frequently obscures the logical execution flow when analysing
kernel subsystems heavily reliant upon inlining (such as the scheduler,
memory management, locking primitives, and RCU).

When the kernel is configured with CONFIG_FUNCTION_GRAPH_RETADDR=y, the
funcgraph-retaddr trace option records the caller's return address on each
function entry, manifested in the trace stream as a comment
(e.g. /* <-wake_up_new_task+0x1d1/0x3e0 */). By interrogating DWARF debug
information from the kernel image (vmlinux) utilising libdw, perf ftrace
resolves this return address to its inlined callchain and synthesises the
intermediate inlined frames directly into the streamed call graph.

This patch series addresses these challenges through six focused commits:

    1.  Stack frame optimisation in __cmd_ftrace()

        Replaces the 4096-byte stack array in __cmd_ftrace() with
        dynamic heap allocation alongside struct strbuf streaming,
        reducing the stack frame footprint by over 96% (down to
        ~160 bytes) whilst ensuring complete line-delimited records,
        explicit NUL termination, and robust error unwind and EOF
        handling.

    2.  Return address comment filtering

        Introduces ftrace_parse_retaddr() and ftrace_filter_retaddr()
        with --filter-retaddr and --graph-opts filter-retaddr to strip
        caller comments from trace output, accompanied by an initial
        unit test suite in tools/perf/tests/ftrace.c.

    3.  Preparatory vmlinux lookup helper

        Introduces vmlinux_path__find() in tools/perf/util/symbol.c and
        symbol.h to search standard vmlinux paths and return the first
        accessible kernel image, providing a generic helper across
        tools/perf and avoiding hardcoded access() checks in tests.

    4.  Inlined function call graph reconstruction

        Introduces --inline and -k/--vmlinux, dynamically synthesising
        inlined frames marked with /* (inline) */. Correctly matches
        bare closing braces when funcgraph-tail is disabled, clamps stack
        depth to prevent indentation drift, and expands the automated test
        suite to verify inline resolution, comment filtering, and stack
        saturation recovery utilising vmlinux_path__find().

    5.  Execution duration suppression

        Introduces --graph-opts noduration (accepting noduration=[0|1])
        to toggle the kernel's funcgraph-duration tracing option,
        omitting the duration column when the user is focused purely on
        call graph topology and inlined hierarchy. Rejects noduration
        when invoked under 'perf ftrace profile'.

    6.  Extraneous function filtering in function graph tracer

        Introduces userspace call graph filtering when targeted
        tracing (-G or --graph-funcs) is active. Suppresses transient
        unrelated entries arriving before filter activation as well
        as detached callee trees (such as ring-buffer wakeups)
        originating outside the target hierarchy. Dynamically resises
        the synthetic call stack to eliminate saturation edge cases and
        accurately suppresses detached subtrees without orphan exit name
        collisions.

Synthesised inlined functions are rendered with an explicit /* (inline) */
annotation at both entry and exit:

    # tracer: function_graph
    #
    # CPU               FUNCTION CALLS
    # |                 |   |   |   |
     3) activate_task() {
     3)   enqueue_task() {
     3)     psi_enqueue() { /* (inline) */
     3)       arch_static_branch_jump() { /* (inline) */
     3)         enqueue_task_fair() {
     3)           enqueue_hierarchy() { /* (inline) */
     3)             update_curr();
     3)             enqueue_entity() {
     3)               account_entity_enqueue() { /* (inline) */
     3)                 account_llc_enqueue();
     3)               } /* account_entity_enqueue (inline) */
     3)             }
     3)           } /* enqueue_hierarchy (inline) */
     3)           place_entity() {
     3)             avg_vruntime();
     3)           }
     3)           __enqueue_entity();
     3)           dl_server_start();
     3)         }
     3)       } /* arch_static_branch_jump (inline) */
     3)     } /* psi_enqueue (inline) */
     3)     sched_info_enqueue() { /* (inline) */
     3)       psi_task_change() {
     3)         psi_write_begin() { /* (inline) */
     3)           psi_flags_change();
     3)         } /* psi_write_begin (inline) */
     3)         psi_group_change() {
     3)           record_times();
     3)         }
     3)       }
     3)     } /* sched_info_enqueue (inline) */
     3)   }
     3) }

Changes since v7:

 - Rebased onto latest perf-tools-next/perf-tools-next (commit 1c90f0a3c8a1)

 - Link to v7: https://lore.kernel.org/all/20261018021346.582845-1-atomlin@atomlin.com/

Changes since v6:

 - Expanded the series from 5 to 6 patches by introducing a standalone
   preparatory commit ("perf symbol: Introduce vmlinux_path__find()
   helper") in tools/perf/util/symbol.c and symbol.h to locate accessible
   kernel images via configured vmlinux paths, replacing ad-hoc
   access("vmlinux", R_OK) checks in unit tests (Ian Rogers)

 - Explicitly included stdio.h in tools/perf/util/ftrace.h to declare the
   FILE type for ftrace_process_fgraph_line(), ensuring clean compilation
   under musl libc and non-glibc environments

 - Prevented name collisions between orphan callee exits and active target
   frames in ftrace_process_fgraph_line()

 - Allowed dropped-orphan exit recovery on closing braces only when the
   exit explicitly names the target root function itself, ensuring that
   lost orphan exits do not swallow the target root's exit while protecting
   intermediate callee frames from collisions

 - Replaced the fixed-size array in struct ftrace_task_state with a
   dynamically resized stack grown via realloc(), completely eliminating
   cs->overflow_depth and its associated failure modes:
    - Fixed skipped filter teardown when a target function begins at the
      stack limit, ensuring standard teardown runs upon root exit and
      preventing subsequent sibling functions from leaking into filtered
      output

    - Fixed orphan filter bypass during deep call stacks by preserving all
      caller frames on the stack, ensuring unknown callers (caller_idx < 0)
      are accurately identified as orphans and suppressed

 - Link to v6: https://lore.kernel.org/all/20261016040310.482876-1-atomlin@atomlin.com/

Changes since v5:

 - Prevented call stack desynchronisation on dropped orphan exit events by
   clearing orphan_depth when a named exit matches a tracked frame or an
   entry descends from the target callgraph

 - Fixed premature target filter termination on child exits by capturing
   cs->target_root_depth after unwinding stale frames above the caller

 - Ensured synthesised caller inlines above cs->target_root_depth are
   cleanly closed upon target function exit before resetting filter state

 - Prevented legitimate deep calls exceeding FTRACE_MAX_STACK from being
   falsely dropped as orphans by checking cs->overflow_depth

 - Expanded unit tests to cover dropped orphan exits, target root depth
   synchronisation after stale siblings, and deep call stack overflows

 - Provided support for glob pattern matching with -G or --graph-funcs

 - Link to v5: https://lore.kernel.org/all/20261015011155.414667-1-atomlin@atomlin.com/

Changes since v4:

 - Handled non-fatal EAGAIN, EWOULDBLOCK, and EINTR in __cmd_ftrace()
   polling and draining loops to prevent premature session termination on
   non-blocking reads or signal interruptions

 - Eliminated an unused local variable endptr in ftrace_parse_retaddr() by
   passing NULL to strtoull()

 - Prevented stack buffer overflows in make_blank_prefix() by clamping the
   blanking loop bounds and end pointer to the destination buffer length
   when processing trace records with exceptionally long prefixes

 - Tracked call stack saturation with overflow_depth to prevent untracked
   function exits with bare closing braces from prematurely popping tracked
   frames from the parser stack on deep call chains exceeding
   FTRACE_MAX_STACK

 - Ensured stale non-inlined callee frames resulting from dropped function
   exits do not block inactive inlined frames from being closed upon
   subsequent entries by unwinding the stack down to caller_idx + 1 +
   common

 - Fixed filter state not resetting for targeted leaf calls when --inline
   is active: synthesised inline frames inflated cs->depth beyond
   cs->target_root_depth, causing subsequent sibling functions to be
   falsely classified as detached orphans and bypassing inline unwinding;
   resolved by tracking target root entries (is_target_root), explicitly
   unwinding all synthesised inlines, and resetting filter state upon leaf
   completion

 - Expanded unit test coverage to verify recovery across dropped exit
   events and bare closing braces, and to verify that targeted leaf calls
   with synthesised inlined frames properly close inlines and reset filter
   state

 - Link to v4: https://lore.kernel.org/lkml/20261014161457.373253-1-atomlin@atomlin.com/

Changes since v3:

 - Explicitly rejected the noduration option when invoked under the profile
   subcommand, since profiling inherently requires function duration to
   compute timing statistics

 - Fixed make_blank_prefix() clobbering the comm-pid column in verbose mode
   by searching backwards for the preceding "|" delimiter, and returning
   early when graph_noduration is active

 - Fixed filter state not resetting for targeted leaf calls at non-zero
   call stack depths by checking cs->depth <= cs->target_root_depth and
   clearing cs->target_root_depth, preventing subsequent non-targeted
   sibling functions within the parent frame from leaking into trace output

 - Expanded unit test coverage to verify comm-pid preservation under
   verbose and verbose-noduration inline modes, and to verify that targeted
   leaf calls at depth > 0 properly reset the target filter state.

 - Link to v3: https://lore.kernel.org/lkml/20261012003016.263063-1-atomlin@atomlin.com/

Changes since v2:

 - Expanded the series from 4 to 5 patches by adding a dedicated commit
   ("perf ftrace: Filter extraneous functions in function graph tracer") to
   enforce strict target callgraph boundaries when -G or --graph-funcs is
   specified

 - Suppressed unrelated top-level functions that leak through the transient
   tracefs filter initialisation window before RCU synchronisation
   completes

 - Filtered detached/orphan calls from appearing as nested children within
   the target graph by validating caller return addresses against the
   active target stack

 - Tracked nested orphan scope depth (cs->orphan_depth) to cleanly suppress
   child calls and closing delimiters of detached subtrees without
   desynchronising the target stack

 - Added automated unit test coverage in tools/perf/tests/ftrace.c
   (test_graph_target_filter()) validating top-level suppression (both with
   and without --inline) and detached orphan wakeup suppression

 - Link to v2: https://lore.kernel.org/lkml/20261006232756.65620-1-atomlin@atomlin.com/

Changes since v1:

 - Modularised the implementation into a 4-patch bisectable series rather
   than a monolithic commit

 - Resolved potential infinite loop on poll() upon trace_pipe EOF

 - Fixed stuck call stack frames when funcgraph-tail is disabled by
   supporting bare closing delimiters matching LIFO stack frames

 - Prevented unbounded indentation growth on deep call trees by clamping
   inline expansion and synchronising cs->inlined_depth to frames
   successfully pushed onto cs->stack

 - Added dedicated unit tests covering bare closing braces and stack
   saturation recovery

 - Refined option documentation in perf-ftrace.txt

 - Link to v1: https://lore.kernel.org/lkml/20261005211518.26786-1-atomlin@atomlin.com/

Aaron Tomlin (6):
  perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
  perf ftrace: Support filtering return address comments
  perf symbol: Introduce vmlinux_path__find() helper
  perf ftrace: Support display of inlined functions in function graph
    tracer
  perf ftrace: Support omitting execution duration in function graph
    tracer
  perf ftrace: Filter extraneous functions in function graph tracer

 tools/perf/Documentation/perf-ftrace.txt |   20 +
 tools/perf/builtin-ftrace.c              |  157 ++-
 tools/perf/tests/Build                   |    1 +
 tools/perf/tests/builtin-test.c          |    1 +
 tools/perf/tests/ftrace.c                | 1552 ++++++++++++++++++++++
 tools/perf/tests/tests.h                 |    1 +
 tools/perf/util/Build                    |    1 +
 tools/perf/util/ftrace.c                 | 1168 ++++++++++++++++
 tools/perf/util/ftrace.h                 |   18 +
 tools/perf/util/symbol.c                 |   30 +
 tools/perf/util/symbol.h                 |    2 +
 11 files changed, 2935 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

-- 
2.55.0

