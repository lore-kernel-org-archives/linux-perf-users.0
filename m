Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8B36074D;
	Thu,  7 May 2026 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778138803; cv=none; b=jcrMUO12xEAAKiH5Z8KLdm+PzltPGTjKjF98SdyttpI8sWi94A8fHlbay1b+PCaMuDnNOaNkzSVfIEQxD823Jnsaf6UEMYLjU21am7sI0Q4CsOQc+HdbMAoRPojvBEMFGV7gSQZBMtJmGlWyw7/EMIEYT1wg7XlLzBMnsqd9tiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778138803; c=relaxed/simple;
	bh=1HFoIcZ8HLLHxRmuKNcMt3jFKCWpW7J65gWEPS8LFdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeb1WsB58R5hDZszHJ8CzuCQnbXxVlQ+SM7bD9A1Go0ugScderGjZrO7UVSBs/tABBi1zmv/HwVzRBY30U1MRzOYSx1pNqPHa8JjWGNMrKIlOl9HUY28Ujt8JOuf1GkOwh6IlHNjLdr6B2YAWCRq0DnR6aKaVSy2xW7hKCe23Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCLwQIvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCLwQIvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954C0C4AF0B;
	Thu,  7 May 2026 07:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778138803;
	bh=1HFoIcZ8HLLHxRmuKNcMt3jFKCWpW7J65gWEPS8LFdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hCLwQIvtd+kw8Y28ULQwo+Rj0KBvlaDmDCQxyAPgR8gByhDHBFmExzQ+VueGdnYlu
	 MIdPKP3Xb3GtzGeknt2PL6k58vSL4had2HkhJ9/7dtwZEgOPY6LGeulTw6g2Y4lMwJ
	 PRfP4Ulp9adYMGIWencokS30+jgqLfzFIHOSTlKqfBbBbjiU4cbscoz1+dgR2lR9/G
	 C0S2qzyj2cq8RQ24yKdASZ98f2jis6s1cUVjDmXEDC6tlf7+djFTorGOsOZkVPZxSk
	 DjdYFAvfaznwYlwc41v0pEyq4OuQGPe5N08/KaxXTXQD0ZXk84aw0WYPFMEqShY5H9
	 m3TW8eAmWzgJA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH v2 5/7] perf build: Add make check-headers target
Date: Thu,  7 May 2026 00:26:30 -0700
Message-ID: <20260507072632.37152-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507072632.37152-1-namhyung@kernel.org>
References: <20260507072632.37152-1-namhyung@kernel.org>
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
2.53.0

