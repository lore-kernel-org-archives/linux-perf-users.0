Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B312D2BE053
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191512; cv=none; b=Ve8AC3p1eR3sU4VgOH1bfu8VO/j8EKqWvGjV5qRq1hRR/uEJoWYCRbUS3RfbzwLMMfj3a6aDyLiuAyN3EHR7pVZAMbd8BElIzRtAyDQqLczKM4h7Uu4M/74YZW9XSQ4SsZ3XAtf3vZAt1n1/rMJHXqAlIQnSI3IiDNfq143IOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191512; c=relaxed/simple;
	bh=SCSVRXj5DB/cfKYLIvAW2+qqqcd9DzSoDst4X0cpuZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XO6uny5u37cbn/f0nUyKJ0E+16S4wzyYdL264F2jTBFV4hgIqTPN0XZgXCuubtGuT2uaJNK2lmz9fe/PmQ+1jNlHHtZyGzCKwLl7Q+eGUZOnNa0J2NGUt9ACHv69J6hkKDDpovj+NPch/FOH8nBJ+3TBhv8ccPxCW1SvX3Ji+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g86iauXM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g86iauXM"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3141f9ce4e2so2385063a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191510; x=1752796310; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uM9b0q174RElAGAUOsRC1+X9nDdEI4t5lPgRji4c5mk=;
        b=g86iauXMog/VEE5iAQ2iWB1tnmY3YGO4AkWNVcWuytSSeiI9T/VWxUOPwwg5FZHrjY
         GJ9da4oB2BatBO+/DpxYiBQ1YibpfR+mQPVdXgX2lMvvxPoun9+tIf+oJEgi1LKAVD3S
         tek2XcVFX5cbE1VcO9dYwf/9glUMWY3xvlhLAaQzqgYTlOx/y8t7wXaRlXukKN5sF4AO
         K9MLvHnmOi//sI8QuSE8XHvUQpdF590KjsTWcKJpZKa1lPEcUw38Q8hdLkmdQ0aHMVcq
         vDZEUOripCHraAEyDoS4elGFWCULGczAP6ki+a32ZenCo+vqC+6EULFew2FilKjWAdXs
         m1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191510; x=1752796310;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uM9b0q174RElAGAUOsRC1+X9nDdEI4t5lPgRji4c5mk=;
        b=OR+BDvPMLGOS4L5htG11zhs0nd8lkcnICw13TXnPf1ndv2dhsCmJsl4actd+vOTHAA
         dtAs4SnnlBKSVZOySwMd9DLF2ElwhBAGYgnmjZSS6AlF19L1CMgqjGKWrYKTBgYjSFHE
         qEYdsUqTdjrIABmurBG6JiN27srOvOPNxyFowGTOC+H4JWRclG1O9a2CU8pO5HgpJz4q
         iuSUI26w9xIXKX0vpTOIHyuQWiBOeHLHILmLPy6i3DIdsia9TjPr+iHdR1F5oLFdVCYx
         2JDOhqpRO/e7sY/vwOGfTdvhN2u+SD47IbEjlR6auRuSHxS5mKU/ZAXmQ+mqOdRfbdEB
         ND/w==
X-Forwarded-Encrypted: i=1; AJvYcCU/JhcJ8HTrWrbNnDX1aLxC3B/5qi5Z501/8d5MgA0JbrQ/UIi5Y3EV8dmQW1X74BYWu7tjK+ykvNaBGHvkrJ49@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDTgao61fY3EdsJ2UhSzXaB0s7PYGGWelP3P0o99leb9mdumJ
	/92zzrkycgQJNUrSj/9PPjTY8aEyYtFsjR0dZBTkJeGMxEdNsazTKe0YcLNheXvD2jW4HnfaL6w
	IwndjXAh+mA==
X-Google-Smtp-Source: AGHT+IGDs1DJDRF+w5DfFiNFxRUIQpInUV1CXnVwgdORwT/YMVNMGT7CuysH9mPzHKNuwHFli0N1Okh1N8rH
X-Received: from pjur8.prod.google.com ([2002:a17:90a:d408:b0:31c:2fe4:33bf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b83:b0:311:e8cc:4248
 with SMTP id 98e67ed59e1d1-31c4f5d782fmr773133a91.33.1752191510088; Thu, 10
 Jul 2025 16:51:50 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:15 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-3-irogers@google.com>
Subject: [PATCH v2 02/13] perf parse-events: Minor tidy up of event_type helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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
index 4cd64ffa4fcd..a59ae5ca0f89 100644
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
2.50.0.727.gbf7dc18ff4-goog

