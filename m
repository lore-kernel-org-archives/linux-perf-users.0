Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C137436B1
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2eUm25P2"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B836D5E
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 16:09:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d859ac9ea15so2098143276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Oct 2023 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547353; x=1697152153; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fapvG1sgoYBqHgoFOW9TcSIAiI5hx1hj0GAN7+v4jh4=;
        b=2eUm25P2a2eFfh56kz1uSlz9NaWL7J/iU17mHmso2A1+lo3PPSav85ngzAJo+E+Weo
         vrW/grBI1oJKqpACTbpHctclty+Yt4pXfeXX4zp3+TODPuLIfW2waNTf5z0Ey+LUCm5r
         9v2JeeiDyNer354S8plXgZL75bCuO6GU4CbxX2j4MhGU2OyZK1jrsAV5oUtek8y+qyut
         q4TKRPSZ+E1o1lmKNO39mbmi39d90sqNvtQgShhQQDa/hcti+cuseS4FSSkNPwiQI0MU
         WVIP/ruBpX+eblxV/SFy7WhQ4bBa29EIBN6/2ja1XHRDrkvhYZ0bF3KnbkticwIrduhD
         /VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547353; x=1697152153;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fapvG1sgoYBqHgoFOW9TcSIAiI5hx1hj0GAN7+v4jh4=;
        b=fMGFUhqfni3SbNj7w7IfMN1j7R97lHquuV9eDTL+ApHwk0faBoDTqPFYTClsJ6WJxz
         isqeC9uygw5XQFB8cx6J+3Qm9mF4KfuT9CbwGgpePMzTHniZ+xOIgfMmagFpImnnx/r7
         7WL5kFKSieQ7H7oej7Z2QEXBWIXSm+gcG09xl6dFvIO8FvlK72HpewIcYBZDzFksEeck
         L7mVlYOJbFpll996h22NM3dLY2bc+BYLE9XfeiXI9cFR99gS+VD8hfe1ji3gJyoEyNOo
         sDCza7xjmil7Vwzl5Nhc1NuwT+glxO8Viyr5cZJZ598WZVdHkiakYODs3PwQ7jF59XH3
         uqNw==
X-Gm-Message-State: AOJu0YwpWADhphGG+LPySP47RQqZTYz1LQ/4s7Yrn2fR90TEQo64InL9
	M/dhyV9Hqa/ETGLRuCaQKSKD3K+mfJEC
X-Google-Smtp-Source: AGHT+IFQvzaYKByRTXdCNgbgMtf6ZQo0ZLONfku1Pyu5zu4z+Lcclzm0e0v4jTWzT6RLDSWWI+/6U4DHYIBX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:770b:0:b0:d0e:d67d:6617 with SMTP id
 s11-20020a25770b000000b00d0ed67d6617mr113429ybc.4.1696547353259; Thu, 05 Oct
 2023 16:09:13 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:40 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 07/18] perf env: Remove unnecessary NULL tests
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

clang-tidy was warning:
```
util/env.c:334:23: warning: Access to field 'nr_pmu_mappings' results in a dereference of a null pointer (loaded from variable 'env') [clang-analyzer-core.NullDereference]
        env->nr_pmu_mappings = pmu_num;
```

As functions are called potentially when !env was true. This condition
could never be true as it would produce a segv, so remove the
unnecessary NULL tests and silence clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index a164164001fb..44140b7f596a 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -457,7 +457,7 @@ const char *perf_env__cpuid(struct perf_env *env)
 {
 	int status;
 
-	if (!env || !env->cpuid) { /* Assume local operation */
+	if (!env->cpuid) { /* Assume local operation */
 		status = perf_env__read_cpuid(env);
 		if (status)
 			return NULL;
@@ -470,7 +470,7 @@ int perf_env__nr_pmu_mappings(struct perf_env *env)
 {
 	int status;
 
-	if (!env || !env->nr_pmu_mappings) { /* Assume local operation */
+	if (!env->nr_pmu_mappings) { /* Assume local operation */
 		status = perf_env__read_pmu_mappings(env);
 		if (status)
 			return 0;
@@ -483,7 +483,7 @@ const char *perf_env__pmu_mappings(struct perf_env *env)
 {
 	int status;
 
-	if (!env || !env->pmu_mappings) { /* Assume local operation */
+	if (!env->pmu_mappings) { /* Assume local operation */
 		status = perf_env__read_pmu_mappings(env);
 		if (status)
 			return NULL;
-- 
2.42.0.609.gbb76f46606-goog

