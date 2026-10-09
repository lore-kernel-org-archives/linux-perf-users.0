Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8316319D074;
	Fri,  9 Oct 2026 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791517818; cv=fail; b=EMXufDZbWxGJPILr3ZlKy2GCBfqmIu+jmJJmWMx+VqTbm1ePFythE1wDJxvbwW+0oZ+siONx8O3gbgddr9JSSDL9MoR6ymDIsSZNOdBrfl9jNX4OymrokXa+v5+HigjYqo8kwE61vUoh6RmSz+NPGZKRw/tzOmqs6oFx29Dm4Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791517818; c=relaxed/simple;
	bh=47INA4b2D583CTi3qXl/491VNj3Xg7v5JVxKrjCecUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UD8AlvMu0HCS5AuOsC1oOYveQOYLnaajqtYfXXxpHAG1VyEyimIp5y0PNyhyouTCC8s70bB0qj6FRAboMsuJAGDOSBbStrKJHE9kKLlfTOquT7PlAobzrXn9T4EUzMUfRkSieZI7xuB/kZPlUjENeZvXo1Kynwwpxqf4A6x0SG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jc/I6JX0; arc=fail smtp.client-ip=40.93.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jc/I6JX0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOFeu1qPymA4PP9H8TE18tcIUwfUOCa+ACIZxu6WwjIyFQW36D8yy2GUcvOBq8Sgv9Yi6sBLNNXS99fOlS7GS39++CdXCZ7NMLircMN4e1m4MJUAr1UOht0qyPniJI7i37ABoMgqoL7Kc7sJAGqB35p2JjICj90JhwWCWjp30ukJBg6j/gAGzRBYUPL97xYTFethn3hSLQrpAZ9etVN2FwfWITYyGaRist8AewlXT8bBeW9mHAXVyVoo7tHzbFisUOS9OV3k6Euffamvn295zGXpmChLnLQvuWv5Q24MusNtmdEb6E3OsRxLZw1dg5WsegVYzf8cr+7o6vSUwe+7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPRGbbYgDZBIen9kUCYaRAyQATjbz10s3zwTgOsVgkM=;
 b=rOrxz7hEXVqicisdH/hWd2rEaGT8W358nAfUJbrhpNGYUVWWIbUhmPCHGgcEdQeyqWHNs9WYCoGKr5eo/HuOESmX1VSEi8I7qzjf8ZzFvAUBgcoHFS55W9A5cisZM+ATr1zsdAAEqEDdDACz1UrL3DdhpUNtM6R89Qp5loflpiMFHKr9CIIDUklZNQKQ6QoPTCYCjnREhDyw7FKcDgc2F8ZnPVhfQI70rTTqfm0tbhWs+jdtiLl79Vt22aVrrYCreFkPuFrkKEzTammTTIQeotxbJsO8JYkTDYR3oiygOSSvYjHYyYOzDFnkvegbHkfYl+nxz8CIx+FoyIlNB/z4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPRGbbYgDZBIen9kUCYaRAyQATjbz10s3zwTgOsVgkM=;
 b=Jc/I6JX0FM+YBukvyOlHDs91IkwI8TjTfbyTsewsj4q3uF/ZYkOAWQqeC1kmF242nEI2FDAzsLR4aJTG1L7P+IeT5ZU1oKo/vO88JANnbCDX4ZnZn80ReJXJ/e9BdHw8dpfzNj7yF83Rq9NXGkFFkIeEs2UNSGgSaJnG9mpgsjc=
