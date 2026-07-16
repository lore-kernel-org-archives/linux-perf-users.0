Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED742CAF0;
	Thu, 16 Jul 2026 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214773; cv=none; b=NVkT7XEF4iTaUImfj0lgOWd/JG/v7wTWOAXotoMaWe319VisEfVHudjsSPmEk9Gz9ge5FU+TDq6HCRe/NKU/kmfWikW3tjncYgS5rwzYViDISRpYrTiJ3mHmypO2VtKsKV83a3WNiu7yOc5PEFCTWRzJppazpOAZuoZ5OKJZ9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214773; c=relaxed/simple;
	bh=riNgHQn3hQVJcEeEO/u7syMJef1+ZO+8QXz6OJzfZO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZOSlFcs4y7khE8wMA47l97fSjfS1GdQr678eXylGOiBApTtEF+4kvW5xN54vCOFh1gb8/BxiwR63e2SzqejWKgfSsiQx+/wQHT2f+WmgbgUDhzTEqmeqsRBbS24EyJbRPKSjU1Uk0MXIwKutxp0ZU3dWGdMuu33kkrA0oCYzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uJAM+XmY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uJAM+XmY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3419E1476;
	Thu, 16 Jul 2026 08:12:43 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A8933F66F;
	Thu, 16 Jul 2026 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784214767; bh=riNgHQn3hQVJcEeEO/u7syMJef1+ZO+8QXz6OJzfZO0=;
	h=From:To:Cc:Subject:Date:From;
	b=uJAM+XmYcM21K0hI8+6LuZWyxmhvSCMpYMdH/LKunRHvJF5idzMDKBU9Rf8JSpStq
	 fpuapCdtMhX4QruFEOR8P8qNdS1mOy6EPiQPsK9OTcdbCOw/lAgG6aC5PxyyVgjrMm
	 6G2f8yjiBcbUB3W/0/FMECKf2muMYTsR30SAVfZU=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: devicetree@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] perf: Support Arm Bus Monitor Unit
Date: Thu, 16 Jul 2026 16:12:38 +0100
Message-ID: <cover.1784214112.git.robin.murphy@arm.com>
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
binding is more for completeness and maybe very early bringup hacking.
I've kept it here for the sake of discussion, but the only requirement
on me for now is to get patch #1 landed.

And yes, I did initially look at trying to factor out the PMU register
accesses that functionally overlap the existing arm_cspmu code, but it
very quickly became clear that that would end up far bigger and more
complex. This is not a big driver, even with a few dozen lines of
nominally-duplicate (but also simplified since the counter size etc.
is fixed and known) code, so this way it went.

v1: https://lore.kernel.org/linux-perf-users/cover.1783439341.git.robin.murphy@arm.com/
v2: Fix valid Sashiko nits, separate DT support

Thanks,
Robin.

[1] https://developer.arm.com/documentation/den0093/latest/

Robin Murphy (3):
  perf: Add Arm Bus Monitor Unit driver
  dt-bindings: perf: Add Arm Bus Monitor Unit
  perf/arm-bmu: Add Devicetree support

 .../bindings/perf/arm,bus-monitor-unit.yaml   |  41 ++
 drivers/perf/arm_cspmu/Kconfig                |   6 +
 drivers/perf/arm_cspmu/Makefile               |   2 +
 drivers/perf/arm_cspmu/arm-bmu.c              | 538 ++++++++++++++++++
 4 files changed, 587 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/arm,bus-monitor-unit.yaml
 create mode 100644 drivers/perf/arm_cspmu/arm-bmu.c

-- 
2.54.0.dirty

