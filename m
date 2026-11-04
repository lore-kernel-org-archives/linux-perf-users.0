Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808521;
	b=25NRqczJbJBuTrtZTfiMO5MxROaJOXz7FBJjfPDgh5HEGyB1jYTtcvAFCXNxW+meqOpP
	 mmK3vemeJnOmqhrRk+N9fxEwUyfmsXftOnT0O1Df1c/CdJDjHh5nFO1EAaUXHXCwzCDi0
	 ogLi/IvMX0wZoDJybpUFoNWw2ZjTojqLtlLrnSG0/dsDn+ysUB4XH+lcWQaTBRb6Y6yB4
	 OYU8RCl6kDWXA2fZgTx/CXtN6EVXv4zOcKsA5C2Ji3eFB9K0L4SSGWjDEv6lc8p3kFsWH
	 1KUBQSd4FsxhV0zE7U89LRyqBC9eScxMybBTlqs4Ij3tGntMJdRr8TmSKyKYRwgwGFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808521;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PeQyp24lotSnEnIrmE0yQFUm7VeGpS3XIC5MhTYw1a8=;
	b=gK4fdbAaQgOUkODKoKT0EqqxvOogg3ifkGTrCXWTzWvOKi0nm4GBoKa9L4D/vWtWOUFS
	 CRVpj5kxJqdEoCaDLdFUusVIAiUAqLsrYMfo3z3yQE+HtWyQqvxwPNkmtTmvr+2FIgVVT
	 4EVcpcFsv0gyGTCG95rWnXWYVHFtAuUGZYPIzsSBOhcI02qTFeKx1cuP9BRAnEykh/lc5
	 +IV+xu7Ofw4lXCGcsZqRVvG01ziM7XNNACtolXakC93UelNVYr74ardLwdEQpc8ZOuM1O
	 oFiJPMCocUXFzNlZX4h60XibAPIqnZnm/BDs0/2bsajxIXN3uQf5eIhPuk7SyLwrvRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Hnla2h5Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.67
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721BB606D813;
	Wed,  4 Nov 2026 16:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 721BB606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Hnla2h5Z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YltxaAovIPMIVaMJ3kBByPGD6WjOK7dJsooE9tEybuplF3tCPt1hAX53Bw3/DIKqXfHfQ8fpPa4jZU0BstPr/Fz6zoMEoQI/byQLvJEKF9aK7pjzpvo2xtD1Uww3vG215pjm8fCRrA7k6yRUWLb7b2CEessym9D+dwttUQRds6z+hBrlAWGBW5lzwCF2R+w/aD+gPPJcEnPNEnkqITudFCXIhPo62nww6+FmD7jCXua97yiJ8ZIOyvDIFTXB+GeFvarfUlJm1QNxQ7oy1vzN9tOo8TDY88bsxfzPUKQlcXOqzpL7pD4WQilvhrVypGudQB7uNfOgZZtSnqHH+Ijd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeQyp24lotSnEnIrmE0yQFUm7VeGpS3XIC5MhTYw1a8=;
 b=r0SWFho/jYthpPmuG3mwWf5aTUTHmC4w+sPUi8t57RhBSM6jmSYOfWiYDFPke+nYrHXM6HDA2CqTCuMWu08mHH2oI9qguml+NLIfvUxzh50U47We/yiFL8l8srDk2wmQ10YwIQQTIkVR8Lna/0V3QVTGdNVwtFSa3PI4HAQZT5M0O5tMjlo4vLZMrLLE/8cCNq6oQSc9aoMyqQUQWWLhMgT/IAL1EkX0Ts6sxtaX8G7bR6gKIx5M9k/JF30S2KvgkAjWvEc2TH5jOcXna8P4u5nL0rCwzlz45Np19+j1k0gLknJr6sK6mtxjkSnjGpwZFgBAUHcYtRDiGifcL36yDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeQyp24lotSnEnIrmE0yQFUm7VeGpS3XIC5MhTYw1a8=;
 b=Hnla2h5ZM4qvu59jS0oFpe76Dwv6e+JWnilw8b1xpi/R3DNxot/Z4cFV1JaOKKxG1pusK63+5xZ1z/Ho6KSIv10rOj6jKCmJpxo+oM+neDXVvpND8lT5dC/j2o406RmpGfUpa5aWV4QqhC63GzrufHjjKgqrCPeJ2WFKYfUCQz9+C1VQ3jRSM/WgM0QIMRP4ObpYDwzI03rlUieyeEqe+/dNkNenjUBXf9hHuEoKnrFU9Z/yqPFP4vULbgyaDx4GqpiPH1okmJalTD1d/zfdsFy91sO6fV4VA/e+zNKEOzCRtWPO2KEliV5xWkz+NfL/6VgKAog1ClyJrN0O6xJlOw==
