Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792951940;
	b=NsvVg1VGl5XHPVKviMXLPJdD0pMMGEU3WLKu8glCqfKHcr/tSASRJUph40Hphgm1UXpJ
	 +rR2m1i7q3Bw+nXh6alKHqEXQ6UPWAfQBLMp+sGAUWhPgwzzcuhAKa9jtroifYk7tVE0F
	 l7GwS9efGJYPS8V4Kex7UxUUJSAhWKWD6JgBeKtxVd8gYgDkaG358qEiiXJzVu72sX8/z
	 AgWqELzGyTqlOaWHF9owlDnC8Z/IScorhUZfZdoxSSbd1XvEHT9anq7uEOyjaRviVuZJV
	 dKoNP0kuk3cwoRwigUHnh3dxgD0Ke23PVYVbaCHE2b6Fyup/E5aePyG62paiDuF/DDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951940;
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
	bh=BaFKKwaiBi5nQGpIFo9OpAkLoUYdUuQfqeveOHKRXNY=;
	b=Ii/p89A2L5m7LllminPT7keaReR710ZcGGB4Wq4EBKXnH7VNHVmgg3FX57rNPWPQMz+q
	 uFjCJnVFaCRAH+8xqJIYR11tvnCHka//VoWmWKkfaAcf5HXFWKB/O8wK0lqHYTOLjtJwJ
	 n6kSp6YgyMgggihvCrny1itMYHuSlEwoO2GbovMxsoSpsVhmmBxNZLxF9zXFtLt64yPgU
	 KtBKHUEF48JUVOO2znx08rhKZQSevPO3TPQlhCGFBuRubzDCWTvwsgWJkhWed9DwpTesV
	 uOZL0PeJ2mpYFDM5PwYwXoAPjCeyRTz9WsRkJ7B17Ilzy48Tq0JdusujIrl43lYJ5EQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.80
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020080.outbound.protection.outlook.com [52.101.196.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9136F606A321;
	Sun, 25 Oct 2026 18:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9136F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgWKaVK9RY6phWhROjBLWSkcnZjck3NxxSEqcDDImaTrsNG4+jCHkJzD4y589GRUbtA5c1td1xo2zeYtJE3CFEvIve87qJlHWN8U1gwQqJ51Uwqk9MZeHxcjWjeqjH/VvMEra2ID4aJr8OIVrvY8NJFDBZI0xhg2mGuo22IyuEnClVplBI9q2USqJVvQiwQmyIVnXtuTm2yyallXP0ijsbfrNXB7uCdU1M3893+DBWERYJ7DxxBxTBO1kKkPGSnKR6G60qvBjnVxL75xX/lLpOVXseCj5GCKj00rtJhybeaElIgvBZhM3+NqIxozHDLMxssXP1fFriPogu0/h+RGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=BaFKKwaiBi5nQGpIFo9OpAkLoUYdUuQfqeveOHKRXNY=;
 b=u9F6a2lj5XLImNlqT6MD1IxolnX88F6BFUIbvfvZ6d7Q195eSvd8mccivxTl1ixdf63QKnj7In+jBs83WZYS7bMSuXj+Z4fWICtH2LmY5iX9IrhpsRYitib9hDTBdBRoM8Kqi1kOf2P82fF9o3g+wPi8a8CRw2+QKyi/jevsMUQBwIkN3A0qTTAWdBrlgeDfWuhx/CYfohiz8/H3B1W7UzdjLSKd7WmSuMzMvhsYzDZWWkAWCp4ILGpfFkpHHYK53Ongokt7nKHsuA7TyBHJovwgI6MWdXRUgtRVoQuXQCqnEfPJx8BXKcPkP9dkV/FBkhdmaoRiOFzVsFi4lYkt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6815.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:30e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 18:12:18 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 18:12:18 +0000
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
Subject: [PATCH perf-tools-next v11 09/10] perf ftrace: Support omitting execution duration in function graph tracer
Date: Sun, 25 Oct 2026 14:11:24 -0400
Message-ID: <20261025181125.514372-10-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025181125.514372-1-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0895.namprd03.prod.outlook.com
 (2603:10b6:408:13c::30) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: b3e30447-650d-4dd0-6229-08df32c38172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|261022105027099003|261021135927099003|261021133027099003|261022115727099003|261022113327099003|261022075727099003|261009223027099003|261021130227099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	33UR612f88kh3PeOb7uYNsl8FIz1WZDblbBhtI4H8m+Zj0r+1xxOV51QEg1ZtrKlUsigQkAsrFI6AlCJq7Q56uDTumO8WwKwyH/iSWBB2q91gjXhb9V86k8P6lOzoMRUvK3+vL0GOheVft69Ryku3jyJbl5LFT3ViGfF3hyzP574IM50ircyUqoQCbYBVUPM+k1aGRGEDoiLAq7lNo1MFKoEWckksVeMDSGT94zIwxoqK+ntR0f1ddFD0kQFPem404c8klfA1S3cROnojKg11JvK48xcYqXTv4A8UagwqBVmZ+ERZnzrcfFFTJpD6IwtWAWYN5pJj2z51it6biDmjW29CnXfaNtNh9Cf5ptJ6KaSyjAQ3CuEWrNNZQO0Y9Ur7HeVshh/KN66Y2aROUadChhZJLBAzV6YOjf9cGKz3kg6/6kHNM58UzyKaGh44Uui1RfOxdHDuaVAIWprQE7vqt36ruhpzeOKYFdKoMiB7JWg1JXqwZ7gg7a9kneLy62UkGCYQfPZ37xfO1K0ve5LENPn+r4ggjc2q4NwbTyJiCuglF+Wkq05yVAtp7xVk6Y9KLvsacrgsBMBBvN+ptEtKIeYMHySuD9hLiYoEogPVAfMnt0uSAK5GVsvLYuq0UuqOlSVIu04vgec1GK2hAPMR85i+OcPFGF4fPDOU++yKyM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(261022105027099003)(261021135927099003)(261021133027099003)(261022115727099003)(261022113327099003)(261022075727099003)(261009223027099003)(261021130227099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1NzQRmkzb3DdSOJT5rQp2nLTT4IJdx/PsJxbbkzMmKKsDMdJjxUI040qxeuA?=
 =?us-ascii?Q?dnJSYfoUmlLeXqgk+apyjjZ86nqsjZZi8aqZrJ85o8yONbvVXq6GgPOXZg2k?=
 =?us-ascii?Q?sbrQktTwm6GsQqcxA+f0imhqnNfzzqWScxF7rcaHGowgcHxCI3y8gO/mdPyy?=
 =?us-ascii?Q?YIGrBgB37mZtpe5UOhdehjHIYtXGLJoy3fBFqdd5+lSY1GTgNeKpzSJNzMhO?=
 =?us-ascii?Q?Nu00p3NmxX96mx64Wtbe8UpSXW49kJnkf0TexkmhDKxyZ7WzJo7wi2/gScCk?=
 =?us-ascii?Q?HSEDZX632ExguMqaQxx7XUz3mOzJktse/kx6orWf+Xr7T/5rP/ll3IUR5EHE?=
 =?us-ascii?Q?wWt/0Z9sh6bP/8/1ioiLEo0on/cJG4vJ0fcLzG5G3+wus6wuusVTF1FKwUrb?=
 =?us-ascii?Q?sItvkfqoJQDt2BBSO90sTuYGrKdDFmn4837CPgp+DFEn3TrujwPFybsAD7CN?=
 =?us-ascii?Q?T370KcbjuLw9JXWMcQ2H6tyB3a9mk2AKql0MNjso4IkMfo1ClBA/Yk0EyARR?=
 =?us-ascii?Q?VCVEcuLTfVwzl5Fs38dVlEiWtk/jjE1ZOWw77vQDBD29+bW0eTc/DX9mWU1q?=
 =?us-ascii?Q?4stP7HDVXiqdvxk+CT7nYFaJ3BKGp0jjC2s5QNM+CWWOPpA2REPfg4KIDFw8?=
 =?us-ascii?Q?bnSvTVpg9QfPrf3IaSsa5s64V2oicd2mDLoFLJxMvOkXA29N6mSdHQb9W8yE?=
 =?us-ascii?Q?7hpXwORYsVKEXvwLMroQq6rg0BzHm2k8e7i1tL3kxGBgxT3+gYAhvQ2Ox1T7?=
 =?us-ascii?Q?ed/uj8LjUp8cW6U3efTmGboOwQf6zfI7kMBMTe3T0NeIlHbMoi/3A5r1FBzm?=
 =?us-ascii?Q?V6b9eLqdIh4H+mmfc+5bwg7M/gdJ2iZSLhN/GIkCL4ac4yn03akoB/wW5pdy?=
 =?us-ascii?Q?cu4TovLrByxplpLQrTG3juPrbARTS7rG5eb+Qhx2YyTErZPXMOpxXoxvW1g0?=
 =?us-ascii?Q?Wyw5ddkzdXIvQvvga4+UAK4RbMv7JI99Dar2R+fmOR1LXF/qYOK9rrv7XNUA?=
 =?us-ascii?Q?pr5SMMlDqHnPegXWVqi3tiVhq15WinJfG6PSSYT+OOfOss6fsgjX2/gYWAoy?=
 =?us-ascii?Q?kqvfgZLcPM2Mag352ntik+yo9X4MydueBBBD7fzT+bTxYLc1V6d+oOZe+4lQ?=
 =?us-ascii?Q?efccMiOd+Dk4C7MbVSxOhOGz+meS7uXUuw0x8J5YYhOnJEl5kF0Bea2NOl9I?=
 =?us-ascii?Q?9XucEw8j0QB+43i+1SyqXWPrLdB45FFXFOMw7deB1Kx5KB627vzFxbPHgaaY?=
 =?us-ascii?Q?U3t7p9WPm177uVBZpHucH2O9I4qjn/wldo+oxMDuEJ2xKHBW3aXtIQiN2a6c?=
 =?us-ascii?Q?wffB0YmSeSac558OYy4s00kkA40gS5qg/5QaiuGnsLQbhO9AEr3Fsd0QLN0t?=
 =?us-ascii?Q?7jE3CcergG3nU/7RlbuAYdrBiBtXRykj3YQ7bwaih72LxTaR+qtSu37VC9Cm?=
 =?us-ascii?Q?xeSv4lxu0tWgJh+wwCgezUGQd2oSzuP7l9kAMKSf676BXcXNiKEIlWirVpsX?=
 =?us-ascii?Q?UpytwVkDPKUK2Utepw97V0mUXRh6QmJWaJrFklIwYIPsRVUINgKICdkQioMs?=
 =?us-ascii?Q?FyChKm/vQxZ+fleyu2P0OVFpjJUH/Wdv0XIXGXwKaMbSyn6BWOIlAPAf3k6N?=
 =?us-ascii?Q?OkKzPQX8bzu1ZzhKVYLO5knUqj87gStLECHnqwbp4DdYi21BbepZx38zbehj?=
 =?us-ascii?Q?fr3cU16/J5pi6BZugQaoyVsa1tJaFbLNWyC6hoIaWYXzdOdc9kQjzREPubS+?=
 =?us-ascii?Q?YQIDSi5BJw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e30447-650d-4dd0-6229-08df32c38172
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 18:12:18.2714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVe5wxgJBC4Z/zRmKXGJkh001MExFDkP1yGi0AEKxCWKfK4WRtBvy8cxlpQuxFvLIMtwQzbWSVOIMcVVHhd3Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6815

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
index 85ff1ede5454..384fc03850f2 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -708,6 +708,9 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
 	memcpy(buf, line, len);
 	buf[len] = '\0';
 
+	if (ftrace->graph_noduration)
+		return;
+
 	if (*pipe_char == '|') {
 		if (ftrace->graph_verbose) {
 			/* In verbose mode, duration starts after the comm-pid '|' */
@@ -746,10 +749,12 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
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
@@ -803,9 +808,14 @@ static const char *find_func_column(const struct perf_ftrace *ftrace,
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
@@ -901,11 +911,12 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
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

