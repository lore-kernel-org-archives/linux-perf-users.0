Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D63009F6
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Mar 2026 00:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774141115; cv=none; b=HW1TR3aPEdIggs7HhVcEyFen5QaLsvanlsZ0Y7K6P/wgBK3WS+38j7IAafRyTQ2A1yDEadm6U8N7rREqXZAr15LSOVkTC5aXhHH6MSoaZXUw/mhj12pa0aTJIpCOcK1poLDzfDd/64JJWXL5Sav+qUAp4lSV5t9Byaq7nMh9CMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774141115; c=relaxed/simple;
	bh=w94Z4ht1ngE2NEfC3k9zIcS3AmVkMhwClW/z8reEnSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LgvdfrFh/2ydQTWO6swoKktF1hSN3Udp0FOAinHmNk9iDcAIEYaydVqUxDVgNGl7YsuSf3BaicIE7DODlIx3iOVZZPbSMm7hCyE11uhrVahtmww4GuSCr2sKopZpu25RFcL6bprAjHBU9NP8T8R6xdYj5ChnMwkUH+mBzfWpRyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T18WgsEE; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T18WgsEE"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12776bebeb3so2583769c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 17:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774141113; x=1774745913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYyPAR1RPCplqnKawfHVIkwnGNEWNEIIYR+bHhpQ178=;
        b=T18WgsEEIXlBHVzMQoxTinFEKz5zIksJ1YZL9E0mfJ1EHxzGh5gmRbBP/b5datuqXB
         J5UTJttrZo47h3MUOB1ROwz9OLEITgLORJSmaWsDg6BFEC/alfcHzZlI51zVxB/gzzdB
         rjbBQn5J0l2uNn9phtx74mVxQykN5HQ33i+S2hXL6yLDTiyaY66Z6ceXLyC/NbRikOuI
         fm97w16AAghZk3kowCDAR8XPpwkF0hxXC+naKwzbtZcaU2fM09eG0yQvdzu8HG06Twqg
         rGvJ5NVQPVGKT4/HNj32IfBey36Ew1dz24Hfb06cPUf/Y4EFni12nACO/v5Hxm6JRfGr
         p4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774141113; x=1774745913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYyPAR1RPCplqnKawfHVIkwnGNEWNEIIYR+bHhpQ178=;
        b=saoVGMqWM1x/wdtjNOO4/AeKIU9QmsdPm4flVcbcJHwe1lhQ9BZrn00YnE+7X+IADZ
         9PNjH97ALgvgaZaG6rkxp+DGqfHeahU7Ka5gcLUjKxdv1ym1jlm4Of9qVTM+d/J7b896
         tEhsEqwGUiYM2S1Hr61/vuMAUNQh/oiqrlradQ4ssFUtVly7dtZ1uTTd7Rj0IXUQAMGC
         WSYEAKKXmLBWlH1DvqqWUfHv4pCqoCYNt44nKZZw3AW1NBlqeFB7Lnp9f4nfCudQ7lty
         TnJ+eCWcGW3QdPjV9wqdVZUwMyh8JmQfPjYdlDmDXcvMKaQuiP7CeZ4OoTn6BIqnjFA+
         hTYg==
X-Forwarded-Encrypted: i=1; AJvYcCW9MJYrJCJ6tWVs/1K4DMy/HDCyx8j6gB+gKSkUDeUek1qkMMDgEGyZ67c+hxo2El0ZbFfdFrtRO+0OpX/sVX6v@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6MjRtE1/fwvZe3zxQtKNhvx/oeAbAYQEo6Dzba+dUJFkcatz4
	/1PatcXeMgVXwINcJ3mqJOuSjbasrjmVunvydqJYREZlB+gCA7FAJcLe858zKxZMA1E7ekiaQ8A
	HfIpgsmeCVQ==
