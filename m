Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582385;
	b=IdgeocdcP3dkPO87PiXLxBINy5VCT541uOtpvzH+4i8xAew6JLEfpc0HZiIQYiEsuWWH
	 DMBj/iEJzu30cpNDoNGfZU/OOCGFvAVfumAzNjkgsqKh/JMmmxdhqu080RihXkQJWQjsh
	 RIvjFoYWYyhWp6itHfUHkaa1ApuoKMQvS0NcEJdTK+WL3F7DwvNIN7rEXsm2/k/ysxBu6
	 BivyP/XDg3lgfXjz7iTPTD3Ag2aX96dC4ElWWOpXgd+9Y+0iywX6tae4GLNcPJs40F/aW
	 2yBZKj4K74WjdgARHPQQ0qF2hiaHrIYEcU9Tm17UjY/pHIYiATZccmiysg/XesYPe3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582385;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=heKncXN2ESk9KNPzZANxBokZt3UOa99KaEx4tb00rrQ=;
	b=Czaup6GBl1MXq9XK94x7fn30WiAjiQHr8kdVxQYf857gboJYUPZj6m7XqQqwU5JKekBk
	 /FDkEalyjtdGnWF9DleOfmLeaBx3sscMFGFPERA8MgxSAaleXZxzy7bsk3F6rpaLXpJ1s
	 BKrN9DavzsV2f8RodGk9VTpphPLqJlxAnpdUElpoSSFDtRh8D61wU5JvsF+ZGkvml0YJJ
	 sdm6w3sGP7p0lvSh3l/ZopgB2nEaw4R5SI/ipGOLmxRW4ohdzIE6pamX2eLiFycOT1o3b
	 jGxvWRkab1UNIPK0HSDhoMjDm/5DZSpMPxLd7a5VogpvVKa/3runF68WIE6zrYGq55w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fnk7FqAx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5360A3828;
	Fri, 13 Nov 2026 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fnk7FqAx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F2C1F000C6;
	Fri, 13 Nov 2026 15:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582385;
	bh=heKncXN2ESk9KNPzZANxBokZt3UOa99KaEx4tb00rrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fnk7FqAxpSVCpNcFpuLc52WpcObncRVHxyP6YyrDgbK/OnQ7RMxaK3FKciRk8fikG
	 BW8niFcyQib2JLb1TnpXT19I3pwYRtRAIXk02CGLqeshIty2QBOrPlzmGY5JeF2od5
	 I3TPJcmkr6LlHSd86BYtGcF0w7V0SWF+ShtWXS3OZsiQJqff8Xc6QMnpc0OdWpnA3B
	 IBuq9B4/P3LJiwMdCT1TN22KJEYCt2ToPjtEjw56Q4lnKtmwn+AgcF9x9e/N19DTO+
	 8F+5IPa2mXEoCUEo6Y03bPZ0SYxldQbTY45MeQjMycDvgdVSb7cEZLEArQTe8Nc/QZ
	 8wXY8xLXvmcOg==
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
Subject: [PATCH v1 08/12] perf build: Record the display-only features in FEATURE-DUMP
Date: Fri, 13 Nov 2026 12:05:49 -0300
Message-ID: <20261113150555.1163049-9-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113150555.1163049-1-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
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

