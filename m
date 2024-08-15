Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897E12B94;
	Thu, 15 Aug 2024 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723763002; cv=none; b=mgb+lCbwVTqEzX+ObUPtPkcnOPKqQcrecbnaOwmRNy9atLn+KS4pf41Js3ntO4HNp0D+YZxTkp2LBmy5XMFU+IKblphP/FptlJrX9b9dK1+kfEagpCXvw9+UJz8mcuh+LF6YtbQTspH836AqUbXUQ/+MgPztk9r1u2w263CjHqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723763002; c=relaxed/simple;
	bh=YjpR+HVze/ORFUtpJLBKTrS28pzM0tK3Ma5uh7Wlw8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lGkMz9IBDi9tWx5P9g8jEaWB6VfhGVm7YHBessiemcNeTOtuWui8PGeX9muH8+M4fOgz7pb4ikt2CpPEhRl6PcNlHfPnujuc82gOXT6FGl5zELVI4Bpu1gaNgTCeQKPtKwJxyTrIOBbiiB9z17XBfokA3OOCPhUxeSv3IZ9ZNhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI86mII2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI86mII2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDDAC32786;
	Thu, 15 Aug 2024 23:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723763002;
	bh=YjpR+HVze/ORFUtpJLBKTrS28pzM0tK3Ma5uh7Wlw8k=;
	h=From:To:Cc:Subject:Date:From;
	b=FI86mII2kpYLV3gSo0rTE7R2DILUVD4uvkevYIQhANTmVtv4wdNAKT1zpNvO8+6NV
	 hjWYsdjYbAwjbj2INfPpnZo5c9P4g/tccHhQQ1kRij/oXENLqiAi/AHl0NrfCncUuA
	 Amnq0xKPoPBTLlawarzFNyXyeWa1qpPMCb1k3bbABa3QSNkNegCyhgNZD1SmOD0NMe
	 9KcJBa0oznE+WI+2h4H35UUpyNjcBYEvDuAx4EnRsYst3pPcSxN2r0vz0hHgV4uA8p
	 /xEST+9vyTdjB4VOrFBLH2+b+0O5dGv+yD6zNk28aU1mFTjI5Z85CGz9y4DGC81nQs
	 PQVlzkgu5hzbw==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools fixes for v6.11-rc4
Date: Thu, 15 Aug 2024 16:03:19 -0700
Message-ID: <20240815230319.2406358-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.11.

Thanks,
Namhyung


The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.11-2024-08-15

for you to fetch changes up to 4bbe6002931954bbe82b25f25990b987b0392e18:

  perf daemon: Fix the build on 32-bit architectures (2024-08-09 19:36:20 -0700)

----------------------------------------------------------------
perf tools fixes for v6.11

The usual header file sync-ups and one more build fix.

* Add README file to explain why we copy the headers
* Sync UAPI and other header files with kernel source
* Fix build on MIPS 32-bit

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      perf daemon: Fix the build on 32-bit architectures

Namhyung Kim (10):
      perf tools: Add tools/include/uapi/README
      tools/include: Sync uapi/drm/i915_drm.h with the kernel sources
      tools/include: Sync uapi/linux/kvm.h with the kernel sources
      tools/include: Sync uapi/linux/perf.h with the kernel sources
      tools/include: Sync uapi/sound/asound.h with the kernel sources
      tools/include: Sync uapi/asm-generic/unistd.h with the kernel sources
      tools/include: Sync network socket headers with the kernel sources
      tools/include: Sync filesystem headers with the kernel sources
      tools/include: Sync x86 headers with the kernel sources
      tools/include: Sync arm64 headers with the kernel sources

 tools/arch/arm64/include/asm/cputype.h             |  10 +
 tools/arch/powerpc/include/uapi/asm/kvm.h          |   3 +
 tools/arch/x86/include/asm/cpufeatures.h           | 803 +++++++++++----------
 tools/arch/x86/include/asm/msr-index.h             |  11 +
 tools/arch/x86/include/uapi/asm/kvm.h              |  49 ++
 tools/arch/x86/include/uapi/asm/svm.h              |   1 +
 tools/include/uapi/README                          |  73 ++
 tools/include/uapi/asm-generic/unistd.h            |   2 +-
 tools/include/uapi/drm/i915_drm.h                  |  27 +
 tools/include/uapi/linux/in.h                      |   2 +
 tools/include/uapi/linux/kvm.h                     |  17 +-
 tools/include/uapi/linux/perf_event.h              |   6 +-
 tools/include/uapi/linux/stat.h                    |  12 +-
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |   6 +-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |   2 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   8 +-
 tools/perf/builtin-daemon.c                        |   9 +-
 tools/perf/trace/beauty/include/linux/socket.h     |   5 +-
 tools/perf/trace/beauty/include/uapi/linux/fs.h    | 163 ++++-
 tools/perf/trace/beauty/include/uapi/linux/mount.h |  10 +-
 tools/perf/trace/beauty/include/uapi/linux/stat.h  |  12 +-
 .../perf/trace/beauty/include/uapi/sound/asound.h  |   9 +-
 22 files changed, 814 insertions(+), 426 deletions(-)
 create mode 100644 tools/include/uapi/README
