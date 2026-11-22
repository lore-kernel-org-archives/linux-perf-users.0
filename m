Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383689;
	b=BR04OY2m/342zsRMwIfDlY1QHKhHIhtin5w1eUPQS+cpVbQu/yGh/bpJqRxW9tVxLN2k
	 k1lwPANk6eykoRSTuhBFfjhNfUl7ZLqPSSqNamfGpoacyOkk3KJnREe1crTgO86e2onn5
	 drNP9J071QXkM5+Fx68PJknMhtoSKFACPJImPaKg5KNey0obDKF0NC03NstRjS9y+U2bg
	 GESQxWG3NzjGcc/hiYA72Wf8EWSW2z1juEPg0fl6KGHYNPTWeEgArvj7tGgSi8gx5r2qK
	 MhhNuefUtVz90h93elKL1oMrgQNCRvKFDwAvHk9Ec+8y9DF6fU+SqLMoLrOzfdAJJuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383689;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NpIDyUQRBSope1I9jsX63rj+ZdZarurWt83uR7hSslo=;
	b=wfiWBqneK73DjA/9vh/EturwdvKAZEAOqhyGwTxYnL/JfeDF4WRiM/Pg4YW7f+4kVgow
	 oZzVfDCLIvjb6JxPa4WWiHdIjuiBHO5W6UMXkVpd+Dqi5QUtoeliLdF4/Wh1TpQ2TJvjM
	 aBO4kNQzladoMkyBbPfVet5L8VxJ1XJgY/QKqigw+4HY1gFyKhmyrmTTkvy86CMcKONSp
	 faccI7GHZJ2o7ABaf4DIb3dWMAsPIq9dmqDefK2oWseA4ZLY4T5oWG8xd/+KZgBpcdyWt
	 ET2tmI0Dfvcxi5RQqclxi1sw2ADbqJ2TGMCZhRqz0OeOWR9UEeEGxdaDNuNEfZrpmcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmAE1rue;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24779606A31A;
	Sun, 22 Nov 2026 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmAE1rue
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C291F000D2;
	Sun, 22 Nov 2026 21:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383688;
	bh=NpIDyUQRBSope1I9jsX63rj+ZdZarurWt83uR7hSslo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TmAE1rueBk3scdbSwYDalEI8z69TuuBlKH6IzCFLJtAreTBUr5lbE/vgp/XDx8Ukc
	 Mv6tUTn+HXgG07sESzfaG5Krky6kxI3ImspqvM2bPUGSfNVBDrU9Z0GzOvvm5E6mNN
	 MYLy+WAqM+eTdjZLMnYeglYk78cFiA9QNXpa93nHklgTBTVw/xfSt3zOozNO+zX6yG
	 WfGrQ+TAymUAUqEAXEr3n3C7eb7uR0ns6CGYfzlinrGJF7uUGE7BLG9BdyG1ZPrNe8
	 zZOXZX2OIsg8JTRkg+MtMcT/AgTTbujdNlyM8n9mB32J9rVwddn1eOCY2B2OsY/1aC
	 Dq26UeC0KR1hg==
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
Subject: [PATCH v11 16/19] perf test: Skip the trace summary BPF tests without kernel BTF
Date: Sun, 22 Nov 2026 18:40:22 -0300
Message-ID: <20261122214025.16769-17-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122214025.16769-1-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
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
2.56.1

