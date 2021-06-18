Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00114C49361
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Jun 2021 16:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC2D613B4
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Jun 2021 16:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhFRQNM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Jun 2021 12:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232384AbhFRQNM (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Jun 2021 12:13:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C0FF61003;
        Fri, 18 Jun 2021 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624032662;
        bh=7mw99MpFiCUa+q2fkany4PWAEckRD04cuygqHBqMmMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtmDGbnDT50/8ZZ/Go232e9d5/IB1odEtIKRiOPKW3UE0Zu3osAbMEDVaue9BLcyi
         e0V2adlCAF5stYXMQISyVk2SUT4DqoHbatYZenuTvJYnIEFdZSTZfT6ekMf6egYXr1
         vhdZFAL5TYysQtPe3lxjmoasRjisVjY67cLpODMZ84wba9jHMHjmJ55SLgWgKWagib
         8i0faTWrUtS5X3viy9hzWY4nB5TSP+3yyWNtKqsDmWwJs+ANldA9x1k1iwyoKKQVYj
         bY/z/ISm6NO762L2wckv3YXxWDqv2Us4mke/jCvt84I9/aW43o+Hkt9ph8N5hiHK+b
         ykt8piBq/c92w==
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
Subject: [PATCH 2/3] perf/probe: Show return probe correctly with --bootconfig
Date:   Sat, 19 Jun 2021 01:11:00 +0900
Message-Id: <162403265988.528888.9996688190141639740.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162403264218.528888.2914545241015551186.stgit@devnote2>
References: <162403264218.528888.2914545241015551186.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since the bootconfig has to use "%return" suffix for the return
probes, perf probe also needs to add that suffix if the user
defines the return probe. E.g.

  $ perf probe -k vmlinux --bootconfig -D vfs_read%return
  ftrace.event.kprobes.vfs_read__return.probe = 'vfs_read+0%return'

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 8e30bf97cf0f..99624e39314b 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2166,15 +2166,17 @@ synthesize_uprobe_trace_def(struct probe_trace_point *tp, struct strbuf *buf)
 }
 
 static int
-synthesize_kprobe_trace_def(struct probe_trace_point *tp, struct strbuf *buf)
+synthesize_kprobe_trace_def(struct probe_trace_point *tp, struct strbuf *buf,
+			    bool show_return)
 {
 	if (!strncmp(tp->symbol, "0x", 2)) {
 		/* Absolute address. See try_to_find_absolute_address() */
 		return strbuf_addf(buf, "%s%s0x%lx", tp->module ?: "",
 				  tp->module ? ":" : "", tp->address);
 	} else {
-		return strbuf_addf(buf, "%s%s%s+%lu", tp->module ?: "",
-				tp->module ? ":" : "", tp->symbol, tp->offset);
+		return strbuf_addf(buf, "%s%s%s+%lu%s", tp->module ?: "",
+				tp->module ? ":" : "", tp->symbol, tp->offset,
+				show_return && tp->retprobe ? "%return" : "");
 	}
 }
 
@@ -2195,7 +2197,7 @@ char *synthesize_probe_trace_command(struct probe_trace_event *tev)
 	if (tev->uprobes)
 		err = synthesize_uprobe_trace_def(tp, &buf);
 	else
-		err = synthesize_kprobe_trace_def(tp, &buf);
+		err = synthesize_kprobe_trace_def(tp, &buf, false);
 
 	if (err >= 0)
 		err = synthesize_probe_trace_args(tev, &buf);
@@ -3574,7 +3576,7 @@ static int show_bootconfig_event(struct probe_trace_event *tev)
 	if (strbuf_init(&buf, 32) < 0)
 		return -ENOMEM;
 
-	err = synthesize_kprobe_trace_def(tp, &buf);
+	err = synthesize_kprobe_trace_def(tp, &buf, true);
 	if (err >= 0)
 		err = synthesize_probe_trace_args(tev, &buf);
 	if (err >= 0)

