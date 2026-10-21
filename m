Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792550027;
	b=x/EGQxRSmIDWfITwgv8Ex6xYHdLxOGWFlqnR6UVWNWu0xpbkQQf2Jj6Arpx1yM7d889w
	 q57RREY0z46YES6QbYofG3qKB0zj20Mq/H1W6gK+vsdr8Yg0jBZtnBToW6VmGCSklyWvq
	 c8OD7zwnu5i3Exdu0+767g2in4/afCvZBpG3e9ZeoOG8fX8NVHhDl1L9L2Gfc6U/8bNd+
	 VtC3hsm+EC1fGjMQIA9sTI8CMZQw75BJ/OxqKVJcmKiEqCka9LSors6TMxwcRRS8jdmeD
	 b8uVWcJad/ti57N4RgNJ4iP9PpWhFJi70gsIHSoHMLNBvAVqfT8Eg8EBYjrSWPYcVtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550027;
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
	bh=E7Uh5knoi9RyTrosSAEAWOh0FHBtgtOW7Cu+DyBSE0Q=;
	b=G2gvMuHOy2O4QhYWPT+oy76FMVZc55rgSFvkUe98qRBp4wmp9VRCcizkE3mjeFUy1YEo
	 djYwotLU49DFSfmRtbmXwaqoKzGjswerhTdmHmWXgk0Btg4KqJ95w4QZC0/oEBCAkYiMi
	 1a+td5869/GdvE9o+K4bJRNe930ufhw95xziP/6U5iV57KkKXkoq55Q1bXB2rWXM//+k8
	 m1dZY5d/tjP+ikvvejXOc4YUPhiO7JQ56dY9tudE7gLnSkmCJaoWBppgisJ5YA2UmPzIB
	 skPi/HUjUP81cJJEpE9z56VU2Zx29TRAcgG8HNKNMumdFr8X6CUhTKb9mWUqcA5rQrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.110
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020110.outbound.protection.outlook.com [52.101.196.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335FA606A319;
	Wed, 21 Oct 2026 02:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 335FA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tytwBGPO3qycndrzqaowmc8Xzi4YBb2MTz3CURpl1QZVLCq5hgqoyt/x+ZE4FGkU/sOX0SNZLwSd607yqT/3Epg+5JO7wvKw7w+W1hHQhNNQTEB3O0C2drKNx49k+JnBg0y2bCFIaw0QUCoFYDZNBPDDGPsMiIyzY6NW75NcCOcwACWXuA2+TjF481EpPqioDkUM+t3iBWODHk4J8AeoQbVZyS6D7D5JUzW5GF7uixk+NYVXVsQKu3ugNU7RuRpKzjdnRwF2K9YIfWSqHcMqLE612mq93IOFkutZTJPWdphtT8KHOtkA5Bhwj8Au29j0xzU8ddx1EnJUZM+LJwuX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=E7Uh5knoi9RyTrosSAEAWOh0FHBtgtOW7Cu+DyBSE0Q=;
 b=NfYDXqy9pX2arkJKSJSfU9i0OZ3KyqDQO3NysWYtoasBJndy/niZCYiry3gABz5CyFi89PKKnIk0UzcnwpO7IEIWkki5lBbo3m4HXrROSgcWv99AO4WFWIZB9Dal4nMDiaVnlfqf8sga1/FTHAJdrJvg8zCZYKOt5SkAk9s3Cy6jPxn8OpqqeU22xgoVZGoFRAzIbbWiYr3wK4iEegu6wyqV+C/+cphvBovkdxjRvYl1DY8LMB5ftnwkBqL5RYfpYQORBcXZjKBnRSCtZ1myr0RIszAhXH5VZmFyu19DiJuwMRcZVWtipFDvHDQ+IwdCsHvmTgmGh/LcKVx7C8s9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB5917.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:287::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:33:42 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:33:42 +0000
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
Subject: [PATCH perf-tools-next v9 0/6] perf ftrace: Support inlined functions and display enhancements in function graph tracer
Date: Tue, 20 Oct 2026 22:33:31 -0400
Message-ID: <20261021023337.809936-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:408:f7::29) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: fc17a1d7-fccf-49d7-c12e-08df2f1bb8a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|5023799004|56012099006|261009223027099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	rDFCxM4T5CIlKhSVdkReiBeiklXMVtUIlVwGUov5N3HomjFhgADbS9x5c8PdRanhRuP9io2gntB5OrCeb86BeXduR6GFfl1oU9tXS3zfOg71rvWCLjxshvy6L33nso74CiGRPkISF1c89G1jFKKHnvZnJCMxmEJkFRvxxjnxiI69VMScZPkv6kVM8mzCL9MHhOfhYn+nsyoqy448wWebK9Ck+xTW1R37d3x+gEuqR/jJMpcotGgHw61JBSwaQdxJtoo9n7EVw3F59Eb+vqoxUOSctSLqZ/UnMQjMT7SORO55DhvMOEDVbGf9RTmSfUedLmOxjLYLJ/ZBBK97G0gqqQk9d3H0tDrnUGgM0m0NgrRBxR7odHyFiaQXmU+8qGCRFErTYwcejhyGGFvPzBiI+ozbP2cpkjKkiOFZv+WWSF4wOlNJjvKbOPCIeGGzUswBUCdTcqC+wu8mrefbAGPp08ZXho4f/NyFBbk+4nspxkMWmPlnJ4RzmOsouoSmWF1bHbdu7fCpzIjl596KjC7VNgFxHZ6JWqqMEa/U5htt6NyXEDnLXix/5lV5XWnj1VKfRhP+o4ROMNqir6KcngmO3vfsOPyMZNb9G39DH00sTMHfL0mklQDi0or3yJapDv0N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(5023799004)(56012099006)(261009223027099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8YNcOueEs4siIOP55nZxEc3ijIncpS29ULeVVEs2rDkKpEKzXtRigbij19RZ?=
 =?us-ascii?Q?N6Zddsr2EAn2+15oWOP2XbHaAIx67+MN68fHomSEJUoUT9ESm+sjhROFRjZm?=
 =?us-ascii?Q?lAL8syqjwDieoXLkc4786evTvNEAO8ux34s6+wL9RFxEbCTI9A8TnOltyuV6?=
 =?us-ascii?Q?tASkVkJ5TDnBgj7a6FGMPP+EYwx9ON/wSd96CMO/wzUFuqNZz2K56dWBkAf5?=
 =?us-ascii?Q?bnSXsCOXRLD4gdIpE9o7YJB5OJVpa14WjmlO7B3LR0QAaGChCwgW8j3dHrWQ?=
 =?us-ascii?Q?T/VFIOSL+g2eY34I45iZzr2Ym9h5brUUPkeuyjydRP1XXg14zgzu2sRo+uBF?=
 =?us-ascii?Q?OYoeoyiy2gHTx2kSXPdWWeGNdWr/sT324ydmlNy/j7aDR+0Nd6D85IQtOSrz?=
 =?us-ascii?Q?79Q9osJXHCE3sObh/XO1s8v5jruUrkvvD1XhxwA0TGGTbMuCHWQCdaFuXcmb?=
 =?us-ascii?Q?1bIVnaY0ET0QVYSu8mCjo+ONQHZolgrRnl6f0O8JSq3CLwBLu3dgxQWbaJvy?=
 =?us-ascii?Q?tYLlHcvnGLfAobODmeQvp+wMX0BcDbZrZqRzwv7x9sT0cbsKEoqUU6sD3VsL?=
 =?us-ascii?Q?SDMhHSm0Ws5f9QMvOGIqFL9qIB9rlDZqq6tHodZogwr0NytYgraF05sMMAwU?=
 =?us-ascii?Q?n7GZqcOb8RSh90ZNQMQUPxZ+nKrB71+ZmQ8xpKAd8AW2IkZ/t6/ql5n+1G2c?=
 =?us-ascii?Q?/+cfqwSBVfnMzIlrmjisDKBG7TQZgQTu66dvw99n8llue5G97/vS4v4/hodR?=
 =?us-ascii?Q?nihFmJgv2bpYEKlpOBztokn7rZT9tvKY5T99WVzFwZnNDjCNw523fW3V3/cJ?=
 =?us-ascii?Q?PY4rfDlLyqxspfB8z8KYTbR8jjgkMR8q04v48H2aAosK0VG2y1vPG94ktvZg?=
 =?us-ascii?Q?UUQdlXvz9X0XcZanH/jnmWTChfNlzh7v63dafiYPGaLK5yfGA7D00BhbgJUB?=
 =?us-ascii?Q?y4xo6gnNkcu2IFxvTNFnWPsNa5kzlLJwg3BAU1yFAbFBBI963Llpq40F0IpN?=
 =?us-ascii?Q?b5J2CV4drzRBWAWv+4YqY8fbmyTdocgpx9qkExwiMy/zONMVu6IpnFwwNozK?=
 =?us-ascii?Q?WU1AnssE3BzrO+mmso7V9rewLjOhmStFqWevA7CLWXBkQbkT/BzE5kSTOyGq?=
 =?us-ascii?Q?Q/uGU2x+0nXkLDwGcUneY7zq4Z8MQ3xwrszEvVJr0munu1NpgIgJX6IUa03v?=
 =?us-ascii?Q?pBJop0J8HW+FqmBDLdzC+ueIaNTsvLh6usx/nc+3NFZNAayvJH4G+S4DDucA?=
 =?us-ascii?Q?7hZP3Nj818W7tseKoj4uox6MbxKODofqwTs+DBF/Qo7tNyAWhQ/mkoWgRRXW?=
 =?us-ascii?Q?Y2WsTZjJfdBRoqJE2GgL5M2OGdoww2ZyutA+2eoUvKW0Tr/dQPKh9ZyPSnN5?=
 =?us-ascii?Q?GLqqc0VkVMfCVkAWvP6x5wBkKF9HilCtODmc2jimMqbqPBrJFXDgiq/O1jcG?=
 =?us-ascii?Q?mjnVQi2Nsd2CgHZ4Sj8lqxwMVGqymx6wr1uuij8mG1Y1yoIBgJP/VrMjhHAG?=
 =?us-ascii?Q?1+ENTLd6kz8CFB6/dczUFJoYgruLaP/PSaaH+bD+6pFaR75bhkUi5i1mUhag?=
 =?us-ascii?Q?oNOlmYWrqL5B7oiT/Cd9IfjeK3DSjd8D2g6+adckuLrdL/actVd7EABNvy1I?=
 =?us-ascii?Q?IeljC5+XNeX4Km+5+xKKkkD/I9leYtJSRgcC8ummDi2vpm6MsMUZGSy9F977?=
 =?us-ascii?Q?RlMbN1GHfUUxcp2F9+AiwaJhMl35ors1b5bF2GmQ7RrSNcsVxq8xBd8NdapG?=
 =?us-ascii?Q?tc/NQD3t3A=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc17a1d7-fccf-49d7-c12e-08df2f1bb8a4
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:33:41.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FazKQmu1UTt8zB4GSfIMbcz6O9LLaGAZyTvFtBcF79gm1xuVHQkleE/V3Wa02755T4H49G/8uH2vKwKOkeJ4Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB5917

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
 tools/perf/builtin-ftrace.c              |  212 +-
 tools/perf/tests/Build                   |    1 +
 tools/perf/tests/builtin-test.c          |    1 +
 tools/perf/tests/ftrace.c                | 3271 ++++++++++++++++++++++
 tools/perf/tests/tests.h                 |    1 +
 tools/perf/util/Build                    |    1 +
 tools/perf/util/ftrace.c                 | 1634 +++++++++++
 tools/perf/util/ftrace.h                 |   28 +
 tools/perf/util/symbol.c                 |   38 +-
 tools/perf/util/symbol.h                 |    2 +
 11 files changed, 5180 insertions(+), 29 deletions(-)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

-- 
2.55.0

