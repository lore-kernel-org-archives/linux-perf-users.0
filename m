Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AE1C32789
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Aug 2022 12:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiHVMnJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Aug 2022 08:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiHVMnI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Aug 2022 08:43:08 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2150932EFE;
        Mon, 22 Aug 2022 05:43:04 -0700 (PDT)
X-QQ-mid: bizesmtp66t1661172171tqmdel8e
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 22 Aug 2022 20:42:50 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: ElntjVByhgV5Ei9BmafEicp7RVbJm7ahRQPG/HG+Fm1GMRLI9bUePGYjWp1As
        xMU5YDdkwIBP4PQ5pvMUT3iwL3RiVyer6EdasXkyJMDgfxS1RHo8VVz/DEDEYG2sLPCJciZ
        Dc3wkPw1Hw/mv58HQRS/2uHknyICzidbVENCLsiWLN8qInt7fjxOGqKqxKR2GRGASdDpMvY
        RTfLLRoJUSiuEHITO7v4bW7B+yv/genf76jIm0TkhMC82txp2F+uCRqu8r2XzBPU3YMccxG
        Mrb8BFohGtAM16JcjWeBnFP8NXgmTroUpU+xvJ/J3qH9TcSlwN6qAeSPwLM2bcIO35FoARs
        mS7wywGcR1s9tL7SkagzsetXuBK1+InfDzJY/5xonGeWTCs0bv8Q5asvmwwhUuLG/QPEnGs
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] perf/util: fix repeated words in comments
Date:   Mon, 22 Aug 2022 20:42:43 +0800
Message-Id: <20220822124243.34053-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 tools/perf/util/cs-etm.c      | 2 +-
 tools/perf/util/probe-event.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8b95fb3c4d7b..16db965ac995 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1451,7 +1451,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		 * tidq->packet->instr_count represents the number of
 		 * instructions in the current etm packet.
 		 *
-		 * Period instructions (Pi) contains the the number of
+		 * Period instructions (Pi) contains the number of
 		 * instructions executed after the sample point(n) from the
 		 * previous etm packet.  This will always be less than
 		 * etm->instructions_sample_period.
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 062b5cbe67af..67c12d5303e7 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1349,7 +1349,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 				/*
 				 * Adjust the number of lines here.
 				 * If the number of lines == 1, the
-				 * the end of line should be equal to
+				 * end of line should be equal to
 				 * the start of line.
 				 */
 				lr->end--;
-- 
2.36.1

