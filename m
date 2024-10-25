Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF24217645
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884090; cv=none; b=aZ+N1g2aj9FNz/4KorDc8MkRMVu92YUEvosfJDW6GxyEgbIKibop1+IjELUJMlYs1ZwShfl9MR0wIUfQ0OF1QinfrXVcDTm3U7O6x4gZfTMd9kRA/pOaUU45cC9I/NtLznuCVafsjVEcTiBI0OBD7cQpVf1e0JO5CWKWXD4zTnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884090; c=relaxed/simple;
	bh=6/uo9WKPPestWRkUgwt62AoatZhqYZAbu5e4hou0/hQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Z/XoljGjgHfVsHiHNekAoOpV1LRaz7iNOmdzX/wwqNOJIyaBviSaiQKhz1KMg3P+ws2qgHI1wJSJ54dUrcq5wF6YKbhSIe64DzQUWI2Ui8/ipIx7x4epl091UAawCf9fE1xJG41xZhd2PpyDtiZw/foc4H6AbxtyS3i+dWVJ41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w8u7W6xd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w8u7W6xd"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e390b164c7so39394867b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729884088; x=1730488888; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2kvdOK9w8weA25EuFrzrtnTE25b0PHQYq3wUq/HkXk0=;
        b=w8u7W6xdbR17SQkwDtA1nG+yClyFpgnawzBRna7r/Lksk52OeL4zVqEqeqMZXvyIfI
         kDnH3MHFbxfamzqbFHeUJJmiXqTiNqN2qsJk8iFzXivIJjNTS9XFMf1n31NCzwEWpEgX
         PDWMfNt5Ny2AVeR1gI3RHghaOo5kVNrkjHfLVcZRCVuHsEgFO4v3vNQr2HHYQC3ElUsf
         hlcxIiNEq293LiXEj9lIueqpKqKNSlgpasm9C6gQWPGrSUQp7BJ8b8oL9GfGoNCDy5mG
         OZOztw2EP5JDMK1tN+PZnXY3SWV6LSnqNMjuWMJaap0R8H2W+UKYBVeN/3ZAzkzk5IQq
         VdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884088; x=1730488888;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kvdOK9w8weA25EuFrzrtnTE25b0PHQYq3wUq/HkXk0=;
        b=AcSMWt7Kna0dkKdlbvVr0O9FBIQoshch32y4lDaD2uafzLxPydyh33k7xN7/KG5Xbj
         F/6JCcYEfp3BtNjNvf1VcYgYAvq9XrUP0gMJm5dneOCRmaF+OtlLx2MggWbakyf7AG5w
         QICD2XtyPKWzndHtCPGajUqz6FGXaJJP+LE9j5IQbuIJz4oLFaucBCgRG5QP9/S5a4W4
         R7xix1yuBoiX8MWVadSvIPRyiOJqezxnho34vs55ChhUPy6R+WKsRdWSG6AY7sgKxUKn
         xjI+wFE1Wh0VNiLAnJPgJJH3UnVI8vbE6U08cb0Ljwbbur7c5KbKTTpEmlJiWUci9zab
         GH/w==
X-Forwarded-Encrypted: i=1; AJvYcCWaK9Tn0V8iByqIZuQ/Nx6KUn272WbnoDXMM4Pki57hxbNyq39p0g5plwV1ugY9jw3K3rHrdYiKAsM7+W6xb53R@vger.kernel.org
X-Gm-Message-State: AOJu0Yw20eW+WN+OBpo1l5qVs+dWMaSpJzBBTeeVIBjXn8enW38UKer1
	tVOf9fSkpVvHolM5tosbTZ3D5EPd5J55L7zSdotY9gkxz/F8WM9j8eVbLMhH7kb44p+tSNFgSTh
	LODL/5w==
X-Google-Smtp-Source: AGHT+IESVMuv1epsLSkwRc7et6XBTVDRIiFvKtPLgYRjxZnXzGz2p12sGQhNRFH3RMqICzEALMwjgUKG1WUu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:690c:6686:b0:6b2:3ecc:817 with SMTP id
 00721157ae682-6e9d8b52a7amr218967b3.8.1729884087794; Fri, 25 Oct 2024
 12:21:27 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:21:05 -0700
In-Reply-To: <20241025192109.132482-1-irogers@google.com>
Message-Id: <20241025192109.132482-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025192109.132482-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 06/10] perf test: Add a signal handler around running a test
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
index 0e8f877f4b1f..8a720ddb0396 100644
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
@@ -229,16 +230,41 @@ struct child_test {
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
2.47.0.163.g1226f6d8fa-goog

