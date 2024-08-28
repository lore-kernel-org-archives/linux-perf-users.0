Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022092.outbound.protection.outlook.com [52.101.43.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66314A4F9
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 05:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724821805; cv=fail; b=LMrXsiifs4Vu3LU+wpHofi9sANkS3LhoKqZnouRwTqb1H8CVip6G3HvH1TK9zWxI1BO1t+TsqpdEeaQM+jZxvXw5EU/Tl9W9RJkmQemGqmriTcQCUGTTMz+jD8CK+qsJKbcS4WJTyBHewwxWgyZs5qATTisHbWUAjKqhn3SGCPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724821805; c=relaxed/simple;
	bh=JBMGw+ZvMXBnIa3I06CGOhAJZJFIpBMk1RF7Oz4JeYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KGMYoswcseP6knL7ChWqK89DrkVh7kNfyuVTdmWIgJzwC/Q6h4pydziVwI+yb1VlGRsf7f1SDdAFf+4WkRpYHZHDoOzVsdI8Ykqef4zu4bM5hCSbuhBM2nlHeDyvSN9yU4+cldpJNCkDLVjWv0AAgUpvyfZ7VHNOwnn5wqK4Xok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Fa8/ZLBR; arc=fail smtp.client-ip=52.101.43.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Fa8/ZLBR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnSpxULxQU04Lhdel1icBO3fnbwnkeDyJALl9kcYWaIq8d4ZXnUZo+ELN4tHlLyBQPa/+ZaGafbnajXLTCsJrwT3ht3FYC8SDSJsjunKc56V4IAV9wjvnjyXWKotf3TZJQ0/AJBFeePwXZYwP5eUMC5kBvTrSbNTh12XqewAKGPLMbs1vdBDduXepIRxm2NKOZ53Eivs0TqnOwHNNFS3c6reWg8u02QlhfV0v200l0bcu9LYqYBK9iVOhn0/79ZgH/9+59iBarjTfGATJ7tjkG4TQGFmjvuDJ3KqaTHstb6TZcoB6Z7FxXjCaBwb2qWs6XYScuWDXcmrNy6Jp2DWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHWC+SfKQZU4x5+3U1K0Xq7drTMGvU/j7ZyAQp0cv5g=;
 b=v19gHaufx57UihNPjfk0U2zCVdXpU+YR+tgmJIwQBn0G2o1aT27mvCvwWVjg1k/ex/N0jXptidM5hv7l0dV0GtIg2vkhkqciIo6/v4cf52tVDpExdNBF5zcdDCjrLhFrOvAx1IQ2tO6t7YIUsClUXIlDUcELYvYV51fTiLL27gR/6SRwAOHUEQPwWzKd/yVnNWnBKX3wvw2Rr3orr2SRgbRDbV8IysQaLE1iVgOX2faDv7lilqFqbmIfIPrKqffP3HRnfF7grO69O1AbsbauFntfJBHhH6a2RmCNnQZaOmxpscg7McWWE0WN8i9qQaxesBQwWLfIkf4caOValROeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHWC+SfKQZU4x5+3U1K0Xq7drTMGvU/j7ZyAQp0cv5g=;
 b=Fa8/ZLBRZbXBP1ljds9Ueq4ph+uSBWjvUEQrx8b7Pd7mPHP7GlcK6ImtJdYZwKGO8O6Jmk4gJKnb5GxosB6zaZK4Qoqp/qlIlPgxZ3Iggqrc0WwUR3w0KEKK7kvGIy9o/hQUS1OPL7TsYKfzD+1AmKT0uWNHGar+iMllNEuNb10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SA0PR01MB6506.prod.exchangelabs.com (2603:10b6:806:eb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 05:10:01 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 05:10:01 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V4 1/4] Add dso__is_pie call to identify ELF PIE
Date: Tue, 27 Aug 2024 23:09:39 -0600
Message-Id: <ee7a0b4944093db90a589040be39ef3e7e747f63.1724820993.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
References: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::27) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SA0PR01MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: de0197e3-90ad-418a-50bc-08dcc71fab63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Ywn61PDdEn9+TEnlWSwmvwKHCZFk7Yod81kWNQq4v5dJ0aNz/xTlugO/clK?=
 =?us-ascii?Q?ymUKNr8PYHVabQhA5H+06iSLiSgZlweiJI4VKAsnjJbs5JOcCQmjKjASVSf1?=
 =?us-ascii?Q?JQTOyyHv1XaUWKJkgk7tj5aYQHY9dIDV3QT1cpdezw5DZ0tYx1MK7M5MHTGE?=
 =?us-ascii?Q?XSBknilNNFQPDkFL01YlnqlMCl8EHANLKdM+zNYHW2G6tqIvGQF5GSP25q9W?=
 =?us-ascii?Q?tZz3DtwynlBiptbcUOqZ+5D1B6rp4lZ5bMUgEItteWZFterVlYvzqX/IN/JS?=
 =?us-ascii?Q?+xDRktnE15AsczVZxg6fOU01yWlTECDxPEpFPAvbUaz9/23yRRazJcbY8zkd?=
 =?us-ascii?Q?vRAJoDHmKFKoXVmOfUN78GSf98AY1TbmwUjXhoBjUCdCIdq/5yi5RppJ1AwK?=
 =?us-ascii?Q?AjxpOURYXk9SbkwuxfReSxVQ8o913C9zGfrK/f1jo0KVcXpNeCrCG23GaYuj?=
 =?us-ascii?Q?K1tgp8PXr0k1HwChHCgA3ydh0XXYBtx+xdDqRKX1X+iU4k47MtTeobk8hrHO?=
 =?us-ascii?Q?jg+b4OdLeeuwmlRpv5Tx9UjIGeAOra3HrgxtX9Cujt819HIXIaJ1FXb9zgEt?=
 =?us-ascii?Q?wSTHfP7JHiHblJAzFeN6FwyRPhdMuvFOjk42sgoIm9+I6cgG67UyT+hLzs3B?=
 =?us-ascii?Q?gFiigFBvIxT54EVck+XdLp/r6rfH9qrNELVQ01M45mcrOghqYiqbiwrrmvcm?=
 =?us-ascii?Q?CP44Nl1vpR3dL5uCP/vEI/GNWibTntTQOQCp1DaUS/AfTsQCCwdTIEYd5j4m?=
 =?us-ascii?Q?+uQhYFZFvsierqL/Li5tap593O0CsO0KfIVfof8+OG/k6sxMfSx6m+K+hXiM?=
 =?us-ascii?Q?YyrsJoWC715667qimYzHhnOfEjPMHkXzlmrHF9VgVnboejtjiIK5xDSZ4o5F?=
 =?us-ascii?Q?DQlhziCyvhJL/8ebXL3QmS65vuigSvfEfykyeuS4AOE5OnpvLhuW3/jipkOr?=
 =?us-ascii?Q?J7xHeWcwIcabVQpwziRzyCGI+dXFr28FHNpkeM1GQxrcfbxg+y5t0phci/Rn?=
 =?us-ascii?Q?YaN7FFgjYc1WWEKxJ/LGFUYeLrJm6f//A71Jr5RLcBWNmad8DjosgyiIVC5R?=
 =?us-ascii?Q?RwFi2v8qT+fWzXvxeYCGNRcU4I1eTM6PMyqVy95tmwYHuttQSmF/BlBkaOdL?=
 =?us-ascii?Q?UKvz7D4tktaHnUlUa7p6+T7xnN13OOihPsHYOmuPInuwZgQYrux18jE7WOfh?=
 =?us-ascii?Q?KOATdOaB9CYGYqVMzRPUttF7m6QANNv/p/m9XDj4vhwSAdqXuyDmjHvBBYqg?=
 =?us-ascii?Q?8/G5LgSFmqduqgOdCvZGDO7YkSdBXnAOGSco04o84MytICNrlrIpYyqleFlS?=
 =?us-ascii?Q?xznLL0U/GB2rBc94WalZFCb5W4ayatLgvsGsEjKksl/nINpF7R926ijskiQc?=
 =?us-ascii?Q?Z8ykoCgeO6iinJSjDMF4QUL+qdVOwsvTBwPk9emeTtprSfZ0vQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bDmVN00Kqk+JX7RK6z3VR+erYmQu6n27RaADqsNj51MAtjxycsws6XywB3ZK?=
 =?us-ascii?Q?VvwN6ESded2ldkJStMcyVAZQB7asal52Z+SfTfDKEnI+l9fhUcZ1bZ5VGzI7?=
 =?us-ascii?Q?HHT3PoaeuvHFqQoiR+EM0xNjpXM/faShgrt2Tqalvksif0u0V9YLmyXGXwKW?=
 =?us-ascii?Q?n1PuqFP+Hll/UdT06TxXME3rDkaF1L0Dzk1Cw0UXvM55IghyYOPQQKdBWOvL?=
 =?us-ascii?Q?RC/InJ1yRrxmnTw6h6SLSPdqhqzw6bUBVI5MKidJqn/li4HPCJ/Zpg/yyU81?=
 =?us-ascii?Q?6Splw4d6ISd3PP9Och8pQ0ocZE4A8myPPC7/c1EcvTx1q+TUxNitWfLojkY+?=
 =?us-ascii?Q?u4cxkgwx+GKTxgVGnsopIJ1iC+W25ZAShQm0X+frkoSA/ESUPWnCOgHOJlJp?=
 =?us-ascii?Q?k5My/YdAPcQVMbyLrrAyLk5Lo1Pf3qtApjnVZaCl2qE44RXUpyhAshT4FGjS?=
 =?us-ascii?Q?AEhcV6ivmQXRtxS1F/fvinGUxBFbqzZz4WAgBFdve+dGgEOaTDLbGhyt2N0S?=
 =?us-ascii?Q?t80XoNcil6xcQVAiPCl150mdv8BNVvufnXNLnn7m9m8C1pc+AvtMZqwshsDY?=
 =?us-ascii?Q?lE+69eCzKszvuZm79+OncDWOG76rtUcDWXLmbhX0JvvHQUEFYwSHJ4S4B9DT?=
 =?us-ascii?Q?F+pz39MZB2lHreIqFWLfrmYoEuCY4V1rEc6vPQ2SQOWnmHtGLWmFK5Jvew1A?=
 =?us-ascii?Q?G/ywCgHjWEaD8muzvn4GIcIj67RineNlIn4seB4Dm0g7yWlO1qd+Ar++VHX7?=
 =?us-ascii?Q?kE4d2+MCX4C+hkvSUeTpxryZEkmMRMMu3o6f178O1Eq6FHeKXVqKAsd1kJXk?=
 =?us-ascii?Q?UkFLJ2N6TzN0DuMgvrOBw7A/9C4FsNQ8YlbPjDglyFIxJzY7CoEienEyE2Dd?=
 =?us-ascii?Q?ilTxt93HTWTrxngbImWPWX038PpD4tTw0r+jxaZ2Jh/at7FgrV9Y+B7KgmH2?=
 =?us-ascii?Q?oZDOHW+hkC2VFb4MspgYiQtvgBqPxCOXTKLBJRFC+BeKkDYpvBVnb439+gdk?=
 =?us-ascii?Q?ewc3wNMkN9cqiDRuLUf+jBfhj+mBLpOeJG1rvAR7eOCPxGGNxagAXhRqDKRI?=
 =?us-ascii?Q?50czSFmztE12HonX9oJWODAC0x2sYfurk7SZOK2mNh805rLRf1FaIBGDuaua?=
 =?us-ascii?Q?BfLn539ZACjDrigavK6nAFMx/2HZjXmXdkcRiZZzZ+Yd6ItMHBIT2mQelJbF?=
 =?us-ascii?Q?HEr6fTOyqXzt10vR3DYQkfXDmDcrQIfeh9r9dPWdhe+BBt1CUe1yuL616x7W?=
 =?us-ascii?Q?IFIeJFlvt+AByCISiyIAHpH5QKG2XhSPJdBTx0nZuczo12QgTVXD4ZiQy22B?=
 =?us-ascii?Q?OP44PdMPq6DRjvt9WDblFPnGsKA2QiLxUcOujBI5jpKhS3TXmOAU/UIdj20E?=
 =?us-ascii?Q?UhGZamXq8dpNQWz9+Kwt+OiKjXfekK9hM3U8ByItZrMhUg7YqdaqRgnG6gwJ?=
 =?us-ascii?Q?9tvg+v3CtKhIKGQ7ZsSIfNGAcTL9BW4oYB10xvMUEkedOX9mIquukiorjaam?=
 =?us-ascii?Q?gKonF15EKyzy1GXDdlxn4PcSlo01Bq3DCFf0TZet7o01pBjjw/fmEhI4TC42?=
 =?us-ascii?Q?hfbc9SKSS4nsHQiki+7In7wFhJOBtcICPx0H6W2ZIpVl0BPIFQYhpLwl0EWE?=
 =?us-ascii?Q?IEboSQ/2oiHu49NmwcwM93HQX8Pac9AKBSJzpH77jWad?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0197e3-90ad-418a-50bc-08dcc71fab63
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 05:10:01.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6SsIhp/2sg/izc5xVl8kmsxf6gSQpDskkBKo/vrR7XdJGERbyhXIVRTJqczGvE2NbmqIUCfIYDSDGZ9aFprdrSku9xk0mVg+pQ7tu3Et9GynDsgS3QuZAXhSeYQYSO7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6506

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

