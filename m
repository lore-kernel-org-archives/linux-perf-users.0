Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739073B42E9
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033835; cv=fail; b=XCNc0InBWnbr81QrFhO6TNFSwtpsOXbE40RW6xuYbRP/fk9o3CROzYb5pBbe80/hJhkSwgZUgjMQznWlYAq2tLALgJ7lk05YgY76iN0zWDaq4NpQ/E+Ck8Yf/3eI+mNy/SUfREk3t8X14c3BnsRnKIPjak2InBkN25kvWFbcGlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033835; c=relaxed/simple;
	bh=UZyVaPDPqgrmNT2UnHPpqh46KxerVHXKdFKb0pNY268=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuABj9jsA02njGC3mrswWpcLujsRNE9KrSaLpWROJDUgxAGvC8c6X1oowHaSIzq6lCowbdi3Z40vkPBQ0vYP+gIfBDK7E8khbOIKiAnK27txC2lwr27JhUs+n6UQE5ye1rIXRLPyp3p3sU4ZiQYWXgSlE5+6IzQbGm/R1C32fFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=kkTQwmpu; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k7LCz5LF; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="kkTQwmpu";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k7LCz5LF"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBhCpk2126481;
	Tue, 14 Jul 2026 07:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=ynYTujsRNEGlG68LJiuqkHiun15rVeEO109kpEAoB
	tc=; b=kkTQwmpukww7YH7y+/U6GC/yigyQ2RprQHYmHMq3l/KmVmY0Gbo13KDT8
	X2DX2tjkm5MsPGTn4/bbYyM53JRVmWHFAoDeHV4mz8Dk4ykI/BmAWjAKgp9upGjo
	Ldw+JvZcI+uWSjSxbsH3V2cZo7LlLBbOFaV8dNoawgZv2uBEpHoFdRsVGIPXqRQp
	AYVg46f7GZA27zfzYST9VBdZLiPHy3SkTMliK7Kwhp9O/dtH6bcHg+e+fbL2SHaE
	1q750zSTZwGfN36mq90Phr3zLtp88zT2Rp8bj4hgS0+/G4in29yw1bdSkLQohuB2
	BgDfB2GMI677DPxf+zeQeY5+JtJgw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fdmg30bvq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 07:57:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGJnvCYue6eHJwq/7oFq9B7r8pAul2E6YNMci47xnbnmPlUyePLJdOPtW/Euz9AW5yfTt16P2mXHEGj0soqxfyxRa50M6EyftH+N0mAESdAChmyWEsdo3ASvWwqRbH5Dz4IRSc1vk/U7ju8zYAMxqby61mF3X4HJr/2+iUf77zpmV15cwzSvnIg7rZYcogbPgE9mUX57UB8J3FscU8KgeRiGg1CO86fGmWHfhQ+IkBvWP8oe3QoKFF6McNC5nc/WxazX/8alBBYYVbqI/utuOxCuAtw0dNOUU661elPNfGBBqUrrvKzEx/KbTDtUY2guMEBPmaL7Xoydr0Fi2NJkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynYTujsRNEGlG68LJiuqkHiun15rVeEO109kpEAoBtc=;
 b=uRpw0I8rjbNOOzSCz9c3gtNaEj2kJXOq7zo6mwHOMTsVdQocf/wPMRWbus0pcEGitymS1hU0LNBILr6jYJtD0M4sulVYzQinvADjzFAlrOPqWpB6YY+Gna7P1zUzQ7CLcs4tlwVAnY8GkDZjLpyT5y7pzfnCMc1NzVtQiteWdDYLc8ptzhAGxiN0mMUCI30fANgCJh4RncK57Wys5OQfSlv0a9dbs5NjckjLATePLmhwtDV/Ki2ECIs9Xoxk1b5Xbsyw7tD+zZqLdWuJaCoIEjE0MDN1V2VsZPyLniqHv7JejW9Eh+1qa7b09sk76iCo2stnjVTO8kDLE7hym76LOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynYTujsRNEGlG68LJiuqkHiun15rVeEO109kpEAoBtc=;
 b=k7LCz5LFboVY+t4txlWq1Ca6qkaPWA/nnjIVi9tCN1wgZwCnTfdEvd6X/DJEghJDHMXFs1onG4FOBkDJKSIer/Z90tv3KDUNZTl5jyYK+vSVvQNGgWjfZDM5SatJ7fsy36ONRMADWc5OrfOSnDUwJIxFk3gnbNOEhUrt9nQu4UQ=
