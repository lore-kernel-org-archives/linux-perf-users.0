Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471284;
	b=x0F0MUGb83+D3qcq1m97r4fqHD7v9JJvP34KmkRels7dlJg/aT+xgcqqW36/d8W1PkhR
	 fEPNMmCFoXx4GaJO/hheWoF3TTuprHJqWB5srfYmuQ873MsR4AXdsgKk0kOZLKKRICvVZ
	 EPG6QjIrZ9syolZbDdSYtQmFFfVHzga2sThIoozStE7m2zAwbr/lS1+x3pSfLsUdQflwe
	 YmWpdsDnFdpthZd194ln9aG4DF+mqH4znEUZIgS8m7QD9ClmqQn2La9s5IlunA+K3TEqG
	 EyqL1jc0kKa4OR3e1sItONd9hJ2IBp/8iZro44fY70sDfNYmDIx1SEmuRLVQ5q/2j4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KZmqBNdphekKEEgxVAXsrHFlb1ohSo5eKZeuG1YGIXE=;
	b=jObl2oINmUsZNQYgoJfqyX6B950AATeZlb2V5/tHHa+VxviWDtlYlwk/IzyjDgUrZB0b
	 /khAtEw37txJBNQAJ76DVLWvyrMGVihPn3/3wxRTkXVIxjfDJmZrxwvnQuncJ5nhqQ3mc
	 2AvI1aICOSb2LgEY/ynoDudmJLQPQTwxVREP1DuIAyKO1wTB4RMHAZtT/id2gUdJi1J5p
	 j4uw+Tol7yFGp6M9qMajpLx8QuWT2StEd6GMJTcG+MqjIss84KG0Udo/3+V/5lAGy1qbA
	 KXtoUmqIRDR8efysLinAQZTuYx7rq9JVVvWyPS+0agcQXoGoEcDdfx8umyrKF7R06Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQrFtKp5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E902606A326;
	Mon, 23 Nov 2026 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQrFtKp5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0BC1F000CA;
	Mon, 23 Nov 2026 22:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471284;
	bh=KZmqBNdphekKEEgxVAXsrHFlb1ohSo5eKZeuG1YGIXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QQrFtKp5PULW14gobH6LW3LybYYYL4wLR4CbPLEfRuiDo0xAh6H4YRtyOSnGceeKe
	 WilRAPBkKL4i7SXvxngHR3nghtpI2sJOyTKsUYG0mIDGp0rMP9pnh+6PzQ3nmtUdR/
	 8zRbPdHg3Wm8kM/+BQLvL0SLpU5DFudgtG4VWK+jvk8okRJHlOhnq41zx/M1LPle39
	 J+QL+ebx79uOw5pRHAq5dETKv16AwjGuhnzyJvHL0vLTvDXZthObm0Yf68mujwmbuY
	 LwfkiVn2jbjrzhIir3yoPqiLWbd5Y5rbMno0aHPkJlchhyezFTBK2VbGO0gR/MJaoo
	 dhLiI1DOxJ2Dg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v12 16/19] perf test: Skip the trace summary BPF tests without kernel BTF
Date: Mon, 23 Nov 2026 19:00:21 -0300
Message-ID: <20261123220024.14891-17-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123220024.14891-1-acme@kernel.org>
References: <20261123220024.14891-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The --bpf-summary tests need BTF in the running kernel; perf check
feature bpf only tells whether perf was built with libbpf.  Without
CONFIG_DEBUG_INFO_BTF the skeleton fails to load and the test fails
instead of skipping.

The /sys/kernel/btf/vmlinux file indicates that the running kernel has
BTF available for the tp_btf programs.  Do not use an on-disk vmlinux
image for this check: it can be readable even when the running kernel
has no BTF loaded.

Fixes: 2d099ccaadf623d3 ("perf test: Add perf trace summary test")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/trace_summary.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index 0e603addb2a99d4d..154f85f16e6528f9 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -63,6 +63,15 @@ if ! perf check feature -q bpf; then
     exit 2
 fi
 
+# The tp_btf programs need BTF in the running kernel.  A vmlinux image
+# on disk is not sufficient: it can be readable even when the kernel has
+# no BTF loaded.
+if [ ! -r /sys/kernel/btf/vmlinux ]; then
+    echo "Skip --bpf-summary tests as kernel BTF is missing"
+    rm -f ${OUTPUT}
+    exit 2
+fi
+
 # summary only for system wide - per-thread summary with BPF
 test_perf_trace "-as --summary-mode=thread --bpf-summary"
 
-- 
2.56.0

