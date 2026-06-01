Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9643348445
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294498; cv=none; b=CxqusboieSbLtOtBRfPpZWNI1MSJS7qU/FYLWgTg5le/auYRMiXsk4msogHb/b4njPENDsjGcEn6UUkAeVNem//jQz8UfUyXHZQjP9sIaBcADTUaUkqDnDsAsLix8O0FfInXsP/ykT6NlUwEf1YvSTHsuGjdMtGU1EbVL/n4PEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294498; c=relaxed/simple;
	bh=70Cd7Tr5DNaTW5TJ6LRmaLRDgxUeR2l6vLb66l08QGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NpS7+eegEehQGLlUO1p22dhBh55CG9bh0/mZtui9rB8zvWyTrDYR16VNOIEEQmZLCUpll7US2kXXbRGWwAL7Uje0OLKVKH91AIgpJuLV9YZE41jHtuOvbBD3EpN95EaUxw1vyS0ATPVr3sg2FZzSZ178AVTKJ1EleTNc8BsiVE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u04N8qHY; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u04N8qHY"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137276019cfso7779187c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780294496; x=1780899296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x8eARVF1aEz6PcKrYzAcMJYJ5B598/QhTEDpTebmYts=;
        b=u04N8qHY/VRRGRdO83CJXp9j8CqUYEJhguCc/FGq/rhLawsvZujno1shV59nAmUmJF
         bGxOlH9hUlryybKE/WWg/7yWbdtSC093cYBlujXECbZ0Z9/2Oq14EyNaWNf4HjGmQEcV
         3tVds2chHEtEnDsNyUqRAT1HnWv3S7f4sWAPz9VViXyw/+YKpzq+G4S8Opj6LADoJtR6
         q7P0mRQrbIcRfKCKS2s6SfvIGJrxujnlEA1+b1fRshoZDxasT3Yz/vFlzScz4gW0KQCr
         TR3pz+k4XZXMKtvcXslMyfXdnLPZT1pb3KJxRV0sfz7+wqUVkdT3NjIKg0s5uu+NpZHE
         eeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294496; x=1780899296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8eARVF1aEz6PcKrYzAcMJYJ5B598/QhTEDpTebmYts=;
        b=sNP1dnauUj4grWkjJ+69aSrQlgx9+C0dOI14s1ESKtdr2gYDDhOE+xPmo08Yof8jwD
         KaGqUs76eOkxSyM8rHMJ5gpzgOtDnFmvisreju24C5qu9Uyso1fCdLESHyrvJ87Quu6A
         amNA6u5Oj5bLAJrnXTvh2a75+LSRmPwFIn6ZEJVKEY71KixPQ4cb1R/Xe40L5WyC/upO
         nDrscZP8X+XuoZfK+6GOD4Si8s28iyqOTDLdFuWk4GQBO4Q6pXS+Y5YUkszTbYMuRaCr
         rM0aY2Zic6Z8tcFJWETTyoLJrZZP8Q3S+SFD6SRVgkpv/ZkKa7PX2BdAPC/3lFJCJeF6
         Xmrw==
X-Forwarded-Encrypted: i=1; AFNElJ8hAkBPQDUn5+hiyOdBPyWFIXewnI34Txrk/9WZVV/UHSo4WYKeri4DLwSgGJO8/pCDKShMPsyDJS12SRcmcnN0@vger.kernel.org
X-Gm-Message-State: AOJu0YyVDa0lA4FitKllLUk5kqxV4wlYSg06nO8iS27LctnoUbqAmtPF
	va6czVcjhKA9PmY5W+lGQxU6z/f9ugiRmEQOO89CeezKFyKlbavZvqnoUXEI0zCI1YMA+Bfhywi
	8tseO2k8gFQ==
X-Received: from dlbvg15.prod.google.com ([2002:a05:7022:7f0f:b0:12d:b7d3:3e31])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ff48:b0:136:c8a3:21b4
 with SMTP id a92af1059eb24-137d426fcb8mr2952577c88.42.1780294495902; Sun, 31
 May 2026 23:14:55 -0700 (PDT)
Date: Sun, 31 May 2026 23:13:50 -0700
In-Reply-To: <20260601061401.1541457-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601000548.1195604-1-irogers@google.com> <20260601061401.1541457-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601061401.1541457-5-irogers@google.com>
Subject: [PATCH 04/15] perf test: Support dynamic test suites with setup
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

