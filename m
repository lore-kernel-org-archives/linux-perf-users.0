Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D17716F849
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779801; cv=none; b=K2tmQk6gtRsTsGCS6e5/+AYjj11CtJa8bs4lKwoUeIskrGRr0DCtJUarSxJj1iEnfmzEZ1JurlibNof1vqyMNr5u3DdZbhgAsGzD/xYXrN3ynCISd2Mq27Iv1V8oD+nfNcPoQi58TyIHTCRoC/ulE8bq4b4AmBZk60wpxYRhh1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779801; c=relaxed/simple;
	bh=UTW/OfwmA4ld3QzlDfACLYRcwZq7k/DASd7CkYwDg7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kNfFTqrjMTwC7ZL4aqStk9K0lh15lVDULmMQg1r9FMXh2JEvemK10kdDQUU5vXvc0yQUzs+fGaYCZNaKeiVLMFW1G9tzqnPqtAQ3QkTo7vX+61lRJhpBTUdY1zfoilKKZxEp+1ADGa1urR6yNeVSSj0lohuvWWFEWNpFjRpL+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IFSx6Xy4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFSx6Xy4"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367a9ab4d81so1073478f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 03:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779798; x=1721384598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw3JiXl0fak9J6G8VyzP7DMJZdcF5dgcCnVpK8zfVIg=;
        b=IFSx6Xy4+8ZrtoeZABMpPkRWwUmlFJoylei7IEu4DDkGG1uDVpHVeI+mZ7mbq7XKbc
         ZPO7Z9RKMoFnc7LiIdiNjM+4scEY5SQwz7kn6d/doRUGJaIktdoAjpyJV/nuFrspnkAV
         UBi8LLBnqVm5Au8ezLtnY+4p0J0fj45joo5iIIsU7RSwXa4ozjLEHKlLdrUO9ag5Im+i
         Oy4nlEny6xpoLcEPfk9mfVldrNK91lQKnR4GQ2COxsy2F0NUJJSkiWJanA7v/p5p/udA
         yIjhP/bRCf2iJrIjeFAX0OXuOHsvh5eUUJuqlQNifbIjGMAFaVvELkzTMqjb19eO319O
         EjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779798; x=1721384598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gw3JiXl0fak9J6G8VyzP7DMJZdcF5dgcCnVpK8zfVIg=;
        b=MgmnBo5aBcAPwrdLSjzlPBXxNcaWSwfIAxGQyoFfCDhr8piiEo03U5Jftedrg7U10s
         zo7are+Yjs+AThVuoe5f1u3/TzBMDDaoDgpTjAuej6POY5+sztDmBkBqm107B71yS75l
         4hU6pxbwFhloO9Qyq0Nzjv5m/g59I+sNeLhAF7A8S2UuL/V/asoRXyYgoBorxa32m3Mz
         qC2HQX+ONnYbrr6rrjMyeizCegYHVi9laMFyWWq/z8vUCJku/48xsKwYiW29SGKUhtK8
         kqCcKZu/6IqQkgRi0/F/1N03F3CcXyNs6hZjP9IBIdbwdTVPfDipUfpv0VyNxF+0/Dry
         gVSg==
X-Forwarded-Encrypted: i=1; AJvYcCWLWiZexvORRO6kKBTcjXwMTILP+qf/69HsRgJvrkDTeRiEJrDVO23lvlD4xWOGmmfTqHUSh6a5kzwvc0G0Q0iNTWFcaKgVf3F0RdafKaQSYQ==
X-Gm-Message-State: AOJu0Yz/mQL8SclFWZX26QsVd310AGCBBIUHsUncfqnjrB+CodzHLiF+
	/9+mrw8SPE/DZB4K6xT8rt+EnvC0gGzHS5STT28TgKtotLEalwhAJVMuDjqbcEQ=
X-Google-Smtp-Source: AGHT+IHpzA6uuDW6rC4LyxVfILMxHzzD7mKtov3wJzqFs4ReHp/D8E/RFpGHGqfQyzBqwMqjZ3C2Aw==
X-Received: by 2002:a05:6000:188e:b0:367:97e9:1121 with SMTP id ffacd0b85a97d-367cea966fdmr8425170f8f.39.1720779797921;
        Fri, 12 Jul 2024 03:23:17 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:23:17 -0700 (PDT)
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
Subject: [PATCH v5 15/17] coresight: Remove pending trace ID release mechanism
Date: Fri, 12 Jul 2024 11:20:24 +0100
Message-Id: <20240712102029.3697965-16-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240712102029.3697965-1-james.clark@linaro.org>
References: <20240712102029.3697965-1-james.clark@linaro.org>
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

