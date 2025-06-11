Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1821E51EB
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657735; cv=none; b=lJ8UHvM/ojBoRkdpTVPo9jp39cTt1U4TqrV9k6LnasRp/rQaoWBBkRh+X7ZenR6wmWl4GuHLpAqm61lhSQfCyNNJCW2GPGFhGtQ5IerGAoqsqblBPHV6OXbtPrpXej4mBY+D9FviLuo7Vua9+ITOj/Je7KSPC7RzRvt+wv/Fslk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657735; c=relaxed/simple;
	bh=w75vlGAuULUigeQ7NC12gcNLDLfy5b2P2WGmKrqlzfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cPBM3U3soqdPEuQIzA6YjhnFza/ZrwLO4a9d4JXoDA7dnoUnT3pXfs3uifaNN8qUD7pzsKdC5uDtsEXikrN/+TBsNDg702zCG6/ZGfKmsVQzPwQkeqBY3k5CYjF3vl+57VXnJjOCivXsfR/awJn39ZnqXxZra/wapVW7ZSvTr3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rWYdO6xS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWYdO6xS"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747adea6ddbso38920b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749657733; x=1750262533; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxsdjkb4V6FP85dTNyusFArFxiD/4CkT/SqFYLClDmU=;
        b=rWYdO6xSHF/OqXEm6Gcwr75ztfVYXzNfBRW0wQ6tzTiBrQywVD/56BSnMBnx7Q3Br3
         UOjs6ddocKUOoCc1PHt853PHyQIcRT6YysXCnTPWhqiabJoWRoYZoAdQba4epV/dOGDE
         SdZ40KLvIPYl14hFFz5aVEbbNa/vCJO5Q+SIORwOza7wZY5zV09Dh3/nP1F1Wq3+Wccc
         lzY6nuPeeBlS/+6peerZQnUogMvWN1hbDIgN4e182LOguiy+IZMhP/SNUGN2o4SfbXyI
         7+G4ZUuJJ35UST5CntAnNps4X2rG2uEkYHxqtgns64qpFlByjPt5FN0mB2Y9AjrGDr+v
         YaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657733; x=1750262533;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxsdjkb4V6FP85dTNyusFArFxiD/4CkT/SqFYLClDmU=;
        b=uCqWUDgZr/gwhRuPYKeMeb0hGOJkPfaR9Zw5+23qmnlTjtRvD+w5Y0vUZk3WMVwTD1
         btuVbU4iVzfUXWaeBDY1mXZ+eAjua5lD9vN8od2gexKtJd1djOGSkTbdluwfi3bE3SuN
         B4DHTmLniVTegmgtmSiPGlyk3XORhmECpGlNoFLbQXO7Jih3KDp0We9Zj/RbZlwcoiOs
         LjWRmyRtB+0EcdOcHbzjEGJ89yoBsHvWZdsttX+RdtWi8jPoiB7g2pro5X7daG8CMXRi
         tUHxi5T/JTzQyU4zhmNuS6KkkgiE+ugEU6NALhD8tjIVK2tzFMz0u1ulJsUv6CeFhnb/
         Bjlw==
X-Forwarded-Encrypted: i=1; AJvYcCXavn3Vv+c0avLWgjdKwcZRo3J3S18Cql+rekjk/1PWEAIbZiOi403AAKqhNV2EfLelOTgiLMWrau2iNy9DRl7H@vger.kernel.org
X-Gm-Message-State: AOJu0YyG+SN4xysNSn+gYM9mdz2ZK4RhpVGzMOAj0CXDWys54cLpoX46
	Z9zBfgJ6RcuJL0gzGCguerXRoji1zNMYLFBrDLU37pnoT5wGLudMOTVxCMXmsmjMlXOqT1EA2iz
	z+chdvH6EDg==
X-Google-Smtp-Source: AGHT+IFKXrW5RA82oSNKBzT1OG4qpzdybD+levBZNDmHVS9cW8AX9yPjtPhrz/fH9L7O4kZBG4TubY9pwh8X
X-Received: from pga13.prod.google.com ([2002:a05:6a02:4f8d:b0:b2f:c26a:8705])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7490:b0:21d:2244:7c5c
 with SMTP id adf61e73a8af0-21f866eb61dmr6169310637.26.1749657733504; Wed, 11
 Jun 2025 09:02:13 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:01:53 -0700
In-Reply-To: <20250611160206.552030-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611160206.552030-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611160206.552030-3-irogers@google.com>
Subject: [PATCH v2 02/15] perf parse-events: Minor tidy up of event_type helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add missing breakpoint and raw types. Avoid a switch, just use a
lookup array. Switch the type to unsigned to avoid checking negative
values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 31 +++++++++++++------------------
 tools/perf/util/parse-events.h |  2 +-
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7f34e602fc08..9dd0216cfae4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -135,26 +135,21 @@ const struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 	},
 };
 
-const char *event_type(int type)
-{
-	switch (type) {
-	case PERF_TYPE_HARDWARE:
-		return "hardware";
-
-	case PERF_TYPE_SOFTWARE:
-		return "software";
-
-	case PERF_TYPE_TRACEPOINT:
-		return "tracepoint";
-
-	case PERF_TYPE_HW_CACHE:
-		return "hardware-cache";
+static const char *const event_types[] = {
+	[PERF_TYPE_HARDWARE]	= "hardware",
+	[PERF_TYPE_SOFTWARE]	= "software",
+	[PERF_TYPE_TRACEPOINT]	= "tracepoint",
+	[PERF_TYPE_HW_CACHE]	= "hardware-cache",
+	[PERF_TYPE_RAW]		= "raw",
+	[PERF_TYPE_BREAKPOINT]	= "breakpoint",
+};
 
-	default:
-		break;
-	}
+const char *event_type(size_t type)
+{
+	if (type >= PERF_TYPE_MAX)
+		return "unknown";
 
-	return "unknown";
+	return event_types[type];
 }
 
 static char *get_config_str(const struct parse_events_terms *head_terms,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 1c20ed0879aa..b47bf2810112 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -21,7 +21,7 @@ struct option;
 struct perf_pmu;
 struct strbuf;
 
-const char *event_type(int type);
+const char *event_type(size_t type);
 
 /* Arguments encoded in opt->value. */
 struct parse_events_option_args {
-- 
2.50.0.rc0.642.g800a2b2222-goog

