From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/16] perf annotate: Pass filename to objdump via execl
Date: Fri,  4 Jan 2019 15:33:34 -0300
Message-ID: <20190104183337.12771-14-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ivan Krylov <krylov.r00t@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Ivan Krylov <krylov.r00t@gmail.com>

The symbol__disassemble() function uses shell to launch objdump and
filter its output via grep. Passing filenames by interpolating them into
the command line via "%s" may lead to problems if said filenames contain
special characters.

Instead, pass the filename as a command line argument where it is not
subject to any kind of interpretation, then use quoted shell
interpolation to build the strings we need safely.

Signed-off-by: Ivan Krylov <krylov.r00t@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181014111803.5d83b806@Tarkus
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ac9805e0bc76..70de8f6b3aee 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1723,15 +1723,14 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
-		 " -l -d %s %s -C \"%s\" 2>/dev/null|grep -v \"%s:\"|expand",
+		 " -l -d %s %s -C \"$1\" 2>/dev/null|grep -v \"$1:\"|expand",
 		 opts->objdump_path ?: "objdump",
 		 opts->disassembler_style ? "-M " : "",
 		 opts->disassembler_style ?: "",
 		 map__rip_2objdump(map, sym->start),
 		 map__rip_2objdump(map, sym->end),
 		 opts->show_asm_raw ? "" : "--no-show-raw",
-		 opts->annotate_src ? "-S" : "",
-		 symfs_filename, symfs_filename);
+		 opts->annotate_src ? "-S" : "");
 
 	if (err < 0) {
 		pr_err("Failure allocating memory for the command to run\n");
@@ -1756,7 +1755,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		close(stdout_fd[0]);
 		dup2(stdout_fd[1], 1);
 		close(stdout_fd[1]);
-		execl("/bin/sh", "sh", "-c", command, NULL);
+		execl("/bin/sh", "sh", "-c", command, "--", symfs_filename,
+		      NULL);
 		perror(command);
 		exit(-1);
 	}
-- 
2.20.1
