Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706895;
	b=3EgucXkuy8iaS26YnwTAtD6qtX7qFzUBS/pFvYOVMTq7YgVNsNXx/beD4oV+5UPVVEE5
	 k4tQ+zEO05PRg2ONvrtGb4C/gzqXuhruTpxvIb4+WE7/NdNZbJk34mtZC9StRpF2dK3Yz
	 PS/RXlpgZjYRadURkhevdFN3CQvxPZd3BJcdwdu6rjWpYRuoWbSE1zMjIe6ZIz+EHAuvn
	 LBW1UP8UKtNEjpGUnkhZdWekZDStF2QMeHmYMJm+aR4jwiqXFChN3leEn8uComQEFA+s3
	 lYUA5NAeFY7OIuMcQTCKn4OZ8cv+avh85m62ZLqdQhDqFgwI9TtB4F8p6iTRtrA0V9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706895;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6BsHS0JIId02xPyH1khlTudO2pFJc4FlMUWiQXC02bs=;
	b=JqSbAMIqXiLnHt/7m9zHPmXX+dXBbRAN7OdMKNsX18KpV4v5qxKL88PmmV/yIQy9dFJo
	 B7vMwBUflZTlNHtVqSK4KQ5jcTs7g/q6IIlto17Lr84zX/e8SXRnADj/vqT/3LET+vLDE
	 DVNRNxAU+7s1jxZ66U9RogOIG2/L65QVr0Yj076oV29e32myMZZXQilEpIWIg2tWprp5e
	 EEx3EDfGkgwsPSYGI+k0VmamUEjPGVDhTW7JG0TYPCslDtQBdDKia/IrZhvKQNd9EBs0V
	 vysQTxBjiRmR5APaS4baEJn7BsfL151echxq4VNADNoOQypGMg48+cvapev600R1Tdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bIIQveY8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E4606A323;
	Sun, 15 Nov 2026 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bIIQveY8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41A21F000C5;
	Sun, 15 Nov 2026 01:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706895;
	bh=6BsHS0JIId02xPyH1khlTudO2pFJc4FlMUWiQXC02bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bIIQveY8iqew80gwi3orr3dD4CJVorgbK7avnIO4tu8TXPxNZsQcikr6rByVDIbtZ
	 l7KWH2RXhVVBU3dHnH0PNzXjw0HTTXVnb0t8jviZ4kpxBTe3oMgDkZcCVoWWTou1iI
	 Twc1Eh04OnGmqdlu4Lln595nYaAtFr0ai+7klTwV+m3phQCtlDaCIlHcsWDLMjzD0J
	 dvBR3z+dq/gv7qNUngyefw5NZHCSy6PmHPvUxyYQSaqRdIWY+t0E0QaHDyw8weYWga
	 NCbGhFYtneblEYLr6MSamX3VUxgDuBWtkSlbtk0gNPbT78g3446QUiGHtI3ALmY9Vs
	 /RjoTYejnNTsg==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 09/12] perf build: Record the display-only features in FEATURE-DUMP
Date: Sat, 14 Nov 2026 22:40:57 -0300
Message-ID: <20261115014102.2879372-10-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115014102.2879372-1-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
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

