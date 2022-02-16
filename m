Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F646C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Feb 2022 03:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344005AbiBPDHC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Feb 2022 22:07:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344002AbiBPDHB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Feb 2022 22:07:01 -0500
Received: from qq.com (smtpbg480.qq.com [59.36.132.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682FE2B267
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Feb 2022 19:06:50 -0800 (PST)
X-QQ-mid: bizesmtp90t1644980693tylaq75g
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 16 Feb 2022 11:04:41 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00A0000000
X-QQ-FEAT: G+mSt178IQqtrmaXXYz7lyJ3KPDNlaIiWGgP5TqNWATsAk5FNjA6Hpx8ZL6bA
        ZxDb1yzWaOxKOFBHgb8MJGjuZXSvhgysm10z5X+aHlHK4bXs+sK08W2IBG1mN1GFPo60TTX
        PjFiyDgNr0Q54GGlU9Yp22YFB+z4TA81L4Wt6iav0ITlcyMRs+JYs2f3HunMvRvlXWr9tyD
        +mtDfFrtxD9UKdXq4mO2bOwmV4dlxUHJai+QqFppNKRC0S9zwY5uq4DPGq0qC/fwoExFE80
        JIMmVM2DNz2ZzG+wq51B8QKitjs1ikMtp0KU5g/jn/JrOAsNQ8UuQbn+9sX1IBXmGtjd7R+
        U6nIGiN1ncPIg/0kM25gNH1zpK8lg==
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 2/2] perf tools: Remove redundant err variable
Date:   Wed, 16 Feb 2022 11:04:25 +0800
Message-Id: <20220216030425.27779-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220216030425.27779-1-tangmeng@uniontech.com>
References: <20220216030425.27779-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The variable err in the perf_event__process_sample is only used
in the only one judgment statement, it is not used in other places.

So, use the return value from hist_entry_iter__add() directly
instead of taking this in another redundant variable.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 tools/perf/builtin-top.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1fc390f136dd..3c8c60b7f6f0 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -746,7 +746,6 @@ static void perf_event__process_sample(struct perf_tool *tool,
 {
 	struct perf_top *top = container_of(tool, struct perf_top, tool);
 	struct addr_location al;
-	int err;
 
 	if (!machine && perf_guest) {
 		static struct intlist *seen;
@@ -839,8 +838,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 
 		pthread_mutex_lock(&hists->lock);
 
-		err = hist_entry_iter__add(&iter, &al, top->max_stack, top);
-		if (err < 0)
+		if (hist_entry_iter__add(&iter, &al, top->max_stack, top) < 0)
 			pr_err("Problem incrementing symbol period, skipping event\n");
 
 		pthread_mutex_unlock(&hists->lock);
-- 
2.20.1



