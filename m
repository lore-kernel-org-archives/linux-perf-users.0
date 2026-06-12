Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633A3D3CE9;
	Fri, 12 Jun 2026 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303111; cv=none; b=tqDaX5kO0rlkstBEkMSyuP81CHSVFDukRtPMq5WfFJ92mC86nfbe9iHyg4Jhziiq4TTbUgB07DBis8ASPF4yRY/G6yHbfeGXIfH9vRQwnRVqLqiNQd029QlHBv+HN2seef0CtTt/noMxlYG/NwBNDEp0pPAJtQR2iwVoYjLRmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303111; c=relaxed/simple;
	bh=GXlCAYc/wiYVnIcVPlIX5bDt1XP0wizicv3+T7JYVO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byaSaQ4yhav9inA0Te6X5F7v9hjW/STdDpMDPMd68Tm/30Ye4AE3FCNe14WDmLd7uWRbPbfpK0im//frhRTSDoPN1f1HxPjGjvzwLHdAvcZwTT4lVcg2miVAGRxuY1ndWm8TgfEUS1D7dDK94iAG51vRNefGprweufKaLPIA7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiF5R9s0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiF5R9s0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D30D1F00A3A;
	Fri, 12 Jun 2026 22:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303110;
	bh=hZKS4YqbQfqB0BFnDGSkIr0t9y7HmMKGZUr7+M+vtWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eiF5R9s0SiZumuWygndBwRXXCZCZdp5FlhgYUPqicKARXzTtPg2CwMyXDKRy/JGuu
	 9F5uBq62Vm3xOkZKup8aJ1qksVHY1HT5w+xhPXBkp53O2g+FqoCIuKyO6USSxS/E2t
	 7EDb/somtcQ5byt/nyWQNUQxwAhQ6A1MDhxYGzeLGkG4lXKb+n0mMAytcIHQFQp+Jl
	 PC9UiW2opUIgnHUmTTSPdLXr4oRO7P36obs3ErFUpxGqI/+g4BeG2wR8pk0xVy3qYG
	 ETb1JAZGD0zc5BczlwLzROGzl1SLVyZrt7tHx59wXF1rFYdXKgZojsVJ+azumMRlRC
	 2oQmCkdLEierw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	James Clark <james.clark@arm.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 13/13] perf cs-etm: Reject CPU IDs that would overflow signed comparison
Date: Fri, 12 Jun 2026 19:24:12 -0300
Message-ID: <20260612222413.40791-14-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612222413.40791-1-acme@kernel.org>
References: <20260612222413.40791-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

metadata[j][CS_ETM_CPU] is a u64 from perf.data, but the comparison
with max_cpu casts it to (int).  A crafted value like 0xFFFFFFFF becomes
-1 after the cast, which compares less than max_cpu (0), so the queue
array is never sized to accommodate it.  When the value is later passed
to cs_etm__get_queue(), it indexes queue_array with the original large
value, causing an out-of-bounds access.

Validate that CS_ETM_CPU fits in an int before using it in the signed
comparison.

Fixes: 57880a7966be510c ("perf: cs-etm: Allocate queues for all CPUs")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/finding/2
Cc: James Clark <james.clark@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5e92359f51a7cb87..0927b0b9c06b1504 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -6,6 +6,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <limits.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/coresight-pmu.h>
@@ -3468,7 +3469,13 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 			goto err_free_metadata;
 		}
 
-		if ((int) metadata[j][CS_ETM_CPU] > max_cpu)
+		/* CPU id comes from perf.data and must fit max_cpu + 1 without overflow */
+		if (metadata[j][CS_ETM_CPU] >= INT_MAX) {
+			err = -EINVAL;
+			goto err_free_metadata;
+		}
+
+		if ((int)metadata[j][CS_ETM_CPU] > max_cpu)
 			max_cpu = metadata[j][CS_ETM_CPU];
 	}
 
-- 
2.54.0

