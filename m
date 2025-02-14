Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA04263F4E;
	Fri, 14 Feb 2025 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532003; cv=none; b=WP6g0eSM53g1Wokh9Qerwi9UY6s+VkY9ub8iV9kxoAqjGBF3joMyJ7HSdK3yMG2Lhtnsq8KYpIZdmZwmX71ooYVmJWaNhviKE5q+8WY84szPj/lEx8QTauWIoR5axEI4TY55GZQzTtn2DgGtPYOtCRshHpqZgwte18eDWT1FR5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532003; c=relaxed/simple;
	bh=3Y8+/4xsuAKE2REiHizJj6PIaDRyeUsSYo0bvk6GdHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FcCpPBjG/Qo4gF4tLOITBzLcls/ClmGw+HN6a+oVkX04MuJKjAMvvhJIgfaUqD0D0dpKoOgR2oFLQYsHR/qwNUrLeYprqOC9VqxOqEDE6QaN/m0i5F6N3yzRPUhfR6gYC+W7yPc+bjEEzipo4EZeYeASk5Wu6YCDuaoClLhP2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 616E5113E;
	Fri, 14 Feb 2025 03:20:21 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 453733F6A8;
	Fri, 14 Feb 2025 03:19:58 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Graham Woodward <graham.woodward@arm.com>,
	Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 05/11] perf script: Add not taken event for branch stack
Date: Fri, 14 Feb 2025 11:19:30 +0000
Message-Id: <20250214111936.15168-6-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214111936.15168-1-leo.yan@arm.com>
References: <20250214111936.15168-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The branch stack has an existed field for printing mispredict, extend
the field for printing events and add support not-taken event.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/builtin-script.c | 20 +++++++++++++-------
 tools/perf/util/branch.h    |  3 ++-
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 2c4b1fb7dc72..43bf327bb72b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -935,19 +935,25 @@ static int perf_sample__fprintf_start(struct perf_script *script,
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
index b80c12c74bbb..7429530fa774 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -25,7 +25,8 @@ struct branch_flags {
 			u64 spec:2;
 			u64 new_type:4;
 			u64 priv:3;
-			u64 reserved:31;
+			u64 not_taken:1;
+			u64 reserved:30;
 		};
 	};
 };
-- 
2.34.1

