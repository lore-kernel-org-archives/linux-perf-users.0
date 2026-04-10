Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFD73B7B72
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819131; cv=none; b=T+ShjnFd2HKeHqMPn7TIsfTkSf9lYnaXqSXwbyGwybok2cKwlXrmcSua3USwX5sNpWUr/nKyftoR5dLF5CwxzvWz/6cOeHkdmIAv34cmu7GvGmpTIoqZU/i/4m3dX04PBAKTbOvjUzNIkyHCtOJzKUgWX2qM4AVaHAG86NuXEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819131; c=relaxed/simple;
	bh=C4TzoVHzgf1rGpQWQodks9joyvbgLfJGekKr3dHfEuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jUwNSOJHkQn2ulYi/ipHZv4CB0pisEF7hVf/Ezn2TgQME0C08+jpO36eMrq3B8yZdDEesW3M0UpjFHEbiz6gzW16ijpJ7nzbvoV6Jfgp5L07eHkQAFY2Fs6yx4xdl6mnrv4+xOSLN+7cezTi9A9lsWP7EQm+uFXLZiV6+pQhUd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M2WalfgO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2WalfgO"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf7683a28so1246261f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 04:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775819126; x=1776423926; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6RQ1iN4kZujA3tCfjxC7Q5lmyqTavIYDLPFwYDheVU=;
        b=M2WalfgOlheTBdQccBcnEtCdbx4hcd+i4mhflj3OqgEUf2lHdg9Z1UeXUzSRXpL2vl
         pII027urvmQyEtHucfA79+pdXZupRQrQz+iKKDzWysDDIT/yKK6t0ngJmkxx4g3U6EbU
         imM0aqkWrQeRnSsV7xgOn7yMMfzC1SGhYYTsupGnWN2DJ3eGZWe+1UzhpbTzEvR6Kos3
         K4VqEwe/viSFFQlrQe7DnQc5BxNeI8zC3XbpXP0JSOWIcV++TD5LIyWMHhleFHd8DYrA
         WrINJqq8eDtW66Yi2RjEoUpcXiIDEZYgHYbRuKNPTHU5wWa0Q0YIjaFwOCwpVwJP+ul+
         PSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775819126; x=1776423926;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6RQ1iN4kZujA3tCfjxC7Q5lmyqTavIYDLPFwYDheVU=;
        b=XvVcg6R/Pn1V2KJt+VUzVwWD7sarjUuC1CYNQh84R09e7uuFjwq5N0OVlblFJp53Yw
         0I4mW4o2R6GzKZS23vZ7V5rPK/5j8unNezZf7ObJ11HJLpdOiLl61YwNg/YK3uYObdjK
         nNjdqfqN171rr8VSt4vGYXCAfzz5iqpJ/6r/N/UYvPJGuTwJQBcDFZN2BwJd7eK5XBAB
         BFHRFa0chFxHKlOUyhFZcER7+WzGMoWQeheMmPa1KiQipIpeQbkWzt9FJEz9b4OzxgMG
         rNqGX9PpxIft7EqzPkFq+Usqia4amwuDku5yAB01wj3aHidYOCuKN5prNXEDGEi0cFqy
         PmKA==
X-Forwarded-Encrypted: i=1; AJvYcCVv/DA61FsRML58CbPDO3TnfF9e7tswfilsKaIU7rpB3igZOFx0ULEai8Z+HYL1GQhCKbx2uC0WoDXO8aFkoJLA@vger.kernel.org
X-Gm-Message-State: AOJu0YwSj5gicPDREYAOF2j1WdhTFfQp6uO4vOAn506IaQ+pnszI1V46
	m636WnsCG2b/YotuorE6QTQRk8B/f9K5xvISQwLlBS5LR8RGka5yBjn6LFjujGg/sr0=
X-Gm-Gg: AeBDieufb6qaaAuBpLPLotedv6S0et49RhkxrgmWtT6IidTUo+QHDll2W7CbGA3V8oe
	qu3iZTym7vj1bUOjNIfw6Lef2jjb9riMOFXYBAm+FMehaC+AO3545M3LEMQqtrBLLwPhgpBDs/f
	tsSup3iqrs0Uz5EKVDatQyp22PXrJoIHdUxEQSfoIo7zbDr9NHEotEFJpniZ8ln5JzxYEgA9qzC
	JQAMkKbPANH7Ev0IHzFwLt6CJ+ELdd0u9DWyw/nK4kgTWAFFYyT+iPfUib5QeSiMkAeC2BaMCY+
	nejDlCUcGOb/aHD6KebZ4Q/+MI2h1lYPWPClXHeHmgywmSsNjzeeyoI60yYQ0zBKaDVfDFj4qWq
	blebHj5s2mQYHJBgoALprBhhvwnDQwRRbVnP8aorLrpjFDhKf+Y62iHpioEy7kgmzRfuw8rekNz
	k8WH1KRnnIFrWET/KM3Wyhf1JXeW8iTwjm
