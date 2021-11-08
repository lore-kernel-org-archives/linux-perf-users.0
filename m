Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96067C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB1861503
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbhKHNk6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:40:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235425AbhKHNk5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NiHsmNsMzSI8fWc11isQFjG99XbkvXdaxrL6GIoZylw=;
        b=STHN6RTnx/yramYujAt9PzPXJJZU79NH++4zx6XdNOa879rDREbf6shD9XOhBQ7gLnvSvt
        wWzWQu4K0rfBRTaQhxlKfSVCJ1vxuAZHovJFELQWHD1SEHZv7jQ2fcUTrqowdfeqfLpFg1
        s1aApayO6E4VFkBrIm4c4xsuMJYkmuE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-mH8foGTbMTedzfjMUuQHCw-1; Mon, 08 Nov 2021 08:38:11 -0500
X-MC-Unique: mH8foGTbMTedzfjMUuQHCw-1
Received: by mail-wm1-f69.google.com with SMTP id m1-20020a1ca301000000b003231d5b3c4cso10149012wme.5
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NiHsmNsMzSI8fWc11isQFjG99XbkvXdaxrL6GIoZylw=;
        b=oBhv95mdX/OIQGdJn9LwI3dpoQlczZbXqL6OFylApJQ4uyitGeBFMD9zXBjAjHjc/J
         H6k5PXD1Gb/jv21ryWQ7xYLdrmVNIH/p0ZaBlBcENH0HG4L92M1AEhd0mILvd62eW5dr
         O/BFZun2JGCGYyIZBwNodc1KbGZW3jXekQD1BpzaFTGJBctgoIj+3VfPpoMf5o8dL5Jb
         A5Of6NyKhagw2HebSPNqzB8t49h41K1L7yCfTPTncoK+0aGYG6TnZl+1OTGLwqFqhNdQ
         z0//DY+6ZrVK5HqvnlqstY0+RUKFEVtfEhh/hz8BfMkz6uW8UlTFtIwWippEEs1gcq4n
         O2Jw==
X-Gm-Message-State: AOAM531C8HlQyCUCBtPweywvQnckVjk9xKPAQOM1RM+EcUvPRKawcpON
        ohdFiKh96Au6pvLYdVh29eYKCVc+JJhMCaAFR7WHGEbdY3pIbIJ1f6n9YWPmHRpYOxzWpD8CwzK
        EP9Ghffy9Xfop1WW+js7vDZDgd5IyNQ==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr50160207wma.158.1636378690005;
        Mon, 08 Nov 2021 05:38:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylwqtf6lp6k7VdeYcfoe6WD8GJ0yAS66IM76OmuWYUDPxjfpE7C7FTrK0Dhu6TNheIcyRWhA==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr50160183wma.158.1636378689824;
        Mon, 08 Nov 2021 05:38:09 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id f3sm19450621wmb.12.2021.11.08.05.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:38:09 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 08/59] libperf: Move auto_merge_stats to perf_evsel
Date:   Mon,  8 Nov 2021 14:36:19 +0100
Message-Id: <20211108133710.1352822-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving auto_merge_stats to perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/evsel.h | 1 +
 tools/perf/util/evsel.c                 | 2 +-
 tools/perf/util/evsel.h                 | 1 -
 tools/perf/util/parse-events.c          | 2 +-
 tools/perf/util/stat-display.c          | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 808720b4cf77..be30dc1ed9a7 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -59,6 +59,7 @@ struct perf_evsel {
 	 */
         struct {
                 char			*name;
+		bool			auto_merge_stats;
 	};
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b737f1c60721..10ba2f91d5a2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -433,7 +433,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 
 	evsel->exclude_GH = orig->exclude_GH;
 	evsel->sample_read = orig->sample_read;
-	evsel->auto_merge_stats = orig->auto_merge_stats;
+	evsel->core.auto_merge_stats = orig->core.auto_merge_stats;
 	evsel->collect_stat = orig->collect_stat;
 	evsel->weak_group = orig->weak_group;
 	evsel->use_config_name = orig->use_config_name;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index de6ed7b258ca..ead2c3f3ea05 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -78,7 +78,6 @@ struct evsel {
 		bool			precise_max;
 		bool			use_uncore_alias;
 		bool			is_libpfm_event;
-		bool			auto_merge_stats;
 		bool			collect_stat;
 		bool			weak_group;
 		bool			bpf_counter;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 072ff971e32f..09fbb128df63 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -384,7 +384,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.cpus = cpus;
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.system_wide = pmu ? pmu->is_uncore : false;
-	evsel->auto_merge_stats = auto_merge_stats;
+	evsel->core.auto_merge_stats = auto_merge_stats;
 
 	if (name)
 		evsel->core.name = strdup(name);
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 9a685b347041..b00097e86c85 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -619,7 +619,7 @@ static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
 	cb(config, counter, data, true);
 	if (config->no_merge || hybrid_uniquify(counter))
 		uniquify_event_name(counter);
-	else if (counter->auto_merge_stats)
+	else if (counter->core.auto_merge_stats)
 		collect_all_aliases(config, counter, cb, data);
 	return true;
 }
-- 
2.31.1

