Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF81A287F;
	Wed, 21 Aug 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247435; cv=none; b=Vpk2pmjd8cK5Run4qZQZ+/c8lUT9o7WJbOvyn/8U0mK0Dj3nITHFE0BgOZPESJ+DxhUz6aC57vHKFQWNYmCiu6Ntkpl5+kWbysDqe3TMf+Ja/9AMdR5LueoHH4cvPtClr3tdf6zD3Wb1H0qV9mkZ+AVCPeMEZR8ugNyi722K+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247435; c=relaxed/simple;
	bh=14HP1Qy2BiWwSeMEO30xd4JqB4jcQU76GqJ49hp/NXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qY7xjudZtMf1R5h9oZcIciM1qaC6sZEsiHPpFF0xeM2wng3f7WHtsrjr1aaoJhAg3hu9p8yoIoTuUu0VBJnwUYn8ji7XxnpiHeTMAnIT5mz4hkU5krWiZkeym7Ih83A/7WUDLioe99ctXHUH6LV8q5zUCjhP/+O4s2DKG+Fv0IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WpnS01mm9z4f3lWF;
	Wed, 21 Aug 2024 21:36:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 552411A058E;
	Wed, 21 Aug 2024 21:37:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4V97cVmXa5CCQ--.15501S4;
	Wed, 21 Aug 2024 21:37:03 +0800 (CST)
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luogengkun@huaweicloud.com
Subject: [PATCH v4 0/2] Fix perf adjust period 
Date: Wed, 21 Aug 2024 13:42:25 +0000
Message-Id: <20240821134227.577544-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4V97cVmXa5CCQ--.15501S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYB7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2js
	IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI
	0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUouWlDUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

v3->v4:
1. Rebase the patch
2. Tidy up the commit message
3. Modify the code style

Luo Gengkun (2):
  perf/core: Fix small negative period being ignored
  perf/core: Fix incorrect time diff in tick adjust period

 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.34.1

