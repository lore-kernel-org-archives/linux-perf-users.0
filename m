Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2B22D26A9;
	Wed, 30 Apr 2025 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046557; cv=none; b=NXz6XyZwtiqd+TQ3WwVxxBMg5cb+XQ8Ew10eiTVCfSpgRejftTEcDH1uz5u/4APQvSwbTyC36q/IVvINIEGowy5M7mlo4IkLiqJHMmyPWfV9MeTvOcRcIQyyj9j+r52jlZ7fJ1aosfrfZTuqQeWZyPV+O1C6iwE16mvp5Q1Z+ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046557; c=relaxed/simple;
	bh=WZ+nSGlzHsTS0xbr4sBolxWqId6PC7bwCnrZ6y/7vkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlN0IImHH1UXDvKVOUAkC8p9YvwVhp6Y9XJ3ycXzIgDoMYYZw82q2FzCRb+GR3jgVh9uAwdQ69kRtqy4uvVxC4E0nFEiijR0GOtVX5eKUSkK3ynm2VS4VrWB5QWxKA1S/np6S7NFnN9jw2XXfkjwIiEXV7v8/OGBDJRvqXBSQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnvR8D2o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnvR8D2o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2F1C4CEED;
	Wed, 30 Apr 2025 20:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746046556;
	bh=WZ+nSGlzHsTS0xbr4sBolxWqId6PC7bwCnrZ6y/7vkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KnvR8D2o/D0i49Q4qg+6FG3UouBW7GSW9j127i4+XCw5nL8vJnDHzUV36CJRV7VFz
	 8Lp2mrdMaPS0F5PxnR/D21BLcym/rt06rL0W1iphRuiqEakecq4lYidOTyuJnmYREi
	 z9ZbNkPwGhHHCsqlieCJOvWSlf/Ez4CY72OzLj/1rbK2fM/Y06OtjtAE9zfflgN6Z2
	 JC3rpwz7HHWLe1nDwwAbkhegFWPHBdhWVNBNHnKxwuc0jn/TqqJCtJrjMU24d+KPTi
	 eOFrXSDVZQunARZw309zxoL5Rtt66gfal3q8XFSQDlp//S9Aty83fo7gTgJCz5ZCSw
	 Y++CoiClfsv/g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Leo Yan <leo.yan@arm.com>
Subject: [PATCH 10/11] perf mem: Add 'snoop' output field
Date: Wed, 30 Apr 2025 13:55:47 -0700
Message-ID: <20250430205548.789750-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430205548.789750-1-namhyung@kernel.org>
References: <20250430205548.789750-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a breakdown of perf_mem_data_src.mem_snoop values.  For now, it
doesn't use mem_snoopx values like FWD and PEER.

  $ perf mem report -F overhead,snoop,comm --stdio
  ...
  #           ---------- Snoop -----------
  # Overhead      Hit   HitM   Miss  Other  Command
  # ........  ............................  ...............
  #
      34.24%     0.6%   0.0%   0.0%  99.4%  gnome-shell
      12.02%     1.0%   0.0%   0.0%  99.0%  chrome
       9.32%     1.0%   0.0%   0.3%  98.7%  Isolated Web Co
       6.85%     1.0%   0.3%   0.0%  98.6%  swapper
       6.30%     0.8%   0.8%   0.0%  98.5%  Xorg
       3.02%     2.4%   0.0%   0.0%  97.6%  VizCompositorTh
       2.35%     0.0%   0.0%   0.0% 100.0%  firefox-esr
       2.04%     0.0%   0.0%   0.0% 100.0%  JS Helper
       1.51%     3.2%   0.0%   0.0%  96.8%  threaded-ml
       1.44%     0.0%   0.0%   0.0% 100.0%  AudioIP~allback
       ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/hists.c |  3 +++
 tools/perf/ui/hist.c           |  5 +++++
 tools/perf/util/hist.h         |  1 +
 tools/perf/util/mem-events.c   | 23 +++++++++++++++++++++++
 tools/perf/util/mem-events.h   |  8 ++++++++
 tools/perf/util/sort.c         |  1 +
 6 files changed, 41 insertions(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 675dd64067747126..5b080f5062440246 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1287,6 +1287,7 @@ __HPP_COLOR_ACC_PERCENT_FN(latency_acc, latency, PERF_HPP_FMT_TYPE__LATENCY)
 __HPP_COLOR_MEM_STAT_FN(op, OP)
 __HPP_COLOR_MEM_STAT_FN(cache, CACHE)
 __HPP_COLOR_MEM_STAT_FN(memory, MEMORY)
+__HPP_COLOR_MEM_STAT_FN(snoop, SNOOP)
 
 #undef __HPP_COLOR_PERCENT_FN
 #undef __HPP_COLOR_ACC_PERCENT_FN
@@ -1316,6 +1317,8 @@ void hist_browser__init_hpp(void)
 				hist_browser__hpp_color_mem_stat_cache;
 	perf_hpp__format[PERF_HPP__MEM_STAT_MEMORY].color =
 				hist_browser__hpp_color_mem_stat_memory;
+	perf_hpp__format[PERF_HPP__MEM_STAT_SNOOP].color =
+				hist_browser__hpp_color_mem_stat_snoop;
 
 	res_sample_init();
 }
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 7fc09c738ed02acb..94024dfa8dccf9ba 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -352,6 +352,8 @@ static enum mem_stat_type hpp__mem_stat_type(struct perf_hpp_fmt *fmt)
 		return PERF_MEM_STAT_CACHE;
 	case PERF_HPP__MEM_STAT_MEMORY:
 		return PERF_MEM_STAT_MEMORY;
