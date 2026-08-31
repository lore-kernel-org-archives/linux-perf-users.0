Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE65521203;
	Mon, 31 Aug 2026 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188838; cv=none; b=h6koOpYj+GV53ZjmOhi+fpP5AFFYfeTPB4eJSymFP3A/D3yCmRWdb/4VjnFYcwopPyE+I7mWHILg2r9vr2GrYXm07LqO62dHlKTLegoXc1hNtjw2QbxWZO+UqxQPxEj9aqe24PoED8WO8wP9h3HWRCWpKweNho9FhY2D5qkHO7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188838; c=relaxed/simple;
	bh=4sLw1UlxnQK6TFK1qI/BKqiOsQ2L7m/MoSzIdqNITg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOPWfZq76HAnAVOT3NBhYC6gnE7udemHEbdNbJ8PF6YBhrvsOuiO+wIT7g+vXKbBdaevvVXSmlDt4u2Mj5xg4E9LJsbfxYKEQtxc64bWt9AdqOnhA2Djr4qqmJwo3cAFSKpLd5HuWLht4gwQWkd3R6lrSxDGqrhJteZEKpX5ncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 2BD2563F9A;
	Mon, 31 Aug 2026 17:07:11 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 321E21622B9; Mon, 31 Aug 2026 08:07:03 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	tglx@kernel.org,
	x86@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	Andi Kleen <ak@kernel.org>
Subject: [RFC v1 17/19] ptwrite uprobes / perf tools probe: Add support of ptwrite probes
Date: Mon, 31 Aug 2026 08:04:53 -0700
Message-ID: <20260831150651.1134594-18-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831150651.1134594-1-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a --ptwrite option to perf probe to enable ptwrite probes. It is mainly
identical to the normal uprobes support, but knows about the new ptw:
probe syntax.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 tools/perf/Documentation/perf-probe.txt |  6 ++++++
 tools/perf/builtin-probe.c              | 17 ++++++++++++++++-
 tools/perf/util/probe-event.c           | 18 +++++++++++++-----
 tools/perf/util/probe-event.h           |  2 ++
 4 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Documentation/perf-probe.txt
index 2e5790325430..859f7ec42422 100644
--- a/tools/perf/Documentation/perf-probe.txt
+++ b/tools/perf/Documentation/perf-probe.txt
@@ -136,6 +136,12 @@ OPTIONS
 --max-probes=NUM::
 	Set the maximum number of probe points for an event. Default is 128.
 
+--ptwrite::
+	Create a ptwrite uprobe (with -x). The probe writes its values
+	into the Intel PT trace stream instead of entering the kernel,
+	which is faster. Requires an Intel PT/PTWRITE CPU and a kernel
+	with ptwrite uprobe support.
+
 --target-ns=PID:
 	Obtain mount namespace information from the target pid.  This is
 	used when creating a uprobe for a process that resides in a
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index a67b565278ae..f6c90bf9cd0d 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -40,6 +40,7 @@ static struct {
 	int command;	/* Command short_name */
 	bool list_events;
 	bool uprobes;
+	bool ptwrite;
 	bool target_used;
 	int nevents;
 	struct perf_probe_event events[MAX_PROBES];
@@ -62,6 +63,7 @@ static int parse_probe_event(const char *str)
 	}
 
 	pev->uprobes = params->uprobes;
+	pev->ptwrite = params->ptwrite;
 	if (params->target) {
 		pev->target = strdup(params->target);
 		if (!pev->target)
@@ -73,9 +75,15 @@ static int parse_probe_event(const char *str)
 
 	/* Parse a perf-probe command into event */
 	ret = parse_perf_probe_command(str, pev);
+	if (ret < 0)
+		return ret;
+	if (pev->ptwrite && pev->point.retprobe) {
+		pr_err("Error: ptwrite probes are entry-only (no %%return).\n");
+		return -EINVAL;
+	}
 	pr_debug("%d arguments\n", pev->nargs);
 
-	return ret;
+	return 0;
 }
 
 static int params_add_filter(const char *str)
@@ -532,6 +540,8 @@ __cmd_probe(int argc, const char **argv)
 		    "be more verbose (show parsed arguments, etc)"),
 	OPT_BOOLEAN('q', "quiet", &quiet,
 		    "be quiet (do not show any warnings or messages)"),
+	OPT_BOOLEAN(0, "ptwrite", &params->ptwrite,
+		    "create trap-free ptwrite uprobes (requires -x)"),
 	OPT_CALLBACK_DEFAULT('l', "list", NULL, "[GROUP:]EVENT",
 			     "list up probe events",
 			     opt_set_filter_with_command, DEFAULT_LIST_FILTER),
