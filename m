Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E171DEFFE
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269208; cv=none; b=YT2TtrU4DgEtqfceBx1D9ZaSoy/9gSL/3AqW39A/jayujPmSfxQIN/FTqjswOKKaicIpriJP2+jJQexlUNpea6hmdw0eZi9DvnVQyX0SNt/FGm2KPRymmS6yTW3tmgK34LxFXNRb/51PjWgaFtASKbZ3s2iawiGdbjf6wRl5SyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269208; c=relaxed/simple;
	bh=tL2J+dMkR415bne8hc/GC9ueSwxwp7jta0t/apbU0rU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tnu9VeXxffMlRJwsK5swvg74FC1i5dfdvU42IIGAGTvMQAxFpMP3rfsoRkHmFW9GmtKm3RYDtQW5wDFB79OWJUq4Vb4yxKPd1zcSxtD/0ZMQG6YbQ0JR/3tapGZdtJMhpv4yODUkoqhFSdczhVXJoxiDtGhT7faw9KZZrHWBAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zAPTtkr/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zAPTtkr/"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso159993075e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 09:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736269202; x=1736874002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7bTUZtuS5gNWUs8r1yWc3tr3aZdCbA1SpiRHMIxrUmM=;
        b=zAPTtkr/55yBVns5HjTe3Qd0p97WScx4U/J+9f0KuwoOzYbPTEEz6IiFWQ2k5r+SJ7
         Hwtxqfqluv2u9sSt8ChUTvPu6vmr4ewCUTshlkOWolCCJhzsF1k0hopo2jK5bqNzLiMG
         lqEo56u+3ywkQfL//7CJxOSdB1iclrmPn5JhXqXlihedYzNfbaYqClMZ99ld6fiQsp1h
         oqLoR+m+WOQjJ9HBy8RJ9RV16I0qwdjxn7wXBFbeu7taB2gUpKRQjSnzl8rIzPvB3oHr
         uPtKto+hDbhuTOQo0MYxAEIvChYVpcjBVq9qoRPPBzBowDdRtj5bTUKuetW16YVZZgnn
         lmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736269202; x=1736874002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bTUZtuS5gNWUs8r1yWc3tr3aZdCbA1SpiRHMIxrUmM=;
        b=naBhDtb5dYN7/zruAiVL5FrrUSt7wnKrBThIvstRu9lPCUdTKMrsGYGgnGYEWE1HIN
         8ciyj9Tvn8bU2HBrD1eDnBzw4CaTa22n357T+AyD7CQZ6aKW5q7Nkv+AXatbmJB1B9Ul
         3ymcjGGpSPjHQBWJfh++JrHoDB3nUkL9dDa946jvMcaeqeK1giKYGxR7i/YbeJ3M0tir
         cJQ9dhXsHLnFBLVj7MYdEDeidoWiCss76/JK8ExhSjDICUwCJWrGmw04tNDO/RDnioPa
         T8NsRxJTVcyOFouuRwP1foer/emGzou9mbViPnz06YMvuQtff+HJnWdrB32QgY5s7JLR
         2BxA==
X-Gm-Message-State: AOJu0YyMAB6FtvfRSQpNOKomyEID6GK05CVqnaRIK/ptEfaLJku4wkx+
	H1N9eUHeeLiBk9c3RTMOVwnRyO5v0bDe/Av4oBNCe0D2MuisApfcRMWxs7obzIEHYSoeX5Wt84J
	W
X-Gm-Gg: ASbGncsrncryn28rbXMuO48XniNWIT51g5ialnPpxfiPND26f1ULUHlap9JkhNH1Hnq
	oDdRhkDMAWrxvURfial2hqnqgG/psG0utqbNUShsugMze+qDz1fmP1trHfru/MXVSn4BwIusDrt
	bFEdUGVprBcogsOOEFQJLewZ3LTcaq0h+/MXXc7J0euwvVkXVoeIxvuFAlZHbcrxAGcjbMlbXR8
	gPVlcdkWHgJrgCgztowlUAW8ISghOhBwlD3wdxwmnzDZ+XKyoBtK13K
X-Google-Smtp-Source: AGHT+IHuUe+2YElpZMPEsZJiFtskfB1MUFaPU4Ev01dTX7HE5z3Kbu4k6L4eKaJmJpC7bVzDitCXrg==
X-Received: by 2002:a05:600c:35cb:b0:434:a386:6cf with SMTP id 5b1f17b1804b1-43668548b49mr488613705e9.2.1736269200501;
        Tue, 07 Jan 2025 09:00:00 -0800 (PST)
Received: from pop-os.. ([145.224.66.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b1646esm632778535e9.26.2025.01.07.08.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 09:00:00 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	acme@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf test: Mark remaining probe tests as exclusive
Date: Tue,  7 Jan 2025 16:59:30 +0000
Message-Id: <20250107165933.292225-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Probes are global and other probe tests are already exclusive. These
two tests can throw warnings when run at the same time so mark them as
exclusive too:

  $ perf test -vvv 81 79

  79: perftool-testsuite_probe:
  --- start ---
  test child forked, pid 46419
  ../common/init.sh: line 137: /sys/kernel/debug/tracing/uprobe_events: Device or resource busy

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/perftool-testsuite_probe.sh    | 2 +-
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/perftool-testsuite_probe.sh b/tools/perf/tests/shell/perftool-testsuite_probe.sh
index a0fec33a0358..7b1bfd0f888f 100755
--- a/tools/perf/tests/shell/perftool-testsuite_probe.sh
+++ b/tools/perf/tests/shell/perftool-testsuite_probe.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perftool-testsuite_probe
+# perftool-testsuite_probe (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 test -d "$(dirname "$0")/base_probe" || exit 2
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 47a26f25db9f..cffdd5fc8b95 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# probe libc's inet_pton & backtrace it with ping
+# probe libc's inet_pton & backtrace it with ping (exclusive)
 
 # Installs a probe on libc's inet_pton function, that will use uprobes,
 # then use 'perf trace' on a ping to localhost asking for just one packet
-- 
2.34.1

