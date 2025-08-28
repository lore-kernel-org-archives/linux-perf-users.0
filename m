Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2139.outbound.protection.outlook.com [40.107.100.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CB1271445;
	Thu, 28 Aug 2025 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756420545; cv=fail; b=U3tjzC/4VW+fFuwmNKXjj1ntubK99L2uQecNFrqiWg/KmiNT7kFwMcx7iaXqoPAyfntqRaakNxtb7OuTUAKBKMWoYDW6vA/0hrQKE97G1lQSJQoBqGkkrAsc3LFHP4aOHnt3d4YDXygWS1YAASD2nVGb9VALIlDhB7lI036qw/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756420545; c=relaxed/simple;
	bh=6Db03154QkdAmw2l104U9zUt9IxO2wFGJi7bulAfjsA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pYRV1isKafdkrS107cTW5ugTDcfd8R0kd4abuRKcQxN7ojTv1aUQ5SYwuP+qao3Yg+UbYqtXdQMnk9N5oMr1CT8fGS5nyoM6Wc7/zd8t81ovtHIVk3iyQ9xsPYQBlj1z3SIUFmJ/S98HIIfuxv6UDvsmvbXW8V0gXrAt7DRCYIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=VybZreou; arc=fail smtp.client-ip=40.107.100.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VybZreou"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGaeBIeDIZ77xEIs2PwYLk2yNSGVevUXNn8QyZ4cO3ZdTA8cict7mPHvXc4vhHiLVCH1HWiszAJ5NgdvNYEsYDl/HeG6mAFaYyNd+HxOQZgKhCAoHSA3FediVIKbdsi4+cTE/+pZrZjdRDX8gPaDTkmTvxVWJLpMwzspPYisGmL/61suIpI9WYmwwEnfVZ09j09+giTzJnmZOK+xcuNbwNx/QGDCSOKtS0EQWRfSz0rqreuKgT2Fg1he4GrdpSQ1rPRP+C5rxx76KXkrbvPkNgBfPdMMKRfX3ypAJqP7QaoalwZxOWS0jOs2k2fbVOv5K9CPhkFGsvkpI4ocYqkQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzdjbjGRcdQ8wf1stLvYxHbH2uAdDn91wiquywga2Ow=;
 b=neSfoAObUhdqRxtSyFpDF8WGF9ruF+uzUTNnlBnRI9Bx9W+yK7u59W/caX81lEMBeG44bfp7bKEmj2ORA7zzOkwLJ07KdtR7Z7fmVlxR4MWqkvd2hZeA3lnYzZujXlVeQDV1NKC44gE0f1RdsESe2r7zllMlR7Yxd3VvFtFEM6fgikSsi9qvKJvFb4BaMNPT5Ss6INb0tOTMDGaCKXolfnXDuxjlbS38pIWrDq2J4FfJSfNXlwNk0K+YN+491VZKbOzEsOHctcYewGoiOEkSg/yKH6pwNDhl1SpMmUPtxGtTQW41Vh+4o/AJ+jIXMRSxkrHgPUzI3QYarTrCCXIeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzdjbjGRcdQ8wf1stLvYxHbH2uAdDn91wiquywga2Ow=;
 b=VybZreoulxm42h0ZTdSuuEIL8WSWtaBmU1Zl9tmAVhzKcDcTDlnz8gLzwN5ASjmN+5576VAX2i1Xyu4DUwFH+XQWvWGGRGMrhamlGcopQaUns+Atc7PZY0VrwDdn+XRJUWRF56GF4foU1RI1J7/b29HtImMHxq+XiZjW59vkUPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 LV3PR01MB8534.prod.exchangelabs.com (2603:10b6:408:197::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.13; Thu, 28 Aug 2025 22:35:37 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%6]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 22:35:36 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH] perf/dwc_pcie: Support counting multiple lane events in parallel
