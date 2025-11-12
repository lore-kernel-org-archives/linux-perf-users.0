Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAB82C1581;
	Wed, 12 Nov 2025 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971895; cv=none; b=rVv9kuWx87nccriggX0J4+yxR728n1Dr1L2JWkNdBBo6YpNZWlEsDN1aIpwCcqlyulr3iKNDQCtB2l+vWYX7xtH/6e8RU7WlRVXSU/L7OufSpz2ynKbQXf5t/h8jCm7ftx1hrQceWUY+mpEh/RmtOVwyQJX+GzEbasO0ZYwO3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971895; c=relaxed/simple;
	bh=uK3OTAm25/Es3W4+oaneRzHWBZP3PdoEBFUSAKd0eE4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d9mW+APbu4Hq4EQMsKDWOanOi06epBYKo6X26RtyyNu/GBxmukYR6rflpZ9c9N02K2xKjdDDg8Xe/ppF3y/m9Sfpl7ISJXEWbRxKMMfIoEZHTDKLhDirpVBUCqqp5HuvEz7msJJgcc1e6hSB1Bsag5+smWxeuIOqlrZEB5SEf/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8060F1515;
	Wed, 12 Nov 2025 10:24:45 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BE273F63F;
	Wed, 12 Nov 2025 10:24:51 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 00/25] perf arm_spe: Extend operations
Date: Wed, 12 Nov 2025 18:24:26 +0000
Message-Id: <20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANrQFGkC/4WOQQ6CMBBFr2K6tqYzFAquvIcxBOhUukCaFomGc
 HcLJLpSN5P8mbw3f2KBvKXAjruJeRptsP0thmS/Y01b3a7ErY6ZocBU5Ci4I2/KcHeu90NZ+a4
 MjkbgCa8zMjozjVI1sog7T8Y+VvX5EnNrw9D75/pphGW7SQuRf5fGIbjSYCopCwDUp3g9NH23f
 NhwLP7gAKmokyZP8lS98aXRiO8WIED90GDUoJZAUsmMoP5o5nl+AfhPUwlEAQAA
X-Change-ID: 20250820-perf_support_arm_spev1-3-b6efd6fc77b2
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762971890; l=4088;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=uK3OTAm25/Es3W4+oaneRzHWBZP3PdoEBFUSAKd0eE4=;
 b=y2ixQtt0MQOdT7sIMM7VD4HKk6uGxtr4Xzs+6r6u722/njjPnwDnXZ3BQuzgL1esC62nECuko
 Jkh4PpJUBetCajuX3Ig39n4jo8cX3egV7yiPFWcmFdffU5K/pIn9CyD
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
  Patches 07 ~ 17: Export the operation info into records, so that the
                   information can be later consumed by samples.
  Patches 18 ~ 25: Set the operation info into sample's data source and
                   SIMD flag, and updated the document.

This patch series is tested on FVP for native parsing and x86_64 for
cross parsing.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v3:
- Rebased on the latest perf-tools-next branch.
- Link to v2: https://lore.kernel.org/r/20251017-perf_support_arm_spev1-3-v2-0-2d41e4746e1b@arm.com

Changes in v2:
- Refined to use enums for 2nd operation types. (James)
- Avoided adjustment bit positions for operations. (James)
- Used enum for extended operation type in uapi header and defined
  individual bit field for operation details in uaip header. (James)
- Refined SIMD flag definitions. (James)
- Extracted a separate commit for updating tool's header. (James/Arnaldo)
- Minor improvement for printing memory events.
- Rebased on the latest perf-tools-next branch.
- Link to v1: https://lore.kernel.org/r/20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com

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
      perf arm_spe: Synthesize memory samples for SIMD operations
      perf/uapi: Extend data source fields
      tools/include: Sync uapi/linux/perf.h with the kernel sources
      perf mem: Print extended fields
      perf arm_spe: Set extended fields in data source
      perf sort: Support sort ASE and SME
      perf sort: Sort disabled and full predicated flags
      perf report: Update document for SIMD flags
      perf arm_spe: Improve SIMD flags setting

 include/uapi/linux/perf_event.h                    | 32 ++++++++-
 tools/include/uapi/linux/perf_event.h              | 32 ++++++++-
 tools/perf/Documentation/perf-report.txt           |  5 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  | 56 ++++++++++++++--
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  | 61 +++++++++--------
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 53 ++++++++-------
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     | 40 +++++++----
 tools/perf/util/arm-spe.c                          | 77 +++++++++++++++++-----
 tools/perf/util/mem-events.c                       | 66 +++++++++++++++++--
 tools/perf/util/sample.h                           | 21 ++++--
 tools/perf/util/sort.c                             | 21 ++++--
 11 files changed, 359 insertions(+), 105 deletions(-)
---
base-commit: da8fcfba0854dbe0b0eca465d35620c9cf4c89c1
change-id: 20250820-perf_support_arm_spev1-3-b6efd6fc77b2

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

