Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308B01CBEB9;
	Thu, 19 Jun 2025 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750303207; cv=none; b=N8w1r5acdnJ3cl6qqA7KediS1+umHgGgBEz1L8hlDWYtjxbGDfCYTdlkeWgetUhqsW4O8gr8PYYaGviDZaqpVcuI1EOXRha6XkA8tl+uJrG1gNJ+aTk35Pb/Bcac8UkpZCMH28Oo1otpYd0hliisoSOLs7xtQtnhzNwXka41R08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750303207; c=relaxed/simple;
	bh=JJl4egwEehwUZ9lH0qcCNVO5URPGIQgATOlSnKgy/dM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iBOno5iyNLBOtG+W+dzDRUTyOonNa+dV4rCj8RqWlo4DNraxEVeUotgLcEm23jiY86pfS82IrsFupqkcng8Oxn9INqt4sWnUQ6DG5gntAbtOWfTX0NfYtr61OJXDsEZMxWtkFR4z9OZWmSq+8kACMUa7pwU0qZuSgOdjAoxc48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4580d29e4cbc11f0b29709d653e92f7d-20250619
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:784bea5c-baf2-46ce-a734-c7636d820195,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:770a56878cedc0abef4c5af809c10e2d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4580d29e4cbc11f0b29709d653e92f7d-20250619
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1002011062; Thu, 19 Jun 2025 11:19:55 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 0B32D16001A01;
	Thu, 19 Jun 2025 11:19:55 +0800 (CST)
X-ns-mid: postfix-685381D9-2974341226
Received: from localhost.localdomain (unknown [10.42.12.96])
	by node4.com.cn (NSMail) with ESMTPA id 8787616001CC7;
	Thu, 19 Jun 2025 03:19:51 +0000 (UTC)
From: tanze <tanze@kylinos.cn>
To: peterz@infradead.org,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	tanze <tanze@kylinos.cn>
Subject: [PATCH] perf/x86/zhaoxin: Fix instructions error by missing fixedctr member
Date: Thu, 19 Jun 2025 11:19:47 +0800
Message-Id: <20250619031947.1111196-1-tanze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Perf's instructions event tests on Zhaoxin CPUs may exhibit:

  $perf stat -e instructions,cycles ls -l

  ......
  Performance counter stats for 'ls -l':

                 0      instructions                     #    0.00  insn =
per cycle
         9,488,278      cycles

       0.004365407 seconds time elapsed

       0.003303000 seconds user
       0.001099000 seconds sys

The absence of the fixedctr member leads to an incorrect hwc->event_base
value on Zhaoxin CPUs, causing a discrepancy in the instruction count
reported by perf stat. This commit resolves the instruction count issue
by properly initializing the fixedctr member.

Fixes: 149fd4712bcd ("perf/x86/intel: Support Perfmon MSRs aliasing")

Signed-off-by: tanze <tanze@kylinos.cn>
---
 arch/x86/events/zhaoxin/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/cor=
e.c
index 4bdfcf091200..3fc3f9abece9 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -467,6 +467,7 @@ static const struct x86_pmu zhaoxin_pmu __initconst =3D=
 {
 	.schedule_events	=3D x86_schedule_events,
 	.eventsel		=3D MSR_ARCH_PERFMON_EVENTSEL0,
 	.perfctr		=3D MSR_ARCH_PERFMON_PERFCTR0,
+	.fixedctr		=3D MSR_ARCH_PERFMON_FIXED_CTR0,
 	.event_map		=3D zhaoxin_pmu_event_map,
 	.max_events		=3D ARRAY_SIZE(zx_pmon_event_map),
 	.apic			=3D 1,
--=20
2.25.1

