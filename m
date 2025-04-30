Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501592D5D0B;
	Wed, 30 Apr 2025 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046558; cv=none; b=WfYP/IK5fms2nTSBkj25MipZw/99Uc/ie1+gLYkwL+0qCZZWAFNrFVv7mWhBUCRJSlGgV2bWJqVblPwBigWV6nceVTAd2AVqBKapi7AkLLwwFjjwdPYs2353zRIF3NMD/sou3GRdMjHNKVzPABFxvf31AsWTVBMunmI6hoD9WAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046558; c=relaxed/simple;
	bh=mwpBnuaInsvGExuka4jT+916LzxQ4kQdYADqsxQz6WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyO0Iy3u31um/MoFiFVscbXSJ4HaHj55vzV9aJkKffoC86zVuOQx0zgSuV0iSl2MA0vd6ir2KAbycxV4dGpFD+VcpX25LyPGEeA+8vA3+AhO6yx2j0uzxs3cxd2NzLQkKG+mpKNDgv0SOr6GivI0s+V+hfIV2eyvwxB9JKvJd58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6UIF3IE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6UIF3IE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBD0C4CEEC;
	Wed, 30 Apr 2025 20:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746046557;
	bh=mwpBnuaInsvGExuka4jT+916LzxQ4kQdYADqsxQz6WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6UIF3IE+0m9WJX0ztFawqwEYr2suMbfFj5mOD7zb924RezYUktXScGBcPCPxhn0B
	 8CZIiBphvYHJ0OSso3PHHYJtam+ED5jqkrJ30ybTdDnHXdi10eM0dW4cOtT3TTtUCa
	 5mulqwn9a6jytw5eg2O/U59RZXfGE/pETtQwkM3bBM3ncB3WmUgVgOdCSdE+Rn0A7C
	 j9pqifPUaoApW48N7elhiMiFqIGfjLVHjzmkkzJAVZ726P00CycsE8kb1FZupZzcWg
	 IYrmkpdsm5gOTfYGZCC1CUSrXGuuiioDvw2ubARPnpmKnK1QHH6D3EI5JOrQuks5LW
	 cE3U7K3iusIsA==
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
Subject: [PATCH 11/11] perf mem: Add 'dtlb' output field
Date: Wed, 30 Apr 2025 13:55:48 -0700
Message-ID: <20250430205548.789750-12-namhyung@kernel.org>
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

This is a breakdown of perf_mem_data_src.mem_dtlb values.  It assumes
PMU drivers would set PERF_MEM_TLB_HIT bit with an appropriate level.
And having PERF_MEM_TLB_MISS means that it failed to find one in any
levels of TLB.  For now, it doesn't use PERF_MEM_TLB_{WK,OS} bits.

Also it seems Intel machines don't distinguish L1 or L2 precisely.  So I
added ANY_HIT (printed as "L?-Hit") to handle the case.

  $ perf mem report -F overhead,dtlb,dso --stdio
  ...
  #           --- D-TLB ----
  # Overhead   L?-Hit   Miss  Shared Object
  # ........  ..............  .................
  #
      67.03%    99.5%   0.5%  [unknown]
      31.23%    99.2%   0.8%  [kernel.kallsyms]
       1.08%    97.8%   2.2%  [i915]
       0.36%   100.0%   0.0%  [JIT] tid 6853
       0.12%   100.0%   0.0%  [drm]
       0.05%   100.0%   0.0%  [drm_kms_helper]
       0.05%   100.0%   0.0%  [ext4]
       0.02%   100.0%   0.0%  [aesni_intel]
       0.02%   100.0%   0.0%  [crc32c_intel]
       0.02%   100.0%   0.0%  [dm_crypt]
       ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/hists.c |  3 +++
 tools/perf/ui/hist.c           |  5 +++++
 tools/perf/util/hist.h         |  1 +
 tools/perf/util/mem-events.c   | 27 +++++++++++++++++++++++++++
 tools/perf/util/mem-events.h   |  9 +++++++++
 tools/perf/util/sort.c         |  1 +
 6 files changed, 46 insertions(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 5b080f5062440246..d26b925e3d7f46af 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1288,6 +1288,7 @@ __HPP_COLOR_MEM_STAT_FN(op, OP)
 __HPP_COLOR_MEM_STAT_FN(cache, CACHE)
 __HPP_COLOR_MEM_STAT_FN(memory, MEMORY)
 __HPP_COLOR_MEM_STAT_FN(snoop, SNOOP)
+__HPP_COLOR_MEM_STAT_FN(dtlb, DTLB)
 
 #undef __HPP_COLOR_PERCENT_FN
 #undef __HPP_COLOR_ACC_PERCENT_FN
@@ -1319,6 +1320,8 @@ void hist_browser__init_hpp(void)
 				hist_browser__hpp_color_mem_stat_memory;
 	perf_hpp__format[PERF_HPP__MEM_STAT_SNOOP].color =
 				hist_browser__hpp_color_mem_stat_snoop;
+	perf_hpp__format[PERF_HPP__MEM_STAT_DTLB].color =
+				hist_browser__hpp_color_mem_stat_dtlb;
 
 	res_sample_init();
 }
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 94024dfa8dccf9ba..ed5c40ebd906f076 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -354,6 +354,8 @@ static enum mem_stat_type hpp__mem_stat_type(struct perf_hpp_fmt *fmt)
 		return PERF_MEM_STAT_MEMORY;
 	case PERF_HPP__MEM_STAT_SNOOP:
 		return PERF_MEM_STAT_SNOOP;
