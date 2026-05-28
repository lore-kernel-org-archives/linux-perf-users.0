Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3FD313539
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997983; cv=none; b=ZZn/r0ifr13uKvGOOcuD+pS2OHVe0aa/3nlQLauOx0wXBDx2dRQS0HA/yKfepuTce2P9cDq70iqXL3wMMYekpBwt28gg+/89cbosf1hqQhbO3neNTGQUtpU7z9hdgbTwMF2U7kE6salHmR3Ii3EJ7kmoXYsSCaJKBFa94TUMfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997983; c=relaxed/simple;
	bh=d5ev39DJ7XuMiT1cusC6h0dkjra32XflyVN5uxigsuQ=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OEmcLO4+G0FYVJAyzc8BmmRsb1RNO8sM3EGiJeog4hbDDwkUvOWqht0Mcl0fIqOeVJVbsQ00MQqIrGVN3xkP45WhOy4q1FU91pWsoGPWWrTV5k+Sm3K5zo0Tk+eAJtv9DVAl1JiowWxukwFhHzPJkrsnRNT7KWluzD/Nb7HIJ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5qsKGng; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5qsKGng"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-516c96d0cdeso64550371cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779997980; x=1780602780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSweMU2kbOJPZdesr6FMZ6m/XS+obLaza9k39QjRM/Q=;
        b=j5qsKGngvBGcXjN7/WKkVPYe0rbro62inoF4VqtpYF9Da5cJMUG34OkkTMB6bG5ioT
         CvrMydMPr+flnZGf6h5ENwekK68ZzJNGoNBwGfl2PH2lBE4+/v9yhjmirBE4jVB2MES+
         uKZkGE8ZXIVuritsLu+k1PG8NyAuAV9GBMwRZhM8nxbpik7LSnQVl4MIyWzK+F7y3em4
         m6gza6yeTh/0gZPwHt2CqB6Y+1z9tMBX++8WCupP2jMRb3Tyny6YETjqkHczHvduQkt9
         5az5r0ozxEUMI+B90Oed4hetxCTKQXNZfPmDw1lZH4T2NrWnK73KLGQaN7XVOgcxOGYt
         J6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779997980; x=1780602780;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hSweMU2kbOJPZdesr6FMZ6m/XS+obLaza9k39QjRM/Q=;
        b=fmmelCZiynG+NdREJmad4pvTsvJRJdOX3nfvyZGYZKDV6qyR4aNKj3dPsk2yR4SIut
         UkUxYNp6FlXZs+br6HUgOSQSWXZmgx7FlCOUqpZwAHRr3FnAiF7cjBkGnDSSnPKwd+Dg
         CZzOIZ82lnqe9tQ7SCeuY88YscNCmp+x/OcJeSkUSb4lx56c1UVVQIXW4n4EkWYD5UH2
         NyTw6yfTkM/+mCFXXrYb9ZkSwzd5/gJf7VIRR7qUBJUjGC4wFjdVvIpydym/eU1gXlEd
         9etWGJ5ndnzel8wMeq7y9tpJu9ViCAGcIlVCB2XZ/y5n/cEFGvacGzlTV2iWI7O4y51n
         fJnw==
X-Forwarded-Encrypted: i=1; AFNElJ9V8H7XjBPYz10PVoCzdDhmGnGpMEF7ZzrDxxKRRqktGGKljByOY1c8Vo/M8omsb2tMXxYQ//81xo4Y057Ft8Ca@vger.kernel.org
X-Gm-Message-State: AOJu0YyZVuvvTdryBbQEk8/RekBpttxU/vWcMdpAerNNgL0ZJvqhbMr7
	yYw9U1LA04Qb3rXSjul9AYmX2bBEpmbyN5wKjTkQEnJp3fXg+SvdGXdy
X-Gm-Gg: Acq92OH98kxez1WK+7nmuOW+Y8DFK8MIxywLNE3Irv1K48G9C9gFoj3chVLD2cGy6pg
	8pAYMwPUMbZ0Cpr40cJbE5X0HKIfxSryFpCW7zN080GdctaX4KCdRDv+fAEMAy7vwlGmBscUxnH
	E7jge+4cCgsaw8kanMZ0BtxeWZ7+juVMhUwHZYsd5fywWD8bfVIqubAoA5fZ96kE5LLPPHtMdmY
	ISHFIt1f2+/HvBCtIP9ymK3DS6iPnyVmyvZfEgQEHiPgLdwyIjkAZfyAXXm0za6NNCRYicG/hJW
	42L6Lc37Z394pm4JGtZBLZ6D9udRaT19ym0QxnWCiLSQZBx9MG+puVWJaWIn6x/LpEneqXA0Oz4
	ee9dW6ZVqSFBWm+Kx7V20ZCIGqmWqO1IQj3mhIPY4e1BtSrPvr2NXRfMUWpXww7ImK452VwrmIy
	YVy4OlMcDpM2XGJyHEPhgH7XhhRnxZ
