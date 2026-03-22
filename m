Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB217BCA
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Mar 2026 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774193548; cv=none; b=Y2iwhJ51rSg4aDbg8ju1yaGzqziySkss0GHgTFidjfwPBMfivhxwKHtMokImh8AJ7MvWuTh9XJs3dDHgx+/thx6gqz4DWWvP5/cmk87aZvfTH8Yx3EEJlJrIELiPR6HkslHm1oElHS9zxIzbLYkajEicM8lC6fXkhNEeUKqfc6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774193548; c=relaxed/simple;
	bh=Pwu0VGWG22PdYkbb4Tne96/HQMronRD+xT3klYekB4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NlIeFuEpA5s4R8KdASlat8/RFs0MLq4i+64uIp+1h7QU6uzTZOVk1oJwz+ltJu0pRSyv49gm3FO1v9tEWDVHWe0ZMDcuQZkhOTVLUQPd3wPiWzf/rTN6hJ/8hiJJEai96rLigd4setLhVVooOtfM1exCyR4+g8syNG9Mr/XkwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKWmPQlZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKWmPQlZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so20844875e9.3
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Mar 2026 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774193545; x=1774798345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0B389yJ4oAxFHhKLMGmcSreI7Cul7epl7fjuLNZz78=;
        b=QKWmPQlZ4xebGNDisgsEmFVZpI3gHsBj+RgwuBHlYZBbJcx5dAj/sDQzzi2DKfPu8l
         ZgpnvcHgKDh8UI+c0GuDihGI8ufnjbt3be9BngbcSJ1DNbEz92joOeJLFtF75WDWnMys
         CGE+cazTOPtPfYq4ngr6R7UrJ6mfKwHh8C3TmNb30bkGbC8c+Bxpfp7nx4F/nSUn2BKA
         9z4xB0sCilyJ6JHwcSruyYgHXaxdkehfVBHGckBLW5CA8fiBqKLAnxXxfsZBy/vHY5C6
         OBTL+JHbyHvUb77hT1BIuKEBW2oUfl2jXpqj1QQh0mDGvhr3uBae7bvjRbL0LUknE/Fr
         fKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774193545; x=1774798345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0B389yJ4oAxFHhKLMGmcSreI7Cul7epl7fjuLNZz78=;
        b=kRpIPGvQMywjR3ixUcZJZOo0Nk1pCCk4FElYuJY/X1d96NBs9zLeTmvzghzidtCfhG
         go+KHsvyOaWUUvXAt4LZMZprlurTIRsCkNbTtrXVi63F14t2C5bOBa8lXESJz5klm4yA
         cPQqW9V204bn7sPDIgrpCQA45BMMtQUa34XO162zijOUTiu/UshHU/lrjiNAcmLaEVUS
         ZpOMA+Ph6tzlw5tfvQE4J9TM7yuuTi2/WoQ8ayTcKuN2L0TdLQRJAXCqFb8SeXN38XdC
         zUvON4VpZb7fhGiwOgvAAYXG4o6yCMrNyja9ggH8Z5N2zk3qtalEUaVebqP4v37K/nON
         mguA==
X-Gm-Message-State: AOJu0YywGlrHs5twe2RzIRLNmnfoqM3dLtB2hKd6Daz+g1S3f+D670lC
	C7Dh4NqascvRoNRWlFay2sdD2br4QlkooHXMpynMbdibBM+2I4wFn6zh08P1tZsZHXg=
