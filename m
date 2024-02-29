Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F38812
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165906; cv=none; b=FJaQZXnAuzHzSVHVvxer+m/GNyTYzcfJkGVYTWHu7bWEdlH7uAEojM+UefGuCJR/ye6ngJOU2qcluIprvXoJyz9xTx4ypoEOf5guBbWEa15bGkA8eojB4Z9RXsWCbF14X8gd/fooSs8xH51KZTG6BNqHbImTUEs3BOTReMUmZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165906; c=relaxed/simple;
	bh=SNeE1H2bSvNelRyZsRJeUUph4hutQUY+T7ny61PsnSo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=L30p6t7pWDbSiaSrBsaXk/M3H+FGG/X1++ZMbTrMvkuOri3Tsiom9EtGVmcsJ+wE3g0sdSJCfHuGeCWjpQuzbUCjQ1mmNngPR5fmOeNg2vTwomLMQlY66Hedp/XZQuiM0X2cOCIp6yvUZhNyuvoMe3cAEzHfZTnAwrKRRDd+cGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q4LXKtwd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q4LXKtwd"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so584163276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165903; x=1709770703; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i9aZM8JSI75x3Nv5IZnCmGh+gLHZGhZIzWCbKV2hRuI=;
        b=Q4LXKtwdwN6AQWuzlOJBKhCj7s4G6FBP9DnemaBa1biautNdnZip8ui+Z5XpbgH7Rs
         on/fQHF5VZJZWMpEIz2lVF9P+UBmKjOyG5drxwHxwWcLM5hzZm+hfDtZqKUtmKP9Kew+
         X/3JGhvKhM2NZ5V7RzB3wr0lAUt4zoxM5dP/i+ASAw/hVN5l6BxLfFtwIweerRzhIgME
         MMp1drRG4gc6R9m/mF1D9JQaCmsobTupDlo0+te9piuvQ+m3hyfsJeAi2PDEBQt+qINc
         WCJAfJDOyX7BM5GuiMgw/Ldh08a2UV9mmgNoOgTTwGgMYA6XADTWLvRbIbtXPuUHWWp/
         YP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165903; x=1709770703;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9aZM8JSI75x3Nv5IZnCmGh+gLHZGhZIzWCbKV2hRuI=;
        b=Z52FfC0PTd8iacI95nCdifB8AI7w7+JSI/QYqagrgKAmEObgfm1RkmV322oFpP2xHE
         3sB0fYhagi8L+rw2ntLylm4HLMypi4J/DPG9O+hYwBD9m+45y0tS4UtWiINKSkJjJ/BV
         wrxHfQVPQDe5nI7PvESi9nyz7wS4Cbw+ZFqIzpvA68cqJWvdZyySLaOUzmhkD7xkt84b
         VfYi4jiCYK5//8LKxVfRl2S+2g/V4EDijXbt9gZWDGy+uB6QW9CPlBv/BdBHhmyqt76M
         PWouKmU/H9OV1Kl5yTFGBf3WCVzJY9FK0Ei28DjwtHLJmZ+1Fzsbr91OLgvwibdPWjUy
         xYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYCdKqYNu6MNic4C3HzYA6ybujmGlTpgO+qpOge2EvQzD3Afk5vc7qIaxNQsKTVWU3OEY69mM55SVNPulypU4CWYBKQFXdkosdZTn6ntcNRw==
X-Gm-Message-State: AOJu0YwQE0DiLfIcdhHvJhTtXg/Glri8p0Co/rYl6CaLtiLrnF+C/Qpq
	K6jKruOL6z3wHHXX5szlBVFaRoQdL2yPg72EO2zVQkwqFU3wzCzIQvOGesiK3O4wqjv4iaGPzeR
	NuLyxig==
X-Google-Smtp-Source: AGHT+IFclBXaulwGLyHKgmDX3fdhdlzOA1oCM6xIgLIenj8gqb/f6kzn7lLC0pwUH1BMotojcewKwsc0F/Tm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:100a:b0:dc6:e5e9:f3af with SMTP
 id w10-20020a056902100a00b00dc6e5e9f3afmr193174ybt.9.1709165903628; Wed, 28
 Feb 2024 16:18:23 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:45 -0800
Message-Id: <20240229001806.4158429-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 00/20] Python generated Intel metrics
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Generate twenty sets of additional metrics for Intel. Rapl and Idle
metrics aren't specific to Intel but are placed here for ease and
convenience. Smi and tsx metrics are added so they can be dropped from
the per model json files. There are four uncore sets of metrics and
twelve core metrics.

The cstate metrics require the event encoding fix of:
https://lore.kernel.org/lkml/20240228170529.4035675-1-irogers@google.com/

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240228175617.4049201-1-irogers@google.com/

Ian Rogers (20):
  perf jevents: Add RAPL metrics for all Intel models
  perf jevents: Add idle metric for Intel models
  perf jevents: Add smi metric group for Intel models
  perf jevents: Add tsx metric group for Intel models
  perf jevents: Add br metric group for branch statistics on Intel
  perf jevents: Add software prefetch (swpf) metric group for Intel
  perf jevents: Add ports metric group giving utilization on Intel
  perf jevents: Add L2 metrics for Intel
  perf jevents: Add load store breakdown metrics ldst for Intel
  perf jevents: Add ILP metrics for Intel
  perf jevents: Add context switch metrics for Intel
  perf jevents: Add FPU metrics for Intel
  perf jevents: Add cycles breakdown metric for Intel
  perf jevents: Add Miss Level Parallelism (MLP) metric for Intel
  perf jevents: Add mem_bw metric for Intel
  perf jevents: Add local/remote "mem" breakdown metrics for Intel
  perf jevents: Add dir breakdown metrics for Intel
  perf jevents: Add C-State metrics from the PCU PMU for Intel
  perf jevents: Add local/remote miss latency metrics for Intel
  perf jevents: Add upi_bw metric for Intel

 tools/perf/pmu-events/intel_metrics.py | 1040 +++++++++++++++++++++++-
 1 file changed, 1037 insertions(+), 3 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog

