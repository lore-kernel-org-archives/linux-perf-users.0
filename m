From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v1 07/10] perf, tools, report: Indicate JITed code better in report
Date: Mon, 11 Mar 2019 13:24:43 -0700
Message-ID: <20190311202446.10210-8-andi@firstfloor.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311202446.10210-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
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
