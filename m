Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B75C284B4C
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511042; cv=none; b=qdkF2K3y6ipeCiQbtfQdw6rP8CsI4jAVXlhNSBUiHblnKeZFQV6GzeVlaZFDxNnh3IQOjSrZa2QifXqrzIJxSpuelAJVY774hXRG05QfhQEoaM8Rv/yEmT0Iubh/An6z+aq9dgHgmZ9Czzf2YGXAWrWMS/PL1bsjpNsmfFjb+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511042; c=relaxed/simple;
	bh=PVnwbE6gLLGh12OScUU9cLIZPNCEuIOX/UvoSZfZJpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+KnvqeDgTfsqttoHfZlAwQ1X9EHH9BRSAs0I7FZ5Xf1BrkAZE4+KeqFNP9NCBhHfhbofBJKrmQrzerz54+xXuCEmISOGkpk7h+VZX3CPllnxgydGBB/APTNn6G5gLxxspz/HIgJPp8oMX9lM6ksImmOmFLGOt96fOQdwyZbppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lNk7Jbhv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNk7Jbhv"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso42798445e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757511039; x=1758115839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4FHAHnzfXCBUqHTlXFdb8ZtCYn5mJo7RSwkcTXI0IA=;
        b=lNk7JbhvhtszYQgTYUlG6j3EgOgwoXAMWzMppBBf3emvn/6ASW73GBalcVavaVUF/+
         EWKkmjjMwbGsb+IgMZ8SQ/CyY9ur5cRYFlHQ3Ye3dNSpK9zrOuTN4uq+fTS+Cn7hpqih
         h9GmefJOCI4iAAjxiFTFUFz2uBx+0Y4RDGB+iaSSHYHuWlMvCmgPAK8NU5lWZRb1UBmn
         m0OwVUiJPmMVsMz0uXaSN7XjtOqT7pjZLIJXzx1OWVR2gjdejhklV4G5BWocy1aJSqFt
         yNoBhvwmq5jCh5Ixc4gkt/wjXXC06RXymSfJ3JMVAG4XwhXF7W87dN1zsuL+z47DuRRW
         ZU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757511039; x=1758115839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4FHAHnzfXCBUqHTlXFdb8ZtCYn5mJo7RSwkcTXI0IA=;
        b=mnVE8BzWeBl9ldlveOAx7gz4piURXlE8fB0RS9ar2AKE3sbUzBkOmxIgQ2zQrji/7O
         TpGr4ETW5jTS2+48tYAz4wuh5hi4okASTOyoI3lyC3IQyb5KhAAvZKRwUZhSP/LaAFty
         D05E7A9Zk8NTTb/11heKdaBGrzq59dHUhdjZ8OjBWur6GTJmwt5f578azTjHFvWrHtrq
         6WcvPB7/obmbRNTUx6TxAxUN1rkHHHAoo7uNWM/EOvARwQ7UrBUrpdwQe55E+e3KEW9i
         nYpiOkqHht6eN/nE9Sq9lf4aqTj8Hn/flOl1QEinhW/4gMbwpVNj1cR3ksG4vVv/wLmd
         yC9g==
X-Forwarded-Encrypted: i=1; AJvYcCVo1yp2khJ0NpN8r2o07L7pc9YnyHhjPPRt+bPdztH7n5ypyP34R3Q+DpNLzT2Lv19vu1DaBLiPq/rnSTOTdPqR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9srAaBN7EQQBpzCTb+cSCWrGIBdxfRWhRwgVSiG6C1c5iOBGQ
	IPN1SMBEIDUUJqWZzfMqdU7+VaLlMMBNauY9CruvPPqT5/ZPOIPThi8AdzR9i4eolkQ=
X-Gm-Gg: ASbGncvZQA320K8oiiEkInYEPeFywGlpAbQt8ccZkPCFAU+OBIl1FjSyvK9sTI3yI4b
	kGlLJpoglV4MJOw9gR/6+ZuF7Ma5PxyWDRXmOewJq0q0gs4mc1XuSzcZlp9QGOThepqF4SiBUW+
	p63DF/DnkudABVICA9Zd3/hNp+W62NEfjw1wrjJs0cbKOrLewnkzDag3OZiHpf05t9M+mhRO6DH
	hrMbpfjQpPMA7BFOwgxDx3+BH4dHzxBHGNbfwLSIBtzcoKJn4+xNzXJubuOMUDHuVbDH6UuxoPo
	/Pv/vGqzIYhZzHzf5i6RLfRFU5oK0lzJQI544SJiPiY4ZW6kKxlCHZK29VQJCXc3BtQkozAlvP3
	vnSE+sWNq7BakZRiolKavqMCH25KjeprOqqPNUfF/9w==
