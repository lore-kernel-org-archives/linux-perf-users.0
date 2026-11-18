Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041486;
	b=GwlzErrb9ZCRnVpSnFCIb6gE46sBVOky76joNl/+iICnlPMZ+gy56BYjP0JlBPN47gAM
	 fl554Uf9K1cB2MTj2kbNoGl0RUJ1rJf1lctvYgUNZjlaP1NkX507l4RHrjW/sEXXByl2o
	 wPE4Z1l3qTB3jM43ZRcNKfKuV62khidpQDmf0gJZj8oW4jyYF9O3nXePZ1kRzs4dHLzb7
	 F7Rf5H/1ge0o+KkbNNc/ZeN95/QqWTtx000m69y5XMC2estjnwOra9mdEn718wWTOVNKX
	 QSBM9H2iG3MWRejezhbN8i1bI0KxiXPAQraLsQ/eIToGjUu19iLR2LIi3glMN/vanKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041486;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d/YIR62Xt6veLrnh9dlXozkCz9WvwzQ5rQFE4YDFbCg=;
	b=fduthOVU1aR/WurlNwP3n0FE4PoUgJKIoURk5s60WQycjvxFKoI6Z+8BWpu00GrlNnhV
	 CXyzJ20++Zb3e4KU6K9xcXsJv4o6nq/axrX77YFZhi94qhkUOpSjs2EV1BYdLuLLzsGgW
	 jAnyC6ky6E4RcaXP+e4tdXf3Qb5jgbIUvpQgVWsSAJsyngwu0ekDObWT+F8NTPqNBOfka
	 HXpfwF4U2D0/InS30HnWCUGw0Lcrjz9TVXcEIZJxOObOe8btvp4KhVMlO7h4vTcMXJp8F
	 TateZ7LIsaFuwcf3v21aq/p14QhB6PX3P3zuaidU82j0P22Kfa5dSNKI0TjbLdlyrQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKtj3OnV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB121606A6DD;
	Wed, 18 Nov 2026 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKtj3OnV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF161F000C4;
	Wed, 18 Nov 2026 22:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041486;
	bh=d/YIR62Xt6veLrnh9dlXozkCz9WvwzQ5rQFE4YDFbCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JKtj3OnVm1AFPVwcCiZxboiAq+ZrGIMiNAW6oma0Mr5yOhYVATKnA/l0lZDyAf6T0
	 jvgUWZdbopj9iFvG+R+rOY6bji2JDxYXQOs45yckMusTEetMGs/XUE557bLQL1oDNU
	 exiQoyv/wmkZLNOpD5cgSyh1xVYDRjn01WAkYCbiOjo5lHK8LbdDMEJWjWFZj7bjxv
	 4QRKusndJ3f0D9btDpe9B5Jc40FKhnC8ObuLqZZNp2DTBHgcScX/CMm+4a2cn+gKFF
	 PYSQgrfvW562KDwqm8fLo7jz16DFHy+nlDBLmb/8PtSNwBCCOYSnqAxuisAxm8IzyF
	 ZWJxcrt/LFBTA==
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
Subject: [PATCH v8 10/13] perf build: Record the features checked outside FEATURE_TESTS
Date: Wed, 18 Nov 2026 19:37:21 -0300
Message-ID: <20261118223725.121500-11-acme@kernel.org>
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

llvm-perf and rust are in FEATURE_DISPLAY but not in FEATURE_TESTS, and
jvmti and jvmti-cmlr are in neither list: they can't be part of the
test-all fast path, which sets every FEATURE_TESTS entry to 1 when
test-all.c builds.  Since FEATURE-DUMP is written from FEATURE_TESTS
only, a FEATURES_DUMP= build, as used by build-test, never sees them and
silently builds without libLLVM, the rust workloads and the jvmti agent.

Record the display features and the jvmti ones that aren't in
FEATURE_TESTS in the dump after the regular feature checks have run.

Fixes: 206dcfca1f5cfac3 ("perf build: Autodetect minimum required llvm-dev version")
Fixes: 3f5dfa472ea6771c ("tools build: Fix rust feature detection")
Cc: James Clark <james.clark@linaro.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 78423b0dcc73ac14..3070947d18772e0e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1313,3 +1313,10 @@ endif
 # tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
+# Features checked outside FEATURE_TESTS aren't part of the test-all fast
+# path, so they have to be checked explicitly and recorded here too,
+# otherwise a FEATURES_DUMP= build silently disables them (llvm-perf,
+# rust and the jvmti agent).
+ifeq ($(FEATURES_DUMP),)
+$(foreach feat,$(filter-out $(FEATURE_TESTS),$(FEATURE_DISPLAY) jvmti jvmti-cmlr),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
+endif
-- 
2.56.1

