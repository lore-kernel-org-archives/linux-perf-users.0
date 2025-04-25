Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DFE2701DD
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745552337; cv=none; b=TQCRx3BCaxMDsWjuNeAGVTvj53oZA0/iPVSToRxvDrZ2ecba1naoAxjYTY/bOLwNqjJKsbep5YfIOgRsDXOIBl5wWS4omshpUYCqcFmZ8OrC3+g6yJeCsTaw3BaLsfLwGoFDqXvqtAaqaZnoyT2lIQIxsIG3YrO2kdQuz5ZDScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745552337; c=relaxed/simple;
	bh=bCtAFtT1I1tcjOqyAqs69/vNC618iHuFvpbrNaXxn2k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UKYOexwPl5AOSo7r1DltdkKPfVIWDZ9mqlv7xZKBG3KCiQKvc49tQ1G9Rnk8QNGw1h9oZkDuen0EWXqTNbsix7zTMqPCxQpc6kKA+nTha+7ybAej0YmVUk36r1829ftUNbqfxkhae2ylWJ90A+LJphrzmNEKn9hDxTsLhOjdQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZkJQ059dxz8xGx;
	Fri, 25 Apr 2025 11:35:20 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CD1B1401E9;
	Fri, 25 Apr 2025 11:38:51 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 25 Apr 2025 11:38:50 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<mark.rutland@arm.com>, <jolsa@kernel.org>, <john.g.garry@oracle.com>,
	<james.clark@linaro.org>, <leo.yan@linux.dev>, <irogers@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <hejunhao3@huawei.com>,
	<linuxarm@huawei.com>, <wangyushan12@huawei.com>, <caijingtao@huawei.com>,
	<xueshan2@huawei.com>, <prime.zeng@hisilicon.com>, <yangyicong@hisilicon.com>
Subject: [PATCH v2 0/3] Add support for SPE Data Source packet on HiSilicon HIP12
Date: Fri, 25 Apr 2025 11:38:42 +0800
Message-ID: <20250425033845.57671-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

Add support for Data Source packet on HIP12. Support counting L2 HITM for c2c
statistic since it was missing.

Change since v2:
- split the kernel/userspace changes into different patch
- revise some mem_snoop decoding according to the discussion
- count missing L2 HITM for c2c statistic
Link: https://lore.kernel.org/linux-perf-users/20250408122809.37884-1-yangyicong@huawei.com/

Yicong Yang (3):
  arm64: cputype: Add cputype definition for HIP12
  perf arm-spe: Add support for SPE Data Source packet on HiSilicon
    HIP12
  perf mem: Count L2 HITM for c2c statistic

 arch/arm64/include/asm/cputype.h              |  2 +
 tools/arch/arm64/include/asm/cputype.h        |  2 +
 .../util/arm-spe-decoder/arm-spe-decoder.h    | 17 ++++
 tools/perf/util/arm-spe.c                     | 96 +++++++++++++++++++
 tools/perf/util/mem-events.c                  |  5 +-
 5 files changed, 121 insertions(+), 1 deletion(-)

-- 
2.24.0

