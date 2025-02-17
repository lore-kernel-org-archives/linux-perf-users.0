Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FE8238D54;
	Mon, 17 Feb 2025 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822366; cv=none; b=dCOoiz9oaVN4eogolrjTac43CgACGdRKWNSRXELj8/51pczrQ/vEUGf+9rL9rznEMSkFpOv1id4XObDfk7U7z1kJKTZVDEVR8PU/ATmy20ZAGqqb+IMKateQUnaho35QpJtSiIRx/1Og6n2r4zDu6xFIM3TC/f/ic0btibbi5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822366; c=relaxed/simple;
	bh=41epd4k4+JPTJYE9uKepUTs7bNrxzdsJTg5Bi8O2aFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEIqvSBZxy4uhoYFVyk12q0UEPk85CAlBR8rYdAZ6O3mygX3QEC+PkjQooKDEuHIzAjAla4wbPADt9fkrcIu1iE/A/++A3AMSolMGB5vDai0rqu2J9W2LQ5rd7XDK5/Q82gRd18TlDkgNSViROcPKdfGFOSV7qLRO9Y4BM6ktNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA1F6152B;
	Mon, 17 Feb 2025 11:59:42 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31A183F6A8;
	Mon, 17 Feb 2025 11:59:21 -0800 (PST)
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
Subject: [PATCH v3 02/12] perf script: Refactor sample_flags_to_name() function
Date: Mon, 17 Feb 2025 19:58:58 +0000
Message-Id: <20250217195908.176207-3-leo.yan@arm.com>
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

When generating a string for sample flags, the sample_flags_to_name()
function lacks the ability to parse the trace start bit or trace end bit.
Therefore, the function is invoked multiple times after clearing its
unsupported bits.

This commit improves the sample_flags_to_name() function to parse sample
flags in one go for three kinds of information:
- The prefix info for trace start, trace end, etc.
- Branch types.
- Extra info for transaction and interrupt related info.

As a result, the code is simplified to call the sample_flags_to_name()
only once.  No expectation for any changes in the perf script output.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/event.h                 |  5 ++
 tools/perf/util/trace-event-scripting.c | 85 ++++++++++++++++---------
 2 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 2744c54f404e..cd75efc09834 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -71,6 +71,11 @@ enum {
 
 #define PERF_IP_FLAG_CHARS "bcrosyiABExghDt"
 
+#define PERF_ADDITIONAL_STATE_MASK	\
+	(PERF_IP_FLAG_IN_TX |		\
+	 PERF_IP_FLAG_INTR_DISABLE |	\
+	 PERF_IP_FLAG_INTR_TOGGLE)
+
 #define PERF_BRANCH_MASK		(\
 	PERF_IP_FLAG_BRANCH		|\
 	PERF_IP_FLAG_CALL		|\
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 4e81e02a4f18..712ba3a51bbe 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -313,49 +313,72 @@ static const struct {
 	{0, NULL}
 };
 
-static const char *sample_flags_to_name(u32 flags)
+static int sample_flags_to_name(u32 flags, char *str, size_t size)
 {
 	int i;
-
-	for (i = 0; sample_flags[i].name ; i++) {
-		if (sample_flags[i].flags == flags)
-			return sample_flags[i].name;
+	const char *prefix;
+	int pos = 0, ret;
+	u32 xf = flags & PERF_ADDITIONAL_STATE_MASK;
+	char xs[16] = { 0 };
+
+	/* Clear additional state bits */
+	flags &= ~PERF_ADDITIONAL_STATE_MASK;
+
+	if (flags & PERF_IP_FLAG_TRACE_BEGIN)
+		prefix = "tr strt ";
+	else if (flags & PERF_IP_FLAG_TRACE_END)
+		prefix = "tr end  ";
+	else
+		prefix = "";
+
+	ret = snprintf(str + pos, size - pos, "%s", prefix);
+	if (ret < 0)
+		return ret;
+	pos += ret;
+
+	flags &= ~(PERF_IP_FLAG_TRACE_BEGIN | PERF_IP_FLAG_TRACE_END);
+
+	for (i = 0; sample_flags[i].name; i++) {
+		if (sample_flags[i].flags != flags)
+			continue;
+
+		ret = snprintf(str + pos, size - pos, "%s", sample_flags[i].name);
+		if (ret < 0)
+			return ret;
+		pos += ret;
+		break;
 	}
 
-	return NULL;
+	if (!xf)
+		return pos;
+
+	snprintf(xs, sizeof(xs), "(%s%s%s)",
+		 flags & PERF_IP_FLAG_IN_TX ? "x" : "",
+		 flags & PERF_IP_FLAG_INTR_DISABLE ? "D" : "",
+		 flags & PERF_IP_FLAG_INTR_TOGGLE ? "t" : "");
+
+	/* Right align the string if its length is less than the limit */
+	if ((pos + strlen(xs)) < SAMPLE_FLAGS_STR_ALIGNED_SIZE)
+		ret = snprintf(str + pos, size - pos, "%*s",
+			       (int)(SAMPLE_FLAGS_STR_ALIGNED_SIZE - ret), xs);
+	else
+		ret = snprintf(str + pos, size - pos, " %s", xs);
+	if (ret < 0)
+		return ret;
+
+	return pos + ret;
 }
 
 int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz)
 {
-	u32 xf = PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_INTR_DISABLE |
-		 PERF_IP_FLAG_INTR_TOGGLE;
 	const char *chars = PERF_IP_FLAG_CHARS;
 	const size_t n = strlen(PERF_IP_FLAG_CHARS);
-	const char *name = NULL;
 	size_t i, pos = 0;
-	char xs[16] = {0};
-
-	if (flags & xf)
-		snprintf(xs, sizeof(xs), "(%s%s%s)",
-			 flags & PERF_IP_FLAG_IN_TX ? "x" : "",
-			 flags & PERF_IP_FLAG_INTR_DISABLE ? "D" : "",
-			 flags & PERF_IP_FLAG_INTR_TOGGLE ? "t" : "");
-
-	name = sample_flags_to_name(flags & ~xf);
-	if (name)
-		return snprintf(str, sz, "%-15s%6s", name, xs);
-
-	if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
-		name = sample_flags_to_name(flags & ~(xf | PERF_IP_FLAG_TRACE_BEGIN));
-		if (name)
-			return snprintf(str, sz, "tr strt %-7s%6s", name, xs);
-	}
+	int ret;
 
-	if (flags & PERF_IP_FLAG_TRACE_END) {
-		name = sample_flags_to_name(flags & ~(xf | PERF_IP_FLAG_TRACE_END));
-		if (name)
-			return snprintf(str, sz, "tr end  %-7s%6s", name, xs);
-	}
+	ret = sample_flags_to_name(flags, str, sz);
+	if (ret > 0)
+		return ret;
 
 	for (i = 0; i < n; i++, flags >>= 1) {
 		if ((flags & 1) && pos < sz)
-- 
2.34.1

