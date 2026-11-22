Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383648;
	b=zLdOBaLREgVk4GFWYy5Vw6pv3HeYTuf7TErwRY/VCL1yY9CG+VjB0UuAsMuwIXEJKFyP
	 wTQFZG6s/yfUlfT4yN5EMkXTKsWRWxQ+LI6WF7A+H4EzEcV8mlhpAa5ZrMH/f0O1V5llb
	 UScfMNiuEBLrY093BW5Oj9yMgkywDciy5y2z4axXAGw/e6F2TQOgmW/zg5s8806mbLqGQ
	 HfMUI2u73y6RZDXpuFPGt3RIsjRQ94bYdWe6SGzeS0dgQN+9lB0SMR6UpWREygMp+TRkF
	 8CQW5dFku4+T8/JjdnnNSnfUE4XIx8pc09GiCS96PSIq5dfkUNwqfk5qOMk1wnxQuTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383648;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=X/jHvMBwgAGpnXcOJInZTL+cGAdtBlhHHRa06zuZiIQ=;
	b=PcBRY+xK3vtSNGnmwac93B6DB0e859gjaXoREK4N55kltJb2FsVQHocptjySEcECZ1Xa
	 9zwhbP/mmXHgKlLLpqEtIq8fbo91kuA84j7N8Fo0EzooWxjcbRQmZzfmaKBdW8xLwhMPE
	 w1XNZ+APAo/GxJSNmsFP5pb8qzXtUuPXtHs14AEYUT4qAA3LaYyHiQtDW9oNu+i32vQlw
	 5Gd/U21PepL3Uaz+30AYgqn8wgv1TZHb3KIkJwUMu4Jn+rqe54HKp1EeSUdheUvEtq1fE
	 SN9VgIXVESLJrRZ3ZsWIxlktm8jeLqXGw2TQU0tyfO7/S0DJm9u60/vB+HLhhOs41EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KyG6x7ho;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FEC606A327;
	Sun, 22 Nov 2026 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KyG6x7ho
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EE61F000C0;
	Sun, 22 Nov 2026 21:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383648;
	bh=X/jHvMBwgAGpnXcOJInZTL+cGAdtBlhHHRa06zuZiIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KyG6x7hopOQ/aPFT5V5NWEIsrhOYX5G90Kfb+0MwuHPZFVfF1S+NwHqlmlhP2170X
	 FrGUOafy3f0sFayf20Ft77bgMSlcN/MNCzXoZ9jR7IsM0IqCsat2r7uZ3YN+Imjx9i
	 zVlab/LpF091qL+tPfZnhAgDE+mVILG3PoMp+iYgjUBO2HGFo61+l3Fa89r8kpKpei
	 UYho3/xc7bafRDSfM2lCwb682OW9M0n2SBWZislpKt+HwS28RfpidQbhah5X+y0kEm
	 cyLiehAwVcmjipC7mCOy2h6U9r9RxiYBLplo5Mkncf7c0yjGb0rFbTv9CiPHQtZyjc
	 SVRUoIz8LOdVQ==
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
Subject: [PATCH v11 04/19] perf build: Record the features checked outside FEATURE_TESTS
Date: Sun, 22 Nov 2026 18:40:10 -0300
Message-ID: <20261122214025.16769-5-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122214025.16769-1-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
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
index 1cee80c531abf434..cb3bdd134f42592f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1364,3 +1364,10 @@ endif
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
2.56.1

