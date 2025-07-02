Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528D2857C5
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Jul 2025 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465301; cv=none; b=kzJ1KdV3QZ6hCuiE6O+9tnQ3hWsAg5hKUAQS8aJS+Hd2wzN+/2L0j29gw3AbZYbMdcT99z3+i94P8kVXuF4ysHxU1llzBDK64k7WifMExf+BsjBKD9WReC6vm7KTzY0b6BmRfe29m6AwHF3hANm+fRYnOmeHiCOSuJJFxjI3J1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465301; c=relaxed/simple;
	bh=khv7WaFQRcLbGmBB6hsyWdmOfNl/vkw99sHyTruVIo0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eMCemkGzFKMnR+RMLQajewd07jKlEbjcBQ8HhJIlagXR6RO3IS0Gc5Yz8+Tak7k2NfN7Qv1XU6XKTXYX9rEvefKjGz+UL8xohdTGejI3cSmHI9CaOjR5K3uBlRvxnjNx+YM3vD97eTc3PJxazCaSXuyoJDMl8HpIM9YzSsy3Il4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C96C22D9;
	Wed,  2 Jul 2025 07:08:03 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C82003F6A8;
	Wed,  2 Jul 2025 07:08:17 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf/arm: Add missing .suppress_bind_attrs
Date: Wed,  2 Jul 2025 15:08:13 +0100
Message-Id: <acd48c341b33b96804a3969ee00b355d40c546e2.1751465293.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PMU drivers should set .suppress_bind_attrs so that userspace is denied
the opportunity to pull the driver out from underneath an in-use PMU
(with predictably unpleasant consequences). Somehow both the CMN and NI
drivers have managed to miss this; put that right.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 1 +
 drivers/perf/arm-ni.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 031d45d0fe3d..d1df2f3adbc5 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2655,6 +2655,7 @@ static struct platform_driver arm_cmn_driver = {
 		.name = "arm-cmn",
 		.of_match_table = of_match_ptr(arm_cmn_of_match),
 		.acpi_match_table = ACPI_PTR(arm_cmn_acpi_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe = arm_cmn_probe,
 	.remove = arm_cmn_remove,
diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index de7b6cce4d68..5f20baf59024 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -707,6 +707,7 @@ static struct platform_driver arm_ni_driver = {
 		.name = "arm-ni",
 		.of_match_table = of_match_ptr(arm_ni_of_match),
 		.acpi_match_table = ACPI_PTR(arm_ni_acpi_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe = arm_ni_probe,
 	.remove = arm_ni_remove,
-- 
2.39.2.101.g768bb238c484.dirty

