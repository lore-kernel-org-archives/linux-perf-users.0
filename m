Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FFC44368
	for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752885; cv=none; b=VlwvAbMZrjav2/6GzDmYfmsmYTfiE8Q1k2qxkvT6DM4oNxVLu7CXEmCYr+WGBEG81c7V57M6LZ4aurUQNde6RsbZSe+DE6+NIHIsL9dPMh3maCR3Y2NhlfqEJ6dONwtBbVRfC1GDlo/XanBtFDIrSLc3lRYuP2ia2Wzb2F56nJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752885; c=relaxed/simple;
	bh=SUmGhn7U8Bhn0LJUMjbbdvaJXGbSc6Bswuda7N7OrT4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=exhzXdaOwc/QYkLUaU9ut/i56SDB3LxDzFCBwvIU96L3wycxgOYc22R2WqAD41mkYMzmDdLQGNJbZihueQntGlwGzbLA39DlpalrYfvwnFkfqt/3JlX1UXscp03OE9gJD14bNSTJ+3OxwxbF1jtuNes71iDG//BEQyfIiIauVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lHYXIAKo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHYXIAKo"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be4b79115so123845947b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 23:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715752882; x=1716357682; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kbt3+oOgWiYhvdlIPoeQ0dzOgUp0iTplIsC7hc2pJ+U=;
        b=lHYXIAKofUYWwYfcakeEYAxQphwSmk20PXmItI3ckRjKSnHFBmTuf5AjefUEpXkgYL
         qmn3yw0+kX8kB6Abr1rPx98KsMNmskAf+xLlhLYlthqD6UavTQsmIcPs0XY3j0wnlRp3
         lbodQzaj3ImeY1PCmCNBEazuYuef1CmisiCmjrlpwm6LcfvZaehxhtSemTVqk2XgWfVe
         MeG2zQH8nnfKwagk/BLqaTDxszAtP774M6htaI8BXO64bJNgEfutnefJ3gvXss6/LbKG
         KEGOV1AnE+qBgsDPkmBLSPenms3hbqLuM9irVIraX+/l2C2aMbTcHOOwY9BuOcr6IAHD
         wcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715752882; x=1716357682;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbt3+oOgWiYhvdlIPoeQ0dzOgUp0iTplIsC7hc2pJ+U=;
        b=Dxcso6AXHTs4FO3csEbAiOWSfd9sGjf7BG8fA2uxAQ5sloQgqEHlyuB02RjbD6Ka64
         ZEN9kDaSt9Ivai80cxfZrjqL957zabjDpfvuhyr+DPk0KdLBvyWgFpsOeE8IH0chNCYp
         zfu1bQnlPOSFgRnu4Ri2jArOt6OH6qRIWrNZjyDOs0SyyDYNKimn40l4r+xR9meVuSPS
         n5QHyHmBpGSFfCtoQ3zs205IUI/GlcnFbGRlbgX5XY6q+NZ+vhXZ1xTFv7eq1h6edh5R
         hGxdRsOGKLA3S0ImxSNLRGIHLPFyC6ju72HG4bYk7KOOfj2Sw6rb5IZY1QirQNNTETm+
         Us+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUf4/nZpgYMmVOk+swPmWP5KKR0XiPxAlihlDVfKVg4lI3NWcTZ8oXhZ0GysLAZw/bp9ewxTsyC2sUJGWtzCQwQzlOrUHTYZI8eC/2n8iuHgQ==
X-Gm-Message-State: AOJu0YxY5MjGfMBVqBkl4M5PHW5BswIhLyyU9il7dNUdi+GNE7yIsGDv
	UgzTArSPofMgQzdr78MnQBGHPig7RMyPtaGGG2QqYtOWMplqYqQS3KpHEvos2G7M6srmldKvSgm
	85XQG4A==
X-Google-Smtp-Source: AGHT+IEYbruynMzwQTf+H5YajmkeOApfArgyEh3Z0hkcdqCiUJOLMAgirPQdXuz0xbnoJkwoe34enSuu9/dP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bac3:cca1:c362:572])
 (user=irogers job=sendgmr) by 2002:a05:6902:149:b0:de5:5225:c3a4 with SMTP id
 3f1490d57ef6-dee4f304cb7mr3523816276.7.1715752882040; Tue, 14 May 2024
 23:01:22 -0700 (PDT)
Date: Tue, 14 May 2024 23:01:14 -0700
In-Reply-To: <20240515060114.3268149-1-irogers@google.com>
Message-Id: <20240515060114.3268149-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515060114.3268149-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v6 2/2] perf tests: Add some pmu core functionality tests
From: Ian Rogers <irogers@google.com>
To: Tuan Phan <tuanphan@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Test behavior of PMU names and comparisons wrt suffixes using Intel
uncore_cha, marvell mrvl_ddr_pmu and S390's cpum_cf as examples.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu.c | 99 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 06cc0e46cb28..cc88b5920c3e 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -3,6 +3,7 @@
 #include "evsel.h"
 #include "parse-events.h"
 #include "pmu.h"
+#include "pmus.h"
 #include "tests.h"
 #include "debug.h"
 #include "fncache.h"
@@ -340,10 +341,108 @@ static int test__pmu_event_names(struct test_suite *test __maybe_unused,
 	return ret;
 }
 
