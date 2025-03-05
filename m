Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FAB25290E
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202376; cv=none; b=oVSKah9NhFXf6ieco4xEuJoo6KfjHmvtz8lFykEeM5mnPTWEqU9d+D1yRK1WrWBiNVp1oYfetT+SPelovOr4PLBss2+5M9ejVBtKpeivHNnm4Xk6ipK+zy5VOJXWM2GRuf0JXyR40XXNTCIp0R9XDxghL++0yNlvU2wgSBmZGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202376; c=relaxed/simple;
	bh=sX022GWBbzyeUnscAa+LlFDRAoeLjMnqEW+kZSrPEGs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Twq+A0mNYxKlYNk2IWii6fOodesjaNkapOAAGG3cMKRYnmmOMEs/W99+HmGoANfqgCMLROoRoTY+tRoomJlh/rJvvO1T5ObpvowXXKpcJli1C+Ewcmu/uvijrEBhW08wnBRHpaVnBXYn6qIHPy6bxfitZSCJ65G9q3d+cxH8+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZsFENrVx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZsFENrVx"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fecd603bb8so9536638a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 11:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741202374; x=1741807174; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2+LMFjDIxrK4BZu0v8Iel/roPj4BPCoWuS8tU31HKGI=;
        b=ZsFENrVxp2z2qMsiQyC2f/lgml11qXFp2sUa2ncy69TEejyDbcUmIxoL5OE7V8M1Nk
         U6s8fi3nV1A3+V5+5xLuguE7AbSpiPEH7VTLNgwDjjSXX3kT+X4LL6zRVwIooSkt4ApS
         F/ywI62tnl3CFOK+UFoXt01v6QVs5tX1gd8MV5lcJCueR2gWfrwjpIChGK8Fz+PmAiN7
         9T4OhcpXCpPH7WK/SLIq/pEr7iAlAabf3cBKvE5KlrsoChBk0q4G+W4VL6HKQrZjpxld
         BVaCIn1VCZIukKySwOjP2Ox82Rf9zWrPai3DTiaVYQwH+LErLCRrbXIfvPhjpLIYWQSU
         WTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202374; x=1741807174;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+LMFjDIxrK4BZu0v8Iel/roPj4BPCoWuS8tU31HKGI=;
        b=VAzAlzVvDdfCqEEqnao2I7mnziaPH+N4SG7Igos8it5aE8M1mqXAFTVzzIj8a6zcYH
         1vupOxrW89yyiOdQfAq+7k1HOjY6O62ftwSOUrtyZAf2GZ8uSlxLOtHPFnv/T4sc55TJ
         Dpl565eznvV2uqJFIhAz0Hmly9jXdwikF7jlQZc/ZldKZpgf0DsTFusP7dq0Zd+w32D2
         GgEzYQDT+IuuvfxY971SjSata7wkNgzr4hykCr1y0Cq8QVMb1rVoFWG1la35LfyVvgeQ
         5bvtDccePIQ1sNhQ+Od/CAxp/FpnUvsn8ItJs6n5yN9MTvMD5U3RflzStj/diHOfW6YR
         vq6g==
X-Forwarded-Encrypted: i=1; AJvYcCUiXd9BqCE5cjmyphqfi+fB9svibzbxjzcVkQu3einFmT2qvstiNQAtpqW5eiWcmYWLX675r8Q9jYarXuUBqyOi@vger.kernel.org
X-Gm-Message-State: AOJu0YwdozJZJy0WSvkMVEGfiKVr5BJYAjuwtHY2XnnmiHZlTtw59hqG
	8blQrivyDkaVDK8zStR9L0WNNavuVk+p5855XU/oGD9pKXdPvrgpmVm8aoDQ9V32rVOlCxL5Ukr
	LcViI7Q==
X-Google-Smtp-Source: AGHT+IHxwV8Zl2o8jfN4/zAmXZn0yIJPGt0LE/Bt4xgqgLMSMDggLG0d7QVUJESKCLeYBbKYkuloen+mXjXo
X-Received: from pgbdh6.prod.google.com ([2002:a05:6a02:b86:b0:ad9:4b38:2677])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7308:b0:1f3:45cc:c6fb
 with SMTP id adf61e73a8af0-1f349496a41mr7894939637.19.1741202374313; Wed, 05
 Mar 2025 11:19:34 -0800 (PST)
Date: Wed,  5 Mar 2025 11:19:31 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250305191931.604764-1-irogers@google.com>
Subject: [PATCH v1] perf test: Fix leak in "Synthesize attr update" test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The own_cpus map variable may be non-NULL and hold a reference, in
particular on hybrid machines. Do a put before overwriting the
variable to avoid a memory leak.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/event_update.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index d6b4ce3ef4ee..9301fde11366 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -109,6 +109,7 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
 	TEST_ASSERT_VAL("failed to synthesize attr update name",
 			!perf_event__synthesize_event_update_name(&tmp.tool, evsel, process_event_name));
 
+	perf_cpu_map__put(evsel->core.own_cpus);
 	evsel->core.own_cpus = perf_cpu_map__new("1,2,3");
 
 	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
-- 
2.48.1.711.g2feabab25a-goog

