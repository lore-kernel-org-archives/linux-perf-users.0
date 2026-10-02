Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021136.outbound.protection.outlook.com [52.101.95.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC483E316B;
	Fri,  2 Oct 2026 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976714; cv=fail; b=VHaRAIqZRMnp4oWkfjvPa1/y6HdO1b7IOfUqv9ihjf7mkPCfU48X75qYQnNnFult9+r+RPJLTh5ljWmFdViose/AfgdiLe/L/bP6YqPfq8xotKs7u5SOtGIBsIMCp2QgfibjDeuPUK91y6OXMuOhj9nbVICLnTk8cSrtRKGi9jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976714; c=relaxed/simple;
	bh=Q9+ph5kGSQRbYvw8rq8nkycPe0eSh7I01fpVHKxaujI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AK9N6FNR/igtB9ldeZdgAR5W5LBFXU/yAP5Sbx17X8ttV3T8eM2lW393KyZNEUfgMAR79ASgN85EItHfsplvneRA7weVryBbNvxGDzdQ7oZm9+j/iXgG2SAWLd/HHeTHgw9Ke8hnK4gZqLwgYCamnFGdmPFTxGw3eXhAkeQ3neE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkgsYBUEiTdimLYre2sNesvmIUmdTfXX2XJcECxLGw2hRBeAUZQYmfv10FtqUJSdej/0bXYS+Y18Sbnt00pP6EDtSKmt3x1SwH/qFh8E68xTQa5W7YL3177XQmEpxaynB6dFqpojZRUm5dajvTxKwYQUIpe/jX08h5O90uqkFULM//woyUvPAk+SpOpUMiFY2ms1imar0iu1YgvIxy/rD7NRGaQvv6eVDHquY/wiurYR5UNYacNGtvQRA8TJGCaZZ8ribhiDNaIFP6WSLCHRT84u+NdcpI6JCEkamQuklealPJNR3AShKI0q0ox+2+LfgHeSI9ppDmPUKlglJNjJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=AEY9HUsxJ+b4G7usFFn6f1hdprCWJSIMXifOADMEcgk=;
 b=sbC5xONavaJVx/agDwYXUsbO/woz00pF69T2O8v8RYNg45bKWgDl8E9+Zpt/zYoqx/OldtbnT5uOUySfzzHO1m+NeA9ip4DxKsk3Oc0HV03AVsn23oQUQM4bjev4+kwyRk3cdkkahpHLxou1hL3nHGnwhE9zdHUr6ck1yQa8s4yPPPqGR8SQBumhUX4cim5Om3r53iSeEkG6B4JbyM+KEKomJRXG+Y9J3jfFTxOg9g4MNNwu5NhD47tpELlLEMBl/EfYRq4l3dAPI8XHT/gKhNbysVQTzN2bO5Yq6RayDQYzp27LWxKXOhL4LVVtjde9M3u5iT7TALspOtsqzcaS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB7791.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:248::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 21:31:49 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 21:31:48 +0000
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
Subject: [PATCH] perf trace: Support --bitmask-list with --libtraceevent
Date: Fri,  2 Oct 2026 17:31:45 -0400
Message-ID: <20261002213145.333100-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:52c::14) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef0e1a2-c7fc-4634-1e62-08df20cc90c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|18002099003|10067099003|3023799007|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	UPPLv4KwL9mRGi3GuKEPJ8BzzLdgv8sFSgcLWs9D+sWIRGR8NufQ7U9Blwq7weJ9/k/l5gvAX4/nzBhpMQoJDwmyUAPSYjJEg+SlXmzfi+LID61oz7sLMjC+4+6k7d0BsTJfHhS2JYyCgPyGGWsgZ0tGHzd+wRQEMpQLkhk1LpvcoZVvCSTZncZ2fKFww2n7hXEs9/lwTwoG19IETd/maFN13XV6BfyWpP+uxkt2az5Gog6m0ZQPQ3MPJxWmHjdBQbbjp58GuI3l2uNgzUvkKM2LpNqTl4kGqb7nDHE0xmJxgXgHoOK0h1YrwTjxTOOsia+0VGxSV9n97DBecW9uao+0qfpIapAuxYy/hu0TrNhCb5XzE50RSkwhyMzhUOxAFOlHPR1eA8op5SuNpoMJeDaIs6rPj31jwKBBPYhNoTA28pArxLgqCEKIqgu58G1nLqrZUANl78u74EJhrgab3/4jAxSpTlQ/oJ5+GMs4+FlViB2nBzhymOXRspxqCUzk3upa7MkJAwEiyld3hsirG43cxIa6CTqdSNE/aLExM62insBLefm3EsMNR3Dd9KOcm2/4dNMSysvpxPBm50tmdBS2BcCViz6SMomiVo6koVkXLAJr4VRXCjEHgo6foBXDVVmu19+PC4j0BrZxo/vFUyf4+hItvIc6JANbT4wIJUE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(18002099003)(10067099003)(3023799007)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g+r/wr1n2spx/EI25bYGmPaj1tu3i5znTl5j4lT/7JtUZHMbvxXcRorCpnot?=
 =?us-ascii?Q?NOD6VlTaUinPdTHipsZfME5MASo9ieS0qOWlJiX47u1lH51RRPTXCJbjCyX+?=
 =?us-ascii?Q?v/Mcv1DwepaNVOZpiZUCQGPhvCXO8w22l1QI80g/RHUEUX4kbMtq2gvp8Msu?=
 =?us-ascii?Q?O3l8BzCUzrM9veCIx99ufp2WD3H7XY166I7g18uWfX5aCjB09BvwkNKM+xbS?=
 =?us-ascii?Q?o1L8eNWn8LRW36ghW12waQA77WGBC0hUd61TC/LqfaVcEB905c5vf+7jyiRq?=
 =?us-ascii?Q?NLAeAxIrczMZxjHixIBMgDVPeVtsx0d+tqszQ7HY9Igiomc8coVVtdIw32Cn?=
 =?us-ascii?Q?LeD5xpmr3I39FyrLLcx9DR6PC3Qm874IXTCdxi45qBbVU6Bv+hRONb8YeVPr?=
 =?us-ascii?Q?+Ne79W/J3ZaKd7t0UNXQd2OSP09LhrvJBuPgA+04zbo9eZmjY4CwQ/dapR4T?=
 =?us-ascii?Q?ui+euHWQ6tt3D/fxo9PEetn7t/J/XFqxNDpYNkR/G1AgPBKq6atj8EqeJ9vt?=
 =?us-ascii?Q?AoP4I59X0hwgT8jENZpxdDsR9VO4djtr787JiKi0rOAbySto2HfLb+qI3jar?=
 =?us-ascii?Q?PNyU/t1fvuYhWVmLXL3FOO5V8i+P1jMonIDYxzwSrXSO8FmgUKDGTOCISWjW?=
 =?us-ascii?Q?vhbpAGlyxeosZrJMor1fBLkHnq1B2WvmM1nCKsql+9iuaRNxXAOSUBh9w9Go?=
 =?us-ascii?Q?3/UN0a6uxlVtOaAgYQFSaxAdibSiTEs/FLP0WVq7mnD/WRNeS0ROn2AUrfbb?=
 =?us-ascii?Q?C4clIIx0LLMztJblneHxPsDufSfo5okRgtaE9yRscDU6waiEyzCX7AhOj8ik?=
 =?us-ascii?Q?ov9YRSiHCBaXAhmVfFyN934wCCtg6h4mfuD78TWWJdNWCt69PuQiPqSaU+lg?=
 =?us-ascii?Q?6dKdBZgPbFCCqC6VzqO0n7TQVZRoynn8IeRpveVWsh1t+YPoc1uNcDCPc+Mu?=
 =?us-ascii?Q?rbwiah/5ZTJO+l0LzK4IhxHDJ/Cr8iTfwlq8OG2wG10a4dlcnHAwJ87Gsx+N?=
 =?us-ascii?Q?GzIRkNHpm8yVuFEBalDyvA1IoGpqFFBF8gUP9AJgeJx0HQibXbmWMy1/xCml?=
 =?us-ascii?Q?b7hurO84gUfSF9zisOPVyUTe5Zv5pMcgfTexDGQhPy9C7bMKQx2GBv9czYAf?=
 =?us-ascii?Q?uedOVMbOYDqCMH8hbycwfSPhuqIJvkwgcGgJiReJhgZbMyBW2A8ISGQXL6+3?=
 =?us-ascii?Q?W3eq8bRG8/KjcPXUbCK1Pb1WWNUiD1sKXK+RaqLnc+3xuwtzgflxA+6o46Na?=
 =?us-ascii?Q?PYNypheL7Pid+saJtVy1qoL8KYlBaC/s+FCLkzU4852Yq+wd0Mx+Axd1RDOo?=
 =?us-ascii?Q?piAoGAUCmNKZVg6rbjcvxkAltPrelTUiZ/Y2W3o8ZunyoVZYQUJXyKk9kmaR?=
 =?us-ascii?Q?DiHJOIILWTsjsq8esjRJYOYabxsP87AOp4V4i0phK3uTKsJbYUYX9LQwYF3N?=
 =?us-ascii?Q?qjWvuEL120G2jFEPfMVNOl8FXAfWJai8wu861SM+F4GzNH0RLDE1nygt01PJ?=
 =?us-ascii?Q?9ndZ2mRBEuYFusxJWZyFH0Y//DHjVuo5N/V9h6SH3fitsYaLwI8kyTdXyL/z?=
 =?us-ascii?Q?ZC8od4NCpmzqnhpSal3jc4tFzr2MowRufO1zhHGFLp38D5e3rc45ZVJ5KWHI?=
 =?us-ascii?Q?m1VsP4/ROziawHRAnVasIMbeZN++OsiddKJhYGyXxc36WIPanZ+1zigHb/XW?=
 =?us-ascii?Q?D5UYdDX4LBZrgRcykdQyf54QxVuiG43dLLIQtfK5g5L0PxH1yOvCg1pBQNTN?=
 =?us-ascii?Q?ufj/6YKW3g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef0e1a2-c7fc-4634-1e62-08df20cc90c3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 21:31:48.6468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqPbp+0cOeLV77LyGivVNu4ONg57CF+8wDvs87PgSvNWFhvy/lryfROgPm1pjShnDolYExJi0egH47hrBrqN0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7791

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

