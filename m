Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9F4248880;
	Mon,  1 Dec 2025 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588131; cv=none; b=jioxf4GjuSxXsY0NC8VPGFOxTmqZYxdD/MAOkBwo7BD4PTd9cTMBvLdSq1ohK6xumIdTRqe5uNNJvV/03cHPjFs5cTtAGMxjcFOa3u83+kQu83dRsjDL/DT6W08rc6xEeVSv4KchO34xQ7kCNVwI/VCM1lpFI9UC928/oMNRew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588131; c=relaxed/simple;
	bh=Q418Pi12Y9fylcLKnDQK9SBuEzma5xaeDlTY2E+UtgY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J2vdt+cgBiQkKQ+mtvUSt2T3QKy7ZIg5vrb+SpChYw5BzN+r+J1OrHHIT00KiUDiwVAWy3DuemeU7wXn+9JmN+32wKQyrB55sGndO66YRYTirX4pFVdCfqUYOmkcsjs0mDcniCtPh4uI1ORNCeBIjz2S0I7NnJkbQgv6MU7A7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F50B153B;
	Mon,  1 Dec 2025 03:22:01 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E31B53F59E;
	Mon,  1 Dec 2025 03:22:05 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 00/19] coresight: trbe: Support trigger and circle buffer
 modes
Date: Mon, 01 Dec 2025 11:21:50 +0000
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE56LWkC/x2MSQqAMAwAvyI5W2jqgvoVkaI11VxUUhWh+HeLx
 2GYiRBImAJ0WQShmwPvWwLMM3DruC2keE4MRpsK0Wh1ykR2urwnsUJ+dOcu9kaFqvGNNgXqqqx
 bSP2RND//ux/e9wM5ztXeawAAAA==
X-Change-ID: 20251120-trbe_buffer_refactor_v1-1-8f8023105469
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>, 
 Tamas Zsoldos <tamas.zsoldos@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=3011;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=Q418Pi12Y9fylcLKnDQK9SBuEzma5xaeDlTY2E+UtgY=;
 b=DKvlT12+88iiZfKhYaoXj/K9VVQbojlYhimip3kurywxxJxainaY25rRCVhBH6dz95kgA69TF
 CJn2AMANkYLCCLgaNEBAGSDrgdxxmhyxf3hqoi2odBEi/7JP9dbYmm2
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The current TRBE driver operates only in fill mode, where tracing stops
at the top of buffer and a maintenance interrupt is raised.  Due to
interrupt latency, tracing is halted while the program continues to run,
resulting in trace data lose.

This series enhances the driver for the trigger mode to mitigate trace
discontinuity.  The circle buffer mode is introduced to avoid any
maintenance interrupts during the snapshot session.

It can be divided into three parts for easier review:

  Patches 01~05: Minor refactoring for disabling operations and
                 clearing status.
  Patches 06~12: Refactor fault action and trace size calculation.
  Patches 13~19: Support trigger and circle modes. To better utilize the
                 new buffer modes, perf sets the watermark to
		 one-quarter of the buffer size.

This series is applied on coresight-next branch and has been validated
on Orion O6 board:

  1) The trigger count and wrap mode are verified using Ftrace logs.
  2) A new kunit test module verifies limit and count calculations.
  3) Basic perf record / script commands and module load/unload have
     been tested successfully.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Leo Yan (19):
      coresight: trbe: Use helpers for checking errata
      coresight: trbe: Remove redundant disable operation
      coresight: trbe: Remove buffer disabling in trbe_handle_overflow()
      coresight: trbe: Remove set_trbe_disabled() from the enable flow
      coresight: trbe: Refactor status clearing
      coresight: trbe: Refactor syndrome decoding
      coresight: trbe: Refactor AUX flag setting
      coresight: trbe: Use PERF_AUX_FLAG_PARTIAL instead of PERF_AUX_FLAG_COLLISION
      coresight: trbe: Add fault action argument to trbe_handle_overflow()
      coresight: trbe: Always check fault action when updating buffer
      coresight: trbe: Apply overwrite erratum for only wrap event
      coresight: trbe: Calculate size for buffer wrapping
      coresight: trbe: Remove misleading comment
      coresight: trbe: Refactor compute_trbe_buffer_limit()
      coresight: trbe: Add static key for bypassing trigger mode
      coresight: trbe: Support trigger mode
      coresight: trbe: Enable circle mode for snapshot
      coresight: trbe: Add kunit tests
      perf: cs-etm: Set watermark for AUX trace

 drivers/hwtracing/coresight/Kconfig                |   9 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 .../coresight/coresight-trbe-kunit-tests.c         | 536 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-trbe.c       | 440 +++++++++--------
 drivers/hwtracing/coresight/coresight-trbe.h       | 111 ++++-
 tools/perf/arch/arm/util/cs-etm.c                  |   7 +
 6 files changed, 896 insertions(+), 208 deletions(-)
---
base-commit: 9e9182cab5ebc3ee7544e60ef08ba19fdf216920
change-id: 20251120-trbe_buffer_refactor_v1-1-8f8023105469

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

