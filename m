From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/43] perf evsel: Ensure reserved member of PERF_SAMPLE_CPU is zero in perf_event__synthesize_sample()
Date: Tue, 23 Jan 2018 10:12:10 -0300
Message-ID: <20180123131251.28197-3-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

PERF_SAMPLE_CPU contains the cpu number in the first 4 bytes and the
second 4 bytes are reserved. Ensure the reserved bytes are zero in
perf_event__synthesize_sample().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1516108492-21401-3-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 85eb84dfdf91..44032679180f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2533,6 +2533,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 
 	if (type & PERF_SAMPLE_CPU) {
 		u.val32[0] = sample->cpu;
+		u.val32[1] = 0;
 		if (swapped) {
 			/*
 			 * Inverse of what is done in perf_evsel__parse_sample
-- 
2.14.3
