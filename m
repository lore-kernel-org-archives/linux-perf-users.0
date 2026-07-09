Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F007439BFFA;
	Thu,  9 Jul 2026 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624946; cv=none; b=gFIi9SfOqKoqJWJmC8rUEQXOgkbGtmHQ38OkzVnvTpOCN2SRammPKiR1vbVi12LOfcZ/kefW97LklGg0abdDmudl/FRc7bdsmvodzHR8+OEweCC94/5uPjOISJhYK6hMmGfCk6d45iMLdXLnF8iRcVl6vBMP50nxKyZrh2J7zPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624946; c=relaxed/simple;
	bh=6fbc1zMOckQ9tYF/nxEIPgsTtwm0FfeMsCMDNf7HVNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LMl6bhy/yTk0Rd8TjnAVKHQpqxXFlRTqZU/q8p0L6fOK0kVubgzJrauZ8sqL1K3yVJv/EWJsA8cLPDaIjVTLIBQNvbvMzkNbZOYf9tdJqdLpRG3zYFZWR4/2E1v/7epje233uIzs3CmR77ybVRoUjSpmipKgqMJEFXOH0mdCtzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c/735BIY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c/735BIY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B60C524C0;
	Thu,  9 Jul 2026 12:22:18 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DDE53FC81;
	Thu,  9 Jul 2026 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783624943; bh=6fbc1zMOckQ9tYF/nxEIPgsTtwm0FfeMsCMDNf7HVNQ=;
	h=From:To:Cc:Subject:Date:From;
	b=c/735BIYMdsOvnrBi/dVQA1f9+apLmvxS87xrc0TC4U/uhnRbqLX4+qC5j9yqYvRZ
	 Rb8EBQQjhcR44x3qzVB9jBixy3PTNELAR2XqSEhSyVTqbs+u7xCLe4aZ6VyUl8IhGr
	 io5B7ZRQlxgkrpWrWwdD9Yv5sqrFUj1Fk9vTVp7M=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: devicetree@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] perf: Support Arm Bus Monitor Unit
Date: Thu,  9 Jul 2026 20:22:06 +0100
Message-ID: <cover.1783439341.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Here we have the delight of another new PMU driver. While not am Arm
product in its own right, the BMU is found in the latest Neoverse
Compute Subsystems, including the recently-announced AGI CPU.

For now it is expected that BMU users will be ACPI-based (binding in
the latest "ACPI for Arm Components" release[1]), so the token DT
binding is more for completeness and maybe very early bringup hacking,
but there is a chance it may end up being used by more embedded/client-
focused subsystems in future.

And yes, I did initially look at trying to factor out the PMU register
accesses that functionally overlap the existing arm_cspmu code, but it
very quickly became clear that that would end up far bigger and more
complex. This is not a big driver, even with a few dozen lines of
nominally-duplicate (but also simplified since the counter size etc.
is fixed and known) code, so this way it went.

Thanks,
Robin.

[1] https://developer.arm.com/documentation/den0093/latest/


Robin Murphy (2):
  dt-bindings: perf: Add Arm Bus Monitor Unit
  perf: Add Arm Bus Monitor Unit driver

 .../bindings/perf/arm,bus-monitor-unit.yaml   |  33 ++
 drivers/perf/arm_cspmu/Kconfig                |   6 +
 drivers/perf/arm_cspmu/Makefile               |   2 +
 drivers/perf/arm_cspmu/arm-bmu.c              | 538 ++++++++++++++++++
 4 files changed, 579 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/arm,bus-monitor-unit.yaml
 create mode 100644 drivers/perf/arm_cspmu/arm-bmu.c

-- 
2.54.0.dirty

