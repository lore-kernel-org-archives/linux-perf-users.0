Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2121.outbound.protection.outlook.com [40.107.92.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176FD18C901
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725917428; cv=fail; b=XRf9o0Qaw5jjGybOQ1XBgPEiwGuFAcOrpG17uWbxh8zaLMYyue4Smv48X1+qZu/YSi++EPpdakP5UyBEfJNJV68RIOlpCCMQ4q3jvo8ACsuKZiaJt4P91xWzo1vg6csL4LXLX6wm/xesvHkK24OFtcuMnhzoX5d7cPsjODoZxMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725917428; c=relaxed/simple;
	bh=6TY83I2d/V6jPR5vSbX2nalJw1JP071kf7B8b0KUCsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u7R7WNZwBUmHBRWwOFuVno0/y/OLkFTdsn7wn4tsWJgwFEnnon9KJTxQbLcQc6/ZM0WIaTCMXtQPRyXpI+Uoy1a3iaBSf/dNf3zAfGqmL7kUAnltLc49jz3yoNeegYKXePML6f5AI9Q56eQ4VZeMe2IyeHLDAZ+LbSYkCiyXsN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZSpz2NKf; arc=fail smtp.client-ip=40.107.92.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZSpz2NKf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKPl3+cMTlKpwR011bmjeKjNFCBq1r7ZwXHFwZbFX8N2rM3Kgh16KH4yyNpMe6MgT5BA1KcudthyKSJQvnC9mR4wrDnbbRIR4iRDLRuKWohKRkVZV8UodtcBl6OQfuerxtmTXVtZrBvQLSdqbBe1wgO8dnLU5ZTPEjZXE/YTP3fffZuf3Wq0BmEBao5M3NfjXMTdtLdIJATqB0wlf45cWw2sWP2v+g928xaUIHV6aAZbfGVtI4Le1t68rDsqsW0B4ctNlm4qlvpiLF6YUI2UVkWOb3DNuIf1DvZMLWgUBKOHMROEVUddw4Gh9I70Wpptkd9ZUuxdGJznShAidSvgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3Z68xW8nOXTyEOcTAZJeJM/P2J92dmdOL3G/97x0/g=;
 b=CLiQxJJE/UxQZ4a0Mxn3ilMjoOnR4STt9C9DyrHGQENa/rvBSV1SUnB1a3ZvoGonkdGLEQXjUlMYk7KN6XvdOfuB4onWwkwe36VKpvTjkzEsYhGYtB42LyzDHAVm3n+F/Whr34xuYlcpm4Y91pIjLM4rh4GlzXA5Cm7QbDMDGaffOupOYOLkytIjEYnlM3nu2G2HElkdnZjnnPwkYAUqKf2Mddiqx7oqxZAI1exP8MBvDPi8FVRbrnqdzxjpqKlZgHso4SxE0lxSqfufLDET2FwqT/N6ct0YkL34YRf1r8Mh3TNoUqHkZfMwCRwR2CxU+VIoleERu4ucTwIwNMww4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3Z68xW8nOXTyEOcTAZJeJM/P2J92dmdOL3G/97x0/g=;
 b=ZSpz2NKfZkZL/ccuVCvo7VsQ65UcHuBXpX+u3Tj3aT1Y6xaGXLc5EhVPx/xV8zle0akcYs8AQM0C6MSF/plNdKuInaf8wtV/gYJW/+ZMXi0+hWtGcLhYpO3M92lnh5BwXW0mDQ3IJf3NBZZaBEvV2eYPa44rxf9LSLbu1a+UKsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 DM8PR01MB6919.prod.exchangelabs.com (2603:10b6:8:14::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.24; Mon, 9 Sep 2024 21:30:22 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 21:30:22 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V8 1/4] Add dso__is_pie call to identify ELF PIE
Date: Mon,  9 Sep 2024 15:30:01 -0600
Message-Id: <18bb5281c3648a67bff61ce44966d3dfd7c09b4f.1725667397.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
References: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::20) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|DM8PR01MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3235e8-b248-44fa-8429-08dcd1169c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vlSqk8Ac1APLiKJG/bomcLetSWIiGIZtPZJ58fvlw+wWx1SCl9ZQxbNHGCAI?=
 =?us-ascii?Q?IEnpFcF1coU6jzLVfb3EdTq6A6EVpqqagC7J5Zjd98VvfGjJVz9r9/wxiWNP?=
 =?us-ascii?Q?NVb5Z7l3wCl3DI2mguCZ5mI3byoIsnyW1d7zR9rvYap4B+lCSoUvrLjVIYg6?=
 =?us-ascii?Q?M/+sbklYBSpNY66NdsnE63e3B90vCatr8R6gnuHXXNAIxON6U+PYHZa8ONbp?=
 =?us-ascii?Q?SNeTzTnfhEM06jVYyxXutyWvG1KpI+AyYstixemT8ocS+UX7m62yP2syafMi?=
 =?us-ascii?Q?vW953nJlb3lODXAmo84Z+UqgywBQGRxR9867dG1IObnC9tem9SPh5naEU/EQ?=
 =?us-ascii?Q?swQlxp52HHJJFDPWRigcrmFQjzK3iMOGYzD0lDKhaVonT41FOOQRs/+n60x4?=
 =?us-ascii?Q?QQnF/IX0lO3jSdsx2ub26PLEylOEaeB13/ugP8KceAIlMJp9JNO4k+qWf5uT?=
 =?us-ascii?Q?EJ3VDT98tUol53SoWueD7wlbZVwHETjoVSazmTEBdP2ryg5fvhR+A1+lGCVR?=
 =?us-ascii?Q?ZuP5bK8YEX5qJ9KnvDV+yhwSgmIqyq3sC1w7N1qPsSxfjpTmpDw93NLWLoKv?=
 =?us-ascii?Q?pNEBRND+Jq+PV383jOvw200fWTq0XGYK2k3ttKlk9aIPccEmC3nPT2O++GeK?=
 =?us-ascii?Q?3eUoGmk57WkpYMBBAzrXsb1isKLGAAaCw/iAJVDFbmRwt7T58n6rjZBVdhHx?=
 =?us-ascii?Q?rYevlY/zPX/NilSXiYy1hldj8PO4JbdqalizL82+mGmwPn5lXEIOuUcbC79B?=
 =?us-ascii?Q?G+enWkxbwgmjycbf4kXEQHDNYnCPR/wbZofiHEA7xr4RBSRhn42DRl8nPCJM?=
 =?us-ascii?Q?l+/rqf49gcBYR1dtZNrbuIKMktFs3md43Kl2ijIPMQlQTT95gLIKU84gzQAY?=
 =?us-ascii?Q?9+d5zr/o4P+iLC75hOwlZ3fKGlB7pUFL3Oyo4gGYarRrbytFtjL0KCj3F1Ic?=
 =?us-ascii?Q?QrzkCbAIXxQT7v8TTLkzQGk1s8AJuoMp1ZZ6U//7P9rULcr2dTkfSo4skOhZ?=
 =?us-ascii?Q?1OkwL7/e78blAA4xGGug1FG2g/16JwEBzbSVFGZH8/VUogFd0VpR5KXfXbyJ?=
 =?us-ascii?Q?yXGBU4W/teLG/GY0BAQDCQ8+owineOqeoDERzCjxx682gcHNz2ZBySqu3Pys?=
 =?us-ascii?Q?ENmeKI3izkTcu2DvYBV9jnz+ikZ2eihfqR7N3rCCzULWjNnGNJKaC2hu03ea?=
 =?us-ascii?Q?cWhHBwk7bNknFypw3yNdrM/kqVqk014cth75gX7d6v63o7wqcgEzhTMidzap?=
 =?us-ascii?Q?UynGR3njDYheHz3m0uAMie4aUvsP++ogtqJsM92k09H6T2ST73dmrt6GFSRV?=
 =?us-ascii?Q?OkCC4ZW81oD2Nk42hHZTmYs2ojud0InfWPj7MMmDZb/eNn0n9Mx2PNNpPBdV?=
 =?us-ascii?Q?EhSMAHyqMP09SRfnqFUnumyhVqPdjaM7hJKdecaee1BFWSXUFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ih3RTh1rp2ITDlbgHz13WQBC7Pao1YE94RNGG7wmyMufKZrynZOVUUY+xVjG?=
 =?us-ascii?Q?uYbXvHxJ6K7H08VRe7DLBt1CrdcGuE16GtX5v5fG/1YlpC5SXKoEaX9DZV40?=
 =?us-ascii?Q?7JypXX1RNbcMoIx5y1GAsKwUbCe8zh3VmYN2JFy/VkWHu3/+Ctds7bbO1cay?=
 =?us-ascii?Q?9FTKYMO7A/OATZh7sh8BVHnwQ1uUX3KJWp7D3hSA/bMfTgG+CTiDf+AZ87QZ?=
 =?us-ascii?Q?fDHAC/nU1w1zlgi1jz6F3GqQ8agJkmsKUZjlNNCTIFp4lhZyU+I2f1/DevZj?=
 =?us-ascii?Q?aOFMqupF4YHtGoOYL2RXeGyxq45ZPz3vpbl9OUf76jsJ7k3fdpYK6oLvUhDA?=
 =?us-ascii?Q?Hjg+uc3QRpReMX3j8SpWhVlXBreF06sTVRxmPPV5Kf3TFIFJGcoDf7Yt3V9Y?=
 =?us-ascii?Q?8VMQWDxMdAiLCuODc1OItSZPf248SP7oRpwi4ONMF2pZKDsZUs5J5kboaqjw?=
 =?us-ascii?Q?aLBB4AkqL9n6AVtO0sGd99eMNSeY3IWYMTX3h5XUskZxcPzcqWS35FG/tGw5?=
 =?us-ascii?Q?LLIR8jVStK4d122UlfyhQs+b4typC8274FYLVxPWL8niDArJxtLfFbzcTNWK?=
 =?us-ascii?Q?Fe0Jncz+9kxNvKn5Agi4Qdwl4sGnGj2dG/TWu7iOOC6CT59+iZZVrPPUxbP2?=
 =?us-ascii?Q?7nsjKbrPbCqy/FdvrStgDhK4lwD87w3EmiAi2MouuDdj1/lEPjjP/tD0KyRz?=
 =?us-ascii?Q?H/zYoYFFEmwbohisRUWEGBxByDiaZU1AqRnVEKQRIbPj71A7H4eoKqHCBcQY?=
 =?us-ascii?Q?LQrAF+JiT77nrItqZe8xAaVu2rE68ThgPAuyzpit4d/119ULKx7G1eRQGDlP?=
 =?us-ascii?Q?N24fuFSA10T0sJeZ7pfho+qNCspP0tuQR0DFcvVw0sS10BTp+JNrhkGXKexW?=
 =?us-ascii?Q?OYhVi933v30PUFrzEhxTAIs4jrDQhyh1axYyZObVobG4uBO6C5QWbA4R7XG5?=
 =?us-ascii?Q?2TFLSS715mqNFLeDWXXXrLBaTri4zGK68nIQz6ovZkbTD7WqctRzlt/vJXvx?=
 =?us-ascii?Q?NXclBUQlQGXDg2mCqvTGEjMMpF6OfK8R5xQVEgniGoNn5mCeJXV0rG9boe5Y?=
 =?us-ascii?Q?JBowrgICGrdpz9AfeX7dKGBBzZkrpmAfaISpKxA6O9Wrvfh/XRfLbHyouzv1?=
 =?us-ascii?Q?iINu3lLGixXb9OZeQbFrEsDSPSfCDqXh1c4cEMxaz22tWPqwgnVtmn/GNssj?=
 =?us-ascii?Q?9Rbl6hhYjLk8QbZP+BFrxruMB4BpEpraaXGKx5QUrg36zYUJvxmrvFR+k9VK?=
 =?us-ascii?Q?bzasyJ6QSviCZscp+mh8bIpkVlBN9KhvvR3KgGtYoKVbsH7AP2Dfv+oMyDPw?=
 =?us-ascii?Q?REybhILKEQZ+619/6iNGczuiOQMhyi69XEd5t9COf3W7PE66kJwmUUXsKLSI?=
 =?us-ascii?Q?GSSK989aXuVSneqBAGh/VCRJfRdYo8/9MgRzW+xvfQd4kYuSaAt1p/W9pmu1?=
 =?us-ascii?Q?AlVibtN4MnzmFe3ocKUOsZ7+Tq9ltPSwTqE3Zl4tmmryXy9cVutq401fP/I/?=
 =?us-ascii?Q?cVmHAWwuE7ovULn4C5yFH04tvb2cn5veOMFO6lvdF4hW6NhH0m3+t6fBSrcz?=
 =?us-ascii?Q?MJFYBcXx0OA8W1ZkLaivjBVbRiqM+tOG44591krhq38S029OV0ULD0LKmIaQ?=
 =?us-ascii?Q?3TSnngHr96ePGZ1gVrgs4otyQj/sJg8CYJpzUZ/3HxO1?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3235e8-b248-44fa-8429-08dcd1169c43
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 21:30:22.2061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdHEIm0DJHoBaLkBkkayqXp8MZvnwyjanJGGSxWbPLDevC4G3dL/j214oJNY9zCDoRyPyDbzU4yi2959GAhODObFmVkTDET99VmkcY7M+KszXQ6FErmR656ve1ssi6Yo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6919

