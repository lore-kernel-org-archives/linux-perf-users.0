Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A821A239B
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 05:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736314488; cv=none; b=g1bUzV6E5FygesZ6T6GixDgLLZWO+gWpHQxACzW7aPvcyXuuydaTUL0eFx2qX4Kf1O9oSnGm3NSmuh97CXSBqa6ik2Uumz40R2nAHtlyaSzh2ndWRTi+spxKj/0EA5H0FFhZSp29NiHkvfAheZEKRXHTnLIVoQPp7DBV2hOSVMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736314488; c=relaxed/simple;
	bh=62bBMWr5E1/GDqwNs41D1h//alB35yPbnHV0Oe7uaNE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=je6tTBY3YcTDapROgm41VZOf7k5O3ZNzaCWNvzxMMamkBUovZ5BobSoYeS3d0uYfp6U757sx6kDgs0UqwitIg57Z0ZzFhcxlkEhubmHKiXja7CIvxI7VCOpWVULM4ONTlSGmOrrNtZ4IxWooUBLaa2Nc9wd+RXZZmvAMnVdMoS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lOzQ/1KH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lOzQ/1KH"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e549b6c54a0so12165462276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 21:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736314486; x=1736919286; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5e2WjueStXy5Vxgh10KeE4aI11iOULRJOsRrypPKwec=;
        b=lOzQ/1KHpQIZEVHM84LBFuvuFyNb0/+96kQv9urnjIlb3DvESX5hRu96z48JRIWgBj
         tC37Dz1RgE+N5R10dv5In2GL3tlljq8jn80qK7EAsItyqQiU8cxAI1BCeqbOb5u7Gv1Z
         9C18YUkWoVTygVUMrh1JG6HTgzCM6uYVTc1EodrRGDXhZegjTdYNNlxJ6Hjloxp0G4oq
         STe5iWOHWnBgRs5S+kRKHBdNLeVvRwAL9F5zq8XlqkyERN4XObRRGFlXEjJlTuL3JGi7
         N2VeTkPxSI0UtI4NcRyyWfesTcO8fbyvX0Mp7YZbcTA078iOlQHxbabYHx3RXNxDGLVg
         k/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736314486; x=1736919286;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5e2WjueStXy5Vxgh10KeE4aI11iOULRJOsRrypPKwec=;
        b=fb8Cc+u01t2FYhxRqjyfddmz2OBolfqbCOlSnsF78flARVrl5deKt9Nh6OUIwed4vK
         p2AX0/Nyyko6sSrwXhYah3sQePnaYBHI8bLVNjYr+k1ahQnkqxAHHEDLBNWwd9QfzSNC
         qxSm2gY8yNGJ+fIKA/tRelmGBcXANJOnUxSzL3T16gwKd7XziY1yA+q9GN2k7RRr8FSd
         38YN9o509hcfclje2+5qKdm088n+5QKfJYneJtkJEkIsVc8AVFLmpHjsPuDBBldzILYA
         W99CqicdYtQzSZc+MBX+fkJt5/hMoi9o4LHZioSBVLVIBDWxYxdljqO58IRI/bXPuXmh
         waxg==
X-Forwarded-Encrypted: i=1; AJvYcCUeLLgIbzwTax8hatfdeZjOz9FZyPBA9QdiYHmPMdgFEM73J6KHB6y1Kxcp6B3CUIMntwXhTTFRH0y9bbTlU54c@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zVJP15pPxZRIHAIRdslDCG72joCsDIHBF7geOPtjRE6my42N
	Fox7OtaZjNR2vj3mrJXluX/c3Hd1WrHVXEHo23+wGzcCn/1rfvPtEVxwzyCSOiL7XbbX8dtFNA1
	h0ZuCPQ==
X-Google-Smtp-Source: AGHT+IHm+uUJ/9xKXPDUqe/nY0Pj280rMgkTdS/UL8bb0e8i5dlC6a+cOylCUFPSLeP19en84v4o8la9XeIL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ae:a887:5504:e3ca])
 (user=irogers job=sendgmr) by 2002:a81:a982:0:b0:6ef:7d06:1eb7 with SMTP id
 00721157ae682-6f5311e4c09mr44177b3.2.1736314485929; Tue, 07 Jan 2025 21:34:45
 -0800 (PST)
Date: Tue,  7 Jan 2025 21:34:25 -0800
In-Reply-To: <20250108053428.1724490-1-irogers@google.com>
Message-Id: <20250108053428.1724490-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108053428.1724490-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 1/4] libperf cpumap: Add ability to create CPU from a
 single CPU number
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add perf_cpu_map__new_int so that a CPU map can be created from a
single integer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c              | 10 ++++++++++
 tools/lib/perf/include/perf/cpumap.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index fcc47214062a..f3054894ff0c 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -242,6 +242,16 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 	return cpus;
 }
 
+struct perf_cpu_map *perf_cpu_map__new_int(int cpu)
+{
+	struct perf_cpu_map *cpus = perf_cpu_map__alloc(1);
+
+	if (cpus)
+		RC_CHK_ACCESS(cpus)->map[0].cpu = cpu;
+
+	return cpus;
+}
+
 static int __perf_cpu_map__nr(const struct perf_cpu_map *cpus)
 {
 	return RC_CHK_ACCESS(cpus)->nr;
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 188a667babc6..077133935bf4 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -36,6 +36,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_online_cpus(void);
  *                     perf_cpu_map__new_online_cpus is returned.
  */
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
+/** perf_cpu_map__new_int - create a map with the one given cpu. */
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_int(int cpu);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
 LIBPERF_API int perf_cpu_map__merge(struct perf_cpu_map **orig,
 				    struct perf_cpu_map *other);
-- 
2.47.1.613.gc27f4b7a9f-goog

