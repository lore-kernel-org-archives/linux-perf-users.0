Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC71BC07E
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760222; cv=none; b=dSmM1NMrYgocbQTAH3FrXAd8rwGG8tO9IL1nW0dJZL8OSFyvMBcH0P0J4rt3GJGRbcqyJCEGbKxHbXZNVlGqsnpm4PUxCwLN8llrsHDtVh4HjVysy0oP6Q6ZI1s/PKw07wbvNFBlRUywenHDlj4ZqY8ZdI9+VwrS3YGrj2O/XsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760222; c=relaxed/simple;
	bh=Ok+FhDXN/bUiz9+kds8fM6XMayPQjAdr+t4YJVsFhlo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Gzkc+Aq3m/nIjdfuvpgQcEuMwlW4K4sXiv7l24eqM6uiCGW4q2Nt/kxQeQHSoj8NbNAYNiM9oMCYeGRRriuweavdoHw630saV77EOfu2SlriABJpGqH3VAMK73pbDi9UVKFbhJN+LZHB1PS9S71scSOIp5HZ49ywfePIkNdDBAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NyXNjkRF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NyXNjkRF"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e25a6fddb0so35741237b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Sep 2024 22:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727760220; x=1728365020; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ta5YpSmga+h02rO1c/RFOYlnk/Em15j2RCfsC0qW0X4=;
        b=NyXNjkRFn40amU8m5lpohCQynDaXqE3wAP96/xxMPiYwHptLu6i+8P/rIKHhMjD74B
         oPlqs9j3uZFo8/Eb8M6pu22zmPpOjiHZbo8uItV0YSmwC71zoYvt5ayuAJQJm4BaEIgy
         C20laGkYM827qqiidGv+yi7m/kWa/5w3QZiiarkSBY1rW8QtDlu5WzGDPshO6AplKsf+
         1dYEKnqDcz77dw+5LjgKQFk2w46QxwZ8/TkPpQW66HTeKON+kYhSLBjXIDBVDGegZ24E
         mOCxtDlCPYXph/rEfRbNa3wp6Le0wV2rY/YfFXf5EPYnU+pj8Ylyxtxmw7ZR56CaI0Dc
         D3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727760220; x=1728365020;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ta5YpSmga+h02rO1c/RFOYlnk/Em15j2RCfsC0qW0X4=;
        b=sg7h1bDvegYuz0JAjZBKbvrmPg6nKBWZWWRJ4ipp3iV0KHsn1sLO6j2pxQwq36WJ8t
         nbGBF/l+vwKPkZTMFX0+ObFAsklPzbF7kbAUX6mCeySa+qNYvktvuvNyTRPY5i/uc+W7
         HHnXm0zZjWt92a8/pO+0l0PpVFD4Dtn/IhwuBMoE8naMDctkDgPCG4KVDJO8LCV+Jpuo
         LlF5w26e4SxAiHzsTMPdGThDWwSA3K1WJqoXZ6UCSupTmncz1y9qGsp6D682SonlJbo+
         r/sgNTPx1Mzvmizv3E/qVTpjZIIhmbZJNatiCbkCKlBQ88GrOEfmVlC2MnCCn9OxndfV
         gTOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfmkkv0939fmcyFbbhenTjcXEf0eX75ltnA9A5u4qQLiDc7JgxauwBvdA84SsslwQEa7LNhGHFceLjkrg7Z+n2@vger.kernel.org
X-Gm-Message-State: AOJu0YxTPR5MB0u3B8ahgtmuXM9jqBxDTBGwk92+ldFImJ5h6hUR/EYm
	8jKsuUqikMLlSOsGUT9nMPH9eUk83MEuTAzeOZ6oRyHa0iNF73MgkiIwpOEAhipSbY8djGyn1K7
	jj2GzEA==
X-Google-Smtp-Source: AGHT+IE9nO+iqokkfm82bAK4mbVT5Uil7PWvBrDlRgIQGKqFunhB43WFpJO35+IDQx+/3jg5ffcPAKWvZ3vt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a05:690c:2c11:b0:6dd:dcf5:28ad with SMTP
 id 00721157ae682-6e247399192mr840327b3.0.1727760219780; Mon, 30 Sep 2024
 22:23:39 -0700 (PDT)
Date: Mon, 30 Sep 2024 22:23:26 -0700
In-Reply-To: <20241001052327.7052-1-irogers@google.com>
Message-Id: <20241001052327.7052-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001052327.7052-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v2 3/4] perf test: Skip not fail tp fields test when
 insufficient permissions
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Clean up return value to be TEST_* rather than unspecific integer. Add
test case skip reason. Skip test if EACCES comes back from
evsel__newtp.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/evsel-tp-sched.c | 40 +++++++++++++++++++------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index cf4da3d748c2..3da6a76eac38 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -36,33 +36,33 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 					   int subtest __maybe_unused)
 {
 	struct evsel *evsel = evsel__newtp("sched", "sched_switch");
-	int ret = 0;
+	int ret = TEST_OK;
 
 	if (IS_ERR(evsel)) {
 		pr_debug("evsel__newtp failed with %ld\n", PTR_ERR(evsel));
-		return -1;
+		return PTR_ERR(evsel) == -EACCES ? TEST_SKIP : TEST_FAIL;
 	}
 
 	if (evsel__test_field(evsel, "prev_comm", 16, false))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "prev_pid", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "prev_prio", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "prev_state", sizeof(long), true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "next_comm", 16, false))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "next_pid", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "next_prio", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	evsel__delete(evsel);
 
@@ -70,23 +70,33 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 
 	if (IS_ERR(evsel)) {
 		pr_debug("evsel__newtp failed with %ld\n", PTR_ERR(evsel));
-		return -1;
+		return TEST_FAIL;
 	}
 
 	if (evsel__test_field(evsel, "comm", 16, false))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "pid", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "prio", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "target_cpu", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	evsel__delete(evsel);
 	return ret;
 }
 
-DEFINE_SUITE("Parse sched tracepoints fields", perf_evsel__tp_sched_test);
+static struct test_case tests__perf_evsel__tp_sched_test[] = {
+	TEST_CASE_REASON("Parse sched tracepoints fields",
+			 perf_evsel__tp_sched_test,
+			 "permissions"),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__perf_evsel__tp_sched_test = {
+	.desc = "Parse sched tracepoints fields",
+	.test_cases = tests__perf_evsel__tp_sched_test,
+};
-- 
2.46.1.824.gd892dcdcdd-goog

