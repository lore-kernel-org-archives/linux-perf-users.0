From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/10] perf tests shell: Remove duplicate skip_if_no_debuginfo() function
Date: Wed, 16 Aug 2017 17:20:41 -0300
Message-ID: <20170816202050.8865-2-acme@kernel.org>
References: <20170816202050.8865-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816202050.8865-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-3zxjswdbs2au3ih0rino0iy1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 42308040f882..3eaddf190a30 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -21,8 +21,3 @@ skip_if_no_debuginfo() {
 	add_probe_vfs_getname -v 2>&1 | grep -q "^Failed to find the path for kernel" && return 2
 	return 1
 }
-
-skip_if_no_debuginfo() {
-	add_probe_vfs_getname -v 2>&1 | grep -q "^Failed to find the path for kernel" && return 2
-	return 1
-}
-- 
2.13.5
