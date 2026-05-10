Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2CB340A6F;
	Sun, 10 May 2026 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444637; cv=none; b=PuvoomPvk8rc5V4v+YIb6++DXzL9Xmp5U2lhnaFw33JmY/hOYFNblNrnTytuKcQwLJfjh4RUI8z4mfeBChYjLW16098Qr/6pTBMvNwxJRQDpG5HpYoBUpXlmhuyKtGfOkSuknLmJjcE83UqqioBgMx4CgkbThSJi+oYRMmqnllA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444637; c=relaxed/simple;
	bh=oJhIRoQKpQESRRveVO+5Sy8jZ1r3vmYzGKIUy1xXZf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3gMJ5ynjn94z1yh/2pKvtF7+Hsh2qe/K2hQxIoZalcJ5Qfm22poXBxeuXN0dNbGLF2und22wGu+kdYWzO94PeR9NXcvGuilpNmcx3gYoflqYzBEEV+oTGgO6sR2MGZPX3UphecbwkbWF4GEpakj9NQSES0zFr+kywwLoWFNuvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV4LIFgy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV4LIFgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78ECC2BCC7;
	Sun, 10 May 2026 20:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778444637;
	bh=oJhIRoQKpQESRRveVO+5Sy8jZ1r3vmYzGKIUy1xXZf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iV4LIFgyJApq9e4sz6xLC3vPKhlV+62yLjrc/U/vdp77C1wwJJXbjDB+rUF2/Tros
	 Jikk9z/d88PAIsyjayqVRw9cY9+98A2P3GlQQ4lg/DxcmFXjUDaWTqvkf5NgP6nSQz
	 hQDAXHB+H/K1a94ydEVMyAeEXw1uEPeyCjxavhBL7NMcR2zrHamNl+8BIoIuwCOOX8
	 8bxQUDg+/Yx0qS1kXbyPeTXWWAlU7ZVGVr7ghP2x9sC+//f/wqHxF9Dp/vCzzPjzAS
	 ZmVq9Hk+PXiWduxD9COI6cslpHG2r89j6bW25gu9PUDkZEJpQceLBrrbxcSUk9+UZx
	 fGnIVzPap49Dw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH v3 5/7] perf build: Add make check-headers target
Date: Sun, 10 May 2026 13:23:44 -0700
Message-ID: <20260510202346.49853-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510202346.49853-1-namhyung@kernel.org>
References: <20260510202346.49853-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't print header differences during the perf build as it's noisy.
Mostly people won't care and find it annoying.

As it's to improve perf trace beautifier to catch up new changes mostly
in UAPIs, we can make it a separate build target and call it
occasionally.  Make it and build-test related targets phony.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile      | 5 ++++-
 tools/perf/Makefile.perf | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 816d5d84816b3d53..5b713837eede7d52 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -111,6 +111,9 @@ endif # MAKECMDGOALS
 build-test-tarball:
 	@$(MAKE) -f tests/make REUSE_FEATURES_DUMP=1 MK=Makefile SET_PARALLEL=1 --no-print-directory out
 
+check-headers:
+	@./check-headers.sh
+
 #
 # All other targets get passed through:
 #
@@ -118,4 +121,4 @@ endif # MAKECMDGOALS
 	$(print_msg)
 	$(make)
 
-.PHONY: tags TAGS FORCE Makefile
+.PHONY: tags TAGS FORCE Makefile build-test build-test-tarball check-headers
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index cee19c923c0607d2..585637fc934fe6ec 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -285,7 +285,6 @@ goals := $(filter-out all sub-make, $(MAKECMDGOALS))
 $(goals) all: sub-make
 
 sub-make: fixdep
-	@./check-headers.sh
 	$(Q)$(MAKE) FIXDEP_BUILT=1 -f Makefile.perf $(goals)
 
 else # force_fixdep
-- 
2.54.0

