Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655664;
	b=FIIgXLc/a1VQucp3BHmg4/OA28q7RkDGumOcaZk0p2k+BbmM+wzbyXoIvwsmub6rJlKM
	 n9ah+oq47Q6KMnPtyVZPDYYK4J+UMJgV3szkLsIGAMsyg71V4i5WjUI6T6IKguHTJywcw
	 yb59xYPtZcGUrSU/K/LZ1JZJin08jK6vZHULiZIIWwDDHxT7NI1U0fxrnM6cfbSuSIXCs
	 GLCLGr9EU19R3GwqD8TnPYsylBuXqo2xmowbqUKklHpxqc02jHR9N8QbOOYixwKzi3ZoH
	 FbmSlyX/HQtsfse56j/SerSCEj0wDQbeGPOIYDowevhWt3dAjfXi25vpoB6XR4pHmkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655664;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=P6nc5XOApSIaaqsxJTLiNjkhBgLaZJqpzDpfgBp6eWA=;
	b=mGiIz1vRBS6jZzrDh8/OjIHzGtwkAU/uuvcugyoRevq461L39db6oKUbpk+fALIO8Cqq
	 mhFPW8Hq5lO1CC70xL0e68UKIO3wXUT2IHGH0WdFgY3WXGvMrXT9PLzXfOSdmcqoiKsKt
	 GYq+Y7wrSqoTv8QGv5B5pawqs3dBxtQhqobjWI/cZkUXYj+rpDlRzyi753uVggYe4J56z
	 y2STpLyLBWIY9jS7uUeWaZoh76kJPA0Jym51kdQjzqsxXAq63DKngMjm3AaEYAe6BHmVH
	 BsEg9rd39uAUGRI8MDTSagKFYErHag4Wk/KUFTZjaSC4AaibJNwP8JnbaJMWfacdwkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.75
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021075.outbound.protection.outlook.com [52.101.95.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF3D606A326;
	Mon,  2 Nov 2026 21:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AF3D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR9nSsRqMqT5tJZxBOjhX4CbkmGutL/fkTZtN9g6+MLm0OO7KocoYT8juoMUe70+BjRZaCdgSKSYGRnYQtcnr3GUm6UUYK/W3wEWSvSf45XrHfdaC2YqqnzFaxbgu49zX8bMsIfa/095O1ni3NhtQn9S1CBCcL/POQeDQ/8EuBbMVYYiZ9nS0DBhY/gMXYrrHxeqmkRo+yDExoSFraaKeDIArmKqmvGab+U96dhSkUn76ndkEWxzhP4hxRl0NqzHKC7aFYHmwgzGxUJ3lzfwWLVfTI/AC8M0ys8YIELfZ33wtr3XFM8bRjWbhDoz1QIFoj4Uv+WsjTbNFyf/L2fNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=P6nc5XOApSIaaqsxJTLiNjkhBgLaZJqpzDpfgBp6eWA=;
 b=DcQMWxbvy8EK3LHMSakMNnirZWYiO+tPddThbVAMcKJk+cuKsr5VZkJEhmiCQobnPP5c0m+mF38iWKVxlFElODJp7PusDDgAqWVd9L3YbEmt5phySBz4vFOzCdyvAMdMOPSMOKN3YWZmUEm95aj4BTjfusJ2beeiAPgOVLB5kA7cx3xPubIRZ8cU+t5bJ5iBZL9HZOlLAY8wIhFz9IOo2e8gZORcY0ZFqBx2+/ivIU2Mxa0njJ1ndp6n8r60Jcwu+/cgb4o3Bzeb77NtpuUcjnGNAlewQdwA7Zclu7LPT9aeHeavHPvgnleCNeZ+rf6uzK4yPiADGOxZv+1D1i2IbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by CWXP123MB3814.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:4c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:40:59 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:40:58 +0000
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
	chjohnst@mail.com,
	neelx@suse.com,
	sean@ashe.io,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v13 00/10] perf ftrace: Support inlined functions and display enhancements in function graph tracer
