Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDDE31AAAA
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740434; cv=none; b=s+csjmS+KHNvRNsagmkmUT7v8wIHQ2itbxZDSNu7BRTqnXzG9vIVHuc1iCg2thhtq6MAYb7O+CWySh8+wodC4TOsxDK3Q9kTEhHUOwYQBH9hZyivr7JYl9i/QClQg9nrBbBGGRdjN1CsC7PeK5Uu1J61cDmHKmTrUu2K3qA5vtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740434; c=relaxed/simple;
	bh=Bl7p5fPq1zzv8earO2MgxKfTQKk3Ks5v1cj5G/bckVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C/56Xdz3KIzDD4y7EGu4daw/5YtLEWNl9SoytX1CGjCJFbg1z1NO48X7469ksjdkUc1dQz/lC+RIPYpggUimc13YTX7dcIrVHXn/cElylZY8MO5JKy/9tx5ECB6KM55JaGB/koOdp45aOOeK9vwh5r2NLNbbkl6M6BPUlY4Ps6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fXSCiMAK; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXSCiMAK"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39e3dad7ab3so1212218a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789740433; x=1790345233; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q198WRfVuFdwy23wGpDOJAEDHlwObTAenaQ9DfUue+I=;
        b=fXSCiMAKa97YGNMs+LkDya3DxPrgvryHUnstG/fH+r5fkwNAf4iDQV9klWEarRaG+T
         p5gqsrx93XLwdW6bESa/fwO+8Zy7AoVzP9ySLXUkuuIsNg0cKSVQLrFNPc9VuDZ681Yq
         +y6/O1vb6+ftwNHjUHRZqweMYAfGhpsJWG1V7PBP5K7C5ahX+oFcxV5wJEH9k+20eDC/
         OD6fgpqZOwLlxsV0WrUWIjUOCTKocHeoKtqqR4txwp+umNkLbMbP1TGYI4h2Th4qEvne
         tkagdY/I3trPp+FmEfdgNd2b6VCh9XpL74Nrctj9uqQ5OkLjGk6aBdO/lGaKGTyhAh4S
         2kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740433; x=1790345233;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q198WRfVuFdwy23wGpDOJAEDHlwObTAenaQ9DfUue+I=;
        b=Mfh4EBQjGCwe2pdlWIlgHeeEUFAwawcTYsKiBnC/D2Rqbok9cuYY9m5yq/vTBSmXae
         AdTsc2Q1AQF7kWXNtsHPJsQlg/7K9MlZRxRn8wWUtqM2Mu5hJqLe5/YYPpzfimHHCZ2V
         U4ij5GKLEhetsFsMIytHQA6wBn4yKD53drYkxM2Jenw5fU41a5bDd2/bYjas74/fbfRe
         PZA5rUUiCTSMDCh8yW2J9iVH4J6wl5vdQk2ftsBu7ST+PqCF2bdWbC5g3KSt5OOZ3VEo
         aOziyr10B/rE1jl+Na5hATcVWdZCh9UuhIl35DhLKnSZp6KgwXvFrOVX0J8ISYyQ4d7C
         Dz9g==
X-Forwarded-Encrypted: i=1; AKwUvBxhoaDgQ6R/13x1ILm+GZbpUPH5a1vaYCoUjgSo7m0oHKQpDTfJnhZGZ5jWNCVzxzRq40fvBzKy6MI3tbKy7oae@vger.kernel.org
X-Gm-Message-State: AFuF++ksVOVG1xkUu6M32cfCSLtN3UP0CXxZrqAIFr74ZdBO+60lvZsF
	4ySHUQb+HOTxxNUsHZ5YdtFC8XbJI8nNbagQ3E86kmqqPEW56vI6+E8YC+V/zuO1opIpVBrOF1O
	QYxbCdXtkWw==
X-Received: from dybfx26.prod.google.com ([2002:a05:7300:c39a:b0:33c:2bb7:a004])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2784:b0:39e:6a80:dda2
 with SMTP id 98e67ed59e1d1-39e6a810c3bmr76211a91.41.1789740432456; Fri, 18
 Sep 2026 07:07:12 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:06:44 -0700
In-Reply-To: <20260918140659.2501976-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com> <20260918140659.2501976-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918140659.2501976-2-irogers@google.com>
Subject: [PATCH v3 01/16] perf trace: Include the headers declaring pid_t,
 strcmp and assert
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
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

