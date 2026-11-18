Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039078;
	b=MiHQpXK62nlR3/FKPx3LSXuVPKl7H0QmCPA2JCAM/kVV/1L2Qsr3cvOI6NyPBdtq4Tzx
	 1trFCEGXwsKEiVy05D1C1dT3uMRUiMYNvbGIJNRDpQC2XWDDVtEZ09boDuZiz2YnvleUM
	 yIDPCantshTjRPrk0JqqntMhSvo4DX+xFVfTyLJ3sNuARPshIylWdE+KHUYbMNp/rftuM
	 NZ3I0VUcf1onxv3bPbvXCgdaRdKEmPQs6GNf7sSEWICWCNP3awahzy7VniVl4B0YFGX9+
	 UmtbboFwLZRkUhg35AlfaBbh4ORMaecxQHhX05botNT5n+5ZDudfNvBHomeeY487gZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039078;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d/YIR62Xt6veLrnh9dlXozkCz9WvwzQ5rQFE4YDFbCg=;
	b=WlUpU++ddYJ0xoTX9jvWmYAlob+pqqMQEv18CUu9K7R6q6bACcGHnULqxIHiMH8ODtOq
	 swWPZ53YrroIWzpH4apqyS3vbxDHqtXhT3FHO8qnAHKvhcZF8mHUgcRXFhkejTc8UT6v5
	 YXA/x9wBXUb0qBah6/yY8z8h6rg+nBGn+23O9i2vBqe0upz0ik7ydYiSHBtJ4gr0WLiQU
	 M4FzgfkqVPFJDZkCnyHTGs7PF92R3a5sJ5KbALu6IfH9Iz6GJJwyPargE9f4S9XT8K+Ur
	 bKTIlDA83/W/hcDneHJfvCoyPP1zAdJj9MICmtee4TfwleKaxbJRGdXB8hvU0O/uJXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ac1c6x4y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCBF606A32C;
	Wed, 18 Nov 2026 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ac1c6x4y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7171F000D2;
	Wed, 18 Nov 2026 21:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039077;
	bh=d/YIR62Xt6veLrnh9dlXozkCz9WvwzQ5rQFE4YDFbCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ac1c6x4ya1caHc8N/f83bR5jhwVrAN4Xu/9HvftFW0dkyBtvT460SWZPgXIFASmi4
	 1MKnXTVR+yMq277wHqc0jgeejAGTF8HqkYJAab/W/WjL/p8NzhrtL4wkqwLQ7uyAai
	 vnTUrCY4vOf8RssLP0eWp1ldMuOljZKxVju+1hEr8q70n3yhYlcyPZYCXQSyIF3Hf2
	 OtYaLVAZ/DRiYoo7O21rj8Bs7V1UOXieeguX1jjVrwujpLwpGOPJP2m+tfoDJwhOsG
	 laDXg7XrKhWCABnslZrShsWoPUxWyEK6T5fa4g7NASP9G2uxRS8U0gIhtbh7isriWP
	 U/oVbg//OqWVg==
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
Subject: [PATCH v7 10/13] perf build: Record the features checked outside FEATURE_TESTS
Date: Wed, 18 Nov 2026 18:57:12 -0300
Message-ID: <20261118215716.114868-11-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118215716.114868-1-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
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

