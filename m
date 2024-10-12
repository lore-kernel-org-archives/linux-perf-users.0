Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D059B19BA6;
	Sat, 12 Oct 2024 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728747882; cv=none; b=C0g3cDNag97PRggGy0Izs+t0EhUCIZDea6IY7hgIAGomcOrOePKbigyOUE0G2ikqt54OzNQDVHKRdXX8PV47FcaJ709wMSRlE7GZPHIB5ADFB48nbtbk5E4LC6C9FQMuCAWWTJDp1EBQha8eI0rzjJ0d9zEZnH7Zr+qRuc8Fns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728747882; c=relaxed/simple;
	bh=jtMttfkYRg3tbpaJDZGsePrF37CI4jeRKhJvIHU4W0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StJxw2+VXx6qg+ZNBjFfWb+sz3Szoj9zvIofeDBWmcMGLrBkOi55qpvqo0VlQ9VV3O932WVPzrd55oqHXNprlv6/LTdsgpG2QGC8NPK5D3IMCBcgyf0HBz0n7gY+JxmjDcIHY/SztZSLKgTOVoTOw0cWnBxJBaAuyvO1y2Yqvf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A8011063;
	Sat, 12 Oct 2024 08:45:09 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 635BD3F58B;
	Sat, 12 Oct 2024 08:44:38 -0700 (PDT)
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
Subject: [PATCH v2 1/3] perf probe: Use the MAX_EVENT_NAME_LEN macro
Date: Sat, 12 Oct 2024 16:44:26 +0100
Message-Id: <20241012154428.888373-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241012154428.888373-1-leo.yan@arm.com>
References: <20241012154428.888373-1-leo.yan@arm.com>
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

