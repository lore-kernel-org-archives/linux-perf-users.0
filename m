Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7053D19E97B;
	Mon,  7 Jul 2025 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919526; cv=none; b=rhqBTC1xbERe8jHnOODi8V02TOhNKc1QcBhP5Y4NnXd5Y2wM1loT1mT1gTyfow7gh8NgmpA6YBR8Nww0O46Ff/qQbNVzoYQR+5VVNFA94TVH7qjpYkvr71+mLNJHUNzt83pFbbfNJVBLxzHg2DtAxqY/FGzWo7OIQiQx9NN8OOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919526; c=relaxed/simple;
	bh=XcT26Cnel5Co83cUwO7hfdhg5l2ZSShPH4ZgSvvvHAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sqbfhynbOAS/jWJrcWi657kok94X9FeHg1V2GOcC8c9kJyF/xYOaEetyQkZrTbWtFmFMpWEISlXh/IUTn0zE+Er9vcCromugAsz0NJ7CnkRQZt7noeSu4NCof1+B9o9N87i+GhWBc4lDENAg0cOCgQs81T1dB2yF2g4w4q0RMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gqp08Uah; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gqp08Uah"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751919524; x=1783455524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XcT26Cnel5Co83cUwO7hfdhg5l2ZSShPH4ZgSvvvHAw=;
  b=Gqp08UahVF3v1YOD4cJ6X/I29kI7bb7Jb1Ul0HoSfPKAoP0rNU+tWLDw
   0Tox1KT8W0dkwERrFvV/PaoCifmsoxyLzPJ0/UVGB0FM9JWWSDfkUTIiK
   HXsQdcE8XVbMhaUYae1AUJx+abc9EMtrYeS8JmfdP2rd8AbnwukwlPv1h
   dShe6c4lrV5y4co2gHsKX5uWshaD/lmseMxjp6uZ+L5ncZep+PuRd+nGX
   JN22EDHZVML4ZhqZGxD4odrvtbnABixPY2DlVk5vYfmFaMNST3Lh7HQpX
   Fa3z3/tqlG8wrLLhOYMCJXnA/49Jvux78gIoHLCTD/3blSLsVi7IrF3Ys
   Q==;
X-CSE-ConnectionGUID: b4x2UH3DQSmqCxAO1hyPMw==
X-CSE-MsgGUID: EIXpALvUQ/CrWqnUdwev6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53362306"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="53362306"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:18:44 -0700
X-CSE-ConnectionGUID: mUdMHiFtT7C4cWRLtWk5mA==
X-CSE-MsgGUID: 4J5H8giyTzG7VWSdHU47tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="159343668"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa003.fm.intel.com with ESMTP; 07 Jul 2025 13:18:43 -0700
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
Subject: [PATCH V4 0/4] perf: Support Panther Lake uncore
Date: Mon,  7 Jul 2025 13:17:46 -0700
Message-Id: <20250707201750.616527-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V3:
- __uncore_max_dies -> uncore_max_dies()
- Add reviewed-by from Dapeng

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

