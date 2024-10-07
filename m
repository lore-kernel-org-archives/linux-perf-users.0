Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFE213698F;
	Mon,  7 Oct 2024 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330504; cv=none; b=Liw3DUlczBdQKVeWtzWjh2zkSdmUNbaGNrL47p+eDqS2+Q0006meyVtVlk1R9UDVZ5kEr0gtnSAnRTzCdhfLXm+0y6vIN9mrQ5MBj0qDwmDc3XwPGds78ho00a5Ts5QsKxOYPljXlSVu1b3BBWxYKK4kXQmBR91RxJOI9388TwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330504; c=relaxed/simple;
	bh=pIvdBlYgJk8tbDAVbRoeD4mDhX8EElylJtVCPxX1lRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e07gycW0FpGCtkVZHB7h3lUlMepYn/4r+9Ha6jNUPfHEDLuCYpKJaNbC6s6e85IMJbfD72t84e4EnaAFZZyvFYoA+GrCmrOnIWccFHv+//cvUFZQ99KPCV+HC/Fq4UwH2JjRC9PY5GsFmoLf7eXsHDlwQtTluPv7CYR7ja8ZAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrrFZVaZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrrFZVaZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728330501; x=1759866501;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pIvdBlYgJk8tbDAVbRoeD4mDhX8EElylJtVCPxX1lRs=;
  b=NrrFZVaZEjGZufAwibQ27dPStnkR74UUPswVIjeGTMofdyZfDYs70fTA
   jzSOq/pRigSU409TEjEVDX4TujN9qoQwo6kQeVMStX2UlFKUjrCukyqiC
   sW0rwTddaaBuHa+g8S+s/f22Humr4RYPkMdJqleseFreGcOZ5dIgdcQyf
   1c0Mei64AgRheWm0gEkTlYTA858WdiZXLyhmA5kOsyBONEw54oYRAPOr5
   YROm4CRrZVpGtoZLxs3JwCB0DLzOG0wLzFCbYiqGoJXHfr4oELjdqsi7E
   WPIgc2pZI2ovLImh1iwuZgPjjvhN+nfN5hzaeq/JzOwj9XmEQfEKhkJpi
   Q==;
X-CSE-ConnectionGUID: HfIyDFzGR5S/W/EiBSyrsA==
X-CSE-MsgGUID: dLPgIn0KSs+zyfy1t/DkoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="44966782"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="44966782"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 12:48:18 -0700
X-CSE-ConnectionGUID: zKkMI6wsQ+ariVF/GLWS6g==
X-CSE-MsgGUID: ptZZFRBcQaGEpQCQ4X6XMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="106338791"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.222.53])
  by fmviesa001.fm.intel.com with ESMTP; 07 Oct 2024 12:48:17 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH] perf test x86: Fix typo in intel-pt-test
Date: Mon,  7 Oct 2024 14:47:58 -0500
Message-ID: <20241007194758.78659-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change function name "is_hydrid" to "is_hybrid".

Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/arch/x86/tests/intel-pt-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/tests/intel-pt-test.c b/tools/perf/arch/x86/tests/intel-pt-test.c
index 09d61fa736e3..b217ed67cd4e 100644
--- a/tools/perf/arch/x86/tests/intel-pt-test.c
+++ b/tools/perf/arch/x86/tests/intel-pt-test.c
@@ -375,7 +375,7 @@ static int get_pt_caps(int cpu, struct pt_caps *caps)
 	return 0;
 }
 
-static bool is_hydrid(void)
+static bool is_hybrid(void)
 {
 	unsigned int eax, ebx, ecx, edx = 0;
 	bool result;
@@ -441,7 +441,7 @@ int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest)
 	int ret = TEST_OK;
 	int cpu;
 
-	if (!is_hydrid()) {
+	if (!is_hybrid()) {
 		test->test_cases[subtest].skip_reason = "not hybrid";
 		return TEST_SKIP;
 	}
-- 
2.46.2