+	case PERF_HPP__MEM_STAT_SNOOP:
+		return PERF_MEM_STAT_SNOOP;
 	default:
 		break;
 	}
@@ -650,6 +652,7 @@ HPP_AVERAGE_FNS(weight3, weight3)
 HPP_MEM_STAT_FNS(op, OP)
 HPP_MEM_STAT_FNS(cache, CACHE)
 HPP_MEM_STAT_FNS(memory, MEMORY)
+HPP_MEM_STAT_FNS(snoop, SNOOP)
 
 static int64_t hpp__nop_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 			    struct hist_entry *a __maybe_unused,
@@ -756,6 +759,7 @@ struct perf_hpp_fmt perf_hpp__format[] = {
 	HPP__MEM_STAT_PRINT_FNS("Mem Op", op, OP),
 	HPP__MEM_STAT_PRINT_FNS("Cache", cache, CACHE),
 	HPP__MEM_STAT_PRINT_FNS("Memory", memory, MEMORY),
+	HPP__MEM_STAT_PRINT_FNS("Snoop", snoop, SNOOP),
 };
 
 struct perf_hpp_list perf_hpp_list = {
@@ -1113,6 +1117,7 @@ void perf_hpp__reset_width(struct perf_hpp_fmt *fmt, struct hists *hists)
 	case PERF_HPP__MEM_STAT_OP:
 	case PERF_HPP__MEM_STAT_CACHE:
 	case PERF_HPP__MEM_STAT_MEMORY:
+	case PERF_HPP__MEM_STAT_SNOOP:
 		fmt->len = MEM_STAT_LEN * MEM_STAT_PRINT_LEN;
 		break;
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 9de50d929ad1268c..c2d286c4ba395674 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -591,6 +591,7 @@ enum {
 	PERF_HPP__MEM_STAT_OP,
 	PERF_HPP__MEM_STAT_CACHE,
 	PERF_HPP__MEM_STAT_MEMORY,
+	PERF_HPP__MEM_STAT_SNOOP,
 
 	PERF_HPP__MAX_INDEX
 };
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 6822815278a4b213..ddcfc6500d77a9e6 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -857,6 +857,17 @@ int mem_stat_index(const enum mem_stat_type mst, const u64 val)
 		default:
 			return MEM_STAT_MEMORY_OTHER;
 		}
+	case PERF_MEM_STAT_SNOOP:
+		switch (src.mem_snoop) {
+		case PERF_MEM_SNOOP_HIT:
+			return MEM_STAT_SNOOP_HIT;
+		case PERF_MEM_SNOOP_HITM:
+			return MEM_STAT_SNOOP_HITM;
+		case PERF_MEM_SNOOP_MISS:
+			return MEM_STAT_SNOOP_MISS;
+		default:
+			return MEM_STAT_SNOOP_OTHER;
+		}
 	default:
 		break;
 	}
@@ -919,6 +930,18 @@ const char *mem_stat_name(const enum mem_stat_type mst, const int idx)
 		default:
 			return "Other";
 		}
+	case PERF_MEM_STAT_SNOOP:
+		switch (idx) {
+		case MEM_STAT_SNOOP_HIT:
+			return "Hit";
+		case MEM_STAT_SNOOP_HITM:
+			return "HitM";
+		case MEM_STAT_SNOOP_MISS:
+			return "Miss";
+		case MEM_STAT_SNOOP_OTHER:
+		default:
+			return "Other";
+		}
 	default:
 		break;
 	}
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 002e2772400e3dda..4d8f18583af42550 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -93,6 +93,7 @@ enum mem_stat_type {
 	PERF_MEM_STAT_OP,
 	PERF_MEM_STAT_CACHE,
 	PERF_MEM_STAT_MEMORY,
+	PERF_MEM_STAT_SNOOP,
 };
 
 #define MEM_STAT_PRINT_LEN  7  /* 1 space + 5 digits + 1 percent sign */
@@ -126,6 +127,13 @@ enum mem_stat_memory {
 	MEM_STAT_MEMORY_OTHER,
 };
 
+enum mem_stat_snoop {
+	MEM_STAT_SNOOP_HIT,
+	MEM_STAT_SNOOP_HITM,
+	MEM_STAT_SNOOP_MISS,
+	MEM_STAT_SNOOP_OTHER,
+};
+
 int mem_stat_index(const enum mem_stat_type mst, const u64 data_src);
 const char *mem_stat_name(const enum mem_stat_type mst, const int idx);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 2ad88f7de95a2247..51a210d874327d3a 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2626,6 +2626,7 @@ static struct hpp_dimension hpp_sort_dimensions[] = {
 	DIM_MEM(PERF_HPP__MEM_STAT_OP, "op"),
 	DIM_MEM(PERF_HPP__MEM_STAT_CACHE, "cache"),
 	DIM_MEM(PERF_HPP__MEM_STAT_MEMORY, "memory"),
+	DIM_MEM(PERF_HPP__MEM_STAT_SNOOP, "snoop"),
 };
 
 #undef DIM_MEM
-- 
2.49.0.906.g1f30a19c02-goog

