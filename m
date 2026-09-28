Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D15485CF1;
	Mon, 28 Sep 2026 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586424; cv=none; b=YBMloAsqd7c69ZWQDy0xI3Lvjxfe4Yzqtmghku7OKebOq2Jpevt0dTk+uUCMcVyGDG8lYd2pWAZtW7tYlb7ds+bGnqAo+aoFTYUuf8WTPKx75+LgZGJVyXAou7gAOaY3xSADmEV23mbWvFsyabtXyox8U95cx8LMxedzbgs9oIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586424; c=relaxed/simple;
	bh=VGuceae+65pE0fRe+nT4QcJlTJKE/a66Mqdu1VWBOpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CL/oei8jSdd7rvtEY4rCO2p2ePN4i0z5QTuJ8gMqIsAxkJkXSc7mJgf86ccOtcwIVydvBPMT6tsi5jkH7zzRD2hl7q7frQEF/n79OGEJwxGmvviLhHogissCpgAChuJFGY8YJVE1tKX/lc10JP9sKUqxaHtfHdzy+hSpy0N/T8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=brVXqz2f; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="brVXqz2f"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF7F31570;
	Mon, 28 Sep 2026 02:06:57 -0700 (PDT)
Received: from e132581.cambridge.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 358D23F763;
	Mon, 28 Sep 2026 02:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790586421; bh=VGuceae+65pE0fRe+nT4QcJlTJKE/a66Mqdu1VWBOpc=;
	h=From:To:Cc:Subject:Date:From;
	b=brVXqz2fq+ArRdhpdmw+IBCRFLWgiSeLWN4GMUR730bA/DPWCI1xa9e9T8gpA1GyM
	 38u6PlQ2vDSi/EZ8FNh3EK6v+eBaa0e5SF53vgpMgcqJ8A6sCb+fis3IFwV80tSRKx
	 5vBz8KBfhuY3Am1gXTjru/eXeY3jPUwRVBd1udH8=
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] perf test: Record kcore for the CoreSight callchain test
Date: Mon, 28 Sep 2026 10:06:44 +0100
Message-Id: <20260928090644.24346-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CoreSight callchain test traces both userspace and kernel execution
and checks the callchain across a syscall.

Add --kcore to perf record to save the running kernel image alongside
the trace data so perf script can use it to decode the kernel trace.

Add a Fixes tag so the change can be backported to stable kernels and
improve the test reliability.

Fixes: ca0e19074bd6 ("perf test: Add Arm CoreSight callchain test")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/shell/coresight/callchain.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/coresight/callchain.sh b/tools/perf/tests/shell/coresight/callchain.sh
index 13cca7dc1118..b69187f1a37f 100755
--- a/tools/perf/tests/shell/coresight/callchain.sh
+++ b/tools/perf/tests/shell/coresight/callchain.sh
@@ -43,7 +43,7 @@ record_trace()
 
 	mkfifo "$cf" "$af"
 
-	perf record -o "$data" -e cs_etm// --per-thread -D -1 --control fifo:"$cf","$af" -- \
+	perf record --kcore -o "$data" -e cs_etm// --per-thread -D -1 --control fifo:"$cf","$af" -- \
 		perf test --record-ctl fifo:"$cf","$af" -w callchain >/dev/null 2>&1 &&
 
 	# It is safe to use 'i3i' with a three-instruction interval, since the
-- 
2.34.1

