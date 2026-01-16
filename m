Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D31930F819;
	Fri, 16 Jan 2026 03:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534544; cv=fail; b=BnqN9f3KawUVIVrteyTysHeGObgSlm+zZAYBg6ZoZudSeRwBT57h0LaiLinGrL4N7H/cZLMOAuyxbabGGcl6Wcr8QOIiTBgxcF76KmS8JnNDR3E2pF9CSsGuOn6RucvBdsP6UnTWVk8v3m4y9p/B4pFk43u3wn3h5PNZOiKo/MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534544; c=relaxed/simple;
	bh=yotcCtMHme7NisWv4keJkL+mQv/2YUGk2mL0lUlpkto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtWugEi/2xXz56kPP3xMuXpcC3d/TRbUuOHmLYMCNFT2b8WolBaspws/SjRCsiw6IouxdOK5UJQJPLTjKr+FT7sHd01JRHKiiFffz/OWX4OH9RsTPakTS/17qHPVqynYBo8Y49Dv/IzbfsY5O8JAhR8f2mjvIkgzkAg352hPccs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2RFt2Yza; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2RFt2Yza"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0sBOPo4ACJ3J8MmLR+ZZfrpcocbFDPindx8BD3GhHPbg2cou7dY3kluNGyx4yDJ/0FjgO1DuZWr07mhbtJpXim0S/cpRgKFGjtuZhRZCFG/IDzOPOkHB6d8enIZLUxtl5ZCqQbq2tMWP+sqXtGyhwDFw+9mC8Urv5B8lujde+EseJIzCDZMMejkqiEG24SVxNY8G8RoeK56EN5Uz/Bxf3VnQbtb3Iu40TWCOI6PxMO43ZLm9uA8nz2LLD71E2Ibo7dJ4HBkYBmnSzRXwuGcBFuR4hL3f2XF+2imB2j9W0er4zLherXIIoh6eVeXPhFax5jVWJPeu3NY/H1b0/ll8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQhsQxPHmR4lk0Alo5MMGB+Klj8btRrbvRjO5KPGhYc=;
 b=O5k1tg9NeBlnTNCjm6RV/eYW7HXHnPcD99wY7fAHuAU9y5Pp+9qV5f/kk7K8dPKnfTh9PL84ZVZ9d47Si+suziEbdKJLHc87YN1NguNSg8c+kxew2d6qoYKOJuKvHe5HVhMDf8er9A5JOwoxgxdHPRC/gseiVDym5VjKKzx5qqFvrN1Xs9JfbwbBo0hCPwMsUz9dcNjWh5mZ7/3N0QBOv4ehS4v3VhbUfcsXKvrL16ibDLn8X/HFq+zEOVqBsN7T0DQyxNtJUbVscxOjnjFvXCYZaUC8NuYrMZ8rPHbKsj+JqQ85sSSmAwg2h3CdVj3raQ8MUzbG2iqgeGUQE9MMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQhsQxPHmR4lk0Alo5MMGB+Klj8btRrbvRjO5KPGhYc=;
 b=2RFt2YzafFDucTyMPSYSf3lIO9GZG4hsSxndLMxSTbHc/ovqZifxr+9vkkxDC4r4qw8WdpdImW6ByfqdQTnbM4XAksR0J0qF20gmBtheRUOTPeRjuAPiCqQgIIkepPDlTns7U5lM/REPQEWV9B6zlBpaKYPcYgzLFF2xShPQ/Mw=
Received: from BN9PR03CA0633.namprd03.prod.outlook.com (2603:10b6:408:13b::8)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 03:35:39 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::82) by BN9PR03CA0633.outlook.office365.com
 (2603:10b6:408:13b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 03:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 03:35:39 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 21:35:34 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 04/11] perf/amd/ibs: Avoid race between event add and NMI
