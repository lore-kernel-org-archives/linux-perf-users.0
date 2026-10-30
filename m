Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793382684;
	b=JQ1HOkkowL8Vglf2Ul1KLY6HBQuAXmbIynK+Laj2am/9iZxBw2iUOt161gYCf53GCnX0
	 nKliR0dnrE7pMjMS8T6nsmoh2u8BmTCVYfyfWUM5yMhWxIS74+a7XKvr45v3xVAxwLGtF
	 w+7HRctp23C1uk/NQf8M6Raw5NyzHowQcCdfpYFgkK8YQ3Z6Qv4S5fWnPCohlIvjAPywZ
	 1IGNTvFByOxADkUFi5VZ2O8Pgvdw1gNTA2/a8RXoMW2fjGcqVv+XntS3NbeVRWJhwYsvH
	 sYdRlt3eu+50w3I6vbP86PYx2U/adYEkAjbzbUCN6SeZejPv3vx31RAInhieI5NgZtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382684;
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
	bh=2lUW6mNAaniOldlAAm4wyYiKTi3JWIrVMmTGiPdZFD4=;
	b=2J0Csqu4hL/Ftc0c0rBwP33Z4AP3PJVtGneKBnLgweqqwpLuxXypqNr1687rxBRIiz5R
	 ywjuC9LuxFBM04ouhmyjt6Roeqvf9JopGkUB7xejopHef6cChNaqI6GSQrSrUUrxYNo2A
	 S6EEUIw5PcAKC0gfsQwr2nScmFM1b3qT2cENIY2LBpu5fLJerbhjGnpBC9pjcUQgyFHTr
	 0ETxOTh9uCBCt0hAw8Sx5lwTxmRcwPYV40eW0LXhdhgVyd/ZHOYlZvmUfwGdS2jgbFOku
	 yOiFaPmCj0P0WRt9h7adoy9srA8ktuGbdImndN3rW/i6UyFKbmxcSzXRMX95upo5FtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="AoiW/s6U";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.37
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673E7606A32E;
	Fri, 30 Oct 2026 17:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 673E7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AoiW/s6U
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofiQSRpqAfziyiAxMLsy83gejqRg7J1fjEMXS1pVgmXgLqNA828efNR8gppgTZS8f1aD0mTyPmVVh6OG23KDO4OEjeLSNV+DNvxztu69t51zmLyVd+dhWQATAuGG5vT7gQ1pHigVVOOKFPSKltWQooxxbepf3Hhw/JQ+vfEJ+T6qAZLb8ewvxf9voMCiWekS+9bFxy51RP5ho2vDaZCuxvZ6PHDZhlss92CKhm2RK6SWMU7AN/V5O2UVrXhErjSFmxQjaq6LJUAmJ+Swh37rXqAHdZuEECTZS5tpMXwaLdx/cOctrG1DPxIdlBbRFfi+69UoNAfpt5zE8r/WECQCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lUW6mNAaniOldlAAm4wyYiKTi3JWIrVMmTGiPdZFD4=;
 b=zGUk7jxzuJE7XNBrv1mx5EOhtpa4b3AzCIUo0tJ49OV3MYzFBL5c54hKcRMgrguIHzgMCLbIFZV23GculDp7dcbSo1bMDTiTpiHWe88uKdgWYRSe4Y9zbMrVg3dob/G7YAc7odH0CgZS2NhEyl4YIRTI1/eN3mkXoB4gBlFw3QD6ZA7YYJHJfuUoCXBWxsKwiemhHepd2aMug3dxUf4VCF6pVVLWinJ/+5Kw486sJVY8y1tSw3MPiP5lPZfcyBa4B1LWLu23jl6DpxZxt2JY79iTFqtO5hZWtKphfjJ0MSHIqli9ckV9jyjXyiH0cAtCs9+s7C5mFQtIMzgW4bt2EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lUW6mNAaniOldlAAm4wyYiKTi3JWIrVMmTGiPdZFD4=;
 b=AoiW/s6UcDITab5hhPBmP2FqM90B47qWR4sxumgU6w44ryg0ORKZ+QENsUCLyFZMoJzOA4M16A01wfpMSh3QMmYLh/7p8W2c2nuoWiTB9Cr+7B0vOG4wO5Hecn8BRBuA88juqI/2Fq8/Z4tgnpPNlRwAB/DWxa8ja8YXtq6I5hosWgknJbgaOUjHeSa1Eb9DIfKmZF9AjOycGXE0yWbu5jBHSxwJSuCeKFOvNz1QmbUS2OWmm9E7NznFMXJ9F5BjVpB4rfAPnsJBt/V/i9svNAH3NhcrHrA3s0WohlSGUN+198r2WYExwRb8p60pCHdzquxU9O/1SSDwf5DcKMsDiQ==
