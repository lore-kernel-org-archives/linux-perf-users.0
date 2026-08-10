Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5958314F70;
	Mon, 10 Aug 2026 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786323098; cv=none; b=M9KD9vNkt5JNb5AeXqSS7ElpZJledrpU3TnjQUEt97Z0Taxj0gVG3P2ZDwkYnLO2kNwi33aXSrG2GFAy6Bz6MB2ghLRqiR/D+prpDFcCUDRApi1U0PG/mI20D0Wgbz89ONuoauLoOIgth4My8/cd3VOH+Z4/kz5bO30VSCeBFT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786323098; c=relaxed/simple;
	bh=PRLqPpVaqLwd44vxlsqTR6uotr35wUcwl7dAATKJupM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsKi9ABjJ8UzJRYGP0iOiAyK5adCQMiMGs+xESxIWLCE6EE3tWciYoYDfrDHsFTXDA41oRea0mJCv97a1zjfAuqL70G5D/0UvhHWO0stP8zZmysUmfe0i1N1LCP1wUxPYqJxN6b9CehmcoJpq9XkE8kAKSwP07C8QX9RlyQ63vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5kE/Tk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5kE/Tk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FE91F00A3A;
	Mon, 10 Aug 2026 00:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786323096;
	bh=d+BwWIf6VyIUvWZ5FsZ+M6SMR9qMLeYFSKsvoAiCigg=;
	h=From:To:Cc:Subject:Date;
	b=i5kE/Tk+aM1Kzf1U8YVPEZJb4NpQOVIpc4nvkgLEpVv6gw9GcJxaeeLix9bvEvwEK
	 Jwrm4pO5bZLeW977B5SfadoRzWLm5KOie814IwlLyiTYjh00HdII3KwPkdOMY2pqsv
	 8o9WhCtDbbH0Wcb1weRaCLFKMSM4kmKuRSAieXT1hK0xojFWRnY79LLdRXqJ07nDNt
	 86hX13ZPow4Js2oxczJRnHOXAGOmlxyYFfvOsjPuEDVkO7CTksYU6l7x0AZH/xpBss
	 7jsqrgoeg5pAEgaBrECsFo0DIHVSo1pdfnyDGHF1I6uJQy2GfT/DOnlOGeS27iN8Kj
	 MxS9+9IfVmM1g==
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
Subject: [PATCHES v1 0/7] perf build: Add target to install devel packages needed to build perf
Date: Sun,  9 Aug 2026 21:51:20 -0300
Message-ID: <20260810005127.289896-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
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

Building perf requires many devel packages (libelf, libdw, libunwind, numactl,
libtraceevent, libbpf, etc.). Today users must iteratively install packages
as each feature check fails. The new target installs the full set in one go.

The first patch adds the framework (make target, distro detection, package
manager drivers). The next four patches add distro-specific package mappings
derived from the headers each feature test requires. The last patch removes
leftover feature test entries for cxx and clang support removed in
56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang for compiling
BPF events (-e foo.c)").

Supported distros (validated in containers, host never modified):
  - Fedora 44 (dnf, 29 packages)
  - Ubuntu 26.04 (apt, 29 packages)
  - Debian 13 (apt, reuses Ubuntu mapping)
  - CentOS 10 (dnf, 29 packages)

On all distros, a clean O= build after running the target enabled every
feature the distro provides (excluding deliberately unmapped deprecated
packages). Re-running the target is a no-op.

This series was developed with assistance from Opencode
(deepseek-v4-flash-free and glm-4-7-flash-ollama-local) for code
analysis, patch generation, and commit message composition.

Regards,

- Arnaldo

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
 tools/perf/scripts/install-build-deps.sh | 560 +++++++++++++++++++++++
 tools/scripts/Makefile.arch              |   2 +-
 tools/scripts/Makefile.include           |   2 +-
 6 files changed, 580 insertions(+), 21 deletions(-)
 create mode 100755 tools/perf/scripts/install-build-deps.sh
