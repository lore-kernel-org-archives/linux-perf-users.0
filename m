Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022092.outbound.protection.outlook.com [52.101.43.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374BE143890
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 05:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724821801; cv=fail; b=oHSng5bjyWdhBUX0JmoXF+RPwDwBRGoaPUGFe+jlxMljgEzbyBC2VtQS4bR5aXOY2BziqgsZBK6tbIK3sSgXq9fVx8QAH6ju3NlwIWQOUtzzIAky0OzA3z+rL7fV+fOVaaf1T+URo6XAxXgDmc189Ockh9fWZBFISX6MzEQF/6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724821801; c=relaxed/simple;
	bh=oIzJUojtPmoGwqQhr3ycm2VK2jibXVTpusIeCST30UI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ilu9rZ3uwHLR741Hp87ROa00sOzIehob37ipZcMaP2YorLmtuHlT4UWwTQ8xjrLlfR2EwI3ur0DhdTV/7bV5AFORE7zRArxkajbTvy2wkKzVVcmtP7DVnwXYUXDOAIQN9RUfnRmxfOiRxIOBqBYAA4LxV7R53l6a/w/vkiRzHVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=e/Sfl0lq; arc=fail smtp.client-ip=52.101.43.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="e/Sfl0lq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzG/cv4eBPhs78+BtDV8d+HCTLsEg78t3pblXK7esBVJ8BwYJrfqaF75UA56J7J1mjubYyyT08jR3U3BeW7Y6O7bup1gTodajqnXCiLp54Iyie74BUanv7Q7DUNCDvYEcNrjfA06DzJbyocv09a7nqu1Bg9mNJI6aPagaKn0kmBsGPEGRRnh9Ec4TZblXMFeMr0KB9stZVcUG850KQMs6dGdjmWCKzxnL1tbpn7dQbeqiuHnXTYfSn/CNb5AGHxCb5F1Bj+qe60jNroZgjyw5JMQC90pPmhtcsubErPfVouBI7OMhEasB1ekDJo2DDUsk14nSw3v7Wzex15WfTwRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR+xHC831DHYMPvwVJxoQiDEooIEo7RZSXIjUnWt1ro=;
 b=u+R3CO+x1EcMQlcDke6SZUdTw1TdohwNzxQSc8H6JIQocQjgntjGrLsv3fV2ekYB5tQExDh1qwaGDkCfXalkEKnSd/ra2Mn4/d4CZSkf93STOZPEU59mGOh54/OL5Hb4TD/cvb9f+DWGtef9zUmWws1RV0HIVrfduCQ2xRE+SE999uWitiUmcI4XKm1QzQHPZBO6qPyy5V3HBCF2yqBIfbiWNF8E+4DR7rXNDDQD2pmHttLXp/lZZZ7lIFfZ9HwuM4SkI3CKq+V/OWxMSwixLMmDH1Tnlq3EIM3c7u8Q2vGTlLBb56Bf5a84fZyZYePOOWMr2QSAGMrIwWzdknORUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR+xHC831DHYMPvwVJxoQiDEooIEo7RZSXIjUnWt1ro=;
 b=e/Sfl0lq8f6wG4cZtLi9naVaZPfwh6XDXQ97qlUBrAI4ISLE7gztP2I3SQrAACR3iGB2Ba0eYRUd35/uowxTbf/1DG0qQJAoLalZ8Bpsan2alS1bAGTRykvj6r+d8VMaKgervN797Twve6tTuNzByURrCcjlRdaneYKP1N20nbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SA0PR01MB6506.prod.exchangelabs.com (2603:10b6:806:eb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 05:09:57 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 05:09:57 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V4 3/4] Add map pgoff to python dictionary based on MAPPING_TYPE
Date: Tue, 27 Aug 2024 23:09:37 -0600
Message-Id: <04a8a735c1a3794c64f1687fc8963d5713807b95.1724820993.git.scclevenger@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 020743a8-cd75-46cf-010d-08dcc71fa91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5iEGnMilkiaPeNP2KcHs6pWEidx6W6y2XIf6CPe4sIYox8xz/PNIq0yw4HM0?=
 =?us-ascii?Q?ZdawHzmDA6A3ngZEiZX0t6XaEvU8Up4H/pQwniHeOu7xGAxrZtTdz9fHXsf3?=
 =?us-ascii?Q?ht2UhoaHep8F6DwKSyH3rHaNGZLhjgOiVjt+HoaLXutK/c4W+EbOQnd3u9rm?=
 =?us-ascii?Q?HCpkECHsa2iglUcosMPzMt3DQqdvR7uZans2QpXWDECHVFtA+7T3MilhqN93?=
 =?us-ascii?Q?PuqJTR6tgnoyvtdwjqiEYQ8Emq54OihrmtySmOvS6aa1Efe870b+UzP9eb6x?=
 =?us-ascii?Q?2OdOnKyu62bdmD4B930hx6vu2SP+VdniBqtWhEj0rDarywCo3rRTFQJbXvYa?=
 =?us-ascii?Q?KxopNTF9XZP+hTeqgtOJ+WSqy9EaPMzmA/V2CImyZZ3kZxapDjZUVPeJG0md?=
 =?us-ascii?Q?79RYWprCMD0BC7FOCQO7/UOtUkQ65tt/D7P+Q/xAilY70/CxNkc1mXpMami+?=
 =?us-ascii?Q?360tZhQMBAobI3oLJrUbPEgxtdSCOY5GCy3eAd17o9y1h1eQHwMwYeJIjIDF?=
 =?us-ascii?Q?8SIdj/Xx6aZP6EuG0Da/mLUHMZuBOKCHeULbuVJo6M9P1YhpoFWB7bndCK7S?=
 =?us-ascii?Q?m1PvsptDrqkn+atBHg9v+5h17bABp+e0+cL7TTkgnRUkUiV2zmtf5nZ5hQNc?=
 =?us-ascii?Q?6u4SXIH87bPgfWXEMV4wqj9+jnPKO2FdBlPZv7Wb78WKlKbzwi0qFzol/3D4?=
 =?us-ascii?Q?G61ZxxNO/C+aISGyEtpknVhMgCG6OykOAh7idt1kHEoyzAazblhdGpD/2z0A?=
 =?us-ascii?Q?yv9CFqPmhMTbAPyZboHpJk+yspz5U6N+2jraiey4oxp7ISJzHGJpm6faglr0?=
 =?us-ascii?Q?Oy/ICgYwJbILgUNuFxelod0Be8I67tFCdgd7J19kx+v7jq1o/H0qFREeUVfz?=
 =?us-ascii?Q?WwPiz3cRajwoI0KMRXboLTsMnCA5E5r56BIRRoUqMVw4gQRuEfMrWPtRXNid?=
 =?us-ascii?Q?a64T2jMLqiXhjMMXUfwp2Wf6iYeFC7n5XTtMLtsdMkO7Hhove6JltIMNcYZ7?=
 =?us-ascii?Q?8vSKLPaVOAQcBICI9YU3+x3SrNMTLuxr+dHf0bnNyU7RIan631q8BdGpcCMi?=
 =?us-ascii?Q?nDQTKNGX4p0iESHhQtnrl1xcVnpiObTDgFYuJHkWcI3d3g1VLGpx8kn2SR+j?=
 =?us-ascii?Q?e6HuDJaEk9almDerPt3R+5EeS89WiMnAHywrE5VN79vTxaBkp8wKKjpEhNjC?=
 =?us-ascii?Q?EHTboiSpUjrJp+4PqrrPBzLIUk538PlzsKyn9vO7vW7ZHRoKMkr4dmQ50ML9?=
 =?us-ascii?Q?T/AHdmqiudBtiaA/WwP1lrKODuDMxKzfo0JrgYaPFuJmFAKXwgrHwBlGoK5A?=
 =?us-ascii?Q?UT3BiSPlLwBcqdGUNZm2FY0Qm9TAp2unp25ID+Of58KPj7reOR77YkRyA7Ec?=
 =?us-ascii?Q?241o+F8hW6LzV5svbN6GXz9zELj9B8uSwKsIYbHAHQqU23X2ww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BgdUAO+3ssM2daub4j8WqN9fUCDn6UusVfshqVkQSYNQOVBxm2jsCjtl6d/+?=
 =?us-ascii?Q?qCUj7yA24ceh4G9YCPDmzmu0X8XMeeXyOGA+2j8pT9o2tGDjmBBDoW5HPeRf?=
 =?us-ascii?Q?mixu1FJ9agQ1sBsVnUrEzhwwJfUtxLuvPO9RhyolBGMk98wZsaf5XbFmZL98?=
 =?us-ascii?Q?LrdqlsD89/HIVzMXriJa/CfDopZ+ZCnOSDxFImqDCfCzfLzzEl9yAdqX35r7?=
 =?us-ascii?Q?z1Wh4V+z5AFgjLzsOmVOlhbRoVoBt5dQFhJ3Zl90Wc6DH627L0V+cf6U8sQy?=
 =?us-ascii?Q?0AufX+VpIuj6xi1zJFX46yl0QEawE5/DSWHG831SYaGT6KlesuBlJbAYIHnp?=
 =?us-ascii?Q?7dBBTmGrHBKnAoTzQqKyBuIxe8zwQBgZ7hLg+JxOCA9u/hJ741HzYUj0NkyL?=
 =?us-ascii?Q?Shy0+BnlbLCMqvxQ5fyBC42zY+GHRWWJ3lmZH9CkQhjFI7N88feDWBUUuIyM?=
 =?us-ascii?Q?+e5v+TUHIhelOyPLR16nj8CXIbPgjuHeyV/dFByKurk2d2ytS35SdiPjciix?=
 =?us-ascii?Q?CNH3U+HeEx955H/xkLoRupp0DQ3fPVv5V81TEEZRBIbEOPzMio88nWrAXtlh?=
 =?us-ascii?Q?Dnq0pcN7wXn5YvUZ5q4Ihk2kC4hzVEdHi2dmcB+H3OPUZOnyovf8m7+EBbMm?=
 =?us-ascii?Q?yIH/1qyywXPNA15SvDj6V7ElfVE9OnF+LMtvX73JEFl3qCZxYS4lT1b6NJ8Q?=
 =?us-ascii?Q?FJsgtqEXTfuG/TL5ZleSzMY3Gov6Adi0dZoldpg17zZEbSq4nzMlD5u05Odk?=
 =?us-ascii?Q?4BPJ9nuO0qudre39xxPfQsG+8Id+QvMHyhUjNqP3ntHhUb/i39Q2S2h3vpwN?=
 =?us-ascii?Q?lxYKyaj4qcp5z7/ZozHD5XgoXvmPf3c/PfeTIZPcuKXmM8cDYASyLe9cesHH?=
 =?us-ascii?Q?y1IXbDPNoVhkC3TDNSqI0FuEjB9Xu1LFDLfNfKg/6CovBR9xj/jf71zO9FEV?=
 =?us-ascii?Q?nH5q8kwMs93hXs+FdaNLP0hIyKBjFRW09bkaosYaddjVjALwvrs0CobuzxsG?=
 =?us-ascii?Q?UIvJBhxg6IZduZIZqpzlQ+mWv2904rmp25c7Vh6r9VaB7MCu6nJxSsDPV4y5?=
 =?us-ascii?Q?BE+0L04m+YiyI3PjG6+9xnoERN/ZReIZd8Nd5F1DkyeLAc2m3dqUIg6Olb8K?=
 =?us-ascii?Q?7mJ3G7UD3dD7eXNDWrGeGQMWZz1YqkQsIYAXimr4bL4bP/BDyG7QDNK34kW1?=
 =?us-ascii?Q?qD6AbFcQFq7H7aeEnv/jh3qqBy0LSWSKE4IvIJz1nD88lzAjPqiVnM95rvQZ?=
 =?us-ascii?Q?RIxwc9buPR2z3c0aGrIMki9v4g5PEnOA5zPJ43UwRndU/HCIk1lnp+gs3O+i?=
 =?us-ascii?Q?jsiC6Gsqea7WCdOqU96/SXrUreT6onHQehpHEQ6PfuKgYjJSMTZD2L2jXG0Q?=
 =?us-ascii?Q?WUJ/iS7PIZ4H5V/yjFnLOOLTXR2E7XBxHwPqAT3iFJg9/MBNgmCOl5Larg0T?=
 =?us-ascii?Q?7elMzbLOoNKIndKn8lhNU3Mf+7of7q3le1R3TGxKSWRa8QqDl9d14j/APGbj?=
 =?us-ascii?Q?9lmMINOxqT3PSqUDLJ4lmeGgc8tjf/Ufvr7yOx/NaNKiKX7nejpfUBN10evD?=
 =?us-ascii?Q?oYn6aTiOuBKN81l1JtJtEG1dCR+lbKEn/hbdXu0YAaJp5YZs5qrmt4aAByJO?=
 =?us-ascii?Q?kQSporAOdoqNjo3Gg0l9xFpB55NdhV9DVzt/cbRTy0j7?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020743a8-cd75-46cf-010d-08dcc71fa91f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 05:09:57.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CS4dwfWA1ErRhEeJuLIKfjkozYCVYlfmPEvKXJW/V/s4saSqkWKI2aCG6QB0stzveLY+CUhKSfVfZvT4h2JG9BrFpPLgsYsBzAQedL/u2nn5qYRXOeTA/oFMh6JsGoTM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6506

Add map_pgoff parameter to python dictionary so it can be seen by the
python script, arm-cs-trace-disasm.py. map_pgoff is forced to zero in
the dictionary if file type is MAPPING_TYPE__IDENTITY. Otherwise, the
map_pgoff value is directly added to the dictionary.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 .../util/scripting-engines/trace-event-python.c     | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 6971dd6c231f..b8da0ea5e55c 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -798,7 +798,8 @@ static int set_regs_in_dict(PyObject *dict,
 static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 			    const char *dso_field, const char *dso_bid_field,
 			    const char *dso_map_start, const char *dso_map_end,
-			    const char *sym_field, const char *symoff_field)
+			    const char *sym_field, const char *symoff_field,
+			    const char *map_pgoff)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 
@@ -814,6 +815,12 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 			PyLong_FromUnsignedLong(map__start(al->map)));
 		pydict_set_item_string_decref(dict, dso_map_end,
 			PyLong_FromUnsignedLong(map__end(al->map)));
+		if (al->map->mapping_type == MAPPING_TYPE__DSO)
+			pydict_set_item_string_decref(dict, map_pgoff,
+					PyLong_FromUnsignedLongLong(al->map->pgoff));
+		else
+			pydict_set_item_string_decref(dict, map_pgoff,
+				PyLong_FromUnsignedLongLong(0));
 	}
 	if (al->sym) {
 		pydict_set_item_string_decref(dict, sym_field,
@@ -900,7 +907,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	pydict_set_item_string_decref(dict, "comm",
 			_PyUnicode_FromString(thread__comm_str(al->thread)));
 	set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
-			"symbol", "symoff");
+			"symbol", "symoff", "map_pgoff");
 
 	pydict_set_item_string_decref(dict, "callchain", callchain);
 
@@ -925,7 +932,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyBool_FromLong(1));
 		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
 				"addr_dso_map_start", "addr_dso_map_end",
-				"addr_symbol", "addr_symoff");
+				"addr_symbol", "addr_symoff", "map_pgoff");
 	}
 
 	if (sample->flags)
-- 
2.25.1

