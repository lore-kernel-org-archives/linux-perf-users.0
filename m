Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705A1165F1F
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222876; cv=none; b=jaFKQjKJwVgC8YdD9CCnHm6K2DWxRk8TxGgB9hZNJgbQO9KHo1qqrDiJjJTQ+RufkLV1GrILworTagUz6+cw0zhRrj7H4q6dcdD9Z9wrctVEiW1fl2PUGjVvP5TXC18TX2Ciba99mBH7uIyexSzF0BeskjoCzFnIS1tKaX+qE3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222876; c=relaxed/simple;
	bh=BNPC1b07mslfGbpTW7XqzdpDJkoFc0uVUKN66zano6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E2XXgZdq0z41SafyK+UIjIg7meekaf0iS3gxRM3dLn9e2+GtPQI8gOIPQjDujSEAhiNOzYJphiaJhOfP5J36/wB665in5HPWg7ca+jOVULr7MbHJCcbC86AjQVOqNKhl96xsLq0p+rHDxOvACyNoNwlagAWKR53gd9Q46mF/Eb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aJtE/nWa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aJtE/nWa"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2163b0c09afso217065305ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jan 2025 20:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736222873; x=1736827673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cysNvnFHs4eqxH3EhS5RSNCqDi87XxzZLEnZlplPDas=;
        b=aJtE/nWaOq/JhzseYa3IGrkPgwb/cEHjtB6Lwg4+m0RakAJzoMEcu42svjF526x2uk
         ufbi+Va6/KRzXfAxwypFJ/YU54mkoWOOqKcq0YphvD0DXruzqIyZ1OLa1syl6eItvwQQ
         vT3oGWgUsGO+eO0j/cxpITnfGeJyz0F9v0sTJDA+PJfhdZeyRCYOHzRTFY7ZI7FIn6+Q
         jqm4+s7Hzmoj1oRHhlC57GV8qJVh4aG93gSkv7IVbtcTLhuvTCsJedzqxzoRuQghYF51
         uL5CAU8JL8/ZytV95IvU3yhxaxfHrFwCVRVC3i52bYNYxJ8lgFH/OOPso20ayYtMTVhU
         J2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736222873; x=1736827673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cysNvnFHs4eqxH3EhS5RSNCqDi87XxzZLEnZlplPDas=;
        b=qdWKgYSEPbzn0csprtfPWMcoe/649mNFq7Hs5HAC7rFd8xMwAa4bsSoujTNd0XluEM
         vlf2iwvVgXu2rUHW5z3Rv/3ETNlIzjPzYYyimMO/TZqt19s4Q7QmgFUcQc1LG2bFjo+d
         UZWSt5q89i4SUQq+A1BP1xZxJCIhlx0UqcqpXi5XWfIONwv3UAqajaLUZzy3ufJ8dDj8
         ppafOv2gnlGzOfHpMzsrhdUwNh/sanmuDHsG2l+VxPrujG2Buz0pwu5c2rDluMdIREp7
         whZdl8dlZ2Re23WkMU8wlCi1lmFaWN0kJY4S58vGyPJtvzYFlzD4vDvm5PbN+TCmZrNS
         TW/w==
X-Gm-Message-State: AOJu0Yx04tTiR6+0clijxWU7/HbA7VzQUA5BEAOLJTdUbPMQClTP0Vzw
	zHhWoA6PEOOwYhTuS+wbZt5fFq0F2GNiFTGsTuYLjUpjx5nQRVCURQsMgpngYLBfKsmadEkXmbS
	t
X-Gm-Gg: ASbGnctUR/i/BUYfALxejmMQm5o4H1q6FspakG4TvGolROnQvV38y43BMVeh3CM/Eo2
	/iOVOdjJEn0xBA0fT5NzHb+p/Kouwg+hJtK0GyBUEIenD3e0TLNUZuc2sJVzV3PeH/ghKBrGwW2
	oDNaAp0YlEBfAL3tJOHSnAyauLEtA7Ag38ikPNoedGWXRteG09ObGxDKKozMKrr+6UGIGDmV4Vy
	fukMpm6G/nHBythtG7wsrsfdYGew1NnblNty1AtbYFeSJuQsV3kBDitaVZSNZ1GkOl4Y2me
X-Google-Smtp-Source: AGHT+IF3IBbAxpbH7R2pb7nbh54CZ6EdvavjWtQcRTKfxkBoS8Ly5o7CLWVYR28+7Hj+fJ2Ue+PMnw==
X-Received: by 2002:a05:6a21:4986:b0:1e1:b1bb:87a0 with SMTP id adf61e73a8af0-1e606dfe60fmr72021441637.34.1736222872651;
        Mon, 06 Jan 2025 20:07:52 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-92587c62eacsm11698726a12.21.2025.01.06.20.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 20:07:52 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 06 Jan 2025 20:07:34 -0800
