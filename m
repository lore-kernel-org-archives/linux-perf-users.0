Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746179;
	b=ge2p33GmriO+8b8yaRrY+Ubv4mHlo5Y1s1WCNBhXcpjMXL9argyr1aho/MiiabU2uJwW
	 frDrtkNhDDXjO5MkFSR4B0JZXtrYRRMPWREnw+wQRLbsh+3XW+u97rAaiZB1t1HZIqohM
	 gdorfdxfbtqEnGhD/58YJxM3r0NY5B66pIOmmfDQ8kUmUPhsC8vpizRA+jFETTb5Ru2yd
	 PbUECEfGogRKNUlGm8OXDidRWHLsCh6GJ6iCY1Y2an1NBG5xcArvfCcY9OYcQoMbEGPVs
	 QxSqCwBVP9x70Rf6v+ZtBBrTysTX8YnLsiTmK8uzpi8Awn+2fHI+jLLkRqoSICJY7Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=4lS1T9V/8hOQNSNI3skemZ6kD/gHU+QD/EI+Xu5vZYE=;
	b=Ya7XuwQrRFD2xdC5r5qfSVpoHOmgdKzhet7ot9hVntD5jKz6Jp96SfNWX8D46+Pb/zwR
	 8oB2PYlYZv8eWBV4nJvu/iedPfbr9NuINchW7FVJin4wWK2NYoeG8yw92d1YmKbJLNgoI
	 huTc5DSQ1RghCJZpksq91GA2ISbbQbnlkRzhKM259AZfFBpIaidKmsmWF3n1nznwXeLb8
	 ExDXPE5l4yK3k0kxbtXgAsOR83E+8gmxbfSzS1+N7VwUGRM07KqAooulgH5KWKhCZ+gU2
	 ZaK4NQpic0pLqYTdu/xOfN1L7Fg7dqaNY8Ci23JzrR2dR4Wtq2UjorCc4EB0kbxzwjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vGOgjVzr;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F93D606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 09:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F93D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vGOgjVzr
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a20c923847so5583245e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792746172; x=1793350972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4lS1T9V/8hOQNSNI3skemZ6kD/gHU+QD/EI+Xu5vZYE=;
        b=vGOgjVzrmhHPQfF26vJcuPQEolaDK+5QQZWWPOaerfKisKndjY2bAa7B1GfCybFKUX
         whoi9uJCcDoiVsIvhO15674cVslx1584Hb8Y9WuHs2U3Qlpt9zPBDG7gNxK7OjQATAIS
         7B2BD2cjIXcqfnsTfmnvIwWh1jHtLTAtVSR4c3rhOx2zLKPhy0/IZ7Z3/FCr6/Zvfx47
         93vssIIQyPfb5NfseXbVTqJihCj5FQ0sB/C1LQbRUgnzW21EneCbgZgwf5gUu6303wdP
         BrBX2l9sjqEM6NO+3lgI5eI9sfqWLmmlYBWfbU+tyU/XXh++UTKFPvZoMfY0ver0I1bP
         8Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746172; x=1793350972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4lS1T9V/8hOQNSNI3skemZ6kD/gHU+QD/EI+Xu5vZYE=;
        b=UMtZf5pBRX2qhu6oqx3p4PBnvbjYz+NRmDdkIb5QE8m8KQsPAPdy8ELFDNuoS7orMv
         9cj6N95V6J2/wAtFFPVB8K2BwHoa2ktwcdMeVtyrClWvz3qHGNY7rVWBHT1XuqnWIWi/
         YX9ipdsH0I7hKUpKatXhdV17k0r9KEvefA/28Z8IOBOZFwrK1dwf8Q6FXCyHSfa1X3Bp
         4XY/Vds5F+ZeKR5qof6RqGCUQbBb1ODdA3aAhMFYwN/x8rp80GkxgGLQtEWJs085+FYb
         dNevBxh9Ex5AHtRIk763TPskqW234JwYuLnPuwS6JCsLLgY3tS6GnzLfVVh940QyAbSH
         3Stw==
X-Gm-Message-State: AFq9FYIjZRNvoT2Uo2igIDLG6tMF8iKHq+9lhOxkcuN1kuYhhxn4kV1g
	EfV3tXQPE7ZBjXSdn9QA37PSsu21ZkzdYzk/lclL1OtfaTNJmXAYSaxADc4hf+P6BME=
