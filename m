Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B017EA
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Oct 2023 02:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zJgDK0rZ"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F5BBE
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Oct 2023 19:13:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d865a8a7819so3831879276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Oct 2023 19:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696644831; x=1697249631; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fc7EI+IqMoK5GVnqlsLaiP62BnjpCmFT/Si/B7nJZs=;
        b=zJgDK0rZ1nQdVyYd+zr+B9/D9pYts8s5cn8NxT4eo6cErsMSnxIZSgwdaWfnfFDJF9
         qAajyn8qFg6g2Bbq5qRlhKoj0BIUQm1JqwNMeraEjjZW5ks0dYNyU2JJkv2LTyS2Y30Q
         Sq/LNG2/3+e7E8P6NqDp0zH7tEkoPOmTAFhvXj4GLz5YLWsyCsYG2S8CHmbOjtpz1Pyu
         Hn/vRMWAlfnFJK7tqgu02dDExQV0fWZ/Flv6lH+byB7BG8ADP+aVFgcfYyHwWAZ0PVqh
         PpFSTVE2CL3CB/tZSVNoTFZctRrDajpMUOSaGoO/5vszaIIpskzWjLXCDrFdR6uQdKrl
         F2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696644831; x=1697249631;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fc7EI+IqMoK5GVnqlsLaiP62BnjpCmFT/Si/B7nJZs=;
        b=Lw8gd+yi/grz6+uAGeguNgkmxFEHrxa2aCYt9oZlCltvRAyckWAgust6E/5Lu5fGy0
         Vg7cioZl9GFITy/QTS8gt3ccU2jZt+cDNyvNAdGVtyfoHOjXS5OUqoaYCLmH8B5bmJBV
         yrhGrEdWq/p/0V8wggumhJ1SSwmiaIzzOEgN+VsuNsQyz7KWOsX6QU0+oApwplGUNfrb
         4DmsFjjSSFOCPhxowszFcpXEcoBsTWpKD9hhKiKj/Tpll7TfQwZ//OxplyWfImA5qChA
         1m5JXfubknHZSrSNKbmjPY7pLzkZDRKnepG4x09K5HHyasNajtGPVZU1PooIdil8UX23
         yasg==
X-Gm-Message-State: AOJu0Ywc0b2Iw8LiJN5aQAbb5WnYnMfx0SgC6RFHY+3ZnKvgKTy8Ww65
	97ZQ76G3yYv/JTnNol4r7iySjoJdpsOW
X-Google-Smtp-Source: AGHT+IHrCzJat+rz/BJ6g8m43IhpNWgcQXVdsawjas52P79D5OWVnwHwRJxeKmFFr5isb0ADzqHoPQ82uORz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7031:b36b:6c77:bfd0])
 (user=irogers job=sendgmr) by 2002:a25:e20b:0:b0:d81:817c:582 with SMTP id
 h11-20020a25e20b000000b00d81817c0582mr155263ybe.7.1696644831137; Fri, 06 Oct
 2023 19:13:51 -0700 (PDT)
Date: Fri,  6 Oct 2023 19:13:21 -0700
In-Reply-To: <20231007021326.4156714-1-irogers@google.com>
Message-Id: <20231007021326.4156714-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231007021326.4156714-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v1 2/7] perf intel-pt: Move PMU initialization from default
 config code
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Avoid setting PMU values in intel_pt_pmu_default_config, move to
perf_pmu__arch_init.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 2 --
 tools/perf/arch/x86/util/pmu.c      | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index b923bca939d9..6d6cd8f9133c 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -267,8 +267,6 @@ intel_pt_pmu_default_config(struct perf_pmu *intel_pt_pmu)
 
 	attr->config = intel_pt_default_config(intel_pt_pmu);
 
-	intel_pt_pmu->selectable = true;
-
 	return attr;
 }
 
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 811e2377d2d5..949b3e2c67bd 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -22,6 +22,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 #ifdef HAVE_AUXTRACE_SUPPORT
 	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
 		pmu->auxtrace = true;
+		pmu->selectable = true;
 		pmu->default_config = intel_pt_pmu_default_config(pmu);
 	}
 	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {
-- 
2.42.0.609.gbb76f46606-goog

