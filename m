Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.96
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655693;
	b=xs+i4wMnZqfuMX7Bx4776U3YhpZuG8aR/Oms1xPLcyB1hOVwiVW0rf1yWgzuE3wUVrJU
	 XHw7CNHAmcJIQtR3y9vE1cvulu6m2HrHa1FC8ymTPHrTztgwRfgvSFXWUGBz7XEYmdNzp
	 j2q/9QOw9xmf+UWYS7rFcJEBWW3d3VRP4SNt6ss5qspKlgqLkQflQXnVVh08qBA6WxvjB
	 WxMdbWZ2ecLAel3CVgnirGZEBz0PAwxhxXWLPbDPI9tlLubXXoIB0K5VFgnkSOUxHAeM8
	 DkGBzA2XFA7uDlZDw93ngbreCpEoXnxtxVSrJ5KiVPbU6i0U1H2cT86UPvKSouWRaag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655693;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UAVFi7ro4xQ+Ly5fHcgFvb6qTYUE+HPBris3NHn6RZI=;
	b=P2pXFDTdH8l6WB+eueW8cFrGlJtvhdTjX0sbyyN1F6YIpgsAYVE48hBXHE48YWSddEPZ
	 RTjm7NuVzaiIp/Pk5SNgidM1oW5JvHZ2PdQS6uCmwNs87DYhQ7T62smvNdLO8uJ3s1l0o
	 GK6yzXm/mtq0jEODTf12eJo5RtrvJQuFgZ0u3HCmP1HMbhr+45qA3SWG72L0IeGedsZHZ
	 l+fqLlUzNu0lwAxwALMdADqG1FhfQKCZiZtM0HyIXc72d4Vey2Kisapgjtfw+mqaoGTJr
	 /IZCHltEvAmEMboNhvj/fa4o2sluml9NB18gw0mgvcnpVUUHNvEHFPb7xW0KvOkqTfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.96
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020096.outbound.protection.outlook.com [52.101.195.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A5606A332;
	Mon,  2 Nov 2026 21:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 548A5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcNMcPYy6ZtaVwbB4vob8FnDfSliQfAetU9b3bj6jI9gMIacPkmtNEwmPrXbOiJi2URUc8EJ11LJDKO3FbWxSbRcfsD1H+xm5yj5uLzrQep39CF3bbbeFM1aMSREqL26MyKZ2xR/M0dG6k/TLpj/xsr3uTpo4X35rPi3FeU7o31F9T5vPUqArPXqDDtibhKN/ZbiNNGEEfhQfrtn5vlf8vp2byTHhAe2K02oK4ZjU7ilUvutvf+Al7tSv0QTGlgjcEORmTTGSmRw/FUVsqI7vnPYVp0DYh6WKuU+xUBb0/M6lWJgD05mQFgxjlJIw9XblOQCBHD/eu1ZeMRMd093pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=UAVFi7ro4xQ+Ly5fHcgFvb6qTYUE+HPBris3NHn6RZI=;
 b=m6DrCIH9dJnBv2nnC4vepLr4UHnfeeYhA0axdCuQTy857a8p0rKgtgAKJqtrGguWcaCSclmiLZwvXqB7y7TLjh7sxHQb0WAAiCqkD2R3W0e8OWaL1ahFvYjWTtosjQK6OctQSRuHwruAzYx069/vnbLm/ECsLuRQBGkEdMiDm93AQFMN5y+m1/xNlw/N3V3PWO6yBLjC5Y9tVsADjO0qESLAK+8mpF6GJGV/GIjTOFEOomiVFY7wGe97F5wcdKqYzpPU2fxQv6Rh14be77Heq29K/RkUaISkOA6sN9ft549gLBKJq1vdvqGwiIqlG4atjfFxNs2GGD7+zXbCBWze0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by CWLP123MB6106.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:41:30 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:41:29 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	atomlin@atomlin.com,
	chjohnst@mail.com,
	neelx@suse.com,
	sean@ashe.io,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v13 07/10] perf symbol: Introduce vmlinux_path__find() helper
