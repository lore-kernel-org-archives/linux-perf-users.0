Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021131.outbound.protection.outlook.com [52.101.100.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A123909C;
	Mon, 12 Oct 2026 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765042; cv=fail; b=lN6tAE0qF1mp1YELxWya2uyI+rZvSz42e7IBSSz31e1NopO7QeRSRMa+j9w5OoqAvksxnloOWHOOtmfd7OKBTQVY+gwFeVS93AK5WmxI46Xs2QUwZPKVrYNDlBEW/+4+pdVrVnkbwF5AsCYhTUcIvvDeyPMFAwJPXy7V1Dnt+EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765042; c=relaxed/simple;
	bh=X2zn6pBhRadYQZMk4HQB0phjh+Q4ZViznJeKPantmbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eOTDYkbH+C7j1VDuVBFmvDg13nCBNqrLi/En4vnvZSGWnGK/SlVv7t3CN/9cUH7JwDR6k3R2cInQ1ZZmuIA7Q+w1o3ste53ntkZp6xp1Fwqs3Ah6nldM7lld1tAYdaIr2SS46e78nP97C7d/NdSVJV67iuG3/35I1qDF7p/2IXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2aP3325p5iEqgfeaW4e9jDkiL6/R/ACR7SrwwZRLb+rq6fKuZxHOdz62FJdjiF8hfce9VU8vsKg4mca86q9b9t+5L3TyuydhedDGbAcBpSmzclogZ67gZtfu03auuum6dJ879VK0hy3bXyc1hiylBn7gIJLHMHwMVwczLGp5+JRAVoKf4U4VyM9Mmfo8CDJFErHejnrzJpNiW7H7BZEJClbe57Mlomj4kFzNHeY9MENr6upnHY1l4FRt25tVOg90slpHNnP6FDjHWqsSFhmrLMhUcJHgsL0Xl6Ei6ao8rwUxWTLsyzdqM3Stzs0AeGpE0HcGyClejoErg/iqWW+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=lxYCGLcuxuFXmDbPBVOZ6J4L+wJsS/URXfT/DKpE6PQ=;
 b=aUdaRKhr5OHsW3PQhzmMxdWuR2P7mdy5Vj6x/0H2KWmxbllSEm3oIzJRPLCYEmRfGicn12rmcnL8+77bmz1/3IO11NAttbXTC1uvxq9yNnGRFR3t+FQcMJlMa4K3WpVOfK/4hd9h3Fa/N7iRaNB3G8P358GT5hmro0O7G/LlmP9weqltXcB9rald1CZ6aqYPnDWwve4fnKD8MrDQufzyGNpC/pOSLf/XT6G3YhyMR5ZxYdC9YEiurKcm38JI4EjBvz7M4UxgLh5EKxQNjpcz5sfoUkd9TnfWEDML5rZo2SgOUeHlKrkj8Qnr1/DrTsgksa7L8hufNbe/WHBC7ZWajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOVP123MB8542.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 00:30:37 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 00:30:37 +0000
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
Subject: [PATCH perf-tools-next v3 5/5] perf ftrace: Filter extraneous functions in function graph tracer
Date: Sun, 11 Oct 2026 20:30:15 -0400
Message-ID: <20261012003016.263063-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012003016.263063-1-atomlin@atomlin.com>
References: <20261012003016.263063-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:408:e6::31) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOVP123MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: e74fd897-64f9-45e5-2247-08df27f8099e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|3023799007|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8aq3Xq1VGkwiPzNPNClQ7/ljAd7B+LXLo1kw0uRo5kOvNECjsZCjOmcSTcjVDPr1Gf6xy5vxU8L4u4OovBsvjJ635lNl8V3PsSYRBUvINWMhT/E7x0ckavjltE63N0QY9MJ6RSvF/TeIoVHjB0SHJefzk0VLI4fctSv0UXnwZG8fSAvzp4kk90XeBfklPMYNy946z5lpJvS4UXV0a875Az7jN9EoublU1rpK6C65P9KFsGNZNdWmVP3PxlmBg0TV8ByhxmF/Jt7RwOvwZNavy0tNCA3mUtLMD+dwN4PDFZ0OlncwSXFKbvxLO9J7t5RZ8+rGVXdd6TAiN0Jjn5RSCBpQxM6wA8SlJ0XzQMI82MKPLkYRbsLi76R91pTOERjAko3Ounn2koheTiXrjiRffTFEMm6xyOsEDkNw6CnoWUfJqDngria87TQMe0wvGF0x9t7R1lyLenkCP0m1x71vT65iaqw9Tj6lKY8aClKns2ajzbECynt9JIjJTpGS1gyAq3lFD8udYJzy7l1illwGuc6kO0Wkx/mwx9lF5wUxE2vO6p6/HUzNHQDSmg4nl99g0AA7fuGAqfVrFU5FlX8kxp3Q6Nklr8c45HRW923pncLbfxYEjuIqS7xsTWskvQU5jIqcB5E8Yj3CYzCiffilhcFUfEul+LVWQt687+uYDyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sM+iK2vIqnXekEQp83JuQRPrMHUhjtco0o4Y9bYxiG4il9VVjoQE2yz23SCh?=
 =?us-ascii?Q?5MXs+aA/hiTTymgJmmQ25shZn1w5NhD96GDHvma3GJaDzi8AKkVkT8/8UOUd?=
 =?us-ascii?Q?qHpIFWRqTLtw9hm9umYasLaddjdmACriE2xNh1kw3Xpq4GohDLEhFhusRotG?=
 =?us-ascii?Q?jvWhhIMVbDmA1Xhbw2xqKZmxBuncHAByKrYwuC+dHIqQDvLNMUFLiUG16ZW7?=
 =?us-ascii?Q?mHVchriU0gfnwdvAgHEyROlU9dzzZG0C8q//4DBsy9X4s06r/j9M2jIW3s//?=
 =?us-ascii?Q?7HPa4czBjXXZVe0Ny3Vm4GExZjt9CcWlSIdjpgc2DNMN4g5DB1WXof5wUzT6?=
 =?us-ascii?Q?OgQYQX7C1tYlPUBr2oRsaDSX8ljbqEQqEoYiAp6kXn8/txMYi9so7dii7m9a?=
 =?us-ascii?Q?aAOMmhztlg7JIQ9LCc1PB/BhRujtnJZ+DhIqsKuXuxOgPZYzqw6w7AX4knh5?=
 =?us-ascii?Q?bcPy2RBQHJ8LAuQL8Jtvagx0Pc+fJI5JBA/BM1RGiah7rerAYgWr3ZitjcPt?=
 =?us-ascii?Q?JpPFHu/vlXQDHRdBOA+bCj4tIfp8mYPHv3tdWagxmAZuQJk6Dj9jD09UEe2T?=
 =?us-ascii?Q?OzJq/pxxPKv/oJAoclPDrbQofMxpDEZTPEkYrK655nwNe7h0AvX5CKzeC3i8?=
 =?us-ascii?Q?WgSW0LUB4mAwfu0MoQMDcCDvfyTKgTUN4d2QwWK+EpfvnZLjbuZtCyAwj2kc?=
 =?us-ascii?Q?LKdUEhOagDs+fjtQqmHqvcRRw6Oo3VemxoLvdrkBzGDtVkbPb60zK4khDMTn?=
 =?us-ascii?Q?Zjf46Gd0RicM5ClyRo7AmkoIjKRFiuoELg4IRtiPSzyRZYgppeaA4l1mthXI?=
 =?us-ascii?Q?78GYmCJ2aWMo1RAYk2hYcxnfs5axCCfoe6P6VNWsYo3rePRv5WhIQY5tXy47?=
 =?us-ascii?Q?IL8I4yW9ANMn/nXKIvdyIfkXBqKURdCC7UC2H9pV/+2+9vXZwrE0uG/6+nOJ?=
 =?us-ascii?Q?AJkjX3pW9a8qNKKZx1vHuPFAGXMrGA93VsQzWGC8e4b0RP88z2jqwo5cy7iT?=
 =?us-ascii?Q?nuqZgG5j73bAdUCIhWNc3rZijNh+o0JTvgP4zGPE04x505+9wPnNJoONGNnN?=
 =?us-ascii?Q?T/168IxuBFXnUlUcO6eACDZAjYkR46DNaeveki6tfT5Qdf286wW1ctTVkd7H?=
 =?us-ascii?Q?fCXz8xgiJM4Ct9Rw4LnjJ2DQuetNK+XbtGfDT8TTs7JZWoxET0xSXwSzAPX7?=
 =?us-ascii?Q?FOh9G04o9S3Lq8WvadraQYdtbmzA0vr3L9LgaRbpLtH7SiHt4Pg9bc4ezeQy?=
 =?us-ascii?Q?acCx8g21PoSADa10qB0t7ziHVemhCVEnO3xdKN1GaqSiS01jC8eMY9TqiG4c?=
 =?us-ascii?Q?8+ERMckrBgnsBhODUewvuUYQ7iUWHPJxPG66qjK9HFdto/CV0NbxDa2Jq7Mr?=
 =?us-ascii?Q?M6mVe3pTsNBn7WXJSWT7N/yNpWl9FM8Zp5vjT1ffKxB5pIzG0rtwU2vjEbwD?=
 =?us-ascii?Q?ZOJRsktKZi386leEZfzniknM+DDMZhI14RFlZBPS4s42ak+XUZdLIlxaM3rx?=
 =?us-ascii?Q?yLlaxnafj6RUQCTaaRwRkgv2i+deSE9nYRI2GMQ72lzljCWO7ngd/QH8GvZr?=
 =?us-ascii?Q?e04TMo3GShIYKrRlS7GWmUgI2CQ8RpvCl4qCCIBYrHDM4QawxW3lAg8MfY0o?=
 =?us-ascii?Q?5sjiUMHQ+QQ+ZAi6QJJsferS2VrE9cuIeyqSzxDtE+dwHGf0lPXfVopO4ADk?=
 =?us-ascii?Q?jijNm+v0RP4nbZlvboTQAUDzTTa5lxMDmruKH4HOHOrg5kUD2nmuQsHejxse?=
 =?us-ascii?Q?Y9G2/jmihA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74fd897-64f9-45e5-2247-08df27f8099e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 00:30:37.8181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2GXL/FN3rYsmFuCq90ZOdfMoR8cDJINSXIAzSK+THzeH6cZIiRPrmQCGjmb6Vel3TPq4gflKCtQO7CzliH+0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP123MB8542

