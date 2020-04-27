From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/7] perf bpf: Decouple creating the evlist from adding the SB event
Date: Mon, 27 Apr 2020 18:19:32 -0300
Message-ID: <20200427211935.25789-5-acme@kernel.org>
References: <20200427211935.25789-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200427211935.25789-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Renaming bpf_event__add_sb_event() to evlist__add_sb_event() and
requiring that the evlist be allocated beforehand.

This will allow using the same side band thread and evlist to be used
for multiple purposes in addition to react to PERF_RECORD_BPF_EVENT soon
after they are generated.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 2c7a50509659..68f315c3df5b 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -45,7 +45,7 @@ static inline int machine__process_bpf(struct machine *machine __maybe_unused,
 	return 0;
 }
 
-static inline int evlist__add_bpf_sb_event(struct evlist **evlist __maybe_unused,
+static inline int evlist__add_bpf_sb_event(struct evlist *evlist __maybe_unused,
 					   struct perf_env *env __maybe_unused)
 {
 	return 0;
-- 
2.21.1
