Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022137.outbound.protection.outlook.com [40.93.195.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD119B3FF
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Aug 2024 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708185; cv=fail; b=suD2oWT1cMFc6Uzsx6o/KYsLJ08uRUTOWMPW8D/CpJoOems8L9vv03JWuwBH3Ohx6/DYLlHmLApiZHYz5NBLBqPOBBCG4jbU++WMMVBA4TpgToLxcdv3sdCewRdg99wJACAP0ex1SsqZI0TvocX/JlyKF5Auxut/9zyTKVb5/UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708185; c=relaxed/simple;
	bh=3OAzw7IQaMjI5mC7qzygTCMVokpwBnYIHRq3YVRG8w4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TCJp+LvjF3MthI/ngAsTUsTfo11j8N5zFXf9i5rhhkwx5TMXWd5bL4jTnMIykPon2oZX2OjMP0NjbuYgWA/TgkdNWDUqMVVY2rv88iD3d5x24VI3Jkt/GnJlucjda2uWr2kfwBBYDIqSTs/fsPKY4xe0Ja/CAMgOL/zneILj09M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ojM8vg3F; arc=fail smtp.client-ip=40.93.195.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ojM8vg3F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlMYGyRqxh7Z/FMR23ainTFSjbB0s0UqafaSxet863EhKJ4DznYjBqrFRDGboHlO/kqd3oa2VPBQRZ7vbtbsD+AkNj1PBjF8INN9SsRV1YiHGEmkKAEUIKKRrysNdwQW+dd/bGi6Ss3grt5M/II0vohq5Q18R9M8zMWM8WcaNCeI6VoqylIC6/L4sG3ij61Rfaz+IdYtNHPJp7UvO2Jn5WEnKXT0urFVhOblspj935IIWYkDsCQNpcaWUCQ+K4GHJPu3KBUeCS63bFCKYnDbOFB9RVrmIRI2AT7SO7oVpr+vKGYoko+W2TbWAECeo/V84qSsVB4uAeskXGteYfiouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aO6isEzkq6NgGksaVY8RsXysbfIH+NsY0J1DpoyxZk=;
 b=MGHFgNCR4F+lhkhYLGgPkGwgh+Vly+sr+8ntLZVU67+5CkgXZc0E5PV9tjKscJWTbD41nrrQzjOwRdTuPdy/7/rQZYwBGP2WlUeUnSvS6p/oDAkacYa+VgjLOaImfr9b4YVMh0wujKAHL3cbEI9DbRBHFX0vzpCITmjQMthXDWj7OeGn94rpNlZwukD1H7abCs0ywMOdyKsDCJU+Rd9RtGNAJk4enVTR6HroFfu4e1/+tzUh9sDpYJOWw/Kw6lqsQIJUCDoqWJqUcbME6lgGVCcoFBQqfhQBh2iskgdGfLIINLHw/q739Z8rfYcnbxMwbCIAkSCVlk8EtWhKsOilOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aO6isEzkq6NgGksaVY8RsXysbfIH+NsY0J1DpoyxZk=;
 b=ojM8vg3F39QTpSvDPvIAGcgajBgiao+Re3EANP3KmjVzNZVaeTE7HQBvopQZopmCl7zZGOUys/QaxntHh789wLd8s2nFTEnZHX11byusMmviyHJtAxLkHsnFjkf+kDXZS/SvYU+8oQolC4DcJM4ogLnNEkhQg+utKA1QEdPwtQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8150.prod.exchangelabs.com (2603:10b6:a03:4ff::5) by
 CYYPR01MB8410.prod.exchangelabs.com (2603:10b6:930:c9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Mon, 26 Aug 2024 21:36:22 +0000
Received: from SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea]) by SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 21:36:22 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 2/5] Add dso__is_pie prototype
Date: Mon, 26 Aug 2024 15:35:55 -0600
Message-Id: <197c2518fe6faea400e7d6ba49c28852fa48007f.1724698250.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724698250.git.scclevenger@os.amperecomputing.com>
References: <cover.1724698250.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQ1P288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::7) To SJ2PR01MB8150.prod.exchangelabs.com
 (2603:10b6:a03:4ff::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8150:EE_|CYYPR01MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 86035f4b-3175-416e-2dd9-08dcc6172123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iH1cU8qirZzt65jQEtxf+8t3bgFD1RvHtyJ9pL1P1fgt6JV3G9VJIRWMQq0y?=
 =?us-ascii?Q?Q3fvAVUfqoAAD7Qr8P8DlIaNCa/JH5QtD3wJd+Fak02oeen+Tnq1t3hPbh+5?=
 =?us-ascii?Q?dCu+rBw3hQvD4NDd2BWL/OCbMpqHNNqFH9digRPCXd4vmM6kWluRCR2Zm85U?=
 =?us-ascii?Q?pl46PT/LAHvbhC/U5KherOsoVvy8Eop7Sn16ctwYh725KXAuyZj6qAL1aYy+?=
 =?us-ascii?Q?CZFrfGpN3Oxez118CX2Vn4XqCmBoU2r2qpJuRwtyT1DX9L/OZupetdodof3j?=
 =?us-ascii?Q?EDyByZdMCjSdbtM75dKItho4g5ukH2vERWxjKhBhQDYvrPi+wA1+chcnG/dA?=
 =?us-ascii?Q?TimCIVuki/YeWwFPU3UIQZ+NrkEsfaLNMXhHDmQh98y6hL1gREXc2hrkDWzu?=
 =?us-ascii?Q?HrvjIF9MbsrfZnJHdgDy8dMFNnBR1mnKToK0lf6N6Z9quPiv9xsKcMi3M9fu?=
 =?us-ascii?Q?xQeRt5beAY8OlmxuLR8juL1WFdCRWTkymQ3AaErTj5dEZ0Hp8GzqFLvcuTsT?=
 =?us-ascii?Q?EGP77C+MZL5B2omicwgLHNeuT5FBOEQF8MiDVwB70N6SPUrwl6Lx+5NFw/SC?=
 =?us-ascii?Q?CFtx2rSbIduJJILx5llMwMKcPP78S2uV12FOUYjJbZTwXlUdUMGk7ruP9ICe?=
 =?us-ascii?Q?1zBn/ChK5X65G1cjrKcHUsMbl+rJDk9onwmwgiok4hKak/9C7bcS4o2TnfcE?=
 =?us-ascii?Q?t8I+tdDH5eQUGZ5WNphfdcSPCrfuo9F1TvUOzDJc6SNJ7Li2e0XjCfR6DImX?=
 =?us-ascii?Q?oc5uooSiIPncrXEyoqs2Qq8rPc4X8QE13kaJuvIOZevXenlaLsoZCGRmptEq?=
 =?us-ascii?Q?q6vtdnIC9q74gDLIx6wjHsYWTBlosBllbacUPMksZNUwWqLm6szr40GwMiAC?=
 =?us-ascii?Q?zMyd3VTpHsga37iBgf3bv5JCVPxYr/Qc8jux8GeRusxQSDgF1zb/mB7yzg1j?=
 =?us-ascii?Q?yb/dOW7kQgyAqvsjch6zpkSmPcOVGrWezoH9uyPP8ZOzQj6ukedqSw9l8zux?=
 =?us-ascii?Q?7IlzAuRBC3WV2JTE7SA9249kPzrst3d+HYSTPGacb438IcfAuT4Z2RpQdaU2?=
 =?us-ascii?Q?kcZhaK1zRL8/Ojxq3+KTlVUs1ddu0H5ENPJXS7I1B4WlnMRqZOeQo/TJG8cG?=
 =?us-ascii?Q?Bf/eRSnAf9h+Ux52mkOvcCdwBLO5fpraCpa590uiNQr1EgNgONc5DWrFuI9S?=
 =?us-ascii?Q?2XShUq9YDaIulPi4wvfcTZDg8nlVDOKOfYFmrHo/3cIUewt1tGVfAgsRrEJX?=
 =?us-ascii?Q?qqR+xFglY1h+qVo1bWVjMSWsK5hPnkCvzs5nV9SSkAPeUka3QJmqANX6OQwQ?=
 =?us-ascii?Q?RnE73ezaMGNk8ROlukF80yLfGiTOMSUu64IGa8HWBResHjsCYFhct+lVHHQ6?=
 =?us-ascii?Q?0dOfNMjerUJC3ywSx5yrql8OI24AHs0wHkgF3S2/4uIBY3FpqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8150.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ctO1BUw72qJrdK33GrURG9pkzDaqvgI98KAWm8QekGlh56V2eX08gziMYCad?=
 =?us-ascii?Q?pN3dTKfQYVjDin7m16ucuYVk1MWeAso6n9cxrKuf5gBlj9ekOC3wd4g5sKL1?=
 =?us-ascii?Q?aUZfdIOb0vnn+Ss4DHBNEuERxHgFfIlveLPu7xanqdK9KJ5D9FBzMEeHk3Yj?=
 =?us-ascii?Q?Z0MZ1SwFCIHJ5H+AENMznmwD3umZtzLRd8ftLPQA0UFUpN6Uu9aVJ5i3pj8y?=
 =?us-ascii?Q?0RqGyVYJs2mRXvrrE6xpoE6HH1I6ul3sJTbQ/an/YO49mRqIt3fH/CMevytW?=
 =?us-ascii?Q?wn0znLT2sBk9cXgnRPcKwT7WG6dJ2vhHLlzaFEwNsiuNwUj4VVfHxtFYF9S+?=
 =?us-ascii?Q?ChUOCoCYGGAAxDRIHrVnzjuZzcM87Ky1bQpS1yQiYQacjVyzhNUw3TBZHKQY?=
 =?us-ascii?Q?7vqL1ftylqkX3tO6MFPhtZyCibEWWkdhJ8OE6BoQYUj/UQkwE908uPfAwotF?=
 =?us-ascii?Q?bX3KLog+DD1zrpXiZOeGD9imm0SNVRV1Cr4AgLTwr5H1Wtay619zjEdzOYNy?=
 =?us-ascii?Q?TneJPDRe8owVMLpp+jRjgnBmJqWSOCAebtCMU3wUqyTaXkJw8VYS68Ox1eC3?=
 =?us-ascii?Q?HE51M/YqK0OfExxWPicTp0K/k9j2p1Hf3by8rshCu7Wm4+alXrzl460OFK/j?=
 =?us-ascii?Q?YH1vhwD2S8ztmXBfZ6j6WGstT4RkcqM58rckSDy8E2ni9VZaEcGrXM3xsbn2?=
 =?us-ascii?Q?C6kbbPpTJ3mi71HbXAuwFKYz7rmL55UDsWAJiwuoMR1q9fw0w7AJtRjvYc1c?=
 =?us-ascii?Q?gi0lCQFBvOqiQBAnnT9Y3P5Kviiz5iPNTRqkuvfcFgXwBWM3uBCYAj2NHW1f?=
 =?us-ascii?Q?qJb99XJre6b2UDvyG49BWjIZBlK/m+0Ki2z6InSyqnp7F2hXYzHHSW21TUck?=
 =?us-ascii?Q?ed4o8nQGp+M7uZkuMB2uV2U4rE2wTrdJC1zf2x6sDV2TnwJfdXztrtq+OLXm?=
 =?us-ascii?Q?+U4pOsX11E26XfX1DtoaRnbsQr634Gj9play/hew79BB7U3zgYds1RAhd1Hw?=
 =?us-ascii?Q?NTNLNakj4sOkgRNZ6vGs8Uu/PkoNl+42lxXloFyJtJo223y0jz3mHhiR5+Rt?=
 =?us-ascii?Q?M+P4zn2jZ7+QtsWGWLR9ScqUca/xxSPBtOvwRhEe1yu9JneBI1ErmumCkN2n?=
 =?us-ascii?Q?OpPvLQjARYxST0XjTGDma/CwR7bB+HNNk38ikCel+l62opboBV27hibp6Krf?=
 =?us-ascii?Q?uz+ginYa1BqVU22HvrAGrcjPq/BuA5k3jIjlkx2p89el8xV8IxN8lBIBQ74A?=
 =?us-ascii?Q?ibHgsvvNP/lRDGZSYIiBekkAQcTx3F/mFZhFzIbFOYgIVEhCPOWX1pdtOEya?=
 =?us-ascii?Q?v6/Qm5rPU2aNSdzrH0f+4quqC6P8bQVvqkjLYglhxUl6XR4BKceDl38gVHs2?=
 =?us-ascii?Q?iNvWl1Br5ykLMLVnTCpDprLnF85vct2IBo7vy4323PEj0VyTwsus/1+Jh3MS?=
 =?us-ascii?Q?9vqVqpFdsjtdheMtPEQI3dznI4zZFwrbIIqwsjVR40MPKpDnv4UVy3uFfsvA?=
 =?us-ascii?Q?YEipcu3gtWudAIV2KVt4UIzvuignuIy1V4wSGWgM3ynzxM9WmdUh7M1LpYk2?=
 =?us-ascii?Q?uGM/y2z9LrZr26heD14itE12/E+2Yg62s2ndQGacsbT+0xDZ1Qw3CHFISaUA?=
 =?us-ascii?Q?xVQ0Kxjqmy1Ic9I5htJ6+ZfAtNzNi7vjEI4z9YLtITkj?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86035f4b-3175-416e-2dd9-08dcc6172123
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8150.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:36:22.3990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1VvAXPMNjhR+4DN5IBc225sveXOmDpomJCPu0BN/8qgzySJQZXwBLOlk55pH/w7rEUXprevaLkWbIRvtuwTJ+l/S5pADhDGnKRPgdjafYbuaWiV0BMVcGzIdV4etGg9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8410

Changes in V2:
  - Updated mailing list distribution

Add prototype to dso__is_pie() global.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 tools/perf/util/symbol.h | 1 +
 1 file changed, 1 insertion(+)

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

