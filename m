Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B41472068;
	Wed, 30 Sep 2026 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758908; cv=none; b=Ok8xw+ZSNenAX3x4Oukhm6kDn0ZJ4IN6WfZnrWcHXAvBwPGDZnJhct+phO70+ecbRC5+V9tthmW6B97cc+HQ8bymbnssBqOfX5erC8/yqV3vZrnl5IaS3Y6MJqbuBmhcdSw5zdCXJ+kXPIJ4OQzoPqT6xpne6zMpSt44nKJB9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758908; c=relaxed/simple;
	bh=iZGcNeKnKXgv7OLBl5q/CEiuEGUHm7/yAueS+sBHUts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKL1G2OuMvCQ0RCohsbFAZzbFqi8GaX8VLS4y+I2r5iPOZ2e/cxtLdBOpt+p+A6qkLV9VHwTOTVOOA3T4BvgaLuVlywV+YAR42slJHg36/DdGZbDmOD+zGDGqqYai3AMKyCMYjVscT+G71jB/lI3lquYb2nb2BeqgupK/7WQryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fbVgtHYv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fbVgtHYv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ADD81477;
	Wed, 30 Sep 2026 02:01:43 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0805E3F85F;
	Wed, 30 Sep 2026 02:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790758906; bh=iZGcNeKnKXgv7OLBl5q/CEiuEGUHm7/yAueS+sBHUts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fbVgtHYvMCUbhXbwcL8QW0mvwKsbc+laiy6GxZVe7h3N+kLzxtAMGhER3EMmlNCLS
	 88mLraj5mPF3fj6RWaLqD0S3gW3d+9BxbxH24bGKGjR8/LhjmuBW3AnPyP6ZIMh4wy
	 BJxncxHSf2QEI/0acz3pTSJLTbpH3b5AWOX8MOZI=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 30 Sep 2026 10:01:12 +0100
Subject: [PATCH 1/3] perf build: Build the Python extension before pylint
 consumers
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-perf_fix_pylint_errors-v1-1-f72151d8b255@arm.com>
References: <20260930-perf_fix_pylint_errors-v1-0-f72151d8b255@arm.com>
In-Reply-To: <20260930-perf_fix_pylint_errors-v1-0-f72151d8b255@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790758902; l=1313;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=iZGcNeKnKXgv7OLBl5q/CEiuEGUHm7/yAueS+sBHUts=;
 b=81YHczmGTeF6BxCNc2WQFdpE8VCa6gBEItXJ6ZGo8Zj76dQoPN569zg5wmQmJtQYkDbmY/+H9
 QqsM77guaTkADfUhbuYI5MmF/+h2lxY9/gE0+Tz4NqqChvidM3JLgxq
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Pylint checks for tests and standalone Python scripts can run before the
perf Python extension is available. On a clean parallel build, an import
error can stop make before the extension is built.

When pylint is enabled, make the perf and perf-test sub-makes wait for the
enabled language bindings using an order-only dependency. The extension
does not depend on either consumer, so this does not introduce a cycle.

Fixes: 8a54784e708b ("perf build: Add pylint build tests")
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Makefile.perf | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 0102c3468a0b79fb22966d8cbd8fa8525d2ff3ae..d350d085542c64fc6d0bed4c5d7d1daac51efa8b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -578,6 +578,12 @@ strip: $(PROGRAMS) $(OUTPUT)perf
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) $(OUTPUT)perf
 
 PERF_IN := $(OUTPUT)perf-in.o
+
+ifdef PYLINT
+# Build the Python extension before starting sub-makes that lint its users.
+$(PERF_IN) $(LIBPERF_TEST_IN): | $(LANG_BINDINGS)
+endif
+
 export NO_JEVENTS
 
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj

-- 
2.34.1

