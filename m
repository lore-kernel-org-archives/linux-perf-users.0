Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.129
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792951895;
	b=UJBsg8SIk0AdHVHtlcKYLQgOV2/3DV7L7TiAJQeB2gss6qwDFNBfZUCjAN3S2D0c1I4L
	 rObU4gZOX42DcbaIWtqhNIuiMDDV7Wi5HOPqYoa00vo7VibqUpqkVtrmc8L743y5s12uY
	 /5LWIGj/uvGwZrZwZdd5kOAt27HfEprp3u4UaBPQRQcpXlNp9lgeeHUC27UzsueT47MMq
	 JzMWEHwqxbFjGkyzOFWxOfblZBIiGNa5x6kEF/9qlEGpbYsOJfxgNNtp0zDKO1mqKr7yw
	 Rleux2dtw2Mv7on+kqzho6tiJM8iy3JVM5rHJr/+HnzrJDAxjs9wCjDpOwA9EBWyqhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951895;
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
	bh=o5xOWDzsNNFT2rY8UCtEKpdisx2lWRqH1s3S9XpSgwM=;
	b=osnbv4/wsuvIRQQ+DZxxRcp35j1r3kevxY+JZqiVL5f+mGbTKWPyMlueW6/HD3nA4k8x
	 LDQigY1rGeCkNIFOtv04/HHh1fW12liyGIxJR+4E4I+MSVITxbqm24w3v/Aljlx2ZLCRk
	 WibrHlrcJz+ktVV0RW3C2Zw2ouNihixiWyj6X0PSJogKb/eZBjb58RtSNmXqXlHqh9lZg
	 lFACcV/TiFPk2tq2vKg8JOMM7+daG04PnBhb9Trr9vAiOEN4Hf/CcdLoOr9MiOHTaHQv+
	 b0I2GcfeTzwkVPUS/2fDmIlDg7sBy/sNWfWyjvbwckt1jXZEjWnbrjKJVklng1NhjRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.129
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020129.outbound.protection.outlook.com [52.101.196.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8B606A327;
	Sun, 25 Oct 2026 18:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DB8B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8cEA4kMBD5zFzGcdVHB5trh6qNkTGLF4MCFzBnNBd3asTBxHh10d8wjVR7XB0kTJkYet5LYpZhW7+V1qtbPdI17KflylJNhn83ahp+/0uU47DmAOzpFLzcuVKcNYegBQsnnFPnsLPoqE9Zk0cOUHPRtb5w+wSKtZH8igspmhK2y+dpjJHwTHXf/89STqBeXS1ZQqZ0o5iALy4BD/+uRRd6l1QtObzWj0uTt4oM6Ble68ZwH3yo/McbyVWLzS6fGE3Ad7fWmKFTIj+t2u7wuubUNE2YDZIZUE8Kj+72jAea2fTmVjiD+Gxy/GSy2jFLsEsEIeHfQF11eVc0eFe6rnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=o5xOWDzsNNFT2rY8UCtEKpdisx2lWRqH1s3S9XpSgwM=;
 b=OXEHz/laI7nJfAboAsQBa/r5jMFksUl+pXdWC+yXJJYpMHNXj+dsKK5bpdldDj7cBHK8nNvPgFBqSGiToIWEd/Iyuf+TzH0cNHzFNxCILRNFrphAtyN71UufE5FCck8fSLVNzh/wk5boGWDNKTxWneKQozSGu3qdnbKXcEjvogBJ7i1GxYl+HroGcX1Z9DmFSsA2c5hMtlX633F3jayk38KllvuDynIeWmluIy1pnV+9aiBxCAOS5wXb5RBbY0u6aL43CpNVMVuRTTVQ9Lccy/A5Dlj121nVDENIYFxjxyaw8N23SghDOxZz/6dJR5z2AVlLsoS5r3LE4G+jTsulgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6815.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:30e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 18:11:29 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 18:11:29 +0000
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
Subject: [PATCH perf-tools-next v11 00/10] perf ftrace: Support inlined functions and display enhancements in function graph tracer
Date: Sun, 25 Oct 2026 14:11:15 -0400
Message-ID: <20261025181125.514372-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 370a4e0e-a39a-4ed4-2399-08df32c3645b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|5023799004|56012099006|261022105027099003|261021135927099003|261022115727099003|261022113327099003|261022075727099003|261009223027099003|261021123027099003|261021121427099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	sbqnLBReZaoet2VuHdyoEOUWlnwnsc59PFyKTE+PnGWfcvKUYN5UFt3PlSV8v12NQsglIYHY6b+oQj1oL4QCPAlF7agboKm9KSM+lDIegRyTvebEaZYIH2Eruef1rvC4HY4clX9gB+o5mp07367Y6cmQsMqnSodXg51mdphUoscZsBLPN4kq8nmuFtOOj9s59FnOU3nCrTczOAi7Ztd0SLpe8TWyW+hLu+fEyJLIuEWiddRJ6iHjL82UOENGVR2kIGdH74PTRxMtXOFB/9zgQxqyvt1TLtxvqGiiCcstNqg7FbJLzT3jt41s1VaNIIoMwajiPjZekc4TD7f/yeB5zZmTcoF7xGeJf+3QmC6JnXevuNmxcwvihQOwz1zXzjms+79SfqxHL3BufD+1O3i6hHptG/SaPnxeuK+hAbg9lOauLpzjhwPzzAi5/kSyDQ2GcMRHgCYZtm4IZgqjDPeyTvgWcSYOj/ymTlVtrXUP6sz2JK87YZSwI9FwyoTSG2FjQkCotEnkNACL7yh4jQ34wwgfZGxrz9mL3YfA7cg1s0Q2RNOU+RtynaAvDZNHKq0oOlufh5so4prmfOxzKkE01JkTpflD3+gn8SQDv6RKTajMlWbihmXFg7leNdE1Z9GL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(5023799004)(56012099006)(261022105027099003)(261021135927099003)(261022115727099003)(261022113327099003)(261022075727099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZfYKhcJhHq+BzX9EuxvcCfsrwjGxpfc5c8t9Ypa5PhWSAT25P3FomBj5+GW1?=
 =?us-ascii?Q?nhbn4vzfi4gVkIunlqHUuaPb4qHAONVOac9GLGAaInekuH+CtQHSe+tfuzqK?=
 =?us-ascii?Q?cJLK32QHkjiEtr+GARuP7ajgd5HvQd07xtUy6CLQk65gvPYtt52xqW5QCgxW?=
 =?us-ascii?Q?ITiaEeN0bJO1ghrPoNL5jRk4xlKwhLZH3F3oftz0PHRqilf6FHUQE4wvzjR4?=
 =?us-ascii?Q?+kSytX6yxrxJViesvtOSzIdKAHCj1WVClxREqfh7CDwuu3fVf9sDNKLELqug?=
 =?us-ascii?Q?+Pn+XsOdoZQjwsWzujtRjjtgu6tz2srkryWqjDkZNDIlnuKC7C0vkzr4GscD?=
 =?us-ascii?Q?Khw75UxIqarnxkzFsbm3pVDgjY4ZH7fJCfnNsHHNlmhhY2QbiDm5nhQfPYbR?=
 =?us-ascii?Q?7xklth5GNqBK2f0l1opRP4OgSN23MR56TK8rAfB2YxVnmQOxMO6GZuiB6OU+?=
 =?us-ascii?Q?z8dkEIMiQ9fmQlJM4uCcltCDNSk5mTm31Qtn5XHCdW+onjwgJH0GFnQGrToo?=
 =?us-ascii?Q?h7FzyakG2sKPCS6Iellh9CNX/6W+TDwtG3DuKgVpzniAVwDuR1jFHOSYfOlZ?=
 =?us-ascii?Q?tteuJj/W8Pom16YbHVGFMn0uD4jQUkQh7dUOPHOEU0pGVxktiV0nB0FmNU/g?=
 =?us-ascii?Q?9cA2ih4fuRG1yzXGVVwiFap3nmaAdDZFN7+CE7unFbtiRaM/fy3zW4TK+2eg?=
 =?us-ascii?Q?vaGbggrW9K6DxlTtvseDJCjajkFu9W3CiJaSbT6fWuop+oxdR7574l5X0lhK?=
 =?us-ascii?Q?DtYHO1nhO9Qu8EcVi292RWlWjeDc2h9dvrCJoKhs0AoD8LcLxM2lQ1eyO83P?=
 =?us-ascii?Q?A8P0xubEEwSZhckXVtiC7VpE92FidTVgPFY+PkZ94+GR8TNnhSS3bsxxx2+X?=
 =?us-ascii?Q?jzhfdie7Bj48WJAWf8hOCTln0YWRGvkJF6lbYRBuI4eB+I4t4AJMlqeNn/wP?=
 =?us-ascii?Q?NgYMRQbLULb8ByGXiOejwQMTVyRDHqZS2iYGZwN/vELaRmtMe+pX5MnOwM8G?=
 =?us-ascii?Q?XCkaNfUq+MKZGN/O91hOYQhWFMj3r54onYo5yyW4kgLTgrhoI1pY6C8Y//8f?=
 =?us-ascii?Q?fnEWCL//te8CGFoxau9rgKccz/0U1YoR4nbHj8wX1EuiJ+o0G5keNFBBMZSt?=
 =?us-ascii?Q?qif/k0/1o9tXE1lj0AxstMVgpki7kxyZhNgJ+O3Dat+sZIV/lqYiehkFaUG+?=
 =?us-ascii?Q?cGE6vzgbvKy97+WWic/nuHFBYW6Aj7iA/cFG6xAB7BPmVBEWMs1tg0owiu5Y?=
 =?us-ascii?Q?VeKo6lsPWTa9P6Qpt7Bi8FpKPM78Mob331S+xmsLuAQDN0CB8/vXrtFJF7R4?=
 =?us-ascii?Q?nmz+9GfRF+Y+ln2QmGdhiuA7CD7q68KOdNCcrOEEACG1U10BEZJNvUHuhWRl?=
 =?us-ascii?Q?H0sOv0jKcm3Sh/es6UXwDXKiM1pLbnKfvX/gefObmCH43E4KNX5sA25DcMeD?=
 =?us-ascii?Q?Ayi19hdkN0NT+AmZM9ieUbgKDB6xAiJ5SqWe4YF/NaTHNDiuZFkK44h0Vwcp?=
 =?us-ascii?Q?5OoxtipbqTV9i7TCCQIxUObShRmE2F3CjwrxR4/vjgOpoLuMpUH673f+Jz05?=
 =?us-ascii?Q?tDu6vrxAxJhI0EJJMDzd862XiG1RYXMwo9DBKEDZj7E0v0KV+5ypjiaJo7EY?=
 =?us-ascii?Q?hT7BrImA12fApef6tQbThMJ2qfLD7Y/fCdcw7Co+eMeb7hu7qF9n36topgh6?=
 =?us-ascii?Q?yT+rOfov9kTfxBEQjZDLqAJSZL0IIw/ag60+Zwa0aPlM2qMU9SaAI1sILuoS?=
 =?us-ascii?Q?apkZyUZ0Fg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370a4e0e-a39a-4ed4-2399-08df32c3645b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 18:11:29.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xhgqmC1xt79zawbt1iQVp0nzKZMMSXojwgpXdWlppLpRC/Y4Yi3/hQLT+g3SffL6h78Mz4YWK53hoyLEtUtMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6815

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
 tools/perf/tests/ftrace.c                | 3797 ++++++++++++++++++++++
 tools/perf/tests/tests.h                 |    1 +
 tools/perf/util/Build                    |    1 +
 tools/perf/util/ftrace.c                 | 1782 ++++++++++
 tools/perf/util/ftrace.h                 |   28 +
 tools/perf/util/symbol.c                 |   38 +-
 tools/perf/util/symbol.h                 |    2 +
 11 files changed, 5838 insertions(+), 29 deletions(-)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

-- 
2.55.0

