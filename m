Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC5616F8E7;
	Tue,  6 Aug 2024 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977317; cv=none; b=KWAUh24zi4JjquBTo5yH+iHMnBASbWhWPj3OUyQIELnHtUbBaC8rilzAnn4WeiaLym9g03R2Yto+rncfzPJpvByYECydbQVo/D7vb5K1BvRhNqEj3WVFrVCabIP/FCWPdLmH5c6H4Ylwq/evwXv89SucK94EAlTRFsCLZSxW0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977317; c=relaxed/simple;
	bh=EQf2w9wx3PjX9vk+49xC7NKMuw4h4aBBkgbhio2X4C4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j8Nsq4RFL8RdZf8umi3OHh5OVr9o8587I2odg0DGjazrHTN0jWM5rPQfQMxfWj5allqKXkPWGthaglJxPGbX9LEOj1VHXVtkGpbXA2ptIgi5yERU0AKS38/qqQ7XS506r0OqBuBcW0ODiwbf6lBN77k5fJngewHvX2XPX/gfpz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1617FEC;
	Tue,  6 Aug 2024 13:49:01 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 268803F766;
	Tue,  6 Aug 2024 13:48:34 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 4/5] perf auxtrace: Bails out after finding the event for the map index
Date: Tue,  6 Aug 2024 21:48:12 +0100
Message-Id: <20240806204813.722372-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806204813.722372-1-leo.yan@arm.com>
References: <20240806204813.722372-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After finding the corresponding event for the passed buffer index, it is
safe to say the found event has been used. Then, the tool can check the
event status and bails out if it has been disabled.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/auxtrace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 174d486056e0..7c998f95d2ff 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -688,15 +688,15 @@ int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
 		int cpu_map_idx;
 
 		if (evsel__is_aux_event(evsel)) {
-			if (evsel->disabled)
-				return 0;
-
 			cpu_map_idx = evlist__find_cpu_map_idx(itr->evlist,
 							       evsel, idx);
 			/* No map is found in per CPU mmap */
 			if (cpu_map_idx == -ENOENT)
 				return cpu_map_idx;
 
+			if (evsel->disabled)
+				return 0;
+
 			if (cpu_map_idx >= 0)
 				return evlist__enable_event_idx(evsel, 1, cpu_map_idx);
 			else
-- 
2.34.1

