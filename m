Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B27916F286
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779784; cv=none; b=AHn1vpXRqXGjzI1cLdtWgUpEqpbQqsD1BPm6H3FeD3IgwWQu16K+eRQj9QYkQ09QUM/5iPcYrz/MzwiRTFImuWILibrvqF4cNrfF1iQm1EenJXHooqHB+8WRX+zYvaP/w6LWKwheuE8pl9i8KJrp6/CDBXJJrfQiZS3rxlzwkAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779784; c=relaxed/simple;
	bh=kf/iN8iv/dVqkp8MS4TRsYjs+Fhf43Q57krZ4fElRuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZDtuC5PzP8UINK5Cz87nKlWbzT3R2G7xn2SQmFZPlPFaviuGz98iI1SftJwDaguOsVSgw0MG4YVszOJkWPehbBU1DwJuZs72XcdhtnKlzLiLRNIgzJe5wcT02JULVaY82g7cea7EPhzN8QGZlJW8Yq9I2b7aKfTtafI/oVg+x5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YW89xNwC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YW89xNwC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-427a0efdb9bso2318905e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779779; x=1721384579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exGpI/q1ubHfcT+dWNjwEciQxWd5C9veIqWOilMjY6Y=;
        b=YW89xNwCWX28VKAyLNmw6+nZXnQxj/vWNq7fPECkPYR4VqowzMJbGxcnMtDsyecHeM
         JOk25o73/ePok0cySya+h7jJB6b+BN4Jo/j0q5n2BIf3acHqK5OGgG8lxIdhCOOyLkIJ
         TKOoogFccMkGZIkSLjU/TIWky5hSkIZ76S4kKvz4firuyyxQr/1UzgoFsdzyZJf2m1+G
         2DTDFQweFyVl/KOfUfPUQKE1Ksv5sqTNCgpnAuOp8pndA7VsuoWpJlvlFB533yZaBcKx
         nYpEpkcnRpntTNffX6GXl81+8YKCIbSgNc7M7HeN7u4i8QgocJjcywpIRA0OcWVUFywZ
         SBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779779; x=1721384579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exGpI/q1ubHfcT+dWNjwEciQxWd5C9veIqWOilMjY6Y=;
        b=pfyr/aIHaRoNNxbjuRyyUfa7vtF+KFXUKThwbAY+il75rX/nUPPFx3m47WIWnhGl0c
         0ZtRXPtvK98abzxc/ZXZYzqMBJ5/L/T1ImiJPwOzU9Xpa24v5X8KRXJyD7uddS/gAqDI
         cOV3vsLqHx9df9IEm+d8AV94TGS4YmWZpISErwDNLEXR2xt8VlcuJ8H1tdApwvpfmgFR
         N/nYnDMUWUhUVuXFT7ZHCSqYtNgPOn+CDEXo3kel+IgeFIO92f8axzhvVBkK6mTFs5V8
         aYamKThcGin8n11tc5lKVNJzj3yRA+hC7v0nLhVCTuJJpJGe5rVshUY9oc2jjuIqjUxT
         JDxA==
X-Forwarded-Encrypted: i=1; AJvYcCVFDF6b+JwRHISLoFIHIGgBEv95//NTwSBByxpvhQmfUbQxdyQAlKPr75URJ77s4B6g4Vr4UH+Sd2mimq6qKjaiuMkdqD0PqTsQbz8x5iJoHQ==
X-Gm-Message-State: AOJu0Yxy1sfa1Lo3968kki+kim3zmY19moMaSv2zOnw9are1Z+MkNY2I
	/mWWeHbc38o7vCfiKmdQhbH1bygv+m1Dj3VzaRQJZbjOSkS2fiKt5lKMTs9iUro=
X-Google-Smtp-Source: AGHT+IGgUYd4gRyLTEW8Swsk7DoK36qF/yql0OQUFfYb+pVDpipH090ZkEOjNQT+aIPUK7J5yQHwzw==
X-Received: by 2002:a05:600c:30d3:b0:426:66fe:8051 with SMTP id 5b1f17b1804b1-426707e677dmr81812355e9.24.1720779779542;
        Fri, 12 Jul 2024 03:22:59 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:22:59 -0700 (PDT)
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
Subject: [PATCH v5 11/17] coresight: Move struct coresight_trace_id_map to common header
Date: Fri, 12 Jul 2024 11:20:20 +0100
Message-Id: <20240712102029.3697965-12-james.clark@linaro.org>
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

The trace ID maps will need to be created and stored by the core and
Perf code so move the definition up to the common header.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
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

