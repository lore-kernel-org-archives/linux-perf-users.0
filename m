Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022105.outbound.protection.outlook.com [52.101.96.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280F3FF1AD;
	Wed, 14 Oct 2026 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994507; cv=fail; b=QODo8bE1xy5CgKRRgRiUfnkzXHxAyKRgDjFmWWXAt6f3OV47COa11ByyIBCL8tkeYvq8V5Pq+KJnooWSLqoU+CRIvd3qtZf1INSCJjPphFJwVuu4pQAbPQA0I6h7N4IAbOs8kWDTV786WN0niPn/Ip6kZHahdzNtCUCxU5UbluE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994507; c=relaxed/simple;
	bh=MmKP5ZfpAxEXhkQNezyoritTq33YheAbcAB0CyMs/Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jp72aF6reCMpYwGb/7L8xfLmPHOwUVgwQKCgzoIWOXcclgDrYtkj6TbmT+s59kVr9F2AxdEVmCF+52sirCq49nmCfsWD2Au293Dfg/f/QxaIEpQvhQXrlbUO//Efd/eR6r3LTi65bW5nqd3U8Ztla+KKlIPuSsfXlXzNCpV15wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDnu98gp2qLm9FdXhyBjykJ1fzOonNBr6x6EBYYmIs+yfRmFe9Uy6CBlYruptovtK+LNbK6rzFcQGRbyLq8ldER8wCytFtgwegAY5Atwke1LuRXS+PS7tmG23FTXY+KFuCzpAzvJq2WvImsD6n2BFBzUixU18XMYWbmV01ta6SLOhQNphaH+XeHHKzOUrIrTz5rxpruBmsaIEds/k3FYGl9LcG1l09nytGx5bgYzUBGd4s3i22Y3Syln/+8TSXJYkkPnORNFIi+oFyoziZssGtadebQP1AE4MnK53hjZ0NH7ex6rdDo/xy8eKRnM1q5A2WZEDTOxIBKRYfDt5UBDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=D9vY0Z8ANfhSrbTYz+w5b0XlFfifuWa0WlkNES9IGVc=;
 b=MBerpiqYY5tYBFzELKjwq5SNlEhrgP3K9ikoo2nRP6slIbXlImeT28jc8+OI4JLS9RFMB0XEIvjxZ8JPF8HTolxJ/YOuqxlJR/0TCMmSEBWDDvVR7FIkw8qxFilI0AsVB332JfXrVi7WbOzELAxLSkY0V9AhWIcEiZBHHciAbAHlHxdjYF5DOKNirYwoybMN3THUq66CGsMUWWP7Ko9JvP1jBYINAi4TteRS+ggNDMjdRntHMuVtcsjGPXRgVaITGrdhcqU23KwlWmoYHWsovo25Mt7Hv9XIv1b/qzz226iijAwM4bOOkf4QviAr99fodbSokH2xyc9zzC/XgX+JVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB3299.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:15:01 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 16:15:01 +0000
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
Subject: [PATCH perf-tools-next v4 0/5] perf ftrace: Support inlined functions and display enhancements in function graph tracer
Date: Wed, 14 Oct 2026 12:14:52 -0400
Message-ID: <20261014161457.373253-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0034.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB3299:EE_
X-MS-Office365-Filtering-Correlation-Id: e52aba98-2f5f-4d0a-e852-08df2a0e4c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|261009223027099003|5023799004|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	59CsdQafy6t/5FWea5u7/d8STruKcI2Nid+ogrAHB3bIb8aLmfbtIi/nG0kJsqkUMv/WTn8657oRp4oHbUEyqs5PrDIrfW9wKfF4hIbocFxnP4nET+QweqbSZ2C4UrOoXmawVSskEmWC119BeJ0Vc/H5pR3OEquHylt9XgvfU5TC6XsAVVu2cxjPAQv5Qz9tvsGd1ctG9HaAcPrj0HCZXpfmcsXTuI2qHsS5qDUieb7tVp1KzNgpGtQE3tvmavuAzW13bH39SnS4ophEPwlKP/xF7YflGMNUz/wtVKyTinAK/L/kbhYALisMvlzIi60+Sye3ZUJovL3LZct1ywBsDfPEMqiuDOSUJa4RYF4AYqCHGblLEBNiy8/3ny+Yd3+EXXXAK4+t41TanlpMgML4lF3f+xOyTDsqnhOBw6MkL4GZFvj1xR1qF5VnpjrlZEUjjZP2Gju6SpMmi5A4FliKnVYG2QGjJJy4SlnkZKESh4WsAuesboLBLKqnzWaflHgREoJe0UG4yVEDgN2CpZD7XkxYbHpXJSbr7L0GoDE6fQVXVxquQ9tGA44AxUv5mVSaY1NJBrT3um8WBqvZFnBSgtdaBfzfyJU8IxAy9vAiDWL+PiLRMu2bzGBSdcKO3oE6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(261009223027099003)(5023799004)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/v/fNdZ4XS3yJ3SuTCXyUtuNBTOVJ42JLaMMw0QOgl70OMZMPolrWlmSJanJ?=
 =?us-ascii?Q?WoBeaXcT+uWPPgNS56w+9jWOFajXye1+g26WQFGzwBv6vv5VvtZ8bbL07Cif?=
 =?us-ascii?Q?slAVP43rVvG4RDqOKrWSD9LeR7TDYqEkXxjTFKuQCt5NDMTj5uVYO/04zzSL?=
 =?us-ascii?Q?DxwMALAKbsItAHP4VKdYue+Xmo96tT+o/itacdif7bz0trOb6sx3nvLfD/1Y?=
 =?us-ascii?Q?GHa0kMDtyuXvOQxOOJaN9boUYf+aaGDWnTjoZpCdmgEFL5bbHoPAXNYkHhZ7?=
 =?us-ascii?Q?YsnUKaI3jExzgC+rm1aeLbXYP5C+p8pHhGZd32hfKkQ35YjnTOgNA7ZN8ia/?=
 =?us-ascii?Q?vi+S6Pm6BlVPk+WnyQnhK9woJR2yXtRFqdTayOc8136WCIuGcAqh8Ylny13m?=
 =?us-ascii?Q?X7tYxla4Wvo4O/WsZSHP7K2yWdg10YDT1+WwNl6aE+8zlp2N+g5sYblPe3f4?=
 =?us-ascii?Q?MXF5MKeWP8VXaqLqes81bPoly5QVUIG66JQd+PxFpPqLo9j2tEhIS2C1/dt+?=
 =?us-ascii?Q?3WmQaOfP+uosHdUkeqR8+GUZujDySb+uDAcUQbZdztxglVKYOdwsQrwlydy/?=
 =?us-ascii?Q?PvBzU1sxSObUvqYAReLwUjZwYzbR1hGBMyXXCdWeqI5klYcpxUGZG40sMsYU?=
 =?us-ascii?Q?5gmsKNZvkiyxOz6hlpjTPNCjF2FauA8gMyZ9VlxVd/Tjg2KFHWvA27S4suye?=
 =?us-ascii?Q?lOkFCU3CJfdg2ItsW24lsiV2fSuplQdXXwmLFIrUZ4pgfXyOlI/Q+DWMMa89?=
 =?us-ascii?Q?uXLogbSyd57G4ICUEG004cHMrHXiOdgOJGCfybNI5D+NbqqsiHxtn8UQ4qnu?=
 =?us-ascii?Q?VJML/6ZPWe2uWoLJaabsNfa2BqM3+54A1/bR/1IKRQ5w10XmeEhuILG+kLAr?=
 =?us-ascii?Q?N3KGuluKIo8/N0AyiPfm27F8sK3x7Ck/j/i4IM/2A7NAesSfFjZXnoPn7JY6?=
 =?us-ascii?Q?mLM6dmuDA354QbTFgZxe4pKQ5Mo1mpc+qtDrgptZI7dDT0BEh9t7c1Zrfuir?=
 =?us-ascii?Q?CW3ySRP9R+K+UtHX8tt2+lj0WmdkySuU93VOdiA/2+MG9ykd2Dsl2gE5azbm?=
 =?us-ascii?Q?v1KDFTarJN9LMtESmH974ACUA2D25uFEI9m/391dky9SnJHByU40nXsbgi0+?=
 =?us-ascii?Q?XuYMQq40FsuDHynmF6E91XWqBh+Uq0cyQ0/q6oLY2XaZ6wMucxPZqpEmy+Ht?=
 =?us-ascii?Q?fTuo+gpOhtAP0MHvglDnJEnYR3s1DxXBMiKgx3RldF4JiROYKjqsBTXK/pAi?=
 =?us-ascii?Q?r40zoFLrVPJwGNKhzDmf78QDh8vYwo1jNvUKqb45S/mk1QGN+4Tyf8haBCjA?=
 =?us-ascii?Q?9t50g0M4yVTTEYG3CYhbzGIHuIXqWGX9q92UUQCnTHbrpmyig8UFixSa3DSl?=
 =?us-ascii?Q?KaY+MPHUj73q/K5eYU58zu/pq2K8mKLqDsvmhe7ADNRmsqvGeHExXA5h2+ep?=
 =?us-ascii?Q?EiKo85IjaH6J0BjMHybWomGlO/3O0V1BEGBTLSLxpCTT99L72Qxtimn2Agdh?=
 =?us-ascii?Q?Ie7C6Fhl7CKIgcDdV0vq4znRvIqX/HkFCkNfqKTNXoZd4fWWrLM3clEGm6FS?=
 =?us-ascii?Q?HVqftiEgRQb8JiTADnhRR8R9T5gbaKV+v7LQ5Y/xUm8HdV8uy7FpmYZG1gMC?=
 =?us-ascii?Q?gqwEkPiB+tgNoehmbUrcoTP/+lcm3hXS4dw1MqhHtIobO7VGlvc5VXSxsODf?=
 =?us-ascii?Q?MKKg7jiPC0/uB+5GZa0QVlGs3RG+H16XJ0gvCaxji7NUD/3GJxr/PWBW4vXb?=
 =?us-ascii?Q?Kt+xuKT7vw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52aba98-2f5f-4d0a-e852-08df2a0e4c7a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:15:01.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zuj/zha+WvTtgicKKPjwMudsVBbZfN3SuHwHCabN+HzqytIY3ljKJZtXiCaMx56YraZ+h8X4A7Cbsif4Ia4Xag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3299

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
 tools/perf/builtin-ftrace.c              | 143 +++-
 tools/perf/tests/Build                   |   1 +
 tools/perf/tests/builtin-test.c          |   1 +
 tools/perf/tests/ftrace.c                | 750 +++++++++++++++++++
 tools/perf/tests/tests.h                 |   1 +
 tools/perf/util/Build                    |   1 +
 tools/perf/util/ftrace.c                 | 887 +++++++++++++++++++++++
 tools/perf/util/ftrace.h                 |  17 +
 9 files changed, 1805 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

-- 
2.55.0

