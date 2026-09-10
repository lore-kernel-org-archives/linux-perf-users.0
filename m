Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CD453B5E3
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063000; cv=none; b=UAVX8N+Z3WLadJsVYPoRoo4qYFGBasu878osCdN8kQJbWU6GzWiQCpleehxgjX34XShCFfrsi3uFCk2LI8IJAuNd8KFhQpwtc0xMSjUfYamlEllQ/vafg5wmWIVnhHagmARNrU7V9MTc3SSEBZ325HcbRH+88iaerYPPX0xYYFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063000; c=relaxed/simple;
	bh=J2+jyM9hLucmpNHPPT6PKrP3tm+jy46AwB9bPZDO998=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=D69ZxBckQwTRl6IgloIrlK27mmX7A0s7N8kgbV7/+KAe4z7EOvCVlKMH902Gjp8dc7ZzDHlPVJ3HIHv/vO0JmBVHHQ2YAFD+X4cdL3baA3Zw4J8fdchVvpvU551GtogJrzL7txhRNFAJEo3Zh+dcirmjmBM23DRLH/9lgT7t/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ml2QVwHW; arc=none smtp.client-ip=209.85.160.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ml2QVwHW"
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-4566537e644so8164fac.0
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789062998; x=1789667798; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VpE0xINv8pWnVzg2btWLFzFoWPyU+SnwvICmE2JIiRA=;
        b=ml2QVwHWI+LYzNUCYiEz3HkFqEwtwCOW56gKD/WclrKMMFWFV7aBz5MYFQ8gynFh+1
         gPs19v6aefAfi1oQAFZ7Hsg8meDuGL6RRjSQ3WT0QE9ijw1Doa5iPllD1x5XNEksyO97
         jHv3O0t5j2UC4yEvQxcRIKASOLA5Oo6sJEY1FYhyg3gqGlO0v0Ur5crucdshH1/8UpBq
         oG9E35/LlZ3XY+pT9hNC0/C49ubvwXatZO6eMWklSVvWH8esK4yeHlWyjRIo8hNqE6AQ
         yIxJXOBRRJEeC4+KwEzL1Si3E1Eddmb/FzPQ1qMj6KTQ84WS02olRFm7+rc2GAd4e8Ib
         wIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062998; x=1789667798;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VpE0xINv8pWnVzg2btWLFzFoWPyU+SnwvICmE2JIiRA=;
        b=N1mF0gG7lZAt9wJQ8yvoFq7nhil3JmGgmxB71Aquu4MfwF0pyzya/NnfEz8eITSZkV
         1kOKU8L3oqKtYHIlUuPNOeoClBpMVr7lYwaxuSCRbBy6L1n+ChsOyETnY6iYv28X4HD1
         gBH/lCrYMYkGXrm2F7MeVjQT7VAMjkSp1jEEdS7HM/HcUFD56VichThR/zfwyNzlGNr5
         QpaMWUQ65f/+eB/Ag+jSfbWuNXNivwVXH7OpXQq1uWCgtDBSmn5qo6TegD4W90SR1RMn
         EyZjUoYQ+2QfZKN4HLflQLqkDnK4IA0LYj/wGBSq2tm5BKkX4/IhDltYf4vBblMTnAfA
         vE4g==
X-Forwarded-Encrypted: i=1; AKwUvBz9qOlpSMLfUendEVMD2kljrLp9gmaZKh6VP3tiS7K8ytvAQIxCkR+gXrQdNq8+yRqdWZqgvjMkT5uovbv8kx4e@vger.kernel.org
X-Gm-Message-State: AFuF++kG+2vqsUHG5wYYCHZ/Nt/gGUhTOYh9koFXVF7LCh1upJOYFNQ8
	7VzuaIWK3LxyQr5dKbgYKlKZZWkeS8ZcDBsxckyL8XHi8CLz6+BStqfPiIejh5B63G0XIRsTqvu
	8Yby48vBFhg==
X-Received: from dlii15.prod.google.com ([2002:a05:7022:418f:b0:143:4c40:d675])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:81cb:b0:6b7:46fc:1d5
 with SMTP id 006d021491bc7-6c0bd77b439mr101041eaf.52.1789062997907; Thu, 10
 Sep 2026 10:56:37 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:56:32 -0700
In-Reply-To: <20260910173715.2996571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910173715.2996571-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910175634.3014018-1-irogers@google.com>
Subject: [PATCH v2 1/3] perf test x86: Fix missing __msan_unpoison
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__msan_unpoison may need the sanitizer header including for its
definition.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/dwarf-unwind.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 99d2b7ed016f..3c66dadcab75 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -8,6 +8,10 @@
 #include "debug.h"
 #include "tests/tests.h"
 
+#if defined(MEMORY_SANITIZER) && !defined(__msan_unpoison)
+# include <sanitizer/msan_interface.h>
+#endif
+
 #define STACK_SIZE 8192
 
 static int sample_ustack(struct perf_sample *sample,
-- 
2.55.0.1007.g17ff1f9808-goog

