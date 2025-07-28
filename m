Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF06322126A;
	Mon, 28 Jul 2025 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753681198; cv=none; b=p2ek5UsFW1JypUeEnmNclxm2DyMpfSKXBCqv8yGDE4DzPLZl/Z9mhzIm4aVgpjBlh9eXSxz25TKRboFb9+LAi0r7hSAyiEDiczuxQtPJcCqr98ZN38gPMR4QVpYgQdfUa2nQDg9sJKaoWGz0xGz+MNI9MwG215S9AmZnnjMkCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753681198; c=relaxed/simple;
	bh=es73wKdlYBlv7OZ0ela7vy5OHBeQcYgfaUIBDQInJIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NtTyZUCgrW4fwcKqRCiG8p18EXq4jFiwyvz5y7mCZDVhdBjAnA2hvvkmo4mqqNQ527ufaPSlIG4mw6QlDoZujQWbfbffUOJYuR+Ug+Kfl+uHIMYz/5deiq6PeDYhV5qF2vL1Mnw93IJc2F9oIels0vSvP0VuKrLAs5792ocvY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln6kQ6Fl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln6kQ6Fl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1CAC4CEEF;
	Mon, 28 Jul 2025 05:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753681197;
	bh=es73wKdlYBlv7OZ0ela7vy5OHBeQcYgfaUIBDQInJIc=;
	h=Date:From:To:Cc:Subject:From;
	b=ln6kQ6Flz7uAUQv44hSyDMlQ1YVrn2RfqNWhFKsfeT/D0Gx1zCbxmsaf4b9Kle5EK
	 ZLpED5TmuPLoYJp1UcuGEGKJasVFA7KsbzlUuGrHvsOzgCaOsz3LIgazfyFyOEVN9t
	 iRBo8XxmWEnYOSI8EcwezqP169UEgkxy6zZpS2BuZ/fo7MNw5NHG4RFIEhAHGhHxF8
	 FM9ZoCrj/KA9factZ3XI9v/FMJCfqM+9y/UyDrkrP5YoLol/hshwiZFVzH7w5M6Jo7
	 RmJvQFKkC56Hz2pPBf4uFd6ephrPLQlORaOwYQU9uy0XbwC0sHPXBTj+T4Oxi1TBu/
	 FoDCfBr4q8QUQ==
Date: Mon, 28 Jul 2025 07:39:53 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] Performance events updates for v6.17
Message-ID: <aIcNKXiXOFPFhh8B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-07-28

   # HEAD: 829f5a6308ce11c3edaa31498a825f8c41b9e9aa perf/x86/intel/uncore: Add iMC freerunning for Panther Lake

Performance events updates for v6.17:

Intel uncore driver enhancements (Kan Liang):

 - Support MSR portal for discovery tables
 - Support customized MMIO map size
 - Add Panther Lake support
 - Add IMC freerunning support for Panther Lake

 Thanks,

	Ingo

------------------>
Kan Liang (4):
      perf/x86/intel/uncore: Support MSR portal for discovery tables
      perf/x86/intel/uncore: Support customized MMIO map size
      perf/x86/intel/uncore: Add Panther Lake support
      perf/x86/intel/uncore: Add iMC freerunning for Panther Lake


 arch/x86/events/intel/uncore.c           |  7 +++
 arch/x86/events/intel/uncore.h           |  2 +
 arch/x86/events/intel/uncore_discovery.c | 89 ++++++++++++++++++++++++--------
 arch/x86/events/intel/uncore_discovery.h |  7 +++
 arch/x86/events/intel/uncore_snb.c       | 79 ++++++++++++++++++++++++++++
 arch/x86/events/intel/uncore_snbep.c     |  4 +-
 6 files changed, 166 insertions(+), 22 deletions(-)