Date: Thu, 28 Aug 2025 15:35:19 -0700
Message-ID: <20250828223519.2812844-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:930:d2::29) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|LV3PR01MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbe8257-31e0-44af-67fd-08dde68334d6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gewV+Hnqwy4KZDt2+XQ/aP8KG5w3h+UCJVPGBRpAA4UYeF7hFvlReep+bvJY?=
 =?us-ascii?Q?EzIpa0REJbea1pQyGxqQQP5ZvZyoCa7FGw8Zl+u7/jwkxCfhH8uBhvaVQlRo?=
 =?us-ascii?Q?x+uXnxb4prBErxXUU04pIEqk46nZ8jPJhmNE5As8phI4u6rP+7tsXm/R3at4?=
 =?us-ascii?Q?mCuweaD7yDMxdpp46/aRjKgy0vlaFa9aO2vrILP5Ev53UfaCdyZ7jvHFNJXn?=
 =?us-ascii?Q?ewb65hBkSk7MV1d/8iOTIoy+a2uDXJ6X9N3ptKdTnprxUdYAbh4cVyXxbe92?=
 =?us-ascii?Q?CgLGzUCs+08GSV/5PgjcKav3eMch+4meMjnOaOsSDVa+iH6+GqulcfIWqFmS?=
 =?us-ascii?Q?Xnk7ESVmMeIZJ9mCuWsmh0lg5ssS1zakPyFqxUW//rvwPB/qsu0LpeF7mhZI?=
 =?us-ascii?Q?19pQCjR3XHpf34NawjBuW8GV+NDIpLrrzhC244N2UxZSdwOTu3rVdTLhhGOS?=
 =?us-ascii?Q?562u87nW8bCuemUSLmhrPaMlD3pe5Pqa2eb/Effs3dJcv98RX2YCrXBOYoo4?=
 =?us-ascii?Q?q11/Bgdxr2brTkDKHUL8py+brY+oHrlwUTHPdlnXJlckDai+ajXS+dR04lug?=
 =?us-ascii?Q?NGLm/a28h/aM/swEmKMys4Va72kAJuDeYAUbLyya1QJMRXajs0gFIqEh1Au7?=
 =?us-ascii?Q?qK6viq6T5c0ZQOoBM8V9qQhuSbaY3xgDOvrhGfH0I+lR3Nb5PDAay0B9xc0w?=
 =?us-ascii?Q?eoRk8m0OO4SDyL+qnvs/A9N0fmvzBhFaGmvsLcx0CGdkGjzcM86c9lMZlJ4V?=
 =?us-ascii?Q?d7RFcU3EiCGcqWSb7Ovjh0ac4B/OWe8D9mWxLJLORausbPbC+THYkrFlt8Ko?=
 =?us-ascii?Q?eFOvXQppFjR6ObPyYVgKhF2R4x+EsoaH95JE94F5/3dHkB8UljR9raU21gtl?=
 =?us-ascii?Q?4AucBSIms1onhYyQ4aIDOCMp1OMZflboZdkzilPfrBIB8TPCSKUwZI3eIVG7?=
 =?us-ascii?Q?Rp9ohqMNq0oc+NwFFciD2UexN32xn6BeOkWYok+S5Ym4vxe59jmWswxKoSTv?=
 =?us-ascii?Q?SxW1ctr8tOhCHgDR0LSatDZJrPQCnRBHXYVPdMuK9ZawZbbAvHGk0ld4YDxT?=
 =?us-ascii?Q?NRLFo31a/BasMx+3LOWgj40oZZVaB5AKBtd+S/zNP1Y0CO5E7gK1lhLgv1Om?=
 =?us-ascii?Q?wxFzI0OG9mT36QgXNPaGq0ZmkyJPyous/jpeExlxbPmzSnL/hPl+btUYKl8f?=
 =?us-ascii?Q?rJr/TosNyQSA/1jsG7AJWU4LSnFESiBYt7ZlosfZnIXn8jMZi1BQUN9SMSDb?=
 =?us-ascii?Q?y+Yfuw+FTL2M/ggHSH6MrcWSkuW0JRSfl559QdJ6bT2CmB2Zh32km8RIOYu+?=
 =?us-ascii?Q?sV9f7pATJRDaWLYueK/EOvMPUsedavqdY1i/eIyVBsjmM+EWXd2UzTcidBH1?=
 =?us-ascii?Q?LlNX+JlHKeChDL7cYbcTGK/zAt5ZFKRHHZkYqh+ne0kQQ6VUW1tmNX6ZiMHr?=
 =?us-ascii?Q?dYWYtJd09Bs5XWW2Ujpswu+/+lF6nXnPaxb3+M/55yhpYF9ixl5jVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WS4BR34azxCM+guGJ+bpOn5DQPwHHD4AjNY2der/m2CP+Oz43MtdNGjs02of?=
 =?us-ascii?Q?CM0wELNGX/9TTkMTdkzKvgFUTnzDKKnmH7+nYp7q7qt8XHfz1dj0zz0TbZoY?=
 =?us-ascii?Q?FOXUdflxOQf8p9L8XVrzf2VHc3NKdo/ICMcuhDd4aKl74hzI7T6V6m7zUnwT?=
 =?us-ascii?Q?okpd/iITJOb8xnj5K9C5XMrponApNXa7UR2amwi8Ah1aKeb6mSkr50H0yB/A?=
 =?us-ascii?Q?TF+RIAY/LLmBHdpuCRtYXrBW/HSIMKL9Y1RGfZZA2u5BjubyrTkMDn3wC4dH?=
 =?us-ascii?Q?LBKpIlZ1X6qpkj/eA/60kHpLqIPHYTz0lA9QSHehwhZZcTuEe9ACibQvyoCS?=
 =?us-ascii?Q?UxBbTQYSZM48kUDU4fJsPHYYLOUM0I9EF00wGKeyCT3iAt7Sbd2r2YmvIchB?=
 =?us-ascii?Q?nsTZ5cooRsnbdFBlN8JbDPw0dXUNQ7OBk2zQa/yF91CY9MUEL00JmuERQUa1?=
 =?us-ascii?Q?hFBsrmfwwbcn+6KS+cWzmGVEZuq+GkKj648vAuVW2fVrdCK8K5fDA9IFyoE3?=
 =?us-ascii?Q?yncUzg7aKCgdH6o3VxrNKS3TyP7w43fJ6JC8mD5RWU2mOCzurbJYGoxDrdNp?=
 =?us-ascii?Q?IzndfAnIPa/NnB3qHvXakzpjZuZdq02EMN4SbI3n1pGhviB0Oy9lGp11LWCL?=
 =?us-ascii?Q?2mR4OuUseKgbtmkP8wn6kjx3D7JHGdI6mPT52gdmRaYqmvUfvy44HbrwFBdP?=
 =?us-ascii?Q?kC0DI1eLuztwklO1dNOPsdentzgydmJNUEuA4s4l+C2x9OoaH17cd9mLfgiQ?=
 =?us-ascii?Q?N4ZdkUsInkT83HEB/loWes5A+WX8DadwxYLvRHP9/5oC9lClnzDGsSLs4KPk?=
 =?us-ascii?Q?bNtn6sQJVB+Lo70/HfmJen1PbmVtwdiSRaw6NHrP04pwndws51GmuTGn1wU6?=
 =?us-ascii?Q?p7eYbhwVj4VQvkzX9mc3hfOWt9UL684Y5QPwdc22Bhgz9cUEwQ+XK3hzMbr6?=
 =?us-ascii?Q?mE8v+RemcLYgXoQ1/shjUgXbeZtwmVHMeeeUIS4q6AY2cu6K32vbmkK4qA42?=
 =?us-ascii?Q?BaUT1ujHI3LCu4PGqsU9ICy3e51J8jS2Aqgk64TUVOuG3YocgcKUkxGvCbKx?=
 =?us-ascii?Q?KGFiRm+pBXRMMfAKWOpoRcWxp94/a8yzJWHB7xQ42h1T4JM3z5JTZ9uNU0BK?=
 =?us-ascii?Q?NL3FC5i7rMFBZXKJbHqZSTlXLcFL7MXj5mwvzgSg/ty3aO8aVzsXK7PfFQP8?=
 =?us-ascii?Q?SxO36uCeiBCTyjkvTUDZuVzRRITf242Q4TweRRT2z6fV5epfxpT1SvkecHGC?=
 =?us-ascii?Q?Azn9SS3XKTYHv53Ym4H/epsKgoL4ILa0iF9SQEuADFQuwqsWzO+JigWbGFJg?=
 =?us-ascii?Q?i+iVNSpkssOWao+74AWtXnzUx5cq5SbPzUejTOKqWOzRoX2XSnVZ/fnrqbY7?=
 =?us-ascii?Q?kXs6p8xzgvyejy976QOfITDZoI7fsdritTyjegh0FoyP/QBhtlR8O8Pndxe/?=
 =?us-ascii?Q?fKGDuV9sTyt+MS8betUfPvwqyeTc2+qNPm8DVwS2EL7h8j2cK0y+MYH4tKnx?=
 =?us-ascii?Q?KA8naiAHiyJApf5Zb+dY7MkIQD78lu0edMSQMeC1WNKUaW1+0JsR8LweeIhs?=
 =?us-ascii?Q?zHNO/j7MLdnCMOIYghMMEsHJqJboL+eQPqec31+B53Ues1HMqBqcsssZRAhn?=
 =?us-ascii?Q?ED7Gze3d+J6SBaPFys0/0Xo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbe8257-31e0-44af-67fd-08dde68334d6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 22:35:35.9844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3mItIk88HyH49HHDKU5zi+mVV5KAtkTKZHECxfUAdh5f0tZ2Vhgzx8jsT5Bhz1xMHwGvJ4YYnk/YyfM08JwTTuh+ElcM8X7Mm7qKrpVuVgHvkwqL06e2QWbwtdzRftG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8534

