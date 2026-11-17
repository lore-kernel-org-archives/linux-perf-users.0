Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884016;
	b=5LaZxMZ7genCvIPgzNfLV4bIsUvH2KY+h+5QvkjJ1HJfg2uxss8kUm3UEezeRLXTfjOK
	 KkMDi1mB+nBAVHPS/JjQfOt/cwM8YVjIqY2N7dnWcNkpDoKHTg+F+u6iFcenLAccXw48P
	 a6ki3zSHP0acn8WYQL+Ba+cwn8Cvf8S5NvRQ1lcnTTsOmkJAGIPgt+9vdldljZ1gkUNKc
	 L1vw4bKYCZodkiUYnLS1x4xHzb39T7cQzDC0PFTC1ycPzn+8awUqcLnGoKvSwYjezrpfB
	 bCMzYfQ4lkW3ZgeE4El0azWC0zVMNkzDtRg5dEJZ5RBJdTeyRvdvI1SmylXe2cQBIlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884016;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BPc5SLhnTp1+AhX70HT21NXZlM36xtIHfw6YHwhe0to=;
	b=XjxBQ5fp4VDg4CqeS82U5oW8YA9WFayWxtrVhTMMe/engiM1PgfnUWL5LxQN2l0hF7BH
	 4XrTc4OwDujMRVXgSs2IsJi7zyxQ2tufC3ruqkixQWrDEBh78IT54d2MMYYbYj37F2sY4
	 oxWxNIwSkrhGmyzLFBgG0+q8fef8qHV/KbjmWayQgdXZSu64Via+mtsGsULXG3asYMXk7
	 HyivFS2eGBygrdEK5C9RcAOPQu/E1Sj6X6UdagxkWKNzbUX/nL/2NzQ1FmqSkWDg0RnOR
	 jFUsX+Kn7PB1ITc9i7JDAG1dGnQqCE4czEPPcqd1xU+/QVWh8NOxWpmwuFB1bI2ARfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PT5K3jdg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0546606A323;
	Tue, 17 Nov 2026 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PT5K3jdg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4681F000CB;
	Tue, 17 Nov 2026 02:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884016;
	bh=BPc5SLhnTp1+AhX70HT21NXZlM36xtIHfw6YHwhe0to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PT5K3jdgVavXkTHMoBg7j6bZp6aAfVU6ohDLijLlS/wCN9C7NpGEo4Wr9wuvbBvvi
	 9roFY/VY47PdX41UZYSIaZU3Hovg8u92cTnwQuzecIhFONcUg9gzz4ETEuzFu6ZbEm
	 d2Km8pf9rW/ECjs65WjF55vY13VqfCiWQGi5RFpTHeIuqCDsvXRlcqR7rxprRwqNpv
	 5M2u3u4CHAm6bFi4BWLkFD+8UtQZd/7oI5yRuG3NpNFJajeCpl8HZIgH2cW5VK+DKI
	 fBZCrs+um7XIQ+VSeSXPLsg1kregSSxdD5DmGEfDtpqryp2oX1ucN6NvJrx3+BO//Q
	 6Hph5u6dAGI6g==
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
Subject: [PATCH v5 08/12] perf tests: Silence the libbfd probe in build-test
Date: Mon, 16 Nov 2026 23:53:00 -0300
Message-ID: <20261117025305.3958882-9-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117025305.3958882-1-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
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