X-Received: by 2002:a5d:5d83:0:b0:43d:30af:a173 with SMTP id ffacd0b85a97d-43d64259b7emr3790576f8f.5.1775819125672;
        Fri, 10 Apr 2026 04:05:25 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5ccdasm6896930f8f.34.2026.04.10.04.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 04:05:25 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 10 Apr 2026 12:05:12 +0100
Subject: [PATCH] perf arm-spe: Don't warn about the discard bit if it
 doesn't exist
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-james-spe-discard-warning-v1-1-985c02756ee4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGfZ2GkC/x3MTQqDQAxA4atI1gbGqT+0VxEX6UzUCJ1KAlaQu
 btDl9/ivQuMVdjgVV2gfIjJNxU0dQVhpbQwSiwG73zv2sbhRh82tJ0xigXSiD/SJGlB1z7ffqD
 uQRSg9LvyLOf/PU453y4G0kJrAAAA
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Opening an SPE event shows a warning that doesn't concern the user:

  $ perf record -e arm_spe
  Unknown/empty format name: discard

Perf only wants to know if the discard bit is set for configuring the
event, not in response to anything the user has done. Fix it by adding
another helper that returns if a config bit exists without warning.

We should probably keep the warning in evsel__get_config_val() to avoid
having every caller having to do it, and most format bits should never
be missing.

Add a test for the new helper. Rename the parent test function to be
more generic rather than adding a new one as it requires a lot of
boilerplate.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c |  3 ++-
 tools/perf/tests/pmu.c               | 11 +++++++++--
 tools/perf/util/evsel.c              |  6 ++++++
 tools/perf/util/evsel.h              |  1 +
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index f00d72d087fc..91bb28cad79a 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -428,7 +428,8 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	evlist__for_each_entry_safe(evlist, tmp, evsel) {
 		if (evsel__is_aux_event(evsel)) {
 			arm_spe_setup_evsel(evsel, cpus);
-			if (!evsel__get_config_val(evsel, "discard", &discard_bit))
+			if (evsel__config_exists(evsel, "discard") &&
+			    !evsel__get_config_val(evsel, "discard", &discard_bit))
 				discard = !!discard_bit;
 		}
 	}
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 0ebf2d7b2cb4..d7be9d1c6f52 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -201,7 +201,8 @@ static int test__pmu_format(struct test_suite *test __maybe_unused, int subtest
 	return ret;
 }
 
-static int test__pmu_usr_chgs(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+static int test__pmu_config_helpers(struct test_suite *test __maybe_unused,
+				    int subtest __maybe_unused)
 {
 	const char *event = "perf-pmu-test/config=15,config1=4,krava02=170,"
 			    "krava03=1,krava11=27,krava12=1/";
@@ -236,6 +237,12 @@ static int test__pmu_usr_chgs(struct test_suite *test __maybe_unused, int subtes
 	}
 	evsel = evlist__first(evlist);
 
+	/* Test evsel__config_exists() */
+	TEST_ASSERT_EQUAL("krava01 should exist",
+			  evsel__config_exists(evsel, "krava01"), true);
+	TEST_ASSERT_EQUAL("krava99 should not exist",
+			  evsel__config_exists(evsel, "krava99"), false);
+
 	/*
 	 * Set via config=15, krava01 bits 0-1
 	 * Set via config1=4, krava11 bit 1
@@ -629,7 +636,7 @@ static struct test_case tests__pmu[] = {
 	TEST_CASE("PMU name combining", name_len),
 	TEST_CASE("PMU name comparison", name_cmp),
 	TEST_CASE("PMU cmdline match", pmu_match),
-	TEST_CASE("PMU user config changes", pmu_usr_chgs),
+	TEST_CASE("PMU config helpers", pmu_config_helpers),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2ee87fd84d3e..685c4118aef3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1396,6 +1396,12 @@ void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
 	perf_pmu__format_pack(format->bits, val, vp, /*zero=*/true);
 }
 
+bool evsel__config_exists(const struct evsel *evsel, const char *config_name)
+{
+	struct perf_pmu_format *format = pmu_find_format(&evsel->pmu->format, config_name);
+
+	return format && !bitmap_empty(format->bits, PERF_PMU_FORMAT_BITS);
+}
 
 int evsel__get_config_val(const struct evsel *evsel, const char *config_name,
 			  u64 *val)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 339b5c08a33d..a255ae2b1f8e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -578,6 +578,7 @@ void evsel__uniquify_counter(struct evsel *counter);
 	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
 
 u64 evsel__bitfield_swap_branch_flags(u64 value);
+bool evsel__config_exists(const struct evsel *evsel, const char *config_name);
 int evsel__get_config_val(const struct evsel *evsel, const char *config_name,
 			  u64 *val);
 void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,

---
base-commit: 4cf1f549bbcdfea9c20df52994bb342677472dcd
change-id: 20260410-james-spe-discard-warning-049b27a53aac

Best regards,
-- 
James Clark <james.clark@linaro.org>

