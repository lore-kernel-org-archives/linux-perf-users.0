Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E57493644;
	Thu, 10 Sep 2026 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069468; cv=none; b=JZzOB57Jn+8UB8UD91PUqGWTkwTFJRZ7ci7Id3gL12UU6O+mBVP7eS9NMDDzkTRIdzpIeafz8irodd+2Y+ITt1Ng4/yV79XG/NjB75ea9JDk5aNU4eJbE165ateYIDaLqeRHpWQK/YUFSBTSuwO6gJmY1hH+wrzxaRoFu1LieOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069468; c=relaxed/simple;
	bh=mLejFowYm2X6VHgkPdi17Jgt/N1ot0OaV91zeWDUK4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+v7F4A41uUdS8OXXsjWKsXJ8P5j5No0LpyjDJkECThwSPyFLoFE8KhXn/xCbexKGyp5+6cVMMsOoT25cZrMYrKw5Gz8uyFyNpmF5LgMadbr/WGiNGohGyV+qkWGgrbssr81MW7VcCHu43R7gtu7ThwpZRIH56AWVw8UKOcJY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcnrM24p; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcnrM24p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789069466; x=1820605466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mLejFowYm2X6VHgkPdi17Jgt/N1ot0OaV91zeWDUK4M=;
  b=jcnrM24p7huzXAlDRWD2TjH7S4fbeqGVwGdeHACGNbRcUtkLq6pfD/6X
   P9lc5mWqTxBgh/VUcKoKfiy4k66VP2BR8GxapGo3FXOVBfgEIEvGMT7OL
   9MT9I7PJdVV8rTG5tQQl3ChsIwKosjN3zrGTd3gOFJOYhhYHn31+cUSFD
   2aUvWh7Uf3n2UmNEOl14Cq+5snAZ+LPI+jTv+N0hiKc+T87C8HmawUKi8
   lR0FJrm0AbbKUWszVlJ8/++kDrhtFjhg6VQszQoZraW4ppQ3OLa2bvkqB
   zu/0cgxm2NV0xDsTyHBrm6rtps1rTAlLNRH2yzobkzJhAXMjfE9yO2gnA
   A==;
X-CSE-ConnectionGUID: ePZSZmvTSX6iYMKruLVjOg==
X-CSE-MsgGUID: JydU6PZ/RCyi6f79dT30Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89402890"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89402890"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 12:43:51 -0700
X-CSE-ConnectionGUID: /D58CptvRWislmqj3SNDDA==
X-CSE-MsgGUID: sdW1GR5FR0mva4w6Y0TxdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="295206760"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.222.113])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 12:43:49 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v8 1/6] perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()
Date: Thu, 10 Sep 2026 14:43:19 -0500
Message-ID: <20260910194324.98002-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910194324.98002-1-thomas.falcon@intel.com>
References: <20260910194324.98002-1-thomas.falcon@intel.com>
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
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.43.0