Received: from PH7PR03CA0018.namprd03.prod.outlook.com (2603:10b6:510:339::15)
 by PH8PR10MB6647.namprd10.prod.outlook.com (2603:10b6:510:221::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 12:56:54 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::1) by PH7PR03CA0018.outlook.office365.com
 (2603:10b6:510:339::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 12:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 12:56:53 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:46 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 07:56:45 -0500
Received: from venkey.dhcp.ti.com (venkey.dhcp.ti.com [10.24.53.161])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66ECuaH14165566;
	Tue, 14 Jul 2026 07:56:43 -0500
From: MANNURU VENKATESWARLU <v-mannuru@ti.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <n-francis@ti.com>, <s-k6@ti.com>, <bb@ti.com>, <v-mannuru@ti.com>
Subject: [RFC PATCH 19/22] perf/events: arm64: ti: Add AM62A DDR performance events
Date: Tue, 14 Jul 2026 18:26:32 +0530
Message-ID: <20260714125635.3304437-3-v-mannuru@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714125635.3304437-1-v-mannuru@ti.com>
References: <20260714125635.3304437-1-v-mannuru@ti.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|PH8PR10MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d37a17f-b6e6-4eaf-3c06-08dee1a76118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KvAp8pCfQZU+r6HHZY9Hyccpm+X7h2ewQvH36XhW3GypJPvSeLa+2sGTk6Dv7CnPEOv4F3iRfILQ/wdEVwP1SMFAZ/tjk0Y2kSztytNJWrpYyV8ZK5R0nyUCoqMIyaNvLPn1rT8R6qRtHzig5OfLX3aeoI+oBjP/dj65KTw/ptZW+WKlg8FOZ3ZYhMJo35DyWD8lp7I2pXgwaNwQpaztQs+LQZCsPuS2IdThz32weuLZ1hIi7VU2ST8C1U4Q6fTAVCm4o/QPmDApNaq0KmdNSCyIO/oHsjy3EjSryxMAdlREZGm5GNYms3H/VwTUO6NZxpNteotCYak3Yd4H/iQnhriMpu6GVpKpZi7t87naQF2R10eLXN9BD+aK2qQos8wTd1otJnHRlPam9SYyS51bk8ROw7UEfdBi9GSZY0SLfge7GloaYYojrwPpENYSvxGkkXwdASP9UVQdsFLOO31y9aA6lFIndSbj56xHv8YQNc0l1FnVTolntChBzmk2dXoES72JUXt9FMqf/DHEyiti3frq1NI1shsGF9HfByUJMlI/eS6gHoqLe9q0MLRQmcfxVmeYpQxtR3AM1SdFTUQpwP8N9ccMQnmIIgZOwFyLi8r2nMTQKgppAJJMD6qXUSib2ham4yhUQ9HYneleXVdiOpPUJ5FvRVdQPuOkdcIT0KqDKGC9bJ3bulcALMRRb0Jn5QjJv/tEAQ7JLLc9tpDu4A==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9bHuEIZdr/4g1X7V2cG2s9pV8YkPgih2F457Zjl6WzyBNy6uYfv2keUhBakz6EgPTUCBgl/tjlwLTHQjZ6X312rI3LEsZEFjCMqcMyq2qxpiL369lV1D4thAizOCQ5S3GTB/acemVGpcX2duX3s+4YwCW8aRfnVBoEo2UJfqMHPZChonDFij6+2lkpqd1pj0BbL8vrYf6pJe57srjCbDkIG9xoJGmI2iSX84no4HpoKTfuNGvPIAIoqdiuQSlEyZp+HbObXoH18NEiyHuiQUN9IcQTxEt0qg4xuZt47r48LA6NwaAid96pDU8wOxAy6OtgLFqkz9sJNuP0PLVFm89P+p0Qs6p5KC/4PkLXUa91jBpcoZAPU2YYjqhtkcEaZqA1f2JSbcaW4QYHjiXcj6IygcQpt6lOMb0dfedZtBh0HywwNqTTfVmB96M4wcv2ux
X-Exchange-RoutingPolicyChecked:
	sZjBLiIsOwkDa+zAPf3uNxKjLrLXwEeqNoljfpXrUSyBnH53ilXoatlvmqqEDcZNTssfRuetwv0/SUC52itDLpiLmNoI4ZxPIJGY0wgzKxMEU3zGIVakL2WdF+6gouMCzTFojjX0b7mZehfcAHznUl6l7QVoAP/XiABTmfa12cgKQ9ChFnHj3jVQdf6YxmrlZtl7ujuzYZ4hR8ujVrLTEpmexiU30JjAGkNGS2yiEqJwwyIZO2wsugySLNA9OMdIOhIE78Cb9d+VRbuz4Yakacm7S9D2VYHJm0B3S4xUFk93HzHdPxwSYhcwVHKaZd5EtgYbCJU4Xj64I7mm0EHR/A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:56:53.7117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d37a17f-b6e6-4eaf-3c06-08dee1a76118
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6647
X-Proofpoint-GUID: L7HwvpXVWrPD06TJE2h8tcNUUL6W1OdY
X-Proofpoint-ORIG-GUID: L7HwvpXVWrPD06TJE2h8tcNUUL6W1OdY
X-Authority-Analysis: v=2.4 cv=EMg2FVZC c=1 sm=1 tr=0 ts=6a56321f cx=c_pps
 a=Ho/Krdd5x/ljPkV1+9yTnA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=v80JpUPI8rrDPgMNanQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfXz8kxlmMT4uJt
 WoQyfIDrW56XhoZmiDYdfi6gNOLbdh6zEqX87nN7zyQp7AUySc90//AZTU17G0YG/MJWgHDBAbY
 CRVMKvpkcQ25Y5qQWO7E+WiurghpD6E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfXx8UYjAATCIo8
 73MAF+A2D8pCuBjt7gqxb6QMhlkVgS9WMTw4X4rA0cfYkXGBQ31tQTLn3dF5K2fAYjxrVg1AJhj
 zI0WZ+TKWxK7+rO5gkNu42Q7TTKxWEKX+KhKB2YZ0sG41yMEN3qrDsmNwU4r3ZTrDHokVtIGvLv
 QYtBIScoObAVwpUycnCEVUW8u2Mf9q6Aic4uMO5EysUw8fXPgObTOWlwZMr1wXgvtoKk6WlOSyF
 vRFtDIRP9YRhx0jU5skPYcI8h/JifPAf2RfsOmg2jLn2LA+V7ybhEuGClzpSrb1H8HjHpTGiMpS
 pFidqYOU0frbxU+DekyGX2aICRElwOEkNkFXpCREbJ1JEeJmBg28Fl1cY5iNS6AcEpSvm2JBnBw
 t/3nETan3VL3md4lFnhQ4PWpOZHbN3f8vhOvEPfCo9NvWNo2n+KqUa5ocVR0b1bithabFZFojkx
 bzy8ObMerp5dZoAOk1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1011 adultscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140135

From: Aarya Chaumal <a-chaumal@ti.com>

Add perf JSON event and metric definitions for the AM62A
DDR controller PMU.

Signed-off-by: MANNURU VENKATESWARLU <v-mannuru@ti.com>
Signed-off-by: Aarya Chaumal <a-chaumal@ti.com>
---
 .../arch/arm64/ti/am62a/sys/ddrc.json         | 240 ++++++++++++++++++
 .../arch/arm64/ti/am62a/sys/metrics.json      |  34 +++
 2 files changed, 274 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am62a/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am62a/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/ti/am62a/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/ti/am62a/sys/ddrc.json
new file mode 100644
index 0000000000000..0322e3c4a73c4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ti/am62a/sys/ddrc.json
@@ -0,0 +1,240 @@
+[
+   {
+       "BriefDescription": "Counts every Write command",
+       "EventCode": "0x00",
+       "EventName": "k3_ddr.write",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every Read command",
+       "EventCode": "0x01",
+       "EventName": "k3_ddr.read",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every read as a result of a RMW command",
+       "EventCode": "0x02",
+       "EventName": "k3_ddr.read_rmw",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every Activate command",
+       "EventCode": "0x03",
+       "EventName": "k3_ddr.activate",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every Precharge command",
+       "EventCode": "0x04",
+       "EventName": "k3_ddr.precharge",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every Precharge All command",
+       "EventCode": "0x05",
+       "EventName": "k3_ddr.precharge_all",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every Mode Register Read command",
+       "EventCode": "0x06",
+       "EventName": "k3_ddr.mode_reg_read",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every Mode Register Write command",
+       "EventCode": "0x07",
+       "EventName": "k3_ddr.mode_reg_write",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every Per Bank Refresh command",
+       "EventCode": "0x08",
+       "EventName": "k3_ddr.per_bank_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every Auto Refresh command",
+       "EventCode": "0x09",
+       "EventName": "k3_ddr.auto_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every ZQ Calib Long command",
+       "EventCode": "0x0a",
+       "EventName": "k3_ddr.zq_calib_long",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every ZQ Calib Short command",
+       "EventCode": "0x0b",
+       "EventName": "k3_ddr.zq_calib_short",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Read and Read-to-Write bus-turn-around",
+       "EventCode": "0x0c",
+       "EventName": "k3_ddr.bus_turn_around",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Write address collision",
+       "EventCode": "0x0d",
+       "EventName": "k3_ddr.write_write_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Read address collision",
+       "EventCode": "0x0e",
+       "EventName": "k3_ddr.write_read_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every Read-to-Write address collision",
+       "EventCode": "0x0f",
+       "EventName": "k3_ddr.read_write_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every Read-to-Read address collision",
+       "EventCode": "0x10",
+       "EventName": "k3_ddr.read_read_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every exit from Power-Down Self-Refresh mode",
+       "EventCode": "0x11",
+       "EventName": "k3_ddr.exit_power_down_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every entry into Power-Down Self-Refresh mode",
+       "EventCode": "0x12",
+       "EventName": "k3_ddr.entry_power_down_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Power-Down Self-Refresh mode",
+       "EventCode": "0x13",
+       "EventName": "k3_ddr.power_down_self_refresh_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every exit from Power-Down mode",
+       "EventCode": "0x14",
+       "EventName": "k3_ddr.exit_power_down",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every entry into Power-Down mode",
+       "EventCode": "0x15",
+       "EventName": "k3_ddr.entry_power_down",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Power-Down mode",
+       "EventCode": "0x16",
+       "EventName": "k3_ddr.power_down_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every exit from Self-Refresh mode",
+       "EventCode": "0x17",
+       "EventName": "k3_ddr.exit_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every entry into Self-Refresh mode",
+       "EventCode": "0x18",
+       "EventName": "k3_ddr.entry_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Self-Refresh mode",
+       "EventCode": "0x19",
+       "EventName": "k3_ddr.self_refresh_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller command queue is full",
+       "EventCode": "0x1c",
+       "EventName": "k3_ddr.command_queue_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller info FIFO is full",
+       "EventCode": "0x1d",
+       "EventName": "k3_ddr.info_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller write latency FIFO is full",
+       "EventCode": "0x1e",
+       "EventName": "k3_ddr.write_latency_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port command FIFO is full",
+       "EventCode": "0x1f",
+       "EventName": "k3_ddr.port_command_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller write response FIFO is full",
+       "EventCode": "0x20",
+       "EventName": "k3_ddr.write_response_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port write FIFO is full",
+       "EventCode": "0x21",
+       "EventName": "k3_ddr.port_write_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller core read FIFO is full",
+       "EventCode": "0x22",
+       "EventName": "k3_ddr.core_read_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port read FIFO is full",
+       "EventCode": "0x23",
+       "EventName": "k3_ddr.port_read_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62A"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ti/am62a/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/ti/am62a/sys/metrics.json
new file mode 100644
index 0000000000000..51f4c8a690828
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ti/am62a/sys/metrics.json
@@ -0,0 +1,34 @@
+[
+    {
+        "BriefDescription": "DDR memory read bandwidth in MB/s (32-bit bus, BL16)",
+        "MetricExpr": "(k3_ddr.read * 64) / (duration_time * 1e6)",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am62a.read_bandwidth_mbytes_sec",
+        "ScaleUnit": "1MB/s",
+        "Compat": "AM62A"
+    },
+    {
+        "BriefDescription": "DDR memory write bandwidth in MB/s (32-bit bus, BL16)",
+        "MetricExpr": "(k3_ddr.write * 64) / (duration_time * 1e6)",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am62a.write_bandwidth_mbytes_sec",
+        "ScaleUnit": "1MB/s",
+        "Compat": "AM62A"
+    },
+    {
+        "BriefDescription": "Average DDR read requests per second",
+        "MetricExpr": "k3_ddr.read / duration_time",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am62a.read_requests_per_sec",
+        "ScaleUnit": "1reads/sec",
+        "Compat": "AM62A"
+    },
+    {
+        "BriefDescription": "Average DDR write requests per second",
+        "MetricExpr": "k3_ddr.write / duration_time",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am62a.write_requests_per_sec",
+        "ScaleUnit": "1writes/sec",
+        "Compat": "AM62A"
+    }
+]
-- 
2.34.1

