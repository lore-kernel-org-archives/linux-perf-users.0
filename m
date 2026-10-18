Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020090.outbound.protection.outlook.com [52.101.195.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1E3515EA;
	Sun, 18 Oct 2026 02:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291109; cv=fail; b=ClHG7KTtzzat1ynp86set/XsTDfB9dIbMb4LrbYL0eVHGFY2/lU2bjyWatQI3lCQbYJjCtSh/T/jlA6InvyIR2VP0z5+7tVfTFJnyqug4WP8i9ID15exmydnJKrLj6WGHGXSq5L0FVhZJ0nDBRn5aglbayrveYeibomB3+PldoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291109; c=relaxed/simple;
	bh=Lrn9G7l9Iium90rT5oXQ4VzdVMAT2wybh77ZPhgr6pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rCFRVz9VkDurX8K54vlXgR72LvPPjAz3bizpOnxK03Us+aBjCS7PtPVKOtQFZVHJe/3uWPCEWVGKaAyCxcfTR4Cl7dz2PTvKo75BdDp1hWeyrvbnP3UiQMrAmNX8kHwhTSaZrMsZN5bETeXrqbrk3rv/rG3YuxXfhfRqZXevi+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6bO031ERwIiL1o9hgP898LrT6tTOxcC3xfiUdXY9YquRs0We1yvZ4gwoNMzulyncVGvB1Rgp4lyPu+VXt0rrq4YQAXlqKkvSE3s9fYoR9vLMrb/KGbYW3UFLQm9RY/Nm8Rce9PBeeL2PJhZh5+FHtNq04lUAr/YZcM0RwHq7fQauKIwJauL6SFaG1LtrXRc6Nh5n8Wi82oUn0xRxb00n2s5/IAfFDZV4ZSqrBERyb4WS9elI6idbfbRa/gBjyj8RLZ3ueli6zP1irhCFqEOi3uLhWeqb2J3xTG6i5EpsyP3QY36ztM+sTpbFQ5QaodnZFFV09WtzA8oI56n5NwJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=tr21gMzFtz43fVFWOn7zM+MQ8QNF5ELiWywaFCz+d3Q=;
 b=Xd6xSuRWBw8AiX+zl0H8jxjKKcFVUlGQGrPxrwRyaVcJs0NIQ+OHyIF37DfHft3u9rIXoYZWT/WSiMBqAeU/UD/+UmyfqN4rraA5gCxIJVZo1KFMk2YhUQ+SAXdzlczEEqOiY6uvxQ/b2LfGYr3Dk38xIhU5JiWf4Lq4fScWC0EVkowfXFQIl3XKVFZjyNlGJmWSg8ANRDq6LsxL2TPBNyf+obrXEDEMQ/V8pRQ4BBINOjfCexbWRskavjA5nfjr1Bo/E+SVHj1b0Sflc868fUEwVmh+l+hQyMbB4NqXu43lOy+xF4k8UsfEQ7KXXrgrprZbkG8bydPl9jO2bMpaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB4333.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Sun, 18 Oct
 2026 02:38:21 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 02:38:21 +0000
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
Subject: [PATCH perf-tools-next v8 6/6] perf ftrace: Filter extraneous functions in function graph tracer
Date: Sat, 17 Oct 2026 22:37:53 -0400
Message-ID: <20261018023753.584873-7-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018023753.584873-1-atomlin@atomlin.com>
References: <20261018023753.584873-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:408:f7::34) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 67dd5e4c-9b24-4900-43df-08df2cc0dfdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|5023799004|261009223027099003|22082099003|6133799003|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	sWfmg5A2ZSpnZ3TAEmLQK6Iso3T3uGTnKGp1mJ2qFJStXpikqXtn5Q59bjBHGsEZLmZxlHLDqmpmUBqDA56feMrTI39aBBNXDthXn0IjsQ0EbGpRwD14fP5uZpXVOCRwrnn6cCIsQidZqIS+5F+KXR1F9DSz7tV9bVOkjrD6J5M5l5FYsKmgpwkn92h2yNVHmpqI/70kajNBaw9kGXxVHm3TyfMXuqRNNee1er0jBBZqaFNRI1lPQB5J5p3MHpTeZp4wF8m1vLSP+33zKQhNXjPvaxBWT+ckeeZQkiFz8S4YVm5X3FUZJDN2uKrS/AKJfJrYN1m1ZXJGXXKbv7l6tf9DFpvUgb6HB6BFr04LKgtWDR/S5IAbQkTCWS5jSdIsRsRQm4uq0NTSM2pPc9Pi+FRFhsTWa+V6MDCWPPxyBGpmXXFrMPbb5vLGUTI9UF9dcsWqxBF4m5EsQlNOma8hqt/mUkduIG67hYVwCoQr5MKQBls7ryremxe6y/xllluoTBpKxLG1c5eQwU+/S4vXwnB/ty9VIRrKTqi3oi04F8pmcg4HNKtQDusJ2JA/Un/2jd07mF7Ku8Xn+HR41b/9AesTV3fDTvXsHbsV8kwPGfPP9YK1k6rbAW/hkdBtQ+OPe7Ruk4KoQqxa/i3IiERsAlaNaOCZ/OdxSWr9NIA61Z8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(5023799004)(261009223027099003)(22082099003)(6133799003)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ILZO7rJ5R9puaJ1KzrioQhMTD9sIZR4dAmtkN8PWwvBLnzHkLmcj/Jjf4na5?=
 =?us-ascii?Q?FJVtZGaqujVWyxEa6LrLa8VuS8m6UkZwvB8bdAtz0LW7W5zX33htfSuj7i8i?=
 =?us-ascii?Q?DC59z/qksCd5V/9bmNTKuSksDjQrbQp7cdyPiJKylmOlfUPRS6O+ab+ZtXrh?=
 =?us-ascii?Q?LB4I+9h/FHNc/V9f9yLZhdaOe9CzmWQg6IV5oYimqjY3yKguHueY8EhtaSBs?=
 =?us-ascii?Q?4XyxZfZDCszhJZMnp7CE+7EuXAgcQeuECnBAdegzx5ogiewv/1jxm3rzIQ9H?=
 =?us-ascii?Q?0lfE2k0qdEkyiqkR36UaB4U2JMgQuokKU+muXsmexJzDXJfiipC0aJ2IIkTw?=
 =?us-ascii?Q?dAVXdVUqUWqpaMtGBuUmbbmbmPjpofX3yMf1c7u+FaxL2unx5c1TGIx3+NUy?=
 =?us-ascii?Q?2JQpnwPe1oKe2TcIfg/VeC2Pke9a8qP5lINzi+XB8GP1UZHuq4Rv6ZbWJJ/t?=
 =?us-ascii?Q?INaimFrTt6/DgK4wg1ISxhTkKyBZaFROtfW2yTTtVKNxA9rN1E7trbnovccs?=
 =?us-ascii?Q?3836Sc8rKoN0bMV4TPFN3v4u354QFeOSfgm+B3lGUrAgUHVglUHFbFcl6P4i?=
 =?us-ascii?Q?BzGDIW/KKz6UPJdhBikIZsBdP/vghxOwk/vAK4X5RuwvvvmjMfII7fq0SEF9?=
 =?us-ascii?Q?iQUNPkfUVieXeCY2+BO20HDerPIXygYM7zmHwlcq0hu2h68OxQNYC/7yFszz?=
 =?us-ascii?Q?Zuq7uMJbIFItF/WKuZOrM4GWNzjNRoUmIfXLC0LENmk6UJPpC9mNUuleV0zB?=
 =?us-ascii?Q?fBYvnAz6Xq0nqnReYnmqXjs5pwoqZSp4ZFDJqlIxbFY4rvzf7GRUfSRj9adS?=
 =?us-ascii?Q?UMH2lk71huJUo990pg/vJuIupcxhYyfedH4GM2je+oEn80Qur8t2Zisz1JmE?=
 =?us-ascii?Q?M+qPsDBL1nFg+RK0exXxzBRS6fLxb0zUGX1NJ6wZ/NnW8ml8yjL77x1Arc1V?=
 =?us-ascii?Q?wnHhjtNAlwbJZxI6wKk9Dg8e95A3RkfnXeTVk/tA0nsxe7bokX15baWSoyHp?=
 =?us-ascii?Q?XUld3Yxw7ZuI/0PJJsOGhVT1JsGgdRczXcp8D4TBzT+j61V+jtc3RtPI5f9/?=
 =?us-ascii?Q?1DQ41dUzN2CAV+vvk1y7CUKDERdB9EAduBQiMoO3MuCaH+EwwcwqtzHGxCV2?=
 =?us-ascii?Q?H/DZKb35JqC0TVtcsDhbuwmOBALICujKXg0RWOiF/bxod7xlKFjUl1zYYs9Q?=
 =?us-ascii?Q?+WeaXzozzdwBcaWpS0aLacRd5RqPyQhy8zlD0txgC/IyV8VXcnByy/F01ePO?=
 =?us-ascii?Q?Holh7W6nr+93KAd0HBimfqwCt/sh1gNVxSnKddkk/m48dw0gHVYTVAi9RM04?=
 =?us-ascii?Q?5ZK0NWca5PeIyPwPdhJlsXXnRb9iWZuRm22aEM8LgCNbI6u+4S9AAaSXNn7j?=
 =?us-ascii?Q?o53DnGcuu8apwTzLnHY1Kdvc0sCml9MVqosfoGceT60pD3NYTiyKtcNisyXD?=
 =?us-ascii?Q?bzfRKdM1hMtW36lvexMqHlUiMKbRYtUXugha6zWy8EI+MkA+uiGCK1IYrM4K?=
 =?us-ascii?Q?25lI5TqGziViWffnaxYjOjelmB+MilDy0DMJQKGfAF0uFtDCQksmWzNZZiPJ?=
 =?us-ascii?Q?mNctRtgtrOSK7bglMT/91OMsu1/H/7HOCHhKoRSAokdkwNIt4NJdnFSj0Z19?=
 =?us-ascii?Q?Xe+6RwND+XKHUi/ABAza4eMpPB1mcqPgIqP+pUTMQN/Kwe+2MZIyL8BaVDtl?=
 =?us-ascii?Q?PmhNfWas4EWO/xPutLrs5C5jkfO4AlzlKg5+/X6AehCHJHNwcyJkoLyTJsIB?=
 =?us-ascii?Q?Np+67HhQ8Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dd5e4c-9b24-4900-43df-08df2cc0dfdc
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 02:38:21.2717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtOChSt119jVpssVCJYJB0jD7zU0bxRoRd0wuhaEe5b/znTS+fw5V+Qh86ZzuKmKF0iPVWmNdIFp1ZN0aWiHXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB4333

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

    2.  Detached/orphan calls inside the target callgraph
        (e.g. housekeeping_any_cpu() and arch_irq_work_raise())
        appearing as child frames under the target function. These
        routines are invoked by rb_wakeups() to notify perf's poll() on
        trace_pipe whenever an event is committed, and execute while the
        target function is on the CPU.