X-Google-Smtp-Source: AGHT+IGbW9nuEQquGFBk6D25fa0JMrDH8WQ0jztEhqtb+20/B62tKDDcVkTJj3xKuK4iohaBIXg7pg==
X-Received: by 2002:a05:600c:468e:b0:45d:da4a:8dd0 with SMTP id 5b1f17b1804b1-45de6b386abmr89000025e9.27.1757511039212;
        Wed, 10 Sep 2025 06:30:39 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df16070bdsm30387015e9.3.2025.09.10.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:30:38 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 10 Sep 2025 14:30:11 +0100
Subject: [PATCH 1/2] tools headers: Remove unused kvm_perf.h copies
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-james-tools-header-cleanup-v1-1-7ae4bedc99e0@linaro.org>
References: <20250910-james-tools-header-cleanup-v1-0-7ae4bedc99e0@linaro.org>
In-Reply-To: <20250910-james-tools-header-cleanup-v1-0-7ae4bedc99e0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

These have been unused since commit 162607ea20fa ("perf kvm/{x86,s390}:
Remove dependency on uapi/kvm_perf.h") in favour of dynamic discovery.
Remove the unused headers to reduce consistency checking overhead and
noise.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/arch/s390/include/uapi/asm/kvm_perf.h | 22 ----------------------
 tools/arch/x86/include/uapi/asm/kvm_perf.h  | 17 -----------------
 tools/perf/check-headers.sh                 |  2 --
 3 files changed, 41 deletions(-)

diff --git a/tools/arch/s390/include/uapi/asm/kvm_perf.h b/tools/arch/s390/include/uapi/asm/kvm_perf.h
deleted file mode 100644
index 84606b8cc49e4..0000000000000
--- a/tools/arch/s390/include/uapi/asm/kvm_perf.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Definitions for perf-kvm on s390
- *
- * Copyright 2014 IBM Corp.
- * Author(s): Alexander Yarygin <yarygin@linux.vnet.ibm.com>
- */
-
-#ifndef __LINUX_KVM_PERF_S390_H
-#define __LINUX_KVM_PERF_S390_H
-
-#include <asm/sie.h>
-
-#define DECODE_STR_LEN 40
-
-#define VCPU_ID "id"
-
-#define KVM_ENTRY_TRACE "kvm:kvm_s390_sie_enter"
-#define KVM_EXIT_TRACE "kvm:kvm_s390_sie_exit"
-#define KVM_EXIT_REASON "icptcode"
-
-#endif
diff --git a/tools/arch/x86/include/uapi/asm/kvm_perf.h b/tools/arch/x86/include/uapi/asm/kvm_perf.h
deleted file mode 100644
index 125cf5cdf6c5f..0000000000000
--- a/tools/arch/x86/include/uapi/asm/kvm_perf.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_X86_KVM_PERF_H
-#define _ASM_X86_KVM_PERF_H
-
-#include <asm/svm.h>
-#include <asm/vmx.h>
-#include <asm/kvm.h>
-
-#define DECODE_STR_LEN 20
-
-#define VCPU_ID "vcpu_id"
-
-#define KVM_ENTRY_TRACE "kvm:kvm_entry"
-#define KVM_EXIT_TRACE "kvm:kvm_exit"
-#define KVM_EXIT_REASON "exit_reason"
-
-#endif /* _ASM_X86_KVM_PERF_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index be519c433ce47..6eacc02fbb1b3 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -40,13 +40,11 @@ declare -a FILES=(
   "arch/s390/include/uapi/asm/perf_regs.h"
   "arch/x86/include/uapi/asm/perf_regs.h"
   "arch/x86/include/uapi/asm/kvm.h"
-  "arch/x86/include/uapi/asm/kvm_perf.h"
   "arch/x86/include/uapi/asm/svm.h"
   "arch/x86/include/uapi/asm/unistd.h"
   "arch/x86/include/uapi/asm/vmx.h"
   "arch/powerpc/include/uapi/asm/kvm.h"
   "arch/s390/include/uapi/asm/kvm.h"
-  "arch/s390/include/uapi/asm/kvm_perf.h"
   "arch/s390/include/uapi/asm/sie.h"
   "arch/arm/include/uapi/asm/kvm.h"
   "arch/arm64/include/uapi/asm/kvm.h"

-- 
2.34.1

