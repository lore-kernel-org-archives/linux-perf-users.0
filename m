From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/8] perf tools: Add long time reviewers to MAINTAINERS
Date: Thu, 19 Oct 2017 14:45:11 -0300
Message-ID: <20171019174515.7407-5-acme@kernel.org>
References: <20171019174515.7407-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019174515.7407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Jiri and Namhyung have long contributed a lot of code and time reviewing
patches to tools/, so lets make that reflected in the MAINTAINERS file
to encourage patch submitters to add them to the CC list, speeding up
the process of tools/perf/ patch processing.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-onicopw68bg6kn56lnybfpns@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc42c838ab4f..f2056624c672 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10559,6 +10559,8 @@ M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
 M:	Arnaldo Carvalho de Melo <acme@kernel.org>
 R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
+R:	Jiri Olsa <jolsa@redhat.com>
+R:	Namhyung Kim <namhyung@kernel.org>
 L:	linux-kernel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
 S:	Supported
-- 
2.13.6
