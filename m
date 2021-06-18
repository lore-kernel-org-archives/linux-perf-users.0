Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B36C48BDF
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Jun 2021 16:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915F2613D5
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Jun 2021 16:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhFRQNU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Jun 2021 12:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232384AbhFRQNU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Jun 2021 12:13:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82700613B4;
        Fri, 18 Jun 2021 16:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624032670;
        bh=SRaSnqPXQjf7vNqJIqe1zkgy8jV9DuKTiN2SxzsWOEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bl2z4FJbZldGBcC6QVF2uGoiGlCf6KVT+IKQql12L5kyCtZkzizh+L4ryKTqE64Gx
         dOGp9RH3fE/KTkcm8GBZu+UBNXYi7sW1Sy+HPX31imSRzvApz3pl0/vuOetqGNdn9z
         EL194XgI1jdXQcpQqwUyjuhi6CSvFfzx8Psy0JAAzZtS6RA+2TSdUJb7eZ8RMzsEfW
         tnwjQmOH2/MZzwUDdpRZz1HCTioLHu/IoNGHd0VUs/r+BQDILd/8npWnTqj716TWPY
         Qc+vTbGwLDIBmKHpyFbyvZ9NXoOpbjYrwVFf2kpt+7Y16It0Q0b36JKbzT+n5g57IW
         6L7D/UyxNG/cQ==
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
Subject: [PATCH 3/3] perf/probe: docs: Add --bootconfig option to perf-probe manual
Date:   Sat, 19 Jun 2021 01:11:08 +0900
Message-Id: <162403266812.528888.12101980553259365416.stgit@devnote2>
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

Add --bootconfig option and example to the perf-probe manual.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/Documentation/perf-probe.txt |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Documentation/perf-probe.txt
index ed3ecfa422e1..d0908170c3d2 100644
--- a/tools/perf/Documentation/perf-probe.txt
+++ b/tools/perf/Documentation/perf-probe.txt
@@ -103,7 +103,14 @@ OPTIONS
 -D::
 --definition=::
 	Show trace-event definition converted from given probe-event instead
-	of write it into tracing/[k,u]probe_events.
+	of write it into tracing/[k,u]probe_events. This accepts --bootconfig
+	option.
+
+--bootconfig::
+	Show the trace-event definition in Extra Boot Configuration (bootconfig)
+	syntax. This helps users to write the probe event definitions for the
+	boot-time tracing.
+	Note that this must be used with --definition(-D) option.
 
 --filter=FILTER::
 	(Only for --vars and --funcs) Set filter. FILTER is a combination of glob
@@ -294,6 +301,12 @@ Add a probe in a source file using special characters by backslash escape
 
  ./perf probe -x /opt/test/a.out 'foo\+bar.c:4'
 
+Define a kprobe event on the line 7 of path_lookup for the boot-time tracing
+and set it to the initrd.img.
+
+ ./perf probe -k /boot/vmlinux --bootconfig -D "path_lookup:7" > tmp.bconf
+ bootconfig -a tmp.bconf /boot/initrd.img
+
 
 SEE ALSO
 --------

