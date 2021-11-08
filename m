Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F5EC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C23F61503
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbhKHNmQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:42:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhKHNmP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Olyn3DwqTBCYO05KPuVzPgUrR26/xwo7zWbH83KnrI=;
        b=DqAhASE/HV1qGFujwGeMKNPocTHDyjCXZwBNbNAhD5SYer35MuIJewDgOQNoaFv0ezLLgg
        eeT8XoyFg99G4xsd18R8JCmie898Mhxg70z9SSwrqo0LAxbUPr3JnzU78tUecRzrb0zAb6
        UIw1kQh/Kpvbn/mHdD9gyB7YLpWb48k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-qGd2u_iXNrSYpfPkA747mg-1; Mon, 08 Nov 2021 08:39:27 -0500
X-MC-Unique: qGd2u_iXNrSYpfPkA747mg-1
Received: by mail-wm1-f71.google.com with SMTP id n16-20020a05600c3b9000b003331973fdbbso2772765wms.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Olyn3DwqTBCYO05KPuVzPgUrR26/xwo7zWbH83KnrI=;
        b=h4noV6o3ITdTD4/jqq5U3fSFvzE7VVNqrIjMa7Hw8MPHStYOhkSjwbp21wML3+/tpC
         gyq3BTGp6s+ktCL7ocJVk1VOnA1cv8Qm/UEjNL15yar7AsCiph1TYM7+WCpqVyeLTggf
         jOYnfED8Uwh+NYffKDDQTGUchl+Fku2rTSGDRPMoSf2lFk4lmkM0ZKJJFIcYhSp3Nm7j
         /ip+/RqJoIFjvXeyU5qZcp2JOU3SbbmiziU+i54D8Amv32veK6309HDALTMmwOfrtYB7
         3r7NJUy4GKdmn6Uz281Or5k+IdRC898yHHy4H1ljMS5Y8GI+xZWU00cDwj2lQx1/20YC
         Ko8A==
X-Gm-Message-State: AOAM532mC2TZeKSVyEUGDUuAfKO4GkDK0ri5DIRxkqhZnyMzxDE/l9l6
        aB1ecH6LWtxPW7GKf9j4NAlmp+gyb4MPosD4OtACsy8D/D6KDLf7AZCsgPLqlxhYoxYoiJSB7y1
        VAojJvuwBP9wE5CFBZAy7usbjiWAuXg==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr54211862wmk.66.1636378766682;
        Mon, 08 Nov 2021 05:39:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmaWSY95IPD2NCzW6GzSfM9S1OSlefubGbo8uNH9xssfwt0h4Q6EoRrt8L+KvEX0p08jRGew==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr54211842wmk.66.1636378766528;
        Mon, 08 Nov 2021 05:39:26 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id h15sm17610237wmq.32.2021.11.08.05.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:39:26 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 21/59] perf tools: Pass parse_state all the way down to add_tracepoint
Date:   Mon,  8 Nov 2021 14:36:32 +0100
Message-Id: <20211108133710.1352822-22-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

So we can provide event allocation callbacks.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 30 ++++++++++++++++++------------
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/parse-events.y |  2 +-
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d3ad2c89c7a2..8f8151738a78 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -595,11 +595,13 @@ static void tracepoint_error(struct parse_events_error *e, int err,
 	parse_events__handle_error(e, 0, strdup(str), strdup(help));
 }
 
