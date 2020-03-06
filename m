From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/5] perf parse-events: Use asprintf() instead of strncpy() to read tracepoint files
Date: Fri,  6 Mar 2020 16:11:39 -0300
Message-ID: <20200306191144.12762-7-acme@kernel.org>
References: <20200306191144.12762-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200306191144.12762-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Make the code more compact by using asprintf() instead of malloc()+strncpy() which also uses
less memory and avoids these warnings with gcc 10:

    CC       /tmp/build/perf/util/cloexec.o
  In file included from /usr/include/string.h:495,
                   from util/parse-events.h:12,
                   from util/parse-events.c:18:
  In function ‘strncpy’,
      inlined from ‘tracepoint_id_to_path’ at util/parse-events.c:271:5:
  /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ offset [275, 511] from the object at ‘sys_dirent’ is out of the bounds of referenced subobject ‘d_name’ with type ‘char[256]’ at offset 19 [-Werror=array-bounds]
    106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In file included from /usr/include/dirent.h:61,
                   from util/parse-events.c:5:
  util/parse-events.c: In function ‘tracepoint_id_to_path’:
  /usr/include/bits/dirent.h:33:10: note: subobject ‘d_name’ declared here
     33 |     char d_name[256];  /* We must not include limits.h! */
        |          ^~~~~~
  In file included from /usr/include/string.h:495,
                   from util/parse-events.h:12,
                   from util/parse-events.c:18:
  In function ‘strncpy’,
      inlined from ‘tracepoint_id_to_path’ at util/parse-events.c:273:5:
  /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ offset [275, 511] from the object at ‘evt_dirent’ is out of the bounds of referenced subobject ‘d_name’ with type ‘char[256]’ at offset 19 [-Werror=array-bounds]
    106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In file included from /usr/include/dirent.h:61,
                   from util/parse-events.c:5:
  util/parse-events.c: In function ‘tracepoint_id_to_path’:
  /usr/include/bits/dirent.h:33:10: note: subobject ‘d_name’ declared here
     33 |     char d_name[256];  /* We must not include limits.h! */
        |          ^~~~~~
    CC       /tmp/build/perf/util/call-path.o

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20200302145535.GA28183@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c01ba6f8fdad..a14995835d85 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -257,21 +257,15 @@ struct tracepoint_path *tracepoint_id_to_path(u64 config)
 				path = zalloc(sizeof(*path));
 				if (!path)
 					return NULL;
-				path->system = malloc(MAX_EVENT_LENGTH);
-				if (!path->system) {
+				if (asprintf(&path->system, "%.*s", MAX_EVENT_LENGTH, sys_dirent->d_name) < 0) {
 					free(path);
 					return NULL;
 				}
-				path->name = malloc(MAX_EVENT_LENGTH);
-				if (!path->name) {
+				if (asprintf(&path->name, "%.*s", MAX_EVENT_LENGTH, evt_dirent->d_name) < 0) {
 					zfree(&path->system);
 					free(path);
 					return NULL;
 				}
-				strncpy(path->system, sys_dirent->d_name,
-					MAX_EVENT_LENGTH);
-				strncpy(path->name, evt_dirent->d_name,
-					MAX_EVENT_LENGTH);
 				return path;
 			}
 		}
-- 
2.21.1
