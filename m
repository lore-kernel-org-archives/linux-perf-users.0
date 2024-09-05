Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021130.outbound.protection.outlook.com [52.101.62.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A258624
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495139; cv=fail; b=cnQ89qcuNGQ8ISgoh5CnrjFaadK38AIXtP/4yixChSimwiAidz+KkvyLzWlwyLyNOggbDh2GAydHDU/mbMJxHQDhK0b5LErJNeJFzAu+T19RkcvXq8UImPXjNt3wegYRCBOC0ewBHp9Dxqxa01wId68hPmX+4yLu52XE4MHuDMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495139; c=relaxed/simple;
	bh=BUnhNTJQVQe74axfRWPVRUZ0205LgQFtTVfKZrEnGrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sGhfSla4MeXoQZxnqna/VB9QQXTlCVyRTg4dgASWz7jTdocpmZ9idAUCNE5TBF1gFmB+iafuQOFGOwvjOt9PnHm+CvxYUahAO0fnR4tO/srgBhwNagKqhXG7OXIoVVFzNHE+8HvIj8qYC4ZivSZwW3QawwbU+R6LN0eFsY4AxZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=B9izC5+4; arc=fail smtp.client-ip=52.101.62.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="B9izC5+4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fu2PoUM8fYN2CJehJkJNhG3d6rRlM/eC09DSL5p3kFZWZ+W+ehX2IJ9f4xEtpdNd0BDVZblmtfV64EcfxLRraYCWFuohVtnKe2WJ8vfnaNyGRXpYKobfSbJVnzQN4eONe88sPtC2vXNoM4QWYHKsTpeK9v8f8plWs4XmlTAbrJablkKi3E3Nw9HY4XLBm9q392KUG1hUy1aOXch31166jvLRNBq11CM/p0Xi2+NjYBOfY6JOf0E4+3t0Emtbm6ia9mD/2cejUE/0C1urfH7Vx1+TXqtsA3zul6bk7Pk0s/4PYOCQ3ZGhj5gHmpjfzrqi7ZbOT33Hsjlfmuw4tVBP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d8sKDDfqhX0VFAITI+x4NbusmqUD10ZNAfW0BKTdEY=;
 b=oc33JS0wVFxuhI8KrWmedbbIEBO1bDTIIb4xV/OFAQaOqv7Squ2JX49q7l8oCpq7xxY+56o6ybHh03RDGnUwUYDGJXeTUJsbiT3CXsxTYAiV6xppddyRoy97nQVa1bVXWqoSAr3YrAm2t8j13vjgU21ZaHmgw7y34GPhOtu80kCFhzbaScvHHNrjl4JdufNiFqLS2JC9r5asxs3bAdR38Sl2aSnCnFOdjymhNbdxDV5z+2n9UWTFXImamq/AYixJ9dcBimRmCsxQtpeuIj4UCp44F662XXsQBWYkCGQVS91Tmrbh5sGjfZo9qr6gDaoYnO+iHJcSOYWRSDzb/Jpyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d8sKDDfqhX0VFAITI+x4NbusmqUD10ZNAfW0BKTdEY=;
 b=B9izC5+4jbTwyqpLY5r7aXRlKP943BxAgdmhQ8YSe5hUGJjQZx+JOQu1xCgrghMr5fwDKIGukGGWpWCGguQI3Z+W+7lB1tY7+XfdbNjLKhYLbrDJ3dwIgbILh6xytSiJfAC/NpgjYvEJpcmdy7P4/JSyaoCBZSc32XvQtzOadiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 MW6PR01MB8365.prod.exchangelabs.com (2603:10b6:303:248::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Thu, 5 Sep 2024 00:12:09 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 00:12:09 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V6 3/4] Add map pgoff to python dictionary based on MAPPING_TYPE
Date: Wed,  4 Sep 2024 18:11:30 -0600
Message-Id: <b4223012eeb9d3ac3d64ce91b265cdf77b7489a1.1725493961.git.scclevenger@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3bf00482-5278-49d8-3acf-08dccd3f624f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z79qwMfny+dAkhd3dVEfhJpJrDYcujer2Uih/Yow1YodGOA4KUp2q/wwl02H?=
 =?us-ascii?Q?CRuwhdaG8Q8Eeo8BFrm9UY6d5gWaHjhe8o6yWSqT2piI3HjREf08UMabXfxg?=
 =?us-ascii?Q?KbFO2GFy2nAb0XgWMLyKtTF/SuGdeADkDqsad6r2lzQjYAQDRYsAzlTZ50s3?=
 =?us-ascii?Q?n67ngc2R6806/ZfUXSFD9PaYbq2e28bsxJPBdr9r4wK+OKM+XbZ96P1v20ri?=
 =?us-ascii?Q?Qj5keTapam8e/XrbyKSrByrx70UMa5xgKICIMnziP+J5IoS0gm66uSpZ5+zl?=
 =?us-ascii?Q?lnzhCu1z+4sXRJsFetZ/f0dUhOk1cHvqTbR5+tprRtIuEMZEjRGw6CPc2pXR?=
 =?us-ascii?Q?PioKlaYAnnYXWcgi6rRojejE5WLROYYIxeANCZfOdjCoIyrdOZ4fjh3Mqdz5?=
 =?us-ascii?Q?zySASS1+v5AF/vizY9eARztkHfdlZmPHlYduIXPUOFG2ianBqyFPlfaaUiTH?=
 =?us-ascii?Q?X+5+QREux/VlqJx+b879g2tJv8qzfPu6zV3Y6CukoAB1X2yMWDCzjkf7Wp8E?=
 =?us-ascii?Q?94RkdlUvTiUz5KFRhPskAOn1G8/LdqQjuzUUtr8Wrb68sWj0bOSiwIxiv7mz?=
 =?us-ascii?Q?tyQQ9mhim8OReBy7W9lQQfXhEbGhfCuOCk+qoGI/z3ePC51y/cAmyqtkcV6O?=
 =?us-ascii?Q?F32zOH5k6lbzA3OZIy50AiivTOxzohKBboPSXSiYc9r6qgX7COTw1ZRa72Q1?=
 =?us-ascii?Q?PXFGkRn603q2rsN4HX2At4+aeKLftd+9SNrwtXNq2A1w4GCArHZF/f/Ybcwe?=
 =?us-ascii?Q?MUeUTou5zof8CXXtRiCddtwv/g7Tz+SXwaEVwrpujxzGJIJMORpE8sNfq8CR?=
 =?us-ascii?Q?r0uBjazTxL88IYP/O/nGhUJ08cobpuDlE6XYAskG6jpxrRdyrNGTPlEGa7n4?=
 =?us-ascii?Q?zMxTT1oJ2vVvsYBY8Y9jJT6rj4m7u9m+xcUm8FDpbu+zP1tGfyDBQN7m7zLw?=
 =?us-ascii?Q?PTQJ3LTeRHI08/PjFkEDdLEbK5jJf2TfgN2LFnOlsbO3xKkP1PmTz7urb+3u?=
 =?us-ascii?Q?un5/adMb2SrU2Cz5VM9qLCbfYyppCAXiocNlBwW59PFk6uIVcW6rQPV2Iemz?=
 =?us-ascii?Q?BXNzKhMHuPmjTNDmmHscmPOnY9Rvg5qYosbBqx7jPZLz+GNKveoRPMgl9k7d?=
 =?us-ascii?Q?5QDuL92gSPDWHPEZBdWAwujvqzmyitiYIqXSvCP5U1ejVEJfZEREHWl79LeW?=
 =?us-ascii?Q?BthNfdcwnguUoGXmmmeaMzb2SKPmt2UcRMx/e060DmVUCwYOWBW+JSuaSvEj?=
 =?us-ascii?Q?k8IM7gjvRae96zpzfA6suLRsxh5EmTXgjp6z+qjl6hZvcz1w8QacW8dn4V1o?=
 =?us-ascii?Q?l6d1YiENE9qmlNYgSwelgqRcKMeQtnGs7FfQysqa3xCkbJCMxjC0hbQ4Jo0P?=
 =?us-ascii?Q?eHH7aGtWW6WvSoS2sEdJcvRjKt+VHjXTAPD+6Cm9Q319BhZoxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v9Qf2P+ik1a4OlqonBvBkYEe6r9wiuKr1oXXGR55fYh0mIjb/VHSjqEPfX/z?=
 =?us-ascii?Q?7U45k65/xTqxz9Ljst7p5jvdmgUJUvtnCjptoB0HzVQ9skksYAusPkKL/9po?=
 =?us-ascii?Q?N8J4+hVEQ4DOg0oGPyZRZlOokPcyElmvWuDKgWh2g9kZXyUyaMaVmoTKh7X6?=
 =?us-ascii?Q?NyNOLcFNcmBDHqmsN4qNq71bPjrofHzjCbQtkbR8SqdAeWu7v6wX8Oa9kKya?=
 =?us-ascii?Q?219HWLmWeb3cQhsYve+w2WVq/UDJ9qKPaa+DM5O9IOy8JPLOHbBbXHP9SaML?=
 =?us-ascii?Q?mZRzp+5xktbCrVzzESaYJXX3JuODooSK1yaVvIQeYdmkwB5Rb9W0xxoyN/tt?=
 =?us-ascii?Q?yNXEGFC5r80fvtg94+NIJzKhZQjQh3SjyhODNr8OdnNWxldIlyMn0/x7C2uU?=
 =?us-ascii?Q?/P8m0gpFZisv5/gIxII6F/EcQtDvQMu6VQsSacKavMBAuQr2gBU4+UOedHbz?=
 =?us-ascii?Q?sK/FWrw8cnPYcwDTEblHxgsthh9lDc0u/uaAw4nwzMHu9lxaOHY1OCPAXegS?=
 =?us-ascii?Q?KDp2WRxFbo1y4iM5Y7I/VSbodzVlnMv4uUbhY144WhA7Q91US1OAH2ooXLXa?=
 =?us-ascii?Q?y7vu4Y6w9+7284dfgD3iJpXYasj1e0SyVTXjWWBtTb8m3Mghm8/YVstE1Jc0?=
 =?us-ascii?Q?8+o6gDOjT7UB+M+FFhPj/JWzqOI3yZSoS1MMP4HTfipRbTzGbVLSQNCvIuuw?=
 =?us-ascii?Q?QZkkl4e4D4CYeVgywx/7012JjZwduJ4e36kPnn37dOisdf4XQooxCi9E2plh?=
 =?us-ascii?Q?1srynihN1rE9ZvamP0X3hDCJUF6lTtRv640UG8HhyHbTVz7KkWHwcSdOZ0nz?=
 =?us-ascii?Q?ARRddA2GiGUI8+g8Q0cVSpjA1FYbvp08slZm8nzJK+YQkYe3IHWAbg1/Y2d6?=
 =?us-ascii?Q?Vb4bCu0NaOOVgYNzdjjIfkKBf/bu2bxeY3/y3Pdh/BcsHN/7yKI3PKT2g7wb?=
 =?us-ascii?Q?w0eMWYoNXyDN4sE/cqFIU7OLae/48OhFfajf//4g5C5f7pKrpmn8LuZ+DOsD?=
 =?us-ascii?Q?rNPzM5xIlv80Owux2aFIRKjZXpt3oFb4hnVbwlAA76Wxhtd6EquNHaJctjzj?=
 =?us-ascii?Q?PUbFspoNTiwDHpTm6YY5WM29AlsdQqqOUhR01FqgqioDk3oaPveCgC9xs+/J?=
 =?us-ascii?Q?ald4D4L3XKxehZhiV7z3qrEHbsjYzg456ga++bzTfrfIltpKtpWxuaAYkiuq?=
 =?us-ascii?Q?pxzEXi8L41ich+RB9ODrgLKxTacwSQxvvSMuUL8zjKKM73spjvHLcW66I9Mu?=
 =?us-ascii?Q?Ek/Raj89s3DyX87a9Tgeem5N7oH5peuZVc728Ir+MSIcmErQmnNEfj7difGD?=
 =?us-ascii?Q?c0R99dkcTVifk0HwjN3jt9xoZxuoKXZYSniefyPpyVhXq80zG2tfWYmy4y0W?=
 =?us-ascii?Q?JrSRFeDtLX5CXN7tKf26QXHX+IsefLgvrTR+nqV6f+YpARqa3J3bZDQnSrwM?=
 =?us-ascii?Q?UAYMTNT4HOE4eUAfHfnxYlGRddpU7XxMF+XRCeSWKXueOSmWktt04akofLR0?=
 =?us-ascii?Q?pyYIhBle81rOZBi0YdzoNADnkpQt/DTSWtvf1Nu9RaoRKQjZ+fn991+WjEJ4?=
 =?us-ascii?Q?aF8bS5aLDB9+NvTzkqdIeK9gNL7fxr6AuZAKT0iLl0U4ltAPqS9sG00/GAdp?=
 =?us-ascii?Q?E4jfYt7H/6TEzuTokbjoBX1zdFWn9gPw9/85Ark/t+ht?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf00482-5278-49d8-3acf-08dccd3f624f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 00:12:09.6766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDv1WyuohRlNn8U1qf2Wfvp/dE4P2GnjeY1E4gdwGUNgAm/70PD9XMo+92fTgN+oll6MTxzY04xV7RFsEGVAHGBZue9JZnGdvtrw3oTJfuhnIpMa+EEYgT/f+IKBJSNE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8365

Add map_pgoff parameter to python dictionary so it can be seen by the
python script, arm-cs-trace-disasm.py. map_pgoff is forced to zero in
the dictionary if file type is MAPPING_TYPE__IDENTITY. Otherwise, the
map_pgoff value is directly added to the dictionary.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
---
 .../util/scripting-engines/trace-event-python.c     | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 6971dd6c231f..7b96504d5406 100644
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
+				PyLong_FromUnsignedLongLong(al->map->pgoff));
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
+				"addr_symbol", "addr_symoff", "addr_map_pgoff");
 	}
 
 	if (sample->flags)
-- 
2.44.0

