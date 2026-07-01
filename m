Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B9386541;
	Wed,  1 Jul 2026 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930506; cv=none; b=bqXn2bWSJt1foZamBPU03FV6538E58gIhmZ682gTOCDA9Y8S6xpmkzZ/B3oDAL5wAh3eu6xJ56m2Km1Up8dFukzOFeJhVYBLn8Cko+TZvKQOd3SjL0n8s4mV9LmW3wfYoavfCt/eFYJYMTldP8/kURKSxL1ArTCGBD7cuEMXuKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930506; c=relaxed/simple;
	bh=bV3TO4GSTV+rp/T+JLXp2cjeTU/FuWWeJaOCqj9OMnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aEuGPAX2/x7Ny153vM72rtLnjO9QlpuVCLf9fodBIz1JVDZiVb8h5jJB8E/CQGTc4HcAjK7MFcXTFzdB6wFR3LNfNAuaMlOO6KJYnTxFi3yZ7DqXDZtlbcD9mjyjUKAPOyRQI7C4zFyHZ8ictmOzNkOP1tfDnR9c/1lMFvYfWUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZWKrerZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZWKrerZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276441F000E9;
	Wed,  1 Jul 2026 18:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782930505;
	bh=mHQIOe/FVGav0bLaHdr+CZn+2ACoFSGayw63o1uDqXY=;
	h=From:To:Cc:Subject:Date;
	b=ZZWKrerZQ0L/iIs/ExmoUJFR37UwHQQCqXJIUFDnpvHkjkpwkjGShVftiFBHK3U1a
	 gWd9KzrLDUaYzscxghhKUO/FYsGanfCbrFzQLzNGIH87KrdHu0XFOBrnS701utxRaa
	 5LVP0y9DkNi83PtuJW0Huvauaa4HA40TrDAUumKVRtEtFprXAZgMpN75SLuhc84DxO
	 DJB/PV7z7aiuvH3qi33e8q+BjNjKz5Q7+C21zs66WrPb4Z9HFeO45eHgODVB7iLzFI
	 PRZtpKsgvrkZNq5gIrxXoh7v7l7nqY5DQiw5LkSdtqvTTKlgPqMOahClZjE1N61AKj
	 eP0XxJmTZunHA==
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
Subject: [PATCH] perf build: Fix compiler errors with old capstone
Date: Wed,  1 Jul 2026 11:28:24 -0700
Message-ID: <20260701182824.347941-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems RISCV was added in capstone version 5.  Unfortunately they are
enum constants so cannot check with #ifdef but anyway we can define the
symbols.  Let's do it using the version number to avoid build errors.
It'll fail at runtime though.

  util/capstone.c: In function 'e_machine_to_capstone':
  util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function);
                                  did you mean 'CS_ARCH_SYSZ'?
    186 |                 *arch = CS_ARCH_RISCV;
        |                         ^~~~~~~~~~~~~
        |                         CS_ARCH_SYSZ
  util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in

  util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function);
                                  did you mean 'CS_MODE_MIPS64'?
    187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
        |                                  ^~~~~~~~~~~~~~~
        |                                  CS_MODE_MIPS64

Also note that capstone renamed CS_MODE_RISCVC to CS_MODE_RISCV_C which
would cause a different build failure on latest versions.  It's reported
in https://github.com/capstone-engine/capstone/issues/2977 so I think
they will add compatibility layer to prevent the error.

Fixes: 12c4737f55f2 ("perf capstone: Determine architecture from e_machine")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/capstone.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 5ad537fea4360e31..dd7cd97d0a38056e 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -24,6 +24,13 @@
 #include "symbol.h"
 #include "thread.h"
 
+#if CS_VERSION_MAJOR < 5
+#define CS_ARCH_RISCV    CS_ARCH_MAX
+#define CS_MODE_RISCV32  1
+#define CS_MODE_RISCV64  2
+#define CS_MODE_RISCVC   4
+#endif
+
 #ifdef LIBCAPSTONE_DLOPEN
 static void *perf_cs_dll_handle(void)
 {
-- 
2.55.0.rc0.799.gd6f94ed593-goog