X-Gm-Gg: AYBFou1dEfmxH48upYsFMS6Vi0z4hIHFaAMc8JvNh7qZYDiylLRNCBL9P5C95mo15Yr
	dSlH/HC9FaOLlXE/T2zG31J7r5RonEmrMb1bw0L+v/G0KPtF5/jxdoByHAyJ0x+clrZyIXMpjGZ
	1uGv395Q/M9H4kO0iZvHqmmDQeCztqidpi/r4XmtjTZkkfG2vChTcvcc9Rxg/TVjmwG0rW18Los
	Mg7rIFBKoaTwgalA8FrftTSBCEiwHPcXoDdV8rPZDJimJhpGeN2upfPNGKBS70DisbQOVxeqHv6
	WN7x0RtP3fbO7gV68Itlic1LD6EFSOhA5TiKa7/Qwhnm9JieACZSKenmjG7GLetgxKNOncSUg+j
	sScBQA4+Fo8kpteFXsKSs5YHU2oQ3qYXGXweYz2ygx3dIBoHECluI/5Lt70qP780B2Q88PzkWiz
	MLw0K/1qRlwaMVp/66TJLKI0eZv167M3DoI2sS1z8gJU79JoG5s8RQgIUgloiV5R3zyBKExuxDO
	SWUgXaPfDUnfoISjpdbc7Xz/WFkkdLo88+gP/x2LtJVPhImIcIRpKLwiOA=
X-Received: by 2002:a05:600c:4e04:b0:4a1:fb2f:eff with SMTP id 5b1f17b1804b1-4a211ee375emr24473815e9.18.1792746170827;
        Fri, 23 Oct 2026 02:02:50 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a210487d16sm60582535e9.15.2026.10.23.02.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:02:50 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 23 Oct 2026 10:01:50 +0100
Subject: [PATCH 1/2] perf test: Factor out the --skip check and its output
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
Message-Id: <20261023-james-perf-test-skip-v1-1-b6c11bdafd46@linaro.org>
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

__cmd_test() checks the --skip list and prints the "Skip (user
override)" line and its junit entry inline, and
perf_test__shares_mlock_budget() repeats the check, with the list passed
to both from cmd_test().

Make the list static, like the other options, check it in
perf_test__skip_suite() and move the output to
print_suite_user_override(), so that the --skip-name option added next
can hook into the same places.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/builtin-test.c | 83 +++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 880eece0bc12..cd0fc3dedc3e 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -68,6 +68,8 @@ static bool list_requisites;
 static unsigned int runs_per_test = 1;
 /* Number of lines to include in failure snippet. */
 static unsigned int failure_snippet_lines = 10;