@@ -733,6 +743,11 @@ __cmd_probe(int argc, const char **argv)
 			parse_options_usage(NULL, options, "x", true);
 			return -EINVAL;
 		}
+		if (params->ptwrite && !params->uprobes) {
+			pr_err("  Error: --ptwrite requires -x.\n");
+			parse_options_usage(NULL, options, "x", true);
+			return -EINVAL;
+		}
 
 		ret = perf_add_probe_events(params->events, params->nevents);
 		if (ret < 0) {
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 11ae4a09412c..0417fa5ccfbe 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1930,6 +1930,7 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev)
 		ret = -EINVAL;
 		goto out;
 	}
+	tev->ptwrite = !strcmp(fmt1_str, "ptw");
 	pr = fmt1_str[0];
 	tev->group = strdup(fmt2_str);
 	tev->event = strdup(fmt3_str);
@@ -1937,7 +1938,8 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev)
 		ret = -ENOMEM;
 		goto out;
 	}
-	pr_debug("Group:%s Event:%s probe:%c\n", tev->group, tev->event, pr);
+	pr_debug("Group:%s Event:%s probe:%c%s\n", tev->group, tev->event, pr,
+		 tev->ptwrite ? " (ptwrite)" : "");
 
 	tp->retprobe = (pr == 'r');
 
@@ -2260,9 +2262,11 @@ char *synthesize_probe_trace_command(struct probe_trace_event *tev)
 	if (strbuf_init(&buf, 32) < 0)
 		return NULL;
 
-	if (strbuf_addf(&buf, "%c:%s/%s ", tp->retprobe ? 'r' : 'p',
-			tev->group, tev->event) < 0)
-		goto error;
+	if (tev->ptwrite)
+		err = strbuf_addf(&buf, "ptw:%s/%s ", tev->group, tev->event);
+	else
+		err = strbuf_addf(&buf, "%c:%s/%s ", tp->retprobe ? 'r' : 'p',
+				  tev->group, tev->event);
 
 	if (tev->uprobes)
 		err = synthesize_uprobe_trace_def(tp, &buf);
@@ -2274,7 +2278,6 @@ char *synthesize_probe_trace_command(struct probe_trace_event *tev)
 
 	if (err >= 0)
 		ret = strbuf_detach(&buf, NULL);
-error:
 	strbuf_release(&buf);
 	return ret;
 }
@@ -2996,6 +2999,7 @@ static int __add_probe_trace_events(struct perf_probe_event *pev,
 	ret = 0;
 	for (i = 0; i < ntevs; i++) {
 		tev = &tevs[i];
+		tev->ptwrite = pev->ptwrite;
 		up = tev->uprobes ? 1 : 0;
 		if (fd[up] == -1) {	/* Open the kprobe/uprobe_events */
 			fd[up] = __open_probe_file_and_namelist(up,
@@ -3610,6 +3614,8 @@ int convert_perf_probe_events(struct perf_probe_event *pevs, int npevs)
 
 	/* Loop 1: convert all events */
 	for (i = 0; i < npevs; i++) {
+		int j;
+
 		/* Init kprobe blacklist if needed */
 		if (!pevs[i].uprobes)
 			kprobe_blacklist__init();
@@ -3618,6 +3624,8 @@ int convert_perf_probe_events(struct perf_probe_event *pevs, int npevs)
 		if (ret < 0)
 			return ret;
 		pevs[i].ntevs = ret;
+		for (j = 0; j < pevs[i].ntevs; j++)
+			pevs[i].tevs[j].ptwrite = pevs[i].ptwrite;
 	}
 	/* This just release blacklist only if allocated */
 	kprobe_blacklist__release();
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 71905ede0207..5fbed6c6a78a 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -60,6 +60,7 @@ struct probe_trace_event {
 	int				nargs;	/* Number of args */
 	int				lang;	/* Dwarf language code */
 	bool				uprobes;	/* uprobes only */
+	bool				ptwrite;	/* ptwrite uprobe (trap-free) */
 	struct probe_trace_arg		*args;	/* Arguments */
 };
 
@@ -99,6 +100,7 @@ struct perf_probe_event {
 	int			nargs;	/* Number of arguments */
 	bool			sdt;	/* SDT/cached event flag */
 	bool			uprobes;	/* Uprobe event flag */
+	bool			ptwrite;	/* ptwrite uprobe (trap-free) */
 	char			*target;	/* Target binary */
 	struct perf_probe_arg	*args;	/* Arguments */
 	struct probe_trace_event *tevs;
-- 
2.54.0

