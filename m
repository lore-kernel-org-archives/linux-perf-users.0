Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F78448CFF
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033875; cv=fail; b=ICxsxyNFuymb26cZXrgv352y1PZNTi5oyYUI4MpW2q7y2gjPEeqyDZ/9rL1+C34DkveUx+Qo9BUYqlpK5wyg+pAJOs6iRV9wEe28xAWsWelT6uerc8z9AMesS8pQc4CSh309Xm6GeyiOlgTbqOr5Tq2cI9cykMIEAPv56x2tmd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033875; c=relaxed/simple;
	bh=aK9Zg7f52Qxa8wABC7Vf2PtMqq/lZyDXTjtFdxMpw/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NC6+7HPXe9rnMnBq8PWsMFkkFJ47zDGaeqoGJlgyiH5xntJvNyyqQmj3FH5qoQs0/LEewekZ4xaxwwTGv6StIT+mXdwBLCJ7fC73ZceyIQYhVvZ5Y4r+d0OACUtCgzlp9zyKKO6J72FfbOyWGdjJCBpRrgFccqF/7t7UybYnbGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=XAgxetPh; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ufCIA9hh; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="XAgxetPh";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ufCIA9hh"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBhCoG2126478;
	Tue, 14 Jul 2026 07:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=6Zlk7X7ZyZ92yAzSb9OusfhwBMfUGFKHJIrH9yrPJ
	n4=; b=XAgxetPhCfI3HYyfmTpAWCl3+w5F4mRiHS2GBfiYBDsEGeSdgvMNEaIpl
	rDuOXHp4hFy9dhuaET9B4LM5igB6bkY3Bz3LiRWkRrhnDNaDtT+cSqUW6dp4nI+/
	ESf9TsG8AIaiNM6M2xjF+i6ZoRFYn2iHMCMkYOmY4S1/MgMG+2xS48vi6jQA6mzV
	eZxvKb3Mbpzkpev2ay4GeZNjGTMFgnWJvvqsSF40dK/9c0mA/UhkamigqH89whgv
	J/1wtXmGnssGrA5+K0dflp6FZX5DBa0MPFwpnjISY7T7gCE/viK3SWeDYMOgSY0Z
	+iKE6Ejn4kJ5vGV2TrmdIAUWFX7Iw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fdmg30byg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 07:57:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFvlDX5VtpFyVPrQ3oNIDCLBV/vimFObwNmDAwUXxGhoQhcbVVwigRhy8qQb37HqdCo/5Ef3UhkhPmtLL5lC0ooVjB9F0ffQiWkYKBSQF0//egJQ2ZZ+jJofpWtjTWSLybpkHh0goqc6IrZuQYU6dQplm3IsTccpmUb5jyj6tAYuw+Mj3uAtAsAdBJSzRsN/QT9x75hj61v2Wi29e2VjJzoW/NEvpcYmpmyuEfWT22jHA+HwXz49d2Ls/4hHoZRSntXFuFb6GIPdQ0eow4xPOqZlCYbrgaRX/MZdeFi2p+BXxgMBTpycZAILA174bP1UEx8+T1Vlmig/vZCGk0EyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Zlk7X7ZyZ92yAzSb9OusfhwBMfUGFKHJIrH9yrPJn4=;
 b=arxHD5F5wT6hOidIDCYhcndGWlWvWc/x2Wy3oIvLq93YO1qATAlZ/JdoBMg/xfjRyTgFOOJBvfovoLE0BQ0l+HaqVbFZ26A5dZdESp8/AlUaCPVCzOVjQC6YjEwnmOdAVRFw3f76p6u3Vk4A4HLya5Thh+SrCU/rMNw5l3wcF7p1N6jJZeICUfPChl1TvN3cN8bAMGePvnWbQxapeyVU6p2X23yNX4ESPvU49cvvy/XLUuyfN9h9VPkSAxKTZDPBNwWPDL6pU8ZnxIJSesfGwnEbVYCmZGNjzBQRnEU3TRrIcKPi8heKEFiy3c4fJrX6aEdA0DO2Z1LrOqL9rXAaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Zlk7X7ZyZ92yAzSb9OusfhwBMfUGFKHJIrH9yrPJn4=;
 b=ufCIA9hhD4MBNkCf1KWiBskGcnWQRgOx/s4x/EhgjJ6yUKlydh74/Y7UpMJqse3yCjfNSGC3/3gq6myBSmJjOzCVtX8Vq89bEvXRkOqbV195PlPCkEABhH3qlTcnacht1keM8AVOjDuykPYfWP2qbKvb0ir4rQMqheZHbjlpNLo=
