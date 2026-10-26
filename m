Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792988364;
	b=R3xEqFpp18RmXhTUM1+UBKJ594/kNTb/Xjb6tv3ZjQFlZg+Q05jaAmrmmxwvs54ApLyP
	 lK3ISqsu7mG1Xdj8R9AzniH99zs6pbS8pS/VxMKmb2BOYYKfz0CfM20YMVyLnDULnUl7t
	 UTb9i9H384CGUq782FGPZg/IkLD98di1hPkyl9Pe5DhcNN1LX1WfUKzzey05LKzQ+ayDX
	 MWHBm+DfQ35R2vH0esQ2cBrmHFzQyUlHHckau/3NrEZp1z31LPa6wIbC+xCHqSUNrwYyf
	 P84BrXakz1wI+2vqLZweRfiRpw1/uBzO96RS4T1+P1VxMpCJkGx2jy7fqyT1J1W+fiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792988364;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eJmcRaPk3Eo9u2RhlJVCk8z9rcYG1xEXI0N+u/SwCbU=;
	b=j6qQQHMn1olozKceg2yYUiS/OUZ7ZpJw8kil1cxtxTTr7muSZfb2JeHGfSABAOziKWUI
	 i9tzzWmAS+fQNpp/b+8g2Uup2JxorcthA0nNZ4KpxY5fedeMrbJMdiAsNRmZMKaIybzCK
	 51Cy//YnWjv6kRJtz/8G/gYgdJ+MdXkKDUS8GIGs83FVFK7VpjKqzXVZhFrvD8xGn7O82
	 i7DUGr0dMHbJvXV8NEKG+azfYEPR6A9NeMaID/E05WNClMcpViP6xxMI5J8liasJqqo16
	 q9AN2jJgybn4656LaJkJ9ZtGwP8cGrJ0nqXl58JVRApmmPhANzHvkoYBibiJUFXvqiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NijQRk6l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.8
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DA606A31A;
	Mon, 26 Oct 2026 04:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F1DA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NijQRk6l
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYMrUXitunZmbXgyd4YQUUDTca3OPalaCUPGDXjJ49MzqulgYMhGkY3Ssp0YkRKuHXBKwzj9BWhRE40819fAnTLWqV5LojRfliuiMA2w41glZYYxbsy6kgKX5M9QGVtN74Rk+y8WDG9g9R3R8/bLHL1De1omV4coUeUddQCbFUg8p0x2lMyyX+GNTsuaS647ao8qbjQjaoYA6kFWDCOvlNSSPYzXyOVqz+Fu0mGNXfF4gUkMOENwcJ6qm3dY08YQdG1jNW8Xz1IwKjlQpxN024btjOzLrB7NpKX+BAM9FNWVdb0k52fm2p3MMEQUvL39vK34J8f4Pfoa4N3EaKFJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJmcRaPk3Eo9u2RhlJVCk8z9rcYG1xEXI0N+u/SwCbU=;
 b=pZP+tuSi17Ucl2q/RBdspYeqNOBZRiHUtD9Adpbm7ex3u4NeKO11XRSBwtT8kFiAV4fxAyFQhjaqzecqG/X98+pyTOmo+LOHlHJa94IVD9NZC3Q6x78AORxJkw3VkQtClPQgIjDi9uaJJy58ZGyGib6cJleA39GTOJY/y9/GVgiVqSLcy9gw1Fd+VGXj0NBPoN0UPJ6z7bjt0BxUVsJByLB1nyu6194TY3b06QqIXa6RK93M4Q42ERXRk2evO1o0bZmHqsvH6y4/qPLfhalZEqpOR4/new78bIhRjZcpMVyC+YLk6IiPfs9IMkXybm5AhJfr0OKpsmMVyzhjkF7uMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJmcRaPk3Eo9u2RhlJVCk8z9rcYG1xEXI0N+u/SwCbU=;
 b=NijQRk6lsqJNKstgGoaoNjwIfCbHczrnSmSkI7YA3Y4220KDC26nd5RuN26PGO6WqXEQoKSHZfr/q86Nssc82eI5+qcntSHTO8n6RTl+FWIqdEBTDjOXo4fbSUJ3bkIIEf7wRg9WXvVOw277vq5mGCou3RGTScBDhCqiRZrQPC4=
