Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244FA171081
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779805; cv=none; b=jNnF4juJOGUQhm5P+YiNjNtnhQ4HZlhldXf3zm8g+WLYMvKRXcK7qb1sS5E6X+HV7H9WlDz7ffnYFn/BEeaH2h0dENyHkNgGvuZitfNx+6FnE/GlvlFyeF68mpnujYFlf3MCSy/hzQaYyrfH7wFMETvMBuUuYYf75tvD9S32Gi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779805; c=relaxed/simple;
	bh=R90ilGzhlmKrnl/Tf2YBzGpAvvaGf6iqWUI2sv9es2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jvj/7RGN7zanR2xtVPWWDR+d9D0P8YUXPEy18xULqS/V+D7XOCfTvDlCXaLxBNzI+XqG53ML0akXcDQ1JTLwUlbgaABfnVsgsMdVjcESR1rrCY52wIo7YmWXx+ab8XHR3GI0IAzuu8Eua11JYp114i5PCQebJ2u6DDMEEKQrhN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sj8enpWN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sj8enpWN"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367a464e200so1034831f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779802; x=1721384602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dezHJ0WyvcpI5gEfWfKVPR1yIz5w0V94MRv9cOZmsu4=;
        b=Sj8enpWNc/IklPGIKS3ft/PIaynnE1WiT6CQf63Tzx7HUY413Sd4d5d6CYK1jnr5PE
         Lf06t0QSAYTRtgIvajqlyGK//eyGmUjOe6++m/fvGgB5YROQNWgieh0R0xocQEZnNIXU
         A4bsFc/cOy1V1wp+6Fq4TaOyxB9HpkJeDLzGgou3vaVgJE2NGLhh21qaUhr8rzSM65z3
         y+TfN9Fuo5X3TN1bJoe3XlzO8NBsHdwbKXRzAF4eutAtZC5FhHPrdEDp8hKzK+JSgzOJ
         lCNzo4x0ShrdAisInpBDaxvg7G70nOjXNeaOygtucsiUwEb+nh18E4P9H7CwbA/mYRfQ
         wjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779802; x=1721384602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dezHJ0WyvcpI5gEfWfKVPR1yIz5w0V94MRv9cOZmsu4=;
        b=vddAPvkTVE9wneZ6K//vZbTRGmLLr9s54VhQaH8/4RJyOGXeaoEfmRzti828mbmLzj
         ancut341vLZ+kCUUv6fUeu4Yyp1T1Jen7aMPxe+sOMq+g3YGe5DqlPodxJqW6aWKWOML
         vUtY06f1guRZHxh6DONUYofc7y7ohRzEAdg+x/S9/xnsYkJ7fipKRcRC4j9KaB/P0BY4
         Nz5EBIlz9+SMd2KHXunRVU2TarpEUzJw09dNlfhSSYGtruQxxn14Hb+qEgJFWrSibyWx
         i1yWWQp0ZM56nXCL4y/X8RsOG6ylLVBJ2K1h2n+FtXnN1xg05HRL8AsHVMxzBMdCuayN
         EwBw==
X-Forwarded-Encrypted: i=1; AJvYcCVaFSoluEkHavzwbDm7jNZh+8YvOd63Q/oR5sNpwfhdjtInP3A363yxlWm5XTSYUUUp+tsckLyk0/m/1J4wGb6v5IKXAOyyaxj3p/+6FGWpmg==
X-Gm-Message-State: AOJu0YyEwTKti4Et3EgM6kgVG3SYptw6B04rjqFCj5HHinzDlvhn/ffW
	oN6/PLIh+loVwK53j86qXzkcllUjcfOSZnaPs/o3/gG24KLrLCmOWZnaJjAYcL8=
X-Google-Smtp-Source: AGHT+IGlRPt4kaRHHz1KeIRpOIRcE7r5fU2p5KJTQlXxdqmYLyhNVtJcwd5simlmXBca/JPpgrLRFw==
X-Received: by 2002:adf:fe4f:0:b0:367:8e59:4220 with SMTP id ffacd0b85a97d-367cea73793mr6313926f8f.24.1720779802607;
        Fri, 12 Jul 2024 03:23:22 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:23:22 -0700 (PDT)
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
Subject: [PATCH v5 16/17] coresight: Emit sink ID in the HW_ID packets
Date: Fri, 12 Jul 2024 11:20:25 +0100
Message-Id: <20240712102029.3697965-17-james.clark@linaro.org>
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

For Perf to be able to decode when per-sink trace IDs are used, emit the
sink that's being written to for each ETM.

