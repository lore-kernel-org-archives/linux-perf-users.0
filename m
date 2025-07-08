Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B342E091A;
	Tue,  8 Jul 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987710; cv=none; b=PTIQsGc3MLtqlch8Wu4m07NABre3+ttlFZaumH77o6u0DN1VZ/khl1KZByeAgYT184MGfBrujI0WF48M/QloV9AAv7cXRrFVsWHfHGSUcCrzgkz09o58iNoZropyQpy68j0gMUBx4XORU7RTBQXFRKNVS+9VAZ3nwYut81B7XSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987710; c=relaxed/simple;
	bh=e/YehiYj+F1LkrXlpvP4oq7tcRL/IGEdsI/vueJDe70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XSONyQlrKm8rraWElQf+wT/AanhS3XDAXPW4I1+iqgyCydSa8TKR97Iag1qjxKhJMQezUTQn2dnOqCI4HSqxaWBjSg/7vX6PrtIlHyUMcLo6MUguQM+N5DNxyKPBhy7SWpYO5CKeDcbFT1xpfEHFFNja+bTf1DRnNYY9pWZORp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bc4Mb0qw1z6D8hV;
	Tue,  8 Jul 2025 23:11:55 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id ED09714025A;
	Tue,  8 Jul 2025 23:15:04 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Jul 2025 17:15:04 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <krzk@kernel.org>, <robh@kernel.org>
CC: <coresight@lists.linaro.org>, <devicetree@vger.kernel.org>,
	<dianders@chromium.org>, <james.clark@linaro.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 0/5] Refactoring finding CPU phandles in DT
Date: Tue, 8 Jul 2025 16:14:57 +0100
Message-ID: <20250708151502.561-1-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500003.china.huawei.com (7.182.85.28)

This series refactors the way CPU IDs are retrieved from the device
tree.

Usually, there is a for loop that goes over every single CPU that can be
avoided. This also reduces the amount of NULL pointer checks in drivers.
I have abstracted away that loop and introduced a new function
(of_cpu_node_to_id) for this.

This patchset is a subset of [1], where I removed content and patches
relevant to hyper-threaded cores for DT. Based on the discussion, the
code refactor is still useful, hence this patchset.

Changes since v1 [2]:
    - Rebased on top of the latest mainline.
    - Addressed Krzysztof Kozlowski's comments -- Hopefully :-)
    - Addressed Jonathan Cameron's comments.

[1] https://lore.kernel.org/all/20250512080715.82-1-alireza.sanaee@huawei.com/
[2] https://lore.kernel.org/all/20250707150414.620-1-alireza.sanaee@huawei.com/

Alireza Sanaee (5):
  of: add infra for finding CPU id from phandle
  arch_topology: update CPU map to use the new API
  coresight: cti: Use of_cpu_phandle_to_id for grabbing CPU id
  coresight: Use of_cpu_phandle_to_id for grabbing CPU id
  perf/arm-dsu: refactor cpu id retrieval via new API
    of_cpu_phandle_to_id

 drivers/base/arch_topology.c                  | 16 ++++----
 .../coresight/coresight-cti-platform.c        | 14 +------
 .../hwtracing/coresight/coresight-platform.c  | 15 +------
 drivers/of/cpu.c                              | 40 +++++++++++++++++++
 drivers/perf/arm_dsu_pmu.c                    |  8 +---
 include/linux/of.h                            |  9 +++++
 6 files changed, 61 insertions(+), 41 deletions(-)

-- 
2.43.0

