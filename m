Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002823CAA31
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713515; cv=none; b=lS3R/rL6y8NnqkvjMiPjPWoVDne17aqCwVD0J4w0NquM4IMIrdqeIYyLv6TlH6mM+0/uUNqUIv7TrCUG2p0RzX/0dn1w9NrLu6jnerOve15HWU3qzVpM9avHhmSRThiV+ryPpO9SwbJFEUSyJzj+CvfpKu9Dk/EeoPV6fNwtn9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713515; c=relaxed/simple;
	bh=9YzjMaQxCMHmywbXb04oY55ubJuQiFEL1v0Kv3F6U0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OBYUBr5fhGklWxDjF8ylnqEFh6uaGD6LUe1bWxSMCvwlH3C2OCOduAJR921ttvya39IsHn65v+jLgnsJPdZ0qaI+e6ZogfTAWLifXMBGyCHIkz+Rbu7NoUzGSpPPE3T0shcsq4CsQse/vBA7g3SFKciFCEUKVhpb4QrneiQpNCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cy7KZURW; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cy7KZURW"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13312cff948so10127723c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713513; x=1779318313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFRb/0vzGf3zmIPM7TQxztzeltx1kS8XddICRkJs5mY=;
        b=Cy7KZURW+2tTuHj9chg/vuq2bEMB7LfbazEDCEQu1wCz7ciCzr1imSxjyHoGFC+40t
         ryXwMXRvzrxZyOev42IWlmUNaCmyge7d/G9f2kQ0Nm7/3vCstQNzVjpT9wTvOo7t1q7c
         scxQDFG4b7VVK+eRQu9doQ2m4wqFltLNpKsR0sa2JXJ1z3yf7E3Hz1UuIx5lIsAtZsqE
         NWXz+G2ugGoSoVhjecI82JPrtNW+XLPAjoCMu0OhQzmwFL3EH2UEfkLGLg2JUjZ8zU/1
         l3MWD5mrjKTgZUD5wEkd3VI7m26WMNIUwDiL1gCj5aRITg6JapeYykU3neYkBFksD1yL
         XkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713513; x=1779318313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFRb/0vzGf3zmIPM7TQxztzeltx1kS8XddICRkJs5mY=;
        b=r4OTRGLGJ+z2qa2JxXFi1oZkxwJmEF16QOweRMxBxw0WHp2b2x9FFMRPw9Ogc6o9Vi
         sz4R40NoDemaEuFJi55Z277x/Gx3KDqalUZy+amGLiQvQnmMcPGDgVHcOJDgyLOYfrxc
         naWLAUJTBZWdwedD7tYFb9IBiNS9nDIRN0cG0igAw5b9X7EuUt0VbotQmkDg/Y+lJHFU
         xuSOfhZNqSotT61pxladaUMDDihKB2TzCX4v9tyd/LqpUytre7Z4WfruPV7+HJ7ZIITb
         iysaW7e48YupdnruYDv55QqQJloJUN+360tAlHjPPvgvZa2GRh3eYqi73DStkR2v/eo+
         8v2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8gK8aTdAzEgyCfCn5O/fub1pBrOqUn2oQjhg9oee3a8xhJceggDLtbb90TAr2G8UMynFCKFWP6fQL3ajk7oFOJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyFDlOz3PNGkOx+tx2HAIRWtCraLObYExyH0FCKSSmdkxIgbV8N
	s9ijoU+ERS/17UkuTGhfQYCqqOCbLXNra4hyEc+4DXc6ELlWWAa4Vxk4k5jT6IUeDykBcDLGxWq
	jVNLg9cXpsw==
X-Received: from dled19-n2.prod.google.com ([2002:a05:701b:42d3:20b0:12d:b839:d0b8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:23a3:b0:12c:6a24:a24f
 with SMTP id a92af1059eb24-13436aa59a3mr3066307c88.33.1778713512604; Wed, 13
 May 2026 16:05:12 -0700 (PDT)
Date: Wed, 13 May 2026 16:04:40 -0700
In-Reply-To: <20260513230450.529380-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513230450.529380-5-irogers@google.com>
Subject: [PATCH v1 04/14] perf test: Support dynamic test suites with setup
 callback and private data
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add void *priv to struct test_case to allow passing per-test context.
Add int (*setup)(struct test_suite *) to struct test_suite to allow
dynamic generation of test cases.
Update build_suites() to invoke the setup callback for each suite if
present, ensuring dynamic cases are available before listing or running.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 13 ++++++++++++-
 tools/perf/tests/tests.h        |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index e88a5f72faed..a350db071674 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -764,8 +764,15 @@ static struct test_suite **build_suites(void)
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
 
@@ -830,6 +837,8 @@ int cmd_test(int argc, const char **argv)
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
 	if (argc >= 1 && !strcmp(argv[0], "list")) {
 		suites = build_suites();
+		if (!suites)
+			return -ENOMEM;
 		ret = perf_test__list(stdout, suites, argc - 1, argv + 1);
 		free(suites);
 		return ret;
@@ -862,6 +871,8 @@ int cmd_test(int argc, const char **argv)
 	rlimit__bump_memlock();
 
 	suites = build_suites();
+	if (!suites)
+		return -ENOMEM;
 	ret = __cmd_test(suites, argc, argv, skiplist);
 	free(suites);
 	return ret;
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index f5f1238d1f7f..6dcf2db02b8c 100644
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
2.54.0.563.g4f69b47b94-goog

