Received: from glass.ash.relay.mailchannels.net (glass.ash.relay.mailchannels.net [23.83.222.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5444A1EE7D5;
	Wed,  1 Jul 2026 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782867941; cv=none; b=CVirlJUdS7Jcoozda03FwWR+WuNCIrjo2L5igKXMUdgCVQ3iPNhkgjtSes+crkHImi1n0HfH5cGK7PRxZDIrj0bkjzWDJG4iAlqcmGoaNqo+8SUQv5jCai9S22GgrLYkUzRUyoAxWqmKtRj4OvB8KcCFbJhuXEfWWm8Pewvd0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782867941; c=relaxed/simple;
	bh=Fb7nAIcDYw6QMJqe73uUlwi9scOJLA4/BbA+tYO5QJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I+yFQmjRFGaBGbR6EtUuIBdAZzXaawuiAcmyFqJzhIWRIF1CWZpRw2yi7c7qV0gb785f/AUJHx28ewh16/iM8ZLLElGa3e9rniYFqa2bPVd9UiFBuQsooFjUnjABHZbt9bo9JTnQVrVtrEDjbMwUd1jRtIdLvA/WMqkOEhkw/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=mHnBvwOW; arc=none smtp.client-ip=23.83.222.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="mHnBvwOW"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EFDE59424F8;
	Tue, 30 Jun 2026 23:50:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (trex-green-2.trex.outbound.svc.cluster.local [100.99.21.53])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8F378941E1D;
	Tue, 30 Jun 2026 23:50:22 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Grain-Decisive: 2d3d758156b57788_1782863422839_3007536862
X-MC-Loop-Signature: 1782863422839:3416388007
X-MC-Ingress-Time: 1782863422839
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.21.53 (trex/7.1.5);
	Tue, 30 Jun 2026 23:50:22 +0000
Received: from offworld.lan (unknown [138.84.33.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4gqfz040tMz9k;
	Tue, 30 Jun 2026 16:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1782863422;
	bh=GhJyxPPD0OVWGBjooQCbT9UE9vjqPUcXQ0dbO54b0CY=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=mHnBvwOWpG0fB8aedmYojjxjGycazAm05/jGbKViZcenyzd7/NsWsnyHc2z54UnRi
	 /WPiQuwtXI2IHzNl6vXBzVbLMEsDIX3CZSoq1ABsHhamVZ93QpH3Pwndpj0GThxCd6
	 NLX6oVyvBeWhs1cK6S2Kj6a0cGteufc1gSMs4rM4YicRGJmL1mFg1T8pKQmQ5904mI
	 xMfqfEv6EplM6hEDrUxumT5ifC5BJcGymENBK26VQ8XpS0taw2L+aIUNRj31MU+kJN
	 HXeMfymZInrENCZS3qHGeXz64GO6r+UUWd4Td+HCjGkZajZ2xpACviNmKtQPUVOO5W
	 Qsbx7Wwdtdlrg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: harshal.t@samsung.com,
	linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 0/2] perf/cxlpmu: Misc updates
Date: Tue, 30 Jun 2026 16:50:00 -0700
Message-Id: <20260630235002.253297-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Two patches for the CXL PMU driver.

Patch 1 adds support for new filters and is a v2 of
https://lore.kernel.org/all/20260611010409.2776635-1-dave@stgolabs.net/

Patch 2 adds the CXL 4.0 events that hardware exposes but
the driver did not.

Both have been tested on real hardware.

Thanks!
Davidlohr

Harshal Thakkar (2):
  perf/cxlpmu: Support Channel/Rank/Bank filter
  perf/cxlpmu: Add missing CXL 4.0 events

 drivers/perf/cxl_pmu.c | 91 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 3 deletions(-)

-- 
2.39.5