X-Gm-Gg: ATEYQzxLtlxGak5RAAgvyVAOv++TSop62k0VcC3Uuilux5ssWlDTnbGkOsVb80BAAGl
	ewNb2FbAOmr6imZrGphmsACBTzOtSv+1v5lPEY2bzSq4g9PAt7moLHcA5dAnObZCs/nefc4UEMR
	lV6JmgJL2yAUkAAiJ6hq7QbkIgkaSFnIyR6zxSYMFECu/JbR40dvubLCZPggGEHVfYgFXvNBFSR
	gePkGiOD+lU7IEKS1pp0mp6qw41yfIeYbmVu82FNTsvU99GIJAnuOTKFnS+Z1oxsL5wNC2Pl4IS
	/nK6nPLrzFLbfdZqnSeE7dPGbn9FxNIDF4imPXuHtl4sYHwBf9Thu09QloNjo7QtMp3aPkXpCUF
	rLlgrheC2tqUs+NOqtmfzOo/Z6I7hB6MYmuivUbmvq1zPVBCWBmt47/iPBhFTpGy55OUA8gxM1j
	MnEhVPdyOA38hcMV2ePWG+3vjMPG2JJNHy5nKfzmHYA9d9JQrXdmz12//71gOXxPXFHzU=
X-Received: by 2002:a05:600c:6308:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-486fee0d9bcmr133144075e9.15.1774193545164;
        Sun, 22 Mar 2026 08:32:25 -0700 (PDT)
Received: from fedora (net-37-119-209-55.cust.vodafonedsl.it. [37.119.209.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703343sm22061059f8f.19.2026.03.22.08.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 08:32:24 -0700 (PDT)
From: Francesco Nigro <nigro.fra@gmail.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	acme@kernel.org,
	irogers@google.com,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	jolsa@kernel.org,
	Francesco Nigro <nigro.fra@gmail.com>
Subject: [PATCH] perf metricgroup: Fix Default metric group lookup for non-Intel CPUs
Date: Sun, 22 Mar 2026 16:31:55 +0100
Message-ID: <20260322153155.205405-1-nigro.fra@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

metricgroup__has_metric_or_groups() only searches the CPU-specific
metrics table returned by pmu_metrics_table__find(). The "Default"
metric group (used by 'perf stat' when no events are specified) is
defined in the common/arch-independent metrics table, not in
CPU-specific tables.

For AMD CPUs (e.g. Zen4), the CPU-specific metrics table contains
metrics for groups like PipelineL1, l2_cache, etc., but not "Default".
This causes bare 'perf stat <command>' to fail with "No supported
events found" because add_default_events() never adds any events.

Other code paths like metricgroup__for_each_metric() (used by
'perf list' and 'perf stat -M Default') correctly search both the
CPU-specific table and the common/default table via
pmu_metrics_table__default(), which is why 'perf stat -M Default'
works while bare 'perf stat' does not.

Fix metricgroup__has_metric_or_groups() to also search the default
metrics table as a fallback, consistent with
metricgroup__for_each_metric().

Tested on AMD Ryzen 9 7950X (Zen4, family 25h) with kernel 6.18.13
and perf built from 6.19.8 source.

Before the fix:
  $ perf stat true
  Error: No supported events found.

After the fix:
  $ perf stat true
  Performance counter stats for 'true':
    0      context-switches        #  0.0 cs/sec
   55      page-faults             #  ...
    0.22 msec task-clock           #  0.0 CPUs utilized

Fixes: b0a9e8f81fc4 ("perf stat,jevents: Introduce Default tags for the default mode")
Signed-off-by: Francesco Nigro <nigro.fra@gmail.com>
---
 tools/perf/util/metricgroup.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a21f2d4969c5..670b650f86fe 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1606,9 +1606,15 @@ bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_gr
 		.metric_or_groups = metric_or_groups,
 	};
 
-	return pmu_metrics_table__for_each_metric(table,
-						  metricgroup__has_metric_or_groups_callback,
-						  &data)
+	if (pmu_metrics_table__for_each_metric(table,
+					       metricgroup__has_metric_or_groups_callback,
+					       &data))
+		return true;
+
+	table = pmu_metrics_table__default();
+	return table && pmu_metrics_table__for_each_metric(table,
+							   metricgroup__has_metric_or_groups_callback,
+							   &data)
 		? true : false;
 }
 
-- 
2.53.0

