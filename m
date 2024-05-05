Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E01114A96;
	Sun,  5 May 2024 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714907672; cv=none; b=hg0VTWRbJBDOX/8ab2+GmPsnh50NU3hz87jQDCBQg5AY7K2FPeQsvgYn6n/rPOHaPCDGSJiNiESSuU8Fdj2YyP3QUP9OGCtz4+AzubuwPVp5ZRITXguP60oVvklC+ZSzyluOkv9yt6dDuLvnkYSQYopbz6lseUQhALQyIRppRqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714907672; c=relaxed/simple;
	bh=gXJdObYymSv+xu5zY8dz7G2l4mbXEFOwz6QHuVB14dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IfUkZFInjFQyQ0zS5EUtYzlcSQui4IrJ3dnBfloqdKiqwSWbuXBiQ8+V4y1V0SK0KEyI8htd6ap9jxbZdFBVzvzhpeTI8TqHO5Y6QVpsiiIrzOdDv30cbKN/Y7XIdqI5IPEJNhVjWgcz4u/OshDbiusXojEFDBjKRDpnqKAWUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=zY1DDpmt; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="zY1DDpmt"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 74B6014C2DC;
	Sun,  5 May 2024 13:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1714907663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9IsIqe9yWCkF+5W0tmJJpm3iiYQWxxVo7wE2Yz9kF0=;
	b=zY1DDpmtB/4s5mSi/E4q6RjnGSGugZCcrHNgT0AZMwQ/lfPWjnih1WOqLxdM1XAa9WjEnK
	UMv/uVvzNSYzFII/PF2iss0X8eeRZuVK+/MvSkv/D+8LMoO9mr+vfiulKKBnYxqusFmajq
	NXfTVNhyluMY3qHuGPDNtJwfQuyRIVL67fig4QVjPr2AoORS40H/5+AHz6E6DfAtDgNY1S
	NmoSFoTQNNy6WMkiPhIsx+DOzQmHpmVAoZnYnIm/uZEkGrihweuxnnhyqYeotmgIqffjEX
	SRSCCSaoTc6FnaLUhJFwGQrFWHGh3tFg2TAdc7fNpQjcVxZ3dFt49yzvsTNNYg==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id ed3b291f;
	Sun, 5 May 2024 11:14:12 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Sun, 05 May 2024 20:13:57 +0900
Subject: [PATCH v2 1/3] perf parse-events: pass parse_state to
 add_tracepoint
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240505-perf_digit-v2-1-6ece307fdaad@codewreck.org>
References: <20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org>
In-Reply-To: <20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6034;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=gXJdObYymSv+xu5zY8dz7G2l4mbXEFOwz6QHuVB14dg=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmN2oDqD59jkZvW5G/2dikehsD4v0MNEgObfnuZ
 sFtJBti/MKJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZjdqAwAKCRCrTpvsapjm
 cMYHD/9NltkR4wwvRVz8vJL7hLdW9/u6MWfGtQhY5n5D2ezJ+kF54wDVt/Rk3otB7V5fawH54Rp
 xAive80s/ED9Tchw2RTrKcuJDUZMlbE1UdCV/sfNJnXx+YZRwX/4e865+2ZRSH7gC4t47CR8HSl
 1U4JJ7tNxR6Jf1V4g2wJ4s298aemo2TNwJIPrDWYOnhUrnOds/FINurhd23UkOfOV5QpXOnpNTX
 JrOhZ5NmKMY+KE1eWu4G1nF5fwojqCAsA/4uIpMk4RfllGpGWWAwnBi91eYsNtyXV7VU4FpLmB7
 n5+2+5SGWngylaKQilI1geKlnzL5UxBVLoBqUqCu5pVZY/zjSguMzbSl4AghengikNYzog88XuN
 jvvss+Br9u0dn7wCRiSKd1eAXhiGDdSBKEqwX/pZnEIjXBK8Q2ptqOF6BEYlCOFM8AACHJV6Fwk
 BvFM6KeHq8wIWadDkcllVgc3hMiNCaAMw7o/tyx6r8X8sW7mO8+b/JZuNkxwfuHW8c4sQXMQady
 vvL8msEo8hQY+WSIE8qb7f1fGe8vtD/jCvgMa5VkGLKEnvgHzypGZib/1jgAMijj6VMW5EaeAri
 6QETa/0Zdc/K00fjr6W1Lq/aqxhG3x7WFlyNiTTiKd31imHkNPf0KIy1WVOQXLzSQLMEM3uRwYn
 bRahdOQ/JUC/eGA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

The next patch will add another flag to parse_state that we will want to
pass to evsel__nwetp_idx(), so pass the whole parse_state all the way
down instead of giving only the index

Originally-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 tools/perf/util/parse-events.c | 31 ++++++++++++++++++-------------
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/parse-events.y |  2 +-
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6f8b0fa17689..6e8cba03f0ac 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -519,13 +519,14 @@ static void tracepoint_error(struct parse_events_error *e, int err,
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
@@ -544,7 +545,8 @@ static int add_tracepoint(struct list_head *list, int *idx,
 	return 0;
 }
 
-static int add_tracepoint_multi_event(struct list_head *list, int *idx,
+static int add_tracepoint_multi_event(struct parse_events_state *parse_state,
+				      struct list_head *list,
 				      const char *sys_name, const char *evt_name,
 				      struct parse_events_error *err,
 				      struct parse_events_terms *head_config, YYLTYPE *loc)
@@ -578,7 +580,7 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 
 		found++;
 
-		ret = add_tracepoint(list, idx, sys_name, evt_ent->d_name,
+		ret = add_tracepoint(parse_state, list, sys_name, evt_ent->d_name,
 				     err, head_config, loc);
 	}
 
@@ -592,19 +594,21 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
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
@@ -630,7 +634,7 @@ static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
 		if (!strglobmatch(events_ent->d_name, sys_name))
 			continue;
 
-		ret = add_tracepoint_event(list, idx, events_ent->d_name,
+		ret = add_tracepoint_event(parse_state, list, events_ent->d_name,
 					   evt_name, err, head_config, loc);
 	}
 
@@ -1266,7 +1270,8 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 	return 0;
 }
 
-int parse_events_add_tracepoint(struct list_head *list, int *idx,
+int parse_events_add_tracepoint(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys, const char *event,
 				struct parse_events_error *err,
 				struct parse_events_terms *head_config, void *loc_)
@@ -1282,14 +1287,14 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
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
index 809359e8544e..fd55a154ceff 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -189,7 +189,8 @@ int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct
 int parse_events__modifier_event(struct list_head *list, char *str, bool add);
 int parse_events__modifier_group(struct list_head *list, char *event_mod);
 int parse_events_name(struct list_head *list, const char *name);
-int parse_events_add_tracepoint(struct list_head *list, int *idx,
+int parse_events_add_tracepoint(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys, const char *event,
 				struct parse_events_error *error,
 				struct parse_events_terms *head_config, void *loc);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d70f5d84af92..0bab4263f8e3 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -537,7 +537,7 @@ tracepoint_name opt_event_config
 	if (!list)
 		YYNOMEM;
 
-	err = parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
+	err = parse_events_add_tracepoint(parse_state, list, $1.sys, $1.event,
 					error, $2, &@1);
 
 	parse_events_terms__delete($2);

-- 
2.44.0

