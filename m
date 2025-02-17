Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ABA22B5A3;
	Mon, 17 Feb 2025 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822363; cv=none; b=HCXqDWzmMhJQdAFd84BDcsIPkkIxe8XTuTCeFWFr7PPf2C/PufFPG4QTvaI5lvRkPJcXzsEpdt0Mb6PyDhKcJop0fIU3wYyyKwBLaaP8SfD4Iv/SPiIS42UzUANR3H+MeGZNil6uMwz3tbeZCj+o+lQtHGTjYTxYO7OqtoKsZ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822363; c=relaxed/simple;
	bh=N3QnyXaL+LrGly7ui66XjpFf2/oiT1rSV8RLmeKWr5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kZAFVv9Pz9gZZ6RwDXGWrVZoHrMbo4Cx5UQX7eMwnni08VDYuWvMonENRErKl2SMA9kmaGNYilGQ2yJxaRXAk8BB3+xtFiCWYc+jp0GKmUgKK3CBfnpwr8CgXtdSW/+FZlV4k6f4jqzg0b4dRGR/51BwwQQFhAW5Vdgar9qRxpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07DE41692;
	Mon, 17 Feb 2025 11:59:40 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 828623F6A8;
	Mon, 17 Feb 2025 11:59:18 -0800 (PST)
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
Subject: [PATCH v3 01/12] perf script: Make printing flags reliable
Date: Mon, 17 Feb 2025 19:58:57 +0000
Message-Id: <20250217195908.176207-2-leo.yan@arm.com>
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

Add a check for the generated string of flags.  Print out the raw number
if the string generation fails.

In another case, if the string length is longer than the aligned size,
allow the completed string to be printed.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/builtin-script.c   | 10 ++++++++--
 tools/perf/util/trace-event.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d797cec4f054..2c4b1fb7dc72 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1709,9 +1709,15 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 {
 	char str[SAMPLE_FLAGS_BUF_SIZE];
+	int ret;
+
+	ret = perf_sample__sprintf_flags(flags, str, sizeof(str));
+	if (ret < 0)
+		return fprintf(fp, "  raw flags:0x%-*x ",
+			       SAMPLE_FLAGS_STR_ALIGNED_SIZE - 12, flags);
 
-	perf_sample__sprintf_flags(flags, str, sizeof(str));
-	return fprintf(fp, "  %-21s ", str);
+	ret = max(ret, SAMPLE_FLAGS_STR_ALIGNED_SIZE);
+	return fprintf(fp, "  %-*s ", ret, str);
 }
 
 struct printer_data {
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index ac9fde2f980c..71e680bc3d4b 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -145,6 +145,8 @@ int common_flags(struct scripting_context *context);
 int common_lock_depth(struct scripting_context *context);
 
 #define SAMPLE_FLAGS_BUF_SIZE 64
+#define SAMPLE_FLAGS_STR_ALIGNED_SIZE	21
+
 int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz);
 
 #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
-- 
2.34.1

