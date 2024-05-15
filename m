Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2636B5DF3B;
	Wed, 15 May 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785975; cv=none; b=mnb8I8/u1jNUbHH+87va+NTe4EauKqXSe5okGcUAP2w0cofb8256EJ1Z1yEUU8JSm8IUeUTlVPQ3cRrCm/G/aXeKzCwuL50EIOpZYY8JH1AfbQeN2cM9POnBVTHbagMymN20Jf0LswPfInHxc01CY7fuAGXzausIWSo5QZGVYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785975; c=relaxed/simple;
	bh=KPfaFcwSv4AAosi3TF8IMY04Xs3ZbwuWqxspN57gxmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eyEKQjdpxRQSOvSYheV7vPw7rppORJ8kPyeZeSCfZf5EyTXKHX59lywpN0CI2h4+VGzrtyaMymChFlD2nLQ2W3yNQnhICCLfG5hdj0qNN0d3R6KaaxiowXtP0NpH97h2g0u7jH9AOqLGCdd1EtbqJ4eCdg4yhASX5Ni6CqbmSnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAF0D1042;
	Wed, 15 May 2024 08:13:17 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.35.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CB5F3F7A6;
	Wed, 15 May 2024 08:12:49 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	James Clark <james.clark@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] MAINTAINERS: perf: arm64: Catch all Arm files and folders
Date: Wed, 15 May 2024 17:12:20 +0200
Message-Id: <20240515151221.204163-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Catch all files and folders with Arm in the name in tools/perf/ up to
two levels deep. There currently no false positives.

This catches lots of missing items like these and more:

  * util/arm-spe-decoder/
    (The existing util/arm-spe* entry only matched files not folders)
  * util/perf-regs-arch/perf_regs_arm.c
  * scripts/python/arm-cs-trace-disasm.py
  * tests/shell/test_arm_spe.sh

Signed-off-by: James Clark <james.clark@arm.com>
---
 MAINTAINERS | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec0284125e8f..c5d0256d32dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17318,9 +17318,10 @@ R:	Leo Yan <leo.yan@linux.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	tools/build/feature/test-libopencsd.c
-F:	tools/perf/arch/arm*/
-F:	tools/perf/pmu-events/arch/arm64/
-F:	tools/perf/util/arm-spe*
+F:	tools/perf/*/*/*arm*
+F:	tools/perf/*/*/*arm*/
+F:	tools/perf/*/*arm*
+F:	tools/perf/*/*arm*/
 F:	tools/perf/util/cs-etm*
 
 PERSONALITY HANDLING
-- 
2.34.1

