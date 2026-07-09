Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993EE3769FA;
	Thu,  9 Jul 2026 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608014; cv=none; b=LpOfmsfIhiE3xMTD4WgwIwzLmaqr1kke4KSqnqkTQMR4L9ZoCZ3YhfTga0Hjcdlr/0+0bgxd5tGbI31VDYZA6yTZKyMukxZuf+0FUPVtMFMtXivim8wb+lvplSNb/70Brep8SsSkVxj6VWzNfPa2siQIIKT3uFgh9dPxAk7WnOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608014; c=relaxed/simple;
	bh=dTWZAhXUg/zIANpVE145MggYBDQAbM1dZ1/YXMvvVOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DI/vk9CSEbPgp8ODfdcX1CneHu0t+FIir584Dog/9ofYYhLD54mcltnoWIqRPQPvf9mKTve9sXOY+wq7XxROQNRA1fmC62gRnzYsMYZUiPFJRARLtPLB36qnYLccQhQP6gn4U8UtgkpgUq1qvGeDxUvj41S/bSSHGHLZe+h0III=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=b2gLKjz3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="b2gLKjz3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD1433593;
	Thu,  9 Jul 2026 07:40:07 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB6D13F66F;
	Thu,  9 Jul 2026 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783608012; bh=dTWZAhXUg/zIANpVE145MggYBDQAbM1dZ1/YXMvvVOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2gLKjz3lHVUVmjhx6a7QM3yzxS7NX/9h9oX8hx/y4KIsHg86VbbkfpRW7xbKJQkG
	 dTLmP7Q3tgsFtMOmaxDae0OeHhBg+88hTTFRc01SJYGEQf73jJ+xjwlv47lOceV9yQ
	 nP61o3K89S2tygk9//p5Uh0lgaSrtTzFrK4jH79E=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: ilkka@os.amperecomputing.com,
	bwicaksono@nvidia.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/4] perf/arm_cspmu: Improve sub-module error reporting
Date: Thu,  9 Jul 2026 15:39:55 +0100
Message-ID: <f8bdaf6c3f0ec2be905e43766410177d3c409690.1783605641.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1783605641.git.robin.murphy@arm.com>
References: <cover.1783605641.git.robin.murphy@arm.com>
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

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 0570be74d11f..0b26a1588eba 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -438,13 +438,15 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
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

