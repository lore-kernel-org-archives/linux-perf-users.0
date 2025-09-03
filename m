Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FBF368098
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Sep 2025 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924982; cv=none; b=b/LrR/pRf+UfD2OJBx/bLYLPkjFK5eBQwQ7wceCN7u+hyHgYdP+ehOp67yYB4Iqex6XpXkBiAAAYxbNByRpmqakK8gp5tQH24xU9ND3nYgo25np6kDEOnCRrwzucnKwYiTzGB3IzeJm/brkonAxaxj3Q771ZKE49BnO4d+2oWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924982; c=relaxed/simple;
	bh=+/4V1TnkaJE6dJlPtdCaVs2/y027qYyexTsOM8eV/88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NBhTT1usL+w7iB4krA3O++AtGT1TZr2BqDN+h2eg+N3VawtzoTbaXeUgBxStva/kPMyEEgDU2Po9GRw9ueSLrLPU5nR34AVd1lqM4xZWq8qTC4kTSVmJlLoERk07X6FYDiaReS9vlMM4bCNMq43OBzcStkgN7JU2E9CWWYea1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F8GtgIWC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8GtgIWC"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24c99f6521dso2584735ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 11:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756924980; x=1757529780; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMuEm8Xw//lz4NUX5kNhF0+ljXCstooczXL6JPzhXbY=;
        b=F8GtgIWCoW72IJPLOfdM+rGzRCGBT03CUEP+3OE18Mh8NW8ZYj6UUJXG15oXDfqhmx
         3vI9nP3YQm3lhzJqsPkNsrRjQW94ed5cnKTLPyaSBvSJgkn2uwzcP+JiK22MkHjCmmbO
         dAROUp9KT0c3aGsjoCc2wMhUgicr58zKahvqr7SZegD7RcZFWqvS1Orp1eOhJGehWLfU
         X7Cskc9ZzbUM4zKekswtvGP4b9VjKqYPEH6s8KevZOD9go1DdL98vxO5VGPqkyzpgKUj
         zIVjdZ/dLCIFv7PskS9TN7tS60x+MtNumMfqr1oFoMSK3CNVOdVe3dzAgZ6FGi8cG3Km
         mEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756924980; x=1757529780;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMuEm8Xw//lz4NUX5kNhF0+ljXCstooczXL6JPzhXbY=;
        b=ahcyUKjnCgdyNds2K545Ux+dxkXIzBvOYZThg6XanXLkz0oRKJ4WW4T1xizoUkeueQ
         PD44kE7tM6H4wUt/ZVET1l7hfQIEfLPQ5x+cCIeBLM8YQ0pi+nMUIB6LAt+kb/cFZJX6
         FlG7DqwwCLyWnCuuVuTYaBhhS2zKg+tzdkkMLkPBYwRjVqM9aDkAlP3H5wiBbizfQPPg
         E2962FtZ5N3Kw+KOkzOoEwv89J70LAo5eGnqcLvS+3Zle36oGxy3QqDjiTGkhsm4ANKs
         uZlNt34yzhl+2+Edpv9c3GB1GjkgOqzBlvPJNF35YgfkhyWlXX4jjxN87mpfUCp3asyP
         bX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZt2JJpB9aDgHJSdVdH0+qQ/qJZR5w9UzlAJY/nO6/OBW/iB9c0JAh0pZRnxp9acBajHDvIwmd+PGxTHt6lO5H@vger.kernel.org
X-Gm-Message-State: AOJu0YxfvOfjqcNA91muw8P1ZKStbri71ae8Rch+/G9pfDDGn85uWyvp
	AIQnNtNoya/HGlkuiUffmFQPDc3HJv1PDeGTFOEBHfBic1iC7pedgaslGOFaPE/BhCfbVk+Ox+M
	0kfqTmQFBqw==
X-Google-Smtp-Source: AGHT+IG2Xh8nMC8Yttp8497v8vS1VI/rD3BoINqu67RTeFSF+xQ9MjBvrvIya2fLPQUfpqpvCfNI/pkOZT+q
X-Received: from pjur7.prod.google.com ([2002:a17:90a:d407:b0:31f:b2f:aeed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c1:b0:249:112c:f947
 with SMTP id d9443c01a7336-249448e49a4mr199749675ad.19.1756924980399; Wed, 03
 Sep 2025 11:43:00 -0700 (PDT)
Date: Wed,  3 Sep 2025 11:42:48 -0700
In-Reply-To: <20250903184248.695267-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903184248.695267-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903184248.695267-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf test: Remove C python_use test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Removed in favor of the shell script version.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build          |  2 --
 tools/perf/tests/builtin-test.c |  1 -
 tools/perf/tests/python-use.c   | 27 ---------------------------
 tools/perf/tests/tests.h        |  1 -
 4 files changed, 31 deletions(-)
 delete mode 100644 tools/perf/tests/python-use.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 3e8394be15ae..af67f8ef74b4 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -20,7 +20,6 @@ perf-test-y += hists_link.o
 perf-test-y += hists_filter.o
 perf-test-y += hists_output.o
 perf-test-y += hists_cumulate.o
-perf-test-y += python-use.o
 perf-test-y += bp_signal.o
 perf-test-y += bp_signal_overflow.o
 perf-test-y += bp_account.o
@@ -75,7 +74,6 @@ ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 endif
 
-CFLAGS_python-use.o   += -DPYTHONPATH="BUILD_STR($(OUTPUT)python)" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
 CFLAGS_dwarf-unwind.o += -fno-optimize-sibling-calls
 
 perf-test-y += workloads/
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 85142dfb3e01..cb09b8f40b41 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -84,7 +84,6 @@ static struct test_suite *generic_tests[] = {
 	&suite__syscall_openat_tp_fields,
 #endif
 	&suite__hists_link,
-	&suite__python_use,
 	&suite__bp_signal,
 	&suite__bp_signal_overflow,
 	&suite__bp_accounting,
diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
deleted file mode 100644
index 0ebc22ac8d5b..000000000000
--- a/tools/perf/tests/python-use.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Just test if we can load the python binding.
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <linux/compiler.h>
-#include "tests.h"
-#include "util/debug.h"
-
-static int test__python_use(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
-{
-	char *cmd;
-	int ret;
-
-	if (asprintf(&cmd, "echo \"import sys ; sys.path.insert(0, '%s'); import perf\" | %s %s",
-		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
-		return -1;
-
-	pr_debug("python usage test: \"%s\"\n", cmd);
-	ret = system(cmd) ? -1 : 0;
-	free(cmd);
-	return ret;
-}
-
-DEFINE_SUITE("'import perf' in python", python_use);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 97e62db8764a..e17594352b13 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -120,7 +120,6 @@ DECLARE_SUITE(dso_data_cache);
 DECLARE_SUITE(dso_data_reopen);
 DECLARE_SUITE(parse_events);
 DECLARE_SUITE(hists_link);
-DECLARE_SUITE(python_use);
 DECLARE_SUITE(bp_signal);
 DECLARE_SUITE(bp_signal_overflow);
 DECLARE_SUITE(bp_accounting);
-- 
2.51.0.338.gd7d06c2dae-goog

