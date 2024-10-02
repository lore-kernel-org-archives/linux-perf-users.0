Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C86C77101
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839249; cv=none; b=OS+Eg8dnRO8nXuQX4r9ibF/o9W8K3cLR51RISjMyI+dPGDecrMaAGQw4FH8N9IipY4A0LjtoFkqm/Lom/DlnSMuJSZjJgE/l5yq2Aofh5MKHakstR489aWOaRdY8kYI0xVH8AmYVzOuHfEhalNbrUyq55K5R/ov7LcqpCaOAxLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839249; c=relaxed/simple;
	bh=nevn6QdpTPNOH75n4LVtcfTWGgvd8nbW5G13PSM+U6E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=NHyGv5YPSRL5nzspdOBrC19BgzUMBe3ieayWf7AAwqPLYuPtfmFeolIeaOrur9xy/SyHbw0jwzDnZ3pPfCHS07k2XmdeP1lAZpnVUgJrU6PTlSaBVmOic+KFSt4PmT82pyMRLRQ/ZpAIIWSeowAKbxGBwwJbcHZOExf8ASXbDKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZA6RjM1e; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZA6RjM1e"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25cfee6581so10038035276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 20:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727839246; x=1728444046; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+oj4Y9eHpVg/gdEJT0IT5tvkpqw09K2+hvamqZ+w/kw=;
        b=ZA6RjM1eg80Tq/8Zbv2nS6AhT2+eNJAHxC8nGebCdIw3ZhDAkD4YlA9JtcDP7Y1UJz
         7cLDhNodYRu7O8yip8OLQhcPAldH0YOCzCeJMh2SG5j7OWUkcbjWaBcmmKB8dm8hS9u1
         Gc2oMvkm5PIXRsvTtEgFxQ8iVMK6q7bb40N5bs8R+1JM3hpE2iIoaSDau0VDXDtzctY/
         u7IWq45nCoh2rCipBKTHQtI+qI23Wvi6k2y6ltWxayF3/PdRBNLvoCsxn31NqpJfhJZ6
         F55y4PLOL3fOBQrremUOLI79rKZLoJardcyKrB6bukYhCvoTue5/nFRhA28rPZqKRudv
         W4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727839246; x=1728444046;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oj4Y9eHpVg/gdEJT0IT5tvkpqw09K2+hvamqZ+w/kw=;
        b=Kl2BU3TOsSZGiF419r4ErYxc8u8f9YWU+TYQmCy0nqfrMC/zBrO3fWuWoHLdK39pJw
         4K485iBzkztgejDLbIKZjJVrld2fegGfHMrD4gexB70nOl+ejux7ZwPiJYYlEzfOZ7xP
         bMJgpfOLeJ9TIzYxuNlAh0c74bps6CFpBKjWVweD1HqAVdYu11MTf1ModSk9K1E0AiIt
         /IDndjPry7f9h2ZZvwyQrw8sPUF49GHA//7rUWxX2bdCQHkRWAn/LnZabUMEL9M85xsg
         4w9TPvQKeaXZ/j6poT4lweCUSdnbjxizbLxuR+UCz1fJ3EAUl/u7PJkou3CepxS+iQ3a
         GyAw==
X-Forwarded-Encrypted: i=1; AJvYcCUMfmdLdtN/g+maVi6hVNjVt4nnti1zIz0T5p1gmUnzxlEZc7Ta/U5wL1dP6bRSD+khf3FMXj3eFuYFviJ858hO@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/2mnvr6qNFkK4zhNi28lMuSxkHt1ZcFRN570uNYXC5yqq8ML
	KuwhqXq4+qWbeXx88944bNmSYhAQhAtSdhFvSevanpGZvTUBQrup4dHp22FTyxzz2acf2hNy+mI
	2uTkZKQ==
X-Google-Smtp-Source: AGHT+IFLk7ckbsAJqcLwrQRm4BJhemsydjTxufIg28XGBfWDeiOLwgIHId6YTSQJzTWxSJ3Yi6j/wvokeIBY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ffa1:6d00:2acb:535f])
 (user=irogers job=sendgmr) by 2002:a25:8403:0:b0:e0e:c9bc:3206 with SMTP id
 3f1490d57ef6-e26383c1058mr1238276.5.1727839246192; Tue, 01 Oct 2024 20:20:46
 -0700 (PDT)
