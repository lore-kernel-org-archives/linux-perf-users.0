Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2D9256C61;
	Sun, 14 Jun 2026 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781448653; cv=none; b=e1CMsvd+1qXI9nsKFEw/gr1RpX8y+N4pErGcYtS4i+x77VLIumoYqvH+qT9RFBZmMCKDUovrYJtVg2ZLUL/ol2qoQdFeI8NznQZrDu6kctnAyWzjoZb+rHoQ4o15l85UeQAnk0RKadrRwLDXdazfXOdV3sCAwUsKFiId4jSXCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781448653; c=relaxed/simple;
	bh=Q8Q4W+YEqCtPwUeH1OlnPTv2UtnZ7gRSuELiQ6LuoAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mVHXM+VjTPByzFXAfh8WKy9QEoVl/92nddW0eYtjyj4pBbEm8vEgiHNXpII+gG7Eqx0hSEIzpoq0Kb8PppL2NlizvcRRQwhjNu/mQDh6Hetcr3mY2+LpywedXgDvyHDEQZbNS5wG72aomq41g7uxNfBwHMLR0fNGAaNMDdP5DRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJG4wc9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJG4wc9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E31F1F000E9;
	Sun, 14 Jun 2026 14:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781448650;
	bh=RZvNIJufyaytxs38HYa+lgs/nF1vb4PAc8kS4sB8BQ8=;
	h=Date:From:To:Cc:Subject;
	b=FJG4wc9Xksu0K+iH8AMFML6/MXTk5DHyZ8XuxvysPSUO6f9toiQtFUOkphbgFr5aY
	 MUZSaqZxNxjf+6z9nCQp510rRqF09RHggSV+qBnwFfqRkVZowYX8SJoHZ7NDIYht40
	 YBPozMcQIHAeusSzlLTgCZ/xQp0OOW2O6E5xx4XXuACnNf0Fg7lqvcwfGUOe/1OeyL
	 Zqn+KZ6BD5M9AE3qz1oPz3zcDGo3gQRXtokFQM9AuQQk8IlwMmI+lDLIDpxEMX9y5N
	 duNy5OG8VaSfHLUAZvLkyEs0Hd7yXqzkUex6bDEP/vkS8blGlz+/swNBuGu3p5hE4a
	 qJg5I7hciVGbg==
Date: Sun, 14 Jun 2026 16:50:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [GIT PULL] Performance events updates for v7.2
Message-ID: <ai6_xmvbz9ISX-Dm@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-06-14

for you to fetch changes up to 67d27727854def4a7e2b386429941f5c4741ccc4:

Performance events updates for v7.2:

Core perf code updates:

 - Reveal PMU type in fdinfo (Chun-Tse Shao)

Intel CPU PMU driver updates:

 - Fix various inaccurate hard-coded event configurations
   (Dapeng Mi)

Intel uncore PMU driver updates (Zide Chen):

 - Fix discovery unit lookup bug for multi-die systems
 - Guard against invalid box control address
 - Fix PCI device refcount leak in UPI discovery
 - Defer ADL global PMON enable to enable_box() to save power
 - Fix uncore_die_to_cpu() for offline dies
 - Implement global init callback for GNR uncore

AMD CPU PMU driver updates:

 - Always use the NMI latency mitigation (Sandipan Das)

AMD uncore PMU driver updates:

 - Use Node ID to identify DF and UMC domains (Sandipan Das)

 Thanks,

	Ingo

------------------>
Chun-Tse Shao (1):
      perf: Reveal PMU type in fdinfo

Dapeng Mi (12):
      perf/x86/intel: Consolidate MSR_IA32_PERF_CFG_C tracking
      perf/x86/intel: Update event constraints and cache_extra_regsfor ICX
      perf/x86/intel: Update event constraints and cache_extra_regsfor SPR
      perf/x86/intel: Update event constraints for DMR
      perf/x86/intel: Update event constraints and cache_extra_regsfor ADL
      perf/x86/intel: Update event constraints and cache_extra_regsfor MTL
      perf/x86/intel: Update event constraints and cache_extra_regsfor LNL
      perf/x86/intel: Update event constraints and cache_extra_regsfor ARL
      perf/x86/intel: Update event constraints for PTL
      perf/x86/intel: Update event constraints and cache_extra_regsfor NVL
      perf/x86/intel: Update event constraints and cache_extra_regsfor SRF
      perf/x86/intel: Update event constraints and cache_extra_regsfor CWF

Sandipan Das (2):
      perf/x86/amd/core: Always use the NMI latency mitigation
      perf/x86/amd/uncore: Use Node ID to identify DF and UMC domains

Zide Chen (7):
      perf/x86/intel/uncore: Fix discovery unit lookup for multi-die systems
      perf/x86/intel/uncore: Guard against invalid box control address
      perf/x86/intel/uncore: Fix PCI device refcount leak in UPI discovery
      perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()
      perf/x86/intel/uncore: Move die_to_cpu() to uncore.c
      perf/x86/intel/uncore: Fix uncore_die_to_cpu() for offline dies
      perf/x86/intel/uncore: Implement global init callback for GNR uncore


 arch/x86/events/amd/core.c               |   6 +-
 arch/x86/events/amd/uncore.c             |   6 +-
 arch/x86/events/intel/core.c             | 489 ++++++++++++++++++++++++++-----
 arch/x86/events/intel/ds.c               |  23 +-
 arch/x86/events/intel/uncore.c           |  32 +-
 arch/x86/events/intel/uncore.h           |   3 +-
 arch/x86/events/intel/uncore_discovery.c |  46 ++-
 arch/x86/events/intel/uncore_snb.c       |   7 -
 arch/x86/events/intel/uncore_snbep.c     |  36 +--
 arch/x86/events/perf_event.h             |   8 +-
 kernel/events/core.c                     |  29 ++
 11 files changed, 540 insertions(+), 145 deletions(-)
