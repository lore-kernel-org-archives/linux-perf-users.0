Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022137.outbound.protection.outlook.com [40.93.195.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEDF19A28D
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Aug 2024 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708184; cv=fail; b=TQ+cUTqGKQJAfOfHEI5Puv3+OPVdoFFy/I10dGLj/sQZWqoTslt7j2mzgvlh+jI/w6LsmPOYkyQHDde2UwTNfEGDdke0lVl2ux4IRYK4jHl1Nj82ZLScbp/O/EgD4mzK4BqOxcpDBHbGlZ/IL55qSEC+YzduvuyHTBoIcw/QIxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708184; c=relaxed/simple;
	bh=KorjlXjmjhKLgDD61bbbDAOgqn2RVSAX9Tj4zWUblYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W8kl0owQjWKtoF3Ht9VpVEJUssYh/kU4EJbPxxX9SQ6RbMV8IOVL+oaptEQeEy+doRlVCTXfJ0w9g47lOcMpnEZ9iwPQdjStGqARTE/llL8LMYYg7sdUi9TDHf3SEqqfHkpRLkyu2h3v25POglnRoFzV2eA9BR0e6dyfCC/JnuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=fFlQ5MF2; arc=fail smtp.client-ip=40.93.195.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="fFlQ5MF2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLbyETG4lnMoOsjvBg6H/YP1yrsYFjvWVje8HGj/slEGcsqRx4Qhus/+zP9qnuVa1Henc4mXdcLZBCY4t5AOT6Rd4mzcO7m3zWWKI6j7IjwMYoCJa9UuZgXffwidYIfQFpjJQdYx/Bu7MXVIse8tu8OMqUkwAm0zMr4qwKT3lHj/OQqNuvqtej49fuE9a5lepB5v1twV1XyiKwJBtgcG8beIsJkS3mukH/EqLaJnoUmMu9zX+hinJzPhRG9Ho2NBBIGS39Jzes1WKQKxTZ5NrS/xB3Uqf9VWRTn6g5Za5ZDZalqyqlmScdLU6RWgzaAVRzlsZgrMhaO/j4aCK3LKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OF+jnntJ/0cyM9SmXgZIk+3jfpGgZNHq/ixJEgd9brw=;
 b=sJuyh/i10G3knGOzBQ7modEz6klOnvK0bOP/lDt/0a/2sd3e3Rl6BLwgG2WOCpFcFmOPHrrHAeRUfz7mBb8jfMkHiDumnc1+N4eW3Zf3SpPxghANmEgvBhMC6UXBDG7iWJn7PtkGIe4gz4Bx/wm57fiPRZnujSXwAza6nfg1RnqdN3BQOtv95LaNkCwwyDB5tUN1JiJWttp8m0jCkp62QLqVXqE8dqo701E/tpYcE+qhprLvPL2SGfZx5ocmnc5WY28+tCphb58r/NjY7tSnEDK+7bsf3i7gT7qo4/VtD8l+D/c/CLiZQhrqilX6oLoSgzlX5hCU5nNGd25CUDfaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF+jnntJ/0cyM9SmXgZIk+3jfpGgZNHq/ixJEgd9brw=;
 b=fFlQ5MF2koCmXK/QGceW/SjPxErmKWUFcTJWxx0CPZZJjdUSpCCRgZcG5qnx0Z38gd8EfpW4r/sxHEtFHXWLfHeb9pG0nxaWlSn2ZsrGZsmzuB4o6ELfu3lrdcwhVR/QEzmPojgkPVMHNHglcjv+Unb3sx7r2Ut852312I3x/Wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8150.prod.exchangelabs.com (2603:10b6:a03:4ff::5) by
 CYYPR01MB8410.prod.exchangelabs.com (2603:10b6:930:c9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Mon, 26 Aug 2024 21:36:20 +0000
Received: from SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea]) by SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 21:36:20 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 3/5] Force MAPPING_TYPE__IDENTIY for PIE
Date: Mon, 26 Aug 2024 15:35:54 -0600
Message-Id: <2ed246c95cac628cffc1628c115a4b791459f8fe.1724698250.git.scclevenger@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6067510b-6551-4349-2bed-08dcc6171fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DvRdaSl1+UtOhmUw3gO8AAxAcjN2NGThyDVVH9Q2z0NSxICrfQcwrUB0UXcb?=
 =?us-ascii?Q?+EB/Bg7VGxFDwKCdu8WJXkY0OKUrrsf+XlwvwI7mbtIMTb44yMdJbraNyncU?=
 =?us-ascii?Q?H1yztK7PevqPvOYbRW2W3LUiVz1FERYwTL8Q89ktVD2utOmD56m+3f0v/n2H?=
 =?us-ascii?Q?ncwo5SDz99N6mPv4axhQGJFafLpAn45rXreHDndVVPLsnA1wvbmSmn8zEF7Q?=
 =?us-ascii?Q?1R82DUkCG2rdccs0Yw/EtOpqK8u22lyknl+wKlwUq7LC33o8oXCLODiMCdex?=
 =?us-ascii?Q?aqxEcS34+FtzdlY4k38dxPOx6zu2G1ETrdNuu3/c3yE/4+2LHdNBHEACkuK7?=
 =?us-ascii?Q?sa3UhhOO1Q8cwCoKR+p+WJnHx2j5y0QOdX9eL5yaOs1jeb6IOKJN68DxWao1?=
 =?us-ascii?Q?n/JiS+vxuyPRfVP3oBpnxhkmI14jvkluvtgJgsZHlAP6M84W5J1IlKRa/cbu?=
 =?us-ascii?Q?rGgBVQUdxTDY07KbQTd7MdzTQ5Zb+gRftE69BxkuEEwXxrih8Guj/4pdwA9S?=
 =?us-ascii?Q?rKzYutQgXFA9z2qtHzMtJo/lhff529KzHF+DEGLv30y6CWEqDqv0pYV4SB8r?=
 =?us-ascii?Q?LDMo+zvTmmezw7fMXdZ7M7gFcLGOeQ19yfop48k9ZhHXuPD2R+PrUY1rexsC?=
 =?us-ascii?Q?O+9Z/8WQzHhAWpgsObQ14iXp5R8LhrJuA2hm+2gssjkdQGpcheoO/Onu89us?=
 =?us-ascii?Q?sI+o+y/k+ZEXoXPDXc/V/FRxpI8GN/Ds8XNNPfD/DpNoIsomgtPsMPZAQdcU?=
 =?us-ascii?Q?8zAjX8aDnAkULUdpybM+UcvgkLrzGjrI4mOBpn9vvU/PlAQuxtTUGWQeKYBz?=
 =?us-ascii?Q?WwrHdpcr4d92UfCgCTqWSbt8R/DudMyVlHyg8vYBZ5ezuU9sIvLvORf7aYJZ?=
 =?us-ascii?Q?zjhOeP50N6CYZutWUN6s/d2v8ZDr0V8oJtpzBV4GtBHxVTOpWXrrTrHsSP4w?=
 =?us-ascii?Q?zjevG41AJ3xK7lP6AB9Q7BfTo2+x/HUtoMRxttU4U1+3ddjbSj9fighcdTif?=
 =?us-ascii?Q?5rSdKqIPm1k2kP0VK7b1TSkcCdDFQ3SWKz28C7igwfkPRIHsvlN9J1Y0bvbe?=
 =?us-ascii?Q?MlUaq+/Z8RieQlb5YcyfsvuOs1p+Fa9tfVPDKfYX5Ngklqu5bQQl9vYbsZnz?=
 =?us-ascii?Q?gUmBktCiXd3Z1j15JU6c/L3rm6eZGlivjkxU6WhzhQHdl4yvwKGPTPxdVg/6?=
 =?us-ascii?Q?IK9GY+9+9tiUzeH0tKg8Z1GnqbmN2d9eSMi3O8lDGR5VKe3T5Nyz1tiLZ9C2?=
 =?us-ascii?Q?QFqEU1zkTgT1Xa6/FaGevtk/fHWY+mfewZEnIOrGOdg6vdGmPD0lUatNdhfT?=
 =?us-ascii?Q?JSGhRL9OPPJny3PY8wrKtUgi4/fZyZPejes/8Lvf2OgUkhWQ7EEVoaZKQnps?=
 =?us-ascii?Q?IIhgXTF2QMRTydKtaTxoSHVI/xso4TbBu1rMglTrf0eE6fdBOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8150.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qIHJ0KD4HgY0o54WyWfZI4ly80Uz/eKDD4pgnrD/ptjgJEmgeh6X5TgAmb1K?=
 =?us-ascii?Q?QLDrPoAYfN5A0ZuSKa96MzdeCyYE9+7AZZM1Rvdd7wefNgBYxEhi8kHV0hkq?=
 =?us-ascii?Q?BtNt07uT+CpJxckxAIHaKgO8+ln5RSf2L8S6WU00MWCxmha09GRPWGpOAEWK?=
 =?us-ascii?Q?1DAQDfxrWsvhYA9rY2nx2cGN63PnX7QcppBBmkpGtLzsOvbME+47+t/TH4A3?=
 =?us-ascii?Q?ahkN13izBa3trkmDY42CQwPcSgD3D+TLEJUzl/fIOW8DQLMKAwUqY9zoJFOd?=
 =?us-ascii?Q?sc+28PowFSvbBmgdHtPq3eHbp3JGxPnpt9jHC3DCvl5x4lvEJobRD77rnucC?=
 =?us-ascii?Q?E3Y3bcfCG9yaJZ64k3980lN/13mVgN3ejiV6w/FoBiaXBnDc7vpbEB4ev5q+?=
 =?us-ascii?Q?++PLKy38jr59R1ItZj+IFrQDpb5BDDWZTLdJzrppHZLijR2LOpqdXHymuSEm?=
 =?us-ascii?Q?i8bOYBaII3M94ZmsiJAdBkivuxcFiPhas2hVmS2hbp06LjVdj+ZzYqf0T7i/?=
 =?us-ascii?Q?xrFgXOv3GGS1L4xfXnodVkZGTsGaiP7ajjtUS3P8zDgyJYngWm1joo11mafj?=
 =?us-ascii?Q?OdHLeyrczYGNEtWD4k0dxKe2YFhhVIc9AvOIGJ07iDWkf2pcZngGlZkMs0Iw?=
 =?us-ascii?Q?3a2Go9D6Eu5KEWpGjJCi/qcB24c3b3GBnPv04tVsoRevPJrmyIQYeRJtFu42?=
 =?us-ascii?Q?bBva8OY3ScKwAO+5aIiEWK4x6FqBi7xjU11dLvmI5weqzsxewx3issUn2MUL?=
 =?us-ascii?Q?QbY8e0Q0zvev2S5Ug6a9XcDJBXHDBFsUIZGyT2xyu8zRsWXWz4qrHMX3lSut?=
 =?us-ascii?Q?Mzjz8Qok0dNl6LxBxKUlR58kCdKcv+8RGbUDnVh7E8nc48he5g/iAc5hcuKz?=
 =?us-ascii?Q?5G9OhpqAWb0q0bt77n3xfNZFuCBCQkC1isgVLyL34I1Y/3+GTR0nRfKxlquq?=
 =?us-ascii?Q?+PTZswEvQFy4u62SYIaBo7tUqzkIhDGmDRCppHhQlO3r+SqTPxIk5qxht5Su?=
 =?us-ascii?Q?5LOEQu5S2/ajKXmkfb7NP5Ev+lZ0ojL8wbgG5XqkN2lFGPo3IGvkc4ygWROO?=
 =?us-ascii?Q?t5ZrPTkcv0K70zA7v0+AEBZn+spl0GCvmDFpZgn+1f++0Bc5/cJrSymyH2PF?=
 =?us-ascii?Q?njtRKkUt0BNty3DM/pqs+6JKE8x3r3VDPRwAXmWGl2en1L0m5cAy1lafXfrZ?=
 =?us-ascii?Q?7gYIxnNqKtWVVleu4dmvNrp/+Ud2+oMDxE++pNVXciph+IffD9FnMwkq1wQR?=
 =?us-ascii?Q?pCui8WkzetkXDsWZ8YSrzFWS4HqeDYaXp5fCV5euSlU8aQ2FmnmT2FKHoian?=
 =?us-ascii?Q?yY99ybTogFTjBJu9QKNTauxH0htkNnJCgLH4k+h9IXuEcpAJnlI6HuIo0DL/?=
 =?us-ascii?Q?Q8AyhaQUEI0l7zn4QJNeJhdfJSNy/l2bbt0x7RhSra0OAxeHMfv5fYBdFLr3?=
 =?us-ascii?Q?tDRVxtgVQmmcGsHvPNEmbeNW3UtcXmge22id6tZZPpBRFEofUsEDv6p0QBuo?=
 =?us-ascii?Q?R3+G36ytqR3X0UlXJn2ymJNO3WhnGglX2zVW7tfd0N0W3VifvywAGMZUc13V?=
 =?us-ascii?Q?uAzyJCbk39kDBd1Hh3tV0x+HK2V89gZLFnvWkr8ZJu/LstRLzsPHHWhgn/Bk?=
 =?us-ascii?Q?Mcj8PR1wwHT1C1bjkaC31rksCq+SNyOrqiSQOkcQ6FcR?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6067510b-6551-4349-2bed-08dcc6171fb4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8150.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:36:20.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhcuC/bOHtRjJ5Y095oZ8X0exaL4UBhyXX25vyBcPfzuDf5gX5X4malgvfBiX7jH+EBPqMDxH1oXHivUEkspCP9bLxZmOTEXbdAF05SC5KD0TyP/pfFu0oSMvyYCzeh4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8410

Changes in V2:
  - Updated mailing list distribution

Use dso__is_pie() to check whether the DSO file is a Position
Independent Executable (PIE). If PIE, change the MAPPING_TYPE to
MAPPING_TYPE__IDENTITY so a zero map pgoff (text offset) is passed
into the script.


Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 tools/perf/util/map.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index e1d14936a60d..df7c06fc373e 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -171,8 +171,11 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		assert(!dso__kernel(dso));
 		map__init(result, start, start + len, pgoff, dso);
 
+		if (map->pgoff && !no_dso)
+			no_dso = dso__is_pie(dso);	// PIE check
+
 		if (anon || no_dso) {
-			map->mapping_type = MAPPING_TYPE__IDENTITY;
+			map__set_mapping_type(map, MAPPING_TYPE__IDENTITY);
 
 			/*
 			 * Set memory without DSO as loaded. All map__find_*
-- 
2.25.1