Received: from PH7PR03CA0001.namprd03.prod.outlook.com (2603:10b6:510:339::26)
 by DS7PR10MB7278.namprd10.prod.outlook.com (2603:10b6:8:d8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.18; Tue, 14 Jul 2026 12:57:39 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:339::4) by PH7PR03CA0001.outlook.office365.com
 (2603:10b6:510:339::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 12:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 12:57:37 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:51 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 07:56:51 -0500
Received: from venkey.dhcp.ti.com (venkey.dhcp.ti.com [10.24.53.161])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66ECuaH34165566;
	Tue, 14 Jul 2026 07:56:49 -0500
From: MANNURU VENKATESWARLU <v-mannuru@ti.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <n-francis@ti.com>, <s-k6@ti.com>, <bb@ti.com>, <v-mannuru@ti.com>
Subject: [RFC PATCH 21/22] perf/events: arm64: ti: Add AM64 DDR performance events
Date: Tue, 14 Jul 2026 18:26:34 +0530
Message-ID: <20260714125635.3304437-5-v-mannuru@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DS7PR10MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ba50d5-3dd8-48c6-2e2d-08dee1a77b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jq3w5Ck0oQRsipPneor6a8JeWPtKXGtHSFYcDUUQeUrG7BTtHArtSXRNYfMpYeU+uqtjWsmUcOmLwz7ICB32l/DvjyrNVXpNjKITsYJ1Ozkg19gMUs75hjj162ms6WlHMHw0+n4epVkNvfmslh4huXz1FqVcNnHgxhR6pEUnD8F1YdlLJrbLC91ogmV+yorurEbJW9mIWiP4CopvXR1nmnANGNFqoUabojU6ADPyAWuodNzKVncYLWbFt8WwvTTxmTCNnWzY6uQ1DJnF2e2qHrL9z+ln9qUFq02xzXiss2b486CD74lSdaEczWQvuJLw9pVp9maXXFoew8DNhgSZKi8hg9bwDfmGsPcCQQFHsPC6slBjyToGjEgL7ZKPZpjyTKGd6tTz88awafcnxPVpcb1fMalYPX8jAlYaiBeEetuIuuqFEP5bIO9lbvDYhVNC0sHgCslG8SoWt9Qr7vfcoojUjEqMIKSeRihYKWVieXM+dFiWiUf9WEwRmwQCd5bIicWly0Z8hKTM/pIbgZ02yDzSzl7eChgiZ4ixqP1+NXq5RJBMTqZcY/7WtqcGJ3YtCqlP46u5yGOP9jFoaOGeuYR2Bx82vuo4avmbw+dep2OWw9KQsI10BbUE9etK5o2ptqMxvuLnMpFoza+TcCdUqIKZ20uy+1ybiTGL7oWEK6JdS1eaHdGCyJd3V38Bx0uJucLqTzryKxxLKH7DxA303g==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+TnygfcC9Tr5742KP3KKHkQu1RSzuN1WEUlQJBT7Y2RbyThoIUINuyb1wsXeIFaDXKrtjLMaYxSp93ugiHSFF0YZWqe1RtHRHmskNBR++3hpFpiprwzwB5Bl6IQFRsy602wS/1Ho0BJslkirJoWGHEaCK4z0GIvIgWJsMKNlARbZND7NLo/AuV0p6Gz7n7+qTs4iQ2mMuQYEbh5rQikkB6hjWDKXeW0JzibpFrhlYTZ5LdM7EST/qcVZFnl43Spke3iip73yaTFoxBvVAB9Maqgb6S3p4cGOgdvYoN8C5EukCf8JCJnOs7IY6oEZ9RgXirICe5VqlnwzTGiX8SxDOWMCtDocKhKrYcP9JZWUu06ylfKLOc4RMA00hFxsNCx0L0E4Qh1rCXl6fUJt6/cTPygTP64El72rjJrqB1uUhth+hY/ObvZWLKZlWpkAgcNx
X-Exchange-RoutingPolicyChecked:
	kxidELFyO9rdycbt/y0nldYkVBLx+S2EdXT+xbE2X9qiF3QPwzjJz/LZvPJ7YwBVbTqE/4Y7hn7JwrpGK/OxUGYKeBkMS1X8CwS5RULJtCVZ3jKXrwoXG1xj36ierQAwO2g9scIP2z4w3HOqdT9KXzCnYPTAdurFLrw7s0UvwhhcKJsnEQx8t3KwC7D3r4vQvZu2+adEhAVDvaqBhPdJ5lGJsNLuTPMyC/+jKYhLgVKpYucSaaBWF51HkHWvLFRx76IXrE3fk9sRaRK79Ipu8xzOKMG0OpMXe9LE/iSTXvPNXZ28N9yMPQW/9B+FdEmJ2sUc+afkxiE1PputcQiLcw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:57:37.7245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ba50d5-3dd8-48c6-2e2d-08dee1a77b54
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7278
X-Proofpoint-GUID: LXiA7tN6vaQRkxpYwlhN_TtlKVJ1YHZb
X-Proofpoint-ORIG-GUID: LXiA7tN6vaQRkxpYwlhN_TtlKVJ1YHZb
X-Authority-Analysis: v=2.4 cv=EMg2FVZC c=1 sm=1 tr=0 ts=6a563248 cx=c_pps
 a=ysgzExocFkmHQmNOaQPFvQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=v80JpUPI8rrDPgMNanQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX/4N3NSA1ik05
 Z3n0CcvwfX/RL8/Nyy3iPp+U9SVAKj1bfCYf8WdBky1WM//fx84JsxHRX85MCyvewZ7G5+OTv7w
 fTVmEf8xzRMl8Eajw1du18KjkSYqqSs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX/heFdQ96Zm6h
 595ZONck5d8z7cuI09JoYJPLzHMSwmCaMHxIFG6WE7eG0A3QJ2x7/ROUiL7Y7csMjq6ySUy7XgR
 +2CX0U/SN5UUZR0kPRt2n4Y+KI7e0pF6+d7AV0BYRr9g1StNTVKByzo/fGcJj02zsGcHOXSwYkH
 XKhWhKLdwQ9Zv5tFIe6Ndn0i/QQgRSVMB/3ogDO/dXEkqaw/wafSX1CY3gKBhd/0QihiyHgRD7X
 8nACGVkx3UTtTFSPgTmF4Z22Zm1EvUcttytkw/GSbleAEo0OEppKMTGtQ+vbRO79ey0yXKGHIG/
 iCalCGd4v2ZI96W5K593zrjPyiv01dDcm+Ze7AmfqS/p3YWi51UeTYy3NKPdy0fUzdX3n3ZQQ9O
 xdhxEe00sOhPCKQJPa//gI5qaajAcA/+sZqiyKGKe21lIkwRcWdABvzRL3KTVmsvj/P4rzv/0/a
 wLp6VfOie9mVdADbIqA==
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

Add perf JSON event and metric definitions for the AM64
DDR controller PMU.

Signed-off-by: MANNURU VENKATESWARLU <v-mannuru@ti.com>
Signed-off-by: Aarya Chaumal <a-chaumal@ti.com>
---
 .../arch/arm64/ti/am64/sys/ddrc.json          | 240 ++++++++++++++++++
 .../arch/arm64/ti/am64/sys/metrics.json       |  34 +++
 2 files changed, 274 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am64/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am64/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/ti/am64/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/ti/am64/sys/ddrc.json
new file mode 100644
index 0000000000000..c3498dfa7feeb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ti/am64/sys/ddrc.json
@@ -0,0 +1,240 @@
+[
+   {
+       "BriefDescription": "Counts every Write command",
+       "EventCode": "0x00",
+       "EventName": "k3_ddr.write",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every Read command",
+       "EventCode": "0x01",
+       "EventName": "k3_ddr.read",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every read as a result of a RMW command",
+       "EventCode": "0x02",
+       "EventName": "k3_ddr.read_rmw",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every Activate command",
+       "EventCode": "0x03",
+       "EventName": "k3_ddr.activate",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every Precharge command",
+       "EventCode": "0x04",
+       "EventName": "k3_ddr.precharge",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every Precharge All command",
+       "EventCode": "0x05",
+       "EventName": "k3_ddr.precharge_all",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every Mode Register Read command",
+       "EventCode": "0x06",
+       "EventName": "k3_ddr.mode_reg_read",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every Mode Register Write command",
+       "EventCode": "0x07",
+       "EventName": "k3_ddr.mode_reg_write",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every Per Bank Refresh command",
+       "EventCode": "0x08",
+       "EventName": "k3_ddr.per_bank_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every Auto Refresh command",
+       "EventCode": "0x09",
+       "EventName": "k3_ddr.auto_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every ZQ Calib Long command",
+       "EventCode": "0x0a",
+       "EventName": "k3_ddr.zq_calib_long",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every ZQ Calib Short command",
+       "EventCode": "0x0b",
+       "EventName": "k3_ddr.zq_calib_short",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Read and Read-to-Write bus-turn-around",
+       "EventCode": "0x0c",
+       "EventName": "k3_ddr.bus_turn_around",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Write address collision",
+       "EventCode": "0x0d",
+       "EventName": "k3_ddr.write_write_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Read address collision",
+       "EventCode": "0x0e",
+       "EventName": "k3_ddr.write_read_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every Read-to-Write address collision",
+       "EventCode": "0x0f",
+       "EventName": "k3_ddr.read_write_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every Read-to-Read address collision",
+       "EventCode": "0x10",
+       "EventName": "k3_ddr.read_read_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every exit from Power-Down Self-Refresh mode",
+       "EventCode": "0x11",
+       "EventName": "k3_ddr.exit_power_down_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every entry into Power-Down Self-Refresh mode",
+       "EventCode": "0x12",
+       "EventName": "k3_ddr.entry_power_down_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Power-Down Self-Refresh mode",
+       "EventCode": "0x13",
+       "EventName": "k3_ddr.power_down_self_refresh_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every exit from Power-Down mode",
+       "EventCode": "0x14",
+       "EventName": "k3_ddr.exit_power_down",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every entry into Power-Down mode",
+       "EventCode": "0x15",
+       "EventName": "k3_ddr.entry_power_down",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Power-Down mode",
+       "EventCode": "0x16",
+       "EventName": "k3_ddr.power_down_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every exit from Self-Refresh mode",
+       "EventCode": "0x17",
+       "EventName": "k3_ddr.exit_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every entry into Self-Refresh mode",
+       "EventCode": "0x18",
+       "EventName": "k3_ddr.entry_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Self-Refresh mode",
+       "EventCode": "0x19",
+       "EventName": "k3_ddr.self_refresh_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller command queue is full",
+       "EventCode": "0x1c",
+       "EventName": "k3_ddr.command_queue_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller info FIFO is full",
+       "EventCode": "0x1d",
+       "EventName": "k3_ddr.info_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller write latency FIFO is full",
+       "EventCode": "0x1e",
+       "EventName": "k3_ddr.write_latency_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port command FIFO is full",
+       "EventCode": "0x1f",
+       "EventName": "k3_ddr.port_command_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller write response FIFO is full",
+       "EventCode": "0x20",
+       "EventName": "k3_ddr.write_response_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port write FIFO is full",
+       "EventCode": "0x21",
+       "EventName": "k3_ddr.port_write_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller core read FIFO is full",
+       "EventCode": "0x22",
+       "EventName": "k3_ddr.core_read_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port read FIFO is full",
+       "EventCode": "0x23",
+       "EventName": "k3_ddr.port_read_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM64"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ti/am64/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/ti/am64/sys/metrics.json
new file mode 100644
index 0000000000000..1d8982c8f5bba
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ti/am64/sys/metrics.json
@@ -0,0 +1,34 @@
+[
+    {
+        "BriefDescription": "DDR memory read bandwidth in MB/s (16-bit bus, BL16)",
+        "MetricExpr": "(k3_ddr.read * 32) / (duration_time * 1e6)",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am64.read_bandwidth_mbytes_sec",
+        "ScaleUnit": "1MB/s",
+        "Compat": "AM64"
+    },
+    {
+        "BriefDescription": "DDR memory write bandwidth in MB/s (16-bit bus, BL16)",
+        "MetricExpr": "(k3_ddr.write * 32) / (duration_time * 1e6)",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am64.write_bandwidth_mbytes_sec",
+        "ScaleUnit": "1MB/s",
+        "Compat": "AM64"
+    },
+    {
+        "BriefDescription": "Average DDR read requests per second",
+        "MetricExpr": "k3_ddr.read / duration_time",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am64.read_requests_per_sec",
+        "ScaleUnit": "1reads/sec",
+        "Compat": "AM64"
+    },
+    {
+        "BriefDescription": "Average DDR write requests per second",
+        "MetricExpr": "k3_ddr.write / duration_time",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am64.write_requests_per_sec",
+        "ScaleUnit": "1writes/sec",
+        "Compat": "AM64"
+    }
+]
-- 
2.34.1

