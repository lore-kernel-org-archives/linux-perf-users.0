Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472A219FF;
	Fri, 11 Oct 2024 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728626225; cv=none; b=nGsldl4apkyLJ4xCwgo9NT/W+2SmldopZMAUhvwKO3Un6ZJ677OyilLCMIHH7f/NpQnsxHwwRmnygwlPgocTMhHZMa6FO4yrNeKXCL1xtoVxI260+R1o4C+j20teGivMiJhYimDmrEQGxcdsimMfbp7g4Kai7Aoh/4PjPnoXqjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728626225; c=relaxed/simple;
	bh=VIa5O4Mkdunqty1j3ijQFPaP6a0eBpH22xQkVKIqdhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ksKOniE0vTeR/y9M+dAtNhKcBnO40Jk/3Jz7eiIuohhkzWBvFdiEpQmvwpyhBGNQVrQ7xs6b5/Ri+2W1D/xD209xEPrrUvwHR3WevwbikEx3bmELIO22hUKYLhYB8P7eMbuj5NuEIwe4uLaN2+ZPo0p517xOjSrOOcB9+HF0wtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE0GFfAQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE0GFfAQ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c6f492d2dso17084715ad.0;
        Thu, 10 Oct 2024 22:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728626223; x=1729231023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPo5xhewKlshq8RUYllOw1URvyS0utF68/5Etae/hmo=;
        b=iE0GFfAQ6CQbblmgJcJ5Y6fUnR3EgTzZC+X7Y75+FjGPQX14jB707V1cGO6Aa0VLms
         QYNR9aDB0E8pRoHDkqAaFLKvNdQ89kIkna/gcvNvV0xf9BNV+bQDGVwB6tA0wbYmkNVw
         jzB4IACAGWZDfSI/cLpqe/RmddEIDiwE7I5dpIEGi7IYs8uvlV+mQK/HSTO3wiSGka9d
         ZrpDzJKOi8lH3AtjaxJeBN81MspuBT3nSa3O+lda3CWg1RF3fnd9bbL4BiPAIZvdeHGQ
         En9PeGmY1SqraB74qmUjTkCx7ZtW84HTcea1u/3t3IV9mSD2WCbzKP79lv0T+mNGMXeg
         1JAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728626223; x=1729231023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPo5xhewKlshq8RUYllOw1URvyS0utF68/5Etae/hmo=;
        b=lLprxnAqv/Bh1r2APpkQQbeUuuv/bwkLK4EGfvEfcrU95VJ/XZ/0h4zmyTii4w/M3n
         qcohdPYgcgdr7VS1TawSCE+BjwhCqDovPuQoPZUdZcRygUEgVgAmlXlybGBDjJfqGFNJ
         Y0FMuOR+hcRpXCG8kpl+TuJVe4vbkQJ9vLpDTS6e2m4hQtqNRrDuZC7wcC70FAdD+aWX
         vFtVHqxqVf+f3UL2LRbl0JM6jk8cDz8aftqHnLlB9QAHeUCQaksp1fGjR/4U/Ska/b8O
         rtbYtnF2Ym84dS5YzJqGnSqzOLmLpzBuKKOFuHa/E/JPqEePFAPd2bRJEEMyq90VY1sJ
         GqXw==
X-Forwarded-Encrypted: i=1; AJvYcCWk/vSGjC8E804Do/Z9mIBhoooyH7jP7MAWTzyrkVwFx2XzqvJxJW+RyOgkaOfB21z297+aItTd7f2rzVY=@vger.kernel.org, AJvYcCWqbefxjRM2gWkPVU8nl8GV+kGV8R5driLwgqN/XlmJ8/ufvQRUO7EDV9hiAYthy4e0hW7z4urp3O/LfPRWhmruvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEhY76WrQXltd9VQYqyF0UUklnKZCxatPo5YwfIZnSLm0Wd+MQ
	g/AaGKCXthkBwGU7vafXmM+T/DGP1FIMaj7BuxP+EzWWsnLj5uqJ
X-Google-Smtp-Source: AGHT+IHuMwPgi2GTVetwUBex5heWqpQzZXPqiR+4kCoBTBCQndirFoUbMwJTC8f2Fg7CHfl7efkfLg==
X-Received: by 2002:a17:903:2282:b0:20c:92ce:359d with SMTP id d9443c01a7336-20ca169aeb6mr22849565ad.45.1728626223379;
        Thu, 10 Oct 2024 22:57:03 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1c566sm17851085ad.114.2024.10.10.22.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 22:57:03 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	matt@readmodwrite.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH] perf test: Delete unused Intel CQM test
