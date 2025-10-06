Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E74F2D8399;
	Mon,  6 Oct 2025 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767702; cv=none; b=UtO3JdrhRZt4O7K3l68V4WxFED1K4yIx3/w/7kXp0hvwfWBKvn53/Yl0ykwTooMlSaKk3wYyNXRm6xqWIGLkc9Kj3DMvGHHw73JA4KA4FlRVLcEuQ22GDoPoT8NXckkn1O25ht08h2hXBMRzU2IWNhfQwgmofu26w1GX7x9ZEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767702; c=relaxed/simple;
	bh=8Q7cwgPG2l22cdHPml+9mko6bkVk2uyGrrnIsI+emBo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ebWKinityCtLdw/4QPvMI/dNrAURE28ar/ioLyZ9xNYvm0popxmzgtO29uNqKWbA8JxVZ7n/0wQoHkmYPk2ULlbrUKEdm8q+fUxCt4jirJz98gOBv8xM56Q3uFc33Hxp6dilYXQoEnxWhwu7fiJ082uqGDXSDjSn+JBEg9SjWe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 976051516;
	Mon,  6 Oct 2025 09:21:31 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AE133F738;
	Mon,  6 Oct 2025 09:21:36 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 0/9] perf build: Support building with Clang
Date: Mon, 06 Oct 2025 17:21:22 +0100
Message-Id: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAILs42gC/3XNTQrCMBCG4auUrI3kp8HWlfcQKUlnaoM2KYkGp
 fTupkXQTZfvB/PMRCIGi5Eci4kETDZa73LIXUHaXrsrUgu5iWBCsZorOmLoGvO0d2i0g+AtNA5
 uVDFmlDSoq1qRfDwG7Oxrhc+X3L2NDx/e65/El/VLik0yccpoZaTSGgAltCcdhn3rB7KASfwhk
 m0iIiMCdVkyc8CO8R8yz/MHpk3A6/8AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759767696; l=8424;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=8Q7cwgPG2l22cdHPml+9mko6bkVk2uyGrrnIsI+emBo=;
 b=era/Wn5yodUf8G/6eSt5+q27j9CLCLY4QnZQ3zTpwI0lPrBGffLBG0rYLftRJb9wkB2/uvw+k
 NOmc48B2MXRDzsxyQxJ+4tepzbZRBFj9EPNrwY43ajZABV4QdLvNASB
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series adds support for building perf with Clang, following the
discussion in [1]. Because the Android NDK uses Clang by default,
enabling Clang builds naturally covers Android as well.

The series is organized as follows:

  - Patches 1~2: Fix two bugs found with Clang.
  - Patches 3~7: Correct CROSS_ARCH, Disable thread safety analysis for
                 perl header, and dismiss Clang build warnings.
  - Patches 8~9: Enable Clang in the Makefile and update the
                 documentation.

Testing:

Tested with linux-tools-container-builds [2], which based on Arnaldo's
build test container but with several fixes for cross building with
Clang:

  - All clang native builds on x86_64 have passed.
  - The cross builds for arm64/mips/mips64/mipsel/riscv64 have passed.

