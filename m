Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10AD2EE;
	Sat,  6 Jul 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720290572; cv=none; b=Wi4U+bxsRWqYCwAXCx0oeBjFyqVc4zp++ryNVnunpBveq0pQib0w3bdevIsYJ6+tW4sF4gK9LStgoH6uxYSMKX6oJB6C2/9M5aduCbi9rVbUTpB0sCioU7LLURvJyww1mMkrPiL6pO63hhSxHQN7qQfCH2kbZ9l5toCLyb/GWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720290572; c=relaxed/simple;
	bh=12YS85SciSBN//EP3voiFIw9mhiL7DXMwcBBnHx2X7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZFeWO9+r9dvKATBTqv6IIzQM8CK4A4uCbETHgPJzz9CA+7diewni+KnaGNhFBpckGYIRTvU/JJDxcsaKvNsh33wYrsat3DwLfIWQ1OcyoU3eprcFFieTzXybOVcD6l7JccGhHbZM2/2EfchoTUxIaePxHDxsM1O+uUHxx/0d+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24486DA7;
	Sat,  6 Jul 2024 11:29:53 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 408483F73B;
	Sat,  6 Jul 2024 11:29:25 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Changbin Du <changbin.du@huawei.com>,
	James Clark <james.clark@linaro.org>,
	amadio@gentoo.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 0/7] perf: build: Fix cross compilation
Date: Sat,  6 Jul 2024 19:29:05 +0100
Message-Id: <20240706182912.222780-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes cross compilation issues.

The first patch sets the package path if the package configuration path
is not specified. This helps the compiler to find the architecture's
package in a Multiarch system.

The patch 02 sets the Python configuration path and renames the .so to

The patches 03, 04 and 05 fix the static build failures.

The patch 06 adds document for how to cross compile. The patch 07 is to
remove obsolete info for building perf with Android NDK.

This patch series is tested for building perf on x86_64 host for Arm64
target, with verified on Debian two distros (buster and bookworm).

Changes from v2:
- Reordered lib paths for PKG_CONFIG_LIBDIR. (Namhyung)
- Verified the Android NDK and based on the testing result to remove the
  file android.txt. (Ian)

Changes from v1:
- Kept the cross-compile-pkg-config if it is available. (Namhyung)
- Removed the patch 02 for fixing pkg-config path for libtraceevent, as
  this will be resolved in Guilherme Amadio's patch "perf build: Use
  pkg-config for feature check for libtrace{event,fs}".
- Added patch 06 for document.


Leo Yan (7):
  perf: build: Setup PKG_CONFIG_LIBDIR for cross compilation
  perf: build: Set Python configuration for cross compilation
  perf: build: Only link libebl.a for old libdw
  perf: build: Link lib 'lzma' for static build
  perf: build: Link lib 'zstd' for static build
  perf docs: Document cross compilation
  perf docs: Remove the Android cross building document

 tools/build/feature/Makefile         | 54 +++++++++++++++----
 tools/perf/Documentation/Build.txt   | 37 +++++++++++++
 tools/perf/Documentation/android.txt | 78 ----------------------------
 tools/perf/Makefile.config           | 20 ++++++-
 tools/perf/Makefile.perf             | 26 +++++++++-
 5 files changed, 125 insertions(+), 90 deletions(-)
 delete mode 100644 tools/perf/Documentation/android.txt

-- 
2.34.1

