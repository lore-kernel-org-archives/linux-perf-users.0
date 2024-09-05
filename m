Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020095.outbound.protection.outlook.com [40.93.198.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF61B12CA
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575334; cv=fail; b=NjimuggZAGrlJgKmqLezK42pFM/DMvcQQMjkVtGCuF2Mpjc5acXNcxNVawC5jImhiNvG/Qph4s+GcWavvyOtXXrUDCsTYh5LSkWM/N7rP0Mi/UciVTGobY8jnbCb5rTZGMVFQrqEjA5QOhID882ly3gB+hkHoe3Hp5c0NdkGiXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575334; c=relaxed/simple;
	bh=6TY83I2d/V6jPR5vSbX2nalJw1JP071kf7B8b0KUCsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uc43o/O5/cnwcUUE2wVMJuJznw9SdtxXbM3Cg4SNN8M7RdImDRwkKxK7UwBnA7eZeOBdoqemrlA3T/J20xGIsbaSpWHqAo4ZRV3HAwAfs0bznTixLPiysOX05YjcSOnrfst9hEntuxY5Vha8WzGam1r1+wLVRVoMZuezmSS1o3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=N8DCKt3t; arc=fail smtp.client-ip=40.93.198.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="N8DCKt3t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNM666JZBWMXNxGu1g/mcthg/LTAIgxxPvINfgLFvo+XxFnKhw8ZqEPCIHHMYgmlhhacc063GTBlj31e7znnduyiry+TizfpoaoY+W6wNtL+ao/1XzHBQ//iYr5QhUXxxRNXxJbgcJoJDdlv66/w/TzrmoaatDqFPK7TpBGFfJ8bOKeCQa2RDOfLdalsQafz63QLLFQCghaKE5uTZofB8vwV0fGsVAruKjN5bYSVt7P4COz7WwKSzU2opFo08mho5t7apABY7SopawvV1rHZvnsPgrWVqraJoXiD3W0lZwx86LYVYiLltboh4hZkV0Bt0CAUVi8XcS2aUdxFfPxu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3Z68xW8nOXTyEOcTAZJeJM/P2J92dmdOL3G/97x0/g=;
 b=q5WukhleqQvn+zrcS7RkUVLMT6gOWiaM+6ttM95p6g6lzGmVDZ4ZqeRe9bcie9xwxXYnNTRRWeDt/J1kjkQSZkpdxUbqUMZZKhqZlHu7whMpt0K6mR1IFIDdCXrqiouT35crT9I/84ipLcU0TxPRQaTPb6J7O55qhCuE/BEnTobYturWNhE+E6ZAUj1jTw266aL+PLUpJ+l6SVWt1tO7WhTJFKIaQ2xAawpo+R9noDf3s5v2PUyzNDxVSqakMuRu9uXGBeDg3S3QiVuCuP/RLUPFrNvZOyQGbc9HsTNN3QQfZpDNbrBvvAEJQeK9qw9gnh/9YwL91mm2U3a22AAdXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3Z68xW8nOXTyEOcTAZJeJM/P2J92dmdOL3G/97x0/g=;
 b=N8DCKt3tTI3HigsvUEOv9XApol3k9sIbgT3xQrrv+cRvVh+SZtXKu83LKrehrSgLYVB/KxXbFSWUcFcRcifgc37a2bfp+7k3wJ+3qy+bss0MaoBW44xJNnsiFXFsEmsKPW4DIHRcNNofa7GLVFDqxrtVSNqFNL8oga+oKe75y00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 PH0PR01MB6501.prod.exchangelabs.com (2603:10b6:510:15::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Thu, 5 Sep 2024 22:28:47 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 22:28:47 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V7 1/4] Add dso__is_pie call to identify ELF PIE
Date: Thu,  5 Sep 2024 16:28:28 -0600
Message-Id: <d13773b41fb11f8e2d202e9a66eea8430456c5df.1725573309.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725573309.git.scclevenger@os.amperecomputing.com>
References: <cover.1725573309.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0056.namprd18.prod.outlook.com
 (2603:10b6:610:55::36) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|PH0PR01MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d944949-a4bf-4a3b-ea38-08dccdfa1c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p8vkYlx7S1p4Ix4veCsmfHghqHXMACBloQSTFY4ro3e7PAAW+DEyPUif9SaW?=
 =?us-ascii?Q?iprcxu2G6NF6cEI29NP2DyJV084bnsIArWSuoFvO0VMBqdCY3ijjKAWUFCJI?=
 =?us-ascii?Q?ikOAfDu8UzNI8tkzghjBRAjQeNvTVD+v7Kc1jGAejF0xHfwNGU3ocnFE/lZ/?=
 =?us-ascii?Q?Qyc/cVs8dydZDmGZ57K5VQBm5dSHoQ89uw3s8+I4zp9z374zX0kH26LeA0Ce?=
 =?us-ascii?Q?sg9UbNKhH324Cs/7spFLUvTZukTplGOGAhvEpui5Expuvswk1l7jVHaYWe8I?=
 =?us-ascii?Q?Y0M/V8gnBat9Da3leVLWQncUBqPM7rBoRoDW91CMXXubtvTgKXVoFLcRmHnW?=
 =?us-ascii?Q?4/mbdJoJpV4UIHhvONYK/H/ZfV7xeGmlLgFsXbAwCfvz95iTzEmy9gSgTOMJ?=
 =?us-ascii?Q?FVWFewSNDY/64fIw9Q8xfU/7IxouNXGToFcmpyKDGrs5l719h3gN0F6aSL3E?=
 =?us-ascii?Q?HMK15ycGcQqs4l77y/rNLc1/42cADXwsacC76WLX5oGqCTLzFCN/jeFVMNsE?=
 =?us-ascii?Q?axGeDJICbnhEGZDWPVX3q0D1lzuTGlby6NZl8Y9hW1RDXO8ZUonwa5WmOh/g?=
 =?us-ascii?Q?z7KKUEPCk5MWQLGUR/KA8wtJxUesFZM1jJ06Q97js/1F/uDByRolS+gBEuJ5?=
 =?us-ascii?Q?igKHSq52/tJ37an/V6WdDpq7G9JhVKIE6Vwb8p0F0gPEt8DLRFSsWVEY6cnS?=
 =?us-ascii?Q?Dd6Dlt53GToaiFbjHR9M4NYTOQJq4A5QuyPcJM6RCZleDsk6Lc8489M7pOMO?=
 =?us-ascii?Q?jn4wRbCrlW4IyHMfyh9oGc5N7h9sDUFNkqBQu1zavG+pia56VEbWJtibtmOI?=
 =?us-ascii?Q?rbFlknx+drY/EstHNLZAROkJOInCenOKm8eMhliHxiM5zJNmWNTxhwX79GK+?=
 =?us-ascii?Q?gxHocNLpZ9EYnz+dpJ3W5p/YntLJoOo2KmWH19MeBAsKQQNgKAMKSC2HckSP?=
 =?us-ascii?Q?/6Tw/0k2vs3sw/iBq4tTuNICcSbjgl50zY76eBaK24BCDVW6UHsdUOOqMil5?=
 =?us-ascii?Q?pFBDg51s26eGPtiuypNF0tiaKd1oFbkUULumOE9FCQO2QZE9lISKthvdme9F?=
 =?us-ascii?Q?62CLYaVg0A6MBOVazeWNcoCDtOURMEg+yLjMscWTulTWu4k1TRmB1nQ2X7Ys?=
 =?us-ascii?Q?svZz5suBfE0P4FYEH302VxJ3Al7L9aYRzOSO060TNsf7KWLK4UWqzFZZijP3?=
 =?us-ascii?Q?/Py7xEyd1cjOnZFiOeheR4CA2rAlIaMFOm9ozMrXwtyK40z/fj/j/B3u27YX?=
 =?us-ascii?Q?K5xnA11/pZU7p4p3nBjB1nYlUZrsnCMaZpyO1mvJg++wktZ4GeX8wBGUJkIM?=
 =?us-ascii?Q?YYiqEicLUFauscFzy6i5gqFoX7gpRCEgmzu5SVWrG3uJTeMslqX6HWafU2qf?=
 =?us-ascii?Q?RvUL52BKAh0z1N0iX8ikSt3n5OqdivnvCNY/FpgrZaXvFlnCkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CZrEQEC/7/IK8KS0ujj8yPoJ96uYTZfaHDIdhWbDqm2ulXOPvUz6XM/3wR9e?=
 =?us-ascii?Q?jPD9Wr+VJRcfwW9VLt63xq6JrSQmD7lnaAlZsCwTuiBt4ryTOTvRSn/pDJMS?=
 =?us-ascii?Q?Byaq2WDd+Ie8rxvHNuNx42W+oZEBeQXRqJwbgMUA1GaseaRn6uN30uYfeMC8?=
 =?us-ascii?Q?m5z/ftmEpPS8Jx8px3/TNf8fhaQZChw9HKvCD/FxNbDLBLXjdrkVwO0Feuzn?=
 =?us-ascii?Q?9G92mvtDIja5FShyx4tVL78OUZ+1TBArZ3ruXCAmwyoRpqx0Agt+Y+DfgDyV?=
 =?us-ascii?Q?6MEOTGWAd9gMLiw5gMsr32oTUOlWiLHqzmBnRsVwcYFu4Pg+hVVcJaPudHSB?=
 =?us-ascii?Q?G4ni0ezGeDc2uxNiAysxsqMUQubOdz9vxvy9/edH2z0EoeY0iqZfP30UYa73?=
 =?us-ascii?Q?pWLSlYGT9LSeASlQcHC1WH2f5134zjVgny1vSRjTyodCIfVrDPDh5KwWPGsL?=
 =?us-ascii?Q?tqM3AY4OyJz8P35/Na8Phc/wAtRIFM2qZI1qg6AOMZdUwqNt8cU4H2pJxsCF?=
 =?us-ascii?Q?c4CvSXwUncp+dxX9OPIk8epvHF9Jq+pZiV5pHSrEqUTN9VOoheaSOGVhYTbD?=
 =?us-ascii?Q?n2S5VMk3oLrEctdtpsZonxtZYfP84I2CNwT3m4RXxu0Rsu24w5sl5Fo0mAIT?=
 =?us-ascii?Q?l9dvGtUC0YmF61131a/Vvpd8s5y4IpIMNqkoRpqb21qY8gi5xoaI12CBME8Y?=
 =?us-ascii?Q?lihFJ8MANDbm6eHW9PvmeoNfMTNAriUPWbPwlJM3opz2+2Xcm5L87kZuI9Pz?=
 =?us-ascii?Q?Dy0cH2TObRbHYiGQJTyYzqNF0Pi1GwXU3KA+uXDnO5FXAQPXHPdIXpqt98t2?=
 =?us-ascii?Q?cXG7JhHznNdsXsMmik5rNR9IunNjsm9TxJdauhpCEJoaY6cUtOn131ymkmZf?=
 =?us-ascii?Q?zEAd5G7Zu47zLwBZ6dSVDp8e1hlJINGoxRTdoVgXseQUJCytQSjvmAzgQ2S4?=
 =?us-ascii?Q?H9EIy/23WBFjJ3IovVWfc8Y+kPFtV7LAS3VDYFEXTKdX7ZIaaE7cYjTllfeI?=
 =?us-ascii?Q?Ah6NRCQ1MF2O+KqeMsuqR4/h1COFsjnSIZ3QCyMwfof1U9K3UNMe8+NETrSr?=
 =?us-ascii?Q?4tpAIKeac3Fe3SgaWAzF/zmtTAU7AcbXIkbkBYx/WZ9rGxbwOAQumSkvuPoF?=
 =?us-ascii?Q?kaXw4cQIv5WOjKdnGeAsSJQGY31TpTf9T38ZyTgV2H2wVSSOWjqrpJop1KZt?=
 =?us-ascii?Q?vMkvjEygmWwCbXcfGTCzrbSVHz0+bMUB8fFPOczOYU5gtzX1Vql3esvEe7VS?=
 =?us-ascii?Q?NOJrJ7oONhFmbsAuWh7RxhIcmg6AOv/sYcK2SiZgPD1UEqnRhDO129V2ZFaa?=
 =?us-ascii?Q?Ubh0aylWDvde0Po/+grUoBRigH2gqyZ4RPlfeI0j2fgUQLEKurGuDKOvynol?=
 =?us-ascii?Q?Zrkb8GHlxHm0QSjFNJihxcp7WksyOxIBhf1rQOUS4wAjZM7AnZuz8vU2lsLj?=
 =?us-ascii?Q?7WXsK8VbQVFNtAFumhjJkIXJu03YcF3kyoo0xM+t5BlfdWaG6z7ApCA2LxhO?=
 =?us-ascii?Q?EQCeV3GpyjoR99usvBuRMlovfFSmRIsPazfDTNNpjrOvC3E99aHO34UuhDIi?=
 =?us-ascii?Q?6pdu3xklceWcCNrSRC1QQ8Yml9kZXmFIl1Ou5EMGjCP6zRIo9dtmWYcB0/MR?=
 =?us-ascii?Q?4kSjxxV6JdglqVdQIfFphXt29PgWcmhOX6TC5WuoAu84?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d944949-a4bf-4a3b-ea38-08dccdfa1c11
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 22:28:47.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRcAPmZM6dBmzyb4Mr0uNT49D0aJbbWAb366pfotY364bsBwG93O1jAgOZKczEHrEalybHRQnyy9xjTmIlz9/A/N+i8xF6NXpp68IDKg1cIsiionBYkF7siu1knfY1Pn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6501

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

