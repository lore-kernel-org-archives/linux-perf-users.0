Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021079.outbound.protection.outlook.com [52.101.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89203B42F3;
	Tue,  6 Oct 2026 23:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329294; cv=fail; b=KI0PPdlre+sx8Mm5kl7+tjnxwss1Mx4jDTd1mT/aBXswaT2ATRNoq+CFfgBL7V2/sHlZYI3m7OKU+JAHPbRcCF9m2nLXO4kwIdEHA3niXXtDUD4UNOl+en812ac9cO3Or2CUsRYB3QUlX/hfceG5WS9a8Wb7jcV5Gi3fm2XBwbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329294; c=relaxed/simple;
	bh=+vjgQLPUeCZi0tuiTE3lkbuJrY93XZhelkuq0dNXWz0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lqU7wgzDpNES31sTPa3osoYtmC4Bwqe/8IrFGelRBU7A9JBf1DaeiTYoCSUq83CzO0H/oSArJjYNIvcuRIGtN1EnhVSWN4bkGo97ibc0OckOaXIxIlTBjib3UOB9ZvQIiCrz28bj7EJ4cjnsO4b+kO9uSoNJ85TG8wn1M4NL+GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tckv+WySXUQFydQjszHOPJn60a6rnOPpTxSmB1GBp9fd6W/9d/dh9+upvp6wsLj9Elr/YTSvLm/yFpFNyBGx2fX1z5t/rNGJBfushd6r7BiE61FEAqlFFgYQq1FeAPLcd0C93RftFYl2frhUGA9sG/k2EmObkWWjpSy7h9YaM0eOoEwsK63LLuYo352nANWTugHhza3PjuCBvDz/8oX9PkCyZLO2gGjsnpmthdADe3aq9Be7kgZntDCCAr1DBQVo4SrcXS/l1MmIo8o/16U6GSik0Yzb7pKNGlPf9wZltY5OpjXskajr2xQpaomMQ8t0UwIoXhuZsQ169uaD15frfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=IMP9sEnvquwMPLJJWN9vNjf43yuKCm4eWAaWgZ4CDnY=;
 b=cKGg/k2a8j0Y2TGZBsRHs9QzZ5VU3WCjB5JVvDYORvQUS9QR5KN349vxuEajSLrN3BPyNolUa6kqo40cTredyVCRhnhewrzlKsBGZmtcqApmFPRvQBk3FHpUA5O7u/zwvgzLeMXZlvoNWHsxwSTcOhMeN8H7CM/YNEbz+6Yrn3ytHoaPEBiPt7zlt26QLDktJUiejmheuLjLyUiBaNkZnUdYzkojUKXeAfGA10EbLtjJUrCOfPW2BqDlWzJO0+u2kapJHsc13XXH1VvWq6D+Ur6TR/eBeaoZTkyJe6NMYE0Cin/tOJRsCwl7ZGd4ASiJiAx1rLJ/ieSc03i4oZBJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB4004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Tue, 6 Oct
 2026 23:27:59 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 23:27:59 +0000
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
Subject: [PATCH perf-tools-next v2 0/4] perf ftrace: Support inlined functions and display enhancements in function graph tracer
Date: Tue,  6 Oct 2026 19:27:52 -0400
Message-ID: <20261006232756.65620-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0050.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB4004:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fab5b4-836d-46a6-3b74-08df2401750b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|6133799003|18002099003|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	dVaq+kDpQfV+28cptsYxVmPHEeMZegN8BYQgApGyt02vROE/RUqHvaUGXmSGHklAUKSJaC1xL/mZEc5PB46k0Xm/jbYX6AX7uClcvgVUQbrxyUqr7ZuSDtr0gLnQLerlwKIu9MQ2sdFY+PIpJr4nA6gBHQIqAREQev1txGJIe0V9Bvkacq8CdZUJieoKK/f+AiX+A25lbWbtKFrrOtKuudW1Ge3vh+KFDNyUKdDIeOPiDTTvtEfOxhRrR0BRPccTYImqBhuUsHGgBDmYbXqOJ64gWd3Xit6/du/9fgN16i4opg0Fj0JldDPcOEkcSLkoBfFQnVDikTgQzg12ZMFXq/v+b1Q6M7XP6CEJCCn90eDran7xIiTfTs/tB6WETYi/SbljSTjxz1jGtxMJxxvmemFWaNRMf6avk3hT3iD39uDb3cY0MJaLzUFjKpuim7FrqTh9Jy+TGLDhyeKds7jj9GAvL64gDsBZLRVJEd13T+Zj06bP3FqgVDdH1m7rGEe/8q00rMnQTTXWhnDIXjIJBi+ByewM+hQbRdgsKEgx/WXNGOdj89bTS/2JqNB2zmHeL/lT/6OW6L4XMShU8bAz2id7AZRlmjESb86Vro1lpvuyPJw1G23/KpDZBsUUj3HpISbBS9g+2b1GZYEMWuMYU2dn2upykLbwyfD+X2fVBkE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(10067099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cxF4TRPrb6bPnfdFTkIlI6wJvrpzR3M0I3ahaw6QdXFsyK09w7BNQXMmSlVr?=
 =?us-ascii?Q?xeQCGcKw2U6zYkDmNhSy5tMSAWIXNDIyiuYOhn9R4a0Vban4BljI2I0ZZAVm?=
 =?us-ascii?Q?HMnUkQxFqYDtUD9JEtf4Dt9EXEG/gSkouHwrc8AYTkMmCVom1kngkWxghtsz?=
 =?us-ascii?Q?1NuMMikMVXNkk3fbq6fW11dfGBKaXTuIKvY44qlB4BtK31N6EflKMB4lVYW2?=
 =?us-ascii?Q?gX6RLDTuZyb/ZPRuJMysa4m/sBL0e8T8S/+SHNbbM3oM09N4jpPAKEWsNGJg?=
 =?us-ascii?Q?hpEEmn1Z7WZFJlMZjSQtDfscj+wCGUZhMEfalnwJ1Ay6E4Krif/+A9FzALzO?=
 =?us-ascii?Q?0ymjyS4iVz3pqsHDhBrYMSQy5736NERKi2QN4syzHjn1zFXJGbTzI3g42qGF?=
 =?us-ascii?Q?Bivg208thGPW3RiPZ0EgRkkvTFQl9EYvFbNpC4Z+eLKYFlsRM0DWuJ8iFHzc?=
 =?us-ascii?Q?+fpmJ2D5AOIDQWzrAnrueJGckKrBSw9tQXiiPevAgRJYpnKYtEpZvNgSvL+Y?=
 =?us-ascii?Q?qv/xOyGl1Dkfhh6MGDUrQbmyq6jEGvk0JbJGARm1t5vkiRZrXlPy5cMhT5wI?=
 =?us-ascii?Q?6sf5NLA1p18qq7tBgA+cVAc40mpxi5Ah8i3yR2slaV9XS/3Eb6Xq3+8+JYGH?=
 =?us-ascii?Q?Gt1V9qmahvo8NfzTa5DX/OqdhMg/rwdZJUGxShjg/y4obuzIlmL4UejElDo5?=
 =?us-ascii?Q?7Y/f6Xht/JC4JwqGuHs1TsuuqJMulzppOtK+dOcodszfuACL7O71LhzhfuKT?=
 =?us-ascii?Q?bahxIZeGC2Bg4AGQFd4+RPrW0EM6Mm6G+J/w8dELdRk250PAWB2IyWRAL6VS?=
 =?us-ascii?Q?gsdsHUXAIJnLe6kXOsNDsgcvF0rWqQ/2uYPNJ6CXdeKsVB0UiPM6w37e8v8R?=
 =?us-ascii?Q?Il7eODCHYVqyIibNJuPIUHzme3HQp3D3pr38lqIxTw3OpU5XUFv0YykQcrP6?=
 =?us-ascii?Q?1dKjtAdYwOzXJk4oPSTZPQZHP8Jd7O2I5lbMH5TIwJaFiJVpdCUVr32uZPJE?=
 =?us-ascii?Q?WMketLDTUnwUYqH7FmtrEPJK8ExAgqfyJlpJXJ2i1OtDPFM4Z4R5jJxRm5LA?=
 =?us-ascii?Q?es0ZwsFNuCX29/TNoPK691IM0j4S7BR657z1tDfHARsWmb3V5zA7dBtditQ6?=
 =?us-ascii?Q?aIyOZb5GPXFf8KghuHBeHP56qt3eJLgCnGlcYAEqhLFQYehm7F+LTK49P7GQ?=
 =?us-ascii?Q?e5LBr+1NPaZIkqM3W+4a7Rxn1If+51DUHdEKh2mHY7HextK/YOuvzH6jVaJm?=
 =?us-ascii?Q?vad2GZj65p75d4Gi+hqxz0lD87+kYJMyo90O7/FDPAT9LJhI8ForY3GBix/v?=
 =?us-ascii?Q?9EfD4mfXDHajigk8aVO0huGt/U+PpVix/lPSrcC9dp/RCykS3an1Q8YofcgE?=
 =?us-ascii?Q?tuKwLL2ExebcN6G3kkfmPF+w6bVPXWAoi3Puryfu/MqtCttSK718TJkbZ4x2?=
 =?us-ascii?Q?WKInC8oS92DgRjK/avfimxe4gzTrxJTcSPHD28uUooSaT2iG9CpDcJkM4wHC?=
 =?us-ascii?Q?YP2fjvO2dnfdPKWiQBbgGyRP8teoi0eXxYspzH5ovYZ+qX15c5ShzDMJQJl9?=
 =?us-ascii?Q?290bu6Gh+uFv9cF52gb1YdX2aY+IWW/8DPT74Zju9Ksix76VG04snEnSn/ip?=
 =?us-ascii?Q?YWKUeKfgCnvs4YReqbOM1EBRqiJfJDfrnvWZ1yrLG517hboApQQa+QDt9aAl?=
 =?us-ascii?Q?uflfdauypWg+8btVs8gVAYu9ZQxCzZKDDYn9JNMWXwLl0Menp+AyPcDaDaBL?=
 =?us-ascii?Q?HG+wnv+P4w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fab5b4-836d-46a6-3b74-08df2401750b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 23:27:58.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7BE7q/b9AI8bs1SrAruEwwGpLdzPwYeDa6WPpqgozxWiyeEzt9gMbsk74BU6ReLrJr2sh24WuP0QXT+H6F0Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4004

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

Synthesised inlined functions are rendered with an explicit /* (inline) */
annotation at both entry and exit:

     # CPU  DURATION              FUNCTION CALLS
     # |     |   |                 |   |   |   |
      1)   0.856 us |  mutex_unlock(lock=0xffffffffbc28bfa0);
      0)            |  wake_up_new_task(p=0xffff8b1f183bac80) {
      0)            |    rb_irq_work_queue() { /* (inline) */
      0)            |      rb_wakeups() { /* (inline) */
      0)   1.374 us |        housekeeping_any_cpu(type=3);
      0)            |        arch_irq_work_raise() {
      0)            |          apic_wait_icr_idle() { /* (inline) */
      0)            |            x2apic_send_IPI_self(vector=246) {
      0)            |              instr_sysvec_irq_work() { /* (inline) */
      0)            |                irq_enter_rcu() {
      0)            |                  instr_sysvec_irq_work() { /* (inline) */
      0)   0.673 us |                    irqtime_account_irq();
      0)            |                  } /* instr_sysvec_irq_work (inline) */
      0)   1.697 us |                }

