From: Sam Liao <phyomh@gmail.com>
Subject: [PATCH] Add inverted call graph report support to perf tool
Date: Mon, 7 Mar 2011 21:43:27 +0800
Message-ID: <AANLkTi=vxgHe=dqz+xEPcZ9oBexM1jBxFz3sXA2DJEZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59161 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab1CGNn2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Mar 2011 08:43:28 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: acme@redhat.com

Add "-r" option to support inverted butterfly report, in the
inverted report, the call graph start from the callee's ancestor,
like main->func1->func2 style. users can use such view to catch
system's performance bottleneck, find the software's design
problem not just some function's poor performance.

Current pref implementation is not easy to add such inversion, so this
fix just invert the ip and callchain in an ugly style. But I do think
this invert
view help developer to find performance root cause for complex
software.
---
 tools/perf/builtin-report.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c27e31f..ac2ec0e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -33,6 +33,7 @@
 static char		const *input_name = "perf.data";

 static bool		force, use_tui, use_stdio;
+static bool		reverse_call;
 static bool		hide_unresolved;
 static bool		dont_use_callchains;

@@ -155,6 +156,41 @@ static int process_sample_event(event_t *event,
struct sample_data *sample,
 {
 	struct addr_location al;
 	struct perf_event_attr *attr;
+
+	/* reverse call chain data */
+	if (reverse_call && symbol_conf.use_callchain && sample->callchain) {
+		struct ip_callchain *chain;
+		int i, j;
+		u64 tmp_ip;
+		event_t *reverse_event;
+
+		chain = malloc(sizeof(u64) * (sample->callchain->nr + 1));
+		if (!chain) {
+			pr_debug("malloc failed\n");
+			return -1;
+		}
+		reverse_event = malloc(sizeof(event_t));
+		if (!reverse_event) {
+			pr_debug("malloc failed\n");
+			return -1;
+		}
+		memcpy(reverse_event, event, sizeof(event_t));
+
+		chain->nr = sample->callchain->nr;
+		j = sample->callchain->nr;
+		tmp_ip = event->ip.ip;
+		reverse_event->ip.ip = sample->callchain->ips[j-1];
+		chain->ips[j-1] = tmp_ip;
+		for (i = 0, j = sample->callchain->nr - 2; i < j; i++, j--) {
+			chain->ips[i] = sample->callchain->ips[j];
+			chain->ips[j] = sample->callchain->ips[i];
+		}
+
+		sample->callchain = chain;
+		call_chain_reversed = true;
+		event = reverse_event;
+	}

 	if (event__preprocess_sample(event, session, &al, sample, NULL) < 0) {
 		fprintf(stderr, "problem processing %d event, skipping it.\n",
@@ -177,6 +213,11 @@ static int process_sample_event(event_t *event,
struct sample_data *sample,
 		return -1;
 	}

+	if (reverse_call && call_chain_reversed) {
+		free(sample->callchain);
+		free(event);
+	}
+
 	return 0;
 }

@@ -469,6 +510,8 @@ static const struct option options[] = {
 	OPT_CALLBACK_DEFAULT('g', "call-graph", NULL, "output_type,min_percent",
 		     "Display callchains using output_type (graph, flat, fractal,
or none) and min percent threshold. "
 		     "Default: fractal,0.5", &parse_callchain_opt, callchain_default_opt),
+	OPT_BOOLEAN('r', "reverse-call", &reverse_call,
+			"reverse call chain report (butterfly view)"),
 	OPT_STRING('d', "dsos", &symbol_conf.dso_list_str, "dso[,dso...]",
 		   "only consider symbols in these dsos"),
 	OPT_STRING('C', "comms", &symbol_conf.comm_list_str, "comm[,comm...]",
-- 
1.7.1
