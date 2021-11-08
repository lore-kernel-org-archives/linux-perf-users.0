Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12339C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7C961458
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbhKHNoA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237467AbhKHNn7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9fk6iFL3+9GIV8413cGC0Srs7ozvs+r/JNhKnvIcuUk=;
        b=RZKQHS8+qk7Xx2Gx1XJDprcD/7MaRC2tqp7ysQFlI0UxrQ8cmuwx5qkCxhe16BHDabNp16
        yKqaWELXJZS10V6OTF2RBYDo/0pRF5wGZo6bWAUMyNaN7WK0hf+tRaVJHQ+eUJvicYXjHc
        Xwt+jDPaz6p/v6jFn1YAA96UWCpyYdA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-lsbFW0ERMJmyVGz22TTQIg-1; Mon, 08 Nov 2021 08:40:50 -0500
X-MC-Unique: lsbFW0ERMJmyVGz22TTQIg-1
Received: by mail-wm1-f70.google.com with SMTP id g80-20020a1c2053000000b003331a764709so5018952wmg.2
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fk6iFL3+9GIV8413cGC0Srs7ozvs+r/JNhKnvIcuUk=;
        b=zLv0i4Dua7fLOqZ6jMG+ABBxSjcPbema2GgqakSEydE2JL3DTHx3NvDh+Jr1Hzxx9T
         vEtZn9p9My7aCQuhCzx4+IXFer45jbjcRGbriBWGFXLGX/dh21k1XLLSwnJ4b84OFN8q
         3k8AGOLmRGGkOOtnza1gi+N97G24cM3dFZI4iirQH4gEySg7J6GLYfOPlbtPXGHHebFd
         dkGxzhNhPm+QKxe2BZZ6E3ztZMQsnjvx7RLVij79H2NHLLh3h4EcrLuIywFFe5Aotc0P
         7aaCX6EGgNBXt12Y5Yo2xbOkI0gFKObeNJ4WPyg4l8QcgWMopwfcyHw3n5LS39Eg3sPF
         hWkQ==
X-Gm-Message-State: AOAM531HZKpYqqvH5LP2xIpzmee1Oo6XzdkRlFQdAzaZnDUnYZ8hqq9N
        i1coLyAEfpa2mIwfDBHAR5f4hCgyh3mi4N0f2fnnuXs7os4qxnC1xW8C9GviI+p8d8ZvWvwyXTc
        f6Y1p79JRzKWl24PlKZzJL744GcMpAw==
X-Received: by 2002:adf:c986:: with SMTP id f6mr105445211wrh.216.1636378849101;
        Mon, 08 Nov 2021 05:40:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUL+SNeTl7zhGSVNCDO6GlyKPDUR2L27rhNSexWs0EVh+VEgZffb2gZIxI1Zzyc2SM9fWd9Q==
X-Received: by 2002:adf:c986:: with SMTP id f6mr105445192wrh.216.1636378848980;
        Mon, 08 Nov 2021 05:40:48 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t8sm16568884wrv.30.2021.11.08.05.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:40:48 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 35/59] libperf: Add perf_evsel__is_group_leader function
Date:   Mon,  8 Nov 2021 14:36:46 +0100
Message-Id: <20211108133710.1352822-36-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding perf_evsel__is_group_leader function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/evsel.h | 5 +++++
 tools/perf/util/evsel.h                 | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index befcd180ef3d..7759fe12d78e 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -89,4 +89,9 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__free_id(struct perf_evsel *evsel);
 
+static inline bool perf_evsel__is_group_leader(const struct perf_evsel *evsel)
+{
+        return evsel->leader == evsel;
+}
+
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 203abab2c48d..bf698e43c9fc 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -368,7 +368,7 @@ static inline struct evsel *evsel__prev(struct evsel *evsel)
  */
 static inline bool evsel__is_group_leader(const struct evsel *evsel)
 {
-	return evsel->core.leader == &evsel->core;
+	return perf_evsel__is_group_leader(&evsel->core);
 }
 
 /**
-- 
2.31.1

