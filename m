Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF930EF89;
	Thu, 17 Sep 2026 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610403; cv=none; b=pO4/JtjV5ol3CajembuuSv4QnHSwbtiouISYJUNTCEnn+hmGkcLFtZx2/mQs0hoC08YiAsdJfYrkTigOwLmuZZ1aNdzsTEmhucgg4ywByori+vH2tLdVeehdY/knfPppqJvimbEFQD0xwb7wn/phj8FGXbX+tq9DVj1o6qq4V1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610403; c=relaxed/simple;
	bh=grGJaf92tfWkwNPgOOs4jkT7F2C4BUxnAzCQLsFQcCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oVYzF2xwDUqT2RMk3hYd2rF5ce21P5wSqweIJRv3ljoBrAPgVwk8a2rkQhFK3aljEZTp61vVz2jN/81bFzPz7dcw1Ucb5AN/1gXlmM0WzFyJISG67FPbKdP+ArudLENA+B0B32Chfy50ytcZN6/BmjJe/MpG0VarerdTU2NJKrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhEZSCNJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhEZSCNJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789610402; x=1821146402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=grGJaf92tfWkwNPgOOs4jkT7F2C4BUxnAzCQLsFQcCs=;
  b=MhEZSCNJefILyjUnG5b/+MJxeLkwvB5GPweakq/UNVQvoQeDW84b5zUs
   ZtzWMzaDDI82e25mw257wCWAN8UiUqTFSf/t37LZFmYt1xELKNrKt31cr
   qdm36gllmicRH1c0JLKtRf/uKYjO3fRVPA8il6meihVTeDqnMDS+/O1a3
   Sl+pmSoSJyAUrZ2H1fPMTiV1B3CqfNJMVuPZEZjseG3DCJqOqf4uXhJHn
   FFHo8uNYeuVjN2RefUIWaUV00Rx/RZscG7osGyFXXRKbKud/rtOKkrUHb
   LfZWcB+b2wGDkGzo9n3Q/TWurf1MmuAp7w0gepPrvyl8jS7+wnxAe2ptH
   Q==;
X-CSE-ConnectionGUID: zqxN4GpvQpi6uT/3NCYvlg==
X-CSE-MsgGUID: 94Kx6XyERcKsyzm59n0N1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107498581"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107498581"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 19:00:02 -0700
X-CSE-ConnectionGUID: pWREtAOCSsCkA/JhXcTf0g==
X-CSE-MsgGUID: iSvx+yrTSt+MclN4uIZ46Q==
X-ExtLoop1: 1
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2026 18:59:59 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 07/12] perf/x86/intel: Correct Panther cove data source snoop states
Date: Thu, 17 Sep 2026 09:52:29 +0800
Message-Id: <20260917015234.981153-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For Panthercove, the snoop states for the data source encodings
"Prefetch Promotion" and "Cross Core Prefetch Promotion" should be
SNOOP_NONE instead of SNOOP_MISS.

Correct the incorrect snooping states for Panther cove.

Fixes: d2bdcde9626c ("perf/x86/intel: Add support for PEBS memory auxiliary info field in DMR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7a67fb675b43..24ec9bc63d2d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -277,8 +277,8 @@ static u64 pnc_pebs_l2_hit_data_source[PNC_PEBS_DATA_SOURCE_MAX] = {
 	0,							/* 0x06: Reserved */
 	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, HIT),	/* 0x07: L2 Hit Snoop HIT */
 	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, HITM),	/* 0x08: L2 Hit Snoop Hit Modified */
-	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, MISS),	/* 0x09: Prefetch Promotion */
-	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, MISS),	/* 0x0a: Cross Core Prefetch Promotion */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, NONE),	/* 0x09: Prefetch Promotion */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, NONE),	/* 0x0a: Cross Core Prefetch Promotion */
 	0,							/* 0x0b: Reserved */
 	0,							/* 0x0c: Reserved */
 	0,							/* 0x0d: Reserved */
-- 
2.34.1

