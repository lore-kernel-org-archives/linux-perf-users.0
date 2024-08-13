Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5F19B59C
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555535; cv=none; b=he2hGtHNtF5c4LQ3l2PIaghhSnSfrEejvL2pAJntsvAmuEGGt49x33X7EZD7v1NRtYvI7pBhG/4WJ7/zWNIDy0hRaSTva63nIAjHHwVYNlG21mDdPBzETRn26nnv/eVujju3k9JaYOpe84wGwj066BvIDhczvIS83dtys1AmOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555535; c=relaxed/simple;
	bh=u+E8ctwMhqOhWA0QdLQIlIzYAq6iAtE1bX/6M6IObcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=euxjO+v6ApdySW+OtMRjTD2RYM12kkhjmjHin/JdOID47XAyhiNbduLzXCYwf6rsuna6RvjuQbgImSW538BONrvA9hrIJLp4YRcBgs3w1IHc1eVwVJWbJ6iDV6dCWTUSfGWU3rl7BS8NzJbpLn3bphfOpCzGyL9OhZot/ExV2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mmIPvP0U; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmIPvP0U"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42816ca797fso40548895e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 06:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723555529; x=1724160329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJPiTzck/wj4Bl8bp1dFvT+bnyHvEgyjm9lLc0sAxDQ=;
        b=mmIPvP0UvIzGTe+PIB4y0UDelO8Vri1mEBGtWSORkOybGD3rzX/JBjAX207/xTs2Y2
         8jCQsrSlJn0svUFAaRQNrU3TwSm+2ZckbK4bgLJDOIBW5TM12whPBUrtsy7xzdH7rXRb
         Iu8bf6JNTL6QHS6qJGdYbjdpooucdExD9+luuGl6+/ap4m5WzFmLwue8CLT5TsdRaxjP
         PeuDpy7PXMFcqyzL9vX8vMvQGDFaphoYg3lhg5vIBaMQFMTCkLV0S0eOCzJQOmMt9eDl
         GH8AHBMtIYS3UbdNbGtQvq7sMQJi26Bm8QWAImO7Gz6l/jm9dB4xC8ys94bMqsv7Aqgy
         /qSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555529; x=1724160329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJPiTzck/wj4Bl8bp1dFvT+bnyHvEgyjm9lLc0sAxDQ=;
        b=CZFYT5yRaSmyU3bRbNfTSSnnk0FVq/v2RsHIVruXrFSMnyOBa0d/6X87jdHWN4ZnJm
         aeB7M/ZhCLUuDx5nnsddnLICtP46wg3MEx7BJj9/46Ytj6Du+Yyiqtt6idtkxY4zOq8R
         1H5YzGZk+wUEWIBenA5ODm2HQySwZTT11ONdU4bQLZ+At1yAFZ5XJcg3wPrcBytjtKmp
         Wius1tEpsB1V3y1UobCL3P5JSfwQT89yz+3uHLi49Mc3D+WwVwUV3upSUSKDLH02lCE4
         rpbgsX+tDkH05Y0m1Xda3pLTaw/s6j9DqKBg/N+CFDkSXwNyn4O4efnoGvyY+nyujR+Y
         gRzg==
X-Forwarded-Encrypted: i=1; AJvYcCXyykijFIMYMjqPEoQBSMQmvdrKUFz22XdR7MdcrhULQWeGXbSxmI5gr+tWge0j/maxT8o+LbzTbUrgAQvBJBAclmbcHMhnfd1QgOIzHkL6Lg==
X-Gm-Message-State: AOJu0YyQdkxIQS+Bc4KoZZJnvLzBDIymP2ynm4IrZGhRwOPN1OH3mi6N
	io5MGgtYbSEQ6SA5YKQLfQfeM8FoEZCqoCkJ8ExGM6ddByO52AMIG4yRX0Tn/Cs=
X-Google-Smtp-Source: AGHT+IGpUiL8HI1I4dgUEXAngk1hqDYSTUpCg0rDVeIRHKgEB9vHTQ+oOqXVgzYYIWv7xtQbj8/VkA==
X-Received: by 2002:a05:600c:358c:b0:428:ea8e:b48a with SMTP id 5b1f17b1804b1-429d47f49fbmr28609085e9.8.1723555528866;
        Tue, 13 Aug 2024 06:25:28 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738d21sm223186625e9.12.2024.08.13.06.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:25:28 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ze Gao <zegao2021@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/7] perf evlist: Use hybrid default attrs whenever extended type is supported
Date: Tue, 13 Aug 2024 14:23:13 +0100
Message-Id: <20240813132323.98728-6-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813132323.98728-1-james.clark@linaro.org>
References: <20240813132323.98728-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For x86, a hybrid version of ___evlist__add_default_attrs() was added to
support default perf stat events. This can actually be used whenever
perf_pmus__supports_extended_type() is true, which now makes default
perf stat arguments work properly on Arm big.LITTLE:

  $ perf stat
  ...
        3347093940    armv8_cortex_a53/cycles/    #  0.563 GHz  (98.99%)
        3295523067    armv8_cortex_a57/cycles/    #  0.554 GHz  (67.07%)
  ...

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/x86/util/evlist.c | 65 -------------------------------
 tools/perf/util/evlist.c          | 65 +++++++++++++++++++++++++++----
 tools/perf/util/evlist.h          |  6 +--
 3 files changed, 59 insertions(+), 77 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index b1ce0c52d88d..bbe6240c7f71 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -8,71 +8,6 @@
 #include "topdown.h"
 #include "evsel.h"
 
