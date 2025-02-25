Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF019DF66
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502035; cv=none; b=etDkbM9yUr9h2uUNpzkGZwVsLz/t5Nz/K7h681IDopRUoYd4hnIS8rNubfMZMlrKRFuPaQ5DNjBBLCpjz2cWgg8Do6DWdQVgbBuuj5BQ99B8ZNGLZqDkgvvH4RssDsK2cxLWuOBBiF1Nf+0Ysz7Gp68oYeveAfA451lA+BVlnro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502035; c=relaxed/simple;
	bh=fJcj3avQNuqrPvfGogvQDFTwhN88MwqiTHVq32AqoM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6CUF9T2LhOtX5KhvJsIvMX3YVuRZw43MmjE8amvkPMI12z6JYsq2yMi7d1nzgSVCkxLcxdgIPO4VnjVojzzPbCeJhDWOQQtA3gnDdZXMscS1jOcNKPosQXInnawP0SE4MoMauDWkEaNSjKRR/CVExjsptacM/VF/B+IacIgeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U0gyxRI7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0gyxRI7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4399d14334aso51341275e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 08:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740502031; x=1741106831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6zYunsslfLFaIghaKuBbDgwSTYPPEUyCdstyv8nGIk=;
        b=U0gyxRI7RGugzyu1uBefwjMdLMrNAns2UpJb5zn7i3gZcnHlBGr7f4u0XkooxVOU1H
         kk3YfTEGemNZ+P7oDio9F4Wm6h59z2UoAi//rPbw+Y8cEwkWSyWEiJ6Awg4DggRgPrel
         lKh2xOkS2u0ynlTE3vzCevhXuHjyEn6BHKnoUrASJG8Xm8lOsKNT1PPdYkmwH+ii6v8q
         NArWo+2Dwz6KRNUoD0jeJYk18PoFqsTF0Wetg6bBAJGpU1Rnr2nBQUO1CE2Kuq97Kyxx
         xIphUR2aNrsArg2RNxlS5a4lYEIxMIxkJ6p66LJsXL76pxnTpBVFhqNvAeRQCUDcSwb5
         VJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502031; x=1741106831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6zYunsslfLFaIghaKuBbDgwSTYPPEUyCdstyv8nGIk=;
        b=t/b0ix1xIKKh+drhLv3e5dFMk91ttIbVWSCaXsE1Nyk7zxnnWyFWRn/DWGbPMfmO61
         CNgFD863TfJYP9aNdtrFvbIxYUio3b7V15p7Vi67jkC5ccNx51M9dtrpISFQUtqOrwSl
         JdLUqMrIoA7vZ+Zr7P7ntNbcK4D0qaimZJ0nnGYkChkdbyE0EdWs3A/J/UUjLFraSpJB
         DMRIN64MU34HJzi25OHXQgHYbxcXHXaCBGp7zqHsbOo1zNMPkUtc4VgtG/BK0eZFvETJ
         TgAiziwdWYtewXcPQxfltI94hv5E5mmxO8C+gHy8Kt358WTqxLfD0UthFCrby2hKB1b3
         0PFg==
X-Gm-Message-State: AOJu0Yy26zEvQJO6QFeaqzmlqudsZoM2LuodVLJ4B/Wq97oThgD69r9g
	oyUQ1g2g5/AaNV1Qdgcp++QyKyrJ+W4EMKUrAKNsQ8Iu+Yj5B5qH2xLe3/e4mXfu+4Cw8Kn0XAI
	SUJE=
X-Gm-Gg: ASbGncuFMGQKrxmYiTyNvSK93uwWepdUo7mx2gH9GuFQJFOYNtl/JJCaMn/h2nNwgzb
	L7MdlJZ5gOlIM8iZg9zlfB8xBGDp0hoj5IDr6lRGCe5SjzwBRojf2q21La7xWexzEJ+dguos2ih
	Rddgyb7Lkl5jHtJpyz38oNvuvcNYn0CGaYIboFczNCUPbE6eZ464YMdOKzLkgs94M0Heixi5AOB
	x+LAGVd1xyOXxIge9ER4k0JvTIe/vDH9n8TDVe6aqM5hla4aT9r7I+al2W81YblufpZeErAJ+GX
	tyrIi/bZ1LLtZMNrXis4LW4W9A==
