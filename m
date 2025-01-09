Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D2B2054F2
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459470; cv=none; b=LmDDyat8BaF/fVJP2VFyQqMZbJorjP9EmjCZseMqBDAwuFy3G8QnBxkXWYh81AvymYXrgMMkn0BSnzAT4o8AMPufdEThyxiYHaoInIpzich95wHgyvmCDgx0qtkmoMaHy92f7BjTt03SBghLZP3vPHC4CWWoPWz+Cap7jCsb0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459470; c=relaxed/simple;
	bh=vhCg2Tn4Jb988ijQ0zQZjM97dW0OeNNbp1gyJpRiTaU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=juiMCaWAKSpFdAuSLv8RZZYHBZOJ3lNZUpxtLP1KfMs8+ttn++6KXHmLZUIN/T8u1lfIXJbzIiQCMi6uA/VkmX1C9uzAXBcRFagZjcvLZ6uc5Od1HVbWtPjCqDgBxDn/80TevaKsJs09sogX80LjMxAjYzLbUcc5tfKDuPI513w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ku+1h5dS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ku+1h5dS"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3fea893dc5so6124722276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 13:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736459467; x=1737064267; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thLKIjRQQE/DKKTvw6zU/13XquDliG1HZakbYNUIuAA=;
        b=ku+1h5dSWyTo14iOgEZx4Nk0KGxinj9aUKPYw2V4poEdp5k1/DcDHFpzr1eytj2TMG
         EkDJIo907Luf/q3cvCmnxBYwihaa7H8KoN5UIZrPcJP0UadMVZA5gBBuz99v7AR1FWmb
         3SPQ1lMw2/mP7YLIn/9BWP+7TfCgIb4vzDtnpGcccz4FbQ+TL9NkWiekI7IWEZSOJS+g
         Kp16zjBdoE5UFxFrGegufBvmUnLehIluVBp9wdumFr2OMh4OUjgwkyJAjSvp+AKTklsK
         T164QTzW5KkwJazZlsWFEIUlfYxfirNrP3ckOvjpOG+utVVyqy5Bn5PsPn8V8SU4seEC
         Qzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736459467; x=1737064267;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thLKIjRQQE/DKKTvw6zU/13XquDliG1HZakbYNUIuAA=;
        b=Uqz3LtAD6paWb/cZJDk6snCpSaTpd6Dabgots4mnH24HWE1D7DPriUuOktw4I8px7l
         IQvh6rypYx18V/5qh9I4Xk2w4Jc4YNCGO9hfEwpSIQd8CgXUq3tCPmrVtxL98qifxzFY
         nOzRiZ74UG5Ll8/IZRbeuGYt/RxWtt02u3NsPB70R1FfgSmJcgQiXDMUqHZFZFgtpWD2
         Qwqc+UifizNTI0R7RDiHEoL41sWtQu8vlc8IddtD5Ew24WvcROElvH05Z/FHpPWmJtLL
         DiRO+VsptlL9pqNSaAnX3/GlzdAACtvi2zHzMfVXXbmeUOQw9Cr7KFpKkl/n9RZorvFb
         0nFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFz/6aMv8NHrFEA2d3JRWSbEQiOF/s4AxDrMk36x9MIH1dr0KSiMlEtiPz35Eq59wVJLxQa0YBENvZaIu3AjSR@vger.kernel.org
X-Gm-Message-State: AOJu0YxDwnFRzTQBAGWMphyKnI9HolWR4l2eXRjrC/wmwNWBNMq7T5/P
	3i5W/q7GLPe5Zg5l5UtkpeFO0rQs9Sz1FZVSGdi48hH+NMvYRUIaiEchaM1n9iLJ+skb0X9rdqW
	vorPmVg==
X-Google-Smtp-Source: AGHT+IE0kvQqeFKIpoGAYSuP5lV8JZPyWKwfFHxLLAsfv1Ims860mcvv1SmXf/HZbXKN/4mdTvKRyQkF7/QW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a05:690c:e1f:b0:6e3:c4cb:689b with SMTP id
 00721157ae682-6f543f7dbc7mr192377b3.4.1736459467557; Thu, 09 Jan 2025
 13:51:07 -0800 (PST)
Date: Thu,  9 Jan 2025 13:50:52 -0800
In-Reply-To: <20250109215055.454888-1-irogers@google.com>
Message-Id: <20250109215055.454888-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109215055.454888-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 2/5] perf test: Send list output to stdout rather than stderr
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Follow the workload listing in using stdout rather than
stderr. Correct the numbering of sub-tests to be 1.1 rather than 1:1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index daf52c83b0f9..c6071c4db741 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -579,7 +579,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 	return err;
 }
 
-static int perf_test__list(struct test_suite **suites, int argc, const char **argv)
+static int perf_test__list(FILE *fp, struct test_suite **suites, int argc, const char **argv)
 {
 	int curr_suite = 0;
 
@@ -589,13 +589,13 @@ static int perf_test__list(struct test_suite **suites, int argc, const char **ar
 		if (!perf_test__matches(test_description(*t, -1), curr_suite, argc, argv))
 			continue;
 
-		pr_info("%3d: %s\n", curr_suite + 1, test_description(*t, -1));
+		fprintf(fp, "%3d: %s\n", curr_suite + 1, test_description(*t, -1));
 
 		if (test_suite__num_test_cases(*t) <= 1)
 			continue;
 
 		test_suite__for_each_test_case(*t, curr_test_case) {
-			pr_info("%3d:%1d: %s\n", curr_suite + 1, curr_test_case + 1,
+			fprintf(fp, "%3d.%1d: %s\n", curr_suite + 1, curr_test_case + 1,
 				test_description(*t, curr_test_case));
 		}
 	}
@@ -721,7 +721,7 @@ int cmd_test(int argc, const char **argv)
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
 	if (argc >= 1 && !strcmp(argv[0], "list")) {
 		suites = build_suites();
-		ret = perf_test__list(suites, argc - 1, argv + 1);
+		ret = perf_test__list(stdout, suites, argc - 1, argv + 1);
 		free(suites);
 		return ret;
 	}
-- 
2.47.1.613.gc27f4b7a9f-goog

