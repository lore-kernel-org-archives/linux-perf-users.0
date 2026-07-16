Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6565429017;
	Thu, 16 Jul 2026 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213813; cv=none; b=jpYn5yvzWEeLBOBZdQxxqXAJdydnUjCSAsk73IX19BK2wg7qV27Iej2NxtZEhBotm0FFYELQXkpfFjazMHSwGOslYx2U8WAwSBoLWOCakzJ+NpZA8QdGr1F/aXdEXjzNxftRKEAXYceXGBGGgai+81IrC9RBqwXOpJQkKbBnjEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213813; c=relaxed/simple;
	bh=Q9arXXauN4GVB8Ak/vT3fe4bjkQnGWjRmuD+Jz/T9SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCrEP8N2suMt7cuapTbxoQJAbq1fjokhy3SCwJbiDmCbd3+tmSn7+7Ich9t1kTyesY1hp/J4E5ZGcjxk2x633tz0ewOJYRfeVXJUA4kvGe4VBFcncZr22i/eR0CJ29fnCiIrBTB6kXSA7L5fXXWrNabk97qSNUl+BM0IQmRJVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fI7mf3kz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fI7mf3kz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA32C168F;
	Thu, 16 Jul 2026 07:56:46 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0329B3F7B4;
	Thu, 16 Jul 2026 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784213811; bh=Q9arXXauN4GVB8Ak/vT3fe4bjkQnGWjRmuD+Jz/T9SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fI7mf3kzLxo6w/1wD0KoNeQan67ZPRAiUGDDosXpRUMREtCx+/NR+427pYecT3IG0
	 5hhgicBKmi3QclxCy9dziihQOw3Ibtymhibbgs2vOGiUB5Z9prmCqRfwNKoAfGDbz0
	 z51BKp+X/3cCe3wSCy4Kl7NIN5gVt8G+x3JElL0w=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: ilkka@os.amperecomputing.com,
	bwicaksono@nvidia.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 3/4] perf/arm_cspmu: Improve sub-module error reporting
Date: Thu, 16 Jul 2026 15:56:36 +0100
Message-ID: <256bcb4c8c98dc95bfdf295adb66b917545c919b.1784213435.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1784213435.git.robin.murphy@arm.com>
References: <cover.1784213435.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When waiting for a sub-module to register, we return a bare
-EPROBE_DEFER that ends up showing the end user:

  platform arm-cs-arch-pmu.1: deferred probe pending (no reason)

wherein it's not necessarily clear that they might need to take some
action to ensure the appropriate module is available to load. Let's use
dev_err_probe() here so we can show exactly what we're waiting for.

Similarly, in the case where something's gone horribly wrong with an
already-registered module, we can use dev_WARN() to standardise the
device/driver attribution rather than just open-coding "arm_cspmu".

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---
v2: No change
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 8c2dda17d73e..caad9a36651d 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -437,13 +437,15 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 				if (ret)
 					module_put(match->module);
 			} else {
-				WARN(1, "arm_cspmu failed to get module: %s\n",
+				dev_WARN(cspmu->dev, "Failed to get module: %s\n",
 					match->module_name);
 				ret = -EINVAL;
 			}
 		} else {
 			request_module_nowait(match->module_name);
-			ret = -EPROBE_DEFER;
+			ret = dev_err_probe(cspmu->dev, -EPROBE_DEFER,
+					    "Waiting for module %s to load\n",
+					    match->module_name);
 		}
 
 		mutex_unlock(&arm_cspmu_lock);
-- 
2.54.0.dirty

