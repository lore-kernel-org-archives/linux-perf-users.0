Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB280132126;
	Tue, 25 Jun 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312350; cv=none; b=ir6WoboJjhF1VTz7mfOcsgFatAeeLhyoJeMUHE8YfVclD1ehNlJH7K5E/YfuwW1lrZsQcmLWXaYN50dh6JgQ8FIlQ5kgV7kQ4pUFMcEbuKot/erd0jQoY4T8qZVJps1hssoMkIaYMEn8MJipg2zQMKM0cqmMScHA8878K3G8Mq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312350; c=relaxed/simple;
	bh=G8QxWB1NdVdD4pGzcfhDvWb2phCcho50XrZJdGK2PxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZxYmajNWY8edDDrkBlfkzjv8EjX66ncAPB4Qrz46OhAFTHMxMRvlhY6I2TKSZqCv0860YdCei4DGvCK/YZCtqmtevK4ZdWCJJ0s2ji74MjkwjU0UZaP162+t6BiN1cdVPFR9IbU+DO5ekbU63+sD21fF/mUk+l9CexzudlnCxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAkq3kmA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAkq3kmA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719312348; x=1750848348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G8QxWB1NdVdD4pGzcfhDvWb2phCcho50XrZJdGK2PxU=;
  b=BAkq3kmAYorfEQCf+CrEc4JA0dpWzj5pfN2FfRG9yL2c98UInmccvRLl
   7oH+swkp5Io54Hgjc+UdmxvjJR4DYu7A28sSJZG4J1mOyyK5wKXyhfyyC
   8QCQw/KwFkVP1QqXC7vvApN3JrbAb8J9PESzYcLvf6F8XE9PS8yiVkxGl
   WyDLdxhT1136N3/MTs+byjfWcfICVLlaYKPE/CsCR7jLtRhS741mcuY3Z
   7NIfiTfqhOE2yvfM5/OVvegj/2N2VP6woW1797ZvisR4PkPNTY2Q5kRBc
   YZsgxt0LHk66QkPNu1OwlfMQUrDOZW+6zBMhHMZIqntVAcXi6T+hL6Anv
   g==;
X-CSE-ConnectionGUID: wpjp2rlHSySfqbiAruXn+w==
X-CSE-MsgGUID: dr0tM9ToTlWpTtAG5ZFBbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="26944148"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="26944148"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 03:45:48 -0700
X-CSE-ConnectionGUID: Ey+0fRT1TpOxHKdI1hRg/w==
X-CSE-MsgGUID: 5dVUBiZMQ9aTlQfduBsj4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43676515"
Received: from gcivario-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.48.191])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 03:45:46 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf intel-pt: Fix aux_watermark calculation for 64-bit size
Date: Tue, 25 Jun 2024 13:45:31 +0300
Message-Id: <20240625104532.11990-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625104532.11990-1-adrian.hunter@intel.com>
References: <20240625104532.11990-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

aux_watermark is a u32. For a 64-bit size, cap the aux_watermark
calculation at UINT_MAX instead of truncating it to 32-bits.

Fixes: 874fc35cdd55 ("perf intel-pt: Use aux_watermark")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 6de7e2d21075..c8fa15f280d2 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -758,7 +758,8 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	}
 
 	if (!opts->auxtrace_snapshot_mode && !opts->auxtrace_sample_mode) {
-		u32 aux_watermark = opts->auxtrace_mmap_pages * page_size / 4;
+		size_t aw = opts->auxtrace_mmap_pages * (size_t)page_size / 4;
+		u32 aux_watermark = aw > UINT_MAX ? UINT_MAX : aw;
 
 		intel_pt_evsel->core.attr.aux_watermark = aux_watermark;
 	}
-- 
2.34.1

