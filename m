Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021133.outbound.protection.outlook.com [52.101.100.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693C254B03;
	Fri, 16 Oct 2026 04:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123403; cv=fail; b=DmQuzvqajZ+ALSG6a8eEecH260YTUnTV8TQHz2yjwz7InxVI8T0QnIlT9p70oETovI7U4SsFGNrX3WDQmTa0KOTj8hkdGsy7UWu7l990w/q9W6NtC7iXicvTquH6DBatr/D+85qZzNsPAQvxP7r6u4XcTwW73RaKsmk62OCK+YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123403; c=relaxed/simple;
	bh=iACqL3EU0mWpeU/5KQqLT+LlnxtcirLSQRbTJyCx0TM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HSOSOoxP+9KqLfxQmWX1dvPo0oreQGt8we+N+eu033wmcvGPKPsn67ckkqN+IJO+SUrME7fZ26zEMgj1g4rGYodEzMBhpYvV9IHyasGL6LfjT9ZiscrzvZjUwAAAQGsr+DH2pn1ggoVQIvzwbpXsZWLmdzZxANouwq+DbahytfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhzIKXbl6/8wLN4IxpqosK/fJxVNZwNM5sAKXwRWv3V6DSDIcMTsn4Ayu6j8UZ92oPX8wNo579ihaoWDaxSchIc3Z4WLPTrlRlZRDfIzaenJJWrQOjU2WLCivrgssAmuqbmpKzNUvcBc5hZUjsD57s5RyrHPB5V+uHaFg+qLNFglQEaQ4oMs/iirjjWFfXcbnkFWdkZHPpHso5B5YbIFatJwqfrWcfBZhCnWIE76ioRTkl3nr4/8M7VPS//+1dpD7n12Gq3gGhpnWU83Gm7u1+IrvkdnXCOsW0cqzYSMA9mBKbMkpkcToKvdFOIwqSs3Ggi7gVdkTxz4Hbo4BNqRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=iQPa5/MJhJKAxv7bYdWcIfjP9m2Z5aMaZf2a8hLfhGw=;
 b=s1K1EMo9mlyolRCoJnqlgROtYVAWVljdVEliEKODfwE7JaVMQ0r44iQcXu6nvYGPWiOQyhi1OegFnBnIYqQL9Ew228rVtODVcsNySh70cKxfGeUCVfEYkVA121gUywNx+czj8XCj/mFsjTppXCv9xOCimGpZJLvoUevfhezX8EbijnxLOL5Xmc0kZQiRcQTYNs9GvBSmpveiibcSnodKcfnCQLdXiAS9CYi1j0KvZTVtBlTRoadQGL82kVk7XXRLSvqtBdKgCD5a227jdObhkCEc/q5ukdaJ2pufE44ikeCvf09JihAzusD2pLbzXMhBw7pDVmesXvfIMkx8tUESkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8944.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 04:03:16 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 04:03:15 +0000
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
Subject: [PATCH perf-tools-next v6 0/5] perf ftrace: Support inlined functions and display enhancements in function graph tracer
Date: Fri, 16 Oct 2026 00:03:05 -0400
Message-ID: <20261016040310.482876-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::10) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 630d1904-bd4b-46ad-d38e-08df2b3a677d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|5023799004|261009223027099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Xxxi904sQwe9LlhBK16IvxscG4gQUEvLD0gg2qvKxIx1FfzvRmxqI3b8UnDUaq1H/LOKka/dIjmna2UDZ+YhDtD+AGhM/W0eMuhPPLJZn6dU3Hjlct8n9yYw/dKAuLnVr/ZEMTxBnhsVseRsRtv5zBuB84zRQpvlB3F2r8mYM/w9WBLjXlWqpaCQs0hIn2JgQ2n0Xa09KMJxVKORZp4mPzIym2J2y9rOyDpbfnTZhsPzHB/xFDGz3rwibWejo198RKVNePTmRbtHYrbt03VmODbZV8BQjvwdq6EKJVhYSLcOh1xmajkXtGWVi1xJfs3zTz8h6flZZTHEzrVqM5M+W4Rul2safsIbw2BXi2ZY+N+W2lLhoFblkKNUonX7w5Efgna/Qzk2fKsiCSlIqeuX00lUm50X7ULO3u070LvHpiLsSb1HWzrLkWm2iUw6GGhI7taogHePylVJif8FnktRmSh5Ep0jDMaVIjUTlZHat8Hg5agK0qrJAtqNxpEHKRZNKc4DGuPF1pU62QC2p/vNRkF0hhedGjyxmi/wobXv+JDjuHCPY6yX5iB/xS6YpCqVpbittOhcjxxECboHctNyK6dVgcg2AaQxOw3Ic8oYy/0K5cmBKQxbLXcM7HCoA4lD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(5023799004)(261009223027099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nBqzMeNLH4KCYnwp/gnJ8JqpnxsFaOaTIweAMOD7QpieTw3g+AWtInESWVWA?=
 =?us-ascii?Q?UF5bwlyEQWEXk274s43Z56Dx2Pe5wVYTRV2Ftom41vnUw/hwtSynC+AS8hwv?=
 =?us-ascii?Q?bb48rNcboeOp0/oQK4zhXKr2aOKfbMsBcJgB4jlBpfaiZqDW0ikiAtG70OVj?=
 =?us-ascii?Q?z2YFxPy+7Bw//c3SpBSVC3YlvEnFL6+ouOGAMHbqy8vMh4GrQPDmXbl8CT4o?=
 =?us-ascii?Q?ZCnHn8WSM6m0VfMGNV/oaxBV+h/sB4Lt99Qd/Hgd4kYO1Rd2MUD0kwUHbTfr?=
 =?us-ascii?Q?Zf7ET5MZv68xvJt6Dygz/ay9t3OCqGCnMtE20rcDeBxE001QSfWWg3Z60+H+?=
 =?us-ascii?Q?KgThoi2jAI/7Flggn8or7QY1PhHzntqYdcxaZ/ErifAX862RBLo3nFLs0Fh7?=
 =?us-ascii?Q?sdTJ9K5UUZY5FTpWj0x3TlQzij1gxaW1AeH/7vyyQQy0ib3E+/ushEJkC1EG?=
 =?us-ascii?Q?gBwBZmYXytt8kbgvLKnEOTBgER+kWOfdJDThhJ/wbIbNDL17iORIKhjuwRBu?=
 =?us-ascii?Q?KWWTRGtrEt/ILxjzGGT0PlJ2TNfte8B5dZOG1cMm9x3Zr1YbnH7CTo+t/xGJ?=
 =?us-ascii?Q?TRRcdaPHSmmcgG+CuZu4nUzDh7VhGGH/vyCgFmMclPIBS45Y4fF6U9H5dD8W?=
 =?us-ascii?Q?jys2eAFwLVcP92g43cm4cdKDF75zciGeNansZDGl0IT+OXTh/0FrRxg3utw6?=
 =?us-ascii?Q?pQ731cwRrzDaXBu9dSU5XqeD07sFX6ZoY62ANvcKdOGcAguExBdYZNuPNDZ+?=
 =?us-ascii?Q?r6hIZUKov8L6pYYCBWTE9CNEikyYDpjp1DoNnodiT38G9IBPM2MhdympERIZ?=
 =?us-ascii?Q?z6KQLRzXtMH6uKlpCq9NTh/5Q+PV0ssH0Fku7zPj75kVxExO5AtjsajgzM9O?=
 =?us-ascii?Q?GLFe/r7VlMf8w4phstuT1mGUfttKkt5xJL+XYHxW5gRPkPAtiMmyKsxm2/mI?=
 =?us-ascii?Q?GgX8ZNhqWo3/eKxRwC7zTIiVwmMkiaYEpqMry2l/v9aGsq5ORKIAQbcCVDAb?=
 =?us-ascii?Q?50Xmwaa3cMuM7PApPjcZRJc1lMRKB2GG1hcgpBsI0CYx2mwy8AQYiT4WAHJJ?=
 =?us-ascii?Q?aKunUFz76s6RfEG95yO76k3te9ZoR/1dSJU0CEw0ytCGqFyUj/BYbckzMVgM?=
 =?us-ascii?Q?x8RKs1d72Xs5WQQcgkpJW99gdkxngk1KgIbBXRURPwHSNZjyukTI1a5zoxJ3?=
 =?us-ascii?Q?0ZKOkeY78TX8CIHG4gpobpc65WogZgBu3gW5u6ob8eqndg/H99jI7/eVFMo8?=
 =?us-ascii?Q?z/vn4kInw3+utJDrn1/05Hx4dctNwCfW3KaXw3kn9p3LMxbVTGLU5YZ/LNPd?=
 =?us-ascii?Q?9kzVhO0z0PMjqOB/hxl6C58x57Mp7b+LVOFNkXfqTBXDLx2Il9dm42eWoPRY?=
 =?us-ascii?Q?CNbixIfHY2m7En/4PiHhg+6O68T6Dchd4FLPqdbE21MbP3rn5It7bdesIbwj?=
 =?us-ascii?Q?j6bwHmErmozjgJUVzE7Mh4R+qkNi8PYEYKvYbDR+duJdUT2cpefXwfuuenaQ?=
 =?us-ascii?Q?fiRGkGynMtWO9u5PigsOuRiawPBsdzIpfGjrYHlUXxSDi7px2DVKEaoz20oq?=
 =?us-ascii?Q?lv2knewoHTIS1G3GCKuHUiro9yEbhC8cNhXaDQfrXQ7M8gkm7g2BdQUNkARG?=
 =?us-ascii?Q?4Tmt0lM5JkAR9ZHK7MfRHIcD6HK3mj6fo68BwVYE2hOLSUuDD78/T8XR/ZcV?=
 =?us-ascii?Q?IMZiHLMXnCwMTM8TWf6vOzJdF2oFlOMoarSXEotW77UEF8ClHrT3bDFS7ttk?=
 =?us-ascii?Q?AMqe2FMUAg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630d1904-bd4b-46ad-d38e-08df2b3a677d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 04:03:15.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Njf6MDK8dG/pWbbpc7mM18tx+QNQ7/9TPM7XizFJRDliJgncqqrGa0vgVRfgaoKVWwSvgISp2fy6FTIeqwLwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8944

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

Aaron Tomlin (5):
  perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
  perf ftrace: Support filtering return address comments
  perf ftrace: Support display of inlined functions in function graph
    tracer
  perf ftrace: Support omitting execution duration in function graph
    tracer
  perf ftrace: Filter extraneous functions in function graph tracer

 tools/perf/Documentation/perf-ftrace.txt |   20 +
 tools/perf/builtin-ftrace.c              |  157 ++-
 tools/perf/tests/Build                   |    1 +
 tools/perf/tests/builtin-test.c          |    1 +
 tools/perf/tests/ftrace.c                | 1287 ++++++++++++++++++++++
 tools/perf/tests/tests.h                 |    1 +
 tools/perf/util/Build                    |    1 +
 tools/perf/util/ftrace.c                 | 1039 +++++++++++++++++
 tools/perf/util/ftrace.h                 |   17 +
 9 files changed, 2508 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

-- 
2.55.0

