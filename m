Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8CE387347;
	Mon, 10 Aug 2026 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390518; cv=none; b=BaCaDqRlM8edjG1f2JctOx193kUnXT+PJ2rRCGS5P1a+0EhClYhnHXn+kFEORw0DCuRPTaV4rxtzJEWnOdsarcCtY8lqDSFjNKN5tA2lB6WhcARLgbMZQarD1NZj8cvv6kxLtjSsXPh4punJZ0R1MY++XvYKPbHw/yj4of1cAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390518; c=relaxed/simple;
	bh=qZe2naqUcySzC8ljgc9QhjWnSlqbUx2GD2cCUq0YNWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H86j/O6hd1cOdL+44mCcdMEs88Jf7JUPmp5s8ZZHNz0Qz5H6yEBcmnWhjMBd/d8txS8HGJvGyjToAaQSMkyK55SOh489WOl7N5UScAFUUOE79wWH/mrjB1pniRLZ4y9MRc14zMNwXRV0d4wW2e9b6vM0yBVXkemTTg7AsvkcTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljcaEnQy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljcaEnQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335531F000E9;
	Mon, 10 Aug 2026 19:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786390517;
	bh=1kjrSmXFVpp9cDr/+WCANQ+0Aj6P2AgfwpRhRR4U/+c=;
	h=From:To:Cc:Subject:Date;
	b=ljcaEnQyVG1gG9qzXD+Kin+edyzKXOeC36srPVg7MeGm2gDlCvgw3yv+WdDRQsSUN
	 tzW2WdSyiMYiezXAKBJB1AEVTt28QS3Gx1IteRfeND+OZ+8bKaNGWQkK9fovKs9C3I
	 ekYSmAZ0YFlUXw7I8ZGy+xtYlHjbuXcDDJiFVvdLim5D7mjKAEzH90xUJCSe74hCgl
	 WhXSWZKjbs//AaENBluuWKmUzoyQkJdiZfsbXZzGMJnuMlwAzU0uxtySurH3GP5wcj
	 O87/vPLNblsue4vLBdu9sXadp5znxEa6UBTsG+KhWna/B52eqKYFbXogx4zScTFF/B
	 G6rAxccTaUw2Q==
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
Subject: [PATCHES v4 0/7] perf build: Add target to install devel packages needed to build perf
Date: Mon, 10 Aug 2026 16:34:59 -0300
Message-ID: <20260810193506.18949-1-acme@kernel.org>
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

-- 
2.55.0

