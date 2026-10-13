Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0D5616A1
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929816; cv=none; b=dS6crAEwJypWSs1/J7vNzX+50R4AzpU+r4OmkriDJvkISnAA9eadLg4L0+APYsusVRsCrPFXAbBFJSPB5KXa0nOpNmL3NNnX8q8QGRFw5m1zQ5/snykuN/eWScgx1TJd6qfstycImMyrzbP9bpIUnN4YAFYUXPHpcGhTSYGKec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929816; c=relaxed/simple;
	bh=tEhLim5A500urqt1lAsV59rNTXfwXqQgACfSlBnwcu4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kv2ZlNN7YeET9FWy428uTuLnLPTSu4ZmuhnmAEVe2lfrmyuFU6VkP5977TN0IxH/YcVO0L2XDLtxiDOghsqZ8+C4FPferrSjmn3Cj7nA59CRyXJQ2tA6vD4KZ6zk6BsL0n83u7QZTkzCFDSxsuhMfGzEFUdF9bFrz/E+VnrBdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JM5tAotT; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JM5tAotT"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3515266f6eeso574110eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 15:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791929812; x=1792534612; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Ws4vCGngu/b3dWygSTRZXb/I2QSHif31v7Ru1h3tj4=;
        b=JM5tAotTqgeAqx2IcGzFoEwosvBdxlmMyTMb5cV1L/8beS/DQyUHtShCMZMHVyLSb3
         KI3fkIcML5KOZ/qRHkn8v5SzrPnFfr4bOjyXiAnisY5TeybF5+Iz7TD4y9OCFoG5k0Aj
         bwfvmslTk6hco+JGq2OxQTC2dzG/fl6U8/hQIPcS9MY1p88823VG+nuocXbgdWOSo77r
         1AYkFz+cDVfX1chJvaF4OgPd74OgLpH0JyqymlqEvBilHyaja5k9nFy39cuocr4X4OMD
         Dyy7RlhqtVP0i1SMuyJeA3fDpP7ne74Z8B4vogDwESSRNcR707J+YHq1zY1U2E8jc+7i
         ZNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791929812; x=1792534612;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Ws4vCGngu/b3dWygSTRZXb/I2QSHif31v7Ru1h3tj4=;
        b=vEGq+tOUxQ7K1vr24FbC05p5Z6Znm/WZ0dBfyIqHzC8Pbko2JNdc+Xxk4xeIzDNl3H
         0ubY38Jp6ZXs7y7fJfVqGQARruMGGBOzxrOGuPoL2FRhYzEz55n2HTMVlHqV//I3NTGo
         ZQRmwRc4F6X6KHavbRYvtqVCgo6jK8DqMEG8GIL3lI/qMZs7+2L3YvZYg7mgat9n0nx1
         zTDq3GGHqfjY7Ylu/mLeuCGDsFkfOslJXG8IqXYzI7j86b4ufX6BHAFqnk0PnLBMcxhz
         ss5u/+Y0n0/ZgDdby7KWkEb7vvgdnbHOBmTHcm5DOXDNCukkoKKxX3tcqwyAM8PLS20u
         er2A==
X-Forwarded-Encrypted: i=1; AKwUvBz5kDdrlb6xcCowPciI61pRoY969qYRTXVjEdFxKMF6a6XOIKJaBJD9BTiUU0xZz5UcEGY4iwvOz5lnGF5NTKdW@vger.kernel.org
X-Gm-Message-State: AFq9FYI0D4SFCjQBf8w8XVzDblAahDaFclRx0GaYQ+m82RZJtiVloisS
	WK7YB4R99aO65efK71mRBCzGw9koI+vkQaazTgI+Y+UAH7q3UmTX31QG5Zana2XnKEI+GLGvHca
	KhvlXrRze0Q==
X-Received: from dleb11-n1.prod.google.com ([2002:a05:701b:424b:10b0:15e:e836:268e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1608:b0:143:4450:e1e6
 with SMTP id a92af1059eb24-16a60de3193mr16143549c88.35.1791929811242; Tue, 13
 Oct 2026 15:16:51 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:16:41 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013221643.1815686-1-irogers@google.com>
Subject: [PATCH v1 0/2] perf build: Support building BPF skeletons with bpf-gcc
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, David Faust <david.faust@oracle.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently the perf build requires clang (>= 12.0.1) to compile BPF
skeleton programs (.bpf.c -> .bpf.o). bpf-gcc (>= 14.0.0) also supports
BPF CO-RE and BTF generation and is already supported in
tools/testing/selftests/bpf/Makefile.

This series updates the perf build to support both clang and bpf-gcc:
- Patch 1 updates Makefile.config, Makefile.perf, and bpf_skel.mak to
  prefer bpf-gcc when building perf with GCC (CC_NO_CLANG=1) and clang
  when building with Clang/LLVM (CC_NO_CLANG=0), while respecting
  explicit BPF_GCC=... or CLANG=... command-line overrides and falling
  back to whichever compiler is available.
- Patch 2 adds make_bpf_skel_clang and make_bpf_skel_bpf_gcc build-test
  targets to tools/perf/tests/make and verifies with
  'perf check -q feature bpf_skeletons' that BPF skeleton support is
  enabled (or disabled for make_no_bpf_skel) as expected.

Ian Rogers (2):
  perf build: Support building BPF skeletons with bpf-gcc
  perf test make: Add BPF skeleton build tests for clang and bpf-gcc

 tools/perf/Makefile.config     | 81 +++++++++++++++++++++++++++-------
 tools/perf/Makefile.perf       |  8 +++-
 tools/perf/bpf_skel.mak        | 36 ++++++++++-----
 tools/perf/tests/make          | 29 ++++++++++++
 tools/scripts/Makefile.include |  1 +
 5 files changed, 126 insertions(+), 29 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog

