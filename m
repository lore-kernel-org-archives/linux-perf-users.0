Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D44364EB2;
	Sun, 31 May 2026 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780225496; cv=none; b=IQSYf296JCZx5TyonnJ/kvSLAY6MRHNBhwd8oltNEkixUOqXtKV4QTjc6c4GrNa15UfgMckTHjVxoOVJ1J9tT9YqKc24skT06m34SHNu3whmnO8fhEpVmVncw6YApph7pgTSsO/LPO68xPSYlnvOggApCCP0YzssO1cZ/Q8nDHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780225496; c=relaxed/simple;
	bh=4sPwiHYi+sQPaGN072qmLOSICvVpHBVtKutKVkgfSJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkZgSY1nH6eTi5fdFULXKU41c38UEJMqw+Hmc7b3U2C+02xV21YC18luyxTYgQNwnU1cx9o1RilkqzsGm9bwNFcuaavZTjRLpm6OsQKDdU0q19u3ZJLoh2vcq0MM/c/QIk4H0LQJmoKhMd4+eC/rFbug1B7min6v4Fr25ekNyJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DKTtcFK8; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="DKTtcFK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780225495; x=1811761495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SJ0EqeycGMqEGZ+ilYzM2TIHWMZS86hqQeQQTWn8JFc=;
  b=DKTtcFK87jZkL+0Y/8RXyPX7CAaB+9kfYbFZCScyW3ATLcStuVPW/Fhk
   2DZOdWdiuZKdb2MAQpZa1zgQJ7G16jpu5pwF+LyrvLY2QqkS/olRApiJ3
   8FV5p1a377NGJ2RRyvZjZ7DnIk9EaqpE06TpNkszXNcwIbGmYyU7WJ2rG
   fAdktglJHHIANNm16KqsO05lscLVmX0uMsq9/dwow4gHBEPIpPGBFSTTH
   Unu4Ke90M+hUVpRimE3DY6Gg+JVDqAwEV7xO2Em0+iZXLbetXMRnAqpQ4
   KTKEsqZZuoMl1H/1g7b3bEazWTi+jJy7UO1DlN+jEo2YyQrpHtNun4dDA
   A==;
X-CSE-ConnectionGUID: tdFeQ4DlRAicmta78vAuzg==
X-CSE-MsgGUID: QSLyO8POSmqrXa4r78VB5w==
X-IronPort-AV: E=Sophos;i="6.24,179,1774310400"; 
   d="scan'208";a="20678444"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 11:04:52 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:21705]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.91:2525] with esmtp (Farcaster)
 id dc0f3f19-864f-4891-9642-d8fdf3f3ce2e; Sun, 31 May 2026 11:04:52 +0000 (UTC)
X-Farcaster-Flow-ID: dc0f3f19-864f-4891-9642-d8fdf3f3ce2e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 31 May 2026 11:04:51 +0000
Received: from dev-dsk-avivb-1b-e28f450e.eu-west-1.amazon.com (10.15.33.9) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 31 May 2026 11:04:49 +0000
From: Aviv Bakal <avivb@amazon.com>
To: <robin.murphy@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<avivb@amazon.com>, <zeev@amazon.com>, <blakgeof@amazon.com>,
	<ilkka@os.amperecomputing.com>
Subject: [PATCH v4 0/2] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
Date: Sun, 31 May 2026 14:04:45 +0300
Message-ID: <20260531110447.10095-1-avivb@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524153848.16334-1-avivb@amazon.com>
References: <20260524153848.16334-1-avivb@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series adds support for Graviton5's customised CMN-S3 which has
zeroed discovery registers.

Patch 1 is based on Robin's suggestion [1] to move the DTM index and
watchpoint bitmaps out of hw_perf_event into separate allocations,
removing the size constraint that prevented increasing CMN_MAX_DIMENSION.
Two fixes were applied on top: the kzalloc size now accounts for
sizeof(u64), and bitmap_zero() is used instead of a raw memset for
wp_idx.

Patch 2 adds the Graviton5 workarounds.

[1] https://lore.kernel.org/all/c1d27212-8e2b-4820-bee6-ad7e7de81238@arm.com/

Changes since v3:
 - Replace patch 1/2 with Robin's approach: dynamically allocate
   dtm_idx and wp_idx instead of moving the struct into perf_event.h

Changes since v2:
 - Revert DTC logical ID assignment back to xp->logid (per Robin's
   review)

Aviv Bakal (2):
  perf/arm-cmn: Move DTM index data out of hw_perf_event
  perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5

 drivers/perf/arm-cmn.c | 121 ++++++++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 31 deletions(-)

-- 
2.47.3

