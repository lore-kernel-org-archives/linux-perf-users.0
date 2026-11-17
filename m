Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945905;
	b=HZrU+a4LHZC7hnxVOU1ilmdE24gUnyZXItJSgkRDBjry1adFbbzPQ2HVBezJF/YXz7Yu
	 qz2m6/+zztgtiLzlCcoD1tsT1h7pOaWpJTLx4ROy9aFQdlyDSgI5LyZW7bPRV0wZx/+aJ
	 Ksz3Hh37CIbQPSG+rsOG6rL+bEKILmnG43MxNyjlbzpgpXE2uOcqs3olf4/gg/OT3YhIr
	 iEavqXog9VIeEQ/tazuTGgRCMTKL1uQuXY28l+u1XRdFrnHjhsAMXgh7Y4X3skYTZ4WYz
	 kEBWIbToNdAO08rnJBngpRQmlkUAMSfrchz1lZBgIl4Vr+Ts+F+LT1/netgu9LJucmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945905;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BPc5SLhnTp1+AhX70HT21NXZlM36xtIHfw6YHwhe0to=;
	b=zTppZ9vo25ZXfqvy2m7nlwIwHxMDm0WqzmXw2HNXg8lQMxqz6mxMSeK3MvHyZsz5xJeH
	 Jv5+Z4xqkWV5uW5b0OwNsROEgRILDFncoxA+YB1H3vSXsudbtqx4ll/EXfMQDWU6vBQeU
	 NBnZwwmEP8du+sdjW5VIThsA3rdCfNdJTmjqufIIbJjbppc0eS2K3BpNYIFmU6rxz038R
	 ihvFlVR+lNMPTJfyhNwsd182VV68cb5J/KiNRjiFo5t+kSGx+ok2vOJSXmsm5bM+eU6U9
	 xPZ/i6E8GnCWyM3g5LcDTTHJRDQms9ncaOMrr6T8juVxHWV03qQsE1He+nyIlwyWEQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLdwKGAd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4860A260F;
	Tue, 17 Nov 2026 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLdwKGAd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBC21F000C7;
	Tue, 17 Nov 2026 20:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794945905;
	bh=BPc5SLhnTp1+AhX70HT21NXZlM36xtIHfw6YHwhe0to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nLdwKGAdJyO7JspCNDJDJMIWI1sdlAZGsjT1VoInZkTVc+SgEjTX2HHlScvYfahk8
	 t8iqqeKN2LfEbsmreTwWsdxQQLtM1mDNlXqZeBMgNRaFmgaMNFDwARkF2eYnlgz5CL
	 YTYcdnjqgzq4kdvxJsGhJzqlj/SC3MiXxxpDs/6PoonhxL3oUaNGmPngKho3lVz3IU
	 eTvxgIj1E/cQXTz8mP7bNF9fvRdq35SQvrgKgzm3PQgTm7fMZVF0Zvvn/w1w6jol/Q
	 P1unYOr4AmCx5iTFo1Am6fRDe3tl5IlKLEI631giO1p7kM4FKigHIJuKfeQRlY7aOO
	 hPlE2yepiVTMQ==
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
Subject: [PATCH v6 09/13] perf tests: Silence the libbfd probe in build-test
Date: Tue, 17 Nov 2026 17:04:27 -0300
Message-ID: <20261117200433.45174-10-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117200433.45174-1-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
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

