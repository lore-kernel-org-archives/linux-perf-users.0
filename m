Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021119.outbound.protection.outlook.com [52.101.100.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35E4A32;
	Sun, 18 Oct 2026 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289637; cv=fail; b=oZHzmnAJ2P2fDUCEVaPgQNOjjQOrtzVy1QIcwW5zgHeYD9lolFCGc4Nq/BxC5xLCIfSaJpCRrXKtj3BtPA/G+9ZD5MNXo6zUJGqcx2xWIPv8sZQUy3I+t1r/E2mz6tTM9BCQps/jltL9oQS1w6xSlT0h9PkutOHJX66J4H7it+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289637; c=relaxed/simple;
	bh=XgewDQV+VK7gSmTonroxrpwnm4ToScRKKS+R8UR/wb4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CUwaQTdUWX3fMcMhFxWDqSErzkKcZ8Aq7BAXFviAQZnBuztZD28eCh+XXG4NN5gw3bCtHwBbOf5dd4EZNgQgs0H1xRsdYgmpjU/HYu7XFXgfYPF1l4/WeSYXGYBdiH2qDKsxGfl21gMBh4lrjsNxXc8qJ6Ogh4gZacoeiZkwhmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrujwvmE0oSb5h92sXUQOy5vH89wclEgFcogrlgs/TP8lyWyyTq9QIlPyCcW4+3LXSAwcGRqwzYX1BAbNSe+FkPKmM7FuIyLsWgFi2Zp8inpcs5M3smnYZu8zWrPzh8ocT1/D7mbrC5z+6Wd62Gt0gng98i+QbkvJDgPiFTJHO5Nwkkdlq9MJNBFCYkIlWiMD0f/dr0etJPGqSDxCfG0f+nU0sThgzLdVuvhatMiB/5CBFGA70O/UANgoUYo1ZqlIayAmWfLk0IsFS06joKHXNG8FjOuldjCRA6my7/RO9ExzbbNfSuPcbJZKUlNdI2zqcwDFpunGi2KxxzBEMEzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=wuGcVhy2nMOvLjUJpqDJgv1kgYBYY4k22Oe9vM6QYI0=;
 b=ogBefqu6Pv/O2RShriSSfszMKk1X2RxJAwfFc2wM9wRBwTlV4QmtfXoFmz39MwTaEbi1Egmuw2uxuDkArFPDrmwPvXHyeMpdyO92T74kivmi2NbK7MA0dt9x7cXU808xYegmI80vWZgePZh6GACUCKw7b9hVLj+RVbfgzSXPGx+kZWGOv2ziGJoQELdw4qDyuKvs6XvhSvPuiIqYkrUH8L+Dy23tAdNoJLE+DPepYuKpEpuGvB/cSFwl/gZFXXWw5cp6x4656yg9oM6LLO/2R/xm+K6CKhNlQKytYSlOuHh7UDD/tREHLIqsvxuY6l/kjYGmGXWFPyJCFglR1/PyrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO8P123MB986281.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:805::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 02:13:51 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 02:13:51 +0000
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
Subject: [PATCH perf-tools-next v7 0/6] perf ftrace: Support inlined functions and display enhancements in function graph tracer
Date: Sat, 17 Oct 2026 22:13:40 -0400
Message-ID: <20261018021346.582845-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:408:ea::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO8P123MB986281:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f9ea70-2b8a-4251-d289-08df2cbd7387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|6133799003|18002099003|10067099003|3023799007|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	kyCN+32ZNsHyJ7gBd5Jj4v8gtm5elov58VZLV/6iejfdgYMvpZcxeA+gciiVTMX3YinN1dKIa4aLbwtrKmBH09ETfDLdApU75P+J3I/fliDoITegJXXdr893Iogp4ZJd/TkJtFkp0Bt1+EFhIqfh2M8/dfB/P5NzN5eQqO4ofaed3/x10pBk6znvdJfzjOM5m9AtvXBVKXo59XfTobKfO4ziABI8Rf6lojDTc8Wg1q+Vq3h0GNX6r32ibqB0LyTYYLkA6WDuWvy/5skRy2JZ6QsxfXMR2YmnhXuF3oYreIy0wrPviYf2Rgtkk4MNXaG9OAmduUpeZWRaauqbVGcPrluoTRHTtioDRgwtUtyi17un+5TO8wp7mTbnZ6/pNoUabK61x3DEoUIE0idu3uSoLlb4WtA8VxEqAsqm7kfymlbJyO/slHpeTcnUE1qMuTOrfxX+mJZyod9lbWfR0AHZB6GmdSN+E0zZBDq/+DI2pR5n1yoI+cAnStyX5yOmoWJxw4cy9anpy0tkHdCIsZ71J1T1984R5YI8HJ9ayACT2kSiZWWpWg+0ggodon6pUWx6qd6CMEHYsHWsjDSuFMYCjh09Mz43eJluDtYwKmoCJN7UH3ZsBykotSL3oz3e9a3X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(18002099003)(10067099003)(3023799007)(261009223027099003)(5023799004)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MoALMHjOMQljV8WzHQJNPf38mUUjJlym1XqmetT7hj6QXQGuREui4A8TjnZP?=
 =?us-ascii?Q?VqvSPFevkTefMF/K+K1eEL8DOmyHjU2AwS5iAMT+AnQI924/gKuV47kkvbfM?=
 =?us-ascii?Q?HA5aEIngGl0p55fB4sxL5OhSmF5f2fyvadMjlwtKlL2T9dmVkoqb8SkimaxR?=
 =?us-ascii?Q?R7DxGomupUn/60oY/UsRz+ME1HIgU8bHdf+NNi+2mWXW+5ZMUfaVFUJX8IUa?=
 =?us-ascii?Q?7/BO/iZScyz/1Ij3A5yo38zHNTtaIUeGtapU0pC3epxOHkNDcac9HKzDFbwN?=
 =?us-ascii?Q?VuX+xsDZ3Wh5ZxuIVGddTLKoJs5s050ONJi05eAogk5Q1EM+Ukc4uA46GDgc?=
 =?us-ascii?Q?F74aqSLraNXZzBHJ7P64JH8ZwlDF7emEWoSkVE0KxRITsGXpqpwwO8XPrYrn?=
 =?us-ascii?Q?pQp92cyn7zlUpihlAhD5SCG/m+bUMn0lFusdvd5aWC4aw/yVcuC6tQ98zMhI?=
 =?us-ascii?Q?GF3SYhqWe5tR8J0visyE20EftScmkEiOHMzQ06SBlm+dU5oyOYrk2zr3T918?=
 =?us-ascii?Q?5BRQ4a78PisJVwbJiP/pcGdWH2Ef5H2d1ZBrFMY8Sf2IL0Ry2NzOOmTkEEIN?=
 =?us-ascii?Q?tu4mcoahYb67dFxsqmr3qqq4NhNVj+e2AEnThIwqC0ZuxtW2U4HFcdkaHDs2?=
 =?us-ascii?Q?dS/Z31T5uK1QYcRKA09k3oGtrHedtAmnVZWhhVbmsLwtngJZrpE/b/gILhlw?=
 =?us-ascii?Q?i4nfJ35UKCfn+++Wz5DESv7YziM5CC3/X/oNiCGkDGWjaHdYi63ZvD+8jSrs?=
 =?us-ascii?Q?VlPEA6Mi/3MPK1w+Rvc5L9HKvyCH22741gyBqwNTOpjBpzivJscWsOUbwdMm?=
 =?us-ascii?Q?bt7pXso3+l4XuewnZ4Pt1bCjh8T9TvXX+vqdNLavrRWZWchzeDypjrbcRda0?=
 =?us-ascii?Q?i1rSMSpOiUym6c2gF2B95juavFrogbTSke74duDToHJMWaquebbFAemGLDjw?=
 =?us-ascii?Q?PX5h/+6vxkQ6mTwjwV99lv8gugiqvdK8QHKEdhyTisAa6lyNTZ6ivrBevOOn?=
 =?us-ascii?Q?LzE23bIPWCBlUN12np889dtESc8ZDhwmK9FXcok2/PpJwDaMXdJubCa0qL0X?=
 =?us-ascii?Q?5v8lykDGnE1EVFvYKpUNVv4d+8jf4fwEcNYKnkm8wsySsz6tx5w4PcD5fYr4?=
 =?us-ascii?Q?+s9y9njYJx1wNkksbGD1eNvle2ovlI+vuBSOzYMT9PCUFy/zp78qK9oT1o41?=
 =?us-ascii?Q?YfTCtbanfO1GstoWvEyon8YEsPJxzrfp1I42ha7eD+Z7hvR+DfN07lkYd/DT?=
 =?us-ascii?Q?kJMEns4c76swZ6uKv5RpY5ri/K5MHpxSF3+Nmxtns+wxJMMOFHW5rB6b5ps5?=
 =?us-ascii?Q?2+ydOMi6pvmQPaFJ+5DS/jR3eNSPZSWyUh04kwtSY/VCgRMmg9QpVLSAGxdV?=
 =?us-ascii?Q?QqwH6BYMP38QhwnT7DS2t2Y/dOi2rQWwD5VgbZNUMkx+LrW42sfL8hCCfRxu?=
 =?us-ascii?Q?iwYLp5GowJfD2uhFQuTQQgWEnUY83+lpUpKAJMKf5e2acaui8YZwhxV7KzrB?=
 =?us-ascii?Q?Pr24gJdFBmrQ1c86hieJno/LiBS7FW2o7SCa6Vku+TRb5emBC2rfRtg+79EY?=
 =?us-ascii?Q?ugHqkS/g1lHacViPanZyuh+RsXZmznFDD9B/LEKZTAz/bDC4789MpKjCEf0M?=
 =?us-ascii?Q?YwHTcKkvYQRfjbpFPK3QWWAnAASZXQHWl5MBNMkK2oSBWTc7oYJasZiQGdso?=
 =?us-ascii?Q?z/7UD7yv7T4XXHC14lVb7ZAluoRoqaqqn0GapviS7vGrHDfxVvqlUA1bxedw?=
 =?us-ascii?Q?Jf7boVlEPQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f9ea70-2b8a-4251-d289-08df2cbd7387
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 02:13:51.0886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pdf7AOSaoW4QGhqH2reiVY4uzJ2JTd4yjx0d6H+Tj06JB4cTxu9eDaQCyHuzPj4lRuPSq+InAya4mHMrci3EJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB986281

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

