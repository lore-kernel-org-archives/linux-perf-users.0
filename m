Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD1E2701DC;
	Mon,  6 Jul 2026 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349964; cv=none; b=e9l4ZSBmQHFnREdG4sWO6JhpfU+RWuC4teOzQ1Zgcs+UnsVKVfbtNq3pCxkZTwiyrDB9JKjK2BOa70YS4alzbk2EMg/9KdqJ7uyn+wfjqjlGiJ4F05tiQgdd5iHsjLFbPNO+RpCwowoVrGxm8XoxS1gIQocR/Ourn+g3ybwLMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349964; c=relaxed/simple;
	bh=QsJjw+uVz3ViL8/LdBAU1uDo65+QvBccdroHoQjul4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6+PR5/SY9DdtqoVnKomfGk4VILUwXT1pOfYgPPX8bLusHI9aFbs89SrwU9y3SMvPTITgpof2/d7dNTbUOSYVe3EqX0+UWooTNSllxOc7IQtQU7DHuYWcaFnzfYJY2J9uW/byNTw/C4vepIjHf/X07YOXEaawWbSoIaj/LFHP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u5iU4odY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u5iU4odY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A60D1F000E9;
	Mon,  6 Jul 2026 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783349963;
	bh=tuRuzQOT0T09CzpPaVV8nOKGRc5yeYMghMrWPU6r+Kc=;
	h=From:To:Cc:Subject:Date;
	b=u5iU4odY9fcPkxunqFmDb8zd8zumV9C9aLca8TizOI7I2cD4/C5jBfXFqoxx7xWcj
	 f3VpX5bXBQHtB8mHmFKY+cIiFZSvzmoi6C9iIBGbEyGi62Fxtzx8ElYpjEed5nTaZP
	 JSiP/E2zI05046c5l/n08a4uA87hxG1e9U4cPghw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] drivers/perf: thunderx2_pmu: add error handling
Date: Mon,  6 Jul 2026 16:59:36 +0200
Message-ID: <2026070635-feel-joyride-6d5b@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2585; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=donjYxC2W+iexmioBwX8kzeazja0D4jOJp6CmR6H3MI=; b=owGbwMvMwCRo6H6F97bub03G02pJDFneh6738FQvPHH7YPS5L2ddOIy1rHjOijhpPD765Xjls 9MhW9Zd64hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJTPZnmKfFKT7BOGOthKfu RGfGoKz8W6t48xnmp8wuP/eI84/FFAnd01zf00+tZdk1BwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

From: Griffin Kroah-Hartman <griffin@kroah.com>

Add error handling for devm_kasprintf functions in
tx2_uncore_pmu_register() and tx2_uncore_pmu_init_dev().

Regarding the latter function, I am unsure whether or not
PMU_TYPE_INVALID should be the default case.

Assisted-by: gkh_clanker_2000
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/perf/thunderx2_pmu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 6ed4707bd6bb..1a6aa94a3efb 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -738,6 +738,8 @@ static int tx2_uncore_pmu_register(
 
 	tx2_pmu->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
 			"%s", name);
+	if (!tx2_pmu->pmu.name)
+		return -ENOMEM;
 
 	return perf_pmu_register(&tx2_pmu->pmu, tx2_pmu->pmu.name, -1);
 }
@@ -837,6 +839,8 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
 		tx2_pmu->attr_groups = l3c_pmu_attr_groups;
 		tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
 				"uncore_l3c_%d", tx2_pmu->node);
+		if (!tx2_pmu->name)
+			goto err;
 		tx2_pmu->init_cntr_base = init_cntr_base_l3c;
 		tx2_pmu->start_event = uncore_start_event_l3c;
 		tx2_pmu->stop_event = uncore_stop_event_l3c;
@@ -852,6 +856,8 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
 		tx2_pmu->attr_groups = dmc_pmu_attr_groups;
 		tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
 				"uncore_dmc_%d", tx2_pmu->node);
+		if (!tx2_pmu->name)
+			goto err;
 		tx2_pmu->init_cntr_base = init_cntr_base_dmc;
 		tx2_pmu->start_event = uncore_start_event_dmc;
 		tx2_pmu->stop_event = uncore_stop_event_dmc;
@@ -866,17 +872,21 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
 		tx2_pmu->attr_groups = ccpi2_pmu_attr_groups;
 		tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
 				"uncore_ccpi2_%d", tx2_pmu->node);
+		if (!tx2_pmu->name)
+			goto err;
 		tx2_pmu->init_cntr_base = init_cntr_base_ccpi2;
 		tx2_pmu->start_event = uncore_start_event_ccpi2;
 		tx2_pmu->stop_event = uncore_stop_event_ccpi2;
 		tx2_pmu->hrtimer_callback = NULL;
 		break;
 	case PMU_TYPE_INVALID:
-		devm_kfree(dev, tx2_pmu);
-		return NULL;
+		goto err;
 	}
 
 	return tx2_pmu;
+err:
+	devm_kfree(dev, tx2_pmu);
+	return NULL;
 }
 
 static acpi_status tx2_uncore_pmu_add(acpi_handle handle, u32 level,
-- 
2.55.0

