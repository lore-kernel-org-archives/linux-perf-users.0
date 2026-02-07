Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D30B30C630
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770452696; cv=none; b=H1+RGQboh21k+ve2Yhu11iPLX2+XmZY41QR6Vpln8/D1A+Iq85+GfWgGj1t4toBXqRPsQ2im5AqfaQ5tpF2wEZaGOVqyCQk67PXLnKmS8PWbjS4QCPBpwKegFFrScIZI25HnZWr0bZ6LIKxkKxhueMEL4fLqdAePmAONC6NW3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770452696; c=relaxed/simple;
	bh=KhN5T8AvFwLNeLAg0jkMyMS0WBRDSb5XoSOUV7V9Q9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kXHtRCe/qnZrFUyB+2Unm79zmyTOzfJ6yQxQvwZQMsY9ySomjCp3DfU/iZ1fVUaRKogbsbif5gnT1+xf9HX2B0byzpLCRWQ9pnh5+HJzt1appw+35fPhkww3PnEgtEcn38WW6/IKm+t/NMycqx64KL8Ct5J0oheWTRiC70qcAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YKy4Pnyx; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YKy4Pnyx"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1270be4d176so8203393c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Feb 2026 00:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770452695; x=1771057495; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5hwRlpZOru3mHo0xtBCmuQo2bn4Bp/qBvnWBCSLokM=;
        b=YKy4PnyxuZp118gNXEQ4B5CjjqbNMtcW3TC1L9xTNNBR7i3FNYVGnYlxXzBh0gmt10
         NYnoYdzMUimG+iFUXbR9gjI8vxAgT/e6CLeptj7+Ee37iNmxovHx6r/9HFOq0ALcerCx
         q2BD2BHOG4OJPCvnOcHXrhcG/c+eJxsUpg9Skd+EcKbD+77tE5bpnll4FBE0pkLiskPo
         L2ovATZLuVUFxEvIl5Ch4mnT409GRFkudHp+qOksUXGIFU5a9RSkmNzxQOELk1cCVGZM
         ShG6HRWOeE39RxR7LbMkBPPcSD8ZSCeNhFqk6uGYBH88xqlzV4B8HSkyDYrZZ5Zw6mwY
         wJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770452695; x=1771057495;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5hwRlpZOru3mHo0xtBCmuQo2bn4Bp/qBvnWBCSLokM=;
        b=lkd1DE/Ge8HWIqxH7ylddopLObCMTKsOp83ZU6ACeoL9uuquoiHhcXio2ghegVsgeN
         zW1T8p/vsQxHJZsPQi3FDmt8ly5aPGVg4djW1Pt+SDC8NzCfpnTGljYu0dHnPrhudDmE
         V97c/DUz6nMvfpqW3twFxkYwhs401t8GpoL1VkC2WUzH27RQLo4bRMgZYGHAH1dIzu6V
         J13xEcY+GzSDkgLSr25Na/aq1de/QaRuruNFiRvr9gQxxFsH82h4z9atw8OgrAINA0IR
         Ckq2bs/z/viQSwAZEcCzEuuHG3/JnDh6nJGpIOKM93iu0BN5QEerAf2hIlZAlnY92clw
         /l4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGCEG/7bd9UcEm23iv1cpYbb0sEJ+Y+vMYdKC+VOAYeE63ebYLYv2WMzZYEjTz67IBRRcA7p41+tw34I6yOamF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8aFW2nhDpPwYkQ9r/bkOsRKE/CWK5yL5ivGlUSWXZqbsznUVD
	4MuuC/Ab/X1KNGl0wYA4y2vjbOPJL+NC0l7a6bq74Rnk/oxmqfivWFt+luOuhFE768GeBNx/VBO
	RFSQYPp4zIw==
X-Received: from dlbpk3.prod.google.com ([2002:a05:7022:3843:b0:11b:d8a1:4048])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:629e:b0:11b:c1fb:896
 with SMTP id a92af1059eb24-12703fd8ea6mr3245953c88.4.1770452695218; Sat, 07
 Feb 2026 00:24:55 -0800 (PST)
