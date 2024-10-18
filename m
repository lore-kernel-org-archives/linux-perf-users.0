Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DAC18873F
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 05:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230464; cv=none; b=iIxunPhFxyMh3Aco+bVOT2j/mhZlz10lkRCLCJkUz1IZ3z5BZY1a+4MKXmB377qjVCw0D+iYtr0zoWu6dvMdNcYV+v3FBjLs2Exg6NDqSrqBskAsABdwFlrORmx6phI7buzU1DsTytJSoAVEnqySnsIIG5ZfmZQ7PxEEBnnwqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230464; c=relaxed/simple;
	bh=k0BOXCGZynGmVHFfSxAt15i/jsThHEDa9Z9xA4vwOcU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=maslqMJuM46z47+TSnPaYHR7p9uf5wu0t4Kkwe89DMjOkdwK2hbGoppp/ZfIO+x90F5MHXXVmupq8haZb/UaUaG4fmK/f7ZWne5W6dDW01asCptv3E4T/MfX4DEjtcQNOqHc9rBgNyL+mH/E2BfPUpSW2rwYIM8vgK+42LgSKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fo1c46Et; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fo1c46Et"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e291ac8dcf3so2780930276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 22:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729230462; x=1729835262; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RlqOyFIbRvuFWfGY7KqjkQMxIKLW0DMuZ9kuTzuxI/g=;
        b=Fo1c46EtcAO3pPFLwMreKRY2ay0ipVD5UQDqlZfASoYQKxJoyOrssMRFUPOQMQeGr0
         2mWx5l6J8qnOyGBN8IvHLOE0Knfvs8lj4NRnHZGSxoXj6G90PN1e8fJPAEJfHzFZWJJO
         EbcCuCKfLBW8/ypqddvkNCN87hPMgnyjf9ZbC5El7DKWoL84dA54fMEQUiU7iWdCq5XV
         QSs2abtp4276eqpWAHfdVKlVsKhlQoJ9cVVSwmtOZOFD4Zu2nAjm7IbIv3RdlEu3QAkb
         eSubFqSw6kcdi2W6Tn9PghwKeiKGKd79ed/Ae8BYFSpMEBY63oeUL2tXdpw05SCdmpe2
         1xVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230462; x=1729835262;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RlqOyFIbRvuFWfGY7KqjkQMxIKLW0DMuZ9kuTzuxI/g=;
        b=pwACgxNtg8T/PVVsonlecv6qOfCsm691yC/tpkmMqSadrp0IyfJjo1IvuaTG3bY0ot
         7ePNCw6+k7+v3GzCLQrYUa9gsgF2g+vXfzzcYVce+fOpP6N6brjZgkSLJ3JPRY+EI2nb
         ZD1yEB3SkWqvHIyggW7cN4s1RZZajnVboD/hAqyksr5Hxv435N3oNAriy1HX1bgcCU17
         RSl/k6kKb+8dqqkx8SS72lzihtG7tfK4LqEMJSkz0xn5Vo61xNPTaavm9MSu2Vh8vXn0
         xfrdxXnVJpUqNFl+oi3rCt2jLi8bG/a+IJyJ09BaR6IoeyHwsZ1BVJKAPwPEiQsMPN3a
         MDTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0iVXgHAFT+oEew+Pc+Ci3KguQ30nD5Lz8oKwDayfTGAACTXgGDlYUNLGp9k6pNiKRoe4a1ChfZK3FqdCFY9sc@vger.kernel.org
X-Gm-Message-State: AOJu0YyhJ5NnPIuOZwkVdJtMyYUULLovSzAS96tvJr7//uhHM2QzwG7W
	XY22Z85HT3z4lp93C6gteUBQDRRwERBsE4vNKRZCOqNX9b/YBo0JekYy5JJdqIJgLCM7lq8Omjz
	vqp/MmQ==
X-Google-Smtp-Source: AGHT+IFEZkKpnOQlkP6vldZgwtko866JrioCfyYPDfy2d1AJe5t/D3hNGzKduhx0GSV7SGg+9mfCQAy0lhQ1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:30c5:9d92:bcd:7977])
 (user=irogers job=sendgmr) by 2002:a25:fc07:0:b0:e29:6e61:3db4 with SMTP id
 3f1490d57ef6-e2bb11cea47mr3154276.2.1729230461616; Thu, 17 Oct 2024 22:47:41
 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:47:16 -0700
In-Reply-To: <20241018054719.1004128-1-irogers@google.com>
Message-Id: <20241018054719.1004128-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018054719.1004128-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 6/9] perf test: Add a signal handler around running a test
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

Add a signal handler around running a test. If a signal occurs during
the test a siglongjmp unwinds the stack and output is flushed. The
global run_test_jmp_buf is either unique per forked child or not
shared during sequential execution.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index db6cc83ba505..f8d6477c3b0c 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <poll.h>
 #include <unistd.h>
+#include <setjmp.h>
 #include <string.h>
 #include <stdlib.h>
 #include <sys/types.h>
@@ -227,16 +228,41 @@ struct child_test {
 	int subtest;
 };
 
+static jmp_buf run_test_jmp_buf;
+
+static void child_test_sig_handler(int sig)
+{
+	siglongjmp(run_test_jmp_buf, sig);
+}
+
 static int run_test_child(struct child_process *process)
 {
-	struct child_test *child = container_of(process, struct child_test, process);
+	const int signals[] = {
+		SIGABRT, SIGBUS, SIGFPE, SIGILL, SIGINT, SIGPIPE, SIGQUIT, SIGSEGV, SIGTERM,
+	};
+	static struct child_test *child;
 	int err;
 
+	err = sigsetjmp(run_test_jmp_buf, 1);
+	if (err) {
+		fprintf(stderr, "\n---- unexpected signal (%d) ----\n", err);
+		err = err > 0 ? -err : -1;
+		goto err_out;
+	}
+
+	child = container_of(process, struct child_test, process);
+	for (size_t i = 0; i < ARRAY_SIZE(signals); i++)
+		signal(signals[i], child_test_sig_handler);
+
 	pr_debug("--- start ---\n");
 	pr_debug("test child forked, pid %d\n", getpid());
 	err = test_function(child->test, child->subtest)(child->test, child->subtest);
 	pr_debug("---- end(%d) ----\n", err);
+
+err_out:
 	fflush(NULL);
+	for (size_t i = 0; i < ARRAY_SIZE(signals); i++)
+		signal(signals[i], SIG_DFL);
 	return -err;
 }
 
-- 
2.47.0.105.g07ac214952-goog

