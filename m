Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792983491;
	b=TzLShL2e3+J47myE44/K8z6Z5b5gad159ltTSkaDpPM9CZFlQcegZPQ0LiAV/3Eemp7t
	 lsjxGHE4j3aLWfHGoTgNh3k7gRArz+Vx7JFoe4MSSbsR2JlIBJ/EG1J6VyW1dMZ9QuN+a
	 AsjdyoxuZUHzOMFLirOODV5pBIxY8mm16bY84aAUneUuhf3RbbKK+02l8+ZQ3zJIcpuoL
	 Cs9iin1iPrdzlmgqdM/566yIT/8hSRaPIXhakHXTv8H028yF/8DSMfTh00X4cUS10piY+
	 AtHVFG6X4+rUJ96D+76XQeC4zEz8oLi/yco9zIE1G3M7sSeWvlLiBanSfgKV1+m6cRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983491;
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
	bh=CYRLDpusJg0d9KsxMCl4z+6VeJtiw7Bf+EQAANmo6M0=;
	b=E+Cx/4vquul9DVFXZiGC3U2XiREkR3US4Ec8RCXzI2mxGvuAbfIxTz79GBEYCzRvBzw0
	 VOVz8u2/9m25KztT1OfaIcpfY8UduJh06AKLAIpAg11Gy4P/JWl30mV3v34f0PyP8kKQN
	 uMGoHlY10aLTluLujqPq1+8ZGKeCZXo6c/Fw1756P738LCmsO0zkMqdB4dQUcvN0DQ3wF
	 Gz71Kjy8+Bs95H8Tbw1ILcmQ72shPEKVylPJH4ZCzJbaz2wau6R8IodypPR4wK7KIRMob
	 HUsoYT5QnQZ2G1OX0iR5ItQtSAEa6nGRDaX9UKnb4ZlmLIsaasTbmBXRXJ2AOTD7T9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.77
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021077.outbound.protection.outlook.com [52.101.100.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFFA606A31E;
	Mon, 26 Oct 2026 02:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CFFA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BO1WStCfrpo8Lehtqq+2tx6ILPmiMtxLcyBND4lR4GF59IFzCfXXL6p0GI2I+tdDEamUp4et7dZFc/ktvQYQlNO7Kdy5YVzPIw460MerefHmvmjWL/9hxyG/NOGoNX+qt9tinGWX3Uf7JqJbP7WKPIuXPW0T9FShK+dAlPZAklCHDAP8MOaTpcQzYOaPb8NrPd/hvya9Rnynh35htUsrmRRYv8/g0gj0TQq/IfKDGWFptPzx385SQGcOdwpbKA5+VhX+yOVCoUs2RMaCnBd4f4B5qJnRPYHxLL/g9gS8r5xCmYgjODQ3S3rtT4sgkdTHB1PcCYALPbb96sBFC1Owbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=CYRLDpusJg0d9KsxMCl4z+6VeJtiw7Bf+EQAANmo6M0=;
 b=aOo8LvSFoyK0586PuoZIHs1cXaOYNZFGnOlQFhAwyHLng5bCO08gas1zU5vKy73Xb8ugdSjQ5VF1KU0vUpR5NeCVDcQ9uWR65e0fuK+vQsvTf8wYDp9uFjuWWJOXP3YXxQr6PYOy3tWRQc10GJ0Ppau8/tPDiNj9B8XAwjtEewYzLW7K02EwDEwvzdpLlnUEZ1UcspEEaEfAfL1ePawsPEK4pSQXEHxxoPqbmuPbOf9qyNKHqxo8hAOUyNvfRl1vy5Ui3zQmCuZ77PlPpSm99b+dFe8vFhb36cJVg3Q+VgSUFM8ERWKErfQ5TyA20FHYyVTlzGzxL8ICVKU0sT+0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB9009.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:285::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:58:09 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:58:09 +0000
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
Subject: [PATCH perf-tools-next v12 07/10] perf symbol: Introduce vmlinux_path__find() helper
Date: Sun, 25 Oct 2026 22:57:32 -0400
Message-ID: <20261026025735.546101-8-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025735.546101-1-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:408:e9::24) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 3919a352-88d2-4c7f-eb6b-08df330cf72f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|261009223027099003|261022105027099003|261022115727099003|261022075727099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Is2YpkebQ5FkcoOzjg6ea3dJ3MkFJXJdCPFg60Uqdqiy4/Z7OESsdoVgFVSMzLS25eIAcDO0dcw4wf2UcpZ0VuGSGYwd2msHYg9OCwv2nVecJ1NzeBV8whnRraQ1sMXrmZk6RvjQIU7Z1mcNftfmhKiFmHMUDacHsq4mhLrSxS7qOwj5cLOwy5paTD0p5cV9QZB3w1HAoOobVeZlEL55NpuHXRoU+NC1wAbz5ifzX7jAVpgmAqeVNPBI5ROZ78ruZBKuQ94vhm0d3eRXU6e0uEdCi84Hrk3xGo5ZOMnJKdiMt8ATh2BxuJ5ap4jBxNq0u62SzLrZcL/7RV7CyKD5BvjoGKkDbgkT6ooPgmqhugGmxJIiKIMv/F0numoTlKaoX/Xs/1MS+2CGN8Wti82G9WNvU06TRaE9ABAFfAaGeLB15ra35d5GJw32cTLKChrDRAE2fN1BuHOvmNsQfY9GxAA+EKdeK46GDbRimSEFLAfjSNuBfvahjK/ppOyuv5oVa2D2vCfkG/sUNDgAglWgFaimOYKDgXzPYnDY3CdH6bQpVmSgY7/j2b+Sl3xnMt3QE4LQOJbMgqzlIDRd9HLkIYCi7ReY/w5yUISy3uKyKTMmd9WC831jAFhW4jNIdmMhGYkPR3bxM2vOr87nwfQz40+8ko3WYE7ereJ+nKA5Mbk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(261009223027099003)(261022105027099003)(261022115727099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uRwHPR9Nfr4CE8TGcxzV78iYSa39d0pJnh4r65emL+uyUAjGd4F9d5Dsyy48?=
 =?us-ascii?Q?xEBUiGS3VPGCCXGzBBBILTZxJt7nhTQcMwXF3AbIuV3ALssxXs6L1H5kFUIB?=
 =?us-ascii?Q?Mp2dD1s1Pa1FHFE4CEANYWDePkhIDEkJNuTWKKMmD0dcyqmH2qgyLhM2CWLY?=
 =?us-ascii?Q?PiOgciRW12oUdPIlUYTxdlE+lPHOxStEtuxPzpzUEtU8kadyg8ffgPX9MFL1?=
 =?us-ascii?Q?6Cb12FI9NCi4Wj2Zl8o8h5LfA3RqMqawBEnA228QNjqO6FZfFIA6aPPtXqnH?=
 =?us-ascii?Q?IrZSvaF02DyMFzpN/IOxU/GPBDyxFOTGRl0HouKrHbqAiOJtWAwxqVubUY23?=
 =?us-ascii?Q?r1Y7z7iISvweLwklG4Ain+wm+Pfwymw+2zNmmBxrZP8ibB7Yr6y9vSCuztwo?=
 =?us-ascii?Q?F52RiCAhjFn9TfLignLuAxZ+i+s3u34OwcTTk10QDg7nN3C2VEumLE0D1aAp?=
 =?us-ascii?Q?hrtgt04/sjlYfzmI+j8Ld2QnBxWQ6jyyEF2MdaLGt6XBKRtkzniKwkYyT5AB?=
 =?us-ascii?Q?Q6jqRIBvulTWSHzb7Qje3KDX3cPazIv1WgCdhF8ZlJk57qLxsJLRtcovIx67?=
 =?us-ascii?Q?O5DFUCbZH3rg6cuqAyAePsAG70pCjXt/xiB5i6ODOW6KYyHqs3QCsbN+DBl5?=
 =?us-ascii?Q?I9FsuYiicmOpnJsMP2M/WJvCRhAkEIPMBHD6BnhBkl/1oiR/7OiDflQaKMZs?=
 =?us-ascii?Q?MOhkI24JBmiTPpNhVwWpz1947xEmd75DLk088NLraST24gZgW5uB12qIwL87?=
 =?us-ascii?Q?XsbAdlk927cAJqk7lPuxpsTPXyIUYOc7rZ7h9mW5yWLyYP+fnAmRs2xMMdbM?=
 =?us-ascii?Q?VaZQ2u/KRNh4afBHQ84w5fL0vSArNBEK7CpHU5q2G4A5iUKsFsmLsqxZoICy?=
 =?us-ascii?Q?tZiDYKV3Dyo3o96jVqqnhNGA8HmF1LCiCV9bkQUX/DogvCbm/jud+9omzcOL?=
 =?us-ascii?Q?nCHs2RKXANo0PSqoGItfLT4lFOAGip9PLT8zFA/g/MQI4LdgEyTaYoymbTek?=
 =?us-ascii?Q?jdb5TFA1ncSCs/JDesmPEO8xg+zPx6mv3jgQQEThBmYiivf1Wast/5dmY0Vd?=
 =?us-ascii?Q?VzjCIuG/IeYBxwX3mtJPN4cz7HEpiEmhMTjLddlbr4fOVqWMAyJDgBFEKQqi?=
 =?us-ascii?Q?L551pTiWvNL1sz9FslkdzOdkIYscnmB37nOwPqnmMfpuGtePkfTWweAJiPRR?=
 =?us-ascii?Q?PNeqyjutZ9NrVCYRzVzJ4PjMyyrhTyFn5YntVscHS+5vWs+kS9pAHMq1ZWut?=
 =?us-ascii?Q?vFWH3lQ3776FpROGMOeIiUqGi9Uys8tDpmaM0zCLPEEqdTvDFdiukSd2/J2N?=
 =?us-ascii?Q?WnXXz330fc4mqRow++qmwAVrVCAvT/59TgCZBNCZ2R0fFYkPx9E61+eanYDC?=
 =?us-ascii?Q?JS/GSG69h4YvyoXvqh3yngNJ0lnnNm2419qfk/cuSjv6NGslzJ4X0XzNCkeL?=
 =?us-ascii?Q?f89cpGnDEUCGI0aih9h7eEfolfyq2WtvU9ZtZX09KkgTLoH6DQVHzDMbVjK+?=
 =?us-ascii?Q?8UMmnbXOoCicOfmViCrqWlTM68rkCQZnZylx7v+zn4GBja+usAig67AoMTc0?=
 =?us-ascii?Q?Dy6rCB3wOW0x6dDYTZq/Hq09Ec518QdTNz3TPLqISQBwrB1oPa/ejNHz3yXq?=
 =?us-ascii?Q?Z6N7ZujlJGAiTg4nHS2ETPwXlAV/ZbrFziYh3dBilubwyobL7Q1r0ekWPdmm?=
 =?us-ascii?Q?HKRDUjk8pgkGdbD/Pe7HgADlzJYqy1Uwv2FoF529arrkkkcpYyOrssHkza9T?=
 =?us-ascii?Q?CjP7PC+hcQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3919a352-88d2-4c7f-eb6b-08df330cf72f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 02:58:09.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoM2mt75vvHI4V8RpO21kSBBHgByJqVgL5NiSzhGwVbIwk5hj+zATgQdKse3s3FrfU0KR5y4FDmZYvlp0Aa3CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB9009

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
index d0bac824c79c..6d1eb08076ab 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -184,6 +184,8 @@ static inline int __symbol__join_symfs(char *bf, size_t size, const char *path)
 extern int vmlinux_path__nr_entries;
 extern char **vmlinux_path;
 
+const char *vmlinux_path__find(void);
+
 static inline void *symbol__priv(struct symbol *sym)
 {
 	return ((void *)sym) - symbol_conf.priv_size;
-- 
2.55.0

