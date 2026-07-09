Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4554723;
	Thu,  9 Jul 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608011; cv=none; b=ilX7qM/wBTu7A1YShwnBSfTvwb3+FKwobbnZSDeSq5ss/chePe85GPFeWxs3m+F3m6ElhrYXx0U13QH45sLXaryrJwG7QcsvVWCMxfJlak0UudwwrzykdbxQVHwCsgPPVIC481dNDTtmzgItiGkMX+V/LNTeNgjmzy65WQMUStI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608011; c=relaxed/simple;
	bh=6tXjr5QO/6YpXAvLeEr0jkgC5AsB7mddypUG7wFuDXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUzL4NiXHPxKjmf6nZzIUFXUGGTKdEGDTmJS+EsskqGBh2+IxMVtT5zU9J6oOEAttUHIpdzVD+oJGTRsvkZ/NnjTPgYllbcZDTat7G0B8EXqvw9MN+ZTJp28X1iJeSfaWeluRSP7TEDLCqXAU4tcdzC0QndEiOh/h1dUSHAZR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NI6w7jDQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NI6w7jDQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AD56152B;
	Thu,  9 Jul 2026 07:40:04 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47FC43F66F;
	Thu,  9 Jul 2026 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783608008; bh=6tXjr5QO/6YpXAvLeEr0jkgC5AsB7mddypUG7wFuDXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NI6w7jDQxpdSmGIVoj1i5//Y0khHktxUQkccnY6MwIR5wPUQOSz303ROQdY8GLuzg
	 FHfN4uazbZXOMbTCY8H/1R9SYC26BKRW3cZnVXlSGXIDemLkmdaoIyKGqATXutcD+Z
	 l7C6Rw36CM2h2m49Pr871KAufRsX/FNEfbmkFnro=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: ilkka@os.amperecomputing.com,
	bwicaksono@nvidia.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>
Subject: [PATCH 1/4] ACPI/APMT: Use stable device ID
Date: Thu,  9 Jul 2026 15:39:53 +0100
Message-ID: <c113eff51124250fc5798589ce905052046b43b3.1783605641.git.robin.murphy@arm.com>
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

The APMT node format includes a unique identifier, so we can use this as
the platform device ID to give userspace stable and identifiable device
names, rather than auto numbering dependent on how the table is parsed.

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/arm64/apmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
index bb010f6164e5..ba48fcb26d52 100644
--- a/drivers/acpi/arm64/apmt.c
+++ b/drivers/acpi/arm64/apmt.c
@@ -79,7 +79,7 @@ static int __init apmt_add_platform_device(struct acpi_apmt_node *node,
 	int ret, count;
 	struct resource res[DEV_MAX_RESOURCE_COUNT];
 
-	pdev = platform_device_alloc(DEV_NAME, PLATFORM_DEVID_AUTO);
+	pdev = platform_device_alloc(DEV_NAME, node->id);
 	if (!pdev)
 		return -ENOMEM;
 
-- 
2.54.0.dirty

