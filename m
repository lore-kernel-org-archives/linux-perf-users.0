Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA81C54AF
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Apr 2025 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392616; cv=none; b=obJEtmIH+Kw+3Oht2v8dlamiZcbcUaHLT18a11lb/2y4JS1njab7gq5sqpgLwoq/tiV0P3iAJ7XbY++w2QJE+JLjXzHJbmuxOQ8Dp4m768Q5+tIzUJabDE4L2y8/K2/satk2JWij5T04ZvebhKT26XyUNlBx03L4rEduvqYjVJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392616; c=relaxed/simple;
	bh=lkzPUJ10gT52uuukb7HPgV/Nh5/UgrSQsaxpNq47X+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaqRVweh3YakD62McsPJigTxmps3IvhE/S2zsz2ML/kuDrb/YMBN7vDq+Ek8Doj98bkCuq6+A6ojU6TA9Fj3F7IUYBBiSRpZ+uVJB9J0MWMDd4otu6zFOFGFSmjW1t3wkuV8GGnEjhmdXlMAQbmjbY1qOxRxlcP2OETwYCrP5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1745391830-1eb14e386e17140001-i5rUwQ
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id t02AG7rUbgqsF5UE (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 23 Apr 2025 15:03:50 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Wed, 23 Apr
 2025 15:03:49 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Wed, 23 Apr 2025 15:03:49 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from silvia-OptiPlex-3010.Zhaoxin.com (10.29.8.50) by
 ZXBJMBX02.zhaoxin.com (10.29.252.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 14:35:10 +0800
From: SilviaZhao-oc <silviazhao-oc@zhaoxin.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kan.liang@linux.intel.com>
CC: <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>,
	<silviazhao@zhaoxin.com>, <cooperyan@zhaoxin.com>, SilviaZhao
	<silviazhao-oc@zhaoxin.com>
Subject: [PATCH RESEND 3/3] perf/x86/zhaoxin: Add Yongfeng support
Date: Wed, 23 Apr 2025 14:35:09 +0800
X-ASG-Orig-Subj: [PATCH RESEND 3/3] perf/x86/zhaoxin: Add Yongfeng support
Message-ID: <20250423063509.20996-4-silviazhao-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423063509.20996-1-silviazhao-oc@zhaoxin.com>
References: <20250423063509.20996-1-silviazhao-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Moderation-Data: 4/23/2025 3:03:49 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1745391830
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3315
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.140368
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: SilviaZhao <silviazhao-oc@zhaoxin.com>

Add support for Yongfeng which is Zhaoxin's successor microarchitecture
to Lujiazui.

Remove PERF_COUNT_HW_CACHE_REFERENCES and PERF_COUNT_HW_CACHE_MISSES
from global zx_pmon_event_map, since the cache hierarchy was changed
from Yongfeng, and these pmc event map changed too.

Add PERF_COUNT_HW_BRANCH_INSTRUCTIONS and PERF_COUNT_HW_BRANCH_MISSES
to global zx_pmon_event_map, since these two event will keep consistent
for Lujiazui and later.

Signed-off-by: SilviaZhao <silviazhao-oc@zhaoxin.com>
---
 arch/x86/events/zhaoxin/core.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.=
c
index 75e51a3f5438..d7dced6ca934 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -20,15 +20,15 @@
 #include "../perf_event.h"
=20
 /*
- * Zhaoxin PerfMon, used on zxc and later.
+ * Zhaoxin PerfMon, used on Lujiazui and later.
  */
 static u64 zx_pmon_event_map[PERF_COUNT_HW_MAX] __read_mostly =3D {
=20
 	[PERF_COUNT_HW_CPU_CYCLES]        =3D 0x0082,
 	[PERF_COUNT_HW_INSTRUCTIONS]      =3D 0x00c0,
-	[PERF_COUNT_HW_CACHE_REFERENCES]  =3D 0x0515,
-	[PERF_COUNT_HW_CACHE_MISSES]      =3D 0x051a,
 	[PERF_COUNT_HW_BUS_CYCLES]        =3D 0x0083,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =3D 0x0028,
+	[PERF_COUNT_HW_BRANCH_MISSES]	=3D 0x0029,
 };
=20
 static struct event_constraint zxc_event_constraints[] __read_mostly =3D {
@@ -560,6 +560,8 @@ __init int zhaoxin_pmu_init(void)
 			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES] =3D 0;
 			zx_pmon_event_map[PERF_COUNT_HW_CACHE_MISSES] =3D 0;
 			zx_pmon_event_map[PERF_COUNT_HW_BUS_CYCLES] =3D 0;
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =3D 0;
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] =3D 0;
=20
 			pr_cont("ZXC events, ");
 			break;
@@ -580,6 +582,9 @@ __init int zhaoxin_pmu_init(void)
=20
 			x86_pmu.event_constraints =3D wudaokou_event_constraints;
=20
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES]  =3D 0x0515,
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_MISSES]      =3D 0x051a,
+
 			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =3D 0x0700;
 			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] =3D 0x0709;
=20
@@ -591,11 +596,26 @@ __init int zhaoxin_pmu_init(void)
=20
 			x86_pmu.event_constraints =3D wudaokou_event_constraints;
=20
-			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =3D 0x0028;
-			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] =3D 0x0029;
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES]  =3D 0x0515,
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_MISSES]      =3D 0x051a,
=20
 			pr_cont("Lujiazui events, ");
 			break;
+		case ZHAOXIN_FAM7_YONGFENG:
+			zx_pmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =3D
+				X86_CONFIG(.event =3D 0x02, .umask =3D 0x01, .inv =3D 0x01,
+						.cmask =3D 0x01);
+
+			memcpy(hw_cache_event_ids, lujiazui_hw_cache_event_ids,
+					sizeof(hw_cache_event_ids));
+
+			x86_pmu.event_constraints =3D wudaokou_event_constraints;
+
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES]  =3D 0x051a;
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_MISSES]      =3D 0;
+
+			pr_cont("Yongfeng events, ");
+			break;
 		default:
 			return -ENODEV;
 		}
--=20
2.34.1