+/* Numbers of the test suites to skip, from --skip. */
+static struct intlist *skiplist;
 /*
  * The tests mapping ring buffers take turns using their share of
  * kernel.perf_event_mlock_kb via this mutex, shared with the forked test
@@ -342,6 +344,11 @@ static bool test_exclusive(const struct test_suite *t, int test_case)
 	return t->test_cases[test_case].exclusive;
 }
 
+static bool perf_test__skip_suite(int suite_num)
+{
+	return intlist__find(skiplist, suite_num + 1) != NULL;
+}
+
 static bool perf_test__matches(const char *desc, int suite_num, int argc, const char *argv[])
 {
 	int i;
@@ -1358,8 +1365,33 @@ static void print_tests_summary(void)
 	strbuf_release(&summary_failed_tests_buf);
 }
 
-static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
-		      struct intlist *skiplist)
+static void print_suite_user_override(struct test_suite *t, int curr_suite, int width)
+{
+	int pad_width = get_max_desc_width(width);
+	int term_width = get_term_width();
+
+	pr_info("%3d: %-*.*s:", curr_suite + 1, pad_width, term_width,
+		test_description(t, -1));
+	color_fprintf(debug_file(), PERF_COLOR_YELLOW, " Skip (user override)\n");
+	summary_tests_skipped++;
+	if (junit_filename) {
+		char *escaped_class = xml_escape(test_description(t, -1));
+		char *escaped_test = xml_escape("override");
+		char *escaped_reason = xml_escape("user override");
+
+		strbuf_addf(&junit_xml_buf,
+			    "    <testcase classname=\"%s\" name=\"%s\" time=\"0.000\">\n",
+			    escaped_class, escaped_test);
+		strbuf_addf(&junit_xml_buf, "      <skipped message=\"%s\"/>\n",
+			    escaped_reason);
+		strbuf_addstr(&junit_xml_buf, "    </testcase>\n");
+		free(escaped_reason);
+		free(escaped_test);
+		free(escaped_class);
+	}
+}
+
+static int __cmd_test(struct test_suite **suites, int argc, const char *argv[])
 {
 	static int width = 0;
 	int err = 0;
@@ -1434,37 +1466,9 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 				suite_matched = true;
 			}
 
-			if (intlist__find(skiplist, curr_suite + 1)) {
-				if (pass == 1) {
-					int pad_width = get_max_desc_width(width);
-					int term_width = get_term_width();
-
-					pr_info("%3d: %-*.*s:", curr_suite + 1,
-						pad_width, term_width,
-						test_description(*t, -1));
-					color_fprintf(debug_file(), PERF_COLOR_YELLOW,
-						      " Skip (user override)\n");
-					summary_tests_skipped++;
-					if (junit_filename) {
-						char *escaped_class =
-							xml_escape((const char *)
-								   test_description(*t, -1));
-						char *escaped_test = xml_escape("override");
-						char *escaped_reason =
-							xml_escape("user override");
-
-						strbuf_addf(&junit_xml_buf,
-							"    <testcase classname=\"%s\" name=\"%s\" time=\"0.000\">\n",
-							escaped_class, escaped_test);
-						strbuf_addf(&junit_xml_buf,
-							"      <skipped message=\"%s\"/>\n",
-							escaped_reason);
-						strbuf_addstr(&junit_xml_buf, "    </testcase>\n");
-						free(escaped_reason);
-						free(escaped_test);
-						free(escaped_class);
-					}
-				}
+			if (perf_test__skip_suite(curr_suite)) {
+				if (pass == 1)
+					print_suite_user_override(*t, curr_suite, width);
 				continue;
 			}
 
@@ -1817,7 +1821,7 @@ static struct test_suite **build_suites(void)
 }
 
 static bool perf_test__shares_mlock_budget(struct test_suite **suites, int argc,
-					   const char *argv[], struct intlist *skiplist)
+					   const char *argv[])
 {
 	int sharing = 0;
 
@@ -1827,7 +1831,7 @@ static bool perf_test__shares_mlock_budget(struct test_suite **suites, int argc,
 		int curr_test_case;
 		bool suite_matched;
 
-		if (!t->needs_mlock || intlist__find(skiplist, curr_suite + 1))
+		if (!t->needs_mlock || perf_test__skip_suite(curr_suite))
 			continue;
 
 		suite_matched = perf_test__matches(test_description(t, /*test_case=*/-1),
@@ -1865,7 +1869,7 @@ static bool perf_test__mlock_budget_exhaustible(void)
 }
 
 static void perf_test__setup_mlock_budget(struct test_suite **suites, int argc,
-					  const char *argv[], struct intlist *skiplist)
+					  const char *argv[])
 {
 	/* Nothing can be denied the budget, nothing to take turns for. */
 	if (!perf_test__mlock_budget_exhaustible()) {
@@ -1874,7 +1878,7 @@ static void perf_test__setup_mlock_budget(struct test_suite **suites, int argc,
 	}
 
 	/* Nothing runs at the same time, nothing to share the budget with. */
-	if (sequential || !perf_test__shares_mlock_budget(suites, argc, argv, skiplist))
+	if (sequential || !perf_test__shares_mlock_budget(suites, argc, argv))
 		return;
 
 	mlock_budget = mmap(NULL, sizeof(*mlock_budget), PROT_READ | PROT_WRITE,
@@ -1936,7 +1940,6 @@ int cmd_test(int argc, const char **argv)
 	OPT_END()
 	};
 	const char * const test_subcommands[] = { "list", "requisites", NULL };
-	struct intlist *skiplist = NULL;
 	struct test_suite **suites;
 	int ret;
 
@@ -2010,8 +2013,8 @@ int cmd_test(int argc, const char **argv)
 		intlist__delete(skiplist);
 		return err ? -err : -ENOMEM;
 	}
-	perf_test__setup_mlock_budget(suites, argc, argv, skiplist);
-	ret = __cmd_test(suites, argc, argv, skiplist);
+	perf_test__setup_mlock_budget(suites, argc, argv);
+	ret = __cmd_test(suites, argc, argv);
 	perf_test__teardown_mlock_budget();
 	free(suites);
 	intlist__delete(skiplist);

-- 
2.43.0