Received: from PH8PR22CA0008.namprd22.prod.outlook.com (2603:10b6:510:2d1::20)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Fri, 30 Oct
 2026 17:51:10 +0000
Received: from MW3PEPF00001659.namprd21.prod.outlook.com
 (2603:10b6:510:2d1:cafe::28) by PH8PR22CA0008.outlook.office365.com
 (2603:10b6:510:2d1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Fri,
 30 Oct 2026 17:51:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MW3PEPF00001659.mail.protection.outlook.com (10.167.249.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Fri, 30 Oct 2026 17:51:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:50:45 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:50:45 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56
 via Frontend Transport; Fri, 30 Oct 2026 10:50:44 -0700
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
Subject: [PATCH v2 8/9] perf evsel: Name a merged uncore counter after all of its PMUs
Date: Fri, 30 Oct 2026 17:48:15 +0000
Message-ID: <20261030174816.1544471-9-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030174816.1544471-1-bwicaksono@nvidia.com>
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW3PEPF00001659:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fcfb9f-fbd9-42de-02dc-08df36ae61ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|261028144727099003|260925021311599003|260925021911599003|260925022911599003|56012099006|261021121427099003|11063799006|261009223027099003|261022105027099003|261026121527099003|261022075727099003|261021123027099003|261026140227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	r6pLX+0WM+AD+bank/cQ5O6HgG+JGJR6ZT4Ht0bWu1EkQ4PaZ2uhrfEgm1fTTCbVqxYZmv6avWrXKYptfhM+baP7iWvcqh0wfp19heSL1uCGMbWMiuEbaEwZnaUez9C32cRyKXqKKy0ip7gRA6NKOsPdMbOJAf7Bxljb/iuDg3i1FALA50m4qrfX2wVg3adG3EVMJj2VhifA1xPPCsgY12rXTUFfyu5yeL6q8+ejaGsjuFJHKmTztbwENYNUA+g1yJOw4r8mfNY2rZM1CQBWeUcu9rbAeaA3xuVS1PJuDWrUuGaoAVoiHD2F+Sw4vz5ZCbN+3kUQVFJjqqmm26H3AIpvOj0zKOo/4U9PBeptUnYdbImSSfOi61dek+/wi2UAIS5cdgW1f5TNyu7h42xV11Tt91hmWjtfVd6xLwCqPwTSWRs9d0hHuyn+1fsvx06EdvxB9AvmDhz00aXasiEWEcJ+4Ll73T4hWr0HS0ceqKI5CA+Du3gf9WzEkZubtLPmJX9hIHqn6We5Jtc+4cggY9Fkeuzblc/fI4rAW+fHec7vcgHRmuGFdUOwEKejFQkO0KF1wILJBX0BQfrWoM9LfymXJB5DRbpRXsZ/1glsnIDvKR+eXXd0/2+S7psc/Nwcr8/nd2ZlqI3d7CoJZdtAWsWeep3HD2Bqqq0sojTmoxzLBz90mI/PrJpD8ianaGzARxSFbP3gQ3s/DjC0SKdAUg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(261028144727099003)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(261021121427099003)(11063799006)(261009223027099003)(261022105027099003)(261026121527099003)(261022075727099003)(261021123027099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q32HF05piGAkz62Gvc426A9fDX6vclsdcxmubRhNlFrlHFfjVkh89wPLmeD4QbwuIN05m2ndfgCSAN3x+j8Nbxn72w71bR8Abbcv97RXRSBAByHsZkBWjkNriWs99pGceWuYKu9Gcz+7aMxmtnwPU0FWdSli7F2cMNRVhx87X2nSnmumj3kIKa3akG+F4Z94+26DLtO6cERj3DJqhq2tXHPVG5YRD7iRvNe+FMRCNAO63xFMSk2/DJwRRgLQPvFomiB15/MWnD33xLOL8ON2jkVhiALy1tuQLSex8OXeoUpC+0GRYL8nA7pX9OBicfoI5454J6cHtYrsgG+a+qmANsEur8kG/PYKS2yg7/hWUEDUNnl1YWTj05t9/oeTrhOreaOCoU1EkovLfTj6zNquKVYidUQk48n3zWt9OR9YgKfpmk25pi6Tv7aY20N9stpV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:51:10.4681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fcfb9f-fbd9-42de-02dc-08df36ae61ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW3PEPF00001659.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923

When an uncore event is opened on several instances of a PMU, perf stat
merges the counts of the other instances into the evsel of the first
one. If the event name has to be made unique, for example because the
event matches more than one PMU type, the name of the first instance is
put in front of it, although the count is the sum of all instances.

For example, on a dual-socket NVIDIA Tegra410 with six PCIe root
complexes per socket, the socket 1 rows count nvidia_pcie_pmu_1_rc_<rc>
but are labelled with nvidia_pcie_pmu_0_rc_0:

Before:
  $ perf stat -a --per-socket -e 'nvidia_pcie_*rc*/rd_req/' -- sleep 1
  S268435456    6            235,037      nvidia_pcie_pmu_0_rc_0/nvidia_pcie_*rc*,rd_req/
  S268435456    6            665,297      nvidia_pcie_tgt_pmu_0_rc_0/nvidia_pcie_*rc*,rd_req/
  S285212672    6              3,967      nvidia_pcie_pmu_0_rc_0/nvidia_pcie_*rc*,rd_req/
  S285212672    6                 45      nvidia_pcie_tgt_pmu_0_rc_0/nvidia_pcie_*rc*,rd_req/

Name a merged uncore counter after all of its PMUs instead. If the PMU
names differ only in the suffix, use the name without the suffix, like
nvidia_ucf_pmu. Otherwise, replace each number that differs with '*',
like nvidia_pcie_pmu_*_rc_*.

After:
  $ perf stat -a --per-socket -e 'nvidia_pcie_*rc*/rd_req/' -- sleep 1
  S268435456    6            234,973      nvidia_pcie_pmu_*_rc_*/nvidia_pcie_*rc*,rd_req/
  S268435456    6            666,448      nvidia_pcie_tgt_pmu_*_rc_*/nvidia_pcie_*rc*,rd_req/
  S285212672    6              3,184      nvidia_pcie_pmu_*_rc_*/nvidia_pcie_*rc*,rd_req/
  S285212672    6                 31      nvidia_pcie_tgt_pmu_*_rc_*/nvidia_pcie_*rc*,rd_req/

Output with --no-aggr, where the counters are not merged, is unchanged.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 tools/perf/tests/pmu.c   | 62 ++++++++++++++++++++++++++++++
 tools/perf/util/evlist.c |  2 +-
 tools/perf/util/evsel.c  | 83 ++++++++++++++++++++++++++++++++++++++--
 tools/perf/util/evsel.h  |  2 +-
 tools/perf/util/pmus.c   | 47 +++++++++++++++++++++++
 tools/perf/util/pmus.h   |  1 +
 6 files changed, 192 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index e722cd08e30a..e31fdc25aa4c 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -547,6 +547,67 @@ static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __
 	return TEST_OK;
 }
 
+static int test__name_mask_numbers(struct test_suite *test __maybe_unused,
+				   int subtest __maybe_unused)
+{
+/*
+ * Check that pmu_name_mask_numbers() turns _pattern into expect after
+ * matching _name, or fails if expect is NULL.
+ */
+#define TEST_MASK(msg, _pattern, _name, _expect)				\
+	do {								\
+		const char *expect = _expect;				\
+		char buf[64];						\
+		bool ok;						\
+									\
+		snprintf(buf, sizeof(buf), "%s", _pattern);		\
+		ok = pmu_name_mask_numbers(buf, _name);			\
+		TEST_ASSERT_VAL(msg, expect ? ok && !strcmp(buf, expect) : !ok); \
+	} while (0)
+
+	TEST_MASK("Same name", "nvidia_ucf_pmu_0", "nvidia_ucf_pmu_0",
+		  "nvidia_ucf_pmu_0");
+	TEST_MASK("Differ in suffix number", "nvidia_ucf_pmu_0", "nvidia_ucf_pmu_1",
+		  "nvidia_ucf_pmu_*");
+	TEST_MASK("Differ in suffix number, with a number inside the name",
+		  "nvidia_nvlink_c2c_pmu_0", "nvidia_nvlink_c2c_pmu_1",
+		  "nvidia_nvlink_c2c_pmu_*");
+	TEST_MASK("Differ in both numbers", "nvidia_pcie_pmu_0_rc_0",
+		  "nvidia_pcie_pmu_1_rc_5", "nvidia_pcie_pmu_*_rc_*");
+	TEST_MASK("Differ in last number only", "nvidia_pcie_pmu_0_rc_0",
+		  "nvidia_pcie_pmu_0_rc_5", "nvidia_pcie_pmu_0_rc_*");
+	TEST_MASK("Differ in first number only", "nvidia_pcie_pmu_0_rc_0",
+		  "nvidia_pcie_pmu_1_rc_0", "nvidia_pcie_pmu_*_rc_0");
+	TEST_MASK("Same number length, different number", "nvidia_pcie_pmu_0_rc_10",
+		  "nvidia_pcie_pmu_0_rc_12", "nvidia_pcie_pmu_0_rc_*");
+	TEST_MASK("Longer last number in name", "nvidia_pcie_pmu_0_rc_0",
+		  "nvidia_pcie_pmu_0_rc_12", "nvidia_pcie_pmu_0_rc_*");
+	TEST_MASK("Longer first number in name", "nvidia_pcie_pmu_0_rc_0",
+		  "nvidia_pcie_pmu_10_rc_0", "nvidia_pcie_pmu_*_rc_0");
+	TEST_MASK("Longer first number in pattern", "nvidia_pcie_pmu_10_rc_0",
+		  "nvidia_pcie_pmu_0_rc_0", "nvidia_pcie_pmu_*_rc_0");
+	TEST_MASK("Same longer number after a masked one", "nvidia_pcie_pmu_10_rc_12",
+		  "nvidia_pcie_pmu_0_rc_12", "nvidia_pcie_pmu_*_rc_12");
+	TEST_MASK("Number is a prefix of the other", "nvidia_pcie_pmu_0_rc_1",
+		  "nvidia_pcie_pmu_0_rc_10", "nvidia_pcie_pmu_0_rc_*");
+	TEST_MASK("'*' matches any number", "nvidia_pcie_pmu_*_rc_*",
+		  "nvidia_pcie_pmu_1_rc_10", "nvidia_pcie_pmu_*_rc_*");
+	TEST_MASK("Numbers without _", "hisi_sccl1_ddrc0", "hisi_sccl3_ddrc0",
+		  "hisi_sccl*_ddrc0");
+	TEST_MASK("Hex suffix, differ in digits", "smmuv3_pmcg_fe0004030",
+		  "smmuv3_pmcg_fe0004620", "smmuv3_pmcg_fe*");
+	TEST_MASK("Hex suffix, differ in a letter", "smmuv3_pmcg_fe0004030",
+		  "smmuv3_pmcg_fe00053a0", NULL);
+	TEST_MASK("Differ before the numbers", "nvidia_pcie_pmu_0_rc_0",
+		  "nvidia_pcie_tgt_pmu_0_rc_0", NULL);
+	TEST_MASK("Name ends early", "nvidia_pcie_pmu_0_rc_0", "nvidia_pcie_pmu_0",
+		  NULL);
+	TEST_MASK("Name is longer", "nvidia_pcie_pmu_0", "nvidia_pcie_pmu_0_rc_0",
+		  NULL);
+#undef TEST_MASK
+	return TEST_OK;
+}
+
 /**
  * Test perf_pmu__wildcard_match() that's used to search for a PMU given a name passed
  * on the command line. The name that's passed may also be a filename type glob
@@ -706,6 +767,7 @@ static struct test_case tests__pmu[] = {
 	TEST_CASE("PMU event names", pmu_event_names),
 	TEST_CASE("PMU name combining", name_len),
 	TEST_CASE("PMU name comparison", name_cmp),
+	TEST_CASE("PMU name number masking", name_mask_numbers),
 	TEST_CASE("PMU cmdline match", pmu_match),
 	TEST_CASE("PMU instance match", pmu_instance_match),
 	TEST_CASE("PMU config helpers", pmu_config_helpers),
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c2402e4791b6..6ece8fb78a2f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2977,7 +2977,7 @@ void evlist__uniquify_evsel_names(struct evlist *evlist, const struct perf_stat_
 		struct evsel *pos;
 
 		evlist__for_each_entry(evlist, pos)
-			evsel__uniquify_counter(pos);
+			evsel__uniquify_counter(pos, config->aggr_mode != AGGR_NONE);
 	}
 }
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d060fca8090f..7256a315e7df 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -4911,10 +4911,84 @@ bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_con
 	return false;
 }
 
-void evsel__uniquify_counter(struct evsel *counter)
+/*
+ * Check whether the PMUs merged into an uncore counter differ from its PMU
+ * only in the suffix, like nvidia_ucf_pmu_0 and nvidia_ucf_pmu_1. Set merged
+ * if any PMU is merged.
+ */
+static bool evsel__merged_pmus_suffix_only(struct evsel *counter, bool *merged)
+{
+	struct evsel *alias;
+
+	*merged = false;
+	evlist__for_each_entry(counter->evlist, alias) {
+		if (alias->first_wildcard_match != counter)
+			continue;
+
+		*merged = true;
+		if (!perf_pmu__name_no_suffix_match(alias->pmu, counter->pmu->name))
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * The PMU name of an uncore counter with each number that differs in the
+ * PMUs merged into it replaced by '*', like nvidia_pcie_pmu_*_rc_*, or NULL
+ * if the names differ in anything but numbers.
+ */
+static char *evsel__merged_pmus_mask_numbers(struct evsel *counter)
+{
+	struct evsel *alias;
+	char *name;
+
+	name = strdup(counter->pmu->name);
+	if (!name)
+		return NULL;
+
+	evlist__for_each_entry(counter->evlist, alias) {
+		if (alias->first_wildcard_match != counter)
+			continue;
+
+		if (!pmu_name_mask_numbers(name, alias->pmu->name)) {
+			free(name);
+			return NULL;
+		}
+	}
+
+	return name;
+}
+
+/*
+ * The name of the PMUs whose counts are merged into an uncore counter, or
+ * NULL if none are. It is the PMU name without the suffix if the PMUs
+ * differ only in the suffix, like nvidia_ucf_pmu, otherwise the PMU name
+ * with each number that differs replaced by '*', like
+ * nvidia_pcie_pmu_*_rc_*.
+ */
+static char *evsel__merged_pmu_name(struct evsel *counter)
+{
+	const char *pmu_name = counter->pmu->name;
+	bool merged;
+
+	if (counter->pmu->is_core)
+		return NULL;
+
+	if (evsel__merged_pmus_suffix_only(counter, &merged)) {
+		if (!merged)
+			return NULL;
+
+		return strndup(pmu_name, pmu_name_len_no_suffix(pmu_name));
+	}
+
+	return evsel__merged_pmus_mask_numbers(counter);
+}
+
+void evsel__uniquify_counter(struct evsel *counter, bool merged)
 {
 	const char *name, *pmu_name, *config;
-	char *new_name;
+	char *new_name, *merged_pmu_name;
 	int len, ret;
 
 	/* No uniquification necessary. */
@@ -4930,7 +5004,8 @@ void evsel__uniquify_counter(struct evsel *counter)
 
 	name = evsel__name(counter);
 	config = strchr(name, '/');
-	pmu_name = counter->pmu->name;
+	merged_pmu_name = merged ? evsel__merged_pmu_name(counter) : NULL;
+	pmu_name = merged_pmu_name ?: counter->pmu->name;
 
 	/* Already prefixed by the PMU name? */
 	len = pmu_name_len_no_suffix(pmu_name);
@@ -4965,6 +5040,8 @@ void evsel__uniquify_counter(struct evsel *counter)
 			ret = asprintf(&new_name, "%s/%s/", pmu_name, name);
 		}
 	}
+	free(merged_pmu_name);
+
 	if (ret > 0) {
 		free(counter->name);
 		counter->name = new_name;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 53f3641b66e1..0c46b95ab777 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -615,7 +615,7 @@ void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader);
 bool arch_evsel__must_be_in_group(const struct evsel *evsel);
 
 bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_config *config);
-void evsel__uniquify_counter(struct evsel *counter);
+void evsel__uniquify_counter(struct evsel *counter, bool merged);
 
 /*
  * Macro to swap the bit-field postition and size.
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 1355b317f3ed..f80ba16a5007 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -90,6 +90,53 @@ size_t pmu_name_len_no_suffix(const char *str)
 	return orig_len;
 }
 
+/*
+ * Replace each number in pattern that differs from the number in the same
+ * place in name with '*'. A '*' already in pattern matches any number.
+ * Return false, with pattern partly changed, if the names differ in
+ * anything but numbers.
+ */
+bool pmu_name_mask_numbers(char *pattern, const char *name)
+{
+	const char *p = pattern;
+	/* Masking never lengthens pattern, so write the result in place. */
+	char *out = pattern;
+
+	while (*p || *name) {
+		size_t p_len, name_len;
+
+		/* Unless both names have a number here, the characters must match. */
+		if (!(isdigit(*p) || *p == '*') || !isdigit(*name)) {
+			if (*p != *name)
+				return false;
+
+			*out++ = *p++;
+			name++;
+			continue;
+		}
+
+		/*
+		 * Both names have a number here. A '*' in pattern is a number
+		 * that differed in an earlier name, so it stays '*'.
+		 */
+		p_len = *p == '*' ? 1 : strspn(p, "0123456789");
+		name_len = strspn(name, "0123456789");
+
+		/* Keep the number if it is the same in both names, else mask it. */
+		if (*p != '*' && p_len == name_len && !strncmp(p, name, p_len)) {
+			for (size_t i = 0; i < p_len; i++)
+				*out++ = *p++;
+		} else {
+			*out++ = '*';
+			p += p_len;
+		}
+		name += name_len;
+	}
+
+	*out = '\0';
+	return true;
+}
+
 int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
 {
 	unsigned long long lhs_num = 0, rhs_num = 0;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 0d55edb3f2fc..535b79b1c750 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -10,6 +10,7 @@ struct perf_pmu;
 struct print_callbacks;
 
 size_t pmu_name_len_no_suffix(const char *str);
+bool pmu_name_mask_numbers(char *pattern, const char *name);
 /* Exposed for testing only. */
 int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
 
-- 
2.43.0

