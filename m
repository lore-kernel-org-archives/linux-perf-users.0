Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93E530C61B;
	Mon,  1 Dec 2025 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588172; cv=none; b=Erlo7bx4smTplico5xFkX5TIMKQAITw2+3Oacm2mLlDPdF3NnhgghputGYAUjLI6tmsPTQEWR2eJkB0PJX6x/8EwDw0fTVmBJtR6JBGDws/KAsqpX8NaW+wUCQnsAlMrJGzPMQNfz0GXmWB1uuYyvfp0Apgw1gUrbFWkdViMJ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588172; c=relaxed/simple;
	bh=f8fiAsWWNi9eG7kzbI25lHuMO+0SEpBi2vesAPCLkBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VtxXD3tmriWu38nyzQLcw2n3XhZxg/XEDNYsIQE9BZNA5dMHR2LAq1JnszrozoxIyKhc5GZpC59oEvj7IQc9+Q/yZO40QQiqK+0SfNV2kH8aZHl1uejud6lYsp4XxyoGehbHgMuzuHsg7lANetzVDzpM5uKMRb/oVwXYcPQYLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1ADF153B;
	Mon,  1 Dec 2025 03:22:42 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2D583F59E;
	Mon,  1 Dec 2025 03:22:47 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:22:05 +0000
Subject: [PATCH 15/19] coresight: trbe: Add static key for bypassing
 trigger mode
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-15-7da32b076b28@arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>, 
 Tamas Zsoldos <tamas.zsoldos@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=1845;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=f8fiAsWWNi9eG7kzbI25lHuMO+0SEpBi2vesAPCLkBQ=;
 b=siS5jicoBJRIEarVYCG4OsMb2IDUFmciW/1Nkg+AM25TbL8IlrHgAYVJqIIaH1u9S9Qal+dNp
 i8heRWCOmCKDw3rmu9hdz7xMe10PTYu9LJWEPrKBPdbZbxF3IFKX7PQ
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

To avoid complexity, if any CPU in the system has the fill mode erratum,
the driver will not use trigger mode, it simply rolls back to fill mode
only and apply the workaround on it.

Add a static key to control trigger mode bypassing.  During each CPU
probe, the key is enabled when the relevant erratum is detected.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 941aa46e9b11f60c707eb40093964de454a3fd83..8390d0a8fe23d35945610df15f21751279ee37ee 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -17,6 +17,7 @@
 
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
+#include <linux/jump_label.h>
 #include <linux/kvm_host.h>
 #include <linux/vmalloc.h>
 
@@ -147,6 +148,12 @@ struct trbe_drvdata {
 	struct platform_device *pdev;
 };
 
+DEFINE_STATIC_KEY_FALSE(trbe_trigger_mode_bypass);
+
+#define trbe_trigger_mode_need_bypass(cpudata)		\
+	(trbe_may_overwrite_in_fill_mode((cpudata)) ||	\
+	 trbe_may_write_out_of_range((cpudata)))
+
 static void trbe_check_errata(struct trbe_cpudata *cpudata)
 {
 	int i;
@@ -1306,6 +1313,14 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
 
 	dev_set_drvdata(&trbe_csdev->dev, cpudata);
 	coresight_set_percpu_sink(cpu, trbe_csdev);
+
+	/*
+	 * If any CPU cannot use trigger mode, bypass the mode globally for
+	 * consistent tracing behaviour.
+	 */
+	if (trbe_trigger_mode_need_bypass(cpudata))
+		static_branch_enable(&trbe_trigger_mode_bypass);
+
 	return;
 cpu_clear:
 	cpumask_clear_cpu(cpu, &drvdata->supported_cpus);

-- 
2.34.1

