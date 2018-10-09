From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/12] perf tools: Avoid double free in read_event_file()
Date: Mon,  8 Oct 2018 21:54:22 -0300
Message-ID: <20181009005427.6607-8-acme@kernel.org>
References: <20181009005427.6607-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009005427.6607-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sanskriti Sharma <sansharm@redhat.com>, Joe Lawrence <joe.lawrence@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sanskriti Sharma <sansharm@redhat.com>

The temporary 'buf' buffer allocated in read_event_file() may be freed
twice.  Move the free() call to the common function exit point.

Fixes the following coverity complaints:

  Error: USE_AFTER_FREE (CWE-825):
  tools/perf/util/trace-event-read.c:309: double_free: Calling "free"
  frees pointer "buf" which has already been freed.

Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Link: http://lkml.kernel.org/r/1538490554-8161-5-git-send-email-sansharm@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/trace-event-read.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index b98ee2a2eb44..a278e1eee5f5 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -297,10 +297,8 @@ static int read_event_file(struct tep_handle *pevent, char *sys,
 	}
 
 	ret = do_read(buf, size);
-	if (ret < 0) {
-		free(buf);
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = parse_event_file(pevent, buf, size, sys);
 	if (ret < 0)
-- 
2.14.4
