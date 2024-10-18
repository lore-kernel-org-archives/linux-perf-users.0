Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADEC18A921
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230472; cv=none; b=OvSYY/0CIDTL2fDLld7y2fiFdlANEH935qYHeUHSnvGbhcucvv0aBf1SGXGHuggQ0NE8yuEy27f48Q4ypTMEyXxxd8MqhsUDzN46eGkky9yVJB2FpFQLFBAZhtufZkFdkLF/gJRV5IbeYgAIYcJk+LkPreY4nDuqdlsdnPXvkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230472; c=relaxed/simple;
	bh=5W+gJCgn/iqQR+0OXY2i27BEZMd24fFR3rEA7huJPM4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gGFP5INCCQHIPNsvSyePGy9/FhsCX5QsWxzyTNgJgOhrk8q4WkjjKl2DHG9IFILY5/pc9Yra+0z7tn07bCAgmSQjvdIjHr2MGrFARyBARWUB59qz09hkGRJhr1KYbs80edivPbreYeWIEzk64b5f+RSQCjG2GALJk6AZmqqJE1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gN1s6Buh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gN1s6Buh"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2928d9e615so2676299276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 22:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729230470; x=1729835270; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQvCceMrlghIZnfCb5WUSYCrB9JkcNmVyoorIOTc2vc=;
        b=gN1s6Buhq8I2Uk2Pt0ZXTFhpmXxlhpxa6Ua/feM1LZI6p+e0fHwmqMM1RFtaPmQPTE
         p6ak36HaUDSOBD8Pet3lld9AFu5hwtDSm6Q1HoPfa9ZavqbaTmALOHD4dfQltGFY+T34
         UBz0+jiDqEwVCl97+zKLitHATZPn950uKi0AygY+kEJ2uMBDYmIQFslezJB6S6NDTUQt
         ToE6UDaiPvMK1tu/QLymBl49YFscHF70MbqKME4LSxRTDiXdo1QbR/fBsifjinEoAQkh
         SX0BsR1eYf6fEynM/ujdI4uhrX5mzIo8ABNglP2ExUXNBwvC4ERTiSZ00Zf/eaEU4Nmu
         /hnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230470; x=1729835270;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQvCceMrlghIZnfCb5WUSYCrB9JkcNmVyoorIOTc2vc=;
        b=oIQ4rJM8xvmqheu1H3TZoy6UfQu2xOFflIqOpf2AjS7UEpHFjJjzo69P5WysIqNtz/
         pEYF/jZaPYgOondNhYICmjGdjd8w3RpZBk8raKMC2PXGoZXDqyFjP+uqyGajf0mDqvWD
         krZdjzkygZGB5HXUG9Jz6PJCzkUodzZhbUHKiLz8o2tGe1nULv2CxAr929RUnTJDYVXQ
         0+KIDzR+p/LdRc7buKq+5DPQMfMGPJjEa8+Sjg1jeJbrog8DxJ6WOXJNWduynzkSLR2/
         IJFzrXi9A2VTkOdqO0O23EE/WjTwT13LKfG9KsOjI9rN7KU9jlZqtcXRnShtK396YRSp
         hvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzgRQ9BXOU0MRhs5wFK+AChiYK3btvcKTkFUA+SmDtrbSBVBy6mdJkB36HFP8lneVeERNjbZL/mfrRn+zfzYQR@vger.kernel.org
X-Gm-Message-State: AOJu0YyUORPbD3u8SGBk9yT+yQlTjQhEH4J3N+KogDVndk18sfMsbqRH
	BqEI/fuFZLst9UjfbrhCMS4p/qd/WBx+NeVfWxtU5P4MwriS+fUapWVVKxnvO0uebOkegev+KLg
	oDScnuA==
X-Google-Smtp-Source: AGHT+IEetzZbv6xKhA7Bjm58oK7gBLuLrdE7VQtAkXXBp2zVdlHbeXhsBPD8UPUb6aKAm0dZbINOr2lcVA4U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:30c5:9d92:bcd:7977])
 (user=irogers job=sendgmr) by 2002:a25:860b:0:b0:e28:f231:1aa8 with SMTP id
 3f1490d57ef6-e2bb11b3e9amr3380276.2.1729230469360; Thu, 17 Oct 2024 22:47:49
 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:47:19 -0700
In-Reply-To: <20241018054719.1004128-1-irogers@google.com>
Message-Id: <20241018054719.1004128-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018054719.1004128-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 9/9] perf test: Add a signal handler to kill forked child processes
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
 tools/perf/tests/builtin-test.c | 34 +++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 78ff7862845a..c4b6300b0212 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -470,13 +470,22 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
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
@@ -500,6 +509,25 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
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
@@ -560,6 +588,8 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
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

