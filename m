Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37972BE622
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688729; cv=none; b=m/C9ndJwDs07lA0Tnz04WBkDQQvCvCL8hlpA2fZ1yqUV0Kasq4wYRYxI951prGuzgES/W3s/HkIOhP4MnFEyzR3Phn95IXSebkobT9bJ/kVf1okNPDGJ40aR51NLtrFK8rSYAtaZBz3OpgYz+qyVvPfGv5mtf7o2gW5Z/jY+wq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688729; c=relaxed/simple;
	bh=jA8V8JQzSzzDaPIOYv6X7BrlScdsF10G+8JsMA7kuTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C+Vvn3nvkO9n2OSvRfqmTw0y/4iimxDQZVcZ3uVv+kdgvAoF5o8Iyb5nYp1tNrd2YTZ8ASgsHba8z8HqmMMXApELa2/xmkCivX1ixgNvjbB1R0RETc4n3AIdWkwRtNmsoitLO10DoML/HJxLKjA+fjcPuORQRQOxB2YbZDkf+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=22FcYi/m; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22FcYi/m"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-277f0ea6ee6so52411525ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688727; x=1760293527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=04jhWbIOWQVvHP4/B5QDDspC12yS1PC3rpInKNqRvvM=;
        b=22FcYi/mY3828b0v3gUbDZjjjGI29PzuyzMOEF8QZ4oHGWsFYUG1xwAtKW+GTLHGg3
         zsc3q3xp9LnH8kX1vmqvgrHkdvMPm8heJaB/PzTJx+NZdqubnfxRu0orB+IhbqZ87wKp
         HNye1qbXEuL76dK+P0P2cbgXi6y59XEsKe6mNinFFgXHWhZ5YqOXC5yJlD4BXP2jZE2W
         V/j3uAlb4S9SlKAGsZ6XPPK5eqUHCfom8KYBYpCJSWFIhfMxwcsz0o96twffbyNdo0jK
         d3DmLaRHAZHR9PePd2D3FFVVF/6qvetFdiAqHywDdbG5Y7ttIlz+BI7MsmCWoxYSPWBU
         dTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688727; x=1760293527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04jhWbIOWQVvHP4/B5QDDspC12yS1PC3rpInKNqRvvM=;
        b=mgfxVadApH/BMCRMhQMGoFUV7Kygdg1uy+4aW1n6z9kRMX7p85mtYYGalj/MJ29t4A
         fthAuTZWIISosO+ymuem+8dtsAJmdlaXrQLzgFOXrmTWNeifGTzge1zDQ6qane1T5Nwr
         ekwzL497v5a3kVz2PabCHhATjOc4Xcjs4zTgQKi7GfMv0+7rmj04o76KgvFN7ueIE9hu
         dxTcdG5MCVz24BNFs/Hb3FhRWMcGvM/1Il+8Ar896ObquTUl35cuFIU/ET+Gn6utAHvf
         XWbzYbwWfYqavFEe69P/olmb8nQ7RxVN/KiZlgWk4hyAA68UEMwbpdyN4VQJKALrUM+Q
         rIZw==
X-Forwarded-Encrypted: i=1; AJvYcCXnFImgFxsWwgUdTQ70pdWxG2MIPY47lQ2t5Qv+WIpLpY5n25qDWFTDqeYq4MrnEtkf3kzzAYugW1zTp0BFKDRc@vger.kernel.org
X-Gm-Message-State: AOJu0YxQIdPpk2r4pw7HGQOj12LGWxs5cjydEddKqh0GqPUxblwc/1q/
	W16yBp0326uDDMILDr4qOzR9gv1+Z0cUDqylsAynOUfEILqQH3N2TE76I7Rue5aNnkVZI2qDEf0
	mo71cgpHNtQ==
X-Google-Smtp-Source: AGHT+IE1ZmsKY4hNrxEAw+Tq+R1d8naqF7yJZyzDeYLPtjsVSiH93uuW+T1nuP4eF+Rcs0FCfN7MI/2SDDK3
X-Received: from plot3.prod.google.com ([2002:a17:902:8c83:b0:27e:4187:b4d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b4e:b0:275:2aac:fef8
 with SMTP id d9443c01a7336-28e9a61abc1mr122423885ad.38.1759688727421; Sun, 05
 Oct 2025 11:25:27 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:27 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-25-irogers@google.com>
Subject: [PATCH v7 24/27] perf test: Switch cycles event to cpu-cycles
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>
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
2.51.0.618.g983fd99d29-goog

