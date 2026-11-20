Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138387;
	b=LWaoGl18vQKUBmWiGhM7i0PcFYRh9m9vv9n0zNopOrV1XZ05r+LV6ZqjqJWZ/en9GsID
	 o8zRZGZsQ8DnONJHsPj49ovbpNN2L3HUQScEHPZNtEwFTQSBpTk59yfiwq3z6EwcAzTdo
	 962Az3mRUCeuWAsRjuZNZ2cSYlORDOeSQmpvSREQTY/jzvUJyyeJLn5Kx4dovBdf98975
	 NZXGMHmobBn53ZNpnJLaUdSr/h5BESillL0jc5HVUQH8vmsLWbYIC/NbZMPfH2WUV96yA
	 aegeRR/3l/bk2H1v7fCaFy0FplqdqChrlUveNcs6EKKiDvmSoUmDGSw0zq/a0+6D+zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138387;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d/YIR62Xt6veLrnh9dlXozkCz9WvwzQ5rQFE4YDFbCg=;
	b=cgee/mIz6+ivVKAz0jEdwkmi00wzjXSH13orEPNJvPNCLdJMsUD0mZ34e/xSd4jVX2sp
	 NZdw3ef4fm1y7y8k/xX711cQiOMdCHQC25Y0XRdOyDJ6t1lGVuQCRcTljOGPwW273ZG4S
	 bHEbeBGGi0y2m26PQu3pocENzhGpepLZfzrpUlHEKq5ELXYxNoH7tNkRj6YAoAfRvv3yJ
	 fgMe+9AN9IF2jgjThX7zCiNUTL6Rjd1kkkXckh9GonmctJu5VBuh+UiXAMKbfqMjqUn0c
	 7fNYqYXE9StNU7XyxdLqYoLKLGCne/qzAK6KQr2qaO6XipXvqpVLu/K7D1qTptjE/eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5xRorMy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74373606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5xRorMy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D781F000CA;
	Fri, 20 Nov 2026 01:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138387;
	bh=d/YIR62Xt6veLrnh9dlXozkCz9WvwzQ5rQFE4YDFbCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L5xRorMyGa5LKaO9NJOjzYbjnwxzyVl6UCs2BlUjz621RuN/RMrLMRP+UGkDwPGtl
	 uA1KN+4mLIuaUog4f4MrhAsqWbgz25sbJgXXIAh4/XU+YuCKG3DO7Ljyhnk7I/JD4g
	 3eW/lMLYVmdLv144bjr7UXoVaFOTKldn2pkbvR/FAqBmkGhOn6KbAC00p1guwQ5z/U
	 ig5GqR8GlavYcCBLOs0l5T0hZmC3UGrkcmHByCJq0RFof5kng+MRe92LnkGpYhknyu
	 Fgc08IN9bDfeqPpf39YL7iiBTvIir6gtjSrTdXZdFpgmH1/aTbSGi0vmw/XFV/HySn
	 CuQVZ5R/iB3jA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 10/13] perf build: Record the features checked outside FEATURE_TESTS
Date: Thu, 19 Nov 2026 22:32:05 -0300
Message-ID: <20261120013211.1510-11-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120013211.1510-1-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
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
index 78423b0dcc73ac14..3070947d18772e0e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1313,3 +1313,10 @@ endif
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
2.56.1

