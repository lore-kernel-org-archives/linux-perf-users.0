Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E906D2DC357
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209479; cv=none; b=lS37Ecn0nmGW2kn/7kE82wT70poJhZ04BMPH32x00aHjVgXut7dkad0LDnIxiKQJJbGmPc/T8UhsPM968rVZYLP7MFGbaUzPZbMDOV2vNLrdsLbEz3g5U/VVKxJYN/tV65RXvsTSPju6SYx4sQPvbIRUMLTQe6RILz3ZX9+kb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209479; c=relaxed/simple;
	bh=70Cd7Tr5DNaTW5TJ6LRmaLRDgxUeR2l6vLb66l08QGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O/pBrvvMpAx+I4eI6U1blVT7EA0Xz3ANdW14Np6LhUqyCSPkmGpBwv51v72vSP0zn9W7D6kFimmA+nTFP90Nthhqdo4p9o3lztEE/HI7ctUoIK21sV/wBrw9RR2szQ1ZB8OT775oJ6ghrnfv9EV5QkyPgYtyhoA4RyGw21ovcU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ihtKZW4T; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ihtKZW4T"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1370417c0bfso4872231c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 23:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780209477; x=1780814277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x8eARVF1aEz6PcKrYzAcMJYJ5B598/QhTEDpTebmYts=;
        b=ihtKZW4TR/5+Z2/1EZE/YDVHmGsPpb80TmEKcKa5NbvV+IDClCq6hsrW+t+ca5vJij
         cd+X29zYhpN/O2nkm/sTdBUkbgIm2JEcIrrL/2SQBvvffJS4nUt0Q5HL5B+hk3C6m0bz
         rlvw7z80yKONXjq798XZW0oKHG5EYk5CJ5HaS+G6M4tHMMZOjikeRCZE/VUFmEan/O+V
         /o0gwCYoYLxds/eAdUoqUoM8CWqJqFHdmwn6IJym2YqWaAE6Cce89QZsOOV8yJ3M/0HM
         4gJXEh49EQnGEz/bkMT7X5oPzmnSDYvFkvtLYv8fjaavRBUaALlrWS8jUkYVvintma6Z
         IzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780209477; x=1780814277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8eARVF1aEz6PcKrYzAcMJYJ5B598/QhTEDpTebmYts=;
        b=NbQIpHyOFLWrwgLwZAJb7u7v/rBdfXzaZ8FbFaKQ8LHpsc7PnntqKklcyIwz2gbB1n
         o0YqWz2wCPmmMVZRvPvOj8Gqgd1d+a8lvu43Al9GZQud+7gVMh+d3IBhMsdcGFLTrfVW
         lTDwnJBQFA3BwI/zUl8oJ5hRnQNiz56Z0ngqITBkYTHnt+CGp9ATqn6a2pIL2pbKstiY
         QgVhi/qthyESkNwr4OCEx3IS8uU2kbOGWYEb72N0kyyVLETC0nbfmuPXxAiyZGtxeeT2
         9RFbvLUr4waAIMk6ynAJ15+mek1xUBwZR16X3LzkIoIkPO+awGOB5Qu3swPD8YsEbqzw
         KEAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8VwQ/KatKbzS5XEjNghHd1oILbcvpLFHkfr3rY3W9djNYc+7N7W3jy6dV15NK3ZpS4SfBSMZteXeG3GWiAgW19@vger.kernel.org
X-Gm-Message-State: AOJu0YzSplC3Gps41UNHJwSwvTVNCmhvvA2XKUOfX8pc0Ozivhq7XxrE
	/95obO+Tao8JoLon0MsCHulQz6BAtsTRn38phgF1LiaCm1wRj5MdBNaC0x/OytrrWzV4qFbL4/C
	q2OqK1RPoUw==
X-Received: from dlea6-n1.prod.google.com ([2002:a05:701b:4206:10b0:134:ea68:2940])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2226:b0:119:e569:f874
 with SMTP id a92af1059eb24-137d443b0camr2608888c88.17.1780209476807; Sat, 30
 May 2026 23:37:56 -0700 (PDT)
Date: Sat, 30 May 2026 23:37:26 -0700
In-Reply-To: <20260531063736.871777-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531052740.796087-1-irogers@google.com> <20260531063736.871777-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531063736.871777-5-irogers@google.com>
Subject: [PATCH v3 04/14] perf test: Support dynamic test suites with setup
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

