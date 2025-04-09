Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2B21DE4EF
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744178877; cv=none; b=iPL4k6HXjVg/BWDwbzE9z8v8tKF9MiYP45HqsDJ51fBrHiR7MdoN0CUBhW00WAWmHJ+IatPgpzNeL6KvxxeTeiTP8t9e3KgWMaemujZoWiw2a8wHXyW/Apy1f4yl7HI3i2mJqb8pI/B+5xuZ5waMuuwYe9oxJjW/HLG2MI6Bqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744178877; c=relaxed/simple;
	bh=oTGRBpcL/2sIHNUD+/BM6BV/LmnMI5XK3yo3xDS6KyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=luvcbzQE7JuSPVKh4r5ckSEL3dQAwaEkSumkALOmjfSK9WEKpzvTEXXMKlnw+TKSXUoMN+xfz7HN1N8OqB15niKFx3vHmkVO91P8eDCX6V9D+jIXXXU/ia7fUZ4VGQ3NnEeYkL1cBWf3H8JA+o+Gy5vbfx6Z3qe62o9a3u252jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLXpEtnN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLXpEtnN"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2254e500a73so50080925ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744178875; x=1744783675; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pClnDyLnT+OkOC5ziZK4pcS5wTXzmuK+3iocOmka5vs=;
        b=FLXpEtnNxLWt9dne0GZ+mnmjKCStMKxSmJ3JmKswa9u6HCwj3Uct+1nufMxyQCzkyl
         Gsi0iuh+HQV87F2Tzfv2HNjuboi0Skgt8y+2mF4yNmNL9U1ycEoFlvss7XKSQz4CyvhE
         yim0ggSgMXPGgMoZhhw+Aqo/aF0MMVkvqhhhUT6OBHfKQ3Ddg99skoXJcYiwZqc2Q+/s
         nQFSpA38f3RtZtjgB89JMLobIJPhn7yufd9BU1fKE3av6OGOyzOU+pUsPA/BzFu6Sq4s
         FrDYKUN8oVKxUsm5ZwNA4eB33NqVcfzeg/NPkVo5/vVJlYrqUeJwIfs6HleHZQ+2lVx4
         uFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744178875; x=1744783675;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pClnDyLnT+OkOC5ziZK4pcS5wTXzmuK+3iocOmka5vs=;
        b=ESQVTCOc82qTDebyl/DiQ4MARx8D61ESGc1csojxAaINomxp8PErWCduwtajBOUuK1
         viC8vzsegr/qeeg2c7ZHc/hMJbYIX5dO3JV9erEqeJ6IyR1CbMwkSKWujuhkaf6DtOBZ
         psQiFh4ljSEMAkr0kBIVCyQ/aifQM+LUQhxTIgm2hKDE5yqmbWaC1VOtlBznNCO3dbbI
         p1pG9e5lXStNxuWgeZ7z3fRy/irTzNUzL29GBBKO1nXro+EVSJ0YkJJeTL05yZKZ+W8s
         VEHeg3Tx07c7hE0zhwoaNVQs90P0QdRKwQMKbO2qB0Ot7GxU0eaGBYxO1ccFjFlTfUWy
         geEg==
X-Forwarded-Encrypted: i=1; AJvYcCWb6lsgq6mhbgkybQBT3saH3heqhH104vOAh+kaxrZvPFIdSOHhGdZs1njUjllHKMDDaVFXrQJtV43bBBVVBcC1@vger.kernel.org
X-Gm-Message-State: AOJu0YxZYGq/wOUOE2DZUDE88qg2I39raKdeTCq57vqVY3+26ZGGEt2O
	o2aCnxAUNyLSynqiSBQjfOPjP4PI4sCFechYASqXfESz+QsHmOuITavBkGKqumtAKruKSIU4G/y
	dolEDxg==
X-Google-Smtp-Source: AGHT+IEDzxJvPRvCwd5uXhzLPWUQoc2F9jgGiMHYHy0Yf4lHZZIfXolXPCitAeiMp1B24JA3k+LAWUYq2fij
X-Received: from plg6.prod.google.com ([2002:a17:902:c246:b0:223:49f0:9077])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:187:b0:224:1c41:a4c0
 with SMTP id d9443c01a7336-22ac296e5e3mr19605125ad.9.1744178875499; Tue, 08
 Apr 2025 23:07:55 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:07:28 -0700
In-Reply-To: <20250409060744.698511-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409060744.698511-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409060744.698511-2-irogers@google.com>
Subject: [PATCH v4 01/16] perf intel-tpebs: Cleanup header
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove arch conditional compilation. Arch conditional compilation
belongs in the arch/ directory.

Tidy header guards to match other files. Remove unneeded includes and
switch to forward declarations when necesary.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build         |  2 +-
 tools/perf/util/intel-tpebs.c |  1 +
 tools/perf/util/intel-tpebs.h | 30 ++++++------------------------
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 946bce6628f3..815274b199fd 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -161,7 +161,7 @@ perf-util-y += clockid.o
 perf-util-y += list_sort.o
 perf-util-y += mutex.o
 perf-util-y += sharded_mutex.o
-perf-util-$(CONFIG_X86_64) += intel-tpebs.o
+perf-util-y += intel-tpebs.o
 
 perf-util-$(CONFIG_LIBBPF) += bpf_map.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 2c421b475b3b..3503da28a12f 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -19,6 +19,7 @@
 #include "tool.h"
 #include "cpumap.h"
 #include "metricgroup.h"
+#include "stat.h"
 #include <sys/stat.h>
 #include <sys/file.h>
 #include <poll.h>
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index 766b3fbd79f1..63c16e759a71 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -2,34 +2,16 @@
 /*
  * intel_tpebs.h: Intel TEPBS support
  */
-#ifndef INCLUDE__PERF_INTEL_TPEBS_H__
-#define INCLUDE__PERF_INTEL_TPEBS_H__
+#ifndef __INTEL_TPEBS_H
+#define __INTEL_TPEBS_H
 
-#include "stat.h"
-#include "evsel.h"
-
-#ifdef HAVE_ARCH_X86_64_SUPPORT
+struct evlist;
+struct evsel;
 
 extern bool tpebs_recording;
+
 int tpebs_start(struct evlist *evsel_list);
 void tpebs_delete(void);
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
 
-#else
-
-static inline int tpebs_start(struct evlist *evsel_list __maybe_unused)
-{
-	return 0;
-}
-
-static inline void tpebs_delete(void) {};
-
-static inline int tpebs_set_evsel(struct evsel *evsel  __maybe_unused,
-				int cpu_map_idx  __maybe_unused,
-				int thread  __maybe_unused)
-{
-	return 0;
-}
-
-#endif
-#endif
+#endif /* __INTEL_TPEBS_H */
-- 
2.49.0.504.g3bcea36a83-goog

