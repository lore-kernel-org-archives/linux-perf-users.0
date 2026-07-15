Received: from butterfly.birch.relay.mailchannels.net (butterfly.birch.relay.mailchannels.net [23.83.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA53443E51;
	Wed, 15 Jul 2026 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142920; cv=none; b=jFSYMZBoCShq23nu18SKCJ1SxJmXFb+Q7PqsdjFLpgC1lrnHHc0wa/MgAe30k7m38zR2vutqWuXCyxxIi1Ro+jgkCYh+uaga3b3lm1Zh8nBuoZK1JhCNvv3yYtG9gtDsfdworcBGQA6ulWhDWyEuE3AqrIVUV21j4AqaoQMH62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142920; c=relaxed/simple;
	bh=E+CtAlwAe7jgGtPX9RxNxEi7FefHGUgb7HVbA/9OLvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YdGU4u1Gr37uM0MEKgLGK2nV7P6IFRZZawp+Q0DI3Mxr6RwHyq1Cqf/QOlz4rrv4OCKEmunjH5FRAfUvioBsgD0QKv8Bcc6w73ziawEKnCqwGYMXQvOWKbtxInFY53y7t/OoQpTCmbMghlNDt5rZ7BGCrqL33mMFqQNTWVADz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=YFBjXNTJ; arc=none smtp.client-ip=23.83.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="YFBjXNTJ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0CF184C1EC0;
	Wed, 15 Jul 2026 19:15:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.103.92.160])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A04C74C13E8;
	Wed, 15 Jul 2026 19:15:06 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Snatch: 50f3024e6e0730c3_1784142906917_3856465850
X-MC-Loop-Signature: 1784142906916:3098121119
X-MC-Ingress-Time: 1784142906916
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.92.160 (trex/8.0.2);
	Wed, 15 Jul 2026 19:15:06 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4h0m8V0RxPz105H;
	Wed, 15 Jul 2026 12:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1784142906;
	bh=AMXEuMzNW5wbRXkV6EZuue+zx94iY8QPsK6ZoHLwwfE=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=YFBjXNTJTLQhd+jOmU+agvTaWMNQumvN56cOVA3HP28cO0VAvvUKLf3waFw6LZ2Fm
	 mTWlmev2QJ26n9QD/4J1WG7pXHhGxytPzCEO497z+ghLVSelJptuB0LcD6NFkg0Llg
	 oO/RPweFlx5XKq1MQa2OcZDmlZFfTYGWd651dUexgeyadI0gTQNfKDRyONgu3BS0sJ
	 /ca+1Ci/aSAoHpmjVd2httZqZsuE1LPXtGOSpn5JYrWqN/MfoH+bKLnqRj4U8Or08y
	 Fzcey6ECWjkELc2JKZ64lPhywFEU9AbKWALLMDeauuOiuYkVmPT2QOm6oH/Sd5Ajn7
	 t0wLRKubkjjgA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: harshal.t@samsung.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v4 0/3] perf/cxlpmu: Misc updates
Date: Wed, 15 Jul 2026 12:14:51 -0700
Message-Id: <20260715191454.459673-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes from v3 (https://lore.kernel.org/all/20260713061112.105419-1-dave@stgolabs.net/):
 - Validate the event vendor ID for CRB filtering, the Table 13-5
   event groups are scoped by the CXL VID in patch 3 (Richard).
 - Add Richard's Reviewed-by tag to patch 1.

Three patches for the CXL PMU driver.

Patch 1 is a standalone fix.

Patch 2 adds the CXL 4.0 events that hardware exposes but the
driver did not. It now precedes the filter work as the latter
refers to the new event group IDs.

Patch 3 implements Channel/Rank/Bank (CRB) filtering, now permitted
for all event groups that CXL 4.0 Table 13-5 allows Filter ID 1 on.

v2 was tested on real hardware. The v4 changes have been exercised
under qemu CPMU emulation (jic23 tree) + changes for the new events/Filter=1:

    https://lore.kernel.org/all/20260715190050.458288-1-dave@stgolabs.net/

Thanks!

Davidlohr Bueso (1):
  perf/cxlpmu: Fix 64-bit write to 32-bit HDM filter register

Harshal Thakkar (2):
  perf/cxlpmu: Add missing CXL 4.0 events
  perf/cxlpmu: Support Channel/Rank/Bank filter

 drivers/perf/cxl_pmu.c | 119 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 116 insertions(+), 3 deletions(-)


base-commit: d60ec36cab338dfe2ae40d73e9c8d6c4af70d2b8
-- 
2.39.5