While Designware PCIe PMU allows to count only one time based event
at a time, it allows to count all the lane events simultaneously.
After the patch one is able to count a group of lane events:

  $  perf stat -e '{dwc_rootport/tx_memory_write,lane=1/,dwc_rootport/rx_memory_read,lane=0/}' dd if=/dev/nvme0n1 of=/dev/null bs=1M count=1

Earlier the events wouldn't have been counted successfully.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../admin-guide/perf/dwc_pcie_pmu.rst         |   4 +-
 drivers/perf/dwc_pcie_pmu.c                   | 161 ++++++++++++++----
 2 files changed, 132 insertions(+), 33 deletions(-)

diff --git a/Documentation/admin-guide/perf/dwc_pcie_pmu.rst b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
index cb376f335f40..167f9281fbf5 100644
--- a/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
+++ b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
@@ -16,8 +16,8 @@ provides the following two features:
 
 - one 64-bit counter for Time Based Analysis (RX/TX data throughput and
   time spent in each low-power LTSSM state) and
-- one 32-bit counter for Event Counting (error and non-error events for
-  a specified lane)
+- one 32-bit counter per event for Event Counting (error and non-error
+  events for a specified lane)
 
 Note: There is no interrupt for counter overflow.
 
diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 146ff57813fb..d77f767cde89 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -39,6 +39,10 @@
 #define DWC_PCIE_EVENT_CLEAR			GENMASK(1, 0)
 #define DWC_PCIE_EVENT_PER_CLEAR		0x1
 
