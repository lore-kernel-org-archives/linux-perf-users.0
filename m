Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478862C6BD;
	Tue, 11 Jun 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118278; cv=none; b=Icsuz8O68fN0trTRntJEYP25aJhGAofHSkv/7VZOYwCuNNl23dmOgH1L1LRnDypepsgPkUO4hA7kR9ExJibf9IaxpzHUKspUBTDF9JG04+h+6+GXVJgCZqEEDB8hq1C1+SVVdVK4St08N0q70S/jY10DaHKYP0SF44pZPVK1U2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118278; c=relaxed/simple;
	bh=+CPbZPwm6idt1BjhNLaLWLEAeeaJnKpKlDcqDQnTcn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awgq3pDBwUH/V6rCMA6JMK9itYndMiQ9hd6vL2JoKQgW5VZohtokPwHW1jtNpsv5nQccFl3AXYJ6wQlTX6BDOY3IA6ELSKJ/1IEr5uQBhiN2CETpDhF5CJws1ds/eKhFE/rfsbMlIgFsBJXx82sysvB4MOxUEMY4vJLBahyRbKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CBD3106F;
	Tue, 11 Jun 2024 08:05:01 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.41.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B2FD3F64C;
	Tue, 11 Jun 2024 08:04:32 -0700 (PDT)
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
Subject: [PATCH v3 14/14] coresight: Make trace ID map spinlock local to the map
Date: Tue, 11 Jun 2024 16:02:25 +0100
Message-Id: <20240611150228.1802828-15-james.clark@arm.com>
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

Reduce contention on the lock by replacing the global lock with one for
each map.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c  |  1 +
 .../hwtracing/coresight/coresight-trace-id.c  | 26 +++++++++----------
 include/linux/coresight.h                     |  1 +
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index c427e9344a84..ea38ecf26fcb 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1164,6 +1164,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 
 	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
 	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+		spin_lock_init(&csdev->perf_sink_id_map.lock);
 		csdev->perf_sink_id_map.cpu_map = alloc_percpu(atomic_t);
 		if (!csdev->perf_sink_id_map.cpu_map) {
 			kfree(csdev);
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index 1e70892f5beb..82bb70c1ad73 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -15,12 +15,10 @@
 /* Default trace ID map. Used in sysfs mode and for system sources */
 static DEFINE_PER_CPU(atomic_t, id_map_default_cpu_ids) = ATOMIC_INIT(0);
 static struct coresight_trace_id_map id_map_default = {
-	.cpu_map = &id_map_default_cpu_ids
+	.cpu_map = &id_map_default_cpu_ids,
+	.lock = __SPIN_LOCK_UNLOCKED(id_map_default.lock)
 };
 
-/* lock to protect id_map and cpu data  */
-static DEFINE_SPINLOCK(id_map_lock);
-
 /* #define TRACE_ID_DEBUG 1 */
 #if defined(TRACE_ID_DEBUG) || defined(CONFIG_COMPILE_TEST)
 
@@ -124,11 +122,11 @@ static void coresight_trace_id_release_all(struct coresight_trace_id_map *id_map
 	unsigned long flags;
 	int cpu;
 
-	spin_lock_irqsave(&id_map_lock, flags);
+	spin_lock_irqsave(&id_map->lock, flags);
 	bitmap_zero(id_map->used_ids, CORESIGHT_TRACE_IDS_MAX);
 	for_each_possible_cpu(cpu)
 		atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
-	spin_unlock_irqrestore(&id_map_lock, flags);
+	spin_unlock_irqrestore(&id_map->lock, flags);
 	DUMP_ID_MAP(id_map);
 }
 
@@ -137,7 +135,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
 	unsigned long flags;
 	int id;
 
-	spin_lock_irqsave(&id_map_lock, flags);
+	spin_lock_irqsave(&id_map->lock, flags);
 
 	/* check for existing allocation for this CPU */
 	id = _coresight_trace_id_read_cpu_id(cpu, id_map);
@@ -164,7 +162,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
 	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
 
 get_cpu_id_out_unlock:
-	spin_unlock_irqrestore(&id_map_lock, flags);
+	spin_unlock_irqrestore(&id_map->lock, flags);
 
 	DUMP_ID_CPU(cpu, id);
 	DUMP_ID_MAP(id_map);
@@ -181,12 +179,12 @@ static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_ma
 	if (!id)
 		return;
 
-	spin_lock_irqsave(&id_map_lock, flags);
+	spin_lock_irqsave(&id_map->lock, flags);
 
 	coresight_trace_id_free(id, id_map);
 	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
 
-	spin_unlock_irqrestore(&id_map_lock, flags);
+	spin_unlock_irqrestore(&id_map->lock, flags);
 	DUMP_ID_CPU(cpu, id);
 	DUMP_ID_MAP(id_map);
 }
@@ -196,10 +194,10 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
 	unsigned long flags;
 	int id;
 
-	spin_lock_irqsave(&id_map_lock, flags);
+	spin_lock_irqsave(&id_map->lock, flags);
 	/* prefer odd IDs for system components to avoid legacy CPU IDS */
 	id = coresight_trace_id_alloc_new_id(id_map, 0, true);
-	spin_unlock_irqrestore(&id_map_lock, flags);
+	spin_unlock_irqrestore(&id_map->lock, flags);
 
 	DUMP_ID(id);
 	DUMP_ID_MAP(id_map);
@@ -210,9 +208,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&id_map_lock, flags);
+	spin_lock_irqsave(&id_map->lock, flags);
 	coresight_trace_id_free(id, id_map);
-	spin_unlock_irqrestore(&id_map_lock, flags);
+	spin_unlock_irqrestore(&id_map->lock, flags);
 
 	DUMP_ID(id);
 	DUMP_ID_MAP(id_map);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 197949fd2c35..c13342594278 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -233,6 +233,7 @@ struct coresight_trace_id_map {
 	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
 	atomic_t __percpu *cpu_map;
 	atomic_t perf_cs_etm_session_active;
+	spinlock_t lock;
 };
 
 /**
-- 
2.34.1

