Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C1B17A2F6;
	Mon, 12 May 2025 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037248; cv=none; b=rf/uuP04WCaPMJOOdC92aSqK7Q4zceFVA9XbUJvrW+QVS6vjFOZJYeNh6gx24GB/v0OqnA64JL7gJ4f9+f27QS4Uk8smBggbrM1kq78ZQ0Fs3R4O/rjXDFh5SQ7U8RoGK2uFN/kMVzecR9QYkrgoSZVS2/KFSpSLJoJ03vcabY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037248; c=relaxed/simple;
	bh=cKm2n4AH6F3DTn3dvdbDG6iaw7pJk0gCrqJKwsVEGJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pd1nLB7E1WmfVHDlOIDw1xvg591LDb8T6cIEObnwau7Dw3PMZ1EGpyxfmroBGXk6xGpQq9jHDkzCjhZICkA9ycBAevqLb+YnwWnkaFnHtSSuMO48wF6qiLVj1LqjmHshW62Od/GwVbWhQ5vddR+ntN9nUlAcC1iHT6KSzAWsOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZwsZq4BwBz67Y2h;
	Mon, 12 May 2025 16:04:35 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id F25291402F4;
	Mon, 12 May 2025 16:07:17 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.30.10) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 May 2025 10:07:16 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <devicetree@vger.kernel.org>
CC: <robh@kernel.org>, <alireza.sanaee@huawei.com>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<mark.rutland@arm.com>, <shameerali.kolothum.thodi@huawei.com>,
	<krzk@kernel.org>, <dianders@chromium.org>, <catalin.marinas@arm.com>,
	<suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@linaro.org>,
	<linux-perf-users@vger.kernel.org>, <coresight@lists.linaro.org>,
	<gshan@redhat.com>, <ruanjinjie@huawei.com>, <saravanak@google.com>
Subject: [PATCH v3 0/7] DT: Enable sharing resources for SMT threads
Date: Mon, 12 May 2025 09:07:08 +0100
Message-ID: <20250512080715.82-1-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500003.china.huawei.com (7.182.85.28)

This patchset allows for sharing resources between SMT threads in the
device tree (DT).

WHY? Given the current use of the DT, it is not possible to share L1
caches, as well as other resources such as clock among SMT threads.
However, DT spec in section Section 3.8.1 [1], describes how SMT threads
can be described in the reg array, this is how PowerPC describes SMT
threads in DT.

CHALLENGE: Given discussions with the community [2], it was apparent
that it is not straightforward to implement this, since cpu-maps must
point to a particular CPU node in DT [3], Section 2.1. However, it is
not only the cpu-map but also there other nodes that point to cpu nodes
which indeed need care and changes.

SOLUTION: This led to more discussions on what the solution should look
like and based on recent conversations we ended up with the following
approach [4].

core0 {
  thread0 {
    cpu = <&cpu0 0>;
  };
  thread1 {
    cpu = <&cpu0 1>;
  };
};

In this layout, first parameter is the phandle to cpu-node and second
index would be the local-thread index in the reg array available in the
cpu-node reg property.

SIDE-NOTE: This patchset does not change any bindings, so I am not
including anything in this patchset.

[1] https://github.com/devicetree-org/devicetree-specification/releases/download/v0.4/devicetree-specification-v0.4.pdf
[2] https://lore.kernel.org/linux-arm-kernel/Z4FJZPRg75YIUR2l@J2N7QTR9R3/
[3] https://www.kernel.org/doc/Documentation/devicetree/bindings/cpu/cpu-topology.txt
[4] https://lore.kernel.org/devicetree-spec/CAL_JsqK1yqRLD9B+G7UUp=D8K++mXHq0Rmv=1i6DL_jXyZwXAw@mail.gmail.com/

PRIOR VERSIONs:
   [V1] https://lore.kernel.org/all/20250422084340.457-1-alireza.sanaee@huawei.com/
   [V2] https://lore.kernel.org/all/20250502161300.1411-1-alireza.sanaee@huawei.com/

CHANGE LOG:
    V2 -> V3:
        * I got the V2 completely wrong, so I updated it.
        * Re-introduce #cpu-cells property.
    V1 -> V2:
        * Address Rob's comments.
            ** Re-order patches.
            ** Fix bugs.
        * Remove #cpu-cells property

Alireza Sanaee (7):
  of: add infra for finding CPU id from phandle
  arch_topology: update CPU map to use the new API
  coresight: cti: Use of_cpu_phandle_to_id for grabbing CPU id
  coresight: Use of_cpu_phandle_to_id for grabbing CPU id
  perf/arm-dsu: refactor cpu id retrieval via new API
    of_cpu_phandle_to_id
  arm64: of: handle multiple threads in ARM cpu node
  of: of_cpu_phandle_to_id to support SMT threads

 arch/arm64/kernel/smp.c                       | 74 ++++++++++---------
 drivers/base/arch_topology.c                  | 12 +--
 .../coresight/coresight-cti-platform.c        | 15 +---
 .../hwtracing/coresight/coresight-platform.c  | 14 +---
 drivers/of/cpu.c                              | 56 +++++++++++++-
 drivers/perf/arm_dsu_pmu.c                    |  6 +-
 include/linux/of.h                            |  9 +++
 7 files changed, 118 insertions(+), 68 deletions(-)

-- 
2.34.1

