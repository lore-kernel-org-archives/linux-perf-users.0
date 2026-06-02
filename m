Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FBD381AE7
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385514; cv=none; b=UXr4Rum4B5hirpv+UdvqZkI9E+n5RO80jaDJ/5v+EHmahF1GiVedVtFagPmECCHagC3UplD0fv6fT5p3AM4XxCp5HAQrRpGIFWSc/a9VzU9mGkdKN0WtzwaQtRnnbWdNPhKSCaXcGLm/h53nVA2Frgeu+gPUV0+li5i5Ip3zYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385514; c=relaxed/simple;
	bh=mEHerDP1++opy8FyGsbuBHUJm+qBAzla9yXOjxT+n1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V+3k/E8z4nzCmadmfbxPvIi+MJejLsUynSddQelJ2GJtDvxVo8CpARmggQzpKYAFoB+F3LOwAoHD69OQVxomXxAVQ698wua9IObNlWJ/CO3bGHuMqZwu++y8ekr42i9mvaSEBySpd/WLzBNEMvo1g35FkX757l6/4fxA0H75/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mmj6E8OQ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mmj6E8OQ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304ea1eea05so11863871eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 00:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780385509; x=1780990309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMAmpupralEEXdLFpGMCVqRubuVkIMhVdyqS5bCiVVQ=;
        b=Mmj6E8OQmi4wBX+S9M4UDlIFaEtvmPAg0t87hgCu0FLK/zxpfh1YcWt9pGfaRJnVq6
         c17GG7hppJit+ktsfd9Ew7MVbYcBYthpv0IHR/U2nnGMxinAlDFaDzwBsquL26BP6H+c
         RqqMc4oi8B5M5ajg2uxV+6RWfc0FiMUR35Tg+lsKrqg7nthDUaYBnues3oZJwGWP9zDz
         2eHyzlbUBXyqRD7yZqAMmckGQSXwRw5dg+o/k+oc4pCzHk8p+Y2pGvD35M/Fu49uGO8G
         HDg2j0coejcqgA9Z2flqNzZY9DUWlEpw4H2IsT2WWKkBAuwuFpiLNqaNAvGtQi2mIe+X
         37rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385509; x=1780990309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMAmpupralEEXdLFpGMCVqRubuVkIMhVdyqS5bCiVVQ=;
        b=R8SdgqkOedoWJSQjoHQiW5KgFJ5u9sTp8b4zHN+GehbBwuxB0ObJlPf+OzWw+vHQ7M
         ljSw/9Qktb3bQj7pzB3jwbCcc2ysTG1YL2zz5kkCz7R75Z1Fwbrc6hjMJA3FA20xnMyi
         z9PDanAJ3GLzma10pDOJcF+gJzuaINJ6wpn24e9ERGtIqCwV6/9BW/dJz3Bbes7pblid
         QWH0Mf/MMWc2i7zIlDAn0MxlyQoda0Kgco57N9qGQIB5rldrHTZoZYpnfjQB8mAlEAoe
         /iGQrC+ur7Zs6P4ZrBPaj1sxyeRFtDdXLCIUeCnzirVpr+4zp4CtpoNaU4igEHNPfeaJ
         1A9A==
X-Forwarded-Encrypted: i=1; AFNElJ98HC3t2ATQDGC17qhnR2/PMtXLrmpvldclGdi/LtGmm5cEgHBe7ofbyQybZXNTv5vQg5AyqolUjF7ZEr1r2tob@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQp1Pn0h1rf9Onp9SWqKb6b1PSy7xoYAGAGT/QfZZgPcXoWmJ
	3TRkGxCiSKbQIdH0b/AENZ8b8iLoVWskaKjmriEPBF+VCO9033LfZdfKKanNsccCX0JfKDwfsEH
	6lgCjVfgJhA==
X-Received: from dycna11.prod.google.com ([2002:a05:7300:ea8b:b0:2f6:cacc:a338])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1698:b0:304:e865:f7d1
 with SMTP id 5a478bee46e88-304fa74349amr7066793eec.25.1780385509303; Tue, 02
 Jun 2026 00:31:49 -0700 (PDT)
Date: Tue,  2 Jun 2026 00:31:20 -0700
In-Reply-To: <20260602073132.2653307-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601061401.1541457-1-irogers@google.com> <20260602073132.2653307-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602073132.2653307-6-irogers@google.com>
Subject: [PATCH v7] perf test: Support dynamic test suites with setup callback
 and private data
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add void *priv to struct test_case to allow passing per-test context.
Add int (*setup)(struct test_suite *) to struct test_suite to allow
dynamic generation of test cases. Update build_suites() to invoke the
setup callback for each suite if present, ensuring dynamic cases are
available before listing or running.

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
2.54.0.929.g9b7fa37559-goog

