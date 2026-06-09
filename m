Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E0352FA5
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016036; cv=none; b=JxJ6hwuppLXat380LyE/lHAdKGtfTp2NURV/+37hL1WzkL2B163P3j9ZsO/+XfGeDX3ZarHeuIuL7K6xSv8Pg2DPRJ3wc1W46YzhMv6fzZmc0HCMBkR2oNt+TpZnC1kglQy8FelCW0C2T5hD0BLjTJoTNxsY36swsV/+oxPGJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016036; c=relaxed/simple;
	bh=eCuV3FuofxqoEQPMj2FadVdPVNUg7XcieFIZyThEq0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hgr4exQihowhVkM28DClixTmnPFY5gZDK/xlSYKGDnEzXQ1xhf7Bq7nVVpYT7TQpdVW1DnWYY0NJk+l/3x3Z+AvUQL3DtfdOBYdZhZREOXLGpKcd8VZGPpveKevZWHpVhrMEkOWECMgqYVEtTMiy6TL2bHHGBuJz95n12IMPltM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rq/UcUXO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rq/UcUXO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490d1e54b3bso19391195e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016034; x=1781620834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSy6i0DRlOr9w5Y09gyckl4fi8MxME+0ZH/anot9Owo=;
        b=rq/UcUXO4nWLSNTgoH8rIYdH51RW0+hrLuUykp6wNs/1xt2qN1xISNzaIrIalJJBV9
         dZQMV9ofjJGcDujI1r+Tcj/zHnWFd5igk2kSimX5GFZK00eqNk4QVewzEufBHqQ8dEMf
         oQsWAz3aK2dnNwjKetucX6WS0hbghcFp9v8q7s8tc9eb0CF/+AOw2n8S2N+CJNlWeC/6
         e2TaqtD+jNTqfO/DkCwr4Shw3bdsK+JK/snx12OklIHTFwmdtnrWc0CT5dTlQ/1HrjS8
         EMZSs217nljZrzMh3BP16zrVWP0H01v0wzEOpMXguvX61qUO91umM5kVcAJQVf0I2OZz
         PsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016034; x=1781620834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bSy6i0DRlOr9w5Y09gyckl4fi8MxME+0ZH/anot9Owo=;
        b=nIvd1fRuX2/mafGZjX50BMcME/i/7NA7J+TeA9FJZ69h7zXgMDmusAdfKIjJstW2Rn
         FufutK4KyEcHi750hX9Rgsqu4fJ1zMHlPqppLzCh+P4AHPEj2jWOxrygW7+EWEIbWQVR
         uhmXMaR1II2FI0EkRVpThPvh6EOJa4SMbyrSd/Azs8M+/KSjU8eAbaqgQWe1oM7aqqIu
         a5zr5LPKCAmbJr8DBy9OgEoNrhE8jVOUCXuGO/3mpAcldj33XhpQxJK0NVfZTZFswphO
         yotyyIfJEX3mN+2NZFfTo+Xa2O1cIfyQRT15FbfEXqVvDnVpqqm/VjsTA8YhxTzwbyCL
         4qzw==
X-Forwarded-Encrypted: i=1; AFNElJ+ohwodHpdoTztP4NDzPgy2MgOeOcjH+WKGwTijc3IbKZqCQCaZnQ+CUvMK17Vvk7YuP26SNqfFXb+skNFsfLny@vger.kernel.org
X-Gm-Message-State: AOJu0YyJJhTszJ3VLjx8gEN2+erd5Ni6w+Q5KaND85vmSaKEGY6Zq+09
	EykysIYQmIMWKzNJ3N3WUqZrDqTaidmdjK/hIsMJb1VYSuJNyU/f5Q7+/DIZUB90ZBc=
X-Gm-Gg: Acq92OHG6kn3hrIgNTVFKBmZFx2KYIXouIDb2GsTqGu9HPY7LiCriLF647OFKFqNJuN
	TjUdRVnwr2QVIlcbOHJ9phcENZrHf1oYJoclpEQCicXQzDk5JKjTtKPPJ2cu2QyJJ2fUqvPtriJ
	zmIXmSdZaBwhye1t2+Ex7/JC0zCpqWQYfWShKzCMPloM1aZMFmZPXCAZDxQg/GU2djSE0B/Ynyq
	hyH7wrGqYy/8HYz5GXUu/VlaVUF66+QSGgPM3f1tV+BGbasgQh8qcwJavyquNNDFEj9qaC7kO7h
	gY3mZWPVSHfT5YNf/upj4NZcXQMujV8pjdu5TEzh4ITiIjCylALWlJTaR1SB0ycW20u5d6D7j8i
	pBx4AF0K32cm/z99zBo4hRUj5G0uwsG4CAxQ+brNGcxSAzVLxtv7If+DVzZUJHPBoFmN3IHoff8
	L1j0gr0uRK+txkICy6krFHOIrf3QRGqea4A7voYb5ywH4=
X-Received: by 2002:a05:600c:8b70:b0:490:ae94:a7e6 with SMTP id 5b1f17b1804b1-490c25c20e0mr322707135e9.24.1781016033565;
        Tue, 09 Jun 2026 07:40:33 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:32 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:40:12 +0100
Subject: [PATCH v5 07/19] perf test cs-etm: Remove asm_pure_loop test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v5-7-d53a7d096a19@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
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

Reviewed-by: Leo Yan <leo.yan@arm.com>
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

