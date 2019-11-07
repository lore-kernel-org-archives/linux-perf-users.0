From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/63] perf dso: Add dso__data_write_cache_addr()
Date: Thu,  7 Nov 2019 15:59:35 -0300
Message-ID: <20191107190011.23924-28-acme@kernel.org>
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

Add functions to write into the dso file data cache, but not change the
file itself.

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
Link: http://lore.kernel.org/lkml/20191025130000.13032-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 73 ++++++++++++++++++++++++++++++++++---------
 tools/perf/util/dso.h |  7 +++++
 2 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 460330d125b6..0f1b77275a86 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -827,14 +827,16 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
 	return cache;
 }
 
-static ssize_t
-dso_cache__memcpy(struct dso_cache *cache, u64 offset,
-		  u8 *data, u64 size)
+static ssize_t dso_cache__memcpy(struct dso_cache *cache, u64 offset, u8 *data,
+				 u64 size, bool out)
 {
 	u64 cache_offset = offset - cache->offset;
 	u64 cache_size   = min(cache->size - cache_offset, size);
 
-	memcpy(data, cache->data + cache_offset, cache_size);
+	if (out)
+		memcpy(data, cache->data + cache_offset, cache_size);
+	else
+		memcpy(cache->data + cache_offset, data, cache_size);
 	return cache_size;
 }
 
@@ -910,8 +912,8 @@ static struct dso_cache *dso_cache__find(struct dso *dso,
 	return cache ? cache : dso_cache__populate(dso, machine, offset, ret);
 }
 
-static ssize_t dso_cache_read(struct dso *dso, struct machine *machine,
-			      u64 offset, u8 *data, ssize_t size)
+static ssize_t dso_cache_io(struct dso *dso, struct machine *machine,
+			    u64 offset, u8 *data, ssize_t size, bool out)
 {
 	struct dso_cache *cache;
 	ssize_t ret = 0;
@@ -920,16 +922,16 @@ static ssize_t dso_cache_read(struct dso *dso, struct machine *machine,
 	if (!cache)
 		return ret;
 
-	return dso_cache__memcpy(cache, offset, data, size);
+	return dso_cache__memcpy(cache, offset, data, size, out);
 }
 
 /*
  * Reads and caches dso data DSO__DATA_CACHE_SIZE size chunks
  * in the rb_tree. Any read to already cached data is served
- * by cached data.
+ * by cached data. Writes update the cache only, not the backing file.
  */
-static ssize_t cached_read(struct dso *dso, struct machine *machine,
-			   u64 offset, u8 *data, ssize_t size)
+static ssize_t cached_io(struct dso *dso, struct machine *machine,
+			 u64 offset, u8 *data, ssize_t size, bool out)
 {
 	ssize_t r = 0;
 	u8 *p = data;
@@ -937,7 +939,7 @@ static ssize_t cached_read(struct dso *dso, struct machine *machine,
 	do {
 		ssize_t ret;
 
-		ret = dso_cache_read(dso, machine, offset, p, size);
+		ret = dso_cache_io(dso, machine, offset, p, size, out);
 		if (ret < 0)
 			return ret;
 
@@ -1021,8 +1023,9 @@ off_t dso__data_size(struct dso *dso, struct machine *machine)
 	return dso->data.file_size;
 }
 
-static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
-				u64 offset, u8 *data, ssize_t size)
+static ssize_t data_read_write_offset(struct dso *dso, struct machine *machine,
+				      u64 offset, u8 *data, ssize_t size,
+				      bool out)
 {
 	if (dso__data_file_size(dso, machine))
 		return -1;
@@ -1034,7 +1037,7 @@ static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
 	if (offset + size < offset)
 		return -1;
 
-	return cached_read(dso, machine, offset, data, size);
+	return cached_io(dso, machine, offset, data, size, out);
 }
 
 /**
@@ -1054,7 +1057,7 @@ ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 	if (dso->data.status == DSO_DATA_STATUS_ERROR)
 		return -1;
 
-	return data_read_offset(dso, machine, offset, data, size);
+	return data_read_write_offset(dso, machine, offset, data, size, true);
 }
 
 /**
@@ -1075,6 +1078,46 @@ ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
 	return dso__data_read_offset(dso, machine, offset, data, size);
 }
 
+/**
+ * dso__data_write_cache_offs - Write data to dso data cache at file offset
+ * @dso: dso object
+ * @machine: machine object
+ * @offset: file offset
+ * @data: buffer to write
+ * @size: size of the @data buffer
+ *
+ * Write into the dso file data cache, but do not change the file itself.
+ */
+ssize_t dso__data_write_cache_offs(struct dso *dso, struct machine *machine,
+				   u64 offset, const u8 *data_in, ssize_t size)
+{
+	u8 *data = (u8 *)data_in; /* cast away const to use same fns for r/w */
+
+	if (dso->data.status == DSO_DATA_STATUS_ERROR)
+		return -1;
+
+	return data_read_write_offset(dso, machine, offset, data, size, false);
+}
+
+/**
+ * dso__data_write_cache_addr - Write data to dso data cache at dso address
+ * @dso: dso object
+ * @machine: machine object
+ * @add: virtual memory address
+ * @data: buffer to write
+ * @size: size of the @data buffer
+ *
+ * External interface to write into the dso file data cache, but do not change
+ * the file itself.
+ */
+ssize_t dso__data_write_cache_addr(struct dso *dso, struct map *map,
+				   struct machine *machine, u64 addr,
+				   const u8 *data, ssize_t size)
+{
+	u64 offset = map->map_ip(map, addr);
+	return dso__data_write_cache_offs(dso, machine, offset, data, size);
+}
+
 struct map *dso__new_map(const char *name)
 {
 	struct map *map = NULL;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index e4dddb76770d..2f1fcbc6fead 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -285,6 +285,8 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
  *   dso__data_size
  *   dso__data_read_offset
  *   dso__data_read_addr
+ *   dso__data_write_cache_offs
+ *   dso__data_write_cache_addr
  *
  * Please refer to the dso.c object code for each function and
  * arguments documentation. Following text tries to explain the
@@ -332,6 +334,11 @@ ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
 			    struct machine *machine, u64 addr,
 			    u8 *data, ssize_t size);
 bool dso__data_status_seen(struct dso *dso, enum dso_data_status_seen by);
+ssize_t dso__data_write_cache_offs(struct dso *dso, struct machine *machine,
+				   u64 offset, const u8 *data, ssize_t size);
+ssize_t dso__data_write_cache_addr(struct dso *dso, struct map *map,
+				   struct machine *machine, u64 addr,
+				   const u8 *data, ssize_t size);
 
 struct map *dso__new_map(const char *name);
 struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
-- 
2.21.0
