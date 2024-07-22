Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1569B16DC00
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643205; cv=none; b=C1I6o5gTPb8wb6r6E2eiERJdjpmT1tBvcDx+RJPMXH7ihWH8tJeDpscyKzFosnynhe7Ql/BI5ZKAJnWm4zdBZ/SPm+znpuZSgl6emOsyktX0dAUF8LxTgYveriHotxLW0oLdoEJN2YEo2GtEoVFI5nfoWSi2MiFghqaNbVTO+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643205; c=relaxed/simple;
	bh=pfTg193U03VQHBc5Y92Ek7wGOxzx6knrjLyWX8sWCXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQo5x6sa80dRz8/fsxAs8Ha3drfCh5k19QBxKr7qYQjOe0KKIA6Wi3ksjpGzOY9uuUtTWOr9bTQeZs7VYAoSOEE3LChiDlopD54vIULVGCvHe0LoOXJJnunfSB4haYGWJqMpb8J7dooQF7hraqq/8UY+oBUWopHQHCXad/vHxnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UltkTRvY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UltkTRvY"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4266182a9d7so27219505e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 03:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643202; x=1722248002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ob3o88R/yxUBwonSp9vzDZCeFMZAfTzy7u2JCgClFSk=;
        b=UltkTRvYoPweB+lBm1Nc6gJvL9IwFYxxQSEQ2ihtZlq5wCvIDokdk/a9nMVW1H2pdW
         xHD2vmHt4Hn5EICc5S04x7nBrax2Uv8Fmgn6v1tAvtnV2LtrksbxtCYLTUyiYSslst5C
         X0tfk1v19ufyGILO6pmqi2k2FVqgCntRjnWuZTdSXDNaeGrjA/kTNYDo8l9zNhHGFlaX
         dSQrp/YcgKTjpIh5eh5qL0QPLMKvmB4KG3QkHcCT14IY1HVpuoqtGY61kKuNE7go9Qx5
         b4xrDto743DFthLWHiqk2cJa8jBwykioB2SnMdonK7ZwwMbrRVZQC6tZ9giQQZHJR/L0
         37LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643202; x=1722248002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ob3o88R/yxUBwonSp9vzDZCeFMZAfTzy7u2JCgClFSk=;
        b=COENOcHTtH2l6Dr1yzb7ahSE8iPDHv/gb4hxXAbzbZODtLYFip4lqK8NhOPJ9KqmgG
         JImtIrsVS5/D6RWU6dtQ0eTSrhR82BsO15qdHAn0XzqJYhOpL5COfr7uwlC9HNbFt53Z
         j4Nj3Qlc7pqE5uB77vgZxK1vIQk/K+bAxON91h/dJxh4s3xZKtDkVy4N7EZn8cDmI5V1
         ej/hhV4l0PLaFHYlvEX3AWEy/JDJJ4UUwgA0cgaVxth3yRzR0s+lFj0VpTR8vPYQ934U
         wP1AbmxWH1xfoMi4cijnvOHFb6Bl7RzIFHyOM6Hy2ewFgMSxD5GDcsVWjRK9e/l1Ue2d
         h9oA==
X-Forwarded-Encrypted: i=1; AJvYcCWOeKzK3onXy1afkSvNMZlW6OwvFAtvX2n5qth80PlPZCzyJL5rciFkJ75Gyg5KrYc2ODGy7EMAxjFFQG1muz39cqv/fJfctLUc4+auAgxSVQ==
X-Gm-Message-State: AOJu0YzSsbjE+V+bd6uyTuMyOohb73XhcjWhDyl+4d42DI8n+u+aIYtL
	cRtQo2JjX+3bSJVkvZKzP6td1XkUx/f6lTpfrpETNBf2vK6iG8uEIMjejXQ0u2A=
X-Google-Smtp-Source: AGHT+IFnRlQjxIzplZP9hmspE1klaaY7FAnTuoO73aRSdCaRY/lNjrX74jyuwVgqrmifZPXhzx+e5A==
X-Received: by 2002:a05:600c:4f4e:b0:427:b995:5bd0 with SMTP id 5b1f17b1804b1-427daa61cbfmr47929775e9.23.1721643202485;
        Mon, 22 Jul 2024 03:13:22 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:13:22 -0700 (PDT)
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
Subject: [PATCH v6 11/17] coresight: Move struct coresight_trace_id_map to common header
Date: Mon, 22 Jul 2024 11:11:53 +0100
Message-Id: <20240722101202.26915-12-james.clark@linaro.org>
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

The trace ID maps will need to be created and stored by the core and
Perf code so move the definition up to the common header.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../hwtracing/coresight/coresight-trace-id.c  |  1 +
 .../hwtracing/coresight/coresight-trace-id.h  | 19 -------------------
 include/linux/coresight.h                     | 18 ++++++++++++++++++
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index af5b4ef59cea..19005b5b4dc4 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2022, Linaro Limited, All rights reserved.
  * Author: Mike Leach <mike.leach@linaro.org>
  */
+#include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
 #include <linux/cpumask.h>
 #include <linux/kernel.h>
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
index 3797777d367e..49438a96fcc6 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.h
+++ b/drivers/hwtracing/coresight/coresight-trace-id.h
@@ -32,10 +32,6 @@
 #include <linux/bitops.h>
 #include <linux/types.h>
 
-
-/* architecturally we have 128 IDs some of which are reserved */
-#define CORESIGHT_TRACE_IDS_MAX 128
-
 /* ID 0 is reserved */
 #define CORESIGHT_TRACE_ID_RES_0 0
 
@@ -46,21 +42,6 @@
 #define IS_VALID_CS_TRACE_ID(id)	\
 	((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))
 
-/**
- * Trace ID map.
- *
- * @used_ids:	Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
- *		Initialised so that the reserved IDs are permanently marked as
- *		in use.
- * @pend_rel_ids: CPU IDs that have been released by the trace source but not
- *		  yet marked as available, to allow re-allocation to the same
- *		  CPU during a perf session.
- */
-struct coresight_trace_id_map {
-	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
-	DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
-};
-
 /* Allocate and release IDs for a single default trace ID map */
 
 /**
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index f09ace92176e..c16c61a8411d 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -218,6 +218,24 @@ struct coresight_sysfs_link {
 	const char *target_name;
 };
 
+/* architecturally we have 128 IDs some of which are reserved */
+#define CORESIGHT_TRACE_IDS_MAX 128
+
+/**
+ * Trace ID map.
+ *
+ * @used_ids:	Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
+ *		Initialised so that the reserved IDs are permanently marked as
+ *		in use.
+ * @pend_rel_ids: CPU IDs that have been released by the trace source but not
+ *		  yet marked as available, to allow re-allocation to the same
+ *		  CPU during a perf session.
+ */
+struct coresight_trace_id_map {
+	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
+	DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
+};
+
 /**
  * struct coresight_device - representation of a device as used by the framework
  * @pdata:	Platform data with device connections associated to this device.
-- 
2.34.1

