From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/30] tools headers: Synchronize perf_event.h header
Date: Tue, 28 Nov 2017 12:02:14 -0300
Message-ID: <20171128150220.5064-25-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in the 085b30625e39 ("perf/core: Add
PERF_AUX_FLAG_COLLISION to report colliding samples") commit, that will
be eventually used by perf to handle the ARM SPE architecture.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-178ohv0oy0csq3kzfdk8ky4n@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 362493a2f950..b9a4953018ed 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -942,6 +942,7 @@ enum perf_callchain_context {
 #define PERF_AUX_FLAG_TRUNCATED		0x01	/* record was truncated to fit */
 #define PERF_AUX_FLAG_OVERWRITE		0x02	/* snapshot from overwrite mode */
 #define PERF_AUX_FLAG_PARTIAL		0x04	/* record contains gaps */
+#define PERF_AUX_FLAG_COLLISION		0x08	/* sample collided with another */
 
 #define PERF_FLAG_FD_NO_GROUP		(1UL << 0)
 #define PERF_FLAG_FD_OUTPUT		(1UL << 1)
-- 
2.13.6