Only a pity thing is I cannot build successfully with clang for
ubuntu:20.04-x-powerpc64el (in below log, it only builds with GCC).
The cross config does not work well on Ubuntu 20.04 due to failure
"No gnu/libc-version.h found, please install glibc-dev[el]". I confirmed
that powerpc64el cross build can make success on Ubuntu 24.04, the
failure on Ubuntu 20.04 should not be caused by perf build.

  Subject: tools build test for http://localhost/perf/perf-6.17.0-rc6.tar.xz 

     1   201.44 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
     2   154.82 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7 flex 2.6.4
     3   136.07 alpine:3.18                   : Ok   gcc (Alpine 12.2.1_git20220924-r10) 12.2.1 20220924 , Alpine clang version 16.0.6 flex 2.6.4
     4   150.21 alpine:3.19                   : Ok   gcc (Alpine 13.2.1_git20231014) 13.2.1 20231014 , Alpine clang version 17.0.5 flex 2.6.4
     5   143.50 alpine:3.20                   : Ok   gcc (Alpine 13.2.1_git20240309) 13.2.1 20240309 , Alpine clang version 17.0.6 flex 2.6.4
     6   146.08 amazonlinux:2023              : Ok   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5) , clang version 15.0.7 (AWS 15.0.7-3.amzn2023.0.4) flex 2.6.4
     7   147.19 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2) flex 2.6.4
     8   117.92 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 13.0.1-6~deb11u1 flex 2.6.4
     9   121.54 debian:12                     : Ok   gcc (Debian 12.2.0-14+deb12u1) 12.2.0 , Debian clang version 14.0.6 flex 2.6.4
    10   128.64 debian:experimental           : Ok   gcc (Debian 15.2.0-4) 15.2.0 , Debian clang version 19.1.7 (7) flex 2.6.4
    11    96.47 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 15.2.0-4) 15.2.0 , Debian clang version 19.1.7 (7) flex 2.6.4
    12    72.89 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 14.2.0-13) 14.2.0 , Debian clang version 19.1.7 (7) flex 2.6.4
    13    73.31 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 14.2.0-13) 14.2.0 , Debian clang version 19.1.7 (7) flex 2.6.4
    14    71.69 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 14.2.0-13) 14.2.0 , Debian clang version 19.1.7 (7) flex 2.6.4
    15   151.92 fedora:35                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-3) , clang version 13.0.1 (Fedora 13.0.1-1.fc35) flex 2.6.4
    16   146.99 fedora:36                     : Ok   gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4) , clang version 14.0.5 (Fedora 14.0.5-2.fc36) flex 2.6.4
    17   139.58 fedora:37                     : Ok   gcc (GCC) 12.3.1 20230508 (Red Hat 12.3.1-1) , clang version 15.0.7 (Fedora 15.0.7-2.fc37) flex 2.6.4
    18   142.00 fedora:38                     : Ok   gcc (GCC) 13.2.1 20240316 (Red Hat 13.2.1-7) , clang version 16.0.6 (Fedora 16.0.6-4.fc38) flex 2.6.4
    19   140.18 fedora:39                     : Ok   gcc (GCC) 13.3.1 20240913 (Red Hat 13.3.1-3) , clang version 17.0.6 (Fedora 17.0.6-2.fc39) flex 2.6.4
    20   139.38 fedora:40                     : Ok   gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3) , clang version 18.1.8 (Fedora 18.1.8-2.fc40) flex 2.6.4
    21   136.26 fedora:41                     : Ok   gcc (GCC) 14.3.1 20250808 (Red Hat 14.3.1-3) , clang version 19.1.7 (Fedora 19.1.7-5.fc41) flex 2.6.4
    22   135.38 fedora:42                     : Ok   gcc (GCC) 15.2.1 20250808 (Red Hat 15.2.1-1) , clang version 20.1.8 (Fedora 20.1.8-4.fc42) flex 2.6.4
    23   127.55 fedora:rawhide                : Ok   gcc (GCC) 15.2.1 20250924 (Red Hat 15.2.1-2) , clang version 21.1.2 (Fedora 21.1.2-1.fc44) flex 2.6.4
    24   180.17 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 15.0.7 flex 2.6.4
    25   169.40 opensuse:15.5                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 15.0.7 flex 2.6.4
    26   167.36 opensuse:15.6                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 17.0.6 flex 2.6.4
    27   154.82 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 15.2.0 , clang version 21.1.2 flex 2.6.4
    28   145.89 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-28.0.1) , clang version 19.1.7 ( 19.1.7-2.module+el8.10.0+90583+7e562d96) flex 2.6.1
    29   139.68 oraclelinux:9                 : Ok   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5.0.1) , clang version 19.1.7 ( 19.1.7-2.el9) flex 2.6.4
    30    40.17 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0  flex 2.6.4
    31    20.83 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.5.0-1ubuntu1~20.04) 10.5.0  flex 2.6.4
    32   127.75 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.4.0-1ubuntu1~22.04.2) 11.4.0 , Ubuntu clang version 14.0.0-1ubuntu1.1 flex 2.6.4
    33    92.25 ubuntu:22.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0 , Ubuntu clang version 14.0.0-1ubuntu1.1 flex 2.6.4
    34   126.64 ubuntu:24.04                  : Ok   gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0 , Ubuntu clang version 18.1.3 (1ubuntu1) flex 2.6.4
    35   130.95 ubuntu:25.04                  : Ok   gcc (Ubuntu 14.2.0-19ubuntu2) 14.2.0 , Ubuntu clang version 20.1.2 (0ubuntu1) flex 2.6.4

[1] https://lore.kernel.org/linux-perf-users/20240715143342.52236-1-leo.yan@arm.com/
[2] https://github.com/Leo-Yan/linux-tools-container-builds/tree/fix-riscv64-cross-build

---
Changes in v3:
- Fixed build failure with musl lib.
- Disabled thread safety analysis for perl head.
- Link to v2: https://lore.kernel.org/r/20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com

Changes in v2:
- Dropped the patch for dismissing warning in bpftool.
- Refined the document. (Ian)
- Link to v1: https://lore.kernel.org/r/20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com

---
Leo Yan (9):
      tools build: Align warning options with perf
      perf python: split Clang options when invoking Popen
      perf build: Correct CROSS_ARCH for clang
      perf build: Disable thread safety analysis for perl header
      perf test coresight: Dismiss clang warning for memcpy thread
      perf test coresight: Dismiss clang warning for thread loop
      perf test coresight: Dismiss clang warning for unroll loop thread
      perf build: Support build with clang
      perf docs: Document building with Clang

 tools/build/feature/Makefile                       |  6 +-
 tools/perf/Documentation/Build.txt                 | 15 ++++
 tools/perf/Documentation/android.txt               | 80 ++--------------------
 tools/perf/Makefile.config                         | 33 ++++++++-
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/scripts/perl/Perf-Trace-Util/Build      |  2 +-
 .../shell/coresight/memcpy_thread/memcpy_thread.c  |  2 +
 .../shell/coresight/thread_loop/thread_loop.c      |  4 +-
 .../unroll_loop_thread/unroll_loop_thread.c        |  4 +-
 tools/perf/util/scripting-engines/Build            |  2 +-
 tools/perf/util/setup.py                           |  5 +-
 11 files changed, 70 insertions(+), 85 deletions(-)
---
base-commit: c17dda8013495d8132c976cbf349be9949d0fbd1
change-id: 20250915-perf_build_android_ndk-500b53bea895

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

