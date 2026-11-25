Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634654;
	b=POSj5uVfVnQUMMrHWMz9gbV1dY9wz/Gr2A4vx5JfwMTTgDQkgxVJvgY0Tq9NMS2BeXCC
	 LyXgNywIs2oWtGnOTOYcbd61J5Yb7A8jzw/KDmGIkDczJeIsC2zF5ExQ5HhBtl8tR0iRz
	 BJckdc767l5x5Zlm5qB9rRlLlw75LDMfa+SPFxl724hdu2LDwPMiQx6+5K0A5U29kTjUf
	 dcg8tfONxHzX9VtmipEpT8pT2anaagPrqwzqJ+KtT45rXghlQMT7/9qo2M3OF9RzVn6iJ
	 o1vgbqFDYMcxCbhvgkKeQOo8nLgWC99yv1Dsx6T8rcJgks2B3+L/o1SkSWePr95zuJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634654;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KZmqBNdphekKEEgxVAXsrHFlb1ohSo5eKZeuG1YGIXE=;
	b=0z+cpwb83tPsm8NcygBKaRWCnPgJassZTlnIBNdOBTCSOGi4AZY3agxC4gulaq7MviDa
	 ju6ztP0qrdRoi8xgVgLYrARWxV3fskEuHjm4X1aVpREg/oup1yHTAd+l7JTVVMpzgUiH2
	 YMDwiZmkvQo2Or1saw6p1i4LwnsvINa6nqESDcKqCpADBBvuTjNbNrm2KcL5VbLep6rbn
	 xfKSbUbZZm+Sri0KjMp4+xhK+8bka0u98RQCmfil5VYX6xDut13KmXvETcDvTca4XMBFC
	 KlhCQyIwm4XrX0NuQGYaKIYLSPj4VlByt3IY17ApgzAEltI8FWSCAyAOxKTsmS9wVhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SAHf0NCQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3A606A330;
	Wed, 25 Nov 2026 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SAHf0NCQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AD91F0093C;
	Wed, 25 Nov 2026 19:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634653;
	bh=KZmqBNdphekKEEgxVAXsrHFlb1ohSo5eKZeuG1YGIXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SAHf0NCQaMRCCnJpRU/tjozNNSp7qVTzD+C2spbozKqnjeHN6BXfcZ2ujhURJKPf5
	 ixAlvMb0VZorLF2Z6SLIfnj16Vo2+MJFrZ3Bpo6Z4lRgjtRUyQSEKEZbfTYDHKE1rt
	 7SnsZKltDdl8SlC1VqYnE/jlMyzouL/LOF2iTy/+s9JMhsS3anDqCzN4AYc3K2flOa
	 1rGZRe5lWO/eI2JJo+eLZMnQibBFoP5wkGr7QSsvJqUz9J8O6DRRfvTIijH0/M+5Eg
	 KJ1s5tYtyyk6N2uEsXAnBHagyeFgxDZlWjbXPt7DVQRuS0G7+WVKKohU3sN/65uAtQ
	 t9ChndnV7etrw==
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
Subject: [PATCH v13 16/19] perf test: Skip the trace summary BPF tests without kernel BTF
Date: Wed, 25 Nov 2026 16:23:09 -0300
Message-ID: <20261125192312.34134-17-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125192312.34134-1-acme@kernel.org>
References: <20261125192312.34134-1-acme@kernel.org>
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

