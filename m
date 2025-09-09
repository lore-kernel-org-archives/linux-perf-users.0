Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D73322A0E;
	Tue,  9 Sep 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418270; cv=fail; b=p7oZuhNaq1U/cc9b/Pgc/LNCxocJwyevZEjLhI1c60Mk5naER6PFjyUkxjfWZcVHc78rCXWgftXENLyc09A0Fz7SEauKsOJvYDT9xZOc/PuPhcHeFfKPO3jQO48B9+s3olSsQKkfUXRtWDXiq3l2g4B441tmun03mOa4R7pRbFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418270; c=relaxed/simple;
	bh=1ksHutykAyCAs3ZIxz8+aGwFZ5EHhlZ7Mcm8WTeuMyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9pL70SW3KMdupwetEHQ9KNQKcBldEUwldrdQdzu0KBRCFMnYo4+/cFsphhOfoD10QnDpzTS5GaX4gxORdfbdCRQetVuKfwaJQs5pWvfoN1xbtEbq+b+2oH6qypDVHBE1ybgaW1VHXOcLBz2OvRCeSVPH3Bz6f+uQnjrNkrXPWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nfnn0xBT; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nfnn0xBT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWxQg5H4m//TKWH8cN6DIJUAY18yjMN7CeZ3zOHSffoEmqHNG1z7o4YTMpHPQtkc5xFU59wLcDQc/d+yiRYom9ODfLkeqw00G9IDDAeL8XKf/cuecPHZ+hQnxHQklAsHwk7zyvwDGUaDEtrBC9IyO0RM2Wf/7mDLK/xoV86brQtEI8HN4FTAm7XhEOjE/SEVBer14VWBB+aU4W4Jr3eBJdfiG+CVZMmVqfdrFIgO7QwdgMX3hLSaX22zMWhh2efa03gulr1RyUFPIZtnP+OScGq/GY6dDCDCmHFMDipmNn6Y34xIpZRk1bd2n/r28j4CivicEGo8beeKY69su8zXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmfPCxHr4SSdqLB7mMRioZTXfR7oOdb555GIlHj+bgA=;
 b=Q7W1B87n/cPwkSoYksf2zzmnDNcOosDSdV4xC5XDKAkMblUfR6qIf00eCnyGOe+a06sOg66/H8a1poNL8zSZwEXXWbPx8lNL3SErNlWjekvcWKCvHC2cj7VGCw6cayVX2ZkciWJWp+SBT/RzO6r7CjxZPuCZKKxeyETA5VcMuC0oV1jDZHxa0fMyO7/o1JvRLVztyGHQATmGBGtFaWStcFYwS0wRWqS+QIdOLanDi9jboS3piGcmjaZ6SUGe/50PH/2KUtTSNwsE5YAiOBBsNfm0pQ1opyqs22Que4nHUfh3vP8g6trfJtc1963ylhkRJQct1DdBRUfhdUv2rx+k2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmfPCxHr4SSdqLB7mMRioZTXfR7oOdb555GIlHj+bgA=;
 b=nfnn0xBT1XSkXFkARcHOZov/dsGDxKV5YAjAiaihded4KQB/OFU6xqxSytRsXpYNMERjiY4EWK7IU7VXAfxvSSQtPw1jht74bDwClp1jbpfF48yXFyJ+XQOUCKpusuDdmiSqE4Rx/sSRnOgR4I75tiR5gkeROoEZUH93x8aTDvI=
