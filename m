Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57809274B42;
	Sun,  1 Mar 2026 01:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328332; cv=none; b=GSX/Tuf2nWncOaUaDxMhPBZFoMoK4YD+qgr9LM2StZBSgrR12RcIMJjL/fv73KrpO+OHGdsm78lAOa/6sU1Xlfk4EeridNm9LYxKTfus9hgVP3HmNTGkrAatxHinRuhCQ9XjuIxbqceIMBkWq7Nh4Gu16XbmTcgbKNJRkioAwPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328332; c=relaxed/simple;
	bh=YoQb1GfTmltnr+4AbRnLrCMrQ9CRaLDWHMX9phNRAsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4nAb9xK6YAC1J5cH5VpZkJkBXDHHyts0A8N1tYcRtWJEGeQUJtJX0DYGIY1ANfs0dyrhi//4vOKj32Y1/mZ9AwYRSH+IJSJvF8ZO94iUhQli72HBSlDNG1lePwbVFUjuiKDMPBFqh2FfRzXTovmzctbE3dxEDAZmgK+79i+Jp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBJ4+u8r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBJ4+u8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933BBC19421;
	Sun,  1 Mar 2026 01:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328332;
	bh=YoQb1GfTmltnr+4AbRnLrCMrQ9CRaLDWHMX9phNRAsQ=;
	h=From:To:Cc:Subject:Date:From;
	b=IBJ4+u8rObU8JfnHuWh7rVtqrnNTcfmopvl6t4/Z+ED65ihBV0Z+t9i2iYdZoFL5e
	 z0h8WAt36wojiNDKZoGOiEdFRs0rhGbZo5BeJVPEB5WHN8Qh2n9Hf2R72HgspKQ1is
	 PS3ojAuE1hDs6+Kd8f/TxiRAUGlNWPUVo/KpXqbycWbsPDfzOoqp52dmfd2LaRJoSh
	 u01zqWVZ9IWek9T+aA3tvMzHpWNV4dt8Q5EjONwzo/0FR5B5qXbsdG//MF1FY4hFL0
	 xo50ywH+rE/n9ecfnSZHAaPUk2EsuB43iduHflB7y2W0ECtvh7SK2YGilYiIVAaJ0y
	 9aP6FamJpNNxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	robin.murphy@arm.com
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: FAILED: Patch "perf/arm-cmn: Reject unsupported hardware configurations" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:25:30 -0500
Message-ID: <20260301012530.1682624-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 36c0de02575ce59dfd879eb4ef63d53a68bbf9ce Mon Sep 17 00:00:00 2001
From: Robin Murphy <robin.murphy@arm.com>
Date: Tue, 3 Feb 2026 14:07:29 +0000
Subject: [PATCH] perf/arm-cmn: Reject unsupported hardware configurations

So far we've been fairly lax about accepting both unknown CMN models
(at least with a warning), and unknown revisions of those which we
do know, as although things do frequently change between releases,
typically enough remains the same to be somewhat useful for at least
some basic bringup checks. However, we also make assumptions of the
maximum supported sizes and numbers of things in various places, and
there's no guarantee that something new might not be bigger and lead
to nasty array overflows. Make sure we only try to run on things that
actually match our assumptions and so will not risk memory corruption.

We have at least always failed on completely unknown node types, so
update that error message for clarity and consistency too.

Cc: stable@vger.kernel.org
Fixes: 7819e05a0dce ("perf/arm-cmn: Revamp model detection")
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/perf/arm-cmn.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 651edd73bfcb1..4fbafc4b79843 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2422,6 +2422,15 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 			arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, dn);
 			dn->portid_bits = xp->portid_bits;
 			dn->deviceid_bits = xp->deviceid_bits;
+			/*
+			 * Logical IDs are assigned from 0 per node type, so as
+			 * soon as we see one bigger than expected, we can assume
+			 * there are more than we can cope with.
+			 */
+			if (dn->logid > CMN_MAX_NODES_PER_EVENT) {
+				dev_err(cmn->dev, "Node ID invalid for supported CMN versions: %d\n", dn->logid);
+				return -ENODEV;
+			}
 
 			switch (dn->type) {
 			case CMN_TYPE_DTC:
@@ -2471,7 +2480,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 				break;
 			/* Something has gone horribly wrong */
 			default:
-				dev_err(cmn->dev, "invalid device node type: 0x%x\n", dn->type);
+				dev_err(cmn->dev, "Device node type invalid for supported CMN versions: 0x%x\n", dn->type);
 				return -ENODEV;
 			}
 		}
@@ -2499,6 +2508,10 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 		cmn->mesh_x = cmn->num_xps;
 	cmn->mesh_y = cmn->num_xps / cmn->mesh_x;
 
+	if (max(cmn->mesh_x, cmn->mesh_y) > CMN_MAX_DIMENSION) {
+		dev_err(cmn->dev, "Mesh size invalid for supported CMN versions: %dx%d\n", cmn->mesh_x, cmn->mesh_y);
+		return -ENODEV;
+	}
 	/* 1x1 config plays havoc with XP event encodings */
 	if (cmn->num_xps == 1)
 		dev_warn(cmn->dev, "1x1 config not fully supported, translate XP events manually\n");
-- 
2.51.0