When tracing with the function graph tracer using a targeted filter
(-G or --graph-funcs), users occasionally observe unrelated functions in
the trace output:

    1.  Top-level functions (e.g. most notably
        finish_task_switch.isra.0()) appearing before or alongside the
        requested target function. This occurs because clearing and
        rewriting set_graph_function creates a transient window where
        remote CPUs still observe an empty filter (tracing all
        functions) before RCU synchronisation completes, coupled with
        perf ftrace sleeping in poll() on trace_pipe right as tracing
        starts.

    2.  Detached/orphan calls inside the target callgraph (e.g.
        housekeeping_any_cpu() and arch_irq_work_raise()) appearing as
        child frames under the target function. These routines are
        invoked by rb_wakeups() to notify perf's poll() on trace_pipe
        whenever an event is committed, and execute while the target
        function is on the CPU.

Resolve both issues deterministically in userspace:

    1.  Track active target callgraph state per CPU in
        tools/perf/util/ftrace.c. Any top-level entry not matching the
        requested -G targets is suppressed along with its nested
        children until its scope exits.

    2.  Within an active target callgraph, validate that child entries
        descend from an active frame on the target stack using their
        return addresses (CONFIG_FUNCTION_GRAPH_RETADDR). Any detached
        calls originating outside the target hierarchy (such as
        ring-buffer wakeups) are suppressed along with their subtrees.

