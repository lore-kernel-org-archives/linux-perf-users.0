Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792550043;
	b=2eWVw/M1bgRfy3nva5coS7KLo/b1RF2OTHQLEjprSzzS6nRIVU9ewtRBSFyXzzbSN67/
	 Asz2/CJObYSZ4Oq9rggTzx4TBqRX4xymoxagAZ/54Zpw9lICHkACxqIRFC/OsyuQBGLw6
	 9QrZ+vTY9MwFOE81UH3Rsf3vmotO6mIVs6v/Gu92/OLikLsGP1J95LN+H210PSG0tnhGG
	 yxR5ap6zr1SVqHmdLSYnWrW1CH9cISqOJVfTcF46ZhIDSksaJ3zitlrt2KCy8AC77cQbx
	 yHvpOW7G35G5XpJnftWnVmUoog4x4rQFWKi/rnjWpiQHMrI2QQ7U+bH03Q7sFHDtAKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550043;
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
	bh=8NZZtsxEIaUxr+tIHYeOcWJgNultevlxPA1Rizl2Gtw=;
	b=Ul/V/GaGClX7Y9JWHkHLXyisKxzN5DPbXEtQpXtfCTJi27/1eHfNfeVw+jCYXb3SDjDU
	 EAbIldcfoepaRh9AONtHGsg+cVV4VVo/U8XtHCvyUcgy/wqAHW7gfvFyR91bX7pIQRmwo
	 YtLs/REkRe1h6J270ArzOWi4OsvKM+hUqTRdHGwhKJFqlJzPgiKRSn6jwrveldtVwjavD
	 p6AIlMjtYzNXgqlQZT3bXE4d27QSwyPKo9UIkyypJgQYWfi2si1APBJlzfvB0IEzCl8wn
	 2SxwpTuhdSWynFDce4yrrrnVcOMSy39t4pjDWYBtdLgfOS+WjaIfHRv+Rb4jvVQaMfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.120
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021120.outbound.protection.outlook.com [52.101.100.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F97606A325;
	Wed, 21 Oct 2026 02:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89F97606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0JwQaXmnIehdh9vtybhv5JhR/fy+iZIgQZYRFGraON61Gw1CJU+7pf9y2Ou2PxFaMdRiDp5A0yHZNm3pQxSJ9E+wFLFKTXbycb52IEOEpwG7/emroxLkE5veW3PFQVOw/d88Tfr7W5wfyCSt9QYXDoAgqPd4C7SSxVN75iFkH9sol293wxnkHe5A9AhVMamKNS6pB1FO+BmAAr0GeBuCXd6iBxyVxKNIPadRJ3pm2VJ16H2sTbcBpncxD7DtMyNdr0eNgw2CT2CLVdqu5GjYMi9dxMCknMRl1wdDkW0iZTRCR8NsPkAaSVuMtFv2paubWPvIQ1WRWHf5/xUwZYuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=8NZZtsxEIaUxr+tIHYeOcWJgNultevlxPA1Rizl2Gtw=;
 b=Uc7GI1vglqBTJkpDs8iTywcYtXlgf/b4HJFbRaL5Ijb+iI/hhEJGlaUBxyaUTQvKtWOeDQWHwgyOCpxuEcjFVQKVzdBRcnTf2v+35jcERlyEaoFX9b4Kkhb99vrWoL+c5c4EGVSKlK0BRsCytVuPESdGNk3jaL6AUHkhwkR5qpWeUtbrQAuMJEqN84838M6sAviDM/lzkB1tZZdWtrAfjyBm2vnNPVfNbaKSAl2E6aZzKKggDwgNTt9eIGtEYF0+f1gWJurL+qRkIw1UWUqSNPeqNQzK7/sfbLBR1Oz3+HthWjbDHl3/7TDA3ZX9hJMSnIjr8lxqI7ug3y4N7ncD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB5917.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:287::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:34:01 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:34:01 +0000
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
Subject: [PATCH perf-tools-next v9 5/6] perf ftrace: Support omitting execution duration in function graph tracer
Date: Tue, 20 Oct 2026 22:33:36 -0400
Message-ID: <20261021023337.809936-6-atomlin@atomlin.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2813aae3-2df6-4ab6-b018-08df2f1bc439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	gLYOANBHrhlbxt5zvJs+/JMdcTdMOBW2mA9zCZAJk+Dg2CB2YzQufClMgKHJHEJduDrFj4gxYND7oSkOre3oLztsX+e5YiT8VNO4hx4AUcZJ3zWd5FaGkYP7yyHHpbyChU3JMD+dcYP3juSFR3U0zSjV9/Vg3qbSsTY/pLgrDJ7jgXCDjh/NfO8oVQkceh+VwCKM/VBtoe2frg/hOV+Z6fDceDn/D4ISBE4xiF2JbQ9ghhkS/+KP3RlM07mUjelGoSF9ofoyl8uVmN+bw5eaNf7g/cmj361OiwW14MKkQp/M5BCKUO6lje6EqVs5URb18I2U9NzaM03sahb+2PY+9ZpJTsZZp0SK/46C2HB/0deYCPq6QsKDM0eESfjzA2M9JPorDdoYKNNO4SxH4UBSDeOfIacwKNKLTl8iZI6aQsiIisfilRicvYNV7sEXNP3tsFVXWOBN111aRPIydJOiUFfmyk7wHRiRc7dtVL9wrZ1XboCIZOo0fbdBRUm+ZZcF/89vRH3GOtYksdTZIPC6edbAnszZBrXkWLaxRvkGqSqpk/TDC8qs4qrWJHkcKqdi3GBHKGTKu3Qk4SCtyJkdl5RTZbw8N7iAjVGO0b3lsltXPxV38vWUJdmiAmHCwMTqoww1r1liK4v7wSiS7VMP64OFDRPvOthBS8B/Una7ckE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OphTS2FxvBcjyrBesEFISIY9whv+ZrfpnCfM7eTVl72kuI3p3WCue2kUOk96?=
 =?us-ascii?Q?X/fYGePxn9P7QQuXcFiRSOcQGOUlzTLZTyZ8jvCmOLC5Ev17WSYM7GIL9ccE?=
 =?us-ascii?Q?1n5rf0Z/tWdasSze6rbKRMzI1yF1GpQI7KlQ5mZUCNQ3xNol03cJUAx12K1v?=
 =?us-ascii?Q?a0hWXuXdtPyTZzpyacTKjIAAQYkqTb6tplJ4mss0p9uaMHdX1w5lYvrvATDp?=
 =?us-ascii?Q?TO2TmCDEuwRexnr3Z4xNiDZbfc5ocOfHkGnzTY5BKqn0sD8lpSB6ERS4eOkQ?=
 =?us-ascii?Q?yPLpgAPZIDnkwIRDeUka7nrtxBWFeUr1is/tnu7gjER9MDyG6VXvpAa806Mw?=
 =?us-ascii?Q?63kVQaxq8de5ufqtqeoAjvYpz51+d+3yFgZSSyF+V3/0yuWqybpIPUzqr8nu?=
 =?us-ascii?Q?gYg59srSlibXmdvhLz/IMH5D0Jz0iIyoUHVKyVP7dvEuWOxW/lkmyyICMFPr?=
 =?us-ascii?Q?yJeTIupNPBNuBf2Gy/FPDI9BEg+DG4AK7IS0xfmmsrZrztQQ+jYCC9P8w7BN?=
 =?us-ascii?Q?kYyLNpdUtFohm9hk7y1r4JE83jlKE/E7fEzxiJcQPWQHUxauQSlUfHiUGOkE?=
 =?us-ascii?Q?s4q/9ssR3w7g12MPmn97zGvRTkX5v9xhuzOdbCjY+TfITX1JsVAQ3qltkM8v?=
 =?us-ascii?Q?CKzeXE7kvvo0dKM0l0aSlJeEF58+cwDJ2/KiDizYHivS4vLxeQO+BFkv9vKF?=
 =?us-ascii?Q?gjANm8mi0kLM5ajGMXaSJiR6QnEw8LgRHWqADpDsmlwZQDraM4pkCDjP5aEr?=
 =?us-ascii?Q?rcXaZ9uDkq7UhIgCLk8ZWOsMnXuzn0BCway6kONS3ndL8POhFFbhjCzIBxRT?=
 =?us-ascii?Q?S1sZklYHLcy7nZ/bwT7ml8/4ZA++YEGSTBoUrEkCheinppwE0mZqyp/JLU6y?=
 =?us-ascii?Q?dl5SX+xDnBLKvtwmQ2Bpr9zU0mO251NOumrW4sepj+KOov3sM/UdI6kBX7/D?=
 =?us-ascii?Q?o2MmP/fsXHtonC2ncId5CmWQdvZ0E/USzb3xofeSXSysaAWZH/aQDurNHwRU?=
 =?us-ascii?Q?+d2o7tsoQZh3S9Npops4XWj8PtcuwEzG9L9x4O8yD1+z95fkxoeEyctKG5m2?=
 =?us-ascii?Q?mMuoBzlDdBrfswv8fhLgTU1hJiV0/oUDfHFvIha7shBXhEvIs+ACjwxpzDBb?=
 =?us-ascii?Q?ao7Bf+o8qxQB0O4oEiLKqCU1pAT+uwmTtBFmW81qQYnGVRTcWuUlA8jW5FIT?=
 =?us-ascii?Q?mtnUzc0YXCMTAomz6AZVOlEpJoTw1aMCmgFK87oaFczoheRyIVzRrzBsOQ5l?=
 =?us-ascii?Q?dw2RZhAhWfY0e9l4Boga4mK5ieN0xZ+XiwMrsNilBynHyUVKbWI1rm2DhkY7?=
 =?us-ascii?Q?yBWPMCyU47+kS/U8aNPWq7P+J5ZvLGkFgFOodld7dbKX41VML6A1ZSPNGJRL?=
 =?us-ascii?Q?h8iF1SGQUoGLzhttlot6VGQSCEO3uTT+AH9JRr+0GkeOraz2XU8F2lSzM69b?=
 =?us-ascii?Q?0tGGnBUjHl4QvdGAb7SgN0CCtJ48Kpo/xRdJZTXIdaJE/jv0vKMGIR5kUYRR?=
 =?us-ascii?Q?ocEcWTjJREFdcHi2sWTbP/NZ5imr0VWtoCeRg7IrCFZowvVyPriOfQipMSR8?=
 =?us-ascii?Q?OVApZpmr6mjAzlzHK8t5iBFRPY7ZNZHnRGWAvKXMTEM+XTCH6KafxKdMcwOu?=
 =?us-ascii?Q?zzQxB+HgsBlp4wjES7VCILkduIr4rxyShZH0PgRofGsIn6m3HIhS1mD4rRrp?=
 =?us-ascii?Q?qV7FNONteuk4mNZnTvrniRrdGdwhy2mobW6/IET1GpgsmxkDLglxNkN3tZCO?=
 =?us-ascii?Q?XAPwZxYLIg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2813aae3-2df6-4ab6-b018-08df2f1bc439
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:34:01.3582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Jgx3l1g4XHCYxZPEjrGOMRxYZLDza2i2y9GBFjvu6fey273uz/m1PpLykB9aBAMSKIbhlr9UTcr4s1U1wIzlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB5917

The Linux kernel's function graph tracer displays the execution duration
of completed functions by default via the funcgraph-duration trace
option. Whilst informative, in scenarios where the user is solely
interested in the call graph topology, call flow sequence, or inlined
hierarchy, the duration column can add visual clutter and widen each
trace line.

Introduce support for omitting function duration by exposing the
noduration sub-option under --graph-opts. Consistent with the existing
nosleep-time and noirqs sub-options, it accepts an optional value, so
noduration=0 explicitly retains the duration column; when specified
more than once, the last occurrence takes effect. When enabled, perf
ftrace configures the kernel's tracing instance option
funcgraph-duration to 0, and restores it to 1 upon resetting tracing
options.

Because the profile subcommand fundamentally requires function execution
duration to compute timing statistics and call counts, combining
noduration with perf ftrace profile is rejected with an explicit error.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-ftrace.txt |   1 +
 tools/perf/builtin-ftrace.c              |  34 ++++++-
 tools/perf/tests/ftrace.c                | 107 ++++++++++++++++++++++-
 tools/perf/util/ftrace.c                 |  25 ++++--
 tools/perf/util/ftrace.h                 |   1 +
 5 files changed, 156 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 445c8ccc22d2..a50f3bae86b2 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -129,6 +129,7 @@ OPTIONS for 'perf ftrace trace'
 	  - retaddr      - Show function return address.
 	  - nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  - noirqs       - Ignore functions that happen inside interrupt.
+	  - noduration   - Do not print function duration.
 	  - verbose      - Show process names, PIDs, timestamps, etc.
 	  - thresh=<n>   - Setup trace duration threshold in microseconds.
 	  - depth=<n>    - Set max depth for function graph tracer to follow.
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index ed483bb20ed5..7abbdeb82264 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -300,6 +300,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
 	write_tracing_option_file("funcgraph-irqs", "1");
+	write_tracing_option_file("funcgraph-duration", "1");
 	write_tracing_option_file("funcgraph-proc", "0");
 	write_tracing_option_file("funcgraph-abstime", "0");
 	write_tracing_option_file("funcgraph-tail", "0");
@@ -599,6 +600,26 @@ static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+/**
+ * set_tracing_funcgraph_duration - Set funcgraph-duration tracing option
+ * @ftrace: Perf ftrace context
+ *
+ * Configure the kernel's funcgraph-duration tracing option based on the
+ * ftrace->graph_noduration flag.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int set_tracing_funcgraph_duration(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->graph_noduration)
+		return 0;
+
+	if (write_tracing_option_file("funcgraph-duration", "0") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
 {
 	if (!ftrace->graph_verbose)
@@ -708,6 +729,11 @@ static int set_tracing_options(struct perf_ftrace *ftrace)
 		return -1;
 	}
 
+	if (set_tracing_funcgraph_duration(ftrace) < 0) {
+		pr_err("failed to set tracing option funcgraph-duration\n");
+		return -1;
+	}
+
 	if (set_tracing_funcgraph_verbose(ftrace) < 0) {
 		pr_err("failed to set tracing option funcgraph-proc/funcgraph-abstime\n");
 		return -1;
@@ -1785,6 +1811,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "retaddr",		.value_ptr = &ftrace->graph_retaddr },
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
+		{ .name = "noduration",		.value_ptr = &ftrace->graph_noduration },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
 		{ .name = "depth",		.value_ptr = &ftrace->graph_depth },
@@ -1874,7 +1901,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
+		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,noduration,verbose,thresh=<n>,depth=<n>,tail",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
@@ -2082,6 +2109,11 @@ int cmd_ftrace(int argc, const char **argv)
 		cmd_func = __cmd_latency;
 		break;
 	case PERF_FTRACE_PROFILE:
+		if (ftrace.graph_noduration) {
+			pr_err("Error: 'noduration' option cannot be used with profile\n");
+			ret = -EINVAL;
+			goto out_delete_filters;
+		}
 		cmd_func = __cmd_profile;
 		break;
 	case PERF_FTRACE_NONE:
diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
index 44ed5d7dcf98..edbbc2b11802 100644
--- a/tools/perf/tests/ftrace.c
+++ b/tools/perf/tests/ftrace.c
@@ -100,6 +100,18 @@ static int test_inline_processing(void)
 		" 1234.567890 |   0)   bash-1234    |  ....   |               |    activate_task() { /* (inline) */";
 	static const char line_verbose_inline_exit[] =
 		" 1234.567890 |   0)   bash-1234    |  ....   |               |    } /* activate_task (inline) */";
+	static const char line_verbose_nodur_entry[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |  wake_up_new_task() {";
+	static const char line_verbose_nodur_enqueue[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */";
+	static const char line_verbose_nodur_exit_enqueue[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |    } /* enqueue_task */";
+	static const char line_verbose_nodur_exit_task[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |  } /* wake_up_new_task */";
+	static const char line_verbose_nodur_inline_entry[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |    activate_task() { /* (inline) */";
+	static const char line_verbose_nodur_inline_exit[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |    } /* activate_task (inline) */";
 	struct perf_ftrace ftrace;
 	char *out_buf = NULL;
 	size_t out_len = 0;
@@ -425,6 +437,33 @@ static int test_inline_processing(void)
 		free(out_buf);
 		out_buf = NULL;
 		ftrace.graph_verbose = false;
+
+		/* Test verbose noduration prefix formatting for synthesised inlines */
+		ftrace.graph_verbose = true;
+		ftrace.graph_noduration = true;
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_verbose_nodur_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_verbose_nodur_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_verbose_nodur_exit_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_verbose_nodur_exit_task, out);
+
+		fclose(out);
+		ftrace_cpu_states__clear();
+
+		TEST_CHECK("verbose noduration inline entry preserves comm-pid",
+			   strstr(out_buf, line_verbose_nodur_inline_entry) != NULL);
+		TEST_CHECK("verbose noduration inline exit preserves comm-pid",
+			   strstr(out_buf, line_verbose_nodur_inline_exit) != NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+		ftrace.graph_verbose = false;
+		ftrace.graph_noduration = false;
 	}
 
 out_cleanup:
@@ -742,20 +781,56 @@ static int test_column_layouts(void)
 {
 	static const struct {
 		const char *desc;
-				bool verbose;
+		bool noduration;
+		bool verbose;
 		const char *in;
 		const char *expected;
 	} cases[] = {
 		{
-			"default layout", false,
+			"default layout", false, false,
 			" 7)               |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
 			" 7)               |  wake_up_new_task() {\n",
 		},
 		{
-			"verbose layout", true,
+			"noduration layout", true, false,
+			" 7)   housekeeping_any_cpu(); /* <-ring_buffer_unlock_commit+0x1a0/0x1f0 */",
+			" 7)   housekeeping_any_cpu();\n",
+		},
+		{
+			"verbose layout", false, true,
 			" 1234.567890 |   7)   bash-1234    |  ....   |               |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
 			" 1234.567890 |   7)   bash-1234    |  ....   |               |  wake_up_new_task() {\n",
 		},
+		{
+			"verbose noduration layout", true, true,
+			" 1234.567890 |   7)   bash-1234    |  ....   |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
+			" 1234.567890 |   7)   bash-1234    |  ....   |  wake_up_new_task() {\n",
+		},
+		{
+			"noduration context switch marker", true, false,
+			"   7)  bash-1234    =>  sh-5678",
+			"   7)  bash-1234    =>  sh-5678\n",
+		},
+		{
+			"noduration irq entry marker", true, false,
+			" 7) ==========>",
+			" 7) ==========>\n",
+		},
+		{
+			"noduration irq exit marker", true, false,
+			" 7) <==========",
+			" 7) <==========\n",
+		},
+		{
+			"verbose noduration irq entry marker", true, true,
+			" 1234.567890 |   7)   bash-1234    |  ....   | ==========>",
+			" 1234.567890 |   7)   bash-1234    |  ....   | ==========>\n",
+		},
+		{
+			"verbose noduration irq exit marker", true, true,
+			" 1234.567890 |   7)   bash-1234    |  ....   | <==========",
+			" 1234.567890 |   7)   bash-1234    |  ....   | <==========\n",
+		},
 	};
 	struct perf_ftrace ftrace;
 	char *out_buf = NULL;
@@ -767,7 +842,8 @@ static int test_column_layouts(void)
 		memset(&ftrace, 0, sizeof(ftrace));
 		ftrace.use_inline = true;
 		ftrace.filter_retaddr = true;
-				ftrace.graph_verbose = cases[i].verbose;
+		ftrace.graph_noduration = cases[i].noduration;
+		ftrace.graph_verbose = cases[i].verbose;
 
 		out = open_memstream(&out_buf, &out_len);
 		if (!out)
@@ -787,6 +863,29 @@ static int test_column_layouts(void)
 		out_buf = NULL;
 	}
 
+	/* Test noduration IRQ markers do not pop active frames from tracked stack */
+	memset(&ftrace, 0, sizeof(ftrace));
+	ftrace.use_inline = true;
+	ftrace.filter_retaddr = true;
+	ftrace.graph_noduration = true;
+	ftrace_cpu_states__clear();
+
+	out = open_memstream(&out_buf, &out_len);
+	if (!out)
+		return TEST_FAIL;
+
+	ftrace_process_fgraph_line(&ftrace, " 0)  root_func() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) ==========>", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) <==========", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)  } /* root_func */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	TEST_ASSERT_VAL("noduration irq markers preserved stack",
+			strstr(out_buf, " 0)  } /* root_func */\n") != NULL);
+	free(out_buf);
+
 	return TEST_OK;
 }
 
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index c3da2d1f44f4..515d69a576fd 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -573,6 +573,9 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
 	memcpy(buf, line, len);
 	buf[len] = '\0';
 
+	if (ftrace->graph_noduration)
+		return;
+
 	if (*pipe_char == '|') {
 		if (ftrace->graph_verbose) {
 			/* In verbose mode, duration starts after the comm-pid '|' */
@@ -611,10 +614,12 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
  *   [ abstime |]  CPU)  [ comm-pid |]  [ duration |]  func
  *
  * The abstime and comm-pid columns are only present with --graph-opts
- * verbose.
+ * verbose, whereas the duration column, and thus its '|' delimiter, is
+ * omitted with --graph-opts noduration.
  *
  * Return: A pointer to the last character of the context columns (the final
- * '|' delimiter). Returns NULL if @line is not a trace record.
+ * '|' delimiter, or the CPU ')' when no delimiter follows it). Returns NULL
+ * if @line is not a trace record (e.g. a header or a context switch marker).
  */
 static const char *find_func_column(const struct perf_ftrace *ftrace,
 				    const char *line, int *cpu)
@@ -668,9 +673,14 @@ static const char *find_func_column(const struct perf_ftrace *ftrace,
 			return NULL;
 	}
 
-	p = strchr(p + 1, '|');
-	if (!p)
+	if (!ftrace->graph_noduration) {
+		p = strchr(p + 1, '|');
+		if (!p)
+			return NULL;
+	} else if (strstr(p, " => ") || strstr(p, "=====>") || strstr(p, "<=====")) {
+		/* Context switch or interrupt marker */
 		return NULL;
+	}
 
 	*cpu = (int)val;
 	return p;
@@ -765,11 +775,12 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	func_start = skip_spaces(after_pipe);
 	leading_spaces = func_start - after_pipe;
 
-	if (*func_start == '\0')
-		return print_line(ftrace, line, out);
-
 	is_exit = (*func_start == '}');
 
+	if (*func_start == '\0' ||
+	    (!isalpha(*func_start) && *func_start != '_' && !is_exit))
+		return print_line(ftrace, line, out);
+
 	if (is_exit) {
 		char exit_name[128];
 
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 4d8a56ce878c..f611e9869913 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -37,6 +37,7 @@ struct perf_ftrace {
 	int			graph_retaddr;
 	int			graph_nosleep_time;
 	int			graph_noirqs;
+	int			graph_noduration;
 	int			graph_verbose;
 	int			graph_thresh;
 	int			graph_tail;
-- 
2.55.0

