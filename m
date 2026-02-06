Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F131A9F82;
	Fri,  6 Feb 2026 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770419977; cv=none; b=jxUX7C89aFh2TK38WiBCpWQwrL6DNcd+ghixrntm3Ph+mjvpfevmV+F9ZTsReJ7ivHhH9NbCrWBMYNN/E0HNnTpiX4KTdGjihdbLZVdU/rlZ3Z+1hTfIEjJgh6pwvt2z+tFOyaU5L3pI8eC4QWMPUTwyVr6Zh2qD2thKr1xh7Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770419977; c=relaxed/simple;
	bh=UAXe+oAmfwT2hlk9+h7kME8BXPRnaQmQJ8QR0F/Zw/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VuaYkqq5oJDDEbFu8UqLPltDlmBWPR6aBCe215H2+vgX9N0mFjIZoBj1MSYHISTelDkr086d5oLV1zVwFocVOH3nne0LdUyEmR/SsDnf3AYsvA4GnYpCESwB8zOOy6qzGhXXc7kevhyU7zVrs+ZITh57aasvq7qjEOtfxcZMsG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEO7011/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEO7011/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770419977; x=1801955977;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UAXe+oAmfwT2hlk9+h7kME8BXPRnaQmQJ8QR0F/Zw/c=;
  b=dEO7011/NEvqh43n8q9GyEOYs0ve9x4lko4zs6eXJ5EuZXROVJjIdZWD
   bu8aqCmo33Wqkv1kKvrxse7cFPUtao6yg0sw34S/KgO6R+VU1AnVasx48
   aVbYrWZU0XP6TW1nw9CsXi2Gdat0asblzKARc1O+qAz8N8RNJXvRhUDw+
   PbQ7KLqJjcG/M4yr29aHmb05jmlZEppH+WzGRKddmtJ6DSeNeNCIYWMpD
   Oc6vcBytf5gvIHrZZRedZcbRRUUAOt5iY7sdQvqdkaArMIOgHsSYXDTqT
   gROMPSNpJN7wb0Dz9vA9Il3R+tQ88511S1m6tbznJY/qW5NHt9k0r7E7z
   A==;
X-CSE-ConnectionGUID: LQ2ngjlJTKSpqS5O/Xvm9A==
X-CSE-MsgGUID: KvTmKaOFQeuzwJXvBmMEnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="81951307"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="81951307"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 15:19:37 -0800
X-CSE-ConnectionGUID: 4OIpGuBbTuazqn4glp6u9g==
X-CSE-MsgGUID: 45jB+ryASy2+meDwMjqwJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="233950844"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 15:19:36 -0800
From: Zide Chen <zide.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Chun-Tse Shao <ctshao@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Remove extra double quote mark
Date: Fri,  6 Feb 2026 15:12:03 -0800
Message-ID: <20260206231203.11760-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
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
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 48 ++++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 7ca0429c4004..3b6b4bd4793a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6909,34 +6909,34 @@ static struct freerunning_counters dmr_iio_freerunning[] = {
 
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
2.52.0