X-Received: by 2002:a05:622a:40c3:b0:516:dbf6:f8e7 with SMTP id d75a77b69052e-5172cb69340mr4244601cf.17.1779997979567;
        Thu, 28 May 2026 12:52:59 -0700 (PDT)
Received: from localhost ([2804:388:90d1:6ac3:6adf:ec45:d26:cc54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706b066e5sm81085101cf.26.2026.05.28.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:52:58 -0700 (PDT)
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 28 May 2026 16:52:55 -0300
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf tests hwmon_pmu: Use PRIu64 + (u64) cast for a
 __u64 field to work more widely
Message-ID: <ahidF9--hJ7YXPiO@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

While testing perf with an updated Debian experimental cross compiler
(gcc version 14.2.0 (Debian 14.2.0-13)) this started failing:

  In file included from tests/hwmon_pmu.c:12:
  tests/hwmon_pmu.c: In function 'do_test':
  tests/hwmon_pmu.c:199:34: error: format '%lld' expects argument of type 'long long int', but argument 7 has type '__u64' {aka 'long unsigned int'} [-Werror=format=]
    199 |                         pr_debug("FAILED %s:%d Unexpected config for '%s', %lld != %ld\n",
        |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /git/perf-7.1.0-rc5/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
     20 | #define pr_fmt(fmt) fmt
        |                     ^~~
  tests/hwmon_pmu.c:199:25: note: in expansion of macro 'pr_debug'
    199 |                         pr_debug("FAILED %s:%d Unexpected config for '%s', %lld != %ld\n",
        |                         ^~~~~~~~
  tests/hwmon_pmu.c:199:79: note: format string is defined here
    199 |                         pr_debug("FAILED %s:%d Unexpected config for '%s', %lld != %ld\n",
        |                                                                            ~~~^
        |                                                                               |
        |                                                                               long long int
        |                                                                            %ld
    LD      /tmp/build/perf/util/intel-pt-decoder/perf-util-in.o

The usual make that %lld a PRIu64 (since arg7 is
evsel->core.attr.config, which is a __u64) but then on Fedora 44 (gcc
version 16.1.1 20260515 (Red Hat 16.1.1-2)) it ends up with:

  In file included from tests/hwmon_pmu.c:13:
  tests/hwmon_pmu.c: In function ‘do_test’:
  tests/hwmon_pmu.c:200:34: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 7 has type ‘__u64’ {aka ‘long long unsigned int’} [-Werror=format=]
    200 |                         pr_debug("FAILED %s:%d Unexpected config for '%s', %" PRIu64 " != %ld\n",
        |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /home/acme/git/perf-tools-next2/tools/perf/util/debug.h:20:21: note: in definition of macro ‘pr_fmt’
     20 | #define pr_fmt(fmt) fmt
        |                     ^~~
  tests/hwmon_pmu.c:200:25: note: in expansion of macro ‘pr_debug’
    200 |                         pr_debug("FAILED %s:%d Unexpected config for '%s', %" PRIu64 " != %ld\n",
        |                         ^~~~~~~~
  cc1: all warnings being treated as errors

So the way to satisfy both compilers is to also add a (u64) cast to
arg7.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/hwmon_pmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index ada6e445c4c41e1b..870d59c0f7cba2e7 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -2,6 +2,7 @@
 #include "hwmon_pmu.h"
 
 #include <errno.h>
+#include <inttypes.h>
 
 #include <fcntl.h>
 #include <linux/compiler.h>
@@ -196,9 +197,9 @@ static int do_test(size_t i, bool with_pmu, bool with_alias)
 			continue;
 
 		if (evsel->core.attr.config != (u64)test_events[i].key.type_and_num) {
-			pr_debug("FAILED %s:%d Unexpected config for '%s', %lld != %ld\n",
+			pr_debug("FAILED %s:%d Unexpected config for '%s', %" PRIu64 " != %ld\n",
 				__FILE__, __LINE__, str,
-				evsel->core.attr.config,
+				(u64)evsel->core.attr.config,
 				test_events[i].key.type_and_num);
 			ret = TEST_FAIL;
 			goto out;
-- 
2.54.0

