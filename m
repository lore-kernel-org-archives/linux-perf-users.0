Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.88
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792550049;
	b=jtALu3YR+/48dds9uH40eQZb/LPcKM5XSgN2KoplX4ftDwBGE7KR0/jJ9j4pNNqHn1bi
	 0RkHEbHuYggqcp6AhxzIXjSyCs/lhewS1dDspHHs0pbcSMwkm89dKMZwByix6/f3yzNdL
	 Ttwx3kCXF+IRQdHF5YQOOmNE2+Yaq6YggB3sGyRivgNYe9Ge8kBQl6PlpdY1RvBdKjKC0
	 +1/Bjp10mLEvxf2DzSYF79kYU5B4T9NMKqwGXRmxp53cUZtlU9viCGISUsE70EejlgBfJ
	 uZzKX/rRPdEoiQxKw3+LTbvW3TdwcPAbhEqblXYL1pRwekE+fHuMKqs5GLpbXhK4I+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550049;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tKy8aNTA7Sd2oQUxD43AXfFa2vgIouPsIhXAFD/JhDY=;
	b=G8LnS9+3KHm8qnwDrv6OEs2OwjpIpGdinkkwRgByJRF5lbyvub0s7eqyMFmUhtFRCffR
	 YEzjt+wztS1hQaXO9jVbXOFr6hvGID1GPd7DVgp6GYGnvCBTRG8010J6IUHGGCVoUI2DS
	 9dYcxHjrrl5lqCUOw6neSP05cYE5ooGZn400ExVZzKZZIOpXonHucKCI0HL5Q1TwCQsoL
	 B/TwMCVK+A/DgtpO4esv/OL8wUtXIaCNPyULGEDz1VF40qMgALQPsm8/EpJXqvUt7z1MW
	 qio53kJnEvtKpTsv1rMdicQqSnkClPcInCRT5JVPyO5kVz3hmMgKUZXBVcaDYW3D+kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.88
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022088.outbound.protection.outlook.com [52.101.96.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6CD606A327;
	Wed, 21 Oct 2026 02:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC6CD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aD3Nl5lhQK62AWdAmpsHwPWNWbtKWRAFeKyhTR3NkWQya2WYHTlIEWUDqwQToIeWyRFAsHgUxndTZfQFEzJJcLVVmCI1VgirNfKCnP1OSApKsVGcGQDosYEvAMbX3yHmGmBoJepZmdWnCASWtKNlAKEOr6o2m9o/1yj16PMsCX1o6lGZspXDM8AJ0vfIXu92U8uRKAlmdIGKRxI8IQ2eZdSHETljsv0QYRk8aVCZ/AG6PuhUp4+tqOyu570TwT+Z0N+a7MMruUUSurYS9L47uOnOQnfB6+TBBVH42uGz4Qv2WCQmLc3k5roDFxUt9kfBVHt4ix49yTejA8VMmcwt2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=tKy8aNTA7Sd2oQUxD43AXfFa2vgIouPsIhXAFD/JhDY=;
 b=VgaBufuzLZso5/SiLkxzLmCiCXkkg9jwnP+ySAlRPA0th3lJmkO51bxjO5eUUeAMvstZYOhUlb6p3KlWL6FYkrg6s3ix+gfsazjvrQ+c4Xdpmy+SF4wd0CA84yUlwe51C5YLUePbQTUC4HAwJTIvoJk9+QVbApZjflpnXcnCtyoQPX+VI8i/E6Ub2OtGQQx0z2E/ti7E2/hP20RcnEsCJdsBc8isD77cFKeT8LhpLagv3US9LEXydAJbM4PbtjPHd1FRPFHpMPd+E+v3ReTPz343NWjSf7YrQBeLyFmyC50d25jWJbSMQRF175XW3G30vQOqylcXbqjC0wn7BAj0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB5917.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:287::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:34:05 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:34:05 +0000
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
Subject: [PATCH perf-tools-next v9 6/6] perf ftrace: Filter extraneous functions in function graph tracer
Date: Tue, 20 Oct 2026 22:33:37 -0400
Message-ID: <20261021023337.809936-7-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021023337.809936-1-atomlin@atomlin.com>
References: <20261021023337.809936-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::34) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 936b5975-4ffa-41af-fe9a-08df2f1bc64c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|5023799004|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	UjehBAbLvUgrnQrxR5epYBCmwYohhY60+gLr4E67VYlhdHbp3d3ATDEYGEzsCAkK9cWF9maMzXBSThwrNR3INT75SWCDmpfYipOCA7DlQKeR8ecWI/klp/ZfWnTm+7uSoGv5zdaZ8zI97ZA4Rok3o0WU3VDUK0W0NwipCgHZXUxPCWb6+L6i9MtPlD56NVizeyZmFxZWC9aqU7GYzQdRpnG7selJ5YkfQyS8jAWU/X3zq5vSdKwUdX4vD2PkQjKQAI2kfwO8zmBL40FtrrSAARK+ArnClhevb6Sjj2ZEcBBBhpkCZ0aroHhwm7JEQTPRF9fdHyofoM/Sxh7VYpSI2oiWs9YkoN8u90Vjr43jbMdTz8GY1R7q2Q5gqJcfivP+pUOvWHcgI+RDlHQnrfh8wYMYRFngapvVmmVJtFXonOMSsNX7wL7/9buv3QVni7xF6nRScOrOqaCeVBmZavj5oFFBm3tokh3NuPtnOChhGg/oPKXAZgLprbPxspGO1m2omnsWqVZA8wTUY+ykQTZeLrOJQa2IM/pKawmiTznFDc/gkaNGKHAA+NoEsu6c5tqUFV5IsEqeXNHkBAT0cApKJC/rSzFYFIG6cBa578SMeHttvzAE8q2nq8+RQDt8y3Q/i9euo0dWhs8qK0Xkn9ndgRmYMfZrEsCzX2MTqTTOXbc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(5023799004)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N+Spvo1NOxV4DWQaiduBpQze6VaSyDBkTrISE5/5ub6qghZ/gRloYbhE44ya?=
 =?us-ascii?Q?6yagJ+XIHZFFy8Uf847WHMOQUr7+Qv1uqsyBH+fAOHCa1YFdKzX03I/Xm5t9?=
 =?us-ascii?Q?tT8MHKtd3xH0AMdtKKXOPsVGCK86sjsoRlWcUTQFmk8pbp0wCqibytRR+u9T?=
 =?us-ascii?Q?DUKfnhwGpBV4SB4VQQv9yJUhw2p5M2tUabP8ZjqCO1ZMCdpSNDL7rwQAZF1a?=
 =?us-ascii?Q?i+oCF9fxAB/es3O5j3Ozetdxpcmg0f3voZGb153ZCe1vL0eMD1x8sAPuvioc?=
 =?us-ascii?Q?G2CFbPWIy4t8+UuCkLrhaHVpXdTZz2iszmORFeKWJOwywY50lJRwW9+oDi0y?=
 =?us-ascii?Q?YBQMASoIKAkZrbzz+/psfsGBoV6jbwigZwNZg9hiAOqTDF+nZfSHhaGUr4VZ?=
 =?us-ascii?Q?TVi/55LZz+S5vvIZyiDJkCCfP0W9b+F3dbe2QKHHYYXrQht1m7sn64elMUN4?=
 =?us-ascii?Q?NuxCYgjUFpidtXD45gV01hazbAdhLDr/iEZwwR153bWVGd75DmTnsKNjQoz4?=
 =?us-ascii?Q?xWRYCa7+P6BW2LZrFbCLg6kVKiNTlmlzTdFuVwmR+1sr0jyEdrhIfrCfLnAV?=
 =?us-ascii?Q?3XjiYwx8f04AmVTj65m+M/craWz3wk9vTXtDSN3u6/M3aJ9HOmECMs/lf2n7?=
 =?us-ascii?Q?Etf43dF9HG5vajLSyBK2e8oJROjovT7ZHNkzDlvO7fQmf8WDPR4i/TtoRlWA?=
 =?us-ascii?Q?P9Q+MPdLwSRKFE+ORkGlaL7F/nhCkb/ZlD76dJq/v28EpYjRq+fomwLz2yOc?=
 =?us-ascii?Q?1AozljLzuSe4w57oymFqEEGi0mwI/6M7Ti/oQEl7eP7yLqa3dJkElf2JF2ci?=
 =?us-ascii?Q?SzQw04YJx0iLfIpKlcr6ii1Byr4R2UBmpaw/T6kDV2uziWVFydccvBqVWEcz?=
 =?us-ascii?Q?IreWtM0a6YgJDQhbWsaae1GPaiUrJDQHF8O7RPIZBH2wF0DbqhW+OFYUB9nq?=
 =?us-ascii?Q?8dNDkiJXP17MkTQWN4gb+969ML4nsnXwgc9GihcmRKRdhooUi2fKPB/AMjcJ?=
 =?us-ascii?Q?lNse4zqEyf3Vu3w8XeHyrhxHQAWWJxRnBQeXR/U7/pW733QOJICQIUiOdXR1?=
 =?us-ascii?Q?9Ax4I7/DpbtU7kJLZIoBmHWuSCRJOzmQj7LKWTsr3fp6/uv0JBjoydNYSBBn?=
 =?us-ascii?Q?0sOtLCSUh83BqelLJ0DD0Ou4IIHxE05IlalvY0ip9inLFWYuEuyShKK3Omcn?=
 =?us-ascii?Q?iIan8uI1BEIspKlg82ZTfZ6O3P6zXOJ16jixLP1oUb0/nznKxue9Xrsx5g1P?=
 =?us-ascii?Q?3+0RSpd/j9jxClHt3wUPL6+LZwpezD/2Zr4SNl00AzzmdjJPeVwuf5mzhwoH?=
 =?us-ascii?Q?+Jpnc/Tf9jFaGwW2kUOdcgqTggAoh/4tLXxvFiSP4I/ZxZ5GpLxZ2irds8ig?=
 =?us-ascii?Q?PjIKLTL2RhdBfPKXfm6AOhZTTkBujAZUpdlZH3hS67EWlV4mdHw9VeZ6o06U?=
 =?us-ascii?Q?m5n4zRrNJZ/NS8ubdMgBk8h/SLuJoHJHcwXKKPfB31YrBm/564zngA8BwKQS?=
 =?us-ascii?Q?D4LYkgtSqZyDL+quZQAhGGScXz0voA5UAXicdrwXBsfF0yzTu7kjiHPEsL/a?=
 =?us-ascii?Q?UtEBLSanVbNSjcodCvDWBjgOPzFhtsbSnwNq2886rM114UddAtuMCf2zYxC9?=
 =?us-ascii?Q?3FuUSL3BTsZjNJ5AinohqS0B1gNxRTY7GFegtofxXg8roRnzcwTL5fPSpBya?=
 =?us-ascii?Q?oQuUvX/io/YVAgBcXyZjz7jlulqNXWpQZP/er5miOMSrs9ow0NI9OSIbfnJr?=
 =?us-ascii?Q?cKeWd1iyBA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936b5975-4ffa-41af-fe9a-08df2f1bc64c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:34:05.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kV9ayi+Ia6/5eqbYha8PRqvmPrKPgl0qzINiGzim+czlMD3CTrV/MX8tw+LnXqwTDpYuwIAG16LK7dpuwbWc3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB5917

When tracing with the function graph tracer using a targeted filter
(-G or --graph-funcs), users occasionally observe unrelated functions in
the trace output:

    1. Top-level functions (e.g. most notably
       finish_task_switch.isra.0()) appearing before or alongside the
       requested target function. This occurs because clearing and
       rewriting set_graph_function creates a transient window where
       remote CPUs still observe an empty filter (tracing all
       functions) before RCU synchronisation completes, coupled with
       perf ftrace sleeping in poll() on trace_pipe right as tracing
       starts.

    2. Detached/orphan calls inside the target callgraph
       (e.g. housekeeping_any_cpu() and arch_irq_work_raise())
       appearing as child frames under the target function. These
       routines are invoked by rb_wakeups() to notify perf's poll() on
       trace_pipe whenever an event is committed, and execute while the
       target function is on the CPU.

