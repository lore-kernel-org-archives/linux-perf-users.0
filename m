Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8FC2066C6
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 04:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736485066; cv=none; b=Kw37rZg+lFdAjFl4OYYpq7ZGFu9gljT0StixKi7+27vAfBoJLPqgunjxgz+DvC/6VHPPQiNbpz6Inzmf1ph8L71ku5e7+bzaiF9C9Tyzpm5w5Yk8Xz/3N6hzT7dNWbpHdv+HAidHqQ/HxDZeksCOWex8rPLmgDxzZkAMUp3/Lqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736485066; c=relaxed/simple;
	bh=vhCg2Tn4Jb988ijQ0zQZjM97dW0OeNNbp1gyJpRiTaU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=E65wxuD8PwT2aORDNcQGJ7EU7apyZEbbIsiFHhJ5e1FFeqy4cMpaLkdypAd9NY/xdR2gM7SRiuGmFG9sUEljia/Rk5c/KTduTYL9jWSEUeNFNFgzG9pfTRZ+apSvqSOidijs5FzN9FjUGn/VsBVpSLIj84kPIK9ligNPlWAWMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IItVIZ/0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IItVIZ/0"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e544c8dae18so4233325276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 20:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736485064; x=1737089864; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thLKIjRQQE/DKKTvw6zU/13XquDliG1HZakbYNUIuAA=;
        b=IItVIZ/0AofM0DoEssDnNitX0TC2xS/v1vfHLcWdAm+HRcIC6UBJTbYR/GB12z6NKe
         QO/JuJAyyf486ovQaTVY66Gy/HcTE4uZv5qOFf6gEoxt/4JsfPTax/uAwoU0cu1WHtHy
         ePbPwtN3T24aQup83sDbt4BDbljzOBCE6MXH7BItQwFwY5J6JY6BYbveMEn27nPEg6qD
         Qi4RzAK+mBxwsqAFbsTzq9TkWjCJAxJQngwaIkO5O1uC4A58RpCpG4l0gNOK7OtOb3WW
         IajUZArlungoAQHEamjrgwM9IPZPYnwoXkKiDMI170hLGuq/LZAb8wAynv66WPuuHgrN
         /sBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736485064; x=1737089864;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thLKIjRQQE/DKKTvw6zU/13XquDliG1HZakbYNUIuAA=;
        b=BtWJ6pergjsDh/YTI9xlrpv3kVRqIF9Fzyo8qUDgJ+Kh0Lv1+h9+cP+lGPZTPB9zl6
         jeGQfz8+Pc7TxK6rtS5P8IJK2QZHjWW72jLGQwKyNRn2TLd34WshU7rxcfkVyIOp3I2j
         hhcy2taXV+UX6Ae24++4LGMcC4Tcf/2GPJ9anFlC7zIeQdzfpQCozGxOZDPjShR2Pzjj
         pFQl1Ou7zZGrtsfzTPHbdr8qDCdge/at2C+r/H5xNRuUxoTc/evR/K3R/1FUaMRj9qom
         vSngRQ5zm1eoVIcjyxMeZke7sjR8+qPtFdQOosgRbEZMtJimEh8E2j4uhBYwjeKf3JCb
         ax9A==
X-Forwarded-Encrypted: i=1; AJvYcCV4zKro2eXbC99a57SLsNekZ16BmT6I6PGLOBAgD3V0eJ6RAQjoWhpYlUNjuGyzK6Q4zlE+LkLsZMj2lPfQ8WuW@vger.kernel.org
X-Gm-Message-State: AOJu0YymAeCU7Kx1SKI2EUQmzLD9vCjDOr6QFVtuD6YTHG3LtcDBSJoa
	gexrckQD/TN5tqAO/vn+GCbVh6bxoN5RQCQxZ8WaqMrQqCVGoax9OFMk5Tv01Y+aH7uJ7SzFezf
	ejk8LTQ==
X-Google-Smtp-Source: AGHT+IEJN0HinTlexQ7R1EtYrmRqv7xFgm3o7LgBYzge1N5nr8Jp5d/ALxvVMuKv3yb+q+6iCkBD6Dg2FoXS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a05:690c:6f0b:b0:6ef:6eba:1d53 with SMTP
 id 00721157ae682-6f5313014c0mr259517b3.6.1736485064147; Thu, 09 Jan 2025
 20:57:44 -0800 (PST)
Date: Thu,  9 Jan 2025 20:57:33 -0800
In-Reply-To: <20250110045736.598281-1-irogers@google.com>
Message-Id: <20250110045736.598281-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110045736.598281-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v5 2/5] perf test: Send list output to stdout rather than stderr
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

