Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4BB2EF2B9
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Jul 2025 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257732; cv=none; b=fSoQWiwr+f6Ch60ykcbGUXVwcLvHunVR0dkgvVkxMDnn7/IVa5bTm8Iv1F01hYlptqrzePokl+DWB0QogYJgVYnRwxpB96HEvnrRx0Gs913YPRvbXTjBKTninMG9xxvBdgHh3JX7QnoMs89tWNRQq1VXq5vVFq6Io9rSD3+V3+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257732; c=relaxed/simple;
	bh=FtUDpskSEwQHs28g+d6NyUskl++paa9MngstaOsLkcI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o+ZMnGm4cW7ESIt8VvPlgLl5kcBrsbR+IIDsSpBAxuin0hoJmEiG0Oqc0e5FpOe8GZET8wWVoRcWdKWAeSGfDeTgwIpLbBsQypjLnXugU0Uk8sFv5+9A9CaJGsmGWPa9xKYHX18N9KVN1aUsg/FK0JLETY9TNGZd+HebIgzMUcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B759516F8;
	Fri, 11 Jul 2025 11:15:18 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CCE13F6A8;
	Fri, 11 Jul 2025 11:15:28 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	allen.wang@hj-micro.com,
	peter.du@hj-micro.com,
	andy.xu@hj-micro.com
Subject: [PATCH v2 0/2] perf/arm-ni: IRQ improvements
Date: Fri, 11 Jul 2025 19:15:15 +0100
Message-Id: <cover.1752256072.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/all/cover.1747149165.git.robin.murphy@arm.com

Hi all,

Here's a quick tweak to address Will's concern last time (minus
the affinity fix that's already queued).

Thanks,
Robin.


Robin Murphy (1):
  perf/arm-ni: Consolidate CPU affinity handling

Shouping Wang (1):
  perf/arm-ni: Support sharing IRQs within an NI instance

 drivers/perf/arm-ni.c | 154 ++++++++++++++++++++++++------------------
 1 file changed, 88 insertions(+), 66 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

