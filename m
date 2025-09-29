Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E2D4A07
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163876; cv=none; b=uKewlc90xyGfyJks1QAhP0QD7MMyeZQVi48fCXEpzIoCPim7nXw4Dx4So85yuboNOQ4YCWQlZJZo83RSvdIDJbz1BBt2cOdh0Z6xUGwWgvDq+wjSd7DvMH31Ik3qGAsqnDKlCkeJvXLBasCLo8Srk/IcXyQ214gdCOwSSVNp1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163876; c=relaxed/simple;
	bh=0UK3UBAhu6yCCdqynZEv/rSNKmeciofmmL/dNxUWQWw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WyN7LDPu8omeXcCK3SgJe0ZHPeF6H0K5o4QOxkfncyrmUgxSdzYl2df+2f/X5p58MDjCV/2hIMSJEfXqR/yrOtaCxuxXqVbvs8ft6Sp/dG2StjE8ahq5tciIAaZgoNl990jnGA8zXQYXjNw4lzvLe8nKHehZNF5/LupPNhHgYno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3A3F150C;
	Mon, 29 Sep 2025 09:37:45 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78C2A3F66E;
	Mon, 29 Sep 2025 09:37:52 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 00/25] perf arm_spe: Extend operations
Date: Mon, 29 Sep 2025 17:37:36 +0100
Message-Id: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANC12mgC/3WNQQ6CMBBFr0JmbU1bkQIr72FIU+hUuoA2UyQaw
 t2tuHYzyfs//80GCcljgrbYgHD1yYc5gzgVMIxmfiDzNjNILq+8lpxFJKfTM8ZAizY06RRxFez
 C+gqdrdygVC8hzyOh869Dfe8yjz4tgd7Hp1V805+04fV/aT6cKSucKctGCGlvuT0PYYJu3/cPu
 qKGy74AAAA=
X-Change-ID: 20250820-perf_support_arm_spev1-3-b6efd6fc77b2
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=3423;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=0UK3UBAhu6yCCdqynZEv/rSNKmeciofmmL/dNxUWQWw=;
 b=3ej9XOeB0onJXrW8RiIvgXIHir+PmuJjJ1isNnwPuDFK2edcpQAn0ay+D9HlmLh5Y0aE9Pme3
 coftzUCrP9hAySe5goy4K/vA3RJhY9D1Yehm6C59SU8gmpUMwFo57Zs
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series enhances tooling to support new operations:

  - Support for MTE tag since Arm SPE v1.3;
  - Support for Advanced SIMD extension and SVE operations;
  - Support memcpy, memset and GCS operations;
  - Support extended operations for atomic, Acquire/Release and
    Exclusive instructions.
  - Enhance the data source for associated info, like floating-point,
    conditional, data processing, etc.

This series is divided into three parts:

  Patches 01 ~ 06: Support raw dump for new operations;
  Patches 07 ~ 18: Export the operation info into records, so that the
                   information can be later consumed by samples.
  Patches 19 ~ 25: Set the operation info into sample's data source and
                   SIMD flag, and updated the document.

This patch series is tested on FVP. I verified Arm SPE trace data with
kselftest's MTE tag test and SVE test. For GCS test, I verified the SPE
decoding with I manually modifying perf binary file.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Leo Yan (25):
      perf arm_spe: Fix memset subclass in operation
      perf arm_spe: Unify operation naming
      perf arm_spe: Decode GCS operation
      perf arm_spe: Rename SPE_OP_PKT_IS_OTHER_SVE_OP macro
      perf arm_spe: Decode ASE and FP fields in other operation
      perf arm_spe: Decode SME data processing packet
      perf arm_spe: Remove unused operation types
      perf arm_spe: Consolidate operation types
      perf arm_spe: Introduce data processing macro for SVE operations
      perf arm_spe: Report register access in record
      perf arm_spe: Report MTE allocation tag in record
      perf arm_spe: Report extended memory operations in records
      perf arm_spe: Report associated info for SVE / SME operations
      perf arm_spe: Report memset and memcpy in records
      perf arm_spe: Report GCS in record
      perf arm_spe: Expose SIMD information in other operations
      perf arm_spe: Expose length for SVE and SME operations
      perf arm_spe: Synthesize memory samples for SIMD operations
      perf/uapi: Extend data source fields
      perf mem: Print extended fields
      perf arm_spe: Set extended fields in data source
      perf sort: Support sort ASE and SME
      perf sort: Sort disabled and full predicated flags
      perf report: Update document for SIMD flags
      perf arm_spe: Improve SIMD flags setting

 include/uapi/linux/perf_event.h                    | 28 +++++++-
 tools/include/uapi/linux/perf_event.h              | 28 +++++++-
 tools/perf/Documentation/perf-report.txt           |  5 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  | 59 +++++++++++++++--
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  | 56 +++++++++-------
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 53 ++++++++-------
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     | 40 +++++++----
 tools/perf/util/arm-spe.c                          | 77 +++++++++++++++++-----
 tools/perf/util/mem-events.c                       | 58 +++++++++++++++-
 tools/perf/util/sample.h                           | 11 +++-
 tools/perf/util/sort.c                             | 15 ++++-
 11 files changed, 336 insertions(+), 94 deletions(-)
---
base-commit: c17dda8013495d8132c976cbf349be9949d0fbd1
change-id: 20250820-perf_support_arm_spev1-3-b6efd6fc77b2

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

