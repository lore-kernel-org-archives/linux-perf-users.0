Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF70392C4B;
	Tue, 23 Jun 2026 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242083; cv=none; b=poIyX1ZhWrRoodFnrqRFnY/x2SAdJIW8ewL6NSCanp0ybIIzGAzJ4Ep3w9ztEGanEDYrYeRow4GSOUklHlMtMGpTs9IGppPZzTlC/iM6mSdRhp1BiyLhmWyke4Bt0cFXIBwmfiOzkvCivDOxhEPTFzuiy5UOK5sWM+NWmiLncnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242083; c=relaxed/simple;
	bh=KMX1p8Z9Viwq3B0/zesYGrixc+hGYvV3scvc7iZrnIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4XKZ3hw+VKcWPFuNYWgZSAOfDlNZvOHu/5GObcSDK2XPh3C/VCgX1lXu7Pm0Ljh74DotDQBLHQM4P/+hUSWIH0P3SQ46nurRLAtg5qEk/9HwIcQyGVR4+GJSOQyZ3PXpOrrmXaHZgjlbNRp9VxWLlZqPWQ7kuUTERBr9naNrH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZu7F5+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZu7F5+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0984C1F00A3F;
	Tue, 23 Jun 2026 19:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782242082;
	bh=8Me162Q5gpwn2JZ6QqHfGUNzHsqmHjZSj32HXGWb0e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gZu7F5+PuCOwBtQI4fzKhGv75MFOXutv5DrB/iPGhnYoX7uFwfWkFHaVbqBHhM9yu
	 ILcJE1U4SWRUZaLF1qyQ5sae7JZDP1jbd/94JLZekxiJMGZxvoCdWQLfRGJus5RYSy
	 PREVW3ke4+ANmwTBJAR3QOtXAlxZN25ghQi94d5TWfDD61KXovu4+8nE36NR2/eqEx
	 LcX/yovnblb1OhI2npvgHk5B75YaPlo5iEBfXPDjCG3lCTd4bKDRYz9fwmE1dftL4h
	 wCC3lAGUZ+bFRYJu2SXeOGGhpqjo6ehqFGwg53VskfcarkYPFPbifrifcgl7KyEQZJ
	 7lvaRNbLPq5IA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 6/6] perf test: Simplify perf kvm record/report tests
Date: Tue, 23 Jun 2026 12:14:39 -0700
Message-ID: <20260623191439.3621593-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260623191439.3621593-1-namhyung@kernel.org>
References: <20260623191439.3621593-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It can now pass command line arguments to perf kvm record --host.
Let's pass 'sleep 1' directly rather than running it in background.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/kvm.sh | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
index f88e859025c42c32..4ca10388748dee93 100755
--- a/tools/perf/tests/shell/kvm.sh
+++ b/tools/perf/tests/shell/kvm.sh
@@ -63,13 +63,7 @@ test_kvm_record_report() {
 	echo "Recording kvm profile for pid ${qemu_pid}..."
 	# Use --host to avoid needing guest symbols/mounts for this simple test
 	# We just want to verify the command runs and produces data
-	# We run in background and kill it because 'perf kvm record' appends options
-	# after the command, which breaks 'sleep' (e.g. it gets '-e cycles').
-	perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
-	rec_pid=$!
-	sleep 1
-	kill -INT "${rec_pid}"
-	wait "${rec_pid}" || true
+	perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" sleep 1
 
 	echo "Reporting kvm profile..."
 	# Check for some standard output from report
-- 
2.55.0.rc0.799.gd6f94ed593-goog