Resolve these issues deterministically in userspace:

    1.  Target callgraph state tracking

        Track active target callgraph state per-CPU in
        tools/perf/util/ftrace.c. Any entry not matching the requested
        -G targets is suppressed along with its nested children until
        its scope exits. When a target function is matched (at root or
        nested depths), record its root depth; for leaf target calls,
        immediately reset the filter state upon completion to ensure
        subsequent sibling functions remain suppressed. Support glob
        wildcard matching (-G 'prefix_*' and compiler clone suffixes).

    2.  Caller provenance and orphan suppression

        Within an active target callgraph, validate that child entries
        descend from an active frame on the target stack using their
        return addresses (CONFIG_FUNCTION_GRAPH_RETADDR). Any detached
        calls originating outside the target hierarchy (such as
        ring-buffer wakeups or asynchronous interrupts) are suppressed
        along with their subtrees (cs->orphan_depth).

        Exits within an orphan subtree are suppressed without querying
        the target stack, preventing common helpers (such as
        _raw_spin_unlock) from colliding with or prematurely unspooling
        active target frames. Dropped-orphan exit recovery is safely
        permitted only when the named exit explicitly matches the target
        root function itself.

    3.  Dynamic call stack allocation

        Maintain the synthetic call stack as a dynamically reallocated
        array, growing on demand via realloc(). This supports arbitrarily
        deep call trees without fixed-size truncation, ensures unknown
        callers are unambiguously identified as orphans, and guarantees
        that standard filter teardown executes cleanly regardless of
        stack depth upon target function entry.

    4.  Automated verification

        Add comprehensive regression tests in tools/perf/tests/ftrace.c
        (test_graph_target_filter()) validating top-level suppression,
        detached orphan suppression, glob matching, deep stack
        traversal, dropped-orphan recovery, and orphan exit collision
        prevention.

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
 tools/perf/tests/ftrace.c | 937 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/ftrace.c  | 398 ++++++++++++++--
 2 files changed, 1294 insertions(+), 41 deletions(-)

diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
index d83dee5a050d..4c70951fd0c0 100644
--- a/tools/perf/tests/ftrace.c
+++ b/tools/perf/tests/ftrace.c
@@ -581,6 +581,939 @@ static int test_context_switch_handling(void)
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
+		symbol_conf.vmlinux_name = vmlinux;
+		symbol_conf.ignore_vmlinux_buildid = true;
+		if (perf_ftrace__setup_inlines(&ftrace) == 0 && ftrace.machine) {
+			out = open_memstream(&out_buf, &out_len);
+			if (!out) {
+				perf_ftrace__cleanup_inlines(&ftrace);
+				ret = TEST_FAIL;
+				goto out_free_filter;
+			}
+
+			ftrace_process_fgraph_line(&ftrace,
+				" 0)               |  wake_up_new_task() {", out);
+			/* Targeted leaf with caller having inline activate_task */
+			ftrace_process_fgraph_line(&ftrace,
+				" 0)   1.500 us    |    enqueue_task(); /* <-wake_up_new_task+0x1d1/0x3e0 */",
+				out);
+			/* Sibling call after targeted leaf */
+			ftrace_process_fgraph_line(&ftrace,
+				" 0)   1.000 us    |    check_preempt_curr(); /* <-wake_up_new_task+0x0/0x3e0 */",
+				out);
+			ftrace_process_fgraph_line(&ftrace,
+				" 0)   2.500 us    |  } /* wake_up_new_task */", out);
+
+			fclose(out);
+			ftrace_cpu_states__clear();
+			perf_ftrace__cleanup_inlines(&ftrace);
+
+			if (!strstr(out_buf, "enqueue_task();")) {
+				pr_debug("FAILED: targeted leaf enqueue_task missing\n");
+				ret = TEST_FAIL;
+				goto out_free_filter;
+			}
+			if (!strstr(out_buf, "} /* activate_task (inline) */")) {
+				pr_debug("FAILED: inline activate_task not closed after leaf target\n");
+				ret = TEST_FAIL;
+				goto out_free_filter;
+			}
+			if (strstr(out_buf, "check_preempt_curr")) {
+				pr_debug("FAILED: sibling check_preempt_curr leaked after leaf target\n");
+				ret = TEST_FAIL;
+				goto out_free_filter;
+			}
+
+			free(out_buf);
+			out_buf = NULL;
+		}
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
+		" 0)               |    overflow_parent() { /* <-sub_func+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      overflow_child() { /* <-overflow_parent+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |        overflow_leaf(); /* <-overflow_child+0x30 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.200 us    |      }", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.400 us    |    }", out);
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
+		" 0)               |    overflow_parent() { /* <-sub_func+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      overflow_child() { /* <-overflow_parent+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |        overflow_leaf(); /* <-overflow_child+0x30 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.200 us    |      }", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.400 us    |    }", out);
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
+	/* 11. Test that orphan exits sharing name with target active frame do not collide (Issue 1) */
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
+		" 0)               |        _raw_spin_unlock() { /* <-smp_apic_timer_interrupt+0x20 */", out);
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
+	/* 12. Test target function entering at deep stack (depth >= 256) and exiting without leaking sibling (Issue 2) */
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
+		" 0)               |    deep_child() { /* <-sub_func+0x10 */", out);
+	/* Detached interrupt fires at depth 257 */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)               |      smp_apic_timer_interrupt() { /* <-irq_work+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |        irq_sub(); /* <-smp_apic_timer_interrupt+0x20 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |      }", out);
+	/* Target continues */
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   1.000 us    |      deep_leaf(); /* <-deep_child+0x10 */", out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 0)   2.000 us    |    }", out);
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
@@ -605,6 +1538,10 @@ static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __ma
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
index 66c19116ee64..26fc5b83b7b4 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -22,6 +22,7 @@
 #include "srcline.h"
 #include "symbol.h"
 #include "util/ftrace.h"
