Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CAE1D9A68;
	Wed, 23 Oct 2024 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717510; cv=none; b=arwmRELlNqefbLGtA6P0Wad3jfQ5bfK1d0j0sg7s1nFkYVQ0K0bbyiuH40/r/4H3r9E7456AIuLXzQqERWj7wJ2hMhKB4x9dxzvHJ1x1x/rsuVolVyV7KFLyMan0/poHPko6b4yRWezepFQ/ZQNyYZ1mMyZ1l5Sq3rwRmJVZERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717510; c=relaxed/simple;
	bh=YGxT/21cdM6lSvXvWqYvvIrJsI/bS0dImUF6eX1aAgs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BvBPko0qpAwctBdBZ13EZSggxtUgP9i1ZShKZhBRC26qWnpC5Ige69VH9SJEFPU0B/n2XFDcihr5P7vF5fEue9Dpg63Tg3UCYOLJF74cFC0mBXqcEpwDCxSkz90TViehMz2D+ew0BlupH07QugmLWaSZ6X4P2frRH14H63b3PRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leKFgbsh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leKFgbsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0E4C4CEC6;
	Wed, 23 Oct 2024 21:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729717509;
	bh=YGxT/21cdM6lSvXvWqYvvIrJsI/bS0dImUF6eX1aAgs=;
	h=Date:From:To:Cc:Subject:From;
	b=leKFgbshLphDRPiHlYl2kAjVr9MglbBobK+bsjFeiqaFl1NPntM6eoxLzuvfzaoSi
	 q+K9IVvUF+eLeE9OIt43Ii3o5A41WgRT8xie9oWXsmXStonCcSs703FQ1ovXzRi3ea
	 HhfBKD0TUm6sR/ERZ4MXJTk9+ibyRDP5cRKu1cCfeJTmali01LHF45tcBXzjKecf3C
	 5FWdI06Fanjg++xuv9UKaJ75y1YJdPzLzyn7XE5080N8lDJH29OH4z8nPtqO5cmLM1
	 HO1PjYaAH2cGJOPeh+3eDLuCbNFvekToZ73LJwHUMjlUExtxGVXfbPKugOsBkQvf0k
	 i2sQbVdbq2sgQ==
Date: Wed, 23 Oct 2024 18:05:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 perf-tools] perf python: Fix up the build on
 architectures without HAVE_KVM_STAT_SUPPORT
Message-ID: <ZxllAtpmEw5fg9oy@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Noticed while building on a raspbian arm 32-bit system.

There was also this other case, fixed by adding a missing util/stat.h
with the prototypes:

  /tmp/tmp.MbiSHoF3dj/perf-6.12.0-rc3/tools/perf/util/python.c:1396:6: error: no previous prototype for ‘perf_stat__set_no_csv_summary’ [-Werror=missing-prototypes]
   1396 | void perf_stat__set_no_csv_summary(int set __maybe_unused)
        |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /tmp/tmp.MbiSHoF3dj/perf-6.12.0-rc3/tools/perf/util/python.c:1400:6: error: no previous prototype for ‘perf_stat__set_big_num’ [-Werror=missing-prototypes]
   1400 | void perf_stat__set_big_num(int set __maybe_unused)
        |      ^~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

In other architectures this must be building due to some lucky indirect
inclusion of that header.

Fixes: 9dabf4003423c8d3 ("perf python: Switch module to linking libraries from building source")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 31a223eaf8e65fa3..ee3d43a7ba4570f0 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -19,6 +19,7 @@
 #include "util/bpf-filter.h"
 #include "util/env.h"
 #include "util/kvm-stat.h"
+#include "util/stat.h"
 #include "util/kwork.h"
 #include "util/sample.h"
 #include "util/lock-contention.h"
@@ -1355,6 +1356,7 @@ PyMODINIT_FUNC PyInit_perf(void)
 
 unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
 
+#ifdef HAVE_KVM_STAT_SUPPORT
 bool kvm_entry_event(struct evsel *evsel __maybe_unused)
 {
 	return false;
@@ -1384,6 +1386,7 @@ void exit_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
 			   char *decode __maybe_unused)
 {
 }
+#endif // HAVE_KVM_STAT_SUPPORT
 
 int find_scripts(char **scripts_array  __maybe_unused, char **scripts_path_array  __maybe_unused,
 		int num  __maybe_unused, int pathlen __maybe_unused)
-- 
2.46.0

