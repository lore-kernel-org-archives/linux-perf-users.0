Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22AB129E7E;
	Thu,  9 May 2024 22:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715293510; cv=none; b=qDQROT3wYWWSRCyMzh3mfiEevr+u442cX7PGl3RX+oFyIwRq5CDljSNYCBAjOu9PIObE2dpYa09cb+Qd8G4SOr3uQYm2Ifi2FyGs949neQjSVQOZyucysKq8NmfNSrdEeJQ8fvOa97a3vjQxyufLomDQ4u3tx9mb7b9RAEZ7+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715293510; c=relaxed/simple;
	bh=TtfXOhFRFK5MpCzNGj3p8LCvY1TKU+bo05T1Fk+ihMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SO5qK+wdIIK9LEZtfwnHmgnunZT1+pzAx8pi1whHEXcDxbkrVRHOPE5AUWdyJOzHMije2jem5qcidlUjHtZ4w+158vCNKPsHSi2X/XAMVmVCImvjHeDa9qB7jRUCUmkr1AU18j3IrcxiNrD0qzPntQ7XLry14KsNUl2py04rXFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=IQLD2wFS; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="IQLD2wFS"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3942814C2DC;
	Fri, 10 May 2024 00:25:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1715293506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9BsOoVVLhm5a/uAQmoovTkJlw4FO44s5iAQuB67NKo=;
	b=IQLD2wFS+vll6ZhMBk1M3tOtWeO5L1mrGUv7OfFS/6iLPtNvJq/WvEAiOIqcscJZhj0jZC
	wYWMUXFQ05y8y49DdG2jifoNIr6rrB/Xb9qR+uxIgg1HdJtR2CimvaiVXuuvgfM5GUtQm7
	GlsfaqTIHQOvDlsXjQEWr4yQavseohkmJfwFrXA5AjIQpXQksRwSwEeGt0E9/Ed/SVF0Nf
	NLlgTyUHlVWDYaN8p682FcVW4iAYzN1eD8vEIVA3bT1UyAybBcNvsHV71wf5Vrfd5MhZCm
	Ksn8oWmnppW0+RhmDiVnnpmp8sIshu5k0SF8/sUW857X0uTh4QtHbG5HQsRY8Q==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 5f5fef47;
	Thu, 9 May 2024 22:24:55 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Fri, 10 May 2024 07:24:30 +0900
Subject: [PATCH v4 1/3] perf parse-events: pass parse_state to
 add_tracepoint
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-perf_digit-v4-1-db1553f3233b@codewreck.org>
References: <20240510-perf_digit-v4-0-db1553f3233b@codewreck.org>
In-Reply-To: <20240510-perf_digit-v4-0-db1553f3233b@codewreck.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev-87f09
X-Developer-Signature: v=1; a=openpgp-sha256; l=6081;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=TtfXOhFRFK5MpCzNGj3p8LCvY1TKU+bo05T1Fk+ihMI=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmPU02S5bb739jvAzqUPfXkqcqR/Us7WORNMFSv
 3a9XjgH6heJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZj1NNgAKCRCrTpvsapjm
 cFefEACD/26h758PzFpEsaTyEPs+wUOdA17linglOy+kAoAWl6G3o5MwxHYjWOHFMDQ8zj8bHcV
 gxOTMNm/+zrRDy9DqSdxnpvRh76CzNt6npDuBdBZ4UJsM+3tTKsgh8tOP6/QcXixoAD07QL2B8H
 DTT1S4cTCB3bgciOpNeLPxb3YoD0939+kwJHsH7xJm2+bVOWSjKdLw4pQ29KuDCpSoj+zP4DpeC
 MbViGX4HOzpfy9Btgam9S7uuxUcVzWVsNLKg2/ocIbSv8Nc2ilpyk6d/EPmun5x3k0jqTomCOa+
 7zUoh5TANLraHTbt+2NydhkSx6qRzo5VnMFzCH39sKz1v/jm9gEXsH9JQyjPx3i64X+x1jbBcmy
 9sxcnnu+N73H+INhkdFL9IIcs5RIIPMKfBAwS3wq0DNKdcx+i91PHnrLdATmg9YGxinmLpyt8QQ
 BADunRukdgJ3PntviTHtjeySep9E7glxkcsYQhPlcXBc4DGgWSDzUQRmGgFiG0xITebuu0KlFu6
 ZwnrYhinyL/jaOaFzTVLpBH09GGTdXWeXp/qDPgYq8FsdzdOFvLDzl0BzR0qEq/NJnetMSkjiuw
 bEQqrNKG2AwpXr1/Cy/wFazJx3+gbMuV/nh5oX6jL+sMVHgNejXBpg8Jmx/fgDcMfX8j3mDinys
 iVses50njDDr4+g==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

The next patch will add another flag to parse_state that we will want to
pass to evsel__newtp_idx(), so pass the whole parse_state all the way
down instead of giving only the index

