Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043631DDC0F;
	Thu, 10 Apr 2025 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284044; cv=none; b=sy4vMQ7QX5MZZC8nNtC6jXGkHSfiK86oo0iCYehuSAGbewLBYg/WR798v+5UyukILUis/GrG4hEQeuOhENwfW7beQ0WtBK4S3QQ1eQ0fcvrrAyb+5lT5cuJBgeuDLOMvxq3XeHKzcY8TnPP9Mi2FUmV3jDvVZFFAsoa6KADs4IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284044; c=relaxed/simple;
	bh=ZqO1NsnyEZ3YKVLWhmhnGFhPqL9CSj9lOsRen8/qGAk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kWwkmqgP+U89ozOAg46Da+nq1Eu5jrHPQqyo2sLbmW7IsfEGbiohxh4CCP9ab640Xcu3Y2ozpQyl5f7RwLF+LzzBU12eN34+fWU33hK7ZNQv7f5MpvIeMGCpqx7o7xj+EAF7Lj61aWbkR5hy7IAAdEepFwWwUsY84+YCJSUKjho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201601.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202504101920305716;
        Thu, 10 Apr 2025 19:20:30 +0800
Received: from locahost.localdomain.com (10.94.12.92) by
 jtjnmail201601.home.langchao.com (10.100.2.1) with Microsoft SMTP Server id
 15.1.2507.39; Thu, 10 Apr 2025 19:20:29 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <will@kernel.org>, <mark.rutland@arm.com>, <suzuki.poulose@arm.com>,
	<Ganapatrao.Kulkarni@cavium.com>, <gkulkarni@marvell.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles
 Han <hanchunchao@inspur.com>
Subject: [PATCH] drivers/perf: Add NULL check in thunderx2_pmu
Date: Thu, 10 Apr 2025 19:20:27 +0800
Message-ID: <20250410112027.80131-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025410192030a0f7fa84987e895022f81a4fc1e0c39c
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kasprintf() can return a NULL pointer on failure,but this
returned value in tx2_uncore_pmu_register() and
tx2_uncore_pmu_init_dev() is not checked.
Add NULL check in tx2_uncore_pmu_register() and
tx2_uncore_pmu_init_dev(), to handle kernel NULL
pointer dereference error.

Fixes: 69c32972d593 ("drivers/perf: Add Cavium ThunderX2 SoC UNCORE PMU driver")
Fixes: 5e2c27e833bb ("drivers/perf: Add CCPI2 PMU support in ThunderX2 UNCORE driver.")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/perf/thunderx2_pmu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 6ed4707bd6bb..03dd297ff326 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -738,6 +738,8 @@ static int tx2_uncore_pmu_register(
 
 	tx2_pmu->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
 			"%s", name);
+	if (!tx2_pmu->pmu.name)
+		return -ENOMEM;
 
 	return perf_pmu_register(&tx2_pmu->pmu, tx2_pmu->pmu.name, -1);
 }
@@ -837,6 +839,11 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
 		tx2_pmu->attr_groups = l3c_pmu_attr_groups;
 		tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
 				"uncore_l3c_%d", tx2_pmu->node);
+		if (!tx2_pmu->name) {
+			devm_kfree(dev, tx2_pmu);
+			return ERR_PTR(-ENOMEM);
+		}
+
 		tx2_pmu->init_cntr_base = init_cntr_base_l3c;
 		tx2_pmu->start_event = uncore_start_event_l3c;
 		tx2_pmu->stop_event = uncore_stop_event_l3c;
@@ -852,6 +859,11 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
 		tx2_pmu->attr_groups = dmc_pmu_attr_groups;
 		tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
 				"uncore_dmc_%d", tx2_pmu->node);
+		if (!tx2_pmu->name) {
+			devm_kfree(dev, tx2_pmu);
+			return ERR_PTR(-ENOMEM);
+		}
+
 		tx2_pmu->init_cntr_base = init_cntr_base_dmc;
 		tx2_pmu->start_event = uncore_start_event_dmc;
 		tx2_pmu->stop_event = uncore_stop_event_dmc;
@@ -866,6 +878,11 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
 		tx2_pmu->attr_groups = ccpi2_pmu_attr_groups;
 		tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
 				"uncore_ccpi2_%d", tx2_pmu->node);
+		if (!tx2_pmu->name) {
+			devm_kfree(dev, tx2_pmu);
+			return ERR_PTR(-ENOMEM);
+		}
+
 		tx2_pmu->init_cntr_base = init_cntr_base_ccpi2;
 		tx2_pmu->start_event = uncore_start_event_ccpi2;
 		tx2_pmu->stop_event = uncore_stop_event_ccpi2;
-- 
2.43.0