+#include "util/string2.h"
 
 #define FTRACE_MAX_CPUS 4096
 #define FTRACE_MAX_STACK 256
@@ -38,10 +39,13 @@ struct ftrace_stack_frame {
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
+	int			orphan_depth;
 };
 
 #define ftrace_cpu_state ftrace_task_state
@@ -66,6 +70,7 @@ void ftrace_cpu_states__clear(void)
 		hlist_for_each_entry_safe(ts, tmp, &ftrace_task_hash[i], node) {
 			for (j = 0; j < ts->depth; j++)
 				free(ts->stack[j].name);
+			free(ts->stack);
 			hlist_del_init(&ts->node);
 			free(ts);
 		}
@@ -96,11 +101,35 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
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
 	hlist_add_head(&ts->node, head);
 	return ts;
 }
 
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
  * get_cpu_state - Get or allocate active task stack state for a given CPU
  * @cpu: The CPU number
@@ -520,6 +549,64 @@ static int print_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
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
 /**
  * ftrace_process_fgraph_line - Process and output a function graph trace line
  * @ftrace: Perf ftrace context
@@ -556,8 +643,10 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	bool has_open_brace;
 	bool has_semicolon;
 	bool has_retaddr = false;
+	bool has_filter = ftrace_has_graph_funcs(ftrace);
+	bool is_target_root = false;
 
-	if (!ftrace->use_inline)
+	if (!has_filter && !ftrace->use_inline)
 		return print_line(ftrace, line, out);
 
 	pipe_char = find_func_column(ftrace, line, &cpu);
@@ -586,28 +675,49 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
 		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
 
-		/* Find matching frame on stack */
+		if (cs->orphan_depth > 0) {
+			/*
+			 * If an orphan exit was dropped by the kernel ring buffer,
+			 * and the target root function itself exits with its named
+			 * closing brace, the orphan has definitively ended. Clear
+			 * stale orphan_depth and proceed with matching the target root.
+			 * Otherwise, all exits (bare or callee names) belong to the orphan.
+			 */
+			if (has_filter && cs->in_target && exit_name[0] != '\0' &&
+			    cs->target_root_depth < cs->depth &&
+			    cs->stack[cs->target_root_depth].name &&
+			    strcmp(cs->stack[cs->target_root_depth].name, exit_name) == 0) {
+				cs->orphan_depth = 0;
+			} else {
+				cs->orphan_depth--;
+				return 0;
+			}
+		}
+
+		/* Find matching frame on stack if exit is named */
 		match_idx = -1;
