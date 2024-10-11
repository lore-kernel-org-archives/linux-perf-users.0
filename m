Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203B194A66;
	Fri, 11 Oct 2024 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657569; cv=none; b=rhMkOtlv8vmsWtHB9aANKkprUF+n9j7uam/HrF3FuCqWBgk5wijnSlCW4iaNubAsiE8jS7KPpIG66FoFFIor1FF117TZNQlTMQWKYsVMnNbAcV5jEGBfHR5YYSU3n5IMJmwvrYlhN0kOBVzZGg/aWPjeg3TFUjtyGCX+vRrVZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657569; c=relaxed/simple;
	bh=M0bxNF/7gQO27/WxyyVyqteQfl7qRroKTDHq6/ghdmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myAWIG3+KDEriruF/WtT7OauPvWSz5EkIgfS4Rabu93T5qZ4/DVR8dQKSdfdq7IWlMbRL+XHIssTgGEhnlDbQzgQBh+j38xcXSyGyzAACTDLDHw4tBuhaRTP5HSc/15FwIG4vKbg+uJ7pktzvuqn2WyKeVGspxGkSC+W15nOcaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ/iVVcm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ/iVVcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB96C4CEC3;
	Fri, 11 Oct 2024 14:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728657568;
	bh=M0bxNF/7gQO27/WxyyVyqteQfl7qRroKTDHq6/ghdmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZ/iVVcmZvQxtQW1EGXKQSwTPgrjx+u0budEo9MEEu0g6dcaycGuGNwIg42beXlkT
	 /+m2zmHyYO4/AYxjXKASjEhgb5xvqwQcaJo8RjogQTgkNt35LLOrXGwWpnYsRSu00T
	 DBtgQrOi5y0xtGlGuWCz0wbb2yzcGYgCxw1o0XU4rOebbfaG0njdXjkct6nR01CDsS
	 frZMYoll5qE6TH864XrhYvVS0Z4IvMV+RGd2JzD4vQWIdLPb6vsVQNG6keYfVgm2Ce
	 7aOztJqjrU7qqu7ZljzrJRflPgEtPLNDHlcZSLRzhoaNIuLsQfgEQ7lfu/6F9E+w9H
	 onpR0swtIKhmg==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/3] perf test: Introduce '-w --list' to list the available workloads
Date: Fri, 11 Oct 2024 11:39:05 -0300
Message-ID: <20241011143906.1285675-3-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011143906.1285675-1-acme@kernel.org>
References: <20241011143906.1285675-1-acme@kernel.org>
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
                            workload to run for testing, use '-w --list' to list the available ones.
  $
  $ perf test -w --list
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
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 2201f7ed432ce9f2..f0d10d2dd0d40019 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -505,10 +505,26 @@ static int perf_test__list(int argc, const char **argv)
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
 
+	if (!strcmp(work, "--list")) {
+		workloads__fprintf_list(stdout);
+		return 0;
+	}
+
 	workloads__for_each(twl) {
 		if (!strcmp(twl->name, work))
 			return twl->func(argc, argv);
@@ -544,7 +560,7 @@ int cmd_test(int argc, const char **argv)
 	OPT_BOOLEAN('p', "parallel", &parallel, "Run the tests in parallel"),
 	OPT_BOOLEAN('S', "sequential", &sequential,
 		    "Run the tests one after another rather than in parallel"),
-	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
+	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '-w --list' to list the available ones."),
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
 	OPT_STRING(0, "objdump", &test_objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
-- 
2.47.0

