Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9659E1D88D5;
	Tue,  5 Nov 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816804; cv=none; b=EMOWtdHcg9Ks+6kjg29dHnZ+Q5JBkumyi1MNnn3pHHQCa79jv2ZElgMxLkkr78aY7mW08zws24DbOaYzD2HycYgXiEFxNXKfhc+cUBO9Kodd0ZM84EB3WLh5klrpT4STMnrvPLe0dMMwrqpbPaAf8/J4HVbpBc0XIrUYbF/FzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816804; c=relaxed/simple;
	bh=R62QBY8iaqvnHYn++qgnd8iZQwcx8VBpLT5T01W6EKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3xY1hP/uk2GayFj4zrsO8QYcNaJibiFvVY3U7CSk8aiiBS3AxEIR2msR/tw9kOQaY8u3V3S7fhbzTzQBAizB7Y7h70hC6RKu3dvtxfhcjWMSouoTjRhbBkMJfHIIky7tby8HfoclJ/0yGkU57eB0m6L0YebLJzfJ/nllBRIn3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7DUYGym; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7DUYGym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7B3C4CECF;
	Tue,  5 Nov 2024 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730816804;
	bh=R62QBY8iaqvnHYn++qgnd8iZQwcx8VBpLT5T01W6EKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7DUYGymNMFL0v8uK0qpAg7iqoAnBvS8C211WO/PSYi4WmhOS17VQsrT/+Ntgj2v9
	 f5pqQm3j72j4wbvM9V/Z2glYsXScu5dBOaYYGQcFVjS+QIXzEi4AO/iHnVwIfpN7oU
	 ZIOHbJP4TxCBYTYSbmIxyw8o6qLYIi4lzk4/agku58FpHeGsJOpQzwBE+7g2/YGGSd
	 6nA8nXgdAh+FPBN4WZz2pr6mKehVcfV4uLUUpepkZ9hzZ8U3lg/S5lw4xRi3D6Kkjn
	 GAUZVWoV8vMFAb31zuGuf/bXF2fMrBnNE4BxXF0OyX09legCxKugh5EfB5LpoSwrEd
	 CT0AgRHsBYgKg==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>
Subject: [PATCH v2 2/4] perf test: Skip the python binding builtin test case with NO_LIBPYTHON=1
Date: Tue,  5 Nov 2024 11:26:14 -0300
Message-ID: <20241105142616.761042-3-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105142616.761042-1-acme@kernel.org>
References: <20241105142616.761042-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The python_use test suite was being built and tested even when the
python binding that it is designed to test is not being built, fix it by
making it skip the test with an informative message.

Testing this patch:

When building with NO_LIBPYTHON=1, i.e. explicitely disabling linking
against libpython and thus not building the python binding:

  $ perf test 17
  17: 'import perf' in python     : Skip (No python binding, enable by not using NO_LIBPYTHON=1.)
  $

Not disabling linking with libpython, the default, that results in the
python binding being built:

  $ perf test 17
  17: 'import perf' in python     : Ok
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linux.dev>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/python-use.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
index b7325caad22bab10..7a86e59ebb27fa75 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -11,6 +11,7 @@
 
 static int test__python_use(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
+#ifdef HAVE_LIBPYTHON_SUPPORT
 	char *cmd;
 	int ret;
 
@@ -22,6 +23,23 @@ static int test__python_use(struct test_suite *test __maybe_unused, int subtest
 	ret = system(cmd) ? -1 : 0;
 	free(cmd);
 	return ret;
+#else
+	return TEST_SKIP;
+#endif // HAVE_LIBPYTHON_SUPPORT
 }
 
-DEFINE_SUITE("'import perf' in python", python_use);
+static struct test_case tests__python_use[] = {
+	{
+		.name	   = "python_use",
+		.desc	   = "'import perf' in python",
+		.run_case  = test__python_use,
+#ifndef HAVE_LIBPYTHON_SUPPORT
+		.skip_reason = "No python binding, enable by not using NO_LIBPYTHON=1",
+#endif
+       },
+};
+
+struct test_suite suite__python_use = {
+	.desc = "'import perf' in python",
+	.test_cases = tests__python_use,
+};
-- 
2.47.0

