Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CAC2877CF
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798432; cv=none; b=k0DIdeyJpX+Zv/ORfr5qfzlo0edKDDEj51TxT922E4Jr0dLCI9GEo06Ozrw/L2tuJATLws89mqAB5D3yFnKsH6gP7nM0NkOaXJdCvplNXlbcoG8MEzEv5nYaU+z/5HM0Cnaw7L36gdXfDb5NJP/mL9QM6xPX8opXsMI4wKr5FDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798432; c=relaxed/simple;
	bh=llfp0PblxlBRT+ndmdBAS1MaVxIINtKjFuJvQqertug=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=mscP4kBJMWUgb5x1MRALAnsuKQwj9lkjasoj0h9+2n8UoyoBUWNktVRu9bedW9TEQgIy41s8bWCq53Wt3YhHwt0kfQjAVKuNfPEfJ0LSAVKLkvEEiW7VR55x7ZTs1DrXzP5c0UyDcuVLcr9L4OLIAu0ezjRneY4KIlczEoalPAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CuiEQbHX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuiEQbHX"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b9d73d57328so222495a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 13:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764798430; x=1765403230; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FT3wNNPjhilWhF5tVB2Y9VoWmr2P3jWc492sYv9/gLU=;
        b=CuiEQbHXGy1td2EtL6OeqlSurbLsbdfJd3oO31beLx5ijmI2q3jm+Acz3ikcUHap/w
         l1sZRAGZWhZzu4wIsFuVCzev0942vnITAAo84u07VqznnV0PBysTwZhEDBRoBFeVMMbR
         xQOYhS5mUxr//r4Ru7Ewkx2r4v/wSObK6PBYAT9gi77M3imhvYz9bgkwC+nEUV1MPa2l
         07+nesSLqO7twsOljs10/j7maS3f9W6IYKErvrzBi8vils762mAqztTD0cjix/iedG5l
         Ch+Ek+6g1C0fKs1JWSnWsjGBWE1zFB/7zgDhQkgg8nAGOnwPeS7DzJvnwPbGmi2m3BZJ
         zG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798430; x=1765403230;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FT3wNNPjhilWhF5tVB2Y9VoWmr2P3jWc492sYv9/gLU=;
        b=odXb5r+3F6OUyzKPvcgMObbM1nM775ysh53yWi3N2S2B5anKlavGyMIPr/MDMOhSxh
         WbT8hzf80ZMQb/97dBFHFMx06g4NGzm0cgeFAM5XO76vTRX7YcAX+zEWP+8nodQcV99q
         y/WwiOuemBTqLxDaQhp3PW8DXX03Mhhg8kZxzoZciYqnuK0yfefql3dfxqj+NMiFA9q2
         CGid4JJaSepAnJt7DTlxx9T0OhRoYWok8v6/geE6THw8qilgfsAPItNhrx7dBWB5j+n+
         /3/54g2wwumSP9c5VKCB+gm1rZw+a30LFQva7t56eQtdYyE+XhxYSEXJCtFM3PAIXUER
         voaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeXSu4GYqSpegV/J6RoxvclckARRx6FdS0ZjBLbUUp4bm5jgMqoOwYSVvsXck4wAVRxCKYDOqvobpo52b4aWDQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxjEjhgDEVXpXQTdPSEEnt+Al1DTybJZpEYtOkpQ7gEDoT2Upiz
	2tTs2owU3zyK4vg7rSI0OJe6xefPLtK332VzupuTu5lSoW+3R/qZJwZKyRzPbFFjVj0L/mAX4ba
	7uDadRq09mA==
X-Google-Smtp-Source: AGHT+IHJSz38sTdlH3OqH9wMFfgwE7XUDrpURvxfh9A4DZ/2U/7Rrxh1PAy2As9txIZ4Mif2jFj1N6o1U70L
X-Received: from dykg3.prod.google.com ([2002:a05:7300:5783:b0:2ab:9468:d9cf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3111:b0:2a4:3592:c5fb
 with SMTP id 5a478bee46e88-2aba424d110mr522761eec.12.1764798429785; Wed, 03
 Dec 2025 13:47:09 -0800 (PST)
Date: Wed,  3 Dec 2025 13:46:59 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251203214706.112174-1-irogers@google.com>
Subject: [PATCH v2 0/7] Perf stat --null/offline CPU segv related fixes/tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ingo reported [1] that `perf stat --null` was segfaulting. Fix the
underlying issue and add a test to the "perf stat tests". Do some
related fixing/cleanup in the perf util cpumap code.

Thomas reported an issue fixed by the same patches [2] but caused by
giving perf stat an offline CPU. Add test coverage for that and
improve the "error" message that reports "success".

Ingo further pointed at broken signal handling in repeat mode [3]. I
observed we weren't giving the best exit code, 0 rather than the
expected 128+<signal number>. Add a patch fixing this.

[1] https://lore.kernel.org/linux-perf-users/aSwt7yzFjVJCEmVp@gmail.com/
[2] https://lore.kernel.org/linux-perf-users/94313b82-888b-4f42-9fb0-4585f9e90080@linux.ibm.com/
[3] https://lore.kernel.org/lkml/aS5wjmbAM9ka3M2g@gmail.com/

Ian Rogers (7):
  perf stat: Allow no events to open if this is a "--null" run
  libperf cpumap: Fix perf_cpu_map__max for an empty/NULL map
  perf cpumap: Add "any" CPU handling to cpu_map__snprint_mask
  perf tests stat: Add "--null" coverage
  perf stat: When no events, don't report an error if there is none
  perf tests stat: Add test for error for an offline CPU
  perf stat: Improve handling of termination by signal

 tools/lib/perf/cpumap.c        | 10 +++++----
 tools/perf/builtin-stat.c      | 29 ++++++++++++++++++-------
 tools/perf/tests/shell/stat.sh | 39 ++++++++++++++++++++++++++++++++++
 tools/perf/util/cpumap.c       |  9 ++++++--
 4 files changed, 73 insertions(+), 14 deletions(-)

-- 
2.52.0.177.g9f829587af-goog

