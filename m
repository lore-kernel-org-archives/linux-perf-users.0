Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270BC1CA94
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Nov 2023 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFF1AD75;
	Mon, 13 Nov 2023 02:23:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2E1E14BF;
	Mon, 13 Nov 2023 02:24:20 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11E673F6C4;
	Mon, 13 Nov 2023 02:23:31 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	acme@kernel.org
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Yonghong Song <yhs@fb.com>,
	Fangrui Song <maskray@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf test: Use existing config value for objdump path
Date: Mon, 13 Nov 2023 10:23:24 +0000
Message-Id: <20231113102327.695386-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is already an existing config value for changing the objdump path,
so instead of having two values that do the same thing, make perf test
use annotate.objdump as well.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/Documentation/perf-config.txt | 8 ++------
 tools/perf/tests/builtin-test.c          | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 16398babd1ef..379f9d7a8ab1 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -251,7 +251,8 @@ annotate.*::
 		addr2line binary to use for file names and line numbers.
 
 	annotate.objdump::
-		objdump binary to use for disassembly and annotations.
+		objdump binary to use for disassembly and annotations,
+		including in the 'perf test' command.
 
 	annotate.disassembler_style::
 		Use this to change the default disassembler style to some other value
@@ -722,11 +723,6 @@ session-<NAME>.*::
 		Defines new record session for daemon. The value is record's
 		command line without the 'record' keyword.
 
-test.*::
-
-	test.objdump::
-		objdump binary to use for disassembly and annotations.
-
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 113e92119e1d..b8c21e81a021 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -518,7 +518,7 @@ static int run_workload(const char *work, int argc, const char **argv)
 static int perf_test__config(const char *var, const char *value,
 			     void *data __maybe_unused)
 {
-	if (!strcmp(var, "test.objdump"))
+	if (!strcmp(var, "annotate.objdump"))
 		test_objdump_path = value;
 
 	return 0;
-- 
2.34.1

