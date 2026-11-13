Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600556;
	b=WSnbd9EiSwVCDMMOiQG51H30uUgUi5tjhIQKsqOtSsEPRQXr+Edy43BOWc/KwiT4bVxT
	 uPu06DKUnGHnHF8B99c9mOARePol5H4q5MpK/VjX69mpIeK6lfR8DMEP61iXsR0tyWqkt
	 zLRCulyVWK7KQEXQ1N8l1mtRP0MTJbfXy/3twvi1aDRRLUxj9oZM/2WxwXp4aEPToeP+L
	 EP/C62UJDr5ZOdUtqQ+oPhZ2Vwni8H1iWsPStkkdif6N6K94IcmuJsrHCEpHkPC99yiS9
	 AJ4A6qSbqWfkNwiut7CmcxOd5v6Yv7uo6gx966043bdkMeMB7YnluHLaf0WrHBQ7khw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aXhUZRiibjudBPuJybTNMVpnE84LXFHMI9y/tCiYIaY=;
	b=CYwPFszrT5yEUvILcXyDKWnfEHc+YS/byBjV29L0nDCAzm/C96UiXfSWgKh8ledOtTmK
	 dELTxuNTZ1IK6xZ0lDlMc/S7YofC3kC1booIQcCxnSKXaJzpdcp/WKJdivm+cizPT2Fek
	 xlSPK/ADoF5fcQ2jesV4I6ekgDYWd50ZIQefwjKa7ABPY3Mu7k6KRKv09VIqiFcJIZro0
	 GTePEmJFCyM2idPmX/cBU18wrrAMIZ4+igqsKRgQ8ZhW8ZzmZ3xSH2ri6TqAnoy8a+Atk
	 ewf2Qkc6ohDJELHg5pf/j+oWuzxDGM/wIA2BbedAk9JJoBkMqOJNGCe4ZkOtzh9O0xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8Sn+71K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDB4606A336;
	Fri, 13 Nov 2026 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8Sn+71K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5DE1F000CA;
	Fri, 13 Nov 2026 20:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600556;
	bh=aXhUZRiibjudBPuJybTNMVpnE84LXFHMI9y/tCiYIaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b8Sn+71KemsPhnNFilha26JjkNqkPZNMvlgFjngdBohHF4Rra5PgwAsgeLkf2UMMg
	 aU4ScaEr+CdtsYt3a9wHTP3lk6xEr/If+mgmBBissaoBJ7PMTNfsCoC/2ZXb7n8Vpl
	 mJomb6SMHRwt0kIO1diqT50hcbEDGUsJ/qxeRA4dV+04HVWiNq8qC75fawe4Q03qp+
	 M3x6wBgmjMopWmva6qcOo6rlw4flWHR/QTQ3IsVlIwvhaXK/NyKvjl92wrhtwOGqZl
	 /AWARQ/ORlwLd6QS8dU2ei46mj3vAXDPUxaYhyI4i70+S4LDuN1Vk6xopckSHbDfEN
	 XoMVTx8BMnjHQ==
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
Subject: [PATCH v2 07/11] perf tests: Silence the libbfd probe in build-test
Date: Fri, 13 Nov 2026 17:08:45 -0300
Message-ID: <20261113200850.2803460-8-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113200850.2803460-1-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
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

