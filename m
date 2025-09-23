Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247331E887
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666849; cv=none; b=WWQ2peP0vIBWA40BH3QZx6G0lMPmKiDoNr0fDGH5cOVUPsS01YO1JLPzsw4Rc4mRxxDYdPf+42QVXNb4DMKLHzR2uvf8UoUtTV40VCn8yZ4Bh3j2v2WaUJe3W0hDqxRVEB6JUbqak6wmTzIsic3D9WdQyTLs0E5eRcnKQaYlBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666849; c=relaxed/simple;
	bh=6bAtb38zV9J/DL1V7CMqXHrxyyDh/espMrQBxm4h/pM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UlYku8QaK/xGy4uZhaQ13O0MjKg/qus6sufDBmQcWUjqJV+YwvY7HF7O/60C3eIe/tOWLyzEKRF2LlZ5kDWGCo9z5q/goHTuHjziEA9AA592dKdx4FOxE+6dQvNPoK6V0oMMQ13R6o83nkR3ZXEYlJf+5TRixuHey1kwE15KNCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8AdrnUK; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8AdrnUK"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-3515b548b49so975311fac.3
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666847; x=1759271647; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GD6dJGQu7Fkw7LxMA7kNIP84YIqKTjc1I229dIn5uGU=;
        b=O8AdrnUKWj9OiOZhvHVgKs0p+MQXEkCCbdAxL54D0WoG6JJdm5eI20vpJ5/4gOZiNQ
         PWYEru0ZOZZnOTFTl9BKUHJOadOJQVUl0evdmhklz6cLkKv1ZVSSeOX2q4MmAkkWKUVV
         GnLnFbxN52+2wfm8eNgQpQNlq3oGSUSMWECITX8EKewj0XDoe6HYPTyKtTy7dvaRYe4T
         5gSY/W1+Dg5G+AMqokX0oKgoOrDn8EtyUk27QxRPFE0XBThoe3NT3ForofHnLt3vkB7o
         voN6E77fCPejJ11ZvQWTL0CRVpWohoG24bimUAhItVAGDuDktAiOq7AfxLdpsVmIHaYU
         FDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666847; x=1759271647;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GD6dJGQu7Fkw7LxMA7kNIP84YIqKTjc1I229dIn5uGU=;
        b=Z/CfSSpE2w8vnrYdqjxViY84VZcMimfsFWO9CRo+7bbzLoX+HRTgcu1QrBKuEjkKJa
         bVxB/hj/mMoorY6c/1+4IaNqIUZZ7Jc754NFu1o/DEJKsQSG79XpFYhcia3tgBjnXgxF
         rajxyJJqvtfmoEh5yMK1N+qnMV232L0NtN/HbOyAixuH6x1rfv5jV340t2wp4bm3YXQ5
         tqJR6ILeH0CKH6RIvMzCqoJWwZ+CJkH8rmZYReZ6P1ifBzvrKrEPWh1z4DxbWYThInVI
         uqrzOR/rnwZQewriCONJQqAmkrQgnNRWAWezRxkNSCEg/RqkHU7uQ6lV/a+7fynv5o+X
         YDcA==
X-Forwarded-Encrypted: i=1; AJvYcCU9oMJbZPn6kkx0io9PiRodXha9/y6PQvXvY6/EkiZ0FKuOh+UPm47Ky49Agdh6MgdqZhdI8TCIWKTbmcfIKV7O@vger.kernel.org
X-Gm-Message-State: AOJu0YzuMnVcqMYRb0LIoxp7+osABRppaQbEx3zTGrbmXT9fjNAMOlHE
	3HdcuKsj9DXQ1sfzexfjlYgFzqc0qH628u0VVCAk2H8izb7BUVqxFsP7K14NyluAeAA69fiuBn6
	XMxZw3QnTAQ==
X-Google-Smtp-Source: AGHT+IFp6DkPfipVKWjqwIOzfegd4Sinvit3+C3SPetoRf0uBeHWE/XghSk/VbLp3mB5OrjyKZ+QOHVG20P7
X-Received: from oackh3.prod.google.com ([2002:a05:6871:bc83:b0:357:4056:751a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:170e:b0:34b:f75a:7d74
 with SMTP id 586e51a60fabf-34c86950abemr2446622fac.42.1758666846663; Tue, 23
 Sep 2025 15:34:06 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:33:09 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-26-irogers@google.com>
Subject: [PATCH v6 25/28] perf test: Switch cycles event to cpu-cycles
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Without a PMU perf matches an event against any PMU with the
event. Unfortunately some PMU drivers advertise a "cycles" event which
is typically just a core event. As tests assume a core event, switch
to use "cpu-cycles" that avoids the overloaded "cycles" event on
troublesome PMUs and is so far not overloaded. Note, on x86 this
changes a legacy event into a sysfs one.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/code-reading.c     | 2 +-
 tools/perf/tests/keep-tracking.c    | 2 +-
 tools/perf/tests/perf-time-to-tsc.c | 4 ++--
 tools/perf/tests/switch-tracking.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 9c2091310191..4574a7e528ec 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -649,7 +649,7 @@ static int do_test_code_reading(bool try_kcore)
 	struct map *map;
 	bool have_vmlinux, have_kcore;
 	struct dso *dso;
-	const char *events[] = { "cycles", "cycles:u", "cpu-clock", "cpu-clock:u", NULL };
+	const char *events[] = { "cpu-cycles", "cpu-cycles:u", "cpu-clock", "cpu-clock:u", NULL };
 	int evidx = 0;
 	struct perf_env host_env;
 
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index eafb49eb0b56..729cc9cc1cb7 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -90,7 +90,7 @@ static int test__keep_tracking(struct test_suite *test __maybe_unused, int subte
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
 	CHECK__(parse_event(evlist, "dummy:u"));
-	CHECK__(parse_event(evlist, "cycles:u"));
+	CHECK__(parse_event(evlist, "cpu-cycles:u"));
 
 	evlist__config(evlist, &opts, NULL);
 
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index d4437410c99f..cca41bd37ae3 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -101,11 +101,11 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
-	CHECK__(parse_event(evlist, "cycles:u"));
+	CHECK__(parse_event(evlist, "cpu-cycles:u"));
 
 	evlist__config(evlist, &opts, NULL);
 
-	/* For hybrid "cycles:u", it creates two events */
+	/* For hybrid "cpu-cycles:u", it creates two events */
 	evlist__for_each_entry(evlist, evsel) {
 		evsel->core.attr.comm = 1;
 		evsel->core.attr.disabled = 1;
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 5be294014d3b..15791fcb76b2 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -332,7 +332,7 @@ static int process_events(struct evlist *evlist,
 static int test__switch_tracking(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	const char *sched_switch = "sched:sched_switch";
-	const char *cycles = "cycles:u";
+	const char *cycles = "cpu-cycles:u";
 	struct switch_tracking switch_tracking = { .tids = NULL, };
 	struct record_opts opts = {
 		.mmap_pages	     = UINT_MAX,
-- 
2.51.0.534.gc79095c0ca-goog

