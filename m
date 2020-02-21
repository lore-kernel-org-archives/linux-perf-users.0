From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/8] perf intel-pt: Fix endless record after being terminated
Date: Thu, 20 Feb 2020 22:53:05 -0300
Message-ID: <20200221015310.16914-4-acme@kernel.org>
References: <20200221015310.16914-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200221015310.16914-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wei Li <liwei391@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Tan Xiaojun <tanxiaojun@huawei.com>, stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Wei Li <liwei391@huawei.com>

In __cmd_record(), when receiving SIGINT(ctrl + c), a 'done' flag will
be set and the event list will be disabled by evlist__disable() once.

While in auxtrace_record.read_finish(), the related events will be
enabled again, if they are continuous, the recording seems to be endless.

If the intel_pt event is disabled, we don't enable it again here.

Before the patch:

  huawei@huawei-2288H-V5:~/linux-5.5-rc4/tools/perf$ ./perf record -e \
  intel_pt//u -p 46803
  ^C^C^C^C^C^C

After the patch:

  huawei@huawei-2288H-V5:~/linux-5.5-rc4/tools/perf$ ./perf record -e \
  intel_pt//u -p 48591
  ^C[ perf record: Woken up 0 times to write data ]
  Warning:
  AUX data lost 504 times out of 4816!

  [ perf record: Captured and wrote 2024.405 MB perf.data ]

Signed-off-by: Wei Li <liwei391@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: stable@vger.kernel.org # 5.4+
Link: http://lore.kernel.org/lkml/20200214132654.20395-2-adrian.hunter@intel.com
[ ahunter: removed redundant 'else' after 'return' ]
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 20df442fdf36..be07d6886256 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -1173,9 +1173,12 @@ static int intel_pt_read_finish(struct auxtrace_record *itr, int idx)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->intel_pt_pmu->type)
+		if (evsel->core.attr.type == ptr->intel_pt_pmu->type) {
+			if (evsel->disabled)
+				return 0;
 			return perf_evlist__enable_event_idx(ptr->evlist, evsel,
 							     idx);
+		}
 	}
 	return -EINVAL;
 }
-- 
2.21.1