+/* Event Selection Field has two subfields */
+#define DWC_PCIE_CNT_EVENT_SEL_GROUP		GENMASK(11, 8)
+#define DWC_PCIE_CNT_EVENT_SEL_EVID		GENMASK(7, 0)
+
 #define DWC_PCIE_EVENT_CNT_DATA			0xC
 
 #define DWC_PCIE_TIME_BASED_ANAL_CTL		0x10
@@ -73,6 +77,10 @@ enum dwc_pcie_event_type {
 	DWC_PCIE_EVENT_TYPE_MAX,
 };
 
+#define DWC_PCIE_LANE_GROUP_6 6
+#define DWC_PCIE_LANE_GROUP_7 7
+#define DWC_PCIE_LANE_MAX_EVENTS_PER_GROUP 256
+
 #define DWC_PCIE_LANE_EVENT_MAX_PERIOD		GENMASK_ULL(31, 0)
 #define DWC_PCIE_MAX_PERIOD			GENMASK_ULL(63, 0)
 
@@ -82,8 +90,11 @@ struct dwc_pcie_pmu {
 	u16			ras_des_offset;
 	u32			nr_lanes;
 
+	/* Groups #6 and #7 */
+	DECLARE_BITMAP(lane_events, 2 * DWC_PCIE_LANE_MAX_EVENTS_PER_GROUP);
+	struct perf_event	*time_based_event;
+
 	struct hlist_node	cpuhp_node;
-	struct perf_event	*event[DWC_PCIE_EVENT_TYPE_MAX];
 	int			on_cpu;
 };
 
