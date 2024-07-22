Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5F516DC2B
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643215; cv=none; b=IrM5ZrptKMmEQ4I+Twob9QR+HVJfkz8XuW//QgPvN1GEAGd0ApM6fLLXSjisjsVamIrs0Onm/yu5dNLl76Ki7cbYSl2vbNEPbtyoV10ZIdtmhJzk7ts8tpyTPtQgTjWYRd5YM+Y04o5m6FnY1kQmxYMhu9wXEYezPx/80gfDcOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643215; c=relaxed/simple;
	bh=ItH9f426qXV+5rIZSG9tiSgqcCYNUSF0NPfya/+tqmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nBAtuzW2cCRIFzYsBCRn0sdmrX32l2ISsPu+SSM+XFkCwRKXYxZt1EoAYwnBytkz8hjcFhfw/y7UCSJ+Vzpf0AV2PL48GwB/9tOvYT4SDvXyWafHb7PUoftE9IDxw3gT3lk+MpjXC+QQVBZ1ldmokbGHXRiW2YZcyPshzsQWB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aLZ54Yaf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLZ54Yaf"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so2267893e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643212; x=1722248012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gac0SAR3KAIOUnKehRmkrRiaYS0y2TNr3epiBL0LQk8=;
        b=aLZ54YafX1paBdvvDhiozd5QD4RCMDtEZxQuSfC1iieNR178jtOhM28ohmLBABpPIf
         HmDBM67kJqCZxEbie4tEAGeZBK1jcJzV63eA2k/ECg5SXzs5YWym9fBbbrcFDlKs08bC
         tVcN08SNbTpZnhHUDlFq1mQSHJvGBYTlgVXwG9Z3TPDM2rUXO2YqWcDwpe5kDDIcxReq
         mTKsRzR7FMRaDqWMvWx8xZTgV2kLrZ9wCOfU9nYY6ftalwZHKfRbe25V8zfuOEZqGb9F
         vO0u8Vm2ERY71qQEoGT2Zr10PoE3HcagCn/Is9fZY5+9j33H8sFx/Fm7vEUmA6mHNECG
         KCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643212; x=1722248012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gac0SAR3KAIOUnKehRmkrRiaYS0y2TNr3epiBL0LQk8=;
        b=bkWQh/CvRJI3/SVpvKOduqiCHD6Zhmuv9QoP7HmqTMkySVvusDkf9l/T2F3kFg7mJH
         6Pu/KVQ96fQo5Iv7R4Ly3bMm/rvvv+HeeZDCXmzN3nr6NzkPph4LWRWjpV1B6rQzp54M
         EBA8u2fHbNeGrMnb1mPClF5kElH3h49LepNDKXx/H7IrJbLecUuqReKBM4zt8mXswfDI
         Et6DnZ/Wl1ObcGCKylZufWZbso7v3bSLgG556s5kmvmWwiqHNC2yrrRGZnU1cvaAoBvK
         kHF1zzyhN/Y328z9RjMt7xQox+csK8+KXPRbFcgALXpre/O0FL3lReeCcm5lKvXGpIqQ
         3jiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU+LwG5ADzijKxDbR8pDPEbyPflXrKU24NlW/HRLaU4mTwI6sRYcgmJvCJYXMpN1Qtx9cgX0SzVfMqxFXxNZDD+PrEzbRV/DSwp14IuISzNA==
X-Gm-Message-State: AOJu0YykrUWnax5K9CpO7efLICG10Nu8y2ZVhsHRvTwr+0NthC/ou1wv
	81u6AdVwbapf5VOcJVKMm8SkGhQ1orPF3NzNjAwLrPXQ8xKNR89sOU48NHWis2U=
X-Google-Smtp-Source: AGHT+IGTZQIhy3gNPKPI7DGy65qUrKCQGhBq5C4l1bUGJPNsWt1iC1rZkJ6h0IJVzpzgCf+Q3zsCVw==
X-Received: by 2002:a2e:92d5:0:b0:2ef:2cbc:9074 with SMTP id 38308e7fff4ca-2ef2cbc91c3mr21432381fa.21.1721643212217;
        Mon, 22 Jul 2024 03:13:32 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:13:31 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@arm.com>,
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
Subject: [PATCH v6 13/17] coresight: Make CPU id map a property of a trace ID map
Date: Mon, 22 Jul 2024 11:11:55 +0100
Message-Id: <20240722101202.26915-14-james.clark@linaro.org>
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

The global CPU ID mappings won't work for per-sink ID maps so move it to
the ID map struct. coresight_trace_id_release_all_pending() is hard
coded to operate on the default map, but once Perf sessions use their
own maps the pending release mechanism will be deleted. So it doesn't
need to be extended to accept a trace ID map argument at this point.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-trace-id.c | 16 +++++++++-------
 include/linux/coresight.h                        |  1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index 5561989a03fa..8a777c0af6ea 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -13,10 +13,12 @@
 #include "coresight-trace-id.h"
 
 /* Default trace ID map. Used in sysfs mode and for system sources */
-static struct coresight_trace_id_map id_map_default;
+static DEFINE_PER_CPU(atomic_t, id_map_default_cpu_ids) = ATOMIC_INIT(0);
+static struct coresight_trace_id_map id_map_default = {
+	.cpu_map = &id_map_default_cpu_ids
+};
 
-/* maintain a record of the mapping of IDs and pending releases per cpu */
-static DEFINE_PER_CPU(atomic_t, cpu_id) = ATOMIC_INIT(0);
+/* maintain a record of the pending releases per cpu */
 static cpumask_t cpu_id_release_pending;
 
 /* perf session active counter */
@@ -49,7 +51,7 @@ static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
 /* unlocked read of current trace ID value for given CPU */
 static int _coresight_trace_id_read_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
 {
-	return atomic_read(&per_cpu(cpu_id, cpu));
+	return atomic_read(per_cpu_ptr(id_map->cpu_map, cpu));
 }
 
 /* look for next available odd ID, return 0 if none found */
@@ -145,7 +147,7 @@ static void coresight_trace_id_release_all_pending(void)
 		clear_bit(bit, id_map->pend_rel_ids);
 	}
 	for_each_cpu(cpu, &cpu_id_release_pending) {
-		atomic_set(&per_cpu(cpu_id, cpu), 0);
+		atomic_set(per_cpu_ptr(id_map_default.cpu_map, cpu), 0);
 		cpumask_clear_cpu(cpu, &cpu_id_release_pending);
 	}
 	spin_unlock_irqrestore(&id_map_lock, flags);
@@ -181,7 +183,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
 		goto get_cpu_id_out_unlock;
 
 	/* allocate the new id to the cpu */
-	atomic_set(&per_cpu(cpu_id, cpu), id);
+	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
 
 get_cpu_id_clr_pend:
 	/* we are (re)using this ID - so ensure it is not marked for release */
@@ -215,7 +217,7 @@ static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_ma
 	} else {
 		/* otherwise clear id */
 		coresight_trace_id_free(id, id_map);
-		atomic_set(&per_cpu(cpu_id, cpu), 0);
+		atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
 	}
 
 	spin_unlock_irqrestore(&id_map_lock, flags);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index c16c61a8411d..7d62b88bfb5c 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -234,6 +234,7 @@ struct coresight_sysfs_link {
 struct coresight_trace_id_map {
 	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
 	DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
+	atomic_t __percpu *cpu_map;
 };
 
 /**
-- 
2.34.1

