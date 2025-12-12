Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C8030FC0E;
	Fri, 12 Dec 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573644; cv=none; b=sOdPDVjGlsHHgDPWBt8OtrpgnYM9OAzHfiReOxxGc5/iDRvXwoF9N8yLQo2j492gLhih2WaymBf6+9USWWq2dM2noC8uQRpNyecPMTbSI458o0rUkhpeMWosrIdF7Wug2otjWb+oBLCXdRYposx/TEDWib8O6PUI1fHp92q3RbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573644; c=relaxed/simple;
	bh=P6fYzZhyP5EAs+fXNaxFNZYzIrUJ0Y7i5+/OhRwtbPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3zqkW2Rm/J66v00QN/BtXdKLJowfVOaNobsyyvQ+4YXli03/RBRZnA4e5hcoB34SEoSUD8kxF6ieEa028zkGHs6Fwsq2wmlyf/rhz+VDb/GR980rMAEKVOUuk6yWq4wj54m3ZzNHBinp6Fngch8FGQ4hoOU+pKkxnx8EguGnF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBOsFYTO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBOsFYTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765573643; x=1797109643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P6fYzZhyP5EAs+fXNaxFNZYzIrUJ0Y7i5+/OhRwtbPE=;
  b=gBOsFYTOSnm7J3hT4QzH9uDrFjmjHzcpolYSRg6HMPB8zuxtAW5d79is
   9zqvRv29JFsclmNDW9Pla0hsn4bocWbduKNMYI4LMP/L1cdt1t33OqyYT
   KF8uWQZQ8bg3lkT/YdFvXIzrO9WVSEC8/0Oh9iy0jZK8tvAaM6cF76PN+
   ragmRiHYJaGbjtoRvDIg2+vlvW28xnwuCto6a07HQ2xlx1VWkQKrR8vOB
   CP7Pqa9eJp9A9TV6bQjDPlMBJtbp1Ti6GNQxct4Q0kOiQV3DIS4ttiCGY
   o/tq9vfqC8j8b0lYY/Putd34Z1BnxPDY/KAvLCI5hXYDsXMs6f8sMzop7
   g==;
X-CSE-ConnectionGUID: wlygf5ExS6KqX8p8pL4RaA==
X-CSE-MsgGUID: BIPrk5kPQf+uRuSpn3B3uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="67333588"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="67333588"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 13:07:17 -0800
X-CSE-ConnectionGUID: fOUOqBwpSjinV8FipJEdRw==
X-CSE-MsgGUID: qeN/eEAbTCOS8XOZ44VN2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="202269528"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 13:07:16 -0800
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
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>
Subject: [PATCH 4/7] perf/x86/intel/uncore: Add freerunning event descriptor helper macro
Date: Fri, 12 Dec 2025 13:00:04 -0800
Message-ID: <20251212210007.13986-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212210007.13986-1-zide.chen@intel.com>
References: <20251212210007.13986-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Freerunning counter events are repetitive: the event code is fixed to
0xff, the unit is always "MiB", and the scale is identical across all
counters on a given PMON unit.

Introduce a new helper macro, INTEL_UNCORE_FR_EVENT_DESC(), to populate
the event, scale, and unit descriptor triplet. This reduces duplicated
lines and improves readability.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 95 ++++++++--------------------
 1 file changed, 28 insertions(+), 67 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index bd1569876640..56c6ac86f28e 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4068,34 +4068,24 @@ static struct freerunning_counters skx_iio_freerunning[] = {
 	[SKX_IIO_MSR_UTIL]	= { 0xb08, 0x1, 0x10, 8, 36 },
 };
 
