From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 88/91] libsymbols kallsyms: Parse using io api
Date: Wed,  6 May 2020 12:22:31 -0300
Message-ID: <20200506152234.21977-89-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ian Rogers <irogers@google.com>

'perf record' will call kallsyms__parse 4 times during startup and
process megabytes of data. This changes kallsyms__parse to use the io
library rather than fgets to improve performance of the user code by
over 8%.

Before:

  Running 'internals/kallsyms-parse' benchmark:
  Average kallsyms__parse took: 103.988 ms (+- 0.203 ms)

After:

  Running 'internals/kallsyms-parse' benchmark:
  Average kallsyms__parse took: 95.571 ms (+- 0.006 ms)

For a workload like:

  $ perf record /bin/true
  Run under 'perf record -e cycles:u -g' the time goes from:
  Before
  30.10%     1.67%  perf     perf                [.] kallsyms__parse
  After
  25.55%    20.04%  perf     perf                [.] kallsyms__parse

So a little under 5% of the start-up time is removed. A lot of what
remains is on the kernel side, but caching kallsyms within perf would at
least impact memory footprint.

Committer notes:

The internal/kallsyms-parse bench is run using:

  [root@five ~]# perf bench internals kallsyms-parse
  # Running 'internals/kallsyms-parse' benchmark:
    Average kallsyms__parse took: 80.381 ms (+- 0.115 ms)
  [root@five ~]#

And this pre-existing test uses these routines to parse kallsyms and
then compare with the info obtained from the matching ELF symtab:

  [root@five ~]# perf test vmlinux
   1: vmlinux symtab matches kallsyms                       : Ok
  [root@five ~]#

Also we can't remove hex2u64() in this patch as this breaks the build:

  /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `modules__parse':
  /home/acme/git/perf/tools/perf/util/symbol.c:607: undefined reference to `hex2u64'
  /usr/bin/ld: /home/acme/git/perf/tools/perf/util/symbol.c:607: undefined reference to `hex2u64'
  /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `dso__load_perf_map':
  /home/acme/git/perf/tools/perf/util/symbol.c:1477: undefined reference to `hex2u64'
  /usr/bin/ld: /home/acme/git/perf/tools/perf/util/symbol.c:1483: undefined reference to `hex2u64'
  collect2: error: ld returned 1 exit status

Leave it there, move it in the next patch.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200501221315.54715-3-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/io.h          |  3 ++
 tools/lib/symbol/kallsyms.c | 93 +++++++++++++++++++------------------
 2 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index b7e55b5f8a4a..777c20f6b604 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -7,6 +7,9 @@
 #ifndef __API_IO__
 #define __API_IO__
 
+#include <stdlib.h>
+#include <unistd.h>
+
 struct io {
 	/* File descriptor being read/ */
 	int fd;
diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
index 1a7a9f877095..a5edc75c346c 100644
--- a/tools/lib/symbol/kallsyms.c
+++ b/tools/lib/symbol/kallsyms.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "symbol/kallsyms.h"
+#include "api/io.h"
 #include <stdio.h>
-#include <stdlib.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 u8 kallsyms2elf_type(char type)
 {
@@ -9,12 +11,6 @@ u8 kallsyms2elf_type(char type)
 	return (type == 't' || type == 'w') ? STT_FUNC : STT_OBJECT;
 }
 
-bool kallsyms__is_function(char symbol_type)
-{
-	symbol_type = toupper(symbol_type);
-	return symbol_type == 'T' || symbol_type == 'W';
-}
-
 /*
  * While we find nice hex chars, build a long_val.
  * Return number of chars processed.
@@ -28,61 +24,68 @@ int hex2u64(const char *ptr, u64 *long_val)
 	return p - ptr;
 }
 
+bool kallsyms__is_function(char symbol_type)
+{
+	symbol_type = toupper(symbol_type);
+	return symbol_type == 'T' || symbol_type == 'W';
+}
+
+static void read_to_eol(struct io *io)
+{
+	int ch;
+
+	for (;;) {
+		ch = io__get_char(io);
+		if (ch < 0 || ch == '\n')
+			return;
+	}
+}
+
 int kallsyms__parse(const char *filename, void *arg,
 		    int (*process_symbol)(void *arg, const char *name,
 					  char type, u64 start))
 {
-	char *line = NULL;
-	size_t n;
-	int err = -1;
-	FILE *file = fopen(filename, "r");
-
-	if (file == NULL)
-		goto out_failure;
-
-	err = 0;
+	struct io io;
+	char bf[BUFSIZ];
+	int err;
 
-	while (!feof(file)) {
-		u64 start;
-		int line_len, len;
-		char symbol_type;
-		char *symbol_name;
+	io.fd = open(filename, O_RDONLY, 0);
 
-		line_len = getline(&line, &n, file);
-		if (line_len < 0 || !line)
-			break;
+	if (io.fd < 0)
+		return -1;
 
-		line[--line_len] = '\0'; /* \n */
+	io__init(&io, io.fd, bf, sizeof(bf));
 
-		len = hex2u64(line, &start);
+	err = 0;
+	while (!io.eof) {
+		__u64 start;
+		int ch;
+		size_t i;
+		char symbol_type;
+		char symbol_name[KSYM_NAME_LEN + 1];
 
-		/* Skip the line if we failed to parse the address. */
-		if (!len)
+		if (io__get_hex(&io, &start) != ' ') {
+			read_to_eol(&io);
 			continue;
-
-		len++;
-		if (len + 2 >= line_len)
+		}
+		symbol_type = io__get_char(&io);
+		if (io__get_char(&io) != ' ') {
+			read_to_eol(&io);
 			continue;
-
-		symbol_type = line[len];
-		len += 2;
-		symbol_name = line + len;
-		len = line_len - len;
-
-		if (len >= KSYM_NAME_LEN) {
-			err = -1;
-			break;
 		}
+		for (i = 0; i < sizeof(symbol_name); i++) {
+			ch = io__get_char(&io);
+			if (ch < 0 || ch == '\n')
+				break;
+			symbol_name[i]  = ch;
+		}
+		symbol_name[i]  = '\0';
 
 		err = process_symbol(arg, symbol_name, symbol_type, start);
 		if (err)
 			break;
 	}
 
-	free(line);
-	fclose(file);
+	close(io.fd);
 	return err;
-
-out_failure:
-	return -1;
 }
-- 
2.21.1
