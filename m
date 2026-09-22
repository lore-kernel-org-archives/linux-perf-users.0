Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E251A3166;
	Tue, 22 Sep 2026 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039553; cv=none; b=cNTz9IyAbiBbcJlHQ86D1U1HYd/cdAY1BePjJ60Tumokput4TGH6tNhI/efoQW88HNZhKqa8k6NHcs1WS8ywAG7aC/Cca3pYvYUJInNYrpHvK72wBOAPTlyhd7zjf45dOa66zlqXc5wskB7VczAPwgWSzoZl3A8Q0iYILygD3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039553; c=relaxed/simple;
	bh=36Cy2wItiWpIaVi1o9udS+2eJemBeXDr1uyA9cT7K/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kw8MsS6jzsE5x16CgCBAvut74rMZzbKeo3Is8W5BY40ti/TEnf57zoZI0zLTpPMpKoP156XHfSGJWGzENS0e09vHE4ejilwQ60QmRPZp+Ixsk2gr4V5NldD7rEFNruNoaW9p3Z+diUCAXEUzddMrMi+XPaOrzs85qKsBENGvmWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqnLXOIu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqnLXOIu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790039550; x=1821575550;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=36Cy2wItiWpIaVi1o9udS+2eJemBeXDr1uyA9cT7K/o=;
  b=ZqnLXOIu8uGtAqE67Z1Y45fCcJJQO6sTEg4sD6gXxAqD117lEliM2tKK
   GS3+9UIBqebs1S8itHThAlObjfC1fgQuNQEuDSWI+e+jZhV7BozaPPxZs
   J+ksrGGO8KAz2Bgs3TOOhRopnlwJx+TbkrluMirOh9Md7xGfAOT9NKB3D
   5ORqZ6ltoXeQvG6muxvRPeGBb778GZRhton0/Pu/Rc84nrK/yeRmMO3du
   Vh+3VENNUsNB/N8cnR8ifPcxYu+LvhA17uONQ8DvtgZJ34U4CAxicl9O4
   RJ6W1xgC6VwkeiCaxtA2R56mJYfPR4yrVgLZJhMIjIQ+NUY6vZI5NmYhC
   A==;
X-CSE-ConnectionGUID: crvpW3KuRCqPapeKDDKoPw==
X-CSE-MsgGUID: tkzqaKfoQLmTPdJZXg1Z0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101264221"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="101264221"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 18:12:29 -0700
X-CSE-ConnectionGUID: shv+TZYdTwSbqXq4dhW37A==
X-CSE-MsgGUID: hU952eAwT+WBTTIy4R4T8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="269436300"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 21 Sep 2026 18:12:26 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 1/2] perf aslr: Add missing SIMD handling in aslr_tool__process_sample()
Date: Tue, 22 Sep 2026 09:05:30 +0800
Message-Id: <20260922010531.1933320-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the SIMD register sampling is supported, but the corresponding
handling is missed in aslr_tool__process_sample(). This can break parsing
of the sample record.

Add the missing SIMD register handling in aslr_tool__process_sample().

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---

V2: Add missed "#undef CHECK_SIMD" and fix typo in short log (Ian).


 tools/perf/util/aslr.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index 027695d96779..697ac0d3d548 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -19,6 +19,7 @@
 #include <internal/lib.h>  /* page_size */
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
+#include <linux/overflow.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <unistd.h>
@@ -992,6 +993,34 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 				COPY_U64();
 		}
 	}
+
+#define CHECK_SIMD() \
+	do { \
+		if (abi & PERF_SAMPLE_REGS_ABI_SIMD) { \
+			u64 nr_vector, vec_qwords; \
+			u64 nr_pred, pred_qwords; \
+			u64 header_len, vec_len, pred_len, simd_len; \
+			if (CHECK_BOUNDS(nr + 4, nr + 4)) { \
+				ret = -EFAULT; \
+				goto out_put; \
+			} \
+			header_len = 4;	\
+			nr_vector = in_array[i + nr]; \
+			vec_qwords = in_array[i + nr + 1]; \
+			nr_pred = in_array[i + nr + 2]; \
+			pred_qwords = in_array[i + nr + 3]; \
+			if (check_mul_overflow(nr_vector, vec_qwords, &vec_len) || \
+			    check_mul_overflow(nr_pred, pred_qwords, &pred_len) || \
+			    check_add_overflow(vec_len, pred_len, &simd_len) || \
+			    check_add_overflow(header_len, simd_len, &simd_len) || \
+			    check_add_overflow(nr, simd_len, &nr) || \
+			    nr > max_i - i) { \
+				ret = -EFAULT; \
+				goto out_put; \
+			} \
+		} \
+	} while (0)
+
 	if (orig_sample_type & PERF_SAMPLE_REGS_USER) {
 		u64 abi;
 
@@ -1007,6 +1036,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 				ret = -EFAULT;
 				goto out_put;
 			}
+			CHECK_SIMD();
 			i += nr;
 		}
 	}
@@ -1061,6 +1091,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 				ret = -EFAULT;
 				goto out_put;
 			}
+			CHECK_SIMD();
 			i += nr;
 		}
 	}
@@ -1154,6 +1185,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 #undef CHECK_BOUNDS
 #undef COPY_U64
 #undef REMAP_U64
+#undef CHECK_SIMD
 
 static int skipn(int fd, off_t n)
 {

base-commit: 1c12f13c079c35a1e5ef2dd9e6aeea1810c58e87
-- 
2.34.1