Received: from SJ0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:a03:33e::22)
 by PH9PR12MB497784.namprd12.prod.outlook.com (2603:10b6:510:411::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 04:19:17 +0000
Received: from SJ1PEPF000037B4.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::32) by SJ0PR03CA0047.outlook.office365.com
 (2603:10b6:a03:33e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 04:19:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B4.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 04:19:17 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 25 Oct
 2026 23:19:12 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	"Jim Mattson" <jmattson@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Jayapal Ashwin Nair
	<janair@amd.com>, Gennady Kupava <gennady.kupava@gmail.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	Manali Shukla <manali.shukla@amd.com>
Subject: [PATCH v3 3/3] perf/amd/ibs: Simplify event state handling with IBS_CAPS_DIS
Date: Mon, 26 Oct 2026 04:18:37 +0000
Message-ID: <20261026041838.941-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026041838.941-1-ravi.bangoria@amd.com>
References: <20261026041838.941-1-ravi.bangoria@amd.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B4:EE_|PH9PR12MB497784:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1c8c31-7337-4f33-3b8b-08df33184d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|1800799024|376014|18002099003|22082099003|56012099006|11063799006|261021123027099003|261021121427099003|10067099003|261009223027099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	IGH05gKIKM8/JSTomuwzPKlX11ptWVsSFrGbIeaPD5JwhO8JBzTxIhCpB3lMuYY5H/+gkfNV4XiY8Sw9ME8VsknsPaDOagoUZ0Wa/sVKQ+kQbzhFx279y4yCC/hF0+ZFpiF5Jf9gi1Y7VuzrPLJd8oHNcfcjzYNDKpa0gOtjQvj1vyCZs/pCo9QcbdHQtt9G2LWa/ZIwbqKxFf2AK92ZuWaIrOMs4CzSvqsPN7tNWvUQr+uMsJXNOJla6wpZ1QkKk7lk/Ka71gGmLNBt3HseRPffve0SnC+4Zrh4AeUEDgiWW/pLqyBvZ2ov/aWzXCsyCebonm+Qbujq/lpQsjvGxyHkGriL2OhEdIfew010qBduRYX4az6Kyyl2EcwelzQIU+CX15+BnpA0uXDZ2N4UAEv0XoBOKX+t0PbOKw0oCDdiAGbgYV9DP0R6zIPEGWN/eXdDaJdwplDvL93S2VIv6xk1ggtxg+gvXyZQl/e1Ao9OqmisknEVDpVOid22dXyRLUPBFMNKUjC6NuLEYJzmuQ1w5+ZFY8iumidf7SY7ZFq54ZRnJkqu/OAmiMxceScLOiikjFVT1owNmDa/rmZ/arkGjCQ+j8s28BwklPyqXKaT+nAXscezX608a6QtvOw3EeQ6VDDTuYw1oC66+gIPXcbB7mWRPFxDjyEOebRXi0w=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J3Uho4JFvuXgK7Z+RPMjlo9Ma3lJ5U0nvBVYkOXOC9fxzo4CP+ID0LeJJFw9+h/XAj8Yru7zpHTb2ExFkTCsbGgleuGUFyP4Uc9pWctQcz/FLB7GMaqdcTTqBXvNKctNoeziZB0st02/b3t47rT6iHDDQvcVz6GlD7dsX60ETQ9HjctPKuHoTnSll7fv9NxFpB9Shaf8wR0tci5/08tF9jyCjtozb0GbRbJVLsKIUwkI4gwZzSU4txgZ0SSftFzClehKZRgubO0/lIiwnQ7g4oj4jnLtTCgEGfB3E3HdpgxVNjTgjwQ9g3xTLZVWb2+6j34cZGkI1ZNX41HJFUTu1XvzWVDfLaFezoX6fdJuy17uY6AfB/BwOLChcNlenBW7/sMSH/3BwLgYrYpjb6giAlzT1Y3avn4P9Fj/5WgDexgkjTFbONdTstGXVXmNNrLM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 04:19:17.5263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1c8c31-7337-4f33-3b8b-08df33184d27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB497784

The IBS_{FETCH|OP}_CTL2[Dis] bit allows IBS sampling to be stopped without
a RMW of IBS_{FETCH,OP}_CTL. Systems providing this bit therefore do not
require the IBS_STARTED and IBS_STOPPED states used to coordinate control
MSR updates with late NMIs.

Add a separate stop path for these systems. Preserve Val while disabling
the event so that a delayed NMI can be identified and consumed, and wait
briefly for such an NMI before restarting the event.

Leave the existing handling unchanged on systems without IBS_CAPS_DIS.

Reported-by: Jim Mattson <jmattson@google.com>
Closes: https://lore.kernel.org/r/20261007234815.4026028-1-jmattson@google.com
Fixes: efa5700ec0da ("perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to eliminate RMW race")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/events/amd/ibs.c | 145 ++++++++++++++++++++++++++++++++------
 1 file changed, 122 insertions(+), 23 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 78a36ebf2d23..714589570c21 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -28,6 +28,7 @@ static u32 ibs_caps;
 #include <linux/hardirq.h>
 
 #include <asm/nmi.h>
+#include <asm/delay.h>
 #include <asm/amd/ibs.h>
 
 /* attr.config2 */
@@ -73,7 +74,12 @@ static u32 ibs_caps;
  *
  * XXX: we could probably be using !atomic bitops for all this.
  */
-
+/*
+ * NOTE: IBS_CAPS_DIS eliminates the RMW race on the IBS_{FETCH|OP}_CTL, making
+ * IBS_STARTED and IBS_STOPPED states unnecessary. We use only IBS_ENABLED and
+ * IBS_STOPPING states when IBS_CAPS_DIS is present. Semantics of IBS_STOPPING
+ * changes a bit as well.
+ */
 enum ibs_states {
 	IBS_ENABLED	= 0,
 	IBS_STARTED	= 1,
@@ -557,7 +563,9 @@ static void perf_ibs_start(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs = container_of(event->pmu, struct perf_ibs, pmu);
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
+	unsigned int delay = 50;
 	u64 period, config = 0;
+	u64 ctl;
 
 	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
 		return;
@@ -575,23 +583,87 @@ static void perf_ibs_start(struct perf_event *event, int flags)
 	}
 	config |= period >> 4;
 
-	/*
-	 * Reset the IBS_{FETCH|OP}_CTL MSR before updating pcpu->state.
-	 * Doing so prevents a race condition in which an NMI due to other
-	 * source might accidentally activate the event before we enable
-	 * it ourselves.
-	 */
-	perf_ibs_disable_event(perf_ibs, hwc, 0);
+	if (ibs_caps & IBS_CAPS_DIS) {
+		/*
+		 *      IBS HW                     SW
+		 *
+		 *  o Capture sample       o ->stop()
+		 *  o Set VAL bit            CTL2[Dis] = 1
+		 *  o Raise NMI --.        o ...
+		 *                 \       o ->start()
+		 *                  \        wrmsr(IBS_{FETCH|OP}_CTL, new value);
+		 *                   \       (wrmsr clears the VAL bit)
+		 *                    `--> o Receives delayed NMI
+		 *                           (Unknown NMI since VAL bit is cleared)
+		 *
+		 * Handle this with induced delay.
+		 */
+		rdmsrq(hwc->config_base, ctl);
+		while ((ctl & perf_ibs->valid_mask) && delay--) {
+			udelay(1);
+			rdmsrq(hwc->config_base, ctl);
+		}
+	} else {
+		/*
+		 * Reset the IBS_{FETCH|OP}_CTL MSR before updating pcpu->state.
+		 * Doing so prevents a race condition in which an NMI due to
+		 * other source might accidentally activate the event before we
+		 * enable it ourselves.
+		 */
+		perf_ibs_disable_event(perf_ibs, hwc, 0);
+		/*
+		 * Set STARTED before enabling the hardware, such that a
+		 * subsequent NMI must observe it.
+		 */
+		set_bit(IBS_STARTED,    pcpu->state);
+		clear_bit(IBS_STOPPING, pcpu->state);
+	}
+	perf_ibs_enable_event(perf_ibs, hwc, config);
+
+	perf_event_update_userpage(event);
+}
+
+/* ->stop() for platforms with additional CTL2[Dis] bit. */
+static void perf_ibs_stop_dis(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct perf_ibs *perf_ibs = container_of(event->pmu, struct perf_ibs, pmu);
+	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
+	u64 config;
+	u64 ctl2;
+
+	WARN_ON_ONCE(test_bit(IBS_STOPPING, pcpu->state));
+
+	set_bit(IBS_STOPPING, pcpu->state);
+
+	rdmsrq(hwc->extra_reg.reg, ctl2);
+	if (ctl2 & perf_ibs->disable_mask)
+		goto reset_state;
+
+	wrmsrq(hwc->extra_reg.reg, perf_ibs->disable_mask);
+
+	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+	hwc->state |= PERF_HES_STOPPED;
+
+	if (hwc->state & PERF_HES_UPTODATE)
+		goto reset_state;
+
+	rdmsrq(hwc->config_base, config);
+
+	config &= ~perf_ibs->valid_mask;
 
 	/*
-	 * Set STARTED before enabling the hardware, such that a subsequent NMI
-	 * must observe it.
+	 * Clear the Val bit otherwise ->start() will unnecessarily
+	 * wait for 50us.
 	 */
-	set_bit(IBS_STARTED,    pcpu->state);
-	clear_bit(IBS_STOPPING, pcpu->state);
-	perf_ibs_enable_event(perf_ibs, hwc, config);
+	if (in_nmi())
+		wrmsrq(hwc->config_base, config);
 
-	perf_event_update_userpage(event);
+	perf_ibs_event_update(perf_ibs, event, &config);
+	hwc->state |= PERF_HES_UPTODATE;
+
+reset_state:
+	clear_bit(IBS_STOPPING, pcpu->state);
 }
 
 static void perf_ibs_stop(struct perf_event *event, int flags)
@@ -602,6 +674,9 @@ static void perf_ibs_stop(struct perf_event *event, int flags)
 	u64 config;
 	int stopping;
 
+	if (ibs_caps & IBS_CAPS_DIS)
+		return perf_ibs_stop_dis(event, flags);
+
 	if (test_and_set_bit(IBS_STOPPING, pcpu->state))
 		return;
 
@@ -1416,19 +1491,43 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	unsigned int msr;
 	u64 *buf, *config, period, new_config = 0;
 	int br_target_idx = -1;
+	u64 ctl2, ctl;
 
-	if (!test_bit(IBS_STARTED, pcpu->state)) {
-fail:
+	if (ibs_caps & IBS_CAPS_DIS) {
 		/*
-		 * Catch spurious interrupts after stopping IBS: After
-		 * disabling IBS there could be still incoming NMIs
-		 * with samples that even have the valid bit cleared.
-		 * Mark all this NMIs as handled.
+		 * ->stop() {
+		 *     set_bit(IBS_STOPPING);
+		 *                               <-- NMI (race 1)
+		 *     CTL2[Dis]=1;
+		 *     ...                       <-- NMI (race 2)
+		 * }
 		 */
-		if (test_and_clear_bit(IBS_STOPPED, pcpu->state))
-			return 1;
+		rdmsrq(perf_ibs->msr2, ctl2);
+		if (test_bit(IBS_STOPPING, pcpu->state) /* race 1 */ ||
+		    (ctl2 & perf_ibs->disable_mask) /* race 2 */) {
+			rdmsrq(perf_ibs->msr, ctl);
+			if (ctl & perf_ibs->valid_mask) {
+				ctl &= ~(perf_ibs->enable_mask |
+					 perf_ibs->valid_mask);
+				wrmsrq(perf_ibs->msr, ctl);
+				return 1;
+			}
+			return 0;
+		}
+	} else {
+		if (!test_bit(IBS_STARTED, pcpu->state)) {
+fail:
+			/*
+			 * Catch spurious interrupts after stopping IBS: After
+			 * disabling IBS there could be still incoming NMIs
+			 * with samples that even have the valid bit cleared.
+			 * Mark all this NMIs as handled.
+			 */
+			if (test_and_clear_bit(IBS_STOPPED, pcpu->state))
+				return 1;
 
-		return 0;
+			return 0;
+		}
 	}
 
 	if (WARN_ON_ONCE(!event))
-- 
2.55.0

