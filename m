Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792983464;
	b=k5ICOil/8HbB6PvIbplQSeFo5QnBueeent1YArwll/sLLMe+dnIXRLqxh1cGL4bv0ZBs
	 RTrymPc7M4G0lTfYGIvx/cyXMH58o9npFWOmsURnifoPz/DaF2xUgUDejrslju9xM2F/g
	 El4TRjFJ+W6Qe6f8f5g62zlkyxNjKSbhgsPC5Ti1P9wJ555/sEyeyqXnp1aL1mmBTcLCG
	 24PCSfVybfC21W2sjupBMbcn5z69uGl0E+4HTSnm9bILUmpEqAxSjDQSHD9fmLafovnKW
	 HondxgvGfPV9GW0IhXwDBQfLqvuFsvkMWzxlKvtXlFEFzmGS0YqjukXaq8bEcuz6iqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983464;
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
	bh=h9FDyXevTNA/oWxUCqkmJgppsXjac+K4thn9D6rdDP4=;
	b=cr1iFBTea8TICVQcyhFjBr6sJ8yFVthHXr6O0jVd5Ltr9z5+hsdRpx4wbXV1I89/e4by
	 /Ey3AJJjmMQg7W9VGg2ehM9nib05bM1lzqUcG56Q7hyLvx7+W5WTU531hz3FYOAN/Vt0E
	 wD999QXTpWFNQOqMRJeAPcveJXipyOW69e9O9b55VdbLgKjy1OR11FE9H3UvmZeM0wg/S
	 alfoMIy8I+SVjHXRp0G8JmIhyiRToXw30NSiqcdaNyfRrRrflrp7ynaUjrppP8nc1LC5j
	 41KQzDm8M4zbqQBgfMpNNLUse/PI+El/kMiz5hsdz9ICWhRTYi9bFx9xyk8fvypL+8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.135
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021135.outbound.protection.outlook.com [52.101.100.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D5606A31A;
	Mon, 26 Oct 2026 02:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C0D5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTgHJ53KBBgNXuen4JYNHL5WNNLZkTc5iNS9Ayin665ZcKYxMP5IjK3/1DviVHzjsqm3I/yKe/m09J5AgC3R7ABs6FdbSp0uMGL9ni5ZMT6TJxUtKBzNB7weHKnfseQKF8QxgOzPpb61vDhlIj/ZaLKkTK3IAClRWcwW5DDhja+rLLG4jwKEhbDlyKs67v/mPTQMPTJ/NjZemcVNA3buO+SkYgwqyUCHHWKuBUUHAaYw96axUjLonwwKltiiWKlZ+7CUlmkOly6TaMi0P84ZdCCzRMQkczj6rkxPM2pz9ohc3AAD4XD2WtSXQGJbwS9RUelEbKrFBD5a+TWwR0hyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=h9FDyXevTNA/oWxUCqkmJgppsXjac+K4thn9D6rdDP4=;
 b=tmdsw2fVAPu+P/GuiN0fLBJGm9J6Dn1ye6RyAEExQVbhQICTOArqpRiGkLCsODgVNpKjq0K3GV3ZePoEikyHFaGl2v5OcNr3NgZhFSK3AAnb2tP2R8Dm9QHnDrTDrfVxfO7EE+jaxPVn+npSNTcNvvXxTDBpkMGQHU3qQMCWE1aT9ZoOHvf3esYZOp42QWDIdnybuPRaOuVW6LMzk6uAigJlKeWAhSdhc+fhfZxx7LpmjxaduprhBYHfAijQbohK8dR3ZU+NpKDi6WKkEp0mfvPBKFC2b1SOp5hdLOJLowzTVQYQm0cFrsanXMaR/cqM71XFxqAWbJ5nE+IKe+kwrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB9009.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:285::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:57:39 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:57:39 +0000
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
Subject: [PATCH perf-tools-next v12 00/10] perf ftrace: Support inlined functions and display enhancements in function graph tracer
Date: Sun, 25 Oct 2026 22:57:25 -0400
Message-ID: <20261026025735.546101-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c1470a-43e0-441c-f704-08df330ce533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|5023799004|56012099006|261009223027099003|261022105027099003|261022115727099003|261022113327099003|261022075727099003|261021135927099003|261021123027099003|261021121427099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hsuAU4rCALmK5PVYpdTA8M6ikk8+pvXDWtxB84OPByroA6AJSb/m89fLc+9S8NTAdspGQO8oChOuheO9XmHL2FE8mILlvfsGkEnjf/JbMqgEEduk0mANr+jtx8J3QVvZejwz5t6KUl24BfXJFl29rwySrp+YnUlSy/PXwkBhpjgjgiZKpYPKrLRCk0056gfPSM0dQ7XAtqj+pHKYXOBSLidkaLYmeR4loccPQod4FoKGtpueYwP6mII5zKU8LyqaTXSPr0bk5lPoK/aMelHBxD2ZcTcFcSt9xpPKoBn3v2tb1R8AeN23cr/hacbwZIOIS/k+2OT+k4x1Vf/3VvqURVHEGKmjGHObbQdPQfZVzuq+tB39jgmsSNiJlcwMBmaXLtVgV6dq2xTV0vqt242Wg9Xa5XtIg5M9wm+RKqTjvmShWL0GJNkxh4px31jg6BuHKAAGlXRwVJzGJQRvBhcJIHoO7Ed2xAIZmYXBZm3nFtljuihJ5Q2aMbo8WDIXwk+1541J02B9eM1un2K9wOQUfC2xqGW4CX8ht3y4qEg+LZFK6ifqfGwvftscCT9bdQOzkXgNIsT9Q9ByGibMMe432p6ZjM3gPZkVIhD7oJsGHyroRVVzMtzGK/0fsUIXusDD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(5023799004)(56012099006)(261009223027099003)(261022105027099003)(261022115727099003)(261022113327099003)(261022075727099003)(261021135927099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9aJtNu1TB/BVR2O7qjHYH+m7V5HbAEWHLgTQOuayL4T9Ov0AxCS4W9OruCyd?=
 =?us-ascii?Q?62Vs7HBEjr782yY52HwsCt1C519j5E0TZ1WhKsz2+8ebrfMGQl/fP45Hg20U?=
 =?us-ascii?Q?vP3Thw6RtNo4sYiTZS9S7D0d8PxDEJiA2i/Dv+bZcClI4RbU4XItN28VdVYC?=
 =?us-ascii?Q?NX4W0riRfB2p/wHaqOg8SdqdnxbHYLEyea6frEuFOTiSJ5euv0V+yfIuND0A?=
 =?us-ascii?Q?mTKmFZxno7+amqapYpIb3CdNRIIPScZ7ryD4erbRh52FH8CCDEIP+eSGIMPJ?=
 =?us-ascii?Q?y8pt/JKfGwJekpML/xE2pIOE9zYtwhk4Qow9EptetI5VTuFGHIN5C87xa86P?=
 =?us-ascii?Q?b+JQ6cYm7N1N2l+FtDeIqWdFkMtwXfzUiPhUpnbJQSuOC13q1+B5elLPxmTC?=
 =?us-ascii?Q?RZiGIc7igSSy4C3RBRj0ZA1hBnk952/miwdYopITlIgfcVXtL7KtE7I5fB0p?=
 =?us-ascii?Q?piDWmZd0WeCjT7ScEcEzybqSp/4B5bWSeo2fPP6qMLLOzmrhEiVonrJWCRoO?=
 =?us-ascii?Q?pYCbbLG21YMLlQ0sNRsPbLvl9505bY6vwQ3N3BrljxdijNCb0YTrSqLnP9My?=
 =?us-ascii?Q?I+BytNeogrnIvY52P+DxD04GuQKzQ03Sc0R7Emuf9UOj6Yd/oPKtoDVTxJRW?=
 =?us-ascii?Q?JLUg4vWGOU22kKwBPCF7IWtGvD9bDwHkPKuVnNqIJfX/KwU9/IpJ87uIf6nj?=
 =?us-ascii?Q?0uRvooa1A+cqK4pG/uXDz/nYGxhpNBBCqmSdDEF7Bh6QhLjPHxBMtnq5ybBW?=
 =?us-ascii?Q?/PXn0x+henTmnnXgyoGXVW5blLBXBcLBmpIboKY35qrAng9pZcXtBbc94o8o?=
 =?us-ascii?Q?4/c3k35guM8kMNCwBLsMsUSy96fd3kvsZSiAPj7e1R3XsyaWpz5edkl/jUXt?=
 =?us-ascii?Q?RpFQwVX5XVUmQQS5ODYUL0Cqo7xZCqgYHb9OQu9QKXIvCopoQTiETxhiQzEo?=
 =?us-ascii?Q?3zEwKTs3awEnNiH0A4uHmgz5yq8RuA3aCzBaJsVshyFStsVzFbFRdeRJztCr?=
 =?us-ascii?Q?wNEPGPR4jYm7dT4zFhWXiyCHtw6zzLf8Yqq4TVX8Xt9gY0K4PUcc6JtLdsA6?=
 =?us-ascii?Q?TloLYBfi+ZtHuppOuSK4YkHH8IiFYsP1HeQjl2EH7BKCISqLRNZNzjSKNpBT?=
 =?us-ascii?Q?GElSXq4yOhFlhhDgHXRw025RD7nMWtqx/fbZOpK9/UR3MdNnMJHWOoxmnJWd?=
 =?us-ascii?Q?xl455XhD78vU/XGOUv6pqkt4QofisysBO3NMXmmb5Y8VO64y/LM/2H2yZwC1?=
 =?us-ascii?Q?YjoG7iJSVIohfHTrTDfSmLL3VcBsaGUjimgDc6NIHjtFfrU5Ohot1eoX57kO?=
 =?us-ascii?Q?KqXrvfjpBBL/G4f5THD588ZaIlo27Kq/juo6ZA2I/aZlUhT/HUHzzS246Oru?=
 =?us-ascii?Q?zKxya79QDdiOSGWIBXDI70YsdYdlniPV/GsRZvUpryVCsTknrV3SCWlx3uXE?=
 =?us-ascii?Q?n9oSVQAW20DjoAcar1JQK0S+CHw3SpUtjBS3XxyebWRdA8pE4OEGNCiNEU8C?=
 =?us-ascii?Q?/SQWXcn12v51IipzSBZSfNW8gaJ9r4q/8rwGCXV8fAWHWMWi2vUw6eCKUcH9?=
 =?us-ascii?Q?YUSSmXJs2dSEqRK/paissCKItJfWg4iGgn/p64Swfb0JBXDGmfQPSse/rECb?=
 =?us-ascii?Q?m4zyzKROWXeoxwYgGDTwS2a+ZB5TZMMeIYGKoKDI88teyrs5L4wNxnBk3mR7?=
 =?us-ascii?Q?5CADWqRBfP7rcVML5/Ar2muDhCMYHjwrY3uBCSElZAW2s3GjjswDUPLJfHxw?=
 =?us-ascii?Q?NBMZUaDw8Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c1470a-43e0-441c-f704-08df330ce533
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 02:57:38.9998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0x7Xl91iks+lxKOT1WpMpWM29+MqBMnF9aeJhxXxSOcSMhUtYIQJ+J7/Q3mbYek+mEeMSm36IX7rjJezNfhjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB9009

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
 tools/perf/tests/ftrace.c                | 4000 ++++++++++++++++++++++
 tools/perf/tests/tests.h                 |    1 +
 tools/perf/util/Build                    |    1 +
 tools/perf/util/ftrace.c                 | 2053 +++++++++++
 tools/perf/util/ftrace.h                 |   28 +
 tools/perf/util/symbol.c                 |   38 +-
 tools/perf/util/symbol.h                 |    2 +
 11 files changed, 6312 insertions(+), 29 deletions(-)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

-- 
2.55.0

