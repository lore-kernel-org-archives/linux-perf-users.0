Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F471FECDB;
	Tue,  4 Mar 2025 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086776; cv=none; b=of4miqob3YtkT4as6Nr353WVFTKYptEnpY5iDSlTkmZZrodyCW0+joLHlSmFrog6adBU/PJE61L1bwtdaK2d3DF7U5ruWfEI3ISQiRY9xuvzQiCoz/jWEevv5hE7FgRoHvpAhSs3bqdsoRjxrALz4A9ZH4Cr9l2oXBY/pA09msk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086776; c=relaxed/simple;
	bh=RvZPorCIYzIHsMqucWYc054nd9W6qhNt19NjIEgOJwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n+bd01HqCh2hCtwcpzru2RbgEQj9ajwZC/9hMgz5Yw/KXfX0ue5HACPLYJxfK3gwjle63J4mc4RTsXXXlbkbwpSmd7vjroKk7Ow/MViciIUApSzmaPk+EllmFpMzO6SciG4pbXksXUwn8LJouUaHAJ9RU6crQXHSLgA4USR3ymE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E12341007;
	Tue,  4 Mar 2025 03:13:05 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E52A83F5A1;
	Tue,  4 Mar 2025 03:12:49 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Graham Woodward <graham.woodward@arm.com>,
	Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 01/12] perf script: Make printing flags reliable
Date: Tue,  4 Mar 2025 11:12:29 +0000
Message-Id: <20250304111240.3378214-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304111240.3378214-1-leo.yan@arm.com>
References: <20250304111240.3378214-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check for the generated string of flags.  Print out the raw number
if the string generation fails.

Use the SAMPLE_FLAGS_STR_ALIGNED_SIZE macro to replace the value '21'.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/builtin-script.c   | 9 +++++++--
 tools/perf/util/trace-event.h | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d797cec4f054..8ca04293d335 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1709,9 +1709,14 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
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
+	return fprintf(fp, "  %-*s ", SAMPLE_FLAGS_STR_ALIGNED_SIZE, str);
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

