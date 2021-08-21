Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8CDC4320A
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442B261206
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhHUJU3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhHUJU2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:20:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B071C061575;
        Sat, 21 Aug 2021 02:19:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id q3so17660657edt.5;
        Sat, 21 Aug 2021 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GDP1MLL1Qg0dnIIFehlblVPtQewpoe7l+lrwKCe2/Qk=;
        b=gvuvUP4K8VAsRQXs8iaxCIOLZ2hgDYsfWfsFAsaNSwAEYkWQ/cbp6CmgbOKpmL2ba0
         qfXF3SdKmYWLx0LYICMPcwDD7p1QXq+WqYJnKFZmnj3p/sj2Deb9OsDClZsi1Gr+isrj
         VFkDg0lJowsuvRFG6vFfTJcAOd23umQ2YDWQ1rMDIplTmMigt0ldWgftZYKQJ5fdZKp8
         na5uCnJtZ/OAkJxRHJpkWEz+2xKafbrqsFpI3unVYP3VKVQAj0pH2rJ94XpCYIeieFdI
         75YM0lqXc0FW9zOA5OWHRzuk6es8IIShY/jqjWi6/qs3Vmk12c5tJAPk4g5h/LTlc9HJ
         09lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDP1MLL1Qg0dnIIFehlblVPtQewpoe7l+lrwKCe2/Qk=;
        b=QuNv9qp/gPwKUrDn7gI+ms0ryFsPEqq5mbVWoOiXAm9MY4g3a7XR1RhccmY0tLszQT
         5j3wMUCflyIGaReVoTHTYZnYPel9VY7j+4nDShxXVeM/M7+rN8D2R0bCLSFLe+khqpf7
         lagQa1c4Kjyqp8SXHIcYndWlncFwC3vDXF+h5ho1dfSaiVQ2Ww1ypfcrBr/X/U1Rks8b
         0s1wlYtRKmVcweNh+AqTsn2n6YOzAs6Mi8CdtyFhh8AgjsHU/FVJBUJ26lBpNkSGUjUz
         UH4/xIBZLmMEqDy8FoYaCV+qGb56+OoBzr28o5eqg7BOk1X+WcaBADai+9bnBt9MepK8
         Kocg==
X-Gm-Message-State: AOAM530TzPWXfDPlXzrsM8dqYJIhhV3WcTJPob+iH9nfIcciufuaoUoY
        q+UOprtaYJHh4jnR9L46lZ8=
X-Google-Smtp-Source: ABdhPJwSs6s3PTZbEpUrjrXyqO3HTocUUwGhf7ReTxWPVyE0PPLIXqAfGHQ9vx3SmqQLDrL2TtgKNQ==
X-Received: by 2002:a05:6402:1694:: with SMTP id a20mr26812801edv.99.1629537587766;
        Sat, 21 Aug 2021 02:19:47 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:19:47 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v1 01/37] libperf cpumap: improve idx function
Date:   Sat, 21 Aug 2021 11:19:07 +0200
Message-Id: <f1543c15797169c21e8b205a4a6751159180580d.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From commit 7074674e7338863e ("perf cpumap: Maintain cpumaps ordered
and without dups"), perf_cpu_map elements are sorted in ascending order.

This patch improves the perf_cpu_map__idx function by using a binary
search.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/lib/perf/cpumap.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index ca0215047c326af4..fb633272be3aaed9 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -265,11 +265,18 @@ bool perf_cpu_map__empty(const struct perf_cpu_map *map)
 
 int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
 {
-	int i;
+	int low = 0, high = cpus->nr, idx, cpu_at_idx;
 
-	for (i = 0; i < cpus->nr; ++i) {
-		if (cpus->map[i] == cpu)
-			return i;
+	while (low < high) {
+		idx = (low + high) / 2;
+		cpu_at_idx = cpus->map[idx];
+
+		if (cpu_at_idx == cpu)
+			return idx;
+		else if (cpu_at_idx > cpu)
+			high = idx;
+		else
+			low = idx+1;
 	}
 
 	return -1;
-- 
2.31.1

