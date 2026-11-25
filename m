Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634612;
	b=1k9ZRYhIFyGqnigQtWXgedSFs6cinE2gaDO9Kaz27c3qPlhmdgl4CjXRQgQKUfXTfngn
	 AEA1zsV3jCTSzHHor0TI+Thbg35+MJN7VNJNBIqO6Xmxnb61J9eYGEqsbl6/kC7h377fw
	 cl/AlRObE2Td0s03Kw4yCgY+8dXxOWU9Na55HYlNQFi7yIw6puJ6rOS7KYSYqW9tSkefp
	 D8gEEOBUaiilX/g94pTBzYHB2iVB/Pl8nisys0biH8mV7GBf6FBjhWNWl2o1tc/zS+QTx
	 q8uMujQn2hS7wNeQpCVSdzeVgrlUgwvQ7d76W79WKporJPm4UGjaVcTsqbzCDlw5usA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634612;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=roRWIvlWqU8+3akzoi6oZQ2mr1t4JbZ7FcCva5/iuis=;
	b=KFYe37nirAThjc1UStCh0mcBuBCqLHzuwVQIY7hnGyo4nwnZ2cA21el6bCT2A09utP+b
	 j+StUwxtgaANQZDw0JZeSsJD6ExUN6cHJW8G61hwfyn7JiDFSLUZDTeKLY7iDug5rOZD/
	 HDUKbV98AkUwZ2FJ2jJdj8Rk/yYzZVZw229LKa3EI4Qqkwyg+K1Q6IO5bJ3I2t7GpMSNE
	 XitCjQM9SkAQfzmNqeg1LLDfMABbIL2cS3nVOCG5Mk+Hd4ofLpJkz80GzR9PQBcyYbeQr
	 qcFYUNSVAEQlEqeynsHe969LNhnqSnkRAcDZSaXL2uJIbw83ndLbzgHls7Z1nlCvWcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f+jFFNd8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73165606A326;
	Wed, 25 Nov 2026 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f+jFFNd8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2411F000C0;
	Wed, 25 Nov 2026 19:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634612;
	bh=roRWIvlWqU8+3akzoi6oZQ2mr1t4JbZ7FcCva5/iuis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f+jFFNd8K608hK6P9qnXToKjA/GgyP8cYW4CVRasGymJRswbx51+BZ4wFBjvvxVFl
	 tQgzrqdusMBhpW3zGoxtA1RM2BWMbQj81chAF1VRriLrDIK+7SaH42GND9Dyh5y0FJ
	 O6Uv+GdjvTwdWw4H85QvDV3UPVDwJQa+2TWvSI2FwSgniC9jm1ei9GHie1ZjEZ6pNH
	 Z7bEUqiYnJ4iFCj+Kxm/o7bdy2ag36Hpksu9/IoXbMbJkrHTbNKw1+tG4Xfqs6bNJ1
	 C9VK+DkP7vhaJGh3YTXAZbz440LVCl+fCmAgOOnRo31BnKY+f3KVfCdUxXiF3UBLUM
	 NGSYuprsYiHMQ==
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
Subject: [PATCH v13 04/19] perf build: Record the features checked outside FEATURE_TESTS
Date: Wed, 25 Nov 2026 16:22:57 -0300
Message-ID: <20261125192312.34134-5-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125192312.34134-1-acme@kernel.org>
References: <20261125192312.34134-1-acme@kernel.org>
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

llvm-perf and rust are in FEATURE_DISPLAY but not in FEATURE_TESTS, and
jvmti and jvmti-cmlr are in neither list: they can't be part of the
test-all fast path, which sets every FEATURE_TESTS entry to 1 when
test-all.c builds.  Since FEATURE-DUMP is written from FEATURE_TESTS
only, a FEATURES_DUMP= build, as used by build-test, never sees them and
silently builds without libLLVM, the rust workloads and the jvmti agent.

Record these four in the dump after the regular feature checks have
run, from a list of their own, so that customizing FEATURE_DISPLAY does
not change what the dump carries.

Fixes: 206dcfca1f5cfac3 ("perf build: Autodetect minimum required llvm-dev version")
Fixes: 3f5dfa472ea6771c ("tools build: Fix rust feature detection")
Fixes: d4dfdf00d43e017d ("perf jvmti: Plug compilation into perf build")
Fixes: dd1d0044dd1c1bf8 ("perf jvmti: Separate jvmti cmlr check")
Cc: James Clark <james.clark@linaro.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index aed2e952c8f3710a..88b8bc13a578a24f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1369,3 +1369,10 @@ endif
 # tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
+# Features checked outside FEATURE_TESTS aren't part of the test-all fast
+# path, so they have to be checked explicitly and recorded here too,
+# otherwise a FEATURES_DUMP= build silently disables them.
+FEATURE_DUMP_EXTRA := llvm-perf rust jvmti jvmti-cmlr
+ifeq ($(FEATURES_DUMP),)
+$(foreach feat,$(FEATURE_DUMP_EXTRA),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
+endif
-- 
2.56.0

