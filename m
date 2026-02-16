Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA82BE64F;
	Mon, 16 Feb 2026 04:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215785; cv=fail; b=BlusZOHvmH6gf0AwAd/iE4jb9xcBizWTZEzVdQ5P/Kz2/uucKOrgnujgX6c9S7umF2qIDyK9dW8ss1MEHezMr1dq3Re/5ww78p2bmRcaeojndTvNrVD2FW3Rrrq6hsMUfBovtLvEgTPbbYBcL5LCEavsnl8JBhSNXHHg7+ErjOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215785; c=relaxed/simple;
	bh=4Fko5Qs71a35JrSDRzHvEHiCGRPAdMd10F+p97IVrFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/xt2p2jsDULJmiUX/BssssflHMonsky4IrsgxU/6nq/AMOBv//w/NSJKoTFkbFQvVh02KotwmhZRQPtOsmxC3dHpLsI+VPq9AdyfDwKVTv9SNuLpMXubPWv6LV7WMz6Y6rjcSp6LHa+IhnLnLwGnq7HHmR56Y7BFAKFvKMVBNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3+P5mHdy; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3+P5mHdy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKXwRVWEBH1HuZzmCWbUT652Z16OVVRctTu74P9kl9Xa4IUmI13NmqS8SSGWRiNiC169/IB95hfhXNdgiqznOq7xgZhM8yHt5JytXzIDlA7dnUnd0Q34rG/w86HkmJwVyfgTKEUzVCchfyycy++TiBgsyyocTxN6qBSawg6DuIfiIeARR2eaT0j7WQavNIjaxBlfYFQbyN/t2OJEh+6o0hSP7ecZlp1Im9bOYUb41ohBlXX9EBuJ18elkQhdcJTt2kKJK3oGRaNoUa4+ahde6QUCLqRlSeBO7MjYGEBpP2jK/WZzlcRJ0uMg2hBxnllqVAVz4KqK5gVb6uVuxr+gDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deLYKkQV91S8CbzTfmPDgaZOXxcQ34oUfAenHqkEd2E=;
 b=yb2NkTmm5Hht0S59gu9PBTiMFlj9syXpoAiWVTO5iKrtwT5A6cj3Ds0hVfO7mcctyfGyBcr6wmNmajcS5D0KOCMBxbmTTd3xRl2X947pdC+PmSL8hCDqlTXXKTk1N4Byp+moahs2X0MYh1ygzWBGSqyDGAcJ8j4k9l/lBlLwxEz+lylr4Kvn0zD8ypNOt/+q0TJyL/xDadEEwHCZSc8qy99fmXCXlTr6ZNqz1lVjMozwqzqObP6GQtu9FkDjcrYSSUEWstdrndw9OIe+WjrozR8HkpxztSICxWVuwTiiRBG+NWJ2R3zPu1DkXrnjXrkiPM9MogeBoQx8v4zJLruygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deLYKkQV91S8CbzTfmPDgaZOXxcQ34oUfAenHqkEd2E=;
 b=3+P5mHdyJqiK2DuyS82ZJjH+/i8DlFZ2VZrlET3774FaAayAQtr5fboZexPBVKGJq0ny2LwHkTR55EFVxGOO4EvKl4Nv7C3NFwXzeU+vjju1ZNH5dRg+jVRbk0dS+Ob/hEkjpEc1n/SHFUm3Y7UwylJXbmVe4iXM/h7waV5HaaI=
