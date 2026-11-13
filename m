Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600559;
	b=iWjXbplFUcB0lm+z8+Q65QMrNvfCK/GqGhv4/WOznpWIxhGWTrW7vwYcaStwESOx+tZZ
	 X3Eap9UhFeaFNNIQ4admPu1id32q8Z5faWebSBdZc0HG4JQGX1XSQJIjzDjU+wBaqUM+8
	 dcmH2jybSgb3SSrF9wnjndPAEFYXVD05WIpA5hSLp0qcBl0978u3lNpQQrgwulr3ZKNXI
	 DMOrKBCWtXqdoOpRyGCPffpCSTiX4xitiAo7C+01koeybhbor9E2LxLd20qAmy2f3OeKf
	 DN6+MQDbzEwasSB2rpKNVmQPQ8nSFj48yjm9MsjBfkgXmisWpsNqhsb0IXaGKT5Y2OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=heKncXN2ESk9KNPzZANxBokZt3UOa99KaEx4tb00rrQ=;
	b=pjJidh1tl86Ir3QRzVkA643BI/fOj5K1Gn7MeV9c3ezafK/i5Uc2dWDHCCy4rqO8Nkls
	 IG4TxdtYyqD6nrBNpSP0JU26+N81H2gUvYRiJwp4Yp+9jU35ElTpmBRK9Fzf4WnjGkAJA
	 RkHY1gBnk/w5Xo6cSiH0FdZmpllqeQWXkEbUIAOdJr1d5BMB08qu0GELSj7n4oeXxtTl1
	 cOgQi7+KEmCRGxqFYV89WhzY8V6QP+O2ojj0kzSHcol98yJey9dLNxqzLQpQOQQu/K9r9
	 1oOKCWyRKDsVOcfn69SyTHs6fv4ZtDBLZc2zSmY570GF/n+0m6pDfywwDN7H1cgIPDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C7VU5EIL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D80606A89E;
	Fri, 13 Nov 2026 20:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C7VU5EIL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D920F1F000C6;
	Fri, 13 Nov 2026 20:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600559;
	bh=heKncXN2ESk9KNPzZANxBokZt3UOa99KaEx4tb00rrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C7VU5EILi2drvLjywTM03MREXGOfEkm7quNUroQ6Z1A8kwLFezZUeMdsSnxQc03vq
	 +6TrDxFY/aQ4T4AYY8zAYGEeFbxv4u661WTtiHw11pxJsIW96iSZFFwInVa9Z1mQg8
	 JsyIu5WrACEFzJJZj3gGAzpCKbWdpay9QusXgldqKhuxuLcscHTa2QN1az8bECAME5
	 FySEojaxG1D6tQKn/R1X5H6YuZ4Qwuk5GjCe3hNdbFcKZaomdtTMyDvOS1KlT9vZki
	 8sy2csrkwrDt8dgXsy31yasmKlCwtcW2ptDjQ82JkKxI09a9iAlxvtDSh1fpD4XZO5
	 snvz6sEyxOARQ==
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
Subject: [PATCH v2 08/11] perf build: Record the display-only features in FEATURE-DUMP
Date: Fri, 13 Nov 2026 17:08:46 -0300
Message-ID: <20261113200850.2803460-9-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113200850.2803460-1-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
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

