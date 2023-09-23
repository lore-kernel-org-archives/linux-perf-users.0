Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD787F9
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Sep 2023 05:36:03 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4012E1B3
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Sep 2023 22:35:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f2c7a4f24so34826927b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Sep 2023 22:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447357; x=1696052157; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gGdTy/Hpx4ZQLMYPilsnkHUZ9OACUdEplw6hC2pVSI=;
        b=VECHTX8kH/m85pfQg57m3iGB7ST5r0q4pSlbk/RBPLUEh9xIOTdPwJzZtNhxzcXt1D
         +ahbfZbBP3JAFkixzvlI0ewFZW4GlcunjGpWryCSEeMK2+qhtVkuiiVYR5COoTycUKpw
         0uujQVhzYlIEO85f8NNW+5z0i7m+KPQQO2KVZHc0qTvzqZaLz1P3XPcN86MnWnjwlwxU
         +P7VSh9ggnno7K+uzXPag31BZKf4vHqJ2OikvhkPXwD9Qj6YZGcjd5XDCIfErmi4roys
         wX5KxzNtqcQPPlM/nG01lfZVdySQTQhJzYVjmcMgA/bMViIA3iRa0TQB5mxXlQQYL27t
         n33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447357; x=1696052157;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gGdTy/Hpx4ZQLMYPilsnkHUZ9OACUdEplw6hC2pVSI=;
        b=DVbaa7JSQniIEM7QL/AJl+0DR34s7uTcLD7++c7eg5gKuej6aa/vLR9NVoh2Lxvib4
         6bxHFxmDHp6RAiTOjK2Kq0vd3TpVmyc0sizYz4XpEz65yuWuoH9V1W5fHsk8a4SCZuUq
         OmiAS4eN0sK1KqPqeNKip/No0SxxbpyPwMgk+/kkq4ltdvk0wuhAEyLkfTbeq91XZaiC
         5HpTlgvwtW+syHhB34PH+su7B2fqTFr/Yoxzvu1piKGYt1DNaofBhcFpJaJLe9FdmEiI
         b9myFNzLcAgpB0aUr6WuuscPAVSpitYAMc/pSOYKCZW2yO1nBvxYXdGKFB9aBMZYe8uf
         A2ng==
X-Gm-Message-State: AOJu0YxwkpyuKg76KGU0feuIKEALuMLT9KDPv2F3qmSg28sgndiLj4DD
	pm2AFSKRVVuqqzdqpu9YGZPUzaaFXCUA
X-Google-Smtp-Source: AGHT+IHu3H0RgtYZ8l9qpPGoXpBjWqmDv48DSjpHsFtxnOifuDQfmXQ64ydXe7XcESUrtgiyDqPuQqKHNS6T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a0d:ec52:0:b0:58c:6ddd:d27c with SMTP id
 r18-20020a0dec52000000b0058c6dddd27cmr19945ywn.6.1695447356813; Fri, 22 Sep
 2023 22:35:56 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:06 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 09/18] perf mem-events: Avoid uninitialized read
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
	James Clark <james.clark@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
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
2.42.0.515.g380fc7ccd1-goog

