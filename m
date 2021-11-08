Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31952C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A40D6109E
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbhKHNo7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:44:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240034AbhKHNo6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0LAkm7loRNbTFLnjyA4F86hTZ98E6wUKKNsBjEc+Q0Y=;
        b=AeBFSJwTP0iRz3bdIBEY3vULBxL+cD/hXKbiThkuKWCqZx9d/lfslJS3dIGl6W9pyB13nT
        cXYMYMF5QDBcLZvfePnmTzR5V1V7ZOs1WWCLaKGOQqp9xn/x68vSgStBpxEnR7rNRoBzoP
        yUuec944d+YAxc/iYoNi2yEA3alXrpY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-JmANnpuAOBCuWXSY_Bsdew-1; Mon, 08 Nov 2021 08:42:13 -0500
X-MC-Unique: JmANnpuAOBCuWXSY_Bsdew-1
Received: by mail-wm1-f69.google.com with SMTP id j193-20020a1c23ca000000b003306ae8bfb7so6226910wmj.7
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0LAkm7loRNbTFLnjyA4F86hTZ98E6wUKKNsBjEc+Q0Y=;
        b=Ycb8LWpvZ51VOhvn5DYaJnYfw2Ci+lEu+57X9H+ORg9cyxCki/8kP1nrw5UnU08n7Q
         xXJ+3SCm8OdBQJQhZ+fzrzPftv1Sz5UPbou/tPKs4orN43fGuxA0/jfh5jbXe+ijdPW4
         YiRwVbDvW7eLxMl6QFfrITBx4h2Az8klRpdKaXXxRq1QFGp/f1cdX2Ezd4gV3HIfWCWe
         /FTqm6eygajwsEpi2fmWk+GC6Hq3S17HDxc+AfubIT3rapjOsDnk3S33eheA1oWHvvmB
         Brp9KTwdYphG8LZ64LBb5EWw4L7Tod2eC9WY6Ed3CWnvvHdDsRL4e2t5pQMKw7VXxWyl
         ATkg==
X-Gm-Message-State: AOAM533jKB1FkLVHu9pbGxlnuaxLISW+zVHdmXwlrYBM5E7R0D8qR2Hr
        99d7n6i/fCfaLAFFXOurGLeQaHPawut+Bdh2vgxmbtUHZOIbNwWGq+6ZJP433OVuem1Bvdg8yT0
        yjjvq4au20pVngqVJ9RPl9Z6ReS9Nog==
X-Received: by 2002:adf:a389:: with SMTP id l9mr89120727wrb.121.1636378931934;
        Mon, 08 Nov 2021 05:42:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMG0hOSBvz4ol/efXTBhOwVaCwql/b17gU2TqELATr4sl3sQdaqRS7YkJPfw6fMhQAKMPC8A==
X-Received: by 2002:adf:a389:: with SMTP id l9mr89120709wrb.121.1636378931799;
        Mon, 08 Nov 2021 05:42:11 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id c17sm17061125wmk.23.2021.11.08.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:42:11 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 49/59] perf tools: Add add_tracepoint callback to struct parse_events_ops
Date:   Mon,  8 Nov 2021 14:37:00 +0100
Message-Id: <20211108133710.1352822-50-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding add_tracepoint callback to struct parse_events_ops,
to allow custom tracepoint parsing code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/parse-events.h | 6 ++++++
 tools/perf/util/parse-events.c                 | 8 ++++++++
 tools/perf/util/parse-events.h                 | 5 -----
 tools/perf/util/parse-events.y                 | 4 ++--
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 9a30155d628b..f06c86630fda 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -117,6 +117,12 @@ struct parse_events_ops {
 	int (*add_breakpoint)(struct parse_events_state *parse_state,
 			      struct list_head *list,
 			      u64 addr, char *type, u64 len);
+
+	int (*add_tracepoint)(struct parse_events_state *parse_state,
+			      struct list_head *list,
+			      const char *sys, const char *event,
+			      struct parse_events_error *err,
+			      struct list_head *head_config);
 };
 
 struct parse_events_state {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0b033c8a852a..ad2bec6e6b37 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -50,6 +50,12 @@ static int get_config_terms(struct list_head *head_config,
 static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
 					 const char *str, char *pmu_name,
 					 struct list_head *list);
+static
+int parse_events_add_tracepoint(struct parse_events_state *parse_state,
+				struct list_head *list,
+				const char *sys, const char *event,
+				struct parse_events_error *err,
+				struct list_head *head_config);
 
 static struct parse_events_ops parse_state_ops;
 static struct perf_pmu_event_symbol *perf_pmu_events_list;
@@ -1286,6 +1292,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 	return 0;
 }
 
+static
 int parse_events_add_tracepoint(struct parse_events_state *parse_state,
 				struct list_head *list,
 				const char *sys, const char *event,
@@ -2910,4 +2917,5 @@ static struct parse_events_ops parse_state_ops = {
 	.add_numeric        = parse_events_add_numeric,
 	.add_cache          = parse_events_add_cache,
 	.add_breakpoint     = parse_events_add_breakpoint,
+	.add_tracepoint     = parse_events_add_tracepoint,
 };
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 6bd3ab01f063..328612945503 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -63,11 +63,6 @@ struct perf_pmu_event_symbol {
 
 void parse_events__shrink_config_terms(void);
 void parse_events__clear_array(struct parse_events_array *a);
-int parse_events_add_tracepoint(struct parse_events_state *parse_state,
-				struct list_head *list,
-				const char *sys, const char *event,
-				struct parse_events_error *error,
-				struct list_head *head_config);
 int parse_events_load_bpf(struct parse_events_state *parse_state,
 			  struct list_head *list,
 			  char *bpf_file_name,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 1e43e6839278..34915b81a7f1 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -613,8 +613,8 @@ tracepoint_name opt_event_config
 	if (error)
 		error->idx = @1.first_column;
 
-	err = parse_events_add_tracepoint(parse_state, list, $1.sys, $1.event,
-					error, $2);
+	err = parse_state->ops->add_tracepoint(parse_state, list, $1.sys, $1.event,
+					       error, $2);
 
 	parse_events_terms__delete($2);
 	free($1.sys);
-- 
2.31.1

