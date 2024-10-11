Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51920CCC8
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632194; cv=none; b=hG9/VtYsV0YAPArmPCMfJmfLcWXkKV9uzDX5rANmrA2ZA0zix/iYwLYbentsTxHCmx/WIVhfzUrOzDsp0egdcUWw0mmkChN01vhjE0R+kpQSQzBb9yoayVQHUWIHTG8jLfveaiQXcqBvtOODVYGdPK2XYN1hPVapNI12ZvspeqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632194; c=relaxed/simple;
	bh=7cqOV3OKkh0N+su0/SwF7baEzp7XzLuZ+XLRbByZ/6Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oWSU37VjVltdzG3zkQvyUYLsknineX/7TeJSU/jlOzH4s6ROpxlk7+bgneGy+AyGkHcN+7cKv1n4OPz2/QY/L+jXflj0aaa71hV3CYZajbuX3ovedZCYmzyCkjeG7+HFspOcJNmYCC04AsvwiqL1quW1sYVh66wm3LDqQYhG37c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nTKWRUil; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTKWRUil"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so38392257b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728632192; x=1729236992; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fQaK0kCKOZGBatmn2bqZbV4z0l+dtzmVYsD8j3jWpk=;
        b=nTKWRUilqiqh4AEX8WKZ0HhnUIqvIufEtQ6IIEGKqTZ0Vc/mPSlFuQg0//imSejJTp
         CJrUXtOmHp1pQUpKZVl9ZqMzwVY9KA7KcDyq/sSxq5tLeRZgfgLpxJTj7cnsRJDqZ7CN
         qvF1Gk4n2UroSLAxAqv+kX6bU/o6HaMfu2VN7S14XDivJBHTCKkyEULLpIATcY8nK9ie
         BR3JvDRsYgSQ2hr6f5vwwkVHhiP77XpEramvO02qcPmElgb1Tt31Q1K27lI4H1tzCGc4
         FhnIW+Jh82nioUu7yNMTdA1BhQpcKw7YYYUGwuQyU8y51nvXgRhWg5H0dxsLHUZoXg3T
         UY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632192; x=1729236992;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fQaK0kCKOZGBatmn2bqZbV4z0l+dtzmVYsD8j3jWpk=;
        b=rpeYK7x4G0sbEPrqpsM7D6Y69tOPzKueHXlJ9YJqcz4u6/YgUBM6tXESFjasyhhFsX
         5VewHwssq81BhUjcLNycIz7DeFaa72LbbWa3s5RmVA9VCYz2H5HVEyZ3ZgMfmT92SShK
         g8D0UOfGmLOXIGhE7cU/Ql9FhNW1+4K0B5RY8xOfQ75zi1J/S5u+t3/BufzTENFLCLZT
         MLmjBz48eKEfUkOpSoZq+3UAHWKijGBR6y7voD+77/r+D3Obfirw9y+XEfEAQ3RvR/+I
         3kWYgurzUXC7sdjEB0HnA5jtpnZh2gh5CmS2n6A8jmBJ9J5AImqafybLN09WLg+njUuV
         ng+A==
X-Forwarded-Encrypted: i=1; AJvYcCWjP8++x9uWRL8Ve1GQCiVmNZ3Yed5S5TbZi4lOduLiRJitSn/YZ02/9Y7sy6FdD8/1k7gmx/J8VBRspbtUncHi@vger.kernel.org
X-Gm-Message-State: AOJu0YwCVMMcpnRdTJSUVHz7TvkfIWIDu1VWRi/dG/9ehTxRbW+RKyfN
	JMMC3oDJZW901KimRck/IBWaSyAzZ9HxCzWEVGHF1hqChIg4sgvfDoszZm21qTCLcPOmt1rPRzw
	cvK4PCQ==
X-Google-Smtp-Source: AGHT+IF3KkyD+E9c898rKYU9e/dhW5sEakuibvn0Cey33Cw5++s26UatIho8gVX2C49X9jgcYvAvAPF5dAGC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e13:b0:6b2:3ecc:817 with SMTP id
 00721157ae682-6e347c6547dmr47247b3.8.1728632191939; Fri, 11 Oct 2024 00:36:31
 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:35:59 -0700
In-Reply-To: <20241011073559.431302-1-irogers@google.com>
Message-Id: <20241011073559.431302-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011073559.431302-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1 8/8] perf test: Make parallel testing the default
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now C tests can have the "exclusive" flag to run without other tests,
and shell tests can add "(exclusive)" to their description, run tests
in parallel by default. Tests which flake when run in parallel can be
marked exclusive to resolve the problem.

Non-scientifically, the reduction on `perf test` execution time is
from 8m35.890s to 3m55.115s on a Tigerlake laptop. So the tests
complete in less than half the time.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index fd6b50f4d145..2d62b4961f85 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -40,8 +40,8 @@
  * making them easier to debug.
  */
 static bool dont_fork;
-/* Don't fork the tests in parallel and wait for their completion. */
-static bool sequential = true;
+/* Fork the tests in parallel and wait for their completion. */
+static bool sequential;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -619,19 +619,12 @@ int cmd_test(int argc, const char **argv)
 	};
 	const char *skip = NULL;
 	const char *workload = NULL;
-	/*
-	 * Run tests in parallel, lacks infrastructure to avoid running tests
-	 * that clash for resources, So leave it as the developers choice to
-	 * enable while working on the needed infra.
-	 */
-	bool parallel = false;
 	const struct option test_options[] = {
 	OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('F', "dont-fork", &dont_fork,
 		    "Do not fork for testcase"),
-	OPT_BOOLEAN('p', "parallel", &parallel, "Run the tests in parallel"),
 	OPT_BOOLEAN('S', "sequential", &sequential,
 		    "Run the tests one after another rather than in parallel"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
@@ -662,8 +655,6 @@ int cmd_test(int argc, const char **argv)
 
 	if (dont_fork)
 		sequential = true;
-	else if (parallel)
-		sequential = false;
 
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
-- 
2.47.0.rc1.288.g06298d1525-goog

