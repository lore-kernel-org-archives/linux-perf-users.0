Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E750F3328FC;
	Wed,  2 Sep 2026 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788310811; cv=none; b=j23CVHgXHpKEKVJLLDC/oGjou2j+xeCQMug9RKRQwcLmv7Fa+UEUbRrZZQl1nipo+amQGW+adKMa6U7XhYPXUiStGn2rtRH+I7SjgSg82HdM1CWo+Fco4Useg/wt6gkyf8nSc6Astu+uEvMId9gglbIjOdVtxrleReCxPSiTbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788310811; c=relaxed/simple;
	bh=31/BZ9+v2dfs1yDzN9wLbBwz+6/0mrXF/Wo/qgVhXGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7TfBqLEAVnleF4ZkL1fyql0Hk338E9vRcKDx+vNGAd7H9M/MyCLSPDBYzdlMQ2aIxyRJryhWAJ4TRwxlBYso2oGNOeRjdZfUGFWH3zZkk1GMyKhPQrpTIb/1jQLXLAjKd1vMXyohE0QXbWPcVXaIA604eGe4Bs1YOAPR2kHEX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9e99309ea66911f19a56ed5b684f684d-20260902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:fda3c320-afd1-4ac7-b57f-a7ed671a4547,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:838c3939a74aa8bd2689a03263d7f5ee,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9e99309ea66911f19a56ed5b684f684d-20260902
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1054009407; Wed, 02 Sep 2026 08:59:58 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: pjw@kernel.org
Cc: linux-riscv@lists.infradead.org, atish.patra@linux.dev, anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: Re: [PATCH v2 2/2] perf: RISC-V: store available counter mask as bitmap
Date: Wed, 2 Sep 2026 08:55:00 +0800
Message-ID: <reply.pjw.pmumask22chk.1787383200.git.liuxixin@kylinos.cn>
In-Reply-To: <460ddaff-bdad-0eb6-a504-1ea43689d6dc@kernel.org>
References: <cover.1786092600.git.liuxixin@kylinos.cn> <prpmask02cmap.1786092600.git.liuxixin@kylinos.cn> <93cab992-f808-8f3e-03a6-19d84baf38f3@kernel.org> <reply.pjw.pmumask22.1787042100.git.liuxixin@kylinos.cn> <cover.v2.1786434000.git.liuxixin@kylinos.cn> <prpmask02cmap.v2.1786434000.git.liuxixin@kylinos.cn> <460ddaff-bdad-0eb6-a504-1ea43689d6dc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

Hi Paul,

Thanks for fixing those in your queued copy. I will run checkpatch.pl
--strict before send going forward.

Thanks,
Xixin

