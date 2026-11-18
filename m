Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041483;
	b=Mf9pgfeTjPQzkJpa47qCqzpzbTBkDacSr8l+/7IZyU5VDudm+D6eMCy2KzDX7FMUc+hN
	 GvhWu+ZFIBTfalPdLIlgDLvi7+5Zi8YWWJk0jT3gF4dyjHsWdmK/vRB3yptfx1GEPVL89
	 SoTIqBaMi07n+KVrG7z1s7/OzQj2HBbIhFDQZnzkl2un6YychJnnrKVldh/6NvKFAq5wS
	 wq9y9kZvdK+V8GNFa30LendC988kq9Qw/GtnLk+e2Nj1nSQ0pXU4VBgpp+4Xd9Wm9unLD
	 D6lTY9Imhkms4D2SFA7uMPgPVVSuBDNNV4YogkS3Zddpjh3jZETjlc12IiuI9etRN+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041483;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2gpm1UxUzmoyh40qnSOyQEWaCYOdlmC3cCwN/wZvJAc=;
	b=HkXVq5q5cgsgJhKAWYTprgH0K/i8+P8ONwy5/X6ifOlULL5/dXsYM5RAp9fO4RR+HQsX
	 ew1o3NQXBlOFLWWo+KjWyTAIzygVjjlrarwpiTMYbKg/jUFBBMsAOyVxUs36KbsUJ3mpJ
	 ELPR0gbgoazXjgYTvHaYRfDJP+mvEPHO9WOtxML5TFQv7uUGRwz05NtZP/HYwa+yTrdVi
	 Q5YYlEiRlNkYagrHQ9YaY0us4zKvUgX+SxWstAXe0rLj0TDnTRpXx0I8jGo0uIJhMKGPA
	 X4Q4Pk0ZtUcrHNLAJzIg57W6JjJxbBieLi80BqZpGxGZQ/Aw+RVEOK/0c72y+Gx7Qkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKAQRG0V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8AD606A6CC;
	Wed, 18 Nov 2026 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKAQRG0V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE861F000C4;
	Wed, 18 Nov 2026 22:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041483;
	bh=2gpm1UxUzmoyh40qnSOyQEWaCYOdlmC3cCwN/wZvJAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jKAQRG0VIx+5sWceaoHHxaKgcQ+1Ini0gF91myCUQQFAlhgwTM0g7ZvU98xSKnl4M
	 N45rGfRTwjmC2lFmsz7Xp1r/fqUnXGaTuDwNwi2g3WWMww6yVBL8hKfYivUMWjSYm4
	 7FjQbSSo6WoMMu3Ux9rRRIx/GQNBvldD72RDaplQIIoAIFyqVG6xWHyaD+0C36hEK7
	 zSrMLVQHuZMLRO1f/5gj9bnUcLfrmC2ABLBflXIrdX2b0/6nEXYDeULZ9M104Pw4Pv
	 r+lU1esqHcbQgy/YHEg4lWFKyaSb2DwOuGaP6ADFpKArEFiZ6c94JeCNsw5QJY2aoP
	 c1fmqhV0orPoA==
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
Subject: [PATCH v8 09/13] perf tests: Silence the libbfd probe in build-test
Date: Wed, 18 Nov 2026 19:37:20 -0300
Message-ID: <20261118223725.121500-10-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223725.121500-1-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
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

