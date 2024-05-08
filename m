Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2C4748F;
	Wed,  8 May 2024 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715209283; cv=none; b=ue3ROct4Ju/q0fGUD8/l69VN0Al+rs9E4zLWSJ/PjjNAfpB7O1p21S7mULHOViqm47fjG1saUqqnpkwYPFZd+hCfi4hSWb9ly8n/QVquL05Z3woEWrM5oyL1tGPAsitc2B5wn60OdDdCWEjCKvkesJFrNw9rMWQ56XFNM2qCgyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715209283; c=relaxed/simple;
	bh=TtfXOhFRFK5MpCzNGj3p8LCvY1TKU+bo05T1Fk+ihMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sXV3sR0YrELFvEpYidaim9oVeM6Z7kvq3RGYK9g4gNwiKGTrz9muNsftHOY9WKQwz4VUYK2HkKXhfEA1J2xQxNSqhLI4tufsehwDH2UzgCEWmfOYMjlM6d5J8epvdqybKYEA9oTMKL/dB72R4d73bCIRDGGFLaFOZSWVasJQ3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=uOlade78; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="uOlade78"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id B91C814C2DB;
	Thu,  9 May 2024 01:01:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1715209275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9BsOoVVLhm5a/uAQmoovTkJlw4FO44s5iAQuB67NKo=;
	b=uOlade78pz7hJk5W6eH1odKzmdfCvgTPdqj1hp/1rBsQdO6FuVWwpsIO5YT/ekcwIUsFt4
	aZmw4POXLysRLLt0Ifk15ZP9fXbBNy2dAtMFDGvmjC7fN/SoWkgVl+iBtHyuDUDP7bePpn
	E1jWLYDn/0JR255ChxGkdCrBNj/tXkwcyf4lxY1YSrIS7MJjVg9PDfuR1aewp+NfLaBE65
	rmublOpXLJo5GkMSEMu8//pfPu6ywA5C2aIvgOo3ipj5E46t6HSc1eZLlVvfrj1F6earXK
	2Zs+21PU6mK+jQhGKH/1afrYR9SGuH2Fv2Zm6btijSm03Ue3dvtYrcZC/BGZew==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id e574cfbc;
	Wed, 8 May 2024 23:01:02 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Thu, 09 May 2024 08:00:45 +0900
Subject: [PATCH v3 1/3] perf parse-events: pass parse_state to
 add_tracepoint
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-perf_digit-v3-1-9036bf7898da@codewreck.org>
References: <20240509-perf_digit-v3-0-9036bf7898da@codewreck.org>
In-Reply-To: <20240509-perf_digit-v3-0-9036bf7898da@codewreck.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6081;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=TtfXOhFRFK5MpCzNGj3p8LCvY1TKU+bo05T1Fk+ihMI=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmPAQulnlzma4cAGBkIaxu0lZ0oXgHKD5yWgcdo
 ACCNRoC0h2JAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZjwELgAKCRCrTpvsapjm
 cHA4D/9neBqDSZRcZm1eGochwXnzHx2Et7h7stypOKj3zEQjj51tXgR16NQLWfY46RlpQJJA7WD
 ld0wkUD5vgAaVEdYSNybInc+1XKdn0Mo3mBcMlHXZet944Ugv4245DWWcmybcEdOHd5KUMejMVk
 Z7Paqme5poIIpx+Ld+/AoSVrc6/YpXMOf+Mi5VyLcPsejRQwjF2QpqeTP4RSnxLuWtsWmnWgxQ8
 DJV+HAquYeI+7QqlM6ybDSRNSsPdicp89zhleb810XZHoh5lI7W+N0O2rlmJ3VHIYXdKr5QyjaQ
 K/lb4zRo6u5A+bvThjoojS+6z+d2Tef2NUMLdaWG4egR5uxYObNdFfJWXcNrt7E96cS7ltR6VKb
 avkzjqbuhNTd4u/uD2e6rN/Y143F9RjBLMqLtcKMKXrfYaGzw3nXMjVsbueTlaM65UhOpyMkeVN
 lvUyixaa5lAVQaMpb1a74oK8siwJtAq7mCHIZFucdYoCP9vvW2mAC8QVCNKQZ6KBxCczIMD7xwd
 SnJswk/2qwtOs/nyu9EcgOVwOsPUL1e5HMG3B42zsfzP1FmO14DWkY6O1i5BNUC49Y3h2GE7Odh
 ZCgMa50n701Zz7xJ3X59PAGpnhqdrOk6r/hKObK62flAKAU8Quzf/9wkx59z5j9UKDooEux4usU
 VaK/il9S7oAjA+A==
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

