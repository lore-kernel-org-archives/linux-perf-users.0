Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471245;
	b=r0uhzvKpu77yS5veStIbVLalz/JNpINBHc9uq6g5T0Jt0NNfZQg5ahWsjwRK5D4v1ApE
	 +2kR9TF/xgHTaGFLQ7E2zJq6zooqtknpoCmsNui8f5+CEZ+CCrgliCCf1P+ZhTbet3FrS
	 +ZV37PTTdR9z/lx2KUjZvgcJflBpcMiwNcSea2XY062Uz4OS+6r2cJlk86ohggOUys4H1
	 SWNjD0e8hFe0DIubegu1E4D7N/Pf2AwZyWP0yVu6JMwoHzxv/etpy9LDBBbesX9je3ydf
	 29QAPzr7Kpk9NJvmpwQfPux2sWvca+Yowjnw91P2Bhjy2B9vgPSgVJ9EeSH97ve9+cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471245;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=roRWIvlWqU8+3akzoi6oZQ2mr1t4JbZ7FcCva5/iuis=;
	b=4yh6a4e7JnVIb/zsUwytZawe3uCEHt0FAcRrxVA05a4hbdTku03bmZSWhH2Xxqa6MSa2
	 rMLGRM0ndhjtSxsA4/DTHMeKc0DpCPGlzANu+k3HvQdorvY3fxFjUT6kPCItPq961ZLqt
	 mkkOJoyBVUq2ZnpUIVOXZHqmuRSpMZCVs65wOmLWSdFLe6P6MpX2EoheUougvpVkOyKPe
	 27iFFrZvpK/gmB5pdp/YhFjUYd/j5C6mbZPNf6hmtjE3PJWUqqlddeiAHBo0txRM5V8bJ
	 pJH8tNn0fErl+mRoW07lN9rZN9XSSC4mUGt9iI8BeDKSZvUc6frGtBXQNaIxNtiFFmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ap7DN1lx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D472F606A321;
	Mon, 23 Nov 2026 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ap7DN1lx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059F21F000CA;
	Mon, 23 Nov 2026 22:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471245;
	bh=roRWIvlWqU8+3akzoi6oZQ2mr1t4JbZ7FcCva5/iuis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ap7DN1lxojf32eVHVwwhGQMDsieatMb5YHyZPVPKXi/TfjBDEvpaS20lP6Ce0/GG7
	 V3uKIoCRCXuZY/gakhvt6dhi0oWhGsIRI03QpOaw0vonQf2EmaL8L56BrCjPEtQewv
	 SlADp2Sw6X0AoyOlc1Jhgnh4Xy//QGOAS9V14lj5QwVMUY6oT5bcFUs/rjtslJqztv
	 APCN7dzh/fjBr+vFDjm4wIQd4z7CriVDpV7yO2uiMVqqrU40HYGSiuNusn4cztAn48
	 OlX9fBNkNn06HeQeGwcXqVfi+xzGgPWTOSZijKcSarRh8qKMR96A0DKfaduDp3gQUb
	 XU+b/e85kZF+Q==
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
Subject: [PATCH v12 04/19] perf build: Record the features checked outside FEATURE_TESTS
Date: Mon, 23 Nov 2026 19:00:09 -0300
Message-ID: <20261123220024.14891-5-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123220024.14891-1-acme@kernel.org>
References: <20261123220024.14891-1-acme@kernel.org>
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

