Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE66254B03;
	Thu,  3 Jul 2025 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561822; cv=none; b=lqr4/atf7z7IKBXDh4GX3SyVeVWyWAbz7MnA9ZwKYztE4YPL0hInCOVXYY3jYBa5ko9Yx+7CiHUDFd80WrSGaEktxKNlCImGBhUxpKXofWzs9m/gkMngcVaI4XLn7DVAZNoXn61bX//PmOeTlmDEy/b/iUZwf1e+MDDAnjJSl1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561822; c=relaxed/simple;
	bh=np0zC8Vm9ZZE6PiG5q9piemOLX0Vr/7XAX1UKa/vkdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OLVuRdBqhGNnSOdzqLwxEoR2PsWE9PbzJjFTXzldgg6dZ3c45K+gFXyCpQFcH/mIT8Bt7uzz9Srl2i3uoscSXpulpelQkFOZ4evWNElYd85/dsv2wZgwcRltkD6JoicUeJ+/N2ZsZ6+JEYkMdOGZutoXOLfm//oN/MUiIyycHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeQraZQB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeQraZQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751561820; x=1783097820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=np0zC8Vm9ZZE6PiG5q9piemOLX0Vr/7XAX1UKa/vkdA=;
  b=DeQraZQBJIW8TgtQE9hii7cgyLQAjEKC5xEwGACkO2u/ScLJDz0VXgyE
   whUWOYmL9rxUHtw/9QPBosOWU7mLSfXBobxf4IIcXFL5LOs1R78IYA0oA
   qnFxQkMiYf3MiDQnLpxSPUHqwAEwhMajeQjSa6yw596Wzy6ngFKtCxlxB
   86ELhsj7XQ0pYTgenIXF5dIn9H8mviif4VspZwz4V09o9aLkFye2Dq+5a
   n3Ft3YZMDNyuQj/jmB0BVxKI+EToJG8p/LLYnuHYbLG6Q8HhDHbLD7ZuA
   N17Ezp/H3kAR72OlcMuCQG6bNBFqDVngWDugcGf7gG9K7OnkMlV2amovu
   A==;
X-CSE-ConnectionGUID: ON5XiaxyQHmH16p5BQoMxg==
X-CSE-MsgGUID: YV4b4JSFR/C80Tur/SghsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53992502"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53992502"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 09:56:53 -0700
X-CSE-ConnectionGUID: kwmJatV9RdChQ5mtPIq87A==
X-CSE-MsgGUID: kQTOeY9DRsq3SMp0wuhjrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154554260"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 03 Jul 2025 09:56:53 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 0/4] perf: Support Panther Lake uncore
Date: Thu,  3 Jul 2025 09:56:10 -0700
Message-Id: <20250703165614.606446-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V2:
- Rebase on the later tip.git
  rdmsrl_safe_on_cpu -> rdmsrq_safe_on_cpu

Starting from the Panther Lake, the uncore discovery table mechanism is
also introduced into the client platforms. The difference is that the
portal of the global discovery table is retrieved from an MSR, rather
than MMIO space.

The first two patches provide a generic support for the extension of the
uncore discovery table mechanism.
The rest patches enable the uncore PMU on Panther Lake.

Kan Liang (4):
  perf/x86/intel/uncore: Support MSR portal for discovery tables
  perf/x86/intel/uncore: Support customized MMIO map size
  perf/x86/intel/uncore: Add Panther Lake support
  perf/x86/intel/uncore: Add iMC freerunning for Panther Lake

 arch/x86/events/intel/uncore.c           |  7 ++
 arch/x86/events/intel/uncore.h           |  2 +
 arch/x86/events/intel/uncore_discovery.c | 89 ++++++++++++++++++------
 arch/x86/events/intel/uncore_discovery.h |  7 ++
 arch/x86/events/intel/uncore_snb.c       | 79 +++++++++++++++++++++
 arch/x86/events/intel/uncore_snbep.c     |  4 +-
 6 files changed, 166 insertions(+), 22 deletions(-)

-- 
2.38.1

