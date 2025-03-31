Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BAB1F5F6;
	Mon, 31 Mar 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743442117; cv=none; b=EJ6KowIiLtY+gw9DbExWPL1wwcRxmUjGZwNjfx3lR6Ek8h7QGEqfuLQV/9bv7M3dEsvQ70plfWxV09KaaZOt4ShadI1WRoJ9scM360OyHHiLQxBgfKV2ktpVuFBJ15xqJJKgB4EFVxNDjUbQl5zgZjpf/zyCbYNAfG5UdSoZpDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743442117; c=relaxed/simple;
	bh=NsI1KtOwBbKNwb0DsinyTWOjTdcvIwsDOB7PZDjA8iI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uaS2tqA8b7FTXuzZywzY02BTI1UPasC4R3L45UdL1duWKnQ6DvqCGmWY3bNLxwlt0/NEv/m3HlaDy1lSjD+zReCbx4i8cLtAWYrjf0MRFicVBHS9EL8/bdbaxJJYAvGt2rakmF0kGgXFDSBjmsBquAqosX56F+YHtJCMKr3OFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B1F11692;
	Mon, 31 Mar 2025 10:28:38 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB5283F59E;
	Mon, 31 Mar 2025 10:28:32 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] perf tests switch-tracking: Fix timestamp comparison
Date: Mon, 31 Mar 2025 18:27:59 +0100
Message-Id: <20250331172759.115604-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test might fail on the Arm64 platform with the error:

  perf test -vvv "Track with sched_switch"
  Missing sched_switch events

The issue is caused by incorrect handling of timestamp comparisons. The
comparison result, a signed 64-bit value, was being directly cast to an
int, leading to incorrect sorting for sched events.

Fix this by explicitly returning 0, 1, or -1 based on whether the result
is zero, positive, or negative.

Fixes: d44bc5582972 ("perf tests: Add a test for tracking with sched_switch")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/switch-tracking.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 8df3f9d9ffd2..6b3aac283c37 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -264,7 +264,7 @@ static int compar(const void *a, const void *b)
 	const struct event_node *nodeb = b;
 	s64 cmp = nodea->event_time - nodeb->event_time;
 
-	return cmp;
+	return cmp < 0 ? -1 : (cmp > 0 ? 1 : 0);
 }
 
 static int process_events(struct evlist *evlist,
-- 
2.34.1

