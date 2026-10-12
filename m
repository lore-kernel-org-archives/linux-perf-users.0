Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020142.outbound.protection.outlook.com [52.101.196.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72E35950;
	Mon, 12 Oct 2026 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765026; cv=fail; b=Fh1mZchpi7AH/cEP2ePmhrSPtez7E45hfMWdoJxuLnVd0Fx3aWmUjpxESBAf1WVYW7aK7jlq6Uzgo1ByDXpF3jB0dh9nctg1LiOY9QA3742LmawgO1zgHwX1x/Xll7E9kc4RTAI6kfvRSpyhfb7SsdwuQt04tmNcqQdZ1Zp9qNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765026; c=relaxed/simple;
	bh=jzr0aRklY7vbLl0Vlmyuk3WBJ0VEQ2XWHbF6JT5LHXk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H2bQ+Cp4zunCOBzL6xkV0qeotiUz8J/x9ujmuLVRLjGquD2su7n9nNrydJLCRpgsvO6wQxb9gYWwUrFekN6juHwbd/HJ3CB5WWcNQ9/A6ZQi5chRsIm7OfJyTa9i2XX1vL7FifzlbyI4UzjX10w3aM2Lmm3TW2+Zp2xwa4KoYvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbDrHlWv8SYEZJ9erxPKMwxGU3f6dBpeFoBwjlwnwht/GxN3RnbjalqP2Ulwb3fviOPlI/D09nWFiRIbqqi0qLkZA8mLYo9aKLM7WGWuZ34Ww35/TEqHVBDiRyLsAU4KgPTrQTrSGPDIt/Db92TQn/D1geXz1RKsphXWPxewwFCoNmQmdP792tPRyge4GT5ve49SFCC0afZrRymUr0bUsxukJak9sDCI6jC7vbzC2l8+EB7EYN6+YVZaRuWm8Uqu0nTltgmoAg6VK21oUbt9FSgbBggps+MF3f7BGlbm9vV41YLwrYgxnvN68dlM9ODjwAt1nf6bzSC0OLrgHEPY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=usWmOtpGBv3RmfE2SGQ5VyEp8QhsOnQQsS0WRC/ZxxA=;
 b=c2h38POdHHwi2MVmaR/yebe1NHf/3z9nRc7wa7UKqRkkpKUVVgHOruepBczb+cu/PG3XU+R0qBNbtECHPtIBCNRuuV4Oeudu0AlZRgGmaK2OY9lI7oiai8Gwq1moAL8ah/UCY4HaJ/+szHRQdyOpnk87QNd58Syq3TXWUdl+arhTHNvN6NsXqk1u5uL8HXMm9ZJaHut592uQmTYzLMEwO6+FYKmjcZy5PR963ND2EPsGuG2tC+VbYenkY9E9T7CXfBCZzqCvUJ74Ka76b6fUAq5tNcYRcJZze/FbBBshPRXOftrLUkbklRz+ackz7BV0PBEaQwz2dRCgSoK0Aou4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOVP123MB8542.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 00:30:21 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 00:30:20 +0000
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
Subject: [PATCH perf-tools-next v3 0/5] perf ftrace: Support inlined functions and display enhancements in function graph tracer
Date: Sun, 11 Oct 2026 20:30:10 -0400
Message-ID: <20261012003016.263063-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:408:f6::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOVP123MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: d718b03f-4175-447c-a21b-08df27f7ff38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|18002099003|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	f3pAexWTI9xk7To9AfJoYJtLwm/wpf6IGW9LZd5PV4lFx+9ATYhwnn2WDa/nOGAfNf5HOXj5u4Z4fR+NyGCorGklhBBui2+KILSCwvnQyLSjGdbUffpTogeIpmDTGqtq9GIKaw3ii5VWKMQB3gZ6QG8kbfstzUA1VH/xY9U93RNiCADds2+/xECv1cdIbTolAQr1/l04RjY/Ecv0ixNQ/PU1Llg19iLlYdeNA5luT07/b46ZMH2BH8w6T7Bp7HKaXjEEDCC20DB45MlySRdMUBePGV6uwXF1fHWYzwozTIMBeHafF1M5r3cnoppe6D7GDpBpiyioFqPawF5VSH9oDdhq8geEHK3n2RfCBSWSVWtbOHk5UcmLBW28ifOJk7tIkKa58xLrIAGxICC24913epUzvcNxhHplWqHOtyqAJ+vg+1tX18Zt85JUXdafbW7kBHklS4FvEal7TvFVjSFKgV6jt1k1JnH1CcqyW5ih9SIwhL44mA7Vo/xvtGl5dIQOFvfsT0Ajh+d4CiEUjj8hJlksjiSiA5s/cXTVF7Ot/fWCedVEd+pN6Wwv2Rd/WsmSWT2rK0mlHAYl7iEK5L61F+zDQhvBfNl3r3wk+Bfym1+dz8cuQAZvfRrixcLYR1tFlunJwleJ3gONc7KQrc8B6su4rtOCKcew5odTIelBj5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(3023799007)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DoERi86wVCMCUGF6uMN/XKQb9mpRhclY1TilB70A9mg8OeeVO3uJxtJnR0Fn?=
 =?us-ascii?Q?9gfEqnBV6OSPneMsrz/iDz5eC2ILRmzWtDsIH1Fj4OP8dCG1zh3UnyLvWXtA?=
 =?us-ascii?Q?VfJWecedjUqB5l5I0xgMsgYY/IfLjAWTwfNLNJ++nS3bzF3qas2e0DdWEpEm?=
 =?us-ascii?Q?n0xw1o5tl9rvTdhgal/w26Njrabs/MDFaTpPdM/VS3YCHwuRl22OfSYCcs5T?=
 =?us-ascii?Q?JGMbqT7Xce6P+R6oL4WRIHQ+S4ineemQ7COePqGU51aFGa2Xjo86Tf+IIXoQ?=
 =?us-ascii?Q?P9D1MzW2P6xNbC1TwvCs0ul6YGyjTBisIrFNcxNX+c5umAQRUL2+kgfasIdq?=
 =?us-ascii?Q?qC8FREbnWzM1dTZvhEGz8tL33ZLTx//eXzPzTFWIDyLZOt/LFpV15xAGHT/3?=
 =?us-ascii?Q?BtlYbUmNk4gQn0atOt3v08tx0zNeI23CLpH6RqZvLtF1SoehC7BsVBqs2IlK?=
 =?us-ascii?Q?jO01H2QQoivt1KJADYkB+kY8BJn7Xor+fciJiCsMy+I5ZGl8rWLkHrILsw87?=
 =?us-ascii?Q?wHMjcWgktDHtOVxuyUnmtn21dsKPqvgLGRtecB/uDgSd2PWqAu5jtjCXgJAs?=
 =?us-ascii?Q?eo0Z199MBxtaxgv1J2B+IZmYOrWV7glkflP2TBr7ye0EwKOTqeS06Fv3lEu3?=
 =?us-ascii?Q?ywRpowkWF/RViJ147fa8oZAMb9NE9myJ4LzSKyoLSfcKHNXPfDJPRtCOHXDG?=
 =?us-ascii?Q?lZ07YyEd/lVPrRVgzjSMc1YKCSZ8cPDHp7XJ+NrvxTex5kFekSGjRdJpVjqb?=
 =?us-ascii?Q?Wl/4xZgWMFKChqAMN3hXpH5U3t6ZITcUGzSdKAs47lDD57CQLkhRNcMYMtTH?=
 =?us-ascii?Q?4w00RfOBiysVCvDhsZQeb/E6nKBQFCgSY4YTGtw5qATosH8fjKJTy69DBWEs?=
 =?us-ascii?Q?ATq3fHul5tc4gU0itA02VwOGNqLYJKvr6dXEfw88wJahXP73A1wak99QHatL?=
 =?us-ascii?Q?fOXl68pw7H8oD9VKUNFqRzQ7zDWboPg0hGymdtOkVMW5meYQD+bUGXC6TIQk?=
 =?us-ascii?Q?3pDpb2EaV/neuBHXY37NqdlY1N/ykCSWdBhMcUSAROadC7e+gv3b9eDEcR9g?=
 =?us-ascii?Q?RP0b8lc5ZjTYP1FtHKGvReNwpM9AqU4QzXQIzjTqVxkMEkpjzdvI4hJnN3y6?=
 =?us-ascii?Q?VqrBsqpTN2C8RGlFG5EsBXsz2MDD4SY7zksn0Xq20Blp7TpDcqSeEyUZnA1o?=
 =?us-ascii?Q?/YGG+mLaYrYS0RTinsgrebQXrIDpdJaxJ0q9MqYg1izkjhrQtzbqAXtjDODx?=
 =?us-ascii?Q?Mc8e1LAt1pMz8lW/+Ogtso0iCIyFzDyRq1j6JANRT0k75daKFSNLJ5I1GlXF?=
 =?us-ascii?Q?gk+DZOtlx2ZTsZK7ifg8ikabbxyQjk02au7wrp7yL8jDYLz6GOgsw6CPxViw?=
 =?us-ascii?Q?/MSq+0JzKDvoO6j056pl87FRrwA645qcZ4uqF9scUoaAO+ijGk5Cjd9qSB7Q?=
 =?us-ascii?Q?ZfWcOMdQ2MTN+HD2dusc8yq99/LcFWpzy0IIml3/SN0+ijWxf/d+U4c7IXfd?=
 =?us-ascii?Q?5eQVd7DVP5sOzYv2Bg7L78FOvjB9tzzua9SCBsoThES3Mi133lgw8yKLNJwy?=
 =?us-ascii?Q?0LWsh/bPwc87BMNFQ/ZJg4Lgqg3xRa/XxMl2hgiq9sU/hl8kmDraaZuBMoQ6?=
 =?us-ascii?Q?ckMWr78BVydSsIbn2RTeLP48odoOTKLm6ZfBVEyRIdcgUOh7KfDNx8zcZM7B?=
 =?us-ascii?Q?+ASaLurD/iCYwSwTKZey4PN+Z+tz0yEZAnN0/nHSNp0W5a7eUMhFCu0wdhJG?=
 =?us-ascii?Q?51fQjwsEGg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d718b03f-4175-447c-a21b-08df27f7ff38
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 00:30:20.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjTaCUQPJGMo2vwU06F9PsG7emYDgZh3gKcWHMdN3p9cM/BgkGx50PU/orBy6KiVVBpf8MW7Jlz+r+Bzqxz30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP123MB8542

The Linux kernel's function graph tracer operates at the machine
instruction level via compiler instrumentation
(-fpatchable-function-entry), recording entry and return events for
physical function calls. Consequently, functions inlined by the compiler
are invisible in the resulting call-graph, as no discrete call or return
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
intermediate inlined frames directly into the streamed call-graph.

This patch series addresses these challenges through five focused commits:

    1.  Stack frame optimisation in __cmd_ftrace()

        Replaces the 4096-byte stack array in __cmd_ftrace() with dynamic
        heap allocation alongside struct strbuf streaming, reducing the
        stack frame footprint by over 96% (down to ~160 bytes) while
        ensuring complete line-delimited records and robust EOF handling.

    2.  Return address comment filtering

        Introduces --filter-retaddr to strip trailing /* <-caller+offset */
        comments in-place across diverse tracer formats (standard,
        bracketed, and return values).

    3.  Display of inlined functions in function graph tracer

        Introduces the --inline option for function_graph tracing.
        Leverages CONFIG_FUNCTION_GRAPH_RETADDR comments and DWARF debug
        info from vmlinux (via libdw) to resolve callers to their inlined
        callchains. Maintains a per-CPU tracking stack to reconstruct and
        synthesise inlined scopes (/* (inline) */) with correct indentation
        and bare closing brace matching.

    4.  Execution duration suppression

        Exposes the noduration sub-option under --graph-opts to omit the
        duration column, enabling concise topological views

    5.  Filter extraneous functions in function graph tracer

        Enforces strict target callgraph boundaries in userspace.
        Suppresses non-matching top-level entries, and dynamically
        validates child entries against the target call stack using their
        return addresses to eliminate detached tracer wakeup side effects.

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

 tools/perf/Documentation/perf-ftrace.txt |  21 +-
 tools/perf/builtin-ftrace.c              | 128 +++-
 tools/perf/tests/Build                   |   1 +
 tools/perf/tests/builtin-test.c          |   1 +
 tools/perf/tests/ftrace.c                | 589 +++++++++++++++
 tools/perf/tests/tests.h                 |   1 +
 tools/perf/util/Build                    |   1 +
 tools/perf/util/ftrace.c                 | 871 +++++++++++++++++++++++
 tools/perf/util/ftrace.h                 |  17 +
 9 files changed, 1615 insertions(+), 15 deletions(-)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

-- 
2.55.0

