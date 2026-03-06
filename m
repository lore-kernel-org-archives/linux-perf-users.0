Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E3B37C11A
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772796302; cv=none; b=JHTZIUwniGwGVtcWMvb7aO6mKu4McfzhZEu9hvoMjNp7wlaxp1p2IEJ0NMVBgoxGLTEUmibgvBi4XfjHhkln0Cct/FXgFZUE9D5ul1KDxmbFGUApJ0XHuqE6Egvz2uEBrhE+6xmJKNJQN8VYH4uVyR3rOkJqbxgY0/O7++VuEvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772796302; c=relaxed/simple;
	bh=gqA+IL+CdvwN/4YaLzVJaTWyek2+LTqX/hZS6kiqEd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=USRUmh6WO7z0/NtcmmUQ+kzTZUGMfEvph5gV06EPpe0xNA5yolIFMkaaq11Zly+XWRPAijblxGovI2r5GJgUiZcx0dNpzXoSyoYfmJPT7sob+P85NFET6QvfKzHyvodoRUyAnIToIUoZekxPIb8ddBcRRKXeXoSOpJRijqn2d+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gaD1Xyqg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gaD1Xyqg"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso84982465e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 03:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772796299; x=1773401099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mMT+D07w7rqjOY120b1nVktQhIrW6vGfucleX/0LgI=;
        b=gaD1Xyqgx+MuBEKG0KE6Q5CuFZOsltE8ZKd0PB0Ol1AYCgxP1awhh3GZlkF53QDk3G
         DAOkE+UzUFrb6+nTVYQdKM0ztGo6AuWazGnZOSgd72KWfPRoEnwpFj2o1b6hAnlPzK53
         rKe+S2vmPXbTns5jLYw8Gtw+e+05ZbTIFM5IAQWQwmjk95BB/OIKKmts+wLo5opdh6HL
         PSS1h/EcRqI7f4s290OUj61xlvWRyYuocNkwtQC4U5ou0tyf6JMobfqYGKiYKzET0euV
         jF3tjyxL32SUZ9wEG7apsAZxUYWTMwjRiKEbTG5rX0CwR5RNUqwpya36WMQNRbi8S9iD
         vACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772796299; x=1773401099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/mMT+D07w7rqjOY120b1nVktQhIrW6vGfucleX/0LgI=;
        b=qpkKqE5FMm3JaamwNNtNKh3ckK8J1bVuopCmL6BqnVqdzuK0boaJR12pZdPcZ7al+2
         U7MVva0aUyWqE8aKGo30hE0FIKe3vjRCAvh4WRsnDV9Fs7Kw1aOopkd1hmX0lo9cKPbJ
         6nBZrUtb9kZhyNdhY7CCByncHOsgFh3jnDwCQ6agrA+Z224mCPSkQ4DNHMhlpoCFD8Sw
         LspQ8/gfTOxMCX3BEotquTVrtRNme0pGibusubeAFFyqh3kzAK/JzBJZKxN8c2BMVFyG
         R4l6CoS8BDClG/eh8Hjd3EXXfQmm6xYhOL5WQBi6l+DjDbfsG1c4Mz6LyItzk31z3VrE
         1Lqw==
X-Forwarded-Encrypted: i=1; AJvYcCWjMaEtX/IaEFM/NEW4Mktms4Xl51mxUvOdFhMPaYoPYuPSK7bVAcwgY9igADUM7tgqmsxHoI+OQtl0qcWjI/OP@vger.kernel.org
X-Gm-Message-State: AOJu0YwNUu/p8ASdCUcRFxHbeBjH58dIdEypmi7d8uejXQb/pta0NOAu
	Tt3mjTjS6bQbXUcoyDXBHuloCU7KoMq2fyYTTvmmEz55J7fekkzbpXGw0yczsL2XJrI=
X-Gm-Gg: ATEYQzzJmne0FT2tEwVvkIfdBDyuc2zPZaM0qWMUyLRG3JJG49mgwFuNvNOlG9CFKMS
	XxlpOGgPJDv6feRLATRJMBc5Ne8XNLdrPEMrRdTp3r0oboB1GsMqrIMXJ1koaWYRLSccz2BdaSZ
	7iB1Dvo4M6GyXvw6kgAIwaNv8JqdmgCruR/Cf5FTXbc4GBtY/+aFlmJafqrLk5Un5La8r4XxG2j
	hRJHvdLasm6PsI2UbgjVlC6xTixPNYmgAAfAOtxeNCf9bfBzglEp/I/rcqxe3sK96fOIsOaNNi9
	CSyQeABUnawnBw2rak7Jnf95wswSrYj/Z1pCcDX/9q51534M0Qd+bTV3gose86RezrZntjU0FBJ
	mqtHnR/MU0MwoUbRqxeR3burCiUQpzAstkepd60YsjupGttJ/Zh9j50rUftmGOFpohqhgLqaQzq
	8nCZErI8wSjY2DISr8DvwEmLZ0sMjcBj+3
X-Received: by 2002:a05:600c:a12:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-485269648fcmr24117915e9.23.1772796298595;
        Fri, 06 Mar 2026 03:24:58 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527681a3esm66542245e9.4.2026.03.06.03.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 03:24:58 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 06 Mar 2026 11:24:46 +0000
Subject: [PATCH 2/2] tools: Sync coresight-pmu.h header
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-james-perf-remove-etm_opt-v1-2-03c662380361@linaro.org>
References: <20260306-james-perf-remove-etm_opt-v1-0-03c662380361@linaro.org>
In-Reply-To: <20260306-james-perf-remove-etm_opt-v1-0-03c662380361@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Update the header to pull in the changes from commit 3285c471d0c0
("coresight: Remove misleading definitions").

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/include/linux/coresight-pmu.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 89b0ac0014b0..2e179abe472a 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -21,30 +21,6 @@
  */
 #define CORESIGHT_LEGACY_CPU_TRACE_ID(cpu)  (0x10 + (cpu * 2))
 
-/*
- * Below are the definition of bit offsets for perf option, and works as
- * arbitrary values for all ETM versions.
- *
- * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
- * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
- * directly use below macros as config bits.
- */
-#define ETM_OPT_BRANCH_BROADCAST 8
-#define ETM_OPT_CYCACC		12
-#define ETM_OPT_CTXTID		14
-#define ETM_OPT_CTXTID2		15
-#define ETM_OPT_TS		28
-#define ETM_OPT_RETSTK		29
-
-/* ETMv4 CONFIGR programming bits for the ETM OPTs */
-#define ETM4_CFG_BIT_BB         3
-#define ETM4_CFG_BIT_CYCACC	4
-#define ETM4_CFG_BIT_CTXTID	6
-#define ETM4_CFG_BIT_VMID	7
-#define ETM4_CFG_BIT_TS		11
-#define ETM4_CFG_BIT_RETSTK	12
-#define ETM4_CFG_BIT_VMID_OPT	15
-
 /*
  * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
  * Used to associate a CPU with the CoreSight Trace ID.

-- 
2.34.1

