Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285F4E5350
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608637; cv=none; b=BeGQ3uI0/B8ysw4Ep7Uha3wYpqR9OwjgTWbqaQzzoibD40IyM9P+gi026QGemJyhjLdOfUvqQKSSvpFo3moyyv95e48roTq31bq88+Q524RLddUn36wV40rNLyYuxiy2qJEM4pXaoFB3MBV0i3+iABkrPODKdGPnS/wh4jgoQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608637; c=relaxed/simple;
	bh=SWR259TN5N/43zacnJp0emDd2EeU3wBPIpPaIhuhUxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PVCaA3BLTYTPnCGMRg7I2Q7xDNRQgO7QxJoQjAza6quiOmCV9j7s0cp0y8gSvM7LuzqKHlwIPalgnZK9r5rinPqamVf9EDayQgKJ6QoOek4u8XdNlqY+igVB9ZJ2YpOpp6W82QDR/Ctt/fzP1LwI2pPrxltoeiyyxNZ40O0VbWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TrMOifxz; arc=none smtp.client-ip=91.218.175.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TrMOifxz"
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SWR259TN5N/43zacnJp0emDd2EeU3wBPIpPaIhuhUxs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790608629; v=1; x=1791213429;
 b=TrMOifxzzjHQyeI6GmtG6r5ZU+S0S+dt0iLrGOp1zttbGJDbPLae79NDHz8V3lr4/lTmWaxA
 LlckvO1SQK2WT0q0rS1tmouncaezGmQ+k8Xv4pWXJBvD+IegRfNYYWm2fdn5utwidylb0v/SC1y
 4yDsmOtadA1XiFAwd7pI5T4g=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id b1a6d710722610ee;
	Mon, 28 Sep 2026 15:17:09 +0000
X-Mizu-Trace-ID: b1a6d710722610ee
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	will@kernel.org,
	james.clark@linaro.org,
	mike.leach@arm.com,
	leo.yan@linux.dev,
	linux-kernel@vger.kernel.org,
	John Garry <john.garry@linux.dev>
Subject: [PATCH] MAINTAINERS: Update John Garry's address for from arm64 perf tools
Date: Mon, 28 Sep 2026 16:16:52 +0100
Message-ID: <20260928151652.66499-1-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My employer e-mail address will stop working soon and I am likely to get
more involved in this area in future, so update my address.

Signed-off-by: John Garry <john.garry@linux.dev>
---
Note that my earlier patch to remove myself entirely was never applied ...

diff --git a/MAINTAINERS b/MAINTAINERS
index 72294ddfa5b7..271f602782d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21407,7 +21407,7 @@ F:	tools/lib/perf/
 F:	tools/perf/
 
 PERFORMANCE EVENTS TOOLING ARM64
-R:	John Garry <john.g.garry@oracle.com>
+R:	John Garry <john.garry@linux.dev>
 R:	Will Deacon <will@kernel.org>
 R:	James Clark <james.clark@linaro.org>
 R:	Mike Leach <mike.leach@arm.com>
-- 
2.43.0

