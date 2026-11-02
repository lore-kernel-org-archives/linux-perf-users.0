Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.129
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655701;
	b=bbEscHN/jR1/3bGqyuCYgIN8qvAB2XKjWvfF9zqdLotzjTl8ekz+TIAtoui9H8PC4ZLK
	 8TqECJGDK85nDf5JMz+bfBq6sNT3cfYt1O6MqwZ9UNprhh1SRxJjNrjYMAAxRjR2JsfSn
	 ZWTZ/vkgxSVmRiBsOZYt4FkX9tKmw8/hI2bKdlCkTRtZj8K/YiOASepz2KOaYEhjoLXS9
	 OEmJ2ntJLF6MoFxlLicqefJvnwJLlvzz2dYLsFc35zxTEA3tAO8RthTnMUwC88YFxyLhU
	 TwnjKg4K0OdHl5DWbFFsprkTiMxQsiHmvmqlDfySj+9odgGEGc9lHy6j89GGcxs35aQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655701;
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
	bh=dEepGyW6c/ClehA/I6Tr3sO+aD+xn2Ck43kRqpoGkvM=;
	b=HNv/bTgs92ewmtIURnw6QPcwnSxTuH3gKx/h+VE6Db307vOF0f0MBawD/q3SwLXyDk0Q
	 ekEu0S+vLFkeP0No2GEtQx3V1mmfQsd0mrfPwHHW/cIqNE/Dsv8ehMzDhy7u1Gn+nXf73
	 98UBUKl9yfM+nnvI2nQt+8oplsQC2z/I1kS09974wOIRcdXLSrl7xmyDHFdg03ZwPVPtP
	 /SyRdj+9Avh/ynBZ1g6VJAU7zGAHRDJk4Lu1Ro7+D6VCqzHudkzEIFPKdN8uyqgr3y3lL
	 HS1YUjuqe91VDqhODYGfax4gCvMcpWjDnzBe1TfAqtlwx4XbysHeCrtfJj+tkve8lMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.129
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020129.outbound.protection.outlook.com [52.101.195.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92007606D81D;
	Mon,  2 Nov 2026 21:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92007606D81D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzezGvbcH8sqFZoXAQ+Qt4eXzZPk76s2gmpm0Pnwc1Xo3lTSy/Y7VHQTVrjdLNyBLXuU2sYletKnfK3/7hpF8Q7L4ws+njXJs2QDapCfylr1UjJjgR3svw3YQPDSjuLoCNd5grhR9grSkHO+uzT+TqYWsLcUXOiCZaB3QNOMVsilraJmNHMZZqfSvjy9WcfdOf34xDZQbZdDkTq6s5d8dp0pnpWsUWzComSVRijtYjLsNwfrtze0f5KDcX5pQXA5E7zVQLepP1RlNYhHCjDPqHHcAHuefaX3mYCC2Yxcfz+TCulMIxnS6jSOdUhjtlBH/mZa+CXQp91Fe7l/BPxc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=dEepGyW6c/ClehA/I6Tr3sO+aD+xn2Ck43kRqpoGkvM=;
 b=XHp1jly7TfsPrIY/zEYa0vh5c6yZwbco5n8pI2bBzjXsJ4UK+Og3juuEhTybVVoFSDkb0GV1ohGFcpjEJkMULKv0F2gYo8pB8De6uYee0T8bwzHMqdm10bjDVeqX/NmcN5iDUWmzLpSav1FR+QqO6M8mMZjLL5FlqgwZcvjEabM5lzWTkABUUK2XokzGTv50VrTsf1MmESV4ISUlP5cjCxtakazJpv4xZLd9Dikl2nNR7DXrbpgWdpWv72DvnCzUZmVTdQtWYS0z+fibw4ekgmiaPh5nKFsA9qHhW0LdIlNMu8VtEBFnS/NRo2d1iemO7lEZSGcygLrG/ZAJNsUPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LOAP123MB8322.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:41:37 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:41:37 +0000
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
Subject: [PATCH perf-tools-next v13 09/10] perf ftrace: Support omitting execution duration in function graph tracer
Date: Mon,  2 Nov 2026 16:40:53 -0500
Message-ID: <20261102214054.911298-10-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102214054.911298-1-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0269.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::19) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LOAP123MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c808a5-3e51-4559-d831-08df392a126d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|10067099003|261102123227099003|22082099003|18002099003|3023799007|56012099006|261021135927099003|261026130827099003|261021133027099003|261021130227099003|261026135527099003|261021121427099003|261026140227099003|261022075727099003|261022115727099003|261026121527099003|261022113327099003|261022105027099003|261028144727099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	4ea29NRrD7iu1I7l2WeiiY8resnDKIzKaSQRSMSbfbWnWHPmU3j4uic72Ze2gmVYLP6w0h1lyi704ifvtyTSqIPLbh04+s4a5FV8mLP3H9C/PiRR5Uj63/oz+TpqtYbB0p76nJzDhfgfE8hR06JolC1qf0zXDlJsXuU+nRnKYtmRYTsSkR9OEg9iJdSC0YhPLyL+TVunACj4QLORxaAKULFFf5Ova2g/PLi6yjuaw65OdRXQObYj/g0jaCXl1fnywqBjWGQI7/poNRefGEuFVY6+3y8/WvFINAVCeTjcbp1J3gnaTZi7aV7Yy3WGIdmqkJCUqHXwl0sO6zBRl91YccXbWLZ49VOmNokHZEi/KDKb4M/2HQ2kKRdHejADp5QrjjJWrq8+38gsjyOgq15xrmJncflezK3l6fKp+AJyrm/u2x3p9BQJsMLASG71lWlhveNFMS7wTzb3imx0eEN9TmEn1lWX+0LFcXaFYNJqt9ZhE7enu8b6tbkLG1wlIDhMz5DD3lr4BZPFB3DNDkD+06v+gfT/jJhjVwGE2X0XrDdugzBZ83QRCGPwwNvQGFiOIqtG+idLaMeUE3Th2aITISOCkiHV5IASVEkLGSWhAZ9lEBSiJPA8hHtkwH9HfUVwqkEvNchdjPIOcdM5Nz57DFUny1Kvx00oRPawLVxKlKQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(261102123227099003)(22082099003)(18002099003)(3023799007)(56012099006)(261021135927099003)(261026130827099003)(261021133027099003)(261021130227099003)(261026135527099003)(261021121427099003)(261026140227099003)(261022075727099003)(261022115727099003)(261026121527099003)(261022113327099003)(261022105027099003)(261028144727099003)(261009223027099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e7voDvspOX1EguFPL+QrGZCw3Z8BMkPitUj2aLcPF0niO/Hp5cAm2VcPPVav?=
 =?us-ascii?Q?ccO/ATy7po8TjV5rZMOILaugFmPrva/jkXKGwJEorHbhPc5p0GwOI3qNcQDj?=
 =?us-ascii?Q?KNwbXkK5tibuugLgFU9HxphJBLYjFZAcEVjYCBFWYb31go8ksD9nb0tE9Ejf?=
 =?us-ascii?Q?ArsDpwHvsBvAcApA2mx+m7rYUkpJo9v8deHDTFmRZKZ3GXYNoo7+FoagIo2m?=
 =?us-ascii?Q?RtNvFtpdOpjQQUSYRZ84LjZ7uE02fG40eh18ft7Htiqt3wc71702dKGWOCuN?=
 =?us-ascii?Q?ESgVmxnoRuPkBFrjP3rQxGJL6kSt/Mu+q73OhQlGSJO9Gvy0EjckwxWckPFC?=
 =?us-ascii?Q?O7SQDEV7k0BeABQ1Y0fYtDU3RIAF+EW3riwb+xTq1Tt/FdCwcqpJtMroTalG?=
 =?us-ascii?Q?nIRfSh3aPd3x4mrFHi+X9mnwz63ezLCVKa6D5f6uEgG/0E9rGkuGOjoAqcl/?=
 =?us-ascii?Q?AhuHDu0z+syeeV42iyU3TIV3LXp1AtttPj558UU72TF7vwu8acK8jlZHPGGx?=
 =?us-ascii?Q?bPKZlmslW1daMNm9uckIwEJ1snC7IOQn2m4441x5uUk3emipwVXimc257Yy5?=
 =?us-ascii?Q?IM7r6wHNp76VwkHfn+j3S0ie8CLt7WoAmECtoNBnDoha/oBJUI2l83zpptr1?=
 =?us-ascii?Q?4n6ZMmQ2CUGcWH6Qm5lSgVuUxvPVNuPvWuPXzT+SKgzRMJo35VG145oCxMWE?=
 =?us-ascii?Q?PEPNjYeJqyKcTrb2Lct5L1bZyIcfcZ6b30XaSq41OFoJQEGFEeclrpH3q5O5?=
 =?us-ascii?Q?I+7LIx/T7upiP9LI11tODWES5bu6wJJrhkRIch5hva8AtRiz3ogn7Kr9L/BI?=
 =?us-ascii?Q?qeDKjf7pU/lYu2QMXzVTIcSSx0sbvBoazKZquy0RSBvBDNVGTwIwPYcpO2MY?=
 =?us-ascii?Q?0qCGNqk2NDR68GwqcIpwbCVaIrqcQPDjfiJTixT3dA1T2Y4hJxacPN76MJKn?=
 =?us-ascii?Q?yFzKCdt1kg4Ayl0SJrRqq46bgLlZOlu+L84xLRn1Tt21rau7gWIxvylUMGl0?=
 =?us-ascii?Q?iB2FWzOrCjbx/dGp7azTxyje8J+6rOSp0X79sxsqVG0Gb/JysApbKxNw+Ys2?=
 =?us-ascii?Q?ktuqLhAXccRpu+sYg1NA5DnCLCbacx+zP4F4VXtCdtF/8NpymOggkCcqI21y?=
 =?us-ascii?Q?HKG27rIzVY+pUf0MEdwLUtye/U5oyI4zhfdz7lFR6ojqZpVoDpFLTsGwEaVB?=
 =?us-ascii?Q?VUOQ7dsn8uO3s57k7bfSM8hQnCRpUD8FOHloFl9jHchTA4vU/MDIv3dmBvaq?=
 =?us-ascii?Q?LPPOyDnTTe1wtNw11zbcszAqkLe5nXFedQbRNHq4/p/6ZhCJ7582M03U45a/?=
 =?us-ascii?Q?pkjh9esx9BZKnISwTWB5SJHbZEo46oe2EzKd2zHOCxdinJXgmw1v19HEW16M?=
 =?us-ascii?Q?EMhev5/y9FD/ZrsYkP+ThaJQncxRL7tyJmUCWN4N5R6y9fV2o7Aqyo+zj/MN?=
 =?us-ascii?Q?W7WZYGZYAwicQzl+dB8ihmXvQr3xQOT8kjLJsUJSs61RD3ndK3sdw+0U/kSU?=
 =?us-ascii?Q?VqURR1Q5jBxnGOqXup3smA5nlW6vbveLnKuZtkmrS+mjmNPQj7npTXZFyunf?=
 =?us-ascii?Q?a7MS0la3yb8W1t3GsmJhZB3yJZHU+eW9XsC3sRjPmOqAB5yfgCp1zCWHhdEt?=
 =?us-ascii?Q?YQ9PzsYRHhmgJaYVNr/IgeIYx3eSQgNuagbrQeIX6etD4dRdiqlSpwvt1CqE?=
 =?us-ascii?Q?+d1jM6JoiKS/pdEUdyOPhVx0dsxsvbPjoQGrK2Dci+cK22+d94KsAv07vggz?=
 =?us-ascii?Q?Fk8AFO/rUQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c808a5-3e51-4559-d831-08df392a126d
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:41:37.1739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgRIc9gPKim9akY72I35ParqaCh88ZSvkxC+gYMfft8lBH7OADNWhB0nja/KIcO+aiSpg8eWhtYQmIOgv8ZC4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8322

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
index 900f5390141f..ec3c26a01ef9 100644
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
@@ -490,6 +502,33 @@ static int test_inline_processing(void)
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
@@ -831,20 +870,56 @@ static int test_column_layouts(void)
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
@@ -855,6 +930,7 @@ static int test_column_layouts(void)
 	for (i = 0; i < ARRAY_SIZE(cases); i++) {
 		memset(&ftrace, 0, sizeof(ftrace));
 		ftrace.use_inline = true;
+		ftrace.graph_noduration = cases[i].noduration;
 		ftrace.graph_verbose = cases[i].verbose;
 
 		out = open_memstream(&out_buf, &out_len);
@@ -875,6 +951,28 @@ static int test_column_layouts(void)
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
index 1f31cf31058c..c2cf4a20553e 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -734,6 +734,9 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
 	memcpy(buf, line, len);
 	buf[len] = '\0';
 
+	if (ftrace->graph_noduration)
+		return;
+
 	if (*pipe_char == '|') {
 		if (ftrace->graph_verbose) {
 			/* In verbose mode, duration starts after the comm-pid '|' */
@@ -772,10 +775,12 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
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
@@ -829,9 +834,14 @@ static const char *find_func_column(const struct perf_ftrace *ftrace,
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
@@ -927,11 +937,12 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
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

