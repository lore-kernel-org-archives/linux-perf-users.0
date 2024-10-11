Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEF120B21A
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632187; cv=none; b=o+dgxs9jCHT7Y+ftV6GBCicnWTmI55me9xxekWkndGMeGfpSkK9agC/TlddFoYm6zAJO7YXjahT4s/YElAbUe+EgGIX87FcXpKJxaa4yGjIWkfbZoSx2Ajg3RZriMJEb9pVs/elw982SxcTN7imGaZZg2LGHwfCdtOWn9V7OtNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632187; c=relaxed/simple;
	bh=qRJ7uobiuXa4lx58ydid8NsiY9eSUc6Dd5fam5Iq7JM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k8LQ3/7O/6aQ4t/oZHqW2nb+Gmy9jpkaMNEZ73ZkNIMA1PyH3Bw5QNUwOkE51skdSgZxjznoAV91wQ1LAdVfhcKYK3X3fakJgNc2/HkjDRqwPHr1GLsyPcjwKgoPC/rzg65upr8EJ0NwDuUu0BIvNfiQ1dglv8y+3KWbdJ8w6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/1WHHhc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/1WHHhc"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e290b8b69f8so3060704276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728632185; x=1729236985; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sGy2stET4dPYcbIauhcjx1YKA3rAeDl4bGF/9JCbzDA=;
        b=x/1WHHhcX5uhIxoTpgJ6UZwPYJRUF+JSEIHaOdJWNzLDZJe6aHEZe/3u+iSYX8MOlB
         Nrk+Bfyq+S/t+w5ZOTXMXYCpMbHvoUN3BoqSGR4KR3wcO6KLTSt86R+Rc/nzuSnFJG78
         ARnI42Sxg/65Q77Vb0iQOzCbiYXAzJ7odOkuvDh0sJa9boNgE3YU6rRWaIplJAHO8niU
         nQ7W2z67TzFq5jNUm8Ntgdk+WAmCeEyauyjtia2NXK4bhEsYV4xPU9yADNrGtj/uuxSu
         t7swkd2owG05q61MaFjqCy8YL2niNI8XDJOfnCUZ3lriD7U0jMXKQq90yo6nMFjwKEn4
         ++3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632185; x=1729236985;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGy2stET4dPYcbIauhcjx1YKA3rAeDl4bGF/9JCbzDA=;
        b=ea8Y37mNfFWiLlGIVp5rZy720JUV8+u7lFkRxG+h/QV/N/Wgd5EceXspoBcOFKdm2K
         UI1v9ea+cqNsVrtgOeMDnNRlSJC6CLZ/6np72REPalFGTDGdJXahEIObevRUX8wghukc
         XRCLBNnHrOIsE1R8qy2ZQk1tsig79b56jFESURk/Iu0WduXKr8qWOZFKSLjZGobYtCyu
         qO3WcpbINsNC8n2bITZi+uwzW4rY+7IDhTrPDkxCulLa/kPFpzEjsaGbi4J2Yzhfb+yH
         v4d18KmTyuNlXhEwtKqsuidtVndyqpzblPlLc60yz6vlU0NNTtWPQsiCWJblp2QvM+T5
         x8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUwH33fsiTfcPh9T+Tj9us8GcB+nEs8HjJ2mlhg9abMe9TTldEQMrHWP98eGijDl3beKEpIc6jcJNZUNTXvVKgt@vger.kernel.org
X-Gm-Message-State: AOJu0YwDB1RXU4ITZ+Oi6h24mve75BknlvxO/IIlfiSH4PKpLbsmH5Vg
	uPGZRRZJLkx7PJ5kWIZ7ZPGBR99o3qw+x2sNUAb1+DXw2AEyDvtVyjSX0uGfKizlZGHHV9ztwv1
	v9KptcQ==
X-Google-Smtp-Source: AGHT+IFCnDFL9xKF8OEn5GZiOdl2eowmU59Qvp9zHwHa5EKbZlB7BPAnM/Hp0z+j/P9xYahKR4m00uHjtQKt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a25:c593:0:b0:e28:ede2:d060 with SMTP id
 3f1490d57ef6-e2919dd2c51mr1323276.4.1728632185018; Fri, 11 Oct 2024 00:36:25
 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:35:56 -0700
In-Reply-To: <20241011073559.431302-1-irogers@google.com>
Message-Id: <20241011073559.431302-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011073559.431302-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1 5/8] perf test: Tag parallel failing shell tests with "(exclusive)"
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

Some shell tests compete for resources and so can't run with other
tests, tag such tests.  The "(exclusive)" stems from shared/exclusive
to describe how the tests run as if holding a lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/perftool-testsuite_report.sh | 2 +-
 tools/perf/tests/shell/record.sh                    | 2 +-
 tools/perf/tests/shell/record_lbr.sh                | 2 +-
 tools/perf/tests/shell/record_offcpu.sh             | 2 +-
 tools/perf/tests/shell/stat_all_pmu.sh              | 2 +-
 tools/perf/tests/shell/test_intel_pt.sh             | 2 +-
 tools/perf/tests/shell/test_stat_intel_tpebs.sh     | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/perftool-testsuite_report.sh b/tools/perf/tests/shell/perftool-testsuite_report.sh
index 973012ce92a7..a8cf75b4e77e 100755
--- a/tools/perf/tests/shell/perftool-testsuite_report.sh
+++ b/tools/perf/tests/shell/perftool-testsuite_report.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perftool-testsuite_report
+# perftool-testsuite_report (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 test -d "$(dirname "$0")/base_report" || exit 2
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 8d6366d96883..f7d8c5b243a4 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf record tests
+# perf record tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
index 32314641217e..8d750ee631f8 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf record LBR tests
+# perf record LBR tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 67c925f3a15a..678947fe69ee 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# perf record offcpu profiling tests
+# perf record offcpu profiling tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
index 42456d89c5da..8b148b300be1 100755
--- a/tools/perf/tests/shell/stat_all_pmu.sh
+++ b/tools/perf/tests/shell/stat_all_pmu.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf all PMU test
+# perf all PMU test (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 723ec501f99a..660991d17607 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Miscellaneous Intel PT testing
+# Miscellaneous Intel PT testing (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
index 9a11f42d153c..f95fc64bf0a7 100755
--- a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# test Intel TPEBS counting mode
+# test Intel TPEBS counting mode (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-- 
2.47.0.rc1.288.g06298d1525-goog

