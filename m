Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B990312831
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205276; cv=none; b=UWDzirhtJKv/z9vSnVd48kKW/JOe0i8SGFaZhz3J5gRIGl1IUMeX+xsnmRbnNCH9sjChi1sdK6mNwaTzGFcvFyNT18J59B4oLm+XD1D2NcKhvfJdJNmTt470u4Yrz1BEoHtPlWti/kBxnrd4HbNnZz2J9plR3f6Zs8oLSO3qI+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205276; c=relaxed/simple;
	bh=70Cd7Tr5DNaTW5TJ6LRmaLRDgxUeR2l6vLb66l08QGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GmmuEHRWngnWdF7zy19n1H+FzzkVP6+tdheftvsMTxdQop1nu5JACJ5vw5y3LoRZ+Jv8eF1BG0Dq3WY/XmK2WS+Pk0GShtLOsFNGwAYUdj0eEp5ECbStGD0JZy8uitm92M1FyUVxqTTnfGkzGfhw//TJVRf3ykUanxbxt9Ge+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DzGsKxDM; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DzGsKxDM"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1370417c0bfso4857578c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 22:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780205272; x=1780810072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x8eARVF1aEz6PcKrYzAcMJYJ5B598/QhTEDpTebmYts=;
        b=DzGsKxDM43XjL8IM2SLsTIKu2RUpc1uulHs9CWco0GvFqqg1JjEcUK8zEc1wylFl6G
         0S2jck1x9WQe1560zPjdlj2KvTn6jAqM5Fc8Yt2CfjIPWhn5beYPJdpuA0AAdFf+jxcS
         YCRzw8fXs8qd/D3d+nVuiWmaCkEmxbknDl8pQqGot6LngHtvr4YCmVcygiZvZQzC5x58
         5gui3ON+6PWzWe51PpWH0JG5PYQXb+AtoML9+rt8Nno2+ys7ekMiFdphVP4TXzsGYrty
         OlmqePxhFSGp9dNI6mv+6wqYps3EJwrvjIc3NRqcrEv/xhaTFmsHjS7N3DSBx8sAkeLl
         tecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780205272; x=1780810072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8eARVF1aEz6PcKrYzAcMJYJ5B598/QhTEDpTebmYts=;
        b=pmReHYKv82gjeSNK5ZL6Q7DlIJKQQ1ZKKdVTBlDck8CjHatDeqlTqQRSd7ofV2LcVr
         DCMfK0uX4CK0ZXzbMkiD/AHWxydKLutDokpUEr8b5Zw2qrx/bITVMmz+sQZgfotFRcrz
         BF+8l28PxCV4AzMLdX/lc2mmq4U1ty1ufwYqzzGB+U1z3d/WutQToXqy14hGkxRIsBoB
         9ZBbgaTxU5TT7APM4x4QUwb6Uw26kct1MoYOLUNU356pFDtAOy5H72PwholNRAGdhIIY
         KkcWDoSGU7Z31Bk30J3cRPbbAGlOppyKpU54JeaTX4Ud+kzB6CDqJg6ZqqTgpUALuFzm
         n3uw==
X-Forwarded-Encrypted: i=1; AFNElJ9nz8hSaz9VIDvPfYtr6HMsp95SlcGDtND43xpFjbAr9CkRwHwrD3GglisxagkIz29r7iKX4r9wKbZZgr4sHy/p@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23GrZh1vAVHoeYK8nZPt07yLkvKTK8WpFmdgKCTgqjI5eOYK2
	JZsAlsKL7SsUewLyDHhwEv6VTdR0GVuLdAqXtGx/ivfF3Q34bbz9v2tMtTo8PfRdTqsYndN33Ae
	1sElWXnDMgA==
X-Received: from dlaf6.prod.google.com ([2002:a05:701b:2406:b0:136:88ed:65ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4585:b0:132:8e84:3ae
 with SMTP id a92af1059eb24-137d43d2850mr2418849c88.6.1780205271959; Sat, 30
 May 2026 22:27:51 -0700 (PDT)
Date: Sat, 30 May 2026 22:27:30 -0700
In-Reply-To: <20260531052740.796087-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com> <20260531052740.796087-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531052740.796087-5-irogers@google.com>
Subject: [PATCH v2 04/14] perf test: Support dynamic test suites with setup
 callback and private data
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add void *priv to struct test_case to allow passing per-test context.
Add int (*setup)(struct test_suite *) to struct test_suite to allow
dynamic generation of test cases.
Update build_suites() to invoke the setup callback for each suite if
present, ensuring dynamic cases are available before listing or running.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 15 ++++++++++++++-
 tools/perf/tests/tests.h        |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7946878195b7..2ccb52a776cc 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -765,10 +765,19 @@ static struct test_suite **build_suites(void)
 	for (size_t i = 0, j = 0; i < ARRAY_SIZE(suites); i++, j = 0)	\
 		while ((suite = suites[i][j++]) != NULL)
 
-	for_each_suite(t)
+	for_each_suite(t) {
+		if (t->setup) {
+			int ret = t->setup(t);
+
+			if (ret < 0)
+				return NULL;
+		}
 		num_suites++;
+	}
 
 	result = calloc(num_suites + 1, sizeof(struct test_suite *));
+	if (!result)
+		return NULL;
 
 	for (int pass = 1; pass <= 2; pass++) {
 		for_each_suite(t) {
@@ -831,6 +840,8 @@ int cmd_test(int argc, const char **argv)
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
 	if (argc >= 1 && !strcmp(argv[0], "list")) {
 		suites = build_suites();
+		if (!suites)
+			return -ENOMEM;
 		ret = perf_test__list(stdout, suites, argc - 1, argv + 1);
 		free(suites);
 		return ret;
@@ -863,6 +874,8 @@ int cmd_test(int argc, const char **argv)
 	rlimit__bump_memlock();
 
 	suites = build_suites();
+	if (!suites)
+		return -ENOMEM;
 	ret = __cmd_test(suites, argc, argv, skiplist);
 	free(suites);
 	return ret;
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index ee00518bf36f..9bcf1dbb0663 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -38,12 +38,14 @@ struct test_case {
 	const char *skip_reason;
 	test_fnptr run_case;
 	bool exclusive;
+	void *priv;
 };
 
 struct test_suite {
 	const char *desc;
 	struct test_case *test_cases;
 	void *priv;
+	int (*setup)(struct test_suite *suite);
 };
 
 #define DECLARE_SUITE(name) \
-- 
2.54.0.823.g6e5bcc1fc9-goog