@@ -246,19 +257,26 @@ static const struct attribute_group *dwc_pcie_attr_groups[] = {
 };
 
 static void dwc_pcie_pmu_lane_event_enable(struct dwc_pcie_pmu *pcie_pmu,
+					   struct perf_event *event,
 					   bool enable)
 {
 	struct pci_dev *pdev = pcie_pmu->pdev;
 	u16 ras_des_offset = pcie_pmu->ras_des_offset;
+	int event_id = DWC_PCIE_EVENT_ID(event);
+	int lane = DWC_PCIE_EVENT_LANE(event);
+	u32 ctrl;
+
+	ctrl = FIELD_PREP(DWC_PCIE_CNT_EVENT_SEL, event_id) |
+		FIELD_PREP(DWC_PCIE_CNT_LANE_SEL, lane) |
+		FIELD_PREP(DWC_PCIE_EVENT_CLEAR, DWC_PCIE_EVENT_PER_CLEAR);
 
 	if (enable)
-		pci_clear_and_set_config_dword(pdev,
-					ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
-					DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_ON);
+		ctrl |= FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_ON);
 	else
-		pci_clear_and_set_config_dword(pdev,
-					ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
-					DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_OFF);
+		ctrl |= FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_OFF);
+
+	pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
+			       ctrl);
 }
 
 static void dwc_pcie_pmu_time_based_event_enable(struct dwc_pcie_pmu *pcie_pmu,
@@ -276,11 +294,22 @@ static u64 dwc_pcie_pmu_read_lane_event_counter(struct perf_event *event)
 {
 	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
 	struct pci_dev *pdev = pcie_pmu->pdev;
+	int event_id = DWC_PCIE_EVENT_ID(event);
+	int lane = DWC_PCIE_EVENT_LANE(event);
 	u16 ras_des_offset = pcie_pmu->ras_des_offset;
-	u32 val;
+	u32 val, ctrl;
 
+	ctrl = FIELD_PREP(DWC_PCIE_CNT_EVENT_SEL, event_id) |
+		FIELD_PREP(DWC_PCIE_CNT_LANE_SEL, lane) |
+		FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_ON);
+	pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
+			       ctrl);
 	pci_read_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_DATA, &val);
 
+	ctrl |= FIELD_PREP(DWC_PCIE_EVENT_CLEAR, DWC_PCIE_EVENT_PER_CLEAR);
+	pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
+			       ctrl);
+
 	return val;
 }
 
