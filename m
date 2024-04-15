Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC98200BF
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162999; cv=none; b=Y6KO1Ccyn7uhXoEHhpKicUm4f7cj9cYpp4V0tinJC4jXSVNr1iML0NkXhX7oVSwQn/AmeadM5+n/mhVYHmf0+M9VWd1lb5IfyFNEtQbHXn0wfwWs0aT73JacjyHVrbdl98WwoeaaHYDrEPbgUmlWfE3c5g1SQF1nuZ89TDOqtHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162999; c=relaxed/simple;
	bh=A9tG8iOIBqHAbekqVK9mlABKDk+WYPW2yjNIRApp2Ow=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=enKRBvilS48vbg4cZWWJ0TLYWcsdEr4J7/oOgGmXthIeZctCV1smkYpMU3CQcDh22rUOSMeP8xgyeL030XxC+xS6+OOgYDc0NnniyuXCLtQzZWuXXnG7e1bZSHKzcFrtl/1j71bWBGqCufKkE2VDE56+lglq7UZfhxB6+UWc1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=frTX9Xd5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="frTX9Xd5"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd8e82dd47eso3895536276.2
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Apr 2024 23:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713162997; x=1713767797; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+gciuZSLFdHIk1i0SV08AyznRpAEm+5KjCzM2jFJbc=;
        b=frTX9Xd5/JSeHqyqq4FTi1Zm+ZTlCqczsOi7cq5poH8+Zcmv5mDAtmNRiwyrH8HMmI
         SJ4+5rcl6LnwxY88Jc/jGf86G9AhMhU6fIqDFHocDvga58vCYbmd3L4xgFeJGo9NuYBB
         ZhxZnpE3z+BpIGR2X2ZtuVZzRnfoZ5/mVR1laEcxHTmEHXxe2/U/aURQYE6l04nD/G3i
         75qeIoB2wGnZesTey+yRYJ8ioVHl7TrFUZVahqF84x7WYHBX6JmcAGwk1152vmShppna
         OouHSvDkTdU6MMcer9yAsy+U+dTppoME3tfeFFG84VAuCl2T0Q41ZerBqIrXyLw22SBT
         AfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713162997; x=1713767797;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+gciuZSLFdHIk1i0SV08AyznRpAEm+5KjCzM2jFJbc=;
        b=jrwdP3pz8F9g7JOM6ZYKPJ1QhEJqkrfDwJgc+25dhYwASpleLkfECzBpAF5nsyH9RO
         Ffcmr5ksGIWOZ6nzfEyhxnu5ilKM/ed+BT2uKBDAedeUlNHsxqPDw/dOexic8lnkUqEG
         Bz4ZGv5NVqrNgNp0qg0KzoyW1kpJWJsBZ4ayH4ngBnmrglFvWtYoTyoGNeMEEJu/iHZq
         uc1vgBV+rmraafDKhVEoeVxElDTD9Q2mePWisj+IhWWHBfnIbHB6bi01ubIuVlmSHsiR
         mzEzhgTgs4Kd+Cnf/5i+ANwEz4EVtDx9PMTEqYiicFY1ttww30VUJSwQGAQGQJfxxK84
         lmOA==
X-Forwarded-Encrypted: i=1; AJvYcCVkZqnJoyj1ec8WQx2WTENpwFT7NHa0JrQY0aXkCgbivstUV4WsK2WzFw8MGqrnIeGGOsBkgzDI9XdN+yJLY//6q85Fm+x4bLJyckExjXaMAQ==
X-Gm-Message-State: AOJu0Yw6iU8/D3X6OQ+edE7v3SSokK/E853KJNpGPb7X3pWiNsYFJwdN
	QkMWZ74C8Ux9gnAgPq3VkvarvVSs1nHryfbLFbQOVrylXK8nL2Z5pA7hChGLcVNEdH4TPQI4iNs
	NyjUA3w==
X-Google-Smtp-Source: AGHT+IFL+Tvkj6R3nO3XnJ0ewuekhH4PPx8UF3ahuI3cz/n03WZ3OYIbXOAvlx9w1Oc053fj9XHZnbkS+UNY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a25:b21b:0:b0:dda:c566:dadd with SMTP id
 i27-20020a25b21b000000b00ddac566daddmr529521ybj.4.1713162997423; Sun, 14 Apr
 2024 23:36:37 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:20 -0700
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
Message-Id: <20240415063626.453987-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 3/9] perf parse-events: Avoid copying an empty list
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
 tools/perf/util/parse-events.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index bc4a5e3c6c21..7e23168deeb9 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1398,29 +1398,20 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
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
+		if (pmu->selectable && const_parsed_terms && list_empty(&const_parsed_terms->terms)) {
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
@@ -1428,7 +1419,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	attr.type = pmu->type;
 
-	if (list_empty(&parsed_terms.terms)) {
+	if (!const_parsed_terms || list_empty(&const_parsed_terms->terms)) {
 		evsel = __add_event(list, &parse_state->idx, &attr,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
@@ -1437,6 +1428,15 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
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

