Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F227E383A2
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163012; cv=none; b=su+0Dh1go+N3FImgbhCWxPnHNpOeb9oU7VKDW5/6d2I4Ks8dRHv6DNIQrbBIgWApzdi26kFAUpR3gbGj7K9kCuz8UjgHGpJ0v0VJpXpz5HDieDgyUWky7stjoU3hRPEN0TseBeJqS1fxf7VevRkcrNJ5GaN/Tr8avCc1mEEfRV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163012; c=relaxed/simple;
	bh=YnUF3ceBTuEWLeyH8vOqzQm1Yqq/JnFb2jhfnx6s9QU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eAzVDG5SknwDqBbJL6IRwmUMlQLyiDT8SAc5knxr29yxT22ZF8s+QD0dE2xkpnyQQMIGD9JJkIh2WJYAPav9S7vAyvucUOMZZOP9VQzkoRHxyRPZGaWNi3WBGkxGoPqEgdjzPauwA5iUD4SPBhxkQXlXxOftut1AihpHhD6FvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LE1BPs3L; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LE1BPs3L"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso4758327276.3
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Apr 2024 23:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713163010; x=1713767810; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SsM8Y1cj6kmrsHpwiXYtXKur/DOQuLkG4gE86ZL8CEk=;
        b=LE1BPs3LcUYqEEl7YNf0MJSUzYbOnMtITFXjBs0w/nJE4yjQuInhXMvMerZjwquSkA
         NzX3yJwHs29EN8taGYBGLrELzTH0Kf15s2wO96zuSMMbOkZESkJyFV8rx+WaahyXYT4s
         nSqAyZySXkYbvjHkSQ+gcej82kbT3h88QPEtmqa0ymaaBLXCAfgkyD66Y/2rjcB+wI1W
         GBCHKu5luo+nuIw61j6J1P9AeKWcgR8x2AhYaUjKBxbr7YvL1GiW9Uw6pYMUzhX0OSOW
         47XT7fDOJ0BB1EniV6eEEGXl6KnDp8oZwL8qBXdwfA77OKE4R007+Bs6HFyPwcAjHOnf
         CCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163010; x=1713767810;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsM8Y1cj6kmrsHpwiXYtXKur/DOQuLkG4gE86ZL8CEk=;
        b=Cp/RJUVpcOLlG4NRs3ygGq69FcAVL5leoSS8Zumryeogf4Yiv6dAwXXKfhQZt6JR25
         vIuyFIL28+zubKUZRPrDW+ba0D3KbR3JkKvbqd3yaPd+IJajNg2vHfC/tS+t1g2bfniC
         QLXt1galOydl/WqGHqRBYat9Y/FKzSi7zxAR1U5SbNmWI84vw3W5Yp5ho1OcIqpmORJd
         6eBILM1NjHpR38PlUbe+3ovOJ80R6LxBHenQ9VnmNO++JiI42aatNJ4wlUnxF8HrPzX/
         eOarzq/Z9z/zJjtLD/H83t/81aHpkZbvociXw0GujgJflhJDvQxSZPUr1XoMrGCOUk0L
         uThg==
X-Forwarded-Encrypted: i=1; AJvYcCXw3Wlt+HsuAc9GHUULKE5SMAYr8T8C/6VtMyQhfSr8y6xebEfs8BQvDwgRh1uO0N9IvfsVvKGQCe2I7Z7CZucg3b6euqe5pv5Ona78JrYkJA==
X-Gm-Message-State: AOJu0Ywc0YLehVfUe7cj/U4Gd8JARGfdu79YfEoh0zucDwhlWI24WEzK
	CWSVJSFLcQoAyWTAXAm4a4/n1XXNpL1kq5HtrXycnkMFebjUd/9GumwEpiIQ4sGHZlPvV4aWG4e
	XrGbUkw==
