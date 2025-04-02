Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA71A316B
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612455; cv=none; b=tjp68Yzf1JPUn6RnCGxa33EZo/HVp0k+rh5X9B2jKZlTEkQSmnBZy6oLoiX/GBFdTslGqu8Y/gKslx4OlJ1G9xk5Z429DhcKVBgIRJ4fLrWNjOoUSZhbIh+jpAM4McTFCWOQVVRlDGdKqhvhXRlZPbV5hp9F+uPSJVLH91+6gt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612455; c=relaxed/simple;
	bh=WStuIdPt8lRJg1FWf8KPFEILp1PnsGADoTb7+XPTPCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CYF6qFUt16WXf2NHy0mj6g/g5sOSBLAWDEwgFXONCog5jDQQcrctC4xasXaPazRbLguf7kugRiRHT8OtnQWkA0p2l6jBBsInxkeeAJ/snnJHDVd8v0qiu6LpE93zoIsZqFR13VNtz0L7GXDV5z6AJk+UaFw0LlBuFaf7GRWGnWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dE+dlHNT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dE+dlHNT"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224364f2492so421725ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743612453; x=1744217253; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tDmbLrtoU9NWl61/Y1ycLMfPN40NbRlPLTERdTcD4c=;
        b=dE+dlHNTq3YirW3NFy8clKeJAAOzOtUAdAhbtce5yzaZJTvgjX5G+u1xdKrO2jpK7S
         0/M5kPyQ9j9ghKkWLl9AnLV4vsR3Zku1iSZA+VpbtDtshEUnR6yaGaVo5KMMwr+uJeie
         SpGlWNfJLAv/PPeMZbu4sCqDAP2xW/Ch8vlApvsetWJANTrMZ1x63FhRD3E8EnWxVqOV
         QiYLzKW5pl2qLvvua07bwx4bUj1jvQio4aFi3oXxqxcjxg/wRXlU/XRKfgLKsqxigxG2
         xMB1aUrzqL8PkC50c0TaqvmLz0JsukIjgLTC3GkK/17na6ppGUr4gNjZkn3eQ4b05YMy
         GrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743612453; x=1744217253;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tDmbLrtoU9NWl61/Y1ycLMfPN40NbRlPLTERdTcD4c=;
        b=RjKtXmiTJu/BMgR3SbmivFnw/G2JZYkP4OYsh17pD0JMtYqs1IPvAm+tN94Mz0JkLg
         uN0NoaaTC4q6rIf6ukL7OluChUlQK3bmQExebs1XTkeCH+8fohR0Ma5Z1qy0w6++EvnK
         LF1IYnQLkx7ehNwJ96cPRfam+GifMZgOpet4sBpQcOkij+j4JeKGwIfaCLPDhfrV1JYU
         84Dvcub54AsG/elBrJ7pKkU8d4N1ANQttdfbCskBAtuZlUhO6m6B0yXKQAHvAYLt+PqF
         10kBnG+69lFphzUyJT416YKvH0u4qlaHZ4qihXGgHUiP4jigaw92dVczqpZhmJn04wLO
         qUBA==
X-Forwarded-Encrypted: i=1; AJvYcCUvfubE0nYQtHxoZRXaICJ1sL+QK5EKq77SvAkbqroeqikcQ20T/1JuqfAEsMdcZiaOX/OpRqHKcKZQ0JJvXzmx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DD3LVqblMe3I5OHctWatyuIImVkblhBdZprWQOFNgv1Innt6
	9NzKIUq+heYYNHYom1YKk4CE0EHq1ontY39dMHIjGW3e72i0MNSKtoKAfbvks3QGs9qZ5hVbNld
	zBqR0dg==
X-Google-Smtp-Source: AGHT+IGIMigwhhEQhcpTdE67GN3lzf59G15dcpWYK309Deu8nT4TCreokRGg9L3IKZhgBwbjjUECr6htPw05
X-Received: from plsa4.prod.google.com ([2002:a17:902:b584:b0:223:432c:56d4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce81:b0:224:584:6eef
 with SMTP id d9443c01a7336-2292f9e8275mr302417375ad.41.1743612453276; Wed, 02
 Apr 2025 09:47:33 -0700 (PDT)
Date: Wed,  2 Apr 2025 09:47:19 -0700
In-Reply-To: <20250402164720.3847573-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402164720.3847573-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402164720.3847573-5-irogers@google.com>
Subject: [PATCH v2 4/5] perf evlist: Add groups to evlist__format_evsels
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make groups visible in output:

Before:
{cycles,instructions} ->
cpu_atom/cycles/,cpu_atom/instructions/,cpu_core/cycles/,cpu_core/instructions/

After:
{cycles,instructions} ->
{cpu_atom/cycles/,cpu_atom/instructions/},{cpu_core/cycles/,cpu_core/instructions/}

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ffb5be41a465..6ebe0795e1c9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2471,13 +2471,18 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 
 void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb, size_t max_length)
 {
-	struct evsel *evsel;
+	struct evsel *evsel, *leader = NULL;
 	bool first = true;
 
 	evlist__for_each_entry(evlist, evsel) {
+		struct evsel *new_leader = evsel__leader(evsel);
+
 		if (evsel__is_dummy_event(evsel))
 			continue;
 
+		if (leader != new_leader && leader && leader->core.nr_members > 1)
+			strbuf_addch(sb, '}');
+
 		if (!first)
 			strbuf_addch(sb, ',');
 
@@ -2485,9 +2490,15 @@ void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb, size_t max_
 			strbuf_addstr(sb, "...");
 			return;
 		}
+		if (leader != new_leader && new_leader->core.nr_members > 1)
+			strbuf_addch(sb, '{');
+
 		strbuf_addstr(sb, evsel__name(evsel));
 		first = false;
+		leader = new_leader;
 	}
+	if (leader && leader->core.nr_members > 1)
+		strbuf_addch(sb, '}');
 }
 
 void evlist__check_mem_load_aux(struct evlist *evlist)
-- 
2.49.0.504.g3bcea36a83-goog

