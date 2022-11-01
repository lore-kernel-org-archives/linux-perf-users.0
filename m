Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7B8ECAAA1
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Nov 2022 13:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiKANOf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Nov 2022 09:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiKANOa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Nov 2022 09:14:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403D21B9C3;
        Tue,  1 Nov 2022 06:14:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFB1CB81D5F;
        Tue,  1 Nov 2022 13:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79BFC433C1;
        Tue,  1 Nov 2022 13:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667308463;
        bh=nd0dM0YiGevMBmIw3JCc/91WirhrGmiigVH7OCr9EG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=haNdp/Mokinp3DXYASQOQZyi8n+1U33VpAEjOZ92rTuzqfZYCwiVTcVLZdyTLCejb
         YTqK/8nB1AJHckWRzX80TqVKFy2sAOQ6GqwuuhEpnpLTx8Xpmk8aRQvae7zf2YeHei
         WLQKbPfpP2LGLgfusExQ+K3suWfNgLl2mz2XhZPEjafQaihz+Ema1ffFnmDd4KGQ3x
         zmr6O8whgsWGoJKO3jak0g3I/+paPR9IsdORxDi1VTbE9m4OSFJJdNkys19JhQixvE
         K1TFa29Id1mUkVzJ1tE1C3qT6JhLhCpwSI5bVy+Fz5yiQJQTIp62eiCOV7Z61ThHbi
         SoSyLz3DezBNA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/3] tools/perf: Fix to use dwarf_attr_integrate for generic attr accessor
Date:   Tue,  1 Nov 2022 22:14:19 +0900
Message-Id: <166730845967.2095228.7831422684261433316.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <166730844138.2095228.4225918836201778608.stgit@devnote3>
References: <166730844138.2095228.4225918836201778608.stgit@devnote3>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Use dwarf_attr_integrate() instead of dwarf_attr() for generic attribute
acccessor functions, so that it can find the specified attribute from
abstact origin DIE etc.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/perf/util/dwarf-aux.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 406b7bdc851a..216fc3d959e8 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -308,7 +308,7 @@ static int die_get_attr_udata(Dwarf_Die *tp_die, unsigned int attr_name,
 {
 	Dwarf_Attribute attr;
 
-	if (dwarf_attr(tp_die, attr_name, &attr) == NULL ||
+	if (dwarf_attr_integrate(tp_die, attr_name, &attr) == NULL ||
 	    dwarf_formudata(&attr, result) != 0)
 		return -ENOENT;
 
@@ -321,7 +321,7 @@ static int die_get_attr_sdata(Dwarf_Die *tp_die, unsigned int attr_name,
 {
 	Dwarf_Attribute attr;
 
-	if (dwarf_attr(tp_die, attr_name, &attr) == NULL ||
+	if (dwarf_attr_integrate(tp_die, attr_name, &attr) == NULL ||
 	    dwarf_formsdata(&attr, result) != 0)
 		return -ENOENT;
 

