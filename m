Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.105
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655706;
	b=yxSrQrtuIRFT+kMYlkuAVFBOnaoQjLJNQajj3fxCQMKIBJhcknXYMdiVgBjUi5Yj5I1n
	 J3tdDHcJrDfrh0/EnMfvQQ8Vlz6XhBEJUtYWnYzzlHW18bxoh1re7AJmPOH+5B6h/phDs
	 /l1rKZzGYJK0hmC5gDhglmSBd41IVM27Wg028W81KAII/nloRkGWcdE+HRlphGEKuoeUW
	 f6K4maFL1ivTYB813REad+TuuCfBkiQP2zrhoJCLrLzjPT+/VITP4/cGjtmObsiAHPsaH
	 hXsfQVB7L2CxouyXPtT/AV091IkRGY0makDgUO6L+ZHNMWoBKrgrHqUr94pQYJCSJ+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655706;
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
	bh=XBkvIwGtxdkwwcLxI05/uxlrXiW5XH4bA04DhFnoHqY=;
	b=3QIzuaNa7LZBT8afXmV0wYIYaviyx15GaAG2AWmDsVv4G3bV0sWgsV/csBOhj1qOJhUE
	 G8uTjFIkEOPE8arNo+HwxZ9OCXO+q31wUZ2IBqPALYSGPyZaDAVDUMC3NBQIECOJ5MzjO
	 0SvCdaGDijaCKcQcS5Ny6lrzUM1zwp6nrE2WvSLN6FHZlsKuNpENelp3ZIPthlzrJrnuB
	 XdvXzMfTaCc/hEfPVLxAAv1Jf7iawhdYZyxzpdbTDdwyoQSn4PfixdVzkj5xrq3Si54Gh
	 JuRHTskxvNRFQJJSM9GKYnt0ufujYatWZYjtgUuBoXl8VEUIjo1mevvYKbjPFGhNZsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.105
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020105.outbound.protection.outlook.com [52.101.195.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A05606A326;
	Mon,  2 Nov 2026 21:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5A05606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLNr8Rubigk6kEwgKQRRGocZBaE3wFAWFVuzuO9Iqcz77rLOTycF08hqxqhYRPnUhKgrr3Hg7f129IwUJy3/IRaRR/l7gkqISXvkrkxW53SkCYBvYFx419mQgp4PjfNumcGpfgEKqeVxk2hXS0ms8ZUbvlRxZzGz0zaSNToALoNVm40MbxyTKM3UDHg8cngleA9h0AEUx+Y65uhCJJOek1DsXqyKwMXmqomSin2ZKNuUEHUbCup+vLJFwGGt94DE43gs0eaQYBCYCWssWfspDEkCBRDYoEB8w5Zvh9VWGn1cmVlpHe9y/9emwdAQtW2HFWI59AOtHw0elMs1gRSkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=XBkvIwGtxdkwwcLxI05/uxlrXiW5XH4bA04DhFnoHqY=;
 b=KgRs2YuBa7QiM4uzcZ/1tJPHHW+SpnI70IZeXDhmFBiJJ4BebBKKmzbrsreuT3qlthKOegnXb43WD8c4ryUCq7yRWY+VzSXEyldS2dm+83aEcJcWHpBd+cNc+3Nd7ECOh/gQ1zATfQWAXT+/6kkiWT7b/94n+AxVYL+/x7H9XrhMCv1YqQ1svrCiMhZsQlTV1MTAmHnNMLrA+jrsKBoL1/PFxFBK0kuXP1VQkXrjn5LuG9ezTUPntyvXgKa9nfVX5tgtlhiqKS2DOY8HdP2HZ5aP6CpX7XRx0Yz0CntzkMgA13JF9DH/Q0OKx/y+lnuw6VThmE5wwFCvfgt1sIEOHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO0P123MB3867.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:41:41 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:41:41 +0000
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
Subject: [PATCH perf-tools-next v13 10/10] perf ftrace: Filter extraneous functions in function graph tracer
Date: Mon,  2 Nov 2026 16:40:54 -0500
Message-ID: <20261102214054.911298-11-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102214054.911298-1-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::28) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO0P123MB3867:EE_
X-MS-Office365-Filtering-Correlation-Id: b2383aff-5dba-4a42-b2dd-08df392a1494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|3023799007|56012099006|5023799004|261026135527099003|261021130227099003|261022105027099003|261026130827099003|261021121427099003|261026121527099003|261022115727099003|261026140227099003|261022075727099003|261021123027099003|261022113327099003|261009223027099003|261028144727099003|261021133027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	bPQ9n2/VoTAge+WJtICZ8RUsAJQDoqsMF87eDD3bJMrAcPhsYLdpXPP6ff3rRFZwlfVdTGx2Nwash1/wZL0yWXiFjRe5VMckk2Jqf1scVh24/im8whYXZDTo9BSNC3cNzOG8PJjANV0SN/7zbGMNXCMHJJHgTOnc2x7+yLHVEWj13UR2113mgM7XymIuo8s8qIbcmPvdQIxBcTlCJlexiez3nII6n7GS4/tID0UJT3pClk04dwS/ntaILarGtof0p0Vc3W+BfyltPX+GJxRjcSYO7kLWIZalk/lkLbWg3lBMMKmhnovGbDlbQB8Q3aRUEJRPN7Ck76sdpTIbnLpj8pvhObMMBs5iq7qEnZAxOCsRZFiqClxAT2bxbMQL9x5tdtA5GR1i+jCFp0+GOUjvVjOm0TwVZ0oZoQXx2KKnjKFQ8Wl0wRRVb6wDEPuc8pPbEmbPnDCGsXXja37A6dyca1qjWzL6dVi0WmVYnPemfntx339Va4P3s365CcPhLZ3ql5RpeV/NvoAnlNs7j6oqi+SCLJIXI0aTePuKVGM1pWk/8fdgZo4m9UPhUMrei4Eal7bQrUbSXajU9VbGDn1G4dzuWLSVcgVM7B/1cp2UoclFUPH7SoQPryBj6Pi+7vOTAMSBou2CTPwCaRKChxsNpp6xoLBLWgadv6dRMxXmIJw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(3023799007)(56012099006)(5023799004)(261026135527099003)(261021130227099003)(261022105027099003)(261026130827099003)(261021121427099003)(261026121527099003)(261022115727099003)(261026140227099003)(261022075727099003)(261021123027099003)(261022113327099003)(261009223027099003)(261028144727099003)(261021133027099003)(261021135927099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tsg+tnx3SGyffZtok0BO4RyEJYyy2N8MbfglwYvmGSzP0QQ6ItgSDnkNIfo9?=
 =?us-ascii?Q?8vt5GiXZPHF38FsP+9g3woV+7wBDHYOgur+YWt/HL5+PcorG6E/YJvh4lsb6?=
 =?us-ascii?Q?I46YQuBzsGZVyivdghidtoVppa9zxVXG/QYCKJ0sG5KhF+xVZe4fGVIUKRR1?=
 =?us-ascii?Q?tMskkZZ5HT+uyrz9m1FtDM9V7T/Xu/fuKyrbkWpTckiT/lTOuj7hhWU/nNg/?=
 =?us-ascii?Q?5TXgHpTPa13yizlpwZ9l0hEqs87c/lf75GCcUOfe7bFjqr0m7CdZ6HcHhN3V?=
 =?us-ascii?Q?MDNsHN7A7y+D/YKZBo9bo82an30dSrp4BrkTCAhfMIltw+jneTxe2XVVRxji?=
 =?us-ascii?Q?t4lCE6m791+Byssp5zVC/qH/ibe5tXhVfz+T8BCVeBfj7B+5Zjnc7n3IaDrO?=
 =?us-ascii?Q?toZYy+XwbbCHw4L8FcGcmPmQvOxcKzxb21INJuNCi9RchVKSEQTVj0z2K4LA?=
 =?us-ascii?Q?Hin7ltgKwkhvJlJ7Losy5Ss1eT4JEd5y/mH6HnQk7f4M5Wbf0Qp0hqTD55aM?=
 =?us-ascii?Q?Vryh1vopk3J0N95jLHTj+8aMyBo7llpUgWyT2R/ygCzx4NhRXWsZ4Y0xLp1k?=
 =?us-ascii?Q?esNh7wXSlb4SkVMq5apqUZdSbg/e8JDlD1XT20K7yAIfl3yAexJ4jV5MLhOf?=
 =?us-ascii?Q?OsHeAV/TgwgUcukoYANyIIlGQf9kiRkQnO0mcIRLUsrI3doM5oSaCr6mAC/I?=
 =?us-ascii?Q?R7cJtXpSDv1IpASljRdZdTdxaXspFAXYezcKLsLARWRiC9+KXxJaQ70ADWys?=
 =?us-ascii?Q?cR4K5fS1mgx6kd25LSgdvy2oGjeraf/pIKwszmZQ8sdF57cZwpM4ZS0bMzJr?=
 =?us-ascii?Q?TTKM0AiAu7aYpE4elZ4PvfzefQSWYuvFaJjpywBigjIiDoJYjXb7NosuPjls?=
 =?us-ascii?Q?9POdce8ClqAwNyI416zEG8G8LyASqKc2ieeFF8tCmNGNMQAECN860ysoukEP?=
 =?us-ascii?Q?HRRpdoD0Soymw0rdryWFS9JSc03wOieqC8zowlCgCK0LkDnQwiHtC2eXe9tv?=
 =?us-ascii?Q?2hLhaaG2mRoeitwxIH9VgIvHirjc13QUvD+EP3USkmg+9FkgiqHdU6gPVaLP?=
 =?us-ascii?Q?OqGVnqhhJt+u32cVQiC3taEABktdtwZskAbW78ElPuSI2+CZINLN7zrNSQUW?=
 =?us-ascii?Q?iL3DHRSkhA8dss5ykjmJf4D0BJvnUXDIUJK44/E381kL2a5wTz8Sd37MNT1I?=
 =?us-ascii?Q?1uVH8AJ7Nc5emsIkpondwpRKrfiNrjbtlKRDwZNdriB9jTdkwUbHp31LC13w?=
 =?us-ascii?Q?Z/CuEPV2QfENgH6pEG+zJM0vfNVClO1UWhEizMduFjiXl+Yyv1ykCnu4PH3O?=
 =?us-ascii?Q?peWnb2NGm8LxyrTsn/8QpZNT7vgZvyAqRgWcPQ75mQaz+pfJuli1bV45S/Go?=
 =?us-ascii?Q?vIOdZS+ikcVb2qztObDinqVz8RXR4sksIKCzJLQgi8Js3VEWVLtMVpD4vwtk?=
 =?us-ascii?Q?ErmRreBqC0Z93KT9ldiUOE2r7Cx7Uh8dxfz6BIonCkqlqzCLOOB4+YxPLsro?=
 =?us-ascii?Q?8b8bblGdHx2NoUPWlGOdinSUswgiKfnGqQkyuKTnwdZKfeJCPtLuZMJgwOE4?=
 =?us-ascii?Q?TmldCAe4U1pLf1vyiSAkf7IUTEwQuJsMKVtrA9g86ox0IcWt2xuXRDI6cpMx?=
 =?us-ascii?Q?/APaOcpyUtAYAgMbx924KJPfR2RdLm67mkLfxAMtZ8Xb8bJ6XzcE/TFwnzXt?=
 =?us-ascii?Q?NP95B1yV/EGXE611Jt+KwOg5KhOkGb47xeh65nYYtE7hXJFFl9IpZMbm9Gwt?=
 =?us-ascii?Q?7lKml4gcQQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2383aff-5dba-4a42-b2dd-08df392a1494
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:41:40.9835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiP4LvP9+W87hBi46qblcZwGUgpk7noj68IZ767LEbShYZpXDX9VKyelgFZkwkRAPgW6Gcany3TA2kf6YrC2nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB3867

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

       Track active target callgraph state per-task in
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
       calls originating outside the target hierarchy (i.e. ring-buffer
       wakeups or asynchronous interrupts) are suppressed along with
       their subtrees (ts->orphan_depth).

       Exits within an orphan subtree are suppressed without querying
       the target stack, preventing common helpers
       (i.e. _raw_spin_unlock) from colliding with or prematurely
       unspooling active target frames. Dropped-orphan recovery safely
       resets orphan depth whenever an entry or exit occurs at or
       outside the target root indentation.

    3. Automated verification

       Add comprehensive regression tests in tools/perf/tests/ftrace.c
       (test_graph_target_filter()) validating top-level suppression,
       detached orphan suppression, glob matching, deep stack
       traversal, dropped-orphan recovery, and orphan exit collision
       prevention.

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-ftrace.c |   42 +-
 tools/perf/tests/ftrace.c   | 2451 +++++++++++++++++++++++++++++++++++
 tools/perf/util/ftrace.c    |  918 +++++++++++--
 tools/perf/util/ftrace.h    |    8 +
 4 files changed, 3276 insertions(+), 143 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index db9616ad68af..1302c9cbfcd6 100644
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
@@ -2013,6 +2024,8 @@ int cmd_ftrace(int argc, const char **argv)
 	if (subcmd == PERF_FTRACE_NONE)
 		subcmd = PERF_FTRACE_TRACE;
 
+	ftrace.subcmd = subcmd;
+
 	argc = parse_options(argc, argv, options, ftrace_usage,
 			    PARSE_OPT_STOP_AT_NON_OPTION);
 	if (argc < 0) {
@@ -2034,6 +2047,11 @@ int cmd_ftrace(int argc, const char **argv)
 				ret = -EINVAL;
 				goto out_delete_filters;
 			}
+			if (ftrace.graph_thresh) {
+				pr_err("Error: --inline cannot be combined with --graph-opts thresh\n");
+				ret = -EINVAL;
+				goto out_delete_filters;
+			}
 		}
 		cmd_func = __cmd_ftrace;
 		break;
diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
index ec3c26a01ef9..8e645d6eab2a 100644
--- a/tools/perf/tests/ftrace.c
+++ b/tools/perf/tests/ftrace.c
@@ -1478,6 +1478,2451 @@ static int test_context_switch_handling(void)
 }
 #undef TEST_CS_ASSERT
 
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
+		const char *saved_vmlinux = symbol_conf.vmlinux_name;
+		bool saved_ignore_buildid = symbol_conf.ignore_vmlinux_buildid;
+
+		symbol_conf.vmlinux_name = vmlinux;
+		symbol_conf.ignore_vmlinux_buildid = true;
+		if (perf_ftrace__setup_inlines(&ftrace) == 0 && ftrace.machine) {
+			ensure_synthetic_inline(ftrace.machine, "wake_up_new_task", 0x1d1,
+						"activate_task");
+			num_inlines = ftrace_resolve_inlines(ftrace.machine,
+							     "wake_up_new_task", 0x1d1,
+							     inlined_names,
+							     FTRACE_MAX_INLINES);
+			if (num_inlines > 0 && !strcmp(inlined_names[0], "activate_task")) {
+				out = open_memstream(&out_buf, &out_len);
+				if (!out) {
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
+	/* 32c. Dropped target root exit followed by untraced ancestor exit (match_idx < 0) */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Target function enters at indent 4 with caller_idx < 0 (untraced caller) */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-untraced_parent+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      enqueue_task();", out);
+	/* Target root exit is DROPPED by ring buffer */
+	/* Untraced ancestor schedule() exits at indent 2 (match_idx < 0) */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  } /* schedule */", out);
+	/* Out-of-target IRQ marker must NOT be printed because target has exited */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0) ==========>", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0) <==========", out);
+	/* Subsequent target function invocation */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      enqueue_task();", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |    } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "schedule")) {
+		pr_debug("FAILED: untraced ancestor schedule leaked\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "==========")) {
+		pr_debug("FAILED: out-of-target IRQ marker leaked after dropped root exit\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: second activate_task invocation suppressed after untraced drop exit\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 33. Rekey with to_copy == 0 when target root exited on new CPU */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* CPU 0: Task 15 enters non-target ancestor and target function */
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  schedule() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    activate_task() { /* <-schedule+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      enqueue_task();", out);
+	/* CPU 1: Task 15 unwinds target root down to schedule (indent 2) */
+	ftrace_process_fgraph_line(&ftrace, " 1)   2.000 us    |    } /* activate_task */", out);
+	/* Pre-bind empty task15 state on CPU 2 */
+	ftrace_process_fgraph_line(&ftrace, " 2) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 2)    <idle>-0    =>    task15-1500 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 2)    task15-1500 =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 2) ------------------------------------------", out);
+	/* CPU 1 emits banner first: merges ts1 (depth 0, min_raw_indent 2) into existing */
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)    task15-1500 =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	/* CPU 0 emits banner second: to_copy is 0, base_raw_indent 2 prunes activate_task */
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)    task15-1500 =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	/* Task 15 resumes: ancestor schedule() calls non-target sibling child */
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)    <idle>-0    =>    task15-1500 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    nontarget_child(); /* <-schedule+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)   3.000 us    |  } /* schedule */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "nontarget_child")) {
+		pr_debug("FAILED: nontarget_child leaked after to_copy == 0 rekey\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 34. Test dropped-orphan recovery inside a nested child of the target root (VF1).
+	 */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Target root enters at indent 2 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	/* Non-leaf child of target enters at indent 4 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    enqueue_task() { /* <-activate_task+0x10 */", out);
+	/* Orphan triggered inside nested child at indent 6; its exit is DROPPED */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      housekeeping_any_cpu() { /* <-rb_wakeups+0x10 */", out);
+	/* Nested child calls legitimate function at indent 6 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      update_load_avg(); /* <-enqueue_task+0x20 */", out);
+	/* Another orphan inside nested child whose exit is ALSO DROPPED before child exits */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      arch_irq_work_raise() { /* <-irq_work_queue+0x10 */",
+		out);
+	/* Nested child exits at indent 4 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |    } /* enqueue_task */", out);
+	/* Target root exits at indent 2 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "housekeeping_any_cpu") || strstr(out_buf, "arch_irq_work_raise")) {
+		pr_debug("FAILED: nested orphan leaked in test 34\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "update_load_avg();")) {
+		pr_debug("FAILED: legitimate child call update_load_avg swallowed after dropped nested orphan\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "} /* enqueue_task */")) {
+		pr_debug("FAILED: nested child exit swallowed after dropped nested orphan\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "} /* activate_task */")) {
+		pr_debug("FAILED: target root exit missing in test 34\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 35. Test orphan_depth preservation and pruning across task rekeying (VF2).
+	 */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/*
+	 * 35a: Task enters target root and orphan on CPU 0 (unknown PID), migrates
+	 * to CPU 1 where PID is bound and orphan exits, then CPU 0 emits delayed banner.
+	 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    housekeeping_any_cpu() { /* <-rb_wakeups+0x10 */", out);
+	/* Task migrates to CPU 1: banner binds task16-1600 to CPU 1 */
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)    <idle>-0    =>    task16-1600 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	/* Orphan exits on CPU 1 at indent 4 */
+	ftrace_process_fgraph_line(&ftrace, " 1)   1.000 us    |    }", out);
+	/* Delayed outgoing banner on CPU 0 rekeys CPU 0 state into task16-1600 */
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)    task16-1600 =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	/* Legitimate target child executes on CPU 1 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 1)   1.500 us    |    enqueue_task(); /* <-activate_task+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 1)   3.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "housekeeping_any_cpu")) {
+		pr_debug("FAILED: orphan leaked in test 35a\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: stale orphan_depth from pre-migration state suppressed enqueue_task\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 36. Test orphan interrupt handler suppresses surrounding IRQ markers (VF3).
+	 */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |  activate_task() {", out);
+	/* Kernel emits ==========> before orphan interrupt entry */
+	ftrace_process_fgraph_line(&ftrace, " 0)   ==========> |", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    sysvec_apic_timer_interrupt() { /* <-asm_call_sysvec_on_stack+0x10 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      hrtimer_interrupt(); /* <-sysvec_apic_timer_interrupt+0x20 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |    }", out);
+	/* Kernel emits <========== after orphan interrupt return */
+	ftrace_process_fgraph_line(&ftrace, " 0)   <========== |", out);
+	/* Legitimate child call */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.500 us    |    enqueue_task(); /* <-activate_task+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   4.000 us    |  } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "==========")) {
+		pr_debug("FAILED: empty IRQ marker pair leaked around suppressed orphan interrupt\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: enqueue_task missing after suppressed IRQ in test 36\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/*
+	 * 37. Test unmatched ancestor exit unwinds non-target ancestor frames
+	 * below target_root_depth with raw_indent >= leading_spaces (VF4).
+	 */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	/* Non-target ancestor enters at indent 4 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |    mid_ancestor() {", out);
+	/* Target root enters at indent 6 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      activate_task() { /* <-mid_ancestor+0x10 */", out);
+	/* Exits of activate_task (indent 6) and mid_ancestor (indent 4) are DROPPED */
+	/* Untraced outer ancestor exits at indent 2 (match_idx < 0) */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   3.000 us    |  } /* outer_untraced */", out);
+	/* New target root enters at indent 6 with untraced caller mid_ancestor */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      activate_task() { /* <-mid_ancestor+0x10 */", out);
+	/* Orphan inside new target root has retaddr matching mid_ancestor */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |        orphan_leaf(); /* <-mid_ancestor+0x20 */", out);
+	/* Legitimate child call of new target root */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |        enqueue_task(); /* <-activate_task+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |      } /* activate_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "mid_ancestor") || strstr(out_buf, "outer_untraced") ||
+	    strstr(out_buf, "orphan_leaf")) {
+		pr_debug("FAILED: ancestor or orphan leaked in test 37\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: enqueue_task missing in test 37 (stale mid_ancestor not unwound)\n");
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
 static int test__parse_retaddr(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	return test_parse_retaddr();
@@ -1493,6 +3938,11 @@ static int test__column_layouts(struct test_suite *test __maybe_unused, int subt
 	return test_column_layouts();
 }
 
+static int test__graph_target_filter(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	return test_graph_target_filter();
+}
+
 static int test__stack_saturation(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	return test_stack_saturation();
@@ -1512,6 +3962,7 @@ static struct test_case ftrace_test_cases[] = {
 	TEST_CASE("Parse return address comments", parse_retaddr),
 	TEST_CASE("Filter return address comments", filter_retaddr),
 	TEST_CASE("Function graph column layouts", column_layouts),
+	TEST_CASE("Graph target filtering", graph_target_filter),
 	TEST_CASE("Stack saturation and expansion", stack_saturation),
 	TEST_CASE("Context switch handling", context_switch_handling),
 	TEST_CASE("Inline symbol and trace processing", inline_processing),
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index c2cf4a20553e..a91930792032 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -24,6 +24,7 @@
 #include "srcline.h"
 #include "symbol.h"
 #include "util/ftrace.h"
+#include "util/string2.h"
 #include <perf/threadmap.h>
 
 #define FTRACE_MAX_CPUS 4096
@@ -39,8 +40,9 @@
  *
  * @name:    Function name extracted from the trace entry.
  * @inlined: Whether the frame represents a synthesised inlined function.
- * @indent:  Indentation (in spaces) used to correlate entry and exit frames
- *           (or visual indentation for synthesised inlined frames).
+ * @indent:  Indentation (in spaces): original leading spaces from the kernel
+ *           trace stream after '|' for real frames, or visual indentation used
+ *           when printing to output for synthesised inlined frames.
  * @seq:     Monotonic event sequence number when the frame was entered.
  */
 struct ftrace_stack_frame {
@@ -53,16 +55,24 @@ struct ftrace_stack_frame {
 /*
  * Per-task call stack state for function_graph trace reconstruction.
  *
- * @node:           Hash list node indexed by PID.
- * @pid:            Task PID (or synthetic per-CPU ID when PID is unavailable).
- * @stack:          Dynamically resized array of active stack frames.
- * @max_stack:      Current allocated capacity (in frames) of @stack.
- * @depth:          Current number of active frames stored in @stack.
- * @overflow_depth: Nesting count of frames entered beyond @stack capacity,
- *                  preventing their exits from popping valid parent frames.
- * @seq:            Event sequence number of the most recent trace record.
- * @min_raw_indent: Minimum raw indentation observed on this task state, or -1 if none.
- * @min_indent_seq: Event sequence number of the shallowest observed trace record.
+ * @node:                  Hash list node indexed by PID.
+ * @pid:                   Task PID (or synthetic per-CPU ID when PID is unavailable).
+ * @stack:                 Dynamically resized array of active stack frames.
+ * @max_stack:             Current allocated capacity (in frames) of @stack.
+ * @depth:                 Current number of active frames stored in @stack.
+ * @seq:                   Event sequence number of the most recent trace record.
+ * @min_raw_indent:        Minimum raw indentation observed on this task state.
+ * @min_indent_seq:        Event sequence number of @min_raw_indent.
+ * @in_target:             Whether the task is currently within a matched -G target tree.
+ * @target_root_depth:     Stack depth at the entry of the matched target root function.
+ * @target_root_frame_idx: Stack index of the matched target root frame.
+ * @target_root_indent:    Raw indentation of the matched target root function.
+ * @target_root_name:      Symbol name of the matched target root function.
+ * @orphan_depth:          Nesting depth of suppressed detached/orphan subtrees.
+ * @orphan_base_indent:    Raw indentation of the outermost active orphan frame.
+ * @orphan_seq:            Sequence number of the most recent event in the orphan subtree.
+ * @pending_irq_ent:       Buffered IRQ entry banner awaiting target caller verification.
+ * @suppress_irq_ret:      Whether the matching IRQ return banner should be suppressed.
  */
 struct ftrace_task_state {
 	struct hlist_node node;
@@ -70,10 +80,19 @@ struct ftrace_task_state {
 	struct ftrace_stack_frame *stack;
 	int max_stack;
 	int depth;
-	int overflow_depth;
 	u64 seq;
 	int min_raw_indent;
 	u64 min_indent_seq;
+	bool in_target;
+	int target_root_depth;
+	int target_root_frame_idx;
+	int target_root_indent;
+	char target_root_name[128];
+	int orphan_depth;
+	int orphan_base_indent;
+	u64 orphan_seq;
+	char pending_irq_ent[256];
+	bool suppress_irq_ret;
 };
 
 static struct hlist_head ftrace_task_hash[FTRACE_PID_HASH_SIZE];
@@ -177,9 +196,9 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
 		free(ts);
 		return NULL;
 	}
-	ts->min_raw_indent = -1;
 
 	ts->pid = pid;
+	ts->min_raw_indent = -1;
 	key = hash_32((u32)pid, FTRACE_PID_HASH_BITS);
 	head = &ftrace_task_hash[key];
 	hlist_add_head(&ts->node, head);
@@ -187,51 +206,69 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
 }
 
 /**
- * ftrace_task_state__record_indent - Record an indentation watermark for a task
- * @ts: Task state to update
- * @raw_indent: Raw indentation (leading spaces) of the observed trace record
+ * reset_target_root_state - Clear graph target filter state for a task
+ * @ts: Task state to reset
  *
- * Record the shallowest indentation observed on @ts along with its event
- * sequence number so that earlier frames that have already exited can be
- * pruned when merging task states across CPUs.
+ * Reset all state tracking associated with an active graph target filter,
+ * restoring the task to an out-of-target state.
  */
-static void ftrace_task_state__record_indent(struct ftrace_task_state *ts,
-					     int raw_indent)
+static void reset_target_root_state(struct ftrace_task_state *ts)
 {
-	if (ts->min_raw_indent < 0 || raw_indent <= ts->min_raw_indent) {
-		ts->min_raw_indent = raw_indent;
-		ts->min_indent_seq = ts->seq;
-	}
+	ts->in_target = false;
+	ts->target_root_depth = 0;
+	ts->target_root_frame_idx = 0;
+	ts->target_root_indent = 0;
+	ts->target_root_name[0] = '\0';
+	ts->orphan_depth = 0;
+	ts->orphan_base_indent = 0;
+	ts->orphan_seq = 0;
+	ts->pending_irq_ent[0] = '\0';
+	ts->suppress_irq_ret = false;
 }
 
 /**
- * ftrace_task_state__inlined_depth - Count active inlined frames on a task stack
+ * ftrace_task_state__inlined_depth - Count active synthesised inline frames on stack
  * @ts: Task state to inspect
  *
- * Return: The number of active synthesised inlined frames on @ts->stack.
+ * Return: The number of active synthesised inline frames currently on @ts->stack.
  */
 static int ftrace_task_state__inlined_depth(const struct ftrace_task_state *ts)
 {
-	int i, count = 0;
+	int count = 0;
 
-	for (i = 0; i < ts->depth; i++) {
+	for (int i = 0; i < ts->depth; i++) {
 		if (ts->stack[i].inlined)
 			count++;
 	}
-
 	return count;
 }
 
+/**
+ * ftrace_task_state__record_indent - Record an indentation watermark for a task
+ * @ts: Task state to update
+ * @raw_indent: Raw indentation (leading spaces) of the observed trace record
+ *
+ * Track the minimum raw indentation observed on @ts and the latest sequence
+ * number at which it occurred.
+ */
+static void ftrace_task_state__record_indent(struct ftrace_task_state *ts,
+					     int raw_indent)
+{
+	if (ts->min_raw_indent < 0 || raw_indent <= ts->min_raw_indent) {
+		ts->min_raw_indent = raw_indent;
+		ts->min_indent_seq = ts->seq;
+	}
+}
+
 /**
  * ftrace_task_state__prune_stack - Prune frames that exited on another task state
  * @ts: Task state whose call stack should be pruned
  * @other: Other task state representing the same task on another CPU
  *
  * Remove any frames on @ts->stack that are known to have exited based on
- * subsequent trace events recorded on @other (i.e. @other->min_indent_seq >
- * frame->seq and @other->min_raw_indent <= frame->indent). Synthesised
- * inline frames are retained if and only if their enclosing real frame
- * survives.
+ * the minimum-indent watermark recorded on @other (i.e. @other->min_indent_seq
+ * > frame->seq and @other->min_raw_indent <= frame->indent). Synthesised
+ * inline frames are retained if and only if their enclosing real frame survives.
  */
 static void ftrace_task_state__prune_stack(struct ftrace_task_state *ts,
 					   const struct ftrace_task_state *other)
@@ -240,6 +277,23 @@ static void ftrace_task_state__prune_stack(struct ftrace_task_state *ts,
 	bool seen_real = false;
 	int i, dst = 0;
 
+	if (ts->in_target && ts->target_root_frame_idx >= ts->depth)
+		reset_target_root_state(ts);
+
+	if (ts->orphan_depth > 0) {
+		int min_indent = (other->min_indent_seq > ts->orphan_seq) ?
+				 other->min_raw_indent : -1;
+
+		if (min_indent >= 0 &&
+		    (min_indent <= ts->target_root_indent ||
+		     (ts->orphan_base_indent > 0 &&
+		      min_indent <= ts->orphan_base_indent))) {
+			ts->orphan_depth = 0;
+			ts->orphan_base_indent = 0;
+			ts->orphan_seq = 0;
+		}
+	}
+
 	for (i = ts->depth - 1; i >= 0; i--) {
 		struct ftrace_stack_frame *frame = &ts->stack[i];
 		int min_indent = (other->min_indent_seq > frame->seq) ?
@@ -257,12 +311,19 @@ static void ftrace_task_state__prune_stack(struct ftrace_task_state *ts,
 			keep_inlines = !prune;
 		}
 
-		if (prune)
+		if (prune) {
 			zfree(&frame->name);
+			if (ts->in_target && i == ts->target_root_frame_idx)
+				reset_target_root_state(ts);
+		}
 	}
 
 	for (i = 0; i < ts->depth; i++) {
 		if (ts->stack[i].name) {
+			if (ts->in_target && i == ts->target_root_frame_idx) {
+				ts->target_root_depth += dst - i;
+				ts->target_root_frame_idx = dst;
+			}
 			if (dst != i)
 				ts->stack[dst] = ts->stack[i];
 			dst++;
@@ -277,7 +338,7 @@ static void ftrace_task_state__prune_stack(struct ftrace_task_state *ts,
  * @new_pid: The new process ID to associate with the state
  *
  * Rehash @ts under @new_pid. If a task state for @new_pid already exists,
- * merge or replace it and return the unified task state.
+ * merge or replace it and update active CPU references accordingly.
  *
  * Return: A pointer to the active task state associated with @new_pid.
  */
@@ -326,8 +387,12 @@ static struct ftrace_task_state *ftrace_task_state__rekey(struct ftrace_task_sta
 			to_copy = 0;
 	}
 
+	if (ts->in_target && ts->target_root_frame_idx >= to_copy)
+		reset_target_root_state(ts);
+
 	if (to_copy > 0) {
 		int e_idx = 0, t_idx = 0, out_idx = 0;
+		int new_e_root = -1, new_t_root = -1;
 
 		if (orig_existing_depth > 0) {
 			memmove(&existing->stack[to_copy],
@@ -338,19 +403,79 @@ static struct ftrace_task_state *ftrace_task_state__rekey(struct ftrace_task_sta
 		while (e_idx < orig_existing_depth && t_idx < to_copy) {
 			if (existing->stack[to_copy + e_idx].seq <=
 			    ts->stack[t_idx].seq) {
+				if (existing->in_target &&
+				    e_idx == existing->target_root_frame_idx)
+					new_e_root = out_idx;
 				existing->stack[out_idx++] =
 					existing->stack[to_copy + e_idx++];
 			} else {
+				if (ts->in_target &&
+				    t_idx == ts->target_root_frame_idx)
+					new_t_root = out_idx;
 				existing->stack[out_idx++] =
 					ts->stack[t_idx++];
 			}
 		}
-		while (t_idx < to_copy)
+		while (t_idx < to_copy) {
+			if (ts->in_target &&
+			    t_idx == ts->target_root_frame_idx)
+				new_t_root = out_idx;
 			existing->stack[out_idx++] = ts->stack[t_idx++];
+		}
 		while (e_idx < orig_existing_depth) {
+			if (existing->in_target &&
+			    e_idx == existing->target_root_frame_idx)
+				new_e_root = out_idx;
 			existing->stack[out_idx++] =
 				existing->stack[to_copy + e_idx++];
 		}
+
+		if (new_t_root >= 0 &&
+		    (new_e_root < 0 || new_t_root < new_e_root)) {
+			int delta = new_t_root - ts->target_root_frame_idx;
+
+			existing->in_target = true;
+			existing->target_root_depth =
+				ts->target_root_depth + delta;
+			existing->target_root_frame_idx = new_t_root;
+			existing->target_root_indent = ts->target_root_indent;
+			strlcpy(existing->target_root_name,
+				ts->target_root_name,
+				sizeof(existing->target_root_name));
+		} else if (new_e_root >= 0) {
+			int delta = new_e_root - existing->target_root_frame_idx;
+
+			existing->target_root_depth += delta;
+			existing->target_root_frame_idx = new_e_root;
+		}
+
+		if (existing->in_target) {
+			const struct ftrace_task_state *first =
+				(ts->seq >= existing->seq) ? ts : existing;
+			const struct ftrace_task_state *second =
+				(ts->seq >= existing->seq) ? existing : ts;
+
+			if (first->orphan_depth > 0) {
+				existing->orphan_depth = first->orphan_depth;
+				existing->orphan_base_indent = first->orphan_base_indent;
+				existing->orphan_seq = first->orphan_seq;
+			} else if (second->orphan_depth > 0) {
+				existing->orphan_depth = second->orphan_depth;
+				existing->orphan_base_indent = second->orphan_base_indent;
+				existing->orphan_seq = second->orphan_seq;
+			} else {
+				existing->orphan_depth = 0;
+				existing->orphan_base_indent = 0;
+				existing->orphan_seq = 0;
+			}
+
+			if (ts->seq >= existing->seq) {
+				strlcpy(existing->pending_irq_ent,
+					ts->pending_irq_ent,
+					sizeof(existing->pending_irq_ent));
+				existing->suppress_irq_ret = ts->suppress_irq_ret;
+			}
+		}
 	}
 
 	for (j = to_copy; j < ts->depth; j++)
@@ -707,6 +832,35 @@ static void extract_exit_func_name(const char *str, char *buf, size_t size)
 	buf[i] = '\0';
 }
 
+/**
+ * push_nontarget_frame - Push non-target entry frame to call stack
+ * @ts: Task stack state
+ * @func_start: Pointer to start of function name in trace record
+ * @leading_spaces: Indentation of trace record
+ *
+ * Return: 0 on success, or negative error code on failure.
+ */
+static int push_nontarget_frame(struct ftrace_task_state *ts, const char *func_start,
+				int leading_spaces)
+{
+	char entry_name[128];
+
+	extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
+	if (ts->depth >= ts->max_stack && ftrace_task_state__grow_stack(ts) < 0)
+		return -ENOMEM;
+
+	ts->stack[ts->depth].name = strdup(entry_name);
+	if (!ts->stack[ts->depth].name) {
+		pr_err("Not enough memory\n");
+		return -ENOMEM;
+	}
+	ts->stack[ts->depth].inlined = false;
+	ts->stack[ts->depth].indent = leading_spaces;
+	ts->stack[ts->depth].seq = ts->seq;
+	ts->depth++;
+	return 0;
+}
+
 /**
  * make_blank_prefix - Create a blank prefix mirroring a trace record's context
  * @ftrace: Perf ftrace context
@@ -762,6 +916,60 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
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
+	if (ftrace->graph_verbose) {
+		const char *proc_start = endptr;
+		const char *pipe = strchr(proc_start, '|');
+
+		if (pipe) {
+			const char *h = pipe - 1;
+
+			while (h >= proc_start && *h != '-')
+				h--;
+			if (h >= proc_start && *h == '-') {
+				long pid_val = strtol(h + 1, NULL, 10);
+				pid_t task_pid = (pid_val == 0) ?
+						 FTRACE_IDLE_PID(val) :
+						 (pid_t)pid_val;
+
+				ftrace_cpu_tasks[(int)val] = get_task_state(task_pid);
+			}
+		}
+	}
+
+	*cpu = (int)val;
+	return true;
+}
+
 /**
  * find_func_column - Locate the function call column in a trace record
  * @ftrace: Perf ftrace context
@@ -879,6 +1087,208 @@ static int print_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
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
+ * @ts: Task state to update
+ * @entry_name: Function symbol name matching the graph filter
+ * @depth: Call stack depth at which the target root function entered
+ * @leading_spaces: Indentation of the target root function
+ *
+ * Mark the task as actively inside a target filter hierarchy rooted at @depth
+ * for function @entry_name, and clear any stale orphan tracking depth.
+ */
+static void ftrace_reset_to_target_root(struct ftrace_task_state *ts,
+					const char *entry_name, int depth,
+					int leading_spaces)
+{
+	ts->in_target = true;
+	ts->target_root_depth = depth;
+	ts->target_root_frame_idx = depth;
+	ts->target_root_indent = leading_spaces;
+	strlcpy(ts->target_root_name, entry_name, sizeof(ts->target_root_name));
+	ts->orphan_depth = 0;
+	ts->orphan_base_indent = 0;
+	ts->orphan_seq = 0;
+	ts->pending_irq_ent[0] = '\0';
+	ts->suppress_irq_ret = false;
+}
+
+/**
+ * ftrace_unwind_to_depth - Unwind call stack frames down to a specified depth
+ * @ts: Task state whose call stack is unwound
+ * @target_depth: Depth to unwind down to
+ * @blank_prefix: Column alignment prefix for synthesised closing lines
+ * @out: File stream to output to, or NULL if suppressing output
+ *
+ * Pop and free call stack frames until the stack depth reaches @target_depth.
+ * For any inlined frames encountered, decrement the inlined depth counter
+ * and, if @out is non-NULL, emit the corresponding synthesised inline closing
+ * delimiter line.
+ */
+static void ftrace_unwind_to_depth(struct ftrace_task_state *ts, int target_depth,
+				   const char *blank_prefix, FILE *out)
+{
+	while (ts->depth > target_depth) {
+		struct ftrace_stack_frame *top = &ts->stack[ts->depth - 1];
+
+		if (top->inlined && out)
+			fprintf(out, "%s%*s} /* %s (inline) */\n",
+				blank_prefix, top->indent, "", top->name);
+		free(top->name);
+		ts->depth--;
+	}
+}
+
+/**
+ * ftrace_check_target_caller - Validate caller of function inside target filter
+ * @ftrace: Perf ftrace context
+ * @ts: Task stack state
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
+				      struct ftrace_task_state *ts,
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
+	if (!ftrace_has_graph_funcs(ftrace) || !ts->in_target ||
+	    ts->depth <= ts->target_root_depth)
+		return 0;
+
+	if (has_retaddr && caller_idx >= 0 && caller_idx < ts->target_root_depth) {
+		ftrace_unwind_to_depth(ts, caller_idx + 1, blank_prefix, out);
+		if (is_graph_target) {
+			ftrace_reset_to_target_root(ts, entry_name, ts->depth,
+						    leading_spaces);
+			*is_target_root = true;
+			return 0;
+		}
+		reset_target_root_state(ts);
+		if (has_open_brace && !has_semicolon &&
+		    push_nontarget_frame(ts, func_start, leading_spaces) < 0)
+			return -ENOMEM;
+		return 1;
+	}
+
+	if (leading_spaces <= ts->target_root_indent) {
+		ftrace_unwind_to_depth(ts, 0, blank_prefix, out);
+		if (is_graph_target) {
+			ftrace_reset_to_target_root(ts, entry_name, 0,
+						    leading_spaces);
+			*is_target_root = true;
+			return 0;
+		}
+		reset_target_root_state(ts);
+		if (has_open_brace && !has_semicolon &&
+		    push_nontarget_frame(ts, func_start, leading_spaces) < 0)
+			return -ENOMEM;
+		return 1;
+	}
+
+	if (has_retaddr) {
+		if (caller_idx < 0) {
+			if (ts->pending_irq_ent[0] != '\0') {
+				ts->pending_irq_ent[0] = '\0';
+				ts->suppress_irq_ret = true;
+			}
+			if (has_open_brace && !has_semicolon) {
+				ts->orphan_depth = 1;
+				ts->orphan_base_indent = leading_spaces;
+				ts->orphan_seq = ts->seq;
+			}
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
@@ -910,16 +1320,54 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	int active_inlines;
 	int common;
 	int match_idx;
-	int top_indent;
+	int ret;
 	int i;
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
+		bool is_irq_ent = (strstr(line, "==========>") != NULL);
+
+		if (has_filter && parse_graph_cpu(ftrace, line, &cpu)) {
+			ts = get_cpu_state(ftrace, cpu);
+			if (ts && ts->in_target && ts->orphan_depth == 0) {
+				if (is_irq_ent) {
+					if (ts->pending_irq_ent[0] != '\0')
+						print_line(ftrace, ts->pending_irq_ent, out);
+					strlcpy(ts->pending_irq_ent, line,
+						sizeof(ts->pending_irq_ent));
+					ts->suppress_irq_ret = false;
+				} else {
+					if (ts->pending_irq_ent[0] != '\0') {
+						print_line(ftrace, ts->pending_irq_ent, out);
+						ts->pending_irq_ent[0] = '\0';
+					}
+					if (ts->suppress_irq_ret)
+						ts->suppress_irq_ret = false;
+					else
+						print_line(ftrace, line, out);
+				}
+			} else if (ts && !ts->in_target) {
+				ts->pending_irq_ent[0] = '\0';
+				ts->suppress_irq_ret = false;
+			}
+		} else if (!has_filter) {
+			print_line(ftrace, line, out);
+		}
+		return 0;
+	}
+
 	pipe_char = find_func_column(ftrace, line, &cpu);
 	if (!pipe_char) {
 		parse_context_switch(line);
@@ -950,30 +1398,31 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
 		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
 
-		top_indent = -1;
-		for (i = ts->depth - 1; i >= 0; i--) {
-			if (!ts->stack[i].inlined) {
-				top_indent = ts->stack[i].indent;
-				break;
+		if (ts->orphan_depth > 0) {
+			if (has_filter && ts->in_target &&
+			    (leading_spaces <= ts->target_root_indent ||
+			     (ts->orphan_base_indent > 0 &&
+			      leading_spaces < ts->orphan_base_indent))) {
+				ts->orphan_depth = 0;
+				ts->orphan_base_indent = 0;
+				ts->orphan_seq = 0;
+			} else {
+				if (ts->orphan_base_indent > 0 &&
+				    leading_spaces == ts->orphan_base_indent)
+					ts->orphan_depth = 0;
+				else
+					ts->orphan_depth--;
+				if (ts->orphan_depth == 0) {
+					ts->orphan_base_indent = 0;
+					ts->orphan_seq = 0;
+				}
+				return 0;
 			}
 		}
 
-		/*
-		 * If currently overflowed beyond FTRACE_MAX_STACK, any exit whose
-		 * indentation is deeper than the top tracked frame belongs to the
-		 * overflow region.
-		 */
-		if (ts->overflow_depth > 0 &&
-		    (top_indent < 0 || leading_spaces > top_indent)) {
-			ts->overflow_depth--;
-			extra_indent = ftrace_task_state__inlined_depth(ts) * 2;
-			fprintf(out, "%.*s%*s%s\n",
-				(int)(pipe_char - line + 1), line,
-				leading_spaces + extra_indent, "", func_start);
-			return 0;
-		}
+		ts->suppress_irq_ret = false;
 
-		/* Find matching frame on stack */
+		/* Find matching frame on stack if exit is named */
 		match_idx = -1;
 		if (exit_name[0] != '\0') {
 			for (i = ts->depth - 1; i >= 0; i--) {
@@ -1000,25 +1449,27 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 			}
 		}
 
-		if (match_idx >= 0) {
-			ts->overflow_depth = 0;
-		} else if (ts->overflow_depth > 0) {
-			ts->overflow_depth--;
-			extra_indent = ftrace_task_state__inlined_depth(ts) * 2;
-			fprintf(out, "%.*s%*s%s\n",
-				(int)(pipe_char - line + 1), line,
-				leading_spaces + extra_indent, "", func_start);
-			return 0;
+		if (ts->pending_irq_ent[0] != '\0') {
+			if (!has_filter || (ts->in_target && match_idx >= ts->target_root_depth))
+				print_line(ftrace, ts->pending_irq_ent, out);
+			ts->pending_irq_ent[0] = '\0';
 		}
 
 		if (match_idx >= 0) {
+			was_target_root = (has_filter && ts->in_target &&
+					   match_idx == ts->target_root_frame_idx);
+
 			/* Close all inlined and orphaned frames above match_idx */
 			while (ts->depth > 0 && ts->depth - 1 > match_idx) {
 				struct ftrace_stack_frame *top = &ts->stack[ts->depth - 1];
 
 				if (top->inlined) {
-					fprintf(out, "%s%*s} /* %s (inline) */\n",
-						blank_prefix, top->indent, "", top->name);
+					int exit_indent = top->indent;
+
+					if (!has_filter || (ts->in_target &&
+					    ts->depth - 1 >= ts->target_root_depth))
+						fprintf(out, "%s%*s} /* %s (inline) */\n",
+							blank_prefix, exit_indent, "", top->name);
 				}
 				free(top->name);
 				ts->depth--;
@@ -1036,9 +1487,46 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 			extra_indent = 0;
 		}
 
-		fprintf(out, "%.*s%*s%s\n",
-			(int)(pipe_char - line + 1), line,
-			leading_spaces + extra_indent, "", func_start);
+		if (!has_filter || (ts->in_target && match_idx >= ts->target_root_depth)) {
+			if (!ftrace->use_inline) {
+				print_line(ftrace, line, out);
+			} else {
+				fprintf(out, "%.*s%*s%s\n",
+					(int)(pipe_char - line + 1), line,
+					leading_spaces + extra_indent, "", func_start);
+			}
+		}
+
+		if (has_filter && ts->in_target) {
+			if (was_target_root) {
+				while (ts->depth > ts->target_root_depth &&
+				       ts->stack[ts->depth - 1].inlined) {
+					struct ftrace_stack_frame *top =
+						&ts->stack[ts->depth - 1];
+					int exit_indent = top->indent;
+
+					fprintf(out, "%s%*s} /* %s (inline) */\n",
+						blank_prefix, exit_indent, "", top->name);
+					free(top->name);
+					ts->depth--;
+				}
+				reset_target_root_state(ts);
+			} else if (ts->depth <= ts->target_root_depth) {
+				reset_target_root_state(ts);
+			} else if (leading_spaces <= ts->target_root_indent) {
+				ftrace_unwind_to_depth(ts, ts->target_root_depth,
+						       blank_prefix, out);
+				reset_target_root_state(ts);
+			}
+		}
+		if (has_filter && !ts->in_target && match_idx < 0) {
+			while (ts->depth > 0 &&
+			       (ts->stack[ts->depth - 1].inlined ||
+				ts->stack[ts->depth - 1].indent >= leading_spaces)) {
+				free(ts->stack[ts->depth - 1].name);
+				ts->depth--;
+			}
+		}
 		return 0;
 	}
 
@@ -1046,33 +1534,13 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	has_open_brace = (strchr(func_start, '{') != NULL);
 	has_semicolon = (strchr(func_start, ';') != NULL);
 
-	if (has_open_brace || has_semicolon)
-		ftrace_task_state__record_indent(ts, leading_spaces);
-
-	top_indent = -1;
-	for (i = ts->depth - 1; i >= 0; i--) {
-		if (!ts->stack[i].inlined) {
-			top_indent = ts->stack[i].indent;
-			break;
-		}
-	}
-
-	if (ts->overflow_depth > 0 && top_indent >= 0 &&
-	    leading_spaces <= top_indent)
-		ts->overflow_depth = 0;
+	extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
+	if (has_filter)
+		is_graph_target = ftrace_is_graph_func(ftrace, entry_name);
 
+	caller_idx = -1;
 	if (ftrace_parse_retaddr(func_start, caller_sym, sizeof(caller_sym), &caller_offset)) {
 		has_retaddr = true;
-		num_inlines = ftrace_resolve_inlines(ftrace->machine, caller_sym,
-						     caller_offset, inlined_names,
-						     FTRACE_MAX_INLINES);
-		if (num_inlines < 0)
-			return num_inlines;
-	}
-
-	/* Determine which inlined frames are currently open above the caller */
-	caller_idx = -1;
-	if (has_retaddr && ts->overflow_depth == 0) {
 		for (i = ts->depth - 1; i >= 0; i--) {
 			if (!ts->stack[i].inlined && ts->stack[i].name &&
 			    ts->stack[i].indent < leading_spaces &&
@@ -1083,9 +1551,166 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		}
 	}
 
-	/* If caller is not on the tracked stack, do not synthesise inlines */
-	if (has_retaddr && caller_idx < 0)
-		num_inlines = 0;
+	if (ts->orphan_depth > 0) {
+		/*
+		 * If an orphan exit was dropped by the kernel ring buffer,
+		 * check whether this entry is a new target root function,
+		 * is shallower than the orphan root, or descends directly
+		 * from an active frame on the tracked call stack.
+		 */
+		if (has_filter && ts->in_target) {
+			if (leading_spaces <= ts->target_root_indent ||
+			    (ts->orphan_base_indent > 0 &&
+			     leading_spaces < ts->orphan_base_indent)) {
+				ts->orphan_depth = 0;
+				ts->orphan_base_indent = 0;
+				ts->orphan_seq = 0;
+			} else if (has_retaddr && caller_idx >= 0 &&
+				   leading_spaces == ts->stack[caller_idx].indent + 2 &&
+				   (ts->orphan_base_indent == 0 ||
+				    leading_spaces <= ts->orphan_base_indent)) {
+				ts->orphan_depth = 0;
+				ts->orphan_base_indent = 0;
+				ts->orphan_seq = 0;
+			} else if (ts->target_root_name[0] != '\0' && has_retaddr &&
+				   leading_spaces == ts->target_root_indent + 2) {
+				if (strcmp(ts->target_root_name, caller_sym) == 0) {
+					ts->orphan_depth = 0;
+					ts->orphan_base_indent = 0;
+					ts->orphan_seq = 0;
+				}
+			}
+		}
+
+		if (ts->orphan_depth > 0) {
+			if (has_open_brace && !has_semicolon) {
+				ts->orphan_depth++;
+				ts->orphan_seq = ts->seq;
+			}
+			return 0;
+		}
+	}
+
+	ts->suppress_irq_ret = false;
+
+	if ((has_open_brace || has_semicolon) &&
+	    !(has_filter && ts->in_target && ts->depth > ts->target_root_depth &&
+	      leading_spaces > ts->target_root_indent &&
+	      has_retaddr && caller_idx < 0))
+		ftrace_task_state__record_indent(ts, leading_spaces);
+
+	if (has_filter) {
+		if (ts->depth == 0 || !ts->in_target) {
+			if (is_graph_target) {
+				if (has_retaddr && caller_idx >= 0)
+					ftrace_unwind_to_depth(ts, caller_idx + 1,
+							       blank_prefix,
+							       ftrace->use_inline ? out : NULL);
+				else
+					ftrace_unwind_to_depth(ts, 0,
+							       blank_prefix,
+							       ftrace->use_inline ? out : NULL);
+				ftrace_reset_to_target_root(ts, entry_name, ts->depth,
+							    leading_spaces);
+				is_target_root = true;
+			} else if (ts->depth == 0) {
+				reset_target_root_state(ts);
+			}
+		}
+
+		if (!ts->in_target) {
+			/* Non-matching call tree; track depth if entering scope, suppress output */
+			while (ts->depth > 0 &&
+			       !ts->stack[ts->depth - 1].inlined &&
+			       ts->stack[ts->depth - 1].indent >= leading_spaces) {
+				free(ts->stack[ts->depth - 1].name);
+				ts->depth--;
+			}
+			if (has_open_brace && !has_semicolon) {
+				if (push_nontarget_frame(ts, func_start, leading_spaces) < 0)
+					return -ENOMEM;
+			}
+			return 0;
+		}
+	}
+
+	if (!ftrace->use_inline) {
+		if (is_target_root) {
+			if (has_retaddr && caller_idx >= 0)
+				ftrace_unwind_to_depth(ts, caller_idx + 1, NULL, NULL);
+			else
+				ftrace_unwind_to_depth(ts, 0, NULL, NULL);
+			ts->target_root_depth = ts->depth;
+			ts->target_root_frame_idx = ts->depth;
+			ts->target_root_indent = leading_spaces;
+		}
+
+		ret = ftrace_check_target_caller(ftrace, ts, func_start, entry_name,
+						 is_graph_target, leading_spaces,
+						 has_open_brace, has_semicolon,
+						 has_retaddr, caller_idx, NULL, NULL,
+						 &is_target_root);
+		if (ret != 0)
+			return (ret < 0) ? ret : 0;
+
+		if (!is_target_root) {
+			if (has_retaddr && caller_idx >= 0) {
+				if (ts->depth > caller_idx + 1)
+					ftrace_unwind_to_depth(ts, caller_idx + 1, NULL, NULL);
+			} else if (caller_idx < 0) {
+				while (ts->depth > ts->target_root_depth &&
+				       !ts->stack[ts->depth - 1].inlined &&
+				       ts->stack[ts->depth - 1].indent >= leading_spaces) {
+					free(ts->stack[ts->depth - 1].name);
+					ts->depth--;
+				}
+			}
+		}
+
+		if (has_open_brace && !has_semicolon) {
+			if (is_target_root) {
+				ts->target_root_frame_idx = ts->depth;
+				ts->target_root_indent = leading_spaces;
+			}
+			if (push_nontarget_frame(ts, func_start, leading_spaces) < 0)
+				return -ENOMEM;
+		}
+		if (ts->pending_irq_ent[0] != '\0') {
+			print_line(ftrace, ts->pending_irq_ent, out);
+			ts->pending_irq_ent[0] = '\0';
+		}
+		print_line(ftrace, line, out);
+		if (has_filter && ts->in_target && is_target_root &&
+		    has_semicolon && !has_open_brace) {
+			reset_target_root_state(ts);
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
+		if (caller_idx < 0)
+			num_inlines = 0;
+	}
+
+	ret = ftrace_check_target_caller(ftrace, ts, func_start, entry_name,
+					 is_graph_target, leading_spaces,
+					 has_open_brace, has_semicolon,
+					 has_retaddr, caller_idx, blank_prefix,
+					 out, &is_target_root);
+	if (ret != 0)
+		return (ret < 0) ? ret : 0;
+
+	if (ts->pending_irq_ent[0] != '\0') {
+		print_line(ftrace, ts->pending_irq_ent, out);
+		ts->pending_irq_ent[0] = '\0';
+	}
 
 	active_inlines = 0;
 	if (caller_idx >= 0) {
@@ -1109,51 +1734,64 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	}
 
 	/* Close stale callee frames and inactive inlined frames above caller */
-	if (caller_idx >= 0)
-		ts->overflow_depth = 0;
-
 	while (caller_idx >= 0 && ts->depth > caller_idx + 1 + common) {
 		struct ftrace_stack_frame *top = &ts->stack[ts->depth - 1];
 
 		if (top->inlined) {
-			fprintf(out, "%s%*s} /* %s (inline) */\n",
-				blank_prefix, top->indent, "", top->name);
+			int exit_indent = top->indent;
+
+			if (!has_filter || (ts->in_target && !is_target_root))
+				fprintf(out, "%s%*s} /* %s (inline) */\n",
+					blank_prefix, exit_indent, "", top->name);
 		}
 		free(top->name);
 		ts->depth--;
 	}
 
-	if (caller_idx < 0 && ts->overflow_depth == 0) {
-		/*
-		 * If caller is not on the tracked stack, unwind any frames whose
-		 * indentation is greater than or equal to the new entry's
-		 * indentation (their exit events were dropped), and close any
-		 * trailing inlined frames that were left open from prior calls.
-		 */
-		while (ts->depth > 0) {
-			struct ftrace_stack_frame *top = &ts->stack[ts->depth - 1];
+	if (caller_idx < 0) {
+		if (is_target_root) {
+			ftrace_unwind_to_depth(ts, 0, blank_prefix, out);
+		} else {
+			/*
+			 * If caller is not on the tracked stack, unwind any frames whose
+			 * raw indentation is greater than or equal to the new entry's
+			 * indentation (their exit events were dropped), and close any
+			 * trailing inlined frames that were left open from prior calls.
+			 */
+			while (ts->depth > 0) {
+				struct ftrace_stack_frame *top = &ts->stack[ts->depth - 1];
 
-			if (top->inlined) {
-				fprintf(out, "%s%*s} /* %s (inline) */\n",
-					blank_prefix, top->indent, "", top->name);
-				free(top->name);
-				ts->depth--;
-			} else if (top->indent >= leading_spaces) {
-				free(top->name);
-				ts->depth--;
-			} else {
-				break;
+				if (top->inlined) {
+					int exit_indent = top->indent;
+
+					if (!has_filter || (ts->in_target && !is_target_root))
+						fprintf(out, "%s%*s} /* %s (inline) */\n",
+							blank_prefix, exit_indent, "", top->name);
+					free(top->name);
+					ts->depth--;
+				} else if (top->indent >= leading_spaces) {
+					free(top->name);
+					ts->depth--;
+				} else {
+					break;
+				}
 			}
 		}
 	}
 
+	if (is_target_root) {
+		ts->target_root_depth = ts->depth;
+		ts->target_root_indent = leading_spaces;
+	}
+
 	/* Open new inlined frames */
 	for (i = common; i < num_inlines; i++) {
 		int entry_indent = leading_spaces + ftrace_task_state__inlined_depth(ts) * 2;
 
-		if (!inlined_names[i])
+		if (!inlined_names[i]) {
+			pr_err("Not enough memory\n");
 			return -ENOMEM;
-
+		}
 		if (ts->depth >= ts->max_stack &&
 		    ftrace_task_state__grow_stack(ts) < 0)
 			break;
@@ -1195,12 +1833,13 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
 	/* If non-leaf entry, push onto stack */
 	if (has_open_brace && !has_semicolon) {
-		char entry_name[128];
-
-		extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
 		if (ts->depth >= ts->max_stack &&
-		    ftrace_task_state__grow_stack(ts) < 0) {
+		    ftrace_task_state__grow_stack(ts) < 0)
 			return -ENOMEM;
+
+		if (is_target_root) {
+			ts->target_root_frame_idx = ts->depth;
+			ts->target_root_indent = leading_spaces;
 		}
 
 		ts->stack[ts->depth].name = strdup(entry_name);
@@ -1214,6 +1853,23 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		ts->depth++;
 	}
 
+	if (has_filter && ts->in_target && is_target_root &&
+	    has_semicolon && !has_open_brace) {
+		while (ts->depth > ts->target_root_depth) {
+			struct ftrace_stack_frame *top = &ts->stack[ts->depth - 1];
+
+			if (top->inlined) {
+				int exit_indent = top->indent;
+
+				fprintf(out, "%s%*s} /* %s (inline) */\n",
+					blank_prefix, exit_indent, "", top->name);
+			}
+			free(top->name);
+			ts->depth--;
+		}
+		reset_target_root_state(ts);
+	}
+
 	return 0;
 }
 
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 0afaa9695691..1dc808b8a7df 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -12,10 +12,18 @@ struct evlist;
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

