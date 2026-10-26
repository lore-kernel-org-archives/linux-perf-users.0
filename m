Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792983500;
	b=1YZeH66M+Adto6DBX3eSPP9Dx3SuRkBS5aHq4RbMPNsgDY6itJ/fyS1+3lbY4HdWES0g
	 0NrbgJbVWPdqetK0y70GJAOlk3LDFCmWJDOwJ3pP/KC0prb7TgQEtzq9ETjbeGNmiayfw
	 iZ6h1q1qSsWKsj2VvilvTDeVda29t7FceOEIt5a1LRMmXl/NT2AnriMPpXaX8wwGX4zp4
	 Q/TrkL3H7i0YtohXnOCThNNjxHYht09darShZTotWHjazWn/LHgmhBXuLiRQKwgvOMADZ
	 4GOX97XP1XApQ3V5u3czAx6C4wp4B77WjmWrH7Ybg8HWorhhUii/LhZtpv8q0VzTZ+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983500;
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
	bh=CBdq6tRA2GV6yv3FkRjQu5k7LQI+guW49ZeoV8y0UXU=;
	b=OzkYy4uKXK+NQN5/MR0OfhC57ojvmkEYYqqT2vPQwlx3P7uF4CdlDJgoEwvvrBhS0DON
	 +a2MSIARD2rWngMEtMO1TLj4xj8r8PNmUP+s4ggPWqrvEg9LT0rUHMVARUk4Pa0Wlvf/f
	 mZ/i6cL/TTIYsxxAHU7BLUm6QD8MwUcjhI/b9Y3YnY0ZASYzQ2hxDrTeuLzHPFR1AgWXp
	 JOQIRmydO0gGFawa5J0F4ztF1wuW3y4cPbJfeQC9FD0vq6QPzu0ELdU2E4BHbOIzVsKBN
	 p/qtHAZOXxBKa9aPrhSYjGjUgMMYGQN5qpBMuBV4A7OejBo/J+FHDjMcLkJeYzL2Myw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.111
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021111.outbound.protection.outlook.com [52.101.95.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0989606A31B;
	Mon, 26 Oct 2026 02:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0989606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQaPtKYYCitR25iKwXQD8XuCH/ivfLddpHVfr36joN8vdF/SQVRWy65C5aOEZGz1AR2ZO5BSje7pjPPMBhBcaCzseeWsDEBDbp5eb+D7gdDnSA90MROVDqz3Fj1WNyY1BwIjvT1hqQXPkx0PeT8VyU0Y3ibte/Qvl7Y9C8XsTwVzGzjRVgAoIEN13XmQSOBgvIUlYs7Boto5KRTC5uvh5pRxikVyo5ue3jFoSec6EJHOmHEDe2Rl1Yg8NY8TO3mqzssCWZp8X6MF9SP7O8leA4+c0jausdDDe9TnM+E9OslVBsVAkWsur0cUTNx8pJ63PXywZZwJpnlpBQicIzbN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=CBdq6tRA2GV6yv3FkRjQu5k7LQI+guW49ZeoV8y0UXU=;
 b=r8Kuz1TjcrBMiW7C1RPqt7t7KeQPk8J/p4EtiK6d+G92M7dp+Oq+/+hAsMFaOqzUuuWA+Uyid+Y25kSZT94Le1JyUX/XeK3wbWWRRKFSqCba3TH7afdPaT4yGLYSUWci5279NdgecBawHEM0CZu5Aq+BSpFNpctmS04bXzRkNsli1Yrsbu0sZ3ZebMppeLZUlTBNbUzIVfdp5Pw2GY1JGNBiYG1MDorho8DU8h1jd0OWRs9CYYexlqPNCWKpxAncG/lDolxtkVxbgqwDtTpygluhHgS4hUc9AirDlvvW0e+cOt11D90GCSTJlTBX0NiiVPsDYq5cxSdKj8GOGaOy9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB9009.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:285::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:58:17 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:58:17 +0000
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
Subject: [PATCH perf-tools-next v12 09/10] perf ftrace: Support omitting execution duration in function graph tracer
Date: Sun, 25 Oct 2026 22:57:34 -0400
Message-ID: <20261026025735.546101-10-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025735.546101-1-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::24) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: b205eb9f-7773-4ba3-6810-08df330cfc3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|261009223027099003|261021133027099003|261022105027099003|261022115727099003|261022113327099003|261022075727099003|261021130227099003|261021135927099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	o8DdLRlpXp0qGDALHYiwdgjwsh4dyPUbaDXBXH8RY0sQFbXFJXsjhP+SNoJEL+RxUWBpbqqxQ2yjl4P0KU5cO/o73EcUkSvSTlUO9VsXe3uQ/reD5K2if8dFDjjT+6Xs7gAfoBEzJxKOGPG5vuwmcrlorB2BnqQY1HkyEcbvYPaKp0elxNmjQ+ZDFggv7dwRSJIEeS26dlWbiax1fIxEM7hZJ3EnET0NJFazsH+8BxkJFe0QFDUrNxyDwxU1m7vrPrSoTmmQ6vLMVBDbZb2+TCRr5pQ1J75gJswCMNKm7rY2zVqdRY5J1i/WN7jKDpQWnlAk1hyA1qgsh0AHhqTzkd5id8u0ozJSOg82uQWWvFLOx9EowaRZdRYGFO3Lz0tThA/UHO9keBfgDzWtHIatPM8n7Iqup5BHe9lXzk0soL4cZ42fUXCTgLWBrkx6cDSexnIBCkWYsof32SecNZYDlw49n0UEMsKY/ZeQXX0RFJLTZzzHOBQPibXsB+6l/cTel2v5eCMpZNNYLc3V+Tc9bK7R8JigEEFm9oDOjyFwD/x431mp8/xpCaSX81vlupqVX8zpoeO+YaY+c3lMwnPmokvHdnRT0RJjex9mEqdCTSvHE9ikmvcSXEaRj40VlWWn2LXlMP2aigqiL36sG/bdd+nqxb1QaFss4VFN3k8fcuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(261009223027099003)(261021133027099003)(261022105027099003)(261022115727099003)(261022113327099003)(261022075727099003)(261021130227099003)(261021135927099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fa0+FV3RMW5ecabqXuWwRBbl6yr9XSB6JcnaTgfwnQT7qL4EnaOYnURy94Su?=
 =?us-ascii?Q?rNlRAvtEvh/fU7nZRBF14zaobIJBLf+vtIkV3BJYVNjptNjM6oFTsymSM+KP?=
 =?us-ascii?Q?96az4HnK+eepJdivqzTEhZ26eKg5g0WXN/OEQ28MHlddbcBO698fX7V+jNuM?=
 =?us-ascii?Q?EKJgMP3ljgwWl+SFqUQ1yneD2UedkWpBKVXzm+MtnIb569G4AIMSFTgv5Ec5?=
 =?us-ascii?Q?nrcksMEbQY08sL2v2uvLikbtWAzAKg1ucx0PA3PuPgYaFhB8OHcXSj/Qm0BZ?=
 =?us-ascii?Q?YBZypntGvQAJr64Eo8eXpnEP9dP2mfxOsjH5/hU81cQNjyC+xtdNlZvfE8Ma?=
 =?us-ascii?Q?xMlG2U6BOrwR746paugrThkI5I10+q1qRwuHOiqWdrwmyLUDzH24YPCp9FkC?=
 =?us-ascii?Q?d5WQME3IIGDqLH2fns8cI6xcoD/pUm6RQ4ZyXOxW7x2iPnpeq3Y82rCjRnAE?=
 =?us-ascii?Q?dQWUrU0k4K7uw670QMzRZ4wJEKJaqSIXC4VNXi3jMaiN9lLGAsfUn3h8sZR4?=
 =?us-ascii?Q?UECXHsIfE1fiobAHS6ltMoH92CyjX+zYXTOtAawXGEsprf1QpvKQnxchJssp?=
 =?us-ascii?Q?jPCY5vJXE8aQcovdk7pRAA57KXPontNlvIf715ylzVATAnM0jY+nF/m5Zc2B?=
 =?us-ascii?Q?unlYC0TL5XwE7YiXlZfwpy0qr65aCaMlpVPbwAbq/oEGuPTAQphk+aqG4dn5?=
 =?us-ascii?Q?IuqReW9NUAZW2HN2QGRR0yQNkRipedQ/FyxU9i4SInkx7jC41XgKFbRj+zbM?=
 =?us-ascii?Q?WTiH+6HXfbsEQ+IhNR+oWPZC2u2NpVWe+Yz4W8jiZ6Ky5Dx7R2dKfqJZE2aP?=
 =?us-ascii?Q?tiG5Myv3SbtsuSrAfPDuyPi45vMUlripCi2GgQk3LIC6NFmDySaNRV7Xhxme?=
 =?us-ascii?Q?IUQ0bwujk2LGrmWYWXHPwUWbZGsaGefMOGZCVeiMC37DRCt7pRoOznfjkyTP?=
 =?us-ascii?Q?vvzi0UVrB+QTg/xvMxsp6ItP3HouJeB9HtMvAqLb37jkKrO3zSqYCeaBadKN?=
 =?us-ascii?Q?59srPmMmNaW3g2oV0UugHMini6GgF6WzPcZBYbqv3pqZ5cVLQLb7XvWXKHLU?=
 =?us-ascii?Q?odL5xiPBoyifmiHEsn2SJpJyrqgOCUuly24XOYWmHJqRr0hc5tTsJwvFDOSf?=
 =?us-ascii?Q?VMfWRjs/tk1jXk98mTmi6vm2J+UYimzxcjkt6zkwA89BF8HffjswazGr2Wh2?=
 =?us-ascii?Q?tiFRavfN0hDbyniCM3C1OFbJOZ7JL4jMtImwDFqIesQjR/kadHnItnZWgxsx?=
 =?us-ascii?Q?isUZsgeopNCCs9qTkbdmYksAzDF2DoRgMYT3c3RGAwNtuWKoBSVhRYVvDnmo?=
 =?us-ascii?Q?ym2E/COMpt0pCZzx7MF+ydVYgJQqMa/Dl8pNv/UmHl+mX0NWPnGq1gU1aot9?=
 =?us-ascii?Q?OOAbwsuG536COJpKOvX7RHvm3tuBZE381ni2yigHeRceZb6U3Hrmex6EfeR5?=
 =?us-ascii?Q?blHI50LOweBF24p5/mHbzwNF1bDqIISDNVn83waYGimUgfIWNzGiD8qzNOI3?=
 =?us-ascii?Q?up4K/7gdxv67i6Mu4Yrk5s9gk089maCS09ORoJOfVPo8fV2VqgI3HVbARwTf?=
 =?us-ascii?Q?gnGGTMJhsAW8XYBvYoq/YhPlVqw4tIX4iaxmL2toMr1/vpZ1FofOsNe2C3ZP?=
 =?us-ascii?Q?+gDe+spTK3GQmIk/CufzH/oJxI7UmTTI5uyqwkwgadxY/PidgkMf2sZubue4?=
 =?us-ascii?Q?mdzPCAzZDo/PFH/d4TzEfEFdCNlPWNL0qe7BiitSJb9ptQeofSepiDhj+c7G?=
 =?us-ascii?Q?BwPdZPEq8Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b205eb9f-7773-4ba3-6810-08df330cfc3d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 02:58:17.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1wMG3PbNAI1hUDtcXsWDAzLAd0mpmlMcYf7z6HR23oAjesd/mQdSCS8t9DbVzOU3xqnA73cqYnu3GdHU+49dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB9009

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

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-ftrace.txt |   1 +
 tools/perf/builtin-ftrace.c              |  34 +++++++-
 tools/perf/tests/ftrace.c                | 104 ++++++++++++++++++++++-
 tools/perf/util/ftrace.c                 |  25 ++++--
 tools/perf/util/ftrace.h                 |   1 +
 5 files changed, 154 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 0af6b0c1f134..ed2e45b8507f 100644
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
index 1f652d1e2754..db9616ad68af 100644
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
@@ -2073,6 +2100,11 @@ int cmd_ftrace(int argc, const char **argv)
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
index 734d1e97bf07..0aef2cd9b07f 100644
--- a/tools/perf/tests/ftrace.c
+++ b/tools/perf/tests/ftrace.c
@@ -160,6 +160,18 @@ static int test_inline_processing(void)
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
@@ -497,6 +509,33 @@ static int test_inline_processing(void)
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
@@ -845,20 +884,56 @@ static int test_column_layouts(void)
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
@@ -869,6 +944,7 @@ static int test_column_layouts(void)
 	for (i = 0; i < ARRAY_SIZE(cases); i++) {
 		memset(&ftrace, 0, sizeof(ftrace));
 		ftrace.use_inline = true;
+		ftrace.graph_noduration = cases[i].noduration;
 		ftrace.graph_verbose = cases[i].verbose;
 
 		out = open_memstream(&out_buf, &out_len);
@@ -889,6 +965,28 @@ static int test_column_layouts(void)
 		out_buf = NULL;
 	}
 
+	/* Test noduration IRQ markers do not pop active frames from tracked stack */
+	memset(&ftrace, 0, sizeof(ftrace));
+	ftrace.use_inline = true;
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
index 2807846d7449..ac1fdf922c7d 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -802,6 +802,9 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
 	memcpy(buf, line, len);
 	buf[len] = '\0';
 
+	if (ftrace->graph_noduration)
+		return;
+
 	if (*pipe_char == '|') {
 		if (ftrace->graph_verbose) {
 			/* In verbose mode, duration starts after the comm-pid '|' */
@@ -840,10 +843,12 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
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
@@ -897,9 +902,14 @@ static const char *find_func_column(const struct perf_ftrace *ftrace,
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
@@ -995,11 +1005,12 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
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
index 7b9e0919ae8d..0afaa9695691 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -39,6 +39,7 @@ struct perf_ftrace {
 	int			graph_retaddr;
 	int			graph_nosleep_time;
 	int			graph_noirqs;
+	int			graph_noduration;
 	int			graph_verbose;
 	int			graph_thresh;
 	int			graph_tail;
-- 
2.55.0

