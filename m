Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020111.outbound.protection.outlook.com [52.101.195.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A941E6D6;
	Sun,  4 Oct 2026 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116146; cv=fail; b=eo7GHYdyWz4kOXmNoDp/CTeL8UqlqntAo8czHPducGe+j5KgriP3NLzmucbMdfpaj/Oi/IE7hfIcvtyteQAMmSxqTdOTCls+PzqlEI5/Ncv32HCweqC+E6KczwGkhPJTGEWf40FVhAlqNt03ClDcIt/A/RoocSjM2QAG1+u5ZZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116146; c=relaxed/simple;
	bh=rWEXrGIHNvTLcdx8sIC15+C7/7fMXc6NVqT6vQFhS8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PCre9BXtWNZfRpUqNnDSwH1YmOMJMditX3joMWA0VMr7Nf9HYAV5Kk0SbfgyDMkKAghKAehokjidlo0+A/7/i+kEdKtseD0DdgwVGGy9LQ7jJXbOggRBtbbkZ177Sj7BsmHkJb7vcYTa0g0N4IXeqIU5Jm4gWeNsg/ZIrt/O/Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KY7USBrAZ2e40/+9pHS5e3jGorV/vqBBcR6/IsnmtG9FrRhc5kum+dZu/NxZa8zyDzRY0FGWPqqRxLPxncgNxWFsxZXDJegg86nB5G9DCtpywsMPv95grfkT8V+QozMSUT5CIvAV+U03eM+2twT3uLRZ6re/m2b3oejN3SOmo+GLhoSnH+t81kzzU+9LDK/F8KWpeqnPk2ypEpgY1VwF0Z1Ibf29AkDmXNm2+tFI7x2JvXaScVx18kkCfG3+qKFozbiVutDF4OrTDrH5HRt0GnPZUVNDjWC1CFQCMO9+8qrK07bqsdRECheUuVss8JHTjTuW+eeXD6YyuQNqB08ImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=elbUeuAWjZVql40S6pfQk+l3LRUUsCzsSVr4A6wNsJc=;
 b=fyrqxoYZ6vLyACtbNLn9LPdZn3c4rySBj5z6Q+6BMbRkf0I0ztDJ8u9NJA9TJhladZcossxXdTVRM7ZBsuIP7zid+B1+Gkvlg3V/8ZQv5V2tZTJHDY9DBUEPBplEP575KvTmXbp6+/RTaKq8p4bMLTKIBPnk7ABmWW+Tt8HiOLS+UUR5DaPY/EcEct9+wV0pHq3vKlzkLNlYC+Y1uvCGbCVjBpldYHmYJkVJdO2igmy/PadP9qr3HYNHXgw8+jYE5z72haIYiblSahuTCV1oAk08NDOP9hdCVstqAqG5pXS0y6HDK/qLHkL1vEB4FWP0JjZUTESbjKhb4VpUlM9OjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB7012.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:15:40 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 12:15:33 +0000
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
Subject: [PATCH v2] perf trace: Support --bitmask-list with --libtraceevent
Date: Sun,  4 Oct 2026 08:15:31 -0400
Message-ID: <20261004121531.380660-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0116.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::14) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: e67acf8f-0366-4d2f-2922-08df221130a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|56012099006|10067099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hyesPQUaDS0wdwivZ9rhnizwRBa4mYEwaStZULat0TJKoTj1XzbXgQpuLoCbma1AjgVMCcPXeaFrkf5BJdN+vBhUTdCYM8jgtk+Vxy4bZ0TyxtiSOnNQLZhxwxAUhqiOkSMQ3U0+5CWqO4WtcRWnCyMLctTYQ+37Hyi+4zHxYVptITdIK6g732rpq1HyBQpfFW2Hx7vy53ix2qsprW4CaLG/PHdHEBX0DAyi0iqppgwkSVhtBbRWaYsBl99z3upsTlQ0FobmyVjIVpWfg8arzIGFYS1oRsFnx4+PvmLkFkaqdOfKuWwUjvyhNygxR/J+GYv9lUdZqIXmO5FQA206RjfDX5TFmxzMYL6E3MjbCyv/bRYX3U7aONgkiTlHYRw0T//fHibWTps402sByKjFOplMiR4VLUm+RBFeYVKKmek1Z1MKyNilBQICJHKBWYdzM6jK0Emjfq4ezvZtgCSDoUCWRlPfAvdxmist+Q5llHB9KyvGnnFfQ46jITdN+v9Rbq+SGiB7rLEtSr93g229sBKWg+9u8IkkuzQoooXdSiTfOLxyILr5kIjvVmoCDtddoH+hHjzHQAXaI7SraItanv2q4i4PCx7m6Apm8NxmsIBq3xGRObCG4u0ShP2eqZUdQW6fXDH0Y2S8YOO73bkUmPYjOTMjXMzDD1nGMUf3S4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(56012099006)(10067099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CLk4zGTuHukJGGMoTUDfAkkF4tap+eFQAfU5/1L2qHdtRincC8007Wprgcj/?=
 =?us-ascii?Q?76AZtGoOMcGLcYHHAHYAhxuJUE728Gcf8iKGrPLt31yqmDjAzuoLrjFVr/Fb?=
 =?us-ascii?Q?f2wkSoQJvUf6rUcHNYbO6IkjZZzI2KPGzWfNMkX3iSp03575EqPcLMejbQtu?=
 =?us-ascii?Q?+pEUlJlcNjBFP1YnMjxuYjj/ngbjhr0A8E9M4KPBEqmxPk3rmTwQuR9APMbR?=
 =?us-ascii?Q?zpLO1iVWERMzfLle+ya/3IohG+rUpU6fvcC5BcWYAVb+aycJDzG3Q8PWWHlL?=
 =?us-ascii?Q?6+AvtdyE9Sm6xKOZnIemDDbdYUE86jOJJKbYPthY4aG1G3z3FsC8YF6qd5Ou?=
 =?us-ascii?Q?UAKBxhJgQdi51Tl7VoUHq23YvgbW94JjDwYw6tauQLENwMR2Kost787fCrb2?=
 =?us-ascii?Q?168+8aA8jZKxNcLq38/+QVP4VfZBQPo7L6q+PR8mzirRnN0L3ilhR1c+Anss?=
 =?us-ascii?Q?1IZyBxIyhWUlCpcXTorgeR8NLqaESbDlxv4338j77l03yP37cw9a+HiCalva?=
 =?us-ascii?Q?dQHHIbQckAUTlruVlUowTB6/nlDym7p4VWCMCyDTMQSllNvV/A/dTh5ZwpKY?=
 =?us-ascii?Q?iat8X6F1tEX5mIDoXnVewZ2XPjiA37UJuBwF674rxxpHdImSG+Tx33Y5l/Ej?=
 =?us-ascii?Q?RtihGLC8XV70+5SIB2tn0mFY1Lhb21ECjb7+YeH6HRfVyAhO+Z8baxpkjEA9?=
 =?us-ascii?Q?I7C4ApIy1dvhlqcJlJBjaVvMBPBANZnj/lZr85v6QAGtZbRjmTePwwGHO3cE?=
 =?us-ascii?Q?qGZFikpDpUGz+dCzbHByQzsJxpfGZHA9pdri5tJFbHeH4a91eKD2flG5sd6M?=
 =?us-ascii?Q?HUbkkclbfwkhHw6mi8AmcOqdnvS/KLmtPIjeWo9vWNSx1nZsoa4+Hui3kOXq?=
 =?us-ascii?Q?D3VQkR03XAbJzduhxrIW+gMralJkug66sMXbGqhsU52wE5UnhIilsdcEjxHN?=
 =?us-ascii?Q?pWU7OA2SN6Ib7QR5V0rKvXa3OwJqDfX0vjQJ4MLjSI/naJoxbi9+1lN/tYmn?=
 =?us-ascii?Q?MD6RUhsBlhmj60Ayqt7Fpv8JOk648Y811MZL+4SlObl+XKHy6aNwnzR+0Xpl?=
 =?us-ascii?Q?+4kxgNsrdficZxA1uFI3nc51/TM3P9P9WJ+avOXr/WVfBiAOpEFjPAFpAJxC?=
 =?us-ascii?Q?9mdKQixyEUVdggVgcH+XAPsOOEjcfj1hrG/f1LJKFQLySsgE4yBW9RmVL4nY?=
 =?us-ascii?Q?H9zeUlTHoE5IikC838wPJw+xm76cGhEUeHVYwCJIk2amfbzguXQR8di4nNXs?=
 =?us-ascii?Q?Ag6NByKVdV4CDh9V1ny38200l8dvygtGxSDR3a4Aq+aacxxM3wbwbrafVjGg?=
 =?us-ascii?Q?Y3OSpQUpoTvFCjwKyk77NV0lnE5D9TWZwVdhUH3LboxQ5NTgDQXPDRze+dek?=
 =?us-ascii?Q?thf0yu8sPRjfjzlN/N2ZnLyn7G9AR/JcfiTMhQH1PgBH27D1EL6FV9JVxPUf?=
 =?us-ascii?Q?TDrvC8FLBZ7PhRRFjtMcOOuWIBP8BTrVNli1nI/neWtLpctvBHYrTjdHpE82?=
 =?us-ascii?Q?kMkMOZIBk5FKXGwjP0OyPYwGwwVNlCASba+uHT7/eNRA/cItx50iiYOCaHJ3?=
 =?us-ascii?Q?1/nNCl18j1EgviWTHWngYgPFQb98HG8536oGHvfhAP6fSRdv/8Dh3f2P5Cfd?=
 =?us-ascii?Q?+KoSawR/iyBnaA1/97UN7K5C+YM3hPt2jwuTEf8JKYstKqcXMLbe9wyZUskD?=
 =?us-ascii?Q?zEMsAXz9bPQ+7FQegW6yiiSGVVL84Pdp7lUNLvaBye4RUBuTBmlMHFJbycNt?=
 =?us-ascii?Q?+x3+kUTvMA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67acf8f-0366-4d2f-2922-08df221130a4
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:15:33.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aXFJu8xSrYEUzNV7jWlXAACp29WNvQte5VrNEyKS2pwbeM8nIW0tl8omStqufSG7Y9ZgIoutFAkV9HwUJ4W8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB7012