Date: Mon,  2 Nov 2026 16:40:51 -0500
Message-ID: <20261102214054.911298-8-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102214054.911298-1-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::13) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|CWLP123MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c96900-05eb-423a-43ff-08df392a0e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261022115727099003|261022105027099003|261021121427099003|261026140227099003|261021123027099003|261028144727099003|261022075727099003|10067099003|261009223027099003|261102123227099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QxIGwKevNNNE8WCoJjJCDQ+WtK7QoboylZipBHDdU4nEi/uBdfTge2B970BQMYRddVc62yrBDXcHu7speogeGzCV6ILzebQSB79UsS3nP3YCVQE+fy7wDCWUhGc47Jmtvqqpj30wDpWvn+Mpoi0WKGrijoUK1+wWfUIhppKm7f5TxEsipIqPKefyh/kmQpN3twYAUa1OemTOI4/A2mduz4wgtHf7CDKSFGjukGwKG6eqrW1cmtA9W6j/GnKrYNJBRDp/DMTPhfPdLs5UgWnIt0Jv9UXDa8n/6kcbDNaKVCu5aKEMyRdtIX/k9R34olAc/lfs/ZPBTDg35xbuPMJ8JHAPPGVpg8OUD/WbmfVfKJAU/SIvbi45hy+WZL4NhLMli10idMg54oGok7eilJPu0GwBwDlMTjVQZetqwrDslIdmd/nCRHoJpTFosbQHGcFuHEz3pMemIibF0eMs3HCNBQL3BfZLhK+o3ei2mtoqbrrPHuFDqdQyu8W0CD8EvDLooXXQB3A3vzLG/rOmWk3AA6x09BitBoCgHOVyuRppeHkAa6ZQ7Zgd/rCKiojxVCvV8fqlqU41rTolSOUNVctpwhEoV7iysNKUwL/wrJpGXkdBXLhjgQ/ia1uw/B32/RD9oAa2dX7qj7QzxPSNLsUEAPUYby1XScnOcEQSD8dPhQc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261022115727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261021123027099003)(261028144727099003)(261022075727099003)(10067099003)(261009223027099003)(261102123227099003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yXXTlgGDv61IGYUZFGUxhDlgmlsAZGHxJ9o+TZLc6FMbFAgKC+Jk5v27DwGz?=
 =?us-ascii?Q?BiivyO1C7SEBez9pzQE/OuZpfjYAXLZLStUB2TduvVFksvlqsxpNLkna7iGZ?=
 =?us-ascii?Q?B5orRy5h8hZrOCcivVDLeaDF5J16xvxutTFzVL/0EOjHE8dC+8i4rZgVkgNC?=
 =?us-ascii?Q?NebsfQJUytjTdXNc8iNd8NCufzt/3sb5rrAzzGgahfuW3bb5f8u5RTuLUp5B?=
 =?us-ascii?Q?O1uemNUrPpH+AcmM3l6FsgejB08y2ziJEXnW/gAuDlyhU3di3fhtvXC/ZRC6?=
 =?us-ascii?Q?FJYTSzdAb9QUc2Mct5pgv2qAYahg6T1bMaza2qpD8QwMpNEazVWhvP/0N9cA?=
 =?us-ascii?Q?PK3UOB/4Qvm5ejnjIgS+JFt5pio6Nb+8WLNjlU66+EJFMyJ4BU1nCrzXAfjK?=
 =?us-ascii?Q?CjE9iUPaGidG95zQ/6PaVK5rTzI2lqFdN+vVddLRqug/RaK9GoSz3hb0L8mT?=
 =?us-ascii?Q?7VMTnebaye6sZGWdWwblS6ytjrWQxQiEdkxCyuQvYo8MMNtcg4pulkPN6n+i?=
 =?us-ascii?Q?bSGXOy1NtemoqWKTXCtLn3q+Q1r4t+HPGwqxorVTixHuPJ0EQJ6HzFsQ0wu8?=
 =?us-ascii?Q?FZ75UZZecOlOxiG5OqLSKm48LLUbHYX0zcZdg8G6y/c6so9xagyWi5tGnyq+?=
 =?us-ascii?Q?jC+yzm/Et4IGrD4DFvn2/AXf7ZWIqUcnw6Sv1wIqWSotGpyYaGDNCnTlQuzO?=
 =?us-ascii?Q?PvTCbqm7UoHJGOflWcuOs9pztzbXp7X73as/4ejYJAc42Mc97BJITi3qC+vq?=
 =?us-ascii?Q?utu+TqIM+j+hqY2JcfxiJCejo0nDvZVSD2u0YE6fjnYRddvacBJftw77NAz2?=
 =?us-ascii?Q?iwl33QGDcjdASblRQnxIxOWnRtulb2LS46QX3sG8FQHB1edMyMtJZKQAFifL?=
 =?us-ascii?Q?se9m/aAFhS9/TdfbYZqEStHGviGYNBRY8oanXBN8Gjkg4kPtaO4KSc7oTPyE?=
 =?us-ascii?Q?VwA5iGmS2XV81DxGduDhzyLFdS5mX+/y7+dxrvzw1usFb6szE8zkOTMvbGHk?=
 =?us-ascii?Q?MV1UwDQmI4g8fK/3vLcJ6wR+2qcg4Z/HPIMDrj8R9FOPTx9Fks5/d43zxI3L?=
 =?us-ascii?Q?s7mLKNc4mXcDciR9XPBidqFfuL1JTILMfXDFGaCybNw0BHdMXZbE6l5VgAnD?=
 =?us-ascii?Q?Igg3REs/bWjuqYYYvSJqokKPpjraQPRHKAhnML2JZfx4gjBlrWd8tvgApYn3?=
 =?us-ascii?Q?sXWFsZBaJHXS4pQnJwEM2/D2zEGyWWrLVHX26jYMiuNS/gLGwD80kCOf5JXl?=
 =?us-ascii?Q?D5A84YlLuMcCIPlP8PXU7a9U9bJTvLiyhJTLe70Q8ttolxuEKiX88K+seksZ?=
 =?us-ascii?Q?gCEgbICIleyfrhSeQ9KdKBjZdntC3UFNCT48PlDCReb5IS0/eOBfeY3b1qIv?=
 =?us-ascii?Q?ogulZd39IwhY5jnperPoF3BLn/6lwDM8FyZe1SaYtGzTxXhOSjmYeWM5sH5c?=
 =?us-ascii?Q?Q1QPV7k4YhrKHnzDWZfUyjbNoFkddVPk+t0wdF71iU1lxxrgT30v9RBUwzT4?=
 =?us-ascii?Q?gkh/Tly8qgzpc7nBnKakHFp8ybPF4keOsWIw9W02kwgPeqjvScqBkXlkRzTX?=
 =?us-ascii?Q?HWDCoUNYOXrRizkO+DtAAhRLPl/8ZBr1CeHVt1g4YwHy5t1ET65v3UAzQFL9?=
 =?us-ascii?Q?aWC6chMm3A4qs9fW7wwA0OKsrdpQXGO15kwaaJUscvnZlvfZlEHtZylATeio?=
 =?us-ascii?Q?L0ilVexI4crzMDD0n1v2/AkgeeNC4pCZYdolz/BcXI/tRTlWnpDQFeT/c0qx?=
 =?us-ascii?Q?rjzdJXxYMw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c96900-05eb-423a-43ff-08df392a0e06
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:41:29.7995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEmxdma97IIo+UOUWBj953GjDHKYn8D+Amt98jIArOa1emJTCpDLTKfnbmbMkaWEP7QTVscsKXADWIfaak3HaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6106

The vmlinux_path array maintains standard paths used by perf to locate
the kernel image (e.g. "vmlinux", "/boot/vmlinux",
"/lib/modules/%s/build/vmlinux", "/usr/lib/debug/..."). While
vmlinux_path__init() populates these candidates and dso__load_vmlinux_path()
loads symbols into a DSO/map, callers (such as test suites or probing tools)
often need to verify the existence of an accessible vmlinux on disk before
attempting machine setup or test execution.

Introduce vmlinux_path__find() to search through the configured vmlinux_path
entries (or symbol_conf.vmlinux_name if explicitly set) and return the
path to the first readable vmlinux file, or NULL if none is accessible.

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/util/symbol.c | 38 +++++++++++++++++++++++++++++++++++++-
 tools/perf/util/symbol.h |  2 ++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b61a574ce9a3..fd4a4441718e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2337,6 +2337,9 @@ static int vmlinux_path__init(struct perf_env *env)
 	const char *kernel_version;
 	unsigned int i;
 
+	if (vmlinux_path)
+		return 0;
+
 	vmlinux_path = malloc(sizeof(char *) * (ARRAY_SIZE(vmlinux_paths) +
 			      ARRAY_SIZE(vmlinux_paths_upd)));
 	if (vmlinux_path == NULL)
@@ -2372,6 +2375,38 @@ static int vmlinux_path__init(struct perf_env *env)
 	return -1;
 }
 
