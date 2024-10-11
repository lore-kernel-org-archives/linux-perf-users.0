Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E920B21A
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632189; cv=none; b=Gxl4L2AwicmdXQsVXOOcHo0oQEaLvNlbEs2cbft4MwJpCiqnoChpjIvTM+Y81b22IvgwfZLK7UeCcF27wqyYHyQR1X85JIelCize/k8P13+Y9LiW0CmeqGJiqfXeCE3nywxnP1yB+AuDKTbEz8FgwDpU1ZRSRZwLXyYgsYWC7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632189; c=relaxed/simple;
	bh=xnAMIL5v413ciitu1wkY24YCgY7LrYNUuSXRkWHF/SY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mVYGk67gOd8kk+AbdmltQqnYPUY8caX98L1aActPm51vdPNWBZ0kO1OypZ/uJx3Mm/YSOG4NNm6M3bIWh0pyo8mCY5h0VOQhzSczl2hPax7uNkdfuCfE22mdq9B+3bEl4KFT6hrX7k0DgfEkwEilmKwhLFtj2cZFbcdJszUIdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EVh7wXdf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EVh7wXdf"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e30fe2a9feso22510407b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728632187; x=1729236987; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sInfOXsK4DHkW3UJ8a7cyPbP0ObPdFBOq3supb45AvQ=;
        b=EVh7wXdfXe0RnpY8nfR5yQqfuXB1hROt3aBQ9TpDmWIFeJKi0XOAlK7GWLBDKA/Elh
         WDDgTnjGWYY+mA/Zl/e8YRHXmcdJ0CtWPGijEVwWkCfRIhHLw+0Tsu1vtjngo1UEa5g9
         wzyA1kqvzpyuado4cXCTXbJLO39OvCmaVlhtbkfsIBceo7wLsOUt3Rqk0fhGGS78OlC+
         +Pvg5b2nnCobNFCwRA0tYwzhtG86Sd09rSDYFFRnRPgha0u3GcEXNMmBuGZsdNTb72Z4
         tMmjcZSj9e2LTFVmVgPYbggCttW+XWwWz7D1o7QInT7F+x0dx8Lcb+SYoTrmC0N3Vb4s
         mzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632187; x=1729236987;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sInfOXsK4DHkW3UJ8a7cyPbP0ObPdFBOq3supb45AvQ=;
        b=wvQnRPM0lXXPy1Hq+w/ZQhjfkowVMK/7eeClfMcNat4zXF/gdVpL6m92eFhNTo3p2Z
         BkTveP5ixuRpBP230GZmdr8++eikvvhxvqZwRVWs9jpjljZLJlA5Ih+Xdc/Y9m4m78GH
         UpXLgg6HvberSHAseFX73UFRexHPSFRKe/QOI8mUvso/iFRZV1Xyk5Vi0fa8gMvTBoKU
         rzWd56U3qQr7/vNk+gbdalJkRtFAqhXxFuXK2xXWsBonoi56zXNwJoUWylZ14T4up09Q
         mlvptChLBTwU/tajJOub6Z72p7/ZIGmpExKOfDm87cPV5bk4Njn/Bsbx8w+wE6z006pl
         yT6g==
X-Forwarded-Encrypted: i=1; AJvYcCXOCMDPNDpxUeG6pGQ2XLjiaXCs4QHuqLbRZqj8Vu85jEU47QHifXE+5Ae+pP6By22y8gpYDbast/N6jD2w7GnU@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1lvfr1186rl5Vdepw9C3/Gx20P8AIu+womiSPb8EtVTFxycl
	M/outWqeXIxq1wXS8OXypVd0s2tC1EEZLuUquEwqESl/2lR8uktIGnN+tM0UXXJW6Vi5BpRJ9cX
	iwUye/Q==
X-Google-Smtp-Source: AGHT+IHA2iTnHlVf+hgVhL9GrhHFp/9IHezt164Cm5YXlEKS9eEEUTgiN/fM/H+2WylpswmvDe7BHPccrB/E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a05:690c:c09:b0:6e2:6f2:efc with SMTP id
 00721157ae682-6e347c52d2emr463317b3.5.1728632187304; Fri, 11 Oct 2024
 00:36:27 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:35:57 -0700
In-Reply-To: <20241011073559.431302-1-irogers@google.com>
Message-Id: <20241011073559.431302-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011073559.431302-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1 6/8] perf test: Add a signal handler around running a test
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 6b8ef198d975..45a31376fdb0 100644
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
@@ -226,16 +227,41 @@ struct child_test {
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
2.47.0.rc1.288.g06298d1525-goog

