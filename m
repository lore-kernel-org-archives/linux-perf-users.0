From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/44] perf report: Indicate JITed code better in report
Date: Thu, 21 Mar 2019 15:51:03 -0300
Message-ID: <20190321185142.11441-6-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Print [TID] tid %d instead of the crypted /tmp/perf-%d.map default.

% cat >loop.java
  public class loop {
          public static void main(String[] args)
          {
                  for (;;);
          }
  }
  ^D
  % javac loop.java
  % perf record java loop
  ^C

Before:

  % perf report --stdio
  ...
      56.09%  java     perf-34724.map      [.] 0x00007fd5bd021896
      19.12%  java     perf-34724.map      [.] 0x00007fd5bd021887
       9.79%  java     perf-34724.map      [.] 0x00007fd5bd021783
       8.97%  java     perf-34724.map      [.] 0x00007fd5bd02175b

After:

  % perf report --stdio
  ...
      56.09%  java     [JIT] tid 34724     [.] 0x00007fd5bd021896
      19.12%  java     [JIT] tid 34724     [.] 0x00007fd5bd021887
       9.79%  java     [JIT] tid 34724     [.] 0x00007fd5bd021783
       8.97%  java     [JIT] tid 34724     [.] 0x00007fd5bd02175b

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
LPU-Reference: 20190314225002.30108-7-andi@firstfloor.org
Link: https://lkml.kernel.org/n/tip-r17l6py9g0sezb7mi1f286gt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ba58ba603b69..ab8a455d2283 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1141,28 +1141,34 @@ void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated)
 
 static void dso__set_basename(struct dso *dso)
 {
-       /*
-        * basename() may modify path buffer, so we must pass
-        * a copy.
-        */
-       char *base, *lname = strdup(dso->long_name);
+	char *base, *lname;
+	int tid;
 
-       if (!lname)
-               return;
-
-       /*
-        * basename() may return a pointer to internal
-        * storage which is reused in subsequent calls
-        * so copy the result.
-        */
-       base = strdup(basename(lname));
+	if (sscanf(dso->long_name, "/tmp/perf-%d.map", &tid) == 1) {
+		if (asprintf(&base, "[JIT] tid %d", tid) < 0)
+			return;
+	} else {
+	      /*
+	       * basename() may modify path buffer, so we must pass
+               * a copy.
+               */
+		lname = strdup(dso->long_name);
+		if (!lname)
+			return;
 
-       free(lname);
+		/*
+		 * basename() may return a pointer to internal
+		 * storage which is reused in subsequent calls
+		 * so copy the result.
+		 */
+		base = strdup(basename(lname));
 
-       if (!base)
-               return;
+		free(lname);
 
-       dso__set_short_name(dso, base, true);
+		if (!base)
+			return;
+	}
+	dso__set_short_name(dso, base, true);
 }
 
 int dso__name_len(const struct dso *dso)
-- 
2.20.1
