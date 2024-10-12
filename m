Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440EE3EA83;
	Sat, 12 Oct 2024 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728747883; cv=none; b=C0eNr6SRDLWLDT+MOIaERfF6yaV9AZ5VcX8UQIDRwWrf3Ud8vOjmICyfAiTcx9uCVrZtJiyLKgaenMKDP5p42WbIsREijqpjH8Az5l2kzVVN+rIh5md8GOI5w4URgXJSOeXxzCRI7M0hY3STimBg0rwYvT1DJT7AmG8I8JhOTsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728747883; c=relaxed/simple;
	bh=mOPPJQdHmP4kUdz8+1BXg5f6hCzDQ0wUTMcLWt7uazA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hVMb6syAtZHo97eRYU0TY2diTrwTu12V+raxOIvsHj3bLXIdqETjI7ndBvajY9aKLgxfKd8EtDbtBDjOOMZn1m6kuA8zvIpD0QDo/UjipD4lOeb8jqMhHkewD3KhyWpsJwA0nuOIUYoii1lTrHiBBRzyItAKvENz6rX8cG+e6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 435CCDA7;
	Sat, 12 Oct 2024 08:45:11 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2780D3F58B;
	Sat, 12 Oct 2024 08:44:40 -0700 (PDT)
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
Subject: [PATCH v2 2/3] perf probe: Check group string length
Date: Sat, 12 Oct 2024 16:44:27 +0100
Message-Id: <20241012154428.888373-3-leo.yan@arm.com>
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

In the kernel, the probe group string length is limited up to
MAX_EVENT_NAME_LEN (including the NULL terminator).

Check for this limitation and report an error if it is exceeded.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/probe-event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 061a0412dec2..224ec6818803 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2868,6 +2868,12 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 	else
 		group = PERFPROBE_GROUP;
 
+	if (strlen(group) >= MAX_EVENT_NAME_LEN) {
+		pr_err("Probe group string='%s' is too long (>= %d bytes)\n",
+			group, MAX_EVENT_NAME_LEN);
+		return -ENOMEM;
+	}
+
 	/* Get an unused new event name */
 	ret = get_new_event_name(buf, sizeof(buf), event, namelist,
 				 tev->point.retprobe, allow_suffix);
-- 
2.25.1

