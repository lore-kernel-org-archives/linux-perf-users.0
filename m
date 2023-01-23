Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3936DC25B50
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Jan 2023 21:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjAWVNQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Jan 2023 16:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjAWVNP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Jan 2023 16:13:15 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A0B38026
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 13:13:15 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id jl3so12725160plb.8
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 13:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lnbo6gUHJR5pYy4aLoTMzmw2ofFdXg+9MZ+Z4rKqpeM=;
        b=DvkmHWYt2TVGKHIUWumHUCiqAw1NmzJoDmElCvjsvM9WzIdKa3W5gemYewsDOGfyVk
         wrLyAfKOZDz44CAephEEyuzXqKC2Rk4h+ZZLpqKIRJbip8T9PFvpH248Gz/QsWMMsJlc
         f9VuJ+3f/quFIJrX9NhW6R3tf+0Ls6/sNmotcAUTTMRzqso0dt5GyCewqmIyVXQm3Wbm
         e/u0D+mlS8afBmjLyUEoYvDolXmDRMJcuf9iRjbbSjv1Ep8kGiqfiFPAsueU59gHBw7G
         MQQoGvrwueOws0cmWWG7ApJDplGlume7/M7dABuHF8ZhhysG/gpY5y2MtLlGTyg3FYQO
         LrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lnbo6gUHJR5pYy4aLoTMzmw2ofFdXg+9MZ+Z4rKqpeM=;
        b=qFEbJXHrOzpFq6wH9pSFAWAP0RzQMhyudw4D+8ZslxdSQHvDpf7vYsO6Fq7KHDSzGb
         Fl+GGIjpz6XCl/fswypdkzJaw+2DVzlfdTPcninLTKGwRiL8gBkcdeQF2LP3nVYySYfy
         X5fqWR6QT8yBqwdhpRtSLqbWkQlw3Gl+u3Jh8LT5UVuqf9ERwX/ofdLTCyQZC1GC8/h3
         5QbYXVkotU37HzKPRfP+vmnhy0xz+fRhMaaysnCdqRsscESB5jdzkCmziy3gFuvmksTk
         9l7NCkc/8zVrl/Pw7ORnUonnKvqxkHggMz28K5x81g+bFPlyfU9K/CYt7Jm0YIdACWOj
         YmfQ==
X-Gm-Message-State: AFqh2koqlpGTWycsZGxq3Re85ViVsyRFKt1S9PpaPBsfnPovrse3kXwD
        vbvBsAX9qCm/2305RBmJB1ejKas+i4lCMA==
X-Google-Smtp-Source: AMrXdXsO744Pt5y+0B1eTvjr42h5fBAQQXGqKhFXHo38AsUROeBW4jFuDUXO4r7nRVbetEFn9OEFog==
X-Received: by 2002:a17:902:ebc9:b0:194:8260:cc50 with SMTP id p9-20020a170902ebc900b001948260cc50mr27593491plg.43.1674508394205;
        Mon, 23 Jan 2023 13:13:14 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::aee3])
        by smtp.gmail.com with ESMTPSA id jh20-20020a170903329400b001783f964fe3sm150487plb.113.2023.01.23.13.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:13:13 -0800 (PST)
From:   Khem Raj <raj.khem@gmail.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf cpumap: Make counter as unsigned ints
Date:   Mon, 23 Jan 2023 13:13:10 -0800
Message-Id: <20230123211310.127532-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

These are loop counters which is inherently unsigned. Therefore make
them unsigned. Moreover it also fixes alloc-size-larger-than
error with gcc-13, where malloc can be called with (-1) due to tmp_len
being an int type.

Fixes
| cpumap.c:366:20: error: argument 1 range [18446744065119617024, 18446744073709551612] exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
|   366 |         tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
|       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/cpumap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 6cd0be7c1bb4..d960880dd903 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -351,8 +351,8 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 					 struct perf_cpu_map *other)
 {
 	struct perf_cpu *tmp_cpus;
-	int tmp_len;
-	int i, j, k;
+	unsigned int tmp_len;
+	unsigned int i, j, k;
 	struct perf_cpu_map *merged;
 
 	if (perf_cpu_map__is_subset(orig, other))
@@ -369,7 +369,7 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 
 	/* Standard merge algorithm from wikipedia */
 	i = j = k = 0;
-	while (i < orig->nr && j < other->nr) {
+	while (i < (unsigned int)orig->nr && j < (unsigned int)other->nr) {
 		if (orig->map[i].cpu <= other->map[j].cpu) {
 			if (orig->map[i].cpu == other->map[j].cpu)
 				j++;
@@ -378,10 +378,10 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 			tmp_cpus[k++] = other->map[j++];
 	}
 
-	while (i < orig->nr)
+	while (i < (unsigned int)orig->nr)
 		tmp_cpus[k++] = orig->map[i++];
 
-	while (j < other->nr)
+	while (j < (unsigned int)other->nr)
 		tmp_cpus[k++] = other->map[j++];
 	assert(k <= tmp_len);
 
-- 
2.39.1