Commit ab74d1fbe061 ("perf trace: Add --bitmask-list command-line option")
introduced the --bitmask-list option to display cpumasks and bitmasks as
condensed, human-readable range lists (e.g. "0,2-5,7") instead of the
default hexadecimal format.

However, that implementation only augmented trace__fprintf_tp_fields().
When --libtraceevent is specified, event formatting is delegated to
event_format__fprintf(), which bypasses trace__fprintf_tp_fields() and
relies directly on libtraceevent.

In libtraceevent, tracepoint bitmask fields defined using __get_bitmask()
are parsed into TEP_PRINT_BITMASK AST nodes and unconditionally formatted
as raw 32-bit hex chunks (e.g. "00000000,00000005"), ignoring the
--bitmask-list command-line option.

While a dedicated configuration API in libtraceevent would be the ideal
long-term solution, that requires a new upstream libtraceevent release
and conditional version checks in perf. To provide immediate support for
existing installations, traverse the event format's print argument AST
in perf trace and rewrite any TEP_PRINT_BITMASK nodes to TEP_PRINT_CPUMASK
when --bitmask-list is enabled. Both types share the identical union
payload (arg->bitmask.field), but TEP_PRINT_CPUMASK instructs
libtraceevent's print engine (print_cpumask_to_seq()) to render the mask
as a condensed range list.

