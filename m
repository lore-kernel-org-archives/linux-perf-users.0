Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FE1268C43
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Apr 2025 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392529; cv=none; b=D4aUpvqNg5GldoYc+XhJGylKw0wjCr329v3zPp9C9unIjV2sQW8Mp+t+m/S+LdQUCO7As4MM41TmB/gn6gpcaMdDUJrX4lKS7mb0gwon3qCH0gPosvJNzlohJfX1ubWoYg2YAix+RfU6yknv1TzcC6lc3cJN2SWaI7QLXQKTVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392529; c=relaxed/simple;
	bh=hA8C8wkUGtRRk/EHjUob2kGix5pwVUrNpaC9+vsXIhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTwCoU3qUB9WW0dDVuOYmgpj6dIDp2VzYUn+Go2c2qDqvBiSbMQKGfWtIKJZuYk9nl4JyIpflatWQiAsL/F/YcLCGk9do7rWbqv3q1Qr23PziUqH5eAmcY9OxKl2dY7RisSkx+B44Kd3RmUnNzJRND7JdTvhz5AafJ8Ua8DOnVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1745391830-086e234cd095e40001-i5rUwQ
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id 1KN34JB33lWzc8KH (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 23 Apr 2025 15:03:50 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Wed, 23 Apr
 2025 15:03:49 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Wed, 23 Apr 2025 15:03:49 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
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
Subject: [PATCH RESEND 2/3] perf/x86/zhaoxin: Replace open-coded model number with macros
Date: Wed, 23 Apr 2025 14:35:08 +0800
X-ASG-Orig-Subj: [PATCH RESEND 2/3] perf/x86/zhaoxin: Replace open-coded model number with macros
Message-ID: <20250423063509.20996-3-silviazhao-oc@zhaoxin.com>
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
X-Moderation-Data: 4/23/2025 3:03:48 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1745391830
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3716
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.140368
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: SilviaZhao <silviazhao-oc@zhaoxin.com>

Replace open-coded family-7 model number in arch/x86/events/zhaoxin/
core.c with the macros defined in zhaoxin-family.h.

Zhaoxin used to use non-canonical name for family 7 processors in
arch/x86/events/zhaoxin/core.c. Replace them with architecture name
to keep consistent with the macros. Following are the correspondences:
ZXD -> Wudaokou
ZXE -> Lujiazui

Signed-off-by: SilviaZhao <silviazhao-oc@zhaoxin.com>
---
 arch/x86/events/zhaoxin/core.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.=
c
index 2fd9b0cf9a5e..75e51a3f5438 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -14,6 +14,7 @@
=20
 #include <asm/cpufeature.h>
 #include <asm/hardirq.h>
+#include <asm/zhaoxin-family.h>
 #include <asm/apic.h>
=20
 #include "../perf_event.h"
@@ -36,7 +37,7 @@ static struct event_constraint zxc_event_constraints[] __=
read_mostly =3D {
 	EVENT_CONSTRAINT_END
 };
=20
-static struct event_constraint zxd_event_constraints[] __read_mostly =3D {
+static struct event_constraint wudaokou_event_constraints[] __read_mostly =
=3D {
=20
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* retired instructions */
 	FIXED_EVENT_CONSTRAINT(0x0082, 1), /* unhalted core clock cycles */
@@ -44,7 +45,7 @@ static struct event_constraint zxd_event_constraints[] __=
read_mostly =3D {
 	EVENT_CONSTRAINT_END
 };
=20
-static __initconst const u64 zxd_hw_cache_event_ids
+static __initconst const u64 wudaokou_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
 				[PERF_COUNT_HW_CACHE_RESULT_MAX] =3D {
@@ -148,7 +149,7 @@ static __initconst const u64 zxd_hw_cache_event_ids
 },
 };
=20
-static __initconst const u64 zxe_hw_cache_event_ids
+static __initconst const u64 lujiazui_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
 				[PERF_COUNT_HW_CACHE_RESULT_MAX] =3D {
@@ -471,7 +472,7 @@ static const struct x86_pmu zhaoxin_pmu __initconst =3D=
 {
 	.max_events		=3D ARRAY_SIZE(zx_pmon_event_map),
 	.apic			=3D 1,
 	/*
-	 * For zxd/zxe, read/write operation for PMCx MSR is 48 bits.
+	 * For wudaokou/lujiazui, read/write operation for PMCx MSR is 48 bits.
 	 */
 	.max_period		=3D (1ULL << 47) - 1,
 	.get_event_constraints	=3D zhaoxin_get_event_constraints,
@@ -573,27 +574,27 @@ __init int zhaoxin_pmu_init(void)
 			X86_CONFIG(.event =3D 0x0f, .umask =3D 0x04, .inv =3D 0, .cmask =3D 0);
=20
 		switch (boot_cpu_data.x86_model) {
-		case 0x1b:
-			memcpy(hw_cache_event_ids, zxd_hw_cache_event_ids,
+		case ZHAOXIN_FAM7_WUDAOKOU:
+			memcpy(hw_cache_event_ids, wudaokou_hw_cache_event_ids,
 			       sizeof(hw_cache_event_ids));
=20
-			x86_pmu.event_constraints =3D zxd_event_constraints;
+			x86_pmu.event_constraints =3D wudaokou_event_constraints;
=20
 			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =3D 0x0700;
 			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] =3D 0x0709;
=20
-			pr_cont("ZXD events, ");
+			pr_cont("Wudaokou events, ");
 			break;
-		case 0x3b:
-			memcpy(hw_cache_event_ids, zxe_hw_cache_event_ids,
+		case ZHAOXIN_FAM7_LUJIAZUI:
+			memcpy(hw_cache_event_ids, lujiazui_hw_cache_event_ids,
 			       sizeof(hw_cache_event_ids));
=20
-			x86_pmu.event_constraints =3D zxd_event_constraints;
+			x86_pmu.event_constraints =3D wudaokou_event_constraints;
=20
 			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =3D 0x0028;
 			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] =3D 0x0029;
=20
-			pr_cont("ZXE events, ");
+			pr_cont("Lujiazui events, ");
 			break;
 		default:
 			return -ENODEV;
--=20
2.34.1

