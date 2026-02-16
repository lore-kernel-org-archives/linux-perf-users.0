Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFAF22A7F1;
	Mon, 16 Feb 2026 04:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215782; cv=fail; b=IoBNH3fw3D1zu2kWJGP4uUgjL53lMjkQLC6vhHse4XwMFLIDnYzmXXd9me+M4QTDKLERug5s6GQm5uqlL1zwwCx+imWaF40Ii/d5Z4VZCPRKY4L3t2UOlUl73Akrj2CvHcBMihDUgcWqikTCXAmGdvL0CRzOIODONS7hmqPeejo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215782; c=relaxed/simple;
	bh=a9z0sDFTjY8uzLGUgu03f7kdekSjgRr9CLMiK0UwMfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTlARgIPZvwUoL8dYfbJ9w9lJe19N3SsIMt/QAZuVUwnerFSdF87lbj5w/6yd2gsf7JjI3YF06zCq+xauCg2NDRfEtlGxLo/inZV1EDpsNJ7e9d6EuM89lx0VYNIGG1kqlJp502MD+491P/77ENK/CCV1q2SnicRP9IT6Ikgg7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=msBLlNvI; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="msBLlNvI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCzjI+c/p0acnriZtighETmizl7HutYycMnGBxScQ5+ok22N6Rb2haiyu4q3PE6eiBgHoUD5J2l71llOj2npY5L67iRdsfeEChWxRd6s+LNQq2B93K0u/W98SJrUevAANYjpZze51sI6BQ/kXPyw6Dka9sb0MZeeSvQrJL+bAMrf0ML6ndFK/qI5cUfwh13XWYBkcZempHwCYtHmuEKybxp47gJj2Q0JdmlPnMYVWkktM04sxBtjsC0g+D1kWuUMTfd9PllJNUYIrIfRy+vlMVxfE55vJRNxkP+XdEG/+YblGxpWJK+t0YsY32eMil4tYNvxqgg8YAX8unng9whiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2ha0VfAR3FdfS4I+wfNqswGVZZ3080xR+q0hiVb5RU=;
 b=DVKy4d+cfwGKS5aZDBIr3/Z9hPSaH2PEJdVlvoEwtPrc/mglbRMQeJJwLC84bX29/XmnBGqsskZn10SpnYRO6X805RixY3qzZLmDxRL6AmDgkAc/jjdfU4VdgXvz5s0NsPvMM9GYqTebTeCXFl0GZJV+u00nNlMkBX9L0meDMUwHng4ldcIDCEhys4/tn20dScpaqbmKSLRCTjFbMSkLe/j3A+7IASGVXQe0XOhSXUpixPgPbqd6V1KY8bY0RXiSfL1woezH3Z4IM1HcTneBsRw66G+VDJ8SEgbZa/fZ0ozPt58i3DcVKzdr6kS2eDcOghyWcaKyO7YkxYNVglUhJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2ha0VfAR3FdfS4I+wfNqswGVZZ3080xR+q0hiVb5RU=;
 b=msBLlNvItcmRyyjhJAF9L37HSiT9Go4jwStiYCIxj2+dwyY4K/QsbY4XRfBSTtt8AWgk1CrmJuH3KVCFVHNka/6mmrL9sUg5SCApt4/ffh1PAhIdg/T1ZI9pn5YnQzRRFxgaY+XyhPiPg+yNjESoHfnjYNO7YZtVptllWl4Z0ns=
Received: from BY3PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:217::26)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:22:55 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::9f) by BY3PR04CA0021.outlook.office365.com
 (2603:10b6:a03:217::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:22:54 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Feb
 2026 22:22:49 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, Sadasivan Shaiju <sadasivan.shaiju2@amd.com>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 4/5] perf/amd/ibs: Avoid calling perf_allow_kernel() from the IBS NMI handler
