From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/5] tools headers uapi: Update tools's copy of linux/perf_event.h
Date: Mon, 30 Jul 2018 17:50:27 -0300
Message-ID: <20180730205031.12853-2-acme@kernel.org>
References: <20180730205031.12853-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730205031.12853-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>, Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>, Vince Weaver <vincent.weaver@maine.edu>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  6cbc304f2f36 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")

That do not imply any changes in the tooling side, the (ab)use of
sample_type is entirely done in kernel space, nothing for userspace to
witness here.

This cures the following warning during perf's build:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-o64mjoy35s9gd1gitunw1zg4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b8e288a1f740..eeb787b1c53c 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -143,6 +143,8 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 
 	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+
+	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63,
 };
 
 /*
-- 
2.14.4
