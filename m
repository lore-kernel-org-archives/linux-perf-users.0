Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6519D068
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555516; cv=none; b=dqYTEZ9+W/ZYKYyHKLiHV8+tvYDqikK6A4LbsC2MNaVvGo3RwWCso1/ACzIbwhkQnb6BYbWe2G+1YJnlo6HKPak72HD27rqDx9CMUdYUKdlvXGAthBMDkE3WyBkog8vUCOM2yvF6eLBTpK57fsPxb8rSlNYNhbHU7ck20BM+QNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555516; c=relaxed/simple;
	bh=nF1MOSoYSRJ7oZ2R65moIw4vTEWLXTn8O58Nzhs5eN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjLhcfLeMeA5GeKmbdAnbyfqrYdy48gJbaMdma5ckOtPVMbLikwLArvSq8LAuMneUn7ghE+4Z0hhTc7xTQubpAro66+MZG9NZ/dtKGESRvZ8EwWfWW9XPRUeruJlK5oFCdPcqcUe9jve++48sA+pmeu7vtRS2DB8JZdzmHeks80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pjJZbwKM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pjJZbwKM"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36bb2047bf4so3603615f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723555512; x=1724160312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+kJ+/NC06vZ9X8R6p8mtg0vV2q4/5EH3hEIt7Tb/aw=;
        b=pjJZbwKMNoDyTP4+7gtiY7N0bDdw3xIZR2RN5ZrMpSZYLLfwAjHZV4vT365WElK0kr
         ATV0qaErd2XLjyj68Zr9SAft4NLVBZA5ik8A5AgZL8rfcLlaVUPjMcoCekCBm2H6PhGP
         PsP14qGc+Qd4EC3WBLDW+wS2AjSvJtknPdTKp7lUz1IuH5Q38MVD5xzxg1ruBdeTr5BD
         LljbFEdHb+NKHG+T9Mf0XabRi+rAb7Y1EQ/ZbmxDSLgZUCZM3D4BNnH9uLoAfIvS+e8Z
         O91V22N17/2jnUsx28uNuvbqalcNbrTQ4GuD/nqxV55gCaD3cb5Y/vH7DDyw/+ka0v2p
         4y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555512; x=1724160312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+kJ+/NC06vZ9X8R6p8mtg0vV2q4/5EH3hEIt7Tb/aw=;
        b=NxSamw+NjqlFZJYh0Re/HdsBsq6ZuMJICxAPx6ithhu42RyS7v0YK0eTc3JHayspLy
         t98fc4+gwZX8PQrPKrbVZIXeu7sbExuA9n9AMWfjGvhyeX/GqN11fdxfVSdwUUrmhaEJ
         NgDpUCW+26TuGVCbKEngdlLpXRlyr86S2axjfqTeMSxxivibZrZ+Lv6xSuX9KuxBxDmE
         yxEd0v5YOEG8P+jMFwHcobacR8ORrtlwPFSVQqu6joflQbi+779Gb2SgkOMAsQ4ykgtg
         25GsxSrZq/WA+/YZbkN2vTlKcNwiyy6BqQMKFdFLzXOLZckRNtdFKgvvmqKDqu1VHClJ
         //Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWj/vGi+f8897chcx1jx00u01sVburMOp4sLXK+8eRniZw79kCCARNxokWlmy44zKncEt7l9JiNuzPLJ6+XOqurBD+tThPHsxgtZ7nDMIQ2Eg==
X-Gm-Message-State: AOJu0YwvfycI8Q//5OfQa49GVfNj2ehY5gUxAL2XTIsZNQFYSYMH2cNQ
	hgim6u3O3XHZ9jzYFYnW5FdjLNbpadPsHMNzHwxuajKkRlewLHmt8wnZ1eogPCE=
