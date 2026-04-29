Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD812DFA3A;
	Wed, 29 Apr 2026 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476567; cv=none; b=fArmOZEUfyfJ6qut4bY+VZp54tyCebAluGC4UtFBrKzsl2V9xPENjS/FPPJRgNLlNxFMk5tFky18xHhX478mM6MuOb6b3xYwkCYIFIkp/Ht65iNid85i+25rAyK9QjBOf2VV3pZ7zRJm0CtMbUrp0cNITCdKdoHFWWzhPOcXnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476567; c=relaxed/simple;
	bh=rYkMWxM3YUTZEhCX/r9k1ofUbqVQcZYrVCMNOFuBcqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWozLutf4hrOlgJqSJvpjhbxXQsYNoYJbuh9TqYZ4UQeMn7G/JD+vMY4xV91TKhiilOK+X4k2CoSriSoGhfptBeJY3xCJyXH0bqwRgVKJ3y1I6zrfa1V/PnvULFjQEMbmA6Ch0NQZZfcTNzd/H5iOe7ZVwWZxXlqzzTd1IcgaB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlSQhCDu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlSQhCDu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777476566; x=1809012566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rYkMWxM3YUTZEhCX/r9k1ofUbqVQcZYrVCMNOFuBcqA=;
  b=BlSQhCDuj4jZzZEhqm72kUVpP32yR+Acs9GkfpROn2ocGmFm43Qa8Ixs
   29M2NYP6mqa3eO6G952H6rmN6KuBPhOLldu2n/OKJd9gjd9ZmVNBE7DdP
   D9hIGi7/pmYwq8Fcb9CljhyllTThfqpfOCOufKVwBykEDT32U8a/eo6YF
   tjCSljmdR5AZhflosIpI+nZSagOXgLhRGVyEVPjyAxoDmFKsgsLJqkZUp
   2mVe2AxI9w4c+lbyjlwa00dXKsSBC4uB7BWLJ9+qf8k9DlqxNL9VERcs9
   lEV+weth04coVwG2NdcnfPESsHFxdTKvfGl1ywKhOxhQCEcqdG/22kl01
   Q==;
X-CSE-ConnectionGUID: 3RG+anH+SO+pWBvazAdDDA==
X-CSE-MsgGUID: 46VXOcy0S/e8c+rU/qMOXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="65937595"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="65937595"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 08:29:24 -0700
X-CSE-ConnectionGUID: cYUafVc7QK6/W6tcFFDx0g==
X-CSE-MsgGUID: KiPDKPzNRZ+xqdeihT8MoQ==
X-ExtLoop1: 1
Received: from iherna2-mobl4.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.221.251])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 08:29:24 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 1/2 v2] perf script: Fix missing '+' indicator when branch counter reaches upper limit
Date: Wed, 29 Apr 2026 10:29:16 -0500
Message-ID: <20260429152917.178803-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429152917.178803-1-thomas.falcon@intel.com>
References: <20260429152917.178803-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

When displaying branch counter (br_cntr) information, a "+"
suffix represents that event occurrences may have been lost
due to branch counter saturation. However, this indicator was
missing in perf script. Add it back.

Before:

 # Branch counter abbr list:
 # cpu_core/event=0xc4,umask=0x20/ppp = A
 # cpu_core/instructions/ = B
 # cpu_core/MEM_INST_RETIRED.ALL_LOADS/ = C
 # cpu_core/MEM_LOAD_RETIRED.L2_MISS/ = D
 # '-' No event occurs
 # '+' Event occurrences may be lost due to branch counter saturated
...
        datasym+190:
        00005567f9951676        jz 0x5567f995162dr_cntr: BBBC   # PRED 1 cycles [1]
...
After:
...
        datasym+190:
        00005567f9951676        jz 0x5567f995162dr_cntr: BBB+C  # PRED 1 cycles [1]
...

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/builtin-script.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c8ac9f01a36b..f865c8b2f95f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1287,8 +1287,12 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 			if (!verbose) {
 				for (j = 0; j < num; j++)
 					printed += fprintf(fp, "%s", pos->abbr_name);
-			} else
-				printed += fprintf(fp, "%s %d ", pos->name, num);
+				if (num == mask)
+					printed += fprintf(fp, "+");
+			} else {
+				printed += fprintf(fp, "%s %d%s", pos->name,
+						   num, num == mask ? "+ " : " ");
+			}
 		}
 		if (numprinted == 0 && !verbose)
 			printed += fprintf(fp, "-");
-- 
2.43.0

