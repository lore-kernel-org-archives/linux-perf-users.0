Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B087416DEB1
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643227; cv=none; b=u9kPr1SxTTO5uz8IWoshsJNDwSOp9C6eoTAzdR5JlNMoVagU8/K80p42M8Q0ocZeKuM6KDaU07W07CW9Ij11BMbElZCnEW3YVWD33++i0thr1hd6TyfXGVuz/OJfJbT7RPl/ffcg5z7CIwuCXv4RpP0Eyfj0cNyPGwT0JlxYoHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643227; c=relaxed/simple;
	bh=K7UMVr+Mb2yQooqK7gzXDOwZNrewkjFmCowy8ExaG+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lO64by0zFDCCKjYj+7gdagSLOxQljouyNPJaPnSQVPB/yWyGzQy8ykQ8zPHK9+wDSSGd9xrDkk0ZjPNsxd8QPB7/ljx+yuvj6ywaEIC+F1jbVKQQLHAljAk1c2mPVUqubMBQOlh7pVWBEqpt3ppd1O5QddAX3SctYt39iyL8FU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rc+/egzi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rc+/egzi"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so18480421fa.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 03:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643222; x=1722248022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsMCqr8T/iQ+uuTbOOHukf9tVZI/Fi7NUej0XAYkU4g=;
        b=rc+/egzit6BngmDKes4O4EJXUudiR3BZ6NpY4P95SDkBBmaa1+eTk/I9h8gj/ijgaa
         24luTCLJEgV+GAhezJDOS1mqHvyrZF5LpQiPXkAwsdA5yWky0OtjNDN9qMr/q+4gsYVl
         x9GbhFVkllHFeMJpFoomwhYCfVqba18N87SMvJoJXX6KURAXAItM7l+F2LSxVkChrrMn
         GHQXdOqssJQx8aTU2C+rWdCk+yjVSwWXZi13ZBVv0bWw75ufRK8tLsPVJ5uEBY1bxAZm
         Ge7AniMp2Xh2EPj5oEPR38uGUe5lnrNfFvhpjJPJnYpeJfBJe3BExD0xt8QxYZeBXSgm
         g+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643222; x=1722248022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsMCqr8T/iQ+uuTbOOHukf9tVZI/Fi7NUej0XAYkU4g=;
        b=hNuVSMXMHiTX+PafSSFDEf5PMP7Rpv/aYiVC73Z1HX4CYS03eFRhkl34WBtF19vD3a
         qfeE3H7xkupMiuzhbwgn2S9t861MJG98cX3GeP2pOvvexs9vZ/PRQt/QuCBnzzoYVzLB
         rVucn+HqV3OhIq54YZH3TG2OalFmcTntofiGn2lXyk6quqMj1eB0HwGJQxZ2o3bkK08Z
         LN23V13z6BBnKBQK8Eqg7AKeD2Z1+etyZrCuPEfPfeHNUZ5s34ieAW5X3iO6rtz1NuMa
         6jT7gqqGB7ykbud+xD5WPBkoQpva+x5LzsHxgr+hTPUfb4wsk68EMhXw3UduTjQRmhDx
         NnzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR9uoBrc8DSTEzq0P1ohBmTo4AB+wgtnCKeyr05UGs3czGxUoGEa+m1U03KOyerYvE/MbjChddVQ2buyM2JLAuBCTlOcCaeX15laXLG1WFMw==
X-Gm-Message-State: AOJu0YxSIsOJg6OAvS64ex69Ss13qaYhjt8KUNFFad4KED2RfAZJCLl6
	6+YU36HGwbntcEZYAVQ7Vj0fv39b8P/ti1Hpv891rq9UpifcUTVVog0j2M5XWVo=
