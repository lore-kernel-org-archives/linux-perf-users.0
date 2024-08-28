Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020104.outbound.protection.outlook.com [52.101.85.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B73D0A9
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809840; cv=fail; b=gM6onvZzK2M1J7T3C8RgGHZqWN/OHlgfH9ewwWKZAo/vEuZK+4KxDATkNt6RXBhjrZGTKW+oCyCpqY97Ywo38tDKGLdTd7HcPqd3gV5ZwgqAxzmgF4wOSavjSMXMmY18ZZ8osQowTXJ/XC5mwSEHutVmD4KLUwHt/uoNk0/Fh5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809840; c=relaxed/simple;
	bh=288RDyyvD7HlX2onrVrALePdzgoYeqahlPc25CZ8Xlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLtu6+DGM9Blrhgr9fsk7DokUvTHdM5cu4Lo9z5he3wZ3pkpctmzf+6Dxi/Fv1z0UVWUu5/VnUzxlgVlvdRm8yTN101Gyad96k9Bqflkuits7953nxp3bPWgyaNN/dGytfqQeSeB4yats2x+/VMe6jXnTW5rymJHnqcgfBG0tL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Wpr3yOgr; arc=fail smtp.client-ip=52.101.85.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Wpr3yOgr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyr7gUO5uIeJsks1+jnvnDsTclxHwtld3VDXaXnDmBsvGNysesdJGL/N9eOj15ToidI42O17jYabYRYnlSdDh6L1MzHb8rz5X83+8TevIGVXIECK58TdayB5YOzuprglUpC8WYcd0qg+v2xV2mKfxzVpIyJl8qCfn8ypi+Qw7FMjsSZnEfyNZTHbm7PpazpooqntTJm1Gx77qWaap/yFSMg8IGEEXTCK/Novto0mYhes4fZkMpROo8glEOJnlR13TKbDEu2acnrEcs+UIRdlWBmdGO0SehtQK0uMEr0K/CQ7uX8TKQULKQQN3hGxqF8INbFQPnQEPvR7c9LyZL14ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkwZ+2zdwZ2vNhcwe9ZZTBO7ZbaQ5vYDrtH5ERwTq94=;
 b=ldZxuNUMuRGsJdSSzl0seRZLJ5FWags8YsfLfzHv/S3n5LIqyEMeOSdjfkfAvVB+/LcP0ubONvM6d/Jy0b7MsNaRoYkdBEoOirfglFC06bf11i+B96Wc1fIdfPh1S+1sqoNeeu/AMN97O07f0dzlFfTvUcRpmjyX3KOo9V6FjkkkBbHfaNe+yfK9cHmXJHO0A8eUHxd9p8CJscMeDN5ObgN/zTqDKvx2cwmlp0lmYZKnliIcm+nDAA2Eg3NNJILOE+dV1ONQM/hWYsR2YnnT5OHhJ0mD/cbkGIwF7FqigcWT8yhyFtQbNATFmfZ6YwCB48/Mhj4wtVf9ggf7B9PBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkwZ+2zdwZ2vNhcwe9ZZTBO7ZbaQ5vYDrtH5ERwTq94=;
 b=Wpr3yOgrDAqIlfdzsJqxUl7gHa/qKKziNFq5ACDlbmNti/C2Kx4gowoxxCWqVcKaflIf93sbTuvyQbC0nrdNtniPM1kBaEs48e955znIp3ze8gTE7LoOUGgzQadVSnhJfONjSx5rJoE5WKm6lzhMERUXh4mWAcF+QOgZvj7w7Ww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 LV2PR01MB7576.prod.exchangelabs.com (2603:10b6:408:17c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Wed, 28 Aug 2024 01:50:35 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 01:50:35 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V3 3/4] Add map pgoff to python dictionary based on MAPPING_TYPE
Date: Tue, 27 Aug 2024 19:50:14 -0600
Message-Id: <afca22382f5ee58c8ec5aabe18b8fc680af0fbdc.1724808513.git.scclevenger@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: f2f588c1-cd5c-452e-d542-08dcc703ceef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qkUuxJZxHXgYMm241vLqILXai7tAPBuwhwewHNmhC55nZHZ7iH6MoAnQPkO4?=
 =?us-ascii?Q?5rX4TrwXo/UkBl3DlFqgRNyw4bmS1S9/NNEl4bL8TH9l96+drg4UnyRCmAEx?=
 =?us-ascii?Q?5+2K63Dc80j7zS8R4BT39SuBzq/+NoPylEOV8pEN8DiD4hz50tM6cmR1I9yq?=
 =?us-ascii?Q?9yVm0LArmg4RJv2KSmbKPA2HffaL2z5eZL+bUW8kalY898XwSRoFj1kk+orQ?=
 =?us-ascii?Q?I0+IU35mt8YzuxYF8TVs5/EgVTb2nXxTuDrHt8S1BubPYso2Rs2NeMREBcAx?=
 =?us-ascii?Q?CRgSnY3aFTRjHyAfT/BpjOMeEe08mdzCIU0rg+Nt/M9dFl+ViPrx4bq9Eiqv?=
 =?us-ascii?Q?0r48pkfDPNlLt7LFfwECEuichd5iOhqJVzn8bVqBdRAcIJ8BwJc08ta8SLuT?=
 =?us-ascii?Q?iXpAWWBXQyRXbPoGk1oRCBmCXxvcEe/W56NJRXveejQ/7MI5pBQuHCQRAeQI?=
 =?us-ascii?Q?HaqbHDABGeRJ2cGT4RCvERahQMiqHMDvCRzchvC5OX6pAsrsJSnqUHZx1jkW?=
 =?us-ascii?Q?G9ithmFWRGWY3rRZyuqBjTno9R1kNEnv5Rto3X/w20E9RsCWgBYLU62aB2hQ?=
 =?us-ascii?Q?Gky3qwFau0hopJf9ehJoPgrtoAhiAGqysh2WFhaHVQ80kzeG8gVH/w1UlyKj?=
 =?us-ascii?Q?gcSFb0FVNyXNRy1yzdFH5nBaQ9Pz81/5aJPdsobh3pVZQtB+2OdopvY15TGv?=
 =?us-ascii?Q?CbJsMX7zdY6vB+/CQxdzCmisSNwI6l3/3ku3indJdpQyRzW8c+x4evEdxWTY?=
 =?us-ascii?Q?rTeFj3JxDNfVsdlw6gyUBYG2JaKmeWPGJZypwMqcNwt5uaIyAMDv9D4HEUpl?=
 =?us-ascii?Q?OekR6NB6hrcKPjTwLW5pLP9kA2nHf+3KsfAwiCtGwQ+NCtMapkmJ0wTG53mn?=
 =?us-ascii?Q?JB6aFQuqHt9lsJW3ycsWL7JLYv5akKxv7EDzxbGl/lFGrlR3irjl5Vigz52O?=
 =?us-ascii?Q?PUUroq768DGd0+MrLLgktHeqdOxWzhLJit7r4QhJ9P8eiyEd1fEWpbkSNOFQ?=
 =?us-ascii?Q?r1QwXeducip2rtgXlXTKqeFkFvg1FAYIWwAlpEdAc53qUXWpP7pEYx1D1Dvi?=
 =?us-ascii?Q?irMDM0B4Z6PPF+nJ/OMpi95lSdb3iULct0U96KaB0kqJFFK08QYpMtXUfpeL?=
 =?us-ascii?Q?wOdDtXwHaLy4BXaqjKXyskDssQZpa/rTolr6aGWXO/gngcjcFmwtyE4r0XlA?=
 =?us-ascii?Q?HUhO2lprqqQjRb1aDltnYUBpvfj6fMUr3g4BAT51dlyjI1n0o+QWZTzvoef9?=
 =?us-ascii?Q?QtHBfw09oRm0Um/qv+zZw0nzG41mfhGbll3k5YvkZPbTIUuvKe/ev2sreT4M?=
 =?us-ascii?Q?ulry+CpEm7qFMWmgXjtGbDzB0e/mpKjWXbDrub9goutvnrtdyVwBkEfPYwwl?=
 =?us-ascii?Q?1vj/F4vLtYaD2dNqu6tCjhj085b2dBCOw6yO3vvNECtgDHHL5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SRN3PpZDGlAHzRUwGWA49S7DRIn1bX80vu+r2FxgshcdTr+Wpaa+EFKI17Ab?=
 =?us-ascii?Q?mN19N/D1o+6C+BjqQO96bApL6Y4RrHvEnaqnZtgv9wEJ/txuWgMQDHGlz10M?=
 =?us-ascii?Q?+0b0vX5mCHcW5R87Knm8Z2aNEz8T+E9o+SpRgmyh9f8G1roVS4vMT4Zd1Xl+?=
 =?us-ascii?Q?/90n2aV9+eBr/XBSpQCJdaGSVpN+YnyQ/98NFxfEmpHjbpB0Gw1ksVWOS8/B?=
 =?us-ascii?Q?IIV10NSRv8u1xDcYpUxbrQGIjir2J3M1tSDWw2UTxYDKIr//9DWqEEEOeJKC?=
 =?us-ascii?Q?hGDLkTuwWfT/imuK1fdSyJAFkIkoBsvIZqLWZJ8OjRH3UnXCwzh53l4JD6/4?=
 =?us-ascii?Q?09klcgPdFhntQx2hYOFheyBA+nSkcwLzRlG8Yh6LS3LqqyvbLrsxvITLBD1S?=
 =?us-ascii?Q?LjIW6A8019lA5rPqCd9ZQFngPub3XBeqOAn5bWnrMpuhHNmLqAcYrQ6Y/i1W?=
 =?us-ascii?Q?gubNBiJCTRS9A2pVCrS87V/h620XNL5P2gDyl+x6slLPaZAODnuFaDfj0pqV?=
 =?us-ascii?Q?TykuyAd5CFp1qbaGHqHT6COsvUKGP7nXFzFPJjiv+hUbTL0jXNqdeS0eOLJC?=
 =?us-ascii?Q?SGiKtGTpGJZOHVis3iTw4rAqsE39xuwwS8eNl8lUyNrVDXYBEt9wW8Gqz84q?=
 =?us-ascii?Q?Bt8xgTFmUfiX6fYFVdj1HTv+oS8EsiO7y97bnObhBkpYb3han7OvBz6DnAWd?=
 =?us-ascii?Q?ZVdKUpLY/+7VzCJRxsPG+gGayPQA3V20xbIgiBkB0WT8YFZcqo93k+vu/7iT?=
 =?us-ascii?Q?CNaz75s3gRYgkohmn6H7iBug8xhyZKSme7smjUe6mLyTX3KtX9fRLBDX5p+y?=
 =?us-ascii?Q?7y3RQzRXHXnUA9Xynyue8BvVvAiRDsX5KGvP2xj/JZ9LTj7yEVb+2vMUV4uN?=
 =?us-ascii?Q?BcEJTkSTPqNAd+9bKb4kXG8cRRGBp3Q0GCX0X2HY5dPBopjJdy3wHtbxtXqo?=
 =?us-ascii?Q?F2ahei8cLIgcq+Q2+T9A1cC/PsEOa2RVzUS3SAKGwbavJKtKx1Qr8+aPxCA7?=
 =?us-ascii?Q?ONRh1kgQIXBQcU5xc0QQ967r0pbcrGiO2l/riPJNhsgWb4UkZSOf0HE8pW0k?=
 =?us-ascii?Q?DFDLhzlUiYsJeb6W8jQYmrCnT9vF7n4WkPj1z+BXu6W41OvKmRj8aBkJpSe2?=
 =?us-ascii?Q?Htp1nDPCyy+muyMl6fl0eBp92HVe394gUDYdMUxLdgCFKcuFCS7e9vQzKn0w?=
 =?us-ascii?Q?NFhhJKi4jMM59hqW+ffLwhiisicgcNB654J7gsI7tFC3QHrQN/x9w6A9V3H+?=
 =?us-ascii?Q?QL96CZ0UsyrrsuAagSh0by2tPdC01l5OjHsNobILrhVX7MuIoxbvhAHCpYSv?=
 =?us-ascii?Q?tsrYvesAaMrOtkzoDIN3Rr7+IzqiTvS3dht/Nqp7wSoX1C0rMw+96fnYvA+l?=
 =?us-ascii?Q?loI9M7EW/umXitdgaZos33h0rIY/i9pL5rpxl+rTFtv/Mkz7otrGGBb4c7M/?=
 =?us-ascii?Q?P9v6VNnvMnw6hOYOYuMHN3fPAi8ZmCuh4PvmQDQ7txcUuAKEo4cMwycmLv2D?=
 =?us-ascii?Q?nNcLgyK9k6nH2awj0ww/LQnx0WR05TYOBYtXYiPLMWUBWMf3Q3FxWqUJjfK6?=
 =?us-ascii?Q?s4KRciCEQvqktnhD+HaSoLk76uSI0GhVVvZnrTibsv2uLhPG5x0sTCIitRJI?=
 =?us-ascii?Q?2x70MA72yJYXZ3VbibhdhzTfC/eefmqXwca0nisbzEzl?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f588c1-cd5c-452e-d542-08dcc703ceef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 01:50:35.1505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHz8PO2G5lSTgorlvesG81bj69x5eJkDOAlGcx8DO6GOVfs0IPYMfBWgY+9QZOaLjB3GaFHRwl4PSVL7gKT4MlWFtEh7l8I3hMLpI0hajiXzIsMiG0sbdFhXluuMIFCp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7576

Add map_pgoff parameter to python dictionary so it can be seen by the
python script, arm-cs-trace-disasm.py. map_pgoff is forced to zero in
the dictionary if file type is MAPPING_TYPE__IDENTITY. Otherwise, the
map_pgoff value is directly added to the dictionary.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 .../util/scripting-engines/trace-event-python.c     | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 6971dd6c231f..74b66692e3a3 100644
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
@@ -900,8 +907,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	pydict_set_item_string_decref(dict, "comm",
 			_PyUnicode_FromString(thread__comm_str(al->thread)));
 	set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
-			"symbol", "symoff");
-
+			"symbol", "symoff", "map_pgoff");
+	
 	pydict_set_item_string_decref(dict, "callchain", callchain);
 
 	brstack = python_process_brstack(sample, al->thread);
-- 
2.25.1