As TEP_PRINT_CPUMASK was introduced in libtraceevent 1.7.0, guard this
transformation behind LIBTRACEEVENT_VERSION >=
MAKE_LIBTRACEEVENT_VERSION(1, 7, 0). Within the AST walker, cast
arg->type explicitly to (int) in the switch evaluation; this satisfies
-Wswitch-enum under -Werror while preventing future enumerators added to
enum tep_print_arg_type from precipitating build breakages.
To avoid any per-sample overhead in the event handling fast path, perform
this transformation once during tracepoint setup via
trace__init_tp_bitmask_list() for both live tracing (cmd_trace()) and
recording replay (trace__replay()), leaving trace__event_handler()
untouched. As with existing tracepoint replay in perf trace, this expects
the evlist to be populated from the session header.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes since v1:

 - Guard the AST transformation with LIBTRACEEVENT_VERSION >=
   MAKE_LIBTRACEEVENT_VERSION(1, 7, 0) in addition to HAVE_LIBTRACEEVENT,
   as TEP_PRINT_CPUMASK was introduced in libtraceevent 1.7.0. Older
   versions fallback to the empty trace__init_tp_bitmask_list() stub

 - In tep_print_arg__set_bitmask_list(), cast arg->type explicitly to (int)
   in the switch statement and consolidate unhandled cases into default,
   satisfying -Wswitch-enum under -Werror while avoiding build failures if
   new enumerators are added to enum tep_print_arg_type in future
   libtraceevent releases

 - Update commit message to document the libtraceevent 1.7.0 version
   dependency and the switch casting rationale

 - Link to v1: https://lore.kernel.org/lkml/20261002213145.333100-1-atomlin@atomlin.com/

 tools/perf/builtin-trace.c | 70 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c3c7f1f85c53..57211f4d031e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4857,6 +4857,72 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	goto out_put_evlist;
 }
 
