Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180032C15A2;
	Mon, 19 Jan 2026 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845580; cv=fail; b=B70fXQTUt7ShQnEGVqwMMcbeS9nFBtbVQZ0aUApNOEOxOLT8LSRxoUk2BtvXzHqeT1sWtrihsXQkkE3XF8vFyp5DNIyqIgfNfDbs3lV7eUnBx0eRtsHIGxxk1Nwaa09MJzzbo1KU4h0EIchtFq3JvBJeXCTI5u/OFzYEkU7ql+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845580; c=relaxed/simple;
	bh=1ksHutykAyCAs3ZIxz8+aGwFZ5EHhlZ7Mcm8WTeuMyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEoyNP+0KlEiEXmZZNWnJK5iVuUlSUpUbJ2VveQGvFQ0fs+UuNPNSmCDnNMZHE08yGaBlAXkeWKtfPCZ4egfMdeCxlRX8OH/7KGNSeyYmr8AeZxoEFuhMmDcD5iiuOc8rhUo+i89dicnroJjqGnX9y6FuJcetZTbG9PZOO5mDZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P9nopaHN; arc=fail smtp.client-ip=52.101.46.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P9nopaHN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzREyyyGOGB+aCgOWcRLDEkw3gc/KWx8Ab1AyjWB71BQ2b0hJ+qnt01bNIeiU1ibyCwBUOKGZDXvPn0dhmXYggO0zll7JEZZ8JoRGRPhbBw237v8Ja1xruy2TV4FUagEvah3w0XKa4pndilQ572H+YFKEfk49MjSXGgsfHbF4gi4sCPb/ZxS4IYe3t427IbJPkHzZhOOPJB+Iwm8Dg1nPRA49eNxj3YnhElMbwIizjJer2qFFZi5avhgKN3zrsfVfOXnhLEFg5XDft7UxWsIycL+kkCh4zAUgNhZZT6bFdru5dwTpsgDJNSTifBzm8Z8rqU1tYnI8sOkU6NoC9mPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmfPCxHr4SSdqLB7mMRioZTXfR7oOdb555GIlHj+bgA=;
 b=eFRp1lHNMoL/CSa5wbMkagpv66WLQ0cV+/rPGoxIUyXPdHfyoJk1Qs9D2X9tfe7OxgWDREhEhABcONTAzZ5hUvvW9L4Z6OJycON+zmkcA1+LNGVYUQQFbDi1y1T84suhZQhXytvDAQOWHCugBxAsaKOfa/3mZJw6HmSHCHNLQ8OTc8eL4mxP4do7DcXSQRHVWSAaJ0f6oBx8kz6vs3L3FROddP27vnm107IfAPeiFHc3168f7FJIFUQkQE/lDdhhYJlqKQETsmxWF12snPdL5lmmI8pQeO1/OISfxVUin+DRrzlOK1xd60tqRTI22SWmcC5p+CsHW2WXu58aiijd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmfPCxHr4SSdqLB7mMRioZTXfR7oOdb555GIlHj+bgA=;
 b=P9nopaHNhkf2VLiSHAnWR0LRm1ItG5GoA2Qcuk1O/q19/MeWr0FT9qvl91GhtkmttL2gnecPNVXjiYY8kqNFvDc1wwIj/+Yu2wgoCFfbiH7zr82KnmWV9Af3FGcopvgAVMyR5LaiADLaj1NhlAjf6t+4mtfSe+Nn1HRXIRN8vqY=
