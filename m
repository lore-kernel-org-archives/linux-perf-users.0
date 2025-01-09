Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F981F9439
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448061; cv=none; b=M7oDUaoAp0WAAWfqT5ydQDin4COHGv1+/FuFzOygp51b4vBL+/zF3dZpoze6jObX4FAqRmEKwgEI1Mrrsy/mYhLoaB5bSaqwAyoIUR3RPhksfa57wTg1MPp0gcq45EuF3cEby+jbIO18924Yv33/ZYs1VP1vAKlOe6KmYcbemzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448061; c=relaxed/simple;
	bh=94yDeESgARdf6BTx6q8uGdmYCl+Uug81Nad7ZVVSVzc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cPqo4ZrxNJWuZfKsEzQxhHOeFWb748uhK8S6X997loEh3tg4w2aEHZKe6Nnx6Ue/ZWTF5On3uQ1yb6O49/sLkbxbprCN+JpV1bmhWPRN9/LK/+xlCstjw5vwTugDm7W0S9BvZ2UumkDe3ZPKc3ZcYAHg11x3CZeVd4/RfiYfKlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RJjze8DJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RJjze8DJ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e4a8b40dd40so3085024276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 10:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736448058; x=1737052858; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bV8GcHcKtuj7GMNesJ0KkhHJkb7OCaruvoF/b4TYI9U=;
        b=RJjze8DJrewfGNROv3kLrlZjh33BgCG+pJj/YsOWgHPBmP6zXwqCXg59RuITrhsV1F
         0bZ5eWOGT9S38OgZ6ZBJAt+p7v+4vd1OiD+hK9OyDMHzawzpdt7ASJFr1ikykbqbnTYL
         caNtzHfbzbXCixXQTyVQjL6vXqG9WpWmB1lj/Tzbx6sHEeqsY7ovEJzA24jIiSpXpEFp
         vuxEvSLcQXju2uSnOxJ0Q0MYkZAL0jo+KWp9lfl5koj0K//ssy639fUGbUemw1po6Ayo
         BmsxpJr7HhLrA36KuVdg8HwmbDwdA0n1V7gNPLwALwtnjci87yCzaaCVZVNsU05sz+oj
         dnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736448058; x=1737052858;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bV8GcHcKtuj7GMNesJ0KkhHJkb7OCaruvoF/b4TYI9U=;
        b=Ae+PaZOYVHDwYNP1ljyss/jSujjpUF5oRp1EsVeVClMl+b7Y+9Ycmrp+vMFeKIQDa8
         4OORyuBTrTKWMR3oa1ALra6ixrOSH/cWQu9vogjD2yl2VxnpUf7bxJPRgLYxbXEjCmeS
         vWHcKo6lpIUl1z1G83JdQEOjw6lTS8Ofn8DxMHL7PJYsFuk+98V9j77GKuQ86wO1RaKO
         5hz77QiX6FHii8v4ITwVJqc5plsUuBzrza2ZdEfAFwwlUMcZzMVG6oledexbsfW6teqD
         WEFn5ZppmI5stDHn5ufVQHZJS5ChEZs6pfImBz9/sz8OjMEilHTJn4tpqu/f8/TuqGT9
         m19g==
X-Forwarded-Encrypted: i=1; AJvYcCX5TLpy9iS6B5dY/L4L78pMFCsev7LayQcgESQ20XPJ3FiWLnsL5NVOrHajDA8oMlSTZXL8BPiU2v9jyd+DKi5x@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzn+0EtZwmP+km95B4XEznhymjLrroQsT0KKN44YkrQxL+u8yI
	T/o2nxrYYMnIBYf0eHk3IR4PMOurAemcdqz9nifXkX3b+E9Z1Z6jt2r8cB7P4STnpGXT82qEl2Z
	WYbwdsQ==
X-Google-Smtp-Source: AGHT+IFg3DTQaMdwxZGCSqbwJsY7QUgVzARMAoFENDrPBpO9GNpfN2JnuS4lJ8aOdPZkSUJMUpzNXhiL9ODo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a25:684b:0:b0:e48:9cab:d051 with SMTP id
 3f1490d57ef6-e54f01e588bmr17250276.9.1736448058531; Thu, 09 Jan 2025 10:40:58
 -0800 (PST)
Date: Thu,  9 Jan 2025 10:40:45 -0800
In-Reply-To: <20250109184046.193736-1-irogers@google.com>
Message-Id: <20250109184046.193736-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109184046.193736-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 4/5] perf test: Add a runs-per-test flag
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To detect flakes it is useful to run tests more than once. Add a
runs-per-test flag that will run each test multiple times. Example
output:

```
$ perf test -r 3 lbr -v
122: perf record LBR tests                                           : Ok
122: perf record LBR tests                                           : Ok
122: perf record LBR tests                                           : Ok
```

Update the documentation for the runs-per-test option.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-test.txt |  9 ++++++++-
 tools/perf/tests/builtin-test.c        | 28 ++++++++++++++++----------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 8f8a3c367570..85f868c324ff 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -33,7 +33,14 @@ OPTIONS
 
 -S::
 --sequential::
-	Run tests one after the other, this is the default mode.
+	Run all tests one after the other. By default "exclusive"
+	tests are run sequentially, but other tests are run in
+	parallel to speed execution.
+
+-r::
+--runs-per-test::
+	Run each test the given number of times, by default once. This
+	option can be useful to determine if a test is flaky.
 
 -F::
 --dont-fork::
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 887f735da900..729740c1e5e5 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -42,6 +42,8 @@
 static bool dont_fork;
 /* Fork the tests in parallel and wait for their completion. */
 static bool sequential;
+/* Number of times each test is run. */
+static unsigned int runs_per_test = 1;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -485,7 +487,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 			len = strlen(test_description(*t, i));
 			if (width < len)
 				width = len;
-			num_tests++;
+			num_tests += runs_per_test;
 		}
 	}
 	child_tests = calloc(num_tests, sizeof(*child_tests));
@@ -549,16 +551,18 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 				continue;
 			}
 
-			test_suite__for_each_test_case(*t, curr_test_case) {
-				if (!perf_test__matches(test_description(*t, curr_test_case),
-							curr_suite, argc, argv))
-					continue;
-
-				err = start_test(*t, curr_suite, curr_test_case,
-						 &child_tests[child_test_num++],
-						 width, pass);
-				if (err)
-					goto err_out;
+			for (unsigned int run = 0; run < runs_per_test; run++) {
+				test_suite__for_each_test_case(*t, curr_test_case) {
+					if (!perf_test__matches(test_description(*t, curr_test_case),
+								curr_suite, argc, argv))
+						continue;
+
+					err = start_test(*t, curr_suite, curr_test_case,
+							 &child_tests[child_test_num++],
+							 width, pass);
+					if (err)
+						goto err_out;
+				}
 			}
 		}
 		if (!sequential) {
@@ -698,6 +702,8 @@ int cmd_test(int argc, const char **argv)
 		    "Do not fork for testcase"),
 	OPT_BOOLEAN('S', "sequential", &sequential,
 		    "Run the tests one after another rather than in parallel"),
+	OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
+		     "Run each test the given number of times, default 1"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
 	OPT_BOOLEAN(0, "list-workloads", &list_workloads, "List the available builtin workloads to use with -w/--workload"),
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
-- 
2.47.1.613.gc27f4b7a9f-goog

