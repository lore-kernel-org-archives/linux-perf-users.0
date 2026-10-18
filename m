Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30244C65C;
	Sun, 18 Oct 2026 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792317889; cv=none; b=QHTnKzSg/LVgMcJAmAZgGwfNO81qkWQYoIp0dQXhuuuJ2tM3BK0nHNqdy7fEfgYghDAi1QVIz+TcawsDW3rS2ODoxogS+U1nMsCAvh1xVZOCq98QQJ7ohmv1Fu7fKmI2aTeJi+CUqjT8RZf5ou1PylMZhooaWfDRuUG+UHXac+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792317889; c=relaxed/simple;
	bh=PwSVXb+lV1GsSu4Zi3Pr7/SsGL9Li0Amdx1biLEdlj8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tbDSwjNt8ZjknN0+JaJLE8bo+ZpJuP9srq143tJ9BB5rGLGQGDgKbtVpCe1Z/3/CBqiwHEUaHPxgSZSFRJF+q2GqLGox3HSQJp91GmSScXnTcbnLOEei4QO7E07dlRWIqbGnC/EWmbzN46wiZKb0d182B8zb9U0LMb4lLsDuV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wqx0RpYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wqx0RpYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB8C1F000C4;
	Sun, 18 Oct 2026 10:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792317884;
	bh=tbl6M0uMj0TksfUEFVPQfnAEUrKTvBvLOUkSVUzqEis=;
	h=Date:From:To:Cc:Subject;
	b=Wqx0RpYn7CU/si8yvmjYrw4EryvGI0KcsCK7JoQxXOytMyBwdyzSglY6qBW+Ei515
	 icggJD5iZ8oYZo61MlHMqO7iLNzLTu5r7b4YkuUOBC0uCvBIYQ5Znlq6hmE3pxk0GA
	 j9y8SW1YswumdL0oqpZ9+pIaxYJAGOJlGr9NqE5dmzKDztJ9bgg50c4ANz2ek0zQd9
	 dWxftARK2a9y0xSMb6Dqf8u5wB5wT4i+6AkdfnVMSSy+kyMleAZA3SpENCLvBKuYoB
	 Wbu33gZC8gW6mjo8pB2E5op3MpytAtHLPkQHL8p/ELzCXvJ+KR2Qfa7K5yL6iDQtlU
	 1THyXLo+8kL2g==
Date: Sun, 18 Oct 2026 12:04:39 +0200
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
Subject: [GIT PULL] Performance events updates for v7.4
Message-ID: <atSZt26TkKplm5qA@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-10-18

for you to fetch changes up to f5a78ecccd98a04c47cea1cd63c2a2fdce8a4b48:

Perf events updates:

 - Support SIMD/eGPRs/SSP register sampling in perf
   (Dapeng Mi, Kan Liang)

 - Turn amd_uncore_ctx events into a flexible array (Rosen Penev)

 - Finish the work related to fixing the guest PEBS path to not
   set unwanted PERF_GLOBAL_CTRL bits, for which urgent fixes
   are upstream already (Sean Christopherson)

 - Drop redundant counter slot searches in the AMD uncore
   driver (Usama Arif)

 - Don't WARN when the ext_regs_buf allocation fails (vineash)

 - Annotate x86_pmu::hybrid_pmu with __counted_by_ptr (Thorsten Blum)

 Thanks,

	Ingo

------------------>
Dapeng Mi (20):
      perf/x86: Move hybrid PMU initialization before x86_pmu_starting_cpu()
      perf/x86/intel: Enable large PEBS sampling for XMMs
      perf/x86/intel: Convert x86_perf_regs to per-cpu variables
      perf: Eliminate duplicate arch-specific function definitions
      perf/x86: Use x86_perf_regs in NMI handlers
      x86/fpu: Add update_fpu_state_and_flag() helper
      perf/x86/intel: Centralize PERF_PMU_CAP_EXTENDED_REGS updates
      perf/x86: Enable XMM register sampling for non-PEBS events
      perf/x86: Enable XMM register sampling for REGS_USER case
      perf/x86: Support XMM sampling using sample_simd_vec_reg_* fields
      perf/x86: Support YMM sampling using sample_simd_vec_reg_* fields
      perf/x86: Support ZMM sampling using sample_simd_vec_reg_* fields
      perf/x86: Support OPMASK sampling using sample_simd_pred_reg_* fields
      perf: Enhance perf_reg_validate() with simd_enabled argument
      perf/x86: Support eGPRs sampling using sample_regs_* fields
      perf/x86: Support SSP sampling using sample_regs_* fields
      perf/x86/intel: Support arch-PEBS based SIMD/eGPRs sampling
      perf/x86/intel: Advertise PERF_PMU_CAP_SIMD_REGS capability
      perf/x86: Activate back-to-back NMI detection for arch-PEBS induced NMIs
      perf/x86/intel: Add sanity check for PEBS record/fragment size

