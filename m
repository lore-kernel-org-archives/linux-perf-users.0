Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746175;
	b=Op/+8eXvuePrbF6gbuCgzv0CHOKL2lXTdGNQPZ+Pq6NcuO4MqcZly+yEVB3MLUSEHw77
	 8VC/CGhgM7qZ59fQIIYgyqxqGHbpisYVvk7sj7gxyMtdhk3Tt8di4anMOKPC/USyfOhzN
	 UCwKhHbAkO/wU3o/WANkl7PvQbz/d4cjINXAfj2+fbZmbtmtjonP87iEhL93gYxulNIz9
	 F38is/kJPn9AuMozh2Mh5CHnR8G81a9IcCiwNNwblsN1aYowzqldJAqIJUFV6OOYcD5wz
	 u9TD/qpfAOSsoV+g5gWmOZ4aV4+WGhs+91ezx4g50MZvxFfuxUZ2Uq1szHj4Xtdj5+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=eVugWWieK0ci2avVTAdazy5+l7Bvth1Y2wdhHs4CEwM=;
	b=lMdvURFWtpMITPF5nyWpwHzmp3/tloz4BfRnIvDFIiI99lAoHKTY01aKMKZtboehiCzM
	 PRmhmZJs7ItMBpD4cSYMuchA3eVXVznnDF/FnNzfzKm00zwi39X1WrVai5+OvehpC06O3
	 NQkRHJtcMVVziu+X+ShySmVPM4eWCwpg4ORmM/1BPLNM18yRUSWNxsmhbN/olV3XoFiM6
	 Ss2ZccGdfgDsq+u3J489jYvO5E68+M6IDOsDi414RcSBorGNwte8o8+Xy9umhnPwA61nF
	 ov/MScdb3grNvwKQaNBnCVDvaAtZfrHXgHhU+LHn8D1DHtp6IqJW/yg5+xUQyrSG6ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kBGnPlY1;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392EB606A325
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 09:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 392EB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kBGnPlY1
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so5997995e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 02:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792746173; x=1793350973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eVugWWieK0ci2avVTAdazy5+l7Bvth1Y2wdhHs4CEwM=;
        b=kBGnPlY108pFZZ9uCEr0zOMKg3EWJsaOXY6e3BNwpBM73BC4TqC2OQWMN/yiu+m3RR
         wlAakwkzJkH6vywzajJBUpoLYTSxGIRIJ9AL8CIuUinXmV8cUN8r2Fd7vpA7iC98eFYM
         1g8rrYnfLAdWcU2toxpdey338cVPvmOXDTCFh11TPctaZwGgK5npCAv/yhWsr4BkRZB1
         wcJGvpzeML2ikBEXpWZt6VNUlCOyDlFUo65g6ioO73qCRyNaqWRjhIFAXvJR4sW1bTVa
         mDWDOTXQth/tUSnGfduLmSr2wJXW0oGo+apMjCLAfEFmFCe2fGZ4VL3eeIUQQhxbBMG9
         +pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746173; x=1793350973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVugWWieK0ci2avVTAdazy5+l7Bvth1Y2wdhHs4CEwM=;
        b=Exeupz4/EjK4jkV+9jPb7gnyL17YO7xF2hJdojfqPWY4eQAk3dfD/I6j0Aw+FAb3JC
         HmXYXrdaN0joChgcW/7+i1y/sqjXDbvj8J6pH7s2Ig3nqSgCiMxNEAuJj2/4QVrtQUh/
         5n5jL63330TjT/IxCSilD8xSee0c3Uz7fdo9lupzldhPxqKCQZ6nyb0uo9S+vekJ+RP9
         QNx/aIO8+YhF6HT9UhWLfmJE2n2BZTmdrVCHjQe5tmsh0WvNdpSkUmjZ2r12McOX8jaT
         05xCw+MXbiifmO3GzTsH4kTg/ZqVEtw6DvkxArSliCDjYsAVlskB7sbnSSC1C7tbpBor
         f+PA==
X-Gm-Message-State: AFq9FYIT30mjsaE+ZoQNUr0rQ9Bdn63pV+pTF03irhAuxDsx+aBN4iDD
	J6d18aWrQf5VkdwxATyxTyIBhpA+ba4OBcbSTU1P9PZP+Veh6BYul623jOd5/tu9tPM=