Originally-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 tools/perf/util/parse-events.c | 31 ++++++++++++++++++-------------
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/parse-events.y |  2 +-
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2b9ede311c31..e6a2a80b02df 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -543,13 +543,14 @@ static void tracepoint_error(struct parse_events_error *e, int err,
 	parse_events_error__handle(e, column, strdup(str), strdup(help));
 }
 
-static int add_tracepoint(struct list_head *list, int *idx,
+static int add_tracepoint(struct parse_events_state *parse_state,
+			  struct list_head *list,
 			  const char *sys_name, const char *evt_name,
 			  struct parse_events_error *err,
 			  struct parse_events_terms *head_config, void *loc_)
 {
 	YYLTYPE *loc = loc_;
-	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, (*idx)++);
+	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, parse_state->idx++);
 
 	if (IS_ERR(evsel)) {
 		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name, loc->first_column);
@@ -568,7 +569,8 @@ static int add_tracepoint(struct list_head *list, int *idx,
 	return 0;
 }
 
-static int add_tracepoint_multi_event(struct list_head *list, int *idx,
+static int add_tracepoint_multi_event(struct parse_events_state *parse_state,
+				      struct list_head *list,
 				      const char *sys_name, const char *evt_name,
 				      struct parse_events_error *err,
 				      struct parse_events_terms *head_config, YYLTYPE *loc)
@@ -602,7 +604,7 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 
 		found++;
 
-		ret = add_tracepoint(list, idx, sys_name, evt_ent->d_name,
+		ret = add_tracepoint(parse_state, list, sys_name, evt_ent->d_name,
 				     err, head_config, loc);
 	}
 
@@ -616,19 +618,21 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 	return ret;
 }
 
-static int add_tracepoint_event(struct list_head *list, int *idx,
+static int add_tracepoint_event(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys_name, const char *evt_name,
 				struct parse_events_error *err,
 				struct parse_events_terms *head_config, YYLTYPE *loc)
 {
 	return strpbrk(evt_name, "*?") ?
-		add_tracepoint_multi_event(list, idx, sys_name, evt_name,
+		add_tracepoint_multi_event(parse_state, list, sys_name, evt_name,
 					   err, head_config, loc) :
-		add_tracepoint(list, idx, sys_name, evt_name,
+		add_tracepoint(parse_state, list, sys_name, evt_name,
 			       err, head_config, loc);
 }
 
-static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
+static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
+				    struct list_head *list,
 				    const char *sys_name, const char *evt_name,
 				    struct parse_events_error *err,
 				    struct parse_events_terms *head_config, YYLTYPE *loc)
@@ -654,7 +658,7 @@ static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
 		if (!strglobmatch(events_ent->d_name, sys_name))
 			continue;
 
-		ret = add_tracepoint_event(list, idx, events_ent->d_name,
+		ret = add_tracepoint_event(parse_state, list, events_ent->d_name,
 					   evt_name, err, head_config, loc);
 	}
 
@@ -1291,7 +1295,8 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 	return 0;
 }
 
-int parse_events_add_tracepoint(struct list_head *list, int *idx,
+int parse_events_add_tracepoint(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys, const char *event,
 				struct parse_events_error *err,
 				struct parse_events_terms *head_config, void *loc_)
@@ -1307,14 +1312,14 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 	}
 
 	if (strpbrk(sys, "*?"))
-		return add_tracepoint_multi_sys(list, idx, sys, event,
+		return add_tracepoint_multi_sys(parse_state, list, sys, event,
 						err, head_config, loc);
 	else
-		return add_tracepoint_event(list, idx, sys, event,
+		return add_tracepoint_event(parse_state, list, sys, event,
 					    err, head_config, loc);
 #else
+	(void)parse_state;
 	(void)list;
-	(void)idx;
 	(void)sys;
 	(void)event;
 	(void)head_config;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e7ac1f13376d..c06984bd3af8 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -208,7 +208,8 @@ int parse_events__modifier_event(struct parse_events_state *parse_state, void *l
 int parse_events__modifier_group(struct parse_events_state *parse_state, void *loc,
 				 struct list_head *list, struct parse_events_modifier mod);
 int parse_events__set_default_name(struct list_head *list, char *name);
-int parse_events_add_tracepoint(struct list_head *list, int *idx,
+int parse_events_add_tracepoint(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys, const char *event,
 				struct parse_events_error *error,
 				struct parse_events_terms *head_config, void *loc);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 68b3b06c7ff0..c94a3994177e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -497,7 +497,7 @@ tracepoint_name opt_event_config
 	if (!list)
 		YYNOMEM;
 
-	err = parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
+	err = parse_events_add_tracepoint(parse_state, list, $1.sys, $1.event,
 					error, $2, &@1);
 
 	parse_events_terms__delete($2);

-- 
2.44.0

