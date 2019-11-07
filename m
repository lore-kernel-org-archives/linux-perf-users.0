From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/63] perf auxtrace: Add auxtrace_cache__remove()
Date: Thu,  7 Nov 2019 15:59:33 -0300
Message-ID: <20191107190011.23924-26-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add auxtrace_cache__remove(). Intel PT uses an auxtrace_cache to store
the results of code-walking, so that the same block of instructions does
not have to be decoded repeatedly. However, when there are text poke
events, the associated cache entries need to be removed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Link: http://lore.kernel.org/lkml/20191025130000.13032-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 28 ++++++++++++++++++++++++++++
 tools/perf/util/auxtrace.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 8470dfe9fe97..c555c3ccd79d 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1457,6 +1457,34 @@ int auxtrace_cache__add(struct auxtrace_cache *c, u32 key,
 	return 0;
 }
 
+static struct auxtrace_cache_entry *auxtrace_cache__rm(struct auxtrace_cache *c,
+						       u32 key)
+{
+	struct auxtrace_cache_entry *entry;
+	struct hlist_head *hlist;
+	struct hlist_node *n;
+
+	if (!c)
+		return NULL;
+
+	hlist = &c->hashtable[hash_32(key, c->bits)];
+	hlist_for_each_entry_safe(entry, n, hlist, hash) {
+		if (entry->key == key) {
+			hlist_del(&entry->hash);
+			return entry;
+		}
+	}
+
+	return NULL;
+}
+
+void auxtrace_cache__remove(struct auxtrace_cache *c, u32 key)
+{
+	struct auxtrace_cache_entry *entry = auxtrace_cache__rm(c, key);
+
+	auxtrace_cache__free_entry(c, entry);
+}
+
 void *auxtrace_cache__lookup(struct auxtrace_cache *c, u32 key)
 {
 	struct auxtrace_cache_entry *entry;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index f201f36bc35f..3f4aa5427d76 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -489,6 +489,7 @@ void *auxtrace_cache__alloc_entry(struct auxtrace_cache *c);
 void auxtrace_cache__free_entry(struct auxtrace_cache *c, void *entry);
 int auxtrace_cache__add(struct auxtrace_cache *c, u32 key,
 			struct auxtrace_cache_entry *entry);
+void auxtrace_cache__remove(struct auxtrace_cache *c, u32 key);
 void *auxtrace_cache__lookup(struct auxtrace_cache *c, u32 key);
 
 struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
-- 
2.21.0