Date: Tue,  1 Oct 2024 20:20:13 -0700
In-Reply-To: <20241002032016.333748-1-irogers@google.com>
Message-Id: <20241002032016.333748-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002032016.333748-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v3 10/13] perf tests: Add tool PMU test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Weilin Wang <weilin.wang@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Ze Gao <zegao2021@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Ensure parsing with and without PMU creates events with the expected
config values. This ensures the tool.json doesn't get out of sync with
tool_pmu_event enum.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/tests.h        |   1 +
 tools/perf/tests/tool_pmu.c     | 111 ++++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+)
 create mode 100644 tools/perf/tests/tool_pmu.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 5671ee530019..a771e4928247 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -67,6 +67,7 @@ perf-test-y += sigtrap.o
 perf-test-y += event_groups.o
 perf-test-y += symbols.o
 perf-test-y += util.o
+perf-test-y += tool_pmu.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 470a9709427d..3b30f258c395 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -73,6 +73,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__PERF_RECORD,
 	&suite__pmu,
 	&suite__pmu_events,
+	&suite__tool_pmu,
 	&suite__dso_data,
 	&suite__perf_evsel__roundtrip_name_test,
 #ifdef HAVE_LIBTRACEEVENT
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 6ea2be86b7bf..1ed76d4156b6 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -83,6 +83,7 @@ DECLARE_SUITE(perf_evsel__tp_sched_test);
 DECLARE_SUITE(syscall_openat_tp_fields);
 DECLARE_SUITE(pmu);
 DECLARE_SUITE(pmu_events);
+DECLARE_SUITE(tool_pmu);
 DECLARE_SUITE(attr);
 DECLARE_SUITE(dso_data);
 DECLARE_SUITE(dso_data_cache);
diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
new file mode 100644
index 000000000000..94d0dd8fd3cb
--- /dev/null
+++ b/tools/perf/tests/tool_pmu.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "debug.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "tests.h"
+#include "tool_pmu.h"
+
+static int do_test(enum tool_pmu_event ev, bool with_pmu)
+{
+	struct evlist *evlist = evlist__new();
+	struct evsel *evsel;
+	struct parse_events_error err;
+	int ret;
+	char str[128];
+	bool found = false;
+
+	if (!evlist) {
+		pr_err("evlist allocation failed\n");
+		return TEST_FAIL;
+	}
+
+	if (with_pmu)
+		snprintf(str, sizeof(str), "tool/%s/", tool_pmu__event_to_str(ev));
+	else
+		strncpy(str, tool_pmu__event_to_str(ev), sizeof(str));
+
+	parse_events_error__init(&err);
+	ret = parse_events(evlist, str, &err);
+	if (ret) {
+		evlist__delete(evlist);
+		if (tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
+			ret = TEST_OK;
+			goto out;
+		}
+
+		pr_debug("FAILED %s:%d failed to parse event '%s', err %d\n",
+			 __FILE__, __LINE__, str, ret);
+		parse_events_error__print(&err, str);
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	ret = TEST_OK;
+	if (with_pmu ? (evlist->core.nr_entries != 1) : (evlist->core.nr_entries < 1)) {
+		pr_debug("FAILED %s:%d Unexpected number of events for '%s' of %d\n",
+			 __FILE__, __LINE__, str, evlist->core.nr_entries);
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (perf_pmu__is_tool(evsel->pmu)) {
+			if (evsel->core.attr.config != ev) {
+				pr_debug("FAILED %s:%d Unexpected config for '%s', %lld != %d\n",
+					__FILE__, __LINE__, str, evsel->core.attr.config, ev);
+				ret = TEST_FAIL;
+				goto out;
+			}
+			found = true;
+		}
+	}
+
+	if (!found && !tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
+		pr_debug("FAILED %s:%d Didn't find tool event '%s' in parsed evsels\n",
+			 __FILE__, __LINE__, str);
+		ret = TEST_FAIL;
+	}
+
+out:
+	evlist__delete(evlist);
+	return ret;
+}
+
+static int test__tool_pmu_without_pmu(struct test_suite *test __maybe_unused,
+				      int subtest __maybe_unused)
+{
+	int i;
+
+	tool_pmu__for_each_event(i) {
+		int ret = do_test(i, /*with_pmu=*/false);
+
+		if (ret != TEST_OK)
+			return ret;
+	}
+	return TEST_OK;
+}
+
+static int test__tool_pmu_with_pmu(struct test_suite *test __maybe_unused,
+				   int subtest __maybe_unused)
+{
+	int i;
+
+	tool_pmu__for_each_event(i) {
+		int ret = do_test(i, /*with_pmu=*/true);
+
+		if (ret != TEST_OK)
+			return ret;
+	}
+	return TEST_OK;
+}
+
+static struct test_case tests__tool_pmu[] = {
+	TEST_CASE("Parsing without PMU name", tool_pmu_without_pmu),
+	TEST_CASE("Parsing with PMU name", tool_pmu_with_pmu),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__tool_pmu = {
+	.desc = "Tool PMU",
+	.test_cases = tests__tool_pmu,
+};
-- 
2.46.1.824.gd892dcdcdd-goog

