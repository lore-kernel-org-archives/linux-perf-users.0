From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/16] tools lib traceevent: Initialize host_bigendian at tep_handle allocation
Date: Tue,  8 Jan 2019 16:59:00 -0300
Message-ID: <20190108195910.17726-7-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

This patch initializes the host_bigendian member of the tep_handle
structure with the byte order of the current host, when this handler is
created - in tep_alloc() API. We need this in order to remove the
tep_set_host_bigendian() API.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181201040852.216292134@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 156e513074b2..44b80471b024 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -6762,8 +6762,10 @@ struct tep_handle *tep_alloc(void)
 {
 	struct tep_handle *pevent = calloc(1, sizeof(*pevent));
 
-	if (pevent)
+	if (pevent) {
 		pevent->ref_count = 1;
+		pevent->host_bigendian = tep_host_bigendian();
+	}
 
 	return pevent;
 }
-- 
2.20.1
