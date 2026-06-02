Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C83438BA
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422117; cv=none; b=OIOEk9zuz4LbbAuxvnic3mRC9FUQy9a/3PFNq72/Jv9qYU0jzWTSY0Web2m7qOxY95sizS6kgbRShjxTAgeCW2Kb4Zr+MVN0Nk8qPUGOT73EilH/isxll1KE8B0XB2F8Y42aNVgMRKAZfZGrKpYjrRKXFnfRxiOx6wmSASzO7gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422117; c=relaxed/simple;
	bh=yOIBlf72jA48mjf589w2ZAWU7HHMLckXT75Zq2uwsSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rMZrzgZDh1B8F5bdfUCq7Td3r4UBDlmFiKlU1ATMp0Ol85tB/htv5pFvdigk7pAbK1+E/z00qzISP3nDi47LNYtogAutlKN/4qeOdXIvESBxo4mDG9VW/NmiRUUVyD/a05QZfbH4ldUZ5xM5fTWv48A4e8MscX0yngrUTbDJunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Peb9SolQ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Peb9SolQ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304d2447962so3764388eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422116; x=1781026916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPCq8R2iFDOBkRBVDOMhdJ7tVwFyybPPEZNvzTbgMro=;
        b=Peb9SolQUQ4bmxIuxvzCrEw7nBPPrMigDEp0lN9T5smuU8C71qcpxyZt73/IRRfHUb
         JhyLc80nil/LIRMOC3zIhcqyXwzo7FVPrHiLhrUhnKXnp8Kr/EwcYAH2o0ROnObUnYe0
         POcc/7IKTUDNZdzAsx0NGN9Xm4/LFeVxNTHHcI8fb9Ukqo3O22wC8e/2sEBfFGLHfnnp
         LeMPLBJVAH2mQlDobBwwIm4MCW50Fosp0s2sI0F9JdCWTJ3hN9otmbAxGCgSUFDLuHnB
         qvIO/ffEDd4OciZ4F1WNfka1AgX6rsP2sxi7Yy/WN/lIdzIopqi210KHDUwPjx3Skq9E
         RtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422116; x=1781026916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPCq8R2iFDOBkRBVDOMhdJ7tVwFyybPPEZNvzTbgMro=;
        b=rJLZIcEOdPewpIA2VM4X+hUDODqhr1xEA9BmWXkHNZuzwSca+JQbxftCYdPAt0Yg3C
         7RJZ/ZGdBaFcRdKxp8S9P0GX6FJbRTwH2v1J6Xfi9n2eIJr9wN3n60EN1nEPF/7RPuQj
         nS1kbxD3Ar/s8nNTtvrUdPDEqWD4NHeQbG6oXMuwnf77t6v2IKc5IW4LMetXOJguBWd5
         OllJxLc1gzNqDBhj5NQzcWmKEhbRPbsCh7X0Fdvk4e5zc6tpltfTh9uJVYCs0VEK1fYa
         YqN/ISPJ8Udv75C6k8nu1Be4vw8pz9CN8ayevEciOxMGzwNbJvZCIxxe4rBrl9I82YEU
         I86Q==
X-Forwarded-Encrypted: i=1; AFNElJ9eyrKGfIu/NwMp/mZKCDhmq3JRMZEnSNudpX2+mjl1Gn6inxG9gbpdE2utZ0h0BZhvVt3b6vNbd2pCPPJYbuUT@vger.kernel.org
X-Gm-Message-State: AOJu0YzGB+gvNJl4/btV1dZAREXPw9P64vzP2To1L93xnm+ggA6G0bqv
	vrJg8wtmIhtB2pPj0jFZmCNT9SzlLHkOxTh/QvlbG1aVPyBx0mTRH+J17IDWDTY+9Z1R4o6gm8X
	Xv0amSbfYYg==
X-Received: from dycok16.prod.google.com ([2002:a05:7301:db10:b0:2d7:dc51:72ad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2313:b0:2c9:ee15:a0ee
 with SMTP id 5a478bee46e88-3074d5322b0mr122281eec.12.1780422115207; Tue, 02
 Jun 2026 10:41:55 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:16 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com> <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-6-irogers@google.com>
Subject: [PATCH v8 05/18] perf test: Support dynamic test suites with setup
 callback and private data
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
 tools/perf/tests/builtin-test.c | 17 ++++++++++++++++-
 tools/perf/tests/tests.h        |  2 ++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7946878195b7..485ff75ab880 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -765,10 +765,21 @@ static struct test_suite **build_suites(void)
 	for (size_t i = 0, j = 0; i < ARRAY_SIZE(suites); i++, j = 0)	\
 		while ((suite = suites[i][j++]) != NULL)
 
-	for_each_suite(t)
+	for_each_suite(t) {
+		if (t->setup) {
+			int ret = t->setup(t);
+
+			if (ret < 0) {
+				errno = -ret;
+				return NULL;
+			}
+		}
 		num_suites++;
+	}
 
 	result = calloc(num_suites + 1, sizeof(struct test_suite *));
+	if (!result)
+		return NULL;
 
 	for (int pass = 1; pass <= 2; pass++) {
 		for_each_suite(t) {
@@ -831,6 +842,8 @@ int cmd_test(int argc, const char **argv)
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
 	if (argc >= 1 && !strcmp(argv[0], "list")) {
 		suites = build_suites();
+		if (!suites)
+			return errno ? -errno : -ENOMEM;
 		ret = perf_test__list(stdout, suites, argc - 1, argv + 1);
 		free(suites);
 		return ret;
@@ -863,6 +876,8 @@ int cmd_test(int argc, const char **argv)
 	rlimit__bump_memlock();
 
 	suites = build_suites();
+	if (!suites)
+		return errno ? -errno : -ENOMEM;
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
2.54.0.1013.g208068f2d8-goog

