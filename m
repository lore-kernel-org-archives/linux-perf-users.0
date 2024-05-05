Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D861370
	for <linux-perf-users@vger.kernel.org>; Sun,  5 May 2024 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714878995; cv=none; b=YPGL2T80gd6RlFZS6Z1dAPZgbbM+/k0kAD1sJ4SV02yWzk+L65+aMFm4u/RKe+QfAMMVdFZdQi0Zcll6d3/SUZeMtftdcJvNONDIVw79kLPMex6J/Rj3seLGUw88IkgLx2oF7CJJ1yspxVix540nHHu1TX6CqvCSR3eIdK6ZWpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714878995; c=relaxed/simple;
	bh=ZqgY35o/fk0bLnsVALiDz04OFwN2vLWcQGzxkdCX1FY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RXy1Ci9mQS6ofpAYWX+wQFTGPs4N+XeKdl1tsAx+iq/e6jn1Ncs4LZ+p5hrcrf6u/WGffMrlWMOUWJjfU3bB6jvC1ZSPXjNKLfzP49hE2pPtHvVBEMGLRv9kc7Of8X2f9pynb1l758NbsTDM7DDA+wgqbOWaEYj3pvm2FxDGjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=miD7pyWo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miD7pyWo"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61dfa4090c1so16577257b3.3
        for <linux-perf-users@vger.kernel.org>; Sat, 04 May 2024 20:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714878993; x=1715483793; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzxYDdoMX/MwVDQpnBzTgXoLHHZdpOpA7oIIBJp7WqY=;
        b=miD7pyWoPQL1FKdbloQ2g9+SxFeLFDOX2YOXf58gBPTUREQG3GnarABFMrOiVTQxhh
         H8FYfBhug/8AQaiQNhjNPtxSnjB5uozdVACSCtKtvwnFCWNbpFYMJAXDbDw1XP/f93Xe
         Db96IFUsLar3QKCInwVuwEFnlh8XJTpZCW9P8FMg1lOoPN4Eoj3mz2sqtb43ZcdNdJ2g
         GNwMm+vx0qPFf7xMg8ys3Be/IqZ01aufGY3njeNpc2qyxr10Y0WxQ185z7gBIw9zeSWl
         atcf4ckI2NRyk08p9FRmpmOF2ZG8bAauQsUXOQipjBh5uc/xX9WjwEt9A84KvGk0jiLw
         Pe3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714878993; x=1715483793;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzxYDdoMX/MwVDQpnBzTgXoLHHZdpOpA7oIIBJp7WqY=;
        b=AjpD52MMYP/tja7ktOEudJwzZ31iwsrW/AApe5Dwa1Toa0X3WxIOpArPkyLaBYSIJw
         LRNLeCT2EIVePryfMAq8z+WlhpGh24JfO4zs+M+RGdlpZvdlnuaWpF17UaH+r/3ODZaM
         fuC6YrqHXswmAFA5xe6Ybi78l4nN/WkjZurU7kz9ICKWVL1293FgBf/TdX/FskAND6TW
         rB9tN/NCdWVDotwhqRVhz+2AQj/kETMQzIiqUErOmuOIqalJ4aIqea1505XNx5/+y14D
         hP/14wSn3uYOcKET/RUwK5hEZVcCXN/cWcT+2g0v0nAZkX/EmAgE+VpCfeY8eJEDBOe6
         ETsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuRCrJuPkzPrn1ioWF8hEIHuEwDEQmxIh4+BSqwoOAqgoH4Nplim4Qho7oE2akyuGJGH5rq6+IlhgEr8YG6Gci9XjLIqCbuktl4KX8rWvYyA==
X-Gm-Message-State: AOJu0YwqI9MfoX54LSflmItnhzPai7BE3Yy1kZ8c+FIC28Bsng194FvV
	Ocf4Af0vwvYdmKLxCmvQczQX/L6NlTiErmNsVUIMrTwah0Lm8Pb3HCuqjzWOkzsqkpUHx2fvuJb
	PJNUuCw==
X-Google-Smtp-Source: AGHT+IHiW7JCLhJ0L+bmMS4hqEn7sIM8MKJJl5+O+guFA42KbGM05jCD1bE8R6vzIGRdfIQsF5+Q587gx8d/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:566d:1f52:f5f5:c8ec])
 (user=irogers job=sendgmr) by 2002:a05:6902:72b:b0:dc6:dfd9:d423 with SMTP id
 l11-20020a056902072b00b00dc6dfd9d423mr996413ybt.3.1714878993136; Sat, 04 May
 2024 20:16:33 -0700 (PDT)
Date: Sat,  4 May 2024 20:16:24 -0700
In-Reply-To: <20240505031624.299361-1-irogers@google.com>
Message-Id: <20240505031624.299361-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240505031624.299361-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v3 2/2] perf tests: Add some pmu core functionality tests
From: Ian Rogers <irogers@google.com>
To: Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
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
uncore_cha and marvell mrvl_ddr_pmu as examples.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu.c | 95 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 06cc0e46cb28..9dc77f29f723 100644
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
@@ -340,10 +341,104 @@ static int test__pmu_event_names(struct test_suite *test __maybe_unused,
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
+	TEST_ASSERT_EQUAL("cpu", pmu_name_len_no_suffix("cpu"), (int)strlen("cpu"));
+	TEST_ASSERT_EQUAL("i915", pmu_name_len_no_suffix("i915"), (int)strlen("i915"));
+	for (size_t i = 0; i < ARRAY_SIZE(uncore_chas); i++) {
+		TEST_ASSERT_EQUAL("Strips uncore_cha suffix",
+				pmu_name_len_no_suffix(uncore_chas[i]),
+				(int)strlen("uncore_cha"));
+	}
+	for (size_t i = 0; i < ARRAY_SIZE(mrvl_ddrs); i++) {
+		TEST_ASSERT_EQUAL("Strips mrvl_ddr_pmu suffix",
+				pmu_name_len_no_suffix(mrvl_ddrs[i]),
+				(int)strlen("mrvl_ddr_pmu"));
+	}
+	return TEST_OK;
+}
+
+static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	TEST_ASSERT_EQUAL("cpu", pmu_name_cmp("cpu", "cpu"), 0);
+	TEST_ASSERT_EQUAL("i915", pmu_name_cmp("i915", "i915"), 0);
+	TEST_ASSERT_VAL("i915", pmu_name_cmp("cpu", "i915") < 0);
+	TEST_ASSERT_VAL("i915", pmu_name_cmp("i915", "cpu") > 0);
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