Date: Mon,  2 Nov 2026 16:40:44 -0500
Message-ID: <20261102214054.911298-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LV3P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::28) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|CWXP123MB3814:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1cb195-c399-4528-8419-08df3929fb6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|3023799007|6133799003|10067099003|18002099003|261102123227099003|56012099006|5023799004|261021135927099003|261022115727099003|261022113327099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261102124527099003;
X-Microsoft-Antispam-Message-Info:
	w9xhwhVzJPDLK9pSETJVbpnQAU8h6GuFjI8Ddcqs0FZ3xRCqYboyNCIU8eUt/YNOB9xK/4m4PM94nd6OsK+wwhRK2fUAJl/oe5slugnPqPE1iYnnY1BAf48zayeaywguOlEMLGUjnDmfmedL9PNeDYjmcrVyciDfMNc8USJO4SjtnK+Yjj3EL3hRlVToer6rrw6bnZgBVtRyWmPdBPrJMXCxcCBnqN6CXt7ht/paijZ2st1yMk/UKqO/SsRXvirYQx0JYfAWcd5aak/Cup5iKkcoEM/Lu7NiTUi9LOwxItiuLlXYoKby8UTUitYU7fSNyTkElqKZHAMu1F37BEMfjqJF/Qab9syXMD5XLtUmUte03Tf8vGjQ1//qDOs9JwTLp3q907EWoIbaNDeMDeXRNIOMU5iR1c9q5MXxTiv7PkrzLiRx7DctG4L9LMT0gR4dcvTH4hAdbYrV5Bv/LPvR8d0hZeF9hgd8x9kTl8Wj0/0lHER2/8yJnym2hcXbY6wV66uuHX/NI91d+6ZdaSaDJQh8aseVaNLiInTkjRSSWIVLB5CCKsQGmGYYvS2VNPC4mw73qXyST1VtEbEe8OiDDVm+H8n+cB0KF/Hsx61HQ7yISbXGMJwSJlbA5yUbJ5nP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(10067099003)(18002099003)(261102123227099003)(56012099006)(5023799004)(261021135927099003)(261022115727099003)(261022113327099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102124527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fajpt0k5NN0rL1GTOiDM9PWsDLkqrIJLvHqofJgAOW1UpQhvQ2MWicWtfqpT?=
 =?us-ascii?Q?2BkwXtt7wVTQiHnQ8eaHLJQrqibMBvKCoApLZpqG781euTrW9SCD0J/7Amv/?=
 =?us-ascii?Q?gnQTprU0LntkdTA3nQERku5Y7l9CnShNmsnEiJaYM2UIQrxt8HOepZ1N4GZx?=
 =?us-ascii?Q?3utm9tzkojopEeARjcaok+URwrbFveCotzNQ/7iU1NL1bkPXy5gHhoLh3bjf?=
 =?us-ascii?Q?pttfIy6fjsWbPfEf0dzTVf38M2lTFkYRaxCVopV7o2+DL7Qwg/9kBp2qObgy?=
 =?us-ascii?Q?EQyx5pQ+cjlEiqqBkS9c8EZgFP52/MxBnth66OjCl1JKT2n2hED7+hk62ciI?=
 =?us-ascii?Q?xDikKTaPvhwf5iOYUvNSbGfbsDiNazvhCc9CQtoGlh1StICQykkgFgfg+iyn?=
 =?us-ascii?Q?ntEiSXjh4vjmkPYPDs8kB4YF8clnqgZ5pZpu0Xpp3q3A/zU05SUMMi+/9ee9?=
 =?us-ascii?Q?B8Dq/YptDWOv1rlik0HsGrlQaMq489PsNNrDs66VfgyX9dCSHqtfJerW2U9q?=
 =?us-ascii?Q?BtDMKZTkZsaW/x//GzvCjA9Ri6hr51mVVipOb7RRCF3KmMdR6NFKiyu0Zq4d?=
 =?us-ascii?Q?nnRgpG/gYpCEIUQm7IaHcXvHLiipj5CmmchigK6zauq4EYp3Qa8cMe1jr/yx?=
 =?us-ascii?Q?GMiaS74Cv1pjX8qDCccfH/di3Fb926RObPDWbM4Gi7Ic394t0uOPwRkzBekW?=
 =?us-ascii?Q?ZfxD2ifPBA/z89Cxq8U7BNoUMH9RLjmEAU0LNc3rz66BnmCzkXnzx+1ec+f9?=
 =?us-ascii?Q?JTYEHGWM9tUmQDGdiMNLkFhWXPtyOUPRHznXGUdjmzL1Ux+RJHspyynE9V40?=
 =?us-ascii?Q?uV2iudFcOdEYnFb1ss0+tWIE7LRPlA1whPkFCV/Qvjfz2fNuMrMlyhxBquck?=
 =?us-ascii?Q?t28GT9VkzS3YT361SQFpSDXjPAwO9QpGc0okKsQ1LG/yDSLdFkXfsrXmVvBn?=
 =?us-ascii?Q?znukGudtxZ4hoiIYR6rIW2Y4zl8GuJdHhHFyly2ItkhNkDxhmaCrakidEvFe?=
 =?us-ascii?Q?gjbNHVcrCKdu9LDJjApLOdfxEFZpcVXyPWdZrvVL1YP1fx4FRO+1kcG5NP4F?=
 =?us-ascii?Q?SKSBK1EuUENMTVeyqVzYp55/XiNQAu1T+1P7zqPU3nlTcxB9nl3l+p3klgj2?=
 =?us-ascii?Q?fV5a1nAE27Sg4uCe1i3LbWcQDWB3qrYMw6IYvFcnimKWOTbsab9NnUtIYibG?=
 =?us-ascii?Q?phycX/y59DSpedob0cvuR0pTYaAFaK0ecB1fYz5sswx2TWGw80VMPPjrsWLJ?=
 =?us-ascii?Q?T+hqoV4un0+i0q3oUYYHfXAOAcnOFcs8IpKzW/Ld+UAm+tbX5R9GI+BzLfTy?=
 =?us-ascii?Q?4I/ewBKKEvFUzVjeNq8lSMaBCxeoITYcuU1vCSw9lsT3fy2+ML9zsuXvKzSj?=
 =?us-ascii?Q?T31fRVMc8Jmpi1MPAKtQ/I7I5ZZbYeZps1v0xUO0FCgoQR6MfAOrUSbBlY0q?=
 =?us-ascii?Q?zVc9txXnbP0TrGYoMTXolOhUGINGoctJemQWuU0ORifGnpbdbXZ9mbcF6fZC?=
 =?us-ascii?Q?q7971MB7O3xGVHuLSEtuK1mOQPUoBaWVILK+oVY34bn1dlAevz0qHYll1Lgk?=
 =?us-ascii?Q?ZbJAj2FlSuq8Pl23p/OQvyps+QwCwBkYhuIWUOPP9JaXjyIcnf4ycD/PL0tt?=
 =?us-ascii?Q?Ik5MXU5Pn3mTOvRcskLy/Qp8bVE1ijLZRb/8eVWS54NVFDBWpZMw1P2r3s5w?=
 =?us-ascii?Q?YaOEzNWFolopSPx2PyvjTo5RXHC8r6D1vA99NI+sT7w5wfTHVnKHMEqo9KoZ?=
 =?us-ascii?Q?E7hAzBns7w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1cb195-c399-4528-8419-08df3929fb6a
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:40:58.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCgELV+xDhvkaFeOO5JcqeFrB/2fmesb6QfcpPtHZlT8dUkgX7wVRTiQGXwG1lD1yaDWfUlWvalHZKuxpB+WNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3814

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

