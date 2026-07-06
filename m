Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89E1331222;
	Mon,  6 Jul 2026 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381717; cv=none; b=Xx5zL0mk7c2UAgIeca2BCB9FC6iykQqkF3+FWgbOAFK09ivce+MOuMq1+oKyhPhRT7XJHa6eK6u+x3rZrWeN8PKj3CuQoX283qYkHmWSm21IRscJ3wIdDh+6QLDQ2IZY6zrISAEscu/QNUIX1G+1z2P5VqoRHjpx/RWAn+a0aWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381717; c=relaxed/simple;
	bh=VAk+quARUoDcEKyg77s04bqXgSg6BekhE85GPLvypIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXo3UfyRWGLOjG4WjeHaFYS7aWJGm+0MBZ5pPrzEBm4iMVa/6vdFusv7Dcsjbvs72h5UmYrWGy1ttCHj7/tEndMUL2r446J2mdy3LnXPV4NLFaph26s8gcEewJCSxRmxlMWU/QEelkaG8o9aZRPdGeXdkagqLRai1F22JFaZRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSj/0UZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSj/0UZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B051F000E9;
	Mon,  6 Jul 2026 23:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381716;
	bh=S25yhuBGNi9Jf2qyLYlC0tP1OPpW3E4XFUly2hHczl4=;
	h=From:To:Cc:Subject:Date;
	b=XSj/0UZrk9tOFK18pw9APcInnEteC0ElKXpzaW1/BrsGUinMrSrKEyk4YVwY+bkF+
	 18KW08w+do0MOn/kIQgpLYL30nRDvW5YV/VljPXibjKyawKJJknPaB0Fa83Xw5YGBD
	 tPvDIcCVe3edUbvDsvjK2sRpVo9uHLOfN05UIaquFZqBpKZQPwpGNJJHnjJcGSL7c1
	 v/b6Uca7HDXJ+qIe6w8dfUCOEqj7UW84TdY3dVORdUglQmPySOEilRfXv2WRpA36+M
	 NfXdEhKPYceRHQQUzRAetaAKXVBg0Yi3Hu54nxpV3H6tEXa39T15ZycgGYL+qXGE5f
	 toj7DDYtsJL5A==
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
Subject: [PATCH v2] perf build: Fix compiler errors with old capstone
Date: Mon,  6 Jul 2026 16:48:35 -0700
Message-ID: <20260706234836.815254-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems RISCV was added in capstone version 5 (released Jul 2023).
Unfortunately they are enum constants so cannot check with #ifdef but
anyway we can define the symbols.  Let's do it using the version
number to avoid build errors.  It'll fail at runtime though.

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
v2 changes)
 * use the actual constant for CS_ARCH_RISCV  (Sashiko)

 tools/perf/util/capstone.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 5ad537fea4360e31..0247142a77ba3c25 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -24,6 +24,13 @@
 #include "symbol.h"
 #include "thread.h"
 
+#if CS_VERSION_MAJOR < 5
+#define CS_ARCH_RISCV    15
+#define CS_MODE_RISCV32  1
+#define CS_MODE_RISCV64  2
+#define CS_MODE_RISCVC   4
+#endif
+
 #ifdef LIBCAPSTONE_DLOPEN
 static void *perf_cs_dll_handle(void)
 {
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

