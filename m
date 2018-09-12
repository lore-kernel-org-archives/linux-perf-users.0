From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/7] tools headers uapi: Update tools's copy of linux/perf_event.h
Date: Wed, 12 Sep 2018 15:55:03 -0300
Message-ID: <20180912185509.32187-2-acme@kernel.org>
References: <20180912185509.32187-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912185509.32187-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

	09121255c784 ("perf/UAPI: Clearly mark __PERF_SAMPLE_CALLCHAIN_EARLY as internal use")

This cures the following warning during perf's build:

	Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
	diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2vvwh2o19orn56di0ksrtgzr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index eeb787b1c53c..f35eb72739c0 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -144,7 +144,7 @@ enum perf_event_sample_format {
 
 	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
 
-	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63,
+	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
 
 /*
-- 
2.14.4