Kan Liang (3):
      x86/fpu/xstate: Add xsaves_nmi() helper
      perf: Move and enhance has_extended_regs() for arch-specific use
      perf: Add sampling support for SIMD registers

Rosen Penev (1):
      perf/x86/amd/uncore: Turn amd_uncore_ctx events into a flexible array

Sean Christopherson (6):
      perf/x86/intel: Invert names of intel_ctrl_{guest,host}_mask
      perf/x86: KVM: Have perf define a dedicated struct for getting guest PEBS data
      perf/x86/intel: KVM: Handle cross-mapped PEBS PMCs entirely within KVM
      KVM: VMX: Drop a redundant pmu->global_ctrl check when processing pebs_enable
      KVM: VMX: Only tell perf to enable PEBS counters for fully enabled PMCs
      perf/x86/intel: Check only PMC bits in PEBS_ENABLED when detecting host PEBS usage

Thorsten Blum (1):
      perf/x86/intel: Annotate x86_pmu::hybrid_pmu with __counted_by_ptr

Usama Arif (2):
      perf/x86/amd/uncore: Remove redundant event slot scan
      perf/x86/amd/uncore: Free counter slot by index

vineash (1):
      perf/x86: Don't WARN when the ext_regs_buf allocation fails


 arch/arm/kernel/perf_regs.c           |   8 +-
 arch/arm64/kernel/perf_regs.c         |   8 +-
 arch/csky/kernel/perf_regs.c          |   8 +-
 arch/loongarch/kernel/perf_regs.c     |   8 +-
 arch/mips/kernel/perf_regs.c          |   8 +-
 arch/parisc/kernel/perf_regs.c        |   8 +-
 arch/powerpc/perf/perf_regs.c         |   2 +-
 arch/riscv/kernel/perf_regs.c         |   8 +-
 arch/s390/kernel/perf_regs.c          |   2 +-
 arch/x86/events/amd/uncore.c          |  39 +--
 arch/x86/events/core.c                | 488 ++++++++++++++++++++++++++++++++--
 arch/x86/events/intel/core.c          | 154 +++++++----
 arch/x86/events/intel/ds.c            | 232 ++++++++++++----
 arch/x86/events/intel/lbr.c           |   2 +-
 arch/x86/events/perf_event.h          | 217 ++++++++++++++-
 arch/x86/include/asm/fpu/sched.h      |   5 +-
 arch/x86/include/asm/fpu/xstate.h     |   3 +
 arch/x86/include/asm/kvm_host.h       |   9 -
 arch/x86/include/asm/msr-index.h      |   7 +
 arch/x86/include/asm/perf_event.h     |  46 +++-
 arch/x86/include/uapi/asm/perf_regs.h |  53 ++++
 arch/x86/kernel/fpu/core.c            |  33 ++-
 arch/x86/kernel/fpu/xstate.c          |  25 +-
 arch/x86/kernel/perf_regs.c           | 174 ++++++++++--
 arch/x86/kvm/vmx/pmu_intel.c          |  28 +-
 arch/x86/kvm/vmx/vmx.c                |  10 +-
 arch/x86/kvm/vmx/vmx.h                |  15 +-
 arch/x86/xen/pmu.c                    |   5 +-
 include/linux/perf_event.h            |  23 ++
 include/linux/perf_regs.h             |  36 +--
 include/uapi/linux/perf_event.h       |  49 +++-
 kernel/events/core.c                  | 177 ++++++++++--
 32 files changed, 1579 insertions(+), 311 deletions(-)