X-Google-Smtp-Source: AGHT+IG0+HTTZyt6B1wjcPhyso/9PPXNw3Zz5eazwlaGyZ8sJpY8m+dE74ZSt2EZzuVAZPlRLLGtUA==
X-Received: by 2002:a2e:8395:0:b0:2ef:2c20:e064 with SMTP id 38308e7fff4ca-2ef2c20e206mr23408401fa.12.1721643221951;
        Mon, 22 Jul 2024 03:13:41 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:13:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 15/17] coresight: Remove pending trace ID release mechanism
Date: Mon, 22 Jul 2024 11:11:57 +0100
Message-Id: <20240722101202.26915-16-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722101202.26915-1-james.clark@linaro.org>
References: <20240722101202.26915-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

Pending the release of IDs was a way of managing concurrent sysfs and
Perf sessions in a single global ID map. Perf may have finished while
sysfs hadn't, and Perf shouldn't release the IDs in use by sysfs and
vice versa.

Now that Perf uses its own exclusive ID maps, pending release doesn't
result in any different behavior than just releasing all IDs when the
last Perf session finishes. As part of the per-sink trace ID change, we
would have still had to make the pending mechanism work on a per-sink
basis, due to the overlapping ID allocations, so instead of making that
more complicated, just remove it.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 18 +++--
 .../hwtracing/coresight/coresight-trace-id.c  | 67 +++++--------------
 .../hwtracing/coresight/coresight-trace-id.h  | 31 ++++-----
 include/linux/coresight.h                     |  6 +-
 4 files changed, 43 insertions(+), 79 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 7fb55dafb639..70c99f0409b2 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -232,15 +232,21 @@ static void free_event_data(struct work_struct *work)
 		if (!(IS_ERR_OR_NULL(*ppath))) {
 			struct coresight_device *sink = coresight_get_sink(*ppath);
 
-			coresight_trace_id_put_cpu_id_map(cpu, &sink->perf_sink_id_map);
+			/*
+			 * Mark perf event as done for trace id allocator, but don't call
+			 * coresight_trace_id_put_cpu_id_map() on individual IDs. Perf sessions
+			 * never free trace IDs to ensure that the ID associated with a CPU
+			 * cannot change during their and other's concurrent sessions. Instead,
+			 * a refcount is used so that the last event to call
+			 * coresight_trace_id_perf_stop() frees all IDs.
+			 */
+			coresight_trace_id_perf_stop(&sink->perf_sink_id_map);
+
 			coresight_release_path(*ppath);
 		}
 		*ppath = NULL;
 	}
 
-	/* mark perf event as done for trace id allocator */
-	coresight_trace_id_perf_stop();
-
 	free_percpu(event_data->path);
 	kfree(event_data);
 }
@@ -328,9 +334,6 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		sink = user_sink = coresight_get_sink_by_id(id);
 	}
 
-	/* tell the trace ID allocator that a perf event is starting up */
-	coresight_trace_id_perf_start();
-
 	/* check if user wants a coresight configuration selected */
 	cfg_hash = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >> 32);
 	if (cfg_hash) {
@@ -411,6 +414,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 			continue;
 		}
 
+		coresight_trace_id_perf_start(&sink->perf_sink_id_map);
 		*etm_event_cpu_path_ptr(event_data, cpu) = path;
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index 8a777c0af6ea..bddaed3e5cf8 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -18,12 +18,6 @@ static struct coresight_trace_id_map id_map_default = {
 	.cpu_map = &id_map_default_cpu_ids
 };
 
-/* maintain a record of the pending releases per cpu */
-static cpumask_t cpu_id_release_pending;
-
-/* perf session active counter */
-static atomic_t perf_cs_etm_session_active = ATOMIC_INIT(0);
-
 /* lock to protect id_map and cpu data  */
 static DEFINE_SPINLOCK(id_map_lock);
 
@@ -35,7 +29,6 @@ static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
 {
 	pr_debug("%s id_map::\n", func_name);
 	pr_debug("Used = %*pb\n", CORESIGHT_TRACE_IDS_MAX, id_map->used_ids);
-	pr_debug("Pend = %*pb\n", CORESIGHT_TRACE_IDS_MAX, id_map->pend_rel_ids);
 }
 #define DUMP_ID_MAP(map)   coresight_trace_id_dump_table(map, __func__)
 #define DUMP_ID_CPU(cpu, id) pr_debug("%s called;  cpu=%d, id=%d\n", __func__, cpu, id)
