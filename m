Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD51BE854;
	Fri, 11 Oct 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666906; cv=none; b=ptgpSRCSi14HQe8BZkmy+GWCnHcFKeEHO0vXvlz8VEf/HOKGgHFw8ohjJqYmOMtk+IPZIBmm6Xfuj+Zfjyfmpcwj06Dr4Lu3IcM4RaQJkfG2PatEZhAxrUsVxnw0oqHwXXhv+N3wUzQENH9EqV453qa4snl86R9B0Eb5wzXCHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666906; c=relaxed/simple;
	bh=GEo1vglydNYoegWFvA+plcFHmXcJ4apLSKDPWRQidag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRNG7yW3ZNvRjsQx9jUtsIcc0oIPmwL4+MwjPk1MPLrIJKzMnRCzlhHtBQTXq7losEkjC+ly4PAsKxSNW9u7XR6jCgaRXcDKHhC5OxETgMQZnanF/nrRPpNuVSYzvjsesnuscuuMZRfXsmwIQKlHs8z1Or9pMhfPAGfcx9w480U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmG8vEXh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmG8vEXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0754EC4CEC7;
	Fri, 11 Oct 2024 17:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728666906;
	bh=GEo1vglydNYoegWFvA+plcFHmXcJ4apLSKDPWRQidag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmG8vEXh0RhDz9f5Sv5wpkOm4KCvLPG9BmLGUnXbV4gerNbUEL0Z7Pm+yyRbwCEKE
	 CPH9DtJFFQVE9lAXiUO+a8l/IH8hI8z/pOH2bTlprNRn2z6NeRgBBq+nvU9wnIGFTr
	 CEQJW0SaPok5qHdZW7TcsUOQexmzLN+fRMNsKzCXQmjNV37biu8gBdTLfYqUwHJpO7
	 +sbVPn5lhvWH945JoqhUpBcSrkd/9FVoo1VtUuuAjq3CtzbsUviTE3dia7eJV6uXCd
	 M1oRCyLTnr6MCV9V2i7MWkTH4C/72SuYUeara5vjks57RTKLFwHh+s+WdOac4kY9WK
	 CrTIGWC63Z3XQ==
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
Subject: [PATCH 1/3] perf test: Introduce workloads__for_each()
Date: Fri, 11 Oct 2024 14:14:47 -0300
Message-ID: <20241011171449.1362979-2-acme@kernel.org>
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

And use it in run_workload().

Testing it:

  root@x1:~# perf trace -e *landlock* perf test -w landlock
       0.000 ( 0.015 ms): :1274331/1274331 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffd3fea55e0, flags: 45) = -1 EINVAL (Invalid argument)
       0.018 ( 0.003 ms): :1274331/1274331 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffd3fea55f0, flags: 45) = -1 EINVAL (Invalid argument)
  root@x1:~# perf test -w bla
  No workload found: bla
  root@x1:~#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 470a9709427ddaad..2201f7ed432ce9f2 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -155,6 +155,9 @@ static struct test_workload *workloads[] = {
 	&workload__landlock,
 };
 
+#define workloads__for_each(workload) \
+	for (unsigned i = 0; i < ARRAY_SIZE(workloads) && ({ workload = workloads[i]; 1; }); i++)
+
 static int num_subtests(const struct test_suite *t)
 {
 	int num;
@@ -504,11 +507,9 @@ static int perf_test__list(int argc, const char **argv)
 
 static int run_workload(const char *work, int argc, const char **argv)
 {
-	unsigned int i = 0;
 	struct test_workload *twl;
 
-	for (i = 0; i < ARRAY_SIZE(workloads); i++) {
-		twl = workloads[i];
+	workloads__for_each(twl) {
 		if (!strcmp(twl->name, work))
 			return twl->func(argc, argv);
 	}
-- 
2.47.0

