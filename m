Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5FEC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B4761503
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbhKHNnC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:43:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237219AbhKHNnC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24dHEwsnrch9x4p4nBismqfbQ5wXIjFlCG0FPXPjn1Q=;
        b=Hwr25I2+J7jUmmGPehhlzKfVOylSGimFO4AKpghPFFNp6AsfGmA78xV4uO2LKM+6Mj5iKi
        Cdm+9rJV+8hiDLJIIa2oMn5GEKznINx1FM+1WMXRYpTT/Ulz3MUt8bkpv4EkY9pJSV5G3e
        Wgze6DL7NDmJ6NbhMSUel9k8Qhvte7A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-a2qZANkGMpKgp5AKvXDBKw-1; Mon, 08 Nov 2021 08:40:14 -0500
X-MC-Unique: a2qZANkGMpKgp5AKvXDBKw-1
Received: by mail-wm1-f72.google.com with SMTP id k6-20020a7bc306000000b0030d92a6bdc7so5779726wmj.3
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=24dHEwsnrch9x4p4nBismqfbQ5wXIjFlCG0FPXPjn1Q=;
        b=VuzphZGkqcjgNLinUe86Gpq+1r0cAShFJ1Jnk8IJwR2Y3ir2MNbt+nXkwmtzcne+l+
         pmNqRUUs74GDGLg1slIICIBnMraoHbBE6sBiI67NEumf2jrl7FElHHBkGrp3o2m1vO6i
         3TdPt1c4cyCKoBgVzenzZ3z2CjVnUawBRkFvfODYEEeNQUIzmiugec+RH9NStB5q4thX
         7q4oE//6OMY8uYQ3bS9nzt733eSDYUhAFV+RwVygjFzNG9c0AbUv6P3H7jQjgsVWrRMD
         DCMHazyoHkH2G0075EtFeRdy6OVqoLQnEj7D4QK93GnWHy4UnEQWBcSstCuGdjd693qZ
         a92Q==
X-Gm-Message-State: AOAM531KQmRhfY06mWqnmMepPRX5uliARoqaapoAMXiJNZwqewHQFKqx
        ubt6G2LbQ/aW2qK+gSil1DHlKHKvaCZLs3wlS+XBKYImyi7umQuaQl/kUneEz9eJFiTkkzdkfmm
        uhqmnzu8EX45Zfrf6bt1+u+mf3mtAEw==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr34820143wrd.369.1636378813712;
        Mon, 08 Nov 2021 05:40:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5lguhN/wIm2h6J84Mg+NRHt/vBJEGUdtW5r+BEC+1LH8ht+qiQF0nU1ZIyg5q/UAS7gxW6Q==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr34820124wrd.369.1636378813543;
        Mon, 08 Nov 2021 05:40:13 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id h2sm1659011wrz.23.2021.11.08.05.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:40:13 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 29/59] perf tools: Change struct parse_events_state::evlist to perf_evlist
Date:   Mon,  8 Nov 2021 14:36:40 +0100
Message-Id: <20211108133710.1352822-30-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Changing struct parse_events_state::evlist to perf_evlist
to prepare it for moving to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 8 +++++---
 tools/perf/util/parse-events.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f41dd97f1623..7e4bc4c1190e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -774,6 +774,7 @@ parse_events_config_bpf(struct parse_events_state *parse_state,
 			struct list_head *head_config)
 {
 	struct parse_events_term *term;
+	struct evlist *evlist;
 	int error_pos;
 
 	if (!head_config || list_empty(head_config))
@@ -789,12 +790,13 @@ parse_events_config_bpf(struct parse_events_state *parse_state,
 			return -EINVAL;
 		}
 
-		err = bpf__config_obj(obj, term, parse_state->evlist, &error_pos);
+		evlist = container_of(parse_state->evlist, struct evlist, core);
+		err = bpf__config_obj(obj, term, evlist, &error_pos);
 		if (err) {
 			char errbuf[BUFSIZ];
 			int idx;
 
-			bpf__strerror_config_obj(obj, term, parse_state->evlist,
+			bpf__strerror_config_obj(obj, term, evlist,
 						 &error_pos, err, errbuf,
 						 sizeof(errbuf));
 
@@ -2224,7 +2226,7 @@ int __parse_events(struct evlist *evlist, const char *str,
 		.list	  = LIST_HEAD_INIT(parse_state.list),
 		.idx	  = evlist->core.nr_entries,
 		.error	  = err,
-		.evlist	  = evlist,
+		.evlist	  = &evlist->core,
 		.stoken	  = PE_START_EVENTS,
 		.fake_pmu = fake_pmu,
 		.ops	  = &parse_state_ops,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 34ee456629b0..2f75e823124f 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -81,7 +81,7 @@ struct parse_events_state {
 	int			   idx;
 	int			   nr_groups;
 	struct parse_events_error *error;
-	struct evlist		  *evlist;
+	struct perf_evlist	  *evlist;
 	struct list_head	  *terms;
 	int			   stoken;
 	struct perf_pmu		  *fake_pmu;
-- 
2.31.1

