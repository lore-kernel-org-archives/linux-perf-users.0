Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193AE13D8B4
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209770; cv=none; b=qA1eAzR/8To8wy7ZNKh/a9my+St+Nlpz8tnNI5fsp/SvcUqQ3mStbGldZ/qCh7OTqybmU/foyaOPc7uj8VIkzA123ehXWanN97WAsrDAPJ14/tj1fNdMc39nStOBQ1WQgx+YlcBSVlV98vYIu9q0UbAvPCh8hHcHiC9kUzkYVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209770; c=relaxed/simple;
	bh=mqhOmmb5D7zCSOmLJGmsN3Tq39WjvR27nLQ5ZPsh9gQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=K7WMXAgjExbd547A0GtEGFX3d8zR1v6jRDhRJjG5CUB2kOxhSnrrR+errF0VAIFFoViVSH3zHQsZNrAQrW27ZLfvQD6EjeDywgJU12kggarpTCT74AKBE3z9xvgDgU0W6kKH8xWi6V0JXAskMR0vunUxemexmSXUPEEqHXpucs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+HyZIkd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+HyZIkd"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ddbaec823eso93622767b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727209768; x=1727814568; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDzgbRV3saEMgHqtXlPW4lWYEn2RBDB7kO3Czm+EZaQ=;
        b=u+HyZIkdo4fPuMlX+2qd8sTU1nIA50hwdeB9dgkqdYR3butbRwr99SqfV+VCpN2pj4
         fq3pCLsCfmPa9Gx2CLWly9e9WFkXxHfte1mHUytNTt47O1h34pUUHfN5tjpD2c7FpzN6
         7F9ewdMZap+hEC6n2jDUOBmk/fCbysjMh2fpFE/lwzc9wtLEesk9KmQL9GSXJHgPoPhx
         R4M1Bsr1ywCyb4ZfGUPgqs6mi2r2sZKdAdrlC1Rjhz+Lzr9LNITPTyDbL6UsCqq2HjNi
         vhCM0m9P92dFnbvF6Xg0BUIXrLZU5Ptt0qxe6nZNTSONs0PHePIfTKatGgiL24DEajUQ
         yPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727209768; x=1727814568;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDzgbRV3saEMgHqtXlPW4lWYEn2RBDB7kO3Czm+EZaQ=;
        b=HMVxM1m8sWF4xvd1KTPHF4ambBs9TKMAeUC12yrMpYlHg68RS8NOgXL/+QAQqBF+l2
         o7R/x0fJgCrSlzAfro/35IDyj09/9t+lkXYKPRX0Ss+RGnzxBYrpj+FqPzBtrqAlOpDo
         kSz0RnJiHoEiY0xiViZHdzrnEDYO3a3E6AKI/QXQORUxR79p+TdqIwqtSYyb5aN4GPSr
         stOLzawNFEp99Ud0HNgc9LhwRbYokSI3vA3otQ2c66HmGFUpcvzav/mqk1zHyujRREx0
         +HjZO/4CL1qdNeFrR7pqIpI7xr2qPDRmGJaRuhJ7gZIQt0sTiQMPAHjA6ymgdxN4y98Z
         lNRA==
X-Forwarded-Encrypted: i=1; AJvYcCX1YGyDcliEoslveNoPM2lBKuNGfRvsNSCo6ch1xKmQG68bSF3ii1lyr+/hKm0ighpN7x6Q3Gfk24P5LanAYP//@vger.kernel.org
X-Gm-Message-State: AOJu0YwpNWQdsrLK0CcDJx0zbYUsYywFyASgJpcf5Yn7LVNdJn6aXdbx
	unbgBOCm47CwnPYPQgDm2LS2U2iFdcVuyE385BZ57L6wm7cYL2Yay0U6s0C8MxfiQtMEGi12P+7
	X5AralQ==
X-Google-Smtp-Source: AGHT+IGznbeG/EIeM/kx+fLQtWIOIBujQilCujxnmYu1O8iIttqTrQ+JngIBgAmfebo5C2ezozKBwiF2Gpj4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:965e:4297:88a9:5902])
 (user=irogers job=sendgmr) by 2002:a05:690c:d85:b0:6db:e107:75a2 with SMTP id
 00721157ae682-6e21da5c761mr113237b3.4.1727209767952; Tue, 24 Sep 2024
 13:29:27 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:29:15 -0700
In-Reply-To: <20240924202916.1560687-1-irogers@google.com>
Message-Id: <20240924202916.1560687-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924202916.1560687-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 3/4] perf test: Skip not fail tp fields test when
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
2.46.0.792.g87dc391469-goog

