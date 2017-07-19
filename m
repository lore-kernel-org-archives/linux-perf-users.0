From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/86] perf trace: Only build tools/perf/trace/beauty/ when building 'perf trace'
Date: Wed, 19 Jul 2017 11:28:31 -0300
Message-ID: <20170719142950.3747-8-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it calls functions in builtin-trace.c.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-bt3lhw1rvy3jzbsp2fvvegb0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index bd8eeb60533c..b48ca40fccf9 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -50,6 +50,6 @@ libperf-y += util/
 libperf-y += arch/
 libperf-y += ui/
 libperf-y += scripts/
-libperf-y += trace/beauty/
+libperf-$(CONFIG_AUDIT) += trace/beauty/
 
 gtk-y += ui/gtk/
-- 
2.9.4
