Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F632032D;
	Tue, 30 Sep 2025 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251317; cv=none; b=cQNDtAOCyf8kjA7BWInunObI0kjTnmbRhwCVKeN46u+aUdf1nnIaGfgssEoZ73wx37zkhViQ1DQHLwZeHMEoY1l5X4DdkV6oBsAmBoYwaLBQMQMwfkfhcROeP0ajv7+QC/K6yVo51GMQLc7UIZ/N0RNxK5haXmhjHY3518g8WJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251317; c=relaxed/simple;
	bh=DG99HF4Lne9RqdlvTT1l9WWDXFii+MEmJGhK5urOu34=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FPrw98z0K9QPrNzsmQG5iKd2ROQky0wmlm5Q60ibWC6IYL47TmDdUw+CBJ9/5fDItTUntxO59mtI/hpglOidyvQIxp2FLKERCRRc1Qg/+vHeqGin75enteowtyvQT4xRpHjVsII1wzyUtCrLyoo0BCfogyV30gyCjcFhYeC82bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48AC9106F;
	Tue, 30 Sep 2025 09:55:06 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C83283F59E;
	Tue, 30 Sep 2025 09:55:11 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/8] perf build: Support building with Clang
Date: Tue, 30 Sep 2025 17:54:48 +0100
Message-Id: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFgL3GgC/3WNQQ6CMBBFr0JmbU0paQKuvIchpGUGmSgtmSrRE
 O5uJW5dvpf891dIJEwJTsUKQgsnjiGDORTQjy5cSTFmBqON1U1p1UwydP7Jd+xcQImMXcCbslp
 7W3lydWMhj2ehgV97+NJmHjk9orz3n6X82l/S/E0updKq9pV1DpEq7M9OpmMfJ2i3bfsAMmNGW
 boAAAA=
X-Change-ID: 20250915-perf_build_android_ndk-500b53bea895
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 llvm@lists.linux.dev, linux-riscv@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759251311; l=2242;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=DG99HF4Lne9RqdlvTT1l9WWDXFii+MEmJGhK5urOu34=;
 b=SzjrvsCzykN6+u62532Hnbo0JlFkPjxkoqgejd67nbrkmjwphzWlZC5C/EYLaAIZAUUMn/YrQ
 +jKctUmlXEsCi+gBra8alvZCQjLe4NPgx/o3F58YKpFdhXlWZjPqcqJ
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series adds support for building perf with Clang, following the
discussion in [1]. Because the Android NDK uses Clang by default,
enabling Clang builds naturally covers Android as well.

The series is organized as follows:

  - Patches 1–2: Fix two bugs found with Clang.
  - Patches 3–6: Correct CROSS_ARCH and dismiss Clang build warnings.
  - Patches 7–8: Enable Clang in the Makefile and update the
    documentation.

Testing:

  - Clang 15.0.7 on Ubuntu 22.04.5: native and cross-compiling (aarch64)
  - Clang 18.1.3 on Ubuntu 24.04.2: native and cross-compiling (aarch64)
  - Android NDK r27d (latest LTS): cross-compiling (aarch64)

[1] https://lore.kernel.org/linux-perf-users/20240715143342.52236-1-leo.yan@arm.com/

---
Changes in v2:
- Dropped the patch for dismissing warning in bpftool.
- Refined the document. (Ian)
- Link to v1: https://lore.kernel.org/r/20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com

---
Leo Yan (8):
      tools build: Align warning options with perf
      perf python: split Clang options when invoking Popen
      perf: build: Correct CROSS_ARCH for clang
      perf test coresight: Dismiss clang warning for memcpy thread
      perf test coresight: Dismiss clang warning for thread loop
      perf test coresight: Dismiss clang warning for unroll loop thread
      perf build: Support build with clang
      perf docs: Document building with Clang

 tools/build/feature/Makefile                       |  6 +-
 tools/perf/Documentation/Build.txt                 | 15 ++++
 tools/perf/Documentation/android.txt               | 80 ++--------------------
 tools/perf/Makefile.config                         | 32 ++++++++-
 tools/perf/Makefile.perf                           |  2 +-
 .../shell/coresight/memcpy_thread/memcpy_thread.c  |  2 +
 .../shell/coresight/thread_loop/thread_loop.c      |  4 +-
 .../unroll_loop_thread/unroll_loop_thread.c        |  4 +-
 tools/perf/util/setup.py                           |  5 +-
 9 files changed, 67 insertions(+), 83 deletions(-)
---
base-commit: c17dda8013495d8132c976cbf349be9949d0fbd1
change-id: 20250915-perf_build_android_ndk-500b53bea895

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