+#define INTEL_UNCORE_FR_EVENT_DESC(name, umask, scl)		\
+	INTEL_UNCORE_EVENT_DESC(name,				\
+		"event=0xff,umask=" __stringify(umask)),	\
+	INTEL_UNCORE_EVENT_DESC(name.scale, __stringify(scl)),	\
+	INTEL_UNCORE_EVENT_DESC(name.unit, "MiB")
+
 static struct uncore_event_desc skx_uncore_iio_freerunning_events[] = {
 	/* Free-Running IO CLOCKS Counter */
 	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
 	/* Free-Running IIO BANDWIDTH Counters */
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port0,		"event=0xff,umask=0x24"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port0.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port0.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port1,		"event=0xff,umask=0x25"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port1.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port1.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port2,		"event=0xff,umask=0x26"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port2.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port2.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port3,		"event=0xff,umask=0x27"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port3.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port3.unit,	"MiB"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0, 0x20, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1, 0x21, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2, 0x22, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3, 0x23, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port0, 0x24, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port1, 0x25, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port2, 0x26, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port3, 0x27, 3.814697266e-6),
 	/* Free-running IIO UTILIZATION Counters */
 	INTEL_UNCORE_EVENT_DESC(util_in_port0,		"event=0xff,umask=0x30"),
 	INTEL_UNCORE_EVENT_DESC(util_out_port0,		"event=0xff,umask=0x31"),
@@ -4910,30 +4900,14 @@ static struct uncore_event_desc snr_uncore_iio_freerunning_events[] = {
 	/* Free-Running IIO CLOCKS Counter */
 	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
 	/* Free-Running IIO BANDWIDTH IN Counters */
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0, 0x20, 3.0517578125e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1, 0x21, 3.0517578125e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2, 0x22, 3.0517578125e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3, 0x23, 3.0517578125e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port4, 0x24, 3.0517578125e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port5, 0x25, 3.0517578125e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port6, 0x26, 3.0517578125e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port7, 0x27, 3.0517578125e-5),
 	{ /* end: all zeroes */ },
 };
 
@@ -5266,12 +5240,8 @@ static struct freerunning_counters snr_imc_freerunning[] = {
 static struct uncore_event_desc snr_uncore_imc_freerunning_events[] = {
 	INTEL_UNCORE_EVENT_DESC(dclk,		"event=0xff,umask=0x10"),
 
-	INTEL_UNCORE_EVENT_DESC(read,		"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(read.scale,	"6.103515625e-5"),
-	INTEL_UNCORE_EVENT_DESC(read.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(write,		"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(write.scale,	"6.103515625e-5"),
-	INTEL_UNCORE_EVENT_DESC(write.unit,	"MiB"),
+	INTEL_UNCORE_FR_EVENT_DESC(read, 0x20, 6.103515625e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(write, 0x21, 6.103515625e-5),
 	{ /* end: all zeroes */ },
 };
 
@@ -5836,19 +5806,10 @@ static struct freerunning_counters icx_imc_freerunning[] = {
 static struct uncore_event_desc icx_uncore_imc_freerunning_events[] = {
 	INTEL_UNCORE_EVENT_DESC(dclk,			"event=0xff,umask=0x10"),
 
-	INTEL_UNCORE_EVENT_DESC(read,			"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(read.scale,		"6.103515625e-5"),
-	INTEL_UNCORE_EVENT_DESC(read.unit,		"MiB"),
-	INTEL_UNCORE_EVENT_DESC(write,			"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(write.scale,		"6.103515625e-5"),
-	INTEL_UNCORE_EVENT_DESC(write.unit,		"MiB"),
-
-	INTEL_UNCORE_EVENT_DESC(ddrt_read,		"event=0xff,umask=0x30"),
-	INTEL_UNCORE_EVENT_DESC(ddrt_read.scale,	"6.103515625e-5"),
-	INTEL_UNCORE_EVENT_DESC(ddrt_read.unit,		"MiB"),
-	INTEL_UNCORE_EVENT_DESC(ddrt_write,		"event=0xff,umask=0x31"),
-	INTEL_UNCORE_EVENT_DESC(ddrt_write.scale,	"6.103515625e-5"),
-	INTEL_UNCORE_EVENT_DESC(ddrt_write.unit,	"MiB"),
+	INTEL_UNCORE_FR_EVENT_DESC(read, 0x20, 6.103515625e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(write, 0x21, 6.103515625e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(ddrt_read, 0x30, 6.103515625e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(ddrt_write, 0x31, 6.103515625e-5),
 	{ /* end: all zeroes */ },
 };
 
-- 
2.52.0

