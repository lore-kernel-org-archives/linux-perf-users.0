Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DCE435EF0;
	Mon,  3 Aug 2026 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789961; cv=none; b=nEW0qIw0rRooWuuq2m1Z0T6IFtx3Y1SpJCtN31lBP9VoMfW43DXWg4Gol9PqsVvVlQbz4gpV7xGseVxSGAtRE+bwlVen4z3j8+m/Xr9WVEK8T9O+gXkD9KdSoxdRil2LyBw/o8g8P/m03VDDDMddd7MNbb2l7YT26wuBKSp4T/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789961; c=relaxed/simple;
	bh=r9Sx8/fk5otaxkzlYES+LH6VW4de19ZUSFFOPTgJbsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEOv/QaWVm7VdKAlbK9cNa8jAp5HgNRhmFuPX2ADynB1KVXhpn8sXomqFR167l4x2Bllz6nSo+fb8KMnq+bf3gSC3DNzpdSGOGNuVWsWVQUFQf8n20CMhCGgsNo8E2HK9y3pEgEnBWysT206zOmd8TLc2AeOOOGL/sFObAo0cPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQ3A0856; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQ3A0856"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785789960; x=1817325960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r9Sx8/fk5otaxkzlYES+LH6VW4de19ZUSFFOPTgJbsc=;
  b=EQ3A0856qUox+r/IzzX9n022en0I5TmramQh9uQVRCgK7G6Tjn/r9RNy
   nx/3tjDsFl9CtZ36wx19vkUiLL0DbBWYa85FK4yQ6u81AhlBveWifN689
   iLCAKF/gl7Stvsncrv8usi8z4ixJ3sl80Okne/B0l8HKJT0ib7nmPNOMh
   gTAAZ0dbW/AbxqCvaV3Y/h2IY9CVfqHH5IfuZ186EjVy+czvXmOAh+h9k
   /vbl/JIdTzBbO1tfWTZO2QDDmCBnCpW98IA8gk2+oKXrzJou1DvpW11nS
   O4hVA0Dn7xRtxhOm3iSJ/id+IDfOif7XGCNhuWPjQTzq/AnLa0ep1TWxS
   Q==;
X-CSE-ConnectionGUID: utCNMLErQ2OjfioMMTT8kw==
X-CSE-MsgGUID: G2sxiJFGSLS+CzGS3S1QqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="96927265"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="96927265"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:45:59 -0700
X-CSE-ConnectionGUID: KoLo8gOkQW+6yYnAjoDZ1A==
X-CSE-MsgGUID: FyMseaNmSgeH3fCDaIh8cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="284702361"
Received: from rosenzwe-mobl1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.221.5])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:45:56 -0700
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
Subject: [PATCH v3 2/6] perf mem: Add support for printing PERF_MEM_LVLNUM_L0
Date: Mon,  3 Aug 2026 15:45:36 -0500
Message-ID: <20260803204540.100348-3-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803204540.100348-1-thomas.falcon@intel.com>
References: <20260803204540.100348-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Add support for printing PERF_MEM_LVLNUM_L0 in perf mem report.

The L0 cache is newly added a small piece of cache which is
the closest, lowest-latency memory cache tied directly to the
execution pipeline.

The table "Table 9-4. Data Source Field Encodings for Panther
Cove and Coyote Cove Microarchitectures" in the ISE doc chapter
"9.2.1 Panther Cove and Coyote Cove Microarchitectures Memory
Auxiliary Field Layout"[1] indicates the code "01H" means the
"L0 Hit - Minimal latency core cache hit. This request was
satisfied by the L0 data cache."

[1]: https://www.intel.com/content/www/us/en/content-details/922690/intel-architecture-instruction-set-extensions-programming-reference.html

Assisted-by: Sashiko:gemini-3.1-pro-preview
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
v3: Included more information about the L0 cache in the commit message.
---
 tools/perf/Documentation/perf-record.txt | 2 +-
 tools/perf/util/bpf-filter.l             | 1 +
 tools/perf/util/mem-events.c             | 5 +++++
 tools/perf/util/mem-events.h             | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 178f483140ed..b54032efe41c 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -212,7 +212,7 @@ OPTIONS
 	The <value> can be one of:
 	  <number> (for any term)
 	  na, load, store, pfetch, exec (for mem_op)
-	  l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
+	  l0, l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
 	  na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
 	  remote (for mem_remote)
 	  na, locked (for mem_locked)
diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index 6aa65ade3385..1be9df6550fc 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -131,6 +131,7 @@ store		{ return constant(PERF_MEM_OP_STORE); }
 pfetch		{ return constant(PERF_MEM_OP_PFETCH); }
 exec		{ return constant(PERF_MEM_OP_EXEC); }
 
+l0		{ return constant(PERF_MEM_LVLNUM_L0); }
 l1		{ return constant(PERF_MEM_LVLNUM_L1); }
 l2		{ return constant(PERF_MEM_LVLNUM_L2); }
 l3		{ return constant(PERF_MEM_LVLNUM_L3); }
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 4e490f9cd348..4fd48fd20055 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -391,6 +391,7 @@ static const char * const mem_lvlnum[] = {
 	[PERF_MEM_LVLNUM_L4] = "L4",
 	[PERF_MEM_LVLNUM_L2_MHB] = "L2 MHB",
 	[PERF_MEM_LVLNUM_MSC] = "Memory-side Cache",
+	[PERF_MEM_LVLNUM_L0] = "L0",
 	[PERF_MEM_LVLNUM_UNC] = "Uncached",
 	[PERF_MEM_LVLNUM_CXL] = "CXL",
 	[PERF_MEM_LVLNUM_IO] = "I/O",
@@ -831,6 +832,8 @@ int mem_stat_index(const enum mem_stat_type mst, const u64 val)
 		}
 	case PERF_MEM_STAT_CACHE:
 		switch (src.mem_lvl_num) {
+		case PERF_MEM_LVLNUM_L0:
+			return MEM_STAT_CACHE_L0;
 		case PERF_MEM_LVLNUM_L1:
 			return MEM_STAT_CACHE_L1;
 		case PERF_MEM_LVLNUM_L2:
@@ -915,6 +918,8 @@ const char *mem_stat_name(const enum mem_stat_type mst, const int idx)
 		}
 	case PERF_MEM_STAT_CACHE:
 		switch (idx) {
+		case MEM_STAT_CACHE_L0:
+			return "L0";
 		case MEM_STAT_CACHE_L1:
 			return "L1";
 		case MEM_STAT_CACHE_L2:
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 5b98076904b0..daa22748f9fe 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -109,6 +109,7 @@ enum mem_stat_op {
 };
 
 enum mem_stat_cache {
+	MEM_STAT_CACHE_L0,
 	MEM_STAT_CACHE_L1,
 	MEM_STAT_CACHE_L2,
 	MEM_STAT_CACHE_L3,
-- 
2.55.0

