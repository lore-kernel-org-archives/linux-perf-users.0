Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85B79D0;
	Sun, 20 Oct 2024 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729390733; cv=none; b=c9oqIpVFyCAubIjuwNA3TzxuVZvahzXg9eurmaCZ1lbGvTTBY0nmO4QEZ18Lp1KJSJko6OPRs+6UEV/nwgrCn7lNThhA7UZTRNLgKZikNwARQcvrdnI7LxfHIO+Er/MAx9q6Hlp/WV+TCsMqZxE1QYLDQ95GX9JoH8dkZ5OnoZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729390733; c=relaxed/simple;
	bh=kMpOUFSGDCOCtdS4eZfo2wWsqbi/lg4ecRAemfZMFMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ/aWUYXpFG2WItZkHy+NmLfscndmZfiTnj9HLZUT8oe7yVXbyZmFiT0tg5+vXvBlCghAHB7JK65I6Mcx0OQ1aX9kfLd3mlBb6ybQxrzE25DLuCX1k+I+GXrLS45ls763WxdZvrK8eUFjoPhtwIOSoHOBcOE+huRwsD9CGi0NAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA1Xq2Rh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA1Xq2Rh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6F5C4CED1;
	Sun, 20 Oct 2024 02:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729390732;
	bh=kMpOUFSGDCOCtdS4eZfo2wWsqbi/lg4ecRAemfZMFMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eA1Xq2RhNFByEu+NiHihDwheHx46mdLZJ3oId618s3qg1/wHDHrUDew2atwRQRtD0
	 Rksr+RLgbEgjaS6eqVssRMXsiwPdlUnBWxJKyjBlX5dRfI9nrg2M+rSj84V4sVIFCr
	 AxLbTkPXYqYGdhxNMPyO5qHASV98BGixSQjlsb/QPUEhzfswm0p4t7WdONm80GJue1
	 kr/JyOAh2c9sSYc/09MXYrxRBJPmAsPwzOfYRqEP8gt2a8X+K0otC+JNNn22YZxW2V
	 VMrFh2IUyFUPFSFTaUNFZQdDCYAjjlx1iWMYQi5VhdwAPyteQVSfbEq7LcpWu/IHRI
	 aQsBiV+HB7bFA==
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
Date: Sat, 19 Oct 2024 23:18:40 -0300
Message-ID: <20241020021842.1752770-2-acme@kernel.org>
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
Link: https://lore.kernel.org/lkml/20241011171449.1362979-2-acme@kernel.org
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
2.46.2

