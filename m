Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795763448;
	b=4BQHpwcS2XFtXb9mZKsOtZ3A7e+4+jMVd1jMZTb8/ufrULgqgGeF4RO/yh3zhRx0FTZO
	 9ZoREJxbX+BLElHSS+93CQ9dDoY7lQHnMWHx3mp73XEbLsMuu3KS4X8N8W6HZ4vNv6YNc
	 KfIo14aLs2DzClZnfVoKDgmH7j01P3jty6ih4MjQ972AeLbtJfGqcZGlPKPCnEXuKVf9r
	 kmnK7M7Ka7kED9R/HkATCCsfff1CQundJLUfB6k0k55vcXVf9xhcVWU9vDNZXmuBh+qjD
	 OZzdGvpCls9LDiFZ39DiMjzeBnyzBDtDwF6YY2V5RvuApqyQ4VW2LNmfJyaZHJr9kDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763448;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K5UnO/HVNaEZuU1ks4QKgaqDoGYKFkvZOzz6WTltCGM=;
	b=Ntl3aQ8ZBMyJWzv6FBe3IVqy/UMHPsMmyWdY4k6sN/uSgWgrXqbk5NOlxEP19lFSsBwK
	 TsidMbxTMUQmsFMS8amRKUBfq9Cz7RbJhupkOi4KuetIV1T7FFpIQcgaIbmpcNH/BNBOw
	 sliWeqc5KbslmTb38oPDjmvtRtYOOSMod0dtPjRnYyS6pAOVxd5fCbDo6GFq2ITO9W8kF
	 4ExZsv5WZCP0ZHeOVHs+QZRjqS9MDdwzfb8KYDOFNInMAJ4cn6elbuAt8Gi7wJgxH0q3c
	 Z1bF6yuYLNHg7+FHrFynFwpd9xWO5LbblJKN2mmcwpHP2swfxjO0yRmNh3T1xWfGM/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XVHGxq2M;
	arc=none smtp.remote-ip=115.124.30.119
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D35606A336;
	Fri, 27 Nov 2026 07:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9D35606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XVHGxq2M
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795763436; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=K5UnO/HVNaEZuU1ks4QKgaqDoGYKFkvZOzz6WTltCGM=;
	b=XVHGxq2MX7JvD9SYmWGcHLVK5ePfUra3YYRo3N6KAjuYnq//jxhmyIqKuz9UbqHNtlBV/Uvav2J4Nc33+77NA2MG/kpj3cNhFqzeH7aIY5tzrKkyFrCD411NWbWew+UQ2CyXLg5cVSUQZw1bGUq53JG2JDVRy9Sj5UKYKKNV3iM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=jiangtianfeng@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFX36Mc_1795763423;
Received: from h68d07384.sqa.eu95.tbsite.net(mailfrom:jiangtianfeng@linux.alibaba.com fp:SMTPD_---0XFX36Mc_1795763423 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 15:10:36 +0800
From: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiangtianfeng@linux.alibaba.com
Subject: [PATCH 0/2] perf/arm_cspmu: nvidia: Fix TGT address-filter handling
Date: Fri, 27 Nov 2026 15:10:08 +0800
Message-ID: <20261127071021.820833-1-jiangtianfeng@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
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

The Tegra410 PCIE-TGT implementation has two independent issues in its
address-filter handling.

First, an empty ACPI memory-resource list is accepted during probe,
leaving addr_filter_reg as NULL and allowing a later filter event to
perform an invalid MMIO access.

Second, the slot lookup can allocate a free slot before finding an
identical active filter, reset can match zeroed metadata from a free
slot, and cycle events can reset a slot they never allocated. These can
cause wrong-slot release, refcount underflow, and loss of filtering for
an active event.

This series rejects the missing resource at probe and fixes the slot
lifecycle without changing the shared PMU callback ABI or rejecting
valid zero base/mask filter data.

AI assistance disclosure:
Qoder AI coding assistant was used with the current upstream source and
the identified defect sequences as inputs. It contributed to the problem
analysis, code changes, state model, and changelog drafts. The human
submitter is responsible for reviewing the complete series and adding
their own Signed-off-by tags.

Validation:
- source-derived model reproduces wrong-slot release, zero base/mask
  underflow, and cycle/reset underflow before the fix;
- the proposed lifecycle model passes those cases and 100 x 500 random
  operations;
- independent static review covers duplicate filters, arbitrary stop
  order, zero base/mask, cycle, full slots, and reset-without-allocation;
- checkpatch.pl reports no issues other than the expected missing human
  Signed-off-by tags in this unsigned draft;
- complete ARM64 Image builds successfully;
- nvidia_cspmu.o and arm_cspmu.o build with W=1 without new warnings.

NOT_RUN:
- runtime fault injection or probe validation with abnormal ACPI tables;
- real address filtering, duplicate event start/stop, cycle/reset, slot
  exhaustion, module reload, or multi-RC testing;
- PCIe/CXL traffic, target hardware, existing Ampere/NVIDIA runtime
  regression, or long-duration testing.

Jiangtian Feng (2):
  perf/arm_cspmu: nvidia: Reject missing TGT address-filter resource
  perf/arm_cspmu: nvidia: Fix TGT address-filter slot lifecycle

 drivers/perf/arm_cspmu/nvidia_cspmu.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
2.47.3