Received: from BY3PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:39b::7)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.11; Mon, 16 Feb 2026 04:23:00 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:39b:cafe::c3) by BY3PR05CA0032.outlook.office365.com
 (2603:10b6:a03:39b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 04:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:22:59 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Feb
 2026 22:22:54 -0600
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
Subject: [PATCH v2 5/5] perf/amd/ibs: Avoid race between event add and NMI
Date: Mon, 16 Feb 2026 04:22:16 +0000
Message-ID: <20260216042216.1440-6-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 837cfdf8-577b-4a7e-44ec-08de6d13115a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?olLYccxq0L6li0Z6P3hh5TNKmvKrixJd9RbvNEv5LwnhW2B6iXIlyE56aoz1?=
 =?us-ascii?Q?gq3N0SlyANYtK2FNIAt9mfDUIX6ArbVEwT92SCI3YYGw1As67/aGrmIXoxtB?=
 =?us-ascii?Q?2BXx/Mz79bZShE2HgaepXGVuP+GuAb3HzrZh1iJXJ8caJbCR6XwvpyfAcuWv?=
 =?us-ascii?Q?1Zs11u0+X10iFI73p/Kcjnq71gUCl8R0yHkPCSG2AEClK4YcsRqXgNzFes1U?=
 =?us-ascii?Q?dHDjGraH6G9Qny9MbhsN4HKWDZDzgG+lIHvMM/odDJ/TWJgF4y8LvaUqXmTC?=
 =?us-ascii?Q?j9RRZsxlUykSYGtSZD57KBz0olCLRnh9EDXTi0vtF9vCCIpRBh58wLTeB2M+?=
 =?us-ascii?Q?qAx/5Ebtg+G3V4UAm1tK3y2+0smRwCR/zYrQPBHiI6PBetI5P6OttV21K+Hr?=
 =?us-ascii?Q?+KialtSBZ0PLqRe2s4T4yYhw65SONOXS3gRTyJies9/a+doE0qCv1fNHg8/4?=
 =?us-ascii?Q?pphQcbUtBMzgNn7uv6GjkMoFA+WmtKmJkYBNot6ZSkFtbDZa0Sc8o7m05xQb?=
 =?us-ascii?Q?NWM//4HWra6h+FAti3Um4rg1j+tMDQXxgqdhGYyog0kd7+NYwJQQGXyOCZsi?=
 =?us-ascii?Q?K/A62KFflsRwph35GtVN9H+QUWd00eb2WKtS7RamO1SZuMAkIsyJ3fwKS9cY?=
 =?us-ascii?Q?iA0330jVVwgfA3JpiRrKoiysI/CVWAWfJHYhnnp3DutnvK3pn3Ampudwgu2F?=
 =?us-ascii?Q?ksO7k+YDSNPWNsBWWJ/EU9Iffd0zI6RGgNuUfikRi1U2xWmHGH7lpkxhlBms?=
 =?us-ascii?Q?im7XA+Yyerz6ReAQSpaltUZ5W28JKEFw33iZY+PZxo3IZnIwfoFerb6PoCZl?=
 =?us-ascii?Q?tEw9uWzvXoBp2lqpLSPSdQHZNI4eLCrKzhC9C4pMSjHy7iRRDjIweI9A9Tt2?=
 =?us-ascii?Q?MdNupAe4pPHEYqkyHR4XX9zoaGdOE4SLtSSYHMw6fvtrR/MFNQ8j7Olx3JUs?=
 =?us-ascii?Q?JWiyhuNsd4Uu4coOCA4L4nEJyT3Qv+twVXUGEmfNCgLM44muJBft5HsP7DqK?=
 =?us-ascii?Q?TGjF3JSkPrLbZNr0dNO3SrjrSJBOKaZDZd33SYqfItQod0VByOfcA8MyFJpt?=
 =?us-ascii?Q?nVfwsk9ezDmYXS9FOy+ACmqCLNKRv0cxJz/MdohTEsrCYTUz51ldYs9CoIt9?=
 =?us-ascii?Q?hcg/tkz4A9UMrqa0ciu2kpalYht7NPnZpYMehFYeiP6yxmJZG/0aBcIXtxfc?=
 =?us-ascii?Q?wlqVY+nvNp++raNTAnRHVUTBzBHmExmqZq3GQ7s7NQdN+LxCfadc/lbCjD6q?=
 =?us-ascii?Q?EVPYcL84pc8+8dfLaF/CWgugtM4rm+yDH/2OmUEN7Bo2fWR84g89MF4fn/D1?=
 =?us-ascii?Q?RotLjHlW9y3ELPWBdsKdTiQi2fh0KioYBPH1zME9m5xkB3Bedw7A5Ojy0SAv?=
 =?us-ascii?Q?BTMjfju1WH/m9RGr7uvjBH4d0q/UgStzbDnsTJ2S1FkmhA1w68sAlYlUO8H+?=
 =?us-ascii?Q?/zVNi89Rx4/C+GPG+KE/erY4xnStaSnBC3IDbMwt36mplpKp0+bOV4B+c513?=
 =?us-ascii?Q?IJ/xxAbea79gdIQilvICZ6Lpvf4ipudBPUS6FhoVXYRBI0ETEBvtYo18S55g?=
 =?us-ascii?Q?fKolMwFuEISQPeEpHPPVcGol+hvt565dhMp1zdWWFhS/DvkPcAWeXl/thXq/?=
 =?us-ascii?Q?2trJgBcv6tV6UTY9CZ2kKYE7rlhpEn3mld2V9vzl5f7I+ZELgbFHJ1izLC/X?=
 =?us-ascii?Q?fKz0lA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	McKy/WstUlkihEH/pf4YA3bLCSSKaRCUqpSGFnxLREBE5d8ZteAAH40P6opfjERHmCbxx6ywga/Zi358wKCfYZysSs7cXmc0WnB0cf/M6fQWtvzOZBHHg5FjczAxLZy/8Mj/bBSGpwvWfc4YG6fZsuFX9jONjwEz+uFSS1eykF+ghbSQRu2CfbOswK2DHAkepf/BAiPV6KhK8UV3YkrXR22uMDobY7qrhSgxD4KrtIx7lesJ+N9QU3WD2kvCMw3ODQbmUeXdK8IwjcprI1RpR5QOzrg3n67kDAyi9U0nc3XM9k/W2CGpVjTvAjXpd5/VlAij60TE/8gFsvYZo6dtWZtLISFtXiLvD3IUKcPIgHJoPIMht2wpmDi3eIpCw3ngMvH0bNCSIBpj1KlSQW7AYympS1Va0i6TlFSGSJLK49sDlYuFZI42jUPRYJ0KWIjK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:22:59.4785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 837cfdf8-577b-4a7e-44ec-08de6d13115a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741

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
index 004226b52ac7..32e6456cb5e5 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -493,6 +493,14 @@ static void perf_ibs_start(struct perf_event *event, int flags)
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

