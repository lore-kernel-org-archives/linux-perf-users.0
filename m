Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ACE1D54E9
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287325; cv=none; b=SkSxPZVlQTHFelV0UusOD0Xsa9wAVLHCbA8Egt9bcEkNMVCDQ1ry/TdfIaYVNVhWIF+r/UsHxA4guvWpE4GafT4qL0WHLHJ+R3REYoLQREndh7M9apaWa6fTDX/VbV4E4n4g1Q+wNypaIR7/Z6OLh3z63WpfX/C9BeOrEfxhFVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287325; c=relaxed/simple;
	bh=yE+k+5yIhBHbG/OX936XoHFBUk0gkIqhen59eUL3Ets=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EuhJEC+vhhpvhUMbuWaXdj9a5L9IYwEPDKwKtBlOW2uHiCETLg4mafsVlKQxFLenFNekeohmstnqEGnhn06K7BRqG4BUMSeXhVahFbz2PUWgWf+/AQw2Jy8w1iEhSDe/AYNjaGgNE4FfNijTXImjbcRXq23JroL3b1tawod9bzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctmxSfUy; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctmxSfUy"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3988f71863so36617975276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 14:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736287322; x=1736892122; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHU2qNqeidstEjTgX/H4wyzqiStAgyte6VQxWp6nfVA=;
        b=ctmxSfUyVoEWi6OdylfyIku5sJOi8nyszTKL0AJ+H0v3ZTIdBg6jeKg0WaEvtnbrsQ
         WPqd+AclIsLyyyJXBDLIgOo3VVt28oyHXcsKvQyiEMPgJZkbzPJvj2EA6fQtHpMCeM/h
         o+XdLdXbm2FdAKlksepR1Gdokgfa4YaHizrZXDk0a1T5bP7MCbrdl6XdERNYixh81kMA
         fqYszGQFI0B2++LaU8buJwsuleUq9mZ+7NMjLV30kFkBzjKUcX1zS3hLMf2CAjp2vqxd
         jXS4GIAlaO3l8We3t/vZL4na85vQ8hZkVI1eKqGb/PUtqr315AoGFBbRwW7f0J2hKLWd
         fXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736287322; x=1736892122;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHU2qNqeidstEjTgX/H4wyzqiStAgyte6VQxWp6nfVA=;
        b=j/sWOfpnGC2/YxidXV8AXA/iN5a7de2mm+da/N/9F+iocosZ/vCVj7grxQHca8pJIC
         pnCmcOBkWDI/UpKagh1vJ5b5SDpL1hJ3bmznAihu5dzifaC+Wy+27TM0VNMcq7QD7lMu
         MsYgEc3LYOmINPPDimz96FUsPqn7+ddVgY29msvmFtRXs8znlpj7nLJOBNJpS5fJdArn
         TEegj9GsBX5sWVma6abJwp0PYYbC55UhhVs+57W8CiGbt6fhtCG1kn6xsucuX/46UOvc
         p7jXf92QrjmmW+fLNmhBQLnQut/z23ISk9QQ0zJGpBFaiqUbr2NRTjmrRPx3qqLUMAfm
         i0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsneOC3gBQ4F2xc+PwHStZYk/rZN/t8uTotylJaJQaMIF99q08XNq01NqSChfAJ3GaFgeAqEYaAHppY3r43AV2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+3tszbvMI6dIaEkrxxEwySQWiDzXrMQ2YOstcVyKe0PKXvgT
	GeVS9IYFCjt6xJ0prLAWjXmHz7rs8bzyqaR68h1hK4TFUILR3/Zts053damF9O1X4kWO9FJl7hG
	tghZXKw==
X-Google-Smtp-Source: AGHT+IH3H7Da2sw+0ZheqyYKo8QWiPE//y8aMnfRz56LLXcwKiusIn7qXkdmZ2MQaqbJotRYnsEogmWOmNTG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ae:a887:5504:e3ca])
 (user=irogers job=sendgmr) by 2002:a25:cecf:0:b0:e4c:35c4:cf05 with SMTP id
 3f1490d57ef6-e54ee1e51a6mr1183276.5.1736287322339; Tue, 07 Jan 2025 14:02:02
 -0800 (PST)
Date: Tue,  7 Jan 2025 14:01:52 -0800
In-Reply-To: <20250107220152.1213959-1-irogers@google.com>
Message-Id: <20250107220152.1213959-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250107220152.1213959-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2 3/3] perf test: Add a runs-per-test flag
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
runs-per-test flag that will run each test multiple times.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

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