@@ -329,26 +358,77 @@ static void dwc_pcie_pmu_event_update(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
-	u64 delta, prev, now = 0;
+	u64 delta, prev, now;
+
+	if (type == DWC_PCIE_LANE_EVENT) {
+		now = dwc_pcie_pmu_read_lane_event_counter(event) &
+			DWC_PCIE_LANE_EVENT_MAX_PERIOD;
+		local64_add(now, &event->count);
+		return;
+	}
 
 	do {
 		prev = local64_read(&hwc->prev_count);
-
-		if (type == DWC_PCIE_LANE_EVENT)
-			now = dwc_pcie_pmu_read_lane_event_counter(event);
-		else if (type == DWC_PCIE_TIME_BASE_EVENT)
-			now = dwc_pcie_pmu_read_time_based_counter(event);
+		now = dwc_pcie_pmu_read_time_based_counter(event);
 
 	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
 
 	delta = (now - prev) & DWC_PCIE_MAX_PERIOD;
-	/* 32-bit counter for Lane Event Counting */
-	if (type == DWC_PCIE_LANE_EVENT)
-		delta &= DWC_PCIE_LANE_EVENT_MAX_PERIOD;
-
 	local64_add(delta, &event->count);
 }
 
+static int dwc_pcie_pmu_validate_add_lane_event(struct perf_event *event,
+						unsigned long val_lane_events[])
+{
+	int event_id, event_nr, group;
+
+	event_id = DWC_PCIE_EVENT_ID(event);
+	event_nr = FIELD_GET(DWC_PCIE_CNT_EVENT_SEL_EVID, event_id);
+	group = FIELD_GET(DWC_PCIE_CNT_EVENT_SEL_GROUP, event_id);
+
+	if (group != DWC_PCIE_LANE_GROUP_6 && group != DWC_PCIE_LANE_GROUP_7)
+		return -EINVAL;
+
+	group -= DWC_PCIE_LANE_GROUP_6;
+
+	if (test_and_set_bit(group * DWC_PCIE_LANE_MAX_EVENTS_PER_GROUP + event_nr,
+			     val_lane_events))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int dwc_pcie_pmu_validate_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+	DECLARE_BITMAP(val_lane_events, 2 * DWC_PCIE_LANE_MAX_EVENTS_PER_GROUP);
+	bool time_event;
+	int type;
+
+	type = DWC_PCIE_EVENT_TYPE(leader);
+	if (type == DWC_PCIE_TIME_BASE_EVENT)
+		time_event = true;
+	else
+		if (dwc_pcie_pmu_validate_add_lane_event(leader, val_lane_events))
+			return -ENOSPC;
+
+	for_each_sibling_event(sibling, leader) {
+		type = DWC_PCIE_EVENT_TYPE(sibling);
+		if (type == DWC_PCIE_TIME_BASE_EVENT) {
+			if (time_event)
+				return -ENOSPC;
+
+			time_event = true;
+			continue;
+		}
+
+		if (dwc_pcie_pmu_validate_add_lane_event(sibling, val_lane_events))
+			return -ENOSPC;
+	}
+
+	return 0;
+}
+
 static int dwc_pcie_pmu_event_init(struct perf_event *event)
 {
 	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
@@ -367,10 +447,6 @@ static int dwc_pcie_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	if (event->group_leader != event &&
-	    !is_software_event(event->group_leader))
-		return -EINVAL;
-
 	for_each_sibling_event(sibling, event->group_leader) {
 		if (sibling->pmu != event->pmu && !is_software_event(sibling))
 			return -EINVAL;
@@ -385,6 +461,9 @@ static int dwc_pcie_pmu_event_init(struct perf_event *event)
 			return -EINVAL;
 	}
 
+	if (dwc_pcie_pmu_validate_group(event))
+		return -ENOSPC;
+
 	event->cpu = pcie_pmu->on_cpu;
 
 	return 0;
@@ -400,7 +479,7 @@ static void dwc_pcie_pmu_event_start(struct perf_event *event, int flags)
 	local64_set(&hwc->prev_count, 0);
 
 	if (type == DWC_PCIE_LANE_EVENT)
-		dwc_pcie_pmu_lane_event_enable(pcie_pmu, true);
+		dwc_pcie_pmu_lane_event_enable(pcie_pmu, event, true);
 	else if (type == DWC_PCIE_TIME_BASE_EVENT)
 		dwc_pcie_pmu_time_based_event_enable(pcie_pmu, true);
 }
@@ -414,12 +493,13 @@ static void dwc_pcie_pmu_event_stop(struct perf_event *event, int flags)
 	if (event->hw.state & PERF_HES_STOPPED)
 		return;
 
+	dwc_pcie_pmu_event_update(event);
+
 	if (type == DWC_PCIE_LANE_EVENT)
-		dwc_pcie_pmu_lane_event_enable(pcie_pmu, false);
+		dwc_pcie_pmu_lane_event_enable(pcie_pmu, event, false);
 	else if (type == DWC_PCIE_TIME_BASE_EVENT)
 		dwc_pcie_pmu_time_based_event_enable(pcie_pmu, false);
 
-	dwc_pcie_pmu_event_update(event);
 	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
 }
 
