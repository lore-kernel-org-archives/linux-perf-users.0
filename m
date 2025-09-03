Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6D225A4F
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Sep 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912550; cv=none; b=Pf+DBeLUsA3sD9EWCbZVQ0ecYnVDl2D+9nIvKd0Ez3ZXSTRkEuAtC08qSn8XwqZ4oHfy6V5Shwe26vcJSPOG3Rv/lODa43tJFt5ZJT3nQtAXzy9dajPSSl/51UzP388Q0kAKd3C3Q5WnuKEXKFkWY05/amWy+8+GRYA6xOpy9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912550; c=relaxed/simple;
	bh=oB6YH9stGXXmyWf9fU6U+hcPYGMIbxOjTtbnKUQ/AME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=upMFNoqqjGC02lSS3KJzqM6RqD1wR8NPpGBMnQ3VcJh67U4WZgz5+bRr3qc1/6D4rIXYXnh/eBX81e7mqA9t96zctZ+w1gZvVbRBKbR4RPZGQ2IZPFm9HiBKe6KbnYJOLT3vikpxNesvJf9ScgQHcT2ce43+6d5G8wJyfZcAp+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qvjxV+lb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qvjxV+lb"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b8b1a104cso311365e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756912545; x=1757517345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETVP+OvG5GLGu2xaJRcK8WzZ71eqDw1aBK23tnlVu0U=;
        b=qvjxV+lbOJi9x7MxnhjaFUV2Lv25/li2a2aW7BvtnLw8mk1PGrdH8zCwM7PEvnMNp4
         7xOSfl23Seq+dLQY1gSziABSfG2RkG8kPFF+kv4edOoXM8xcsLXMZwhhyA3M5xIdaFOT
         iWqhRD9aGaDhRHduAXNSPCa0uUz4m9WbJQP7mzTJp5eudUiZjMw3MIPwO2FSG7EM3lzI
         S4jwFoEiusmHq6fQlogrgqg1HPHnnGG+W5WFCOs/GkzCeIjxGaL4Hp6/NN5gZ7b9rcTs
         c3xe16oUT2Y2gndzz1Qd1f6LJh0jdkQOeVvxOBh4Da70Qgc0HLJcgMfUYdUR2ujpiHy5
         0M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912545; x=1757517345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETVP+OvG5GLGu2xaJRcK8WzZ71eqDw1aBK23tnlVu0U=;
        b=sZKazpqagn/AgXsA7wMmnbVZ3F91s136T87vWh20PTIwbzET8xVE8NbcjpLmv9vr8W
         Cx3QokXowWFzRYu2q++7mzUhmuM06XUP8+Qncm2Z1ZgSS+HGY7W5CNYdzuSU7zE0wg15
         vJrVo0PUuDOs48KDiTdWuJwoWoKRhWkhMrzK8KmA3gcRcoYu8Rumnuu5Kg09FkQdJ1Zr
         Z7GnWhHisoeIAUDBFq1u8IDJBE2w0WWRN92sKSRwJHyzq3sNbTB/VgxDNWXidaRsDvxP
         x5zZFgYspyWq5eyILAUxYr9XvZ42nkj34YCUiahakjVAjeAAOiqIL0ZPA71NhbFAsGRh
         R2tg==
X-Gm-Message-State: AOJu0YzzwE0sL3vR8kQQbAzShzhRUPUlG50+conrKiQAmt3TlJWYN4BN
	A/y07entkiM0uzQOpwWuHzy0O5Oy8/5i8P3MCzmNzH7aTt2D/nxDz8rpVTM1QYN0qHY=
X-Gm-Gg: ASbGncuHIjvwjXm2JYLM6xnyanHaPUsdLX1GwsZ/tVa+axQ/6XptyRqLHL9LpG/pVJi
	ix/Rd8BEuWUhjLw45nv0cjqWmOYiB2L0lWlR8H39SSXzWv0OlXbZLxAA5MhASzURQMqnz8QGUlh
	y7VpzoLCNz5/OVO0wtAqNuetSrOlw2dn/mGuJE08lT9WjSGgWuV2mMyRc/jhKiXtjhceFrc/vFP
	U38uI6x/HhuUVT82/ZXHHDxxrS9Hx1Fpb+jdkLwR5MnDcoB3ZDc2BzO/z+Gn2SOOcsSAG5dkKzN
	4k+ij8KMTciFHeCB/Z3T8p1a/DYaEilRp1aFy5xA7xQBiaZvBbcBh4+XVSaPf0mWtsGgvEqMu/r
	UG2rng5WQnKTwvp0Q8dJ+SmM6D9Y/ZgpkRxC7UwZuZg==
X-Google-Smtp-Source: AGHT+IGQx37RL3c+ClyXLKbsQA1OFjTpe2lVkHyoUBOyO2DmfYjczXJvj3+g+jXr/QP+2ORQGmopGQ==
X-Received: by 2002:a05:600c:1384:b0:45b:7b00:c129 with SMTP id 5b1f17b1804b1-45b8558d694mr136409375e9.35.1756912545579;
        Wed, 03 Sep 2025 08:15:45 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0f85c287fsm22090097f8f.52.2025.09.03.08.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:15:45 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Sep 2025 16:15:26 +0100
Subject: [PATCH 1/2] perf tests: Fix "PE file support" test build
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-james-perf-read-build-id-fix-v1-1-6a694d0a980f@linaro.org>
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
In-Reply-To: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

filename__read_build_id() now takes a blocking/non-blocking argument.
The original behavior of filename__read_build_id() was blocking so add
block=true to fix the build.

Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to filename__read_build_id")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/pe-file-parsing.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 30c7da79e109..8b31d1d05f90 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -37,7 +37,7 @@ static int run_dir(const char *d)
 	size_t idx;
 
 	scnprintf(filename, PATH_MAX, "%s/pe-file.exe", d);
-	ret = filename__read_build_id(filename, &bid);
+	ret = filename__read_build_id(filename, &bid, /*block=*/true);
 	TEST_ASSERT_VAL("Failed to read build_id",
 			ret == sizeof(expect_build_id));
 	TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_id,
@@ -49,7 +49,7 @@ static int run_dir(const char *d)
 			!strcmp(debuglink, expect_debuglink));
 
 	scnprintf(debugfile, PATH_MAX, "%s/%s", d, debuglink);
-	ret = filename__read_build_id(debugfile, &bid);
+	ret = filename__read_build_id(debugfile, &bid, /*block=*/true);
 	TEST_ASSERT_VAL("Failed to read debug file build_id",
 			ret == sizeof(expect_build_id));
 	TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_id,

-- 
2.34.1

