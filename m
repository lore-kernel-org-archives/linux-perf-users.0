Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706892;
	b=hq2VpV90491VUuZJJE1N2gR+AtjMWcatMK52wlAzdGSf8HuOqqsVhOpafVFa20d1cHc7
	 ZMFutr2xv7SVLtbv9Tg9iPzfEFMb+sLBQuPJ1Qcjyw1FZ0aPHp3ENGQMf4yCAjc1Jg+i2
	 gJL3k0O11ANU3+WWh1DGJW3V5wfu8ee9p8R3uiyhM3nqWqf4dyvZv8Dlr0QFExCwAjHdG
	 FuAmDheiccQ4xoTzTQJ0cIXw15ozMvaCgqEluUK/tdzH8+em3aMdawuyUZdSJDnHSe/ek
	 6VU1nN/n9Te015byncKm9Mj6Zoccro7joaq3v9TkkbXoqhUyHVI6mjcF6ldR+XE/Ezg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706892;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+13hIsgQnv0B2AAQ68aKBQVG5iSkxdRa1nxHLJEd4KM=;
	b=CEokjw6uZ26YYg8xK1En0KivCrxRlgxGsoGnAsu3lV0NwywWrBkkMi0EbGJifwhcUNqJ
	 n1+9oiGRURq0O3KZ93IaqTXBOlTM7DkGm0GKWMc4/uM+e/bU2aHm8xNLIJYnFVbOegRup
	 9C9Kr1cEmXkjhPyn5E3oP9msiqTLU/hY1zYfNFXJfKesWUB8WX0ZDD8CE3a0T7nhouTIO
	 vGNf3O0XxG2l95195G9hazZqNJC1SngJDBCpoM7ssKxPEt2pCtT+FV5ljYflIrvtW9JGf
	 JL28IrL4k36aJ9Eb1wRGRcxfFc+dIkYmzAh9GvgacUjp/deTiV1MZ3oqJh7GO5+23kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h4/lPnIu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86F606A8A3;
	Sun, 15 Nov 2026 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4/lPnIu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED401F000CC;
	Sun, 15 Nov 2026 01:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706892;
	bh=+13hIsgQnv0B2AAQ68aKBQVG5iSkxdRa1nxHLJEd4KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h4/lPnIuc3gQBe/zBV9O90ikzWXm3jHTVhRzDI0VsnQvRLyhLphLW/T6geoMppksd
	 P06w3khuzPkVf84jg/haExaxNvkvMeXvIP0SE2+YcM8HNfcXF3+hwf2xRK5qjgbr38
	 wnUYVhWS3hybH7lDkESMyqwsb58dyRs1EcgsYybMa2PG9xEhXLlECLRtYDJYkwc/c1
	 PrFLJMGcsfeqich4yghiIVLS/yyOG/fl8XpdyfJNRVEm2kGoAuq+3vdEDH9J+zYoKk
	 AtjthxG6wAV710pbEsQe1z1UgvFyA2SpKJLKtf3zD0VXdyW/z2Yd2WRP4OJiamr/Kv
	 kByhpo2XpRu0g==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 08/12] perf tests: Silence the libbfd probe in build-test
Date: Sat, 14 Nov 2026 22:40:56 -0300
Message-ID: <20261115014102.2879372-9-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115014102.2879372-1-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
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

