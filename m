Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D5F1EDA02
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764002408; cv=none; b=QtTTwPP4RvOp8aGfJFMMN/ESssSpMInhcByimJ5yYHgWDlqOB4EkgbPV4rwx9viq633LenqaeM97leDpAGX+dxrvAAmwgfmmUXuS+WbRNM6bRzfI6n9Hpp72Kx6Fi6BIAleH7/IfqdeZMzswpNrtUtw/hgQOV7Yo8pwKmakJtp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764002408; c=relaxed/simple;
	bh=AZFPQvx6ShncMyK7/jWvSgudnL/U8XvvcbADQYnNofQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m5vQJqPFsO1mu+8eVz0Dr30TL6AtH4XwVrUVHPgZoXY0GPfyW6CCG+K6CxTpFyedk7woYLV0FnbrmhRXvpeyBVMFBVC0C3dHQtNvc89o4qw8tU8DhIQ6mjopmmrHSAURjYlBvOBdWbWq94X0bo4RjMaSV76QZL0yoyEahyCHxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D7681477;
	Mon, 24 Nov 2025 08:39:56 -0800 (PST)
Received: from 010265703453.cambridge.arm.com (unknown [10.1.30.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 850063F86F;
	Mon, 24 Nov 2025 08:40:02 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	michal.simek@amd.com
Subject: [PATCH] perf/arm-cmn: Support CMN-600AE
Date: Mon, 24 Nov 2025 16:39:54 +0000
Message-Id: <f0c6e66df6b74f073df77c00bdf9ed560ca9c703.1764002394.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functional safety features of CMN-600AE have little to no impact on
the PMU relative to the base CMN-600 design, so for simplicity we can
reasonably just treat it as the same thing. The only obvious difference
is that the revision numbers aren't aligned, so we may hide some aliases
for events which do actually exist, but those can still be specified via
the underlying "type,eventid" format so it's not too big a deal.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 23245352a3fc..651edd73bfcb 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -210,6 +210,7 @@ enum cmn_model {
 enum cmn_part {
 	PART_CMN600 = 0x434,
 	PART_CMN650 = 0x436,
+	PART_CMN600AE = 0x438,
 	PART_CMN700 = 0x43c,
 	PART_CI700 = 0x43a,
 	PART_CMN_S3 = 0x43e,
@@ -2266,6 +2267,9 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 	reg = readq_relaxed(cfg_region + CMN_CFGM_PERIPH_ID_01);
 	part = FIELD_GET(CMN_CFGM_PID0_PART_0, reg);
 	part |= FIELD_GET(CMN_CFGM_PID1_PART_1, reg) << 8;
+	/* 600AE is close enough that it's not really worth more complexity */
+	if (part == PART_CMN600AE)
+		part = PART_CMN600;
 	if (cmn->part && cmn->part != part)
 		dev_warn(cmn->dev,
 			 "Firmware binding mismatch: expected part number 0x%x, found 0x%x\n",
-- 
2.34.1

