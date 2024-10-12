Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217B88F64;
	Sat, 12 Oct 2024 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728766058; cv=none; b=mgDxbubhtpb7DzxpOO+4RlYoWt3vKIoduHjVEGBtlx4LgVcrpC7mysbKhROhZu6fPy9K6NQ6cqfMOGvvAijHpXhtIkQVlY2ApNZUMC91CJlYWozDAG0W25TONmu+ubPBfsf9lRF4j0R/vK+owzZgj03HPEQz3mF6s3+A+7tjrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728766058; c=relaxed/simple;
	bh=jtMttfkYRg3tbpaJDZGsePrF37CI4jeRKhJvIHU4W0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQ6TeuaKfs0evdLGmraeCSJT5aUBE9jNVOHI4k6RnxH7jKuQtH3N0v+db9xbbJ5Cs0yPHd6gE9DDgY98au4cSptnMmojAIZ34VOtAoK8wOXm64mXEjJnVXv0d0MplHbftDn44hyBK6VDgGHAhnolZ6oD2igquwa2Hpf6uTho8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13E0A1063;
	Sat, 12 Oct 2024 13:48:05 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC3173F5A1;
	Sat, 12 Oct 2024 13:47:33 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 1/3] perf probe: Use the MAX_EVENT_NAME_LEN macro
Date: Sat, 12 Oct 2024 21:47:23 +0100
Message-Id: <20241012204725.928794-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241012204725.928794-1-leo.yan@arm.com>
References: <20241012204725.928794-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX_EVENT_NAME_LEN macro has been defined in the kernel. Use the
same definition in the tool for more readable.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/probe-event.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a17c9b8a7a79..061a0412dec2 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -51,6 +51,9 @@
 
 #define PERFPROBE_GROUP "probe"
 
+/* Defined in kernel/trace/trace.h */
+#define MAX_EVENT_NAME_LEN	64
+
 bool probe_event_dry_run;	/* Dry run flag */
 struct probe_conf probe_conf = { .magic_num = DEFAULT_PROBE_MAGIC_NUM };
 
@@ -2841,7 +2844,7 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 				       bool allow_suffix)
 {
 	const char *event, *group;
-	char buf[64];
+	char buf[MAX_EVENT_NAME_LEN];
 	int ret;
 
 	/* If probe_event or trace_event already have the name, reuse it */
-- 
2.25.1

