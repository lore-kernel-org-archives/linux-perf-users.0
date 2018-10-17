From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/11] perf tools: Fix tracing_path_mount proper path
Date: Wed, 17 Oct 2018 19:54:57 -0300
Message-ID: <20181017225501.32150-8-acme@kernel.org>
References: <20181017225501.32150-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017225501.32150-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

If there's no tracefs (RHEL7) support the tracing_path_mount
returns debugfs path which results in following fail:

  # perf probe sys_write
  kprobe_events file does not exist - please rebuild kernel with CONFIG_KPROBE_EVENTS.
  Error: Failed to add events.

In tracing_path_debugfs_mount function we need to return the
'tracing' path instead of just the mount to make it work:

  # perf probe sys_write
  Added new event:
    probe:sys_write      (on sys_write)

  You can now use it in all perf tools, such as:

          perf record -e probe:sys_write -aR sleep 1

Adding the 'return tracing_path;' also to tracing_path_tracefs_mount
function just for consistency with tracing_path_debugfs_mount.

Upstream keeps working, because it has the tracefs support.

Link: http://lkml.kernel.org/n/tip-yiwkzexq9fk1ey1xg3gnjlw4@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: 23773ca18b39 ("perf tools: Make perf aware of tracefs")
Link: http://lkml.kernel.org/r/20181016114818.3595-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/tracing_path.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 120037496f77..5afb11b30fca 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -36,7 +36,7 @@ static const char *tracing_path_tracefs_mount(void)
 
 	__tracing_path_set("", mnt);
 
-	return mnt;
+	return tracing_path;
 }
 
 static const char *tracing_path_debugfs_mount(void)
@@ -49,7 +49,7 @@ static const char *tracing_path_debugfs_mount(void)
 
 	__tracing_path_set("tracing/", mnt);
 
-	return mnt;
+	return tracing_path;
 }
 
 const char *tracing_path_mount(void)
-- 
2.14.4
