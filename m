Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872850;
	b=pAVFEzx2+tgtoFYtRu2iv7VN7ji/CwEJ9yRmqoB947G5PMbAfaxb6mTF6XMKg95eweFo
	 c2PnU+8fF4ML168GeO8ERhHvA9QFFTra5cqe+ZIZ+1i8KV03UBSv4HLdxnhvHEmL+jLSZ
	 b6WS0mP0pUeds5J8trW9z2zjVH5a0787GjXpWr6Dh1xpabu2QG6XS3jZJwQpDiS8Qsa3l
	 O9oZ0r0ohFtBfj59EAsOQMFWSMKcTMwm68qZaTduPkVTqyTybT9vIKQzvtVFC5UeHdeKz
	 E0iZGXxYaX9bGmTnVMWKk4nhI0d7RHCNyqTLKxTrSIgENOQSYS0ItKwhcKo/o8hgqCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872850;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=heKncXN2ESk9KNPzZANxBokZt3UOa99KaEx4tb00rrQ=;
	b=XigaFjiVu+qd2eoYM/0awLsH/3bu4fz0NP7XjGzzGLW3TuJ149C50JOZiZKbS2RNJ2uz
	 5ifQ43AmMgZ/U2fPjv/lpPUp7XXVh6x7CoQ37ihPgb5VWPS9yptojNCSMHOfymYmBAKFs
	 DntpkGZ5GwjfSbGmSlkHCRMQ160U2aw/fmrC77TdsFJlDLYPUwtArfjdTXHetJDwo0pNB
	 ssI2h9JN30AwJgcNrQ3szh1ttGdElGdaC79QjN51sjk0UoPmG50FAcQowKCLVMTFSD0Ga
	 k8BqdK/yemAn2If0bGVhHdKGv61MNiP2mMpGvB4tT8LEQ8FMWdYaCkyCjbOclFJ/NQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1TBUjUs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C699606A333;
	Mon, 16 Nov 2026 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1TBUjUs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49211F000C5;
	Mon, 16 Nov 2026 23:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794872850;
	bh=heKncXN2ESk9KNPzZANxBokZt3UOa99KaEx4tb00rrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D1TBUjUsBcCewznpSysSRU5LHf+mt5uQw3kyRAewsAsut80RozunsU6xDcAGQwEOP
	 KhsWYJOofs467prA7E6/wLCwEkqsgBUCfAOGr6xSB2Omk/Tl2yRk8wWxSBznXITSDq
	 9+WwAna0LLwARQD1FDf97iTHo4sTm127d37BLv0jWI/yIy1vy04KPwT88iOoxeHFRx
	 4czSDSuxp4iMPXrp7N35ns4UZDeZVQQRA1rzFbTfKyVMKaOFV67EFKKdbSgQHvM0bE
	 dr+ijId6S2pWyIfutj7XI6RcufDWh2oXzXtKzpF0H214fa5PSO44NKzbAVG633P6Ad
	 k+LJSkc37THQg==
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
Subject: [PATCH v4 09/12] perf build: Record the display-only features in FEATURE-DUMP
Date: Mon, 16 Nov 2026 20:46:55 -0300
Message-ID: <20261116234659.3950531-10-acme@kernel.org>
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

llvm-perf and rust are in FEATURE_DISPLAY but not in FEATURE_TESTS: they
can't be part of the test-all fast path, which sets every FEATURE_TESTS
entry to 1 when test-all.c builds.  Since FEATURE-DUMP is written from
FEATURE_TESTS only, a FEATURES_DUMP= build, as used by build-test, never
sees them and silently builds without libLLVM and the rust workloads.

Append the display features that aren't in FEATURE_TESTS to the dump
after the regular feature checks have run.

Fixes: 206dcfca1f5cfac3 ("perf build: Autodetect minimum required llvm-dev version")
Fixes: 3f5dfa472ea6771c ("tools build: Fix rust feature detection")
Cc: James Clark <james.clark@linaro.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b4764f69f47f4d8c..1b5caa246345c9bb 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1310,3 +1310,7 @@ endif
 # tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
+# Features only in FEATURE_DISPLAY aren't part of the test-all fast path, so
+# they have to be checked explicitly and recorded here too, otherwise a
+# FEATURES_DUMP= build silently disables them (llvm-perf, rust).
+$(foreach feat,$(filter-out $(FEATURE_TESTS),$(FEATURE_DISPLAY)),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
-- 
2.56.0

