Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B21C47426
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 16:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B0A61406
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 16:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhFDQae (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 12:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhFDQae (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 12:30:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B59B5613FF;
        Fri,  4 Jun 2021 16:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622824128;
        bh=fnZ+NYTlprc2KY9TUqg3zrv52FF4xQoS2VuwFUzeVs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBk0dP+Zsf4KbEqrDsy3MUlgXjNDWgd9vKuXGeOQ0W7xKchLgYvkcbyDDxIgbwyKZ
         a8F12YboMrb8tsQs5PoVMJpR+IQqxSt2Kz64+0bm5zwmgtVX5OtSCzJOw0QBZEiCym
         4cJfLLJOK2/lk+MNtLI0uOluK06BKuVrgXFChw6hwPJ6Q+eGmCVMyDyfzcirRK3+7w
         /2AetKrLncfJdHbnjxEdnjNTHc5zAxFagCyP5h53cXsaNgO2aOvfN+J6geoBeOELsl
         JkjZ/GWSGV1ZogVhyYPlqAY4KQdMUsAnHNRl9AP9+oy47ekapz0ViJIMGKQ1roikq5
         noChVe7RjYB9g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf/probe: Add --bootconfig to output definition in bootconfig format
Date:   Sat,  5 Jun 2021 01:28:43 +0900
Message-Id: <162282412351.452340.14871995440005640114.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162282409255.452340.4645118932261585719.stgit@devnote2>
References: <162282409255.452340.4645118932261585719.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Now the boot-time tracing supports the kprobes events and that
must be written in bootconfig file as following format.

ftrace.event.kprobes.<EVENT_NAME>.probes = <PROBE-DEF>

The perf probe already supports --definition (-D) action to
show the probe definitions, but the format is for the tracefs.

[p|r][:EVENT_NAME] <PROBE-DEF>

This adds --bootconfig option for -D action so that it output
the probe definitions in bootconfig fromat. E.g.

 $ perf probe --bootconfig -D "path_lookupat:7 err:s32 s:string"
 ftrace.event.kprobes.path_lookupat_L7.probe = 'path_lookupat.isra.0+309 err_s32=%ax:s32 s_string=+0(%r13):string'

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/builtin-probe.c    |   12 ++++++-
 tools/perf/util/probe-event.c |   72 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/probe-event.h |    2 +
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 6b1507566770..2bfd41df621c 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -347,7 +347,10 @@ static int perf_add_probe_events(struct perf_probe_event *pevs, int npevs)
 		goto out_cleanup;
 
 	if (params.command == 'D') {	/* it shows definition */
-		ret = show_probe_trace_events(pevs, npevs);
+		if (probe_conf.bootconfig)
+			ret = show_bootconfig_events(pevs, npevs);
+		else
+			ret = show_probe_trace_events(pevs, npevs);
 		goto out_cleanup;
 	}
 
@@ -581,6 +584,8 @@ __cmd_probe(int argc, const char **argv)
 		   "Look for files with symbols relative to this directory"),
 	OPT_CALLBACK(0, "target-ns", NULL, "pid",
 		     "target pid for namespace contexts", opt_set_target_ns),
+	OPT_BOOLEAN(0, "bootconfig", &probe_conf.bootconfig,
+		    "Output probe definition with bootconfig format"),
 	OPT_END()
 	};
 	int ret;
@@ -692,6 +697,11 @@ __cmd_probe(int argc, const char **argv)
 		}
 		break;
 	case 'D':
+		if (probe_conf.bootconfig && params.uprobes) {
+			pr_err("  Error: --bootconfig doesn't support uprobes.\n");
+			return -EINVAL;
+		}
+		__fallthrough;
 	case 'a':
 
 		/* Ensure the last given target is used */
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 505c0702dbe2..f1348fa3dd1b 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -3564,6 +3564,78 @@ int show_probe_trace_events(struct perf_probe_event *pevs, int npevs)
 	return ret;
 }
 
+static int show_bootconfig_event(struct probe_trace_event *tev)
+{
+	struct probe_trace_point *tp = &tev->point;
+	struct strbuf buf;
+	char *ret = NULL;
+	int err;
+
+	if (strbuf_init(&buf, 32) < 0)
+		return -ENOMEM;
+
+	err = synthesize_kprobe_trace_def(tp, &buf);
+	if (err >= 0)
+		err = synthesize_probe_trace_args(tev, &buf);
+	if (err >= 0)
+		ret = strbuf_detach(&buf, NULL);
+	strbuf_release(&buf);
+
+	if (ret) {
+		printf("'%s'", ret);
+		free(ret);
+	}
+
+	return err;
+}
+
+int show_bootconfig_events(struct perf_probe_event *pevs, int npevs)
+{
+	struct strlist *namelist = strlist__new(NULL, NULL);
+	struct probe_trace_event *tev;
+	struct perf_probe_event *pev;
+	char *cur_name = NULL;
+	int i, j, ret = 0;
+
+	if (!namelist)
+		return -ENOMEM;
+
+	for (j = 0; j < npevs && !ret; j++) {
+		pev = &pevs[j];
+		if (pev->group && strcmp(pev->group, "probe"))
+			pr_warning("WARN: Group name %s is ignored\n", pev->group);
+		if (pev->uprobes) {
+			pr_warning("ERROR: Bootconfig doesn't support uprobes\n");
+			ret = -EINVAL;
+			break;
+		}
+		for (i = 0; i < pev->ntevs && !ret; i++) {
+			tev = &pev->tevs[i];
+			/* Skip if the symbol is out of .text or blacklisted */
+			if (!tev->point.symbol && !pev->uprobes)
+				continue;
+
+			/* Set new name for tev (and update namelist) */
+			ret = probe_trace_event__set_name(tev, pev,
+							  namelist, true);
+			if (ret)
+				break;
+
+			if (!cur_name || strcmp(cur_name, tev->event)) {
+				printf("%sftrace.event.kprobes.%s.probe = ",
+					cur_name ? "\n" : "", tev->event);
+				cur_name = tev->event;
+			} else
+				printf(", ");
+			ret = show_bootconfig_event(tev);
+		}
+	}
+	printf("\n");
+	strlist__delete(namelist);
+
+	return ret;
+}
+
 int apply_perf_probe_events(struct perf_probe_event *pevs, int npevs)
 {
 	int i, ret = 0;
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 4f0eb3a20c36..65769d7949a3 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -15,6 +15,7 @@ struct probe_conf {
 	bool	force_add;
 	bool	no_inlines;
 	bool	cache;
+	bool	bootconfig;
 	int	max_probes;
 	unsigned long	magic_num;
 };
@@ -163,6 +164,7 @@ int add_perf_probe_events(struct perf_probe_event *pevs, int npevs);
 int convert_perf_probe_events(struct perf_probe_event *pevs, int npevs);
 int apply_perf_probe_events(struct perf_probe_event *pevs, int npevs);
 int show_probe_trace_events(struct perf_probe_event *pevs, int npevs);
+int show_bootconfig_events(struct perf_probe_event *pevs, int npevs);
 void cleanup_perf_probe_events(struct perf_probe_event *pevs, int npevs);
 
 struct strfilter;