Received: from SJ0PR13CA0134.namprd13.prod.outlook.com (2603:10b6:a03:2c6::19)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 03:50:02 +0000
Received: from SJ1PEPF000037A2.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::45) by SJ0PR13CA0134.outlook.office365.com
 (2603:10b6:a03:2c6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 9
 Oct 2026 03:50:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A2.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 03:50:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 22:49:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 22:49:56 -0500
Received: from [10.85.33.129] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 22:49:50 -0500
Message-ID: <cce3cc5b-7942-4833-8ff2-8dc544ba45a2@amd.com>
Date: Fri, 9 Oct 2026 09:19:49 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/amd/ibs: Clear stale IBS_{FETCH|OP}_CTL in
 perf_ibs_start() with CTL2[Dis]
To: Jim Mattson <jmattson@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Yosry Ahmed
	<yosry@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20261007234815.4026028-1-jmattson@google.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20261007234815.4026028-1-jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A2:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: adf379da-4e6f-4b5b-7831-08df25b865ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|23010399003|22082099003|18002099003|5023799004|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	kHpCgvrnp/L1EqLf3A2dC+WoV4JcdNKXZ9TLoX/Loy94kUAh6zvlUxfL3z2YU4p3muiEwDN+djbziGMfv1VLBJiMoGtSNmizOOn7287kHXAVqu9yOSZ+9OdJQYjiv19hnA7e0fKfFluhYXVkk+tHZaLrcjTvABAfpfK/Eywuv3ZQobU3TQLa6ZeBgdwg84NeOT1gu4JYTYB5pNIBHQNvbir63mVRQm0iGQ5zuWVf5MTB+HEKpRJByJQloE+4dv4og+UUUCvR7pYXqkfHTrGqgkMsBy042roXRLYO/Z5ubE+1m9w4JWS28eGqMsLBctswKOnAbjj1VU2iPJ2uWZ+K06Qma9icvMDlcCbRZSbCFadCP+D6X2eOT2/pDe0n1fv+F2LDUXtHZSJqJqNtJ2sg4zN9zhTW54Rnc8JmTEbv7a+M+KbCOUhpNJyiYRiL8XJvZBexX7m/e+dAG/C7MV3K7huJGMKbwAiQYo5nQ5IE+xrJ6VwptZ5uU0fNwKxOcaaEggkOf6u7hRqIIKn+MwJj0fxDW65eCAPXskOPZz3JvQvtJYTy0rYyntMYHA9SFpqL/0oII74lNhYEHYuapm7+xzakvNaV+BOJ/Hi5JcfjFmrZcHRFXalKClXkZqQ/iWauSV6l2yrlfVFUmj9mtEaKKA5h0AZbcBRvZPcqDuPQ5R5+SdS0CGOyVaRsjBQXhgYr+4G0+iYlUyZ10y1rBpa5IA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(23010399003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F4aAP7zQB41kw6qt0nsOjyIJmpJnBlWK7o9gD+A9TOaxDcYVXrKQ4SZ0akZzRr6cywyLCg5rzpWXUooVmG8ocjILLLEiTngo76xhcs2/GVtRHsY40oF+yYnRr8OEaG+W+Gly4KMhFWLG6Mb8l0b0+ptTow41RxYt0TwKPNqH43y2Cj2hkZZ4DF8Cah4CFNAYwGtYQ78CIIXjRMSbUC+ul0EvkNnagu3rsG2TA5bPKDqHSEqyUtjzl9Fs1hIX+BcakFV2p+kcKogFuIh51cn0+wQ4uQO3KNjl5IYQKJrZhM/av4cngyd/oUyTDvvTEM/5NwxiCzepBfIw93DnmlTydOsFpFWE7CnGVlJkYaYrjnO04lhTL2dZpE0sgo60kt/a/8LRc5ZRI7lRnljOPGx5sdMCuQaBGqvEqD0C6/nlVoqPY72bzncLJIEJRycO2poK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 03:50:02.0808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adf379da-4e6f-4b5b-7831-08df25b865ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493

Hi Jim,

> Commit 1b044ff3c17e ("perf/amd/ibs: Avoid race between event add and
> NMI") makes perf_ibs_start() reset IBS_{FETCH|OP}_CTL before it sets
> IBS_STARTED. Thus, an NMI from another source that arrives before the
> event is enabled finds Val=0 and does not process a stale sample or
> enable the event too early.
> 
> The reset is a call to perf_ibs_disable_event() with config=0. A later
> commit changed perf_ibs_disable_event():
> 
>   commit efa5700ec0da ("perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to eliminate RMW race")
> 
> When IBS_CAPS_DIS is set, the function now writes only
> IBS_{FETCH|OP}_CTL2 and returns. It does not write IBS_{FETCH|OP}_CTL.
> On hardware with IBS_CAPS_DIS, the reset does nothing, and the race is
> possible again: CTL still holds the previous sample, with Val=1, when
> IBS_STARTED is set.
> 
> Clear IBS_{FETCH|OP}_CTL explicitly when IBS_CAPS_DIS is set, as
> perf_ibs_disable_event() did before CTL2 support. Everything in CTL is
> stale at this point, so it does not matter if this write discards a
> Val that the hardware sets late.

Since the additional disable bit in the independent control register
eliminates the RMW write race, we can simplify the logic by removing
the IBS_STARTED and IBS_STOPPED software states. However, we may still
need to retain IBS_STOPPING, since ->stop() can race with NMIs, and
NMIs also arrive with a delay.

Can you please review this. I'll send a formal patch after testing
it thoroughly.

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 3531f9c23b8c..c9b96c3fa7ac 100644
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
@@ -575,23 +581,82 @@ static void perf_ibs_start(struct perf_event *event, int flags)
 	}
 	config |= period >> 4;
 
-	/*
-	 * Reset the IBS_{FETCH|OP}_CTL MSR before updating pcpu->state.
-	 * Doing so prevents a race condition in which an NMI due to other
-	 * source might accidentally activate the event before we enable
-	 * it ourselves.
-	 */
-	perf_ibs_disable_event(perf_ibs, hwc, 0);
+	if (!(ibs_caps & IBS_CAPS_DIS)) {
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
+	unsigned int delay = 50;
+	u64 ctl2, ctl;
+	u64 config;
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
 
 	/*
-	 * Set STARTED before enabling the hardware, such that a subsequent NMI
-	 * must observe it.
+	 *      IBS HW                      SW
+	 *
+	 *  o Capture sample        o ->stop()
+	 *  o Set VAL bit             CTL2[Dis] = 1
+	 *  o Raise NMI             o ...
+	 *                          o ->start()
+	 *                            wrmsr(IBS_{FETCH|OP}_CTL, new value);
+	 *                            (wrmsr clears the VAL bit)
+	 *                          o Receives delayed NMI
+	 *                            (Unknown NMI since VAL bit is cleared)
+	 *
+	 * Handle this with induced delay.
 	 */
-	set_bit(IBS_STARTED,    pcpu->state);
-	clear_bit(IBS_STOPPING, pcpu->state);
-	perf_ibs_enable_event(perf_ibs, hwc, config);
+	if (config & perf_ibs->valid_mask) {
+		ctl = config;
+		while (delay-- && ctl & perf_ibs->valid_mask) {
+			udelay(1);
+			rdmsrq(hwc->config_base, ctl);
+		}
+	}
 
-	perf_event_update_userpage(event);
+	config &= ~perf_ibs->valid_mask;
+	perf_ibs_event_update(perf_ibs, event, &config);
+	hwc->state |= PERF_HES_UPTODATE;
+
+reset_state:
+	clear_bit(IBS_STOPPING, pcpu->state);
 }
 
 static void perf_ibs_stop(struct perf_event *event, int flags)
@@ -602,6 +667,9 @@ static void perf_ibs_stop(struct perf_event *event, int flags)
 	u64 config;
 	int stopping;
 
+	if (ibs_caps & IBS_CAPS_DIS)
+		return perf_ibs_stop_dis(event, flags);
+
 	if (test_and_set_bit(IBS_STOPPING, pcpu->state))
 		return;
 
@@ -1416,19 +1484,38 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	unsigned int msr;
 	u64 *buf, *config, period, new_config = 0;
 	int br_target_idx = -1;
+	u64 ctl2, ctl;
 
-	if (!test_bit(IBS_STARTED, pcpu->state)) {
-fail:
-		/*
-		 * Catch spurious interrupts after stopping IBS: After
-		 * disabling IBS there could be still incoming NMIs
-		 * with samples that even have the valid bit cleared.
-		 * Mark all this NMIs as handled.
-		 */
-		if (test_and_clear_bit(IBS_STOPPED, pcpu->state))
+	/* Catch delayed NMIs which arrives after disabling IBS PMUs. */
+	if (ibs_caps & IBS_CAPS_DIS) {
+		rdmsrq(perf_ibs->msr2, ctl2);
+		if (ctl2 & perf_ibs->disable_mask) {
+			rdmsrq(perf_ibs->msr, ctl);
+			if (ctl & perf_ibs->valid_mask) {
+				ctl &= ~(perf_ibs->enable_mask &
+					 perf_ibs->valid_mask);
+				wrmsrq(perf_ibs->msr, ctl);
+				return 1;
+			}
+			return 0;
+		}
+
+		if (test_bit(IBS_STOPPING, pcpu->state))
 			return 1;
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
---

> A related question for AMD: with IBS_CAPS_DIS, perf_ibs_stop() now
> leaves IBS_{FETCH|OP}_CTL[En]=1. APM vol. 2, section 15.38, says that
> IbsFetchEn and IbsOpEn must be 0 at VMRUN of an SEV-ES or SEV-SNP
> guest with IBS virtualization enabled, and should be 0 for other
> guests.

I think the intention is, host IBS should be disabled (could be from
CTL2[Dis]) before running VMRUN. But I'll confirm with the HW team.

Thanks,
Ravi
