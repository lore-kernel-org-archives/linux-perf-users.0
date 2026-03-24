Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD31C3B5825;
	Tue, 24 Mar 2026 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389501; cv=none; b=Zv2pafMoHIaBqv4sDN/i//oLVpk8pYTH8qEis7U8IdsczZc9hK76ZKHV8T+NFhm1LRR6VzI0iOrgTEH4YMsbYNUkHloU9AW5k2UYKToNdGUQldAbkTU5WVv7yQV1YXyIx7y41aCFd0mn7FC1GDTtHZBlh2VmNqwfUH/JOAk+ThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389501; c=relaxed/simple;
	bh=2YjUCinYPQZs22HlwqHgyrz1SfFbrS3x38+UlftDJE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azl4g0udhGL9mSFbVX+2jIEBb/Ji2i4EisLTzaFMHIfucY6SuPL/4qRAwTYaqPaw93+wV6VFveW/XXuS0Vtnq4qhTX8mqQcWDZ/EV83XWB+zqir6bBS2YoDJZjO2fxShcx13Xhc3RXyXxHqKYDydCnmYdeW+YH0dzJeTs5Kpeak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mom9hg8h; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mom9hg8h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774389500; x=1805925500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2YjUCinYPQZs22HlwqHgyrz1SfFbrS3x38+UlftDJE0=;
  b=Mom9hg8h0ynJIH9Zh7TiOV71WBBZWZtz9w8R8aLfnHXPYniOssFQQo8a
   APLg1EeyCcMzmSdFjesssqxj6NL+9rQvRu+lUZpJOEqRGkywOZkfIYITk
   1j6hNrwLL12ScUOoj0T0lBu6kBFMWGLhAKiJl7Rymgjq9UN9YvuksNGDq
   TplA3gC6Xtuh+x0TI1Coxc+M2deByTk511HubyS0H9IbBFmS/rjXl02YN
   7ZBr3ZfCOoHLwRMhB05ijABeY5W1mmDPEepxmzsDhfAzFzDKwqTxxnAyt
   vvMNsVn6BMMvFuFe6BFAvCDlqvBvH8gMQAZG1ZHhlTefwTCOvEWEXjzxm
   g==;
X-CSE-ConnectionGUID: 8Ulb0hQyQ5GUMKehW+wJUA==
X-CSE-MsgGUID: QrW04dSaR42RzWqMcHeBGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="100866114"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="100866114"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 14:58:19 -0700
X-CSE-ConnectionGUID: j2Xty3H0QiSf7NBc5i3fFw==
X-CSE-MsgGUID: MUeBepRdQvOhb8JOxBrA7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="224496731"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 14:58:19 -0700
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
Subject: [PATCH V5 4/4] perf/x86/intel/uncore: Remove extra double quote mark
Date: Tue, 24 Mar 2026 14:49:32 -0700
Message-ID: <20260324214932.10068-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324214932.10068-1-zide.chen@intel.com>
References: <20260324214932.10068-1-zide.chen@intel.com>
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
V2: Added Reviewed-by tags.
---
 arch/x86/events/intel/uncore_snbep.c | 48 ++++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 5ef205a70559..526e995c63da 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6960,34 +6960,34 @@ static struct freerunning_counters dmr_iio_freerunning[] = {
 
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

