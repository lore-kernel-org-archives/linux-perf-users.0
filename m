Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719314601C;
	Sat, 12 Oct 2024 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728766059; cv=none; b=G2xckJr0qwH79ljRItFRVbehQHJYKiT7yFS5aLnGmk2is8X/qEsGPa0bPr6glTuJ8KdDPvuGbi1zRAAn2BpwlS2SbAgALwHzxhhpR/PQer3KymfHAt3vJgkK7DsJxBa+g8iOxuO5pxlrxh8miNR1L161QC5Pzug76ZQDy/LCUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728766059; c=relaxed/simple;
	bh=mOPPJQdHmP4kUdz8+1BXg5f6hCzDQ0wUTMcLWt7uazA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aiFSfokcPmPjO8jsFJWF7dU9E+jcBFOA7+boqCDWRXcIgH/dRHTptaECOg9TGX0oYZWnmNxv+UrPm7aTypF7y21cmpRP9LhNqQCjl8ztpa2HgFoDP2cmBtaptyu9Dfq4ndMn3v4hebIdhGFakb0jjisHIQkAbUvfgMgc82R1W2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB60A15A1;
	Sat, 12 Oct 2024 13:48:06 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AEDF63F5A1;
	Sat, 12 Oct 2024 13:47:35 -0700 (PDT)
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
Subject: [PATCH v3 2/3] perf probe: Check group string length
Date: Sat, 12 Oct 2024 21:47:24 +0100
Message-Id: <20241012204725.928794-3-leo.yan@arm.com>
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

