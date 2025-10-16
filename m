Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A0D145348;
	Thu, 16 Oct 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603433; cv=none; b=nFG1kcW/xY6mkbVSsipz5GZUlZy/vHQ742ubbOuuYLs+8zvrCvuqbeHoOdM+SMUv23rOuZVZC8qU0EFDIJuUlfJFR3zundPFsC3SF/G/tjjCFz5A/JHa7BtH0Gq0Q6R90qKVAqJrx2qwWNOEzU/jrZuPo/g88RF0CzLC+722pR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603433; c=relaxed/simple;
	bh=Sd9Do/Jjw3NN3FGRJWI9ryug/fIT264op5LRF4M/3xE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t5C5+DjpiH4cOWSI7FmjuK/8JoVT+aOI+7k0HZXK91OSe2b6x3rB7dpjUkKONK3PnXAVxLWmNn2leF6ktXV08/q6FM33Dx8kUy/XshamKU9YZf0jPrW/LHyjh4tibW6/MYyGqr+QfN7WuAJTkqwWdoymerbrF3YtAj95cBIleFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5c4481b8aa6a11f0a38c85956e01ac42-20251016
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:11e05e84-edd7-4313-8812-d04bac35b71e,IP:0,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:d24af52aa30fd24840d7476069b00f81,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5c4481b8aa6a11f0a38c85956e01ac42-20251016
X-User: tanze@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1044116877; Thu, 16 Oct 2025 16:30:23 +0800
From: tanze <tanze@kylinos.cn>
To: james.clark@linaro.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	graham.woodward@arm.com,
	tanze <tanze@kylinos.cn>
Subject: [PATCH v1] perf arm_spe: Add a macro definition to handle offset value
Date: Thu, 16 Oct 2025 16:30:19 +0800
Message-Id: <20251016083019.27935-1-tanze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a macro definition SPE_SYNTH_ID_OFFSET to handle the offset value
and improve readability.

Signed-off-by: tanze <tanze@kylinos.cn>
---
 tools/perf/util/arm-spe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 71be979f5077..645048ac7708 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -36,6 +36,7 @@
 
 #include "../../arch/arm64/include/asm/cputype.h"
 #define MAX_TIMESTAMP (~0ULL)
+#define SPE_SYNTH_ID_OFFSET (1000000000ULL)
 
 #define is_ldst_op(op)		(!!((op) & ARM_SPE_OP_LDST))
 
@@ -1732,7 +1733,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	attr.sample_period = spe->synth_opts.period;
 
 	/* create new id val to be a fixed offset from evsel id */
-	id = evsel->core.id[0] + 1000000000;
+	id = evsel->core.id[0] + SPE_SYNTH_ID_OFFSET;
 
 	if (!id)
 		id = 1;
-- 
2.25.1

