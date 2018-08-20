From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/21] perf python: Fix pyrf_evlist__read_on_cpu() interface
Date: Mon, 20 Aug 2018 13:16:00 -0300
Message-ID: <20180820161602.6830-20-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Joe Mario <jmario@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Jaroslav reported errors from valgrind over perf python script:

  # echo 0 > /sys/devices/system/cpu/cpu4/online
  # valgrind ./test.py
  ==7524== Memcheck, a memory error detector
  ...
  ==7524== Command: ./test.py
  ==7524==
  pid 7526 exited
  ==7524== Invalid read of size 8
  ==7524==    at 0xCC2C2B3: perf_mmap__read_forward (evlist.c:780)
  ==7524==    by 0xCC2A681: pyrf_evlist__read_on_cpu (python.c:959)
  ...
  ==7524==  Address 0x65c4868 is 16 bytes after a block of size 459,36..
  ==7524==    at 0x4C2B955: calloc (vg_replace_malloc.c:711)
  ==7524==    by 0xCC2F484: zalloc (util.h:35)
  ==7524==    by 0xCC2F484: perf_evlist__alloc_mmap (evlist.c:978)
  ...

The reason for this is in the python interface, that allows a script to
pass arbitrary cpu number, which is then used to access struct
perf_evlist::mmap array. That's obviously wrong and works only when if
all cpus are available and fails if some cpu is missing, like in the
example above.

This patch makes pyrf_evlist__read_on_cpu() search the evlist's maps
array for the proper map to access.

It's linear search at the moment. Based on the way how is the
read_on_cpu used, I don't think we need to be fast in here.  But we
could add some hash in the middle to make it fast/er.

We don't allow python interface to set write_backward event attribute,
so it's safe to check only evlist's mmaps.

Reported-by: Jaroslav Škarvada <jskarvad@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817114556.28000-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f74fbb652a4f..ce501ba14b08 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -11,6 +11,7 @@
 #include "cpumap.h"
 #include "print_binary.h"
 #include "thread_map.h"
+#include "mmap.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyUnicode_FromString(arg) \
@@ -976,6 +977,20 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 	return Py_BuildValue("i", evlist->nr_entries);
 }
 
+static struct perf_mmap *get_md(struct perf_evlist *evlist, int cpu)
+{
+	int i;
+
+	for (i = 0; i < evlist->nr_mmaps; i++) {
+		struct perf_mmap *md = &evlist->mmap[i];
+
+		if (md->cpu == cpu)
+			return md;
+	}
+
+	return NULL;
+}
+
 static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 					  PyObject *args, PyObject *kwargs)
 {
@@ -990,7 +1005,10 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 					 &cpu, &sample_id_all))
 		return NULL;
 
-	md = &evlist->mmap[cpu];
+	md = get_md(evlist, cpu);
+	if (!md)
+		return NULL;
+
 	if (perf_mmap__read_init(md) < 0)
 		goto end;
 
-- 
2.14.4
