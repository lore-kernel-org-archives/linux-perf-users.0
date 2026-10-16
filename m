Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021088.outbound.protection.outlook.com [52.101.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D80A395240;
	Fri, 16 Oct 2026 04:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123432; cv=fail; b=ZOzqyFWh2lqRGxMrTRJTzb/62zr6HZQhaNkCSU7kkMY3MxXhn+S6io1wLnVmIXffVu5rLhhgJm7MeiLVE8LPch3DfJ8peRDhO047IIfdyEsp5hqyvLCDnkd/PMggQDqMAtdXHL08LN8A+pgXgk77ahp69yZZIm3q3M4K+V2prWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123432; c=relaxed/simple;
	bh=okCy9le73eYl2MEzwzLJOq4f1xtpMZS8mAoROyhHh2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KKmVEid2cBnax6tZw3Qt4nT9BEtB4zrfDDT157uewdErt6muA6CjWCK77zQYKnbBFLoEua2aPNTf0O/C3miPN/xEmjiJ5DZXgTnfroixC9qKpmZKF0EgyIhNilY6Ehi+4D2nvAuHXzavNVZq5ncE0vkh1Tpae3zZ4fnsEhnuLr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNn9asQuUghnqPuDIz1mIxykXqQuirJqM+gMya/vHlg7IUrJ4pifDACmlBNmRFkXmvirtTbKKiVbXicQvhtVldgBvw1m8LzduiGXllly9ROHhLcc8RQTvqgdom+lLoBR38x8BSV2s+H60tpOjmdsMpKuen5BwpMjT0QJ+z0GUGSXXZtw84+jolUBGiB2zSi0vMXq6uil+UARPOfCRDZt8iBoHVy2Fijav3hbExj5GDYs5p6X11IUIFqJBrEW1EfR3y9N57/6rS4yohWlTuJg6DRe2FMdm0H9oprJe0RL0aO0d4ZZAymSzgiIMUaWtcrD1jQwwq5uYIkqnGusBYHoug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=k2XurEunJtBO56b/mfkvL6+WEDDC5hfXJZev5z6bdPM=;
 b=k9QDQfiGbp9TRnZ0fPPN6elPgsYtqnky3PSgZtXGD2tTCrfs+Nas2VOg0tRPa2p2aNWxfmhi/gkxw84Mq6T5jxoa8lcHkAI5sS9LI8A8yWyLyNJKesVM+XqSIqpv9yoQZM2i8KLe+r0idfe6gf4dktYqVDPL4OjI3/gtv8oV65IusQmikKLOeyVlmnTbpKQFt0nASKskBlrCuynEOHs5QMluCgexrXqsoxmVkaRaEPb2pK+m/YiqlUsUUPJrr33zW/5TOeXHJuR0p+uOpVKtItfIkFJuDt9XinfiWF1CEDjid9f+mJ1yaVA+78jR/DJQ9SMehJkuGmL1bjptakj3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8944.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 04:03:44 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 04:03:44 +0000
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
Subject: [PATCH perf-tools-next v6 5/5] perf ftrace: Filter extraneous functions in function graph tracer
Date: Fri, 16 Oct 2026 00:03:10 -0400
Message-ID: <20261016040310.482876-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016040310.482876-1-atomlin@atomlin.com>
References: <20261016040310.482876-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:510:5::23) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: b04a3213-854e-483f-05af-08df2b3a78d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	al7HjDSbqI8dIeVkvpAtea+HwnImEmrZUUsQZp6VUrGNyAYrWmqVRSpApgUPa5I2UpCU2LtBJuuO5RC5kEXpGH97k6JZ3R/uzRxu8SK18/0o7UtonhLmn7CbSx3ZI2d9gX8FrU8aWWoszPuioshWETYFZEylTg7jrPVyELwWmoNS/v5I7vYYil7B6w3sbC1/83y5U6fOsJ7qI7UxarGJqOTxHwjjbNI9mX9b1RzoX5OBarJq9vNbJ4kvreGCVqqb8cEKRQDaX3DgeVyAd9Wsbv5IJRrejJn928GuRFDN+tZNIbIlWxfvaLshA9CkrIWNW6lQn0zUKz9nM/Es3vdP6exvKNIuu6799Pq0lospUh43BikS1GQ4F4KLCP0tLQCAAX8tGXSeOh3AZQLN7Ws/A1U8okorinUR6XB6/MDPBO8jr5eybxnaDElKZvlVNMpwB/ZNCdFCOJUVklmnMvP06CtUiwz58hTj7De2a36lqugKWeTt71Nc33koWUCPZqueT1l+48lpXMfBAUiptNa5gvVFAvjUqGKbzjiEWTgaEyrhvVkx/kibFyQLyJRL98N9mefX/4oO8l37HX4llAWs+voLtjvA4A8vx15haIzSmJ4hF4tQAqd0q+faIISBmcFTUS1K0TpHLynbjAfVTlC4takaWbQScqcKaaDj8E03i3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n4RePRiMZIIhLWGwURgjmbUqBF6S0xJnQju0xMKLYWSt0XOEQ33PGUwID3sQ?=
 =?us-ascii?Q?KEdutQ/zICbwSd1tC0Nfgt0w3Ei0AuUYKRHbxn0N8cbRXzmaAiRRMjAW7Nxt?=
 =?us-ascii?Q?nx91tf4v5I0eR76aa+yFvxmJrOVoqd2m4tf4yiUdrZY87w6MHuoxPKYWPoek?=
 =?us-ascii?Q?k0YH5/I3oYL6W6pDe2h1zHa5DeG9aYoGGhZaplfgpnCNSo5aLqAiDH7pHiyr?=
 =?us-ascii?Q?Z/gpaaqKnmyF90ZbKE/1Uff9r1tpnFbUGtQ+2oNp9cVtj9e+/0TL+OHS0Hf/?=
 =?us-ascii?Q?KfQmP+uqf2lKxH0ngf1eH9y1kPIy0dGPxzUVJtHea1Zsn6lLWZoednHO5cK+?=
 =?us-ascii?Q?e/UVFz4zng7fQK3CQE/B1iEmkgkJ0hP7EaUi7fWJVHtlLrCs+RHg+9E3PphD?=
 =?us-ascii?Q?A3ccR8mJyXYdP4zKQLGLYFRsij7Q3W8iH7S25zYSJF0ZDX8xT1kEeNEmy7QP?=
 =?us-ascii?Q?bXLC9iUI4ZxpssAu+xyrJk3X1fK5BTmfyTcNdGMKKQzo+ZUtJTpoX8p62Gjt?=
 =?us-ascii?Q?OGzZbrY+wdnxF7Zn/1xCN4RLUv3a0HXDAP3LNVdbNm/TraakxHJzcdiTg4rJ?=
 =?us-ascii?Q?fmtsqGoeboLDnheG7J5/4QF0Hf3P3qBmdvQs3+59gx6eiPU/4ONUBkNGX74g?=
 =?us-ascii?Q?qi01w+zlULuEg50/lpYIraH3Wf53NP/jojOB5HsXj5FhAPFP2Efuj1Q/Tgn7?=
 =?us-ascii?Q?ivGfdv8Pnskg+W42KW92c5UDniAh24K1YhF9yw1sm0xv9MZ9wUG2cTFh9skf?=
 =?us-ascii?Q?cnfSSfRiocF7WN2lpmJ1ql2YRmsYmI+8R7uxWKmY2iYWBkUNj2IddEw/lzeD?=
 =?us-ascii?Q?n0v5kmgpfXTPU37j0mY1KJRkEWofcG6PZ1QQF5zkfSOE6kImvnokrsA/PjmP?=
 =?us-ascii?Q?2/NnZeWSVZhpWSe+GNbAAJpTLcgtbYEUnbB+zrBRGzyI8xD3FEw8dSTDKF04?=
 =?us-ascii?Q?QH4HN+xIQFjvjAIdFg5KyPd+mgu+DJzwFFPRA1nta8Y94fxeDrhK7E+yCP2V?=
 =?us-ascii?Q?6VbKp7yZ2SzNf28W9zuiRYioHsHp6bGNCl1FxhXPlv9a3/Ci3HoLKr1yrBR8?=
 =?us-ascii?Q?fwWaDfKR71Afno0O23D7G0UPLkxt9efaZXbQJd6FPhhhCgh4LN7Ak8ocyue/?=
 =?us-ascii?Q?G8a5YJO0zV86ziLcKpfMZRVxBacXcl70ZwFW6QlutoPC3frXX1hKpB2NkRVB?=
 =?us-ascii?Q?JHrYp2A/n48cFBXJUT3WhzeOeZSEE08nefNzDGDFs1UI72D97Im0ocssIzeR?=
 =?us-ascii?Q?i31jrmzTF9lpkAH+bFXkrCte7q9Kx9A+MyCQkaVLAel4FXeyutN738GLEVhv?=
 =?us-ascii?Q?MzGGjCSFtTZzPayr6WKizQpGJfZEr1UP3bjNWvwXnY4oyK4C28Z0kVCfi9iW?=
 =?us-ascii?Q?0m++BU/QPwdvL1uqtWCqW0JJkLrp2eD02XhGSjs1lA9L21PsO+lhTakMcTwh?=
 =?us-ascii?Q?TgSU6tSCP3j/VKftqvhCApj3QFjVnnnBS6LWR7I1xBirAOoN1Ss01acvRLbJ?=
 =?us-ascii?Q?tHf162tg5HN65Bztakf5zXE6d6u8A7hkPsprHKXhidaYYwqU50OPNRYATjww?=
 =?us-ascii?Q?atZqlJZfP8Ibue8S38+hgRZfOvB/+3KoRVncCP3hIi9br/HICelShZHYkOlw?=
 =?us-ascii?Q?2KqxS6VxmGL9FLGoijTYcJKQR4dl3m08qWS5Dtuwqwq7qIl35FQM9hikzMzv?=
 =?us-ascii?Q?ROQPlLdDSmvRMJ6jMtTSaiFL8Q5hzmYuQGrPUjl5MfN+vagqGaYeFhAzWPDB?=
 =?us-ascii?Q?SzR0FDenog=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04a3213-854e-483f-05af-08df2b3a78d1
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 04:03:44.7682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeKQVYb+7Jr05IihnvKZCi0ooOtpeAXZ5c9bo5zO2LI53VQME4P+Laj1+t5lN5RNujzECJmueWCuXbwWKnVsAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8944

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
        tools/perf/util/ftrace.c. Any entry not matching the requested
        -G targets is suppressed along with its nested children until
        its scope exits. When a target function is matched (at root or
        nested depths), record its root depth; for leaf target calls,
        immediately reset the filter state upon completion to ensure
        subsequent sibling functions remain suppressed.

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
 tools/perf/tests/ftrace.c | 769 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/ftrace.c  | 345 +++++++++++++++--
 2 files changed, 1091 insertions(+), 23 deletions(-)

diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
index 6a3702e1992a..83bf326fb65b 100644
--- a/tools/perf/tests/ftrace.c
+++ b/tools/perf/tests/ftrace.c
@@ -488,6 +488,771 @@ static int test_column_layouts(void)
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
+	/* 6. Test targeted leaf call with synthesized DWARF inlines closing and resetting filter */
+	if (access("vmlinux", R_OK) == 0) {
+		symbol_conf.vmlinux_name = "vmlinux";
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
@@ -508,6 +1273,10 @@ static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __ma
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
index 6cdb87b445ea..8a5d2bdf0720 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -20,6 +20,7 @@
 #include "srcline.h"
 #include "symbol.h"
 #include "util/ftrace.h"
+#include "util/string2.h"
 
 #define FTRACE_MAX_CPUS 4096
 #define FTRACE_MAX_STACK 256
@@ -36,6 +37,9 @@ struct ftrace_cpu_state {
 	int depth;
 	int inlined_depth;
 	int overflow_depth;
+	bool in_target;
+	int target_root_depth;
+	int orphan_depth;
 };
 
 static struct ftrace_cpu_state *ftrace_cpu_states[FTRACE_MAX_CPUS];
@@ -415,6 +419,64 @@ static int print_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
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
@@ -451,8 +513,10 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	bool has_open_brace;
 	bool has_semicolon;
 	bool has_retaddr = false;
+	bool has_filter = ftrace_has_graph_funcs(ftrace);
+	bool is_target_root = false;
 
-	if (!ftrace->use_inline)
+	if (!has_filter && !ftrace->use_inline)
 		return print_line(ftrace, line, out);
 
 	pipe_char = find_func_column(ftrace, line, &cpu);
@@ -477,30 +541,57 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	if (is_exit) {
 		char exit_name[128];
 
-		if (cs->overflow_depth > 0) {
-			cs->overflow_depth--;
-			extra_indent = cs->inlined_depth * 2;
-			fprintf(out, "%.*s%*s%s\n",
-				(int)(pipe_char - line + 1), line,
-				leading_spaces + extra_indent, "", func_start);
-			return 0;
-		}
-
 		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
 
-		/* Find matching frame on stack */
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
 
+		if (match_idx >= 0) {
+			/* Named exit matches a tracked frame; clear stale orphan depth */
+			cs->orphan_depth = 0;
+		} else if (cs->orphan_depth > 0) {
+			cs->orphan_depth--;
+			return 0;
+		}
+
+		if (cs->overflow_depth > 0) {
+			cs->overflow_depth--;
+			if (!has_filter || cs->in_target) {
+				if (!ftrace->use_inline) {
+					print_line(ftrace, line, out);
+				} else {
+					extra_indent = cs->inlined_depth * 2;
+					fprintf(out, "%.*s%*s%s\n",
+						(int)(pipe_char - line + 1), line,
+						leading_spaces + extra_indent, "", func_start);
+				}
+			}
+			return 0;
+		}
+
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
+		}
+
 		if (match_idx >= 0) {
 			/* Close all inlined and orphaned frames above match_idx */
 			while (cs->depth > 0 && cs->depth - 1 > match_idx) {
@@ -511,8 +602,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
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
@@ -530,9 +622,36 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
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
 
@@ -540,6 +659,145 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
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
+				if (caller_idx >= cs->target_root_depth ||
+				    (caller_idx < 0 && cs->overflow_depth > 0))
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
+				if (cs->depth < FTRACE_MAX_STACK) {
+					cs->stack[cs->depth].name = strdup(entry_name);
+					if (!cs->stack[cs->depth].name) {
+						pr_err("Not enough memory\n");
+						return -ENOMEM;
+					}
+					cs->stack[cs->depth].inlined = false;
+					cs->stack[cs->depth].indent = leading_spaces;
+					cs->depth++;
+				} else {
+					cs->overflow_depth++;
+				}
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
+				if (caller_idx >= 0 ? caller_idx < cs->target_root_depth
+						    : cs->overflow_depth == 0) {
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
+			} else {
+				cs->overflow_depth++;
+			}
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
@@ -566,6 +824,22 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		}
 	}
 
+	/*
+	 * When inside a target graph filter, child functions must descend
+	 * from an active frame on the target stack. Suppress detached
+	 * calls originating outside the target hierarchy.
+	 */
+	if (has_filter && cs->in_target && cs->depth > cs->target_root_depth) {
+		if (has_retaddr && (caller_idx >= 0 ? caller_idx < cs->target_root_depth
+						    : cs->overflow_depth == 0)) {
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
@@ -596,13 +870,17 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
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
@@ -676,6 +954,27 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		}
 	}
 
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
+			}
+			free(top->name);
+			cs->depth--;
+		}
+		cs->in_target = false;
+		cs->target_root_depth = 0;
+		cs->orphan_depth = 0;
+	}
+
 	for (i = 0; i < num_inlines; i++)
 		free((void *)inlined_names[i]);
 	return 0;
-- 
2.55.0

