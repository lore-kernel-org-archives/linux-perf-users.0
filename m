Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00DCC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54FC61458
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbhKHNnz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:43:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237467AbhKHNny (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JdH1psn2EUb50HCdB/D90iJtxa5znCIqlID/ZPVkLDE=;
        b=eahVSvDWz49gzkEwdGpFxrvPGTkcVaHMyVNwyFIkZMTX+r5rUDSc/ondCQGZaDj/fcPP2m
        zRWzLXrWU1fQn4nXEA8tnSbqrILSElDnjXvUqcdTp1ehFiBeAHf8DcNlZ4BK9ldkbLoJPZ
        zxsKb5D0Yh2fsB/mj1mVSOpaB+V0FsY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-Z-VxnWitMlKylKGdahseMw-1; Mon, 08 Nov 2021 08:41:08 -0500
X-MC-Unique: Z-VxnWitMlKylKGdahseMw-1
Received: by mail-wm1-f70.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso10156031wme.8
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdH1psn2EUb50HCdB/D90iJtxa5znCIqlID/ZPVkLDE=;
        b=wHfBoM72aC2GD/89zMInXD3symdvJQ6gwFTWQQgbRewp9nxgtpPCVIfh9iEtWvG2Om
         NpsX+HSa223Ou368VKy/FSejk++LkWdQOY3RXd4N+dW4OFouWeXOTFNeVolHkiZ34y+b
         WGUbAbC4BUp11Cmhyvw9DfrNhnmeY81ZZa3qymd2Lg8E4SgzirZlR2+w9AMqdrLJR0xm
         7BeQmgisFaC9If6fXLQ4flycNi/fGz+M1teYizv5Nuf5eD4b8YLwq7xJ11F0UgrGQD9T
         Zp2vHhui31lQPEtcTNGmmjLZggdiJipaSelhpjUc6nkAGb78okTktjvUJUg+zOYfgTKU
         +Y9w==
X-Gm-Message-State: AOAM530TBEc8ep8m0pl+D8RcbpZWlLkDgpxFziEt9UgtwitTNPxEZKz5
        ziR5YSLJ+NqtyD26kywniBDqrw0+sivghs+ipoDk2Iov80w8dZGfCCh2wdrh87c4Z5dcZ3b/REU
        LOCTLYDvgoNn85wza2cIU8vqcFXm9Pw==
X-Received: by 2002:a5d:6d86:: with SMTP id l6mr59798260wrs.304.1636378867058;
        Mon, 08 Nov 2021 05:41:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyK8PUAJOe3IJOam50uR+AEsioG+hbHUD6LImaLvMsy2X8MSIMw3EKrlaEFFCYjCYTUntlliw==
X-Received: by 2002:a5d:6d86:: with SMTP id l6mr59798235wrs.304.1636378866842;
        Mon, 08 Nov 2021 05:41:06 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id n7sm16635072wra.37.2021.11.08.05.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:41:06 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 38/59] libperf: Move in parse_events__modifier_group/event functions
Date:   Mon,  8 Nov 2021 14:36:49 +0100
Message-Id: <20211108133710.1352822-39-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving parse_events__modifier_group/event functions to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../lib/perf/include/internal/parse-events.h  |   2 +
 tools/lib/perf/parse-events.c                 | 187 ++++++++++++++++++
 tools/perf/util/parse-events.c                | 186 -----------------
 tools/perf/util/parse-events.h                |   2 -
 4 files changed, 189 insertions(+), 188 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index e4b136a58484..88195ae2eb10 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -130,4 +130,6 @@ perf_evsel__add_event(struct parse_events_state *parse_state,
 		      const char *name, const char *metric_id, struct perf_pmu *pmu,
 		      struct list_head *config_terms, bool auto_merge_stats,
 		      const char *cpu_list);
+int parse_events__modifier_event(struct list_head *list, char *str, bool add, bool guest);
+int parse_events__modifier_group(struct list_head *list, char *event_mod, bool guest);
 #endif /* __LIBPERF_PARSE_EVENTS_H */
diff --git a/tools/lib/perf/parse-events.c b/tools/lib/perf/parse-events.c
index 6d840764c84d..3b93528f4569 100644
--- a/tools/lib/perf/parse-events.c
+++ b/tools/lib/perf/parse-events.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <internal/parse-events.h>
 #include <internal/pmu.h>
+#include <internal/evlist.h>
 #include <internal/evsel.h>
 #include <perf/cpumap.h>
 #include <stdlib.h>
