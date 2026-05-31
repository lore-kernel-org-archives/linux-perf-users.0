Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E13815EF
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780215778; cv=none; b=gtS3QW24Z8TZ/URX2sBe4xkFz+rHoZOzBhZZDljexE08sGDk7BqZPjje0/EQ1fiR+0h0ubp2UxJ5bLywjUIw22MbtpPVZixFs8q8QLMUVH90Poo75nHC33tJuYWvp66ff499AHpM2CiW8joxSG/qMeR+eUKKmDrtZyN5LxPTxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780215778; c=relaxed/simple;
	bh=70Cd7Tr5DNaTW5TJ6LRmaLRDgxUeR2l6vLb66l08QGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nQ7++mkUfQqjlYkm4IlQAiTqPcVx+eI9UlL/ZMIRx0AYCIol/uP6/qJV0lGULmaNK3quYASerqFcRuS5MiyAQ/OHSJtrBZeWrITgQb2uvSniZj8kzpMCWJSmqZ0GKTszCo7UQCo+AINTebJO7BwYaLtDvVyEzB2m37UbkNjwdeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HBGv32LA; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBGv32LA"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137d003cf09so4565754c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780215776; x=1780820576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x8eARVF1aEz6PcKrYzAcMJYJ5B598/QhTEDpTebmYts=;
        b=HBGv32LA3LhTpTYUJdoZgSxIgohKM6FKnbKQrz7wWPT6cyMa7D6bB3Gi57kexf0itk
         JdJlouhUYj9M4XVZ4DYFFsA9pddn+zep/mdW/5NcfL+Gj1udeeMMhDfynBlGIrI1uqGX
         yKCba8TXD+qVxa+kyf/78wWCS0aAXK0J+cYrudOJr03eQGL/eO8MaloN7/aO2eot9rfG
         C2tA9Y7Hnt/RywHQXCOSVxCLMNO//icdOGcFndb2GnDaLjlHnK8TF/azwhBHznlzgeSM
         0+s0P+deup8UZn/WnCqOkA4w69BPfR2eu3e2cytDWeR50cFiUDlpdpK7y1D0AC2yEx6Y
         Kf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780215776; x=1780820576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8eARVF1aEz6PcKrYzAcMJYJ5B598/QhTEDpTebmYts=;
        b=hbBoK0dUPwXrno9dbXuVBR0UUZUM0aFTYOn5N5OzlwMJL/vrW6tOPiUqv7Dx66JmJ5
         hHaC7kYLZEjIM4OQZS2KhDeFKo5uLWUNmAifF/oD7PX8NQx2oHq7577P9k9hlG48Zh6j
         4sbe7MBTB86FUeRM+a2CEWvaWH9LOvKfn++vOOjPJYpee+7WpoCTT/ZGyelWnj6XVFNN
         Ndwiwe0AiA6VUrdLTc6hoULMUd3CO45tJR8e3tQfrGWUx8tfemU4w10j6lLDBDiyQpeS
         S5V25Gl6iQiwUQB0RO0LIgLfYd1xcr2Cndn0vTQJ2oreHcamfv5WXH5u67suSsIBXu3o
         0kqw==
X-Forwarded-Encrypted: i=1; AFNElJ/QRGa54IsRM6HWxaf3hiX5BmSqgm77D6gpo4hIGuQBXQZz7gPJ0dZb2KttEjC5dffyE9HkwlUAL7Snsha38dyi@vger.kernel.org
X-Gm-Message-State: AOJu0Yybzddsg3d90+ECvxTlgrQqwfuERQ35mGxSo8XOqopahov1VXtN
	xKBV4l/yv/vw1qwAQSPMeR8ObX4YND8ippKe1XSLnq2NYWZ1makvr2k0r/qDBQvZKomG4gBNr+g
	/Nw/8mPVoYQ==
X-Received: from dlam17-n2.prod.google.com ([2002:a05:701b:2091:20b0:12a:7dc7:7b04])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:69a9:b0:136:c565:e83a
 with SMTP id a92af1059eb24-137d426160fmr2841626c88.24.1780215775746; Sun, 31
 May 2026 01:22:55 -0700 (PDT)
Date: Sun, 31 May 2026 01:22:24 -0700
In-Reply-To: <20260531082235.940833-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531063736.871777-1-irogers@google.com> <20260531082235.940833-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531082235.940833-5-irogers@google.com>
Subject: [PATCH v4 04/15] perf test: Support dynamic test suites with setup
 callback and private data
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add void *priv to struct test_case to allow passing per-test context.
Add int (*setup)(struct test_suite *) to struct test_suite to allow
dynamic generation of test cases.
Update build_suites() to invoke the setup callback for each suite if
present, ensuring dynamic cases are available before listing or running.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 15 ++++++++++++++-
 tools/perf/tests/tests.h        |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7946878195b7..2ccb52a776cc 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -765,10 +765,19 @@ static struct test_suite **build_suites(void)
 	for (size_t i = 0, j = 0; i < ARRAY_SIZE(suites); i++, j = 0)	\
 		while ((suite = suites[i][j++]) != NULL)
 
-	for_each_suite(t)
+	for_each_suite(t) {
+		if (t->setup) {
+			int ret = t->setup(t);
+
+			if (ret < 0)
+				return NULL;
+		}
 		num_suites++;
+	}
 
 	result = calloc(num_suites + 1, sizeof(struct test_suite *));
+	if (!result)
+		return NULL;
 
 	for (int pass = 1; pass <= 2; pass++) {
 		for_each_suite(t) {
@@ -831,6 +840,8 @@ int cmd_test(int argc, const char **argv)
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
 	if (argc >= 1 && !strcmp(argv[0], "list")) {
 		suites = build_suites();
+		if (!suites)
+			return -ENOMEM;
 		ret = perf_test__list(stdout, suites, argc - 1, argv + 1);
 		free(suites);
 		return ret;
@@ -863,6 +874,8 @@ int cmd_test(int argc, const char **argv)
 	rlimit__bump_memlock();
 
 	suites = build_suites();
+	if (!suites)
+		return -ENOMEM;
 	ret = __cmd_test(suites, argc, argv, skiplist);
 	free(suites);
 	return ret;
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index ee00518bf36f..9bcf1dbb0663 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -38,12 +38,14 @@ struct test_case {
 	const char *skip_reason;
 	test_fnptr run_case;
 	bool exclusive;
+	void *priv;
 };
 
 struct test_suite {
 	const char *desc;
 	struct test_case *test_cases;
 	void *priv;
+	int (*setup)(struct test_suite *suite);
 };
 
 #define DECLARE_SUITE(name) \
-- 
2.54.0.823.g6e5bcc1fc9-goog

