Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5589F22DF9D;
	Wed,  5 Feb 2025 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757785; cv=none; b=T6Ve6Vmm/ydytYJGOYTBxnbmlooNBDcb6wkPQVfE6Ar7JDegrGZOyyZDlGDFqydOIxu447E3bBR8wxjEjVpTnzENz4XBXiQwAwfMZKQdfOqXmDE0X/ZLhAu4SQcgWMfAZJlySRIhGMQH2r6HyagnXzoBw1grxn4RsqPq+NybsLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757785; c=relaxed/simple;
	bh=vgKhNi+L9i3Sr0y8suoI0PsYPUjUY9hgP3pcrNYWTqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHAE7Sf94O0l8NRqILbw60OuojFCj/xmuh+DvZ6AxERGryw1YPoOKUcuuUfGDSgaT1/sBIB7OUboEiBMwIZl/DzCvhE3GyiD/yROvRIAdWPt1Tl2W7Sgyl1UaJJmu0DTGpneLUukp3+xy6eFz9HKGI+DTtG+gNsIxPeSGsTg0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 580131515;
	Wed,  5 Feb 2025 04:16:47 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 500A73F63F;
	Wed,  5 Feb 2025 04:16:21 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Graham Woodward <graham.woodward@arm.com>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 05/11] perf script: Add not taken event for branch stack
Date: Wed,  5 Feb 2025 12:15:49 +0000
Message-Id: <20250205121555.180606-6-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205121555.180606-1-leo.yan@arm.com>
References: <20250205121555.180606-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The branch stack has an existed field for printing mispredict, extend
the field for printing events and add support not-taken event.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/builtin-script.c | 20 +++++++++++++-------
 tools/perf/util/branch.h    |  3 ++-
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e7f79a3f1fd2..5e1c9a803d66 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -929,19 +929,25 @@ static int perf_sample__fprintf_start(struct perf_script *script,
 	return printed;
 }
 
-static inline char
-mispred_str(struct branch_entry *br)
+static inline size_t
+bstack_event_str(struct branch_entry *br, char *buf, size_t sz)
 {
-	if (!(br->flags.mispred  || br->flags.predicted))
-		return '-';
+	if (!(br->flags.mispred || br->flags.predicted || br->flags.not_taken))
+		return snprintf(buf, sz, "-");
 
-	return br->flags.predicted ? 'P' : 'M';
+	return snprintf(buf, sz, "%s%s",
+			br->flags.predicted ? "P" : "M",
+			br->flags.not_taken ? "N" : "");
 }
 
 static int print_bstack_flags(FILE *fp, struct branch_entry *br)
 {
-	return fprintf(fp, "/%c/%c/%c/%d/%s/%s ",
-		       mispred_str(br),
+	char events[16] = { 0 };
+	size_t pos;
+
+	pos = bstack_event_str(br, events, sizeof(events));
+	return fprintf(fp, "/%s/%c/%c/%d/%s/%s ",
+		       pos < 0 ? "-" : events,
 		       br->flags.in_tx ? 'X' : '-',
 		       br->flags.abort ? 'A' : '-',
 		       br->flags.cycles,
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index b80c12c74bbb..99338f26f5e5 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -18,6 +18,7 @@ struct branch_flags {
 		struct {
 			u64 mispred:1;
 			u64 predicted:1;
+			u64 not_taken:1;
 			u64 in_tx:1;
 			u64 abort:1;
 			u64 cycles:16;
@@ -25,7 +26,7 @@ struct branch_flags {
 			u64 spec:2;
 			u64 new_type:4;
 			u64 priv:3;
-			u64 reserved:31;
+			u64 reserved:30;
 		};
 	};
 };
-- 
2.34.1

