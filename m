Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2130.outbound.protection.outlook.com [40.107.244.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596F14BF8D
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 23:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887105; cv=fail; b=U6Jvttj0C8TeqRW7JGAS+yH2ybEaxRLYkK6CQ27/NcGvReb/ksgK3u+J/+rtb4BUzTwOROUDXTLF8oDM9OO8t376gi19xSOR6JAzbO2Cg/xhg+beHOq9mzIQOQLiTkfNTeKgQX2rKaJCS/EpGZ0Ui+IaFhPDSwdU8H+UmX+f8Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887105; c=relaxed/simple;
	bh=dCSJEAUnuExFJJShxF6z+0dcc2Hf0D+wuub7bycOWSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TVGnwSRSMYkNuCJNoPRHqk8WDtlZbTO9me6Nd8dXwrg4ZRw9XFX/MUP958dq2U7LaB5QZVGxt3QMJ1ImsA6yPljVoibGMf48HhVuaIiYQi6KabTkXHs1s6brENqOU97oyZ9AJdgX+aOrE+SIQ14IOb1PhO4mTTNOXBbnWlSyc+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=n45iyNkp; arc=fail smtp.client-ip=40.107.244.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="n45iyNkp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USarL/f/m0K89qSfXTpPEoiVG6YnLGgPdwsG45TSzr3WM7IXI3MeaobrSgCftqQwegH5yceAcgmcM+Vx3JG/Y0iK5kWmAC24OYtE/XQUlLTqVEp/um1icDqxbB8q5yUFdzPI7k9VVTkIIciGilBIAvyu/r6XoIMoNo7Y9eS1yMnaYAgtEYchrtfDuqXS2IK6PSNlSBfojjyfCyCbCqKGOBYkPYvk7j1drRj0XgMEn6adY2qzYeeyqTCOcVbh5MAFnEqG/p4p3ezpaSN4Icdi0NMLBtNBl+7E3AUgB4RW2C3Ldk/724V/qFfB+rllQJllhIJz52kDuY9HHoOz0KNOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tz5unbF2cL2aYOGT9SiFAOnhee8tvl8DVpI/qSUJnLw=;
 b=FpNpI70I93QbqaduOXKFL1SkF+ItalEdhF1GS6WAXDLkRzdcYONDJxZ8ah7/l/d1nHN/omNNdz5XIpjB4ujLmAAbUn9HY7MUcZzQRsYGVLynq4SB5AQYuMHi9O4u8HUmdsufjyzzlu8Vg+pWqfe1a0sA5GCBGOyQwZ5+ME4JyrcvmxZ7LKK3/5ZYPdj1AOdmIqXKE2XrBjvMNmKykY5B0eefsGvaDBAySxd95u6UbYWrihDAS+lX19mGLrHdDz0Kl69MDKaM5q7DqtCze8qNkMOw6ByY/FypVCGJ5CRLIbO59vMjLyXsDymOgD9c0FQII3rAext0ZcObiV/BfZmUQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz5unbF2cL2aYOGT9SiFAOnhee8tvl8DVpI/qSUJnLw=;
 b=n45iyNkpyYzGILY2ep4nzBZL9cN7mYuh1r+Q0FixD+yhDDvlP12txc/A4Xw10klWbYedihMvPSHsvsxediM1tVqqsjlnOjQwkTQR+RDmUVh9OytYDUEr7vvwcLiRK8DQAx/3C5ZozT8I2OC3Pd8OZzwuwQ1yAoaA9vnmxUnBvEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 PH0PR01MB7895.prod.exchangelabs.com (2603:10b6:510:28a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 23:18:18 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 23:18:17 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: PATCH V5 1/4] Add dso__is_pie call to identify ELF PIE
Date: Wed, 28 Aug 2024 17:17:58 -0600
Message-Id: <0b79b9f8eb11ae3abc874a660d6cc09be8d8ecbd.1724879699.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
References: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::24) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|PH0PR01MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: f314e3c3-588b-4572-e71d-08dcc7b7b326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PB5iQETbP//JTVAQGMGG+/qft2I/OskVm+M51OxJAdGt/u6D8uMczbLc8OuK?=
 =?us-ascii?Q?J4mfabbfYZBq6asPfxtngV6NODTBrve3cIL+bIIEwbAqcynuvLPJrFSekTk9?=
 =?us-ascii?Q?QiSrSF2uDunvnfosWA6rwgG+bm5mmn6xwWBFrmLoMP08gDZb6BZDJHXo8tgj?=
 =?us-ascii?Q?WA+9XTR4mUTds++UI+PZiF+qiZMPZErY/VpZFZP0Nl31y++NNe9DU7Z5X6av?=
 =?us-ascii?Q?Dx7yfOe8j2fipP78AtKh2lY8Gaq2lw0J3YduRKdw6m4axl0mMri3RjLqhV4F?=
 =?us-ascii?Q?lx5TndtADS4rIDC/aS4ice/wnf97alonpbWBoccujL7F1f4nNDSp1po7wOQq?=
 =?us-ascii?Q?px0xyl+idSQOomQieuq3ixy24dRHYR9x+HenJvGT8ieQbZIsn4sejpetSOJN?=
 =?us-ascii?Q?cVHrVx38A9uU0o01O7NUnzENQuCkNbBF/wMmeDACB0aaZEY5fCGhJ+f9dXFc?=
 =?us-ascii?Q?8itpcSLwfQaz+9QeuE6xqCOuhj2hCOwb4ywowV8nQldtbOI5BElqZSs1sINv?=
 =?us-ascii?Q?RtAN+uHh5lsFqrm+qb+A/+ORzFd5YTAXsdR9mi7UTOrDdT27EYiX9CM+WW+W?=
 =?us-ascii?Q?YSQXqTT4NuqB3Nm5SBkVFq5x27GabZuFGEr2ayecZ4sG4soUG+Fc6ba4D6hP?=
 =?us-ascii?Q?y9VHFhZ95xl1kDvF2kXgs5cX36LAFoCFhQerHhb3l4v+X7nkZj+x4lTdqcn1?=
 =?us-ascii?Q?X2LVq015iA7Xp/1xAlsll//ppvbEbxsrQi1OLv6/uEHw60aioe0pGvR1HxLI?=
 =?us-ascii?Q?M9C+Ydj7l8VtKEOkpOv46USslIFJd24E92G67iN2/3i0m+IVtoSKtfucoZ5W?=
 =?us-ascii?Q?QpGYEzzapLzCXPhAjAK/HA/uD7yQ+jEyfYmzdzThLFk8x8W/6Du5msm4l5C1?=
 =?us-ascii?Q?qxsY47i5gVZx2H0nY18H7kCT4T7FsewDn3c9rJhL6/oLOXqWK1fyr6RhnJ4E?=
 =?us-ascii?Q?cYZXAGoF2A+/ZWzsAoLEDVnyjXy6HNXaW6/Qcu+Vprl6jP/TT6Yd29N6ESi4?=
 =?us-ascii?Q?L8qmW14qpkSKxPZH54Zx8Rg2+oBmubwNEjydhngOPhrEj0f3gRUGFkIRbUi0?=
 =?us-ascii?Q?4qvatUv8blkSEI3x6kSIPSxWwPMNfksoJVKycp03cQrpgo16Z/q8Gu4NJxOu?=
 =?us-ascii?Q?Gjzmk936U6bjVF+B576iWunxXH/s6eWhpiCTf2GmHqyp9JDdFeLMrWv0SFAW?=
 =?us-ascii?Q?kGogNj7t8QHAMAtY2g9IKEv9aerfO75vn5IXIjc+UzGmcSqbPURIACeM2wWc?=
 =?us-ascii?Q?1mH5eKBL3Wg+pY/1OAiPkXrWKGToZ6ZkMRCi1k9IvkpfChDSsdHBteRY6qVI?=
 =?us-ascii?Q?vvGg/VLywp8FyIHuYKa6jp9W10gWGiISl64DdctuVfkhjQc5TPXJUszWMS32?=
 =?us-ascii?Q?SJTVP7szSVtBKDAOqdIT0R8nqyQuk/1nHNeQyUbQKzt06UgWLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VxujcP9qEWi9GGtioVeh0SKYyfuqWyxedG+cze5a2+V7KVKgrxX6TJfIoyT7?=
 =?us-ascii?Q?OKLU0FGcrvNFFIwNGT/PzYPQ78nqqRJx75Ud20u/vGX2lRivDyzQ40l2v5X4?=
 =?us-ascii?Q?pdX2Oz/6BWEH5+ZJ2/ufJVHl2bgy5jaeFMXyZyKPxxxDNm+BRVQhbaueTF4S?=
 =?us-ascii?Q?YM1ZDn8oY+DF15TM4tRBfRW5ACYLSbdWnC8/TRiBlrZh2mVFgjOCgrupBkC+?=
 =?us-ascii?Q?+C2AZ7vgtkT1+9USN/zL+4c0TG5G5fxAGOxgSnyylbcxFpn99z4qa31qr3CT?=
 =?us-ascii?Q?3V8tluUrodGR9tMuomTS4lOK2ZX8JuZpfZWDaGDlNGo1DTcDdGsHwvX3UzcK?=
 =?us-ascii?Q?BcaLub/Cd7emfTQz7cjfntBY9o2x62BNu2TlNLWOHL/niBe4AfdahzZDFDpP?=
 =?us-ascii?Q?4htxK8S/clIGibDnDqFlWEV0A7k/KhTSU+PoH8YtjJhnDoZabki42/O0pzk4?=
 =?us-ascii?Q?RKjl9XSmfcpZZdqM+NOQUvhwfBBxJMmsvJrCw8baECZYYNlKkE9SLoPg0+9S?=
 =?us-ascii?Q?gqwI84sA/ShqCM6AovbFM4quZgZU/qvwTThXjxePq+qZHZ+f9aPxjxA8t3SG?=
 =?us-ascii?Q?lcs/UprswPDChasVxdQ73sM8Tjr46d2LAv1Rw4vFyf0rOANEJG6RytoUNmeP?=
 =?us-ascii?Q?gpCBHnGc886nQbWIIlyFPi9lsN7f16E9/AOx5wS74rIeg0BUAFVY691+Uarq?=
 =?us-ascii?Q?d7YH2dyuX18mnU6vhu6CtkLY+ObOkPczAygrhQh7TIiGam5l1DWyGglXk+Ez?=
 =?us-ascii?Q?qs7lff+01LImn2nNyWxOcDRIkwCitdQjpjenQHJ6PmvvuJ3BiJByyj+TbhMI?=
 =?us-ascii?Q?NiHRl69I+S4H+rJPXqAncAoLxS8MEjV6G/C1GDmUTNg/DPLE5Oel5JOTBafY?=
 =?us-ascii?Q?Opozb+iMjHeC0Alqc9LoOYH414BYn0jJhALisU/8M2kL5bar4tYt9bG5TMPl?=
 =?us-ascii?Q?7d9wJP4cOhpKILg4vAulug4Rp/X0RHQKchdrwt7wBP1En0KIuHswNr3VoMd5?=
 =?us-ascii?Q?zfTcKMIuBciI2/07J3j0hNJ1RqjBYF9wNh9sbq8KI/LTpicpeEkYjp283AIP?=
 =?us-ascii?Q?y9XOBo+HmD0PEkzZFvfBWXfWw/1uMzEEbN7mDRTZe6jNH/NXfQsOTy5f24kk?=
 =?us-ascii?Q?pfsRB9OxW0o9M9LNdAI0UFSfg2zzeCx3wywrAUkzn2aSfkd6dcogYZhhicLS?=
 =?us-ascii?Q?Si+KGUmIa/Pu0lrKYOOk9WH96dMP3ucULDbStll1FggzVwBPomubKD0SlEQb?=
 =?us-ascii?Q?X1WZp7p2PfnB80/RwwBdTa+gyWfYyXVkKfbRd4LZRJrJjm39XLteit/he4wg?=
 =?us-ascii?Q?stEzBAW73zK0rJAnvri/pYHmptBH/lN20DIYifhQurVXC8kV0iThpbZxmrIz?=
 =?us-ascii?Q?AZNGEmqs2ggEMZZTcjHORqqYJmZ5Bf432a97rzuiFBELjEInN+YMRvmHK/H4?=
 =?us-ascii?Q?NyXnx6vnQpaPBptyAyYX3B22GQYRK7LsmwP51GTu9Yus1dqxX1FTVbUQoaKn?=
 =?us-ascii?Q?3KoF23+v/E1B+Kk5p/xug8ZkEUq193moQvfRNMCsxs8WewRUFFCLVWU/jfFB?=
 =?us-ascii?Q?FelGjFHiIhgG0EwWTMjvZZ7q/PYHkCRCk7SdUbqL5AQF6WI4xQ4jCEhYUx1l?=
 =?us-ascii?Q?RPD+pEQAmBZrN/q7bVhLilPOfIdBvib1PqgRFz04Z3Qz?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f314e3c3-588b-4572-e71d-08dcc7b7b326
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 23:18:17.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSv8TkVuSeJYsYo0lRH4lDpdA28/X8b0Dyc9VMjIxOsN8wZvjK9wFanWrU+5fRnT9w7VRLyNV26JpOurGegfjxqw8O2v6xxLyadKS5IhqQG2N6hpPn7RIp29Slqp12Wn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7895

Add dso__is_pie global to read the .dynamic section DT_FLAGS_1 entry for
the DF_1_PIE flag. This identifies position executable code.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
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
2.25.1

