From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/85] perf trace: Associate more argument names with the filename beautifier
Date: Tue, 11 Jun 2019 15:58:18 -0300
Message-ID: <20190611185911.11645-33-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For instance, the rename* family uses "oldname", "newname", so check if
"name" is at the end and treat it as a filename.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wjy7j4bk06g7atzwoz1mid24@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 905e57c336b0..f7e4e50bddbd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1431,10 +1431,11 @@ static int syscall__set_arg_fmts(struct syscall *sc)
 		if (sc->fmt && sc->fmt->arg[idx].scnprintf)
 			continue;
 
+		len = strlen(field->name);
+
 		if (strcmp(field->type, "const char *") == 0 &&
-			 (strcmp(field->name, "filename") == 0 ||
-			  strcmp(field->name, "path") == 0 ||
-			  strcmp(field->name, "pathname") == 0))
+		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
+		     strstr(field->name, "path") != NULL))
 			sc->arg_fmt[idx].scnprintf = SCA_FILENAME;
 		else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
 			sc->arg_fmt[idx].scnprintf = SCA_PTR;
@@ -1445,8 +1446,7 @@ static int syscall__set_arg_fmts(struct syscall *sc)
 		else if ((strcmp(field->type, "int") == 0 ||
 			  strcmp(field->type, "unsigned int") == 0 ||
 			  strcmp(field->type, "long") == 0) &&
-			 (len = strlen(field->name)) >= 2 &&
-			 strcmp(field->name + len - 2, "fd") == 0) {
+			 len >= 2 && strcmp(field->name + len - 2, "fd") == 0) {
 			/*
 			 * /sys/kernel/tracing/events/syscalls/sys_enter*
 			 * egrep 'field:.*fd;' .../format|sed -r 's/.*field:([a-z ]+) [a-z_]*fd.+/\1/g'|sort|uniq -c
-- 
2.20.1