To avoid any per-sample overhead in the event handling fast path, perform
this transformation once during tracepoint setup via
trace__init_tp_bitmask_list() for both live tracing (cmd_trace()) and
recording replay (trace__replay()), leaving trace__event_handler()
untouched. All enum values of enum tep_print_arg_type are explicitly
covered in the switch statement to satisfy -Wswitch-enum under -Werror.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 75 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c3c7f1f85c53..57249df65fe3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4857,6 +4857,77 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	goto out_put_evlist;
 }
 
+#ifdef HAVE_LIBTRACEEVENT
+static void tep_print_arg__set_bitmask_list(struct tep_print_arg *arg)
+{
+	for (; arg; arg = arg->next) {
+		switch (arg->type) {
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
+		case TEP_PRINT_NULL:
+		case TEP_PRINT_ATOM:
+		case TEP_PRINT_FIELD:
+		case TEP_PRINT_STRING:
+		case TEP_PRINT_BSTRING:
+		case TEP_PRINT_DYNAMIC_ARRAY_LEN:
+		case TEP_PRINT_HEX_STR:
+		case TEP_PRINT_CPUMASK:
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
@@ -4908,6 +4979,8 @@ static int trace__replay(struct trace *trace)
 	if (err)
 		goto out;
 
+	trace__init_tp_bitmask_list(trace, session->evlist);
+
 	evsel = evlist__find_tracepoint_by_name(session->evlist, "raw_syscalls:sys_enter");
 	trace->syscalls.events.sys_enter = evsel;
 	/* older kernels have syscalls tp versus raw_syscalls */
@@ -5814,6 +5887,8 @@ int cmd_trace(int argc, const char **argv)
 
 		if (use_btf)
 			trace__load_vmlinux_btf(&trace);
+
+		trace__init_tp_bitmask_list(&trace, trace.evlist);
 	}
 
 	/*
-- 
2.55.0

