Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039074;
	b=DD1dyGZ+p8QQtM9TsDjtt5AiSl52uia37TbkAcB5D8AM+NOa6Ft3IN+1eApDgtm3jh6O
	 qwwyLl1PY8zXMy0GBlNXYKzeVdJBjTY/V3IjhJq/G9bMTcWqyfOLvxkskrzYt6eCgtoIO
	 Z5s2A4+xCbDX5z2stfghw8OZqNSHTiSrXm0XMPB2/datnrWd/4S/prj0DutUTvKcsV52R
	 m+UyoTDYvZlfHbyDVR72cyXXiYkzAvxqH3tM0ODXIPmjUT+yOkCTVQpro+XIDsPhZS33q
	 HJbuo6NYOrATl1YM+uBQlFPH3I3/r1S5wVlgn3CDSiyGkBKOtYCntF92YVqE8MhxvsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039074;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2gpm1UxUzmoyh40qnSOyQEWaCYOdlmC3cCwN/wZvJAc=;
	b=4LRxe86u0shx2yJPSRvvJ1ME8Vnhbx+o5jBDtUBWk1iF9dNjpPgJVdZoHu4/zm2COH8E
	 2jMLTMyKVppp8oTxIWpHfdnahlrYwUpNYjq4TEUmRT7zM1Zze2zU8C8UKAI8mIrF2ku1y
	 PiKjVV+E5hHC9525aaDZCVDSMZAKPoENPcZsh5mw10ZZ1EzzPSP+XAsd2RJbwU+r0pJW1
	 hAEzB0OAHPt+QLF1Xk6d3uIpKZreJDzNxjmNywCe3YtZivnWAUpcvhZMxKtmMHZzMhII6
	 H4JTQ9HOh6b03jA8m0DhbOOAqVgXN3CtyoATrVhNFsjAS8dYuKkJsSZpnmsNJDy5Ssw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ltJR0Pfc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D99606A338;
	Wed, 18 Nov 2026 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ltJR0Pfc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFF61F000C4;
	Wed, 18 Nov 2026 21:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039074;
	bh=2gpm1UxUzmoyh40qnSOyQEWaCYOdlmC3cCwN/wZvJAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ltJR0PfcQs4coyUfKqsiWj5aGTWv+mCAvGENLcsGZLkaWSKwsCVPuO3Bz9jhEslzY
	 c6HE7zlxxAdBOxU7EXUwH5OpE/x8zxNg4f+y2/MminkGsDl7x7lCDpdivD7qGb1Ovr
	 P7BziPm1ZX9RiXHXVKlhHzbxPo++GQiNWJPF4FGQOkO7BhDHT3Uz+eEnmvRUhhpy+b
	 5/yK/sQ0FOllGM31VqCCMa9jOycEcT1cfZJr5G+KDU8qEVIuzOJFm9NVB2qRustItb
	 Ztx17AejBd2P2hwnf5F4ULvfwkqieqkB8dO+5Y8JLNRY5mguR1WsnPzBnw4xvFR9yP
	 OZ4X9XLHVK8eA==
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
Subject: [PATCH v7 09/13] perf tests: Silence the libbfd probe in build-test
Date: Wed, 18 Nov 2026 18:57:11 -0300
Message-ID: <20261118215716.114868-10-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118215716.114868-1-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
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
2.56.1

