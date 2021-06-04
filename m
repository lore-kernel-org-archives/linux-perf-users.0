Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE0DC47425
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 16:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2463361406
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 16:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhFDQaY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 12:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230201AbhFDQaY (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 12:30:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 098F5613BF;
        Fri,  4 Jun 2021 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622824118;
        bh=xldhAYvpNp7T8FsAXTGCg2xSMIM8K9z2JZUDsEUwjbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e50JvrtLsBBAfKHT60mJyI2pm8y7bz/fTaGwHewrxpI9UK0we/Sba5kPaUsyG6Vfg
         urbvZZPhy0LafZ6kIEhietVmY4qVgOONLoJ9aw3CSHb8rDKBmF66/6ueCSUvCnp7lD
         YiWy8mxyRqscii/sFFbPwek6ai+N6VbGK9Ud0qFXs/2T3JF+0Bsttrek6t6sxT5+W6
         EAsrnIoFPZcdmWmcxese+oCSZt9BY7BG7Wstir+NQlriucF9w3E/evt9ouVX9lpBhy
         VAWffM/OZ6Gvb7ZkQnb/+2RWIswhniNFE9nVuzfQCKylGnT/r5V6RqbN7VCugQ6Z0Q
         HvGY3Zm4qpvYg==
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
Subject: [PATCH 2/3] perf/probe: Cleanup synthesize_probe_trace_command
Date:   Sat,  5 Jun 2021 01:28:33 +0900
Message-Id: <162282411361.452340.16886399333622147122.stgit@devnote2>
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

Cleanup the synthesize_probe_trace_command() to simplify
code path.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c |   86 +++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a6e121afb651..505c0702dbe2 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2127,19 +2127,55 @@ static int synthesize_probe_trace_arg(struct probe_trace_arg *arg,
 }
 
 static int
-synthesize_uprobe_trace_def(struct probe_trace_event *tev, struct strbuf *buf)
+synthesize_probe_trace_args(struct probe_trace_event *tev, struct strbuf *buf)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < tev->nargs && ret >= 0; i++)
+		ret = synthesize_probe_trace_arg(&tev->args[i], buf);
+
+	return ret;
+}
+
+static int
+synthesize_uprobe_trace_def(struct probe_trace_point *tp, struct strbuf *buf)
 {
-	struct probe_trace_point *tp = &tev->point;
 	int err;
 
+	/* Uprobes must have tp->module */
+	if (!tp->module)
+		return -EINVAL;
+	/*
+	 * If tp->address == 0, then this point must be a
+	 * absolute address uprobe.
+	 * try_to_find_absolute_address() should have made
+	 * tp->symbol to "0x0".
+	 */
+	if (!tp->address && (!tp->symbol || strcmp(tp->symbol, "0x0")))
+		return -EINVAL;
+
+	/* Use the tp->address for uprobes */
 	err = strbuf_addf(buf, "%s:0x%lx", tp->module, tp->address);
 
 	if (err >= 0 && tp->ref_ctr_offset) {
 		if (!uprobe_ref_ctr_is_supported())
-			return -1;
+			return -EINVAL;
 		err = strbuf_addf(buf, "(0x%lx)", tp->ref_ctr_offset);
 	}
-	return err >= 0 ? 0 : -1;
+	return err >= 0 ? 0 : err;
+}
+
+static int
+synthesize_kprobe_trace_def(struct probe_trace_point *tp, struct strbuf *buf)
+{
+	if (!strncmp(tp->symbol, "0x", 2)) {
+		/* Absolute address. See try_to_find_absolute_address() */
+		return strbuf_addf(buf, "%s%s0x%lx", tp->module ?: "",
+				  tp->module ? ":" : "", tp->address);
+	} else {
+		return strbuf_addf(buf, "%s%s%s+%lu", tp->module ?: "",
+				tp->module ? ":" : "", tp->symbol, tp->offset);
+	}
 }
 
 char *synthesize_probe_trace_command(struct probe_trace_event *tev)
@@ -2147,11 +2183,7 @@ char *synthesize_probe_trace_command(struct probe_trace_event *tev)
 	struct probe_trace_point *tp = &tev->point;
 	struct strbuf buf;
 	char *ret = NULL;
-	int i, err;
-
-	/* Uprobes must have tp->module */
-	if (tev->uprobes && !tp->module)
-		return NULL;
+	int err;
 
 	if (strbuf_init(&buf, 32) < 0)
 		return NULL;
@@ -2159,37 +2191,17 @@ char *synthesize_probe_trace_command(struct probe_trace_event *tev)
 	if (strbuf_addf(&buf, "%c:%s/%s ", tp->retprobe ? 'r' : 'p',
 			tev->group, tev->event) < 0)
 		goto error;
-	/*
-	 * If tp->address == 0, then this point must be a
-	 * absolute address uprobe.
-	 * try_to_find_absolute_address() should have made
-	 * tp->symbol to "0x0".
-	 */
-	if (tev->uprobes && !tp->address) {
-		if (!tp->symbol || strcmp(tp->symbol, "0x0"))
-			goto error;
-	}
 
-	/* Use the tp->address for uprobes */
-	if (tev->uprobes) {
-		err = synthesize_uprobe_trace_def(tev, &buf);
-	} else if (!strncmp(tp->symbol, "0x", 2)) {
-		/* Absolute address. See try_to_find_absolute_address() */
-		err = strbuf_addf(&buf, "%s%s0x%lx", tp->module ?: "",
-				  tp->module ? ":" : "", tp->address);
-	} else {
-		err = strbuf_addf(&buf, "%s%s%s+%lu", tp->module ?: "",
-				tp->module ? ":" : "", tp->symbol, tp->offset);
-	}
-
-	if (err)
-		goto error;
+	if (tev->uprobes)
+		err = synthesize_uprobe_trace_def(tp, &buf);
+	else
+		err = synthesize_kprobe_trace_def(tp, &buf);
 
-	for (i = 0; i < tev->nargs; i++)
-		if (synthesize_probe_trace_arg(&tev->args[i], &buf) < 0)
-			goto error;
+	if (err >= 0)
+		err = synthesize_probe_trace_args(tev, &buf);
 
-	ret = strbuf_detach(&buf, NULL);
+	if (err >= 0)
+		ret = strbuf_detach(&buf, NULL);
 error:
 	strbuf_release(&buf);
 	return ret;

