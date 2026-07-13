Received: from purple.birch.relay.mailchannels.net (purple.birch.relay.mailchannels.net [23.83.209.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B835F61A;
	Mon, 13 Jul 2026 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923086; cv=none; b=lH7MtCZx3fyitVPM4+kwX/caL4agSJvsTn5Lc2vHlYprsp8QjaGY2nA4E4IbsP0gTcY8LPt3+8b5H+h1rK47Nkv/miuRaylKuUeuGWx+TEqg7g12TsOSs0U1nrPc788GniMz0PiAbI89aizwFZcMAKxVJ/6CVtaNckACEhb37Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923086; c=relaxed/simple;
	bh=WjLXYPtZ48PUmAptVGCleZa4XxDp+q9fii1WWV3WbmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pEonLRD6we53DQ/+6Xs3RVj7CQKBy4hx8LXoX7m/Wnhs7tNlL+Ixlf2jmSTiR95xIcD9p3SWbULBfYfg7Wrn6DSiz+Q69uLXsrOXg1qsDY1aToYoUU/30uf+kZnxGPEHirs5c9XcK5m08YUMt2n6ZlY3lmGdhcNw1OrVUKdXkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=lGDKnY+v; arc=none smtp.client-ip=23.83.209.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="lGDKnY+v"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D2C687A1D10;
	Mon, 13 Jul 2026 06:11:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (100-98-253-75.trex-nlb.outbound.svc.cluster.local [100.98.253.75])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 64C117A276B;
	Mon, 13 Jul 2026 06:11:18 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Quick-Trade: 5edf72aa348f58c2_1783923078673_544100311
X-MC-Loop-Signature: 1783923078673:3515348654
X-MC-Ingress-Time: 1783923078673
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.253.75 (trex/8.0.2);
	Mon, 13 Jul 2026 06:11:18 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4gzBs15mZvz77;
	Sun, 12 Jul 2026 23:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1783923078;
	bh=0gV9rAaaoqv9ur6PUIs7Vw8/UB99KTwcTpWSwyiBi3Y=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=lGDKnY+vE+f/GrbCatHDjfWP1Sv3LxX6/TwS65HPjoj3wJVwQhyLIetlX5roRyPz3
	 4la2F7LBNvkPK6a8H+PSTQZmOUH88Ib4eB4UDANP7PDILVzLzxccmtKXBnPTrvPXfW
	 AzEgPU8PmFw7ui32NKLODsyZUE8WDDdyLm4yrcStKS1M3EHb17KiQVKbl1/8PWNjbP
	 8ffpftVK1TVc1JvbdQIyRgZsWzEDwaXCqp2bgOntOWv9UlxWmW/YBIRyij7rCp83IC
	 CPCT4Bx5zz3BSBJUC4akZS+yXcYMCmLzP63c+RRqFoWA7PUmzzIXNcgvxoGPkgf4yy
	 ZqFz03wTOkrxA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: harshal.t@samsung.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v3 0/3] perf/cxlpmu: Misc updates
Date: Sun, 12 Jul 2026 23:11:09 -0700
Message-Id: <20260713061112.105419-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes from v2 (https://lore.kernel.org/all/20260630235002.253297-1-dave@stgolabs.net/):
 - Split the 64-bit HDM filter write fix into its own patch 1. (Richard).
 - Allow CRB filtering for the Queue Occupancy, Queue Residency and
   Retry event groups, not just DDR Interface in patch 3 (Richard).
 - Reject CRB filtering when counting multiple events (multiple
   mask bits set), undefined behavior in patch 3.
 - Reordered the series so the events patch comes first, providing
   the event group ID definitions the filter validation needs.
 - Add the RD/WR merged queue occupancy and power down events,
   and the Throttle Events group in patch 2.

Three patches for the CXL PMU driver.

Patch 1 is a standalone fix.

Patch 2 adds the CXL 4.0 events that hardware exposes but the
driver did not. It now precedes the filter work as the latter
refers to the new event group IDs.

Patch 3 implements Channel/Rank/Bank (CRB) filtering, now permitted
for all event groups that CXL 4.0 Table 13-5 allows Filter ID 1 on.

v2 was tested on real hardware. The v3 changes have additionally
been exercised under qemu CPMU emulation (jic23 tree) + changes for
the new events/Filter=1.

Thanks!

Davidlohr Bueso (1):
  perf/cxlpmu: Fix 64-bit write to 32-bit HDM filter register

Harshal Thakkar (2):
  perf/cxlpmu: Add missing CXL 4.0 events
  perf/cxlpmu: Support Channel/Rank/Bank filter

 drivers/perf/cxl_pmu.c | 115 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 112 insertions(+), 3 deletions(-)

-- 
2.39.5

