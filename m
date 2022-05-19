Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F39C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 May 2022 03:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiESDUS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 23:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiESDUQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 23:20:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915FA55353
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 20:20:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v140-20020a252f92000000b0064d955c7b4eso3290184ybv.18
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 20:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ufua0rfEsqMCPLeh09lss9xKZavLX++00V1DsERJjuU=;
        b=C2Q3j4NOoL4Znn2cGiCWb4Z782Kd2RARJteKmjYTOGdWO6+Brzes/Fo4nRvRkBFGUB
         J81EYI6UBSwSDerNAoiP30Qs30Ii38BnskBz3WuRNFTJfZ5DujjkKEXhM5bS3io5SU7j
         LcQxaHJ+gy1ko9Zqrx1du2j26kXBIZS+6fUywTcYG0PL4WjiTEsXPXe7jY9TLdEdllpt
         5CRxECRfwb/Zx+fAEWGZY/MhkC7ExuppQP2pXqWTe36nsC0hdiWuduiaPv+hfylYKL8X
         8LHaBWv3xRmCkO0xvARKNFAWDYZb6sd6n3xIqRcRBdfbwxVk1cnz5pV9Ld9AUKsmCvFE
         7gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ufua0rfEsqMCPLeh09lss9xKZavLX++00V1DsERJjuU=;
        b=Mi9MBka6xc2CbA1EWancAa8Kuk3SBCtv2EeQeCoaW1VxFstfmz8tXy8rWBwoF2Ea8p
         9pNFA1ADVvVhihNGONn9A5UzH3ChjO4CW0y8lDGUSJVfAU6RX4MbQVi5mBw8R0jJyaQ4
         Bfz7QCVgGRMobnVRz085Fez/+McV0CjOkl9keiCxLMuDFU5Bt450X9LgOv4EF+vD+79f
         Z4DtNasPtNyOubN5ZXyTO5dcFmoOh99+6z6INCxIzlqtNBs6PtU5nVSI8DkpoDIzSmsb
         DOQA3FQDOW522GHU/l8YzVcvowkHHUs60yHOUNU+gWV2EadilI/CRJBl3SW1qgZJeKjH
         PVvQ==
X-Gm-Message-State: AOAM532P4fVNv0jBrLEQwbLdQtjkAMk5apeFR3hl5lBIs6RMuWpfYTNr
        u7p16wxsav8Byj8GaE3RwkLXF0QDfE2R
X-Google-Smtp-Source: ABdhPJx3T641FWbwHWHy2wSXrWrEb93gC2BG4MiPOUUip0yv3E7lm0SEMw+8KmEckfWymjCEbsRsFDLqc+hA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a233:bf3c:6ac:2a98])
 (user=irogers job=sendgmr) by 2002:a25:dc02:0:b0:64d:b6a3:e0bf with SMTP id
 y2-20020a25dc02000000b0064db6a3e0bfmr2460794ybe.41.1652930413690; Wed, 18 May
 2022 20:20:13 -0700 (PDT)
Date:   Wed, 18 May 2022 20:20:01 -0700
In-Reply-To: <20220519032005.1273691-1-irogers@google.com>
Message-Id: <20220519032005.1273691-2-irogers@google.com>
Mime-Version: 1.0
References: <20220519032005.1273691-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 1/5] perf stat: Fix and validate inputs in stat events
From:   Ian Rogers <irogers@google.com>
To:     Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Lv Ruyi <lv.ruyi@zte.com.cn>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Stat events can come from disk and so need a degree of validation. They
contain a CPU which needs looking up via CPU map to access a counter.
Add the CPU to index translation, alongside validity checking.

Discussion thread:
https://lore.kernel.org/linux-perf-users/CAP-5=fWQR=sCuiSMktvUtcbOLidEpUJLCybVF6=BRvORcDOq+g@mail.gmail.com/

Fixes: 7ac0089d138f ("perf evsel: Pass cpu not cpu map index to synthesize")
Suggested-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 4a5f3b8ff820..a77c28232298 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -474,9 +474,10 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 int perf_event__process_stat_event(struct perf_session *session,
 				   union perf_event *event)
 {
-	struct perf_counts_values count;
+	struct perf_counts_values count, *ptr;
 	struct perf_record_stat *st = &event->stat;
 	struct evsel *counter;
+	int cpu_map_idx;
 
 	count.val = st->val;
 	count.ena = st->ena;
@@ -487,8 +488,18 @@ int perf_event__process_stat_event(struct perf_session *session,
 		pr_err("Failed to resolve counter for stat event.\n");
 		return -EINVAL;
 	}
-
-	*perf_counts(counter->counts, st->cpu, st->thread) = count;
+	cpu_map_idx = perf_cpu_map__idx(evsel__cpus(counter), (struct perf_cpu){.cpu = st->cpu});
+	if (cpu_map_idx == -1) {
+		pr_err("Invalid CPU %d for event %s.\n", st->cpu, evsel__name(counter));
+		return -EINVAL;
+	}
+	ptr = perf_counts(counter->counts, cpu_map_idx, st->thread);
+	if (ptr == NULL) {
+		pr_err("Failed to find perf count for CPU %d thread %d on event %s.\n",
+			st->cpu, st->thread, evsel__name(counter));
+		return -EINVAL;
+	}
+	*ptr = count;
 	counter->supported = true;
 	return 0;
 }
-- 
2.36.1.124.g0e6072fb45-goog

