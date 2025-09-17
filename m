Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29012FE599;
	Wed, 17 Sep 2025 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130925; cv=none; b=cxirjVBkmoDKB7KSwyol+WjbX7qaQkQakxgG9sEFS9c9p6dQY4t9a5b5SpsOeOG+VLEkH+cpkPPu3qlJTHX14mDyUvKZOfmZVF/E48ydIlXbiTOlAkWdxQ5hemmovAGKjRR86Rl3CtpUUdAmVtWCHpWRv8ugfNUA+/QTe2QjCws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130925; c=relaxed/simple;
	bh=7d6idTSBvkiqCwUiJ/luxxi9bE5VUTAm37cIjDh+ZzA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q4BDvhypJbZthtJCYiUW/8jijNqbrtMo2TfZsWJPYUDEl0IjNjjqYPgnXaDsBhtwlzhlEj1VpyPBj1K0Ze8InOHhSTcrOyJuoDRdQbz9CamUNMtmSVG3qqH5K/IARteiKV6S5K61bzMqsaGhOd1zFe9tok+qaf3Rynz5nq4gvxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2D562696;
	Wed, 17 Sep 2025 10:41:54 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DD343F694;
	Wed, 17 Sep 2025 10:42:01 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 0/2] perf: Fix overflow in PERF_IDX2OFF() for Arm SPE and
 TRBE drivers
Date: Wed, 17 Sep 2025 18:41:37 +0100
Message-Id: <20250917-fix_aux_trace_index-v1-0-e36a76ac6292@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANHyymgC/x2MQQqAIBAAvyJ7TtDQxL4SIWJb7cVCK4Tw70nHg
 Zl5IWMizDCyFxI+lOmIDWTHIOw+bshpaQy96LWw0vCVivN3cVfyAR3FBQu3RunBqFWLQUIrz4R
 N+6/TXOsHEUNqjWUAAAA=
X-Change-ID: 20250917-fix_aux_trace_index-9745674f5061
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Tamas Zsoldos <tamas.zsoldos@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758130921; l=922;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=7d6idTSBvkiqCwUiJ/luxxi9bE5VUTAm37cIjDh+ZzA=;
 b=l1R2E0wH9AF+zWn77eji4SNZvlIIGpnYbl+xIy2V8F3ACCoxcbAm1QcrImRDRoMH34+wF7ewX
 gwCmdpX6BpVASGS3IqfhOCW5XbZoPd+r27JfNEKkBhN9Om/ToECELvJ
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

If the AUX buffer size is specified as 2 GiB or larger, the expression
"(buf)->nr_pages << PAGE_SHIFT" may exceed 0x8000_0000. Since
(buf)->nr_pages is a signed integer, the shift can overflow and produce
a negative value. As a result, PERF_IDX2OFF() fails to work correctly.

Fix this by casting (buf)->nr_pages to unsigned long before the shift,
which allows PERF_IDX2OFF() to handle large buffers properly.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Leo Yan (2):
      coresight: trbe: Prevent overflow in PERF_IDX2OFF()
      perf: arm_spe: Prevent overflow in PERF_IDX2OFF()

 drivers/hwtracing/coresight/coresight-trbe.c | 3 ++-
 drivers/perf/arm_spe_pmu.c                   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)
---
base-commit: 5aca7966d2a7255ba92fd5e63268dd767b223aa5
change-id: 20250917-fix_aux_trace_index-9745674f5061

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

