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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2857C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB3B61101
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhHUJVT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhHUJUv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:20:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C733AC0612A3;
        Sat, 21 Aug 2021 02:20:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g21so17634290edw.4;
        Sat, 21 Aug 2021 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GdLOUQfMiSvyr/krR4mQnx8RhZT43Ru8R5OO/VTr+4g=;
        b=oex+PMhEWJc4qwt8Ggjweiaj75IMXWNcxKWGsglVkLTpLuRsDVhhn9Wih1vYhRL6uf
         LAC+2aZENq3Dtc+KwR9Lt7gGQSGV+pDfGS8r+J3PeoTRCvpV5XXrjquIgDFvqAeMrAS3
         9oiakVOvaZiFkni2m8E1FK2cu60iW+4wLCIBem/tQVDSffnmj8La6mCuj/UftextcpKu
         LAVtX8rKzltLdnPy4zAtpMvZb9yJTWhkmOdSc3zZKkbXO1IZ+Wh9BY/CXeoUfqdub1VJ
         zgpzgEUvNjZcdKNbCfyJI/ZBaRChM35Hh2Ls4pfU0hWowUWGSlInw6IjIqt2ovkU5IbJ
         tnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GdLOUQfMiSvyr/krR4mQnx8RhZT43Ru8R5OO/VTr+4g=;
        b=TS3NuNSexre3XEqxfRLfyX0xuqC88AAW3NAr3kwuTSl4k5Yw6DWNTPZlj+3+2b1RMK
         IneIbaVrOXjCK29Whe28ttRK4pZLuVl/ZDYz6SVXiydHw6FbWhOhO1JwEh0Q9ZaEhR6X
         9XbY8A+Tn8ryMBcsDdE9aIR6RBMG//yRGVBrmTvS3c9GUrJ/zfjxr1XGg7bclyOKG0Uy
         dAQcYr2jHeqUjJg2mOcSRk1Do0qZclgZ9NSDPso3s4HSWhz85y8sLR0a6OiKZhHgs3h9
         nk480nE0eQ05nVGYY7+wsT6mDIF5Il5P7baEDdBHalr4C2h+OabV2ie05cQYFxUocVUO
         ONbQ==
X-Gm-Message-State: AOAM532mcYlrkj43o7cnxBryE6c/JQsOoLQqww/CiJGNbs5osflqA4MA
        /WGlHeU75PmFoN/mhu439WI=
X-Google-Smtp-Source: ABdhPJwv43GnPtCNdOqMO5P90nO8K3zv3Bm0H/mwUHij9kQ5Xq0T+kmsYbhkxKklIBPKKLg9Oq7N8Q==
X-Received: by 2002:aa7:ce87:: with SMTP id y7mr26928301edv.306.1629537604387;
        Sat, 21 Aug 2021 02:20:04 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:04 -0700 (PDT)
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
Subject: [RFC PATCH v1 13/37] perf evlist: add multithreading to evlist__close
Date:   Sat, 21 Aug 2021 11:19:19 +0200
Message-Id: <5473d8d537e30b3fd5333038dc5fdd25ba027d06.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In this patch, evlist__for_each_evsel_cpu is used in evlist__close to
allow it to run in parallel.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evlist.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index fbe2d6ed8ecc8f21..f0a839107e8849bf 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1340,11 +1340,17 @@ void evlist__set_selected(struct evlist *evlist, struct evsel *evsel)
 	evlist->selected = evsel;
 }
 
+static int __evlist__close_evsel_cpu_func(struct evlist *evlist __maybe_unused,
+					struct evsel *evsel, int cpu,
+					void *args __maybe_unused)
+{
+	perf_evsel__close_cpu(&evsel->core, cpu);
+	return 0;
+}
+
 void evlist__close(struct evlist *evlist)
 {
 	struct evsel *evsel;
-	struct affinity affinity;
-	int cpu, i, cpu_idx;
 
 	/*
 	 * With perf record core.cpus is usually NULL.
@@ -1356,19 +1362,8 @@ void evlist__close(struct evlist *evlist)
 		return;
 	}
 
-	if (affinity__setup(&affinity) < 0)
-		return;
-	evlist__for_each_cpu(evlist, i, cpu) {
-		affinity__set(&affinity, cpu);
+	evlist__for_each_evsel_cpu(evlist, __evlist__close_evsel_cpu_func, NULL);
 
-		evlist__for_each_entry_reverse(evlist, evsel) {
-			cpu_idx = evsel__find_cpu(evsel, cpu);
-			if (cpu_idx < 0)
-				continue;
-			perf_evsel__close_cpu(&evsel->core, cpu_idx);
-		}
-	}
-	affinity__cleanup(&affinity);
 	evlist__for_each_entry_reverse(evlist, evsel) {
 		perf_evsel__free_fd(&evsel->core);
 		perf_evsel__free_id(&evsel->core);
-- 
2.31.1