Add dso__is_pie global to read the .dynamic section DT_FLAGS_1 entry for
the DF_1_PIE flag. This identifies position executable code.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/symbol-elf.c | 61 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/symbol.h     |  1 +
 2 files changed, 62 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index e398abfd13a0..babe47976922 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -662,6 +662,67 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
 	return err;
 }
 
+/*
+ * Check dynamic section DT_FLAGS_1 for a Position Independent
+ * Executable (PIE).
+ */
+bool dso__is_pie(struct dso *dso)
+{
+	Elf *elf = NULL;
+	Elf_Scn *scn = NULL;
+	GElf_Ehdr ehdr;
+	GElf_Shdr shdr;
+	bool is_pie = false;
+	char dso_path[PATH_MAX];
+	int fd = -1;
+
+	if (!dso || (elf_version(EV_CURRENT) == EV_NONE))
+		goto exit;	// false
+
+	dso__build_id_filename(dso, dso_path, sizeof(dso_path), false);
+
+	fd = open(dso_path, O_RDONLY);
+
+	if (fd < 0) {
+		pr_debug("%s: cannot read cached %s.\n", __func__, dso_path);
+		goto exit;	// false
+	}
+
+	elf = elf_begin(fd, ELF_C_READ, NULL);
+	gelf_getehdr(elf, &ehdr);
+
+	if (ehdr.e_type == ET_DYN) {
+		Elf_Data *data;
+		GElf_Dyn *entry;
+		int n_entries = shdr.sh_size / sizeof(GElf_Dyn);
+
+		scn = elf_section_by_name(elf, &ehdr, &shdr, ".dynamic", NULL);
+		if (!scn)
+			goto exit_close;	// false
+
+		data = (Elf_Data *) elf_getdata(scn, NULL);
+		if (!data || !data->d_buf)
+			goto exit_close;	// false
+
+		// check DT_FLAGS_1
+		for (int i = 0; i < n_entries; i++) {
+			entry = ((GElf_Dyn *) data->d_buf) + i;
+			if (entry->d_tag == DT_FLAGS_1) {
+				if ((entry->d_un.d_val & DF_1_PIE) != 0) {
+					is_pie = true;
+					break;
+				}
+			}
+		} // end for
+	}
+
+exit_close:
+	elf_end(elf);
+	close(fd);
+exit:
+	return is_pie;
+}
+
 /*
  * We need to check if we have a .dynsym, so that we can handle the
  * .plt, synthesizing its symbols, that aren't on the symtabs (be it
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 3fb5d146d9b1..33ea2596ce31 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -127,6 +127,7 @@ void dso__insert_symbol(struct dso *dso,
 			struct symbol *sym);
 void dso__delete_symbol(struct dso *dso,
 			struct symbol *sym);
+bool dso__is_pie(struct dso *dso);
 
 struct symbol *dso__find_symbol(struct dso *dso, u64 addr);
 struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr);
-- 
2.44.0

