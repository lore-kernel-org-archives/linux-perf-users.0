Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C93A6EE2;
	Sun,  3 May 2026 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777836708; cv=none; b=RiTefxv+83tPXZbJbtw5RYZET/lrd7Tf0Llu+GH6Hp72EGVAndU214pB3JAty3PhT/+1fBjDdcv3VhELkqyDUM+ZhDgAGISsjkBCByc1A/c0zCFkgg2b98hNuDJmeUlMV3SZBCFy157/ZOxoKV9D4Ni1Bh3ViXDp4aenZMhxQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777836708; c=relaxed/simple;
	bh=6HTkwXqMa+yx9EvLjTn2vtMm222peib2SO9qKY0Fzf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbnVTN4j3QrR8vmPRJI7KuL8A2kLOgHL5ySQgJWWIWD4Us/3CBpwSs/uRAgzylwhOmOWP9ImFwuzcjgMG4LjzrwzVUUaZT/Nfef30w++qhXGm+tTQzqqPP8r/20rUbfcGdp//PwA75fuU+BIUMHPpk4JiMHhP2so1G8DulOSMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsoWzojZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsoWzojZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DA1C2BCF6;
	Sun,  3 May 2026 19:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777836708;
	bh=6HTkwXqMa+yx9EvLjTn2vtMm222peib2SO9qKY0Fzf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsoWzojZOuUziJdN43H+smEiFf7jTM8zDVUn5qUMbUib53jdyjqbbpWrziCyxaDU3
	 ujburfeLeG4PxUhOJJV0xWoK6esj/bIsFRAy/oxKH0O0jHBjRzl6dgWv+FLqNOEhlZ
	 qi5t+Qpydfuxz/3uUxrIOZZxK+cf6vnyEmlYo+KKY2FBM8rUlADDwrZlJy6+fBn+Dm
	 9KBDsaCyQgPbRDbEHSm0wSVMbDAZXUthj1YGJlF7RkaVAzpw5q9ZGqSQ1eeM/dpVMZ
	 qhL+jS+tHAMsptBoViBh7+oHrltWWySQcicT65NgXFsULwgJ1mlOQKxk9QV9ZkQtuk
	 3w4sZi2oPy88Q==
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
Subject: [PATCH 5/5] perf build: Add make check-headers target
Date: Sun,  3 May 2026 12:31:37 -0700
Message-ID: <20260503193137.27465-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503193137.27465-1-namhyung@kernel.org>
References: <20260503193137.27465-1-namhyung@kernel.org>
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
occasionally.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile      | 3 +++
 tools/perf/Makefile.perf | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 816d5d84816b3d53..e072a41e05eaab5f 100644
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

