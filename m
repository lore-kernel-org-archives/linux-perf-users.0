Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022088.outbound.protection.outlook.com [52.101.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB002BEC2B;
	Thu, 15 Oct 2026 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792026726; cv=fail; b=KmXAcDYXxF89Z7vx4lTthDZrSVFuzi53rWz9oGd5H18jGQb3Yx6QHHVpO3wu2boxAGy0lmYco31XQKxoTIs10km56XTspMbd5dGi1udIEQWXiKHB3JFqSvWU4Hrr5Kde7N4s6Tsjt9TFMtrO1VYDV6iE4w9vVHuYmdvWg5LCGrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792026726; c=relaxed/simple;
	bh=kXq4F9rbSVC36D9bvx9blpUscET2bkZdrbZWHT0dY14=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hSuUU4FZuXU+IJ1GYvpUUoD4n+1tzYpDcOaM6zKEylKdcSC6e05Sv2rJp95IZIZ6mdsP/o9Km3gsa8bdccVL74H8GGlRgpgTaYvAb9ooe1xRUuEmvhLKEw8UK3xO6LUbH/OX3D6YdfHs43M8m61ky/7hFIAjVDPVgJKXGnEtnQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBPUqVg0P4fIPqKakU4e6Qv3ixNw4Fx46hUCppGZ+A+k2wQHEJbyvM8Mcw1nT20ukazA8SLIP8L/Izm15GNz9z8Y+BYyrcuPoQ+rRICdVrfJewqsKwOLBwIe0g8MZHF0m1PJ+mTxLwplcj+wJu+jtjJiI0RHY5MsKmLjk5SLpFMYC4h2uQskr9H0szzT/5QK/e7MsHobgXH3L2DUd6HY1LV1FlVNQ7+hn7QqO6qSfZ/lQ425ceWlVdnjlYz7ZOCeMF/P3tRXR3uaj4HCIPtk+Sel10b//xkApWGoPTQ1ZuYi2nLu2AOroqW2zbIvtsZFZn/y0XKRoR3+6T7bRlxtfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=JxRM6U4dqpJi+tSAPZgfzDvXhePJXYEyyocCTGROJ/I=;
 b=Xe6XAR7VSaXArPGh8zGglPWCcIvguBZl3VAB33ps1zMhGTsWzNCt0ngmGp/W8TdPbbTo5jHHwCe76cVEy6Q/KLVSyR2hNx1EpI8ORlHeoTWLHEQ/4XO61N911AMujjDI38040X0adSLU1sxjL/Ev06at9hmTmzjUaKwmcDWBXl9lvbE3ijW/mqwq1F224uk5W5OX3yebzctKCvnRI36gU47rV97p8xnmDQDzrAhepyr/mfKuij9GdWqbSFJS+OdSFkxlq4ue2MU9OFKEPe+4vw6wjsiYGjnejYALklUxC4gadMM57SPLFzYz4katHN2bq0VYxi4CJRhYnajysu3hGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3927.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 01:12:00 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 01:11:59 +0000
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
Subject: [PATCH perf-tools-next v5 0/5] perf ftrace: Support inlined functions and display enhancements in function graph tracer
Date: Wed, 14 Oct 2026 21:11:50 -0400
Message-ID: <20261015011155.414667-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3927:EE_
X-MS-Office365-Filtering-Correlation-Id: 14288966-f096-445e-317c-08df2a594fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|261009223027099003|5023799004|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hl6GmX38JVhBzFGFPOdBgCuJENJ3InbbiPtRTf+tSF0fbJXwz9VgDWrjJ7dDZeYh8uLqk4Xd4YljJ7B09PKCu3ykbuaSaSODCHEsMvacjYnDjJMF8ccehr373zhTaZaL7Zt6M8dP1MAzB/WVL3i1OZpP/75lUdj5M5fildfeyZCUpldL+qKVsbeQ0AwvWRXKbLXt3+Ll0VUba/a8/b/AVhZzoMmf4qvlMFmnuNoHOYVLHG5XSy6PE38jhJrEObQfQ/AojmyfMc0ZZhGyG/YkgTNHsR5NcQRiLoBGquIDnnfkHD+AfE2cH5DLP8VDMzAdQtDhv+MY0D821xJdU/U0CJGuMCfzP5gWplhSs3vNv+TrenHWvgfDRUn3cZM34oBNna6O/sPtp10gC5hSOtjdfd1lpAlZJh/xmFMHsuebzsDsplLbrw/3CAliR2+zAYF2q4Ewl6MeN+MuKnyAds4VwYXbh+R99hQ7mWFpF0IuWTaeMz/gocK6GdwWa9i493uBsvAp5JHRAukI8iSv+Zw64p4euUvFMUixdfwuXG2aF5hlOPk5sz1D8ZoYkIXK4k2L9QNgWqS36El1Calp3RSF/rKfWhjxyVJXbpUIZOu3FlVQhQxczESOqOf/H0Zkw1sB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(261009223027099003)(5023799004)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sMeaLBgDgYHBlwV3bnG7YHGF2aOQ1joysimIwVRR8/YR0g2SIb+hAGArF1dA?=
 =?us-ascii?Q?YgB0dci2mNojC0VC5CkfFsPvLrpbjG8KaPPI+ptT4E6dieuwxmcNdOZWUgDN?=
 =?us-ascii?Q?GnqkKL2Ozjjbml9YJYWlVM1bx31iEK9b5SW4ySYXpq04iSCTQZfOVE1+x/7Q?=
 =?us-ascii?Q?ENrr014xz4gKPaw9MHwFlpyLoejM1pdnbXyso8zclP83DjYBOnhgAFkvAJWh?=
 =?us-ascii?Q?SFElCr4tk2KDHP+MnCEiVCV9sbawlQB3D79fpeagIPJ/v3FqoBbl1ufOpCLc?=
 =?us-ascii?Q?PZuFyCNaU0Kr31aawlJoye5IjK8aKtAjlBa5i3O4vJqmBRGYa8kS9hBEHGot?=
 =?us-ascii?Q?w6ui9RJC5NITpE6ofpYHxfcBFCTJJIKQRSdq1F+vipQYK9TxyVEtFCiPtR20?=
 =?us-ascii?Q?1/nPAYl4jVaYyZfVJ+DGFwmsyGLnxgpN6sBoKwtbuJlKjqSRaCyg8d2AilCp?=
 =?us-ascii?Q?sw82AirmpfnDf6abKsUQRq+yyt6el7mUIXC7KR23zRfqbgi+orGCLf9Qrq0G?=
 =?us-ascii?Q?gRH2JFov+zOiGUz5TIMrHtxsOAvseHhsjqdKQp3ashb4+CBvuMHOy458BZZn?=
 =?us-ascii?Q?/aGjqA1mqncZesHHkRmNnk/qp2L9agGBQ15c1ih1856KmdwxV4SezCa3dpKd?=
 =?us-ascii?Q?jmuY6mwgAzMoStQpwmHWUbYudkqFBgCxiXeefV4+8IXWAseWhWqTrnEiVbWD?=
 =?us-ascii?Q?FcZzbJDLjweOw5lxsYKCxbQaQOlDdjFXcM4e5g+TXO86gNqcICspeHmboyTH?=
 =?us-ascii?Q?WS+o82bLE3Y83LDwoLaArG0kH9kQ0Apz9Sm9x4yh1EmL9FNUhOCJKW/aGxYT?=
 =?us-ascii?Q?admul2uv+KgczzwEt+Uv8og4aZfQ7fbeUdk7wV2lmXs500l9AQYyiUvP3xlL?=
 =?us-ascii?Q?/aCFz7mdodD4YMTqdF4F5aBdKxrZsUUt/1XFfN0RYegmnvaXh321AIbqCUzB?=
 =?us-ascii?Q?nGfdxkyLMRwcmllkQoTxPbj0PlzNcJKP75C88oqICrXneJOm2ZvumXmKOFmz?=
 =?us-ascii?Q?JsLTmjvlzu+rChMKNRLvg8iwLzxN6KqEykWJzdgg6kPXR8XoAuAS0n12UM/+?=
 =?us-ascii?Q?VCcUokhlKCMpyGhtfjZ+JQ9aqMa3C7MOAnYC48rpEbR09dZIrLMApPheA7Qe?=
 =?us-ascii?Q?jOwRUgPe0zcOJyQuu7E1qjjAHtpeZlSBN92I9U547WJR4htlmqsXmJ0cy/mU?=
 =?us-ascii?Q?YVFC/m94Dr0AHScvqPG1PiKJFscpG05XxxgLxB+MRCe5VdR7oAKlz/qh8lyC?=
 =?us-ascii?Q?h+8VG/q/o4c7kdN+84hOgR+uZXXEip6+ZxjARnyKSpIaqzxXkHunduXHAXMB?=
 =?us-ascii?Q?1X5ZSDsQirw00JCagognvfT1J6JBvdo2CJLuJkElHzo3IVhaXxIkG0p7fH3t?=
 =?us-ascii?Q?1yXfOAlf+b5Fwrz+NsOqx52N4jIvLnZdi5l3615OKlKgsTCiAsyNxVuJKdyp?=
 =?us-ascii?Q?gxaKhcWWRBTsDG3yS/12kADRoWNrSYrzHCWevHTtUqHovoKl9cxDfI2vB1lW?=
 =?us-ascii?Q?cBsjNq3x04bSBdJhRgN/YYpkiJ53KLx+O/mC4BPqpht+3PNi1KD0WBeM8t3V?=
 =?us-ascii?Q?JibqvRQVhlN/7TK12YWWihOvpTeRqN2SI+fhOpdMLtVF64NjMA/qJFXWn4JQ?=
 =?us-ascii?Q?A9TcpichJAtJynyuLLjoZa7e1IXsvDtvgMjm8PJ6ujz8UNqUjDHieIVDWBy9?=
 =?us-ascii?Q?MhIWq9NEe2QNeVA3+MkGfGeXITeQGnXJ1knf75bKSTZx7MfcjV/j3e9+/I4o?=
 =?us-ascii?Q?/DEgdo66Ow=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14288966-f096-445e-317c-08df2a594fec
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 01:11:59.3390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEQz0k8UfIb4E4z7sMR7mB8v1+Vf50xKSS5eqdj0Sk2XyWDP0JxlCbuqu7c9/eDCBR69z6bJP8Mkq1YlVlxY/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3927

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

This patch series addresses these challenges through five focused commits:

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

    3.  Inlined function call graph reconstruction

        Introduces --inline and -k/--vmlinux, dynamically synthesising
        inlined frames marked with /* (inline) */. Correctly matches
        bare closing braces when funcgraph-tail is disabled, clamps stack
        depth to prevent indentation drift, and expands the automated test
        suite to verify inline resolution, comment filtering, and stack
        saturation recovery.

    4.  Execution duration suppression

        Introduces --graph-opts noduration (accepting noduration=[0|1])
        to toggle the kernel's funcgraph-duration tracing option,
        omitting the duration column when the user is focused purely on
        call graph topology and inlined hierarchy. Rejects noduration
        when invoked under 'perf ftrace profile'.

    5.  Extraneous function filtering in function graph tracer

        Introduces userspace call graph filtering when targeted
        tracing (-G or --graph-funcs) is active. Suppresses transient
        unrelated entries arriving before filter activation as well
        as detached callee trees (such as ring-buffer wakeups)
        originating outside the target hierarchy.

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

Aaron Tomlin (5):
  perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
  perf ftrace: Support filtering return address comments
  perf ftrace: Support display of inlined functions in function graph
    tracer
  perf ftrace: Support omitting execution duration in function graph
    tracer
  perf ftrace: Filter extraneous functions in function graph tracer

 tools/perf/Documentation/perf-ftrace.txt |  20 +
 tools/perf/builtin-ftrace.c              | 156 +++-
 tools/perf/tests/Build                   |   1 +
 tools/perf/tests/builtin-test.c          |   1 +
 tools/perf/tests/ftrace.c                | 837 ++++++++++++++++++++
 tools/perf/tests/tests.h                 |   1 +
 tools/perf/util/Build                    |   1 +
 tools/perf/util/ftrace.c                 | 930 +++++++++++++++++++++++
 tools/perf/util/ftrace.h                 |  17 +
 9 files changed, 1948 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

-- 
2.55.0