Received: from IA4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::10)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 17:59:33 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:559:cafe::bd) by IA4P221CA0005.outlook.office365.com
 (2603:10b6:208:559::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 17:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 17:59:33 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 11:59:23 -0600
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <yu.c.chen@intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v5 01/10] tools/lib: Add list_is_first()
Date: Mon, 19 Jan 2026 17:58:23 +0000
Message-ID: <20260119175833.340369-2-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119175833.340369-1-swapnil.sapkal@amd.com>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: eae10db1-1bf0-48bd-6c27-08de57848052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c28fNMiEpoiOA93ge+MA144cftFR/qqxZfsgKlBjxMUEDROdZ0vIpBYPdM2V?=
 =?us-ascii?Q?6JwkeNywHL7zgBdWkmlvccvxaedklBIS15EmusLoiJ0Kv6ARd6bHnplS/KiY?=
 =?us-ascii?Q?M+V9L/naJz1vb2/Xhsw0RfHwz4D9EXsmaAHUAzWZG+HiOBbeinGi1iwOPsVa?=
 =?us-ascii?Q?RSLL1U5V27KPLjIExiAhIDLJ6p4M8lpyfQbP5NJY1yGSr3BwUTiVLdmtDrcq?=
 =?us-ascii?Q?WdUYKgq5ndShp+93fld2P/RBSGvNp+e2jeCV4aJg0duktbcavhlq2nYPrkeZ?=
 =?us-ascii?Q?mr6b5qglKke6bQedqZhV++FENUOL1T1bCESHYNncMI05smpOrWcPqsJUn90T?=
 =?us-ascii?Q?qkZzzi0ODsylsyrW7k3+tyDW65G8fry+Uwbp/5RJh0Huh9qRl8s5T+LuicIr?=
 =?us-ascii?Q?yo3ssHQGoFjZ1xuSoSn/iGSEq0ykhID+FkHYfSLIQInMzEVQNImOCVD6cFxe?=
 =?us-ascii?Q?GVjozLOrO3upb3TM+RXTCsOzsVZkOnICx+I1dGNkHpXXmmFDi5p43xd1M0fk?=
 =?us-ascii?Q?YgwFzJAeH0E8vZrIM13Sjm4WYG0Hph4gzZko23NjdPEPANkHLD4dIUCgNLnm?=
 =?us-ascii?Q?DG57iDlCVUQPLNOZ43+mvrXjiAXpWfqDOi92n/QHXuuavYRaIoRQaEPdUFxo?=
 =?us-ascii?Q?9mLujDTlq+8kz8a09HqrwyYZMNN7b7CVoBCZG6ZoUU7KuHIb3GCvlzzKUnd2?=
 =?us-ascii?Q?DL5SCLWH6Ki3CUqf/KWAYFU6jyZWQtlO7ypgBuCnv6FYCWVb3BsspICXnEbu?=
 =?us-ascii?Q?1NXlUmGFhVZvfeS73/+9tITkNx9Vfw76TOheUuTYmXzo7dZeQfTun+xivMt3?=
 =?us-ascii?Q?bPR5KtZwX97RfU1wX07h4xvruQTPqRbyX3+QmwrpxxJwM0pVaYarpjlfZd7q?=
 =?us-ascii?Q?fbQBZx6EwP7JSMxQuI5CA7dYPPEA+9gXBmiav1JPdPdHfCInu/x0qv0jAqmT?=
 =?us-ascii?Q?49em3rgkaY85Tgu8IgwOhs4RTHEUYauWzpeAXqy0tQ2dQN9CEcgrLhwZojse?=
 =?us-ascii?Q?hyE/FmIn2p6TvMstB1JMAJQA+PHJZLhN19oOMzPmxbaR3sKuva+Ro4eIhJb4?=
 =?us-ascii?Q?FR/Ami7+KhwYGwMQCuVnDS7Hd5yblkQ1c29SagEiwyIK7JHqkcGvfRokIHGc?=
 =?us-ascii?Q?Sz2uxL07GjbDZFDGoGyoZB3/HLIYpRgnJZd+uYadqOhTkA87O+btWrTPqxD1?=
 =?us-ascii?Q?kVYx3/NaOPf3fkySN4cB9a06vdbNp8RVRoNcG+3MQFeJmrIvJ9VSubOU+YSZ?=
 =?us-ascii?Q?JOMaicZqsbco8NSFSwcGKV4gWBGFBO5D8jC1ys3wDEdIO0TgQw8MkiV6/lFp?=
 =?us-ascii?Q?QQ0RfOON6DwrWeSoLlexy5BVLY15OXN0T3gNWw2HS6AhUc8pPi/aT9uSO4t+?=
 =?us-ascii?Q?ckilJ1BcqCVf2IBZf5S2LUjf7/8MHpOxLWByAxGqHqdMovqPoF9Yy7SbH8If?=
 =?us-ascii?Q?2CvjZlHGbgKxHjLidPeHqV9hdVbt8s82cNBaA+ZS4Sa7cts/zg2jqR+gfp5m?=
 =?us-ascii?Q?2W67py/GMui36GuC3o8AJ4i3GTFqUK50wA0E8BoKXlxxlmkn6poCYs2Ehle8?=
 =?us-ascii?Q?pBLXqfM9VooWOQHxaf/4LgyAKsj1Oo7xK/mOvzfBAS8kf9TRRvLtpj3/R26t?=
 =?us-ascii?Q?uYSaLMatjIcRYLunL19zUuAfckmoeq1wNXJG240AwYMQVKSCqPMqTAj+UgDB?=
 =?us-ascii?Q?Na6gyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 17:59:33.2940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae10db1-1bf0-48bd-6c27-08de57848052
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729

Add list_is_first() to check whether @list is the first entry in list @head

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/include/linux/list.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/linux/list.h b/tools/include/linux/list.h
index a4dfb6a7cc6a..a692ff7aed5c 100644
--- a/tools/include/linux/list.h
+++ b/tools/include/linux/list.h
@@ -169,6 +169,16 @@ static inline void list_move_tail(struct list_head *list,
 	list_add_tail(list, head);
 }
 
+/**
+ * list_is_first -- tests whether @list is the first entry in list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_first(const struct list_head *list, const struct list_head *head)
+{
+	return list->prev == head;
+}
+
 /**
  * list_is_last - tests whether @list is the last entry in list @head
  * @list: the entry to test
-- 
2.43.0