-static int ___evlist__add_default_attrs(struct evlist *evlist,
-					struct perf_event_attr *attrs,
-					size_t nr_attrs)
-{
-	LIST_HEAD(head);
-	size_t i = 0;
-
-	for (i = 0; i < nr_attrs; i++)
-		event_attr_init(attrs + i);
-
-	if (perf_pmus__num_core_pmus() == 1)
-		return evlist__add_attrs(evlist, attrs, nr_attrs);
-
-	for (i = 0; i < nr_attrs; i++) {
-		struct perf_pmu *pmu = NULL;
-
-		if (attrs[i].type == PERF_TYPE_SOFTWARE) {
-			struct evsel *evsel = evsel__new(attrs + i);
-
-			if (evsel == NULL)
-				goto out_delete_partial_list;
-			list_add_tail(&evsel->core.node, &head);
-			continue;
-		}
-
-		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
-			struct perf_cpu_map *cpus;
-			struct evsel *evsel;
-
-			evsel = evsel__new(attrs + i);
-			if (evsel == NULL)
-				goto out_delete_partial_list;
-			evsel->core.attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
-			cpus = perf_cpu_map__get(pmu->cpus);
-			evsel->core.cpus = cpus;
-			evsel->core.own_cpus = perf_cpu_map__get(cpus);
-			evsel->pmu_name = strdup(pmu->name);
-			list_add_tail(&evsel->core.node, &head);
-		}
-	}
-
-	evlist__splice_list_tail(evlist, &head);
-
-	return 0;
-
-out_delete_partial_list:
-	{
-		struct evsel *evsel, *n;
-
-		__evlist__for_each_entry_safe(&head, n, evsel)
-			evsel__delete(evsel);
-	}
-	return -1;
-}
-
-int arch_evlist__add_default_attrs(struct evlist *evlist,
-				   struct perf_event_attr *attrs,
-				   size_t nr_attrs)
-{
-	if (!nr_attrs)
-		return 0;
-
-	return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
-}
-
 int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 {
 	if (topdown_sys_has_perf_metrics() &&
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1417f9a23083..e0c31399beb6 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -5,6 +5,7 @@
  * Parts came from builtin-{top,stat,record}.c, see those files for further
  * copyright notes.
  */
+#include "pmus.h"
 #include <api/fs/fs.h>
 #include <errno.h>
 #include <inttypes.h>
@@ -338,24 +339,74 @@ int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size
 	return -1;
 }
 
-int __evlist__add_default_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
+
+static int __evlist__add_default_attrs_ext_type(struct evlist *evlist,
+						struct perf_event_attr *attrs,
+						size_t nr_attrs)
 {
-	size_t i;
+	LIST_HEAD(head);
+	size_t i = 0;
 
 	for (i = 0; i < nr_attrs; i++)
 		event_attr_init(attrs + i);
 
-	return evlist__add_attrs(evlist, attrs, nr_attrs);
+	for (i = 0; i < nr_attrs; i++) {
+		struct perf_pmu *pmu = NULL;
+
+		if (attrs[i].type == PERF_TYPE_SOFTWARE) {
+			struct evsel *evsel = evsel__new(attrs + i);
+
+			if (evsel == NULL)
+				goto out_delete_partial_list;
+			list_add_tail(&evsel->core.node, &head);
+			continue;
+		}
+
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			struct perf_cpu_map *cpus;
+			struct evsel *evsel;
+
+			evsel = evsel__new(attrs + i);
+			if (evsel == NULL)
+				goto out_delete_partial_list;
+			evsel->core.attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+			cpus = perf_cpu_map__get(pmu->cpus);
+			evsel->core.cpus = cpus;
+			evsel->core.own_cpus = perf_cpu_map__get(cpus);
+			evsel->pmu_name = strdup(pmu->name);
+			list_add_tail(&evsel->core.node, &head);
+		}
+	}
+
+	evlist__splice_list_tail(evlist, &head);
+
+	return 0;
+
+out_delete_partial_list:
+	{
+		struct evsel *evsel, *n;
+
+		__evlist__for_each_entry_safe(&head, n, evsel)
+			evsel__delete(evsel);
+	}
+	return -1;
 }
 
-__weak int arch_evlist__add_default_attrs(struct evlist *evlist,
-					  struct perf_event_attr *attrs,
-					  size_t nr_attrs)
+int __evlist__add_default_attrs(struct evlist *evlist, struct perf_event_attr *attrs,
+				size_t nr_attrs)
 {
+	size_t i;
+
 	if (!nr_attrs)
 		return 0;
 
-	return __evlist__add_default_attrs(evlist, attrs, nr_attrs);
+	if (perf_pmus__supports_extended_type())
+		return __evlist__add_default_attrs_ext_type(evlist, attrs, nr_attrs);
+
+	for (i = 0; i < nr_attrs; i++)
+		event_attr_init(attrs + i);
+
+	return evlist__add_attrs(evlist, attrs, nr_attrs);
 }
 
 struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int id)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index cccc34da5a02..06d1eeacc0d1 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -106,12 +106,8 @@ int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size
 int __evlist__add_default_attrs(struct evlist *evlist,
 				     struct perf_event_attr *attrs, size_t nr_attrs);
 
-int arch_evlist__add_default_attrs(struct evlist *evlist,
-				   struct perf_event_attr *attrs,
-				   size_t nr_attrs);
-
 #define evlist__add_default_attrs(evlist, array) \
-	arch_evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
+	__evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
 
 int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs);
 
-- 
2.34.1

