Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49273DFC7F;
	Fri, 10 Apr 2026 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858993; cv=none; b=LX6ZzVq8c2PM/OGcBrBHJyLslQmHdxkbERjbEpEbZE7rDrQcmIBiXIEBuzFSJEv70LXqrKrbqcDspsueRZSA9AqP4vIwHPbqhQcRsaGzoAPt6GxdEPILlU5hsMKrtO91NM9ofCEUVL1Tiw6LMSM9sQoj2XXXGz8+H0R0dZLEj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858993; c=relaxed/simple;
	bh=Qvl6itdDYe7T41pkFxvKgw4wkWxik7cNcspL+cGnelM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsLAMq3s9lFOxBZeeP5kE68AS51lU2fjZkVDxtz0v9OQIO4Uu1MGE189TU+YIQLm4fFsqLBZ+VPEQ+ZMnNbAWHFR6FIm67ghwGiTNoMcoXEeMPMoHtJTD02CZ3TC2MK7GQvM1gnLEic/TRMtnmEaAY2+A29jnTVJ+hUk5cY8Ldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBO1C1PM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBO1C1PM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A44C2BC87;
	Fri, 10 Apr 2026 22:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858992;
	bh=Qvl6itdDYe7T41pkFxvKgw4wkWxik7cNcspL+cGnelM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OBO1C1PMJ/SqQUb2yGRAVSypFMwqWseik6kk2wmmVEIeZwSjCjr/0F4cQAqphTRpY
	 fjQ+ouFCD6tySG69ARtFv82Q4Q/bTxTPCnKe2uCW3MjCbv81PSrzNG92tHSAaZe0y/
	 gfSYKEBZB7fJ2MNlgMaW+0weHCG23ZyY0x0rwor+2w15w0y+Xe65UCtHRzGqkUhBkU
	 FxHe2PTJO9rIUY2dFqLMtJLWHwf2J+kjJHReRwT/uQdGvwWLED72arxH6zWlLGPOy5
	 O6PtpTN3kqsryidLOF02ldGyE8oupSDOBWndIC/VDuvd8Ul0KoRybLSkRHWhTD+Uou
	 zNCMTb1AujmJg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/13] perf header: Sanity check HEADER_CACHE
Date: Fri, 10 Apr 2026 19:09:01 -0300
Message-ID: <20260410220905.200051-10-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410220905.200051-1-acme@kernel.org>
References: <20260410220905.200051-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add upper bound check on cache entry count in process_cache() to harden
against malformed perf.data files (max 32768).

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 993e20debd5ca315..749a522fe057e739 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -63,6 +63,7 @@
 #include <event-parse.h>
 #endif
 
+#define MAX_CACHE_ENTRIES	32768
 #define MAX_GROUP_DESC		32768
 #define MAX_NUMA_NODES		4096
 #define MAX_PMU_MAPPINGS	4096
@@ -3243,6 +3244,18 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &cnt))
 		return -1;
 
+	if (cnt > MAX_CACHE_ENTRIES) {
+		pr_err("Invalid HEADER_CACHE: cnt (%u) > %u\n",
+		       cnt, MAX_CACHE_ENTRIES);
+		return -1;
+	}
+
+	if (ff->size < 2 * sizeof(u32) + cnt * 7 * sizeof(u32)) {
+		pr_err("Invalid HEADER_CACHE: section too small (%zu) for %u entries\n",
+		       ff->size, cnt);
+		return -1;
+	}
+
 	caches = calloc(cnt, sizeof(*caches));
 	if (!caches)
 		return -1;
-- 
2.53.0