@@ -434,14 +514,17 @@ static int dwc_pcie_pmu_event_add(struct perf_event *event, int flags)
 	u16 ras_des_offset = pcie_pmu->ras_des_offset;
 	u32 ctrl;
 
-	/* one counter for each type and it is in use */
-	if (pcie_pmu->event[type])
-		return -ENOSPC;
-
-	pcie_pmu->event[type] = event;
 	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
 
 	if (type == DWC_PCIE_LANE_EVENT) {
+		int event_nr = FIELD_GET(DWC_PCIE_CNT_EVENT_SEL_EVID, event_id);
+		int group = FIELD_GET(DWC_PCIE_CNT_EVENT_SEL_GROUP, event_id) -
+			DWC_PCIE_LANE_GROUP_6;
+
+		if (test_and_set_bit(group * DWC_PCIE_LANE_MAX_EVENTS_PER_GROUP + event_nr,
+				     pcie_pmu->lane_events))
+			return -ENOSPC;
+
 		/* EVENT_COUNTER_DATA_REG needs clear manually */
 		ctrl = FIELD_PREP(DWC_PCIE_CNT_EVENT_SEL, event_id) |
 			FIELD_PREP(DWC_PCIE_CNT_LANE_SEL, lane) |
@@ -450,6 +533,11 @@ static int dwc_pcie_pmu_event_add(struct perf_event *event, int flags)
 		pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
 				       ctrl);
 	} else if (type == DWC_PCIE_TIME_BASE_EVENT) {
+		if (pcie_pmu->time_based_event)
+			return -ENOSPC;
+
+		pcie_pmu->time_based_event = event;
+
 		/*
 		 * TIME_BASED_ANAL_DATA_REG is a 64 bit register, we can safely
 		 * use it with any manually controlled duration. And it is
@@ -478,7 +566,18 @@ static void dwc_pcie_pmu_event_del(struct perf_event *event, int flags)
 
 	dwc_pcie_pmu_event_stop(event, flags | PERF_EF_UPDATE);
 	perf_event_update_userpage(event);
-	pcie_pmu->event[type] = NULL;
+
+	if (type == DWC_PCIE_TIME_BASE_EVENT) {
+		pcie_pmu->time_based_event = NULL;
+	} else {
+		int event_id = DWC_PCIE_EVENT_ID(event);
+		int event_nr = FIELD_GET(DWC_PCIE_CNT_EVENT_SEL_EVID, event_id);
+		int group    = FIELD_GET(DWC_PCIE_CNT_EVENT_SEL_GROUP, event_id) -
+			DWC_PCIE_LANE_GROUP_6;
+
+		clear_bit(group * DWC_PCIE_LANE_MAX_EVENTS_PER_GROUP + event_nr,
+			  pcie_pmu->lane_events);
+	}
 }
 
 static void dwc_pcie_pmu_remove_cpuhp_instance(void *hotplug_node)
-- 
2.50.0

