Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC3B1B95B;
	Tue,  1 Jul 2025 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751400628; cv=none; b=Ui3alGi9nweXdCzVC2Kib9D2dWe9L8f9x83qNzT0aBt3OYVG+bAxYXnFqJ7+TwnsYND2VCm2fx21cMIGFzLZTx5xYmmrza8470SgKUMp++dlkEZKvbCVpAhl1j/nUQSCvKDxnQHUZMDtOLzVVOEGEsqc8WO68wQYDRXdathnz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751400628; c=relaxed/simple;
	bh=Ru9NzqECvOrZzfG15wF+9Ezl9X8/F8uVISxt9U2kt1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQje6ywIeW9Fb5i+IKG/cjCK5q8+7sJPimxLqTSflw+PoBNR7nu2xLz7qY2WYwHrGBW9e0ORPhHUXF6GWQiWa8B6HtIoT8CwwXm7UB1Ryl0U6iJYKxwiuRZ02m0Szd2VVvSTO4fBKBbiElSNYmYbKdZV8q8yoEC2GOeckzMaR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M16RZzbs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M16RZzbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08ABC4CEEB;
	Tue,  1 Jul 2025 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751400628;
	bh=Ru9NzqECvOrZzfG15wF+9Ezl9X8/F8uVISxt9U2kt1U=;
	h=From:To:Cc:Subject:Date:From;
	b=M16RZzbsGyjSwPtzjLH9rU75MPs4/EJusU6ODoFZWIFHqdP147MZQaPITi+R9P84r
	 Dxmgpkw0wrd3i3mypV1RCEgLbBM4fBhY2LygFJ9X6tam9pspT/0EGf9vI10qYpRD/H
	 mvAWjOBmMXqAkjG46fZEjlWfwlYIWh6SKG0i0Uy1KsBxACxoAa++3XHX8vRwYJ8mV4
	 M1zI8DIVfLgdH35L7iQPvVLk6sS/JUZedkZVLU/0SOkGPCQnmEUTX4p15jntOzP7Xb
	 c0EJe39dEzLAs5GGOYurr+K29swBGqeL9rTZxua0MPOWqAxNcrLVH+nNGzUytMs+BR
	 2Ri7JHSnaZAEw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/3] perf test: Check test suite description properly
Date: Tue,  1 Jul 2025 13:10:25 -0700
Message-ID: <20250701201027.1171561-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently perf test checks the given string with descriptions for both
test suites and cases (subtests).  But sometimes it's confusing since
the subtests don't contain the important keyword.

I think it's better to check the suite level and run the whole suite
together if it matches description in the suite.

Before:
  $ perf test hwmon
  (no output)

After:
  $ perf test hwmon
   10: Hwmon PMU                                                       :
   10.1: Basic parsing test                                            : Ok
   10.2: Parsing without PMU name                                      : Ok
   10.3: Parsing with PMU name                                         : Ok

And keep the existing behavior when it only matches test description only.

  $ perf test "Equal cpu map"
   39.5: Equal cpu map                                                 : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/builtin-test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 80375ca39a37a256..846c9b3a732c9b3a 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -539,6 +539,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 
 		for (struct test_suite **t = suites; *t; t++, curr_suite++) {
 			int curr_test_case;
+			bool suite_matched = false;
 
 			if (!perf_test__matches(test_description(*t, -1), curr_suite, argc, argv)) {
 				/*
@@ -556,6 +557,8 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 				}
 				if (skip)
 					continue;
+			} else {
+				suite_matched = true;
 			}
 
 			if (intlist__find(skiplist, curr_suite + 1)) {
@@ -567,10 +570,10 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 
 			for (unsigned int run = 0; run < runs_per_test; run++) {
 				test_suite__for_each_test_case(*t, curr_test_case) {
-					if (!perf_test__matches(test_description(*t, curr_test_case),
+					if (!suite_matched &&
+					    !perf_test__matches(test_description(*t, curr_test_case),
 								curr_suite, argc, argv))
 						continue;
-
 					err = start_test(*t, curr_suite, curr_test_case,
 							 &child_tests[child_test_num++],
 							 width, pass);
-- 
2.50.0.727.gbf7dc18ff4-goog

