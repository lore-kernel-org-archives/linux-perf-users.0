Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31A1A071E;
	Mon, 24 Jun 2024 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259883; cv=none; b=CN2MADT08XWsOdLSN4ANpxWlHljJNstWSmpuZq+0knN4J9v70rDGl4ktS2Jh3VH/6ECgISVOLQOF68EGfeHojvVGlFAHBWN/gm26ADmm9xDLddsA9+K+KN5lMcH9bnX3RWdRTtXo5WpWG08e5logK/4pqa0jiIcyxUq+TLAWQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259883; c=relaxed/simple;
	bh=uKouTBImw1g40BRrpkJYLNPwpqU8Bl63RT+V983HQ4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HpAoIq1gsVwVgEKMsgwtr7KnjFayX4WJXRhZ3mP5lGjcFdDZ6p5yIjF+JVDh38YYvQvd8aovvV6AHRSLkOHBoYskRyREALj2JJenGdp4ECbKKeewHPjm/0ypr7yIm2s+o8j0FNqRERC/espo8LXtWQXZMFj0MpCuotvskTBIao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKpdjz1B; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKpdjz1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719259881; x=1750795881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uKouTBImw1g40BRrpkJYLNPwpqU8Bl63RT+V983HQ4I=;
  b=lKpdjz1BHrT0MS/db/tT/FmuMhFAjE95OnO9XcxzE7tsceMJyKAhWEtG
   hcODSSZA1FIwWEwe90j+TG2XLhcdwd5DT7NOui4ldq1+xOkLi2GbthVGm
   L7eCOzJaIcd7KPbczsYnXrcCWzjtdRYeiwbzVP9Ox5YPkMvCl6+QuSozD
   1bJXZXEsYkfeAxmffdHOeezzizzaaBr9dlPt8PpLHemGSp8PsKU9qgarL
   l1/lYlfTjEnK3xb74qgLB3/Kv6F9WEB1IKfVOIy25nn8gHJkI+VBNq+AC
   wX5GuKd789BVjWkY1gKj5zuLWUGEqy/vCENwdj65UrgpKPJux5dROwJcW
   Q==;
X-CSE-ConnectionGUID: Te2CQJrhQNST4MRGezBYzw==
X-CSE-MsgGUID: EN/c+HQCQTOMdv9Ce+oLOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16127999"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16127999"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:20 -0700
X-CSE-ConnectionGUID: eIjSsg2aQNaOT9zZ4+g4ZQ==
X-CSE-MsgGUID: 6pDfilqaSNuY0Fc8HXm3Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43387275"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.249.84])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:16 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Marco Cavenati <cavenati.marco@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/7] perf/x86/intel/pt: Fix topa_entry base length
Date: Mon, 24 Jun 2024 23:10:55 +0300
Message-Id: <20240624201101.60186-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624201101.60186-1-adrian.hunter@intel.com>
References: <20240624201101.60186-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

From: Marco Cavenati <cavenati.marco@gmail.com>

topa_entry->base needs to store a pfn.  It obviously needs to be
large enough to store the largest possible x86 pfn which is
MAXPHYADDR-PAGE_SIZE (52-12).  So it is 4 bits too small.

Increase the size of topa_entry->base from 36 bits to 40 bits.

Note, systems where physical addresses can be 256TiB or more are affected.

[ Adrian: Amend commit message as suggested by Dave Hansen ]

Signed-off-by: Marco Cavenati <cavenati.marco@gmail.com>
Fixes: 52ca9ced3f70 ("perf/x86/intel/pt: Add Intel PT PMU driver")
Cc: stable@vger.kernel.org
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 96906a62aacd..f5e46c04c145 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -33,8 +33,8 @@ struct topa_entry {
 	u64	rsvd2	: 1;
 	u64	size	: 4;
 	u64	rsvd3	: 2;
-	u64	base	: 36;
-	u64	rsvd4	: 16;
+	u64	base	: 40;
+	u64	rsvd4	: 12;
 };
 
 /* TSC to Core Crystal Clock Ratio */
-- 
2.34.1

