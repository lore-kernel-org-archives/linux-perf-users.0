Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DF112D77D
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Feb 2024 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917276; cv=none; b=gSp82zI18WgEhBJdfsUNxR/qb+nWN7KTAX3w+hwthoWB+RHpghD4a++OISr8bMlVGKyqL3w1L9tQAaNc7l0/+OPX1wYyL7g/L2IyRbxpULG/12Wihe5FpBab3mVyViCrm6PKHAPeH0oD5N5ujqmJOnm/h4fI4nwMjVXeOoqVA8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917276; c=relaxed/simple;
	bh=R7HDLt+WXCKcw0UAraBcZnWD54QthkXyaQu13uOf35M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XKpmu8y8+udJTpwzDBGaVjNKVjon810ETvYveNdP+/AnoOJk2a3mIxJnJzBDWDqK8v4maTvtRkRh8h02fy7R/asCXEGuYtKTosbtF3pz+GDzdujeDAFwK4re7uxs+lhUTAL+C5jvMmxY0AifESMkpuy4pU5yx07MKZ4IqgMA5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AyrvHKJj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AyrvHKJj"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60436130450so9478357b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Feb 2024 15:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706917274; x=1707522074; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wOc7/ot5clrlqkd/XVVApb41eylij+dgoGLfSlWPOp0=;
        b=AyrvHKJjjXcpTnTw4Q1Oh72rOi5vJrbZ3NSKSgFRcmHrdQ9urAxqzaDeeAWfqmw1CL
         V2OIprdiY9MJ0htwTWHjbjukLdw7GmjOkyqarwZWfqn2/8Nov6Ocp/QbJOAyaHPZqEhv
         hziwunHjYpud1MfPnxCijqL4At/8TCLcXP3ITG/sHjJf5dLMZBDCWVnSsVuJpt8WizXl
         wZDeqrqXusMSV10naS2Ovb/WYhlAqQRr2Xtbkc0txIShOu29QlZQm42MK7Ezu4CBW1H2
         OxpzDQzCpQwQLEealrpbXlNFI9Pleu4GOdpHUI3AnJSzmnPwCCL/ker674WkFBkQGxwz
         OW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917274; x=1707522074;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOc7/ot5clrlqkd/XVVApb41eylij+dgoGLfSlWPOp0=;
        b=OLb5Fbo1j0ui4PIr4K5S0SiKklr0l4NvqpRWphk8XRPNZR8nRODoASziifOBwCbvpj
         nRSkTPp/Wcy1r3TF1SwtDQ6QcwhgBBt9hU0YqsT/aWZNPOJX4K3xba6bQsbP6xDZ43LV
         VTh/IuqtwWhi791tXNTvui2qaQVJlWrlaLO6rYaPTVTIiXt5TfHF2TR9O9sUdY3/pGxJ
         WAp95M5UWswpACuT+90sEEGqvHYkOiAGR/G2BKXn/K5Hv8b8Z9k0aSIxzDFcGUjAb+FC
         nLTH00hngP+S3E1IBnCUHnJDmLj8lMT2qxj6EadoDAnPO1NK2PRVu8bXNtGpSQKz7wvs
         GiKw==
X-Gm-Message-State: AOJu0Yw2e9SnJeI9BHu0kdmNmoG00Y/cJc9jZoFD0lL3wIo+Mk0uYmHY
	May1kjmyQ6tEFnHZUI9RFTATpvz7vf4D7tZtDECKdqBJ9BOSXmQ8+PZpTKUv+maqcy2yj/Vm9P3
	2JWo51Q==
X-Google-Smtp-Source: AGHT+IHFL6+6WJT+TDjsN0v4AycgXqtEdFuE4PFoyenBnNnNjcCA2pFf3NUeukXxzibAja4cMAtIanSVNF3E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7732:d863:503:f53d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1b08:b0:dc2:398d:a671 with SMTP
 id eh8-20020a0569021b0800b00dc2398da671mr1024554ybb.10.1706917274174; Fri, 02
 Feb 2024 15:41:14 -0800 (PST)
Date: Fri,  2 Feb 2024 15:40:51 -0800
In-Reply-To: <20240202234057.2085863-1-irogers@google.com>
Message-Id: <20240202234057.2085863-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v3 2/8] libperf cpumap: Ensure empty cpumap is NULL from alloc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Potential corner cases could cause a cpumap to be allocated with size
0, but an empty cpumap should be represented as NULL. Add a path in
perf_cpu_map__alloc to ensure this.

Suggested-by: James Clark <james.clark@arm.com>
Closes: https://lore.kernel.org/lkml/2cd09e7c-eb88-6726-6169-647dcd0a8101@arm.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index ba49552952c5..cae799ad44e1 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -18,9 +18,13 @@ void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
 
 struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
 {
-	RC_STRUCT(perf_cpu_map) *cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
+	RC_STRUCT(perf_cpu_map) *cpus;
 	struct perf_cpu_map *result;
 
+	if (nr_cpus == 0)
+		return NULL;
+
+	cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
 	if (ADD_RC_CHK(result, cpus)) {
 		cpus->nr = nr_cpus;
 		refcount_set(&cpus->refcnt, 1);
-- 
2.43.0.594.gd9cf4e227d-goog

