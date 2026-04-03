Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6683D4118;
	Fri,  3 Apr 2026 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237395; cv=none; b=K+LXcjKEi4GACoXD9rX1MmCz8H8qKEGkNe5XQHjT3VHDBFwgsrl73l9S5bxeLM6cTNCjh+K1LTdaFFFQKyOcEmh6sHhFGiWnMCOfdtgzlG5tEIMNLjkrNWvTrNf0JJ8E3xXLF66tuDqOqpWClB5SE1U7bt6aQgkJy7Z4crzaPMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237395; c=relaxed/simple;
	bh=ZqiaI5TC6Mi00iCyHh6CXLOYnMHz2HotHcd9ED7rnUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsJqjoieEvPqTFE8KOhyQ+A1F0RNZh2MxpUVJOC5j1C9g7Dt/ASkKG3s0LsuGRFwZlQJuMgXpUOGuHpYGiiLvUEhTm6XVH7fD1uPrp072Mi/8wULysWs0oY+/vu69WGthWEYJ1GmnuhPurV0usT1kfeK0MMc3uYPLYyttIYos7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWFYzcBj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWFYzcBj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775237394; x=1806773394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZqiaI5TC6Mi00iCyHh6CXLOYnMHz2HotHcd9ED7rnUQ=;
  b=IWFYzcBjNvSOA90245oerjgss0S27Ld1+iQvLPFuxKYSbyTXVZy90Xkg
   xRnb1ZKgq4UyBgNOZn8WHbms3kjXCVvGey11mOmdcps8irDB7waMxmigv
   volNZ4TZB1a0aQgNJWgAQscj7LWUKFEeRbGmsg/Dod8AkbBHlrjepavrY
   HH86zdVZuoNNXpBlftImpEW0F1eJztT3LTjlmuFtEmnK1lbX1myYOqqkl
   +x81E8+7rnj6ldDy0bIjZ91MEMDtIQudato3y95hbYG0I5lgqpkXsKTjU
   CDH3aDD0MZVA7j3Yqn5xTts6LSZe3gBcl4NYzwhqt51BGOHBNXOo6FXl5
   w==;
X-CSE-ConnectionGUID: Mgy9Bd+eQKuGUU5p9Cje3g==
X-CSE-MsgGUID: OT6GcsSdTKK5acH7VYGFXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="93693326"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="93693326"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 10:29:53 -0700
X-CSE-ConnectionGUID: VShfKu/pRduFuvxNqHVcow==
X-CSE-MsgGUID: iWGqVyADScK4Avv+K1R1aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="250525266"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 10:29:52 -0700
From: Zide Chen <zide.chen@intel.com>
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Steve Wahl <steve.wahl@hpe.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH V7 4/4] perf/x86/intel/uncore: Remove extra double quote mark
Date: Fri,  3 Apr 2026 10:21:46 -0700
Message-ID: <20260403172146.158172-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403172146.158172-1-zide.chen@intel.com>
References: <20260403172146.158172-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The third argument in INTEL_UNCORE_FR_EVENT_DESC() is subject to
__stringify(), and the extra double quote marks can result in the
expansion "3.814697266e-6" in the sysfs knobs, instead of
3.814697266e-6.

This is incorrect, though it may still work for perf, e.g.
perf stat -e uncore_iio_free_running_0/bw_in_port0/

Fixes: d8987048f665 ("perf/x86/intel/uncore: Support IIO free-running counters on DMR")
Reported-by: Chun-Tse Shao <ctshao@google.com>
Closes: https://lore.kernel.org/all/20251231224233.113839-1-zide.chen@intel.com/
Reviewed-by: Chun-Tse Shao <ctshao@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2: Add Reviewed-by tags.
---
 arch/x86/events/intel/uncore_snbep.c | 48 ++++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 742f8cb2eac5..2a4bf2ae4050 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6930,34 +6930,34 @@ static struct freerunning_counters dmr_iio_freerunning[] = {
 
 static struct uncore_event_desc dmr_uncore_iio_freerunning_events[] = {
 	/*  ITC Free Running Data BW counter for inbound traffic */
-	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port0, 0x10, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port1, 0x11, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port2, 0x12, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port3, 0x13, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port4, 0x14, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port5, 0x15, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port6, 0x16, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port7, 0x17, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port0, 0x10, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port1, 0x11, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port2, 0x12, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port3, 0x13, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port4, 0x14, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port5, 0x15, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port6, 0x16, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port7, 0x17, 3.814697266e-6),
 
 	/*  ITC Free Running BW IN counters */
-	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0, 0x20, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1, 0x21, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2, 0x22, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3, 0x23, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port4, 0x24, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port5, 0x25, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port6, 0x26, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port7, 0x27, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0, 0x20, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1, 0x21, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2, 0x22, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3, 0x23, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port4, 0x24, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port5, 0x25, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port6, 0x26, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port7, 0x27, 3.814697266e-6),
 
 	/*  ITC Free Running BW OUT counters */
-	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port0, 0x30, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port1, 0x31, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port2, 0x32, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port3, 0x33, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port4, 0x34, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port5, 0x35, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port6, 0x36, "3.814697266e-6"),
-	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port7, 0x37, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port0, 0x30, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port1, 0x31, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port2, 0x32, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port3, 0x33, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port4, 0x34, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port5, 0x35, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port6, 0x36, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port7, 0x37, 3.814697266e-6),
 
 	/* Free Running Clock Counter */
 	INTEL_UNCORE_EVENT_DESC(clockticks, "event=0xff,umask=0x40"),
-- 
2.53.0

