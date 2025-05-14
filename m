Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A581F91F6;
	Wed, 14 May 2025 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204250; cv=none; b=oG6rbJw6zyNxQXmnCgp+QFkn2/c0hHmYWInk6IMN3XJfhBXFHVdx8EoXePMIlxK4eW44H+ZP3VgSrBGD+O3TZIqJhcsWNpbu0FjFFMhIbXuoyFE2ndL48XiRvimB+goL5UgUNbxxa8JzfTFGqQfHgWfPRNIzB3i0tlM3MDiVb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204250; c=relaxed/simple;
	bh=zg4yQhnZ7x9uWi+mdu4h2qeIUYKF+Kr2SRjgijuoIA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YRb/LIJAU71bzngFWQ+iayirHpgGzcFMkBcbN+0f9KVhpdtJ2VQ58oTKq9yAfTnPV+BwAEfeCvMxaKL7vP1hRUfM8yq2r4D5doIQzMvgHaSyS0q643vuZ2dxochon2DVD205bsHpLB6dDXK+YpbU7ZOCJu9ZUwY3GOZdiauxoJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4Zy3PX1CCZzKHMdM;
	Wed, 14 May 2025 14:30:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C728F1A07C0;
	Wed, 14 May 2025 14:30:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl+NOCRovzV0MQ--.23862S4;
	Wed, 14 May 2025 14:30:38 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	yeoreum.yun@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH Fix perf cgroup problem 0/2]
Date: Wed, 14 May 2025 06:47:56 +0000
Message-Id: <20250514064758.4156497-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnSl+NOCRovzV0MQ--.23862S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY-7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

Fixed the issue that nr_cgroup and cpuctx->cgrp of the perf cgroup event
are not correctly updated. And Fixed the possible concurrency of
perf_cgroup_switch and perf_cgroup_event_disable.

Luo Gengkun (2):
  perf/core: Fix nr_cgroups/cpuctx->cgrp is not updated correctly
  perf/core: Fix WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0) in
    perf_cgroup_switch

 kernel/events/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.34.1

