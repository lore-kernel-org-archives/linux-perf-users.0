Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2465C46EF69;
	Tue, 15 Sep 2026 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463890; cv=none; b=sCObjrp8q9pJeuzNdLqieqjvnEmM+/X2QZLQ+KxlvqtZd+E0pV27NUVNbjt3skjfb/gWd5m4NPGpGiCpXYDrxh2OH7c5gdlEFf/pWFapstt8fCJofNfO7BZilejqIUxiq5lHKGCXPgRtrzv5EIehIhLIk7lhcP3+5fSGwoNQySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463890; c=relaxed/simple;
	bh=NdgbSqwyR03z7n7QE1IVneWfRI2ez4/xZkx/YQzxuSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M7MBDeQlQjITZMpxmQCEb8nv9fY34/rylXpVrOweeD9xIuIZ1r5nSJMWu1y+dA54FWDPcGc8XZ6nUz87ZnH7wU557Rl61pbTaByvpL5eJcAJkKwzn9+66+q86pimSXcOMSeDSDB1I0PWXLrhBjHgjfQ0fUKtut4z9WJSwkK+wpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSr8nL86; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSr8nL86"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789463889; x=1820999889;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NdgbSqwyR03z7n7QE1IVneWfRI2ez4/xZkx/YQzxuSY=;
  b=WSr8nL86L0ndGECxuz1+MxFm36MRLMAVvmF/TB40efTmlArmPwod+suQ
   EGJdWoSyfCerZ6+gUKx4Bdv9aL6C8wZ5AzV+KEVxtefohYVOeF5E1WKb8
   sHAeZK2TFkgxypO2w3UNq0Uru1G/SAXkvzZwmxr14miJx2ua0MGzjTaM7
   +y1Je8iZTvU7rDl3Vf+bs2u4sFdNmFqaNEIjSczI5EBtPt71cIBQdkZ9b
   PGjoNxez3V7uDb9lq7m+PHTaWH1S3xBH9cdrHaRutzXYqxFYuUDHaHpDa
   V35ehRznATczHonvveXSwGu9LWRQeAt1EKCxmKREWOFqqTJ/Ze15TObYw
   g==;
X-CSE-ConnectionGUID: Oza/3+qWQPWa87kI8wqG8g==
X-CSE-MsgGUID: 5jc1V0rUT/W1cNSq3Im4Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89580975"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89580975"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:18:08 -0700
X-CSE-ConnectionGUID: FMeCGp1pStaLo3R/31M+uw==
X-CSE-MsgGUID: oYEXm9u8TKKSj5WGxRSe6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1115306"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 02:18:05 -0700
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
Subject: [PATCH 1/2] perf alsr: Add missing SIMD handling in aslr_tool__process_sample()
Date: Tue, 15 Sep 2026 17:11:11 +0800
Message-Id: <20260915091112.333308-1-dapeng1.mi@linux.intel.com>
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
---

These two patches fix Sashiko reported defects for the patchset:
"Perf tools: Support eGPRs/SSP/SIMD registers sampling"
https://lore.kernel.org/all/20260914014049.2061519-1-dapeng1.mi@linux.intel.com/

 tools/perf/util/aslr.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index 027695d96779..a097084201a0 100644
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

base-commit: 91b0782fc9e9d2f0a40b5256146e014802fdbb36
-- 
2.34.1