Perf currently errors out if it sees a newer packet version so instead
of bumping it, add a new minor version field. This can be used to
signify new versions that have backwards compatible fields. Considering
this change is only for high core count machines, it doesn't make sense
to make a breaking change for everyone.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c  | 26 ++++++++++---------
 .../hwtracing/coresight/coresight-etm-perf.c  | 16 ++++++++----
 drivers/hwtracing/coresight/coresight-priv.h  |  1 +
 include/linux/coresight-pmu.h                 | 17 +++++++++---
 4 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index faf560ba8d64..c427e9344a84 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -487,23 +487,25 @@ struct coresight_device *coresight_get_sink(struct list_head *path)
 	return csdev;
 }
 
+u32 coresight_get_sink_id(struct coresight_device *csdev)
+{
+	if (!csdev->ea)
+		return 0;
+
+	/*
+	 * See function etm_perf_add_symlink_sink() to know where
+	 * this comes from.
+	 */
+	return (u32) (unsigned long) csdev->ea->var;
+}
+
 static int coresight_sink_by_id(struct device *dev, const void *data)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
-	unsigned long hash;
 
 	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
-	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
-
-		if (!csdev->ea)
-			return 0;
-		/*
-		 * See function etm_perf_add_symlink_sink() to know where
-		 * this comes from.
-		 */
-		hash = (unsigned long)csdev->ea->var;
-
-		if ((u32)hash == *(u32 *)data)
+	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+		if (coresight_get_sink_id(csdev) == *(u32 *)data)
 			return 1;
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 70c99f0409b2..ad6a8f4b70b6 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -460,6 +460,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
 	struct list_head *path;
 	u64 hw_id;
+	u8 trace_id;
 
 	if (!csdev)
 		goto fail;
@@ -512,11 +513,16 @@ static void etm_event_start(struct perf_event *event, int flags)
 	 */
 	if (!cpumask_test_cpu(cpu, &event_data->aux_hwid_done)) {
 		cpumask_set_cpu(cpu, &event_data->aux_hwid_done);
-		hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK,
-				   CS_AUX_HW_ID_CURR_VERSION);
-		hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK,
-				    coresight_trace_id_read_cpu_id_map(cpu,
-								       &sink->perf_sink_id_map));
+
+		trace_id = coresight_trace_id_read_cpu_id_map(cpu, &sink->perf_sink_id_map);
+
+		hw_id = FIELD_PREP(CS_AUX_HW_ID_MAJOR_VERSION_MASK,
+				CS_AUX_HW_ID_MAJOR_VERSION);
+		hw_id |= FIELD_PREP(CS_AUX_HW_ID_MINOR_VERSION_MASK,
+				CS_AUX_HW_ID_MINOR_VERSION);
+		hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, trace_id);
+		hw_id |= FIELD_PREP(CS_AUX_HW_ID_SINK_ID_MASK, coresight_get_sink_id(sink));
+
 		perf_report_aux_output_id(event, hw_id);
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 61a46d3bdcc8..05f891ca6b5c 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -148,6 +148,7 @@ int coresight_make_links(struct coresight_device *orig,
 			 struct coresight_device *target);
 void coresight_remove_links(struct coresight_device *orig,
 			    struct coresight_connection *conn);
+u32 coresight_get_sink_id(struct coresight_device *csdev);
 
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
 extern int etm_readl_cp14(u32 off, unsigned int *val);
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 51ac441a37c3..89b0ac0014b0 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -49,12 +49,21 @@
  * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
  * Used to associate a CPU with the CoreSight Trace ID.
  * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
- * [59:08] - Unused (SBZ)
- * [63:60] - Version
+ * [39:08] - Sink ID - as reported in /sys/bus/event_source/devices/cs_etm/sinks/
+ *	      Added in minor version 1.
+ * [55:40] - Unused (SBZ)
+ * [59:56] - Minor Version - previously existing fields are compatible with
+ *	      all minor versions.
+ * [63:60] - Major Version - previously existing fields mean different things
+ *	      in new major versions.
  */
 #define CS_AUX_HW_ID_TRACE_ID_MASK	GENMASK_ULL(7, 0)
-#define CS_AUX_HW_ID_VERSION_MASK	GENMASK_ULL(63, 60)
+#define CS_AUX_HW_ID_SINK_ID_MASK	GENMASK_ULL(39, 8)
 
-#define CS_AUX_HW_ID_CURR_VERSION 0
+#define CS_AUX_HW_ID_MINOR_VERSION_MASK	GENMASK_ULL(59, 56)
+#define CS_AUX_HW_ID_MAJOR_VERSION_MASK	GENMASK_ULL(63, 60)
+
+#define CS_AUX_HW_ID_MAJOR_VERSION 0
+#define CS_AUX_HW_ID_MINOR_VERSION 1
 
 #endif
-- 
2.34.1