Date: Mon, 16 Feb 2026 04:22:15 +0000
Message-ID: <20260216042216.1440-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216042216.1440-1-ravi.bangoria@amd.com>
References: <20260216042216.1440-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: dfef9b67-95eb-4ce4-c340-08de6d130e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?orUQ6EADrTWrI+6RK9CQSd6JSoSJooFNPZ2Fr1Wo4zvY2l40JM/l4poC3AZs?=
 =?us-ascii?Q?MBeVTHDZ3HNl1XBILIjRcka3IgCdh9zEud9j658ptkn/Ph9zcV2FPxF/8ksZ?=
 =?us-ascii?Q?uJFtNvvsthtVas7ZP0IOf/AUiO0A02AOuwTwqtsAh0OUNj6kMURKNcNeBiFx?=
 =?us-ascii?Q?5Q40xLv0TX8GATCGBvfmIg0HUxQXbzn8KQVM7sAkTj0Yc/8MF5RriHy1B+nI?=
 =?us-ascii?Q?2s1IG8i8WajMRaadBjrEPF6aWlSvHuaUToWxJC1STNsoEfs2LUNt2X30JjK8?=
 =?us-ascii?Q?Qv8cKQg4eNYNH6qe46JY5ofgpDDF/jDCT4pwzgQcpx5c7foGQJYhCu5HDTiB?=
 =?us-ascii?Q?UApjebe46tgfRatRK7TdumhbiBd6JVQhSXgd1UDC+uv9/cRSLMOTsCjd6Ixh?=
 =?us-ascii?Q?4vBq9gSkYIS7LGSzxaHgJkc6UBeeSSE+YcGR9Ucq/ubXPfGzzsq/+QlXILJa?=
 =?us-ascii?Q?DbzuDuvaXB4gs7Z6qAY29Xtnht+Xj+PGnZ54qn0uITPt5BrewiOfiHXLKKBZ?=
 =?us-ascii?Q?/Cn017RC3V+K3i+H0vyyovshbX8bQ20NINFXtfpV46Ie7YOXjmA6vI6USO1d?=
 =?us-ascii?Q?sH+m+1T1CLdDB2w8mE5ElALms+GlD7rsvPt7c+F1svKWCGAT+Gp2jTqxf8NT?=
 =?us-ascii?Q?FoDRgJiFMBNWRhH5yBL4DUjEw/YJvCn+Us8C1ZSYfCjQqfy/CpPwMMhKVdsf?=
 =?us-ascii?Q?2TY4eCCBj8E+n5I0rb6uNEjP67yI9qyrQOfUh2WUydvu1UJMGq8eYtJkM981?=
 =?us-ascii?Q?WMxRdmZo3gh5lfI4l8CuHre3qLW/3j4Cep9hpSm/M1Jf63zi9BQW+d3NF11s?=
 =?us-ascii?Q?orIEreOTDLuc/Ivi78oHnX0Mzzw+a1xRkJlanaWXeLT1vNP+Z/SUE4ACBfJx?=
 =?us-ascii?Q?alMpU9ukl0NI9lg0TURZvuATitz242rrMxR0oUUn1qSn3zMEMoui/MX/h7nT?=
 =?us-ascii?Q?eS5SHri5kwm1vZtm7E1P4jgTtleAV+fUASflojS+f0SLcd5Q/ia7hqapNJgf?=
 =?us-ascii?Q?dXB3OF4zNju4hUBsJtAIJCUIQ15HvzNUBn2Xol+OMHjs+Kll9xqBwt4/5y1n?=
 =?us-ascii?Q?I+wm04lblCpGd+ODyR6w6NEvg/b9GIlE5d8PSkghnLfm4Xbl8WY3xSX12OOI?=
 =?us-ascii?Q?Zguq3Qe5gLSBcx0yv+je8WNWxlJH5uiSKj5XSiMLE527R4y9zlweeBK/JD7a?=
 =?us-ascii?Q?mVvjkdftGhHe6LXTmOYQBb47PFnIEuFvFy4jmWQsK/ZdqUEgE0AivvM4e1PJ?=
 =?us-ascii?Q?RkRK+yVYDRhudWbVGJ41aRxeXfjWO2dCcoeed9QIGTl/Lc/4QE6PjAy8A0oc?=
 =?us-ascii?Q?gClBZMXyor3eTYGU99WOw3leNYIHLA8AIVGBO9pYNrWmalFHmvS/WMMDKpA6?=
 =?us-ascii?Q?00Odgjp4PIr5Cp14Vjg8IGTwdBsAJpUTmYM88mDs5UUfLokXcByCRr3Crkv2?=
 =?us-ascii?Q?fMiVBKa1NnsPcHrWpWMKvV4oRNBm8i8Bv2ELAx5HzbVDmaHE+o+A4kgwol0Q?=
 =?us-ascii?Q?Jhg5wKaV1xupTH5BXw9wjmxEACUPDcelcWhrYP7teg7ONwHSKQvXU29QSpQC?=
 =?us-ascii?Q?G3/0srrwMX/jBoO1x4yrzfpnp3vXqzrUiiXm8WvUj7D1L2QvVaXZGgE7uCpe?=
 =?us-ascii?Q?ueJ5PrmFQazyzNosHJ2K+Sah3XgIv1x3pKaIYWt2CuwD4UBLmXd+EdbSJHbm?=
 =?us-ascii?Q?QBPLzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LayZS8VLPyHdbJ16+ZT9+kmAEdtQQTmWQzDxBNa2/WdwCbIMOX5SoLaG29A2K6z0N2avcY1RIt8oWBIYRALmiWNs4pQGrYwe3xRDjJtjsLPNMUrc+IFpJoj5DQl1SYCtcgSWXCTay7ITWn8srXvUC3Yy3aUd7/+os4uvWblsPmj2d4XLcg42VU18AfqQaqxdUGHwH0y1/6BQ+2FFYIw/8CLKSYoWaBo9ykY0G1p+w9kU60+CepZnY9CcotAab+sRlVsLmX1+Exb6o1eOi3W4XXQElpRVrBEMoimf6QYeMY+LZdzw69QRIqJF9cyLebCY3dZj70aq0+H5UQN7z8dIf+dQu6CFCX8SygevqIv0igzupV6ou+YGn8C3B/rC4aspUySO9XUUiBJyFQR/R2CZBXS8HnSXnfN6H0KlXJ22Envq4R7sYYKccbTrY8nhSpcn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:22:54.8167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfef9b67-95eb-4ce4-c340-08de6d130e92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083

