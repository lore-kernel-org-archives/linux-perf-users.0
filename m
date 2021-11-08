Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21FFC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B530861506
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbhKHNlo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:41:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240006AbhKHNlo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ejuRsPNC89e59toYMnyfmFCBJyTRtW7yN4eTuH7rYFE=;
        b=VYnFMNkYgUC/9QlLRihki/7BWomNLEXd1eqXCUefem6/zHWhdJSACYtHsAaaAjUOICIBZM
        Zsjz0QkMyFoXQL9sweSP/PEXIvp7JTiQeuG0NHyf4Uj2+pBcZ60w+0ogGkvRRKm21mKukH
        RurXhw5gsfKz2RcUD0CCbkDXo8Ye1as=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-WBZXi4EIOl6dnGKGDVa2pQ-1; Mon, 08 Nov 2021 08:38:58 -0500
X-MC-Unique: WBZXi4EIOl6dnGKGDVa2pQ-1
Received: by mail-wm1-f70.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso10169571wms.4
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ejuRsPNC89e59toYMnyfmFCBJyTRtW7yN4eTuH7rYFE=;
        b=L11xdvBIc3AX3yD2d3hE798Rwk4/6Btku1V/G3TDnRSbGxb/dNVUghA2LHOyjCMGme
         gIsRLU/viMXnjR1QP9SwJxxvk4QtbMploBFDNSSUtlOugnM+5Zu6o2rafcuIZ8aW3Vie
         WAzXC+BezCSc8UXVefTjcT8dHTyAqJamBU4beOA8IuuL1ifsua8MPbdwADja5CLzwB04
         d99w/s3AWVaCyuJ4n7llCL1H/b/gAW+BXJtZLzuWaHf69WEn8rirMxg7Z5ECtcD8wy/0
         KiOQCB7hNBmTZcC8qeGAkFL72VpHIwV/E/iHHyBU7X1ABHlR4YuFlYa2IF/4U6RCZ/27
         U/jg==
X-Gm-Message-State: AOAM531otR/O3/x6plL4qR9RgfECFtnz0+OA6BGyj2IV54LO1IsjjLcK
        GI7495klmUSZh4SXuqq+7LFK1WNgDN4PtqAGuINQ4zRtQUEMUfv5ICV+Dyb4DKwuyreZfDVERBg
        iLkVior2ShbYjPxDN1ci0mO0JjnlCmg==
X-Received: by 2002:adf:f001:: with SMTP id j1mr93697494wro.351.1636378737083;
        Mon, 08 Nov 2021 05:38:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdjVMifEMIpObvyKa0YwXeBEH4oGqv7dPs1WrsDCqa+nFD9ZgWbHfTxWZaZBqum0fqYlC/0g==
X-Received: by 2002:adf:f001:: with SMTP id j1mr93697473wro.351.1636378736900;
        Mon, 08 Nov 2021 05:38:56 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id u15sm12757578wmq.13.2021.11.08.05.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:38:56 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 16/59] libperf: Move weak_group to perf_evsel
Date:   Mon,  8 Nov 2021 14:36:27 +0100
Message-Id: <20211108133710.1352822-17-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving weak_group to perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/evsel.h | 1 +
 tools/perf/builtin-record.c             | 2 +-
 tools/perf/builtin-stat.c               | 2 +-
 tools/perf/util/evsel.c                 | 2 +-
 tools/perf/util/evsel.h                 | 1 -
 tools/perf/util/parse-events.c          | 2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 0d14cbebae3a..8374dc8365cb 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -72,6 +72,7 @@ struct perf_evsel {
 		int			exclude_GH;
 		int			sample_read;
 		bool			precise_max;
+		bool			weak_group;
 	};
 };
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d5b899b235be..d232de3e72ac 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -929,7 +929,7 @@ static int record__open(struct record *rec)
 			}
 			if ((errno == EINVAL || errno == EBADF) &&
 			    pos->core.leader != &pos->core &&
-			    pos->weak_group) {
+			    pos->core.weak_group) {
 			        pos = evlist__reset_weak_group(evlist, pos, true);
 				goto try_again;
 			}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f57a366b7a1a..8b39f3f3b3b8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -842,7 +842,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 				 */
 				if ((errno == EINVAL || errno == EBADF) &&
 				    evsel__leader(counter) != counter &&
-				    counter->weak_group) {
+				    counter->core.weak_group) {
 					evlist__reset_weak_group(evsel_list, counter, false);
 					assert(counter->reset_group);
 					second_pass = true;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d1bb784a4310..aafd91805870 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -435,7 +435,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->core.sample_read = orig->core.sample_read;
 	evsel->core.auto_merge_stats = orig->core.auto_merge_stats;
 	evsel->collect_stat = orig->collect_stat;
-	evsel->weak_group = orig->weak_group;
+	evsel->core.weak_group = orig->core.weak_group;
 	evsel->use_config_name = orig->use_config_name;
 
 	if (evsel__copy_config_terms(evsel, orig) < 0)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 79dd9ea5bf85..22f579e0e862 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -68,7 +68,6 @@ struct evsel {
 		bool			use_uncore_alias;
 		bool			is_libpfm_event;
 		bool			collect_stat;
-		bool			weak_group;
 		bool			bpf_counter;
 		bool			use_config_name;
 		int			bpf_fd;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index dc70ff74b357..7a3a27f45644 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2052,7 +2052,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 		evsel->core.exclude_GH          = mod.exclude_GH;
 		evsel->core.sample_read         = mod.sample_read;
 		evsel->core.precise_max         = mod.precise_max;
-		evsel->weak_group	   = mod.weak;
+		evsel->core.weak_group          = mod.weak;
 		evsel->bpf_counter	   = mod.bpf_counter;
 
 		if (evsel__is_group_leader(evsel)) {
-- 
2.31.1

