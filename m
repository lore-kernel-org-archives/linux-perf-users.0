Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40330FC20;
	Wed, 31 Dec 2025 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221387; cv=none; b=lL4PfRUE3lTp5NwVS5Cy8KSIZQpYDLnSA62Z4xdScQGDwnr/Xy6gAZhi1yp6bwur1Wm3DoUbEprxuZibSKGD35Asbb3qfA9W8CminVuN32+AozPwkMAEMuB8oCDbS78cFo0bKB/Gl+CjUR3pQdedZiyH18AzRJfJJiRr+mC3VNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221387; c=relaxed/simple;
	bh=eteop7kz+iqnqy0j+9ut2VtapxJjHxmmKe3PzLV0qBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3ceK7mflZCUUfEsnr6lvrrwzMdjwFCgX364DxofDuVUFFQjk5w4e8F3AOBljbPbiNbkohoaheIRgpJ8z22DSQ0atKQXDjeT2r0KJOx6efAWXLoRL854CF0+eNff9TRUWCeIU74iSKip8PmRGhV48VigOsf9A0C4whw+3Yu6CVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ry6GwaGq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ry6GwaGq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767221385; x=1798757385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eteop7kz+iqnqy0j+9ut2VtapxJjHxmmKe3PzLV0qBk=;
  b=Ry6GwaGqSuMzyeesrxd/8my4EDgO233TqYTwX6AWr54xJLAzqlaRMuiK
   37uvxKG6SEuPkcKTHbGoDRHRIDkxwVbPiF4Cx2a54XZpmM2R/5CsLzkrM
   w3kB/Y+tIQdeBv9kze2bIkmWjnCFZhfFe37y8Zo383qlx3ZIPuNxvvbVz
   bGkdXkkNb/EUjTDAdzBszO5ogv9tBpPwpqTpQRQbB39+1dGLXqM8409vE
   Qe7nYN3RhUPJMcmXv9HTvLVkF+2tradSBT7NBh3G9ax+3OSI9QYvZ/EVq
   MuRyzU8/a+5BrVATXmolDKQ1vYHDZZp7eWv1+kA6tk3Y/MDSqp1TrfZVK
   Q==;
X-CSE-ConnectionGUID: 9H1Sf/rCRxiFpEyWXhCWvA==
X-CSE-MsgGUID: LZmaXvhQQoe72cFG2cZKMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68816644"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="68816644"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:42 -0800
X-CSE-ConnectionGUID: NscidoXJQhyXF+plCApjuA==
X-CSE-MsgGUID: luhGdI8ISwC6EC3SNCQGaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="232611028"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:41 -0800
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
Subject: [PATCH V2 09/13] perf/x86/intel/uncore: Support uncore constraint ranges
Date: Wed, 31 Dec 2025 14:42:26 -0800
Message-ID: <20251231224233.113839-10-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251231224233.113839-1-zide.chen@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add UNCORE_EVENT_CONSTRAINT_RANGE macro for uncore constraints,
similar to INTEL_EVENT_CONSTRAINT_RANGE, to reduce duplication when
defining consecutive uncore event constraints.

No functional change intended.

Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2: new patch

 arch/x86/events/intel/uncore.c       |   2 +-
 arch/x86/events/intel/uncore.h       |   2 +
 arch/x86/events/intel/uncore_snbep.c | 183 ++++++---------------------
 3 files changed, 44 insertions(+), 143 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 080b6870a88d..54b3c1e3af32 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -436,7 +436,7 @@ uncore_get_event_constraint(struct intel_uncore_box *box, struct perf_event *eve
 
 	if (type->constraints) {
 		for_each_event_constraint(c, type->constraints) {
-			if ((event->hw.config & c->cmask) == c->code)
+			if (constraint_match(c, event->hw.config))
 				return c;
 		}
 	}
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 55e3aebf4b5e..564cb26c4468 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -33,6 +33,8 @@
 #define UNCORE_EXTRA_PCI_DEV_MAX	4
 
 #define UNCORE_EVENT_CONSTRAINT(c, n) EVENT_CONSTRAINT(c, n, 0xff)
+#define UNCORE_EVENT_CONSTRAINT_RANGE(c, e, n)			\
+		EVENT_CONSTRAINT_RANGE(c, e, n, 0xff)
 
 #define UNCORE_IGNORE_END		-1
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 28bcccf5cdfe..fac2be780276 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -836,76 +836,37 @@ static struct intel_uncore_ops snbep_uncore_pci_ops = {
 static struct event_constraint snbep_uncore_cbox_constraints[] = {
 	UNCORE_EVENT_CONSTRAINT(0x01, 0x1),
 	UNCORE_EVENT_CONSTRAINT(0x02, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x04, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x05, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x04, 0x5, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x07, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x09, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x11, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x12, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x13, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x1b, 0xc),
-	UNCORE_EVENT_CONSTRAINT(0x1c, 0xc),
-	UNCORE_EVENT_CONSTRAINT(0x1d, 0xc),
-	UNCORE_EVENT_CONSTRAINT(0x1e, 0xc),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x12, 0x13, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x1b, 0x1e, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0x1f, 0xe),
 	UNCORE_EVENT_CONSTRAINT(0x21, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x31, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x35, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x31, 0x35, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x36, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x37, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x38, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x39, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x37, 0x39, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x3b, 0x1),
 	EVENT_CONSTRAINT_END
 };
 
 static struct event_constraint snbep_uncore_r2pcie_constraints[] = {
-	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x11, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x12, 0x1),
 	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x24, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x25, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x24, 0x26, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x32, 0x34, 0x3),
 	EVENT_CONSTRAINT_END
 };
 
 static struct event_constraint snbep_uncore_r3qpi_constraints[] = {
-	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x12, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x12, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x13, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x20, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x21, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x22, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x24, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x25, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x29, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2a, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2b, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2e, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2f, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x30, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x31, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x36, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x37, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x38, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x39, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x20, 0x26, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x28, 0x34, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x36, 0x39, 0x3),
 	EVENT_CONSTRAINT_END
 };
 
