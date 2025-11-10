Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686BB28000B;
	Mon, 10 Nov 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792126; cv=none; b=cDCzZ+WfUFOp9Rfue0Syxf4IZ1q6ui8wPYwOqYTXKzcPQgMYyivr3732QXDBmKs6uvkWHsM0HblaHBcLLaDtPyD/WIRCy0NEmJ0hhLh71nWM75FNxmqJKUvSrKyJz23UY6zVqcmU8zqOPhGcToywNu0XT643BJ5kfhJb+LZ8FH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792126; c=relaxed/simple;
	bh=9qj+/Tmhl7LZo6Iri04G9/1be9SzjZcpr/NFCxaSF8s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bGlnE9gjvIKQ9HcxGNiBONjdmMKReaKyxhVmjKgZI82OiJjMFtjWe8GxnnT+CTzhRtovU7UwJANlBxzS/uiEwxu+5dVm3zsBD+pp8KiaRDGuVLymO1X/b3yYmak4A0YagiwwLvEplTlBENosGpZ0RyBxHkzYaOUXaODB/bPhiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B49402B;
	Mon, 10 Nov 2025 08:28:35 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 510CF3F66E;
	Mon, 10 Nov 2025 08:28:42 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/2] perf: arm_spe: Fix trace disabling for invalid
 limits
Date: Mon, 10 Nov 2025 16:28:30 +0000
Message-Id: <20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK4SEmkC/42NWwrCMBBFt1Lm20iSMiJ+uQ8pYZpO2wH7IIlBK
 d27sSvw81wO524QOQhHuFUbBM4SZZkL2FMFfqR5YCVdYbDaotEGFYXJxZVdL2+Xwmv2lLhz/ZM
 GZQjb+mI11dRCCayBi3XEH03hUWJawuf4yua3/pXNRhmFiFzbq29J473IZ79M0Oz7/gVHBGY6w
 gAAAA==
X-Change-ID: 20251015-arm_spe_fix_truncated_flag-1a5b3620a3ab
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792122; l=1249;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=9qj+/Tmhl7LZo6Iri04G9/1be9SzjZcpr/NFCxaSF8s=;
 b=QPnGaJt6VTtGLNALrrNz4ryCFP7P25/YrHn2ARSpS71fbBCYa14eb9t0KAoX5HNJCF185nL/F
 rCj04qrE/0ZA350MgTnck4i4/8EmBl2+CkZVhfJKMuOov2IbYmMDXB1
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series fixes trace disabling issues that occur when failed to
calculate a valid limit (E.g., due to buffer overflow or insufficient
space during padding).

The first patch improves arm_spe_perf_aux_output_begin() for failure
handling, ensuring that all failure cases set the PERF_HES_STOPPED
flag.

The second patch applies the profiling buffer disable flow in the
interrupt handler when the PERF_HES_STOPPED flag has been set.

This series has been verified on Orion6 board.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v2:
- Added the patch 01.
- Did not rely on irq work for disabling as the disable callback will
  skip operations after PERF_HES_STOPPED flag has been set.
- Link to v1: https://lore.kernel.org/r/20251015-arm_spe_fix_truncated_flag-v1-1-555e328cba05@arm.com

---
Leo Yan (2):
      perf: arm_spe: Correct setting the PERF_HES_STOPPED flag
      perf: arm_spe: Ensure profiling buffer is properly disabled

 drivers/perf/arm_spe_pmu.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)
---
base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
change-id: 20251015-arm_spe_fix_truncated_flag-1a5b3620a3ab

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

