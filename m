Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211BD18A938;
	Mon, 15 Jul 2024 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053780; cv=none; b=MJUapojlTaFXlBoa5PRnAaypYTcXA0K6qaKgXVTeD4ULAQqXYNK/1GyeikWzCEfbu3839clRZMGstS04+WdN16rxEFeThJt8NYLnTC2xldrkuEWgmFozt8P8RgLNYTRbbpO280wreBfYBmeiOnxoTjJFy7nwCLTlKymofKUE3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053780; c=relaxed/simple;
	bh=C0JJocGvXe5PpAqvz7ombWEeK3Q4KAL96hAxTPsrwZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ekL2HysIix3fY/6AAt9gPy+9nJ2seTuYMIh17k7k4SyjIbIBDgPaiq99cLSx9x6lmX1ng/2530vXLey3kGPnYN24CaAWXbcMjvYPsDSF048XQs2PBVAvhwtJ/0oSJWY+Ccm27WOuaqUFLERZkHTmrrX1JWFgSxW+pNDk+jdBWiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 553B0DA7;
	Mon, 15 Jul 2024 07:30:01 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 73D733F766;
	Mon, 15 Jul 2024 07:29:34 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	amadio@gentoo.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 0/6] perf: build: Fix cross compilation
Date: Mon, 15 Jul 2024 15:29:15 +0100
Message-Id: <20240715142921.51881-1-leo.yan@arm.com>
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

The patch 06 adds document for how to cross compile.

This patch series is tested for building perf on x86_64 host for Arm64
target, with verified on Debian two distros (buster and bookworm).

Changes from v3:
- Added more completed comments and logs for PKG_CONFIG_SYSROOT_DIR.
  (Namhyung)
- Didn't include the patch 07 for "perf docs: Remove the Android cross
  building document" in this version, which will be sent out separately.
  (Namhyung/James)

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


Leo Yan (6):
  perf: build: Setup PKG_CONFIG_LIBDIR for cross compilation
  perf: build: Set Python configuration for cross compilation
  perf: build: Only link libebl.a for old libdw
  perf: build: Link lib 'lzma' for static build
  perf: build: Link lib 'zstd' for static build
  perf docs: Document cross compilation

 tools/build/feature/Makefile       | 53 ++++++++++++++++++++++++------
 tools/perf/Documentation/Build.txt | 37 +++++++++++++++++++++
 tools/perf/Makefile.config         | 20 ++++++++++-
 tools/perf/Makefile.perf           | 27 ++++++++++++++-
 4 files changed, 125 insertions(+), 12 deletions(-)

-- 
2.34.1

