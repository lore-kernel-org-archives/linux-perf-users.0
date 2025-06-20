Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA4C2C374E;
	Fri, 20 Jun 2025 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434862; cv=none; b=aNYAuIpmHMe/oHOy7FO1D2sZVmatSlt3QVL+s5O5dp4xMPoSSb8RXuezXunnwC2kOQUaOJhedRWM06Ez7Ki9YZ1tmr5/RKwWz6/3+2GVqbG7HKSzDVoyAUXC0AEYwEKUGn3XSGf8/MlVzcuDhCLBFxZIQNfUYQAhWk+kRpGxL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434862; c=relaxed/simple;
	bh=L+5n/q1joZENJYF/r0KuVXPChvTNGh+qOVoAXlFy97U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hXHn0Lzvez9AbATfqWOqW66Fbv826dt7/w8R17hTJX2UhXWG5G5RL6zzshINYaPALl0Ey3exl7sJBkMfo/rLqpAAFEvVsMZhyGVHSgjXLKlj5tcgWI3krWK8DAeNNSeCb29SKlTHZaN05UYT2uLhUnuKx6H9m3zkMfZKzgWpyHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPck3FAA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPck3FAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155F8C4CEE3;
	Fri, 20 Jun 2025 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750434862;
	bh=L+5n/q1joZENJYF/r0KuVXPChvTNGh+qOVoAXlFy97U=;
	h=From:To:Cc:Subject:Date:From;
	b=NPck3FAAqqQbowswZ4Bs9WQSeDFdlLzALda6dw2sOGvdu2GPaaXPwVC+Ue0I3mT2D
	 xCodo5MJbVikwhdWdkZ9KQX17P32/qNs+DkOOWOcm7J8AHB24n3Z6oSANV67PtdbD1
	 cKyM41Ve2cxXpIHJOWj0sLrNZZq3wqJRJnn8X99zANQiM+N0E8ickQhCSUhTTdwUe1
	 fT/NQ237d0qLc/QQqXQKOJNTKwdEMqnQ8ymBcatzxVPZFH8eTFWD+ll03OPolwsIpy
	 nselsg0dC2PWXafRdiiu+p+BgUjWN3daNGM9iaZx3bgWbSwVgyKckmzPHfn9jl9JcH
	 d7R7tM/JcfOyA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chun-Tse Shao <ctshao@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.16
Date: Fri, 20 Jun 2025 12:54:15 -0300
Message-ID: <20250620155415.88215-1-acme@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 44a5ab7a7958fbf190ae384b8ef252f23b840c1b:

  Merge tag 'powerpc-6.16-3' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2025-06-16 08:49:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.16-1-2025-06-20

for you to fetch changes up to d222b6e6fb31e320eca506e665694d8ddf459157:

  tools headers x86 cpufeatures: Sync with the kernel sources (2025-06-17 18:29:42 -0300)

----------------------------------------------------------------
perf tools fixes for v6.16, 1st batch:

- Fix some file descriptor leaks that stand out with recent changes to
  'perf list'.

- Fix prctl include to fix building 'perf bench futex' hash with musl libc.

- Restrict 'perf test' uniquifying entry to machines with 'uncore_imc' PMUs.

- Document new output fields (op, cache, mem, dtlb, snoop) used with
  'perf mem'.

- Synchronize kernel header copies.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (16):
      tools headers: Update the fs headers with the kernel sources
      tools headers UAPI: Sync linux/prctl.h with the kernel sources to pick FUTEX knob
      tools kvm headers arm64: Update KVM header from the kernel sources
      tools headers UAPI: Sync KVM's vmx.h header with the kernel sources
      tools headers x86 svm: Sync svm headers with the kernel sources
      tools headers UAPI: Sync kvm header with the kernel sources
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools headers UAPI: Sync the drm/drm.h with the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools headers: Update the copy of x86's mem{cpy,set}_64.S used in 'perf bench'
      tools headers: Syncronize linux/build_bug.h with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools arch amd ibs: Sync ibs.h with the kernel sources
      tools headers: Synchronize linux/bits.h with the kernel sources
      perf bench futex: Fix prctl include in musl libc
      tools headers x86 cpufeatures: Sync with the kernel sources

Chun-Tse Shao (1):
      perf test: Restrict uniquifying test to machines with 'uncore_imc'

Ian Rogers (2):
      perf evsel: Missed close() when probing hybrid core PMUs
      perf test: Directory file descriptor leak

Namhyung Kim (1):
      perf mem: Document new output fields (op, cache, mem, dtlb, snoop)

 include/uapi/linux/bits.h                          |  4 +-
 tools/arch/arm64/include/uapi/asm/kvm.h            |  9 +--
 tools/arch/x86/include/asm/amd/ibs.h               |  5 ++
 tools/arch/x86/include/asm/cpufeatures.h           | 14 +++--
 tools/arch/x86/include/asm/msr-index.h             | 16 +++--
 tools/arch/x86/include/uapi/asm/kvm.h              | 71 ++++++++++++++++++++++
 tools/arch/x86/include/uapi/asm/svm.h              |  2 +
 tools/arch/x86/include/uapi/asm/vmx.h              |  5 +-
 tools/arch/x86/lib/memcpy_64.S                     |  1 +
 tools/arch/x86/lib/memset_64.S                     |  1 +
 tools/include/linux/bits.h                         | 57 ++++++++++++++++-
 tools/include/linux/build_bug.h                    | 10 +--
 tools/include/linux/compiler.h                     |  8 +++
 tools/include/uapi/drm/drm.h                       |  4 ++
 tools/include/uapi/linux/fscrypt.h                 |  6 +-
 tools/include/uapi/linux/kvm.h                     |  4 ++
 tools/include/uapi/linux/stat.h                    |  8 ++-
 tools/perf/Documentation/perf-amd-ibs.txt          | 59 ++++++++++++------
 tools/perf/Documentation/perf-mem.txt              | 50 +++++++++++++++
 tools/perf/bench/futex-hash.c                      |  1 -
 tools/perf/bench/futex.c                           |  9 ++-
 tools/perf/check-headers.sh                        |  2 +-
 tools/perf/tests/shell/stat+event_uniquifying.sh   | 12 +++-
 tools/perf/tests/tests-scripts.c                   |  1 +
 tools/perf/trace/beauty/include/linux/socket.h     |  2 +-
 tools/perf/trace/beauty/include/uapi/linux/fs.h    |  1 +
 tools/perf/trace/beauty/include/uapi/linux/prctl.h |  7 +++
 tools/perf/trace/beauty/include/uapi/linux/stat.h  |  8 ++-
 tools/perf/util/include/linux/linkage.h            |  4 ++
 tools/perf/util/print-events.c                     |  1 +
 30 files changed, 329 insertions(+), 53 deletions(-)
