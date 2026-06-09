Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1D359A65
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015489; cv=none; b=Npz6XKf1j/yxOQ1H/hAoYHe33RgoeY12GkBnpj6YuZE6n4lHtoo4hTsMFXzRcEX9cBULLXvsMhzJ10cgxlhucagEq4K52XTiUgAvQn6/zpVUnG5jzCm+5v7Hlr6VEngRa/ZBLL/cAn5ABHXIHJ3vaMlm5gL+xHaH837I+3T0uBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015489; c=relaxed/simple;
	bh=eCuV3FuofxqoEQPMj2FadVdPVNUg7XcieFIZyThEq0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lh9PDY12Wq51DzQ+yoQYTFk+3rnq0F4qIKxZsoHJWQRw1ydJEVaq7TeJG0mn8CAZp0OPqWdVcsTyZysI0oooPVYqj80Vzk+Zaht1IDfPFsF765gmMpvsGMgE2cZJx2Ew859SiBRcKxYd2Q+aU2mmD+2NCjkW4gU8Wqen82gzGZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AWbAHH2V; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWbAHH2V"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68c32f3c6d6so5722319a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015487; x=1781620287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSy6i0DRlOr9w5Y09gyckl4fi8MxME+0ZH/anot9Owo=;
        b=AWbAHH2VX1MYTL+0G9ic8LszXaydbRcUoWM78FAJqc4MLIlBxg+yqpuk7/xvNy2KDt
         6C4DgOReeJZW/oFptV1DSOGgJtlzegihjfrOa5QDjipHtffNpcz/7Uuy0KJCnDfELmyR
         IEh7oqMvDK7DiPjwcMs5EoC2mDgbBur4czhxNDm7lxFfI1RMHrM6iOHgvQBqkcX6YbYT
         0ffj+xX+CVaMXGihzcqP/0fNJrz+DqoPeCKCRtSKUbiA6pe8vS+2m+Diig0roezTt6Hi
         W1pJ7SFieg8v9Jvp7tCTsx09hT5NquvHus3YRACoTV+uuR+DyX5cYsyBNp83bWqh33HB
         7RcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015487; x=1781620287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bSy6i0DRlOr9w5Y09gyckl4fi8MxME+0ZH/anot9Owo=;
        b=Gh9JSW/yEAO6fhnrW2Ltp5sto0CbtaoOZi2aCadF+XCoiuH2uwb7IjXAWiYkznxB4Q
         l7vstKo7D7Ni7Lu37JTpBVFmmut4E/zKUhLp5RcoZNASs8+ymH0W1Eu8SBBuiPvNrAuG
         Uwgjf9XNsIVXMAkdkkkuTOJJUH0Kw7QvDXICR0ThoI+duJmG/ZFeawyHChbgcA8YH7jd
         Q5KoKrzCXLPrSoU7wIYMCn+6UFYcqtH9lLw5QJe7zP627+tnxnkSnux8zEahWotTdQzl
         F4EVzZlcwL6Oselqui8Z5ahkQ2sOnkAOXIrgPQg4WLu9+HnQPW+rGRPF9uyZDGKCYWei
         igHA==
X-Forwarded-Encrypted: i=1; AFNElJ8pc6jHJp9MGpFnZboKNaCJtJFcKb84RdxUGEdaNZt7dvgEr7xGdeG6BP8zH2D6eD8x1aRfkp4xG4Nm1crlgQx5@vger.kernel.org
X-Gm-Message-State: AOJu0YwLDnFgM/QmMWSVwLuK8vCiN8HDI00+6I6H4Ny+ObhGBsEMdcep
	u3/sKTSuKIyKdQO36msPdcs1qYUXXLoZlmNgEDH7IECPAdT4bDXs+Ppe45BMRqCx7eA=
X-Gm-Gg: Acq92OGL3KtGaXaJ6+FAf6w7ODaHIzQy5T9ic8z385UweVetwvd0FriLqZ7uZzu3RHl
	xU4aNQHcTxzXkccHnwYE4QtZaHmZyQkzPspvd7BtQpLGzO1BuefhlGx3ok+0+A7x4B5reRFmKXU
	HMd4NkDXcd4M66Cs5PXuhGkximwN1eNdWTD0Tu05B6Sh9Gg/Blj46+ooB8J5Ub+3VvMYIRKClc8
	Hkc0qNTNoM3hYFqdbLYZ99XAdAVxC5S1kgp+dVAV9DynJ5CH6+wY9+SchqpGSjd868UUqfr1fHv
	X1wY2IaBsMxO0VbAkGa1V2iRzYiCt0HmdkdcMGgG2idhm1F5rQla2zIuS3gUTlXD0vGs1wvxjgA
	7shxeZ4K7odQYmqf5tZ+/IicxmjWjAvQczEVVJAGoPGcSlFpU1jPRHahsNGISdAKWlc7mKXoo6A
	WwTdKRTRNcSaEY4RWfqJDPWnEEOoWHAIxMg5DAy+ZEKarixVk4xRtDJg==
X-Received: by 2002:a05:6402:845:b0:68d:4450:d21 with SMTP id 4fb4d7f45d1cf-68fa4e1bc89mr9424533a12.8.1781015486790;
        Tue, 09 Jun 2026 07:31:26 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:25 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:31:00 +0100
Subject: [PATCH v4 07/19] perf test cs-etm: Remove asm_pure_loop test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-7-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
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

