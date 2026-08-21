Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6A330569B;
	Fri, 21 Aug 2026 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787271525; cv=none; b=SIhSLPS+jHeqqnOnfnU9k+XYuRye/jxZIO4iFENVkFVoLXHkvB7ySBgsCKvpkMwiSx59dD+9w9pBXy3eYZ9eaPvocBSUPEf7kauU+OlphJoTPgA7SbudeNwwoz3OjG9K43bDSXsVbc0Ps3o/4gotWsOHFGV5g6Avj7dGpu3VcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787271525; c=relaxed/simple;
	bh=dgjAtpsguz6t8FmJhf7uhm4kiIcO049XKVV50vAysIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBvKYO1h0zPa6iZRtzEbB8gfRcNGI+RjrofjlG+jN3N7qFVqgs6VCVlOpWAwmsbY7qgzSK3ckQ7BZ6xDqxiUFOPXXt3LdhZZgTnAoOGl67JnLeXyG6oEwTycEioCces7hj2m6xpbdQVAw9coyd0u4B/RxrEiRyEpIpdqxx6ykjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/aF+zwm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/aF+zwm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787271516; x=1818807516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dgjAtpsguz6t8FmJhf7uhm4kiIcO049XKVV50vAysIU=;
  b=P/aF+zwmMDXF8+U0AxXQOPIOINqWkZy/T+5s21ZFeJKTk4SHRiQ/qeli
   bVGijKxIRwXAeByYC0AwyK6AwV6R4bVq9/SFG/c8JsLhUXliv8rsn4rqO
   yL4N+HnMdaa6pKKWf6uvmdcKchcuhzCc1dWCZWFQxmqBS4iAagf7s352t
   bUki81DFcDWaJhDsYyrULVe8LnmHZc6XmuupVJelSQ98e07TZh4AjpUhv
   KYIxPzyQmx/etwPVxqj6ZQ3yMwgDirGVlJZr0T5Y+SLfUR36dQpxj1W/3
   lQfrgW4H9ezZt0T0+tD4XYlz1ljpn5lALt7XeBN4hGJZ44MtWMmatx4i8
   g==;
X-CSE-ConnectionGUID: YHvURKnySDuKpn7rKWyfkg==
X-CSE-MsgGUID: DQm/EgvRTY+0dGuXtvHRCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87839505"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="87839505"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 17:18:34 -0700
X-CSE-ConnectionGUID: /vLtCw1PQB+dTrkiLCQfCg==
X-CSE-MsgGUID: 9QtBiomfTkq3mVY2/QGGIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="261915000"
Received: from rodrigoa-mobl1.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.221.152])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 17:18:33 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v5 6/6] perf c2c: print memory region data with stdio output
Date: Thu, 20 Aug 2026 19:18:19 -0500
Message-ID: <20260821001819.162277-7-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821001819.162277-1-thomas.falcon@intel.com>
References: <20260821001819.162277-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print memory range data in perf-c2c subcommand. Only available in stdio
mode currently. If memory ranges are not supported or present, print
nothing.

Example output of perf c2c report --stdio:

=================================================
                  Memory Ranges
=================================================
Range 0: [0x0000000000000000-0x00000000bfffffff] Node 0, local region id 0, remote region id 255
Range 1: [0x0000000100000000-0x000000203fffffff] Node 0, local region id 0, remote region id 255
Range 2: [0x0000008000000000-0x0000027fffffffff] Node -2, local region id 1, remote region id 255
Range 3: [0x0000028000000000-0x0000047fffffffff] Node -2, local region id 1, remote region id 255
Range 4: [0x0000048000000000-0x000004ffffffffff] Node -2, local region id 1, remote region id 255

Assisted-by: Sashiko:gemini-3.1-pro-preview
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
v3: Included examples of memory range output in commit message
---
 tools/perf/builtin-c2c.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index ce324fc59947..4cac63e843c9 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2680,6 +2680,34 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
 	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
 }
 
+
+static void print_memory_ranges_info(FILE *out, struct perf_session *session)
+{
+	struct perf_env *env = perf_session__env(session);
+	int nr_ranges = 0;
+
+	if (!perf_header__has_feat(&session->header, HEADER_MEMORY_RANGES))
+		return;
+	nr_ranges = env->nr_memory_ranges;
+	if (nr_ranges == 0) {
+		pr_debug("No memory ranges found, skipping\n");
+		return;
+	}
+
+	fprintf(out, "\n");
+	fprintf(out, "=================================================\n");
+	fprintf(out, "                  Memory Ranges                  \n");
+	fprintf(out, "=================================================\n");
+
+	for (int i = 0; i < nr_ranges; i++) {
+		struct memory_range *r = &env->memory_ranges[i];
+
+		fprintf(out, "Range %d: [0x%016" PRIx64 "-0x%016" PRIx64 "] Node %d, local region id %u, remote region id %u\n",
+			i, r->base, r->base + r->length - 1, r->node,
+			r->local_region_id, r->remote_region_id);
+	}
+}
+
 static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 {
 	setup_pager();
@@ -2693,6 +2721,8 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 	if (c2c.stats_only)
 		return;
 
+	print_memory_ranges_info(out, session);
+
 	fprintf(out, "\n");
 	fprintf(out, "=================================================\n");
 	fprintf(out, "           Shared Data Cache Line Table          \n");
-- 
2.55.0

