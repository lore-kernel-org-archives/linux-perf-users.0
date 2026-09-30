Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E794485509;
	Wed, 30 Sep 2026 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809915; cv=none; b=lMRwBkr8WpWB1EP79UYAZKxDUfHE5w6HTBWdKh3G+XsJ8oB/8PYqmkAW9XvOEQ6j7R+gmss2jijvnUK5gESNIfKYbfqVgVb8G9fw5RgMLlqrdKUY8NygHBmbRWNvbZ82KSJF7G37NkyFnsoqQopBpmiYA0htHaHnlNYrOnmTVD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809915; c=relaxed/simple;
	bh=ukGZ6fDb6EFZgWpph1GcXay10iZszMLLJ16DKd8k84U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gG46GP6ysGEdQ7wl+RPFgTVcIx/uUp5FFTq3oLdAwywSRwbQ8ONxG0cn9BVL37/q83kJyXpp7GvPg927GkqetsV+MwXznX0h8SdksqofjcrItI14KxXKvkEEgPcknoR4DWXuErHzBAfL9t3Sn/1LuO3XpM1j7gt+HT6dft2UZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JzosyV5y; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="JzosyV5y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790809911; x=1822345911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OeIJ3O0U+r0Rl3V651EIIueM+T9lKIRL2Db35zQlHz8=;
  b=JzosyV5yULwp6TVJaOdmCuLcqH32E/Ji5sHcZWKxGE8XoKFtUijNpcul
   knQXB0UdsKQOKZjuuMEnRYYm49a7eqELGoA6010eHMfLucBQWynMZ+N1z
   PBD8jKNYN2Ib+Mf0Orb74TkwHUzhkPuKTUwHvtFAFwXI1SkWR2Fb1Bkhr
   0AABYUJmH01hI/ZH619mA/8oQ9fH4msBT4ryzPu7y3WMp5GDd7uNOSBVX
   tq1zLysV6/+M0dXseBucSmQ632zAnE88UImn7GOnROLktrqYlWHpUgiRC
   Pz4ZoBJupQC1g+tCp/FqAaBZ0nlhcFKMdR6z94pZzlDcCEhjkrOgEYYg8
   Q==;
X-CSE-ConnectionGUID: iP5fGfNTS/qNGjiL1G1XrQ==
X-CSE-MsgGUID: Vd6MpAqzTaKdq5m82A39yQ==
X-IronPort-AV: E=Sophos;i="6.27,133,1787011200"; 
   d="scan'208";a="29861899"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 23:11:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:10475]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.208:2525] with esmtp (Farcaster)
 id 83cd9eaf-0b34-4051-8754-af499e1c55f9; Wed, 30 Sep 2026 23:11:49 +0000 (UTC)
X-Farcaster-Flow-ID: 83cd9eaf-0b34-4051-8754-af499e1c55f9
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 30 Sep 2026 23:11:48 +0000
Received: from u34cccd802f2d52.amazon.com (10.106.239.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 30 Sep 2026 23:11:47 +0000
From: Haris Okanovic <harisokn@amazon.com>
To: <robin.murphy@arm.com>, <mark.rutland@arm.com>, <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<harisokn@amazon.com>
Subject: [PATCH v2 1/2] perf/arm-cmn: Don't schedule events on a CPU which no longer owns the PMU
Date: Wed, 30 Sep 2026 18:11:26 -0500
Message-ID: <20260930231127.3094040-2-harisokn@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930231127.3094040-1-harisokn@amazon.com>
References: <20260930231127.3094040-1-harisokn@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

perf_event_open() can latch cmn->cpu and then install the event after a
migration has already moved the PMU. The driver has no locking -- it
relies on all events living in one CPU's context -- so such an event
races the owning CPU and can corrupt the shared DTC and DTM state,
giving wrong counts. arm_cmn_event_add() now rejects an event which is
not on the owning CPU.

arm_cmn_migrate() now claims cmn->cpu before migrating, so that events
it reinstalls via perf_pmu_migrate_context() still pass that check.

Signed-off-by: Haris Okanovic <harisokn@amazon.com>
---
 drivers/perf/arm-cmn.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 5378fba916cf5..a5593e5821925 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2112,6 +2112,9 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 	enum cmn_node_type type = CMN_EVENT_TYPE(event);
 	unsigned int input_sel, i = 0;
 
+	if (cmn->cpu != smp_processor_id())
+		return -ENOENT;
+
 	if (type == CMN_TYPE_DTC) {
 		while (cmn->dtc[i].cycles)
 			if (++i == cmn->num_dtcs)
@@ -2245,12 +2248,12 @@ static int arm_cmn_commit_txn(struct pmu *pmu)
 
 static void arm_cmn_migrate(struct arm_cmn *cmn, unsigned int cpu)
 {
-	unsigned int i;
+	unsigned int i, old = cmn->cpu;
 
-	perf_pmu_migrate_context(&cmn->pmu, cmn->cpu, cpu);
+	cmn->cpu = cpu;
+	perf_pmu_migrate_context(&cmn->pmu, old, cpu);
 	for (i = 0; i < cmn->num_dtcs; i++)
 		irq_set_affinity(cmn->dtc[i].irq, cpumask_of(cpu));
-	cmn->cpu = cpu;
 }
 
 static int arm_cmn_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
-- 
Haris Okanovic
AWS Graviton

