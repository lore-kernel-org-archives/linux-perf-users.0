Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723B3750D6;
	Fri, 25 Sep 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341486; cv=none; b=RKkhTmF9JBUtud27LueKs5RehqSS2oWsxAnEY49OBFl1PdXldyTehc19+sNZHY/HBi1eigbqmWzBztu0slQ4W+qzaafCIziFduTcRzIaHNDMIK7YNTmJtffNUVZKgmhlYh6KI7vy+mM57yApOufWXxKOusfP+C+TO5SeRBIVaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341486; c=relaxed/simple;
	bh=4X1Qn26Rv02pij9epi25wycnZozbjcmE2gWYNwUGA9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPVFmLfFDt7K9nR/qWXWNNhzPL79AKvL2wow4EWmDAKn/aKdisBZgQeksB527ZvjT1YltlkCNVQEO8JuYz9KxstNHgTEQxbJMnq2suYH0fAO4ER6ZZnliDd736p1CBmFxuacMFwVWjm4W0KlVbR4E6i22PIv8MgFdH9zEee7fz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBOi/xz1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBOi/xz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363181F000FF;
	Fri, 25 Sep 2026 13:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341485;
	bh=92gf6m9YOIPDsCP688vyQFsYfi3lwgydMZ3LqXmn3gc=;
	h=From:To:Cc:Subject:Date;
	b=SBOi/xz15oQl7twIyrtO4yKBCgAQPj6/OZhYu8U3oP8ECGc8P4+iB7/0HxtrimI+p
	 3hbKLbnScGXlW/P1Xqe7Ur17Z/p4I5GiNYK3vwCocskYglwQH70aKksT6l3enezdxh
	 1jNKFyOd0tKdt+4NQQE7fIWc5IdGoik4Vso6c8gb3sy5I2g3Iahj6SAnl61rxNAnta
	 uDqGXX6DRl2cRREfQqy/yxxeV2nfS2HZMXs0zyc8gmK1+78c854yQsdnmtMsvumQ0C
	 zrdsJo1vHOm1Zp+HrjtwzoANXNy0iFZ/L1FikLc1U6wnRpzc2bxFSmvUKcw/LzfQxV
	 G3DiELNF9IqXg==
From: Arnd Bergmann <arnd@kernel.org>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Geetha sowjanya <gakula@marvell.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Yury Norov <ynorov@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: marvell: avoid large stack variables
Date: Fri, 25 Sep 2026 15:04:30 +0200
Message-ID: <20260925130440.4107512-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The probe function in this driver constructs multiple large structures
on the stack, which ends up causing a size warning:

drivers/perf/marvell_cn10k_ddr_pmu.c:1168:12: error: stack frame size (1296) exceeds limit (1280) in 'cn10k_ddr_perf_probe' [-Werror,-Wframe-larger-than]
 1168 | static int cn10k_ddr_perf_probe(struct platform_device *pdev)
      |            ^

Avoid this warning and simplify the code by turning these into static
const structures and directly assigning them without the extra copy.

Fixes: 9b551a2446b2 ("perf: marvell: Add CN20K DDR PMU support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 85 +++++++++++++++-------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 0a8cb6166408..9b68d6c1c31c 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -1165,6 +1165,47 @@ static const struct ddr_pmu_platform_data odyssey_ddr_pmu_pdata = {
 };
 #endif
 