Date: Sat,  7 Feb 2026 00:24:28 -0800
In-Reply-To: <20260207082428.1742209-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207082428.1742209-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260207082428.1742209-6-irogers@google.com>
Subject: [PATCH v1 5/5] perf record: Remove unused cpu-set-sched.h
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Eric Biggers <ebiggers@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Header file declares unused macros, so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c     |  1 -
 tools/perf/util/cpu-set-sched.h | 50 ---------------------------------
 2 files changed, 51 deletions(-)
 delete mode 100644 tools/perf/util/cpu-set-sched.h

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 60d764068302..40917a0be238 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -40,7 +40,6 @@
 #include "util/perf_api_probe.h"
 #include "util/trigger.h"
 #include "util/perf-hooks.h"
-#include "util/cpu-set-sched.h"
 #include "util/synthetic-events.h"
 #include "util/time-utils.h"
 #include "util/units.h"
diff --git a/tools/perf/util/cpu-set-sched.h b/tools/perf/util/cpu-set-sched.h
deleted file mode 100644
index 8cf4e40d322a..000000000000
--- a/tools/perf/util/cpu-set-sched.h
+++ /dev/null
@@ -1,50 +0,0 @@
-// SPDX-License-Identifier: LGPL-2.1
-// Definitions taken from glibc for use with older systems, same licensing.
-#ifndef _CPU_SET_SCHED_PERF_H
-#define _CPU_SET_SCHED_PERF_H
-
-#include <features.h>
-#include <sched.h>
-
-#ifndef CPU_EQUAL
-#ifndef __CPU_EQUAL_S
-#if __GNUC_PREREQ (2, 91)
-# define __CPU_EQUAL_S(setsize, cpusetp1, cpusetp2) \
-  (__builtin_memcmp (cpusetp1, cpusetp2, setsize) == 0)
-#else
-# define __CPU_EQUAL_S(setsize, cpusetp1, cpusetp2) \
-  (__extension__							      \
-   ({ const __cpu_mask *__arr1 = (cpusetp1)->__bits;			      \
-      const __cpu_mask *__arr2 = (cpusetp2)->__bits;			      \
-      size_t __imax = (setsize) / sizeof (__cpu_mask);			      \
-      size_t __i;							      \
-      for (__i = 0; __i < __imax; ++__i)				      \
-	if (__arr1[__i] != __arr2[__i])					      \
-	  break;							      \
-      __i == __imax; }))
-#endif
-#endif // __CPU_EQUAL_S
-
-#define CPU_EQUAL(cpusetp1, cpusetp2) \
-  __CPU_EQUAL_S (sizeof (cpu_set_t), cpusetp1, cpusetp2)
-#endif // CPU_EQUAL
-
-#ifndef CPU_OR
-#ifndef __CPU_OP_S
-#define __CPU_OP_S(setsize, destset, srcset1, srcset2, op) \
-  (__extension__							      \
-   ({ cpu_set_t *__dest = (destset);					      \
-      const __cpu_mask *__arr1 = (srcset1)->__bits;			      \
-      const __cpu_mask *__arr2 = (srcset2)->__bits;			      \
-      size_t __imax = (setsize) / sizeof (__cpu_mask);			      \
-      size_t __i;							      \
-      for (__i = 0; __i < __imax; ++__i)				      \
-	((__cpu_mask *) __dest->__bits)[__i] = __arr1[__i] op __arr2[__i];    \
-      __dest; }))
-#endif // __CPU_OP_S
-
-#define CPU_OR(destset, srcset1, srcset2) \
-  __CPU_OP_S (sizeof (cpu_set_t), destset, srcset1, srcset2, |)
-#endif // CPU_OR
-
-#endif // _CPU_SET_SCHED_PERF_H
-- 
2.53.0.239.g8d8fc8a987-goog