Date: Thu, 10 Oct 2024 22:57:00 -0700
Message-ID: <20241011055700.4142694-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Ian Rogers <irogers@google.com> pointed out, intel-cqm.c is neither
used nor built. It was deleted in the following commit:

commit b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier to files with no license")

However, it resurfaced soon after in the following commit:

commit 5c9295bfe6f5 ("perf tests: Remove Intel CQM perf test")

It should be deleted once and for all.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/arch/x86/tests/intel-cqm.c | 128 --------------------------
 1 file changed, 128 deletions(-)
 delete mode 100644 tools/perf/arch/x86/tests/intel-cqm.c

diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/tests/intel-cqm.c
deleted file mode 100644
index 360a082fc928..000000000000
--- a/tools/perf/arch/x86/tests/intel-cqm.c
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "tests/tests.h"
-#include "cloexec.h"
-#include "debug.h"
-#include "evlist.h"
-#include "evsel.h"
-#include "arch-tests.h"
-#include <internal/lib.h> // page_size
-
-#include <signal.h>
-#include <sys/mman.h>
-#include <sys/wait.h>
-#include <errno.h>
-#include <string.h>
-
-static pid_t spawn(void)
-{
-	pid_t pid;
-
-	pid = fork();
-	if (pid)
-		return pid;
-
-	while(1)
-		sleep(5);
-	return 0;
-}
-
-/*
- * Create an event group that contains both a sampled hardware
- * (cpu-cycles) and software (intel_cqm/llc_occupancy/) event. We then
- * wait for the hardware perf counter to overflow and generate a PMI,
- * which triggers an event read for both of the events in the group.
- *
- * Since reading Intel CQM event counters requires sending SMP IPIs, the
- * CQM pmu needs to handle the above situation gracefully, and return
- * the last read counter value to avoid triggering a WARN_ON_ONCE() in
- * smp_call_function_many() caused by sending IPIs from NMI context.
- */
-int test__intel_cqm_count_nmi_context(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
-{
-	struct evlist *evlist = NULL;
-	struct evsel *evsel = NULL;
-	struct perf_event_attr pe;
-	int i, fd[2], flag, ret;
-	size_t mmap_len;
-	void *event;
-	pid_t pid;
-	int err = TEST_FAIL;
-
-	flag = perf_event_open_cloexec_flag();
-
-	evlist = evlist__new();
-	if (!evlist) {
-		pr_debug("evlist__new failed\n");
-		return TEST_FAIL;
-	}
-
-	ret = parse_event(evlist, "intel_cqm/llc_occupancy/");
-	if (ret) {
-		pr_debug("parse_events failed, is \"intel_cqm/llc_occupancy/\" available?\n");
-		err = TEST_SKIP;
-		goto out;
-	}
-
-	evsel = evlist__first(evlist);
-	if (!evsel) {
-		pr_debug("evlist__first failed\n");
-		goto out;
-	}
-
-	memset(&pe, 0, sizeof(pe));
-	pe.size = sizeof(pe);
-
-	pe.type = PERF_TYPE_HARDWARE;
-	pe.config = PERF_COUNT_HW_CPU_CYCLES;
-	pe.read_format = PERF_FORMAT_GROUP;
-
-	pe.sample_period = 128;
-	pe.sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_READ;
-
-	pid = spawn();
-
-	fd[0] = sys_perf_event_open(&pe, pid, -1, -1, flag);
-	if (fd[0] < 0) {
-		pr_debug("failed to open event\n");
-		goto out;
-	}
-
-	memset(&pe, 0, sizeof(pe));
-	pe.size = sizeof(pe);
-
-	pe.type = evsel->attr.type;
-	pe.config = evsel->attr.config;
-
-	fd[1] = sys_perf_event_open(&pe, pid, -1, fd[0], flag);
-	if (fd[1] < 0) {
-		pr_debug("failed to open event\n");
-		goto out;
-	}
-
-	/*
-	 * Pick a power-of-two number of pages + 1 for the meta-data
-	 * page (struct perf_event_mmap_page). See tools/perf/design.txt.
-	 */
-	mmap_len = page_size * 65;
-
-	event = mmap(NULL, mmap_len, PROT_READ, MAP_SHARED, fd[0], 0);
-	if (event == (void *)(-1)) {
-		pr_debug("failed to mmap %d\n", errno);
-		goto out;
-	}
-
-	sleep(1);
-
-	err = TEST_OK;
-
-	munmap(event, mmap_len);
-
-	for (i = 0; i < 2; i++)
-		close(fd[i]);
-
-	kill(pid, SIGKILL);
-	wait(NULL);
-out:
-	evlist__delete(evlist);
-	return err;
-}
-- 
2.43.0

