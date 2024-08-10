Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07F3EA69;
	Sat, 10 Aug 2024 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723285108; cv=none; b=DeGvAzj5NDCVkLnPne2LxOztQbfvc9YqdOXLV+uBXaETlvj8QqugBw3ge3FX3z28F4DFo3LCriCVaMUO2bs5oW/IBNWKx8MPGavn570/PSWbAZOvHA8hUHEgj5v5CHjdjt1Vsal9xCJbz+uTBpyr0bOWUX5lzOp/aNXcbgqu9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723285108; c=relaxed/simple;
	bh=Tz7IYKs7+yGssg2l4ZuXroiPy7tnETLyRBqm35Y6p6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ss4OB6FmMt5JA3bM/Glns3rc/4YFJYzTSDMqNpl5n6TnNhrbdlaVc83jc7rkDMKf8HSWVpeFn6M14kS54rlBixChCN5ouun/HnHWD493xdmH4wiMIVR3M6c4Se7/V7w2Wu00/P5d6M7PnVrwuPdw98uY4nCBZ1ETZzlCg8qdZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WgxYr6jhdz4f3jJB;
	Sat, 10 Aug 2024 18:18:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6EB921A0568;
	Sat, 10 Aug 2024 18:18:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgBXfoRuPrdmTV4rBQ--.16555S4;
	Sat, 10 Aug 2024 18:18:23 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luogengkun@huaweicloud.com
Subject: [PATCH v3 0/2] *** Fix small negative period being ignored ***
Date: Sat, 10 Aug 2024 10:24:03 +0000
Message-Id: <20240810102406.1190402-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXfoRuPrdmTV4rBQ--.16555S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYP7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14
	v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

v2 -> v3:
1. Replace perf_clock with jiffies in perf_adjust_freq_unthr_context

Luo Gengkun (2):
  perf/core: Fix small negative period being ignored
  perf/core: Fix incorrected time diff in tick adjust period

 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.34.1