Calling perf_allow_kernel() from the NMI context is unsafe and could be
fatal. Capture the permission at event-initialization time by storing it
in event->hw.flags, and have the NMI handler rely on that cached flag
instead of making the call directly.

Reported-by: Sadasivan Shaiju <sadasivan.shaiju2@amd.com>
Fixes: 50a53b60e141d ("perf/amd/ibs: Prevent leaking sensitive data to userspace")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c          | 5 ++++-
 arch/x86/events/perf_event_flags.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 05b7c9f2ec33..004226b52ac7 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -313,6 +313,9 @@ static int perf_ibs_init(struct perf_event *event)
 	if (ret)
 		return ret;
 
+	if (perf_allow_kernel())
+		hwc->flags |= PERF_X86_EVENT_UNPRIVILEGED;
+
 	if (hwc->sample_period) {
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
@@ -1349,7 +1352,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	 * unprivileged users.
 	 */
 	if ((event->attr.sample_type & PERF_SAMPLE_RAW) &&
-	    perf_allow_kernel()) {
+	    (hwc->flags & PERF_X86_EVENT_UNPRIVILEGED)) {
 		perf_ibs_phyaddr_clear(perf_ibs, &ibs_data);
 	}
 
diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
index 70078334e4a3..47f84ee8f540 100644
--- a/arch/x86/events/perf_event_flags.h
+++ b/arch/x86/events/perf_event_flags.h
@@ -23,3 +23,4 @@ PERF_ARCH(PEBS_LAT_HYBRID,	0x0020000) /* ld and st lat for hybrid */
 PERF_ARCH(NEEDS_BRANCH_STACK,	0x0040000) /* require branch stack setup */
 PERF_ARCH(BRANCH_COUNTERS,	0x0080000) /* logs the counters in the extra space of each branch */
 PERF_ARCH(ACR,			0x0100000) /* Auto counter reload */
+PERF_ARCH(UNPRIVILEGED,		0x0200000) /* Unprivileged event (wrt perf_allow_kernel()) */
-- 
2.43.0