Resolve these issues deterministically in userspace:

    1. Target callgraph state tracking

       Track active target callgraph state per-CPU in
       tools/perf/util/ftrace.c. Any entry not matching the requested
       -G targets is suppressed along with its nested children until
       its scope exits. When a target function is matched (at root or
       nested depths), record its root depth; for leaf target calls,
       immediately reset the filter state upon completion to ensure
       subsequent sibling functions remain suppressed. Support glob
       wildcard matching (-G 'prefix_*' and compiler clone suffixes).

    2. Caller provenance and orphan suppression

       Within an active target callgraph, validate that child entries
       descend from an active frame on the target stack using their
       return addresses (CONFIG_FUNCTION_GRAPH_RETADDR). Any detached
       calls originating outside the target hierarchy (such as
       ring-buffer wakeups or asynchronous interrupts) are suppressed
       along with their subtrees (cs->orphan_depth).

       Exits within an orphan subtree are suppressed without querying
       the target stack, preventing common helpers (such as
       _raw_spin_unlock) from colliding with or prematurely unspooling
       active target frames. Dropped-orphan recovery safely resets
       orphan depth whenever an entry or exit occurs at or outside
       the target root indentation.

    3. Dynamic call stack allocation

       Maintain the synthetic call stack as a dynamically reallocated
       array, growing on demand via realloc(). This supports arbitrarily
       deep call trees without fixed-size truncation, ensures unknown
       callers are unambiguously identified as orphans, and guarantees
       that standard filter teardown executes cleanly regardless of
       stack depth upon target function entry.

    4. Automated verification

       Add comprehensive regression tests in tools/perf/tests/ftrace.c
       (test_graph_target_filter()) validating top-level suppression,
       detached orphan suppression, glob matching, deep stack
       traversal, dropped-orphan recovery, and orphan exit collision
       prevention.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-ftrace.c |   45 +-
 tools/perf/tests/ftrace.c   | 2179 +++++++++++++++++++++++++++++++++++
 tools/perf/util/ftrace.c    |  767 +++++++++---
 tools/perf/util/ftrace.h    |    8 +
 4 files changed, 2841 insertions(+), 158 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7abbdeb82264..6679b76bb763 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -576,13 +576,19 @@ static int set_tracing_funcgraph_retval(struct perf_ftrace *ftrace)
 
 static int set_tracing_funcgraph_retaddr(struct perf_ftrace *ftrace)
 {
-	if (ftrace->graph_retaddr || ftrace->use_inline) {
+	bool need_retaddr = ftrace->graph_retaddr || ftrace->use_inline ||
+			    (ftrace->subcmd == PERF_FTRACE_TRACE &&
+			     !list_empty(&ftrace->graph_funcs));
+
+	if (need_retaddr) {
 		if (write_tracing_option_file("funcgraph-retaddr", "1") < 0) {
 			if (ftrace->use_inline) {
 				pr_err("failed to set funcgraph-retaddr option in tracing\n");
 				pr_err("Hint: ensure kernel is compiled with CONFIG_FUNCTION_GRAPH_RETADDR=y\n");
+				return -1;
 			}
-			return -1;
+			if (ftrace->graph_retaddr)
+				return -1;
 		}
 	}
 
@@ -1381,6 +1387,8 @@ static int parse_func_duration(struct perf_ftrace *ftrace, char *line, size_t le
 {
 	char *p;
 	char *func;
+	char *semi;
+	char *ret_str;
 	double duration;
 
 	/* skip CPU */
@@ -1423,12 +1431,21 @@ static int parse_func_duration(struct perf_ftrace *ftrace, char *line, size_t le
 	func = skip_spaces(p);
 
 	/* skip the closing bracket and the start of comment */
-	if (*func == '}')
+	if (*func == '}') {
 		func += 5;
+		ret_str = strstr(func, " ret=");
+		if (ret_str)
+			*ret_str = '\0';
+		p = func + strlen(func) - 1;
+	} else {
+		semi = strchr(func, ';');
+		if (semi)
+			*semi = '\0';
+		p = func + strlen(func) - 1;
+	}
 
-	/* remove semi-colon or end of comment at the end */
-	p = line + len - 1;
-	while (!isalnum(*p) && *p != ']') {
+	/* remove parens, semi-colon or end of comment at the end */
+	while (p > func && !isalnum(*p) && *p != ']') {
 		*p = '\0';
 		--p;
 	}
@@ -1853,12 +1870,6 @@ static int parse_sort_key(const struct option *opt, const char *str, int unset)
 	return 0;
 }
 
-enum perf_ftrace_subcommand {
-	PERF_FTRACE_NONE,
-	PERF_FTRACE_TRACE,
-	PERF_FTRACE_LATENCY,
-	PERF_FTRACE_PROFILE,
-};
 
 int cmd_ftrace(int argc, const char **argv)
 {
@@ -2016,6 +2027,8 @@ int cmd_ftrace(int argc, const char **argv)
 	if (subcmd == PERF_FTRACE_NONE)
 		subcmd = PERF_FTRACE_TRACE;
 
+	ftrace.subcmd = subcmd;
+
 	argc = parse_options(argc, argv, options, ftrace_usage,
 			    PARSE_OPT_STOP_AT_NON_OPTION);
 	if (argc < 0) {
@@ -2037,9 +2050,15 @@ int cmd_ftrace(int argc, const char **argv)
 				ret = -EINVAL;
 				goto out_delete_filters;
 			}
+			if (ftrace.graph_thresh) {
+				pr_err("Error: --inline cannot be combined with --graph-opts thresh\n");
+				ret = -EINVAL;
+				goto out_delete_filters;
+			}
 		}
 		if (!ftrace.filter_retaddr_set) {
-			if (ftrace.use_inline && !ftrace.graph_retaddr)
+			if ((ftrace.use_inline || !list_empty(&ftrace.graph_funcs)) &&
+			    !ftrace.graph_retaddr)
 				ftrace.filter_retaddr = true;
 			else
 				ftrace.filter_retaddr = false;
diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
index edbbc2b11802..e2adf5bc4309 100644
--- a/tools/perf/tests/ftrace.c
+++ b/tools/perf/tests/ftrace.c
@@ -1058,6 +1058,2181 @@ static int test_context_switch_handling(void)
 	return TEST_OK;
 }
 
+static int test_graph_target_filter(void)
+{
+	static const char line_idle[] = " 7)   3.000 us    |  sched_idle_set_state();";
+	static const char line_sw_entry[] = " 6)               |  finish_task_switch.isra.0() {";
+	static const char line_sw_child[] = " 6)   1.000 us    |    _raw_spin_unlock();";
+	static const char line_sw_exit[] = " 6)   2.000 us    |  }";
+	static const char line_tgt_entry[] = " 2)               |  activate_task() {";
+	static const char line_tgt_child[] = " 2)   1.500 us    |    enqueue_task();";
+	static const char line_tgt_exit[] = " 2)   2.500 us    |  }";
+	struct perf_ftrace ftrace;
+	struct filter_entry *entry;
+	struct filter_entry *pos, *tmp;
+	char *out_buf = NULL;
+	size_t out_len = 0;
+	FILE *out;
+	const char *vmlinux;
+	const char *inline_entry, *inline_dup, *inline_exit, *child_exit, *sibling_call;
+	const char *first_act, *second_act, *first_enq, *second_enq;
+	int ret = TEST_OK;
+	int i;
+
+	memset(&ftrace, 0, sizeof(ftrace));
+	INIT_LIST_HEAD(&ftrace.graph_funcs);
+
+	entry = malloc(sizeof(*entry) + strlen("activate_task") + 1);
+	if (!entry)
+		return TEST_FAIL;
+	strcpy(entry->name, "activate_task");
+	list_add_tail(&entry->list, &ftrace.graph_funcs);
+
+	/* 1. Test without --inline */
+	ftrace.use_inline = false;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace, line_idle, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_exit, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_exit, out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+	if (strstr(out_buf, "sched_idle_set_state")) {
+		pr_debug("FAILED: sched_idle_set_state not suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "finish_task_switch")) {
+		pr_debug("FAILED: finish_task_switch not suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "_raw_spin_unlock")) {
+		pr_debug("FAILED: _raw_spin_unlock not suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: activate_task entry missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: enqueue_task child missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 2. Test with --inline */
+	ftrace.use_inline = true;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace, line_idle, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_exit, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_exit, out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	pr_debug("Target filter output with --inline:\n%s\n", out_buf);
+
+	if (strstr(out_buf, "finish_task_switch")) {
+		pr_debug("FAILED: finish_task_switch not suppressed with --inline\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: activate_task entry missing with --inline\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 3. Test suppressing detached orphan calls within target graph */
+	ftrace.use_inline = true;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace, line_tgt_entry, out);
+	/* Leaf orphan call from ring_buffer_unlock_commit */
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)               |    housekeeping_any_cpu(); /* <-ring_buffer_unlock_commit+0x1a0/0x1f0 */",
+		out);
+	/* Non-leaf orphan call from irq_work_queue_on */
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)               |    arch_irq_work_raise() { /* <-irq_work_queue_on+0x81/0xa0 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)               |      apic_wait_icr_idle() { /* (inline) */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)               |        x2apic_send_IPI_self();",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)               |      } /* apic_wait_icr_idle (inline) */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)   1.000 us    |    }",
+		out);
+	/* Genuine child call from activate_task */
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)               |    enqueue_task() { /* <-activate_task+0x1d1/0x3e0 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)   1.500 us    |    }",
+		out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_exit, out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	pr_debug("Orphan call filter output:\n%s\n", out_buf);
+
+	if (strstr(out_buf, "housekeeping_any_cpu")) {
+		pr_debug("FAILED: housekeeping_any_cpu orphan not suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "arch_irq_work_raise")) {
+		pr_debug("FAILED: arch_irq_work_raise orphan not suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "x2apic_send_IPI_self")) {
+		pr_debug("FAILED: x2apic_send_IPI_self not suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task() {")) {
+		pr_debug("FAILED: genuine enqueue_task missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 4. Test targeted leaf call at depth > 0 resetting filter */
+	ftrace.use_inline = false;
+	list_for_each_entry_safe(pos, tmp, &ftrace.graph_funcs, list) {
+		list_del(&pos->list);
+		free(pos);
+	}
+	entry = malloc(sizeof(*entry) + strlen("enqueue_task") + 1);
+	if (!entry) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	strcpy(entry->name, "enqueue_task");
+	list_add_tail(&entry->list, &ftrace.graph_funcs);
+
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace, line_sw_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_exit, out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "finish_task_switch")) {
+		pr_debug("FAILED: finish_task_switch not suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: targeted leaf enqueue_task missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "_raw_spin_unlock")) {
+		pr_debug("FAILED: sibling _raw_spin_unlock not suppressed after leaf target\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 5. Test targeted leaf call at depth > 0 with inlines resetting filter */
+	ftrace.use_inline = true;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace, line_sw_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_exit, out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "finish_task_switch")) {
+		pr_debug("FAILED: finish_task_switch not suppressed with inlines\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: targeted leaf enqueue_task missing with inlines\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "_raw_spin_unlock")) {
+		pr_debug("FAILED: sibling _raw_spin_unlock leaked with inlines\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	vmlinux = vmlinux_path__find();
+
+	/* 6. Test targeted leaf call with synthesized DWARF inlines closing and resetting filter */
+	if (vmlinux) {
+		const char *inlined_names[FTRACE_MAX_INLINES];
+		int num_inlines;
+		int j;
+		const char *saved_vmlinux = symbol_conf.vmlinux_name;
+		bool saved_ignore_buildid = symbol_conf.ignore_vmlinux_buildid;
+
+		symbol_conf.vmlinux_name = vmlinux;
+		symbol_conf.ignore_vmlinux_buildid = true;
+		if (perf_ftrace__setup_inlines(&ftrace) == 0 && ftrace.machine) {
+			num_inlines = ftrace_resolve_inlines(ftrace.machine,
+							     "wake_up_new_task", 0x1d1,
+							     inlined_names,
+							     FTRACE_MAX_INLINES);
+			if (num_inlines > 0 && !strcmp(inlined_names[0], "activate_task")) {
+				out = open_memstream(&out_buf, &out_len);
+				if (!out) {
+					for (j = 0; j < num_inlines; j++)
+						free((void *)inlined_names[j]);
+					perf_ftrace__cleanup_inlines(&ftrace);
+					symbol_conf.vmlinux_name = saved_vmlinux;
+					symbol_conf.ignore_vmlinux_buildid = saved_ignore_buildid;
+					ret = TEST_FAIL;
+					goto out_free_filter;
+				}
+
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)               |  wake_up_new_task() {", out);
+				/* Targeted leaf with caller having inline activate_task */
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)   1.500 us    |    enqueue_task(); /* <-wake_up_new_task+0x1d1/0x3e0 */",
+					out);
+				/* Sibling call after targeted leaf */
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)   1.000 us    |    check_preempt_curr(); /* <-wake_up_new_task+0x0/0x3e0 */",
+					out);
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)   2.500 us    |  } /* wake_up_new_task */", out);
+
+				fclose(out);
+				ftrace_cpu_states__clear();
+
+				if (!strstr(out_buf, "enqueue_task();")) {
+					pr_debug("FAILED: targeted leaf enqueue_task missing\n");
+					ret = TEST_FAIL;
+				} else if (!strstr(out_buf, "} /* activate_task (inline) */")) {
+					pr_debug("FAILED: inline activate_task not closed after leaf target\n");
+					ret = TEST_FAIL;
+				} else if (strstr(out_buf, "check_preempt_curr")) {
+					pr_debug("FAILED: sibling check_preempt_curr leaked after leaf target\n");
+					ret = TEST_FAIL;
+				}
+
+				free(out_buf);
+				out_buf = NULL;
+
+				/*
+				 * 6b. Test child function exit inside inlined function does not
+				 * prematurely close inlined frame (Issue 1).
+				 */
+				list_for_each_entry_safe(pos, tmp, &ftrace.graph_funcs, list) {
+					list_del(&pos->list);
+					free(pos);
+				}
+				entry = malloc(sizeof(*entry) + strlen("wake_up_new_task") + 1);
+				if (!entry) {
+					for (j = 0; j < num_inlines; j++)
+						free((void *)inlined_names[j]);
+					perf_ftrace__cleanup_inlines(&ftrace);
+					symbol_conf.vmlinux_name = saved_vmlinux;
+					symbol_conf.ignore_vmlinux_buildid = saved_ignore_buildid;
+					ret = TEST_FAIL;
+					goto out_free_filter;
+				}
+				strcpy(entry->name, "wake_up_new_task");
+				list_add_tail(&entry->list, &ftrace.graph_funcs);
+
+				out = open_memstream(&out_buf, &out_len);
+				if (!out) {
+					for (j = 0; j < num_inlines; j++)
+						free((void *)inlined_names[j]);
+					perf_ftrace__cleanup_inlines(&ftrace);
+					symbol_conf.vmlinux_name = saved_vmlinux;
+					symbol_conf.ignore_vmlinux_buildid = saved_ignore_buildid;
+					ret = TEST_FAIL;
+					goto out_free_filter;
+				}
+
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)               |  wake_up_new_task() {", out);
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)               |    enqueue_task() { /* <-wake_up_new_task+0x1d1 */",
+					out);
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)   1.000 us    |    } /* enqueue_task */", out);
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)   1.500 us    |    check_preempt_curr(); /* <-wake_up_new_task+0x1d1 */",
+					out);
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)   2.500 us    |  } /* wake_up_new_task */", out);
+
+				fclose(out);
+				ftrace_cpu_states__clear();
+
+				inline_entry = strstr(out_buf, "activate_task() { /* (inline) */");
+				if (inline_entry)
+					inline_dup = strstr(inline_entry + 1,
+							    "activate_task() { /* (inline) */");
+				else
+					inline_dup = NULL;
+				inline_exit = strstr(out_buf, "} /* activate_task (inline) */");
+				child_exit = strstr(out_buf, "} /* enqueue_task */");
+				sibling_call = strstr(out_buf, "check_preempt_curr();");
+
+				if (!inline_entry) {
+					pr_debug("FAILED: inline activate_task entry missing\n");
+					ret = TEST_FAIL;
+				} else if (inline_dup) {
+					pr_debug("FAILED: duplicate inline activate_task synthesized\n");
+					ret = TEST_FAIL;
+				} else if (!inline_exit || !child_exit || !sibling_call) {
+					pr_debug("FAILED: expected trace frames missing\n");
+					ret = TEST_FAIL;
+				} else if (inline_exit < sibling_call) {
+					pr_debug("FAILED: inline activate_task closed before sibling call\n");
+					ret = TEST_FAIL;
+				}
+
+				free(out_buf);
+				out_buf = NULL;
+
+				/*
+				 * 6c. Test recursive target root function with --inline (Issue 2).
+				 * Inner target root exit must not prematurely close inlined frames
+				 * or unseat outer target root.
+				 */
+				out = open_memstream(&out_buf, &out_len);
+				if (!out) {
+					for (j = 0; j < num_inlines; j++)
+						free((void *)inlined_names[j]);
+					perf_ftrace__cleanup_inlines(&ftrace);
+					symbol_conf.vmlinux_name = saved_vmlinux;
+					symbol_conf.ignore_vmlinux_buildid = saved_ignore_buildid;
+					ret = TEST_FAIL;
+					goto out_free_filter;
+				}
+
+				/* Outer target root */
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)               |  wake_up_new_task() {", out);
+				/* Recursive target root call with inline activate_task */
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)               |    wake_up_new_task() { /* <-wake_up_new_task+0x1d1 */",
+					out);
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)   1.000 us    |      enqueue_task(); /* <-wake_up_new_task+0x10 */",
+					out);
+				/* Inner target root exits */
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)   2.000 us    |    } /* wake_up_new_task */", out);
+				/* Sibling call under inlined activate_task in outer target */
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)   1.500 us    |    check_preempt_curr(); /* <-wake_up_new_task+0x1d1 */",
+					out);
+				/* Outer target root exits */
+				ftrace_process_fgraph_line(&ftrace,
+					" 0)   4.000 us    |  } /* wake_up_new_task */", out);
+
+				fclose(out);
+				ftrace_cpu_states__clear();
+
+				inline_entry = strstr(out_buf, "activate_task() { /* (inline) */");
+				inline_exit = strstr(out_buf, "} /* activate_task (inline) */");
+				sibling_call = strstr(out_buf, "check_preempt_curr();");
+
+				if (!inline_entry) {
+					pr_debug("FAILED: recursive target: inline activate_task missing\n");
+					ret = TEST_FAIL;
+				} else if (!inline_exit || !sibling_call) {
+					pr_debug("FAILED: recursive target: expected frames missing\n");
+					ret = TEST_FAIL;
+				} else if (inline_exit < sibling_call) {
+					pr_debug("FAILED: recursive target: inline closed before outer sibling\n");
+					ret = TEST_FAIL;
+				}
+
+				free(out_buf);
+				out_buf = NULL;
+			}
+			for (j = 0; j < num_inlines; j++)
+				free((void *)inlined_names[j]);
+			perf_ftrace__cleanup_inlines(&ftrace);
+		}
+		symbol_conf.vmlinux_name = saved_vmlinux;
+		symbol_conf.ignore_vmlinux_buildid = saved_ignore_buildid;
+		if (ret != TEST_OK)
+			goto out_free_filter;
+	}
+
+	/* 7. Test recovery when an orphan exit event is dropped by the ring buffer */
+	list_for_each_entry_safe(pos, tmp, &ftrace.graph_funcs, list) {
+		list_del(&pos->list);
+		free(pos);
+	}
+	entry = malloc(sizeof(*entry) + strlen("activate_task") + 1);
+	if (!entry) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	strcpy(entry->name, "activate_task");
+	list_add_tail(&entry->list, &ftrace.graph_funcs);
+
+	/* 7a. Method 1: Target function exits directly after a dropped orphan exit */
+	ftrace.use_inline = false;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	/* Orphan entry: housekeeping_any_cpu called from outside activate_task */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    housekeeping_any_cpu() { /* <-rb_wakeups+0x10 */",
+		out);
+	/* Exit of housekeeping_any_cpu is DROPPED by ring buffer (never arrives) */
+	/* Target function exits with named closing brace */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.500 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: target activate_task entry missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "housekeeping_any_cpu")) {
+		pr_debug("FAILED: orphan housekeeping_any_cpu leaked into output\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "} /* activate_task */")) {
+		pr_debug("FAILED: target activate_task exit swallowed after orphan exit dropped\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 7b. Method 2: Target function calls legitimate child after a dropped orphan exit */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	/* Orphan entry: housekeeping_any_cpu called from outside activate_task */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    housekeeping_any_cpu() { /* <-rb_wakeups+0x10 */",
+		out);
+	/* Exit of housekeeping_any_cpu is DROPPED by ring buffer */
+	/* Legitimate child call from activate_task */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.200 us    |    enqueue_task(); /* <-activate_task+0x1d1/0x3e0 */",
+		out);
+	/* Target function exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.500 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "housekeeping_any_cpu")) {
+		pr_debug("FAILED: orphan housekeeping_any_cpu leaked into output\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: legitimate child enqueue_task swallowed after orphan exit dropped\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "} /* activate_task */")) {
+		pr_debug("FAILED: target activate_task exit missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 8. Test target_root_depth synchronisation when target root enters
+	 * after dropped sibling exit.
+	 */
+	/* 8a. Without --inline */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Caller at depth 0 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  wake_up_new_task() {", out);
+	/* Extraneous sibling at depth 1 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    stale_sibling() {", out);
+	/* Exit of stale_sibling is DROPPED by ring buffer */
+	/* Target function enters with caller wake_up_new_task */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-wake_up_new_task+0x10 */", out);
+	/* First child of target enters and exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      enqueue_task() { /* <-activate_task+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      }", out);
+	/* Second child of target enters and exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.500 us    |      check_preempt_curr(); /* <-activate_task+0x30 */", out);
+	/* Target function exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.500 us    |    } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "stale_sibling")) {
+		pr_debug("FAILED: stale_sibling leaked into output (!inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: activate_task entry missing (!inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task() {")) {
+		pr_debug("FAILED: first child enqueue_task missing (!inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "check_preempt_curr();")) {
+		pr_debug("FAILED: second child check_preempt_curr missing (!inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "} /* activate_task */")) {
+		pr_debug("FAILED: target activate_task exit missing (!inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 8b. With --inline */
+	ftrace.use_inline = true;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Caller at depth 0 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  wake_up_new_task() {", out);
+	/* Extraneous sibling at depth 1 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    stale_sibling() {", out);
+	/* Exit of stale_sibling is DROPPED by ring buffer */
+	/* Target function enters with caller wake_up_new_task */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-wake_up_new_task+0x10 */", out);
+	/* First child of target enters and exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      enqueue_task() { /* <-activate_task+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      }", out);
+	/* Second child of target enters and exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.500 us    |      check_preempt_curr(); /* <-activate_task+0x30 */", out);
+	/* Target function exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.500 us    |    } /* activate_task */", out);
+	/* Sibling call after target function */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    after_target(); /* <-wake_up_new_task+0x40 */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "stale_sibling")) {
+		pr_debug("FAILED: stale_sibling leaked into output (--inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: activate_task entry missing (--inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task() {")) {
+		pr_debug("FAILED: first child enqueue_task missing (--inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "check_preempt_curr();")) {
+		pr_debug("FAILED: second child check_preempt_curr missing (--inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "} /* activate_task */")) {
+		pr_debug("FAILED: target activate_task exit missing (--inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "after_target")) {
+		pr_debug("FAILED: after_target leaked into output (--inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 9. Test deep legitimate subtrees when stack depth exceeds
+	 * FTRACE_MAX_STACK (overflow_depth > 0).
+	 */
+	/* 9a. Without --inline */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	for (i = 1; i < 256; i++) {
+		ftrace_process_fgraph_line(&ftrace,
+			" 0)               |    sub_func() { /* <-activate_task+0x10 */", out);
+	}
+	/* Push frames beyond FTRACE_MAX_STACK (256) */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      overflow_parent() { /* <-sub_func+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |        overflow_child() { /* <-overflow_parent+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |          overflow_leaf(); /* <-overflow_child+0x30 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.200 us    |        }", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.400 us    |      }", out);
+	for (i = 1; i < 256; i++) {
+		ftrace_process_fgraph_line(&ftrace,
+			" 0)   1.000 us    |    }", out);
+	}
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.500 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (!strstr(out_buf, "overflow_parent() {")) {
+		pr_debug("FAILED: overflow_parent entry missing (!inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "overflow_child() {")) {
+		pr_debug("FAILED: overflow_child entry missing (!inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "overflow_leaf();")) {
+		pr_debug("FAILED: overflow_leaf missing (!inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 9b. With --inline */
+	ftrace.use_inline = true;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	for (i = 1; i < 256; i++) {
+		ftrace_process_fgraph_line(&ftrace,
+			" 0)               |    sub_func() { /* <-activate_task+0x10 */", out);
+	}
+	/* Push frames beyond FTRACE_MAX_STACK (256) */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      overflow_parent() { /* <-sub_func+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |        overflow_child() { /* <-overflow_parent+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |          overflow_leaf(); /* <-overflow_child+0x30 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.200 us    |        }", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.400 us    |      }", out);
+	for (i = 1; i < 256; i++) {
+		ftrace_process_fgraph_line(&ftrace,
+			" 0)   1.000 us    |    }", out);
+	}
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.500 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (!strstr(out_buf, "overflow_parent() {")) {
+		pr_debug("FAILED: overflow_parent entry missing (--inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "overflow_child() {")) {
+		pr_debug("FAILED: overflow_child entry missing (--inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "overflow_leaf();")) {
+		pr_debug("FAILED: overflow_leaf missing (--inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 9. Test glob wildcard filter (-G 'activate_*') */
+	list_for_each_entry_safe(pos, tmp, &ftrace.graph_funcs, list) {
+		list_del(&pos->list);
+		free(pos);
+	}
+	entry = malloc(sizeof(*entry) + strlen("activate_*") + 1);
+	if (!entry) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	strcpy(entry->name, "activate_*");
+	list_add_tail(&entry->list, &ftrace.graph_funcs);
+
+	ftrace.use_inline = false;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace, line_idle, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_exit, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_exit, out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "finish_task_switch")) {
+		pr_debug("FAILED: finish_task_switch leaked with wildcard\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: wildcard target activate_* missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: wildcard child enqueue_task missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 10. Test wildcard filter matching compiler clone with suffix (-G '*task_switch') */
+	list_for_each_entry_safe(pos, tmp, &ftrace.graph_funcs, list) {
+		list_del(&pos->list);
+		free(pos);
+	}
+	entry = malloc(sizeof(*entry) + strlen("*task_switch") + 1);
+	if (!entry) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	strcpy(entry->name, "*task_switch");
+	list_add_tail(&entry->list, &ftrace.graph_funcs);
+
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace, line_idle, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_exit, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_exit, out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (!strstr(out_buf, "finish_task_switch.isra.0() {")) {
+		pr_debug("FAILED: wildcard target *task_switch did not match clone\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "_raw_spin_unlock();")) {
+		pr_debug("FAILED: child _raw_spin_unlock missing under clone target\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "activate_task")) {
+		pr_debug("FAILED: unrelated activate_task leaked under *task_switch\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 11. Test that orphan exits sharing name with target active frame
+	 * do not collide (Issue 1).
+	 */
+	list_for_each_entry_safe(pos, tmp, &ftrace.graph_funcs, list) {
+		list_del(&pos->list);
+		free(pos);
+	}
+	entry = malloc(sizeof(*entry) + strlen("activate_task") + 1);
+	if (!entry) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	strcpy(entry->name, "activate_task");
+	list_add_tail(&entry->list, &ftrace.graph_funcs);
+
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    _raw_spin_unlock() { /* <-activate_task+0x10 */", out);
+	/* Detached interrupt enters */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      smp_apic_timer_interrupt() { /* <-irq_work+0x10 */", out);
+	/* Interrupt invokes _raw_spin_unlock and exits with named brace */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |        _raw_spin_unlock() { /* <-smp_apic_timer_interrupt+0x20 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |        } /* _raw_spin_unlock */", out);
+	/* Interrupt exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |      }", out);
+	/* Target's _raw_spin_unlock exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |    } /* _raw_spin_unlock */", out);
+	/* Target continues and exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   4.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "smp_apic_timer_interrupt")) {
+		pr_debug("FAILED: orphan smp_apic_timer_interrupt leaked into output\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: activate_task entry missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "} /* activate_task */")) {
+		pr_debug("FAILED: activate_task exit missing or prematurely unspooled\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 12. Test target function entering at deep stack (depth >= 256)
+	 * and exiting without leaking sibling (Issue 2).
+	 */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Push 256 non-target outer frames */
+	for (i = 0; i < 256; i++) {
+		ftrace_process_fgraph_line(&ftrace,
+			" 0)               |  outer_func() {", out);
+	}
+	/* Target function enters at depth 256 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    enqueue_task(); /* <-activate_task+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |  } /* activate_task */", out);
+	/* Unrelated sibling enters at depth 256 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  unrelated_sibling() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    unrelated_child();", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |  }", out);
+	/* Unspool outer frames */
+	for (i = 0; i < 256; i++) {
+		ftrace_process_fgraph_line(&ftrace,
+			" 0)               |  }", out);
+	}
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: deep activate_task entry missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: deep enqueue_task child missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "unrelated_sibling")) {
+		pr_debug("FAILED: unrelated_sibling leaked after deep target exit\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 13. Test orphan suppression during deep stacks (Issue 3) */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	for (i = 1; i < 256; i++) {
+		ftrace_process_fgraph_line(&ftrace,
+			" 0)               |    sub_func() { /* <-activate_task+0x10 */", out);
+	}
+	/* Target call at depth 256 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      deep_child() { /* <-sub_func+0x10 */", out);
+	/* Detached interrupt fires at depth 257 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |        smp_apic_timer_interrupt() { /* <-irq_work+0x10 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |          irq_sub(); /* <-smp_apic_timer_interrupt+0x20 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |        }", out);
+	/* Target continues */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |        deep_leaf(); /* <-deep_child+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |      }", out);
+	for (i = 1; i < 256; i++) {
+		ftrace_process_fgraph_line(&ftrace,
+			" 0)   1.000 us    |    }", out);
+	}
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "smp_apic_timer_interrupt") || strstr(out_buf, "irq_sub")) {
+		pr_debug("FAILED: interrupt leaked during deep stack\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "deep_leaf();")) {
+		pr_debug("FAILED: legitimate deep_leaf missing during deep stack\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 14. Test orphan calling common helper present on stack does not leak child (Issue 2) */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    _raw_spin_unlock() { /* <-activate_task+0x10 */", out);
+	/* Detached interrupt fires */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      smp_apic_timer_interrupt() { /* <-irq_work+0x10 */",
+		out);
+	/* Orphan interrupt calls _raw_spin_unlock */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |        _raw_spin_unlock() { /* <-smp_apic_timer_interrupt+0x20 */",
+		out);
+	/* Orphan _raw_spin_unlock calls child helper with retaddr <-_raw_spin_unlock+0x10 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |          native_queued_spin_unlock(); /* <-_raw_spin_unlock+0x10 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.500 us    |        }", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |      }", out);
+	/* Legitimate target child call */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      queued_spin_unlock(); /* <-_raw_spin_unlock+0x10 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |    }", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   4.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "native_queued_spin_unlock")) {
+		pr_debug("FAILED: orphan child native_queued_spin_unlock leaked\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "queued_spin_unlock();")) {
+		pr_debug("FAILED: target child queued_spin_unlock missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 15. Test dropped target root exit followed by outer ancestor call
+	 * (Issues 4A & 4B).
+	 */
+	/* 15a. Without --inline */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Ancestor frame at depth 0 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  schedule() {", out);
+	/* Target function enters at depth 1 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-schedule+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      enqueue_task(); /* <-activate_task+0x20 */", out);
+	/* Target root exit is DROPPED by ring buffer! */
+	/* Outer ancestor schedule() calls another function */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    context_switch() { /* <-schedule+0x50 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      prepare_task_switch(); /* <-context_switch+0x10 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.500 us    |    }", out);
+	/* Ancestor schedule() exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  } /* schedule */", out);
+	/* Subsequent target function invocation on same CPU */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    enqueue_task();", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "schedule")) {
+		pr_debug("FAILED: outer ancestor schedule leaked into output (!inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "context_switch")) {
+		pr_debug("FAILED: ancestor child context_switch leaked (!inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: legitimate enqueue_task missing (!inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 15b. With --inline */
+	ftrace.use_inline = true;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  schedule() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-schedule+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      enqueue_task(); /* <-activate_task+0x20 */", out);
+	/* Dropped target root exit */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    context_switch() { /* <-schedule+0x50 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      prepare_task_switch(); /* <-context_switch+0x10 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.500 us    |    }", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  } /* schedule */", out);
+	/* Subsequent target function invocation on same CPU */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    enqueue_task();", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "schedule")) {
+		pr_debug("FAILED: outer ancestor schedule leaked into output (--inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "context_switch")) {
+		pr_debug("FAILED: ancestor child context_switch leaked (--inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: legitimate enqueue_task missing (--inline)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 16. Test dropped-orphan exit recovery when target root exits (Issue 5) */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  schedule() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-schedule+0x10 */", out);
+	/* Detached orphan interrupt enters */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      smp_apic_timer_interrupt() { /* <-irq_work+0x10 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |        irq_sub(); /* <-smp_apic_timer_interrupt+0x20 */",
+		out);
+	/* Orphan exit is DROPPED by ring buffer! orphan_depth remains 1 */
+	/* Target function exits with named closing brace */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |    } /* activate_task */", out);
+	/* Ancestor schedule exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  } /* schedule */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "smp_apic_timer_interrupt") || strstr(out_buf, "irq_sub")) {
+		pr_debug("FAILED: dropped-orphan interrupt leaked\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: activate_task entry missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "} /* activate_task */")) {
+		pr_debug("FAILED: activate_task exit missing after dropped orphan\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "schedule")) {
+		pr_debug("FAILED: schedule leaked after target exit\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 17. Test dropped-orphan exit recovery with bare '}' exit (Issue 3.1) */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  schedule() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-schedule+0x10 */", out);
+	/* Detached orphan interrupt enters */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      smp_apic_timer_interrupt() { /* <-irq_work+0x10 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |        irq_sub(); /* <-smp_apic_timer_interrupt+0x20 */",
+		out);
+	/* Orphan exit is DROPPED by ring buffer! orphan_depth remains 1 */
+	/* Target function exits with bare closing brace '}' */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |    }", out);
+	/* Ancestor schedule exits with bare '}' */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  }", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "smp_apic_timer_interrupt") || strstr(out_buf, "irq_sub")) {
+		pr_debug("FAILED: dropped-orphan interrupt leaked (bare exit)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: activate_task entry missing (bare exit)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "}")) {
+		pr_debug("FAILED: activate_task exit missing after dropped orphan (bare exit)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "schedule")) {
+		pr_debug("FAILED: schedule leaked after target bare exit\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 18. Test dropped top-level target root exit followed by next invocation (Issue 3.2) */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* First top-level invocation of target root */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    enqueue_task(); /* <-activate_task+0x20 */", out);
+	/* Target root exit is DROPPED by ring buffer! */
+	/* Second top-level invocation of target root with untraced caller */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() { /* <-untraced_caller+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    enqueue_task(); /* <-activate_task+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	first_act = strstr(out_buf, "activate_task() {");
+	second_act = first_act ? strstr(first_act + 1, "activate_task() {") : NULL;
+	first_enq = strstr(out_buf, "enqueue_task();");
+	second_enq = first_enq ? strstr(first_enq + 1, "enqueue_task();") : NULL;
+
+	if (!first_act || !second_act) {
+		pr_debug("FAILED: subsequent target root dropped after dropped top-level exit\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!first_enq || !second_enq) {
+		pr_debug("FAILED: child calls missing after dropped top-level exit\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 19. Test dropped target root exit (depth > 0) followed by target recall (Issue 3.3) */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Ancestor schedule() at depth 0 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  schedule() {", out);
+	/* Target function at depth 1 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-schedule+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      enqueue_task(); /* <-activate_task+0x20 */", out);
+	/* Target exit is DROPPED by ring buffer! */
+	/* Ancestor calls target function again */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-schedule+0x30 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      enqueue_task(); /* <-activate_task+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |    } /* activate_task */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  } /* schedule */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "schedule")) {
+		pr_debug("FAILED: ancestor schedule leaked into output\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	first_act = strstr(out_buf, "activate_task() {");
+	second_act = first_act ? strstr(first_act + 1, "activate_task() {") : NULL;
+
+	if (!first_act || !second_act) {
+		pr_debug("FAILED: target root not recovered on recall by ancestor\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 20. Test nested target-matching call with caller_idx < 0 inside
+	 * an orphan subtree does not unwind outer target call stack.
+	 */
+	list_for_each_entry_safe(pos, tmp, &ftrace.graph_funcs, list) {
+		list_del(&pos->list);
+		free(pos);
+	}
+	entry = malloc(sizeof(*entry) + strlen("activate_task") + 1);
+	if (!entry) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	strcpy(entry->name, "activate_task");
+	list_add_tail(&entry->list, &ftrace.graph_funcs);
+
+	entry = malloc(sizeof(*entry) + strlen("enqueue_task") + 1);
+	if (!entry) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	strcpy(entry->name, "enqueue_task");
+	list_add_tail(&entry->list, &ftrace.graph_funcs);
+
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Target root enters at root indentation */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	/* Detached orphan interrupt enters */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    smp_apic_timer_interrupt() { /* <-irq_work+0x10 */", out);
+	/* Nested target-matching function called inside orphan with caller_idx < 0 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      enqueue_task() { /* <-smp_apic_timer_interrupt+0x20 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      } /* enqueue_task */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.500 us    |    }", out);
+	/* Target continues with legitimate child */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.200 us    |    enqueue_task(); /* <-activate_task+0x1d1 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "smp_apic_timer_interrupt")) {
+		pr_debug("FAILED: nested orphan interrupt leaked into output\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: activate_task entry missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: legitimate child enqueue_task missing after nested target-match in orphan\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "} /* activate_task */")) {
+		pr_debug("FAILED: activate_task exit missing after nested target-match in orphan\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 21. Test orphan exit named differently from target root is not
+	 * misidentified as target root exit when extra_indent > 0.
+	 */
+	list_for_each_entry_safe(pos, tmp, &ftrace.graph_funcs, list) {
+		list_del(&pos->list);
+		free(pos);
+	}
+	entry = malloc(sizeof(*entry) + strlen("activate_task") + 1);
+	if (!entry) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	strcpy(entry->name, "activate_task");
+	list_add_tail(&entry->list, &ftrace.graph_funcs);
+
+	ftrace.use_inline = true;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Target root enters */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	/* Synthesised inline child adds extra_indent */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    inline_child() { /* (inline) */", out);
+	/* Detached orphan interrupt enters */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    smp_apic_timer_interrupt() { /* <-irq_work+0x10 */", out);
+	/* Orphan exits with named closing brace */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    } /* _raw_spin_unlock */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |    }", out);
+	/* Genuine target child */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.500 us    |      enqueue_task(); /* <-activate_task+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    } /* inline_child (inline) */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   4.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "smp_apic_timer_interrupt")) {
+		pr_debug("FAILED: orphan smp_apic_timer_interrupt leaked\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: genuine child missing after orphan exit with different name\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "} /* activate_task */")) {
+		pr_debug("FAILED: target root exit prematurely unspooled by orphan exit\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 22. Test target root entry with caller_idx < 0 purges stale
+	 * non-target frames so calls matching old frames do not terminate target.
+	 */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Non-target function enters; its exit is dropped */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  stale_ancestor() {", out);
+	/* Target root enters with untraced caller (caller_idx < 0) */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() { /* <-untraced+0x10 */", out);
+	/* Target child calls helper with retaddr to stale_ancestor name */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    helper() { /* <-stale_ancestor+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    }", out);
+	/* Target legitimate child */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.500 us    |    enqueue_task(); /* <-activate_task+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "stale_ancestor")) {
+		pr_debug("FAILED: stale_ancestor leaked into output\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: target prematurely terminated by match on stale frame below target root\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "} /* activate_task */")) {
+		pr_debug("FAILED: target root exit missing after stale frame purge\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 23. Test !use_inline dropped child exit does not prevent bare '}'
+	 * from exiting target root.
+	 */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Target root enters */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	/* Child 1 enters; its exit is DROPPED by ring buffer */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    child_one() { /* <-activate_task+0x10 */", out);
+	/* Caller activate_task calls Child 2 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    child_two(); /* <-activate_task+0x20 */", out);
+	/* Target root exits with bare closing brace '}' */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.500 us    |  }", out);
+	/* Subsequent non-target function enters */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  unrelated_after() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    unrelated_child();", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |  }", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: activate_task entry missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "child_two();")) {
+		pr_debug("FAILED: child_two missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "unrelated_after")) {
+		pr_debug("FAILED: unrelated_after leaked; bare '}' matched dropped child instead of target root\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 24. Test graph_thresh with -G outputs return lines when !use_inline.
+	 */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	ftrace.graph_thresh = 1000;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   5.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+	ftrace.graph_thresh = 0;
+
+	if (!strstr(out_buf, "} /* activate_task */")) {
+		pr_debug("FAILED: graph_thresh return event suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 25. Test orphan subtree invoking target root function T at deeper
+	 * indentation does not reset orphan_depth or target root state.
+	 */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Target root enters at indent 2 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	/* Detached orphan interrupt enters at indent 4 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    irq_handler() { /* <-unrelated_irq+0x10 */", out);
+	/* Orphan invokes activate_task at indent 6 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      activate_task() { /* <-irq_handler+0x20 */", out);
+	/* Nested activate_task calls child inside orphan */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |        orphan_child(); /* <-activate_task+0x10 */", out);
+	/* Nested activate_task exits inside orphan */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |      } /* activate_task */", out);
+	/* Orphan interrupt exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |    } /* irq_handler */", out);
+	/* Real child of outer target root executes */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    real_child(); /* <-activate_task+0x30 */", out);
+	/* Outer target root exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   5.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "orphan_child")) {
+		pr_debug("FAILED: orphan_child leaked from nested invocation\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "real_child")) {
+		pr_debug("FAILED: real_child missing; outer target root was prematurely closed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 26. Test IRQ markers outside target function are suppressed with -G,
+	 * but preserved when inside target callgraph.
+	 */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* IRQ marker outside target */
+	ftrace_process_fgraph_line(&ftrace, " 0)   ==========> |", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)   <========== |", out);
+
+	/* Target enters */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	/* IRQ marker inside target */
+	ftrace_process_fgraph_line(&ftrace, " 0)   ==========> |", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)   <========== |", out);
+	/* Target exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	first_act = strstr(out_buf, "==========>");
+	if (!first_act) {
+		pr_debug("FAILED: IRQ marker inside target suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	second_act = strstr(first_act + 1, "==========>");
+	if (second_act) {
+		pr_debug("FAILED: IRQ marker outside target leaked\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 27. Test !has_retaddr dropped target root exit does not leak non-target.
+	 */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 0;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Target root enters at indent 2; exit is dropped */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	/* Non-target enters at indent 2 without retaddr */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  nontarget_leak() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    nontarget_child();", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |  }", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "nontarget_leak")) {
+		pr_debug("FAILED: nontarget_leak leaked after dropped target exit (!has_retaddr)\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 28. Test !in_target unwinds frames with raw_indent >= leading_spaces
+	 * before pushing to avoid stale ancestor accumulation.
+	 */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Non-target stale ancestor enters at indent 2; exit is dropped */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  stale_ancestor() {", out);
+	/* Real non-target parent enters at indent 2 (same indent) */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  real_parent() {", out);
+	/* Real parent calls target root */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-real_parent+0x10 */", out);
+	/* Target calls child that has return address pointing to stale_ancestor */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      shared_child(); /* <-stale_ancestor+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |    } /* activate_task */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  } /* real_parent */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "stale_ancestor() {")) {
+		pr_debug("FAILED: stale_ancestor leaked\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: activate_task missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 29. Test has_retaddr dropped target root exit followed by non-target
+	 * entry at root indent resets target state and allows subsequent
+	 * child target invocation.
+	 */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Target root 1 enters at indent 2; exit is DROPPED by ring buffer */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+
+	/* Non-target parent enters at indent 2 with retaddr to untraced caller */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  unrelated_caller() { /* <-untraced_kernel+0x10 */", out);
+
+	/* Unrelated caller invokes target root as child at indent 4 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-unrelated_caller+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      enqueue_task(); /* <-activate_task+0x30 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |    } /* activate_task */", out);
+
+	/* Unrelated caller exits with bare closing brace '}' at indent 2 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  }", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "unrelated_caller")) {
+		pr_debug("FAILED: unrelated_caller leaked\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: child target enqueue_task missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 30. Test noduration IRQ markers outside target function are suppressed
+	 * with -G, but preserved when inside target callgraph.
+	 */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	ftrace.graph_noduration = true;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Noduration IRQ marker outside target */
+	ftrace_process_fgraph_line(&ftrace, " 0) ==========>", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) <==========", out);
+
+	/* Target enters */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)  activate_task() {", out);
+	/* Noduration IRQ marker inside target */
+	ftrace_process_fgraph_line(&ftrace, " 0) ==========>", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) <==========", out);
+	/* Target exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+	ftrace.graph_noduration = false;
+
+	first_act = strstr(out_buf, "==========>");
+	if (!first_act) {
+		pr_debug("FAILED: noduration IRQ marker inside target suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	second_act = strstr(first_act + 1, "==========>");
+	if (second_act) {
+		pr_debug("FAILED: noduration IRQ marker outside target leaked\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 31. Test ancestor frame preservation when ancestor calls sibling
+	 * at leading_spaces <= target_root_indent after dropped target root exit.
+	 */
+	ftrace.use_inline = false;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Ancestor schedule() enters at indent 2 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  schedule() {", out);
+	/* Target function enters at indent 4 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-schedule+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      enqueue_task(); /* <-activate_task+0x20 */", out);
+	/* Target root exit is DROPPED by ring buffer */
+	/*
+	 * Ancestor schedule() calls sibling non-target function at indent 4
+	 * with return address pointing into schedule (caller_idx == 0 < target_root_depth).
+	 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    context_switch() { /* <-schedule+0x50 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    }", out);
+	/* Ancestor schedule() calls target function again at indent 4 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-schedule+0x60 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      enqueue_task(); /* <-activate_task+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |    } /* activate_task */", out);
+	/* Ancestor schedule() exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  } /* schedule */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "schedule")) {
+		pr_debug("FAILED: ancestor schedule leaked\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "context_switch")) {
+		pr_debug("FAILED: sibling context_switch leaked\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	first_act = strstr(out_buf, "activate_task() {");
+	second_act = first_act ? strstr(first_act + 1, "activate_task() {") : NULL;
+	if (!first_act || !second_act) {
+		pr_debug("FAILED: target function not tracked across ancestor sibling call\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 32. Test recovery when both an orphan exit and enclosing target root exit
+	 * are dropped by ring buffer.
+	 */
+	/* 32a. Followed by non-target entry at root indent and child target invocation */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Target root enters at indent 2 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	/* Detached orphan interrupt enters inside target at indent 4 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    smp_apic_timer_interrupt() { /* <-irq_work+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      irq_sub(); /* <-smp_apic_timer_interrupt+0x20 */", out);
+	/* Orphan exit and target root exit are BOTH DROPPED by ring buffer */
+	/* Non-target caller enters at root indent 2 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  unrelated_caller() { /* <-untraced_kernel+0x10 */", out);
+	/* Unrelated caller invokes target root as child at indent 4 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-unrelated_caller+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      enqueue_task(); /* <-activate_task+0x30 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |    } /* activate_task */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  }", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "smp_apic_timer_interrupt") || strstr(out_buf, "irq_sub")) {
+		pr_debug("FAILED: orphan leaked into output\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "unrelated_caller")) {
+		pr_debug("FAILED: unrelated_caller leaked into output\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: target child enqueue_task missing after double drop recovery\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 32b. Followed by ancestor exit at root indent */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Ancestor schedule() enters at indent 2 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  schedule() {", out);
+	/* Target function enters at indent 4 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-schedule+0x10 */", out);
+	/* Orphan interrupt enters at indent 6 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      smp_apic_timer_interrupt() { /* <-irq_work+0x10 */", out);
+	/* Orphan exit and target root exit are BOTH DROPPED by ring buffer */
+	/* Ancestor schedule() exits at indent 2 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  } /* schedule */", out);
+	/* Subsequent target function invocation */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |    enqueue_task();", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "schedule")) {
+		pr_debug("FAILED: ancestor schedule leaked after double drop exit\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "smp_apic_timer_interrupt")) {
+		pr_debug("FAILED: orphan smp_apic_timer_interrupt leaked\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: subsequent target invocation suppressed after double drop exit\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+out_free_filter:
+	if (out_buf)
+		free(out_buf);
+	list_for_each_entry_safe(pos, tmp, &ftrace.graph_funcs, list) {
+		list_del(&pos->list);
+		free(pos);
+	}
+	return ret;
+}
+
 static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret;
@@ -1082,6 +3257,10 @@ static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __ma
 	if (ret != TEST_OK)
 		return ret;
 
+	ret = test_graph_target_filter();
+	if (ret != TEST_OK)
+		return ret;
+
 	ret = test_inline_processing();
 	if (ret != TEST_OK)
 		return ret;
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index 515d69a576fd..a0cc4228569c 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -23,6 +23,7 @@
 #include "srcline.h"
 #include "symbol.h"
 #include "util/ftrace.h"
+#include "util/string2.h"
 #include <perf/threadmap.h>
 
 #define FTRACE_MAX_CPUS 4096
@@ -43,10 +44,16 @@ struct ftrace_stack_frame {
 struct ftrace_task_state {
 	struct hlist_node	node;
 	pid_t			pid;
-	struct ftrace_stack_frame stack[FTRACE_MAX_STACK];
+	struct ftrace_stack_frame *stack;
+	int			max_stack;
 	int			depth;
 	int			inlined_depth;
-	int			overflow_depth;
+	bool			in_target;
+	int			target_root_depth;
+	int			target_root_frame_idx;
+	int			target_root_indent;
+	char			target_root_name[128];
+	int			orphan_depth;
 };
 
 #define ftrace_cpu_state ftrace_task_state
@@ -71,6 +78,7 @@ void ftrace_cpu_states__clear(void)
 		hlist_for_each_entry_safe(ts, tmp, &ftrace_task_hash[i], node) {
 			for (j = 0; j < ts->depth; j++)
 				free(ts->stack[j].name);
+			free(ts->stack);
 			hlist_del_init(&ts->node);
 			free(ts);
 		}
@@ -119,6 +127,13 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
 	if (!ts)
 		return NULL;
 
+	ts->stack = calloc(FTRACE_MAX_STACK, sizeof(*ts->stack));
+	if (!ts->stack) {
+		free(ts);
+		return NULL;
+	}
+	ts->max_stack = FTRACE_MAX_STACK;
+
 	ts->pid = pid;
 	key = hash_32((u32)pid, FTRACE_PID_HASH_BITS);
 	head = &ftrace_task_hash[key];
@@ -126,6 +141,32 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
 	return ts;
 }
 
+/**
+ * ftrace_task_state__grow_stack - Double the capacity of a task's call stack
+ * @cs: Task state whose stack should be resized
+ *
+ * Reallocate @cs->stack with twice the current capacity, zero-initialising
+ * the newly allocated frames.
+ *
+ * Return: 0 on success, or -ENOMEM if memory allocation fails.
+ */
+static int ftrace_task_state__grow_stack(struct ftrace_task_state *cs)
+{
+	int new_max = cs->max_stack ? cs->max_stack * 2 : FTRACE_MAX_STACK;
+	struct ftrace_stack_frame *new_stack;
+
+	new_stack = realloc(cs->stack, new_max * sizeof(*new_stack));
+	if (!new_stack) {
+		pr_err("Not enough memory to resize ftrace stack\n");
+		return -ENOMEM;
+	}
+
+	memset(new_stack + cs->max_stack, 0, (new_max - cs->max_stack) * sizeof(*new_stack));
+	cs->stack = new_stack;
+	cs->max_stack = new_max;
+	return 0;
+}
+
 /**
  * ftrace_task_state__rekey - Reassign a task state to a new PID
  * @ts: The task state to re-key
@@ -141,8 +182,8 @@ static struct ftrace_task_state *ftrace_task_state__rekey(struct ftrace_task_sta
 {
 	struct ftrace_task_state *existing;
 	u32 key;
-	int keep_existing;
 	int j, c;
+	int to_copy;
 
 	if (ts->pid == new_pid)
 		return ts;
@@ -157,55 +198,51 @@ static struct ftrace_task_state *ftrace_task_state__rekey(struct ftrace_task_sta
 					ftrace_cpu_tasks[c] = ts;
 			}
 			hlist_del_init(&existing->node);
+			free(existing->stack);
 			free(existing);
 		} else {
 			for (c = 0; c < FTRACE_MAX_CPUS; c++) {
 				if (ftrace_cpu_tasks[c] == ts)
 					ftrace_cpu_tasks[c] = existing;
 			}
+			while (existing->depth + ts->depth > existing->max_stack) {
+				if (ftrace_task_state__grow_stack(existing) < 0)
+					break;
+			}
 
-			if (ts->depth >= FTRACE_MAX_STACK) {
-				for (j = 0; j < existing->depth; j++) {
-					if (!existing->stack[j].inlined)
-						existing->overflow_depth++;
-					free(existing->stack[j].name);
+			to_copy = ts->depth;
+			if (to_copy > 0) {
+				if (existing->depth + to_copy > existing->max_stack)
+					to_copy = existing->max_stack - existing->depth;
+
+				memmove(&existing->stack[to_copy], &existing->stack[0],
+					existing->depth * sizeof(existing->stack[0]));
+				memcpy(&existing->stack[0], &ts->stack[0],
+				       to_copy * sizeof(existing->stack[0]));
+
+				if (ts->in_target) {
+					existing->in_target = true;
+					existing->target_root_depth = ts->target_root_depth;
+					existing->target_root_frame_idx = ts->target_root_frame_idx;
+					existing->target_root_indent = ts->target_root_indent;
+					strlcpy(existing->target_root_name, ts->target_root_name,
+						sizeof(existing->target_root_name));
+				} else if (existing->in_target &&
+					   existing->target_root_frame_idx >= 0) {
+					existing->target_root_depth += to_copy;
+					existing->target_root_frame_idx += to_copy;
 				}
-				existing->inlined_depth = 0;
-				for (j = 0; j < FTRACE_MAX_STACK; j++) {
+
+				existing->depth += to_copy;
+				for (j = 0; j < to_copy; j++) {
 					if (ts->stack[j].inlined)
 						existing->inlined_depth++;
 				}
-				memcpy(&existing->stack[0], &ts->stack[0],
-				       FTRACE_MAX_STACK * sizeof(existing->stack[0]));
-				existing->depth = FTRACE_MAX_STACK;
-				existing->overflow_depth += ts->overflow_depth;
-			} else if (existing->depth + ts->depth > FTRACE_MAX_STACK) {
-				keep_existing = FTRACE_MAX_STACK - ts->depth;
-
-				for (j = keep_existing; j < existing->depth; j++) {
-					if (!existing->stack[j].inlined)
-						existing->overflow_depth++;
-					else
-						existing->inlined_depth--;
-					free(existing->stack[j].name);
-				}
-				memmove(&existing->stack[ts->depth], &existing->stack[0],
-					keep_existing * sizeof(existing->stack[0]));
-				memcpy(&existing->stack[0], &ts->stack[0],
-				       ts->depth * sizeof(existing->stack[0]));
-				existing->depth = FTRACE_MAX_STACK;
-				existing->inlined_depth += ts->inlined_depth;
-				existing->overflow_depth += ts->overflow_depth;
-			} else {
-				memmove(&existing->stack[ts->depth], &existing->stack[0],
-					existing->depth * sizeof(existing->stack[0]));
-				memcpy(&existing->stack[0], &ts->stack[0],
-				       ts->depth * sizeof(existing->stack[0]));
-				existing->depth += ts->depth;
-				existing->inlined_depth += ts->inlined_depth;
-				existing->overflow_depth += ts->overflow_depth;
+				for (j = to_copy; j < ts->depth; j++)
+					free(ts->stack[j].name);
 			}
 
+			free(ts->stack);
 			free(ts);
 			return existing;
 		}
@@ -546,6 +583,52 @@ static void extract_exit_func_name(const char *str, char *buf, size_t size)
 	buf[i] = '\0';
 }
 
+/**
+ * push_nontarget_frame - Push non-target entry frame to call stack
+ * @cs: CPU stack state
+ * @func_start: Pointer to start of function name in trace record
+ * @leading_spaces: Indentation of trace record
+ *
+ * Return: 0 on success, or negative error code on failure.
+ */
+static int push_nontarget_frame(struct ftrace_task_state *cs, const char *func_start,
+				int leading_spaces)
+{
+	char entry_name[128];
+
+	extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
+	if (cs->depth >= cs->max_stack && ftrace_task_state__grow_stack(cs) < 0)
+		return -ENOMEM;
+
+	cs->stack[cs->depth].name = strdup(entry_name);
+	if (!cs->stack[cs->depth].name) {
+		pr_err("Not enough memory\n");
+		return -ENOMEM;
+	}
+	cs->stack[cs->depth].inlined = false;
+	cs->stack[cs->depth].indent = leading_spaces;
+	cs->stack[cs->depth].raw_indent = leading_spaces;
+	cs->depth++;
+	return 0;
+}
+
+/**
+ * reset_target_root_state - Clear graph target filter state for a task
+ * @cs: Task state to reset
+ *
+ * Reset all state tracking associated with an active graph target filter,
+ * restoring the task to an out-of-target state.
+ */
+static void reset_target_root_state(struct ftrace_task_state *cs)
+{
+	cs->in_target = false;
+	cs->target_root_depth = 0;
+	cs->target_root_frame_idx = 0;
+	cs->target_root_indent = 0;
+	cs->target_root_name[0] = '\0';
+	cs->orphan_depth = 0;
+}
+
 /**
  * make_blank_prefix - Create a blank prefix mirroring a trace record's context
  * @ftrace: Perf ftrace context
@@ -601,6 +684,40 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
 	}
 }
 
+/**
+ * parse_graph_cpu - Extract CPU number from a function_graph trace record
+ * @ftrace: Perf ftrace context
+ * @line: The trace record to parse
+ * @cpu: Pointer to store the CPU number
+ *
+ * Return: true if CPU was successfully parsed, false otherwise.
+ */
+static bool parse_graph_cpu(const struct perf_ftrace *ftrace,
+			    const char *line, int *cpu)
+{
+	const char *p = line;
+	char *endptr;
+	long val;
+
+	if (ftrace->graph_verbose) {
+		p = strchr(p, '|');
+		if (!p)
+			return false;
+		p++;
+	}
+
+	p = skip_spaces(p);
+	val = strtol(p, &endptr, 10);
+	if (endptr == p || *endptr != ')')
+		return false;
+
+	if (val < 0 || val >= FTRACE_MAX_CPUS)
+		return false;
+
+	*cpu = (int)val;
+	return true;
+}
+
 /**
  * find_func_column - Locate the function call column in a trace record
  * @ftrace: Perf ftrace context
@@ -718,6 +835,201 @@ static int print_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
 	return 0;
 }
 
+/**
+ * ftrace_has_graph_funcs - Test whether graph target filters are active
+ * @ftrace: Perf ftrace context
+ *
+ * Return: true if any target filter functions are configured, false otherwise.
+ */
+static inline bool ftrace_has_graph_funcs(const struct perf_ftrace *ftrace)
+{
+	return ftrace->graph_funcs.next != NULL && !list_empty(&ftrace->graph_funcs);
+}
+
+/**
+ * ftrace_is_graph_func - Check if a function matches the graph_funcs target filter
+ * @ftrace: Perf ftrace context
+ * @func_name: The function name to test
+ *
+ * Return: true if ftrace->graph_funcs is empty or @func_name matches a
+ * target filter (including glob and compiler clone matches), false otherwise.
+ */
+static bool ftrace_is_graph_func(const struct perf_ftrace *ftrace, const char *func_name)
+{
+	struct filter_entry *pos;
+	char base_name[128];
+	const char *dot;
+
+	if (!ftrace_has_graph_funcs(ftrace))
+		return true;
+
+	/* Extract base symbol name by stripping compiler clone suffixes (.isra.*, .part.*, etc.) */
+	dot = strchr(func_name, '.');
+	if (dot) {
+		size_t base_len = dot - func_name;
+
+		if (base_len < sizeof(base_name)) {
+			memcpy(base_name, func_name, base_len);
+			base_name[base_len] = '\0';
+		} else {
+			dot = NULL;
+		}
+	}
+
+	list_for_each_entry(pos, &ftrace->graph_funcs, list) {
+		/* Fast path: non-glob patterns */
+		if (!strisglob(pos->name)) {
+			size_t len = strlen(pos->name);
+
+			if (strcmp(pos->name, func_name) == 0)
+				return true;
+			if (!strncmp(pos->name, func_name, len) &&
+			    (func_name[len] == '\0' || func_name[len] == '.'))
+				return true;
+			continue;
+		}
+
+		/* Glob pattern matching */
+		if (strglobmatch(func_name, pos->name))
+			return true;
+		if (dot && strglobmatch(base_name, pos->name))
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * ftrace_reset_to_target_root - Initialise a new target root frame state
+ * @cs: Task state to update
+ * @entry_name: Function symbol name matching the graph filter
+ * @depth: Call stack depth at which the target root function entered
+ * @leading_spaces: Indentation of the target root function
+ *
+ * Mark the task as actively inside a target filter hierarchy rooted at @depth
+ * for function @entry_name, and clear any stale orphan tracking depth.
+ */
+static void ftrace_reset_to_target_root(struct ftrace_task_state *cs,
+					const char *entry_name, int depth,
+					int leading_spaces)
+{
+	cs->in_target = true;
+	cs->target_root_depth = depth;
+	cs->target_root_frame_idx = depth;
+	cs->target_root_indent = leading_spaces;
+	strlcpy(cs->target_root_name, entry_name, sizeof(cs->target_root_name));
+	cs->orphan_depth = 0;
+}
+
+/**
+ * ftrace_unwind_to_depth - Unwind call stack frames down to a specified depth
+ * @cs: Task state whose call stack is unwound
+ * @target_depth: Depth to unwind down to
+ * @blank_prefix: Column alignment prefix for synthesised closing lines
+ * @out: File stream to output to, or NULL if suppressing output
+ *
+ * Pop and free call stack frames until the stack depth reaches @target_depth.
+ * For any inlined frames encountered, decrement the inlined depth counter
+ * and, if @out is non-NULL, emit the corresponding synthesised inline closing
+ * delimiter line.
+ */
+static void ftrace_unwind_to_depth(struct ftrace_task_state *cs, int target_depth,
+				   const char *blank_prefix, FILE *out)
+{
+	while (cs->depth > target_depth) {
+		struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
+
+		if (top->inlined) {
+			if (cs->inlined_depth > 0)
+				cs->inlined_depth--;
+			if (out)
+				fprintf(out, "%s%*s} /* %s (inline) */\n",
+					blank_prefix, top->indent, "", top->name);
+		}
+		free(top->name);
+		cs->depth--;
+	}
+}
+
+/**
+ * ftrace_check_target_caller - Validate caller of function inside target filter
+ * @ftrace: Perf ftrace context
+ * @cs: CPU stack state
+ * @func_start: Pointer to start of function name in trace record
+ * @entry_name: Function entry symbol name
+ * @is_graph_target: Whether function matches target filter
+ * @leading_spaces: Indentation of trace record
+ * @has_open_brace: Whether record opens a frame
+ * @has_semicolon: Whether record is a leaf call
+ * @has_retaddr: Whether return address comment was parsed
+ * @caller_idx: Index of caller on tracked stack, or -1 if untraced
+ * @blank_prefix: Space prefix for synthesised closing lines
+ * @out: File stream to output to
+ * @is_target_root: Pointer to target root flag to update
+ *
+ * Return: 1 if line should be dropped (orphan or non-target ancestor),
+ *         0 if entry should proceed as valid call or new target root,
+ *         negative error code on memory failure.
+ */
+static int ftrace_check_target_caller(struct perf_ftrace *ftrace,
+				      struct ftrace_task_state *cs,
+				      const char *func_start,
+				      const char *entry_name,
+				      bool is_graph_target,
+				      int leading_spaces,
+				      bool has_open_brace,
+				      bool has_semicolon,
+				      bool has_retaddr,
+				      int caller_idx,
+				      const char *blank_prefix,
+				      FILE *out,
+				      bool *is_target_root)
+{
+	if (!ftrace_has_graph_funcs(ftrace) || !cs->in_target ||
+	    cs->depth <= cs->target_root_depth)
+		return 0;
+
+	if (has_retaddr && caller_idx >= 0 && caller_idx < cs->target_root_depth) {
+		ftrace_unwind_to_depth(cs, caller_idx + 1, blank_prefix, out);
+		if (is_graph_target) {
+			ftrace_reset_to_target_root(cs, entry_name, cs->depth,
+						    leading_spaces);
+			*is_target_root = true;
+			return 0;
+		}
+		reset_target_root_state(cs);
+		if (has_open_brace && !has_semicolon &&
+		    push_nontarget_frame(cs, func_start, leading_spaces) < 0)
+			return -ENOMEM;
+		return 1;
+	}
+
+	if (leading_spaces <= cs->target_root_indent) {
+		ftrace_unwind_to_depth(cs, 0, blank_prefix, out);
+		if (is_graph_target) {
+			ftrace_reset_to_target_root(cs, entry_name, 0,
+						    leading_spaces);
+			*is_target_root = true;
+			return 0;
+		}
+		reset_target_root_state(cs);
+		if (has_open_brace && !has_semicolon &&
+		    push_nontarget_frame(cs, func_start, leading_spaces) < 0)
+			return -ENOMEM;
+		return 1;
+	}
+
+	if (has_retaddr) {
+		if (caller_idx < 0) {
+			if (has_open_brace && !has_semicolon)
+				cs->orphan_depth = 1;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * ftrace_process_fgraph_line - Process and output a function graph trace line
  * @ftrace: Perf ftrace context
@@ -749,16 +1061,33 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	int active_inlines;
 	int common;
 	int match_idx;
-	int top_raw_indent;
+	int ret;
 	int i, j;
+	char entry_name[128];
 	bool is_exit;
 	bool has_open_brace;
 	bool has_semicolon;
 	bool has_retaddr = false;
+	bool has_filter = ftrace_has_graph_funcs(ftrace);
+	bool is_graph_target = false;
+	bool is_target_root = false;
+	bool was_target_root = false;
 
-	if (!ftrace->use_inline)
+	if ((!has_filter || ftrace->graph_thresh) && !ftrace->use_inline)
 		return print_line(ftrace, line, out);
 
+	if (strstr(line, "==========>") != NULL ||
+	    strstr(line, "<==========") != NULL) {
+		if (has_filter && parse_graph_cpu(ftrace, line, &cpu)) {
+			cs = get_cpu_state(ftrace, cpu);
+			if (cs && cs->in_target && cs->orphan_depth == 0)
+				print_line(ftrace, line, out);
+		} else if (!has_filter) {
+			print_line(ftrace, line, out);
+		}
+		return 0;
+	}
+
 	pipe_char = find_func_column(ftrace, line, &cpu);
 	if (!pipe_char) {
 		parse_context_switch(line);
@@ -786,30 +1115,17 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
 		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
 
-		top_raw_indent = -1;
-		for (i = cs->depth - 1; i >= 0; i--) {
-			if (!cs->stack[i].inlined) {
-				top_raw_indent = cs->stack[i].raw_indent;
-				break;
+		if (cs->orphan_depth > 0) {
+			if (has_filter && cs->in_target &&
+			    leading_spaces <= cs->target_root_indent) {
+				cs->orphan_depth = 0;
+			} else {
+				cs->orphan_depth--;
+				return 0;
 			}
 		}
 
-		/*
-		 * If currently overflowed beyond FTRACE_MAX_STACK, any exit whose
-		 * indentation is deeper than the top tracked frame belongs to the
-		 * overflow region.
-		 */
-		if (cs->overflow_depth > 0 &&
-		    (top_raw_indent < 0 || leading_spaces > top_raw_indent)) {
-			cs->overflow_depth--;
-			extra_indent = cs->inlined_depth * 2;
-			fprintf(out, "%.*s%*s%s\n",
-				(int)(pipe_char - line + 1), line,
-				leading_spaces + extra_indent, "", func_start);
-			return 0;
-		}
-
-		/* Find matching frame on stack */
+		/* Find matching frame on stack if exit is named */
 		match_idx = -1;
 		if (exit_name[0] != '\0') {
 			for (i = cs->depth - 1; i >= 0; i--) {
@@ -836,17 +1152,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		}
 
 		if (match_idx >= 0) {
-			cs->overflow_depth = 0;
-		} else if (cs->overflow_depth > 0) {
-			cs->overflow_depth--;
-			extra_indent = cs->inlined_depth * 2;
-			fprintf(out, "%.*s%*s%s\n",
-				(int)(pipe_char - line + 1), line,
-				leading_spaces + extra_indent, "", func_start);
-			return 0;
-		}
+			was_target_root = (has_filter && cs->in_target &&
+					   match_idx == cs->target_root_frame_idx);
 
-		if (match_idx >= 0) {
 			/* Close all inlined and orphaned frames above match_idx */
 			while (cs->depth > 0 && cs->depth - 1 > match_idx) {
 				struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
@@ -856,8 +1164,10 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
 					if (cs->inlined_depth > 0)
 						cs->inlined_depth--;
-					fprintf(out, "%s%*s} /* %s (inline) */\n",
-						blank_prefix, exit_indent, "", top->name);
+					if (!has_filter || (cs->in_target &&
+					    cs->depth - 1 >= cs->target_root_depth))
+						fprintf(out, "%s%*s} /* %s (inline) */\n",
+							blank_prefix, exit_indent, "", top->name);
 				}
 				free(top->name);
 				cs->depth--;
@@ -875,9 +1185,36 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 			extra_indent = 0;
 		}
 
-		fprintf(out, "%.*s%*s%s\n",
-			(int)(pipe_char - line + 1), line,
-			leading_spaces + extra_indent, "", func_start);
+		if (!has_filter || (cs->in_target && match_idx >= cs->target_root_depth)) {
+			if (!ftrace->use_inline) {
+				print_line(ftrace, line, out);
+			} else {
+				fprintf(out, "%.*s%*s%s\n",
+					(int)(pipe_char - line + 1), line,
+					leading_spaces + extra_indent, "", func_start);
+			}
+		}
+
+		if (has_filter && cs->in_target) {
+			if (was_target_root) {
+				while (cs->depth > cs->target_root_depth &&
+				       cs->stack[cs->depth - 1].inlined) {
+					struct ftrace_stack_frame *top =
+						&cs->stack[cs->depth - 1];
+					int exit_indent = top->indent;
+
+					if (cs->inlined_depth > 0)
+						cs->inlined_depth--;
+					fprintf(out, "%s%*s} /* %s (inline) */\n",
+						blank_prefix, exit_indent, "", top->name);
+					free(top->name);
+					cs->depth--;
+				}
+				reset_target_root_state(cs);
+			} else if (cs->depth <= cs->target_root_depth) {
+				reset_target_root_state(cs);
+			}
+		}
 		return 0;
 	}
 
@@ -885,30 +1222,13 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	has_open_brace = (strchr(func_start, '{') != NULL);
 	has_semicolon = (strchr(func_start, ';') != NULL);
 
-	top_raw_indent = -1;
-	for (i = cs->depth - 1; i >= 0; i--) {
-		if (!cs->stack[i].inlined) {
-			top_raw_indent = cs->stack[i].raw_indent;
-			break;
-		}
-	}
-
-	if (cs->overflow_depth > 0 && top_raw_indent >= 0 &&
-	    leading_spaces <= top_raw_indent)
-		cs->overflow_depth = 0;
+	extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
+	if (has_filter)
+		is_graph_target = ftrace_is_graph_func(ftrace, entry_name);
 
+	caller_idx = -1;
 	if (ftrace_parse_retaddr(func_start, caller_sym, sizeof(caller_sym), &caller_offset)) {
 		has_retaddr = true;
-		num_inlines = ftrace_resolve_inlines(ftrace->machine, caller_sym,
-						      caller_offset, inlined_names,
-						      FTRACE_MAX_INLINES);
-		if (num_inlines < 0)
-			return num_inlines;
-	}
-
-	/* Determine which inlined frames are currently open above the caller */
-	caller_idx = -1;
-	if (has_retaddr && cs->overflow_depth == 0) {
 		for (i = cs->depth - 1; i >= 0; i--) {
 			if (!cs->stack[i].inlined && cs->stack[i].name &&
 			    cs->stack[i].raw_indent < leading_spaces &&
@@ -919,11 +1239,135 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		}
 	}
 
-	/* If caller is not on the tracked stack, do not synthesise inlines */
-	if (has_retaddr && caller_idx < 0) {
+	if (cs->orphan_depth > 0) {
+		/*
+		 * If an orphan exit was dropped by the kernel ring buffer,
+		 * check whether this entry is a new target root function
+		 * or descends directly from the target root function.
+		 */
+		if (has_filter && cs->in_target) {
+			if (leading_spaces <= cs->target_root_indent) {
+				cs->orphan_depth = 0;
+			} else if (cs->target_root_name[0] != '\0' && has_retaddr &&
+				   leading_spaces == cs->target_root_indent + 2) {
+				if (strcmp(cs->target_root_name, caller_sym) == 0)
+					cs->orphan_depth = 0;
+			}
+		}
+
+		if (cs->orphan_depth > 0) {
+			if (has_open_brace && !has_semicolon)
+				cs->orphan_depth++;
+			return 0;
+		}
+	}
+
+	if (has_filter) {
+		if (cs->depth == 0 || !cs->in_target) {
+			if (is_graph_target) {
+				if (has_retaddr && caller_idx >= 0)
+					ftrace_unwind_to_depth(cs, caller_idx + 1,
+							       blank_prefix,
+							       ftrace->use_inline ? out : NULL);
+				else
+					ftrace_unwind_to_depth(cs, 0,
+							       blank_prefix,
+							       ftrace->use_inline ? out : NULL);
+				ftrace_reset_to_target_root(cs, entry_name, cs->depth,
+							    leading_spaces);
+				is_target_root = true;
+			} else if (cs->depth == 0) {
+				reset_target_root_state(cs);
+			}
+		}
+
+		if (!cs->in_target) {
+			/* Non-matching call tree; track depth if entering scope, suppress output */
+			while (cs->depth > 0 &&
+			       cs->stack[cs->depth - 1].raw_indent >= leading_spaces) {
+				free(cs->stack[cs->depth - 1].name);
+				cs->depth--;
+			}
+			if (has_open_brace && !has_semicolon) {
+				if (push_nontarget_frame(cs, func_start, leading_spaces) < 0)
+					return -ENOMEM;
+			}
+			return 0;
+		}
+	}
+
+	if (!ftrace->use_inline) {
+		if (is_target_root) {
+			if (has_retaddr && caller_idx >= 0)
+				ftrace_unwind_to_depth(cs, caller_idx + 1, NULL, NULL);
+			else
+				ftrace_unwind_to_depth(cs, 0, NULL, NULL);
+			cs->target_root_depth = cs->depth;
+			cs->target_root_frame_idx = cs->depth;
+			cs->target_root_indent = leading_spaces;
+		}
+
+		ret = ftrace_check_target_caller(ftrace, cs, func_start, entry_name,
+						 is_graph_target, leading_spaces,
+						 has_open_brace, has_semicolon,
+						 has_retaddr, caller_idx, NULL, NULL,
+						 &is_target_root);
+		if (ret != 0)
+			return (ret < 0) ? ret : 0;
+
+		if (!is_target_root) {
+			if (has_retaddr && caller_idx >= 0) {
+				if (cs->depth > caller_idx + 1)
+					ftrace_unwind_to_depth(cs, caller_idx + 1, NULL, NULL);
+			} else if (caller_idx < 0) {
+				while (cs->depth > cs->target_root_depth &&
+				       cs->stack[cs->depth - 1].raw_indent >= leading_spaces) {
+					free(cs->stack[cs->depth - 1].name);
+					cs->depth--;
+				}
+			}
+		}
+
+		if (has_open_brace && !has_semicolon) {
+			if (is_target_root) {
+				cs->target_root_frame_idx = cs->depth;
+				cs->target_root_indent = leading_spaces;
+			}
+			if (push_nontarget_frame(cs, func_start, leading_spaces) < 0)
+				return -ENOMEM;
+		}
+		print_line(ftrace, line, out);
+		if (has_filter && cs->in_target && is_target_root &&
+		    has_semicolon && !has_open_brace) {
+			reset_target_root_state(cs);
+		}
+		return 0;
+	}
+
+	if (has_retaddr) {
+		num_inlines = ftrace_resolve_inlines(ftrace->machine, caller_sym,
+						      caller_offset, inlined_names,
+						      FTRACE_MAX_INLINES);
+		if (num_inlines < 0)
+			return num_inlines;
+
+		/* If caller is not on the tracked stack, do not synthesise inlines */
+		if (caller_idx < 0) {
+			for (i = 0; i < num_inlines; i++)
+				free((void *)inlined_names[i]);
+			num_inlines = 0;
+		}
+	}
+
+	ret = ftrace_check_target_caller(ftrace, cs, func_start, entry_name,
+					 is_graph_target, leading_spaces,
+					 has_open_brace, has_semicolon,
+					 has_retaddr, caller_idx, blank_prefix,
+					 out, &is_target_root);
+	if (ret != 0) {
 		for (i = 0; i < num_inlines; i++)
 			free((void *)inlined_names[i]);
-		num_inlines = 0;
+		return (ret < 0) ? ret : 0;
 	}
 
 	active_inlines = 0;
@@ -948,9 +1392,6 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	}
 
 	/* Close stale callee frames and inactive inlined frames above caller */
-	if (caller_idx >= 0)
-		cs->overflow_depth = 0;
-
 	while (caller_idx >= 0 && cs->depth > caller_idx + 1 + common) {
 		struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
 
@@ -959,41 +1400,52 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
 			if (cs->inlined_depth > 0)
 				cs->inlined_depth--;
-			fprintf(out, "%s%*s} /* %s (inline) */\n",
-				blank_prefix, exit_indent, "", top->name);
+			if (!has_filter || (cs->in_target && !is_target_root))
+				fprintf(out, "%s%*s} /* %s (inline) */\n",
+					blank_prefix, exit_indent, "", top->name);
 		}
 		free(top->name);
 		cs->depth--;
 	}
 
-	if (caller_idx < 0 && cs->overflow_depth == 0) {
-		/*
-		 * If caller is not on the tracked stack, unwind any frames whose
-		 * raw indentation is greater than or equal to the new entry's
-		 * indentation (their exit events were dropped), and close any
-		 * trailing inlined frames that were left open from prior calls.
-		 */
-		while (cs->depth > 0) {
-			struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
+	if (caller_idx < 0) {
+		if (is_target_root) {
+			ftrace_unwind_to_depth(cs, 0, blank_prefix, out);
+		} else {
+			/*
+			 * If caller is not on the tracked stack, unwind any frames whose
+			 * raw indentation is greater than or equal to the new entry's
+			 * indentation (their exit events were dropped), and close any
+			 * trailing inlined frames that were left open from prior calls.
+			 */
+			while (cs->depth > 0) {
+				struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
 
-			if (top->inlined) {
-				int exit_indent = top->indent;
+				if (top->inlined) {
+					int exit_indent = top->indent;
 
-				if (cs->inlined_depth > 0)
-					cs->inlined_depth--;
-				fprintf(out, "%s%*s} /* %s (inline) */\n",
-					blank_prefix, exit_indent, "", top->name);
-				free(top->name);
-				cs->depth--;
-			} else if (top->raw_indent >= leading_spaces) {
-				free(top->name);
-				cs->depth--;
-			} else {
-				break;
+					if (cs->inlined_depth > 0)
+						cs->inlined_depth--;
+					if (!has_filter || (cs->in_target && !is_target_root))
+						fprintf(out, "%s%*s} /* %s (inline) */\n",
+							blank_prefix, exit_indent, "", top->name);
+					free(top->name);
+					cs->depth--;
+				} else if (top->raw_indent >= leading_spaces) {
+					free(top->name);
+					cs->depth--;
+				} else {
+					break;
+				}
 			}
 		}
 	}
 
+	if (is_target_root) {
+		cs->target_root_depth = cs->depth;
+		cs->target_root_indent = leading_spaces;
+	}
+
 	/* Open new inlined frames */
 	for (i = common; i < num_inlines; i++) {
 		int entry_indent = leading_spaces + cs->inlined_depth * 2;
@@ -1004,7 +1456,8 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 				free((void *)inlined_names[j]);
 			return -ENOMEM;
 		}
-		if (cs->depth >= FTRACE_MAX_STACK)
+		if (cs->depth >= cs->max_stack &&
+		    ftrace_task_state__grow_stack(cs) < 0)
 			break;
 
 		fprintf(out, "%s%*s%s() { /* (inline) */\n",
@@ -1049,24 +1502,48 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
 	/* If non-leaf entry, push onto stack */
 	if (has_open_brace && !has_semicolon) {
-		char entry_name[128];
-
-		extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
-		if (cs->depth < FTRACE_MAX_STACK) {
-			cs->stack[cs->depth].name = strdup(entry_name);
-			if (!cs->stack[cs->depth].name) {
-				pr_err("Not enough memory\n");
-				for (i = 0; i < num_inlines; i++)
-					free((void *)inlined_names[i]);
-				return -ENOMEM;
+		if (cs->depth >= cs->max_stack &&
+		    ftrace_task_state__grow_stack(cs) < 0) {
+			for (i = 0; i < num_inlines; i++)
+				free((void *)inlined_names[i]);
+			return -ENOMEM;
+		}
+
+		if (is_target_root) {
+			cs->target_root_frame_idx = cs->depth;
+			cs->target_root_indent = leading_spaces;
+		}
+
+		cs->stack[cs->depth].name = strdup(entry_name);
+		if (!cs->stack[cs->depth].name) {
+			pr_err("Not enough memory\n");
+			for (i = 0; i < num_inlines; i++)
+				free((void *)inlined_names[i]);
+			return -ENOMEM;
+		}
+		cs->stack[cs->depth].inlined = false;
+		cs->stack[cs->depth].indent = leading_spaces + extra_indent;
+		cs->stack[cs->depth].raw_indent = leading_spaces;
+		cs->depth++;
+	}
+
+	if (has_filter && cs->in_target && is_target_root &&
+	    has_semicolon && !has_open_brace) {
+		while (cs->depth > cs->target_root_depth) {
+			struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
+
+			if (top->inlined) {
+				int exit_indent = top->indent;
+
+				if (cs->inlined_depth > 0)
+					cs->inlined_depth--;
+				fprintf(out, "%s%*s} /* %s (inline) */\n",
+					blank_prefix, exit_indent, "", top->name);
 			}
-			cs->stack[cs->depth].inlined = false;
-			cs->stack[cs->depth].indent = leading_spaces + extra_indent;
-			cs->stack[cs->depth].raw_indent = leading_spaces;
-			cs->depth++;
-		} else {
-			cs->overflow_depth++;
+			free(top->name);
+			cs->depth--;
 		}
+		reset_target_root_state(cs);
 	}
 
 	for (i = 0; i < num_inlines; i++)
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index f611e9869913..d1e4df9c0db0 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -10,10 +10,18 @@ struct evlist;
 struct hashamp;
 struct stats;
 
+enum perf_ftrace_subcommand {
+	PERF_FTRACE_NONE,
+	PERF_FTRACE_TRACE,
+	PERF_FTRACE_LATENCY,
+	PERF_FTRACE_PROFILE,
+};
+
 struct perf_ftrace {
 	struct evlist		*evlist;
 	struct target		target;
 	const char		*tracer;
+	enum perf_ftrace_subcommand subcmd;
 	struct list_head	filters;
 	struct list_head	notrace;
 	struct list_head	graph_funcs;
-- 
2.55.0

