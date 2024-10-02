Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5309918C36
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839231; cv=none; b=ZRQAtoskpQ9MXFd7mOklBHOP9fgGV1WDau5kLs8YemJAoBRO6EIK/e3yIV/e13453lnDSCt7eFfGaDyTfgMwKF1Iwgenbmt7HDBqQLzjaOXnRH9LtXrJy6tzgJKCVw6oS/Mb6sTOHgwQ+bMSEeedYVbNqEl9iyc8gDhnHyAIjK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839231; c=relaxed/simple;
	bh=pbd0mtz7VbHTf9Txoh97J1oZDoDP3tqW9zIloce5NSE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ADFvy+c4tlhtoiLq/cOQckUxop8fAoL6h79lqA2t1pFpsR0i4Lc5j0yOKPUYkc+S4628W3ZImJjzLQlwu+5O2JkbBAyBq8RJ6yFesIn0QZOUa7zs6p8mHXakCAw6g76E9n/xIqaS4N8iSGNHNnq+v6UPK0TNo3tS9O2SBW1O6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DcSd1WeI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DcSd1WeI"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25d494faa4so6930776276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 20:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727839229; x=1728444029; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39T+6noF1HDYHixFiWW8nys9E5rCFMsxZqBd3BPaByY=;
        b=DcSd1WeIoaya/OLsqKgxKzHR9cKxv1Y1LoQk5xOPveRM1fGBMyKj6a2syWAkylpENC
         9A4cGNfdrjW/XK29IMJTwj2RL6RWrOkeRZvoUdM8EXtmUaAVZ8oAeNcUbWTLxb7Mi8K8
         srDZAPM7vUoPdmcS9RNZPOdQrVkqITbjcCyFGawJN3qhRsfTyeIxDWwfmXpIJNT1QHTa
         im2x3faWIeF6B0zpL88amoFuURW3qA0P6aC9BApVaXaAU1zyHyDgwZOzB8iZ+9il7Vr5
         xmfW2Hdh0Fclp+tRRDvN4c9/N3UkfAqH7VZpPXSxqgO1tqtyV7O76GDUVvTnIUxBX0Be
         NcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727839229; x=1728444029;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39T+6noF1HDYHixFiWW8nys9E5rCFMsxZqBd3BPaByY=;
        b=Zj8Ga5nL3e+KkhOVTUaZMjKkdTY7Q5UOzXLcqLsIhsKwXups7r0WU0bHiaOWhHUU2t
         v19+IIGlcC5qoCwTWJIDY1RUMRw1XAMGj/h4s9/bNRgnmqUYyqi21oD67+ZC8pa4cLq6
         t7vOHj+DfJnbP+1h9OXdqZVtInxkDisoN7xL7+QggITO0AdXj31p6LoAQYx+0jOvINCg
         +QZyqTYk5w7hFw/ZjrVL0KF1hHcWc69CiEOOs6BD21TCbEEIVvoA6bXijZXZsm7zc5fS
         Uhxv9OjlD3QSpAWIfWd3mAitJraMHIEbwSQn2YSzxneiw1HP5ClQGmmTO2DkRX+LbtG7
         0DPw==
X-Forwarded-Encrypted: i=1; AJvYcCWy5aIKK0JE4HRSRxfMTZ3QoKGx9OG4cOm1vEDRLrM5l9hBFeQfj1EUKty8itkjCcizk4aW45EjtZgi4+Lmz8s/@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYZYdXaXEwlCbqqd0vG05gDIv5vfNzOPAaYkbkUyO1K9tXzhM
	ensQNw6dPsCEOWrpeu9GUbqElxdC+L8OiUX+GsdP4nFIY0YmGZ8jkpk0NoTFN4kkRgsrQRsoOMf
	l176Kjg==
X-Google-Smtp-Source: AGHT+IGGXpz7W1T1yyjYa2QLFOERmH1YOJwoLGSUEPWG+E5FM/tlDieHSEHZd2aGX20w6HMLgZUOd0Zysatg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ffa1:6d00:2acb:535f])
 (user=irogers job=sendgmr) by 2002:a25:bc8d:0:b0:e25:e5b9:8114 with SMTP id
 3f1490d57ef6-e26383e33d0mr5567276.4.1727839229299; Tue, 01 Oct 2024 20:20:29
 -0700 (PDT)
