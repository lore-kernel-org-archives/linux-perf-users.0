Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021130.outbound.protection.outlook.com [52.101.62.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55291854
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495142; cv=fail; b=g3959l2RRE/uZd+488Vr9XpORBkAU3EgboV2/9cZ+gm3r0EAl+ruNcdcycrAt/1SEBu2+mSoMPJfCdJ4GcJITN4lTguP6vTiO1Uv3L/C0bua9x4ZsieeQiDM+OBiHS3aZnAyCQWYBGPgjpYE47ac8BjF593YMSB0VBCqK7v9a4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495142; c=relaxed/simple;
	bh=6TY83I2d/V6jPR5vSbX2nalJw1JP071kf7B8b0KUCsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j+vT9dJIQxAJx/HSp4csBzYJCaP3ZOqyaXX5ZInhm+KV/ZeFOvHXLDoC3CyzKkbaEN8jdzoQhl6MWv9htAp73UFnFZkOC7UsV9m9seK0Z8qsomfhMebajHL0leydomF3eSM5C73fwM4A81eBcKPe3Xcfc4/JolgzAitVsjj1qxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Qr2k9yIn; arc=fail smtp.client-ip=52.101.62.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Qr2k9yIn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5dj34qvGecfwJJAmbmEyOVi86yMOZ4yQZx4XMpiNQksGgYI+W9rH0cNkd8xhBbMkAaFcv85trNDYR7L2q0u94BxgZpowhbhHiIjRdgWPtimddh+9tEyZ0Dl+ODbGSr6wHmZoXj8bPUK6+g615w/xQ9kaxDC0RNo4jwlS9CARQ8NTMwuAVoOpN3UcnMKk4v+o5ak+z7OFml+7Zb7tAzO/dHf6vs2xl1Zi/6+vEIPz/qwQd/DY1sgNbND32xtsMRQIqKDIPJ9OwvN1/97rTO5XxlNwAbFIBVWbKPwegvSbgUaHuq8waeqnlkxM8iCoLBu5cLalwfZxwaSmdO3OSf/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3Z68xW8nOXTyEOcTAZJeJM/P2J92dmdOL3G/97x0/g=;
 b=IqLujuhuI1Zg8PLE9bHDjYF177N/UjqRsVME3kLgTJCnN64pYuNKKKdmXhvYVdAwb8QhDF9PAUnmBnivithjXIgD+yLyi9NhaCC1uQWLxKxWFPqNMIIeHd9u/jrm6oJ25w3LmkaEUKsg3r1WEs7X7K4o93oWlF67oef6wO2aXpWRB/it+RIRR36cHyM/EHZO00e8W5TWBDf3o9FcNsi/DI/24yyYaPBwr11YhuoojEVKysJgirYPSu8YPExzM5rhBvx51txuoRZoU8q9I6XjDFVphUk2EV6hEXE+b03LQ2xA9hvEroxljckEpbOu3Ky3a2xLpEfRFOjyI/S5Mb2IYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3Z68xW8nOXTyEOcTAZJeJM/P2J92dmdOL3G/97x0/g=;
 b=Qr2k9yInUMe5eQydNrNRvtNEqRTrr29+sfvek5xQ8mKV9P0CkHwZ8OvvGuTG5h1B4fgtEHWJncRGB7qge4yyGXLeAzoRjib98bWCKVkyo6PvUMJf6QEOqostj8EJI8NExkETw/B2+FEIBZt5M4MVfeuAQB2j01HkHlrODp+gJS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 MW6PR01MB8365.prod.exchangelabs.com (2603:10b6:303:248::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Thu, 5 Sep 2024 00:12:14 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 00:12:14 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V6 1/4] Add dso__is_pie call to identify ELF PIE
Date: Wed,  4 Sep 2024 18:11:32 -0600
Message-Id: <85d8de9558414879d19bd0c530f94a8002836166.1725493961.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725493961.git.scclevenger@os.amperecomputing.com>
References: <cover.1725493961.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:610:5b::24) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|MW6PR01MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: b00457f8-59ea-44e8-6259-08dccd3f6518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jb6j8aI1kb6zgQSrQg//pmOK7lyXLI2Ah0udNcudKlLa/zfdC+TOckxJzO3C?=
 =?us-ascii?Q?aqBo4H9Pkmlkk4vsRXxomM52zZIWhvsQafd9oSOlkq9/QT4iJiebhyWgwvCk?=
 =?us-ascii?Q?yJXsPaurHuCvOPzoxLput6U/Mjw2TldmPyBhbToS9Iw7oHE/S8ypUBJ7KD7m?=
 =?us-ascii?Q?YtM0AsrTKI74IrL+IA7QyiFnpsDPw51TTkeLP6pxxtQJGLJOMGDgp5w1AQhP?=
 =?us-ascii?Q?iyMgp7+nbnsqJXGchiF4GftbyeaNUW53ea8KguadodZigXUYfqm1m6dd5CC8?=
 =?us-ascii?Q?JTOjDFRsml571cq7qMpV2I4o3kWP7esH5EinaGdc9yiIfqbTb1cXDHJxL17J?=
 =?us-ascii?Q?T+C3Y0iLGro1E3rRBXsn7aJm/RzXf4SfU72wBZhQ8KhEwXwgonY1YMrB5sg9?=
 =?us-ascii?Q?i3Z3qEfvQJbHgcC9VK/946WhW+1Q2gwlx/JT5yvUyghV82SOOiKNntCfyJ30?=
 =?us-ascii?Q?ZFCyb1cM2FIWNHy3vcjOdDv27nRAg8w+F9hPISYlP12Epq+ez8Z7XpPI0Vx2?=
 =?us-ascii?Q?oiqaYkC7Xv5wDqgDOXZDjBj5cp9/+LQdwty2RFVJfI0yeMXaBZtjYiXvcVAH?=
 =?us-ascii?Q?EjPs0H3TA0zyCjulF8e20HIJKBUzzpYlLwA+Q7FMlfMeF1PXsTSTie4X2rPM?=
 =?us-ascii?Q?Wp4mOIFQ4XoMRxXRuhUPVTuTgfqf4c8qX5VRDpJH2uy4N1U+wLrqybuFXFFr?=
 =?us-ascii?Q?U7mC2sgcdFrkQo+RVgIhx6KpHv4vwA0bcRIdamrsbuDo3pEi7q8amsudEWmz?=
 =?us-ascii?Q?QGaUw+PCj8J7BQ+HW0KKndXRmTr86Mf59YmPVBPZwY79cAlQlAnyCc8w+03K?=
 =?us-ascii?Q?lh9dWhRq6xceEA9STsnEw6omJisAwapOkWrSXWPyxYb8OiGchLBXU2Q+AhxH?=
 =?us-ascii?Q?/nZfTrDVdUsjeFYfh9G4ud8UtuDFC7J1ClIHgMZibxTp5avWzKW9Oh5Xaxbr?=
 =?us-ascii?Q?z8In6YJzuvUjBL2SbWtbdrDH/RKrVPUMEe1ojDtAOuKsmG8aXcsa7nh5igy1?=
 =?us-ascii?Q?VEOI21HlgtUCMkaRc6rRr4rm80lOWtreFE8m0yWB+Pe8NfZM9FvFqgnCKUki?=
 =?us-ascii?Q?z2XLw6e1KxmvZkT/5txf/XgP1kAK08QUBn/xPp/hrE4vmDwu3ppYQdY98BCZ?=
 =?us-ascii?Q?mzJyKKmSxc+Z6SovvvLLI+inupwSMDVx++8ihvcStswfCtWkQyt8d2sHemSK?=
 =?us-ascii?Q?V/+umcWue6D51exUz24YF2qY129hGNif8uPaM35SeZfvt9Obmw+DG40g4P0b?=
 =?us-ascii?Q?8hQMwc0Y3w3NxKsTv8QjNPYEGg5mpRzWUFpnBwwvosy5UFU+k69pxjTVhw49?=
 =?us-ascii?Q?eauwCxnuYn9ae24mwFFdgcLpOajPYK58tsnnOoUSSydsugToHlUaUCPaP8R6?=
 =?us-ascii?Q?7EX1xut2L5Uv9Q0blJd5mL4J1KUZXVrmeUuMfh9AazqOmbE9UA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7+C+qApnfjGLLFFwZug8LFB+Ef17AjPMbc37N2wCgjswLkhoG//VqC5EaVuH?=
 =?us-ascii?Q?X9NVCk0XSE2IDfvHO5QGeu3yqfWWezbQNa2EUS3l1yRM/eZXN2xoAFeKeVBs?=
 =?us-ascii?Q?dTEFx9/N4k0RCo2j4GJAtQyALgXO5uXJPvr0NLp3GivwlO6gO7L3/sj66Q3U?=
 =?us-ascii?Q?le/iriMHwVVXtcKrESwHENVdoM58R6Lhq7ilCEceWcSNjzC97XouZtBFrA8I?=
 =?us-ascii?Q?6YeiWSZ07y6bwjLvnRl8/XEI8boHRLPq/p//yVHUDjj0sa6HXMtK7K3VUK9e?=
 =?us-ascii?Q?b3XP5687Of80Yv3IECV4oSdn1dB+w3eG8iDPpHZJu/FwRpGRbkPAdh8Ob3rM?=
 =?us-ascii?Q?H2R7J3S+QSQY7on+7osQZO4Hema+uG9iqgti624+9DTzNQH6z7sq58E27NR5?=
 =?us-ascii?Q?UJEwlxwjbulFifWMDWmfCE3aYcrqAs4NRmXKqCVdB7Ib711WqpVwASFQpKKX?=
 =?us-ascii?Q?8NSTWruuZDoQC9JQO3bwvsm9sKKlKyDg0Zvj0haxu2rS4m34xlKu51nNi8IP?=
 =?us-ascii?Q?Z2nhO3VcIuT5KuvwiyiPB0HcAZoN2OoEhrsXMndu0/qfCTbhKprBsOQNpo3x?=
 =?us-ascii?Q?P8GTVrFRZvWCF05uB22rDY47eVphVFtXBJY384Hy0+tD22ZPmVHU3B6NuwZU?=
 =?us-ascii?Q?jBzA+aA3aIZQinOYAozkcBVR6LbOmTGyoRytS8/WTHI76M48vhpNaxf7sOM3?=
 =?us-ascii?Q?RaJ04ZQLdTUYBKDQOMvOgAORvuVwRUFBzZl5E+aOicYQYqHUUHttcUBhulDo?=
 =?us-ascii?Q?jbyiQUOwvIVU2c+YNRx36knAZlxtGz1BnVJtuEZCAYz3LRcnmudyxpnhyxfK?=
 =?us-ascii?Q?kmNr/+554RfaVC4b5OKSVAy33u3je6qCuq7bZaWmDRbp/mPvWS3CrD7i4q4q?=
 =?us-ascii?Q?oHzcOocP6wf+acoQmhVkWOOnzGP5zx68KeirJ8mj2URnvB/wEuROxsVNVR0J?=
 =?us-ascii?Q?f4Q4DknZ+Ww0P8Rbsl1JpCjv7wKOu0yO4lVNicMyrXwiPoBLeURzQMTmfZGi?=
 =?us-ascii?Q?bFP0celb58si6SSZPiLk/nU0mkwm9DQZR3MaQAq2BJbE7Maikkkq81m7yyXp?=
 =?us-ascii?Q?Jvw25cBkKLmpmO+VIKS4GGql26RMUyoNCMhTUQJfJQ9y/PiCuhK55WzAYdNG?=
 =?us-ascii?Q?KVT2cggcueOxJDZrn1k+IpvCWsosIpkgmIdUERLEYLzd3nCIlGn1Nzt/fjJm?=
 =?us-ascii?Q?2RoBuXiAhkJ3LsLAoGFBmXgTHo2DunjNt80uIq6uKkKar9+TpIPOcm7MtpGb?=
 =?us-ascii?Q?QQDgDFPB5sEPVgarYtJHC6rpGBQUMW2VBE1jIr8CeE7o0aVpxVKCn007wKZ/?=
 =?us-ascii?Q?738fZ1OE2niBrifJsi1e7palLWh38ZSiXWgN04cX5iH73QeiKAXSiY7kjULB?=
 =?us-ascii?Q?0dYHfjmCblM6Rq8T6vXCjLM2UL0EKtFWhN33y0McH15OKfksFtkfcuPuXZKF?=
 =?us-ascii?Q?fjTvcf2uEPjppAmq3fs1EoQJ7vueVDtQ/k7JxTldQWoh0heY5f6i4GKSl2Ks?=
 =?us-ascii?Q?3Dn5o6wF0uqkZL64EiE1cxa+mNrwvTGAMknN+kXKTQVejHU42d1sY2H7WJ7o?=
 =?us-ascii?Q?PSCEF1f3cD0CsPH21oF5cHZGWSUloh8E/aWHt/wDIS2Vk2pfkYQFClb6p6dN?=
 =?us-ascii?Q?gi8TQPtxRXidtMYla5oiyh6aSSn2In4pWBGqZxTWc7D3?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00457f8-59ea-44e8-6259-08dccd3f6518
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 00:12:14.3440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCvd+ugdMMIRPFPXeCUPDcdYdXk4B219vQeXxtpKf1A2rFmmbHa38sm2/GF0PzK80a50D80GT4Kiz3quFL9a2Pg1ueJFTh0fCuO0CEpn5WUXJgvVjCIVE0bQcPTbqpHH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8365

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

