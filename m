Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10242258CDB
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Apr 2025 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743709436; cv=none; b=TNrypD1qsAfznbSW2i2m2h4ZYK+aWHni6oNw/CJJ3kBvsy8pitHBIIscW6pKlw0d9x01tf0Dol8ohwfhq7uKa/7VeHmqtzYRRBuoXveERjvDpm1uRuwqVyPHp8ZeCvF4h1fdgKiw5V3WNRqszrMFBAMdpXy6CGHwaQtaeuQNZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743709436; c=relaxed/simple;
	bh=ru7u7pKXS/EaVzSTBdHYNt3QsjMHV+QaLj4tONySshs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eM8lsiVSjd9v14uOLF5hply4i3g2nlBKQzWxPe9ZU3WedkihV6ro1bGbO/dSyla4xEIHfoKHnkAoaAcZArEG26mus4OybEMD+VoUHq/gtDcCmiMWqG4Kqv2uk6OSTXk2mmBd5ENZn4BA07IkGsRDl8dPlVuwRWzQr76qhddxwXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t6yYlCgz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6yYlCgz"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af5a8c67707so621184a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Apr 2025 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743709434; x=1744314234; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5Pfi1jEe5jcwyGvVBhtjGFb4NLTmTQnKdr17Cg5Kpc=;
        b=t6yYlCgzn6riXEF4+vmNxtH5wvqkcfcT0wG2qcpL7zBgbWajHv+VpeJ9fcYroKZpLx
         JqeK9RO8HOONjc0f3E9MsMzQk0RGxgWd5gCyk2y+YyxP0CDU/LM8r+AZu63zEBwtJ1tX
         psPo1zT6NCLPt3u6lD4E3af+PRMZV+vq+Gxy39e2iOjDoFrFS7XuFULAP69bjyfuguht
         1i4W6tFyS7/b/dZzT017yE1L0B22kVY86BTisYdIPDNnLMOYy2480uUE4mDvRjgQ1TjS
         E8IxG/JplHpqbpX9WaXzWo4ejSzvumPlHPLv2DU2vgFLQbR3A6RPaH6bo1cYk/veTO4E
         P6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743709434; x=1744314234;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5Pfi1jEe5jcwyGvVBhtjGFb4NLTmTQnKdr17Cg5Kpc=;
        b=Wvhuh34yReSgyqNfM4zucv+TyfBBF71XXtBCMke+rA2byb3e64E9F6fAl6DMzPDm71
         CRrsY0mXh8CXBPs407XPAOqW/zrrDnvl6/KFNfRkdWsUcjdBrLtySEhTEJbJ6J1WMPXF
         x4Phq9JpKQpiDVL/FXlkIcPMxQllnZbazkUzpcaz3XbDCTXwcdWH8Y3pO3pMRFs39ci8
         zKkzo/BwnMKuk6w2Rk5nSenpONYhw18PJyixo7szzcs1VeG5qe5CnLtraMq4YhsHYLyd
         Y9etKUv5PnEyttGy53aE/CLjpEN1BsTG5Q9bOcLZuC6VpmGpGf8v2zEsxemWSnSM8YbN
         i3pg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ0q5z7y5cJjWMliCcBsb/O/Brjn65zZdI6o+TW/K7sWzF6dV3E1EZvjyPSf6XqCQGkNTlclB2TKXSXFYDGu6G@vger.kernel.org
X-Gm-Message-State: AOJu0YxSfDpkI2xPwVAy0qk715aMbR1VaXqiUruAfW7TCC3qCQBxBQTp
	trzjhmT8G71lNc2zOLsvGnWvDjQlZ8GdFVcNbvWnjxUVygutYbP5KVJsAEC3a6q8B9fvRPwfcim
	ve+zknw==
X-Google-Smtp-Source: AGHT+IG1CI93Af9+RSqQ2ONFXYqX+CMo0v2Jgy+naLqDvO/26ArW4PrhUNUcnhD4A9oMbqfEqoZvzEkKAVbf
X-Received: from pjx14.prod.google.com ([2002:a17:90b:568e:b0:2fa:1481:81f5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f86:b0:2f9:c144:9d13
 with SMTP id 98e67ed59e1d1-306a4908a75mr1034365a91.24.1743709434338; Thu, 03
 Apr 2025 12:43:54 -0700 (PDT)
Date: Thu,  3 Apr 2025 12:43:34 -0700
In-Reply-To: <20250403194337.40202-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250403194337.40202-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403194337.40202-2-irogers@google.com>
Subject: [PATCH v6 1/4] libperf cpumap: Add ability to create CPU from a
 single CPU number
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	James Clark <james.clark@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
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
index 4454a5987570..b20a5280f2b3 100644
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
index 8c1ab0f9194e..58cc5c5fa47c 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -37,6 +37,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_online_cpus(void);
  *                     perf_cpu_map__new_online_cpus is returned.
  */
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
+/** perf_cpu_map__new_int - create a map with the one given cpu. */
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_int(int cpu);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
 LIBPERF_API int perf_cpu_map__merge(struct perf_cpu_map **orig,
 				    struct perf_cpu_map *other);
-- 
2.49.0.504.g3bcea36a83-goog