@@ -349,3 +350,189 @@ perf_evsel__add_event(struct parse_events_state *parse_state,
 
 	return evsel;
 }
+
+struct event_modifier {
+	int eu;
+	int ek;
+	int eh;
+	int eH;
+	int eG;
+	int eI;
+	int precise;
+	int precise_max;
+	int exclude_GH;
+	int sample_read;
+	int pinned;
+	int weak;
+	int exclusive;
+	int bpf_counter;
+};
+
+static int get_event_modifier(struct event_modifier *mod, char *str,
+			       struct perf_evsel *evsel, bool guest)
+{
+	int eu = evsel ? evsel->attr.exclude_user : 0;
+	int ek = evsel ? evsel->attr.exclude_kernel : 0;
+	int eh = evsel ? evsel->attr.exclude_hv : 0;
+	int eH = evsel ? evsel->attr.exclude_host : 0;
+	int eG = evsel ? evsel->attr.exclude_guest : 0;
+	int eI = evsel ? evsel->attr.exclude_idle : 0;
+	int precise = evsel ? evsel->attr.precise_ip : 0;
+	int precise_max = 0;
+	int sample_read = 0;
+	int pinned = evsel ? evsel->attr.pinned : 0;
+	int exclusive = evsel ? evsel->attr.exclusive : 0;
+
+	int exclude = eu | ek | eh;
+	int exclude_GH = evsel ? evsel->exclude_GH : 0;
+	int weak = 0;
+	int bpf_counter = 0;
+
+	memset(mod, 0, sizeof(*mod));
+
+	while (*str) {
+		if (*str == 'u') {
+			if (!exclude)
+				exclude = eu = ek = eh = 1;
+			if (!exclude_GH && !guest)
+				eG = 1;
+			eu = 0;
+		} else if (*str == 'k') {
+			if (!exclude)
+				exclude = eu = ek = eh = 1;
+			ek = 0;
+		} else if (*str == 'h') {
+			if (!exclude)
+				exclude = eu = ek = eh = 1;
+			eh = 0;
+		} else if (*str == 'G') {
+			if (!exclude_GH)
+				exclude_GH = eG = eH = 1;
+			eG = 0;
+		} else if (*str == 'H') {
+			if (!exclude_GH)
+				exclude_GH = eG = eH = 1;
+			eH = 0;
+		} else if (*str == 'I') {
+			eI = 1;
+		} else if (*str == 'p') {
+			precise++;
+			/* use of precise requires exclude_guest */
+			if (!exclude_GH)
+				eG = 1;
+		} else if (*str == 'P') {
+			precise_max = 1;
+		} else if (*str == 'S') {
+			sample_read = 1;
+		} else if (*str == 'D') {
+			pinned = 1;
+		} else if (*str == 'e') {
+			exclusive = 1;
+		} else if (*str == 'W') {
+			weak = 1;
+		} else if (*str == 'b') {
+			bpf_counter = 1;
+		} else
+			break;
+
+		++str;
+	}
+
+	/*
+	 * precise ip:
+	 *
+	 *  0 - SAMPLE_IP can have arbitrary skid
+	 *  1 - SAMPLE_IP must have constant skid
+	 *  2 - SAMPLE_IP requested to have 0 skid
+	 *  3 - SAMPLE_IP must have 0 skid
+	 *
+	 *  See also PERF_RECORD_MISC_EXACT_IP
+	 */
+	if (precise > 3)
+		return -EINVAL;
+
+	mod->eu = eu;
+	mod->ek = ek;
+	mod->eh = eh;
+	mod->eH = eH;
+	mod->eG = eG;
+	mod->eI = eI;
+	mod->precise = precise;
+	mod->precise_max = precise_max;
+	mod->exclude_GH = exclude_GH;
+	mod->sample_read = sample_read;
+	mod->pinned = pinned;
+	mod->weak = weak;
+	mod->bpf_counter = bpf_counter;
+	mod->exclusive = exclusive;
+
+	return 0;
+}
+
+/*
+ * Basic modifier sanity check to validate it contains only one
+ * instance of any modifier (apart from 'p') present.
+ */
+static int check_modifier(char *str)
+{
+	char *p = str;
+
+	/* The sizeof includes 0 byte as well. */
+	if (strlen(str) > (sizeof("ukhGHpppPSDIWeb") - 1))
+		return -1;
+
+	while (*p) {
+		if (*p != 'p' && strchr(p + 1, *p))
+			return -1;
+		p++;
+	}
+
+	return 0;
+}
+
+int parse_events__modifier_event(struct list_head *list, char *str,
+				 bool add, bool guest)
+{
+	struct perf_evsel *evsel;
+	struct event_modifier mod;
+
+	if (str == NULL)
+		return 0;
+
+	if (check_modifier(str))
+		return -EINVAL;
+
+	if (!add && get_event_modifier(&mod, str, NULL, guest))
+		return -EINVAL;
+
+	__perf_evlist__for_each_entry(list, evsel) {
+		if (add && get_event_modifier(&mod, str, evsel, guest))
+			return -EINVAL;
+
+		evsel->attr.exclude_user   = mod.eu;
+		evsel->attr.exclude_kernel = mod.ek;
+		evsel->attr.exclude_hv     = mod.eh;
+		evsel->attr.precise_ip     = mod.precise;
+		evsel->attr.exclude_host   = mod.eH;
+		evsel->attr.exclude_guest  = mod.eG;
+		evsel->attr.exclude_idle   = mod.eI;
+		evsel->exclude_GH          = mod.exclude_GH;
+		evsel->sample_read         = mod.sample_read;
+		evsel->precise_max         = mod.precise_max;
+		evsel->weak_group          = mod.weak;
+		evsel->bpf_counter         = mod.bpf_counter;
+
+		if (perf_evsel__is_group_leader(evsel)) {
+			evsel->attr.pinned = mod.pinned;
+			evsel->attr.exclusive = mod.exclusive;
+		}
+	}
+
+	return 0;
+}
+
+int parse_events__modifier_group(struct list_head *list,
+				 char *event_mod, bool guest)
+{
+	return parse_events__modifier_event(list, event_mod, true, guest);
+}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e10f6476854f..ecbb7f284158 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1617,12 +1617,6 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	return ok ? 0 : -1;
 }
 
