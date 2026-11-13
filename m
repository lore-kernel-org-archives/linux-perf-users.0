Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582382;
	b=N29mJnrqiBehFzHiPwmpq5lgFAh6eYdlFWeYzklb7X7ibmVQ3IiqcHycmV6EGX+XwkWZ
	 OM/hYF/QFkgv34TRE/WwLx6rH12GWuUGaZVHvkMcT8zubvlzP2xQwInwiYIGhBTvNm6PN
	 3tGHq4mnHYK99ReHQ2RYKm8Pu4ZhPG/NkU1F3mPavc2umJCyYnSNLuzicx9hiXXXSGLH7
	 BGVUxZiu5tPH3YaDu4aQnXGKNNdwzhO3KUpzkPSg/YTwgpUT7UK4cDx3VeQxKGmv+x2A+
	 6yoHSCvHpXQY868JfplFDMoiIgQR4Bk5J88cN9dSnEiY/yD6N8GgojmLcgjqO5pnWwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582382;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aXhUZRiibjudBPuJybTNMVpnE84LXFHMI9y/tCiYIaY=;
	b=lYXtgl6w950yo6Kz1+qQHmgl+k1NOw0b7lbkFIccWaIvI1jTWzfYVMQoIpmYF+LSR0Th
	 kB0gvFdp98rBc+oetrJFIb0WKH5bOA6YdMOMzULhHlEAhDFKA4RICARhG+Dxs/8XbiuXM
	 ytcGLCATHjMHKfN+CQt9uJIzLZCTT5WOWp5Z2QM7iXKiU0HrzrRcoLT7sq4gD9vQjVVfK
	 NthpbWYlsgwrgNwETXxisTwy/Bc1ZHZa5JNUfOo5eFglhWc0m5MLsC/nLIlg68M6tlZVB
	 eH7LDGRk4jryyETHg3okPqpu7kaHYgHc5iao9wMkyDDWRv3NMzlm/hird555COv2ZyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lU3Bk1Je;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE260A3806;
	Fri, 13 Nov 2026 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lU3Bk1Je
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349121F000C4;
	Fri, 13 Nov 2026 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582382;
	bh=aXhUZRiibjudBPuJybTNMVpnE84LXFHMI9y/tCiYIaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lU3Bk1JeYoRB7aCNwMCkHgEnIAuJoCLmO3zE1TxHDHtfV1uDeKdFgx9cwxgkKCqfh
	 t7L+Om07d5q+Ap2KxQilLvfrkRmXvXXZiDZ8qcUKKX9Er5lEUrGZLcT0DtFZX4nhJJ
	 SwpCZsenvGpLsS1nkP4HHs8YW1/dIc1RtZ224tMEiNDDTX8qoP0CoDfFqEu521/erX
	 qBSHEanr8jLpJzDSH8fvgYMBWmXprsEn/QyiEyLyISc7lqVAkCGc4ePOx03wEVszrs
	 PtwA4+xvetnz9ehSuEUa/k5wOxeP4bDcaSFHUV1Os/hZ/oTp7l1E3VCw4G7TqJjIc1
	 QIXoAkTWBOfBA==
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
Subject: [PATCH v1 07/12] perf tests: Silence the libbfd probe in build-test
Date: Fri, 13 Nov 2026 12:05:48 -0300
Message-ID: <20261113150555.1163049-8-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113150555.1163049-1-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
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

build-test evaluates the libbfd probe at parse time and the compiler's
stderr isn't captured by $(shell ...), so without binutils-devel it
prints "bfd.h: No such file or directory" once per tests/make
invocation, five times per run.

Redirect the compiler's stderr; the empty result still skips the
nondistro tests as intended.

Fixes: 523471c5163659c6 ("perf build: Skip nondistro build test if libbfd is old")
Cc: James Clark <james.clark@linaro.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 7524de5228029e7e..e6d7ac49b5b1693d 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -128,7 +128,7 @@ make_minimal        += NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
 make_minimal        += NO_CAPSTONE=1
 
 # binutils 2_42 and newer have bfd_thread_init()
-new_libbfd := $(shell echo '#include <bfd.h>' | $(CC) -E -x c - | grep bfd_thread_init)
+new_libbfd := $(shell echo '#include <bfd.h>' | $(CC) -E -x c - 2>/dev/null | grep bfd_thread_init)
 
 # Whether libLLVM can be built, which needs the llvm-devel/llvm-dev headers and
 # libraries of version 13 or newer, not just llvm-config. This mirrors the
-- 
2.56.0

