Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7341BC433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 30 Apr 2022 06:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382186AbiD3G1K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 30 Apr 2022 02:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382207AbiD3G1E (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 30 Apr 2022 02:27:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E0CFE7C
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Apr 2022 23:23:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d11b6259adso93691587b3.19
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Apr 2022 23:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b34dyzAkv3FpeidZX/hRwae+MMN4Fpbu6ur7DPv1sVY=;
        b=hfLIL3a4Zhyyg3Nc2LxQ8wkrEYWraDLuY33gtpHXcSjAROtxwWSNuXWNoYgOgSw20m
         0+DB+YjgUYpjZQXDSb+TYy5nApOeR9ChnhcPR77D52Jb2xiCS6gr39wJ7BuA5lUpW7S6
         2XQXEigKXZNKefV3Qi+NqtplyP6VnyHZYvloh1lRlrGViDW3qdXXAAX6WqeuNBA4M+Ef
         x+n/WqFMozmxM0KnfddJL0rzgoTTpUwa9dnjG7T7b8xwlmNLekjz+hWYmb21LKC9UbXv
         sh0fHsDR/BqKByFiaxUF1xnIuh+7znh0ApsYAmYS2rKsdJCuj04OFbYLsXHyN9vtRrSK
         HdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b34dyzAkv3FpeidZX/hRwae+MMN4Fpbu6ur7DPv1sVY=;
        b=AfeLPO9Z/mbKvwbudqMtePEuvfySCSlSIEx6+N4tn07KrarKw3k/VVyz26utCa6czy
         ojnJbta+7yMLix+AOuJL2CdURF9y8BZSNiRewtCnJZSntds9r+2EPL52TCJO1auXDW59
         KxoSmQDONQy/YIjv3ZNMp/xznMeQvEmRKFIGFzjfKxI6N/tHB6Td02uzTUDkam4aCSwO
         LYGgSKaaWdj5uJHzFvHTPKZGsNstxJ5b9JKLkkyVuehKm/wR3BWJuPfj9rNh6DCHeCX9
         Ojzz1f6wqiWiwW9r9caubqxLPRNH7Zg0qU+rzvHlc6qnfNXO6MCyACb/8LslFBZN5xBo
         fiSg==
X-Gm-Message-State: AOAM5326luLatKFJl0JS0dLYZjdGnMFRwGWrwvPPgeIrlVGeyDy0/v8m
        QwxEyc+9PVTsuB1F6uCt/Gk46xlFOeMe
X-Google-Smtp-Source: ABdhPJxJRQJNZzDBHJN5YDt1lFxHqwUQLyivISTont2ekEDl8igflw9m4NtiuFCJeFVuGHhCDiRVX/QeMkHf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2481:caab:4fd5:232b])
 (user=irogers job=sendgmr) by 2002:a25:df8a:0:b0:647:4954:83e8 with SMTP id
 w132-20020a25df8a000000b00647495483e8mr2482748ybg.526.1651299822443; Fri, 29
 Apr 2022 23:23:42 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:23:23 -0700
In-Reply-To: <20220430062324.1565215-1-irogers@google.com>
Message-Id: <20220430062324.1565215-6-irogers@google.com>
Mime-Version: 1.0
References: <20220430062324.1565215-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 5/6] perf evlist: Add to user_requested_cpus documentation
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Document a key use-case in propagation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/evlist.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index e3e64f37db7b..74541bd87aa9 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -21,7 +21,8 @@ struct perf_evlist {
 	bool			 has_user_cpus;
 	/**
 	 * The cpus passed from the command line or all online CPUs by
-	 * default.
+	 * default. For evsels with no or dummy cpu maps, this cpu map replaces
+	 * their cpus during propagation.
 	 */
 	struct perf_cpu_map	*user_requested_cpus;
 	/** The union of all evsel cpu maps. */
-- 
2.36.0.464.gb9c8b46e94-goog

