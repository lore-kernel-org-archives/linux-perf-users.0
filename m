Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493571DBB13
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050933; cv=none; b=hcrg0rWQ/w0fCmseCcEFCOj3QekL7dIlGc7zrAtEIdM/YIufDFOU+ywpJgBef1cRA7X1k/sy3of16pudZoqMMAZZ7wHOxZXytmEOC42L2DlbRCQW+DELmdP+sBJgV9DavFSkYQfHUKn6UXs7n39NZh7F8k6invNY92rUPVUjqyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050933; c=relaxed/simple;
	bh=+rzqLnUZ9aKJHwPLS6rKWr6+5uLxahK86bnCKy+9kCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SXmhxScWukxJ0GsodDOk9s8cdZpffAMwUbVJmI+bOdTz7r69BH+5xhxQBYRlGKBmLA5f0naZ44QvKm/7awEdjqA4bcBdbHlsFZtEzJiDjI0PpvMNcq+lviWPs/n1myn3I3YOdYEBYdfSEZVEvUNjNxVeSLz80Ii3rJhShcAkVQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTHwa3sW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTHwa3sW"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so2724664a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jun 2025 22:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750050930; x=1750655730; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9cHBz9Jxgvdqu2C+765Nd/C5I0sI5XdrVknxJ/DmjSo=;
        b=vTHwa3sWOrisW1w0E0au4E4n2Vh2ejWi+rfOCUssgmcU1YqxCa4UETyB6oj7vXdNJg
         2cTsMUrX8AVveAF7H9sdCvK0u+wagpg3mRtN18xl9isBwd5J6NC9tc2ufwaUT885ua3o
         bQMpKXqId6rAxsw0bvLG/mniHQbrvtYr2TnrtCaJzM7ybhxy857xTGCx5yPuQjsZghPN
         uNPOES8pzYVBZ4u9K9VUIsOQnV/ajMe+pZhUebocw5aMGh0wtDX8vD7J1LeYZ6hokP+i
         qUGZtSF/gk2lA8l1WbqctRyghSYSKBwpIFLguVvJoX6xicT/pr2LmamTe4c3pRZtAMeo
         rSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750050930; x=1750655730;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cHBz9Jxgvdqu2C+765Nd/C5I0sI5XdrVknxJ/DmjSo=;
        b=oh052p/rFw/DuOEQL5HqeHBy+8dh1h3BNm2smSI5GORw3lRXaJHaAjazPEXNUlDRKF
         KTIVkzinbY6dcaOi7i4eR/FtxlqLxXoSx/6+ZG2dBeRZeillvXnPo6i0kih2q2jmHGYm
         2YOaA6M3kCrY716sw/PM1lUtq52I+DdxVBYhYSmvu4wU7GIDfnZwCV88URPFlP/JDOTG
         osnMh7Equo+OWSrbsXjkreDOnJ34s8UufvyDAg0KmBjUWAEyBlqLMjLtRv+GPWfy1amt
         Bwing7cRBWK0kNRONjsHQUJCmaELJYiEEkamG0xvtvvKpOiD82rXroWmsVjik6EfphNd
         dAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWems179q8QDzVZVEDktkEXoCFqbHsq0uSH0ynTuuDrP6MpsViOAlyCxUicVVRB5AQbmi9nqc3aEko/SDqa9LLJ@vger.kernel.org
X-Gm-Message-State: AOJu0YysmgZxy6/pvzGUtKWPveWaozGZdFhOuL5L/QfOVUUqQ5jqNsHk
	2RKIqosMG1IhKfNpujbJrGhRBeP1kGnRNMMszNM+R3hr7BUg5gSGBibLa8nd2sNW+TvvwaH34bB
	qqxaa6XCJ6Q==
X-Google-Smtp-Source: AGHT+IGsqLtLqfPivL8Z6UmUsOUy9pRSswLZ1JX/hHTzfJz7520mL2IlDRISK5F4XF1mIBfRUHSHqsf0SGe1
X-Received: from pgbdh21.prod.google.com ([2002:a05:6a02:b95:b0:b2e:b370:6975])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6186:b0:1f3:418d:91b5
 with SMTP id adf61e73a8af0-21fbd55a331mr12605812637.24.1750050930485; Sun, 15
 Jun 2025 22:15:30 -0700 (PDT)
Date: Sun, 15 Jun 2025 22:14:47 -0700
In-Reply-To: <20250616051500.1047173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250616051500.1047173-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250616051500.1047173-3-irogers@google.com>
Subject: [PATCH v3 02/15] perf parse-events: Minor tidy up of event_type helper
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
2.50.0.rc2.696.g1fc2a0284f-goog

