Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E022E3B38AC
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385533; cv=none; b=dXhPS7gIjNxP+hFWutq5aAyuTpE2TXyFALJINfgQEKSZJ9Y1BguDm79bxsvjWEhRqgo1yFmS11o70zbYGqNZe3rbLf62tJmn8DBSQAp0hsHzaGMSduJDZSjMKH3Z2b+BaZw9kxdYAENATwTdGDEjUd2hgqHlfyjf8/Mr4SXH2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385533; c=relaxed/simple;
	bh=DgJy33f3qaFp+PUFLJjCzac2PYOqX/26bXyhRtGVTFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sQxMto4fgo5F631hpvspI+0ymfOJplgjDL00ztZ+S+L7zdGxL+QbZUztK85YP7lULh5o+TOHKJGaUuiIMR1OFM4xRBANuDkq0EV3SXPZp6QCeXYaDYiXWjh0p1labBnVEFb8pBSthT5ZFa/T3NZYUASEourLhwiIzAtnpRElZ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nsR76+wY; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nsR76+wY"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13537722193so17824337c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 00:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780385527; x=1780990327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Va+s/EEbKn/51zgYeOxmoieRWOD/n3cBCji4k/GXkQs=;
        b=nsR76+wY8PoEmaRoLnAPWNnod3hAFoqbJLT3MOo1Y8wFN6XybhIsTWkb3MFUXN7FHC
         +Mpr8mbNOZFWFBqFEKZwvQI3OgziGRI7zbKK0cnhO56I7t3xgag/sDS+TfRiMT55Vgus
         oJVmTsYksTCLuEtR6yjXYtqj6tZ7nlocOdqJvKRcIH+appr/o8avIHZlCyqL7a0mSUAz
         /BCIjAzcArfGPoWBYktmlx7Fqbn0+gCFK2tynm9A09Z3IXq6Z+R7LcLRP+aVOfIG/+6L
         1M4JHn4ZH6jkjzFDxZ1poSFDttLyfObwOTnFAOusGd5cKFwoxpYg8L9MfzNfsUfira3E
         5Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385527; x=1780990327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Va+s/EEbKn/51zgYeOxmoieRWOD/n3cBCji4k/GXkQs=;
        b=mAH5iJz4SMkqMYEYQ4ZQX1U3cDNd0uAqHltYCkwNFrpiC0t9EMzXZV/Z7fJd5pnSb5
         jSOOCByw8CrOPkVMTpR2vORihbr61bmZdSDmIbtNAkBvcbZecDOehRRYc1QlUmhwpPut
         16g/AiksFT4m4wB95D5DWsmjZjO/LsrbBLcHb5m2VoIfPfvK0Vv0tIeuH3jpuq9vMx3k
         lQ/51x/3OrOubfk4vpYIZDM2wa+IHs81zeZCbwYWEF8Kti8eJPdmyotwG7rjwCbZ15d0
         vq2C32pvJ8M66Fho4GsH9UWjGduOJ7O7STRQ7UBd88ZOPSkuGCrnVpX0UCkWsp8eViFk
         3fCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9XiCT4GCWg8pOi/DrsBnHJ4a5UBgfMR4uJ7OuHRc7fexob27TFZOYtcqlVf75UYzAt5hAt+VxWXqDHlFCeRKd7@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZzpoz4+w+D9jjY0Zlv7FDeayWqoLQxvXphC2WYNIrMaIBQyD
	3NXK39Pg6je6fEMK6dTzYOAi1nM9hvNDuqXObEY1X2eeoIKRQxd8W/+NjlW+iQRu0kc74rWwZff
	Mw06yA8w7qA==
X-Received: from dlbbo37.prod.google.com ([2002:a05:7022:43a5:b0:135:d0cf:93de])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:981:b0:135:52d3:d9de
 with SMTP id a92af1059eb24-137d3f0cd3emr7093132c88.15.1780385526646; Tue, 02
 Jun 2026 00:32:06 -0700 (PDT)
Date: Tue,  2 Jun 2026 00:31:28 -0700
In-Reply-To: <20260602073132.2653307-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601061401.1541457-1-irogers@google.com> <20260602073132.2653307-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602073132.2653307-14-irogers@google.com>
Subject: [PATCH v7] perf test: Split monolithic 'util' test suite into sub-tests
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Refactor the monolithic 'util' test suite into distinct 'String
replacement' and 'BLAKE2s hash' sub-tests using the struct test_case
framework. This improves test reporting granularity and is used in a
subsequent perf test for JUnit XML test result reporting.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/util.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/util.c b/tools/perf/tests/util.c
index bf2c5b133884..f9abd9911e6c 100644
--- a/tools/perf/tests/util.c
+++ b/tools/perf/tests/util.c
@@ -86,7 +86,12 @@ static int test_blake2s(void)
 	return 0;
 }
 
-static int test__util(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
+static int test__blake2s_case(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
+{
+	return test_blake2s();
+}
+
+static int test__strreplace(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("empty string", test_strreplace(' ', "", "123", ""));
 	TEST_ASSERT_VAL("no match", test_strreplace('5', "123", "4", "123"));
@@ -95,7 +100,16 @@ static int test__util(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	TEST_ASSERT_VAL("replace long", test_strreplace('a', "abcabc", "longlong",
 							"longlongbclonglongbc"));
 
-	return test_blake2s();
+	return 0;
 }
 
-DEFINE_SUITE("util", util);
+static struct test_case tests__util[] = {
+	TEST_CASE("String replacement", strreplace),
+	TEST_CASE("BLAKE2s hash", blake2s_case),
+	{ .name = NULL, }
+};
+
+struct test_suite suite__util = {
+	.desc = "util",
+	.test_cases = tests__util,
+};
-- 
2.54.0.929.g9b7fa37559-goog

