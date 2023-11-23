Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/HBexlh"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407771B2;
	Wed, 22 Nov 2023 23:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700726371; x=1732262371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7da/0iEnQCMxy/lLCWXMFnGwlTG2TiSr880zeoxTvII=;
  b=L/HBexlhTOpnqTb9b5I3EvqTLF7hGl6h3DFzVNB703C+2Liq2imeKXRM
   lSqL72jwiYAi5huJAXM0L7SI8jWQt9JmVPA53fxB0rGt75d69ZlwGaTSs
   sfCmo47qEHy5TZxmhoX9S2h9lV7ZUApH0WuheRfOyMHUFgXpiy9GoM1cz
   Rx0gaZTFl7Qa7y17OI+igJJGhrDjHNPIbuWTtZfYwjetL+2U3NFQpOjxb
   UOzhTRFKCA3qaE8XzCmybnchcUMmY8Jmpns23gO5A7YYVbyvQMAZNHtaA
   U1x6pLMAk0G6771b5ElB8fJEahbI8yNaENU2FfQjXfODD6S36n61Avn65
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396126425"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="396126425"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="8764988"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.41.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:14 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@arm.com>,
	German Gomez <german.gomez@arm.com>,
	Leo Yan <leo.yan@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/8] perf tests: Skip record test if test_loop symbol is missing
Date: Thu, 23 Nov 2023 09:58:44 +0200
Message-Id: <20231123075848.9652-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123075848.9652-1-adrian.hunter@intel.com>
References: <20231123075848.9652-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

perf record test depends on finding symbol test_loop in perf, and fails if
perf has been stripped and no debug object is available. In that case, skip
the test instead.

Example:

 Note, building with perl support adds option -Wl,-E which causes the
 linker to add all (global) symbols to the dynamic symbol table. So the
 test_loop symbol, being global, does not get stripped unless NO_LIBPERL=1

 Before:

  $ make NO_LIBPERL=1 -C tools/perf >/dev/null 2>&1
  $ strip tools/perf/perf
  $ tools/perf/perf buildid-cache -p `realpath tools/perf/perf`
  $ tools/perf/perf test -v 'record tests'
   91: perf record tests                                               :
  --- start ---
  test child forked, pid 118750
  Basic --per-thread mode test
  Per-thread record [Failed missing output]
  Register capture test
  Register capture test [Success]
  Basic --system-wide mode test
  System-wide record [Skipped not supported]
  Basic target workload test
  Workload record [Failed missing output]
  test child finished with -1
  ---- end ----
  perf record tests: FAILED!

 After:

  $ tools/perf/perf test -v 'record tests'
   91: perf record tests                                               :
  --- start ---
  test child forked, pid 120025
  perf does not have symbol 'test_loop'
  perf is missing symbols - skipping test
  test child finished with -2
  ---- end ----
  perf record tests: Skip

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/record.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 29443b8e8876..1838b76e2282 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -8,10 +8,16 @@ shelldir=$(dirname "$0")
 # shellcheck source=lib/waiting.sh
 . "${shelldir}"/lib/waiting.sh
 
+# shellcheck source=lib/perf_has_symbol.sh
+. "${shelldir}"/lib/perf_has_symbol.sh
+
+testsym="test_loop"
+
+skip_test_missing_symbol ${testsym}
+
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 testprog="perf test -w thloop"
-testsym="test_loop"
 
 cleanup() {
   rm -rf "${perfdata}"
-- 
2.34.1