@@ -3034,24 +2995,15 @@ static struct intel_uncore_type hswep_uncore_qpi = {
 };
 
 static struct event_constraint hswep_uncore_r2pcie_constraints[] = {
-	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x11, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x13, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x23, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x24, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x25, 0x1),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x23, 0x25, 0x1),
 	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x27, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x29, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x28, 0x29, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x2a, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x2b, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x35, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x2b, 0x2d, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x32, 0x35, 0x3),
 	EVENT_CONSTRAINT_END
 };
 
@@ -3066,38 +3018,17 @@ static struct intel_uncore_type hswep_uncore_r2pcie = {
 
 static struct event_constraint hswep_uncore_r3qpi_constraints[] = {
 	UNCORE_EVENT_CONSTRAINT(0x01, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x07, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x08, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x09, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x0a, 0x7),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x7, 0x0a, 0x7),
 	UNCORE_EVENT_CONSTRAINT(0x0e, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x12, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x12, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x13, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x14, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x15, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x1f, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x20, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x21, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x22, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x25, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x29, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2e, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2f, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x31, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x36, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x37, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x38, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x39, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x14, 0x15, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x1f, 0x23, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x25, 0x26, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x28, 0x29, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x2c, 0x2f, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x31, 0x34, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x36, 0x39, 0x3),
 	EVENT_CONSTRAINT_END
 };
 
@@ -3371,8 +3302,7 @@ static struct event_constraint bdx_uncore_r2pcie_constraints[] = {
 	UNCORE_EVENT_CONSTRAINT(0x25, 0x1),
 	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x2c, 0x2d, 0x3),
 	EVENT_CONSTRAINT_END
 };
 
@@ -3387,35 +3317,18 @@ static struct intel_uncore_type bdx_uncore_r2pcie = {
 
 static struct event_constraint bdx_uncore_r3qpi_constraints[] = {
 	UNCORE_EVENT_CONSTRAINT(0x01, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x07, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x08, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x09, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x0a, 0x7),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x07, 0x0a, 0x7),
 	UNCORE_EVENT_CONSTRAINT(0x0e, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x11, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x13, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x14, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x15, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x1f, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x20, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x21, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x22, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x14, 0x15, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x1f, 0x23, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x25, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x29, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2e, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2f, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x36, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x37, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x38, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x39, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x28, 0x29, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x2c, 0x2f, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x33, 0x34, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x36, 0x39, 0x3),
 	EVENT_CONSTRAINT_END
 };
 
@@ -3722,8 +3635,7 @@ static struct event_constraint skx_uncore_iio_constraints[] = {
 	UNCORE_EVENT_CONSTRAINT(0x95, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0xc0, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0xc5, 0xc),
-	UNCORE_EVENT_CONSTRAINT(0xd4, 0xc),
-	UNCORE_EVENT_CONSTRAINT(0xd5, 0xc),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0xd4, 0xd5, 0xc),
 	EVENT_CONSTRAINT_END
 };
 
@@ -4479,14 +4391,9 @@ static struct intel_uncore_type skx_uncore_m2pcie = {
 };
 
 static struct event_constraint skx_uncore_m3upi_constraints[] = {
-	UNCORE_EVENT_CONSTRAINT(0x1d, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x1e, 0x1),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x1d, 0x1e, 0x1),
 	UNCORE_EVENT_CONSTRAINT(0x40, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x4e, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x4f, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x50, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x51, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x52, 0x7),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x4e, 0x52, 0x7),
 	EVENT_CONSTRAINT_END
 };
 
@@ -5652,14 +5559,9 @@ static struct intel_uncore_type icx_uncore_upi = {
 };
 
 static struct event_constraint icx_uncore_m3upi_constraints[] = {
-	UNCORE_EVENT_CONSTRAINT(0x1c, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x1d, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x1e, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x1f, 0x1),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x1c, 0x1f, 0x1),
 	UNCORE_EVENT_CONSTRAINT(0x40, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x4e, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x4f, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x50, 0x7),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x4e, 0x50, 0x7),
 	EVENT_CONSTRAINT_END
 };
 
@@ -6142,10 +6044,7 @@ static struct intel_uncore_ops spr_uncore_mmio_offs8_ops = {
 static struct event_constraint spr_uncore_cxlcm_constraints[] = {
 	UNCORE_EVENT_CONSTRAINT(0x02, 0x0f),
 	UNCORE_EVENT_CONSTRAINT(0x05, 0x0f),
-	UNCORE_EVENT_CONSTRAINT(0x40, 0xf0),
-	UNCORE_EVENT_CONSTRAINT(0x41, 0xf0),
-	UNCORE_EVENT_CONSTRAINT(0x42, 0xf0),
-	UNCORE_EVENT_CONSTRAINT(0x43, 0xf0),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x40, 0x43, 0xf0),
 	UNCORE_EVENT_CONSTRAINT(0x4b, 0xf0),
 	UNCORE_EVENT_CONSTRAINT(0x52, 0xf0),
 	EVENT_CONSTRAINT_END
-- 
2.52.0

