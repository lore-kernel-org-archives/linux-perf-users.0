Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B820236430;
	Mon, 30 Jun 2025 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751326368; cv=none; b=n4NyClTnvhg18tpxrqY+qNaHDqBYH5FZrXS2rC/2TZ3rk5g3NBm4j7enS1DfjxV1hkNv1jg35hUbjjd3TlMWYZBnE5uKFvHXq09m20J9UDZIljWIT2UPI0xSnWGbANMWsF5gCoZaI7GUAaXGuPfBv7tpaKrY5i7EwLHJb6OxyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751326368; c=relaxed/simple;
	bh=Ld5zYn+r5WUyjaFSko8PmSj1fqleOuSpjpPB3ingajw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qvo62CWZc8cVFDrFHKCkQrVdMXXd8Q4CMKJsgiWpkqTXtkd8iZyjepGC9SCcQpnNbZHCUpAiHE3TuIoFyCcZYEfsmAJTDzhDX3i9arCAwfFcxRBsmFvNy8zFsut37DWcbVRzBqCj3yxqDP4m31ah3cE6P3P4EqMXpQUqAnxA0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plZX8Yf9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plZX8Yf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65405C4CEE3;
	Mon, 30 Jun 2025 23:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751326367;
	bh=Ld5zYn+r5WUyjaFSko8PmSj1fqleOuSpjpPB3ingajw=;
	h=From:To:Cc:Subject:Date:From;
	b=plZX8Yf9Mf9V1gW5nWHE7czQE/+oY8ON/ajvY1ZKZi2TEud4SgB2riwSP9gEZHUPz
	 hNK5g9nx0jFExNZfPsvbmJxiWbpSk6sHrLavuMe5n4ZJeD1w+mfZ8fljel+z9dbYVH
	 VJ3o7dkA7b7y2PKvPqf7Fvz4II5at9Wzn/w0YR0FDiXicgZmm9hpPj52XvDqGxhbrm
	 XXhkcmTRE8ry7WynmHsNhqNKBVQoHr0ARvPUwFfKslmIPwBkC7A0tQJA6N7W/3TwEg
	 VQm5OXEQIVyEb7w0bY/ThW3AMKJKFmESbjeCnkaPYsYOU7j646GimXh+eEXOrES98w
	 L0hhknkxwtMlw==
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
Subject: [PATCH 1/3] perf test: Check test suite description only
Date: Mon, 30 Jun 2025 16:32:44 -0700
Message-ID: <20250630233246.1063977-1-namhyung@kernel.org>
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
together.

Before:
  $ perf test hwmon
  (no output)

After:
  $ perf test hwmon
   10: Hwmon PMU                                                       :
   10.1: Basic parsing test                                            : Ok
   10.2: Parsing without PMU name                                      : Ok
   10.3: Parsing with PMU name                                         : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/builtin-test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 80375ca39a37a256..dfaff4185eb05a1a 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -567,10 +567,6 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 
 			for (unsigned int run = 0; run < runs_per_test; run++) {
 				test_suite__for_each_test_case(*t, curr_test_case) {
-					if (!perf_test__matches(test_description(*t, curr_test_case),
-								curr_suite, argc, argv))
-						continue;
-
 					err = start_test(*t, curr_suite, curr_test_case,
 							 &child_tests[child_test_num++],
 							 width, pass);
-- 
2.50.0.727.gbf7dc18ff4-goog

