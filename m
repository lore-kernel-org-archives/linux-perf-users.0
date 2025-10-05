Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D01DB95E
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688681; cv=none; b=TgHYk8MxYunaMJYfPEZZ/35D18s3WJ8w35yrEFMoaJ9Idx1QWBErTmPQ7XZmzUNj5igGHcpcWZeO0KDTPa572DpaI94fPfNaHHOk9CnZU/SMQocvvjVNOyxcngujFj56pwCgWNsoZgYQzTYAWUbP8WdP8T5B7Cmu1mqWDKc50pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688681; c=relaxed/simple;
	bh=8p/urS87Auj0Qc/hLjlTgfByL6vRZArwY5TP2UtPovE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mFi4mUxVTuYvIVEayS0sjCiSq5rMDPRZQtx37hHj44uloSsjzGo0sj+TAfQcDkfAnbRdUCCz7V5bRVChwfN9tKVNFhC4cN8ffTzsWwFxZuS9KTrtXgvXYZtcZwiG6e5lAjJ1sWN+B5ndXpktS1DmHKbuS49MxiYosyc//4ePUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4rxhZe0J; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4rxhZe0J"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27eca7298d9so80518235ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688679; x=1760293479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk7xh7SZJJ3XEbkvNLhoR3syBhj+u9bQNDkycPU9Lww=;
        b=4rxhZe0Jxehxdt5+zUKeJck0vKbXT3v3teIqGBuuiAnh5QbvROxilrpVEpXudiPghx
         8PArqztpGCCyCG987l2Cs/mkme+Zv5eZUDaMsqt9R75uAYguFXpqNdA6xG0E6o5VJBQo
         PNhOLptVGA9xZX/W6BVblO0DPFrMoitFQLbinwmzJwweuo53ffWBmk0LvK9tjZ9xDbrh
         E7F8ABKXS7IuIRIWLLq3z3bTUDr2HHq5JjfeD82ufdVnKKFxqMkgCbl+btuP+EtdMP6z
         7HGxQI2A4LbWSx5aiN552E5j0hsjABAkZeMw4ZozcxOs8EnpXnjri2GLiDz2k/Hux6VD
         AfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688679; x=1760293479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk7xh7SZJJ3XEbkvNLhoR3syBhj+u9bQNDkycPU9Lww=;
        b=u5/c7FkVCp7Trq/6SVqkPOvDKdoCEpHCG3QD5qXoIJhXf2g+uo7z6vEfrYHwPvmceM
         4Z5tXoFflbGBORr6CNCkEUWjjju0//y6rvFaTotk/oFIRn0cSxY9YOHm4jtFnLeuPKWr
         LIpONxziuI/9NMOTT1oWF6QFxftstDlybICSHVt6xOpWIU36LY4hZn+yF57zsJLZTFEt
         LS+2tnsDLzbI2w0iaGq+Gu0eyQ2wD9uIEas5AEut/nc99L5llZ7r24kgvwabHkoA3T9G
         jt+mTKPJiveenPGn9P4RdWjsL2Z/mdHBGZe26p9nVsOm6ZVQWkoJjsjPvIwktGEXUsc/
         qq4A==
X-Forwarded-Encrypted: i=1; AJvYcCXGO/3/GdadqhefL4AQLKCMN3CopnW27iytwZ9xVyG4hgpKNUiTB53wFO5/nqaCA6c5DSLa71z5PLOXlMyykhBh@vger.kernel.org
X-Gm-Message-State: AOJu0YwobMMasWnP9KoVCO8XEaFFq+YST+qRTX7hHiUUG/r2WyHCkq1k
	gsFOkZvzc5eJH4umw98F0VtxwkUfxlMS01/GotHP6FSlbyUZiTGgIsNLaj/vySkOcEbXq7+r3Jy
	gMR4IPYLZaQ==
X-Google-Smtp-Source: AGHT+IFJMaI7AAdlvvX+sCFJDsuKt1vlz+B2+hujflOrEg+1jNaUzgqjTUpEqCAvScumMuywhWYZncSVvAaZ
X-Received: from plpl16.prod.google.com ([2002:a17:903:3dd0:b0:26a:23c7:68d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc86:b0:24b:182b:7144
 with SMTP id d9443c01a7336-28e9a5655f4mr112806005ad.7.1759688679065; Sun, 05
 Oct 2025 11:24:39 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:05 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-3-irogers@google.com>
Subject: [PATCH v7 02/27] perf perf_api_probe: Avoid scanning all PMUs, try
 software PMU first
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Scan the software PMU first rather than last as it is the least likely
to fail the probe. Specifying the software PMU by name was enabled by
commit 9957d8c801fe ("perf jevents: Add common software event
json"). For hardware events, add core PMU names when getting events to
probe so that not all PMUs are scanned. For example, when legacy
events support wildcards and for the event "cycles:u" on x86, we want
to only scan the "cpu" PMU and not all uncore PMUs for the event too.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/perf_api_probe.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 1de3b69cdf4a..6ecf38314f01 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -59,10 +59,10 @@ static int perf_do_probe_api(setup_probe_fn_t fn, struct perf_cpu cpu, const cha
 
 static bool perf_probe_api(setup_probe_fn_t fn)
 {
-	const char *try[] = {"cycles:u", "instructions:u", "cpu-clock:u", NULL};
+	struct perf_pmu *pmu;
 	struct perf_cpu_map *cpus;
 	struct perf_cpu cpu;
-	int ret, i = 0;
+	int ret = 0;
 
 	cpus = perf_cpu_map__new_online_cpus();
 	if (!cpus)
@@ -70,12 +70,23 @@ static bool perf_probe_api(setup_probe_fn_t fn)
 	cpu = perf_cpu_map__cpu(cpus, 0);
 	perf_cpu_map__put(cpus);
 
-	do {
-		ret = perf_do_probe_api(fn, cpu, try[i++]);
-		if (!ret)
-			return true;
-	} while (ret == -EAGAIN && try[i]);
-
+	ret = perf_do_probe_api(fn, cpu, "software/cpu-clock/u");
+	if (!ret)
+		return true;
+
+	pmu = perf_pmus__scan_core(/*pmu=*/NULL);
+	if (pmu) {
+		const char *try[] = {"cycles", "instructions", NULL};
+		char buf[256];
+		int i = 0;
+
+		while (ret == -EAGAIN && try[i]) {
+			snprintf(buf, sizeof(buf), "%s/%s/u", pmu->name, try[i++]);
+			ret = perf_do_probe_api(fn, cpu, buf);
+			if (!ret)
+				return true;
+		}
+	}
 	return false;
 }
 
-- 
2.51.0.618.g983fd99d29-goog

