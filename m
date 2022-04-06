Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA00C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Apr 2022 11:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiDFL7c (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Apr 2022 07:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiDFL6W (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Apr 2022 07:58:22 -0400
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5505282F0
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Apr 2022 00:29:23 -0700 (PDT)
Received: (qmail 8439 invoked by uid 989); 6 Apr 2022 07:29:22 -0000
Authentication-Results: euporie.uberspace.de;
        auth=pass (plain)
From:   Florian Fischer <florian.fischer@muhq.space>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Florian Schmaus <flow@cs.fau.de>,
        Florian Fischer <florian.fischer@muhq.space>
Subject: [PATCH v2 4/4] perf util: add 'us' unit to the rusage time events
Date:   Wed,  6 Apr 2022 09:28:39 +0200
Message-Id: <20220406072839.107519-5-florian.fischer@muhq.space>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406072839.107519-1-florian.fischer@muhq.space>
References: <YkybjsCKyWkDZGX+@kernel.org>
 <20220406072839.107519-1-florian.fischer@muhq.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) REPLY(-4) MID_CONTAINS_FROM(1) BAYES_HAM(-1.955753)
X-Rspamd-Score: -4.555753
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Wed, 06 Apr 2022 09:29:22 +0200
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

---
 tools/perf/util/parse-events.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5c84d5d43bff..13db69b71187 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -421,6 +421,10 @@ static int add_event_tool(struct list_head *list, int *idx,
 		free((char *)evsel->unit);
 		evsel->unit = strdup("ns");
 	}
+	else if (tool_event == PERF_TOOL_RU_UTIME || tool_event == PERF_TOOL_RU_STIME) {
+		free((char *)evsel->unit);
+		evsel->unit = strdup("us");
+	}
 	return 0;
 }
 
-- 
2.35.1

