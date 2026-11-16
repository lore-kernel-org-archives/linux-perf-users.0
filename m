Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872847;
	b=sbg6TFews2AkhVwzf5ikZkAGhPtAtIFJFRrJLGATL3MAknFX+SPxBZe+76d+2d53hKnQ
	 GNweGBHahMoYLbUaTD3i+emBTfYDOfROctAIM3tj6BjwJFwzD7SVG3bDjzqYw46Qyshlx
	 0Mz4wcKjxNf+gFU+vSg5Bi0tYw18gHN9+RrjfXP//duZSIAllQGVYnS7RJmaF3rpjWKMm
	 qlQnEGBLsKWim6aCiiXld9DZEstCUMpeX2K1FnKccCg5QGJJgByGLvujzDZu0m0xWtEv2
	 PvR4FqoE0J9BRL1gVw/8MJyze0iSgDvv/6PEFX5H/Uq2e/P1HtN8EIbUeeUaknZaJAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872847;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BPc5SLhnTp1+AhX70HT21NXZlM36xtIHfw6YHwhe0to=;
	b=VYrhrqGg0UiM1rX8Tnk7pTVl6RjWFatKUEDeQ39MaTnCJlZp9vZkXzSCXbrVmsf8Y3S8
	 ITX+TdUU9ovUEjE9sfEk2UgHE32E4rUV4IDWHJHbye0CI6wiU653CDUoakDYlQW/bDeiX
	 F0chEV4NLYyZ85jCjl8Za+IKn1+8Cdznnw88Ylz97WJ/B3PLjRpDGaYRKjPMAuayVq5up
	 ftqaCshkWtg/e8iEjYoQaIu3z2Go6/rPfTPEFswh1lTWc5PCsRLXw79lAgj1e6J0Ee/jO
	 5KLCIbeqi63JSkwA4QiRc7TqOnua2Et0ApJnq+fizcW165/1D5Kzzl/ZIUB+jLFkmfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acN297VA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAF4606A334;
	Mon, 16 Nov 2026 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acN297VA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246CF1F000C6;
	Mon, 16 Nov 2026 23:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794872847;
	bh=BPc5SLhnTp1+AhX70HT21NXZlM36xtIHfw6YHwhe0to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=acN297VAk2x1eMmv7mR2WD9TpnN+gu5sDbzX+yTWnG6aLAWyB7MrmBKbp31Wua2OL
	 nSEqvDGwGBVG9/ALlfb65cPIT99UrQZer6CazKIV+cIjR/ORfCDbYgO6WWVh6jeeZ5
	 ecwmilPy0bhEEsLmK9SA891c4b40X3LakkbMvx0sPKUcdtSF//uUbzsB2Gf4xEOEbm
	 W0SONTXra5YTFkADTIqFogEVwph/Fx3IiCs3r0hoknrLqMt8YGqHl4mikL+UJ/WKlT
	 vXyrqgc7ao3qWEWKtiSdsXUZEAbXRoIfn04RRr63IlxoNGq0hHtDgvhGWRaOENKfiR
	 jDHBq4nQe1vJw==
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
Subject: [PATCH v4 08/12] perf tests: Silence the libbfd probe in build-test
Date: Mon, 16 Nov 2026 20:46:54 -0300
Message-ID: <20261116234659.3950531-9-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116234659.3950531-1-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
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
Reviewed-by: Ian Rogers <irogers@google.com>
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

