Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5628EA
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Nov 2024 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147806; cv=none; b=Jmi/VsvhrYJo/CkYRdUDg9+qzUuC55dJHELXNaJ/lqEELvcN++7T+Jh5G/ikFGAMfiwoIcF6Zjv9AJeGeGzHnTbXlQ5Nst8k1fedB7XpdtXUkjTOYB6SAfE6gWrvHyah00GkfOSyhQhjQ3DxsoiBZwelKJpR5NTMkoPsIFf9kfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147806; c=relaxed/simple;
	bh=O/yMNZrirBScAgKI94cBzqEnvOowo0MA6z0q16DxO1A=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=isJefjCTvN8aBTM3nYs3E7kpCnHVSGsJftGLIiLM1UJ2pk1uHv3AF4Hh2k3vCQ3TZv+tL2CXgkX8/3oL5L2vR+kXrLn9k3O+8gqmtuLO+rQokU51dhSiVZQmcTR0GYYpjPLt4gKY9R8NOioSFJR8QW39y/ls4VKTGq1bqcByvxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ajyfkrv6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ajyfkrv6"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eec33c5c50so5240407b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 16:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732147802; x=1732752602; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uGFxFptMJQAFIjN9wGwiYhVq63M4S9vZgunlbNZee5s=;
        b=Ajyfkrv615pYU0OoW9g9GyvbMhPAgKObeGPTv7N7eMRiGutkFURpyT8PeyLQtPkFC9
         dgcjNmpTWFN8R9hRYHaiySTZKdE1fyg6l2Cvus6MpptFNR4XXotrLTGvZ9jiqT7pXoEI
         pxTCztFVVGYC79tZHe6AD9nfZDKEbOcoYzx6XrHDjK4ZzUP5uAPFsIgOKnvkjYZk+gtW
         YHOtYEyJyODEbVTePBE9C3tQFnUhRs+IPLtYlPjuSBGNczSwE2hn3Kcq1ueXBwVR7YDA
         0yi0NGBohgXgbv8nYqdpvLfUmBD1EKqD4CRVAFMiyQUguKbqOQpjwihwU22vyBQEYo3L
         P8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732147802; x=1732752602;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGFxFptMJQAFIjN9wGwiYhVq63M4S9vZgunlbNZee5s=;
        b=X+agsjHr1GnCzajT1c8yZEOMO7g/mGsV83yftTX61lM1Dx52uRPp8E7JdA4xXLsFpd
         a3WkeKMWVUl0L2emKj4YJZ6/bptDj605kuVgovljYniiQsGFETBjJjPGJc4MBIIhrVM/
         wPkZSyjpQY9ArpmfAkuWpmsJDCocLzoGjjEEnZG+cCGzLPx+GGdWC3Lgke3NjOChAkoU
         FgSF/FB47DVkDWYFkWCkH6PG9BoDI5P0epoX94QyNnMBcdR7gdLU1pT1+avumtJw9LWd
         4fVf5vwP8XpXXAEOJROddphsxy96FiGugfkm38h/wfp/inXYlCUE0bAS89vdJYgEwyyc
         ycnA==
X-Forwarded-Encrypted: i=1; AJvYcCXWR6BXMyu0YpVZQk3w0sQwf7OrepBCOSXRlrbPeOWQyCKshTEmEVBHpjTQdKSAKNpqRLINOlhDu+23/m5YayYh@vger.kernel.org
X-Gm-Message-State: AOJu0YxHuXHx7Yjkj1qbaTjwMlOfGE2Oy6rWW6CWo5yXlHYRwYlOqE2H
	fVcYlQRnHaJqW8aXqLIaKGhGZXmwYeDQTCKeIhSbgkceHMdUJl3afwql2VMHr+WfddcIKJO2GcW
	ikwpv/A==
X-Google-Smtp-Source: AGHT+IHVbGrkkREFtXXgtVDR4qO5j4+SwvySXmNQ3eAKZklqlUbszdYFgWrGlTLJBuH3HqU2LOVdOjgdHiAi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f0ab:b1c6:6df2:ed2a])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b10:b0:6e3:f32:5fc8 with SMTP id
 00721157ae682-6eebd141ff1mr52667b3.1.1732147802352; Wed, 20 Nov 2024 16:10:02
 -0800 (PST)
