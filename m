Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D43F1B2EF2
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319776; cv=none; b=qWcXHXJbb2Z56KF8zfOA9PQY6o/aRb5JqgB/dA/tr3nSAkhi0bJXSXplnZKyLc6dQg5VTegASGcCFF1BELatbwwFXfK0U13nsYwjBsTldLbU4aZ3vRQJyykvBLSsVaqga/zgcT1Hb/vvmljABtac2oXg8ukOIiEEEYq6OWOSyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319776; c=relaxed/simple;
	bh=Bz4LxCTa33wqCDdtx6TZatScOlU8dCwKfQWgH27/7Fk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ANKPGil8WHuSNs9whqDojyQ+rtSIPJxEs1f1avnMNujHa6SG6iZ3orHPivtUnm2TbBp6TXQeQhB6L/7yXXfyVx63hXCfLVhL782AqGNHQ2r+so/c4RaYIJib6Y5G9j1hvfRpHEqaAT+O4NXmAFZb72CKRSv6uUMQfg0rQct76Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8zuRIcU; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8zuRIcU"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d40c0c728aso13836351a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 23:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736319772; x=1736924572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WzUTEwuJeYcSf17eDpB5yV1DZfs91R/xpM+4/0WQ8Yk=;
        b=b8zuRIcU0knnxxrhS8Qqk1C5nbIMaHppIiRsJMuhmH3GnZpVgpcKwWbZoEMnQNtATX
         amfzMnFNoUTt9XrPGimL4bMCSUR+WMDB9tOipKGzA2iTw5DEO79isKf84ITySv2WCs+r
         10ANxmaFpGZFJi+OvgSV4wMIXD0yVYNDmyo5EPyAQLd2gy6k64iQLxGuTV1qlIBVBTOQ
         bF1sfBuRN1mjwRgnob9M5ODmw4gKxlYoK+lBhxXZucxbt8OWSzoLrsl/27YqrgAahrGi
         /KMLtNJn7SOHRFtlF0uDQNEOlhJOwnSjQnOu+te+OnU9oRyOfTOYveg4qRZcGAlJuL6z
         ZeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319772; x=1736924572;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzUTEwuJeYcSf17eDpB5yV1DZfs91R/xpM+4/0WQ8Yk=;
        b=QKjuX5LajzhhzW7zdMso1mzTA/XrcEXzkxHcZujjURnIDZHYP/WgvlDktFmwwMM+u0
         KZ0jdByGYLOfPO0Sl5BNBbVdEIdNLddlWU3hTFsQ9ZMRmApZ0UchVoPcMgOskrLeLToN
         BjU0lLW2IlfsejTK9DclWasXmrtenPxyXHp3XpGeYmwaUeIUKcZvIQlHeMhMbB48FiSx
         YTnx4ft6MmkljaKZVQ4gLUIEajh08h5UHcbBxii79xSBmf6oXMuFxJ3POW5qK/MuQ0Je
         qznnC6t8CEShhAIC6mzaKSV3SrGBMsPVFd6K2DeON4T8du7uAONuXwSBcJClG+qoztr/
         Eb6w==
X-Forwarded-Encrypted: i=1; AJvYcCXtEY8VxpNGAKgjRPm1nLIVKgdlubHoox+hWX1gdZl/zZxwWe7FJnceS7a2uHBYo6cY0UjsYq8svaKMrwnfCt6A@vger.kernel.org
X-Gm-Message-State: AOJu0YzkADLKHbBJVnyJrTDPCwKNietKFCEP71ybOiAFkq3x0Rcm6tc5
	sxrz0luVAssFGf1pGyDNmkfxVmH8g/EopOs3iPnW6d65tC8n71289Vwr7s+K1r1q8Z+fC1zaOib
	IztUxjQ==
X-Google-Smtp-Source: AGHT+IGpVXPxb1zkPS6SYz3yM+kJAR6DtzfXEyx9zNlFwzyaai+MJYu2JZANZwLpJf9IDnJ29XWlAwvFX9Vb
X-Received: from edben19.prod.google.com ([2002:a05:6402:5293:b0:5cf:bdb9:fa82])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:26c5:b0:5d0:d491:2d5e
 with SMTP id 4fb4d7f45d1cf-5d972dfff55mr3625307a12.7.1736319772118; Tue, 07
 Jan 2025 23:02:52 -0800 (PST)
Date: Wed,  8 Jan 2025 08:02:28 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108070248.237943-1-dvyukov@google.com>
Subject: [PATCH] perf llvm-add2line: Remove unused include
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove unused symbol_conf.h include.
First, it's just unused. Second, it's problematic since this is a C++ file,
and most perf headers don't compile as C++. So if any other includes are
added to symbol_conf.h, it may break the build.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/util/llvm-c-helpers.cpp | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-helpers.cpp
index 663bcaba2041f..004081bd12c9c 100644
--- a/tools/perf/util/llvm-c-helpers.cpp
+++ b/tools/perf/util/llvm-c-helpers.cpp
@@ -18,7 +18,6 @@
 extern "C" {
 #include <linux/zalloc.h>
 }
-#include "symbol_conf.h"
 #include "llvm-c-helpers.h"
 
 extern "C"

base-commit: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780
-- 
2.47.1.613.gc27f4b7a9f-goog