This patch series addresses these challenges across ten commits covering
six key areas:

    1.  Signal handling and stack frame optimisation in __cmd_ftrace()

        Separates robust signal handling (EINTR), non-blocking read
        retries, and pager exit handling into a dedicated patch, and
        replaces the 4096-byte stack array in __cmd_ftrace() with
        dynamic heap allocation alongside struct strbuf streaming,
        reducing the stack frame footprint by over 96% (down to
        ~160 bytes) while ensuring complete line-delimited records.

    2.  Return address comment filtering

        Introduces ftrace_parse_retaddr() and ftrace_filter_retaddr()
        to automatically strip caller comments from trace output unless
        explicitly requested via --graph-opts retaddr, accompanied by
        a unit test suite in tools/perf/tests/ftrace.c.

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
        originating outside the target hierarchy. Dynamically resizes
        the synthetic call stack to eliminate saturation edge cases and
        accurately suppresses detached subtrees without orphan exit name
        collisions.

Synthesised inlined functions are rendered with an explicit /* (inline) */
annotation at both entry and exit:

    # tracer: function_graph
    #
    # CPU               FUNCTION CALLS
    # |                 |   |   |   |
     0) enqueue_entity() {
     0)   update_cfs_group() { /* (inline) */
     0)     calc_concur_shares() {
     0)       tg_cpus() {
     0)         cpuset_num_cpus() {
     0)           class_rcu_constructor() { /* (inline) */
     0)             rcu_read_lock() { /* (inline) */
     0)               __rcu_read_lock();
     0)             } /* rcu_read_lock (inline) */
     0)           } /* class_rcu_constructor (inline) */
     0)           cgroup_e_css();
     0)           class_rcu_destructor() { /* (inline) */
     0)             rcu_read_unlock() { /* (inline) */
     0)               __rcu_read_unlock();
     0)             } /* rcu_read_unlock (inline) */
     0)           } /* class_rcu_destructor (inline) */
     0)         }
     0)       }
     0)       __calc_smp_shares();
     0)     reweight_entity();
     0)   } /* update_cfs_group (inline) */
     0) }