+	case PERF_HPP__MEM_STAT_DTLB:
+		return PERF_MEM_STAT_DTLB;
 	default:
 		break;
 	}
@@ -653,6 +655,7 @@ HPP_MEM_STAT_FNS(op, OP)
 HPP_MEM_STAT_FNS(cache, CACHE)
 HPP_MEM_STAT_FNS(memory, MEMORY)
 HPP_MEM_STAT_FNS(snoop, SNOOP)
+HPP_MEM_STAT_FNS(dtlb, DTLB)
 
 static int64_t hpp__nop_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 			    struct hist_entry *a __maybe_unused,
@@ -760,6 +763,7 @@ struct perf_hpp_fmt perf_hpp__format[] = {
 	HPP__MEM_STAT_PRINT_FNS("Cache", cache, CACHE),
 	HPP__MEM_STAT_PRINT_FNS("Memory", memory, MEMORY),
 	HPP__MEM_STAT_PRINT_FNS("Snoop", snoop, SNOOP),
+	HPP__MEM_STAT_PRINT_FNS("D-TLB", dtlb, DTLB),
 };
 
 struct perf_hpp_list perf_hpp_list = {
@@ -1118,6 +1122,7 @@ void perf_hpp__reset_width(struct perf_hpp_fmt *fmt, struct hists *hists)
 	case PERF_HPP__MEM_STAT_CACHE:
 	case PERF_HPP__MEM_STAT_MEMORY:
 	case PERF_HPP__MEM_STAT_SNOOP:
+	case PERF_HPP__MEM_STAT_DTLB:
 		fmt->len = MEM_STAT_LEN * MEM_STAT_PRINT_LEN;
 		break;
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index c2d286c4ba395674..355198fd70281f43 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -592,6 +592,7 @@ enum {
 	PERF_HPP__MEM_STAT_CACHE,
 	PERF_HPP__MEM_STAT_MEMORY,
 	PERF_HPP__MEM_STAT_SNOOP,
+	PERF_HPP__MEM_STAT_DTLB,
 
 	PERF_HPP__MAX_INDEX
 };
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index ddcfc6500d77a9e6..3e9131e05348a996 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -868,6 +868,19 @@ int mem_stat_index(const enum mem_stat_type mst, const u64 val)
 		default:
 			return MEM_STAT_SNOOP_OTHER;
 		}
+	case PERF_MEM_STAT_DTLB:
+		switch (src.mem_dtlb) {
+		case PERF_MEM_TLB_L1 | PERF_MEM_TLB_HIT:
+			return MEM_STAT_DTLB_L1_HIT;
+		case PERF_MEM_TLB_L2 | PERF_MEM_TLB_HIT:
+			return MEM_STAT_DTLB_L2_HIT;
+		case PERF_MEM_TLB_L1 | PERF_MEM_TLB_L2 | PERF_MEM_TLB_HIT:
+			return MEM_STAT_DTLB_ANY_HIT;
+		default:
+			if (src.mem_dtlb & PERF_MEM_TLB_MISS)
+				return MEM_STAT_DTLB_MISS;
+			return MEM_STAT_DTLB_OTHER;
+		}
 	default:
 		break;
 	}
@@ -942,6 +955,20 @@ const char *mem_stat_name(const enum mem_stat_type mst, const int idx)
 		default:
 			return "Other";
 		}
+	case PERF_MEM_STAT_DTLB:
+		switch (idx) {
+		case MEM_STAT_DTLB_L1_HIT:
+			return "L1-Hit";
+		case MEM_STAT_DTLB_L2_HIT:
+			return "L2-Hit";
+		case MEM_STAT_DTLB_ANY_HIT:
+			return "L?-Hit";
+		case MEM_STAT_DTLB_MISS:
+			return "Miss";
+		case MEM_STAT_DTLB_OTHER:
+		default:
+			return "Other";
+		}
 	default:
 		break;
 	}
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 4d8f18583af42550..5b98076904b0b689 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -94,6 +94,7 @@ enum mem_stat_type {
 	PERF_MEM_STAT_CACHE,
 	PERF_MEM_STAT_MEMORY,
 	PERF_MEM_STAT_SNOOP,
+	PERF_MEM_STAT_DTLB,
 };
 
 #define MEM_STAT_PRINT_LEN  7  /* 1 space + 5 digits + 1 percent sign */
@@ -134,6 +135,14 @@ enum mem_stat_snoop {
 	MEM_STAT_SNOOP_OTHER,
 };
 
+enum mem_stat_dtlb {
+	MEM_STAT_DTLB_L1_HIT,
+	MEM_STAT_DTLB_L2_HIT,
+	MEM_STAT_DTLB_ANY_HIT,
+	MEM_STAT_DTLB_MISS,
+	MEM_STAT_DTLB_OTHER,
+};
+
 int mem_stat_index(const enum mem_stat_type mst, const u64 data_src);
 const char *mem_stat_name(const enum mem_stat_type mst, const int idx);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 51a210d874327d3a..8efafa7c10822ee9 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2627,6 +2627,7 @@ static struct hpp_dimension hpp_sort_dimensions[] = {
 	DIM_MEM(PERF_HPP__MEM_STAT_CACHE, "cache"),
 	DIM_MEM(PERF_HPP__MEM_STAT_MEMORY, "memory"),
 	DIM_MEM(PERF_HPP__MEM_STAT_SNOOP, "snoop"),
+	DIM_MEM(PERF_HPP__MEM_STAT_DTLB, "dtlb"),
 };
 
 #undef DIM_MEM
-- 
2.49.0.906.g1f30a19c02-goog

