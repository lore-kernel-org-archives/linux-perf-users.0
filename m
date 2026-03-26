Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025B3603F8
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516220; cv=none; b=om4U2hKJojCEkDRw3Zd+h2gd8/tP54x9sMWNcMN7hZn6Luo2r7LPtfg5FEGYu/k2sfuIDWecJ9tkdLdSb9KC+qmknu9CGkURm041DKuppKlW17H5WRZNRXxn8EzvRTAxPAICK2bc0AFwxYYP4VTUnB/WQ84vOf/2D6gnALVl+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516220; c=relaxed/simple;
	bh=6mq5dy0/xWriwcPnRpQ0tyrZlWdKbtV+wQYgNa4+bwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RSL93pBXbmm065/XDo4LJkkyKLiR9w5Lywy1Rffyx89rFbk5umET7JH8yZNJW59Qeu0nfQCsFsH1YhXDhkZc0VCANDGXfdbCYSHVG+qC659GJQ0Ez6Cjj5vV3CypX9HUjshrUr5ikCbsVeh6b0jH/l/gTzIwLuhjCXsCjTktdLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowACXQW3m98Rp5tI6Cw--.4094S2;
	Thu, 26 Mar 2026 17:09:58 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: will@kernel.org
Cc: robin.murphy@arm.com,
	mark.rutland@arm.com,
	ilkka@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] perf/arm-cmn: Fix incorrect error check for devm_ioremap()
Date: Thu, 26 Mar 2026 17:08:56 +0800
Message-Id: <20260326090856.644136-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXQW3m98Rp5tI6Cw--.4094S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4ruFWrXF17Xry5ZFyDtrb_yoWDXrX_Cr
	4fuFnxCFykCF1qvr13Gw1rZ34Syr1v9FWxXFs8KasxZw4UJw17WrW7Z3s3Zr4xuw4rJr1q
	gryUAFySvr4xGjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUj9a93UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Check devm_ioremap() return value for NULL instead of ERR_PTR and return
-ENOMEM on failure. devm_ioremap() never returns ERR_PTR, using IS_ERR()
skips the error path and may cause a NULL pointer dereference.

Fixes: 5394396ff548 ("perf/arm-cmn: Stop claiming entire iomem region")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/perf/arm-cmn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 1ac91cda6780..9fe00d0f4deb 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2573,8 +2573,8 @@ static int arm_cmn_probe(struct platform_device *pdev)
 
 	/* Map the whole region now, claim the DTCs once we've found them */
 	cmn->base = devm_ioremap(cmn->dev, cfg->start, resource_size(cfg));
-	if (IS_ERR(cmn->base))
-		return PTR_ERR(cmn->base);
+	if (!cmn->base)
+		return -ENOMEM;
 
 	rootnode = arm_cmn_get_root(cmn, cfg);
 	if (rootnode < 0)
-- 
2.25.1