X-Gm-Gg: AYBFou34khO0kOWXKnz4rddeFbALj9za5C4Ti179qMjfUImYRKm7fMZ0gAJGTEFDJ0C
	1UDayVFebAxCfVb3JhImAtSPC8R8Pf0yXf36/QW1+vcPmSpN9JpaFki8ESmD5TMuaSm/JWYgvm+
	jZTW4b+IPkCBfm830O2dvqwjGLuJqUw2jKUrYR6f48HfnldSsEqnaofpCZ6JhNdodwMI1+ncWij
	YfPdHFPRf73+kALXGiBGBaxaj0NHzD3rS3HEbJeBguMka67iAfEkMopoQqHRjbtKwZdyBEJvs2U
	+yp5u6XLO9qMhaBsWnNXurZHg7Fgb5eedBXVOzEOTsYTcbPqRaNGKULXwJoEEBG/sRPsaw29HE7
	lA9YNdIeHIX23ey6RBAm9SCFL4XlnJwcstiXxp068pcAJtYPj1oUyUmC6pGh+oQX5wVyH7XUR9z
	FAM5AwceEUo479mtH2voiqIdHCEWALZ9Aanbq1mKR/n4YqZgLrGTZMM1CC+kzAtSFwATs+6ohMo
	4bNj/Koe0NGyH4frtz4msRog2dV0fiG+qhCW9hXDl7NIO85qv37Qsfq8xMbpd1W5qxsKptFFtRy
	8S0W
X-Received: by 2002:a05:600c:e548:10b0:4a2:180a:3417 with SMTP id 5b1f17b1804b1-4a2180a3438mr5186525e9.1.1792746172133;
        Fri, 23 Oct 2026 02:02:52 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a210487d16sm60582535e9.15.2026.10.23.02.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:02:51 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 23 Oct 2026 10:01:51 +0100
Subject: [PATCH 2/2] perf test: Add --skip-name to skip tests by name
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-james-perf-test-skip-v1-2-b6c11bdafd46@linaro.org>
References: <20261023-james-perf-test-skip-v1-0-b6c11bdafd46@linaro.org>
In-Reply-To: <20261023-james-perf-test-skip-v1-0-b6c11bdafd46@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Alice Rogers <alice.mei.rogers@gmail.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

--skip takes test numbers which change whenever tests are added or
removed, so a list of tests to skip in CI has to be updated as perf
changes, or it silently skips the wrong tests.

Add --skip-name to skip a test by its name which should be more stable.
The option can be repeated to skip more than one test instead of taking
a comma separated list, as some descriptions contain commas, e.g.:

  $ perf test --skip-name 'Add fd to a fdarray, making it autogrow' \
              --skip-name 'Simple expression parser' 7 32 33
    7: Simple expression parser                : Skip (user override)
   33: Add fd to a fdarray, making it autogrow : Skip (user override)
   32: Filter fds with revents mask in a fdarray : Ok

The match is exact rather than substring so that adding a new test
containing an existing skip substring doesn't get skipped.

A name that matches no test exits with an error so that a renamed test
isn't silently run again:

  $ perf test --skip-name 'Add fd to a fdarray'
  No test matches --skip-name 'Add fd to a fdarray'
  $ echo $?
  234

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-test.txt |  4 ++
 tools/perf/tests/builtin-test.c        | 71 ++++++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index f66ccd77bfe7..bc3426705a80 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -57,6 +57,10 @@ OPTIONS
 --skip::
 	Tests to skip (comma separated numeric list).
 
+--skip-name=<name>::
+	Skip the test whose description is exactly <name>, as printed by
+	'perf test list'. Can be provided multiple times.
+
 -v::
 -vv::
 -vvv::
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index cd0fc3dedc3e..433534b8e182 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -42,6 +42,7 @@
 #include "hist.h"
 #include "intlist.h"
 #include "string2.h"
+#include "strlist.h"
 #include "symbol.h"
 #include "tests-scripts.h"
 #include "tests.h"
@@ -70,6 +71,8 @@ static unsigned int runs_per_test = 1;
 static unsigned int failure_snippet_lines = 10;
 /* Numbers of the test suites to skip, from --skip. */
 static struct intlist *skiplist;
