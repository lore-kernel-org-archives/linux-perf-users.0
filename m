Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759654737
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248154; cv=none; b=FVZgBNnxkzmv3+z6GQ4YQEJxdSDC1fN64GIqM6rmxZI5U3Gxzgl4hfq29jm+OyzFHan0Re/tUDTOqaH61WFowXPv02h0ylb5WjxG2UJhNR8blABonDL6hN8YwgbKSG0IV2SvUdRQDDByn5qLwY/p+y6A8aF2JdTKnCRxh5prfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248154; c=relaxed/simple;
	bh=IERvH/Ao6HfWGEykCXtiWrApDF698nujkO4wwCpYmzw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YTJ3nniM5KzUEjrQDW1/AtumtLbc2ksQWdJMY/KRb03LAnHbHNsLdxcO5CYcuJIkZO+kzcxjV46WmVrEyIw5c91UMvbm81LJXC4ss58UcGA16KV5IFTKA/CIgJw1w+TrPV9NsUQiZMVnCtVu0d8yJMfxNKttwFG46hnLa2C3Fzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNN4qflV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNN4qflV"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso1566346276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 23:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248151; x=1713852951; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trVc8Z3cM9HfuUa79775aNx5De/ILl71mqLeEIudwkY=;
        b=XNN4qflVBY4y9wyZFiv0CpHJcPKMRC7AEpYwTL2cRaJQDuj6JK1i9EDrFqhyXSY4ih
         RsW/5rpPp/tXv4Ygt424I5TOBks3HxBrLTO+eHniPjok95LQPzu0YnWf46AjZ5vkgIc5
         Jh3+xbHXNq0lM9vloV2y94TIByFwtdip9eWaLX2IOAUVXSZDjGMpSAzO09EZwKtjLVj/
         2b7kZi+sEBjL1CpmQle52ix7WJr50iH7b0HX1qmFsO5olvaI2kklsycZX8AV7JHXt5MH
         VvaXSZrbkxAQG5PKyXMPiCDcesROb4qqpMhVL28wmMoMn/Hw8hOmtorLX9lPrcqGOXaU
         9E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248151; x=1713852951;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trVc8Z3cM9HfuUa79775aNx5De/ILl71mqLeEIudwkY=;
        b=hXcGDih8oTX2cOqSqYAsjmbZSG/Bk6N7ElqK+WtyRvfI/k8Nmdtou7CByHSYvIaoxP
         8neDa3Yadt6GVN1EE8hGGUReXHWOd7KNkROmx5kB2kg/jsIakrrUeU/Q8yYEaxvrpD3F
         0vbwsYIwaGE8Gvdb7fWGTKu3yIS/8nvSnm1ehdyQAXRnFjjbNqMh32eJ8+ssAeqXilFj
         SPhU2dHypcKeKv6PAP+jOoZ00WYepa0GtvbQ8rDsi/n7wwpct1sg0pripr6XNgRVmBqV
         Fmr5jG6S3iDcvh9SltzeuRZKd/HsPuebJLlgw/Z7KL9CwsEyOgb5Q7WTCspg+MwDXx0Q
         ObAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNUAmsRPytS240uNSQqpA2Hbs8k/jcvAHTJqq6nmskHkeO3IUo3zL7m3XihEin5XHtrfw6SwaBxz1gVsJt5Yv4lkgH91VpOeCtgcPuDHnOVw==
X-Gm-Message-State: AOJu0YxwLqeUv5i6sybZ9O2ZrG2wEfWRudwpCNX3dSbrbPN+4BeHqqlq
	WRGzVyuEVZFBGIcpohid0LuK32xKK0M4dJZkKGP7qja4YI2pkamLOHgDXGgs3eCH4ETw/P0oZDO
	PJ6ycPg==
X-Google-Smtp-Source: AGHT+IHbe1DxlHRAKrzSKiVOtakxA6Q18A5QeFHX1nkM8ma5D0AnWniiwkUYIfGXxIcoemP4HQq1Zn/FTkGf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:100d:b0:dbd:ee44:8908 with SMTP
 id w13-20020a056902100d00b00dbdee448908mr615704ybt.0.1713248151392; Mon, 15
 Apr 2024 23:15:51 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:19 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 03/16] perf parse-events: Avoid copying an empty list
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

In parse_events_add_pmu, delay copying the list of terms until it is
known the list contains terms.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2d5a275dd257..3b1f767039fa 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1398,29 +1398,21 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	struct parse_events_terms parsed_terms;
 	bool alias_rewrote_terms = false;
 
-	parse_events_terms__init(&parsed_terms);
-	if (const_parsed_terms) {
-		int ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
-
-		if (ret)
-			return ret;
-	}
-
 	if (verbose > 1) {
 		struct strbuf sb;
 
 		strbuf_init(&sb, /*hint=*/ 0);
-		if (pmu->selectable && list_empty(&parsed_terms.terms)) {
+		if (pmu->selectable && const_parsed_terms &&
+		    list_empty(&const_parsed_terms->terms)) {
 			strbuf_addf(&sb, "%s//", pmu->name);
 		} else {
 			strbuf_addf(&sb, "%s/", pmu->name);
-			parse_events_terms__to_strbuf(&parsed_terms, &sb);
+			parse_events_terms__to_strbuf(const_parsed_terms, &sb);
 			strbuf_addch(&sb, '/');
 		}
 		fprintf(stderr, "Attempt to add: %s\n", sb.buf);
 		strbuf_release(&sb);
 	}
-	fix_raw(&parsed_terms, pmu);
 
 	memset(&attr, 0, sizeof(attr));
 	if (pmu->perf_event_attr_init_default)
@@ -1428,7 +1420,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	attr.type = pmu->type;
 
-	if (list_empty(&parsed_terms.terms)) {
+	if (!const_parsed_terms || list_empty(&const_parsed_terms->terms)) {
 		evsel = __add_event(list, &parse_state->idx, &attr,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
@@ -1437,6 +1429,15 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return evsel ? 0 : -ENOMEM;
 	}
 
+	parse_events_terms__init(&parsed_terms);
+	if (const_parsed_terms) {
+		int ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
+
+		if (ret)
+			return ret;
+	}
+	fix_raw(&parsed_terms, pmu);
+
 	/* Configure attr/terms with a known PMU, this will set hardcoded terms. */
 	if (config_attr(&attr, &parsed_terms, parse_state->error, config_term_pmu)) {
 		parse_events_terms__exit(&parsed_terms);
-- 
2.44.0.683.g7961c838ac-goog