Date: Tue,  1 Oct 2024 20:20:06 -0700
In-Reply-To: <20241002032016.333748-1-irogers@google.com>
Message-Id: <20241002032016.333748-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002032016.333748-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v3 03/13] perf parse-events: Expose/rename config_term_name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Weilin Wang <weilin.wang@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Ze Gao <zegao2021@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Expose config_term_name as parse_events__term_type_str so that PMUs not
in pmu.c may access it.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/parse-events.c | 20 +++++++++++---------
 tools/perf/util/parse-events.h |  2 ++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6ae611e70fae..228ae469d44a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -800,7 +800,7 @@ static int check_type_val(struct parse_events_term *term,
 
 static bool config_term_shrinked;
 
-static const char *config_term_name(enum parse_events__term_type term_type)
+const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 {
 	/*
 	 * Update according to parse-events.l
@@ -886,7 +886,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 
 		/* term_type is validated so indexing is safe */
 		if (asprintf(&err_str, "'%s' is not usable in 'perf stat'",
-			     config_term_name(term_type)) >= 0)
+			     parse_events__term_type_str(term_type)) >= 0)
 			parse_events_error__handle(err, -1, err_str, NULL);
 		return false;
 	}
@@ -1010,7 +1010,7 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	default:
 		parse_events_error__handle(err, term->err_term,
-					strdup(config_term_name(term->type_term)),
+					strdup(parse_events__term_type_str(term->type_term)),
 					parse_events_formats_error_string(NULL));
 		return -EINVAL;
 	}
@@ -1134,8 +1134,9 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
-						   strdup(config_term_name(term->type_term)),
-				strdup("valid terms: call-graph,stack-size\n"));
+					strdup(parse_events__term_type_str(term->type_term)),
+					strdup("valid terms: call-graph,stack-size\n")
+				);
 		}
 		return -EINVAL;
 	}
@@ -2582,7 +2583,7 @@ int parse_events_term__num(struct parse_events_term **term,
 	struct parse_events_term temp = {
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = type_term,
-		.config    = config ? : strdup(config_term_name(type_term)),
+		.config    = config ? : strdup(parse_events__term_type_str(type_term)),
 		.no_value  = no_value,
 		.err_term  = loc_term ? loc_term->first_column : 0,
 		.err_val   = loc_val  ? loc_val->first_column  : 0,
@@ -2616,7 +2617,7 @@ int parse_events_term__term(struct parse_events_term **term,
 			    void *loc_term, void *loc_val)
 {
 	return parse_events_term__str(term, term_lhs, NULL,
-				      strdup(config_term_name(term_rhs)),
+				      strdup(parse_events__term_type_str(term_rhs)),
 				      loc_term, loc_val);
 }
 
@@ -2723,7 +2724,8 @@ int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct
 				if (ret < 0)
 					return ret;
 			} else if ((unsigned int)term->type_term < __PARSE_EVENTS__TERM_TYPE_NR) {
-				ret = strbuf_addf(sb, "%s=", config_term_name(term->type_term));
+				ret = strbuf_addf(sb, "%s=",
+						  parse_events__term_type_str(term->type_term));
 				if (ret < 0)
 					return ret;
 			}
@@ -2743,7 +2745,7 @@ static void config_terms_list(char *buf, size_t buf_sz)
 
 	buf[0] = '\0';
 	for (i = 0; i < __PARSE_EVENTS__TERM_TYPE_NR; i++) {
-		const char *name = config_term_name(i);
+		const char *name = parse_events__term_type_str(i);
 
 		if (!config_term_avail(i, NULL))
 			continue;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 2b52f8d6aa29..ac1feaaeb8d5 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -168,6 +168,8 @@ struct parse_events_state {
 	bool			   wild_card_pmus;
 };
 
+const char *parse_events__term_type_str(enum parse_events__term_type term_type);
+
 bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 			      const struct perf_pmu *pmu);
 void parse_events__shrink_config_terms(void);
-- 
2.46.1.824.gd892dcdcdd-goog