+/* Exact descriptions of the tests to skip, from --skip-name. */
+static struct strlist *skip_names;
 /*
  * The tests mapping ring buffers take turns using their share of
  * kernel.perf_event_mlock_kb via this mutex, shared with the forked test
@@ -344,9 +347,12 @@ static bool test_exclusive(const struct test_suite *t, int test_case)
 	return t->test_cases[test_case].exclusive;
 }
 
-static bool perf_test__skip_suite(int suite_num)
+static bool perf_test__skip_suite(const struct test_suite *t, int suite_num)
 {
-	return intlist__find(skiplist, suite_num + 1) != NULL;
+	if (intlist__find(skiplist, suite_num + 1))
+		return true;
+
+	return skip_names && strlist__has_entry(skip_names, test_description(t, -1));
 }
 
 static bool perf_test__matches(const char *desc, int suite_num, int argc, const char *argv[])
@@ -1466,7 +1472,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[])
 				suite_matched = true;
 			}
 
-			if (perf_test__skip_suite(curr_suite)) {
+			if (perf_test__skip_suite(*t, curr_suite)) {
 				if (pass == 1)
 					print_suite_user_override(*t, curr_suite, width);
 				continue;
@@ -1510,6 +1516,52 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[])
 	return err;
 }
 
+static int parse_skip_name(const struct option *opt __maybe_unused, const char *str,
+			   int unset)
+{
+	int err;
+
+	/* --no-skip-name clears the list, like --no-skip does. */
+	if (unset) {
+		strlist__delete(skip_names);
+		skip_names = NULL;
+		return 0;
+	}
+
+	if (!skip_names) {
+		skip_names = strlist__new(NULL, NULL);
+		if (!skip_names)
+			return -ENOMEM;
+	}
+	err = strlist__add(skip_names, str);
+
+	/* Asking to skip a test twice is harmless. */
+	return err == -EEXIST ? 0 : err;
+}
+
+/*
+ * A --skip-name that matches nothing is likely a typo or a test that was
+ * renamed, report it rather than silently running the test.
+ */
+static int perf_test__check_skip_names(struct test_suite **suites)
+{
+	struct str_node *pos;
+	int err = 0;
+
+	strlist__for_each_entry(pos, skip_names) {
+		bool found = false;
+
+		for (struct test_suite **t = suites; *t && !found; t++)
+			found = !strcmp(test_description(*t, -1), pos->s);
+
+		if (!found) {
+			pr_err("No test matches --skip-name '%s'\n", pos->s);
+			err = -EINVAL;
+		}
+	}
+	return err;
+}
+
 static int perf_test__list(FILE *fp, struct test_suite **suites, int argc, const char **argv)
 {
 	int curr_suite = 0;
@@ -1831,7 +1883,7 @@ static bool perf_test__shares_mlock_budget(struct test_suite **suites, int argc,
 		int curr_test_case;
 		bool suite_matched;
 
-		if (!t->needs_mlock || perf_test__skip_suite(curr_suite))
+		if (!t->needs_mlock || perf_test__skip_suite(t, curr_suite))
 			continue;
 
 		suite_matched = perf_test__matches(test_description(t, /*test_case=*/-1),
@@ -1918,6 +1970,9 @@ int cmd_test(int argc, const char **argv)
 	bool list_workloads = false;
 	const struct option test_options[] = {
 	OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
+	OPT_CALLBACK(0, "skip-name", NULL, "name",
+		     "test to skip, by its exact name, can be repeated",
+		     parse_skip_name),
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('F', "dont-fork", &dont_fork,
@@ -2011,12 +2066,20 @@ int cmd_test(int argc, const char **argv)
 		int err = errno;
 
 		intlist__delete(skiplist);
+		strlist__delete(skip_names);
 		return err ? -err : -ENOMEM;
 	}
+	if (skip_names) {
+		ret = perf_test__check_skip_names(suites);
+		if (ret)
+			goto out;
+	}
 	perf_test__setup_mlock_budget(suites, argc, argv);
 	ret = __cmd_test(suites, argc, argv);
 	perf_test__teardown_mlock_budget();
+out:
 	free(suites);
 	intlist__delete(skiplist);
+	strlist__delete(skip_names);
 	return ret;
 }

-- 
2.43.0

