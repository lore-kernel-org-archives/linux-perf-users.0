Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020104.outbound.protection.outlook.com [52.101.85.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18261381AF
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809843; cv=fail; b=CjDEy34nkqLMNVqm5VPBTbxASj05Q0g/GrT8sHxuG4m+gmM86Dvvebkxce3F2dbqfMJTAw9AxlgVCdiiBWE1V27T1YQ1PdUKIVP9b5SYauI0WBjdbVkrQrZEG3YZ2Hl+4wXID4wM/BZ3KpDNVkRxngypfroQP6MvjNFXOTnrHcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809843; c=relaxed/simple;
	bh=JBMGw+ZvMXBnIa3I06CGOhAJZJFIpBMk1RF7Oz4JeYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QzyrrmzMHblzw8bNc3J4cWfQX4JG/NgiPLiR3ZiZi+0RM6oKjWpR7mFNadg98eQMFjRGaAnBn73SoMMsHdytuI8eJ65EOs3C4EbfHEAtrwOomH49NO0ebVitMuLX6X55SEEhe81c/qqanZIaoBTYECYKDxws1QjcIqw06SIUcSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=PZOVqYIy; arc=fail smtp.client-ip=52.101.85.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="PZOVqYIy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNnpJ8Ll8UadOdmDHFXbNPz9UbOXZUrJgMf98MM0VpUj/R7n9NdC30nUUKJI1+o4rS6adzW3MhAcCJGDlzetbMNGm1jRURk01/j4wAz1rSBwD7sgH3lI3HlVNetHNWOyaGKH90WCvVKWlpNJnQlqjecozwkeJqaXIOqM4rQuDMZt8eQag9AiAAfF/YK21QCqGg5jzxn+IdSFvJwZvq7MZnsFkcEuALpfi7Ty65ZvkrRRA/je1sG5wkbs3hX7q+0teWMkQ6r7hF3IsFyKhrGevvW4qwdoBSLQdb7MyTgoDhM5evxzErlq+zOeGJxVs6U9A6LA0YoO1fxuuELE7oI39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHWC+SfKQZU4x5+3U1K0Xq7drTMGvU/j7ZyAQp0cv5g=;
 b=Pae/J5dVy+dpZE1eeNkTOkRRQigQrx+67mIn6t679UqezTjWm/7J82hgWtsB7IULjGNRpWRilTyFju6N+eBTM/77WN2lQoZi11Oh/UzxW5Ceq94jwwC5moMTGyYdKUI4SSsqVMQLnd88KaruD3N62jskNjnD+kfwnAa5JCQH5O+H9VggfpyMiBz1U1N5gSdWb9KwB5IlCFWm8xbL+yuWS+ovZK8dKcr+68YCb7aSY2jFj83NnRN5u/f3NfsHiR/3qYEFgCFNpaKR0YdaXXXhHa2a1ieRVv2If2n2QBup3k8c4qe4EuNrW4c3NPV6W0ovdw60aSdWVeL6RvtLQ+Gh4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHWC+SfKQZU4x5+3U1K0Xq7drTMGvU/j7ZyAQp0cv5g=;
 b=PZOVqYIyvSrt2oIUgzKdcvidec5pmQfu7T6Kn6rHUNihTbQUcRWtPsGBMi3ox8bSaCgJB87QUk5pLF+SZ1WZs3pR9XmLxQdPhLxxq9B/LuCP7z3bhbKmLrTsIfWkgXxVXkrrUzJMaPVPoKA47JczxicWYOUWBRyUa3c+7ZJobE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 LV2PR01MB7576.prod.exchangelabs.com (2603:10b6:408:17c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Wed, 28 Aug 2024 01:50:38 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 01:50:38 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V3 1/4] Add dso__is_pie call to identify ELF PIE
Date: Tue, 27 Aug 2024 19:50:16 -0600
Message-Id: <a5893ebca462c28417adc47113cb78fc989fec97.1724808513.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724808513.git.scclevenger@os.amperecomputing.com>
References: <cover.1724808513.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|LV2PR01MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: d59bf81e-5ff6-49b9-d65b-08dcc703d0e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iqae7ms85OcDHJCZLgD1Ql7B+BtW5yVTX3fOJ6aqn0lgm/XspWDkv4ORIkQw?=
 =?us-ascii?Q?nzXiUeBNVil460f7QfGSvc1czhWl0AHlwlTcUkDeD2Z6udTl3QfbOK1hEr/A?=
 =?us-ascii?Q?mFz6aFEbCJCu+B/rr08T1tCDGIb2z8xZ9wJSgthMIOrz/W0MX44xohV0CFd2?=
 =?us-ascii?Q?k6dvyLLLF85GUQwGGftroD1BhbITqfug0iekwYk3bsO5CztEsMcloqPV/aSL?=
 =?us-ascii?Q?Ke2v7O/wSTYLCsYH0tsYKWtUtQ6k7IwAHfUj122kUeSwsxxuyHsAKbs6lfwt?=
 =?us-ascii?Q?Z1EwGQMDiDhKEmJ0KvV89bLKRdaM+P5zmsCuPjtp0jxkfZHRdQalHlj77hD+?=
 =?us-ascii?Q?DD9w+lP7xUgCrBLBec8WDrddtIS3W705ZXsUSaU5vFmuLhuMdf3JMbBpsYmx?=
 =?us-ascii?Q?Lz8aBE4p9atfeFOwxEbzYnyUj+2hqgf+jeCbaS4lSCAHF/Q0PmdquaAGIfaJ?=
 =?us-ascii?Q?Wala8NHddFb6WTv0bDO0x17etPYoTxd1FQqQF82YIsUr1mHTSyctiCTzWUpb?=
 =?us-ascii?Q?+Ymwympo+mhZ0uBM4p1QOvzNkZd4NSadY+Rfb1qUyn7DSXx0n3dhZAezGZqW?=
 =?us-ascii?Q?PcKI5v7CW0PMe2LQ0U2jCSZvV04vCatlOaz99/Xw7taCeXe4LbDHCDOk6HUR?=
 =?us-ascii?Q?aYjGewhLGJKN5VEwvOdw6We44Fjm2LGZDOjiq9Cj/Ex34F6fpHGFA/JaVC8/?=
 =?us-ascii?Q?P0BiWH1+cJVzlGZY5W4hSk4CkP8hP1UcpRUUit21aQbi0N3VJ7xMsETS74Fa?=
 =?us-ascii?Q?un9IUm99rr32X5VOxKTff3rjA9jlTjG3wDy9pto+zYLRzkGFQa0oTKbK4b/3?=
 =?us-ascii?Q?8xndbI5sNCdRCRVphlMMHW12Lf9yB9NZRAxBDjx0y9vj+9r/aEYKPsHZzUup?=
 =?us-ascii?Q?cl87+4yRi974aomL4EC869XW0TFo6irZ+LuqEk5ooPNJYhb8Jcm5rF116EAf?=
 =?us-ascii?Q?wiq8PdPnhjRBO0WkBMHZoCVgdw7k2mKlAj9b2FInY/+2ERQS7Cle7nLeDn/q?=
 =?us-ascii?Q?AKRxoWiDdV4aM4J/D6eBX8WodLHKuyaA+gUmjg4B2NFbJ2t5/m0bZd21F+q5?=
 =?us-ascii?Q?s+HIxI4o8xDMLbIhxV1s8HT9dmtadsoRz/PmggXeqmzPDE5445imqvBlm8H0?=
 =?us-ascii?Q?qXYBWj42dSidemHyL5w8rDCl2UlY/qnA3YlfWXfcx0uRn5dpYL6Fu2Uzvr67?=
 =?us-ascii?Q?F5EsUhTs3GA43mc4EIWP5uDXlmAtq+KngmqCMMDsU3d2YBesTJskgZUf1pSi?=
 =?us-ascii?Q?f3X+D6bYrN42rmv30NlAGa3A2g6Dg1KaO2/zTQu0uZpfNZbugt8WwN3fZ3wG?=
 =?us-ascii?Q?1lZ3u1QrKKNTW74MyUHc9NmCRIax8u/CrKhsOxjsf4UTdnhMqou3nvxYMSlB?=
 =?us-ascii?Q?juQj/skjUSOua2CPRCJ6A1F3TUnzM2XCwJCXdKiIuO3kjyo4QA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DKPf+3YsXlXSldmD8SJZxDVayeuPZpmdt4inuTK+wXuZFwgSpzfjcnEwM+QW?=
 =?us-ascii?Q?pjGNgaSJRdRCYXmv+1Rc5xZTm42EjdUz8rdRLwPORWZLbqhAmLu1Cm8sTCEd?=
 =?us-ascii?Q?KsxEZ+idPcBi6aiorMWFU5hgguNh/1PxyJ9HmPOg22pg47k9a7z5zLsvswVN?=
 =?us-ascii?Q?4JMQ8Igdwow9lzH9BjpHIkL31Hv7KF7hAvfv1zOr71796FYugzOZmklDbncJ?=
 =?us-ascii?Q?02JXijfH7ohSzVhf+42Y4s3FXjAx910KGVggTLcChSedChawXtLvY+OCfMbU?=
 =?us-ascii?Q?ZEHj+Y1LQZW+fIRfjwRy8wMb4tRXpYjL/luwMNXllrUfhWQzaXOekN5xY3fq?=
 =?us-ascii?Q?vslkbNaQsmmFUpydK+nNuv92fOzRyMp5x5fAXCxcPLRHQmQEahGZarvS3wPc?=
 =?us-ascii?Q?c0357TF+Ih5pd70DFXKjuB8XC6ZjPV04Ce+1qLCG7XEoupHu1V3Zxduh5jn3?=
 =?us-ascii?Q?u1TTsCrocOJqkAOO7M2/xyPmjP64wPrpj18PmiCMXC0kcG6CDyahveoWH4ny?=
 =?us-ascii?Q?Y3lQtwL/SzNw4HTWcaIOkoTzyCq3THgE4sBJG8kjndN3qdU7wyVL7Gcz8Bk0?=
 =?us-ascii?Q?zPc9lYyEZ2XVD6F2x/vR5pqrWRfMupTl7+nHFg4z5tJzaenDCKwb9JiRT4uL?=
 =?us-ascii?Q?FeB3GQXtieRt4JM9sq7CG3cDJL16LOvu5FaTQPOwrbET5Ssldrg4KSWxdKel?=
 =?us-ascii?Q?zmuppuHwxoVxU5tD+2PR/kfGvsuMn49LqgGf6VflpoP2ptULgdU2ArJx35Iw?=
 =?us-ascii?Q?wUeOm1g5TJpBSBIwRmeewDpNYCMhOt+Hvie/+XXvA8oTiAOJW1yKiAip/Z+8?=
 =?us-ascii?Q?hiZzdDQjBObMwqcTZz1+ryJMtLdcKKTdcpkA6oLdYfHphedXXYUU6lDTy4uM?=
 =?us-ascii?Q?2lg9nOdkO1YM2vT2GlRcaTdc+KBlM5fAWzMKkXxjb646InSNtK2fnQ6xR2g1?=
 =?us-ascii?Q?xAr8AiIYSpfAIbmZX/NowY/LGZVzO51pyhPjazsA8Sgi9x+LF90pm943urb3?=
 =?us-ascii?Q?XW4uncEHyjSTp07m+bm5Wx7r8yPllNUV6VOqHAQHBelg0diQPVwnOF0ti3Lu?=
 =?us-ascii?Q?WTkcEGX94fCSy+7NOXK4vTmTcR2EplnFHomF7/qW7eujEI5JP+wh3OP7BcC/?=
 =?us-ascii?Q?qeuoYWtlc2ZonUfkLZ0flssJSshlWvUdn4OBuhUOdAZKJXHMCB58jyq6b8S1?=
 =?us-ascii?Q?3kxjc4wgI0QK0WN+AaQxs2DQlkrZb9Y2YOvPfJ4pj0HFVxX6Ldqx/uZT4XxC?=
 =?us-ascii?Q?8KtlvC9VSi10u7oJdQKAF1f5/c/RyHU8lJVbAAmKddT7y97vIuW5eBQq2weN?=
 =?us-ascii?Q?lI9p5cYG87Ocz+mD+ZJk2X1WDTaTflJZCO79MM8YngE/NfeXNdIHuNdsSh3x?=
 =?us-ascii?Q?/aXcXddq2DU2vg6an/iTR7aeJ/D8reOs3+MUR/NK0Lz3R4UKbJqHMKz/Bmgw?=
 =?us-ascii?Q?RwowU0gTH2U5ntAVt5WuSAseT026Y/d4IIBGJ/9BgcgMrqdvAokrzsFaeOI5?=
 =?us-ascii?Q?FXMlUPU8bjzcMgBVZG40Cs6b6TYbLP0KKl7xcl9xLYLQA7+gOPl05VPzc7jh?=
 =?us-ascii?Q?YSyxPvGWai7yZLYv8SHdWoFNQb1+SUJdspj7gQY7Zc/lPuQ6RKdT3UXO5VF2?=
 =?us-ascii?Q?gvL29oiZ95JyqDb+vasPrZjBX16a5qCidy/0aW5rx4u7?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59bf81e-5ff6-49b9-d65b-08dcc703d0e3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 01:50:38.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siugeZ5m5vVKzOByMeKIzbN0IV4/r2QCp8jBB1BTnxBIshYQZD0dFcH/IYK81QW6QMk+UBvOn1hILaS7saYvUPe5Ky8wGJ0XpwHQ+JM9BbJlAq9Y11In2oDsvSj3Sc52
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7576

Add dso__is_pie global to read the .dynamic section DT_FLAGS_1 entry for
the DF_1_PIE flag. This identifies position executable code.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 tools/perf/util/symbol-elf.c | 60 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/symbol.h     |  1 +
 2 files changed, 61 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index e398abfd13a0..0e49c1345a67 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -662,6 +662,66 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
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
+			goto exit;	// false
+
+		data = (Elf_Data *) elf_getdata(scn, NULL);
+		if (!data || !data->d_buf)
+			goto exit;	// false
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
2.25.1

