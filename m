Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6209524AE5
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766389; cv=none; b=upYVPS1fuHXoTa/wUr8zfmFkjqftDw0/7fGr7FWKRoOW4RD8/zX7DGRAUw5De3REvtnr+GqoZbPutDGESb8jlIA4yb4MBYca40o1LjbJT23OdrsFlGGjxszNS+TueBloorPhk2uI4iIizbEtDt5G32fxfyg6rODMFF3F3CFgxJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766389; c=relaxed/simple;
	bh=Bl7p5fPq1zzv8earO2MgxKfTQKk3Ks5v1cj5G/bckVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RuSGopX85dKH+TaQySqotU2tkdTuCROT7t9Qc+uzAIq6Gv/XNwLcHvTM/zx36uBZyYRG4Xq5aCwqLQzhwoMGmV1vCm90WSyKc72ueLtMrX0ujg/RsX28uycLSKbBgQsnOqP553Hpexr++/7X9V/0bgFCgdqhQrSxifXNCe6Ohx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p4bBk+GQ; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4bBk+GQ"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso1628884a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789766386; x=1790371186; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q198WRfVuFdwy23wGpDOJAEDHlwObTAenaQ9DfUue+I=;
        b=p4bBk+GQXz8+40B3xQ7ywYnp376nYIN/jJYpMclPYueuHMJk1Uf3AkzPj1OgjU8MX0
         qRgLwViCC7y9pRmx/5r/L5KBiddEClU67X7wp5+cKkA6xyw8VM/k99rsSApuHZexqq3V
         3g6a0/CMkfMIjgobWjFTcTgSdTS8exAFjiHI8CetLhW8bis3zBnLv8xkPHtAKMdTZvqj
         uS8LGrPTJj8W4PL/9WsRFzM/LFD30WCZSeDUASDsBjLMRDfyglxwHVfIDNCGx0vm/gJO
         vxIgPJLM/MStvneQTHFb4sMLrnxg31NYRGAsUGMs7hMn8yYhBblzPcqnAffRZ7OLvC7O
         3jkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789766386; x=1790371186;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q198WRfVuFdwy23wGpDOJAEDHlwObTAenaQ9DfUue+I=;
        b=M10jv+gjGM/1tYiUWzRtmcqTKxo3zAqfETne71tJTUZoZrVxnBy+96BIozPfzWG0u0
         ZZ/UJem5BitYhr9idLfw7zbpVkpj7lmm4b0vNT78IHwYMTv1eI273d56x4X4f6GgjYKd
         yMM6wvTT9YHr8Kej4hvB9Pp5dNUBnToZMC+B1d4YkvG3KGhAFYmfff4eJdr7eGKsLasw
         x5cwfLwztdQzmQ1qTyq24fET50aigSCrzq6TxVfus2TyzJqcvlcx2DJ6DEhnvLGwkW6f
         pQKwfXFBf+7+3yvM1eBzG0zbN+/nT5NVxbJide86uyLOoryUtyAhP/PKqaKNJauFvlFw
         Mzew==
X-Forwarded-Encrypted: i=1; AKwUvBwiGRTIWGCdSBR9KyutcaPN+3VHCkK2XTKqWQgYvacHf8qmerUNYwu6/O1mHIQLEZyVOuoU+pqnZDAyj3Go/25S@vger.kernel.org
X-Gm-Message-State: AFuF++krDKelUE/RuuwnFGvgMLhrFmU0dqyxz9nVxGL4/fn9uPzDUQS0
	RlLsrafrekwXvi9RdfrA2fU6CUUNWKEsh//cIdvTfHNbH/MDgc6/Ie7Nbz9MNIcRz77y9Wf03Dg
	U5nHX8uKuvQ==
X-Received: from dlbqq10.prod.google.com ([2002:a05:7022:ed0a:b0:143:7c9b:184f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ecb:b0:39e:31ec:ba55
 with SMTP id 98e67ed59e1d1-39e54d36b09mr8589531a91.7.1789766386140; Fri, 18
 Sep 2026 14:19:46 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:19:15 -0700
In-Reply-To: <20260918211932.2966061-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918140659.2501976-1-irogers@google.com> <20260918211932.2966061-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918211932.2966061-2-irogers@google.com>
Subject: [PATCH v4 01/18] perf trace: Include the headers declaring pid_t,
 strcmp and assert
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

trace_augment.h uses pid_t in the augmented_syscalls__set_filter_pids()
prototype and in the !HAVE_BPF_SKEL stub. bpf_trace_augment.c calls
strcmp() in augmented_syscalls__find_by_title() and assert() in
augmented_syscalls__create_bpf_output(), but neither pulls in the header
that declares what it uses. Both happen to build today only because
something else in the include chain drags <sys/types.h>, <string.h> and
<assert.h> in first, which is not guaranteed and does not hold on libcs
such as musl that keep the POSIX namespaces strictly separated.

Include <sys/types.h>, <string.h> and <assert.h> explicitly.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_trace_augment.c | 2 ++
 tools/perf/util/trace_augment.h     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
index a9cf2a77ded1..ebb26225fb04 100644
--- a/tools/perf/util/bpf_trace_augment.c
+++ b/tools/perf/util/bpf_trace_augment.c
@@ -1,5 +1,7 @@
+#include <assert.h>
 #include <bpf/libbpf.h>
 #include <internal/xyarray.h>
+#include <string.h>
 
 #include "bpf_skel/augmented_raw_syscalls.skel.h"
 #include "debug.h"
diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_augment.h
index 4f729bc67753..a1cd9a5e0213 100644
--- a/tools/perf/util/trace_augment.h
+++ b/tools/perf/util/trace_augment.h
@@ -2,6 +2,7 @@
 #define TRACE_AUGMENT_H
 
 #include <linux/compiler.h>
+#include <sys/types.h>
 
 struct bpf_program;
 struct evlist;
-- 
2.55.0.1082.g2b9226bbc0-goog