Date: Fri, 16 Jan 2026 03:34:43 +0000
Message-ID: <20260116033450.965-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033450.965-1-ravi.bangoria@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 83508c57-0584-4252-6702-08de54b051ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+IMwUCuCbJonqf7WqRdEz9MPqvj4n6chnq2P/C51fvIrXAxfgFBmmfVlRfD+?=
 =?us-ascii?Q?YP26ry591wQzHMprfu2s/gu/2iWOIaX6zXOy42Wi3ktFwXlVACv6PmkV43Yy?=
 =?us-ascii?Q?9ITMPYJJZHdahX+q7SJ8eLlsoqOaAIl5c/bgC6uvom0fPg633anlAYG6hFR0?=
 =?us-ascii?Q?6EPo1579ooDgWj4CHgEuh5BtWPa03qD2S4XWjxMYHK8AzkVZgl3FTpx2G9zJ?=
 =?us-ascii?Q?R3VghxO9TNcA5yTcZPFEPP9TMR7ENEx6HmDBhYlQGDWvfHXjROIYIc8JdXLo?=
 =?us-ascii?Q?5ioZ8QEu4RHso4MBjeZabxephoSAuAKZWkTJ9FO3kuMZ7UeKmBad2ITR54kQ?=
 =?us-ascii?Q?SzwNoennxnCvyYpKYfC9TwWKNMAE5sg5/CDRlg3DjaE5LWsCBOvWBEe863/B?=
 =?us-ascii?Q?lk7NHaOiiOnEYBtwPSVUOYL3ceLiJ45YdjvwTYQz4qhzFEf3sULZknAzi3e4?=
 =?us-ascii?Q?bnk9FIefCYJ0nu8G7msZlGT5I6f3BiB5VN7FhOJiFRpYA7t80YC4fMRScOEU?=
 =?us-ascii?Q?lAVe6Y3q7ubWfbpCaK8Ccu9l97c6T9RQa+LE+Zb+O3zYYtc+71/H0W8LXwOS?=
 =?us-ascii?Q?IoxvECJVKbBwMlokgsZJW+nme7zPtV4AKZthZVORfk1WuLf9s6H/BPVwybuv?=
 =?us-ascii?Q?HG/i0HsWwLhXTz12N0aL+KVfcqS8cat48O8KRt6Seh0HIYbQYZY3pvaqzrM+?=
 =?us-ascii?Q?HN9RNMhgqiLkJ7jspxZKQT4OK605gxp75EImtYH1l+Oq1g/zK0eDgtB9L6H0?=
 =?us-ascii?Q?O+giDi4gJpwQ9SKLFDw08FhHCiaYeu9Nt29CKq8EJ7ZYyqP5znQ00sJaAy8N?=
 =?us-ascii?Q?ZpOhxQuqblGTdK5mtTnKBt8df3yW1pqt/lxOQuke7yOHw8uL8TT3R0jeRA5T?=
 =?us-ascii?Q?ftMsruHJnkMOZXy852zOV1lz6TZxM4GLzkUXzsYaQHP0FpCWobY4dUIWsEeF?=
 =?us-ascii?Q?eBCOpDFlSMCIFj64aqd4SGkHDsPj0Yg/x0ucHkbRse3eDG5xNGZ7wJcVE+aV?=
 =?us-ascii?Q?lwwdLk+5/lKxt3lX5IzGrIO3ijmRI/XUNm9pyqKBz6k171mbI3axdICR6Nhx?=
 =?us-ascii?Q?eIFI82kcD6DfggAUAxWO5ZvFRUnlgOiMCxyjEENDPhiv5+9F6CWrGJSsuSnZ?=
 =?us-ascii?Q?PZZUl/NeJOuaSybU9r8Z/py1UOmieHQup9ajU99BqfMo6dDAniwmG80YgyCF?=
 =?us-ascii?Q?Te1iBKt7imdem7ICjhserMq4OumgHUJQSeW5ANBDWa7TGS6MTb8EJ260pJ7t?=
 =?us-ascii?Q?QU5UzPd5I/K97KlcvhDP7M1Tomw/G0v6LgaX68m6vSXgge1xw5SG8sBnxERe?=
 =?us-ascii?Q?J/TcDkZTvJyWPNj44EIzjTRZczffjUFUx5TTfraZU9xIEDatI5du/7mAz3bk?=
 =?us-ascii?Q?ZW9BSgZo+6PRB5yH0tAI7FbtCCZsU45DSQk6sBgg2TMD0mbUwqDl0m9vOV5S?=
 =?us-ascii?Q?Gfz8wTuaPflAWH2PKkmrJb3d9aYGTGoxa56BTJKDXhddJP7ey+zlSidjkvxp?=
 =?us-ascii?Q?wEEtWmSKd7J8qzX3DyfYlhGjFkbGmJfKGFSD++yjAh7uNGrutr5BuuQpzTCJ?=
 =?us-ascii?Q?PJX9cvCDqShuAwKI5Yltk76nILu7+FRc9kCWcDlUYsXbgEQKmtnmnpLKrN68?=
 =?us-ascii?Q?wnWs8uyHBiNbTA0HwSPhiRi3n3sODhQYZ+kU3djfS2JB1Ej98YsMdOl+bdqs?=
 =?us-ascii?Q?b/Adag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:35:39.4123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83508c57-0584-4252-6702-08de54b051ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596

