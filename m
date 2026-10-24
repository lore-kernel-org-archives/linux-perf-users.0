Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792877159;
	b=27iwkmBvzobLccXiYdOf0blL07m996bS69/gSLRa851PLTM9lqUxYrgl8jrTgvXiGSsX
	 0gfOedoc1hgjbepstvMNQUHImnOwTXvur02MBJK2k8OTDforfGB1Ce5tZgn65EPauTtLO
	 ipAzeZeZNiC5a72JfURmPDouwNZd0ZMeNJoXZLD9Ajv7F7UE3jJTJtiPtMobRgjqtJY01
	 cTufZN2WzJ6ovPAd5YHDe6YA+jR+sGUG6a188SsiSa13AmoZtjF/GcHEv7Qvvu19eELJk
	 tXrXhCCLaLrS9d5iDjfc/GLXmiPYpFn8ewWaxnf7/jbFn8fbZgMjlQq2TytPWb/DWSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877159;
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
	bh=jcMNbKqPbTSF1upstUcb/AqpLWNqUgKfiglznrnonYU=;
	b=wwD+cJ08CffgVsGu2z0jnzZxJX9djEpodsUCUGEHvfpdOJqFxcYSKTFCrtJJmDkuTr8B
	 vg+8IJUux3Qg+ALqVCRY2Q3Kt4Bar+sLrDoIVeKeaDxrwE4ICsBl0LSrLEqxDFsER+4JQ
	 wMyVd8GZ/qUrBzAkzDRIXM7g2HgZy+scVmxT/dGyy5s+9EZjtZq6lVgjJLFaRg2/QVjxP
	 a9Vsv3JnvSqufEYjdfb4hdn/kcitTasbYVsvkV3Sd6i6Z8YKEumU1pm6YUs27S80XfUpr
	 jHeA8u5BQGaUKZvoQ1LB7MSEDtTRTfpm/QqviUa8myCb5NSBfXc/0vNJIpgw7pmYcwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.140
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022140.outbound.protection.outlook.com [52.101.101.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D0606A31B;
	Sat, 24 Oct 2026 21:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F0D0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTvQBvQfszvDiJ/1RwuF5Sc9FK4ILVJ96wtUj1vcc6hgdGgZN4EdZTP2ShD2pGj8/ygDnusme1GvBqMXVkFfAp5tPhEEP9bgw0VvMDsR+4/f74pRnVlEgWmtyimVHKUDFFR6F8Px+qdL+lUz9uatAB2AJKDxztY4ze/fdhRk+HNcFHL78H+GiZdpzBEbuj4simU8w3DxRmf8F6AhByyCFiclWlEvd6uEZdF8qfAGVm0NYFSzwi6ky/QIH8PaRXHmyfkMSDXdWxUyi05a1BMKKnNicPBnduvd9beK4lmYmr0ajVe9bNxKjCpBdPygnEZRyfqaAgb6Kqu3/9383aSZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=jcMNbKqPbTSF1upstUcb/AqpLWNqUgKfiglznrnonYU=;
 b=Al36RQduQmt8v/oAkjNA1HMyOfKh24Sp2F3oI2YtYpZnQuFgEDvLZNoQI9+nepRMtnbQKuxazDYjEgyILqAAEl9s/EXvHRu8V8wmtfIW5KuhA1K926fZ5i+9SxvAb4Ru+P3GleRUQzbvr3V82X9loK5BaF3/RIdf+r35DDggoZwkJBHTuARKajSYMMZYA/0ZIa/KtOHbtG5S7bDpoQM6Q0Al99/fhR0v4BDc53rw7/prh5DJUBnZtnm6t18ES4lE5IlEm+flF1kE7NsIV3qblpxU9JPFebOzZBUaY/pJYrODL46UvF87Uk6kX3VtVKgqdnPi1E2e+jEwVY1zeSACZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6642.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:273::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sat, 24 Oct
 2026 21:25:54 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sat, 24 Oct 2026
 21:25:53 +0000
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
Subject: [PATCH perf-tools-next v10 00/10] perf ftrace: Support inlined functions and display enhancements in function graph tracer
Date: Sat, 24 Oct 2026 17:25:39 -0400
Message-ID: <20261024212549.450634-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:408:fc::31) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 830609f8-6ef4-4b75-8dee-08df32156248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|6133799003|3023799007|56012099006|5023799004|261022115727099003|10067099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261021135927099003|261022075727099003|261022113327099003;
X-Microsoft-Antispam-Message-Info:
	vXE2XOiD9OO4PRpy09nE57BLgUo9SnaMdxMQJwx+6AyhQHnmVjeV8gFh00e0610+W5C/e01xxBNFY8FbyS+orIW77fAN6zwtqaRWd0kIh9SlUG0imHsjLYQ2Ws9W5J2Na2qqRIzqL8pQeWimDRy7tJ/AYX9OesMBcMyB0yNon5hHthODdIniQG0ehkRJ4RwarlLT9N3au38ZyGr21xh9mDI5KREye0RNcI/1C57/4RSKbO1q3gT38lyz8wq/vmlIWE/v+M42sIrEsX9dPEvmOjzzN8/FM56DBENVcKfHLwY2m46wfpcCkghBYkXk0qAL19i+PfM5E04gaBx9veF7iED1S9C+jlF9ZmC1/DpMH62kEhYLp+OnYRbZ4+G8KhNz4+MnHVivq/thGFuQA/tWllVyA0RWZdZizD92OMwJ4KCLtc6mIgWwoHPVDzXpqBPenh+DpzbQJFnrdqRu8lrihy+QkKNCYEHFz9SqORAW0EclELu+VBcFKou7FLupXNu94l1oQdcfOoQrwgPKFQmtQ+tpFdLmVTAwdFCIor/Z/LZyICH3WXrzE4OLuqMIL6TS6DH1e3bvc3eb191hMpK0oO/+IX9APmL1hvyEoQHU8ussFEC9hlOsMvFt0Z7WK08r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(6133799003)(3023799007)(56012099006)(5023799004)(261022115727099003)(10067099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022075727099003)(261022113327099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iZbIGRy7SmFgz5KUIwmsctwDHPp4Qpv0JhNvSmrA68SaLjPqjtb9aUwi5Ia4?=
 =?us-ascii?Q?XnAstnVBjzpFWuBoPrRE9hwYpNQerCJuns753ooyLR/YldHuT/cmo0mjkSGw?=
 =?us-ascii?Q?giYTGO8yEnt3jQ21l1hcx2jMbp4LxsZNLt1n1Hgh4B1K6T2GrBc6jLBYIeA1?=
 =?us-ascii?Q?1HWn7PMmDUPXwCSV3EaW+NBAnzOPaxF7tOevHmGLdP5wuiEPrGJr4Q5GxBSN?=
 =?us-ascii?Q?in/HSiTqhGi/743sKHFaljZ2S+ylD8W+oOaenbYfBF7S60i4x+ZPR8t+WQ6a?=
 =?us-ascii?Q?CLtl6YrQ7ZguJI3bxlAK2Pkk90QTNgcoDT4vRjNHZKfyGVxMxU3+WRsXHsD1?=
 =?us-ascii?Q?uDlHRsFtOmxZ9q/MYFzwDJnNg2j0acE5PAvc1VzCrG8r11a2+c1lN3FrVdFt?=
 =?us-ascii?Q?r2vBr6y709nxjmfAjpdu5AFfbJXL50+0NX366USq7rG2HhtjuUivFEl7EKOS?=
 =?us-ascii?Q?wtvHAZDa4f0QpESOLNEcyxf2wG7nwmImJNCBE/ov3p8t6Y9LShdgUbvnpX86?=
 =?us-ascii?Q?KqIwBGtozs3bIv02n8LOkuPI1ZW7fhATU80ptMv9zX6zQ+r5j05u+/ws0+YE?=
 =?us-ascii?Q?zRvh/G6Wne9utkb2ORtPfF/+fEATK9sDM8Fa5NJCftN4dys098FvJldK7TdM?=
 =?us-ascii?Q?eqwyya5tJUS8GqO4vj/7BGe+wJlsil+rok/m7OHCmIjkMmB2YzDkVknKZt2c?=
 =?us-ascii?Q?kV/mW+/5Wu4jPHF9XSck8vxR1ktrfnBDeYSHefnGbx9+LKI70S0Y4CNCAB5N?=
 =?us-ascii?Q?wnJGbvu212gX6bMRTXzIePpha7r5WwgZiTu/LU59vK0/xmR45WbXtsQsbYuE?=
 =?us-ascii?Q?r8KG3BqXAzqg4uBahHIfTrdSOWYqOsslUOiin/2AyQ4Y6KXZo7wCVA5Jmb3a?=
 =?us-ascii?Q?aFTHLn/qUfRDNaxL8/7/rn20YFSp409XX+38mRsS6p56ct3LeKTnPSP8Uvv0?=
 =?us-ascii?Q?phEEIthVT227CjBc+V6Cpoa8zXn7NmK0A87v7QR5/QgUjNVdvklWJTGrTphj?=
 =?us-ascii?Q?gFGMiDuwBA3E0cPstpXmERgKHSflprII1BaAVB+KngQhLx/aka19jN4wpKKy?=
 =?us-ascii?Q?D9q6p9nvz3RHJZ96RXK7w4NG15nbXsY2FNyuDsHONZGSTZ4pqpLURHeV/4w7?=
 =?us-ascii?Q?aNpYS7qJ6AgqekuVD1Ma6I+/NGMBZcWnUWoj5xXw1VBwfq2lSySZ1iRKsHQI?=
 =?us-ascii?Q?72xIChvZDJM1ySgo/PcFJehyxnfznGoTp1mCxkxdrdq1gQZvOCvfUT+R+m8B?=
 =?us-ascii?Q?CYadeWLvSX5Y7362roxYj9QzsZIy/UF2T7QWPyBzVtwkpaZgKgNd/3U0QwxA?=
 =?us-ascii?Q?anu4GP7XkFL3LIH4CsyT6TpSnEImIyOrmCm5pXJGc39hsD5B8vzW9BrWkyUD?=
 =?us-ascii?Q?q/tfmGNa2sVw4MPGBxBFfl4U1uS2UfOtf4Q/BqQXE0tXNlRENMKF/VvtKEWC?=
 =?us-ascii?Q?OdkEH7+t6YBOqRufHyXIk+nsWOC1LoQUJs8QeMlrvFIdkBhiiOtFiB3blfjz?=
 =?us-ascii?Q?dStysgg4T6T+jH6koOdfSrkcX9fFy2InjISJRkgM186ogM3QQjT6C2uUIzng?=
 =?us-ascii?Q?01KTZhD8FcUd2RgdKCNPt6qmH7X/VTrz+O6sE6pUZvrMf/6bhzyEIV+IrMXS?=
 =?us-ascii?Q?PemFdYlpVZCepIQRx4nHPVZIGXG+GIsquoxSu/JUg4O4gT+FUWfy7QakX0NR?=
 =?us-ascii?Q?ltKsxWFK2BwOpBfRFogaQUD4FzGrSrDW2rIWkVc/evf1koteB4Yr7S5oEp1d?=
 =?us-ascii?Q?NwFV8MSpXQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830609f8-6ef4-4b75-8dee-08df32156248
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 21:25:53.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IuBLtoJ8OjU7rjlSaN4qS/m+cpyqzic6gQ1D+frAeQw3hihr6TgG7XYkE7LPwz8Lny+pyCvjxFxUpn/oSG6jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6642

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
 tools/perf/tests/ftrace.c                | 3744 ++++++++++++++++++++++
 tools/perf/tests/tests.h                 |    1 +
 tools/perf/util/Build                    |    1 +
 tools/perf/util/ftrace.c                 | 1736 ++++++++++
 tools/perf/util/ftrace.h                 |   28 +
 tools/perf/util/symbol.c                 |   38 +-
 tools/perf/util/symbol.h                 |    2 +
 11 files changed, 5739 insertions(+), 29 deletions(-)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

-- 
2.55.0