Date: Wed, 20 Nov 2024 16:09:55 -0800
Message-Id: <20241121000955.536930-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Subject: [PATCH v1] perf tests: Fix hwmon parsing with PMU name test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Incorrectly the hwmon with PMU name test didn't pass "true". Fix and
address issue with hwmon_pmu__config_terms needing to load events - a
load bearing assert fired. Also fix missing list deletion when putting
the hwmon test PMU and lower some debug warnings to make the hwmon PMU
less spammy in verbose mode.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/hwmon_pmu.c |  5 +++--
 tools/perf/util/hwmon_pmu.c  | 16 ++++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index d8bc71b51599..b4656529146e 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -41,6 +41,7 @@ static int test_pmu_put(const char *dir, struct perf_pmu *hwm)
 	if (ret)
 		pr_err("Failure to \"%s\"\n", buf);
 
+	list_del(&hwm->list);
 	perf_pmu__delete(hwm);
 	return ret;
 }
@@ -147,7 +148,7 @@ static int do_test(size_t i, bool with_pmu, bool with_alias)
 	}
 
 	if (with_pmu)
-		snprintf(str, sizeof(str), "/%s/", test_event);
+		snprintf(str, sizeof(str), "hwmon_a_test_hwmon_pmu/%s/", test_event);
 	else
 		strlcpy(str, test_event, sizeof(str));
 
@@ -230,7 +231,7 @@ static int test__hwmon_pmu_without_pmu(struct test_suite *test __maybe_unused,
 static int test__hwmon_pmu_with_pmu(struct test_suite *test __maybe_unused,
 				   int subtest __maybe_unused)
 {
-	return test__hwmon_pmu(/*with_pmu=*/false);
+	return test__hwmon_pmu(/*with_pmu=*/true);
 }
 
 static int test__parse_hwmon_filename(struct test_suite *test __maybe_unused,
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 4d9d6f405434..e61429b38ba7 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -197,13 +197,13 @@ bool parse_hwmon_filename(const char *filename,
 		}
 	}
 	if (fn_item == NULL || fn_type[0] == '\0' || (item != NULL && fn_item[0] == '\0')) {
-		pr_debug("hwmon_pmu: not a hwmon file '%s'\n", filename);
+		pr_debug3("hwmon_pmu: not a hwmon file '%s'\n", filename);
 		return false;
 	}
 	elem = bsearch(&fn_type, hwmon_type_strs + 1, ARRAY_SIZE(hwmon_type_strs) - 1,
 		       sizeof(hwmon_type_strs[0]), hwmon_strcmp);
 	if (!elem) {
-		pr_debug("hwmon_pmu: not a hwmon type '%s' in file name '%s'\n",
+		pr_debug3("hwmon_pmu: not a hwmon type '%s' in file name '%s'\n",
 			 fn_type, filename);
 		return false;
 	}
@@ -223,7 +223,7 @@ bool parse_hwmon_filename(const char *filename,
 	elem = bsearch(fn_item, hwmon_item_strs + 1, ARRAY_SIZE(hwmon_item_strs) - 1,
 		       sizeof(hwmon_item_strs[0]), hwmon_strcmp);
 	if (!elem) {
-		pr_debug("hwmon_pmu: not a hwmon item '%s' in file name '%s'\n",
+		pr_debug3("hwmon_pmu: not a hwmon item '%s' in file name '%s'\n",
 			 fn_item, filename);
 		return false;
 	}
@@ -281,7 +281,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 			continue;
 
 		if (!parse_hwmon_filename(ent->d_name, &type, &number, &item, &alarm)) {
-			pr_debug("Not a hwmon file '%s'\n", ent->d_name);
+			pr_debug3("Not a hwmon file '%s'\n", ent->d_name);
 			continue;
 		}
 		key.num = number;
@@ -653,10 +653,14 @@ int hwmon_pmu__config_terms(const struct perf_pmu *pmu,
 			    struct parse_events_terms *terms,
 			    struct parse_events_error *err)
 {
-	const struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
+	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
 	struct parse_events_term *term;
+	int ret;
+
+	ret = hwmon_pmu__read_events(hwm);
+	if (ret)
+		return ret;
 
-	assert(pmu->sysfs_aliases_loaded);
 	list_for_each_entry(term, &terms->terms, list) {
 		if (hwmon_pmu__config_term(hwm, attr, term, err))
 			return -EINVAL;
-- 
2.47.0.371.ga323438b13-goog