Consider the following race:

  --------
  o OP_CTL contains stale value: OP_CTL[Val]=1, OP_CTL[En]=0
  o A new IBS OP event is being added
  o [P]: Process context, [N]: NMI context

  [P] perf_ibs_add(event) {
  [P]     if (test_and_set_bit(IBS_ENABLED, pcpu->state))
  [P]         return;
  [P]     /* pcpu->state = IBS_ENABLED */
  [P]
  [P]     pcpu->event = event;
  [P]
  [P]     perf_ibs_start(event) {
  [P]         set_bit(IBS_STARTED, pcpu->state);
  [P]         /* pcpu->state = IBS_ENABLED | IBS_STARTED */
  [P]         clear_bit(IBS_STOPPING, pcpu->state);
  [P]         /* pcpu->state = IBS_ENABLED | IBS_STARTED */

  [N] --> NMI due to genuine FETCH event. perf_ibs_handle_irq()
  [N]     called for OP PMU as well.
  [N]
  [N] perf_ibs_handle_irq(perf_ibs) {
  [N]     event = pcpu->event; /* See line 6 */
  [N]
  [N]     if (!test_bit(IBS_STARTED, pcpu->state)) /* false */
  [N]         return 0;
  [N]
  [N]     if (WARN_ON_ONCE(!event)) /* false */
  [N]         goto fail;
  [N]
  [N]     if (!(*buf++ & perf_ibs->valid_mask)) /* false due to stale
  [N]                                            * IBS_OP_CTL value */
  [N]         goto fail;
  [N]
  [N]         ...
  [N]
  [N]     perf_ibs_enable_event() // *Accidentally* enable the event.
  [N] }
  [N]
  [N] /*
  [N]  * Repeated NMIs may follow due to accidentally enabled IBS OP
  [N]  * event if the sample period is very low. It could also lead
  [N]  * to pcpu->state corruption if the event gets throttled due
  [N]  * to too frequent NMIs.
  [N]  */

  [P]         perf_ibs_enable_event();
  [P]     }
  [P] }
  --------

We cannot safely clear IBS_{FETCH|OP}_CTL while disabling the event,
because the register might be read again later. So, clear the register
in the enable path - before we update pcpu->state and enable the event.
This guarantees that any NMI that lands in the gap finds Val=0 and
bails out cleanly.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 72abc474ec23..27b764eee6c7 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -490,6 +490,14 @@ static void perf_ibs_start(struct perf_event *event, int flags)
 	}
 	config |= period >> 4;
 
+	/*
+	 * Reset the IBS_{FETCH|OP}_CTL MSR before updating pcpu->state.
+	 * Doing so prevents a race condition in which an NMI due to other
+	 * source might accidentally activate the event before we enable
+	 * it ourselves.
+	 */
+	perf_ibs_disable_event(perf_ibs, hwc, 0);
+
 	/*
 	 * Set STARTED before enabling the hardware, such that a subsequent NMI
 	 * must observe it.
-- 
2.43.0