X-Received: from dlbts23-n1.prod.google.com ([2002:a05:7022:b057:10b0:12a:796d:c7e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2507:b0:128:bac0:2edf
 with SMTP id a92af1059eb24-12a726cfa29mr4106254c88.34.1774141113098; Sat, 21
 Mar 2026 17:58:33 -0700 (PDT)
Date: Sat, 21 Mar 2026 17:58:19 -0700
In-Reply-To: <CAP-5=fUsaORbZuCtUxFgzMT-Cn2jVDLYfcYGSkXC7TdtyfnatQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fUsaORbZuCtUxFgzMT-Cn2jVDLYfcYGSkXC7TdtyfnatQ@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260322005823.981079-1-irogers@google.com>
Subject: [PATCH v2 0/4] perf hashmap: Separate perf's hashmap code from libbpf
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org
Cc: alexander.shishkin@linux.intel.com, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

The hashmap code as-is violates the C specification meaning
 -fno-strict-aliasing is required or fixes sent in:
https://lore.kernel.org/lkml/20260321024446.692008-1-irogers@google.com/
    
We're looking to not build perf with -fno-strict-aliasing:
https://lore.kernel.org/lkml/20260320224248.536449-1-irogers@google.com/
    
There is also the continual problem with hashmap using errptrs rather
than errno introducing subtle bugs as shown in commits,
  d05073adda0f perf trace: Avoid an ERR_PTR in syscall_stats
  96f202eab813 perf trace: Fix IS_ERR() vs NULL check bug
  9f3c16a430e8 perf expr: Fix return value of ids__new()
but there are additional fixes on the mailing list.
https://lore.kernel.org/lkml/20250805063209.3678359-1-linmq006@gmail.com/
    
Allow the perf version of hashmap diverge from libbpf's so that we can
fix its issues. This means that perf has a dependency on libbpf that
has strict aliasing violations, no -fno-strict-alias or the fixes, but
you can bring a horse to water, you can't make it drink.

v1: https://lore.kernel.org/lkml/20260321024446.692008-1-irogers@google.com/

Ian Rogers (4):
  perf build: Don't check difference of perf and libbpf hashmap
  perf hashmap: Rename hashmap to perf_hashmap to avoid libbpf conflict
  perf hashmap: Fix strict aliasing violations in hashmap
  perf hashmap: Remove errptr usage from hashmap

 tools/perf/builtin-ftrace.c           |  20 ++--
 tools/perf/builtin-trace.c            |  32 +++---
 tools/perf/check-headers.sh           |   4 -
 tools/perf/tests/expr.c               |  68 ++++++-------
 tools/perf/tests/pmu-events.c         |   8 +-
 tools/perf/ui/browsers/annotate.c     |  16 +--
 tools/perf/util/Build                 |   9 --
 tools/perf/util/annotate.c            |  18 ++--
 tools/perf/util/annotate.h            |   6 +-
 tools/perf/util/bpf-trace-summary.c   |  30 +++---
 tools/perf/util/bpf_lock_contention.c |  14 +--
 tools/perf/util/evsel.c               |   8 +-
 tools/perf/util/evsel.h               |   4 +-
 tools/perf/util/expr.c                |  68 ++++++-------
 tools/perf/util/expr.h                |  12 +--
 tools/perf/util/expr.y                |   2 +-
 tools/perf/util/fncache.c             |  16 +--
 tools/perf/util/ftrace.h              |   2 +-
 tools/perf/util/hashmap.c             | 126 +++++++++++------------
 tools/perf/util/hashmap.h             | 138 +++++++++++++-------------
 tools/perf/util/hwmon_pmu.c           |  44 ++++----
 tools/perf/util/metricgroup.c         |  30 +++---
 tools/perf/util/pmu.c                 |  30 +++---
 tools/perf/util/pmu.h                 |   4 +-
 tools/perf/util/s390-sample-raw.c     |  14 +--
 tools/perf/util/stat.c                |  10 +-
 tools/perf/util/threads.c             |  24 ++---
 tools/perf/util/threads.h             |   2 +-
 28 files changed, 379 insertions(+), 380 deletions(-)

-- 
2.53.0.959.g497ff81fa9-goog

