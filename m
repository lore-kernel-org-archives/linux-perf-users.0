Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231275;
	b=4RSDH0JiQssEcM76DcdiJumAnTALhSDIMfpcwwP7HWgSN8JJxBx72suhgxNunbvrX1IC
	 OIbQE+fWY9A7/Iy/1HgR6ENXz1atqv4khliLbJe5+DQWcMpGXnqze3FXiIJTPf/7Clisn
	 oiawz9Y+tPeMZLfE7xiY3Rt5zPMRJvk7j6QZPYl4CgqugYfc/M/vPfnXtMkOrZYTNIhq9
	 a31XG6X7aPuHPmRkIM+wLkw3D+fysK61nS4xrz7B31ZFcMDNpSg82oWQsRNhdUtQOLiQI
	 E8QUZxswkNzkXN+nc9PmDz9JV81VlrND2DeTCu9qZPWShXXuWm3tIzWv+sgrAs19zQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231275;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=31RBj6xJexhr7Im8AEJkX98C8hNNQL5wWlUXijqEqMg=;
	b=ANKwcdYT2S05zbmjSZaJN1nMf7IQh76PS1bMSFIuAkHQpkyzg4txa3CTtBmBKymsdvu0
	 6Q+uuwYVoqds1Hf52qaLoVRQnXmjC2krAcbfMSj45yMOCQeqWyrUqxjDpfIvg/F+q3qry
	 Rkf+ExOYUvyKtn1iGwzxkt2wBxhJshXQGXYsLxLFj2NdcJW+TxiKE6c5xX53KYxTVAj6g
	 BCs4ulQ/EesxEauY5/J7tMbVwmJf2iO1LKRRYK6FErpWK5V06KjWN48/fzBqow7iH5w6N
	 yUsk4dMYV5XUdXjntLg7e8StMwYjgutQhw8PZy3uofde3ZB4J9WVbNVHUU07mNMRjKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsHYYTBG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB0606A68A;
	Sat, 21 Nov 2026 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsHYYTBG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D420D1F000D0;
	Sat, 21 Nov 2026 03:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231274;
	bh=31RBj6xJexhr7Im8AEJkX98C8hNNQL5wWlUXijqEqMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CsHYYTBG6/qPENzAgwLv1QKaPDOl0dS27i/8P1KUH5xBdiUliISnzkQYsb/temuu/
	 Skt9BSc3EdwqHoJwwpDT1UwNnoOT+ulKL6x5H8E6fAeKBj43aqDsM0kUGyABdnSK+o
	 vbn20vT9aNFQWYKzdfXWbvVvEomanCH9sQBQYywu5ihXCtPnF0n77uCfVYQ4qjfewi
	 9jMTN54dgdi1cUZt193oQlQH+dtea7i4OL6yWMPT3JcdabNvpxIcDfx6JPck0N0pOW
	 z7GFk/Htg3lryp6lU1Y0fT43aVaDASU8vtVG6jYLX5HrBVe7B6eqEBzRpOZPqDcjpz
	 e9SMSjJl40xNw==
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
Subject: [PATCH v10 04/16] perf build: Record the features checked outside FEATURE_TESTS
Date: Sat, 21 Nov 2026 00:20:40 -0300
Message-ID: <20261121032052.1392234-5-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121032052.1392234-1-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
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

Record the display features and the jvmti ones that aren't in
FEATURE_TESTS in the dump after the regular feature checks have run.

Fixes: 206dcfca1f5cfac3 ("perf build: Autodetect minimum required llvm-dev version")
Fixes: 3f5dfa472ea6771c ("tools build: Fix rust feature detection")
Cc: James Clark <james.clark@linaro.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 1cee80c531abf434..9613594b40e82179 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1364,3 +1364,10 @@ endif
 # tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
+# Features checked outside FEATURE_TESTS aren't part of the test-all fast
+# path, so they have to be checked explicitly and recorded here too,
+# otherwise a FEATURES_DUMP= build silently disables them (llvm-perf,
+# rust and the jvmti agent).
+ifeq ($(FEATURES_DUMP),)
+$(foreach feat,$(filter-out $(FEATURE_TESTS),$(FEATURE_DISPLAY) jvmti jvmti-cmlr),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
+endif
-- 
2.56.0