@@ -122,34 +115,18 @@ static void coresight_trace_id_free(int id, struct coresight_trace_id_map *id_ma
 	clear_bit(id, id_map->used_ids);
 }
 
-static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_map *id_map)
-{
-	if (WARN(!IS_VALID_CS_TRACE_ID(id), "Invalid Trace ID %d\n", id))
-		return;
-	set_bit(id, id_map->pend_rel_ids);
-}
-
 /*
- * release all pending IDs for all current maps & clear CPU associations
- *
- * This currently operates on the default id map, but may be extended to
- * operate on all registered id maps if per sink id maps are used.
+ * Release all IDs and clear CPU associations.
  */
-static void coresight_trace_id_release_all_pending(void)
+static void coresight_trace_id_release_all(struct coresight_trace_id_map *id_map)
 {
-	struct coresight_trace_id_map *id_map = &id_map_default;
 	unsigned long flags;
-	int cpu, bit;
+	int cpu;
 
 	spin_lock_irqsave(&id_map_lock, flags);
-	for_each_set_bit(bit, id_map->pend_rel_ids, CORESIGHT_TRACE_ID_RES_TOP) {
-		clear_bit(bit, id_map->used_ids);
-		clear_bit(bit, id_map->pend_rel_ids);
-	}
-	for_each_cpu(cpu, &cpu_id_release_pending) {
-		atomic_set(per_cpu_ptr(id_map_default.cpu_map, cpu), 0);
-		cpumask_clear_cpu(cpu, &cpu_id_release_pending);
-	}
+	bitmap_zero(id_map->used_ids, CORESIGHT_TRACE_IDS_MAX);
+	for_each_possible_cpu(cpu)
+		atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
 	spin_unlock_irqrestore(&id_map_lock, flags);
 	DUMP_ID_MAP(id_map);
 }
@@ -164,7 +141,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
 	/* check for existing allocation for this CPU */
 	id = _coresight_trace_id_read_cpu_id(cpu, id_map);
 	if (id)
-		goto get_cpu_id_clr_pend;
+		goto get_cpu_id_out_unlock;
 
 	/*
 	 * Find a new ID.
@@ -185,11 +162,6 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
 	/* allocate the new id to the cpu */
 	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
 
-get_cpu_id_clr_pend:
-	/* we are (re)using this ID - so ensure it is not marked for release */
-	cpumask_clear_cpu(cpu, &cpu_id_release_pending);
-	clear_bit(id, id_map->pend_rel_ids);
-
 get_cpu_id_out_unlock:
 	spin_unlock_irqrestore(&id_map_lock, flags);
 
@@ -210,15 +182,8 @@ static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_ma
 
 	spin_lock_irqsave(&id_map_lock, flags);
 
-	if (atomic_read(&perf_cs_etm_session_active)) {
-		/* set release at pending if perf still active */
-		coresight_trace_id_set_pend_rel(id, id_map);
-		cpumask_set_cpu(cpu, &cpu_id_release_pending);
-	} else {
-		/* otherwise clear id */
-		coresight_trace_id_free(id, id_map);
-		atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
-	}
+	coresight_trace_id_free(id, id_map);
+	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
 
 	spin_unlock_irqrestore(&id_map_lock, flags);
 	DUMP_ID_CPU(cpu, id);
@@ -302,17 +267,17 @@ void coresight_trace_id_put_system_id(int id)
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
 
-void coresight_trace_id_perf_start(void)
+void coresight_trace_id_perf_start(struct coresight_trace_id_map *id_map)
 {
-	atomic_inc(&perf_cs_etm_session_active);
-	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
+	atomic_inc(&id_map->perf_cs_etm_session_active);
+	PERF_SESSION(atomic_read(&id_map->perf_cs_etm_session_active));
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
 
-void coresight_trace_id_perf_stop(void)
+void coresight_trace_id_perf_stop(struct coresight_trace_id_map *id_map)
 {
-	if (!atomic_dec_return(&perf_cs_etm_session_active))
-		coresight_trace_id_release_all_pending();
-	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
+	if (!atomic_dec_return(&id_map->perf_cs_etm_session_active))
+		coresight_trace_id_release_all(id_map);
+	PERF_SESSION(atomic_read(&id_map->perf_cs_etm_session_active));
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
index 840babdd0794..9aae50a553ca 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.h
+++ b/drivers/hwtracing/coresight/coresight-trace-id.h
@@ -17,9 +17,10 @@
  * released when done.
  *
  * In order to ensure that a consistent cpu / ID matching is maintained
- * throughout a perf cs_etm event session - a session in progress flag will
- * be maintained, and released IDs not cleared until the perf session is
- * complete. This allows the same CPU to be re-allocated its prior ID.
+ * throughout a perf cs_etm event session - a session in progress flag will be
+ * maintained for each sink, and IDs are cleared when all the perf sessions
+ * complete. This allows the same CPU to be re-allocated its prior ID when
+ * events are scheduled in and out.
  *
  *
  * Trace ID maps will be created and initialised to prevent architecturally
@@ -66,11 +67,7 @@ int coresight_trace_id_get_cpu_id_map(int cpu, struct coresight_trace_id_map *id
 /**
  * Release an allocated trace ID associated with the CPU.
  *
- * This will release the CoreSight trace ID associated with the CPU,
- * unless a perf session is in operation.
- *
- * If a perf session is in operation then the ID will be marked as pending
- * release.
+ * This will release the CoreSight trace ID associated with the CPU.
  *
  * @cpu: The CPU index to release the associated trace ID.
  */
@@ -133,21 +130,21 @@ void coresight_trace_id_put_system_id(int id);
 /**
  * Notify the Trace ID allocator that a perf session is starting.
  *
- * Increase the perf session reference count - called by perf when setting up
- * a trace event.
+ * Increase the perf session reference count - called by perf when setting up a
+ * trace event.
  *
- * This reference count is used by the ID allocator to ensure that trace IDs
- * associated with a CPU cannot change or be released during a perf session.
+ * Perf sessions never free trace IDs to ensure that the ID associated with a
+ * CPU cannot change during their and other's concurrent sessions. Instead,
+ * this refcount is used so that the last event to finish always frees all IDs.
  */
-void coresight_trace_id_perf_start(void);
+void coresight_trace_id_perf_start(struct coresight_trace_id_map *id_map);
 
 /**
  * Notify the ID allocator that a perf session is stopping.
  *
- * Decrease the perf session reference count.
- * if this causes the count to go to zero, then all Trace IDs marked as pending
- * release, will be released.
+ * Decrease the perf session reference count. If this causes the count to go to
+ * zero, then all Trace IDs will be released.
  */
-void coresight_trace_id_perf_stop(void);
+void coresight_trace_id_perf_stop(struct coresight_trace_id_map *id_map);
 
 #endif /* _CORESIGHT_TRACE_ID_H */
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 9c3067e2e38b..197949fd2c35 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -227,14 +227,12 @@ struct coresight_sysfs_link {
  * @used_ids:	Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
  *		Initialised so that the reserved IDs are permanently marked as
  *		in use.
- * @pend_rel_ids: CPU IDs that have been released by the trace source but not
- *		  yet marked as available, to allow re-allocation to the same
- *		  CPU during a perf session.
+ * @perf_cs_etm_session_active: Number of Perf sessions using this ID map.
  */
 struct coresight_trace_id_map {
 	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
-	DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
 	atomic_t __percpu *cpu_map;
+	atomic_t perf_cs_etm_session_active;
 };
 
 /**
-- 
2.34.1

