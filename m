Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054A843BDC3;
	Tue, 11 Aug 2026 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469636; cv=none; b=cltjIL1jY3/QNiIrqv7ScoNyzQeYxPHeT4Ulmlwv6IvbmkfkAl4BrQPi9ntY9UH9Onz6cF1ccMRazVLPAf98+E25WdCjUiddBLVZV4fTHWggwiUKYNRSA5pf9E9d49ToKD9WhCp43KnJhX8mYOQBgNCLDGnckMTnSTBldcjkCl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469636; c=relaxed/simple;
	bh=B4MuTUdhC3EllZcVqMauZHoRywzHrlzMHRYm5m56Tlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHJyZ0sxvo3qIRAUl3aIPjWK1E+QdfIdAhwazli/LIc8lJ1GGjfE2Wkc2Ui5OCoqpb/TN3GleOBgFlNo9g88P+5C9fl+EibnjOvyNpqlAmgvj8Nx7ZlzQ9f3ut3sQDkuOUR3Jnph2fO0A7ZYo77R3VpEOEfgeuqdveQuw5E1iV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNCOZoj9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNCOZoj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786469635; x=1818005635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B4MuTUdhC3EllZcVqMauZHoRywzHrlzMHRYm5m56Tlw=;
  b=GNCOZoj9VO3vb9ZkPvald7kSj1MHsFI35s1GBzGn534vJKkYChUCdfGj
   GEB8ckP+9trvGyJXOp01neel96u0QGax9Tw4CKWa9ubtr2E4zgVhaApXX
   kY1RQ4r28nOgbWUwPuQNpe6F1d3x28vC/qfXORba9XjmMjPjyttr6O+ep
   gub33PMofeY0Z8KeuQyqKht7VcW1mgRzPpqnz+IRA34I69EZPRu5qVxiH
   Btaov9achFq4XTs6uZ3fmYfTilTAlTMTuaYCqVqboTVFVq8Q9I+I4M1C/
   Oy72psxetFEXjPvUb2BHuAkbViPlhk7rYTqtAuPmbxYsJJ4iqFlKjGgKS
   A==;
X-CSE-ConnectionGUID: BqNZ4Ft3TqCEgv9DQ6LFmQ==
X-CSE-MsgGUID: KggbEtPJQ12AicVWXwiNMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86863212"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="86863212"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 10:33:55 -0700
X-CSE-ConnectionGUID: iF1o5b38TKG/Xv2VCVXyUQ==
X-CSE-MsgGUID: lg1kF8HYQBm7Q9lMbCqP6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="261648021"
Received: from hanvin-mobl3.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.223.16])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 10:33:53 -0700
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
Subject: [PATCH v4 1/6] perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()
Date: Tue, 11 Aug 2026 12:33:35 -0500
Message-ID: <20260811173340.96013-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811173340.96013-1-thomas.falcon@intel.com>
References: <20260811173340.96013-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing memory info in perf script, the entire size of the
buffer is passed to perf_mem__lvl_scnprintf() instead of the remaining
size. Pass the remaining buffer size instead.

This issue was detected by sashiko during an internal code review.

Assisted-by: Sashiko:gemini-3.1-pro-preview
Fixes: fdefc3750e847 ("perf mem: Print memory operation type")
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/util/mem-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 0b49fce251fc..4e490f9cd348 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -610,7 +610,7 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *
 	i += scnprintf(out, sz, "|OP ");
 	i += perf_mem__op_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|LVL ");
-	i += perf_mem__lvl_scnprintf(out + i, sz, mem_info);
+	i += perf_mem__lvl_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|SNP ");
 	i += perf_mem__snp_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|TLB ");
-- 
2.55.0

