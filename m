Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1544E41A558;
	Thu, 16 Jul 2026 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213805; cv=none; b=IRvELvsQeFh5uN0V/2G7NS/yca7BISYTljeBDqJOZtpjK2hPEoJ7PiEfSsiDCobGk5UWpUKWrBtK9dAROC0yWR/Bi4Dp2Pi6NZyA/VKn6VHtRVjFHLE0OoTSgh30pMmX9eAaZDFJzrirCWw/MfFvo6hLbH8OJD4eYNBBbxQN2vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213805; c=relaxed/simple;
	bh=OeE48gTGuCZ9msSMA3TQXhBCtnD2xyz0+Yow4siGDBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHXlP38Z8GdCXxGuGmj1RaV8jIr3UbfS4JYNHCId5utZqKBl+lFtt9fz3L3EwwkYVahILl2mI2MAkZsaWI81vHCOyta1K+SpHKhmmt1mAGek7blPLgFTVEgBf973ZLuQ1lUGxu6SsPigxnttLtq9Sw7WbSoBOFGG+6V+KmUkYts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bCHKgAz2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bCHKgAz2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B0FD1476;
	Thu, 16 Jul 2026 07:56:39 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 30BC73F7B4;
	Thu, 16 Jul 2026 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784213803; bh=OeE48gTGuCZ9msSMA3TQXhBCtnD2xyz0+Yow4siGDBc=;
	h=From:To:Cc:Subject:Date:From;
	b=bCHKgAz2whfs/OnWepF/6oZB1IBTl5EJ9ez7x3w18MiQoABQ2qHF07EJBD6n3Xt2O
	 gmw2B956fbMpystKqEEXtAtQ1Fzsomby82X+xtO/I+UxKBaEXVjgWpddhGsacH3TY0
	 s5nS2P/Pa3fzr9IdwjV8LJsxrorbuNtf9UEbNDLg=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: ilkka@os.amperecomputing.com,
	bwicaksono@nvidia.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 0/4] perf/arm_cspmu: Miscellaneous improvements
Date: Thu, 16 Jul 2026 15:56:33 +0100
Message-ID: <cover.1784213435.git.robin.murphy@arm.com>
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

v1: https://lore.kernel.org/linux-perf-users/cover.1783605641.git.robin.murphy@arm.com/
v2: Fix valid nits from Sashiko review, add Ilkka's R-b.

Thanks,
Robin.


Robin Murphy (4):
  ACPI/APMT: Use stable device ID
  perf/arm_cspmu: Improve APMT-based PMU naming
  perf/arm_cspmu: Improve sub-module error reporting
  perf/arm_cspmu: Make IRQ more optional

 drivers/acpi/arm64/apmt.c          |  6 ++--
 drivers/perf/arm_cspmu/arm_cspmu.c | 48 ++++++++++++++++++------------
 2 files changed, 33 insertions(+), 21 deletions(-)

-- 
2.54.0.dirty

