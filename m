Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E475C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB2561505
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbhKHNl1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:41:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239992AbhKHNl0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YPlWQ7R5s7ihnsjWl+J80VBmUiqlhu5SV43sqirLh6o=;
        b=AyBGrM8nNvb13wQQ1M/v4Z8UJtz2gZrDtqzm610/SN4Ge5hDC9o1LSntVl6RIOjk1qc9TW
        FFb7KFyS3hSemUHDTpCOJ8GCjk0BZLalwNQEzXDWnefTTvsp6MHoISKTa7ntteN8Ia62rQ
        fMlqgawJ1mfk81fwaKm8ixx3V0fRYbk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-MldW1PvhPOm3mjmP5kaV6A-1; Mon, 08 Nov 2021 08:38:40 -0500
X-MC-Unique: MldW1PvhPOm3mjmP5kaV6A-1
Received: by mail-wm1-f71.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so6212047wmj.8
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YPlWQ7R5s7ihnsjWl+J80VBmUiqlhu5SV43sqirLh6o=;
        b=PtqHf9PW/4BBBi8Z0PBQMzzTXfrdSki4QKIYLxkh/ak2foLn6yroD1+1mirFOnPKYI
         5i6WJcl3Icmr/g9+VDC3EHgg1Ji7sr1vWokB4TYh57Ykh7TX/DX3T8V4iyNSNflW6Y1m
         +itpo3F+FTc1rUwU0zvUrczQAU5IyB3SxWSpa472KRpIL7DXB4EJbM74GitFjB7liMWn
         6OQ6mzSttCEJRrHyuy3yhlSHNPq74551pgQwDHlYS/Azj2YVUbIk+ffwgl95BDvH+oZT
         fiR/y/BElyLfXzubyetZHAj2nbHjS4omv9qZ454lP2ZK2hmmw/k7IpKjE6PdbEX+o/mW
         D6oA==
X-Gm-Message-State: AOAM5333Hk+tRzj8QWzfKH2ZDdaUaUgYuhCvIIPXydPaOmu7wtQF4nUW
        HXa6q5RJCX1CkQ/MjiXf4tcrlD8h9X3t9jyIJsWiyQfDWkojGtRRA64e1tNITtYVquGYOKpTp9Z
        8XvJ6Byex7aT97HdgyaevKy/qq/Mrxg==
X-Received: by 2002:a1c:a904:: with SMTP id s4mr50581450wme.163.1636378719399;
        Mon, 08 Nov 2021 05:38:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkrIiHQ+mBxsVqWOSMqv/StZEm46UQvWqUYk3zROUtX+2OBpbtFPTEIxK2s8jMM699ABGFcw==
X-Received: by 2002:a1c:a904:: with SMTP id s4mr50581437wme.163.1636378719258;
        Mon, 08 Nov 2021 05:38:39 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id f15sm16406516wrt.26.2021.11.08.05.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:38:39 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 13/59] libperf: Move exclude_GH to perf_evsel
Date:   Mon,  8 Nov 2021 14:36:24 +0100
Message-Id: <20211108133710.1352822-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving exclude_GH to perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/evsel.h | 1 +
 tools/perf/util/evsel.c                 | 2 +-
 tools/perf/util/evsel.h                 | 1 -
 tools/perf/util/parse-events.c          | 4 ++--
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index b96c9f4808ca..7f3ee73c5aa5 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -69,6 +69,7 @@ struct perf_evsel {
 		const char		*metric_id;
 		enum perf_tool_event	tool_event;
 		const char		*unit;
+		int			exclude_GH;
 	};
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 133b571e1190..802c7de9e8e3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -431,7 +431,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->use_uncore_alias = orig->use_uncore_alias;
 	evsel->is_libpfm_event = orig->is_libpfm_event;
 
-	evsel->exclude_GH = orig->exclude_GH;
+	evsel->core.exclude_GH = orig->core.exclude_GH;
 	evsel->sample_read = orig->sample_read;
 	evsel->core.auto_merge_stats = orig->core.auto_merge_stats;
 	evsel->collect_stat = orig->collect_stat;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index f6cc1e78903f..6c3634ed169a 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -62,7 +62,6 @@ struct evsel {
 		double			scale;
 		struct cgroup		*cgrp;
 		/* parse modifier helper */
-		int			exclude_GH;
 		int			sample_read;
 		bool			snapshot;
 		bool			per_pkg;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1878ea1310d3..89787ebc23ef 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1918,7 +1918,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 	int exclusive = evsel ? evsel->core.attr.exclusive : 0;
 
 	int exclude = eu | ek | eh;
-	int exclude_GH = evsel ? evsel->exclude_GH : 0;
+	int exclude_GH = evsel ? evsel->core.exclude_GH : 0;
 	int weak = 0;
 	int bpf_counter = 0;
 
@@ -2049,7 +2049,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 		evsel->core.attr.exclude_host   = mod.eH;
 		evsel->core.attr.exclude_guest  = mod.eG;
 		evsel->core.attr.exclude_idle   = mod.eI;
-		evsel->exclude_GH          = mod.exclude_GH;
+		evsel->core.exclude_GH          = mod.exclude_GH;
 		evsel->sample_read         = mod.sample_read;
 		evsel->precise_max         = mod.precise_max;
 		evsel->weak_group	   = mod.weak;
-- 
2.31.1

