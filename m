Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577BC249F9;
	Wed, 17 Jul 2024 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204580; cv=none; b=iIgXASNb+ps9ZCntBqtVKy6FWecGa8GXbauqkNa2IOAfQH/SOWgrPDDpSTAhoFXZHvJyqvf/ufg/8TvMRYdX35HrFPghAjNvdh2BhpJoHLHgRrpMq33EYTQUhy8ytl2X/fBs5WKKk060JCzXF4Vw5EdpGs2r29EvlZwx9WRRNAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204580; c=relaxed/simple;
	bh=dx8bXWJYdEelq1uVPl5fWI5ojcRkhKpHSLn+/1ARlis=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Q472wDre7BebayX3ZAHENzsDdkDtqv/sH7rJQh8XMAbMVZi1AZxZTuf2b269okqeu1DsohvJjuaIr2MMZdOICYXTzEkJCq5YtBran51LNlFv8A/6apl/KqJkIZ1BrBuPzCV1J1qjRhLxSL1guzcPky+NmOF911pztZt7KvJEv18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4A3F1063;
	Wed, 17 Jul 2024 01:23:22 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 911F43F762;
	Wed, 17 Jul 2024 01:22:55 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@linaro.org>,
	amadio@gentoo.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v5 0/6] perf: build: Fix cross compilation
Date: Wed, 17 Jul 2024 09:22:05 +0100
Message-Id: <20240717082211.524826-1-leo.yan@arm.com>
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

Changes from v4:
- Polished patch 06 for removing redundant sentences.

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
 tools/perf/Documentation/Build.txt | 28 ++++++++++++++++
 tools/perf/Makefile.config         | 20 ++++++++++-
 tools/perf/Makefile.perf           | 27 ++++++++++++++-
 4 files changed, 116 insertions(+), 12 deletions(-)

-- 
2.34.1

