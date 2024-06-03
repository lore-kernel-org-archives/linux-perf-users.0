Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5632282D86;
	Mon,  3 Jun 2024 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407226; cv=none; b=Kl22NDWBopGYRobKNYO3A5VlgQlUZfH/95JWgpkSilluJ7vkWouwLBHK1+oSuoDX3vtqIZl1kFDh3i0MjP8CoEyC5yywL3IPpWhn36MGtIeaIPjIoKJ0+l0PhYXX+BsgqNBs7iRjgAcQ1zfyvBFS9Tq3N8dUFXKHLed0IPbJAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407226; c=relaxed/simple;
	bh=irUYFkAM4ysrKF+H1+xbc54MGs1P7MFJrAkGBeKcA2s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cZKNNN+zXCEJUKJWyTeITjb01SEoza8H5a5V6lf/A/Ud3pyVMUL5MHIZ6zYSeBeF1MkpGdkfVzSJvUPzUhZolBIbTR8SigMO0Kw+RtW2UQuG5ymUnjVJZHgsv4W7g4ew+y/qKC83yz4Zyw9azJnV9QQ4sHOs4d/Bl6Ui2c7xfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Vt7jQ2TGNzwRJy;
	Mon,  3 Jun 2024 17:29:46 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 4866118006E;
	Mon,  3 Jun 2024 17:33:40 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Jun 2024 17:33:39 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>, <dongli.zhang@oracle.com>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 0/3] Perf avoid opening events on offline CPUs
Date: Mon, 3 Jun 2024 17:28:09 +0800
Message-ID: <20240603092812.46616-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

If user doesn't specify the CPUs, perf will try to open events on CPUs
of the PMU which is initialized from the PMU's "cpumask" or "cpus" sysfs
attributes if provided. But we doesn't check whether the CPUs provided
by the PMU are all online. So we may open events on offline CPUs if PMU
driver provide offline CPUs and then we'll be rejected by the kernel:

[root@localhost yang]# echo 0 > /sys/devices/system/cpu/cpu0/online
[root@localhost yang]# ./perf_static stat -e armv8_pmuv3_0/cycles/ --timeout 100
Error:
The sys_perf_event_open() syscall returned with 19 (No such device) for event (cpu-clock).
/bin/dmesg | grep -i perf may provide additional information.

This patchset tries to avoid this case by:
- Double check the PMU's cpumask in the perf tool and only include online CPUs
- Trying to make the PMU drivers only export online CPUs in its "cpus" or "cpumask"
  attributes

Previously discussion can be found at [1]. Will suggested to do it in userspace.
I think it makes sense to do a double check in the perf tool in case the driver
doesn't do this. So PATCH 1/3 is added in this version.

[1] https://lore.kernel.org/linux-arm-kernel/20240410095833.63934-1-yangyicong@huawei.com/

Yicong Yang (3):
  perf pmu: Limit PMU cpumask to online CPUs
  perf: arm_pmu: Only show online CPUs in device's "cpus" attribute
  perf: arm_spe: Only show online CPUs in device's "cpumask" attribute

 drivers/perf/arm_pmu.c     | 24 +++++++++++++++++++++++-
 drivers/perf/arm_spe_pmu.c | 22 +++++++++++++++++++++-
 tools/perf/util/pmu.c      | 13 +++++++++++--
 3 files changed, 55 insertions(+), 4 deletions(-)

-- 
2.24.0