+/**
+ * vmlinux_path__find - Locate the first accessible vmlinux file
+ *
+ * Check symbol_conf.vmlinux_name first if set, then search through the
+ * initialized paths in vmlinux_path.
+ *
+ * Return: A pointer to the path of the first readable vmlinux file, or NULL if
+ * none is accessible.
+ */
+const char *vmlinux_path__find(void)
+{
+	int i;
+
+	if (symbol_conf.vmlinux_name && access(symbol_conf.vmlinux_name, R_OK) == 0)
+		return symbol_conf.vmlinux_name;
+
+	if (symbol__init(NULL) < 0)
+		return NULL;
+
+	if (!vmlinux_path) {
+		if (vmlinux_path__init(NULL) < 0)
+			return NULL;
+	}
+
+	for (i = 0; i < vmlinux_path__nr_entries; ++i) {
+		if (access(vmlinux_path[i], R_OK) == 0)
+			return vmlinux_path[i];
+	}
+
+	return NULL;
+}
+
 int setup_list(struct strlist **list, const char *list_str,
 		      const char *list_name)
 {
@@ -2598,6 +2633,8 @@ int symbol__init(struct perf_env *env)
 
 void symbol__exit(void)
 {
+	vmlinux_path__exit();
+
 	if (!symbol_conf.initialized)
 		return;
 
@@ -2608,7 +2645,6 @@ void symbol__exit(void)
 	intlist__delete(symbol_conf.tid_list);
 	intlist__delete(symbol_conf.pid_list);
 	intlist__delete(symbol_conf.addr_list);
-	vmlinux_path__exit();
 	symbol_conf.sym_list = symbol_conf.dso_list = symbol_conf.comm_list = NULL;
 	symbol_conf.bt_stop_list = NULL;
 	symbol_conf.initialized = false;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 3b850cdd9ba6..d7b10199c3eb 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -182,6 +182,8 @@ static inline int __symbol__join_symfs(char *bf, size_t size, const char *path)
 extern int vmlinux_path__nr_entries;
 extern char **vmlinux_path;
 
+const char *vmlinux_path__find(void);
+
 static inline void *symbol__priv(struct symbol *sym)
 {
 	return ((void *)sym) - symbol_conf.priv_size;
-- 
2.55.0

