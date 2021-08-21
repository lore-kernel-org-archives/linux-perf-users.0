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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27D0C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB11761101
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhHUJVr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbhHUJVS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:21:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36482C06179A;
        Sat, 21 Aug 2021 02:20:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s25so4933431edw.0;
        Sat, 21 Aug 2021 02:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/cXCUrZyJrSXhlY2buOOLYVNdgfOW9khyRbxBZB9LKU=;
        b=NKl0D4hS5TgUd757ZzzuL6NG8v3TvbZa1fdRJuOXQsnhL8YWP+PBmfc7Pa3/umlC8n
         ZFozMkcSYSTW05ngDMNqMASPmiQWXMwAUVrC0F42r9qCCs5V1nPikMsnDkT0/9Hvq7cK
         h+D63O9VduzhNF3uY5Tf/SBEefx06Wc6SFV2smWwtHBDG+wtyqid7QUOhFyAf5J3mt0P
         yWsn/ZKuEiaQ2a9yG/bKlyq9fmaK+qmmzwnw7f2n8HB5hxysJrXHbQYP9HEpSiuwY/9K
         fpJm2Bsk3sWwkTYef8YGMCJGdWlXQprwJ68v5xylCX1c9JMWTnXFrswS38Mg1kkUgk0y
         DOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cXCUrZyJrSXhlY2buOOLYVNdgfOW9khyRbxBZB9LKU=;
        b=o5HPEGFvBDWltriq3lYy8sdYgxGfczkCJo6IJ2TD5mPSe8OiqjYU8gZ9PvEfS7/QQR
         WmVN6sbTuLjb6HQzSfoLSVYIMH924LsZerv1zRCeCggKzC2zBQV0Fopw/W2Y/Zjz7n2G
         k+Xvc1bmbKdmx1fmaVv1IJR7kJ0Xb7W8SxbXLB4oAz/3w+Rnk+Qr5wazlfkHde8XWU58
         e6pKWpMspj+YuIgG8QOppAtGuqP3HeJbDYBSrVxJAmSIs8FFTrVMwCkGp3HZ+JtVbAE7
         YjndRH/NJQDrSAHrWKRpyYVZcFiKj85nvCVbRAhiwTjS8xk9zw1EKTOYzsq/qiVuG+of
         7wjQ==
X-Gm-Message-State: AOAM533fWkbr0JxsuhzcdNUiBlrhMET5ITmaLa/ysye0fs2ns9LqnlID
        9PIPakKf55OkrdUZQTID0jc=
X-Google-Smtp-Source: ABdhPJyrmCVUVKDCSeUyrd72rE8kDtU2kEI8A+skQ5Ur4cGEy4U7C0/OtaTP8ki/jiRGJRGbewaNxQ==
X-Received: by 2002:a50:cc0b:: with SMTP id m11mr26358893edi.96.1629537610818;
        Sat, 21 Aug 2021 02:20:10 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:10 -0700 (PDT)
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
Subject: [RFC PATCH v1 18/37] perf evsel: add evsel__prepare_open function
Date:   Sat, 21 Aug 2021 11:19:24 +0200
Message-Id: <fa5e78bbb92c848226f044278fdcf777b3ce4583.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This function will prepare the evsel and disable the missing features.
It will be used in one of the following patches.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evsel.c | 14 ++++++++++++++
 tools/perf/util/evsel.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f0bc89f743915800..4e9a3e62075305f1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1827,6 +1827,20 @@ static void evsel__disable_missing_features(struct evsel *evsel)
 		evsel->core.attr.sample_id_all = 0;
 }
 
+int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
+		struct perf_thread_map *threads)
+{
+	int err;
+
+	err = __evsel__prepare_open(evsel, cpus, threads);
+	if (err)
+		return err;
+
+	evsel__disable_missing_features(evsel);
+
+	return err;
+}
+
 static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads,
 		int start_cpu, int end_cpu)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 1c0057e80d080f2f..58aa998e1814ac9e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -286,6 +286,8 @@ int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
 int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads);
 void evsel__close(struct evsel *evsel);
+int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
+		struct perf_thread_map *threads);
 
 struct perf_sample;
 
-- 
2.31.1