-		for (i = cs->depth - 1; i >= 0; i--) {
-			if (!cs->stack[i].inlined) {
-				if (exit_name[0] == '\0' ||
-				    (cs->stack[i].name &&
-				     strcmp(cs->stack[i].name, exit_name) == 0)) {
+		if (exit_name[0] != '\0') {
+			for (i = cs->depth - 1; i >= 0; i--) {
+				if (!cs->stack[i].inlined && cs->stack[i].name &&
+				    strcmp(cs->stack[i].name, exit_name) == 0) {
 					match_idx = i;
 					break;
 				}
 			}
 		}
 
-		if (match_idx >= 0) {
-			cs->overflow_depth = 0;
-		} else if (cs->overflow_depth > 0) {
-			cs->overflow_depth--;
-			extra_indent = cs->inlined_depth * 2;
-			fprintf(out, "%.*s%*s%s\n",
-				(int)(pipe_char - line + 1), line,
-				leading_spaces + extra_indent, "", func_start);
-			return 0;
+		/* If bare brace ('}'), match the topmost non-inlined frame */
+		if (match_idx < 0) {
+			for (i = cs->depth - 1; i >= 0; i--) {
+				if (!cs->stack[i].inlined) {
+					if (exit_name[0] == '\0' ||
+					    (cs->stack[i].name &&
+					     strcmp(cs->stack[i].name, exit_name) == 0)) {
+						match_idx = i;
+						break;
+					}
+				}
+			}
 		}
 
 		if (match_idx >= 0) {
@@ -620,8 +730,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
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
@@ -639,9 +750,36 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
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
+		if (has_filter && cs->in_target) {
+			while (cs->depth > cs->target_root_depth &&
+			       cs->stack[cs->depth - 1].inlined) {
+				struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
+				int exit_indent = top->indent;
+
+				if (cs->inlined_depth > 0)
+					cs->inlined_depth--;
+				fprintf(out, "%s%*s} /* %s (inline) */\n",
+					blank_prefix, exit_indent, "", top->name);
+				free(top->name);
+				cs->depth--;
+			}
+
+			if (cs->depth <= cs->target_root_depth) {
+				cs->in_target = false;
+				cs->target_root_depth = 0;
+				cs->orphan_depth = 0;
+			}
+		}
 		return 0;
 	}
 
@@ -649,6 +787,143 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	has_open_brace = (strchr(func_start, '{') != NULL);
 	has_semicolon = (strchr(func_start, ';') != NULL);
 
+	if (cs->orphan_depth > 0) {
+		/*
+		 * If an orphan exit was dropped by the kernel ring buffer,
+		 * check whether this entry descends from an active target
+		 * frame on the stack. If so, the orphan has completed; clear
+		 * orphan_depth and resume processing.
+		 */
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
+				if (caller_idx >= cs->target_root_depth)
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
+			char entry_name[128];
+
+			extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
+			if (ftrace_is_graph_func(ftrace, entry_name)) {
+				cs->in_target = true;
+				cs->target_root_depth = cs->depth;
+				cs->orphan_depth = 0;
+				is_target_root = true;
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
+				if (cs->depth >= cs->max_stack &&
+				    ftrace_task_state__grow_stack(cs) < 0)
+					return -ENOMEM;
+
+				cs->stack[cs->depth].name = strdup(entry_name);
+				if (!cs->stack[cs->depth].name) {
+					pr_err("Not enough memory\n");
+					return -ENOMEM;
+				}
+				cs->stack[cs->depth].inlined = false;
+				cs->stack[cs->depth].indent = leading_spaces;
+				cs->depth++;
+			}
+			return 0;
+		}
+	}
+
+	if (!ftrace->use_inline) {
+		if (is_target_root) {
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
+				if (caller_idx >= 0) {
+					while (cs->depth > caller_idx + 1) {
+						free(cs->stack[cs->depth - 1].name);
+						cs->depth--;
+					}
+				}
+			}
+			cs->target_root_depth = cs->depth;
+		}
+
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
+			if (cs->depth >= cs->max_stack &&
+			    ftrace_task_state__grow_stack(cs) < 0)
+				return -ENOMEM;
+
+			cs->stack[cs->depth].name = strdup(entry_name);
+			if (!cs->stack[cs->depth].name) {
+				pr_err("Not enough memory\n");
+				return -ENOMEM;
+			}
+			cs->stack[cs->depth].inlined = false;
+			cs->stack[cs->depth].indent = leading_spaces;
+			cs->depth++;
+		}
+		print_line(ftrace, line, out);
+		if (has_filter && cs->in_target && is_target_root &&
+		    has_semicolon && !has_open_brace) {
+			cs->in_target = false;
+			cs->target_root_depth = 0;
+			cs->orphan_depth = 0;
+		}
+		return 0;
+	}
+
 	if (ftrace_parse_retaddr(func_start, caller_sym, sizeof(caller_sym), &caller_offset)) {
 		has_retaddr = true;
 		num_inlines = ftrace_resolve_inlines(ftrace->machine, caller_sym,
@@ -675,6 +950,21 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
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
@@ -697,9 +987,6 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	}
 
 	/* Close stale callee frames and inactive inlined frames above caller */
-	if (caller_idx >= 0)
-		cs->overflow_depth = 0;
-
 	while (caller_idx >= 0 && cs->depth > caller_idx + 1 + common) {
 		struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
 
@@ -708,13 +995,17 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
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
 
+	if (is_target_root)
+		cs->target_root_depth = cs->depth;
+
 	/* Open new inlined frames */
 	for (i = common; i < num_inlines; i++) {
 		int entry_indent = leading_spaces + cs->inlined_depth * 2;
@@ -725,7 +1016,8 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 				free((void *)inlined_names[j]);
 			return -ENOMEM;
 		}
-		if (cs->depth >= FTRACE_MAX_STACK)
+		if (cs->depth >= cs->max_stack &&
+		    ftrace_task_state__grow_stack(cs) < 0)
 			break;
 
 		fprintf(out, "%s%*s%s() { /* (inline) */\n",
@@ -772,20 +1064,44 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		char entry_name[128];
 
 		extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
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
+		cs->stack[cs->depth].name = strdup(entry_name);
+		if (!cs->stack[cs->depth].name) {
+			pr_err("Not enough memory\n");
+			for (i = 0; i < num_inlines; i++)
+				free((void *)inlined_names[i]);
+			return -ENOMEM;
+		}
+		cs->stack[cs->depth].inlined = false;
+		cs->stack[cs->depth].indent = leading_spaces + extra_indent;
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
-			cs->depth++;
-		} else {
-			cs->overflow_depth++;
+			free(top->name);
+			cs->depth--;
 		}
+		cs->in_target = false;
+		cs->target_root_depth = 0;
+		cs->orphan_depth = 0;
 	}
 
 	for (i = 0; i < num_inlines; i++)
-- 
2.55.0