Changes since v12:

 - Moved internal stack-tracking structures and macros (struct
   ftrace_stack_frame, struct ftrace_task_state, FTRACE_MAX_CPUS,
   FTRACE_MAX_STACK, FTRACE_PID_HASH_BITS, FTRACE_PID_HASH_SIZE,
   FTRACE_IDLE_PID, and FTRACE_UNKNOWN_PID) from tools/perf/util/ftrace.h
   into tools/perf/util/ftrace.c, and moved the find_func_column()
   kernel-doc comment to the commit that introduced the function
   (Namhyung Kim)

 - Renamed struct ftrace_task_state variables from cs to ts across
   tools/perf/util/ftrace.c for consistency (Namhyung Kim)

 - Simplified indentation watermark tracking in struct ftrace_task_state by
   replacing the dynamically allocated indent_log array and binary search
   with a scalar (min_raw_indent, min_indent_seq) pair (Namhyung Kim)

 - Simplified ftrace_task_state__prune_stack() and
   ftrace_task_state__rekey() by using zfree(&frame->name), returning early
   when !existing, and removing the redundant ftrace_cpu_tasks[] scan
   during rekeying (Namhyung Kim)

 - Simplified ftrace_resolve_inlines() by inverting the symbol check
   condition to reduce indentation and storing ilist->symbol->name pointers
   directly in inlined_names[] without duplicating or freeing each string
   (Namhyung Kim)

 - Unified indent and raw_indent into a single indent field on struct
   ftrace_stack_frame and removed inlined_depth from struct
   ftrace_task_state, computing active inline depth via
   ftrace_task_state__inlined_depth() when needed (Namhyung Kim)

 - Added Namhyung Kim's "Acked-by:" tag to patch 01/10

 - Link to v12: https://lore.kernel.org/lkml/20261026025735.546101-1-atomlin@atomlin.com/