Received: from MN2PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:23a::12)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:44:26 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::34) by MN2PR03CA0007.outlook.office365.com
 (2603:10b6:208:23a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Tue,
 9 Sep 2025 11:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 11:44:25 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 04:44:09 -0700
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
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH RESEND v4 02/11] tools/lib: Add list_is_first()
Date: Tue, 9 Sep 2025 11:42:18 +0000
Message-ID: <20250909114227.58802-3-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909114227.58802-1-swapnil.sapkal@amd.com>
References: <20250909114227.58802-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 756fde27-2158-488e-7523-08ddef963a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g+bx2cEsmHokvfGCG5BNB0yM/nslAgn2GHCXijRFZqSyUw6UVV6mqgtl2Ncr?=
 =?us-ascii?Q?iYq5sqRba9TUIsJTuviRsWYYxKH9OqtK3exJzPiMz1DXOn8RADT/5L2Mqk9E?=
 =?us-ascii?Q?TYOHz+UUGAVJyPzZE0SQMeEnhp5DYWjKWhWY0FzVF/IlN88OOEgvdjqZ6rn0?=
 =?us-ascii?Q?bPfrdcmcqwWXUtZlndeYX5nbg04MiVvR3Ochhseh+u0PAbejY5/GuWKdEQxS?=
 =?us-ascii?Q?75g1jXkGbCHhiLhRs2ghzj5zOKeIHBbdd121S/qADBEVbUs2wBOR7wTOkQyx?=
 =?us-ascii?Q?3z9aayLwsWD0IM/j4s9/5oOD2UR7aPW5CWo2T0rdar4njbnBoJlPjYo83geo?=
 =?us-ascii?Q?rxLkwxbsePFSVMgdptLLXv40wbaRqGNhBYFhtsbc+RDX5s7binPKAWRNgO9j?=
 =?us-ascii?Q?P0NsbzRjq6+pY6GJL2wMYDNBbZ3gP1ckCG5Ituke7Yz/mvNf4C2UYjYa34CT?=
 =?us-ascii?Q?nr3hgy4ezHNrHC8FkkhkYg8cDLgrtNk+9uo3t28xBFCt0PvQ15KcLuSujOzi?=
 =?us-ascii?Q?/GlUD8u/P86iVYEAh7T7R3WPG7TddPiysvi3txhWJBVeAeP0XJGgM3whTSS8?=
 =?us-ascii?Q?kqZgQx4zHGtZq85ZO0AoyUHVbxXVJ+adO2UpOSTIqEbM8ShsFa5k5FW6mdBx?=
 =?us-ascii?Q?6ZOiknPJENDyip2qqrHtHJpoAkYMDsaaBS3xN3zXpcjt9avT/++JX5Dr+15/?=
 =?us-ascii?Q?yy4PFQa6aDn1kHeW0h3htpnz8zmEAJqnhxL8SylUrRpIPuYI5jxauypyyxh9?=
 =?us-ascii?Q?Imljw1xFWphR4A0tJilHs3e0SaN4FLxszSsoavLDaFFtdDnUrNT90BTYCXdh?=
 =?us-ascii?Q?wGDAwSjD/B1is8pYQ5KvnUms7rb7bpSC2ZRIfgLrbbiDJ5WGSmUnVgVjhDCX?=
 =?us-ascii?Q?KZYBYT1gwPqsAP62fG4DbkOf6sRpWv/6b7daDR8F4Tf2ravNGFJVb9bj6P0l?=
 =?us-ascii?Q?Zu3BBvJwIC60K75TkJ4prS/ElJKaGhk8OYQDqyVG+ftl4JlfikT0EaCZ/Gb5?=
 =?us-ascii?Q?qAPKdCzeTEDpoZappDKpK6yblQO1fLBEMHWetJPA6yUukN0D2C8XVloii3jG?=
 =?us-ascii?Q?x2CtQ2t2XTT+Lacy3IHSys3dqYRAmIYR1pmgZUflndC0LAiKEjtYtNKXFBTJ?=
 =?us-ascii?Q?aZmtaSh6knhXJuco9Ft6Uh2i/7Xt9+XV6gn9i2pMy4IvfpL9TVAqIBTuvRpA?=
 =?us-ascii?Q?5ktPPZ5vlzpnZ2ccdUJ3LKAxUwbq49nl9gcSV6tE+Z5ezMab7cknj8W7sXA3?=
 =?us-ascii?Q?vjSTVEn6NB/cvSRPjOzlpAE80u4huhEaDENddAGdx2sPqDC0cVPExrY7+hXP?=
 =?us-ascii?Q?CxmoWJUR2oFVtL1gTTWs/WqZTEHvXSMmddQYICGsGJZgorxV1q/8S/7q0S+a?=
 =?us-ascii?Q?v68m+8n4AJJJ7BJz8UhLlSsT0cBj+HKc17FJLugf3KY1VUSWHpNYwm+4HPEs?=
 =?us-ascii?Q?ZdudmRVzZGAM0r7JAAzJJIYrZV5EJZ+IGzECFfNEQ4yA/7s/orETHeT7cKYW?=
 =?us-ascii?Q?z8fRrvjguZPyXPnM2F5PnFFRBy7fMwshrzRw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:44:25.7561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 756fde27-2158-488e-7523-08ddef963a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242

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