+#if defined(HAVE_LIBTRACEEVENT) && \
+	defined(LIBTRACEEVENT_VERSION) && \
+	(MAKE_LIBTRACEEVENT_VERSION(1, 7, 0) <= LIBTRACEEVENT_VERSION)
+static void tep_print_arg__set_bitmask_list(struct tep_print_arg *arg)
+{
+	for (; arg; arg = arg->next) {
+		switch ((int)arg->type) {
+		case TEP_PRINT_BITMASK:
+			arg->type = TEP_PRINT_CPUMASK;
+			break;
+		case TEP_PRINT_OP:
+			tep_print_arg__set_bitmask_list(arg->op.left);
+			tep_print_arg__set_bitmask_list(arg->op.right);
+			break;
+		case TEP_PRINT_FUNC:
+			tep_print_arg__set_bitmask_list(arg->func.args);
+			break;
+		case TEP_PRINT_FLAGS:
+			tep_print_arg__set_bitmask_list(arg->flags.field);
+			break;
+		case TEP_PRINT_SYMBOL:
+			tep_print_arg__set_bitmask_list(arg->symbol.field);
+			break;
+		case TEP_PRINT_HEX:
+		case TEP_PRINT_HEX_STR:
+			tep_print_arg__set_bitmask_list(arg->hex.field);
+			tep_print_arg__set_bitmask_list(arg->hex.size);
+			break;
+		case TEP_PRINT_INT_ARRAY:
+			tep_print_arg__set_bitmask_list(arg->int_array.field);
+			tep_print_arg__set_bitmask_list(arg->int_array.count);
+			tep_print_arg__set_bitmask_list(arg->int_array.el_size);
+			break;
+		case TEP_PRINT_TYPE:
+			tep_print_arg__set_bitmask_list(arg->typecast.item);
+			break;
+		case TEP_PRINT_DYNAMIC_ARRAY:
+			tep_print_arg__set_bitmask_list(arg->dynarray.index);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void trace__init_tp_bitmask_list(struct trace *trace, struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	if (!trace->libtraceevent_print || !trace->bitmask_list)
+		return;
+
+	evlist__for_each_entry(evlist, evsel) {
+		struct tep_event *tp_format = evsel__tp_format(evsel);
+
+		if (tp_format)
+			tep_print_arg__set_bitmask_list(tp_format->print_fmt.args);
+	}
+}
+#else
+static void trace__init_tp_bitmask_list(struct trace *trace __maybe_unused,
+					struct evlist *evlist __maybe_unused)
+{
+}
+#endif
+
 static int trace__replay(struct trace *trace)
 {
 	const struct evsel_str_handler handlers[] = {
@@ -4908,6 +4974,8 @@ static int trace__replay(struct trace *trace)
 	if (err)
 		goto out;
 
+	trace__init_tp_bitmask_list(trace, session->evlist);
+
 	evsel = evlist__find_tracepoint_by_name(session->evlist, "raw_syscalls:sys_enter");
 	trace->syscalls.events.sys_enter = evsel;
 	/* older kernels have syscalls tp versus raw_syscalls */
@@ -5814,6 +5882,8 @@ int cmd_trace(int argc, const char **argv)
 
 		if (use_btf)
 			trace__load_vmlinux_btf(&trace);
+
+		trace__init_tp_bitmask_list(&trace, trace.evlist);
 	}
 
 	/*
-- 
2.55.0

