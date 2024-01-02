Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E9C18037
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jan 2024 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xj4rMXUa"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9c7932b3so202723276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jan 2024 13:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704232671; x=1704837471; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JeBLjYeUzVvGXpYvoerCoIh5W3LL/y5Nyz5E/CMr1+M=;
        b=Xj4rMXUanAK4Y+9kZ+tLgszsSp4Q+T/gtWEFz7dx79dAprIueUv1EZXuD0ErgKScyg
         HdwODm43yTQdjWRTdiJ5IaK4316GlWgGhgWWeTBeSc+kP2gQmKzVaOuqPUPXTCCBJABk
         f9sIbuR4JdoZAKCcNcNKZI+uPQ75lwdpOCPisGomUZen+HzpEUOmPXpIZLZLNp6ViOw/
         TRpdsmq2gaZLphbMcv+cA6AhVySBHtk/dEyGx/vOn6PATN4VmOKNsq4QZN7OkIzv1yS6
         CjisvcihVX762rTyJRhALHtSynm2OrQkBYhHBXnwjjp2KpTrYnKEZGH/c8avi6P4Mev5
         5gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232671; x=1704837471;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JeBLjYeUzVvGXpYvoerCoIh5W3LL/y5Nyz5E/CMr1+M=;
        b=NwrKmtHQFrC7SO0BtWQ9yUq+SVhNa0LbWZ1o6WDD/cADqoXu9JWYkY6N4d5XERkzeM
         cRw4vjjApbICAYz58E2GA1KaW4JZkgrH0lpb6ub1sf7Ez3CxpgHEhThgQ0hE00fKOPu0
         +m68nnMmI4vXjIML2pNHjLw60qn5B9x9ViUl4a37gouCbnxLWNyE6UlKerKk4G7i/Kbx
         q9dFd3hE0Cv0x4Ffbu0PulPyBMAy3qFiUedRyBiQFezS5fnUCwD1xr3QD/Q3/LnD26an
         t5X6Kh7XgJuESP/EgvA/vvAtrIGhohP1QxrTonSt+7CZ15U6yYaMQR6M2qnRDqKAQq0T
         hEZg==
X-Gm-Message-State: AOJu0YyPRQKYhCIbXL1/GiLku9FJtkEgEXzhmUyXCNlHTpkjThnbuZ4E
	fPL3P5+IRI87uYCJyyfoE8vMBcjIUh/AKOL0Gaw=
X-Google-Smtp-Source: AGHT+IFEQPSm0ADT0ReVTgngHV14SjJnghlnq0H4SAGNO+8sOnWmB2i+R8qvSQI3Xv3M9RlGgdKaCXCz9/yO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e2bd:f1f6:8ea6:8d6c])
 (user=irogers job=sendgmr) by 2002:a25:6852:0:b0:dbe:9642:8df6 with SMTP id
 d79-20020a256852000000b00dbe96428df6mr405018ybc.6.1704232670871; Tue, 02 Jan
 2024 13:57:50 -0800 (PST)
Date: Tue,  2 Jan 2024 13:57:32 -0800
Message-Id: <20240102215732.1125997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v1] perf x86 test: Update hybrid expectations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The legacy events cpu-cycles and instructions have sysfs event
equivalents on x86 (see /sys/devices/cpu_core/events). As sysfs/JSON
events are now higher in priority than legacy events this causes the
hybrid test expectations not to be met. To fix this switch to legacy
events that don't have sysfs versions, namely cpu-cycles becomes
cycles and instructions becomes branches.

Fixes: a24d9d9dc096 ("perf parse-events: Make legacy events lower priority than sysfs/JSON")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/hybrid.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
index eb152770f148..05a5f81e8167 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -47,7 +47,7 @@ static int test__hybrid_hw_group_event(struct evlist *evlist)
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return TEST_OK;
 }
@@ -102,7 +102,7 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -171,27 +171,27 @@ struct evlist_test {
 
 static const struct evlist_test test__hybrid_events[] = {
 	{
-		.name  = "cpu_core/cpu-cycles/",
+		.name  = "cpu_core/cycles/",
 		.check = test__hybrid_hw_event_with_pmu,
 		/* 0 */
 	},
 	{
-		.name  = "{cpu_core/cpu-cycles/,cpu_core/instructions/}",
+		.name  = "{cpu_core/cycles/,cpu_core/branches/}",
 		.check = test__hybrid_hw_group_event,
 		/* 1 */
 	},
 	{
-		.name  = "{cpu-clock,cpu_core/cpu-cycles/}",
+		.name  = "{cpu-clock,cpu_core/cycles/}",
 		.check = test__hybrid_sw_hw_group_event,
 		/* 2 */
 	},
 	{
-		.name  = "{cpu_core/cpu-cycles/,cpu-clock}",
+		.name  = "{cpu_core/cycles/,cpu-clock}",
 		.check = test__hybrid_hw_sw_group_event,
 		/* 3 */
 	},
 	{
-		.name  = "{cpu_core/cpu-cycles/k,cpu_core/instructions/u}",
+		.name  = "{cpu_core/cycles/k,cpu_core/branches/u}",
 		.check = test__hybrid_group_modifier1,
 		/* 4 */
 	},
-- 
2.43.0.472.g3155946c3a-goog