Changes since v11:

 - Replaced the single unsequenced min_raw_indent scalar with a monotonic
   suffix-minima array of (seq, raw_indent) watermarks so shallow exit
   watermarks are not lost on subsequent function entries or falsely
   applied to frames pushed after an earlier shallow exit

 - Pruned each stack per-frame against subsequent watermarks on the other
   state and performed a 2-way sequence-ordered merge of surviving frames
   and watermarks in ftrace_task_state__rekey() to handle non-contiguous
   unknown-PID execution across multi-hop CPU migrations

 - Tracked orphan subtree base indentation and event sequence numbers
   (orphan_base_indent and orphan_seq) in struct ftrace_task_state:
    - Recovered cleanly when an orphan exit event is dropped inside a
      nested child of the target root by clearing orphan_depth when an
      exit matches or is shallower than orphan_base_indent, or when an
      entry at or shallower than orphan_base_indent descends directly from
      an active frame on the tracked stack
    - Pruned stale orphan_depth across CPU migrations in
      ftrace_task_state__prune_stack() using subsequent watermarks on the
      peer state and preserved orphan tracking state across
      ftrace_task_state__rekey()
    - Avoided recording indentation watermarks on detached orphan entries
      so suppressed orphan calls do not prematurely prune active frames

 - Buffered interrupt entry markers ("==========>") in pending_irq_ent
   while inside a target callgraph and suppressed the corresponding
   "<==========" return marker (suppress_irq_ret) when the interrupt
   handler is filtered out as a detached orphan, preventing empty IRQ
   marker pairs from leaking into filtered output, and updated
   parse_graph_cpu() to bind the active task state from the comm-pid
   column in verbose mode

 - Unwound stale non-target ancestor frames with raw_indent >=
   leading_spaces (and any trailing inlined frames) when an unmatched
   exit (match_idx < 0) occurs outside or resets the target filter state

 - Expanded unit tests in tools/perf/tests/ftrace.c
   (test_graph_target_filter()) to ensure deterministic synthetic inline
   fallback and cover dropped orphan exits inside nested target children,
   orphan_depth pruning across task rekeying, IRQ marker suppression
   around orphan interrupt handlers, and stale ancestor unwinding on
   unmatched exits

 - Link to v11: https://lore.kernel.org/lkml/20261025181125.514372-1-atomlin@atomlin.com/

Changes since v10:

 - Removed duplicated member fields members seq and min_raw_indent from
   struct ftrace_task_state

 - Fixed call stack misordering and active frame pruning during CPU
   migration in ftrace_task_state__rekey():
    - Tracked monotonic event sequence numbers (seq) on each synthetic
      stack frame
    - Replaced whole-state older/newer classification with a
      split-and-splice
      merge, partitioning existing->stack at the splice boundary where
      frames postdate ts, pruning only pre-ts exited ancestor frames from
      existing, and splicing ts->stack directly between ancestor and
      descendant frames via memmove()
    - Prevented active intermediate frames entered on unbannered CPUs from
      being pruned and prevented exited ancestor frames from remaining on
      the stack when a task migrates and returns before a banner is emitted
    - Added unit test scenario in tools/perf/tests/ftrace.c validating
      migration across unbannered CPUs and delayed context-switch rekeying

 - Added tags "Tested-by:" and "Reviewed-by:" (Ian Rogers)

 - Link to v10: https://lore.kernel.org/all/20261024212549.450634-1-atomlin@atomlin.com/

