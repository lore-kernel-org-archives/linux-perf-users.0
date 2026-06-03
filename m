Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0BA3AEF57
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481858; cv=none; b=RKFjl9fcUxq8kCHARLFagFHLPxGvOb9wfHuybX0zT8GCq7iK8Vel1u9ps7FLWxfjSSFE/VUOaokUZVLBqJMDEpNR802MzkYgQRz1gnq0yKpjW2sUJHT7Cntlui4YW+A9lPie5zLh1oqlNUrAgNB1nr1K7RVWii0UohAZMpoIgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481858; c=relaxed/simple;
	bh=Bet7dcog4cI1OWFbkgHySPvLYRaBjOEAmnyguA5dwLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vnk5z4H5rsbbbwaSBGVagTanPujC0D1mEW/OcTauB/grfiQb0zKKoGo38x5xBI86vS8iaKvncXwizztKAXxp+XahLAOkFzxowZ8Xj2ZWE5olsKuWR/wdB58sRdfDnIXIl2MiReGjgNjASREMy/fBKClg379FPNdPBg5P0vsiS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OU9L44sN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OU9L44sN"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so4756874f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481849; x=1781086649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mOc2t8dZN0s1J71IBgMzN0QR+1naOVex0M+qvmJCq0=;
        b=OU9L44sNb0MQl6xNfYkLA2jUiWL7Ltbcbg0P6kv5ygVI8uOqIqlZG9MI1/eLhZgYLh
         1sQd4bmjlGNwCBiyqK6tbtVdpIR+1XDMJivOqU0bjkr4q09bEJFrl+kSnJbhut1D+fWd
         LFXxFqJJo9rsChhsNIXgNs2QwGPG+h7I3bVIGSkkGg8S9SwYg0VZffhgvZVNMYcwC47Z
         pxdY4C99v6vn4hOhUCTKROVt4CclCqexvm3POh67O1Grrlc/YZxBTW/l0zDeevo3qKjF
         7E66pGg4qD1dOLrJmFlXf7GDA5G0dRLOJ8rgsSc+nuWNzCuoXQyv1fM7VMK8912c38Xl
         0qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481849; x=1781086649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8mOc2t8dZN0s1J71IBgMzN0QR+1naOVex0M+qvmJCq0=;
        b=abj3CucGNHum6cdBUUCRX8m2sEwfu85uWnIpLhr5KwtZPwuS8YKvbKm4O/DixQ90Dl
         CXYtJB2u0VeQ5+hubI4hwuiEmsLaELy5pDVQuSRUwNKG8vZJpvcFzWwj7RPSkiLoCAeb
         xTYoYMoJq2ukpZPkzQXAQRt4kqSwNlstzKy4CB3P4jDry9Jky5E6qtDl+/oi54tK65a8
         oJ7kfknoNuxFDQTFFdZlhP2pvCyP+rmy6n90Q8qGKcMIHJ/mIm72m9sz3HXQTbeFleAS
         MFBYOtGLtk/VIRWQ7+s/HFb68S/Kei6sxCUF9AplWkbKqdXdpSQo17e9h564+mM6L8pe
         ge1g==
X-Forwarded-Encrypted: i=1; AFNElJ8RjK3+RKIXC+zjHpXHKiidB8O2qZF4WFLiD+JJM4Kl1XfkyIQUZ/kSymH+ehfVx2I1MMyaXGSiFu4knaIj1OBT@vger.kernel.org
X-Gm-Message-State: AOJu0YxaJOPAxio2aPdoW7f4TOnrE4JAA4sPgtcfqn+UtC9gTsM8m8iy
	DRkzDDrXOcp9HI7KfwhDI9mo7OBsQ9w4NU90gvJN/uwVr8FdbQHJWfLpjea1JCCzBcs=
X-Gm-Gg: Acq92OEsxpV4EYO0l7KKXGWXLI8qrmpPMkB3CRvMtQx7aX9E4aZFmrnzyY2GzfAlxZ5
	yKiyqeIZq59uLyQLAgH4/J7UTdDICX4GHJmz1YHeLw8QayxmUk0vCehjYxfSSIzgVkp/JKuOx+I
	A3RgP3ob26RV0IK8Jz69kD/FTB7zMkClcQ2269ICW/9zGZT5Nn4HH/+iUHK219IZyLjo0GC8hm3
	Hzj8XCSXoe+kcxznCyZhKLoG2nV/Vo5F/WLquclVzs6OHiJ8wUefzNsGRmoBUV4XyONH54rhfZK
	nknQZdaJeF2krVZUfPDC/moYkEDJ07W1xUYLQP5GW/VWgo2OYnUS50lrqAtOrmSQMVLE6nO3dy7
	siLZO8uxwnzz7wkEkrLsjts2mnRHVv/BXsqgJeyTzaES6no+BRYnUvxMA2R7pXQAS37OJx+pz2f
	NPRvR1LcW650KXU8lB3eDlPpjVUlzNyH1qO5mZqLMzO5k=
X-Received: by 2002:a05:600c:154d:b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490b5fda5b7mr44655035e9.26.1780481849590;
        Wed, 03 Jun 2026 03:17:29 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:28 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:11 +0100
Subject: [PATCH v3 07/19] perf test cs-etm: Remove asm_pure_loop test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-7-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

It's not obvious what this test is for so remove it. It's not a stress
test because it doesn't output lots of data and it's not a functional
test because it only looks for raw trace output. It seems to imply that
a program written in assembly influences whether trace would be
generated by the CPU or not, but the CPU doesn't know what language the
program is written in.

We already have lots of Coresight tests that test the full pipeline
including decoding, and in many more modes of operation than this one,
so if no trace was collected they will already fail leaving this one
redundant.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/coresight/asm_pure_loop.sh | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop.sh b/tools/perf/tests/shell/coresight/asm_pure_loop.sh
deleted file mode 100755
index 0301904b9637..000000000000
--- a/tools/perf/tests/shell/coresight/asm_pure_loop.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/bash -e
-# CoreSight / ASM Pure Loop (exclusive)
-
-# SPDX-License-Identifier: GPL-2.0
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-
-TEST="asm_pure_loop"
-
-# shellcheck source=../lib/coresight.sh
-. "$(dirname $0)"/../lib/coresight.sh
-
-ARGS=""
-DATV="out"
-# shellcheck disable=SC2153
-DATA="$DATD/perf-$TEST-$DATV.data"
-
-perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
-
-perf_dump_aux_verify "$DATA" 10 10 10
-
-err=$?
-exit $err

-- 
2.34.1