+static const struct pmu cn10k_pmu = {
+	.module	      = THIS_MODULE,
+	.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+	.task_ctx_nr = perf_invalid_context,
+	.attr_groups = cn10k_attr_groups,
+	.event_init  = cn10k_ddr_perf_event_init,
+	.add	     = cn10k_ddr_perf_event_add,
+	.del	     = cn10k_ddr_perf_event_del,
+	.start	     = cn10k_ddr_perf_event_start,
+	.stop	     = cn10k_ddr_perf_event_stop,
+	.read	     = cn10k_ddr_perf_event_update,
+	.pmu_enable  = cn10k_ddr_perf_pmu_enable,
+	.pmu_disable = cn10k_ddr_perf_pmu_disable,
+};
+
+static const struct pmu ody_pmu = {
+	.module       = THIS_MODULE,
+	.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+	.task_ctx_nr = perf_invalid_context,
+	.attr_groups = odyssey_attr_groups,
+	.event_init  = cn10k_ddr_perf_event_init,
+	.add         = cn10k_ddr_perf_event_add,
+	.del         = cn10k_ddr_perf_event_del,
+	.start       = cn10k_ddr_perf_event_start,
+	.stop        = cn10k_ddr_perf_event_stop,
+	.read        = cn10k_ddr_perf_event_update,
+};
+
+static const struct pmu cn20k_pmu = {
+	.module       = THIS_MODULE,
+	.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+	.task_ctx_nr = perf_invalid_context,
+	.attr_groups = cn20k_attr_groups,
+	.event_init  = cn10k_ddr_perf_event_init,
+	.add         = cn10k_ddr_perf_event_add,
+	.del         = cn10k_ddr_perf_event_del,
+	.start       = cn10k_ddr_perf_event_start,
+	.stop        = cn10k_ddr_perf_event_stop,
+	.read        = cn10k_ddr_perf_event_update,
+};
+
 static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 {
 	const struct ddr_pmu_platform_data *dev_data;
@@ -1202,56 +1243,20 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 		/* Setup the PMU counter to work in manual mode */
 		writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
 			       ddr_pmu->p_data->cnt_op_mode_ctrl);
+		ddr_pmu->pmu = cn10k_pmu;
 
-		ddr_pmu->pmu = (struct pmu) {
-			.module	      = THIS_MODULE,
-			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
-			.task_ctx_nr = perf_invalid_context,
-			.attr_groups = cn10k_attr_groups,
-			.event_init  = cn10k_ddr_perf_event_init,
-			.add	     = cn10k_ddr_perf_event_add,
-			.del	     = cn10k_ddr_perf_event_del,
-			.start	     = cn10k_ddr_perf_event_start,
-			.stop	     = cn10k_ddr_perf_event_stop,
-			.read	     = cn10k_ddr_perf_event_update,
-			.pmu_enable  = cn10k_ddr_perf_pmu_enable,
-			.pmu_disable = cn10k_ddr_perf_pmu_disable,
-		};
 	}
 
 	if (silicon_flags & IS_ODY) {
 		ddr_pmu->ops = &ddr_pmu_ody_ops;
-
-		ddr_pmu->pmu = (struct pmu) {
-			.module       = THIS_MODULE,
-			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
-			.task_ctx_nr = perf_invalid_context,
-			.attr_groups = odyssey_attr_groups,
-			.event_init  = cn10k_ddr_perf_event_init,
-			.add         = cn10k_ddr_perf_event_add,
-			.del         = cn10k_ddr_perf_event_del,
-			.start       = cn10k_ddr_perf_event_start,
-			.stop        = cn10k_ddr_perf_event_stop,
-			.read        = cn10k_ddr_perf_event_update,
-		};
+		ddr_pmu->pmu = ody_pmu;
 	}
 
 	if (silicon_flags & IS_CN20K) {
 		ddr_pmu->ops = &ddr_pmu_ody_ops;
-
-		ddr_pmu->pmu = (struct pmu) {
-			.module       = THIS_MODULE,
-			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
-			.task_ctx_nr = perf_invalid_context,
-			.attr_groups = cn20k_attr_groups,
-			.event_init  = cn10k_ddr_perf_event_init,
-			.add         = cn10k_ddr_perf_event_add,
-			.del         = cn10k_ddr_perf_event_del,
-			.start       = cn10k_ddr_perf_event_start,
-			.stop        = cn10k_ddr_perf_event_stop,
-			.read        = cn10k_ddr_perf_event_update,
-		};
+		ddr_pmu->pmu = cn20k_pmu;
 	}
+
 	/* Choose this cpu to collect perf data */
 	ddr_pmu->cpu = raw_smp_processor_id();
 
-- 
2.53.0