Received: from PH5P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::10)
 by BN7PPF0D942FA9A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Wed, 4 Nov
 2026 16:08:37 +0000
Received: from CY4PEPF000392D9.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::98) by PH5P220CA0013.outlook.office365.com
 (2603:10b6:510:34a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 16:08:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392D9.mail.protection.outlook.com (10.167.247.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 16:08:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 08:08:10 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 08:08:10 -0800
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via
 Frontend Transport; Wed, 4 Nov 2026 08:08:08 -0800
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<ctshao@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vsethi@nvidia.com>, <rwiley@nvidia.com>, <skelley@nvidia.com>,
	<mochs@nvidia.com>, <rajjoshi@nvidia.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <john.garry@linux.dev>, <will@kernel.org>,
	<james.clark@linaro.org>, <mike.leach@arm.com>, <leo.yan@linux.dev>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, Besar Wicaksono
	<bwicaksono@nvidia.com>
Subject: [PATCH v3 7/7] perf pmus: Treat both numbers of NVIDIA PCIe PMU names as suffix
Date: Wed, 4 Nov 2026 16:07:16 +0000
Message-ID: <20261104160716.2910873-8-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104160716.2910873-1-bwicaksono@nvidia.com>
References: <20261104160716.2910873-1-bwicaksono@nvidia.com>
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
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D9:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b492c6-5fbb-476c-424b-08df3a8de243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|1800799024|23010399003|376014|18002099003|6133799003|22082099003|261102123227099003|56012099006|11063799006|261009223027099003|10067099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	gxnznAIVJqEh8Nx8IkNxiQYLOoKpo5CmfMU49h5+JVC4wn+d3VXYq5edP1r+4hB3F1dJ5O6lrcScQ8lK0SLAyDLDbmOLCEzGkdAMj7hYem/hSrsq8oawpotkwae+46JAUkY7VMWwKG948xdKoNmV05EG2XbzjYmk5TJ/WcAaw31gssde5mznVfw/r6pPvWiY1ftQqQmCCjyJcdzshHVoVcRWOuMzx1n/vU94Ua+Y580A2j4aoQXev9KGFa6Y7tshNCNVhnP4NQkHBVAx8pJ+rOtdG6m/eEjrXx6UBHgS4pRc4KnXjpNHOsmBDsC7oZjULAo8W5UZBYRSKm6xtfJhnGj5hF9sQkS8U/E1tsBiHoxlL9xgnSnpCe7bNiBZ9ufqD6iWR4trIi/uUtHcBry1Nkm+6WdurW5Tl17hjJoXlMZfnkgjKZnEUndiTl2cWH0vcoN5NS9Jhge+URe7IxMbMlRrWN/7Hv+C073t3u8dTu/LeZkY8CcpHro4pSMN28fqsmiD85gEKAo/hGHpIcg/YwohvQcMdVt6lo3SYoV+aijzdVG3A3PGqhgtHXwgCBBw6zbnUcCwYt/rMtMvgwrcFxHRXwiD9uOr+jdMEGncQtD5EK6jdSvvRniFJzYHExxCm1QbX3ExieqO07Gtrnci/XxJzIbBIXOiBSRbawJf/N7Any/kCl7Q7uBsALBqrqoGQVzk8itsoV8z12Bh/yTEzQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(1800799024)(23010399003)(376014)(18002099003)(6133799003)(22082099003)(261102123227099003)(56012099006)(11063799006)(261009223027099003)(10067099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m+1A/ZU6gdWSD1pRA86TyVc79rqNaEFDkrOWvhl5Ax+5Z/Jfdwva7CCxaBozLlsn0o1ksyYWf2shMG8abgO4bm6odyH5qLKGyih0BH7nJxabSJTiwvLb7j3H238XgPy7kBwrWm3ix3AN89Stq79uBHPiR4kixNFmC4EB6YyWkps/0qp8pbuAvjI2xW4wwcnu78IalGOOSEZQ3PZQzgW9Psh1asNG57hQ29ib+hygL39fkmp1qZHgn4yFQht77mYq1UMEB29BdTqE/HAuUyzrroW1B3hNReGa/N6kRwRiru0OOVPEinUeApGF42yr9/II7CMjyELhPEWQl1E8g5nvfOvgDHZr+Kbf3DBawM8RVRNiwHdMbj4+khgiOhDR5kwBfTf7ESS1Zzaqq6lRBx5vi4AHUU2nPrGMWZNBAFKWAi/FgZzHm5Xq1SMiwEOTkC3I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:08:36.9787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b492c6-5fbb-476c-424b-08df3a8de243
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392D9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A

The NVIDIA PCIe and PCIe target PMUs are named <name>_<socket>_rc_<rc>,
like nvidia_pcie_pmu_1_rc_3. pmu_name_len_no_suffix() only strips the
last number, so perf treats the PMUs of each socket as a different PMU.
An event or metric on all PCIe PMUs then gives one result per socket,
each labelled with the first RC of its socket.

Make pmu_name_len_no_suffix() strip both numbers of these names, so the
instances on all sockets are merged as one PMU, nvidia_pcie_pmu or
nvidia_pcie_tgt_pmu. Also accept that name on the command line, as perf
list shows it, and sort these PMUs by socket and then by RC.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 tools/perf/util/pmu.c  |  9 +++++++++
 tools/perf/util/pmus.c | 23 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 01753d5c69d1..1ae8bcf71c68 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -926,6 +926,15 @@ static bool perf_pmu__match_wildcard(const char *pmu_name, const char *tok)
 	bool has_underscore = false;
 	size_t tok_len = strlen(tok);
 
+	if (strstarts(pmu_name, "nvidia_")) {
+		/* NVIDIA PMU with a non-ABI suffix of nvidia_..._[0-9]+_rc_[0-9]+. */
+		const char *rc = strstr(pmu_name, "_rc_");
+
+		if (rc && isdigit(rc[-1]) && tok_len == pmu_name_len_no_suffix(pmu_name) &&
+		    !strncmp(pmu_name, tok, tok_len))
+			return true;
+	}
+
 	/* Check start of pmu_name for equality. */
 	if (strncmp(pmu_name, tok, tok_len))
 		return false;
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 1355b317f3ed..8d3238fd23f1 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -67,6 +67,15 @@ size_t pmu_name_len_no_suffix(const char *str)
 {
 	int orig_len, len;
 	bool has_hex_digits = false;
+	const char *rc = strstr(str, "_rc_");
+
+	if (strstarts(str, "nvidia_") && rc && isdigit(rc[-1])) {
+		/* NVIDIA PMU with a non-ABI suffix of nvidia_..._[0-9]+_rc_[0-9]+. */
+		while (isdigit(rc[-1]))
+			rc--;
+		if (rc[-1] == '_')
+			return rc - str - 1;
+	}
 
 	orig_len = len = strlen(str);
 
@@ -106,6 +115,20 @@ int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
 	if (rhs_pmu_name_len + 1 < strlen(rhs_pmu_name))
 		rhs_num = strtoull(&rhs_pmu_name[rhs_pmu_name_len + 1], NULL, 16);
 
+	if (lhs_num == rhs_num && strstarts(lhs_pmu_name, "nvidia_")) {
+		/*
+		 * NVIDIA PMU with a non-ABI suffix of nvidia_..._[0-9]+_rc_[0-9]+:
+		 * compare the RC too.
+		 */
+		const char *lhs_rc = strstr(lhs_pmu_name, "_rc_");
+		const char *rhs_rc = strstr(rhs_pmu_name, "_rc_");
+
+		if (lhs_rc && rhs_rc && isdigit(lhs_rc[-1]) && isdigit(rhs_rc[-1])) {
+			lhs_num = strtoull(lhs_rc + 4, NULL, 10);
+			rhs_num = strtoull(rhs_rc + 4, NULL, 10);
+		}
+	}
+
 	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
 }
 
-- 
2.43.0

