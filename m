Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B89BC0015E
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Aug 2023 20:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjHAUzA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Aug 2023 16:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjHAUy7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Aug 2023 16:54:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB2311D
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Aug 2023 13:54:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5844a99c268so69038177b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Aug 2023 13:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690923298; x=1691528098;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=01D3Mc0WQ1sIli+WCBM4zperRKd1MnhhHpfIVHiLwx8=;
        b=1jJu6159CsEIRLvgUdpUI1Kmk2CD/pULRu35xBZarz3VKKiaxvzywe8XhiyRymuz9+
         VGXNWUH2W7pvQXfMIFXjZmhpOu6k5N8HysyDDxF6SRGYVwcdOjXbrjMZSdm3nL489cDc
         zNM16qvLpgziUskQ7RgtgbUDHKiLINF17HGx7edKruttIUkYvdFWrvMBgblyiXcIKy2K
         jA062pKnujX4Aq2su7H2c7Z7HerlA36c3xy6KMqDzQfKJv5GX4lc6ucFYCKTyZD3eDPo
         0JLAGEHy8Q9zCvLhjp+I25CNKfCJwrDZpC1A6PWm42ykYKs4hAwSlWvUEgc6mbjYXdhO
         aFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690923298; x=1691528098;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01D3Mc0WQ1sIli+WCBM4zperRKd1MnhhHpfIVHiLwx8=;
        b=LUyoIoNH6pGVHc1Hc4Un17eN4fcL2DND4QOXNtoQkcR7aGgkybF+pYnSRFgHLvuN0k
         odmXwiyG1ZHTpt6vQiEMdeIauKiqiM+iIAqQo+UOrMmNnitTeMW7z/frL1/CeH0o6PI+
         sU/0awnWNKdbX/jNuHIatjpOIoyGPZuOBvJX13Rn2ntPu2Egx90dJRqk81fHzOqnks4G
         KwqlxMRMbuHkJPgEiPSGlJ8cGmxcPmUdAHZMqPLsZ4sfKVLDPSsFO7MCnmi/RHTAKpB5
         bZCNCHUJPlsA417OAGiMHNVuB0yuNNv5+YRmvshMdi5l7QayMmNxSIOV+R2IAwyn19U5
         JZVA==
X-Gm-Message-State: ABy/qLalKZyYX6r7a1dZzj2/E46yjgz0Iqe1qTwGTHYXYfXYpAB1UWpo
        ZoePBFTcQigWH5YxTJ4uw7Bdykio3uTW
X-Google-Smtp-Source: APBJJlEq9l+NEtUD1U41TgFedR95hPQqXDoEZJG5YtLGgKxbgLgZUUEM7/8Esq5rFZhfDdXxNAOrT/Xz2wJm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bea9:545d:a179:25e7])
 (user=irogers job=sendgmr) by 2002:a25:d613:0:b0:d12:d6e4:a08d with SMTP id
 n19-20020a25d613000000b00d12d6e4a08dmr85369ybg.7.1690923298054; Tue, 01 Aug
 2023 13:54:58 -0700 (PDT)
Date:   Tue,  1 Aug 2023 13:54:52 -0700
Message-Id: <20230801205452.3380578-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Subject: [PATCH v1] perf stat: Don't display zero tool counts
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Claire Jensen <cjense@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Skip zero counts for tool events.

Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 7329b3340f88..d45d5dcb0e2b 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -931,6 +931,11 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 	 */
 	if (config->aggr_mode == AGGR_THREAD && config->system_wide)
 		return true;
+
+	/* Tool events have the software PMU but are only gathered on 1. */
+	if (evsel__is_tool(counter))
+		return true;
+
 	/*
 	 * Skip value 0 when it's an uncore event and the given aggr id
 	 * does not belong to the PMU cpumask.
-- 
2.41.0.585.gd2178a4bd4-goog

