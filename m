Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792877180;
	b=xX0Qabio/P894byrUaiFzBdST3lJAkWiLlL9lILAHbSep9DGbAKn4b8YnO0b4G55m94A
	 ffqBhX0YlK0Y86pEu2AhXKxPfB8Sczo4H1XaqcKWpCjKIw2B9dDuvehPmUi2ym8dbGfQS
	 DO//hRAoRLmz7yBcLWsdwk6Jk+iMKr93jhx+b6vC5WPZXrs4pEfJQ//ZiteR5uzG+C86P
	 /zwTcIJ9cjEBugUQMI9DgBldbP4L/6wkDE8TD7Qkf8EIbCoUdFPLKitzXDxcZ0bYTNtbI
	 RYm/MRjMQSkVN+pEKfpHsXip1V/O83Ju8Tq9lmz+3jkhCh6KCM1ZDpKmgSZ34VMQVIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877180;
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
	bh=rKnL1h/NUXkJBkliXBl1Ur+6R10J1GqhjH2XR0mJids=;
	b=2NzNLsTPzuOXy8Qewwa/AsZaM73oC80fPjuXj/FMUUrXDbHYUGu9GhmlAfhzrWkIbzWw
	 qBd4rpXCHV6SBA4ZKVr5GLOlwb/HfC0M7RTOAOC6ogCePX9y9/P+R1MDs+z6frlyDAU0M
	 JwmLEKCJWuhzb0szip8HnQxf8bLjVp0bI6640FghQT1G6F6SEgF8BIH3XU5OJHbrzmfEu
	 cNu/fV9gn3YFVEdzESow5kPDRwXWkgonzXCndLcJIGIHzLisLiwTaoy2j65a9o3dpr7n6
	 VHBbRMp8czpJ1ppNpdakinWAeIlka6RZAQN43f4w1p2YE1cx2G3xX6DxUwChloIB4Tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.136
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021136.outbound.protection.outlook.com [52.101.95.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65525606A326;
	Sat, 24 Oct 2026 21:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65525606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7wCDnDzX6/u4VAuxLQ/q4dJLemcoQg/yMOuEO9mPuFqucnByQmJt/h8tao78RKWAqGZZ7EhmFLUTzDOuJYWFX7fjh6PcJf3nhZqWg9hqdpBa770wYuYXRuELWwfVqhDYiWhNsuT/hx9PYnbqSIegHTy7ptCv2gy0+CIQ2FVNATjY8fQWUjb6gHkC3WbRi+tDUfX1NhqjEfg3VqpcLODeFZT9v5b4sggDFrmjcwkE67xOig2cqqwCK4vaA3wCU1qyyFvtxkdnwqt5306I+ZvGzsMDe3XVZaKjuLHMGMHffpW5mX3xG0ww5abEsks0Z2oVYLlEmSigPnbCfL8MZS7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=rKnL1h/NUXkJBkliXBl1Ur+6R10J1GqhjH2XR0mJids=;
 b=yChCBREN2vWarEQOa4AsNcQRfgh+u/9plZuHvd7p0+g2vlJuiHjqtRun8GbbWFyigoRhGHAb8QLrN+16aE0Gba+yhTqgkx7EXBGCTiNS+a95KlI4MPwWxzEN3CYayO6OMZ4pMAivWTKMq1fxKaavfYdM18C7fpHcA84bvKcaBSdWfwv98F+e5k/6NjUp+u6grFWUQSzh02RUBQe2d+LsvHlu5kRDguhJW21nROHshzFV2K8vg/CroZV52a5ekALqVo0P6NXQFyN0n8pChN9P7x4MuADaYo+TTX3LjnZqydxmleVML683jN392DdFExglQ1b4zdSmByJCW/JiJHPPFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6642.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:273::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sat, 24 Oct
 2026 21:26:19 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sat, 24 Oct 2026
 21:26:19 +0000
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
Subject: [PATCH perf-tools-next v10 07/10] perf symbol: Introduce vmlinux_path__find() helper
Date: Sat, 24 Oct 2026 17:25:46 -0400
Message-ID: <20261024212549.450634-8-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024212549.450634-1-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0576.namprd03.prod.outlook.com
 (2603:10b6:408:10d::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 7643fe46-25a4-4ecb-82e9-08df321571c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|56012099006|261022115727099003|10067099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	fsMaimEOFmsK9/d8k/340cX1SfM1kgo/ehRE5WnNfFlUxE4WpdxLjxHPT8cLZ94HgC6+lmbW5AmYM7iBeNi8Opn8apcMyhz62Z9oaa1J942uOsBIjEFsEIjXJaCuGJgHwL42SFsLF+1mQuVc3EHoWWfxE7Dh6WmoA/TIxbBgw9h9HFIEDXwO0RDiGdzgXryB1rNTuqM8zO0n5mtjKk5LeK1btfWyayUZ7LVM3Mhae8m+t3ccoW2N+vRhihZp0ryMGMZtX8rnpPzUSVZ1tbAxIgc/cN3GWHiOCJw6y8VTpLAKvUHBg5LWk5H00yiqFMSMPzGH+vzrt9d4Y4isPj7wrptlSbR2zcm12pB8ZvCmPsVQG/kkKgVFwf96ZXbapF262z45EM8oCxD1gaxxnP+1q5cl35xEPJNSun9iOH2/REfjF70EJJJUesu4NYwTKS0fgkw+lMC3lxz0pVzWJWYGtq9JAOVsbOzA6WxJyiQylmxP4QoJ/Jjz4xazT0qz1+uL/H5QzDJqQ/08NUGY11hrcmV2EgQ2uYiG/n3aAZPv72uJcHU4Wo/h8QgVbvikNPrJ/Qu8ptD0DHmAsbRMx4rvTPVFJCerO8cZUwN2gB4vxHTpkIZFQozS9oUxpkOY71HTJ35SqstDVI/utZzwS2vTxEKbUpG9OipgXmi9Zb2TPCM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(261022115727099003)(10067099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zY4Ugqj53fpQ0/UqO7QPMmW+kJFkNn5mP7iD1+NG+VgdLGbQ7H+OO+DmjYdA?=
 =?us-ascii?Q?qsDQlT4nfQFs67cVw9ULLNkrS6TulsPr6ZOT2LNviRRiLnS0gK4sowtyQH/g?=
 =?us-ascii?Q?PiRRafH93WENxtAIjAZiIocwvKGgnmJdXyPrktZ2v8Yv0K3FJtFWzBYtrUt4?=
 =?us-ascii?Q?Dr06jT2cIE8H4XEjvXsJpXarcexcCDbjzvZ8J3Exrp1lbqJU8JlQTqMtez+S?=
 =?us-ascii?Q?Y7/fimPk8PGOU6JNbjMIZCGQ2F802ld9ZXUjlRgaV8oNO8XC8bHHWoICyhSg?=
 =?us-ascii?Q?W+IwnjRDF17eH3QVGInIZ7yQPvvqYG7blueaoSL2RMggHDc4qNjG0XRdZeRk?=
 =?us-ascii?Q?OB4GCPNsZYDUV95+pmgot5uSR0sXb7i0/mpv8Al6QpROyuU/HPdVKgTIIamc?=
 =?us-ascii?Q?H7KLg9BtV4sEqN4LUg3ppPdbTAyN4ZLGrIcIcnYbf2S3iRwr9EYW6R6W/J2C?=
 =?us-ascii?Q?+DR1tENtbV86TZwTNf+oRyuTNXSxidhXw88fiARTubppWvmhPVVkpsupD6K6?=
 =?us-ascii?Q?TH6oxj6HxYI+DNY7LwEpFAJh9F7ilGwuJVPkJYguG60/+4jwaTBBmcpqlI4X?=
 =?us-ascii?Q?Mv0gV4oArnP2tiZTZdfbjf+YB7SzMwByXk/gAu8bQDW1XVGp+gt0Xz414bEZ?=
 =?us-ascii?Q?XyQ/MtxjF7ohTwJyBCsK7km69B5LtobeeCOQcbKZFRH2VufUjo5vQWNbDMSL?=
 =?us-ascii?Q?BPHhCGjDSojldZ9/kmSKxw9q56OnwTD7Fpk6APnlgfN5HXlVFN/eSAaViINg?=
 =?us-ascii?Q?azLKoFKTbGILub5GqG/2qUpPJTKValHiEebvyj62EtCv18PmiPrFNleaofcJ?=
 =?us-ascii?Q?a271QvxFmf6ZsWjvX4Ea0Y6K/bky2u4sCOOAj6BtBNLaPKn7D52xLLlS8YWc?=
 =?us-ascii?Q?9VRNDXqKrtR7fzgU/Vyk1edv8Jd/sgQjPmjBy9UMvDp08xM4nX3fZAr5vFVw?=
 =?us-ascii?Q?itzwWNFlzuK81bCSAGe8RAeGo31Qp+YQYtJXgMtJru/K7lohzaLJR0gUh58/?=
 =?us-ascii?Q?kbH4tyPLGfHnGgJuXBGzmidxFZ861SVZz/OVSxV7AbwBTbMMZXYXpxhbYECd?=
 =?us-ascii?Q?7y2QKpwOXq2tIP5cS9gEm404zNMt71J2sxVaahuojl0LMq6bT0IhDiRSPG3G?=
 =?us-ascii?Q?ZHXwV6Pm95nh42VdjhJg4yOgOkxH1zGMrRkuYdzQliK5fyhZ63ziBnE9g+yJ?=
 =?us-ascii?Q?Q558D3/jlKXGwGCKq960QwZQmcIEGghCW+doBBSUyK8Ui26+71KuwfuH4KPm?=
 =?us-ascii?Q?duYQS03a2XaH2n0UKyMzx6HMoXK88/SW2JBPtjmmg34sOADTzbOzwZWkB7xT?=
 =?us-ascii?Q?q+BPVpT5UUbbmPPcdu59QLzM7jE7KPEqApoFXN94h4QeTP1dxv7Puax00ndq?=
 =?us-ascii?Q?GuCgMJSwvEQxNxN2G8JUB11MnIllkAMBcSH4nu3WJwC2CheRuMBJ+fPnCUQp?=
 =?us-ascii?Q?/JLA2U2ElvyYfyiMBisftF64br09pWwo3qtr1Yh14HGdm9SEINcInJBXWgfm?=
 =?us-ascii?Q?nXR2fMoTVgOv66bsxOu4JiF51ANAS4+Yg6pl+bSTMRKcnxSudzTN8HnEGVlp?=
 =?us-ascii?Q?hwCxMod0F63G32AtAUGfYW6+z+aA/PuaUHKey6oYUzh/IZen2Z3RkGMewZ3Y?=
 =?us-ascii?Q?jSBqy1hdNS3H5ziKaz4Ro697p7pC/OYmDHMhmFLXkw/wmYxgEksq83nQ3dNw?=
 =?us-ascii?Q?7SYkuBrcV7DyQ/Wp10IJ8qR9DuGgonbaBjwXaDXe9TPnUGwL5RjIBFAxkw63?=
 =?us-ascii?Q?AQp9MTslJA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7643fe46-25a4-4ecb-82e9-08df321571c2
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 21:26:19.5722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPKMMB1R9Y5gfQX/g1Qd/oCbjFOpnHnSYI9GL8RFu2Lf9eOaIm0X3x8OdEyb6DhNBYql7B5trIjlewLhb/BePA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6642

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

