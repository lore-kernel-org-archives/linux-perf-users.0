Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9468A2BDC09
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150748; cv=none; b=L1euIEe4CFBzbchXEXSb5yKbHeXcojUC1DoP6BtdqbEHkUHg60QmabwvQqznTti7sS8RWsf/dbqvbDy4lEHM3as/n61gaqKbF2ccWv89JSlYhiMwDpYwQF3+G1qB1flbgsWR9MqsjRNNU5+QPNekY/sUvSve8BdapazJhYr6OcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150748; c=relaxed/simple;
	bh=8aPo39A+bYOt9g7x7KxuSfw++2PeRF3y5qwI/zXoHkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JxrAThxhEQuzR15VHlhvrR/lqDTo1EoQnXok/g75J23f9vS2bkx2MgE2UcDxDpYNJ5WthJhMIjUdQyCemmaINEBs62jm5h62cMP+f6pLnQ5AqQxJ0yW5mS0wQgJ4FD+cahpgLbthACjlBWa3OwDjCAq2Zq9yzZWpAWiV0BMzyJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9A07150C;
	Tue, 13 May 2025 08:38:54 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B0E723F63F;
	Tue, 13 May 2025 08:39:04 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	allen.wang@hj-micro.com,
	peter.du@hj-micro.com,
	andy.xu@hj-micro.com
Subject: [PATCH 0/3] perf/arm-ni: IRQ improvements
Date: Tue, 13 May 2025 16:38:57 +0100
Message-Id: <cover.1747149165.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

While the previous attempt[1] was missing some important aspects, it's
a valid problem to solve, so I figured I'd take a look myself. This
ended up turning into a slightly wider cleanup, but I think the end
result is nice enough.

As usual I don't have anything to test this on, so if there are any
silly mistakes left that the compiler couldn't catch please do let me
know.

Thanks,
Robin.

[1] https://lore.kernel.org/all/20250410114214.1599777-3-allen.wang@hj-micro.com/


Robin Murphy (2):
  perf/arm-ni: Set initial IRQ affinity
  perf/arm-ni: Consolidate CPU affinity handling

Shouping Wang (1):
  perf/arm-ni: Support sharing IRQs within an NI instance

 drivers/perf/arm-ni.c | 148 ++++++++++++++++++++++++------------------
 1 file changed, 84 insertions(+), 64 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

