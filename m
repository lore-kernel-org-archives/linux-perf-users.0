Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020095.outbound.protection.outlook.com [52.101.196.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3978C330317;
	Sun, 18 Oct 2026 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289646; cv=fail; b=s8q1GN/pOBWVS1UiWuZIvF3E7Mxc++xTY/dC98rC+OagpVr56Fidbl8dY7hPujaQg2hL9Bn+clyVktrztFirVSwkh1Obwx1kUDYnvxSWyPDB15j62crDYg50a+W9psB/wC9DgtvfVsxcJBuyXTJV4AgD1MgNYFOTyo+o4TU2WOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289646; c=relaxed/simple;
	bh=UncdCzv3B6BDdFKD5mZKIdAaWWlctzYC2mQEWJ3N6bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SrSdvdayEEv38sOxWyNRoz86PWTBEeZMzXynfs/wQDQoRPyvF9+B3ig3S+quCsSMcNtJDWgEMRz7ZqX00UulhodgybUK4YYb2eY0GHdR8B+g7mx0eM4OR5GkfF2/3zlhgNpVH6yGn3Piwtm0x5qXz5x4mPZndvjVS6UDEEHhTck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DedsMvXPyK+3Z8fUeHH96AgFxDKgm7PmL3dRmSYtZcCPKJQZ0z6+pYFITSziQ04uAQvDpLv/MF1zchCa29rhaF17T3pJ6oe+3xfWdSedlOoKPV2gYFX7/RU3m9gDfWpVUNMA2mFowpRq4ihZccS+ar64DtPCrG+lN/3Gx/mzBXc03jEUmxA4YWo4ZOVXWRt8n0R7Kx1g7JkJ5IbMtbdgrCiOa6HvZMCCVjPe7VIZxqpx67Mr0kkaPT/7LiVFKW/s6mLhQUIx6BKtXrgFCjs3hz/FwaDpiMQcIedmbEEoqi+k5KS94hZIkEIvp5QpHAFwISLuThSQbP//fnXIGTIoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=DAGiN1Utf3g8RNjo/we+szk5sCmobmOBhTCcbR4/2Qc=;
 b=HDxBOyBtdpLwdm0HVwcCfkccPK4zLR7edV7fADffiXLdFqIS37XfJ4cp7D6qiQZNiGGbk6hukQscBH4525Trgs/txsNIrN0nNSey9jXZNlOMVynAbNWNNZyo8nFXlBjgKauf0QwHTHP9AQIvfnyj9lXv84avHCEL8/oSNel3HMWy8eHVJ5x+oyLD7kQEJ/slXwmy5/JqsiYQsuDMfTbKOhEbiaTGV7NQSuYTd8vGXfBENu9d5NXRRsNAg7UFz0GcafNaJvYzbKsaA5uLDc2wAhNoUZneuk6V4s99dlijDvTTlC6ofRitHq+RRWIndLAg2wsNV3W93vW81Dv/cpPYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO8P123MB986281.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:805::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 02:14:03 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 02:14:03 +0000
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v7 3/6] perf symbol: Introduce vmlinux_path__find() helper
Date: Sat, 17 Oct 2026 22:13:43 -0400
Message-ID: <20261018021346.582845-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018021346.582845-1-atomlin@atomlin.com>
References: <20261018021346.582845-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:408:f5::29) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO8P123MB986281:EE_
X-MS-Office365-Filtering-Correlation-Id: 30db346b-f605-4a57-1559-08df2cbd7aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|6133799003|18002099003|22082099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ta3iZTyw590LC0vFzMdJH/s3nsiU0620n4WAWL7I3zWf3kh/za7yRAiU3+uRxvRgsN5vvesxMsrWnehSBdFcb4z2awGdfkj8BwAv0nhuE8SlV8LLFD5gTsbFcdyJ4kb1hnhxKILH/dqT01GTjoAwnfK8Wed3hq7qcahr0OKyZHirMOEJXQLwjnjLbJ+PcRycMnzyPTghdb6Zs7EPWvWFGZkVoHsrvSD00sJvzQut69fqeN1S1R5Xhj3Og89KkHkdkAS9Nihp+bBFj0K/hT/b9rLZotXmsnUV4uCofP2RD19Runf9jDvoiuGfMpDuRVxb3IEnXbHDg6vhFBM8xBYK0pOmtAW5S3oXHBl79vBcrUXhhXdnaKCK9cc8R7UnbOeuo1LKfA3hsuYSlZRussaWrn5hf7HADwtYXBKGEJRh+U4Au+xosHWQe3GNyPgEokbw4VOYKlM0IpMK1g4t95+HwuR3htPyFi/Qf0gvtZg3pD3nBQcZ3OQzrjLdij8R94Og3A6+9eB+iZLFlth98i/WWUVnV0oy+Y/in43wLpANR74xe2gIkwP9B3c76xRuijT89Eo+YRfoSlRoiAw+4QT46hNrt4oHX0gvD22BKgRXHUvYChb7UVm2tqoHMJQEtTSOMMst4xeYM17r3ytoRDr/AZEqFkUeUHvG659dQj7tE7A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eydKXJ6htLk1VbHc/6rvA4OPt9pbjfTk7HnAuDJ2wQ+LD4dAcCTdmINga8oE?=
 =?us-ascii?Q?uBG8dp2fQ5eeEKbpQ5YuH4++QZ51R9SlusDZThM7tW3QcKit03hLETXpN46/?=
 =?us-ascii?Q?j9a9TtrXG2y8dAJMapF4v7+z9B6I8cTMMgeAnFZfjYIqsFPJ2R2/pJNM0QJz?=
 =?us-ascii?Q?xmce3aofrrkcK21HHWa2vh6iL59QV8ozFg4ppS0Vp7BF4L/J0SSONfse+nmT?=
 =?us-ascii?Q?diCVH+qdYrcvtsVrwwXbsfYTJ5cV3rCrRBSxyfXk4j+XnYHRtkGPDVhzWF6y?=
 =?us-ascii?Q?dv2oAvj+aj0Qyb968g6z2BbqZKzg9yZQAo4KgwV+A+0mLegoYwKU03Qe9tBf?=
 =?us-ascii?Q?99Oyja+WlkApqXScC5pRZ0rpA4mYPbdLQRf45rzlIeyymo1U7hnH7dxekx/k?=
 =?us-ascii?Q?OzSU1jgUn3wid5rHQYyQ4Hgct3x8zz+c21bmKljrxIqPPhvSRI6MrDVs9sSE?=
 =?us-ascii?Q?5UexNNOFipCVFVR4RmLzsO8gQJEFegM8z40fhEZjA28dPMVqVNsfwH/9HrVF?=
 =?us-ascii?Q?l3+bZ0I/4O6vpTMj9mgxq74S+NdALWVq+EqKDG/OUzxhonsKsB/nlEohCqqN?=
 =?us-ascii?Q?YiD50GYy9S/OgloogAxYcogfjr2uI0KXqBc+Usvkiu58qrcG/bc48tO89Dv5?=
 =?us-ascii?Q?y4dXpHTE6tz/aQlN8Bk9KkzvDcGM1qiLBasNHMScZJC1KRSrLWCFn6i4VkKm?=
 =?us-ascii?Q?i9entCogt1e3T6VI4Bs+e8xOxp7PlhVrW3NveHjINzsDERBJguk5cE9fifpb?=
 =?us-ascii?Q?COrK/VGX3g74taSXn6rt+2UhdDWGwL+zkqUqCIwgzrscPR2+r93r5XjEiCm/?=
 =?us-ascii?Q?+/ADg6eeB4f+6hcJEhsDyIjFkSsSDHcDVMyGbwHqeUIAkGCMx4MqgkISb6Qi?=
 =?us-ascii?Q?sp5JMmA2LbpLPGa2ESwIcWPFU4XOxM44m200ygF5ZeC+XjUNowxzEXLFBwWv?=
 =?us-ascii?Q?RPsIWvNSTRTO+z1XD8LQlv6ZR80HHBziAPrRoOHNQF78/B+hZeXCqFkc6qmJ?=
 =?us-ascii?Q?eH/wgBulgX/R8nKeJrBVGNHwsGXIW3VFTxKx3byYAj/86++Bgw/HrKDUOiWd?=
 =?us-ascii?Q?TfihaiQw7tZFiBMQXpy6i1MXvDjbDVpQZ6o9mXLC0ql3MNSR1y/YifLjqWhv?=
 =?us-ascii?Q?r1pUM54mitGvmMj9bVutzYauRHELi8/Ud9FlLT7skk6EU3XAa14ds8lUNCQe?=
 =?us-ascii?Q?O0vGePK9tZgoGCPhGP2A7u57UVqPonRcDJ7Fe+xPkvhfxD+71atVZ9M+ByaK?=
 =?us-ascii?Q?Ok9rEwzvGRlESAUeiDlA4OrCMn8gFNJJ1JVzqN3G9T67Ti0EQUHg6E9KZ6+h?=
 =?us-ascii?Q?B6oTawBmSS/JrFswVDOtTBX9AhxC51rNT87OnnZ+dEVyooKPKp8+/hzzy3vn?=
 =?us-ascii?Q?Ku5JRYa0AZRkCO4vW/NFLATRhYFZsg22oBuPFApvkKKbTjertxE41oYvHxfh?=
 =?us-ascii?Q?CeBHFAApcRJlZh+hkDZ7guxiPp9uFxB/MWRYhomwWxq86Lmw4EMJ3FyPdi+f?=
 =?us-ascii?Q?qfx8UmBpZ12tWg7ZzT3/itxqrXyz0OBOAt9UTPjcsNnJKNFZZBdRs8LmZ4Ob?=
 =?us-ascii?Q?fOcht7yZrZZQXtQUH689g4T6MrOVKfrnnteTqC4FOA8eYxYxqYA5RfAnNqoB?=
 =?us-ascii?Q?R+/imiQ7QKx29fDiTpnYLwwS6iaS9v2X6wp43TJfcQSDb1dootIRjxuWx9yI?=
 =?us-ascii?Q?aq4g5UI0o/Yp9OIhFC/EOHJH6+yg+/pnUPSpxz8Tz50iNhAfNZHmA2JSxDtI?=
 =?us-ascii?Q?uIzuJ0vQxA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30db346b-f605-4a57-1559-08df2cbd7aa7
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 02:14:02.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5AcyeHFlYq2HsBPNaRlEjcaxtflwRADbQuNb3QlgB/tjPy+l66dOgPcc9av1/QLjAgx2hAcpcxfxeckMrKsOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB986281

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

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/util/symbol.c | 30 ++++++++++++++++++++++++++++++
 tools/perf/util/symbol.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5d98888d068c..a46fd2f3f6a3 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2390,6 +2390,36 @@ static int vmlinux_path__init(struct perf_env *env)
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
+	if (!vmlinux_path) {
+		symbol_conf.try_vmlinux_path = true;
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

