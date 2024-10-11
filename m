Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254E51885AD;
	Fri, 11 Oct 2024 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666911; cv=none; b=pbPSp0p3C3n3EFbG0zlKTTiqhW8Z7RFungBxYUIeZQ1jVY8hF89D9JfSPATOVRPrvB2MOwr+u7YvXeiSVMH+YlCJPO+T4XOQwctL3ISFg+vBY2kYdJoksKN3zZH3CKEMv0RZX2y+OdeDjk8Q65GolO+cc8tHmRe+KWawQLVEGu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666911; c=relaxed/simple;
	bh=U6+qm+B0AaTlqXgAJ/VO+bUTXGFWSL7zGfpWIujF5vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5ueHkhXNIF/Spl/Nmg61Wv3i6CLiGL67i+BCIsqkIa6qI6am7iQJORpDOVmh2Nny9/aEx0S7GnmV0F3nQbJ4YwuUuR62i/lRWgHjW13NAkR+vYMJjBVt/MeSm6nKC/Mq4pCRi+B9OJLAtca13hRU2Xd6hE9kjG1oqutwMcWMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBA8g12u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBA8g12u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9806EC4CEC3;
	Fri, 11 Oct 2024 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728666910;
	bh=U6+qm+B0AaTlqXgAJ/VO+bUTXGFWSL7zGfpWIujF5vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBA8g12uIwJPUHedepZfUVzlgXAnGLOa6wRJqMGqhUsiA3MgFgEBI02ZyP1KRcpj/
	 4N+nAT1VV/MdD2Pc8yk4axR/EE/QgroDvPHMNkla5y4GUwzHP/2dghcRqC0uOZ0aMO
	 EJZciuEtbmuNsl0LTMlQYYq9slKvxWcFbUj7mDwaYc7LA3IA8lIGwLoRYlDZ+5ypph
	 8Wlz13w/vERsJBCZL2q+OxILJBHzLVBqc21PFoZ6gQ4jmmJEhQlIai3/SnJin3GjGA
	 lDREITlZ1+Ve3muaqu4vVuWzW+lynM24lt+pf3RwlkfzMjjyoKdVL1HBWGGisGux3t
	 zAK3rB/DBEweg==
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
Subject: [PATCH 2/3] perf test: Introduce '-w --list' to list the available workloads
Date: Fri, 11 Oct 2024 14:14:48 -0300
Message-ID: <20241011171449.1362979-3-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011171449.1362979-1-acme@kernel.org>
References: <20241011171449.1362979-1-acme@kernel.org>
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
2.47.0

