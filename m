Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945908;
	b=szOyZe4wOwc59DUcdogBiq6lRmV2XCHL30akGGEKW8pW+PHJhyaaVzn5n9ld5zZwpOpM
	 m/qI9COBZVDWDnvM5OLGAYpgzxpwj9gtQ8geBjgPp0pDhNuyv00aisZvf+I3eAhgIU+6i
	 olOPxhDAXWZr/cqSvwZe+7sgtr1XnTYnDAR5LvN1EWMVbYH0Bk9WrLfNF7oUG/00djHFr
	 8oKTSiK9CALLt+0dxOeIbX52jpygmul9SvwX9q+cxvU74ASOjr0w6XnQVZCuabKZPrB3R
	 IRlE2TMRy1Vdddah8d/eFfQFWsdGBl3CVb1hooAz/MXnOFfHzeDsQRcUsomJlAYq/3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945908;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TY+X18Hi6/F1HS0HOZKQ0oricYEFFRLC5ne+zNaY40Y=;
	b=3PEh13T6XMx6Vm/tcy0P0KIUjlzvKs0vDlQnTworaAqBPmVMcMpHNRZ9uNuDCL2WHKwS
	 zbH/z2tT2Q6kXQtIKqKflCO9iBLAAgbNBPoG1H/x+qYNoiBIx7Jlyt3NzGfwfjxflzFbg
	 yD2KXRV1UPzRxn7jNHac40BtpdTxJ+VS3WcdABrKhOR2AUvdKLLQaXn3KhjKisx1TxqsJ
	 FIIPXVE+EAWpDyrqZ8/auUjDJ/qwa8mYE9cigDXQNMBB21ZbIS9QI1VmS4+0NXOLjlsDJ
	 s5kPy+RDCJqum+K5v00bNPG7Q/TV8jXEz6asYNiO84pnh71axnRjyLUrj6sW0PiHKJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KetXJaDV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C13606A89A;
	Tue, 17 Nov 2026 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KetXJaDV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B211F000C5;
	Tue, 17 Nov 2026 20:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794945908;
	bh=TY+X18Hi6/F1HS0HOZKQ0oricYEFFRLC5ne+zNaY40Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KetXJaDV0jSxTko+4odMR4LYAo9dN29eM9+PjVIzkRkJVDft/S08kkeAHKzxAGmW7
	 PTZX0+novl4wC5bU0qR19uqMWL5CktWSzrocw5IBGVUfMoYLF1uPytFTYs7dDenPHm
	 WY/GL9hRh9jKvibb6I4opTcqX/ZlPc2ViDAlfrh/p0j6S4i1pLR2ZklWIh8hSSPOyQ
	 yswgpuWlJHk1Mv5yldGfzbEBKJopDM9Aavo+QTW37IyLOiWIuAR/2F+Sb+ThDIhkJ2
	 Yj9hk8UlEQudKrEWdqVyqQ9wx7Ptx6Tq5UC8gw/oK/Z/hy1bgoFPsU/nbNO2+Nikr6
	 +UlPX2VMVJsWg==
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
Subject: [PATCH v6 10/13] perf build: Record the display-only features in FEATURE-DUMP
Date: Tue, 17 Nov 2026 17:04:28 -0300
Message-ID: <20261117200433.45174-11-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117200433.45174-1-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
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
index 78423b0dcc73ac14..baef6b534e8aa8dc 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1313,3 +1313,7 @@ endif
 # tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
+# Features only in FEATURE_DISPLAY aren't part of the test-all fast path, so
+# they have to be checked explicitly and recorded here too, otherwise a
+# FEATURES_DUMP= build silently disables them (llvm-perf, rust).
+$(foreach feat,$(filter-out $(FEATURE_TESTS),$(FEATURE_DISPLAY)),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
-- 
2.56.0

