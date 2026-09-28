Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F46D30EF9A;
	Mon, 28 Sep 2026 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590567; cv=none; b=b6FkxRcy80cBd7camMyxFEKwbJ2ejdgC8j4IhImFBXaOBT7Rc8fSREfvWgQGpBkp4RC6a7tJ1RVVlhoxJ7hX+53Y36YegUO0wJPvn7FshFY1Wccbq1D58NLy2qVYGsxUwLj2Ep9v49AppFciU7IOZFHMevGtYHZeCO5rmLNEdKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590567; c=relaxed/simple;
	bh=TLcuAfNS5WGF0Ruj4addevBg9cjbks/F3rMnppHCpFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i3XuuAcMtrbBMZJMH9pUYi+c+ydBMqaRDprA6zqI0YEL707ILTipCILMSMzvhnLJ7Lndb+UB3fTtS7haOosYFAVPGTG+q4ocEEiYiiQh7gEa/hm0Zy/7MEsFSE1nHcjcbgKLCNZZB/OlqlpMLPtrGjAG33fs0/DVgjpYuD0snvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Qj293lBg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Qj293lBg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E42F1595;
	Mon, 28 Sep 2026 03:16:01 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C36183F86F;
	Mon, 28 Sep 2026 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790590564; bh=TLcuAfNS5WGF0Ruj4addevBg9cjbks/F3rMnppHCpFQ=;
	h=From:Date:Subject:To:Cc:From;
	b=Qj293lBg/6b843xYXIk9YO/DL5ZlcuD8zBJGerZdZts+ENqsUVJep4w+Pc6KlwNJj
	 nyWECdxejVewrMEYaQiMLr6lXZE+ra/3nb/mQeRs+c2ubsQmD8OFwQlfyDFmFqeQrz
	 xKnzNC2CzPiDqaIAxo9yZSeKOCIuFOPJOIzGhrzQ=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 28 Sep 2026 11:15:51 +0100
Subject: [PATCH v2] perf test: Record kcore for the CoreSight callchain
 test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-perf_cs_etm_callchain_test_add_kcore-v2-1-24fff6fab009@arm.com>
X-B4-Tracking: v=1; b=H4sIAFY+umoC/x2N0QqDMAwAf0XyvIIWJna/MkYoaaphrkpSZCD++
 8oeD467E4xV2ODRnaB8iMlWGvhbB7TEMrOT1Bh878c++MntrBnJkOsHKa5rs6RgZasYU8I3bco
 uh5GnMOQw0B1aalfO8v1vnq/r+gGBWobudgAAAA==
X-Change-ID: 20260928-perf_cs_etm_callchain_test_add_kcore-f96e891f91c5
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790590562; l=1896;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=TLcuAfNS5WGF0Ruj4addevBg9cjbks/F3rMnppHCpFQ=;
 b=PBLAJZQTz4UAxqKrLyv3CqWD4tY8pyLYcqZhXfLSXqr1Oaz+AT7oVouvPfS9f4nU0Vezdmpw/
 96D3DunWinYB0n/QnueUdjkNQgEPoW4JEGspaRGqwiD5ogGg8Fr8j/Z
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The CoreSight callchain test traces both userspace and kernel execution
and checks the callchain across a syscall.

Add --kcore to perf record to save the running kernel image alongside
the trace data so perf script can use it to decode the kernel trace.
If kcore is not available, the test will be skipped.

Add a Fixes tag so the change can be backported to stable kernels and
improve the test reliability.

Fixes: ca0e19074bd6 ("perf test: Add Arm CoreSight callchain test")
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v2:
- Add check /proc/kcore and skip test if absent.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/shell/coresight/callchain.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/coresight/callchain.sh b/tools/perf/tests/shell/coresight/callchain.sh
index 13cca7dc11184002e3ddc058c0d0ffa1c458c483..43ad90bc30345efdd40ba4649ceeb435a1781a4b 100755
--- a/tools/perf/tests/shell/coresight/callchain.sh
+++ b/tools/perf/tests/shell/coresight/callchain.sh
@@ -30,6 +30,11 @@ skip_if_system_is_not_ready()
 		return 2
 	}
 
+	[ -e /proc/kcore ] || {
+		echo "[Skip] /proc/kcore is not available" >&2
+		return 2
+	}
+
 	return 0
 }
 
@@ -43,7 +48,7 @@ record_trace()
 
 	mkfifo "$cf" "$af"
 
-	perf record -o "$data" -e cs_etm// --per-thread -D -1 --control fifo:"$cf","$af" -- \
+	perf record --kcore -o "$data" -e cs_etm// --per-thread -D -1 --control fifo:"$cf","$af" -- \
 		perf test --record-ctl fifo:"$cf","$af" -w callchain >/dev/null 2>&1 &&
 
 	# It is safe to use 'i3i' with a three-instruction interval, since the

---
base-commit: 0ae6fc78c5ce0dfd18d8712a50f0fd4602eff103
change-id: 20260928-perf_cs_etm_callchain_test_add_kcore-f96e891f91c5

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

