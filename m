Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73C7171647
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779810; cv=none; b=i/USuIggFKwiRJl8Naw+ojtJgH7WAJeafP1t9sB7ScM9ObjZ7Va0i2mFERB0M85adnkHz4l3kj+vTz6L5+ncezG0xkLFMbTPUW2IxO2LaSkXI4QGizDF2+51W8o4B3+Q9aIGDBVwew/t9VucWKDa2Ah9cxCC3pGRQCyCtcvxjhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779810; c=relaxed/simple;
	bh=wyNmDtFNVLT/QQIdkPdJMHGJ0ByIMslVZbPDlZ1y0GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTC/OvRC26z92lfMTb4oyft/ZSDip+orDWLr6EEASYiY/FRl+XAyvDlq0PfXHcxRe4XEKZVuRBuPgRyyXx0jJb1StMt/F0NXYElgJZ7COyDnWgRVHO3vqSSx/uyOdz0S1bMLmKFlBr1JkvOQv2fC2NLi5xs+PALsHkcmxRff3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lWugS3Gg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWugS3Gg"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4279c10a40eso9428915e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 03:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779807; x=1721384607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpxSR+OxOJGXCnYWh++gbk7h/WN1CJFySV4IXuclqdY=;
        b=lWugS3GgHq4g+NMSekbCPEgSGrgn24fgRwtFmsxyjLnnnSY/eJqF/T/uYTN1wgcVLx
         kvo9BbMKFEG6+eZbPvyAzziduxoEyEoW6+UWcMW3lhCX2XYD+yx03t+7RwLRIgfZ/exb
         NF6QfhFHuBUVCyx88Uv6LjcJbwI7/ZF3Tuh+TtpFavw492FmiBQMUhqckoktkopnpvaL
         aDEetedo+fsXZaU+aF0PAePpfcBJT+Q/tF6roioQ3HzZj2aX+n9dO/h4rBZ0EsYlYMpk
         eTzKdVz0R1zqg8ZEnOlB3p+zsGw/K/JY/oHuQCMzqLhM0UDe+VL3Dl98AYGtf97Su+rF
         sNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779807; x=1721384607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpxSR+OxOJGXCnYWh++gbk7h/WN1CJFySV4IXuclqdY=;
        b=YAothxedS370C/GQD5ZKYISjYaDLgoYarP99qbnE8AWI5K+GPqt0z4XGeilXI5XmZq
         15XZ0kWFppH6qjaLuPTjDW/Xd6RiTbKLBtH/dVZ16MCYcmqu8BQkya+gmDlKM+XuZD3z
         px22ZLsZBTqC6bA9/HVy1s/hKxlsf5lfJjFyi8OD6mOSfxZxZ+vYypH8041pe+hVQ/fo
         JOIq8kpXkUwaIAe+1nvCrH0ykBeDCx+g5SGzxceQVMm0zTrL4Tc9gJ4Dh/+YIDf8k1Gy
         4m/od6zCZ31LSsf+k9UESX6dsBq/bkAgoJ8QeUm+HzqZUrEvrC61ZL/LwxAQ27MlqTGs
         GBNA==
X-Forwarded-Encrypted: i=1; AJvYcCXZysbBk5m30jqMcpiBDpKfwrEtbjQCnDXQHVVGpFrGpdN6rv+Br5JG+MLqpCmDi/qrUbMHldp+5B0NQmgaW9uO7EcLb0l0kycM6OR/2hN2zQ==
X-Gm-Message-State: AOJu0YwZNcVOG8PM+/FZD0cceF+Y0Nwv8E2m7c704Ph9y+7ZwK2LHLTV
	8lDixXJrWjrD0flMshH7ewzVJYOTB8Vc/MIymNqxxlWv7P0QpBd9356F+hp7E+w=
X-Google-Smtp-Source: AGHT+IGkdOJ8Ugbo4oD+wcaWDs6QuuzOVfByLPfLBnScuTNj4bSyK9c0zHmOSBDx2NODaqC0aYA2CA==
X-Received: by 2002:a05:600c:6d4:b0:426:6b85:bafb with SMTP id 5b1f17b1804b1-426707db6e7mr63038085e9.20.1720779807119;
        Fri, 12 Jul 2024 03:23:27 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:23:26 -0700 (PDT)
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
Subject: [PATCH v5 17/17] coresight: Make trace ID map spinlock local to the map
Date: Fri, 12 Jul 2024 11:20:26 +0100
Message-Id: <20240712102029.3697965-18-james.clark@linaro.org>
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

Reduce contention on the lock by replacing the global lock with one for
each map.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
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
index bddaed3e5cf8..d98e12cb30ec 100644
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
 
@@ -123,11 +121,11 @@ static void coresight_trace_id_release_all(struct coresight_trace_id_map *id_map
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
 
@@ -136,7 +134,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
 	unsigned long flags;
 	int id;
 
-	spin_lock_irqsave(&id_map_lock, flags);
+	spin_lock_irqsave(&id_map->lock, flags);
 
 	/* check for existing allocation for this CPU */
 	id = _coresight_trace_id_read_cpu_id(cpu, id_map);
@@ -163,7 +161,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
 	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
 
 get_cpu_id_out_unlock:
-	spin_unlock_irqrestore(&id_map_lock, flags);
+	spin_unlock_irqrestore(&id_map->lock, flags);
 
 	DUMP_ID_CPU(cpu, id);
 	DUMP_ID_MAP(id_map);
@@ -180,12 +178,12 @@ static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_ma
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
@@ -195,10 +193,10 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
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
@@ -209,9 +207,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
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

