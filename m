Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE2A57D239;
	Wed,  9 Sep 2026 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969754; cv=none; b=pmx9k0h2fLeZkOpbFarYSNYHCm0jnkxCqY3N/GEMn+QGNNxr14/Bun4qf16WWpxvn4KPwSXbasrEnSvYGqrrK2OIX7GUjwMrKoeVTQZmlwZZ1pV/t/s3MpMjUdY3h5SKyfCkijkWHYjoQ7++pUcAemPIAR3JZaCAg/r2o353nLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969754; c=relaxed/simple;
	bh=pur8Eze4+XrwJ9Gf7uH6Gld/z1arU4xEqnuXcuwoyG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtjWy1We3Tl+Y41bpbcXzbZHRUhFs7e2xFX8WpTfpEEZzvme58GzpRmHoWG3Np3hCIOUO+fiJ2epHbjEF1AK0962WwJxy/1bNcckBbDZh3pkznWAoVg+oRYQHQjtRma7mZxs9Hd49o9/9w/jQojIHeeUWJk/epVyn46fPoY3nJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehRoiljV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehRoiljV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788969754; x=1820505754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pur8Eze4+XrwJ9Gf7uH6Gld/z1arU4xEqnuXcuwoyG8=;
  b=ehRoiljVDiC7Bx+96x5sP+JL1qAfKhN7rl1eJ8JMmzzfGNw0etn0tvjV
   Hm9jfWGB734/rjxqY9AFYpvzsPgqidNV067unDbvN9aTbd/NbvIPLtB41
   ituEJz56nAzdV5fHJ85EznwelYzuZmXYS1dUtGOztKrCDh0I5zEilyNOi
   bsh4EP47R+Y08m08j0o1ZxeEjJ2zh87PNGGJX1w54QlFZG530biFmfr9m
   xJ/+uAhvKjoyINzozyYdstxyLosh07PWz46zyCsp2PfXEkIMQrFAeYNwy
   vVIvrCVFLGx2CbVLXZd9cySVWpQLF5uCaG9ZmVhYOzu4eG7gIVZmmvjDz
   Q==;
X-CSE-ConnectionGUID: Ta9pfMSZQoW28IiFXhDPyg==
X-CSE-MsgGUID: kl0Jhx8iTXm5j0KCrcC+Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100564473"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="100564473"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 09:02:33 -0700
X-CSE-ConnectionGUID: RfcKXboxRs+NUVyz8tHtBg==
X-CSE-MsgGUID: dcdmbfgnTD+gu4juKxT+0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="267072945"
Received: from iweiny-desk3.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.222.48])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 09:02:31 -0700
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
Subject: [PATCH v7 2/6] perf mem: Add support for printing PERF_MEM_LVLNUM_L0
Date: Wed,  9 Sep 2026 11:02:14 -0500
Message-ID: <20260909160218.174928-3-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909160218.174928-1-thomas.falcon@intel.com>
References: <20260909160218.174928-1-thomas.falcon@intel.com>
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
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.43.0

