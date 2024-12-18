Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2A19F422
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522979; cv=none; b=duKGIroqQfNz8SNX7xKGEeDyU42z6YaCpTmYfxUVY39gpDX7TxGk7JqPYu0wsm/H/FIx1sB/RueVhRmnoBmHt6hnSwxgl9HDWi7qgLXAGHOqmzhkSqPLtlOndgBhSdmrI3Q+JxKSTKLPoqUlw5ZN6zgyja8O4oPNY2ASYF+8DPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522979; c=relaxed/simple;
	bh=KZa0o3cth01TaTGeQ4zWl8phZHJpX9P1YG1XZNPuIZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MRoECaNt8dBxz/8ukcJr0KiTio5G3eZNMCskm4XSSh9yEubySObBxW7iCwMCTyoac2KSHE0vP3WcqmsAekkCMNUY5ySi2Z88pmLM5qDNH6gajDiAe84CxgvRteTgg0dLhkoD0AdruHM9LoArXNT4039R1HoQeqabYIRJvBHhcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xk6ApJBP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xk6ApJBP"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so61862265e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 03:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734522974; x=1735127774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sU8TRl5Hia5/9m0MCf6RTQFt9vY1tSkFnfXtAKlr66o=;
        b=Xk6ApJBPsKrfVohCKl/XzOZp9SPLN6DrJM78t+ISDcYo6NUvK7EWShSZA3PP5n2ju9
         QpIgC3FeCk5JE4tlEJWFdVGThAS4l1ixFPpVxE2NMViY2ieTN36h5tSFNF4ni4nD72tF
         tFM8eXtJ2L3ziHPw8W6+S/FzQbklTbFp0Bl7AKWVloMS0lF5vhw19vnNScGxA+bJQ7YN
         NedXaij0bf35t23MKnClKsdjCJBkT9MZll58bvwB5Lz7deEi48k6HglJ/yrfyfbkNOZD
         cBKMzxRaYNnwQLiUehWiqDiW36QyKOYdKRIfI3aoLGep0yAsTCrtSqnlLXneDheeinRt
         tKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734522974; x=1735127774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sU8TRl5Hia5/9m0MCf6RTQFt9vY1tSkFnfXtAKlr66o=;
        b=nBwLxCjaxZAGPoi7e3wTwyQY4WbUBGX0stT4chHVSvmjOwFmySOy8bsVvzffK1Jxt1
         Dlvf5xu/HaNxwi7nN0Zt7InOgG+VluqT9QibsQ5vFMvcUc8X0xGxLlZ7DgvwdEtJqzzI
         oqGgB9ngryIxXHIce2vXLmfkThdstX8hImozL0llqnoZ/YFkNZDkjsxds8c88RaI5hxe
         oLTX81ljvVglBF8CS4pGP8fsrVUSeMwoZicKVg3b5AW2kvvR8e+nPP7XNBSnT+ClGUCw
         rUzC1CBEDcwWCI27vM7kpKMTawDAt+WY1A+n35tAB+kNYmX41IvfjFUvBkdYt3zQcC9f
         zxbA==
X-Gm-Message-State: AOJu0YxH1M6c9Zu4wVH3OhPVSqFgIh3xJiU0PXlmKocMdwoHVwUeNthP
	hflFN7I7fYKrx42Ek5FR8G6Mpn2JGYX5BS610s5q3gQ+Gi0ezuC++Tt9zb6F5g7lLzzYwOpQdho
	f
X-Gm-Gg: ASbGncuBnC8gAq+yns9HJpo/NudYkc3Tu7Bnmw+XCmWYjuuDcgAMo1otSkiTyHPGBgl
	KJ9Q+iCIVjI45h/7+65ykp1d7anYrM/8F9Sn+dPefC5EJkt/zbn1m9Q6KIjgWKbK4sR3LK36Hla
	vHJfs2KAEEHvHb0hyhGS4qZCLgI7/Q+vsvL8aEZ4+xQInD/lOlJsq+iANAWtm5cpBIkhcAbfCu2
	5T4DyZYzepq1iZQKcT3UTt2bSShRW/babJaJlePpIl//ZUdC4eDtZPU
X-Google-Smtp-Source: AGHT+IH9gLkQ299AhfHqHgypTkbxG+ZiziTPZ7k6f7s4gIbsplCWdD5KQXHgEmp+HnCsoA3HTliHIQ==
X-Received: by 2002:a5d:5f88:0:b0:385:ec6e:e87a with SMTP id ffacd0b85a97d-388e4d8ecbcmr2399415f8f.43.1734522974570;
        Wed, 18 Dec 2024 03:56:14 -0800 (PST)
Received: from pop-os.. ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c806cbd8sm13669043f8f.109.2024.12.18.03.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 03:56:14 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	acme@kernel.org,
	irogers@google.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf cpumap: Fix die and cluster IDs
Date: Wed, 18 Dec 2024 11:55:51 +0000
Message-Id: <20241218115552.912517-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that filename__read_int() returns -errno instead of -1 these
statements need to be updated otherwise error values will be used as
die IDs.

This appears as a -2 die ID when the platform doesn't export one:

  $ perf stat --per-core -a -- true

  S36-D-2-C0            1               9.45 msec cpu-clock

And the session topology test fails:

  $ perf test -vvv topology

  CPU 0, core 0, socket 36
  CPU 1, core 1, socket 36
  CPU 2, core 2, socket 36
  CPU 3, core 3, socket 36
  FAILED tests/topology.c:137 Cpu map - Die ID doesn't match
  ---- end(-1) ----
  38: Session topology                                                : FAILED!

Fixes: 05be17eed774 ("tool api fs: Correctly encode errno for read/write open failures")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cpumap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 27094211edd8..5c329ad614e9 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -293,7 +293,7 @@ struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
 
 	die = cpu__get_die_id(cpu);
 	/* There is no die_id on legacy system. */
-	if (die == -1)
+	if (die < 0)
 		die = 0;
 
 	/*
@@ -322,7 +322,7 @@ struct aggr_cpu_id aggr_cpu_id__cluster(struct perf_cpu cpu, void *data)
 	struct aggr_cpu_id id;
 
 	/* There is no cluster_id on legacy system. */
-	if (cluster == -1)
+	if (cluster < 0)
 		cluster = 0;
 
 	id = aggr_cpu_id__die(cpu, data);
-- 
2.34.1

