From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 47/86] perf tests attr: Add 1s for exclude_kernel and task base bits
Date: Wed, 19 Jul 2017 11:29:11 -0300
Message-ID: <20170719142950.3747-48-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's an event open fallback which set exclude_kernel=1 in case use
does not have enough privileges. Adding both 0|1 for this attribute,
because we don't know what value it is.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170703145030.12903-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr/base-record | 2 +-
 tools/perf/tests/attr/base-stat   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index 7e6d74946e04..cdf3adf7d389 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -15,7 +15,7 @@ inherit=1
 pinned=0
 exclusive=0
 exclude_user=0
-exclude_kernel=0
+exclude_kernel=0|1
 exclude_hv=0
 exclude_idle=0
 mmap=1
diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
index f4cf148f14cb..ff9b33d4ae9e 100644
--- a/tools/perf/tests/attr/base-stat
+++ b/tools/perf/tests/attr/base-stat
@@ -15,7 +15,7 @@ inherit=1
 pinned=0
 exclusive=0
 exclude_user=0
-exclude_kernel=0
+exclude_kernel=0|1
 exclude_hv=0
 exclude_idle=0
 mmap=0
-- 
2.9.4
