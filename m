Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF763C01;
	Fri, 18 Jul 2025 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832140; cv=none; b=InD5I8R3I5mJqodSrszkKvN9oxgsjfUePIrfhTBeRScZsPRojqXiRJkwrafIH6rbLu6EGsLBFieu6UuR5WmoW0asElNgUaCKgKsJBwGUbvzHvvSwYBz8Y01gi7aQGGa6cjBfLPTK0PzIgS3vmeW57KIKIyAc0jVt+2wFk3JmCjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832140; c=relaxed/simple;
	bh=mvLX7J2fJUv9irR0mGQwaL/gbW7N9hqowlHbHSKrSAk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mSLcBIS3l+Ed7fN+PXoXuodiUFtO4uZ52SrllHZuyfCH0pbv9pesns5h1QxfjWex0ts4jZ4NnKAnvBSnyK+bxdFKmXA2jXdS0rLy0cHmpxsqIdt64hwfIhrulcxb7J1b3A29kr94NgjqCRmbyL0nfUMrBQK7dtOaURWFLAuTZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bk4hh0HRnz6M4gR;
	Fri, 18 Jul 2025 17:47:32 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 41E581402F6;
	Fri, 18 Jul 2025 17:48:50 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Jul 2025 11:48:49 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <coresight@lists.linaro.org>,
	<dianders@chromium.org>, <james.clark@linaro.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<robh@kernel.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: [PATCH v3 0/6] Refactoring finding CPU phandles in DT
Date: Fri, 18 Jul 2025 10:48:42 +0100
Message-ID: <20250718094848.587-1-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500003.china.huawei.com (7.182.85.28)

This series refactor the way CPU IDs are retrieved from the device
tree.

Usually, there is a for loop that goes over every single CPU that can be
avoided. This also reduces the amount of NULL pointer checks in drivers.
I have abstracted away that loop and introduced a new function
(of_cpu_node_to_id) for this.

This patchset is a subset of [1], where I removed content and patches
relevant to hyper-threaded cores for DT. Based on the discussion, the
code refactor is still useful, hence this patchset.

[1]
https://lore.kernel.org/all/20250512080715.82-1-alireza.sanaee@huawei.co

Changes since v2:
    - Addressed Jonathan Cameron's comments.
    - Added reviewed-by tags.
    - Added a new commit where I suggest simplfing the code in
      arch_topology.c to remove the use of cpu_node on failure path.
    - Improve documentation.
    - Caught a bug in patch 1.
    - Commit message fixed for patch 2.

Changes since v1:
    - Rebased on top of the latest mainline.
    - Addressed Krzysztof Kozlowski's comments -- Hopefully :-)
    - Addressed Jonathan Cameron's comments.

Alireza Sanaee (6):
  of: add infra for finding CPU id from phandle
  arch_topology: drop the use of cpu_node in the pr_info
  arch_topology: update CPU map to use of_cpu_phandle_to_id
  coresight: cti: Use of_cpu_phandle_to_id for grabbing CPU id
  coresight: Use of_cpu_phandle_to_id for grabbing CPU ID
  perf/arm-dsu: refactor cpu id retrieval via new API
    of_cpu_phandle_to_id

 drivers/base/arch_topology.c                  | 22 ++++-----
 .../coresight/coresight-cti-platform.c        | 13 +----
 .../hwtracing/coresight/coresight-platform.c  | 15 +-----
 drivers/of/cpu.c                              | 49 +++++++++++++++++++
 drivers/perf/arm_dsu_pmu.c                    |  7 +--
 include/linux/of.h                            |  9 ++++
 6 files changed, 72 insertions(+), 43 deletions(-)

-- 
2.43.0

