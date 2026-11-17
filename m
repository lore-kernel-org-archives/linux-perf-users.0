Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884019;
	b=qnNvvk7Z2Z/elGxw3g5ErCAF4sOBMAIkpam+73mPzzcTj4WRVzSt5JRoc2Y2LPjk58DK
	 rekLI7f4IWlJZ6UtZdpk6a/RRYsKKoVVNjc88ZuwIy9br9c+mJeSFu/B6G/dfiX01k3nS
	 xP32DsWDV+U+c3ybR5j/w3IyQz1uz5JvRhnhU5VgNrhnLU2fgWzlFt5mbyB8YVN34mwEA
	 thbrT/jVJoy+0va7qTQpqGLv2FSzJg8rWubJZV3sCeHm5m/TQEgtHPSd31s86hj10WC1z
	 O5jEyj2c5th6e7ZwsHi2hzN5OGS6+RnwKJYn+I9EkNZQtNlAdvAHrVY1eKatvIxOvrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884019;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TY+X18Hi6/F1HS0HOZKQ0oricYEFFRLC5ne+zNaY40Y=;
	b=TlMaXJc/RSokvbyhcNfQ9d8vUzbyEV6FA/Y4+G4kUw+4uG86zt3/41T5V5BDR2EK+EcU
	 DDWeRiNO6AxowejrPtYt3e/9Va7NrbFtaTXYDkYSK8kNPSJ0Ed0r06na9RR12YTJ4Fut0
	 6sQKIs2fkmRfJpuS1a3jQkzEHQ3oGxKEAtXotrsrjJLTLYaYfmPDGXS1QarB8VileJJOC
	 iEmJ0Hq2V5PGhMdQBu/ChFi0KOqAupJxIBa4M1eHGx/T6c6BpdMrHemBiLh/6NmaPrIuR
	 kc6uK2HxM0wNY++V52d5aTXBX5MMpzfNmae7awUVb1AAeKKq2vUsKwVIDhYFwCauqYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxpXgd8a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAB606A330;
	Tue, 17 Nov 2026 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxpXgd8a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268D51F000C4;
	Tue, 17 Nov 2026 02:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884019;
	bh=TY+X18Hi6/F1HS0HOZKQ0oricYEFFRLC5ne+zNaY40Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AxpXgd8ah10uozEG9Qi2xFAQ/e96LEhjgMis1KaJQ4YurQfGl1HN24uCTR0m2FUy4
	 Q30uG/W5yBzV1UeGId8CtnRyjJxlZSXPGf+wUlnda+QpZhmJ3vKU3WFDPaZkfedAc8
	 8e1eK0j7lbyoQ06oxxa4sV5jdP81mr2ByNvnOGQcRM5OOXj/k84+tAhr/AuzW9nEIS
	 QAtvQ3HhhL0QYrWu1G30tvSBzeNPmj6Vxd8QadJvOpYN9QDG1sIBouSe8y11+Hat1y
	 weBxq8GkZz/HCr/f5w4uIrKPPUYTBsQTNpmPg0cx8GXKh+n89a4ZehvBbNJeU+WzfT
	 QuBvVja79V2jg==
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
Subject: [PATCH v5 09/12] perf build: Record the display-only features in FEATURE-DUMP
Date: Mon, 16 Nov 2026 23:53:01 -0300
Message-ID: <20261117025305.3958882-10-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117025305.3958882-1-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
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