Subject: [PATCH v3 3/3] libperf: Add perf_evsel__refresh() function
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-perf_set_event_limit-v3-3-dbde0e90ddde@rivosinc.com>
References: <20250106-perf_set_event_limit-v3-0-dbde0e90ddde@rivosinc.com>
In-Reply-To: <20250106-perf_set_event_limit-v3-0-dbde0e90ddde@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6791; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=BNPC1b07mslfGbpTW7XqzdpDJkoFc0uVUKN66zano6I=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rNikld0/k4E6JPv6nmOD+rOITVf113QPYSszeL7kzam
 vqj8F1nRykLgxgHg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABMx38zI8Ge9KIN3azyzUcYG
 b/kQKf3giV3TdwbxvYjQV3T06O77yfBX/PR67WU5/JWNiZpsi6dVFLYz9Wiwd61XZpr2fG4rXx8
 PAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Introduce perf_evsel__refresh() to increment the overflow limit. Can
optionally enable the event immediately.

Co-developed-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/Documentation/libperf.txt |  2 ++
 tools/lib/perf/evsel.c                   | 49 ++++++++++++++++++++++++++------
 tools/lib/perf/include/perf/evsel.h      |  2 ++
 tools/lib/perf/libperf.map               |  2 ++
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 59aabdd3cabff19c9a4835d9d20a74c6087d9a06..d557cb0279853c82dfc65533ba230255fced64bc 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -146,6 +146,8 @@ SYNOPSIS
   int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   int perf_evsel__disable(struct perf_evsel *evsel);
   int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
+  int perf_evsel__refresh(struct perf_evsel *evsel, int refresh, bool enable);
+  int perf_evsel__period(struct perf_evsel *evsel, uint64_t period);
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c475319e2e410d31d072d81afb9e6277b16ef1f1..92633d426c9439afd7a8cde70dde8320d6a2efa3 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -19,6 +19,7 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <asm/bug.h>
+#include "internal.h"
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 		      int idx)
@@ -414,7 +415,7 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
 	return 0;
 }
 
-static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, void *arg,
+static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, unsigned long arg,
 			     int cpu_map_idx, int thread)
 {
 	int *fd = FD(evsel, cpu_map_idx, thread);
@@ -426,7 +427,7 @@ static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, void *arg,
 }
 
 static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
-				 int ioc,  void *arg,
+				 int ioc, unsigned long arg,
 				 int cpu_map_idx)
 {
 	int thread;
@@ -443,7 +444,7 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 
 int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, cpu_map_idx);
 }
 
 int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
@@ -453,7 +454,7 @@ int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
 	int err;
 
 	perf_cpu_map__for_each_cpu(cpu, idx, evsel->cpus) {
-		err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, idx, thread);
+		err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, idx, thread);
 		if (err)
 			return err;
 	}
@@ -467,13 +468,13 @@ int perf_evsel__enable(struct perf_evsel *evsel)
 	int err = 0;
 
 	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
-		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i);
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, i);
 	return err;
 }
 
 int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, cpu_map_idx);
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, cpu_map_idx);
 }
 
 int perf_evsel__disable(struct perf_evsel *evsel)
@@ -482,7 +483,39 @@ int perf_evsel__disable(struct perf_evsel *evsel)
 	int err = 0;
 
 	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
-		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, i);
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, i);
+	return err;
+}
+
+int perf_evsel__refresh(struct perf_evsel *evsel, int refresh, bool enable)
+{
+	int i, ioc;
+	int err = 0;
+
+	ioc = enable ? PERF_EVENT_IOC_REFRESH : PERF_EVENT_IOC_INC_EVENT_LIMIT;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
+		err = perf_evsel__run_ioctl(evsel, ioc, refresh, i);
+	return err;
+}
+
+int perf_evsel__period(struct perf_evsel *evsel, uint64_t period)
+{
+	struct perf_event_attr *attr;
+	int i;
+	int err = 0;
+
+	attr = perf_evsel__attr(evsel);
+
+	for (i = 0; i < xyarray__max_x(evsel->fd); i++) {
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_PERIOD,
+					    (unsigned long)&period, i);
+		if (err)
+			return err;
+	}
+
+	attr->sample_period = period;
+
 	return err;
 }
 
@@ -493,7 +526,7 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 	for (i = 0; i < perf_cpu_map__nr(evsel->cpus) && !err; i++)
 		err = perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_SET_FILTER,
-				     (void *)filter, i);
+				     (unsigned long)filter, i);
 	return err;
 }
 
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 6f92204075c244bc623b26dc2c97fa4c835a4228..19d30bab8fe1e2d860b432855bc01958ba5e54c8 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -40,6 +40,8 @@ LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
 LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__refresh(struct perf_evsel *evsel, int refresh, bool enable);
+LIBPERF_API int perf_evsel__period(struct perf_evsel *evsel, uint64_t period);
 LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index fdd8304fe9d05862376c122d68777a6bf6a03d80..d67299bd5216b02e09a47a1b1ef947eef460cf17 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -33,6 +33,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__munmap;
 		perf_evsel__mmap_base;
 		perf_evsel__read;
+		perf_evsel__refresh;
+		perf_evsel__period;
 		perf_evsel__cpus;
 		perf_evsel__threads;
 		perf_evsel__attr;

-- 
2.34.1

