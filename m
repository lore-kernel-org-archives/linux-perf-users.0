Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D491DE3BE
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165484; cv=none; b=I3HVYYW7Q8Flpo/iQNcERQ3Bgdq6/JLoFzrnfq3nI/XlIuH1WJoPANz2SYnWbb8pAPIS2+XxY8mtgDlohzX6dVmZ8LVd8dyrzux5ERGm1f0kQjnFvrvEgrD/fEu0TfFQsfsS/zA9sRUpii29qsWf5cN2ugs6N6zYWFJ1d3AsYw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165484; c=relaxed/simple;
	bh=cWHfYeyt+oHxSfbBoOrNogusDIOQlCQOMrZ+MWLH8B4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M5KWGoI4Ob7VUNuW3NmkpXPbozjrDrBYtT25ozIVLOZu7cSlIJ9ZdToxc85UMMRlShSXlQRDH/3TaPFHJMacicGhUxBJif69OJUoxg/RSgRI5YeKNYJfIJmlMgGyGyclV32XXJ0xEkpe+beMx8sxomfgEXPgAmZ6GTZy5rssYx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aqtKZ3xm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqtKZ3xm"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so4999396f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 07:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738165480; x=1738770280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b38VL+rBP91884jzBXnnCS1YsVPwzuVXNg23TycEXNw=;
        b=aqtKZ3xml2F7TSqTDikXxIM0zz9QSJhGLKCCoNRxVT5P1+Z6P8NQaql+vFyUKQle0K
         jvvTYuQ7pH7VXUYhD/DZr7G58IkeVlJLdFpxYWgwzy+nUAKTjspiqeK3v/XCKm7ZK0wb
         AhJp/+jW8jHq/e+kRjlN98+bTlcnxGo/sgSbWINpS1vXoTGMxBvJO8WuSq48iIC3DZRf
         f7bMbCTX5swnsVx1Cp1kaTmcnmHMVCScR8poIZdEaDM2xJQGuU+nxirRn2JHHoqxgO2Y
         AUttkKM9c8/gdCiuL9evWOt92MPfKNOWd57iJl1ITkYKF5qMZ0gquTYPkA/bBxs9m/Zf
         0JBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738165480; x=1738770280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b38VL+rBP91884jzBXnnCS1YsVPwzuVXNg23TycEXNw=;
        b=jfWUEZmt6OhD5ES6Op5+FJdTBHGDXjgOlbTtRL5UV3Qbt6EVKU3Y2yx0VB2IgeKu0a
         ai7RPmwn7XgivmpjX9A9UeZk0rN4CCLUw8fu72vvluoGlPD9dyZf5zfT22W35BBO+tVu
         bdn1vA+MeWbUTJwiDSa+kRk+nhrN2CsL2mLwOTDkUf1Ur/wvmMjH+w/EivQLI594/s0F
         72w/WMCoLVcCMJ3Tlb2IoNkoja8mQL3PF2KdkstaEFBhie4dxXWx55O/xkrlOPJ7eU0h
         qshKh2AAyvziks/gQhETNEeoG79FWXT+49WfYf6fl/GDHAnMyE8jzqTmsr1FmDkvMaN+
         tBSw==
X-Gm-Message-State: AOJu0YzSRjwEtdmp6l12K6B/L5XzyfkwoR1xCd+5pMKUY3E30VBMoPB6
	LgGfCHrqE/QOZyESsJ4QGMefHasrmjtAhBYZoZ1OktZAtXsI+5nZSerln9eR075eJaobNpTth62
	x
X-Gm-Gg: ASbGncu/VaGFEVvPKxUYmCr190V5+2B1kMpLDqup6UU18Pvo/9BxopYOtfI8Rm2aJky
	i5l5vhnzu5FUBncXCVSR9gcDrP9Bpvf3G7spUgn7/HLYiYPU9NETiObZKhN15As5AibrOLomT6F
	phRv3TTo/jjXc98BHa7sH09BBD6QCbx3Nybsw+a21pO8/I/K/7KMCfUA2bVIUYNvFGWFITVHe0I
	p+DfANb6fzJjyjVC+9KvUtKfY5uMRQnXF1oKSMwGF9mUkAjKrGf6R5tk4m0yBwOWg/v6Z6JfgBl
	K5RZIfNhjD6tCwU=
X-Google-Smtp-Source: AGHT+IGP8GgwuWRnSTc83q6GU6uSdJwwCAR0ZKLna0aMyBcMy2h+dZwjsLGCBz1Jm35rhc1DQtEc6w==
X-Received: by 2002:a05:6000:1888:b0:385:f195:2a8 with SMTP id ffacd0b85a97d-38c5195f5d4mr2910278f8f.30.1738165480523;
        Wed, 29 Jan 2025 07:44:40 -0800 (PST)
Received: from pop-os.. ([145.224.90.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a313383sm17917287f8f.36.2025.01.29.07.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 07:44:40 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Ali Utku Selen <ali.utku.selen@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: Always feature test reallocarray
Date: Wed, 29 Jan 2025 15:44:05 +0000
Message-Id: <20250129154405.777533-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is also used in util/comm.c now, so instead of selectively doing
the feature test, always do it. If it's ever used anywhere else it's
less likely to cause another build failure.

This doesn't remove the need to manually include libc_compat.h, and
missing that will still cause an error for glibc < 2.26. There isn't a
way to fix that without poisoning reallocarray like libbpf did, but that
has other downsides like making memory debugging tools less useful. So
for Perf keep it like this and we'll have to fix up any missed includes.

Fixes the following build error:

  util/comm.c:152:31: error: implicit declaration of function
                      'reallocarray' [-Wimplicit-function-declaration]
  152 |                         tmp = reallocarray(comm_strs->strs,
      |                               ^~~~~~~~~~~~

Fixes: 13ca628716c6 ("perf comm: Add reference count checking to 'struct comm_str'")
Reported-by: Ali Utku Selen <ali.utku.selen@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Makefile.config | 10 ++++------
 tools/perf/util/comm.c     |  2 ++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a148ca9efca9..ed3ba13f1018 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -497,13 +497,14 @@ ifeq ($(feature-setns), 1)
   $(call detected,CONFIG_SETNS)
 endif
 
+ifeq ($(feature-reallocarray), 0)
+      CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
+endif
+
 ifdef CORESIGHT
   $(call feature_check,libopencsd)
   ifeq ($(feature-libopencsd), 1)
     CFLAGS += -DHAVE_CSTRACE_SUPPORT $(LIBOPENCSD_CFLAGS)
-    ifeq ($(feature-reallocarray), 0)
-      CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
-    endif
     LDFLAGS += $(LIBOPENCSD_LDFLAGS)
     EXTLIBS += $(OPENCSDLIBS)
     $(call detected,CONFIG_LIBOPENCSD)
@@ -1103,9 +1104,6 @@ ifndef NO_AUXTRACE
   ifndef NO_AUXTRACE
     $(call detected,CONFIG_AUXTRACE)
     CFLAGS += -DHAVE_AUXTRACE_SUPPORT
-    ifeq ($(feature-reallocarray), 0)
-      CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
-    endif
   endif
 endif
 
diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 49b79cf0c5cc..8aa456d7c2cd 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -5,6 +5,8 @@
 #include <internal/rc_check.h>
 #include <linux/refcount.h>
 #include <linux/zalloc.h>
+#include <tools/libc_compat.h> // reallocarray
+
 #include "rwsem.h"
 
 DECLARE_RC_STRUCT(comm_str) {
-- 
2.34.1