X-Google-Smtp-Source: AGHT+IGjXdWWrJsG8ue7FAAFzotqCer/0Jr9WoBguXbU5v52cPPA7AkQerMal8MjToQlhspx2O6d6Q==
X-Received: by 2002:adf:8b1e:0:b0:367:992f:4ac4 with SMTP id ffacd0b85a97d-3716cc542a0mr2499815f8f.0.1723555511781;
        Tue, 13 Aug 2024 06:25:11 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738d21sm223186625e9.12.2024.08.13.06.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:25:11 -0700 (PDT)
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
Subject: [PATCH 3/7] perf evsel: Use the same arch_evsel__hw_name() on arm64 as x86
Date: Tue, 13 Aug 2024 14:23:11 +0100
Message-Id: <20240813132323.98728-4-james.clark@linaro.org>
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

Both of these platforms share the same extended type ID mechanism, so
share the implementation of the evsel name lookup.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/Build   |  1 +
 tools/perf/arch/arm64/util/evsel.c |  7 +++++++
 tools/perf/arch/x86/util/evsel.c   | 17 +----------------
 tools/perf/util/evsel.c            | 24 ++++++++++++++++++++++++
 tools/perf/util/evsel.h            |  2 +-
 5 files changed, 34 insertions(+), 17 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/evsel.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 343ef7589a77..45c77f747d54 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,3 +1,4 @@
+perf-util-y += evsel.o
 perf-util-y += header.o
 perf-util-y += machine.o
 perf-util-y += perf_regs.o
diff --git a/tools/perf/arch/arm64/util/evsel.c b/tools/perf/arch/arm64/util/evsel.c
new file mode 100644
index 000000000000..6974f72ee37f
--- /dev/null
+++ b/tools/perf/arch/arm64/util/evsel.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "util/evsel.h"
+
+int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
+{
+	return evsel__hw_name_ext_type_id(evsel, bf, size);
+}
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 090d0f371891..771b35fef61a 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -49,22 +49,7 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
 
 int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
 {
-	u64 event = evsel->core.attr.config & PERF_HW_EVENT_MASK;
-	u64 pmu = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
-	const char *event_name;
-
-	if (event < PERF_COUNT_HW_MAX && evsel__hw_names[event])
-		event_name = evsel__hw_names[event];
-	else
-		event_name = "unknown-hardware";
-
-	/* The PMU type is not required for the non-hybrid platform. */
-	if (!pmu)
-		return  scnprintf(bf, size, "%s", event_name);
-
-	return scnprintf(bf, size, "%s/%s/",
-			 evsel->pmu_name ? evsel->pmu_name : "cpu",
-			 event_name);
+	return evsel__hw_name_ext_type_id(evsel, bf, size);
 }
 
 static void ibs_l3miss_warn(void)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bc603193c477..19f4d0e71733 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -584,6 +584,30 @@ int __weak arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
 	return scnprintf(bf, size, "%s", __evsel__hw_name(evsel->core.attr.config));
 }
 
+/*
+ * Version of evsel__hw_name() used on platforms where perf_pmus__supports_extended_type()
+ * may be true and the type needs to be extracted and masked.
+ */
+int evsel__hw_name_ext_type_id(struct evsel *evsel, char *bf, size_t size)
+{
+	u64 event = evsel->core.attr.config & PERF_HW_EVENT_MASK;
+	u64 pmu = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+	const char *event_name;
+
+	if (event < PERF_COUNT_HW_MAX && evsel__hw_names[event])
+		event_name = evsel__hw_names[event];
+	else
+		event_name = "unknown-hardware";
+
+	/* The PMU type is not required for the non-hybrid platform. */
+	if (!pmu)
+		return  scnprintf(bf, size, "%s", event_name);
+
+	return scnprintf(bf, size, "%s/%s/",
+			 evsel->pmu_name ? evsel->pmu_name : "cpu",
+			 event_name);
+}
+
 static int evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
 {
 	int r = arch_evsel__hw_name(evsel, bf, size);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 80b5f6dd868e..f95fc2919462 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -299,7 +299,7 @@ extern const char *const evsel__sw_names[PERF_COUNT_SW_MAX];
 extern char *evsel__bpf_counter_events;
 bool evsel__match_bpf_counter_events(const char *name);
 int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size);
-
+int evsel__hw_name_ext_type_id(struct evsel *evsel, char *bf, size_t size);
 int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
 const char *evsel__name(struct evsel *evsel);
 bool evsel__name_is(struct evsel *evsel, const char *name);
-- 
2.34.1

