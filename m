From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/43] perf utils: Silence "Couldn't synthesize bpf events" warning for EPERM
Date: Thu, 14 Feb 2019 21:45:08 -0300
Message-ID: <20190215004539.23571-13-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>, kernel-team@fb.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Song Liu <songliubraving@fb.com>

Synthesizing BPF events is only supported for root. Silent warning msg
when non-root user runs perf-record.

Reported-by: David Carrillo-Cisneros <davidca@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Tested-by: David Carrillo-Cisneros <davidca@fb.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: kernel-team@fb.com
Link: http://lkml.kernel.org/r/20190204193140.719740-1-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 796ef793f4ce..62dda96b0096 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -236,8 +236,8 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 			pr_debug("%s: can't get next program: %s%s",
 				 __func__, strerror(errno),
 				 errno == EINVAL ? " -- kernel too old?" : "");
-			/* don't report error on old kernel */
-			err = (errno == EINVAL) ? 0 : -1;
+			/* don't report error on old kernel or EPERM  */
+			err = (errno == EINVAL || errno == EPERM) ? 0 : -1;
 			break;
 		}
 		fd = bpf_prog_get_fd_by_id(id);
-- 
2.19.1