X-Google-Smtp-Source: AGHT+IGgmCtdEtZrTu/VTbHRcGxy01TSWSnKf6exxI0DVUKXLBA7LgeFtUQlO61tu+Bc2rAGxXCSISNxPEr+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a05:6902:1549:b0:dc6:dfd9:d431 with SMTP
 id r9-20020a056902154900b00dc6dfd9d431mr2983582ybu.1.1713163009901; Sun, 14
 Apr 2024 23:36:49 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:25 -0700
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
Message-Id: <20240415063626.453987-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 8/9] perf parse-events: Constify parse_events_add_numeric
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Allow the term list to be const so that other functions can pass const
term lists. Add const as necessary to called functions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 20 +++++++++++---------
 tools/perf/util/parse-events.h |  2 +-
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f711ad9b18f0..50c4012c737e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -34,7 +34,8 @@
 #ifdef PARSER_DEBUG
 extern int parse_events_debug;
 #endif
-static int get_config_terms(struct parse_events_terms *head_config, struct list_head *head_terms);
+static int get_config_terms(const struct parse_events_terms *head_config,
+			    struct list_head *head_terms);
 static int parse_events_terms__copy(const struct parse_events_terms *src,
 				    struct parse_events_terms *dest);
 
@@ -154,7 +155,7 @@ const char *event_type(int type)
 	return "unknown";
 }
 
-static char *get_config_str(struct parse_events_terms *head_terms,
+static char *get_config_str(const struct parse_events_terms *head_terms,
 			    enum parse_events__term_type type_term)
 {
 	struct parse_events_term *term;
@@ -169,12 +170,12 @@ static char *get_config_str(struct parse_events_terms *head_terms,
 	return NULL;
 }
 
-static char *get_config_metric_id(struct parse_events_terms *head_terms)
+static char *get_config_metric_id(const struct parse_events_terms *head_terms)
 {
 	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_METRIC_ID);
 }
 
-static char *get_config_name(struct parse_events_terms *head_terms)
+static char *get_config_name(const struct parse_events_terms *head_terms)
 {
 	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_NAME);
 }
@@ -358,7 +359,7 @@ static int config_term_common(struct perf_event_attr *attr,
 			      struct parse_events_term *term,
 			      struct parse_events_error *err);
 static int config_attr(struct perf_event_attr *attr,
-		       struct parse_events_terms *head,
+		       const struct parse_events_terms *head,
 		       struct parse_events_error *err,
 		       config_term_func_t config_term);
 
@@ -1107,7 +1108,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 #endif
 
 static int config_attr(struct perf_event_attr *attr,
-		       struct parse_events_terms *head,
+		       const struct parse_events_terms *head,
 		       struct parse_events_error *err,
 		       config_term_func_t config_term)
 {
@@ -1120,7 +1121,8 @@ static int config_attr(struct perf_event_attr *attr,
 	return 0;
 }
 
-static int get_config_terms(struct parse_events_terms *head_config, struct list_head *head_terms)
+static int get_config_terms(const struct parse_events_terms *head_config,
+			    struct list_head *head_terms)
 {
 #define ADD_CONFIG_TERM(__type, __weak)				\
 	struct evsel_config_term *__t;			\
@@ -1324,7 +1326,7 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 				struct list_head *list,
 				struct perf_pmu *pmu, u32 type, u32 extended_type,
-				u64 config, struct parse_events_terms *head_config)
+				u64 config, const struct parse_events_terms *head_config)
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
@@ -1360,7 +1362,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     struct list_head *list,
 			     u32 type, u64 config,
-			     struct parse_events_terms *head_config,
+			     const struct parse_events_terms *head_config,
 			     bool wildcard)
 {
 	struct perf_pmu *pmu = NULL;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index db47913e54bc..5005782766e9 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -196,7 +196,7 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     struct list_head *list,
 			     u32 type, u64 config,
-			     struct parse_events_terms *head_config,
+			     const struct parse_events_terms *head_config,
 			     bool wildcard);
 int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
-- 
2.44.0.683.g7961c838ac-goog

