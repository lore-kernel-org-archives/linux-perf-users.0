Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B927239570;
	Mon, 17 Feb 2025 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822368; cv=none; b=kK/B2VA78/c+1gaqh8427XL11YxEJFXFKLp9+Wk1gky86pYk9bI62OsedN60zyI81u4ZaAqY5DSmy1n+6h2bjFqXOPRE0+aJvXslog/eSKxcfmg5yz3DBQbGPtMYYoS/wLiOrEQq9Lt4tFEm1nzgUpeOMHpeHSQ/MYUEn4fhTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822368; c=relaxed/simple;
	bh=/bzHaegk/WitL7gRtnefR4KYDpr12ID6MVZyPGJbb/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IK56dXuaFxQrn8UyHmh8pkHJ2ghApnomiomkE4DsT39kMFPsrjIZ2CgvHfLB6qwJiPKO9q55vxmhsn1jnMlH/OWzq0McL1mnsw9gq4n/Ca0PDYpr/f0g0XM3rmikIM5DInjQenkV4QSHgdkXtCb0mHPTW7jkNk+K6Fwv22pH4bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57CB5152B;
	Mon, 17 Feb 2025 11:59:45 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D40643F6A8;
	Mon, 17 Feb 2025 11:59:23 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Graham Woodward <graham.woodward@arm.com>,
	Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 03/12] perf script: Separate events from branch types
Date: Mon, 17 Feb 2025 19:58:59 +0000
Message-Id: <20250217195908.176207-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217195908.176207-1-leo.yan@arm.com>
References: <20250217195908.176207-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Branch types and events are two different things.  A branch type can be
a conditional branch, an indirect branch, a procedure call, a return, or
an exception taken, etc.  The extra event information is provided for
what happens during a branch, e.g. if a branch is mispredicted or not
taken (specific to conditional branches).

To deliver information about branches, this commit separates events from
branch types.  It parses branch types first, then appends event strings
embraced by the '/' character.  If multiple events occur, the events is
separated with a comma (,).

Also add a minor improvement by adding char 'm' in char array for branch
mispredict event.

Below are extracted sample flags.

Before:
        branch:   br miss
  instructions:   br miss

After:
        branch:   jmp/miss/
  instructions:   jmp/miss/

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/event.h                 |  5 +++-
 tools/perf/util/trace-event-scripting.c | 36 ++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index cd75efc09834..962fbc1714cf 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -69,7 +69,7 @@ enum {
 	PERF_IP_FLAG_BRANCH_MISS	= 1ULL << 15,
 };
 
-#define PERF_IP_FLAG_CHARS "bcrosyiABExghDt"
+#define PERF_IP_FLAG_CHARS "bcrosyiABExghDtm"
 
 #define PERF_ADDITIONAL_STATE_MASK	\
 	(PERF_IP_FLAG_IN_TX |		\
@@ -90,6 +90,9 @@ enum {
 	PERF_IP_FLAG_VMENTRY		|\
 	PERF_IP_FLAG_VMEXIT)
 
+#define PERF_IP_FLAG_BRACH_EVENT_MASK	\
+	PERF_IP_FLAG_BRANCH_MISS
+
 #define PERF_MEM_DATA_SRC_NONE \
 	(PERF_MEM_S(OP, NA) |\
 	 PERF_MEM_S(LVL, NA) |\
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 712ba3a51bbe..55d7e4e612d5 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -309,7 +309,14 @@ static const struct {
 	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_END, "tr end"},
 	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMENTRY, "vmentry"},
 	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMEXIT, "vmexit"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_BRANCH_MISS, "br miss"},
+	{0, NULL}
+};
+
+static const struct {
+	u32 flags;
+	const char *name;
+} branch_events[] = {
+	{PERF_IP_FLAG_BRANCH_MISS, "miss"},
 	{0, NULL}
 };
 
@@ -317,8 +324,9 @@ static int sample_flags_to_name(u32 flags, char *str, size_t size)
 {
 	int i;
 	const char *prefix;
-	int pos = 0, ret;
+	int pos = 0, ret, ev_idx = 0;
 	u32 xf = flags & PERF_ADDITIONAL_STATE_MASK;
+	u32 types, events;
 	char xs[16] = { 0 };
 
 	/* Clear additional state bits */
@@ -338,8 +346,9 @@ static int sample_flags_to_name(u32 flags, char *str, size_t size)
 
 	flags &= ~(PERF_IP_FLAG_TRACE_BEGIN | PERF_IP_FLAG_TRACE_END);
 
+	types = flags & ~PERF_IP_FLAG_BRACH_EVENT_MASK;
 	for (i = 0; sample_flags[i].name; i++) {
-		if (sample_flags[i].flags != flags)
+		if (sample_flags[i].flags != types)
 			continue;
 
 		ret = snprintf(str + pos, size - pos, "%s", sample_flags[i].name);
@@ -349,6 +358,27 @@ static int sample_flags_to_name(u32 flags, char *str, size_t size)
 		break;
 	}
 
+	events = flags & PERF_IP_FLAG_BRACH_EVENT_MASK;
+	for (i = 0; branch_events[i].name; i++) {
+		if (!(branch_events[i].flags & events))
+			continue;
+
+		ret = snprintf(str + pos, size - pos, !ev_idx ? "/%s" : ",%s",
+			       branch_events[i].name);
+		if (ret < 0)
+			return ret;
+		pos += ret;
+		ev_idx++;
+	}
+
+	/* Add an end character '/' for events */
+	if (ev_idx) {
+		ret = snprintf(str + pos, size - pos, "/");
+		if (ret < 0)
+			return ret;
+		pos += ret;
+	}
+
 	if (!xf)
 		return pos;
 
-- 
2.34.1

