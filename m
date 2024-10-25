Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10976218939
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884098; cv=none; b=pq0+JqjjDQGVCOatlQJj9O2dnoTcxckR1FPLrPOh+m6eKD8Mm9A97rR+ffdpd5tqxnCHsce368hpzbhGE2zS927t5RI00vZLURPY0ANEzn3qm7OzH1yE+GC8dmDEnlDV8mGJwecDEeCMC3BuaWmtir8K0z3YqaXU8K3B0jMwbws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884098; c=relaxed/simple;
	bh=ghMU9Vl1129d7aWePglqRYfdFpvshxaCpGvdUmoT8T8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qJlhResgyW/J5KZ7mGhU0ul2oajp9SpDuUueYgGGi1cw0fbxoTeHNSKR9WkvCQZBTmON5edju8FGtBETe1cCON2qUqgTdRM+044JdS1TNvkii3yJ834ZuMMBDOahLIjNok7AkeWtOwwEIshHCIhuSLCu+jqwoPO6f7Erp+5qcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwpLy51O; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwpLy51O"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02b5792baaso4548961276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729884095; x=1730488895; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yEEHJhH62aevzqc8qsynaFFtwxKyovj2FfawNsxdzTY=;
        b=MwpLy51O7t0LbkS/BCrW+ChfTWBYkWWXRnp9DHnn5xPBx4KPL5uAX1U3RTnWJUUyB/
         4jwr8CeZkQwgt3ZzUWmflbJJqFOGbJ34kyQ0xNI7Cp+Ryi02eC3zk2a/Nhx8yc/boc9p
         BbOWa7CJMzyJHUg4g80tinIUJY5sslmLLky6bWh6K63MpUjWFlLswROiIu4hBzqq6I9y
         GjWMnLatXJkicOPM50c0tg+80vg3jjJQNH8F0z6RlSPqDBft6H9+P4LZKQtqn9voxxXm
         8/OduGo2gwm+k844fdCveLgtI0pxqR0SzBl29rTQlXbuX+CrXLnQt/vGsyNxaWmf8yKS
         iMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884095; x=1730488895;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEEHJhH62aevzqc8qsynaFFtwxKyovj2FfawNsxdzTY=;
        b=b8AN1+obXxpB+pnJyZwd+Urnmc4LJJXUXQnSxOK1uuF5og4tgD+WD2UYToHVrixqsl
         zbC0FCfHiu4BVK3CXeoujmuG1Erww4YSIq7I52/6B5hxAhBzXcjVtGxaCrdl3f7NBXtf
         RnTMxAMWYZUeT/IG9jPaZGZCYZwhPuAVygMMjZEVUeow9d6o8T+JXiagOy0CtCQqTYQ0
         Izw2HuMytr+/yv0vv4SnnVVUcShSFUf/BD0Ri8zIoJx3Wl15j4CyzG52M7iwYFDPDJJc
         RGrZ1zSYRn0OScA9U1L9U8fQWa1EO5O2jb+PzdkSA/b1vv2bmiLIZiBPKk1iiUQN5Alk
         wLKw==
X-Forwarded-Encrypted: i=1; AJvYcCXPzlJG6X57/XBpt87vpxufn8KKLVNiFUuT1Br00mO9aOeMRuBB52+VdpCJsKurDDrLj/CAXN4HEa6ATYxHSxji@vger.kernel.org
X-Gm-Message-State: AOJu0YyxwD2hyJOUwylPT8Zb3M5LQtnridALNqmk7DQCK4TILxA5O9fs
	zfi3xpt7H/94E7EkSv8/dB59ecwl/kYA72FVjWv2rnUN5CJ2r0NadPpUTjByOScnziHX8dmhu3z
	82fh4pw==
X-Google-Smtp-Source: AGHT+IFVYQmqkhyHSys5ICdQO9t19XsKgLF71YdqD9HgQlqwwWQFFEgJMJdd1H5RXJKM8uyKH8UBMdYA9gd6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a25:b28e:0:b0:e29:6df8:ef58 with SMTP id
 3f1490d57ef6-e3087a5bd64mr3201276.4.1729884094762; Fri, 25 Oct 2024 12:21:34
 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:21:08 -0700
In-Reply-To: <20241025192109.132482-1-irogers@google.com>
Message-Id: <20241025192109.132482-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025192109.132482-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 09/10] perf test: Add a signal handler to kill forked child processes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the `perf test` process is killed the child tests continue running
and may run indefinitely. Propagate SIGINT (ctrl-C) and SIGTERM (kill)
signals to the running child processes so that they terminate when the
parent is killed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 37 ++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index a0a678facc45..2f880f48cdc5 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -472,13 +472,22 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
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
-	int width = 0;
+	static int width = 0;
 	unsigned int j, k;
-	size_t num_tests = 0;
-	struct child_test **child_tests;
 	int err = 0;
 
 	for_each_test(j, k, t) {
@@ -502,6 +511,26 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	if (!child_tests)
 		return -ENOMEM;
 
+	err = sigsetjmp(cmd_test_jmp_buf, 1);
+	if (err) {
+		pr_err("\nSignal (%d) while running tests.\nTerminating tests with the same signal\n",
+		       err);
+		for (size_t x = 0; x < num_tests; x++) {
+			struct child_test *child_test = child_tests[x];
+
+			if (!child_test)
+				continue;
+
+			pr_debug3("Killing %d pid %d\n",
+				  child_test->test_num + 1,
+				  child_test->process.pid);
+			kill(child_test->process.pid, err);
+		}
+		goto err_out;
+	}
+	signal(SIGINT, cmd_test_sig_handler);
+	signal(SIGTERM, cmd_test_sig_handler);
+
 	/*
 	 * In parallel mode pass 1 runs non-exclusive tests in parallel, pass 2
 	 * runs the exclusive tests sequentially. In other modes all tests are
@@ -562,6 +591,8 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 		}
 	}
 err_out:
+	signal(SIGINT, SIG_DFL);
+	signal(SIGTERM, SIG_DFL);
 	if (err) {
 		pr_err("Internal test harness failure. Completing any started tests:\n:");
 		for (size_t x = 0; x < num_tests; x++)
-- 
2.47.0.163.g1226f6d8fa-goog

