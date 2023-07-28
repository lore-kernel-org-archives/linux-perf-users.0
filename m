Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F7C001DF
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 14:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbjG1OTy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 10:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbjG1OTo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2023 10:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F26E7E
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 07:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E0466215D
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 14:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194D6C433BA;
        Fri, 28 Jul 2023 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690553974;
        bh=k1yrhKN55pnSQjpa8Z1plGb/LhTSCAvOOrECgnnamvw=;
        h=From:To:Cc:Subject:Date:From;
        b=QJjVNvz6PtGJz5LGDkofOdvKnuZvBbidyQ149ZaDfkmSVjpnUwVgMCV+pJGdW28qG
         nHbGbA8sIutFs6Ra4z8/sQlBUzsLmwWNQHE2cfWxlEuInh6JDnV1011/sFBAtmh2iJ
         0feYuNXoUcCe7WnWhSkOFebR4UXPDyyEhOBpnbjOhrm2yRJOPo2tbxTmU7RM9SFBtn
         8NLsa/iEkL3LUvvoW2e5fLUX3espMd9mjgI8neuwz//6s0qEwvqvkyDoKzQTvHFsYD
         9jt2rdNex8WywtYdu9pBABia+ZmgXWpYUVnkZTdmIFv25ezbKIYGq/zbxzvMShzBJs
         gdJFtcLgdGAEQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, mhiramat@kernel.org
Subject: [PATCH] perf probe: Show correct error about @symbol for uprobe
Date:   Fri, 28 Jul 2023 23:19:30 +0900
Message-Id: <169055397023.67089.12693645664676964310.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since @symbol variable access is not supported by uprobe event, it must be
correctly warn user instead of kernel version update.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/all/ZLWDEjvFjrrEJODp@kernel.org/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 6e2110d605fb..c1ded85fe859 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2800,13 +2800,18 @@ static void warn_uprobe_event_compat(struct probe_trace_event *tev)
 	if (!tev->uprobes || tev->nargs == 0 || !buf)
 		goto out;
 
-	for (i = 0; i < tev->nargs; i++)
-		if (strglobmatch(tev->args[i].value, "[$@+-]*")) {
-			pr_warning("Please upgrade your kernel to at least "
-				   "3.14 to have access to feature %s\n",
+	for (i = 0; i < tev->nargs; i++) {
+		if (strchr(tev->args[i].value, '@')) {
+			pr_warning("%s accesses a variable by symbol name, but that is not supported for user application probe.\n",
+				   tev->args[i].value);
+			break;
+		}
+		if (strglobmatch(tev->args[i].value, "[$+-]*")) {
+			pr_warning("Please upgrade your kernel to at least 3.14 to have access to feature %s\n",
 				   tev->args[i].value);
 			break;
 		}
+	}
 out:
 	free(buf);
 }

