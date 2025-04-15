Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4CE2750F4;
	Tue, 15 Apr 2025 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701610; cv=none; b=saGTXiLMwVrZfnB0w+XsKKzma89p4b0HuNWC384vjA4oFZBR4JdNCga3gXKdTcVrghrVz67o89zDEJZyKW7Fsnm2mflEtmRWzdkViOcBF9ET4cn7Zfvj+HFCHoDTs8zpm6gg1x4RzkHx7AcgdgJ+B8QtMoH7C0XL0w8bifory6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701610; c=relaxed/simple;
	bh=ejz78Krnr/OnOfEYUY9m5HfGBABU7+0JMb6tAyQpWOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cs7F0Mu9jpm8rQ2YoQt2cgGwI6WsvUb+uorL0+6mbn7iz0piGb7F6UP3na84AKU/tqxv1FtpdnFzhky7eBJVnV6f2cOUsgkjxOXxABjfRNr4J9bJXaqVDc8agX/U5edgmxJcGzQTLEiBSw7niK4foy9LLk+n/tlrHjW1+Bg/pW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZL1z+5I6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZL1z+5I6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744701609; x=1776237609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ejz78Krnr/OnOfEYUY9m5HfGBABU7+0JMb6tAyQpWOk=;
  b=ZL1z+5I6dMtEzUMDHC34f9sluJmX1v18rJqc2G7Bi3HxTyUdALrLr275
   3hA+GAD8QT2Dh370iz05dN6KBqYQ0mjNG4RKeRs5KhyYzFZIHiEfy8uWP
   ik+6NNh2m57DXC4+BvbdIneiadpOtKIsklQNY+esiAoeLlM8bDedkZRZt
   u05a8L4gSiCOB3jeYgOU7rGCn3E7niOOzKMrsFiXrAjf05E2lB5qupGVE
   zq56qxre9u42MH1zML2tCg7YvVqPtjNKzaKWgT+ntQlyyj2uM7/LTvCjZ
   63sAhHUhj64pvcNJ6gaZCId2x4sNOr6kfb7kwN1EdZrLnjOzfOFN9DJKq
   Q==;
X-CSE-ConnectionGUID: MbKAvzHSRJi2xrE8CjDS5A==
X-CSE-MsgGUID: rbARR0f8RQG72KQXNc8PcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="33807585"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="33807585"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:20:01 -0700
X-CSE-ConnectionGUID: CfDBdKxkT5i4xF1xOiX+SQ==
X-CSE-MsgGUID: sFglZGT3TPCm0h+0HBvCoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="129885767"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa006.fm.intel.com with ESMTP; 15 Apr 2025 00:19:57 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel: Allow to update user space GPRs from PEBS records
Date: Tue, 15 Apr 2025 10:41:35 +0000
Message-Id: <20250415104135.318169-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250415104135.318169-1-dapeng1.mi@linux.intel.com>
References: <20250415104135.318169-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when user samples user space GPRs (--user-regs option) with
PEBS, the user space GPRs actually always comes from software PMI
instead of from PEBS hardware. This leads to the sampled GPRs may be
inaccurate for single PEBS record case because of the skid between
counter overflow and GPRs sampling on PMI.

For the large PEBS case, the thing is even worse. If user sets
exclude_kernel attribute, large PEBS would be used to sample user space
GPRs, but since PEBS GPRs group is not really enabled, it leads to all
samples in the large PEBS record shares a same piece of user space GPRs,
like below command shows.

perf record -e branches:pu --user-regs=ip,ax -c 100000 ./foo
perf report -D | grep "AX"

.... AX    0x000000003a0d4ead
.... AX    0x000000003a0d4ead
.... AX    0x000000003a0d4ead
.... AX    0x000000003a0d4ead
.... AX    0x000000003a0d4ead
.... AX    0x000000003a0d4ead
.... AX    0x000000003a0d4ead
.... AX    0x000000003a0d4ead
.... AX    0x000000003a0d4ead
.... AX    0x000000003a0d4ead
.... AX    0x000000003a0d4ead

So enable GPRs group for user space GPRs sampling and prioritize reading
GPRs from PEBS. If the PEBS sampled GPRs is not user space GPRs (single
PEBS record case), perf_sample_regs_user() modifies them to user space
GPRs.

Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 486881fe162e..fcf9c5b26cab 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1398,8 +1398,10 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	 * + precise_ip < 2 for the non event IP
 	 * + For RTM TSX weight we need GPRs for the abort code.
 	 */
-	gprs = (sample_type & PERF_SAMPLE_REGS_INTR) &&
-	       (attr->sample_regs_intr & PEBS_GP_REGS);
+	gprs = ((sample_type & PERF_SAMPLE_REGS_INTR) &&
+		(attr->sample_regs_intr & PEBS_GP_REGS)) ||
+	       ((sample_type & PERF_SAMPLE_REGS_USER) &&
+		(attr->sample_regs_user & PEBS_GP_REGS));
 
 	tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT_TYPE) &&
 		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
@@ -2122,7 +2124,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 			regs->flags &= ~PERF_EFLAGS_EXACT;
 		}
 
-		if (sample_type & PERF_SAMPLE_REGS_INTR)
+		if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
 			adaptive_pebs_save_regs(regs, gprs);
 	}
 
-- 
2.40.1

