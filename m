Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE3A19D894
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Jun 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598687; cv=none; b=QaFwUmxJ8h7dFCHuqOES0hiPB8mXPvkezpSsUp5IZz6xCvDd/VXlwp4S5LJQnBEULAUm4qzEdV+BVBU/Pg/9NWZbRogxwrXexH/Vr2erpePXuOCDQs45UCyOHoMgNfEYwaAAmH2y5o5vvrpNL6FfvMfVvsBUO7L8+qXKpF5ulaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598687; c=relaxed/simple;
	bh=0z1iFcJDr3wr4mfmYOWqF/66/ed0+L0XKNmJbgl3YsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JbZ9JGabebXUEHlCJEeC8YT4nkXcs9hSEHny/CL5X4VAPopeC+lWEhpSUdGdh/lpTgbXeEiaMbSqsfRAa0RK3acHpuKwa0/ZoN/Sf8n6JpPiPrRxzoL/+vXKY1UBIUhleFoLuiCTZqRKPUuxqxWRJ8ZgFaRRtaP468RTo7R501U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sErsY-0002rJ-JF; Wed, 05 Jun 2024 16:44:42 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sErsY-000Ldu-3N; Wed, 05 Jun 2024 16:44:42 +0200
From: Lucas Stach <l.stach@pengutronix.de>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: [PATCH] perf script: netdev-times: add location parameter to consume_skb
Date: Wed,  5 Jun 2024 16:44:42 +0200
Message-Id: <20240605144442.1985270-1-l.stach@pengutronix.de>
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

dd1b527831a3 ("net: add location to trace_consume_skb()") added a new
parameter to the consume_skb tracepoint. Adapt the script to match.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 tools/perf/scripts/python/netdev-times.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/netdev-times.py b/tools/perf/scripts/python/netdev-times.py
index 00552eeb7178..30c4bccee5b2 100644
--- a/tools/perf/scripts/python/netdev-times.py
+++ b/tools/perf/scripts/python/netdev-times.py
@@ -293,7 +293,8 @@ def skb__kfree_skb(name, context, cpu, sec, nsec, pid, comm, callchain,
 			skbaddr, location, protocol, reason)
 	all_event_list.append(event_info)
 
-def skb__consume_skb(name, context, cpu, sec, nsec, pid, comm, callchain, skbaddr):
+def skb__consume_skb(name, context, cpu, sec, nsec, pid, comm, callchain,
+			skbaddr, location):
 	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
 			skbaddr)
 	all_event_list.append(event_info)
-- 
2.45.1

