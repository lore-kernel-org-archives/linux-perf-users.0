Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EC2BE5E;
	Sun, 20 Oct 2024 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729390736; cv=none; b=Zg0uQ/edPVzHtySUSLlAZt672i8leWmFhIvOgzgeinhStNtarfjo+XD23zcMquk36aU8jRoDLUYZQUt2qk3SXhkPomMB090zPqQxg7+zO0iXPQeuO8uZ7wPEPE4OrlTtfeILO3BBPjFYK1xaHUNhmVnRS8po3UpbwJsRtxncX+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729390736; c=relaxed/simple;
	bh=bBPuIvSFwObOYnBape4WJZ+7xTE7/R7yrTNG+rvAiQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNmk7HRJ+TOhP7S3fIjcrSLMmIFjlCqeM6DONogZ8XqGlVQoQWE87ubhCtPJf/fWL+XbEUOpGkFJm+j3ldi6eT239zqhgeKTfVsNvq3PVykxqXTryXMHOiG+4nQKPOju+GQvj/Sc6TokmzVDO8bmMuMrZ5oHg6rnahQ6uCAz3mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrtdVUQE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrtdVUQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E687DC4CED0;
	Sun, 20 Oct 2024 02:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729390735;
	bh=bBPuIvSFwObOYnBape4WJZ+7xTE7/R7yrTNG+rvAiQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrtdVUQE6M8Nm0YEz3ESzzmFgYKjDTh3vCpbUlojTVOfWNfOtc+Bkq2dT+s9ESHZA
	 D3WIQMGTK/iL8qNEqAkHengHT8ahiUHSR3TEj8EREzMmd/bhL7HvMSAc4G/MRmyhiE
	 i9xIb5rDq6I/eJ05gifCNmxMZf5Vr6pqyJ6KpswfJ4ruuweDPw4HcpCPNA/j7K7HQf
	 NNS39FJc08R7CruV1zwJDv5tTG9SIG/A59TU8BjBxOFeggrSAhHOw7Nj+/x91iTOQf
	 M1kVw91XwnlFehBOvaJMv5a7DlXQpOAGi7rGmB8i9nKkOQkuJduxb5EqymBJ4FmCf2
	 Tb3znSdDPllTg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 2/3] perf test: Introduce --list-workloads to list the available workloads
Date: Sat, 19 Oct 2024 23:18:41 -0300
Message-ID: <20241020021842.1752770-3-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020021842.1752770-1-acme@kernel.org>
References: <20241020021842.1752770-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Using it:

  $ perf test -w noplop
  No workload found: noplop
  $
  $ perf test -w
   Error: switch `w' requires a value
   Usage: perf test [<options>] [{list <test-name-fragment>|[<test-name-fragments>|<test-numbers>]}]

      -w, --workload <work>
                            workload to run for testing, use '--list-workloads' to list the available ones.
  $
  $ perf test --list-workloads
  noploop
  thloop
  leafloop
  sqrtloop
  brstack
  datasym
  landlock
  $

Would be good at some point to have a description in 'struct test_workload'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/20241011171449.1362979-3-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 2201f7ed432ce9f2..cc43b9f366d09436 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -505,6 +505,17 @@ static int perf_test__list(int argc, const char **argv)
 	return 0;
 }
 
+static int workloads__fprintf_list(FILE *fp)
+{
+	struct test_workload *twl;
+	int printed = 0;
+
+	workloads__for_each(twl)
+		printed += fprintf(fp, "%s\n", twl->name);
+
+	return printed;
+}
+
 static int run_workload(const char *work, int argc, const char **argv)
 {
 	struct test_workload *twl;
@@ -535,6 +546,7 @@ int cmd_test(int argc, const char **argv)
 	};
 	const char *skip = NULL;
 	const char *workload = NULL;
+	bool list_workloads = false;
 	const struct option test_options[] = {
 	OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
 	OPT_INCR('v', "verbose", &verbose,
@@ -544,7 +556,8 @@ int cmd_test(int argc, const char **argv)
 	OPT_BOOLEAN('p', "parallel", &parallel, "Run the tests in parallel"),
 	OPT_BOOLEAN('S', "sequential", &sequential,
 		    "Run the tests one after another rather than in parallel"),
-	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
+	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
+	OPT_BOOLEAN(0, "list-workloads", &list_workloads, "List the available builtin workloads to use with -w/--workload"),
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
 	OPT_STRING(0, "objdump", &test_objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
@@ -570,6 +583,11 @@ int cmd_test(int argc, const char **argv)
 	if (workload)
 		return run_workload(workload, argc, argv);
 
+	if (list_workloads) {
+		workloads__fprintf_list(stdout);
+		return 0;
+	}
+
 	if (dont_fork)
 		sequential = true;
 	else if (parallel)
-- 
2.46.2

