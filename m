Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844CB3C37B4;
	Tue, 23 Jun 2026 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198202; cv=none; b=n7amat29q6YokktxKgzcny+jLjgDQiJkxFbhUUbwGL+maaOhhkmBP+oRr7PCmK8bq7nnMx1/xGd7D1j9X+AM4cRsKKjPclESix1MZEhlQou+zM4MR4+O6a2NDPTsYvVOSfX8PcJjE8j1iw53KHw/rA237VCMTJUqMBqSjcvsYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198202; c=relaxed/simple;
	bh=GAp0Wrmagq64cren8BOAqiQX/fMF//brvOKtfJICDCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsb0BREE9azHk3mx7rmDI8UlJxTw9cncfmsWZZpuGht2+Ko1pE59Y3FiyXK34eobKAW0CeiVSxl/doADp3K40SCMqtFAGYWjrZ5TuPwsg92ZbYZtG1FLq3P7eEXd2QR0RxzmWLedtIF9Nt+QQuDF0dYv/VYNfALPL9WDjjkNreA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/+HRlzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/+HRlzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177161F00A3A;
	Tue, 23 Jun 2026 07:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782198201;
	bh=twxBQwNpNOTEYJBRDdYdTECnlRjHdrHN9af9GG015iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V/+HRlzx4iLERVAgNfZClnFAdvpel5bs6SUNbkUS+Vqmy7cWheWYNXsQhVxdds91q
	 441hNELtmu2dKZhOr54aM3UHr8blFiGssEugyp/5gdp0jUH/YRFkIgYjdGtgKgg6D+
	 T9VMWE/krUXVsijiZTh3vzErXX7otQRIc9IKnVtpcJEHacEalaHqVSKv3VzjvpLlSN
	 KayzJbecaLXtZqJU7Li/3U1Lh8k8cSXkn1kh9eLvkHHcx0VAgp4ImBs4cFX9eKtaV4
	 vN/woJN+/9uinIP/YTo+LrF449iKAIRxzT0rmHTQRKr98dYbSoI4MsvmnH1HbWIAoB
	 p5aEuBOEx+Aig==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/4] perf test: Simplify perf kvm record/report tests
Date: Tue, 23 Jun 2026 00:03:13 -0700
Message-ID: <20260623070313.55225-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623070313.55225-1-namhyung@kernel.org>
References: <20260623070313.55225-1-namhyung@kernel.org>
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
2.54.0

