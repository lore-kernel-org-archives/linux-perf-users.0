Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795763444;
	b=KvP6twKhJRbwh2vyJe5aXSQREIyh+hyJFluKjLtjwPd4ZZfJtKMv7PElMui48BI0KwVE
	 Td0YpMyZCbRksjjY7CHV4+utW6UVPF5xbZl9c0bVpH1fVOjvJE2NDIG+cwZ/NbeKiCa4O
	 51ruEGmBBZ9ktPovWCFTrcmpPcFJLx9XavCYgMk8VkZaWbY3qEIoqgioGS9KRd145xFzc
	 dl3OIqp5U3yTW8h87RL1datzn7t7/UwHwpkGkiDH16mQDanEWX1LkMRs+RqTiqDkcsD1K
	 Xuvb7CqQBqvXXcpUWpHwcrH0ikmwgD7K630D4k6ki3kgkJGTeNWMBtbMlO4AZY7pyAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763444;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Fe6waKdNkyaZ7iMH0/zpUt81dGcgiN278dUR0JooI70=;
	b=gn/6U2HnpcJ/dYydNKBlWwy6WEb0ewzuwDsBH/LtlkhOURZCCG1OiQs4fRIuobL5uEkF
	 gB8YQRsabpfOZmxkVdYV01mxCe4wFZuGhpWWVf/2hSKkrJmo7O7KPN2LQHzW/gZHxAISa
	 jXI6GGCAme+SgWxPHxMn2FZlUWYWfePKGV/37IV3Or0iTVHMctA5EQTMVeJNvwfdeXVJh
	 3RrRtX/WCFo9T5GqAtjNu4xFnDOaMv5Fws8LtHyHme4NafauBCugiRUpijPsJ6QtwRd37
	 j5OL3mdrSVWH16P1kakphG0Aie0cOhRuEStANyAq+s5/943k04ZKiTeDsI5FjDBdO5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=f6Wrk9lu;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E432606A31C;
	Fri, 27 Nov 2026 07:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E432606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=f6Wrk9lu
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795763439; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Fe6waKdNkyaZ7iMH0/zpUt81dGcgiN278dUR0JooI70=;
	b=f6Wrk9luUosyElP3hPfOXXN28ihefZ/LL+VZGjGqTZ76/PXQh0skKNzk7DUVHfPBmXyauOd1PQG70cr53AnO6pWLqzPWHlSsMzGi3PLhUeomxQ3GLaWJInaYa+FcEzDr9Ykw1ufWkWS3iPhemMTUUXBngS9tuu/QTkhKTILNuHY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=jiangtianfeng@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFX36QT_1795763436;
Received: from h68d07384.sqa.eu95.tbsite.net(mailfrom:jiangtianfeng@linux.alibaba.com fp:SMTPD_---0XFX36QT_1795763436 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 15:10:38 +0800
From: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiangtianfeng@linux.alibaba.com
Subject: [PATCH 1/2] perf/arm_cspmu: nvidia: Reject missing TGT address-filter resource
Date: Fri, 27 Nov 2026 15:10:09 +0800
Message-ID: <20261127071021.820833-2-jiangtianfeng@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127071021.820833-1-jiangtianfeng@linux.alibaba.com>
References: <20261127071021.820833-1-jiangtianfeng@linux.alibaba.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_dev_get_memory_resources() can return 0 with an empty resource list.
In that case pcie_tgt_init_data() leaves addr_filter_reg as NULL but
returns success. A later address-filter event then writes to registers
computed from that NULL base.

Reject an empty resource list with -ENODEV and keep the existing ioremap
error propagation. This turns missing firmware resources into a probe
failure instead of a runtime invalid MMIO access.

Qoder, an AI coding assistant, helped analyze the issue, develop the fix
and source-derived state model, and draft this description.

Fixes: 3dd73022306b ("perf/arm_cspmu: nvidia: Add Tegra410 PCIE-TGT PMU")
Signed-off-by: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
---
 drivers/perf/arm_cspmu/nvidia_cspmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
index af256f662731..a0257dc3249d 100644
--- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
@@ -555,7 +555,10 @@ static int pcie_tgt_init_data(struct arm_cspmu *cspmu)
 
 	rentry = list_first_entry_or_null(
 		&resource_list, struct resource_entry, node);
-	if (rentry) {
+	if (!rentry) {
+		dev_err(dev, "no address filter resource\n");
+		ret = -ENODEV;
+	} else {
 		data->addr_filter_reg = devm_ioremap_resource(dev, rentry->res);
 		ret = 0;
 	}
-- 
2.47.3

