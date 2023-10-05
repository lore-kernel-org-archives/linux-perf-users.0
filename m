Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3850043A8A
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4iR0P4IS"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A8ED69
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 16:09:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b5a586da6so12807887b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Oct 2023 16:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547358; x=1697152158; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGGlE54ge9XxgsvPeqIZ7isbDlHsMUv/MJYLVA09opo=;
        b=4iR0P4ISPLOMMxrMSLXIeqoVzLlvLx47CT9TvLhsx6NwX3CyV8PYkzusmYED/x1CQr
         XIiT8F8Sh0OHiDk/OJuNuTTaCE4NWInqRbV8Y5WyzSLTm/Ye0/rPrCsBkxKU6+i7z/DA
         K6rwMg0yn6X8CXZlEQez7tK6veJvjS1NEBlfSXUdSLsqeaQ5IvzT/sNf+I/SLSu02X9t
         jyQfExUiXT7DB34xQa69AGs03Ac3dauAqMumBPJPzvZjGxm7rSLIsFC36gvGhG1pEOkV
         3JfvcMvlDhFywthUqQBMFIVnbeBl0FoK7MLHR/TcYt0lweXIRf51Xup96Yjz+669UHdJ
         4/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547358; x=1697152158;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGGlE54ge9XxgsvPeqIZ7isbDlHsMUv/MJYLVA09opo=;
        b=vgmh1q2HV9zS0761tpljAieZjIxQxhP4afyDOp2O81qsBWNSROFbAvhHMhtr6zL70/
         oNkLQ+IueuXB+daNAE8g8OKVuMgnIKCBTi8mkOthr8AYAyRlGpwG2/EKvP+7UTuBIgxu
         y6vosP8yZzo4eYTMck4HjlXjGO5g7H23wH6gto/kG2QP8AdcyGbsdkPzDxTm8gfz0nIe
         WWiwTe0qgoICLW+Lovnl3QxsfuCdiQlcN2+sl9mCcCKsymmB7Tp/ukOXtsVsuLci88yk
         B5O4w2VvO6G4l9EC1BIqgE6m3kX5SodlAaNsdZkWDz/qvl0piiX7kZbGurZ/3WX6YLfv
         pdfA==
X-Gm-Message-State: AOJu0Yxg16UkfaOv8wxJI5zPTbNapXnReDN/r7t1+9VTRhwe+kuBMLow
	b48lgf4vYomBig46uCodcMClYSagm6gA
X-Google-Smtp-Source: AGHT+IHZIti6IayoNIIvrlr9f3twKSIg0zCXbRbou+pCuTID4omq25jI81Q4BzjSR5/jxW+VxluvDukpej+F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a05:690c:c90:b0:59b:b0b1:d75a with SMTP id
 cm16-20020a05690c0c9000b0059bb0b1d75amr51537ywb.4.1696547358196; Thu, 05 Oct
 2023 16:09:18 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:42 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 09/18] perf mem-events: Avoid uninitialized read
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

pmu should be initialized to NULL before perf_pmus__scan loop. Fix and
shrink the scope of pmu at the same time. Issue detected by clang-tidy.

Fixes: 5752c20f3787 ("perf mem: Scan all PMUs instead of just core ones")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mem-events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 39ffe8ceb380..954b235e12e5 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -185,7 +185,6 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 {
 	int i = *argv_nr, k = 0;
 	struct perf_mem_event *e;
-	struct perf_pmu *pmu;
 
 	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		e = perf_mem_events__ptr(j);
@@ -202,6 +201,8 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 			rec_argv[i++] = "-e";
 			rec_argv[i++] = perf_mem_events__name(j, NULL);
 		} else {
+			struct perf_pmu *pmu = NULL;
+
 			if (!e->supported) {
 				perf_mem_events__print_unsupport_hybrid(e, j);
 				return -1;
-- 
2.42.0.609.gbb76f46606-goog

