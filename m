Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D238AC97;
	Wed,  3 Jun 2026 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498833; cv=none; b=N5YzkvapCaEOyOdaMs6N58j/hWAvkX8Ryh47rcKHtuSbAehjYzWoCNRpTMAxNUGt+Vl0FpMbbrcTHp2UAszkT+jQ3Nbyrn7IebkFyJ+741U6/9iMU9sLPt6Potjo20BkxmvuZiM8vzoEmDe+/wlAL+t8mJOAi8coGXHMWq8s0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498833; c=relaxed/simple;
	bh=XSXwuFZBkhwnYYZPuP9L3bGnuf3ZFy4EkdR+Kxftpo4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ckgl3XthmNprDZ5seIvVqamZ2lDAnx5LuASZNhZscphFHmImGeAGjRPRJuBrOfAiMq2ItQLEGYho1NI+tDeWECLTbG2PKE+xDT7i9gg1j44/yE6QzM9qi/KAPCEJso8LvKTRDcioTRSnZk34hwGAjn9DGHjFkI7sOTyaiiIingE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=jU3fAyx3; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="jU3fAyx3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780498832; x=1812034832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PDKsKDSbVExn0jxUl7+BzuzYpAY/H5UznWmB8z1SNjo=;
  b=jU3fAyx37XowmPj6BWvdOI9SqOZM752MBLi95QJH3qXBu+4tVtHpO6qg
   fo1NSDSpiK5tNqGY3L7jskVoaZR7VUGOh57ZtOEmPU9TSKQnrBoIWdi5z
   /KoZ/UIXqclFYvdH9n6ms/lRC06fE8C0gchIyDY1KVLJzTNXysWvghq2z
   Q/h1pv+5H0+Cvv9uR/Gv7nyNdUzqP8b/qA3wgohEoQjW0B2ws21C8Irkg
   qTYGip5+WN/POytnnXeO2vterNJiAztOrOlQqyszTpAeajO5RUrWfgnYw
   ARBYf2kLHtQX3KLp8lQz88AQOqO2Vf+3GiF21RzOyRu6RalIOIIxQCVow
   A==;
X-CSE-ConnectionGUID: b9jaOWH8RN6ZEhdVqDhijw==
X-CSE-MsgGUID: 2SVPzv9oRj6D/tKKggKFEw==
X-IronPort-AV: E=Sophos;i="6.24,185,1774310400"; 
   d="scan'208";a="21030303"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:00:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:26179]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.252:2525] with esmtp (Farcaster)
 id ebaf609f-8359-43be-8777-7a8e67c948f0; Wed, 3 Jun 2026 15:00:29 +0000 (UTC)
X-Farcaster-Flow-ID: ebaf609f-8359-43be-8777-7a8e67c948f0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 3 Jun 2026 15:00:29 +0000
Received: from dev-dsk-avivb-1b-e28f450e.eu-west-1.amazon.com (10.15.33.9) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 3 Jun 2026 15:00:27 +0000
From: Aviv Bakal <avivb@amazon.com>
To: <robin.murphy@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<avivb@amazon.com>, <zeev@amazon.com>, <blakgeof@amazon.com>,
	<ilkka@os.amperecomputing.com>
Subject: [PATCH v5 0/2] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
Date: Wed, 3 Jun 2026 18:00:23 +0300
Message-ID: <20260603150025.30980-1-avivb@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531110447.10095-1-avivb@amazon.com>
References: <20260531110447.10095-1-avivb@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series adds support for Graviton5's customised CMN-S3 which has
zeroed discovery registers.

Changes since v4:
 - Fix patch 1 authorship to correctly attribute Robin as author
 - Collect Reviewed-by tags from Robin and Ilkka

Aviv Bakal (1):
  perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5

Robin Murphy (1):
  perf/arm-cmn: Move DTM index data out of hw_perf_event

 drivers/perf/arm-cmn.c | 121 ++++++++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 31 deletions(-)

-- 
2.47.3

