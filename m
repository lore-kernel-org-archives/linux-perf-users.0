Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1924A33
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272366; cv=none; b=i576Oa0Jb8FngTpnDuywmJ629hc2+QVo/kyH5PT2JsnOttN79O0/DoLn9R5WjQ8KCeqA0Qr34KUN7yoH+CT9imUpkenysyqidTXjlHf/5rNUrjdQSzPiFvVU03+7ScamDpMNHhcAdwPlZ7JppmWw96KcJLZ7KChR+oruF8Fzf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272366; c=relaxed/simple;
	bh=70Cd7Tr5DNaTW5TJ6LRmaLRDgxUeR2l6vLb66l08QGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cu5Iotik+lKveFfcmwTqGZxcg93hgI5zI4oQA0tMLOddLoYYsfp7JbSEHjqkQnEM6xBew3vzAHIaP5W9Q8dKYQIusiLk23YHhuTTjkxH9QEm1BKkt+ztXTKEoW/QaBLXPJxB/hhNoN/rw+DHv/fK6Hqh4Zx+RbGazxgyTWpGBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pzbUSgZY; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzbUSgZY"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13709ab38a8so9175028c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 17:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780272364; x=1780877164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x8eARVF1aEz6PcKrYzAcMJYJ5B598/QhTEDpTebmYts=;
        b=pzbUSgZY2LkIOmY3JFS/3aOb709RXzNDsMJWfV+PCVQstG7SBLZbBboaaaYb16cPD+
         Pm0XNUSh/TGxrTZ9ZiFsBSOlylJMTOKvtOAifD/MHbVk2I/10NK7NiSNneMp0c8H9B9R
         /ZCflFb7vaDEZhHH69qxTNGgb16LvrpE26kjvLwiVk8+15fXNurrZP5nSD/DtTATdSJC
         vxzw5Ov2VoSQOuwJY7/ta1gRxT9mOjlxgN1NfYIjomlM5E3FkUySQ5U7ETKnKNNMLKUA
         T9tgwy+++nG/8Jl74HNKO+vVgUnSZTXS3oqIw70HJ4cWbpctZG8epi7nRdik5/0cxRoo
         8P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780272364; x=1780877164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8eARVF1aEz6PcKrYzAcMJYJ5B598/QhTEDpTebmYts=;
        b=k4uF/asITnXGo8orVZbqD1ildqJmQOtWdPdpn2Bfe43la6+Y1Ls4iWkIegPX60u1Rd
         Wbo3XCSXJ4HxbabUZ0NZlubYfCyni5KfJmD9nWO3bE7KQZ1HO8PnRXw4KhpmUBDIBmhv
         T6yj7bWUCJfu8mCEKpLpJRkdEmr3DJrsWjdh8UuJt6kAsFX9EFAtgS+neaBTwCBiCmyY
         u8e4fIikuf8PRL3m31IHAb1W4NApW+MAapDfl7DqQSppSJHMa/WdQUZZD7SyjknT5U/t
         0723m5mISQaeGBbviBf/9py8AOHjkLzLtVNrOiNMHOPM+1/MOETnB551HlkcVx1PNYV7
         6/8A==
X-Forwarded-Encrypted: i=1; AFNElJ9VmsWOJ55NNQK1oubklqSkngqNiQTpvAPseOGr/zQETsTaSZpni8NfS8cOTamI72o4go3Tz6ynENJO5MvL1Xae@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+2KxZJrACmzeMs01TmgDUcymrzJnnYfE2Y0mmud6OkTUh2lCI
	70SSh/LM/ObSQXGzbZmc9Ylv9WsfximvoKpL1hY/S3FKtHOt4AAYcV7mBV2Gc2tK5p810wgNys0
	Ot1YzLrpldQ==
X-Received: from dlah14.prod.google.com ([2002:a05:701b:260e:b0:137:9bc1:9e41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f8f:b0:11b:b3a1:714a
 with SMTP id a92af1059eb24-137d413072emr3050660c88.12.1780272363553; Sun, 31
 May 2026 17:06:03 -0700 (PDT)
Date: Sun, 31 May 2026 17:05:37 -0700
In-Reply-To: <20260601000548.1195604-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531082235.940833-1-irogers@google.com> <20260601000548.1195604-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601000548.1195604-5-irogers@google.com>
Subject: [PATCH 04/15] perf test: Support dynamic test suites with setup
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