For example:

    # tracer: function_graph
    #
    # CPU               FUNCTION CALLS
    # |                 |   |   |   |
     3) activate_task() {
     3)   enqueue_task() {
     3)     psi_enqueue() { /* (inline) */
     3)       arch_static_branch_jump() { /* (inline) */
     3)         enqueue_task_fair() {
     3)           enqueue_hierarchy() { /* (inline) */
     3)             update_curr();
     3)             enqueue_entity() {
     3)               account_entity_enqueue() { /* (inline) */
     3)                 account_llc_enqueue();
     3)               } /* account_entity_enqueue (inline) */
     3)             }
     3)           } /* enqueue_hierarchy (inline) */
     3)           place_entity() {
     3)             avg_vruntime();
     3)           }
     3)           __enqueue_entity();
     3)           dl_server_start();
     3)         }
     3)       } /* arch_static_branch_jump (inline) */
     3)     } /* psi_enqueue (inline) */
     3)     sched_info_enqueue() { /* (inline) */
     3)       psi_task_change() {
     3)         psi_write_begin() { /* (inline) */
     3)           psi_flags_change();
     3)         } /* psi_write_begin (inline) */
     3)         psi_group_change() {
     3)           record_times();
     3)         }
     3)       }
     3)     } /* sched_info_enqueue (inline) */
     3)   }
     3) }

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/tests/ftrace.c | 191 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/ftrace.c  | 174 ++++++++++++++++++++++++++++++++--
 2 files changed, 359 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
