From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/12] perf tools: Cleanup trace-event-info 'tdata' leak
Date: Mon,  8 Oct 2018 21:54:20 -0300
Message-ID: <20181009005427.6607-6-acme@kernel.org>
References: <20181009005427.6607-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009005427.6607-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sanskriti Sharma <sansharm@redhat.com>, Joe Lawrence <joe.lawrence@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sanskriti Sharma <sansharm@redhat.com>

Free tracing_data structure in tracing_data_get() error paths.

Fixes the following coverity complaint:

  Error: RESOURCE_LEAK (CWE-772):
  leaked_storage: Variable "tdata" going out of scope leaks the storage

Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Link: http://lkml.kernel.org/r/1538490554-8161-3-git-send-email-sansharm@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/trace-event-info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 7b0ca7cbb7de..8ad8e755127b 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -531,12 +531,14 @@ struct tracing_data *tracing_data_get(struct list_head *pattrs,
 			 "/tmp/perf-XXXXXX");
 		if (!mkstemp(tdata->temp_file)) {
 			pr_debug("Can't make temp file");
+			free(tdata);
 			return NULL;
 		}
 
 		temp_fd = open(tdata->temp_file, O_RDWR);
 		if (temp_fd < 0) {
 			pr_debug("Can't read '%s'", tdata->temp_file);
+			free(tdata);
 			return NULL;
 		}
 
-- 
2.14.4
