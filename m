Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D43FC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538BC6152A
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbhKHNlj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237209AbhKHNlj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1KjRDJ//n8quLSTh3tW94EM/JVn19TpBx1KSBtkyKY8=;
        b=X79vowqg37Drjt7KyuCIAEPkYDiOeKrSNc5qMHIdBXm6U2dJNXyFqgF7p6lSn59HtFI/g6
        UarHA1nyc4xbb2V2IRU8qCJwfKCIi3ocHq5ThMj2by+Apk3SgDKfjhQz0pFdE8+6nGg8WN
        GU1gBA4BDz0QquazJpANO1oU1wtJ81o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-2pgVfQkoNrqkBW9lQ3whEA-1; Mon, 08 Nov 2021 08:38:52 -0500
X-MC-Unique: 2pgVfQkoNrqkBW9lQ3whEA-1
Received: by mail-wm1-f72.google.com with SMTP id c185-20020a1c35c2000000b003331dc61c6cso4660419wma.6
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1KjRDJ//n8quLSTh3tW94EM/JVn19TpBx1KSBtkyKY8=;
        b=ZHNx2dFhLvu2/MNBxnlo3f8bFYkkxmW4QupvjL0VwD3GW1rD/49Edzuxeq2zhTKWze
         77j0wyqWFl6mwriO7MyyUZ6i8LKaMypzXupv8iCxEIuiFQ8Rf4wingkfTYJF5VY0e+Rh
         VWiElJ6c0u/fzXLZ1sfuWlCFDDrnOWm7nsqmQTjU3BlrY5sqVBCnVveMQ/K4F0ORPLJS
         bIDih5ClNAW5UdDMPBj20X0c9EnBJMD5qzOrZlXZP2Ptbf5PDmnDuOCV6bwYjy9v6d0y
         ZZiTjwUGwncIsg06gCV3yxMFCVuwr0FnJuHnDQA62Xvr0BBg+RO1u/ok/JJ5lVaTUyx3
         LyHA==
X-Gm-Message-State: AOAM532bUiZZqXjX0qiwgdAp1pu21yhtTLCrUSsfIM/1Q1zOZpAl+5Q8
        9Et6y1rS2C9/joeV6McT/UZco8hyTfNbGy5Y2xUdBDu8OcHyxnTAs3/OKsC/YDGH0U/X7dB2MJt
        1LTfiTCqY8IzzCzl2ekks7pOnH+ocVQ==
X-Received: by 2002:a5d:5850:: with SMTP id i16mr74260569wrf.197.1636378731202;
        Mon, 08 Nov 2021 05:38:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZohEBEaryiN2ayPKlVRn5rnCSlFewcxT9QVB3r91p6mWcPKsALDxEIznX7ySjFkZn8d/9YQ==
X-Received: by 2002:a5d:5850:: with SMTP id i16mr74260553wrf.197.1636378731078;
        Mon, 08 Nov 2021 05:38:51 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id y7sm16616291wrw.55.2021.11.08.05.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:38:50 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 15/59] libperf: Move precise_max to perf_evsel
Date:   Mon,  8 Nov 2021 14:36:26 +0100
Message-Id: <20211108133710.1352822-16-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving precise_max to perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/evsel.h | 1 +
 tools/perf/util/evsel.c                 | 8 ++++----
 tools/perf/util/evsel.h                 | 1 -
 tools/perf/util/parse-events.c          | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 6f820742615c..0d14cbebae3a 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -71,6 +71,7 @@ struct perf_evsel {
 		const char		*unit;
 		int			exclude_GH;
 		int			sample_read;
+		bool			precise_max;
 	};
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index e0fde07ae9b6..d1bb784a4310 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -317,7 +317,7 @@ struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config)
 	if (evsel == NULL)
 		goto out;
 
-	evsel->precise_max = true;
+	evsel->core.precise_max = true;
 
 	/* use asprintf() because free(evsel) assumes name is allocated */
 	if (asprintf(&evsel->core.name, "cycles%s%s%.*s",
@@ -427,7 +427,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->snapshot = orig->snapshot;
 	evsel->per_pkg = orig->per_pkg;
 	evsel->percore = orig->percore;
-	evsel->precise_max = orig->precise_max;
+	evsel->core.precise_max = orig->core.precise_max;
 	evsel->use_uncore_alias = orig->use_uncore_alias;
 	evsel->is_libpfm_event = orig->is_libpfm_event;
 
@@ -1287,7 +1287,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		attr->clockid = opts->clockid;
 	}
 
-	if (evsel->precise_max)
+	if (evsel->core.precise_max)
 		attr->precise_ip = 3;
 
 	if (opts->all_user) {
@@ -1739,7 +1739,7 @@ static void display_attr(struct perf_event_attr *attr)
 bool evsel__precise_ip_fallback(struct evsel *evsel)
 {
 	/* Do not try less precise if not requested. */
-	if (!evsel->precise_max)
+	if (!evsel->core.precise_max)
 		return false;
 
 	/*
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 83722fce3d04..79dd9ea5bf85 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -65,7 +65,6 @@ struct evsel {
 		bool			snapshot;
 		bool			per_pkg;
 		bool			percore;
-		bool			precise_max;
 		bool			use_uncore_alias;
 		bool			is_libpfm_event;
 		bool			collect_stat;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index da171f549e54..dc70ff74b357 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2051,7 +2051,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 		evsel->core.attr.exclude_idle   = mod.eI;
 		evsel->core.exclude_GH          = mod.exclude_GH;
 		evsel->core.sample_read         = mod.sample_read;
-		evsel->precise_max         = mod.precise_max;
+		evsel->core.precise_max         = mod.precise_max;
 		evsel->weak_group	   = mod.weak;
 		evsel->bpf_counter	   = mod.bpf_counter;
 
-- 
2.31.1

