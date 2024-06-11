Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675BD381DF;
	Tue, 11 Jun 2024 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118230; cv=none; b=p8hnGOlpR4Cid6T0Nd34vucKIU5VUfRvRntGqBNzLGatw0+4nUMBJCDfgazHUzWKHm4gMngmb+q4JOpJgmKO2ICLg9Jq777YJMpAd5sXO36sZENdzN+zf5nVTcBytOHEG+PbJ4Q03ZsW3OcLnwh3sWswZR0QX2ZSBlIQvuN/tsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118230; c=relaxed/simple;
	bh=P1WyyQPLwTQFk5WbskNdpN+wvmgxvGdDio47JAr50cM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDQaSmSIaqF7bPKaBfhjRsTIlZmjaMGAZkM9xLAVCYMigHdEK4gEh1EYYBZunDYlnVIWTqDTMs+fsRHZzOiOL1cjfCzpWjeRX1LHOM6+zotlEvqvrx6oOAcn95mE4nhO1vlpdEpbeACs2U0U7POYzbHx9cm7LruN3MNqnrfYcYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 906381595;
	Tue, 11 Jun 2024 08:04:12 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.41.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D8323F64C;
	Tue, 11 Jun 2024 08:03:43 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 09/14] coresight: Expose map arguments in trace ID API
Date: Tue, 11 Jun 2024 16:02:20 +0100
Message-Id: <20240611150228.1802828-10-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611150228.1802828-1-james.clark@arm.com>
References: <20240611150228.1802828-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trace ID API is currently hard coded to always use the global map.
Add public versions that allow the map to be passed in so that Perf
mode can use per-sink maps. Keep the non-map versions so that sysfs
mode can continue to use the default global map.

System ID functions are unchanged because they will always use the
default map.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../hwtracing/coresight/coresight-trace-id.c  | 36 ++++++++++++++-----
 .../hwtracing/coresight/coresight-trace-id.h  | 20 +++++++++--
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index 19005b5b4dc4..5561989a03fa 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -12,7 +12,7 @@
 
 #include "coresight-trace-id.h"
 
-/* Default trace ID map. Used on systems that don't require per sink mappings */
+/* Default trace ID map. Used in sysfs mode and for system sources */
 static struct coresight_trace_id_map id_map_default;
 
 /* maintain a record of the mapping of IDs and pending releases per cpu */
@@ -47,7 +47,7 @@ static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
 #endif
 
 /* unlocked read of current trace ID value for given CPU */
-static int _coresight_trace_id_read_cpu_id(int cpu)
+static int _coresight_trace_id_read_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
 {
 	return atomic_read(&per_cpu(cpu_id, cpu));
 }
@@ -152,7 +152,7 @@ static void coresight_trace_id_release_all_pending(void)
 	DUMP_ID_MAP(id_map);
 }
 
-static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
+static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
 {
 	unsigned long flags;
 	int id;
@@ -160,7 +160,7 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
 	spin_lock_irqsave(&id_map_lock, flags);
 
 	/* check for existing allocation for this CPU */
-	id = _coresight_trace_id_read_cpu_id(cpu);
+	id = _coresight_trace_id_read_cpu_id(cpu, id_map);
 	if (id)
 		goto get_cpu_id_clr_pend;
 
@@ -196,13 +196,13 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
 	return id;
 }
 
-static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
+static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
 {
 	unsigned long flags;
 	int id;
 
 	/* check for existing allocation for this CPU */
-	id = _coresight_trace_id_read_cpu_id(cpu);
+	id = _coresight_trace_id_read_cpu_id(cpu, id_map);
 	if (!id)
 		return;
 
@@ -254,22 +254,40 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
 
 int coresight_trace_id_get_cpu_id(int cpu)
 {
-	return coresight_trace_id_map_get_cpu_id(cpu, &id_map_default);
+	return _coresight_trace_id_get_cpu_id(cpu, &id_map_default);
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
 
+int coresight_trace_id_get_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map)
+{
+	return _coresight_trace_id_get_cpu_id(cpu, id_map);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id_map);
+
 void coresight_trace_id_put_cpu_id(int cpu)
 {
-	coresight_trace_id_map_put_cpu_id(cpu, &id_map_default);
+	_coresight_trace_id_put_cpu_id(cpu, &id_map_default);
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
 
+void coresight_trace_id_put_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map)
+{
+	_coresight_trace_id_put_cpu_id(cpu, id_map);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id_map);
+
 int coresight_trace_id_read_cpu_id(int cpu)
 {
-	return _coresight_trace_id_read_cpu_id(cpu);
+	return _coresight_trace_id_read_cpu_id(cpu, &id_map_default);
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id);
 
+int coresight_trace_id_read_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map)
+{
+	return _coresight_trace_id_read_cpu_id(cpu, id_map);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id_map);
+
 int coresight_trace_id_get_system_id(void)
 {
 	return coresight_trace_id_map_get_system_id(&id_map_default);
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
index 49438a96fcc6..840babdd0794 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.h
+++ b/drivers/hwtracing/coresight/coresight-trace-id.h
@@ -42,8 +42,6 @@
 #define IS_VALID_CS_TRACE_ID(id)	\
 	((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))
 
-/* Allocate and release IDs for a single default trace ID map */
-
 /**
  * Read and optionally allocate a CoreSight trace ID and associate with a CPU.
  *
@@ -59,6 +57,12 @@
  */
 int coresight_trace_id_get_cpu_id(int cpu);
 
+/**
+ * Version of coresight_trace_id_get_cpu_id() that allows the ID map to operate
+ * on to be provided.
+ */
+int coresight_trace_id_get_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map);
+
 /**
  * Release an allocated trace ID associated with the CPU.
  *
@@ -72,6 +76,12 @@ int coresight_trace_id_get_cpu_id(int cpu);
  */
 void coresight_trace_id_put_cpu_id(int cpu);
 
+/**
+ * Version of coresight_trace_id_put_cpu_id() that allows the ID map to operate
+ * on to be provided.
+ */
+void coresight_trace_id_put_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map);
+
 /**
  * Read the current allocated CoreSight Trace ID value for the CPU.
  *
@@ -92,6 +102,12 @@ void coresight_trace_id_put_cpu_id(int cpu);
  */
 int coresight_trace_id_read_cpu_id(int cpu);
 
+/**
+ * Version of coresight_trace_id_read_cpu_id() that allows the ID map to operate
+ * on to be provided.
+ */
+int coresight_trace_id_read_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map);
+
 /**
  * Allocate a CoreSight trace ID for a system component.
  *
-- 
2.34.1

