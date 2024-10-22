Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9EF1B86D5;
	Tue, 22 Oct 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612822; cv=none; b=mhWKDCarcylXwJYDzjSGNvq2raUgFBuSjIXnkBf+m5CL/OCmf3Dwz//zF18y3hxfFU4/4sUgW1nG+vXWhIWPzqfAc3e+2iOQVV+JJLKnV9GLoYq8OgO5aIGKs5Rz+3rwpehkngCocQvj4VvdbtsmrEXvUEvXwsVBtMOOL8U2Xbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612822; c=relaxed/simple;
	bh=QStAwdkye38HLwLvAfPzq8FmSRXF3FozST6s+/YdPUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUCdQC2Sk7q4e/jDBHez+OLylQ1ok8BJSVNHu9i4AQDKjPUiatL2F8JGWiYDLv+35RLPMaXZNWELtqMfFk1VxSL0egzkyXjBJ/bVFu3IwbQMR6nf06gZOsFMofPW2vY3sRUGNLV8ynA8p2ecwmf+8gqzFCOD5cMZMQwsNiMDX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJr1GsLO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJr1GsLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729612820; x=1761148820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QStAwdkye38HLwLvAfPzq8FmSRXF3FozST6s+/YdPUQ=;
  b=dJr1GsLOSgbjxK+COoobhOixRWiQL/4FlzNiim5xD9qTcteIKO9RgrnQ
   099AmDnNr8REqFfyLoPOFXEPBnJYPW1M7vrsFegwc1BqWuriLGAoGwQbg
   M7XpVDz5xV2D00FcCKmcGagOHph2lFNC+kq2Z3Zm3vJjCsYSZN0C5P0Lt
   r/LTpCTrDY80/mGDG4+aZ/0dliEW2oSUAIt3qzeSRZaUJF5nm1yDbm5/p
   XhJrvAmJT+C+yLudST12N5l7zjxbOOGMYRcLKUYm5Uw4PCVkj3KQsjRYY
   vNPHzEsuy7hQqOiS/fyFVipJIGfoHn16Xsw5vPBDawdt/m8yiqRuOxUdM
   w==;
X-CSE-ConnectionGUID: nYTkCt0SSuGev2hZkxvwig==
X-CSE-MsgGUID: 44OJcBDlTz2TwLVwzBmXoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29270911"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29270911"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 09:00:15 -0700
X-CSE-ConnectionGUID: 4u1D0BmRTmewWLHKsfHjeA==
X-CSE-MsgGUID: 9SFK0AObQkimpU1fYFrlpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79858526"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.246.16.81])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 09:00:06 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V14 04/11] perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
Date: Tue, 22 Oct 2024 18:59:10 +0300
Message-ID: <20241022155920.17511-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022155920.17511-1-adrian.hunter@intel.com>
References: <20241022155920.17511-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Events with aux actions or aux sampling expect the PMI to coincide with the
event, which does not happen for large PEBS, so do not enable large PEBS in
that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---


Changes in V11:
	Remove definition of has_aux_action() because it has
	already been added as an inline function.


 arch/x86/events/intel/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7ca40002a19b..bb284aff7bfd 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3962,8 +3962,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 
 		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
-			if (!(event->attr.sample_type &
-			      ~intel_pmu_large_pebs_flags(event))) {
+			if (!(event->attr.sample_type & ~intel_pmu_large_pebs_flags(event)) &&
+			    !has_aux_action(event)) {
 				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
 				event->attach_state |= PERF_ATTACH_SCHED_CB;
 			}
-- 
2.43.0

