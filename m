Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896841EBFEF;
	Wed, 30 Oct 2024 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321283; cv=none; b=qhkTNN6DcvYTb4y3aHg1yErZZE5GmQifmyEU5pEtbwvq9ODV2cVRNi6QwOdGFQ53he4BG7otlZMOtd3G1PH7Vf/OmIW7S7S3ADGEg4jQt0+iZFAtt2gYbbbJESQc62X6Wg/teJLOj9FpWZI215RU/9YXTYNjK2iTFlJMppSBJtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321283; c=relaxed/simple;
	bh=e7fUMOjvwY6rW2cNDXiNGklZxZWbO+ZI3gtK0vVj8LM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ahjzLCwgmPxQ2az0jlKgHvygUAzgQgFSQeTEDgn4XE3OBm9dfimXiNz7UPEput007jMtzNCiLZdhLrD3iFBJasweKgG4ZnL0n3mmnz+ZFKF4Dwmw76dyL/6EAjxoksahGXbDsis844vA6d9uvs5ebChqaLqqaZE3vd6voswNYEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHP/VrWL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHP/VrWL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D189C4CECE;
	Wed, 30 Oct 2024 20:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730321283;
	bh=e7fUMOjvwY6rW2cNDXiNGklZxZWbO+ZI3gtK0vVj8LM=;
	h=From:To:Cc:Subject:Date:From;
	b=gHP/VrWLpyPOfZaede6c+z8n3DYRozJGubgT54Y9Bi2jrAjspoTZZ4+0zL0Fh6VdD
	 sP5N8XzNI0iD5qACwBPLCiNUGW9SrSFZLSgPvjB+8BAf2MQ/VfHl9Gd3MlaYftgLNd
	 CApfl3fvaKQXci9JF5M8XINVeMx//zvecMNt6rMJHZNwnokwuL5rU5E9GeDZSO9sxJ
	 nsTTr3wyE6OCAK2U8BP+t5PxshCF0O6aVJXAIg228r1E6GpUK6r0Z4TlP9Vw4tOBEa
	 fGR6Whk50p79dV2bardLe5RtpiRlRNZ9rVtenCgizPHisV6Fi9Og5MdTA4zEa8YRDB
	 pc8L5thl5f43A==
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
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Slaby <jslaby@suse.cz>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.12: 2nd batch
Date: Wed, 30 Oct 2024 17:47:52 -0300
Message-ID: <20241030204752.316247-1-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
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

The following changes since commit c964ced7726294d40913f2127c3f185a92cb4a41:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2024-10-16 13:37:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.12-2-2024-10-30

for you to fetch changes up to a5384c426744ebe41dafc6e5fa3acecc05e43462:

  perf cap: Add __NR_capget to arch/x86 unistd (2024-10-28 13:04:52 -0300)

----------------------------------------------------------------
perf tools fixes for v6.12: 2nd batch

- Update more header copies with the kernel sources, including const.h,
  msr-index.h, arm64's cputype.h, kvm's, bits.h and unaligned.h

- The return from 'write' isn't a pid, fix cut'n'paste error in 'perf
  trace'.

- Fix up the python binding build on architectures without
  HAVE_KVM_STAT_SUPPORT.

- Add some more bounds checks to augmented_raw_syscalls.bpf.c (used to
  collect syscall pointer arguments in 'perf trace') to make the
  resulting bytecode to pass the kernel BPF verifier, allowing us to go
  back accepting clang 12.0.1 as the minimum version required for
  compiling BPF sources.

- Add __NR_capget for x86 to fix a regression on running perf + intel PT
  (hw tracing) as non-root setting up the capabilities as described in
  https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html.

- Fix missing syscalltbl in non-explicitly listed architectures, noticed
  on ARM 32-bit, that still needs a .tbl generator for the syscall
  id<->name tables, should be added for v6.13.

- Handle 'perf test' failure when handling broken DWARF for ASM files.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (9):
      tools headers UAPI: Sync linux/const.h with the kernel headers
      perf trace: The return from 'write' isn't a pid
      perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers
      tools headers UAPI: Sync kvm headers with the kernel sources
      perf python: Fix up the build on architectures without HAVE_KVM_STAT_SUPPORT
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers: Synchronize {uapi/}linux/bits.h with the kernel sources
      tools headers arm64: Sync arm64's cputype.h with the kernel sources
      tools headers: Update the linux/unaligned.h copy with the kernel sources

Howard Chu (2):
      perf trace augmented_raw_syscalls: Add more checks to pass the verifier
      perf build: Change the clang check back to 12.0.1

Ian Rogers (1):
      perf cap: Add __NR_capget to arch/x86 unistd

Jiri Slaby (1):
      perf trace: Fix non-listed archs in the syscalltbl routines

Veronika Molnarova (1):
      perf test: Handle perftool-testsuite_probe failure due to broken DWARF

 tools/arch/arm64/include/asm/cputype.h             |  2 +
 tools/arch/x86/include/asm/msr-index.h             | 34 ++++++-----
 tools/arch/x86/include/uapi/asm/kvm.h              |  1 +
 tools/arch/x86/include/uapi/asm/unistd_32.h        |  3 +
 tools/arch/x86/include/uapi/asm/unistd_64.h        |  3 +
 tools/include/linux/bits.h                         | 15 +++++
 tools/include/linux/unaligned.h                    | 11 +---
 tools/include/uapi/linux/bits.h                    |  3 +
 tools/include/uapi/linux/const.h                   | 17 ++++++
 tools/include/vdso/unaligned.h                     | 15 +++++
 tools/perf/Makefile.config                         |  4 +-
 tools/perf/builtin-trace.c                         |  2 +-
 tools/perf/check-headers.sh                        |  1 +
 .../shell/base_probe/test_adding_blacklisted.sh    | 69 +++++++++++++++++-----
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c     | 22 ++++++-
 tools/perf/util/cap.c                              | 10 +---
 tools/perf/util/python.c                           |  3 +
 tools/perf/util/syscalltbl.c                       | 10 ++++
 18 files changed, 174 insertions(+), 51 deletions(-)
 create mode 100644 tools/include/vdso/unaligned.h
