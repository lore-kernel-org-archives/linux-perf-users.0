Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9610E2905
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 05:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729142515; cv=none; b=nP88lMk0mMlRsgbc/O5yaITpFGkKlWevgWd9EJYceWJ3XiopotOfDLeOuuZltL45wLTK9ViiPAT0omszuISQ0e3qy118etZBBplNRXD+Tmktt5V6XzDKuksF7GRf9nNxQ9mLGnDtLlIOi3g0Q7LxPXAgdXsNwy5BgoT3E2btxYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729142515; c=relaxed/simple;
	bh=xkntsTyW214McUZOI4YK0PdX88OTCnH1vIdM2rrkYrU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=FACA0z//y5RloXikPN5CnQo2RPD/JYdPVifqqMVdmH8Kyl2jfsmuEUoo4I7D6a97MioV8++md53pQ3fVXt2dn0l/9VVGPOK86NOrKwURpOCjYnTsw8M4+ltIG3F3+CdHC9beSQXdWpIl1jnc40DS9iiL+9fWSdecnf7nd5vuhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YxrsrTsn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YxrsrTsn"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e390b164c7so11397657b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 22:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729142512; x=1729747312; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/pHJ2/jYB0ZkRftk8XT40WjO6Pb9plA13uzt50byz9E=;
        b=YxrsrTsnKHtmKmWfKJx6z9ivdLISuC+n7g/szog5ctcOSkRWsNomgLtDemQcDiytvs
         FI7byPPepDbFQjPM1bK9zjyXSKjWzj3IISfl/oekrCIrAsC7EoXoGw6OTpurLrDkTS3q
         a1HuYZp8YLLtTzxevEhLvqg8mSVOq2i11LUyt9egSjbr7lQIMzO1FSXSXF9x1qkYvbuB
         aJ39z+CgnpqAF9d6r868itWyUemDoW18iRr9u1m1qFFbdSzvl2i1Mh5TtepaIItkRwHs
         PojEO4fTIZgv591CC/4t5SMUnp37WTt/fG17NseH4dhPMxFHkqrNmJ1BPVSAWwH+krrZ
         gwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729142512; x=1729747312;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pHJ2/jYB0ZkRftk8XT40WjO6Pb9plA13uzt50byz9E=;
        b=mduuj6g5KYnv5OBl6PvppNJyx/5Dt3gePYCGG6As+pqBT0qfqf9of5eroshopguGGx
         u5x9j4b/K3HeVsmJDXAyZkTMnZZMP12bikWOeN/vAxgUQYZEAh2yezlXZHFsAx2SPykM
         EskO3t0jEw9ZtC98EdwVEK6ZMvib0VwYNqLBLJZLTb9wqCQJ1lIEir+FYNcvk2NqxY+P
         pRjlFq9De7pmLZ6SamM6GuhbErhW9LVCarKf+ZTBSLKU4eop1JIi5CoZ7oQ6e84IZwtD
         CXFHY0oZYVcuCc1tOZUyemR5QLExlFHAagwzPTgFBuchm846PnFANwS5SMm26UBptUwM
         Uj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUboYR2WqrGBBjU+iQyhmhzGOPV+u6wytBirt2Hpf6v5FyhO45BgTau+Cj4p5LjF4i1QtpjO/oQA3Tg6KbsZW1j@vger.kernel.org
X-Gm-Message-State: AOJu0YzhyjwXV44/nCD5kqVfH0qbcgapxy96Tqm1mlCLR6tZ0e9O7mg5
	k4t0INxopPSBE+Nc3qTCp0YgU5qhBsWEBmv1StZmKUCSz0Q/p5T607aeZKBzbJu8TJQ9WOEuAX+
	SQtYx1w==
X-Google-Smtp-Source: AGHT+IFx8038/Nn1GMMW99JA4rgv+GkI2D/hoWH0ohWCXwjlgYSNRt1ck55s/92JZpdrRJKxcd/rbvUywVcL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:690c:6906:b0:6db:c3b8:c4ce with SMTP
 id 00721157ae682-6e3d41e8dbdmr799607b3.7.1729142511774; Wed, 16 Oct 2024
 22:21:51 -0700 (PDT)
Date: Wed, 16 Oct 2024 22:21:37 -0700
Message-Id: <20241017052137.225514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v1] perf test: Add a signal handler to kill forked child processes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the `perf test` process is killed the child tests continue running
and may run indefinitely. Propagate SIGINT (ctrl-C) and SIGTERM (kill)
signals to the running child processes so that they terminate when the
parent is killed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
This change is on top of the 8 patch parallel test series:
https://lore.kernel.org/lkml/20241011220354.756798-1-irogers@google.com/
---
 tools/perf/tests/builtin-test.c | 34 +++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 09afe884a987..5c93608e9a75 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -469,13 +469,22 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 	for (j = 0, k = 0; j < ARRAY_SIZE(tests); j++, k = 0)	\
 		while ((t = tests[j][k++]) != NULL)
 
+/* State outside of __cmd_test for the sake of the signal handler. */
+
+static size_t num_tests;
+static struct child_test **child_tests;
+static jmp_buf cmd_test_jmp_buf;
+
+static void cmd_test_sig_handler(int sig)
+{
+	siglongjmp(cmd_test_jmp_buf, sig);
+}
+
 static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 {
 	struct test_suite *t;
 	int width = 0;
 	unsigned int j, k;
-	size_t num_tests = 0;
-	struct child_test **child_tests;
 	int err = 0;
 
 	for_each_test(j, k, t) {
@@ -499,6 +508,25 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	if (!child_tests)
 		return -ENOMEM;
 
+	err = sigsetjmp(cmd_test_jmp_buf, 1);
+	if (err) {
+		pr_err("Signal while running tests. Terminating tests with signal %d\n", err);
+		for (size_t x = 0; x < num_tests; x++) {
+			struct child_test *child_test = child_tests[x];
+
+			if (!child_test)
+				continue;
+
+			pr_debug3("Killing %3d pid %d\n",
+				  child_test->test_num + 1,
+				  child_test->process.pid);
+			kill(child_test->process.pid, SIGTERM);
+		}
+		goto err_out;
+	}
+	signal(SIGINT, cmd_test_sig_handler);
+	signal(SIGTERM, cmd_test_sig_handler);
+
 	/*
 	 * In parallel mode pass 1 runs non-exclusive tests in parallel, pass 2
 	 * runs the exclusive tests sequentially. In other modes all tests are
@@ -559,6 +587,8 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 		}
 	}
 err_out:
+	signal(SIGINT, SIG_DFL);
+	signal(SIGTERM, SIG_DFL);
 	if (err) {
 		pr_err("Internal test harness failure. Completing any started tests:\n:");
 		for (size_t x = 0; x < num_tests; x++)
-- 
2.47.0.105.g07ac214952-goog

