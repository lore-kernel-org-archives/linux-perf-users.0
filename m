Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26FE36CE03;
	Thu,  9 Jul 2026 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608005; cv=none; b=XjDlXLcCEJgQgR0X6u8iwAnLcfoP0Nr/qf9TwMskfAQHT1TZdoSZ3hWzfJnDXNqLoBdVO7m1iEXrqpX6LS7ungm64jqeM4CHu0rAK6lS399+PDF7XwgDuSGx4NG8Z5t2Xg43ev8veAFIT2LgykgRQmMCjfPRXUt66EHEw9dlj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608005; c=relaxed/simple;
	bh=52TghAuaTr4O+tB+lgjiiJERJST0JojMUFPR+rQdHNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQegmghT3jwl0h5UVrBDwNm7MSm/Q8sCUuK5Yu0o+f/gJz7DltHL0sC+fDVnG1nrYKTLw9enZM0IQc3MGPdIcxF2JR32aGArfBk0v3kJTwdXjJwPAfrYc3EBOL+Qj+9HSGJAEFvSwDXvT6ppv1d+HRyUhLtQUvveBX78XROit9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JAg+IqJM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JAg+IqJM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E39C5152B;
	Thu,  9 Jul 2026 07:39:58 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E73A83F66F;
	Thu,  9 Jul 2026 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783608003; bh=52TghAuaTr4O+tB+lgjiiJERJST0JojMUFPR+rQdHNE=;
	h=From:To:Cc:Subject:Date:From;
	b=JAg+IqJMSp0tqZbFfrthAWNrr5+D7zhml+CAzJPxWNRk8gzS1KegMJg5VAf+sJyAA
	 +AEU+J75b3zzIgSBHVbA5eG8YPO+hxCN8Zgl7MKZfuEvEa/zQZ6pC7dJg0KHdN6CiJ
	 zS/tNSOPG/01k1oJozBmhMdI9xWX2y5K1ufU31is=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: ilkka@os.amperecomputing.com,
	bwicaksono@nvidia.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/4] perf/arm_cspmu: Miscellaneous improvements
Date: Thu,  9 Jul 2026 15:39:52 +0100
Message-ID: <cover.1783605641.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

These are a few quality-of-life improvements for CoreSight PMU that
I've accumulated based on things which have come up in practical usage.
There's no real dependency between any of the individual patches, it
just felt right to send them as a series.

Thanks,
Robin.


Robin Murphy (4):
  ACPI/APMT: Use stable device ID
  perf/arm_cspmu: Improve APMT-based PMU naming
  perf/arm_cspmu: Improve sub-module error reporting
  perf/arm_cspmu: Make IRQ more optional

 drivers/acpi/arm64/apmt.c          |  2 +-
 drivers/perf/arm_cspmu/arm_cspmu.c | 49 ++++++++++++++++++------------
 2 files changed, 31 insertions(+), 20 deletions(-)

-- 
2.54.0.dirty