Changes since v9:

 - Reorganised the patch series from 6 to 10 commits following review
   feedback:
    - Split error handling (signals on EINTR, non-blocking read retries,
      and pager/pipe exits) out of the strbuf streaming commit into a
      dedicated preparatory commit ("perf ftrace: Handle signals,
      non-blocking reads and pager exits in __cmd_ftrace()")
      (Namhyung Kim)
    - Decomposed the monolithic inlined functions commit into four
      focused, bisectable commits covering basic task stack management,
      context-switch tracking, inlined function display, and automated
      unit tests (Namhyung Kim)

 - Removed the standalone --filter-retaddr command-line option and
   --graph-opts filter-retaddr flag; return address comments are now
   automatically stripped from function graph output unless explicitly
   requested via --graph-opts retaddr (Namhyung Kim)

 - Link to v9: https://lore.kernel.org/lkml/20261021023337.809936-1-atomlin@atomlin.com/

Changes since v8:

 - Preserved funcgraph-retval return value comments when filtering
   funcgraph-retaddr comments (/* <-caller ret=0x0 */ ->
   /* ret=0x0 */) in ftrace_filter_retaddr()

 - Enhanced vmlinux_path__find() helper in tools/perf/util/symbol.c:
    - Avoided redundant memory allocation in vmlinux_path__init() when
      vmlinux_path is already initialised
    - Ensured symbol configuration is initialised via symbol__init() prior
      to path resolution
    - Guaranteed vmlinux_path memory cleanup by invoking
      vmlinux_path__exit() unconditionally in symbol__exit()

 - Tracked raw (pre-inline-expansion) indentation on synthetic stack
   frames, ensuring bare closing braces ("}") are accurately matched
   against corresponding non-inlined frames without indentation
   distortion

 - Unwound stale frames on untracked caller entries (caller_idx < 0) whose
   raw indentation is greater than or equal to the new entry, and closed
   trailing open inlined frames resulting from dropped exit events

 - Pre-bound single-PID tracing across all CPUs in
   perf_ftrace__setup_inlines(), ensuring consistent synthetic call stack
   tracking across CPU migration when kernel context-switch banners are
   suppressed (verif_pid prev_pid == -1)

 - Strengthened error handling during DWARF/vmlinux initialisation in
   perf_ftrace__setup_inlines(), checking load return codes, emitting
   diagnostic warnings, and safely freeing ftrace->machine on failure

 - Recognised interrupt/IRQ entry and exit markers ("=====>" and "<=====")
   alongside context-switch markers under --graph-opts noduration,
   preventing non-function lines from corrupting function column detection
   or popping active stack frames

 - Handled leaf function lines with trailing comments
   (e.g. funcgraph-retaddr or funcgraph-retval comments) in
   parse_func_duration() for 'perf ftrace profile', ensuring parentheses
   are stripped cleanly and leaf records match non-leaf entries in duration
   tracking

 - Preserved tracked ancestor frames on cs->stack across dropped target
   root exits by verifying caller provenance
   (caller_idx < cs->target_root_depth) before checking indentation bounds
   in ftrace_check_target_caller()

 - Purged stale non-target frames below target root upon target root entry
   when caller_idx < 0, preventing unrelated ancestor frames from
   prematurely terminating subsequent target calls

 - Prevented cs->orphan_depth lockouts when both an orphan exit and
   enclosing target root exit are dropped by resetting cs->orphan_depth on
   any line at or outside target root indentation
   (leading_spaces <= cs->target_root_indent), and allowing ancestor exits
   to fall through to match frames on cs->stack

 - Preserved interrupt/IRQ markers inside active target callgraphs while
   suppressing those outside target filters under -G or --graph-funcs

 - Fixed test_stack_saturation() to avoid premature frame unwinding,
   ensuring depth clamping and recovery are tested as intended

 - Expanded automated test coverage in tools/perf/tests/ftrace.c:
    - Added test_context_switch_handling() for CPU migration and task
      tracking
    - Added test_column_layouts() covering standard, verbose, and
      noduration formats including IRQ and context-switch markers
    - Added regression tests in test_graph_target_filter() covering double
      dropped exits, ancestor frame preservation, leaf duration parsing,
      and deep orphan recovery

 - Link to v8: https://lore.kernel.org/lkml/20261018023753.584873-1-atomlin@atomlin.com/

Changes since v7:

 - Rebased onto latest perf-tools-next/perf-tools-next (commit 1c90f0a3c8a1
   ("perf kvm: Cast tv_usec to long to fix build on MIPS 32-bits"))

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

Aaron Tomlin (10):
  perf ftrace: Handle signals, non-blocking reads and pager exits in
    __cmd_ftrace()
  perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
  perf ftrace: Support filtering return address comments
  perf ftrace: Add basic task call stack management
  perf ftrace: Support context switch tracking in function graph tracer
  perf ftrace: Support display of inlined functions in function graph
    tracer
  perf symbol: Introduce vmlinux_path__find() helper
  perf test: Add test for ftrace inline and task stack tracking
  perf ftrace: Support omitting execution duration in function graph
    tracer
  perf ftrace: Filter extraneous functions in function graph tracer

 tools/perf/Documentation/perf-ftrace.txt |   14 +
 tools/perf/builtin-ftrace.c              |  202 +-
 tools/perf/tests/Build                   |    1 +
 tools/perf/tests/builtin-test.c          |    1 +
 tools/perf/tests/ftrace.c                | 3975 ++++++++++++++++++++++
 tools/perf/tests/tests.h                 |    1 +
 tools/perf/util/Build                    |    1 +
 tools/perf/util/ftrace.c                 | 1956 +++++++++++
 tools/perf/util/ftrace.h                 |   28 +
 tools/perf/util/symbol.c                 |   38 +-
 tools/perf/util/symbol.h                 |    2 +
 11 files changed, 6190 insertions(+), 29 deletions(-)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

-- 
2.55.0