-static int add_tracepoint(struct list_head *list, int *idx,
+static int add_tracepoint(struct parse_events_state *parse_state,
+			  struct list_head *list,
 			  const char *sys_name, const char *evt_name,
 			  struct parse_events_error *err,
 			  struct list_head *head_config)
 {
+	int *idx = &parse_state->idx;
 	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, (*idx)++);
 
 	if (IS_ERR(evsel)) {
@@ -619,7 +621,8 @@ static int add_tracepoint(struct list_head *list, int *idx,
 	return 0;
 }
 
-static int add_tracepoint_multi_event(struct list_head *list, int *idx,
+static int add_tracepoint_multi_event(struct parse_events_state *parse_state,
+				      struct list_head *list,
 				      const char *sys_name, const char *evt_name,
 				      struct parse_events_error *err,
 				      struct list_head *head_config)
@@ -653,7 +656,7 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 
 		found++;
 
-		ret = add_tracepoint(list, idx, sys_name, evt_ent->d_name,
+		ret = add_tracepoint(parse_state, list, sys_name, evt_ent->d_name,
 				     err, head_config);
 	}
 
@@ -667,19 +670,21 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 	return ret;
 }
 
-static int add_tracepoint_event(struct list_head *list, int *idx,
+static int add_tracepoint_event(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys_name, const char *evt_name,
 				struct parse_events_error *err,
 				struct list_head *head_config)
 {
 	return strpbrk(evt_name, "*?") ?
-	       add_tracepoint_multi_event(list, idx, sys_name, evt_name,
+	       add_tracepoint_multi_event(parse_state, list, sys_name, evt_name,
 					  err, head_config) :
-	       add_tracepoint(list, idx, sys_name, evt_name,
+	       add_tracepoint(parse_state, list, sys_name, evt_name,
 			      err, head_config);
 }
 
-static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
+static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
+				    struct list_head *list,
 				    const char *sys_name, const char *evt_name,
 				    struct parse_events_error *err,
 				    struct list_head *head_config)
@@ -705,7 +710,7 @@ static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
 		if (!strglobmatch(events_ent->d_name, sys_name))
 			continue;
 
-		ret = add_tracepoint_event(list, idx, events_ent->d_name,
+		ret = add_tracepoint_event(parse_state, list, events_ent->d_name,
 					   evt_name, err, head_config);
 	}
 
@@ -742,7 +747,7 @@ static int add_bpf_event(const char *group, const char *event, int fd, struct bp
 	pr_debug("add bpf event %s:%s and attach bpf program %d\n",
 		 group, event, fd);
 
-	err = parse_events_add_tracepoint(&new_evsels, &parse_state->idx, group,
+	err = parse_events_add_tracepoint(parse_state, &new_evsels, group,
 					  event, parse_state->error,
 					  param->head_config);
 	if (err) {
@@ -1440,7 +1445,8 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 	return 0;
 }
 
-int parse_events_add_tracepoint(struct list_head *list, int *idx,
+int parse_events_add_tracepoint(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys, const char *event,
 				struct parse_events_error *err,
 				struct list_head *head_config)
@@ -1454,10 +1460,10 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 	}
 
 	if (strpbrk(sys, "*?"))
-		return add_tracepoint_multi_sys(list, idx, sys, event,
+		return add_tracepoint_multi_sys(parse_state, list, sys, event,
 						err, head_config);
 	else
-		return add_tracepoint_event(list, idx, sys, event,
+		return add_tracepoint_event(parse_state, list, sys, event,
 					    err, head_config);
 }
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 218a282d8b3d..aedb1153a1a1 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -164,7 +164,8 @@ void parse_events__clear_array(struct parse_events_array *a);
 int parse_events__modifier_event(struct list_head *list, char *str, bool add);
 int parse_events__modifier_group(struct list_head *list, char *event_mod);
 int parse_events_name(struct list_head *list, const char *name);
-int parse_events_add_tracepoint(struct list_head *list, int *idx,
+int parse_events_add_tracepoint(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys, const char *event,
 				struct parse_events_error *error,
 				struct list_head *head_config);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 30c382d4a605..7d7bffed0dd7 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -605,7 +605,7 @@ tracepoint_name opt_event_config
 	if (error)
 		error->idx = @1.first_column;
 
-	err = parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
+	err = parse_events_add_tracepoint(parse_state, list, $1.sys, $1.event,
 					error, $2);
 
 	parse_events_terms__delete($2);
-- 
2.31.1

