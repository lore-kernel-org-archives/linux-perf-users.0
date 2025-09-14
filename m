Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CD121578D
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874547; cv=none; b=rfMo01FaNrfzcJds03v/P9iWIibkUzwcoAwO6yQWiDE1qgUOxtEfWtJXX8WkLEC/mdAEq6l+Rp5NndZFa46uoDFP7XZG+YYvMOl+i0Dd7483Gsx9L5JfiUNjA9EpFnvgan/GQVoOa6neY0oBJUQGkygEPzJaPJRNX45vN1Z2jZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874547; c=relaxed/simple;
	bh=y6Qp+G1zT3Ln2PDwystdpi61j4rF8Tlwlp1QHuMBIyo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ulltmmkrDJWisrt2q3HYWtwr0Gz9f66va0Lmrt/LGTDrKy3juGWkLYm8R5kSBw6rdBZt2E3qiR48rAy1Nz8ytjmoZT49AxYoqbEvQq8ymDbFKpmbU9rgAWy0t/gTj2C659b1bbyRe9Ng/GTZppeyXRAZdDWJYvOEfB6qCroqgyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=URMTlT4y; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URMTlT4y"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b5f6eeb20eso137855771cf.3
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874544; x=1758479344; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rquQJL2evsCzXK6bUcd8di9MOOXgvPL9hkrSF7CsVao=;
        b=URMTlT4yQ9BGuVEe1U4/fRxrBiBd1rvgxFosnR0LoMjUOsyZ5Yr2V/idjDVqmDPNZn
         F4T9vEMT26z71Pc0DjeBQUIbUAE9AmASJBNTshwtGkkpioQ6kEH31gImorhnniV1i8jJ
         BCfB2ku4uF3+OguDWVxBWuCC3URBkqYpZzBV0GASCRF54MTNa3QU3p7o4UopIJCszziG
         21A9C16wO/BsX2Ooy7jjnkEGFMkbiT77pJ/pXBmWFPvCzb+ctHPYbRPfBKU51Dof+Vf0
         iQgOdMZBqFRFsn6JyEsZF0Egsca/z5kNNgTiOcd2dN9qzcRTQZdrtTnDyreCqsjJP1Zx
         X5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874544; x=1758479344;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rquQJL2evsCzXK6bUcd8di9MOOXgvPL9hkrSF7CsVao=;
        b=sNZUNn8wvq4mp4Fl1LDuDXf2NPmOXoMvmDeJ2ZkCVK4PC3/JZpIRsjk8Aw6/YtD8QO
         sNWajsIMLL1no8QCQciUKNT2NCbaUPmvYH9859NERwPWaxxcnDO5una1My7bQvtiy67L
         CTF3r3dRPfVog2mKQdVqZAwMBq5Yearrs25+xdwiOwODoLDqgQXWZ3CPEp+b1hm2E9ju
         bVORrMQeCjd4guroEpOlRuxUYebYKKwZyvY1wXtKTCOT4Yt3IbYM1M+J9doqBozMKEgC
         dG9T8LGByyTXtDlKcBK+x2e14ZBl9kXyVWBC+IcZQuSuTBie93cpleG9xLih4TiYTjws
         lSRg==
X-Forwarded-Encrypted: i=1; AJvYcCUewdiyRp2q675pCHVc5rkaWjwvFUg2lIa5/XhKPnl8I97CdK7ClCFS95Eone6PoyjU5LhJjRhHSikoD9B1lSy1@vger.kernel.org
X-Gm-Message-State: AOJu0YzIERedD5P2EnjMYlXq0nn2G8B415Whyr4JmvBKpcJXuRYZMihx
	Zunut7HLLEaef0zzksg2QeZB0yR23jsv75RBpyRNcZW0O/eket0on9rlNKmfJ1LA8a/ykNrVsHn
	3tJsD3gEc4Q==
X-Google-Smtp-Source: AGHT+IFbVR+iIE1ccbHzJMOYdPr9VXWlSFOa8u5OXqRL9y3cY51SJ1YJ3R7euJutU7WAepatYdrhuYHZu5pu
X-Received: from qkoz27.prod.google.com ([2002:a05:620a:261b:b0:806:b8ac:63c0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:4187:b0:4b3:940:e41d
 with SMTP id d75a77b69052e-4b77d0847abmr119904891cf.69.1757874544492; Sun, 14
 Sep 2025 11:29:04 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:28:56 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914182900.1960567-1-irogers@google.com>
Subject: [PATCH v1 0/4] Test fixes and debug logging
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Testing in a hypervisor guest showed some issues that these patches
try to address, or improve the debug situation upon.

Ian Rogers (4):
  perf test: Be tolerant of missing json metric none value
  perf parse-events: Add debug logging to perf_event
  perf test: Don't fail if user rdpmc returns 0 when disabled
  perf stat-shadow: Display metric-only for 0 counters

 tools/perf/tests/mmap-basic.c                       |  2 +-
 tools/perf/tests/shell/lib/perf_json_output_lint.py |  7 +++++--
 tools/perf/util/parse-events.c                      |  2 ++
 tools/perf/util/stat-display.c                      |  3 +++
 tools/perf/util/stat-shadow.c                       | 11 ++++-------
 5 files changed, 15 insertions(+), 10 deletions(-)

-- 
2.51.0.384.g4c02a37b29-goog

