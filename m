Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587CC257ACF;
	Tue, 11 Aug 2026 00:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786409233; cv=none; b=WPFbRSWPnI+w9XJAlJMeJpFs1OmsJSKGJ2Ex26CJ8/13sf0wthnfm3iQ0Y/ZskPAH5RcXI0PKzk4lQLnzdVXyuiiIJHjVCMOG0JM8iUL5+4bYBD7wdIPUy/p/0A2DHWm0ndjOF0xwTYy2igp/m2HDTWdX0Z1XsnTmwonZKz9D1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786409233; c=relaxed/simple;
	bh=qgTMvpIyY8qadjeQZhsgopH/H6mCef4UbRYtX0xpYq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oTkUmgvqArSUIu8sQBnnl5tOwSshLr6xdiGVVl44RCGxeYTyJzdZTej/gWRk2eM7EVETPQB/D2vjyIC7HKdgOmfiRETL0CLShQ4ZCyK6X64gCIk2inbbJ3Oqiuc6Oe9a3H3sP0YJdIx/UZS36fCm15ziw3ve+5nIHTz5Iv6LcYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULEZvx5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULEZvx5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29881F000E9;
	Tue, 11 Aug 2026 00:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786409231;
	bh=ZNVsgWopaPVX8yPMUW2A05iOqzOA/W5XqK76rDaPHwk=;
	h=From:To:Cc:Subject:Date;
	b=ULEZvx5l2+BaBgeHodrUiOvA9gyEuCyR1ONN0WDeyWwaAIcEaGNjpLgyq0Z7Udlan
	 wMikVQbEr9sGft+lKELhNjQq6i163l+fZkejDG7OC1HaYpG0pbV/yIYsEZN3Kggm3h
	 7iyHqXkvofhNHhshVZAWdAfTSQUvwe0no3+5uaDC6AAg/BpTsiydNYnX/mBDNQw89P
	 NixJN2Ej084kPTPH/SudhU8Vq2LjsW+wbIbm/Xmk2c2/7mEENYXVeEbDjGWTI9xAee
	 z2GFth1MT72Y3t2KvxDKvpo6Dbm0Zb2ywBBeea2DFYlbo0RJ+CjEpQJ5+6nELUxm7V
	 HAZHiuuREuE8g==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES v6 0/7] perf build: Add target to install devel packages needed to build perf
Date: Mon, 10 Aug 2026 21:46:52 -0300
Message-ID: <20260811004659.6212-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds a 'make -C tools/perf install-build-deps' target that
installs the development packages needed to build perf on Fedora, Ubuntu,
Debian, and RHEL family distributions.

Building perf requires many devel packages (libelf, libdw, libunwind,
numactl, libtraceevent, libbpf, etc.). Today users must iteratively
install packages as each feature check fails. The new target installs the
full set in one go.

The first patch makes the compiler probe run at parse time only when the
tool is installed, so a missing C++ compiler or clang no longer fails the
feature tests prematurely. The second patch adds the framework (make
target, distro detection, package manager drivers). The next four patches
add distro-specific package mappings derived from the headers each
feature test requires. The last patch removes leftover feature test
entries for cxx and clang support removed in 56b11a2126bf2f42 ("perf
bpf: Remove support for embedding clang for compiling BPF events
(-e foo.c)").

Supported distros (validated in containers, host never modified):
  - Fedora 44 (dnf, 29 packages)
  - Ubuntu 26.04 (apt, 29 packages)
  - Debian 13 (apt, reuses Ubuntu mapping)
  - Centos 10 (dnf, 29 packages)

On all distros, a clean O= build after running the target enabled every
feature the distro provides (excluding deliberately unmapped deprecated
packages). Re-running the target is a no-op.

Best regards,

- Arnaldo

What changed from v5:

  - the unused 'pkg' local declaration was removed from main(): the
    iteration over packages happens in package_set(), which declares
    its own 'pkg' variable [sashiko review of PATCH 3/7];
  - sourcing /etc/os-release in detect_distro() now redirects stderr
    with 2>/dev/null, so a missing /etc/os-release no longer prints
    an error message [sashiko review of PATCH 2/7].

What changed from v4:

  - No changes from v3, just resubmitting because Sashiko restarted and
    when back it didn't manage to apply this even with the same base
    commit (perf-tools-next/perf-tools-next) as V3, so this probably is
    something transient, and as I'm addressing comments for v3, worth
    resubmitting.

What changed from v3:

  - clear the EXIT/INT/TERM traps after consuming and removing the temp
    file: missing_file is local to main(), so the EXIT trap firing after
    main() returns hits an unbound variable under set -u, printing a
    spurious error on the successful-install path [sashiko review of
    PATCH 7/7].

What changed from v2:

  - the trap that removes the temporary file tracking missing packages
    now exits the script when SIGINT/SIGTERM is received, instead of
    only removing the file and letting the script resume after the
    interrupted command [sashiko review of PATCH 7/7].

What changed from v1:

  - AlmaLinux is now detected by its actual /etc/os-release ID
    ("almalinux" instead of "alma") in detect_distro() [sashiko review
    of PATCH 7/7];
  - packages that no enabled repo provides (e.g. zlib and the versioned
    JDK/jvmti packages on the RHEL family) are no longer silently
    omitted from the missing packages list, they are reported at the end
    of the run, as stated in the commit message [sashiko review of
    PATCH 7/7];
  - the temporary file used to track those missing packages is now
    removed by a trap, so it does not leak if the script is interrupted
    [sashiko review of PATCH 7/7];
  - the leftover feature test removal patch now carries the suggested
    Fixes: tag for 56b11a2126bf2f42, with the author of that commit
    Cc'd [Ian Rogers review of PATCH 6/7].

This series was developed with assistance from Opencode
(deepseek-v4-flash-free and glm-4-7-flash-ollama-local) for code
analysis, patch generation, and commit message composition, and from
Claude (Opus 4.7) for review triage and bug-fix generation.

Arnaldo Carvalho de Melo (7):
  tools build: Only probe the compiler at parse time when it is installed
  perf build: Add install-build-deps framework to install devel packages
  perf build: install-build-deps: add Fedora devel package mapping
  perf build: install-build-deps: add Ubuntu devel package mapping
  perf build: install-build-deps: add Debian devel package mapping
  perf build: Remove leftover feature tests for removed cxx and clang support
  perf build: install-build-deps: add RHEL family devel package mapping

 tools/build/Makefile.feature             |   2 -
 tools/build/feature/Makefile             |  14 -
 tools/perf/Makefile.perf                 |  21 +-
 tools/perf/scripts/install-build-deps.sh | 581 +++++++++++++++++++++++
 tools/scripts/Makefile.arch              |   2 +-
 tools/scripts/Makefile.include           |   2 +-
 6 files changed, 601 insertions(+), 21 deletions(-)

base-commit: bf10e6ee2ac3034c9068e03eed418fd16961984e
