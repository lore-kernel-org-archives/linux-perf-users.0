Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48167C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3201261506
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbhKHNlw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:41:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238674AbhKHNlt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rf/yQR9PqwtD6bYXVOOSNE9H2eY/8U0aYOU2brEAud4=;
        b=f28gZvqsGxcTar+A0E723nwovdPFNiMxvzGX5Iz6w/fwnZx/6P5wrLo9R+OFeCLTuYKtmv
        qWz/mTkeblbWVuINMZ4k7O5WlzpLobEjBpx/xTpAExb6EZp90sfXsryvI1xl7yM00qZz1Y
        ktgoZ3Rs7mFb2ERP2RfSvD7JI/7kdgM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-tLyWi7xYPGSQ_nmxwkpQLQ-1; Mon, 08 Nov 2021 08:39:04 -0500
X-MC-Unique: tLyWi7xYPGSQ_nmxwkpQLQ-1
Received: by mail-wr1-f71.google.com with SMTP id r12-20020adfdc8c000000b0017d703c07c0so4065028wrj.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rf/yQR9PqwtD6bYXVOOSNE9H2eY/8U0aYOU2brEAud4=;
        b=1LzPVEF4hfvczdsfY0YmzznCYEA68Xcf0mj5KA9k90yTdQUJTkH2jFElNEK5MTZGyd
         156iUFH0hVMVNLLkbv6ffAqicNWRX46p6eV0SQPOrRJ7FxUobgSG2U5fn8slLyWdUiKy
         JOXiDqccWgkH9abZFNO5mpgfyqY9DquhzO84IjxBU3biXDDLgv6BD38p7PruBE34GGHq
         tJx51nhN0FYe/nBaCTE5XbtbTU5CsaZDWutLX09q6gHQE+44UhKeFVlJCGl9GXYO4XsJ
         vSPp8AsctgwBy+jRxQHriq/0mjYLBiLKhue3lQ+HeNOW3ghDgJbSEmxNMB02JV4IyXfq
         KYcw==
X-Gm-Message-State: AOAM5325qJEaPb8YHFklkvPSMIsw1MEjc20zG/qoZ+lVgWx2y0VquUvs
        8xlL9ceeyLKJL1BxfsBiV9f0NchatQOqvfm6Usg/TCArZZP2gIACVg8LwTto/1GbQAupEO5SccY
        r3cg6F459V7fqBHmv/4rQEbB4sLdVOQ==
X-Received: by 2002:a05:600c:40b:: with SMTP id q11mr51602193wmb.185.1636378742970;
        Mon, 08 Nov 2021 05:39:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9FqW86Yc9JOcKog+3vayQiCTh32LiRgpCGVXg7c7RiV5DMVIqEEnwIVQC0+xC75dz/+PY/g==
X-Received: by 2002:a05:600c:40b:: with SMTP id q11mr51602175wmb.185.1636378742844;
        Mon, 08 Nov 2021 05:39:02 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 21sm15645079wmj.18.2021.11.08.05.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:39:02 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 17/59] libperf: Move bpf_counter to perf_evsel
Date:   Mon,  8 Nov 2021 14:36:28 +0100
Message-Id: <20211108133710.1352822-18-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving bpf_counter to perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/evsel.h | 1 +
 tools/perf/util/bpf_counter.c           | 2 +-
 tools/perf/util/evsel.h                 | 1 -
 tools/perf/util/parse-events.c          | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 8374dc8365cb..81df282fa008 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -73,6 +73,7 @@ struct perf_evsel {
 		int			sample_read;
 		bool			precise_max;
 		bool			weak_group;
+		bool			bpf_counter;
 	};
 };
 
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index ced2dac31dcf..c0146b4a03d3 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -770,7 +770,7 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
 		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
 	else if (cgrp_event_expanded && target->use_bpf)
 		evsel->bpf_counter_ops = &bperf_cgrp_ops;
-	else if (target->use_bpf || evsel->bpf_counter ||
+	else if (target->use_bpf || evsel->core.bpf_counter ||
 		 evsel__match_bpf_counter_events(evsel->name))
 		evsel->bpf_counter_ops = &bperf_ops;
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 22f579e0e862..c09bbddd5da0 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -68,7 +68,6 @@ struct evsel {
 		bool			use_uncore_alias;
 		bool			is_libpfm_event;
 		bool			collect_stat;
-		bool			bpf_counter;
 		bool			use_config_name;
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7a3a27f45644..24d01b768078 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2053,7 +2053,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 		evsel->core.sample_read         = mod.sample_read;
 		evsel->core.precise_max         = mod.precise_max;
 		evsel->core.weak_group          = mod.weak;
-		evsel->bpf_counter	   = mod.bpf_counter;
+		evsel->core.bpf_counter	        = mod.bpf_counter;
 
 		if (evsel__is_group_leader(evsel)) {
 			evsel->core.attr.pinned = mod.pinned;
-- 
2.31.1