index cb212339e666..0b88feb97a1e 100644
--- a/tools/perf/tests/ftrace.c
+++ b/tools/perf/tests/ftrace.c
@@ -368,6 +368,193 @@ static int test_column_layouts(void)
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
+	int ret = TEST_OK;
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
+
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
@@ -388,6 +575,10 @@ static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __ma
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
index 5cae01a28529..96a41077dccb 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -34,6 +34,9 @@ struct ftrace_cpu_state {
 	struct ftrace_stack_frame stack[FTRACE_MAX_STACK];
 	int depth;
 	int inlined_depth;
+	bool in_target;
+	int target_root_depth;
+	int orphan_depth;
 };
 
 static struct ftrace_cpu_state *ftrace_cpu_states[FTRACE_MAX_CPUS];
@@ -393,6 +396,39 @@ static int print_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
 	return 0;
 }
 
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
+ * target filter, false otherwise.
+ */
+static bool ftrace_is_graph_func(const struct perf_ftrace *ftrace, const char *func_name)
+{
+	struct filter_entry *pos;
+
+	if (!ftrace_has_graph_funcs(ftrace))
+		return true;
+
+	list_for_each_entry(pos, &ftrace->graph_funcs, list) {
+		size_t len = strlen(pos->name);
+
+		if (strcmp(pos->name, func_name) == 0)
+			return true;
+		if (!strncmp(pos->name, func_name, len) &&
+		    (func_name[len] == '\0' || func_name[len] == '.'))
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * ftrace_process_fgraph_line - Process and output a function graph trace line
  * @ftrace: Perf ftrace context
@@ -429,8 +465,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	bool has_open_brace;
 	bool has_semicolon;
 	bool has_retaddr = false;
+	bool has_filter = ftrace_has_graph_funcs(ftrace);
 
-	if (!ftrace->use_inline)
+	if (!has_filter && !ftrace->use_inline)
 		return print_line(ftrace, line, out);
 
 	pipe_char = find_func_column(ftrace, line, &cpu);
@@ -455,6 +492,11 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	if (is_exit) {
 		char exit_name[128];
 
+		if (cs->orphan_depth > 0) {
+			cs->orphan_depth--;
+			return 0;
+		}
+
 		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
 
 		/* Find matching frame on stack */
@@ -480,8 +522,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
 					if (cs->inlined_depth > 0)
 						cs->inlined_depth--;
-					fprintf(out, "%s%*s} /* %s (inline) */\n",
-						blank_prefix, exit_indent, "", top->name);
+					if (!has_filter || cs->in_target)
+						fprintf(out, "%s%*s} /* %s (inline) */\n",
+							blank_prefix, exit_indent, "", top->name);
 				}
 				free(top->name);
 				cs->depth--;
@@ -499,9 +542,21 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 			extra_indent = 0;
 		}
 
-		fprintf(out, "%.*s%*s%s\n",
-			(int)(pipe_char - line + 1), line,
-			leading_spaces + extra_indent, "", func_start);
+		if (!has_filter || cs->in_target) {
+			if (!ftrace->use_inline) {
+				print_line(ftrace, line, out);
+			} else {
+				fprintf(out, "%.*s%*s%s\n",
+					(int)(pipe_char - line + 1), line,
+					leading_spaces + extra_indent, "", func_start);
+			}
+		}
+
+		if (has_filter && cs->in_target && cs->depth <= cs->target_root_depth) {
+			cs->in_target = false;
+			cs->target_root_depth = 0;
+			cs->orphan_depth = 0;
+		}
 		return 0;
 	}
 
@@ -509,6 +564,92 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	has_open_brace = (strchr(func_start, '{') != NULL);
 	has_semicolon = (strchr(func_start, ';') != NULL);
 
