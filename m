Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E323F9287
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413980; cv=none; b=ijcY32VJ7dPF9jzC3R5cqqaaqV+hNsV4EZnKr9xRqIg2GhkNJONYhBfvR+UvFaLmpMEhy/sy7D1duEGnCQugvSmRavlN6mU2FKafxji2ntkuAqt7g3c02R5KC81z40haGjVoMoCpRFISCYuIVkRpQ6CHnIT932dpWof0AGTPnUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413980; c=relaxed/simple;
	bh=WPG8dPv9TK2SdNtl17T4gx5NaWiw3DgHmq0K8beS3Jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XLMBuu7h8Tcwi1kFLWskI8r/txjRtPYam6dkha7HNK6G2OzolHJ9FyIx4yOo0/sOz4dQXR4kmR/xpt3Wu1xSRL4OvG3wfkQq8hMe8Wl0ZXKja5oKa1P3YRd/2Gd8aeg4RIIOlEsrGb4OGMdRZEGdvExLQj0puqMdAnaAYVHkctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIb5BiMK; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIb5BiMK"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304b8d0ee63so9674837eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413977; x=1781018777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a++q+Cspvy+lo3emUzDENGkW1idP9N7NULAFivLQywA=;
        b=vIb5BiMK4bcVFBatmIj5bh0MraYz0F+Md9NOPhrr9TYuQQbAEWGhvZseRXBYlg5Bm5
         wxF0vj7kUDV56HegRYe9rCxUthWT2SJ+YPp+WQ5122dCeUnQtZfzNr/0lbCKxFBN7pB0
         SK7krd99O5RobleoXp9PPxeMg3bwyqJWQbNpa6+btBwTQkcRVlIPo7GAhHJKHXZNuqjQ
         VIPPQ2rcyj8HKaz9dHToAa3OEYdh46PSPy/8q3xSs+1Lk+gGISAVbVOako4ZKD1gwSOv
         WJHMmkDj5eeO1YA8UzrL0Zja+BaVzLASVl7VFNEcRf3LOCc4K8Ssykgu6uw89IccXPtR
         FwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413977; x=1781018777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a++q+Cspvy+lo3emUzDENGkW1idP9N7NULAFivLQywA=;
        b=sHs7DlErWZU1d/LBAeAd8B+cWSf9AMaTNtJYRtxkb80GKOW9YjU1wI3h4AJ1Y1Ix1r
         b6bN4yfWY1BQcsA6zCJrvRMLJn9VCBO1KzrQwEXGYzXxh/HkV0sgPxJ6R3FpbXPXHinY
         f/elNjFE+W7YAeW6Pe5kB+p9CCd1oiJgKedfOmHVOCeaoGwKc/17noc6jWzRiS/zHrhI
         h79L/AL9bAp6QkcaEh0iM9glq3xVkYHxQ+4aDnCyhnEw7/TKxh6u//1y1FSXwKXy/z3y
         xPrOsCkFGVsgPzhnk8lLLbgJM7VbKAVs4kjIOReOMFXSTS8DbZAOiCJOM94840kHcYVC
         XK4w==
X-Forwarded-Encrypted: i=1; AFNElJ+iYuf0xikE+dG8CZGwqq7U65HAF8MbCPnqntRuuAqYuf6PfwgYeSOj4I4dM32iQ2oUw0nXkFpN1BAKy59pKDcU@vger.kernel.org
X-Gm-Message-State: AOJu0YzwEQ+Mkvn/arzT1mD3XxF6OPYhnOapWkbK3/6mvUpADWcrvI2H
	NQhe0P5t+gxPw4mgji37jWitKK9gS4kau3mZH+MKdA5j6sKrhCKkcAThbFjkclStHxO3njF2U2m
	i9Kd8ybHRiA==
X-Received: from dybpi11.prod.google.com ([2002:a05:7301:420b:b0:304:de31:a7b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4312:b0:2ce:25be:c8e8
 with SMTP id 5a478bee46e88-304fa5a8b1amr8918813eec.17.1780413976931; Tue, 02
 Jun 2026 08:26:16 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:13 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-17-irogers@google.com>
Subject: [PATCH v12 16/19] perf env: Add mutex to protect lazy environment initialization
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Introduce a mutex to 'struct perf_env' to safely protect lazy
metadata setup, such as os_release or e_machine resolution,
preventing concurrent initialization data races and memory leaks
during multi-threaded profiling or symbol loading.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c | 5 +++++
 tools/perf/util/env.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 28c54c58193e..03d90a45992c 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -250,6 +250,8 @@ void perf_env__exit(struct perf_env *env)
 {
 	int i, j;
 
+	mutex_destroy(&env->lock);
+
 	perf_env__purge_bpf(env);
 	perf_env__purge_cgroups(env);
 	zfree(&env->hostname);
@@ -307,6 +309,7 @@ void perf_env__init(struct perf_env *env)
 	init_rwsem(&env->bpf_progs.lock);
 #endif
 	env->kernel_is_64_bit = -1;
+	mutex_init(&env->lock);
 }
 
 static void perf_env__init_kernel_mode(struct perf_env *env)
@@ -1014,6 +1017,7 @@ bool x86__is_amd_cpu(void)
 	struct perf_env env = { .total_mem = 0, };
 	bool is_amd;
 
+	perf_env__init(&env);
 	perf_env__cpuid(&env);
 	is_amd = perf_env__is_x86_amd_cpu(&env);
 	perf_env__exit(&env);
@@ -1036,6 +1040,7 @@ bool x86__is_intel_cpu(void)
 	struct perf_env env = { .total_mem = 0, };
 	bool is_intel;
 
+	perf_env__init(&env);
 	perf_env__cpuid(&env);
 	is_intel = perf_env__is_x86_intel_cpu(&env);
 	perf_env__exit(&env);
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 83e74328798f..6aaf80c640bd 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -6,6 +6,7 @@
 #include <linux/rbtree.h>
 #include "cpumap.h"
 #include "rwsem.h"
+#include "mutex.h"
 
 struct perf_cpu_map;
 
@@ -156,6 +157,8 @@ struct perf_env {
 		 */
 		bool	enabled;
 	} clock;
+	/* Protects lazy environment initialization (e.g. os_release, e_machine). */
+	struct mutex		lock;
 };
 
 enum perf_compress_type {
-- 
2.54.0.929.g9b7fa37559-goog

