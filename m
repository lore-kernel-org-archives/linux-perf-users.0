Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F5E2BEC39;
	Mon,  7 Jul 2025 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900662; cv=none; b=MfHbpY7xYWtb8yqxDeITp93EyeBxfkoMw9LBNe5moE6N5mVfdIiRmA36HwbIBMVbnJFlZZ4QBBsbH8wM2NUYhYHvSAqeK2ataNRJa4RsDgXHegMOKkO12V/fpENAd8B32Bew5dMk9K8DONWa5ThLn0OWPT7ZqTn6GY3aSvkQqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900662; c=relaxed/simple;
	bh=j9ddN2B76uhAFmyN3iQu/vGSTPpgGKiei0hV4HiWoMk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UK9GmTtlYyy7EgaeVVGz7LUKntVALIaC/cKrXWxiOt+x3mcwUbYKJgmTAT+g408POoMN543gjY0HiQCa0QzENLmNZZOMO5QGNIs8lVwov727fiiiGfSYL07t3s6/0AqdyugFjc5hdTB3NCsERfYL1r2kCBctbefbzBIz844sLr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bbSD24DJBz6M573;
	Mon,  7 Jul 2025 23:03:14 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 3630C1402EB;
	Mon,  7 Jul 2025 23:04:17 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.45.147.207) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Jul 2025 17:04:15 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <mark.rutland@arm.com>, <robh@kernel.org>
CC: <coresight@lists.linaro.org>, <devicetree@vger.kernel.org>,
	<dianders@chromium.org>, <james.clark@linaro.org>,
	<jonathan.cameron@huawei.com>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linuxarm@huawei.com>,
	<mike.leach@linaro.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: [PATCH 0/5] Refactoring finding CPU phandles in DT
Date: Mon, 7 Jul 2025 16:04:09 +0100
Message-ID: <20250707150414.620-1-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

[1] https://lore.kernel.org/all/20250512080715.82-1-alireza.sanaee@huawei.com/

Alireza Sanaee (5):
  of: add infra for finding CPU id from phandle
  arch_topology: update CPU map to use the new API
  coresight: cti: Use of_cpu_phandle_to_id for grabbing CPU id
  coresight: Use of_cpu_phandle_to_id for grabbing CPU id
  perf/arm-dsu: refactor cpu id retrieval via new API
    of_cpu_phandle_to_id

 drivers/base/arch_topology.c                  | 12 ++++----
 .../coresight/coresight-cti-platform.c        | 15 ++--------
 .../hwtracing/coresight/coresight-platform.c  | 14 ++-------
 drivers/of/cpu.c                              | 29 +++++++++++++++++++
 drivers/perf/arm_dsu_pmu.c                    |  6 ++--
 include/linux/of.h                            |  9 ++++++
 6 files changed, 51 insertions(+), 34 deletions(-)

-- 
2.43.0

