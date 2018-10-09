From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/12] perf tools: Free temporary 'sys' string in read_event_files()
Date: Mon,  8 Oct 2018 21:54:23 -0300
Message-ID: <20181009005427.6607-9-acme@kernel.org>
References: <20181009005427.6607-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009005427.6607-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sanskriti Sharma <sansharm@redhat.com>, Joe Lawrence <joe.lawrence@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sanskriti Sharma <sansharm@redhat.com>

For each system in a given pevent, read_event_files() reads in a
temporary 'sys' string.  Be sure to free this string before moving onto
to the next system and/or leaving read_event_files().

Fixes the following coverity complaints:

  Error: RESOURCE_LEAK (CWE-772):

  tools/perf/util/trace-event-read.c:343: overwrite_var: Overwriting
  "sys" in "sys = read_string()" leaks the storage that "sys" points to.

  tools/perf/util/trace-event-read.c:353: leaked_storage: Variable "sys"
  going out of scope leaks the storage it points to.

Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Link: http://lkml.kernel.org/r/1538490554-8161-6-git-send-email-sansharm@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/trace-event-read.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index a278e1eee5f5..add8441de579 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -347,9 +347,12 @@ static int read_event_files(struct tep_handle *pevent)
 		for (x=0; x < count; x++) {
 			size = read8(pevent);
 			ret = read_event_file(pevent, sys, size);
-			if (ret)
+			if (ret) {
+				free(sys);
 				return ret;
+			}
 		}
+		free(sys);
 	}
 	return 0;
 }
-- 
2.14.4
