Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2E0C19F2A
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Aug 2022 08:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiHGIqu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Aug 2022 04:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHGIqt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Aug 2022 04:46:49 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64427DFA5;
        Sun,  7 Aug 2022 01:46:47 -0700 (PDT)
X-QQ-mid: bizesmtp76t1659861998tku7hzlj
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 07 Aug 2022 16:46:30 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: 5q30pvLz2ifjYY45MUmNmIMw5FZwAdXwm31PRw0LeWE6+sWigjqDnja1gwmex
        rKt529CH9yGdSPGVzyDaOrLtm29v49fl0m1kTBUybYi2dMmul+oOC/lqUJBBcDbGHvqR2Hw
        Ucj7/oJI6CJLIOYUpq+ev5U2Iv50TLqGeC0Etju28q+rccST59qaa/2QyK3QQcqSnWfyrre
        ppWlY7EZlJd66UVzFGMuQ6JByK3OjJJ5ngYeSt98u4lYU2LoOFXFpE3LwhZk17rKYRKxpjs
        XZvuDz19+ztlMBNPx8dYitiI9RTZegKSbeXAgLMS6Ezc9AkmaeYY1iz3eJWjxcjxasoSDMT
        zTT4fXNUsj/zLNesm1OYgNDpm5GTZmzag5nC0kYJjDsBnTGE13OwYRebVbADA==
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] perf trace: Fix typo in comments
Date:   Sun,  7 Aug 2022 04:46:29 -0400
Message-Id: <20220807084629.23121-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Delete repeated word "and" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7aefecb23a17..2f7b1111d8e9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2748,7 +2748,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 
 		/*
 		 * Suppress this argument if its value is zero and
-		 * and we don't have a string associated in an
+		 * we don't have a string associated in an
 		 * strarray for it.
 		 */
 		if (val == 0 &&
-- 
2.35.1

