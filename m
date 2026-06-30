Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC6D331EC6
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824487; cv=none; b=uWk+5mV7qjfiJMLIDSbhIDLikCjjFvlgKjlEnzXsxLuOrcPGsnohH6ifd9g4BiP+PKAV1gy6upkpvrR9p/zETabbHjWXyanbB5R2iau/V3MWqmrxFIiQ7bXQ/SFM7O7iz2DFnvAhgLHaXsgxdpS9iIEG+eKalBbpW5YTnicNGdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824487; c=relaxed/simple;
	bh=J++bVc2eDFtasCu94A0O+i2iCy1XUUqw/X2NxGrpFEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnzedvzCjaIByU2w5xqYiWy9NR+hFod6Log2bSR+SzumQzILuDPah3HK4+nA9oMu95bTAETQt64z6TFTnTKYzLWm7E8AmfrN7lddKOsvmsalr3eJCyhPiCRlTdiLndqCU51QrZs/EYNH4PhnauTr44LSc02rROKevqP21IhAf1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Zq9e1ohW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Zq9e1ohW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E24DC2ED2;
	Tue, 30 Jun 2026 06:01:20 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0BF983F905;
	Tue, 30 Jun 2026 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782824485; bh=J++bVc2eDFtasCu94A0O+i2iCy1XUUqw/X2NxGrpFEk=;
	h=From:To:Cc:Subject:Date:From;
	b=Zq9e1ohWmKsPCpcMjN69pt8XAVKHkNLBa9OrFY7IdZeyp5ciEyZExPNtJjqjNpwWX
	 bgJ4xgHeg5uCQzuJYdTq8kInCenAkmXlJVETp4mkjJbzWXsHUb2xtaD+rfD8HOpYGw
	 X/yLTfesRZriu1G0Ee3o3ma0/gcXjuz567PeBJ4o=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	zeev@amazon.com,
	blakgeof@amazon.com,
	avivb@amazon.com,
	ilkka@os.amperecomputing.com
Subject: [PATCH v6 0/2] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
Date: Tue, 30 Jun 2026 14:01:16 +0100
Message-ID: <cover.1782824005.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5: lore.kernel.org/r/20260603150025.30980-1-avivb@amazon.com

Hi all,

I'm reposting Aviv's series partly for visibility, since the previous
versions were buried in a thread, but also to respin patch #1 - Aviv had
fixed up the bugs in my initial draft, but I also get reports against the
original commit on my branch, so I ended up taking a second look, and
deciding the improvement was worthwhile.

Thansk,
Robin.


Aviv Bakal (1):
  perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5

Robin Murphy (1):
  perf/arm-cmn: Move DTM index data out of hw_perf_event

 drivers/perf/arm-cmn.c | 123 ++++++++++++++++++++++++++++++-----------
 1 file changed, 92 insertions(+), 31 deletions(-)

-- 
2.54.0.dirty