+	if (cs->orphan_depth > 0) {
+		if (has_open_brace && !has_semicolon)
+			cs->orphan_depth++;
+		return 0;
+	}
+
+	if (has_filter) {
+		if (cs->depth == 0 || !cs->in_target) {
+			char entry_name[128];
+
+			extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
+			if (ftrace_is_graph_func(ftrace, entry_name)) {
+				cs->in_target = true;
+				cs->target_root_depth = cs->depth;
+				cs->orphan_depth = 0;
+			} else if (cs->depth == 0) {
+				cs->in_target = false;
+				cs->orphan_depth = 0;
+			}
+		}
+
+		if (!cs->in_target) {
+			/* Non-matching call tree; track depth if entering scope, suppress output */
+			if (has_open_brace && !has_semicolon) {
+				char entry_name[128];
+
+				extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
+				if (cs->depth < FTRACE_MAX_STACK) {
+					cs->stack[cs->depth].name = strdup(entry_name);
+					if (!cs->stack[cs->depth].name) {
+						pr_err("Not enough memory\n");
+						return -ENOMEM;
+					}
+					cs->stack[cs->depth].inlined = false;
+					cs->stack[cs->depth].indent = leading_spaces;
+					cs->depth++;
+				}
+			}
+			return 0;
+		}
+	}
+
+	if (!ftrace->use_inline) {
+		if (has_filter && cs->in_target && cs->depth > cs->target_root_depth) {
+			if (ftrace_parse_retaddr(func_start, caller_sym,
+						 sizeof(caller_sym), &caller_offset)) {
+				caller_idx = -1;
+				for (i = cs->depth - 1; i >= 0; i--) {
+					if (!cs->stack[i].inlined && cs->stack[i].name &&
+					    strcmp(cs->stack[i].name, caller_sym) == 0) {
+						caller_idx = i;
+						break;
+					}
+				}
+				if (caller_idx < cs->target_root_depth) {
+					if (has_open_brace && !has_semicolon)
+						cs->orphan_depth = 1;
+					return 0;
+				}
+			}
+		}
+
+		if (has_open_brace && !has_semicolon) {
+			char entry_name[128];
+
+			extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
+			if (cs->depth < FTRACE_MAX_STACK) {
+				cs->stack[cs->depth].name = strdup(entry_name);
+				if (!cs->stack[cs->depth].name) {
+					pr_err("Not enough memory\n");
+					return -ENOMEM;
+				}
+				cs->stack[cs->depth].inlined = false;
+				cs->stack[cs->depth].indent = leading_spaces;
+				cs->depth++;
+			}
+		}
+		print_line(ftrace, line, out);
+		if (has_filter && cs->in_target && cs->depth == 0 &&
+		    has_semicolon && !has_open_brace) {
+			cs->in_target = false;
+			cs->orphan_depth = 0;
+		}
+		return 0;
+	}
+
 	if (ftrace_parse_retaddr(func_start, caller_sym, sizeof(caller_sym), &caller_offset)) {
 		has_retaddr = true;
 		num_inlines = ftrace_resolve_inlines(ftrace->machine, caller_sym,
@@ -535,6 +676,21 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		}
 	}
 
+	/*
+	 * When inside a target graph filter, child functions must descend
+	 * from an active frame on the target stack. Suppress detached
+	 * calls originating outside the target hierarchy.
+	 */
+	if (has_filter && cs->in_target && cs->depth > cs->target_root_depth) {
+		if (has_retaddr && caller_idx < cs->target_root_depth) {
+			if (has_open_brace && !has_semicolon)
+				cs->orphan_depth = 1;
+			for (i = 0; i < num_inlines; i++)
+				free((void *)inlined_names[i]);
+			return 0;
+		}
+	}
+
 	active_inlines = 0;
 	if (caller_idx >= 0) {
 		for (i = caller_idx + 1; i < cs->depth; i++) {
@@ -645,6 +801,12 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		}
 	}
 
+	if (has_filter && cs->in_target && cs->depth == 0 &&
+	    has_semicolon && !has_open_brace) {
+		cs->in_target = false;
+		cs->orphan_depth = 0;
+	}
+
 	for (i = 0; i < num_inlines; i++)
 		free((void *)inlined_names[i]);
 	return 0;
-- 
2.55.0

