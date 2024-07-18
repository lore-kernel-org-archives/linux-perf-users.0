Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91C29422
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264453; cv=none; b=TJuqjTlNoghtTqCaf1JjOneUpZ0Q61RdoPRItUBtrvrjfRMdR4lawQLWlFpZuY6WNPizqUDFCesNryrzGr7HQyeMe1EupWG5riqFCCX6K0IE75pFcOsEn31d+uENHFrwwTykcBp48UOirM4FXEL/SkO07lR4jFvK57DGLgyTGAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264453; c=relaxed/simple;
	bh=adFJ4x5J0O4JSdSaPCPDVp0aeGz0NJC8hGerl3ETtpo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k4t0ITeyf/CeH4kT4RGFq7jl91Axub+FmcnzJXU8rGcDgEsJNqtZCfT46siY6mzy3Ucl3jQ72P5m+PWtbynDCkNjfEtXqX2HYNeMj9JG6rxcpq6yzq7t3BNU9Z1g9KFwlocblAoLyc29jP+7xMjC7YdXZgpRdtgalmll2Bc9aKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EaZ8l/nd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EaZ8l/nd"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-665a6dd38c8so6537997b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264450; x=1721869250; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0AwPG4o0G47V27ShPbkOoNNhsGypnaaBt/qve64P2w=;
        b=EaZ8l/ndFhzdgfK+/dm+kH2/5UAmvE5LS6yAoreAj84MdwqcGihbARKB7NKAAefEhU
         Q688Lrh0PZ0V9mU3a6kNU/E6NOsUNkDIfdKS4KfZ2kpmpa/0vpIvsh2OMeYfpXz/Domf
         MXjWdQw4u/3gqR4p1I+F+gMHy7uT9IE03qQ/bgRB2tU9bO/7JAvWhdASnuTIqXVAAd64
         yeIwl5nrlKbSjoy/0gQT+Vj3zXM+DnugzwiERno7e2m3PxAURQrUkwLdBCYJRoMKmIre
         jTyokLUN4ffBfRnnFixxHmbPkzhmDZlkHsgZ1cp9XDGKZ+2Ml73nryY4WGGh8RO0rIrt
         ydmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264450; x=1721869250;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0AwPG4o0G47V27ShPbkOoNNhsGypnaaBt/qve64P2w=;
        b=IQF6iQX4gLLTEwcBUYS7mlp4vk0NmQwIAOm8sToJzJ0LluQ7yGZnXaj2LGAfnjp0IA
         8bFkf4WYQ+P9m/Vhu1Et5xb+ClIzXTSNyRC46zoF0OfiiqzcwpzOgjvptZWy3UUBAtNz
         jojwVnTttm/L2Ks3dRs2kNUoMKOU5X8hul7w2bS9Z5Ah5Xrn0FizZSLf0j9aVlWv6UzB
         qEChB75/LRxCuFxtqWs2FOG/pHvwsk/ib+rtycoobSEz/UsW5b0d1gHc60me6as+V5Xt
         BvFrdeNokTEhAkIkRza9hNtP8RRNmW7e5AhPgGg/v4hSQT4+mBfr5NHqXYZIdml+NBRB
         azwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzfJUaAA7Alt8t6WdFoIRLe8sD2bVlRaqdsdLczaqvNH3sXjFHEuA4/vlmrKWvrDmw0AcfTZ4NUf5gmebKFgW6jYTriy2lhl6P0LehM2Maeg==
X-Gm-Message-State: AOJu0YwAIhqtdtlWg2u/U7AbRMQsH1kVxEVycnojvRYo39GkK9UC/Wx8
	4e62fKMN/b/1xFv7Y3GEEtJ0Q0o+crFSQfhloNPdF+Jj51vORY4bOrS1mEtnBsm1hn2N5FMbXer
	flC8YrA==
X-Google-Smtp-Source: AGHT+IF6Z+ddaWru78kkv+Rbe/2ixIoAa0Oh0Ttd6cumo1XTW3h3Qcnj/31TOiTWD2HXbFwryaFb3vcyoCHV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:ec8:b0:665:a4a4:57c1 with SMTP id
 00721157ae682-666015f3170mr275337b3.2.1721264450488; Wed, 17 Jul 2024
 18:00:50 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:02 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 06/27] perf kmem: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Reduce the scope of the tool from global/static to just that of the
cmd_kmem function where the session is scoped. Use the perf_tool__init
to initialize default values.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-kmem.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 859ff018eace..b3cbac40b8c7 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -986,15 +986,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	return err;
 }
 
-static struct perf_tool perf_kmem = {
-	.sample		 = process_sample_event,
-	.comm		 = perf_event__process_comm,
-	.mmap		 = perf_event__process_mmap,
-	.mmap2		 = perf_event__process_mmap2,
-	.namespaces	 = perf_event__process_namespaces,
-	.ordered_events	 = true,
-};
-
 static double fragmentation(unsigned long n_req, unsigned long n_alloc)
 {
 	if (n_alloc == 0)
@@ -1971,6 +1962,7 @@ int cmd_kmem(int argc, const char **argv)
 		NULL
 	};
 	struct perf_session *session;
+	struct perf_tool perf_kmem;
 	static const char errmsg[] = "No %s allocation events found.  Have you run 'perf kmem record --%s'?\n";
 	int ret = perf_config(kmem_config, NULL);
 
@@ -1998,6 +1990,13 @@ int cmd_kmem(int argc, const char **argv)
 
 	data.path = input_name;
 
+	perf_tool__init(&perf_kmem, /*ordered_events=*/true);
+	perf_kmem.sample	= process_sample_event;
+	perf_kmem.comm		= perf_event__process_comm;
+	perf_kmem.mmap		= perf_event__process_mmap;
+	perf_kmem.mmap2		= perf_event__process_mmap2;
+	perf_kmem.namespaces	= perf_event__process_namespaces;
+
 	kmem_session = session = perf_session__new(&data, &perf_kmem);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.1089.g2a221341d9-goog

