Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A514C43334
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Jun 2022 06:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiFLGVV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 12 Jun 2022 02:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiFLGVU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 12 Jun 2022 02:21:20 -0400
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Jun 2022 23:21:19 PDT
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3D739BAD
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jun 2022 23:21:19 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id E465DC01B; Sun, 12 Jun 2022 08:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655014562; bh=nJDO7/qBIBucVpix5fyRM3Rkiiq7vw3tMCV118r+sj4=;
        h=From:To:Cc:Subject:Date:From;
        b=ibS4L0UCjxNSfiKLJvGRcjtTuXWAZ8IoSuX7hxFJnKoww4a4fLtSCYZUvWU19DF7K
         QM5IiwpB+CA/OSiqklIYgDvjMzS8se2hu8F/cP1dx0SIhnmynJw0qRxVdQgG2wNwKI
         rmDMSM7yzRjAF2dmKA1sGMsL4MOpkmVOHQvsSq6h6040E2r+dfRpVQD11gn0rmXPUM
         rFOTM7VLMw/3n2HCS0GXEGjI3RQ0aXKq7XOrtyTEaPKhvmfzoKsvRW5ZlxyIjJzLqm
         /KIf30X7o2MzLG1NP/eSLVMckgmRlzbcjgajYqbDpguYj/vV3LO1q1VilvwVjX7aNq
         aG5aAaWz11EjQ==
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id EC1C1C009;
        Sun, 12 Jun 2022 08:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655014552; bh=nJDO7/qBIBucVpix5fyRM3Rkiiq7vw3tMCV118r+sj4=;
        h=From:To:Cc:Subject:Date:From;
        b=X+28B/h9frr/iIwfyqbvVHz1QbaByJJkfl4R/GL/wcIgt7ckMZS/CFhz7YH4vq7Ss
         PsnGZi0JRVrsFJWWaK29bzbMODfEn6X84u29d//YYsURAbuqJlZUqD+UOeUtxhHbf8
         oPjjlr62vnxAHHZpO5K0nYEao2ielnw9fQW1r7reRAOmr7lx3GmniWvMsA4YcMuLgv
         JGChOQBJpesVbnDmv8Hk2GLpkH8uoG76W6mDjD2FyNds+u1J4VP6tikcIx0bLPuTsT
         Q0NbGWSoBLbXqBIahpQijUAR3Im/fXUiK5niuM6xwygYbTM9dtkwRF4WhqOSRhn+gf
         10we1yzNOll1Q==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id be16708e;
        Sun, 12 Jun 2022 06:15:45 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf parse: Allow names to start with digits
Date:   Sun, 12 Jun 2022 15:15:08 +0900
Message-Id: <20220612061508.1449636-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Tracepoints can start with digits, although we don't have many of these:

$ rg -g '*.h' '\bTRACE_EVENT\([0-9]'
net/mac802154/trace.h
53:TRACE_EVENT(802154_drv_return_int,
...

net/ieee802154/trace.h
66:TRACE_EVENT(802154_rdev_add_virtual_intf,
...

include/trace/events/9p.h
124:TRACE_EVENT(9p_client_req,
...

Just allow names to start with digits too so e.g. perf probe -e '9p:*'
works

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 tools/perf/util/parse-events.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 5b6e4b5249cf..4133d6950d29 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -211,7 +211,7 @@ bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
-name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
+name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
 name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
-- 
2.36.1