+static const char * const uncore_chas[] = {
+	"uncore_cha_0",
+	"uncore_cha_1",
+	"uncore_cha_2",
+	"uncore_cha_3",
+	"uncore_cha_4",
+	"uncore_cha_5",
+	"uncore_cha_6",
+	"uncore_cha_7",
+	"uncore_cha_8",
+	"uncore_cha_9",
+	"uncore_cha_10",
+	"uncore_cha_11",
+	"uncore_cha_12",
+	"uncore_cha_13",
+	"uncore_cha_14",
+	"uncore_cha_15",
+	"uncore_cha_16",
+	"uncore_cha_17",
+	"uncore_cha_18",
+	"uncore_cha_19",
+	"uncore_cha_20",
+	"uncore_cha_21",
+	"uncore_cha_22",
+	"uncore_cha_23",
+	"uncore_cha_24",
+	"uncore_cha_25",
+	"uncore_cha_26",
+	"uncore_cha_27",
+	"uncore_cha_28",
+	"uncore_cha_29",
+	"uncore_cha_30",
+	"uncore_cha_31",
+};
+
+static const char * const mrvl_ddrs[] = {
+	"mrvl_ddr_pmu_87e1b0000000",
+	"mrvl_ddr_pmu_87e1b1000000",
+	"mrvl_ddr_pmu_87e1b2000000",
+	"mrvl_ddr_pmu_87e1b3000000",
+	"mrvl_ddr_pmu_87e1b4000000",
+	"mrvl_ddr_pmu_87e1b5000000",
+	"mrvl_ddr_pmu_87e1b6000000",
+	"mrvl_ddr_pmu_87e1b7000000",
+	"mrvl_ddr_pmu_87e1b8000000",
+	"mrvl_ddr_pmu_87e1b9000000",
+	"mrvl_ddr_pmu_87e1ba000000",
+	"mrvl_ddr_pmu_87e1bb000000",
+	"mrvl_ddr_pmu_87e1bc000000",
+	"mrvl_ddr_pmu_87e1bd000000",
+	"mrvl_ddr_pmu_87e1be000000",
+	"mrvl_ddr_pmu_87e1bf000000",
+};
+
+static int test__name_len(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	TEST_ASSERT_VAL("cpu", pmu_name_len_no_suffix("cpu") == strlen("cpu"));
+	TEST_ASSERT_VAL("i915", pmu_name_len_no_suffix("i915") == strlen("i915"));
+	TEST_ASSERT_VAL("cpum_cf", pmu_name_len_no_suffix("cpum_cf") == strlen("cpum_cf"));
+	for (size_t i = 0; i < ARRAY_SIZE(uncore_chas); i++) {
+		TEST_ASSERT_VAL("Strips uncore_cha suffix",
+				pmu_name_len_no_suffix(uncore_chas[i]) ==
+				strlen("uncore_cha"));
+	}
+	for (size_t i = 0; i < ARRAY_SIZE(mrvl_ddrs); i++) {
+		TEST_ASSERT_VAL("Strips mrvl_ddr_pmu suffix",
+				pmu_name_len_no_suffix(mrvl_ddrs[i]) ==
+				strlen("mrvl_ddr_pmu"));
+	}
+	return TEST_OK;
+}
+
+static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	TEST_ASSERT_EQUAL("cpu", pmu_name_cmp("cpu", "cpu"), 0);
+	TEST_ASSERT_EQUAL("i915", pmu_name_cmp("i915", "i915"), 0);
+	TEST_ASSERT_EQUAL("cpum_cf", pmu_name_cmp("cpum_cf", "cpum_cf"), 0);
+	TEST_ASSERT_VAL("i915", pmu_name_cmp("cpu", "i915") < 0);
+	TEST_ASSERT_VAL("i915", pmu_name_cmp("i915", "cpu") > 0);
+	TEST_ASSERT_VAL("cpum_cf", pmu_name_cmp("cpum_cf", "cpum_ce") > 0);
+	TEST_ASSERT_VAL("cpum_cf", pmu_name_cmp("cpum_cf", "cpum_d0") < 0);
+	for (size_t i = 1; i < ARRAY_SIZE(uncore_chas); i++) {
+		TEST_ASSERT_VAL("uncore_cha suffixes ordered lt",
+				pmu_name_cmp(uncore_chas[i-1], uncore_chas[i]) < 0);
+		TEST_ASSERT_VAL("uncore_cha suffixes ordered gt",
+				pmu_name_cmp(uncore_chas[i], uncore_chas[i-1]) > 0);
+	}
+	for (size_t i = 1; i < ARRAY_SIZE(mrvl_ddrs); i++) {
+		TEST_ASSERT_VAL("mrvl_ddr_pmu suffixes ordered lt",
+				pmu_name_cmp(mrvl_ddrs[i-1], mrvl_ddrs[i]) < 0);
+		TEST_ASSERT_VAL("mrvl_ddr_pmu suffixes ordered gt",
+				pmu_name_cmp(mrvl_ddrs[i], mrvl_ddrs[i-1]) > 0);
+	}
+	return TEST_OK;
+}
+
 static struct test_case tests__pmu[] = {
 	TEST_CASE("Parsing with PMU format directory", pmu_format),
 	TEST_CASE("Parsing with PMU event", pmu_events),
 	TEST_CASE("PMU event names", pmu_event_names),
+	TEST_CASE("PMU name combining", name_len),
+	TEST_CASE("PMU name comparison", name_cmp),
 	{	.name = NULL, }
 };
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

