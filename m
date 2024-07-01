Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3616EBEA
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jul 2024 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856683; cv=none; b=D7/ak6O/pTo0Op+OydPbAR+SGYXH0EG+ASxw8Sy7VfBerTitszfCwG9zXevaD7BBv9X2BSs1Y8GqgpqSUypFfPD83c1IVeCX9Vm/f6CsDg+nItJRKLJUGl4Um0HfsDVVg/N6XmxxLRdppKAaDXSAK73bXRc/9HUlVMy0XhihBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856683; c=relaxed/simple;
	bh=G2UkIVwvAFP/3sNWmb/3Ga/Ej0RGnJixSuEjRf14qeU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SMo+UbA/ZjYSMprao7rB+aEOawowNUQ/XKUbnNTn5dkG4wOzqDiDRZ+T1BP8a8sCTby2SaBeFfDnKS+6pSxvuHonesR11YV1v0U2UhNJYhAq2VUC28uyLngsScqFk4RQFLGtB5KBv9o+yCtQ7q+WlGxwi+86DF1sxevMgqxd9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sOLHW-0006dy-9V; Mon, 01 Jul 2024 19:57:38 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sOLHT-006QRJ-QP; Mon, 01 Jul 2024 19:57:35 +0200
From: Lucas Stach <l.stach@pengutronix.de>
To: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: [PATCH] perf vendor events arm64: Move Yitian 710 DDR PMU into T-Head directory
Date: Mon,  1 Jul 2024 19:57:35 +0200
Message-Id: <20240701175735.485655-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-perf-users@vger.kernel.org

The Yitian 710 is not a Freescale/NXP design and thus should
be located in a separate T-Head vendor directory.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 .../arch/arm64/{freescale => thead}/yitian710/sys/ali_drw.json    | 0
 .../arch/arm64/{freescale => thead}/yitian710/sys/metrics.json    | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename tools/perf/pmu-events/arch/arm64/{freescale => thead}/yitian710/sys/ali_drw.json (100%)
 rename tools/perf/pmu-events/arch/arm64/{freescale => thead}/yitian710/sys/metrics.json (100%)

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json b/tools/perf/pmu-events/arch/arm64/thead/yitian710/sys/ali_drw.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
rename to tools/perf/pmu-events/arch/arm64/thead/yitian710/sys/ali_drw.json
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/thead/yitian710/sys/metrics.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
rename to tools/perf/pmu-events/arch/arm64/thead/yitian710/sys/metrics.json
-- 
2.39.2