X-Google-Smtp-Source: AGHT+IHxcabNYd68N3fAYJwzKJtxAGyEN4XVr5OMEsGkvW8AeGZ4ctNdJiH2U7/OsTMvRHxz0sqrjw==
X-Received: by 2002:a05:600c:3507:b0:439:9225:2f76 with SMTP id 5b1f17b1804b1-43ab8fe97d8mr2239285e9.18.1740502031441;
        Tue, 25 Feb 2025 08:47:11 -0800 (PST)
Received: from pop-os.lan ([145.224.90.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab154754esm32072415e9.21.2025.02.25.08.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:47:11 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	cyy@cyyself.name
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Junhao He <hejunhao3@huawei.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf pmu: Dynamically allocate tool PMU
Date: Tue, 25 Feb 2025 16:46:28 +0000
Message-Id: <20250225164639.522741-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225164639.522741-1-james.clark@linaro.org>
References: <20250225164639.522741-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_pmus__destroy() treats all PMUs as allocated and free's them so we
can't have any static PMUs that are added to the PMU lists. Fix it by
allocating the tool PMU in the same way as the others. Current users of
the tool PMU already use find_pmu() and not perf_pmus__tool_pmu(), so
rename the function to add 'new' to avoid it being misused in the
future.

perf_pmus__fake_pmu() can remain as static as it's not added to the
PMU lists.

Fixes the following error:

  $ perf bench internals pmu-scan

  # Running 'internals/pmu-scan' benchmark:
  Computing performance of sysfs PMU event scan for 100 times
  munmap_chunk(): invalid pointer
  Aborted (core dumped)

Fixes: 240505b2d0ad ("perf tool_pmu: Factor tool events into their own PMU")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/pmus.c     |  2 +-
 tools/perf/util/tool_pmu.c | 23 +++++++++++------------
 tools/perf/util/tool_pmu.h |  2 +-
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 8a0a919415d4..c1815edaca37 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -268,7 +268,7 @@ static void pmu_read_sysfs(unsigned int to_read_types)
 
 	if ((to_read_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) != 0 &&
 	    (read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) == 0) {
-		tool_pmu = perf_pmus__tool_pmu();
+		tool_pmu = perf_pmus__new_tool_pmu();
 		list_add_tail(&tool_pmu->list, &other_pmus);
 	}
 	if ((to_read_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) != 0 &&
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 3a68debe7143..45eae810b205 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -490,17 +490,16 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	return 0;
 }
 
-struct perf_pmu *perf_pmus__tool_pmu(void)
+struct perf_pmu *perf_pmus__new_tool_pmu(void)
 {
-	static struct perf_pmu tool = {
-		.name = "tool",
-		.type = PERF_PMU_TYPE_TOOL,
-		.aliases = LIST_HEAD_INIT(tool.aliases),
-		.caps = LIST_HEAD_INIT(tool.caps),
-		.format = LIST_HEAD_INIT(tool.format),
-	};
-	if (!tool.events_table)
-		tool.events_table = find_core_events_table("common", "common");
-
-	return &tool;
+	struct perf_pmu *tool = zalloc(sizeof(struct perf_pmu));
+
+	tool->name = strdup("tool");
+	tool->type = PERF_PMU_TYPE_TOOL;
+	INIT_LIST_HEAD(&tool->aliases);
+	INIT_LIST_HEAD(&tool->caps);
+	INIT_LIST_HEAD(&tool->format);
+	tool->events_table = find_core_events_table("common", "common");
+
+	return tool;
 }
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index a60184859080..268f05064d03 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -51,6 +51,6 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 			 int start_cpu_map_idx, int end_cpu_map_idx);
 int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread);
 
-struct perf_pmu *perf_pmus__tool_pmu(void);
+struct perf_pmu *perf_pmus__new_tool_pmu(void);
 
 #endif /* __TOOL_PMU_H */
-- 
2.34.1

