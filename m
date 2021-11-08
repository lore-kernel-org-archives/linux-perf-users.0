Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8169C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBC361503
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbhKHNm0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:42:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240014AbhKHNmZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x1jaXOkzwIxAc/xhD4QN+0GGiMsxLzitsTj9Lgd/KnI=;
        b=PE+uGdn6LaN98NbCbRs8xWg8eJ+j2+llerPIm80+AJWpvNJPaikamSCGS9BpOwPrj++aeJ
        162TeV/vM1xzxUK/OVZ1AVI9h8j/R0Rr81oJd0Tgpx6wjyz82ZoVvOjrvyeZiVxRDlI6J6
        fyVpjTptjzbhi7iyisO0VrxCtFvlMoA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-2ue5P6IVN5658Yo7fGMeqQ-1; Mon, 08 Nov 2021 08:39:39 -0500
X-MC-Unique: 2ue5P6IVN5658Yo7fGMeqQ-1
Received: by mail-wm1-f72.google.com with SMTP id g80-20020a1c2053000000b003331a764709so5017698wmg.2
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1jaXOkzwIxAc/xhD4QN+0GGiMsxLzitsTj9Lgd/KnI=;
        b=QSh8w+DayaYVPF2aKFV4wEBte7tWWMBgO8gOarORVTyREsyg6VEdVWclNiQnMDHF79
         ybAobEdCBI3xXZExSjsiq0YJ3Er6jTu/cT7u/Wn0vpChwJ55nvIi13mUvb4LFZXhuFPJ
         YlB+Hu+4rnpS0UTw6Woz3R73KeNV3FbHp9SO8mm5+ycQJD/4P+IS+LIPHa81VZ3o9ybF
         owfL7Z10QLuKv/bbos+uSI+8NTGcliVIZh8ZDx/tgv0bKMvCiq0yRTHto0mfiiWaigGp
         vcNVWyXss3RflrkIoA759Lsfl/MxaFmFOq81h8rPMtVku0NRbwc6ycW1XOIlJEG/OKHK
         PghA==
X-Gm-Message-State: AOAM530jyVRxopT/E68h+SlzFTuN4Qt6zHGfNzqgJRBQWhtYMeO7piBQ
        a0tSgVkjEytbLhlf7wUVzzAEZGTsbWB38GHezG2EL5n5d4Lgxp5btnua10H79p2XYNCaY7AI1P0
        KvZnzvzZNgBQKVcXXglVjUAI/pENX3Q==
X-Received: by 2002:adf:e848:: with SMTP id d8mr81438713wrn.3.1636378778341;
        Mon, 08 Nov 2021 05:39:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOEi1LWSRxI1j/f5AVO4so1GuQ/iHjvU4cDCjnbuRzqfYi49VjxvzCo3o7tDai+QhLDyAoCw==
X-Received: by 2002:adf:e848:: with SMTP id d8mr81438697wrn.3.1636378778227;
        Mon, 08 Nov 2021 05:39:38 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id c6sm17522247wmq.46.2021.11.08.05.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:39:37 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 23/59] perf tools: Add evsel__new_tp callback to parse_state_ops
Date:   Mon,  8 Nov 2021 14:36:34 +0100
Message-Id: <20211108133710.1352822-24-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding evsel__new_tp callback to parse_state_ops to allow
custom tracepoint event allocation for event parsing.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 5 +++--
 tools/perf/util/parse-events.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e782a329484e..60f48d797853 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -155,7 +155,8 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 };
 
 static struct parse_events_ops parse_state_ops = {
-	.evsel__new = evsel__new_idx,
+	.evsel__new    = evsel__new_idx,
+	.evsel__new_tp = evsel__newtp_idx,
 };
 
 #define __PERF_EVENT_FIELD(config, name) \
@@ -606,7 +607,7 @@ static int add_tracepoint(struct parse_events_state *parse_state,
 			  struct list_head *head_config)
 {
 	int *idx = &parse_state->idx;
-	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, (*idx)++);
+	struct evsel *evsel = parse_state->ops->evsel__new_tp(sys_name, evt_name, (*idx)++);
 
 	if (IS_ERR(evsel)) {
 		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 346c3a8cd381..728074093c95 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -132,6 +132,7 @@ struct parse_events_error {
 
 struct parse_events_ops {
 	struct evsel* (*evsel__new)(struct perf_event_attr *attr, int idx);
+	struct evsel* (*evsel__new_tp)(const char *sys, const char *name, int idx);
 };
 
 struct parse_events_state {
-- 
2.31.1