This series decomposes the feature into a modular, bisectable progression
of four patches:

    1.  Stack frame optimisation in __cmd_ftrace()

        Replaces the 4096-byte stack array in __cmd_ftrace() with dynamic
        heap allocation alongside struct strbuf streaming, reducing the
        stack frame footprint by over 96% (down to ~160 bytes) while
        ensuring complete line-delimited records and robust EOF handling.

    2.  Return address comment filtering

        Introduces ftrace_parse_retaddr() and ftrace_filter_retaddr() with
        --filter-retaddr and --graph-opts filter-retaddr to strip caller
        comments from trace output, accompanied by an initial unit test
        suite in tools/perf/tests/ftrace.c.

    3.  Inlined function call-graph reconstruction

        Introduces --inline and -k or --vmlinux, dynamically synthesising
        inlined frames marked with /* (inline) */. Correctly matches bare
        closing braces ('}') when funcgraph-tail is disabled, clamps stack
        depth to prevent indentation drift, and expands the automated test
        suite to verify inline resolution, comment filtering, and stack
        saturation recovery.

    4.  Execution duration suppression

        Introduces --graph-opts noduration (and duration=[0|1]) to toggle
        the kernel's funcgraph-duration tracing option, omitting the
        duration column when the user is focused purely on call-graph
        topology and inlined hierarchy.

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

Aaron Tomlin (4):
  perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
  perf ftrace: Support filtering return address comments
  perf ftrace: Support display of inlined functions in function graph
    tracer
  perf ftrace: Support omitting execution duration in function graph
    tracer

 tools/perf/Documentation/perf-ftrace.txt |  21 +
 tools/perf/builtin-ftrace.c              | 126 +++++-
 tools/perf/tests/Build                   |   1 +
 tools/perf/tests/builtin-test.c          |   1 +
 tools/perf/tests/ftrace.c                | 240 ++++++++++
 tools/perf/tests/tests.h                 |   1 +
 tools/perf/util/Build                    |   1 +
 tools/perf/util/ftrace.c                 | 537 +++++++++++++++++++++++
 tools/perf/util/ftrace.h                 |  17 +
 9 files changed, 933 insertions(+), 12 deletions(-)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

-- 
2.55.0