-int parse_events__modifier_group(struct list_head *list,
-				 char *event_mod, bool guest)
-{
-	return parse_events__modifier_event(list, event_mod, true, guest);
-}
-
 /*
  * Check if the two uncore PMUs are from the same uncore block
  * The format of the uncore PMU name is uncore_#blockname_#pmuidx
@@ -1752,186 +1746,6 @@ void parse_events__set_leader(char *name, struct list_head *list,
 	leader->core.group_name = name ? strdup(name) : NULL;
 }
 
-struct event_modifier {
-	int eu;
-	int ek;
-	int eh;
-	int eH;
-	int eG;
-	int eI;
-	int precise;
-	int precise_max;
-	int exclude_GH;
-	int sample_read;
-	int pinned;
-	int weak;
-	int exclusive;
-	int bpf_counter;
-};
-
-static int get_event_modifier(struct event_modifier *mod, char *str,
-			       struct perf_evsel *evsel, bool guest)
-{
-	int eu = evsel ? evsel->attr.exclude_user : 0;
-	int ek = evsel ? evsel->attr.exclude_kernel : 0;
-	int eh = evsel ? evsel->attr.exclude_hv : 0;
-	int eH = evsel ? evsel->attr.exclude_host : 0;
-	int eG = evsel ? evsel->attr.exclude_guest : 0;
-	int eI = evsel ? evsel->attr.exclude_idle : 0;
-	int precise = evsel ? evsel->attr.precise_ip : 0;
-	int precise_max = 0;
-	int sample_read = 0;
-	int pinned = evsel ? evsel->attr.pinned : 0;
-	int exclusive = evsel ? evsel->attr.exclusive : 0;
-
-	int exclude = eu | ek | eh;
-	int exclude_GH = evsel ? evsel->exclude_GH : 0;
-	int weak = 0;
-	int bpf_counter = 0;
-
-	memset(mod, 0, sizeof(*mod));
-
-	while (*str) {
-		if (*str == 'u') {
-			if (!exclude)
-				exclude = eu = ek = eh = 1;
-			if (!exclude_GH && !guest)
-				eG = 1;
-			eu = 0;
-		} else if (*str == 'k') {
-			if (!exclude)
-				exclude = eu = ek = eh = 1;
-			ek = 0;
-		} else if (*str == 'h') {
-			if (!exclude)
-				exclude = eu = ek = eh = 1;
-			eh = 0;
-		} else if (*str == 'G') {
-			if (!exclude_GH)
-				exclude_GH = eG = eH = 1;
-			eG = 0;
-		} else if (*str == 'H') {
-			if (!exclude_GH)
-				exclude_GH = eG = eH = 1;
-			eH = 0;
-		} else if (*str == 'I') {
-			eI = 1;
-		} else if (*str == 'p') {
-			precise++;
-			/* use of precise requires exclude_guest */
-			if (!exclude_GH)
-				eG = 1;
-		} else if (*str == 'P') {
-			precise_max = 1;
-		} else if (*str == 'S') {
-			sample_read = 1;
-		} else if (*str == 'D') {
-			pinned = 1;
-		} else if (*str == 'e') {
-			exclusive = 1;
-		} else if (*str == 'W') {
-			weak = 1;
-		} else if (*str == 'b') {
-			bpf_counter = 1;
-		} else
-			break;
-
-		++str;
-	}
-
-	/*
-	 * precise ip:
-	 *
-	 *  0 - SAMPLE_IP can have arbitrary skid
-	 *  1 - SAMPLE_IP must have constant skid
-	 *  2 - SAMPLE_IP requested to have 0 skid
-	 *  3 - SAMPLE_IP must have 0 skid
-	 *
-	 *  See also PERF_RECORD_MISC_EXACT_IP
-	 */
-	if (precise > 3)
-		return -EINVAL;
-
-	mod->eu = eu;
-	mod->ek = ek;
-	mod->eh = eh;
-	mod->eH = eH;
-	mod->eG = eG;
-	mod->eI = eI;
-	mod->precise = precise;
-	mod->precise_max = precise_max;
-	mod->exclude_GH = exclude_GH;
-	mod->sample_read = sample_read;
-	mod->pinned = pinned;
-	mod->weak = weak;
-	mod->bpf_counter = bpf_counter;
-	mod->exclusive = exclusive;
-
-	return 0;
-}
-
-/*
- * Basic modifier sanity check to validate it contains only one
- * instance of any modifier (apart from 'p') present.
- */
-static int check_modifier(char *str)
-{
-	char *p = str;
-
-	/* The sizeof includes 0 byte as well. */
-	if (strlen(str) > (sizeof("ukhGHpppPSDIWeb") - 1))
-		return -1;
-
-	while (*p) {
-		if (*p != 'p' && strchr(p + 1, *p))
-			return -1;
-		p++;
-	}
-
-	return 0;
-}
-
-int parse_events__modifier_event(struct list_head *list, char *str,
-				 bool add, bool guest)
-{
-	struct perf_evsel *evsel;
-	struct event_modifier mod;
-
-	if (str == NULL)
-		return 0;
-
-	if (check_modifier(str))
-		return -EINVAL;
-
-	if (!add && get_event_modifier(&mod, str, NULL, guest))
-		return -EINVAL;
-
-	__perf_evlist__for_each_entry(list, evsel) {
-		if (add && get_event_modifier(&mod, str, evsel, guest))
-			return -EINVAL;
-
-		evsel->attr.exclude_user   = mod.eu;
-		evsel->attr.exclude_kernel = mod.ek;
-		evsel->attr.exclude_hv     = mod.eh;
-		evsel->attr.precise_ip     = mod.precise;
-		evsel->attr.exclude_host   = mod.eH;
-		evsel->attr.exclude_guest  = mod.eG;
-		evsel->attr.exclude_idle   = mod.eI;
-		evsel->exclude_GH          = mod.exclude_GH;
-		evsel->sample_read         = mod.sample_read;
-		evsel->precise_max         = mod.precise_max;
-		evsel->weak_group          = mod.weak;
-		evsel->bpf_counter         = mod.bpf_counter;
-
-		if (perf_evsel__is_group_leader(evsel)) {
-			evsel->attr.pinned = mod.pinned;
-			evsel->attr.exclusive = mod.exclusive;
-		}
-	}
-
-	return 0;
-}
-
 int parse_events_name(struct list_head *list, const char *name)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 599ee3a760d7..78a8fa799b09 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -65,8 +65,6 @@ void parse_events__handle_error(struct parse_events_error *err, int idx,
 				char *str, char *help);
 void parse_events__shrink_config_terms(void);
 void parse_events__clear_array(struct parse_events_array *a);
-int parse_events__modifier_event(struct list_head *list, char *str, bool add, bool guest);
-int parse_events__modifier_group(struct list_head *list, char *event_mod, bool guest);
 int parse_events_name(struct list_head *list, const char *name);
 int parse_events_add_tracepoint(struct parse_events_state *parse_state,
 				struct list_head *list,
-- 
2.31.1

