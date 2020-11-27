Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B38C64E7B
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Nov 2020 05:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE935221EB
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Nov 2020 05:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiuZ7fk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389414AbgK0FtA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 27 Nov 2020 00:49:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbgK0FtA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 Nov 2020 00:49:00 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 677F121D93;
        Fri, 27 Nov 2020 05:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606456139;
        bh=/YtIZKRJP1T006cX/Nf29w/v3Ysh0ly7iX2Zi8rOkEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KiuZ7fk9h4xzTdPPv3iXLoCz/ffSZJgMhoBTSSCjU6iYMAHvqOOobthn/6AyusfOk
         Z9M5KKRHKlzKgfWVsi4+Vb1l5dF1gbr3yhxUIksGpEufKkxY0PsqvGrOU3jkn9/cF+
         9GF4WJU0tBa0C1LAJubsWoYYug3M6XSENvEhP1cA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/2] perf-probe: Change function definition check due to broken dwarf
Date:   Fri, 27 Nov 2020 14:48:55 +0900
Message-Id: <160645613571.2824037.7441351537890235895.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126172849.GE53384@kernel.org>
References: <20201126172849.GE53384@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since some gcc generates a broken DWARF which lacks DW_AT_declaration
attribute from the subprogram DIE of function prototype.
(https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060)

So, in addition to the DW_AT_declaration check, we also check the
subprogram DIE has DW_AT_inline or actual entry pc.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/dwarf-aux.c    |   20 ++++++++++++++++++--
 tools/perf/util/probe-finder.c |    3 +--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 03c1a39c312a..7b2d471a6419 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -356,9 +356,25 @@ bool die_is_signed_type(Dwarf_Die *tp_die)
 bool die_is_func_def(Dwarf_Die *dw_die)
 {
 	Dwarf_Attribute attr;
+	Dwarf_Addr addr = 0;
+
+	if (dwarf_tag(dw_die) != DW_TAG_subprogram)
+		return false;
+
+	if (dwarf_attr(dw_die, DW_AT_declaration, &attr))
+		return false;
 
-	return (dwarf_tag(dw_die) == DW_TAG_subprogram &&
-		dwarf_attr(dw_die, DW_AT_declaration, &attr) == NULL);
+	/*
+	 * DW_AT_declaration can be lost from function declaration
+	 * by gcc's bug #97060.
+	 * So we need to check this subprogram DIE has DW_AT_inline
+	 * or an entry address.
+	 */
+	if (!dwarf_attr(dw_die, DW_AT_inline, &attr) &&
+	    die_entrypc(dw_die, &addr) < 0)
+		return false;
+
+	return true;
 }
 
 /**
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 2c4061035f77..76dd349aa48d 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1885,8 +1885,7 @@ static int line_range_search_cb(Dwarf_Die *sp_die, void *data)
 	if (lr->file && strtailcmp(lr->file, dwarf_decl_file(sp_die)))
 		return DWARF_CB_OK;
 
-	if (die_is_func_def(sp_die) &&
-	    die_match_name(sp_die, lr->function)) {
+	if (die_match_name(sp_die, lr->function) && die_is_func_def(sp_die)) {
 		lf->fname = dwarf_decl_file(sp_die);
 		dwarf_decl_line(sp_die, &lr->offset);
 		pr_debug("fname: %s, lineno:%d\n", lf->fname, lr->offset);

