Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020095.outbound.protection.outlook.com [40.93.198.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C1165F0E
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575329; cv=fail; b=tG12Yh4YtKuQl5OlgOdUQf17wGI+D0lldO4XwiguPLLyJrZkMHSxVZfGVwnmRxLoKDozZWPZP7RB8lRItd67sM+LO/Ma+nPKOHsmVXgJV+OfOktk7XNQ2iq6eWHY+CvemEDN8xmqwKq3TcDbuNUTu3W1jKYhPF73CHd1lj2Bef4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575329; c=relaxed/simple;
	bh=BUnhNTJQVQe74axfRWPVRUZ0205LgQFtTVfKZrEnGrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pLB+76Hbra1lr7Lk6J9rR5MhGjiTw0+szwUROkj6gyuaNQ3Vd0OGwn8Q37JuF0pg2FMUkvgE3IFHdTKumq4VbkeoZa2BNHE6/Z0UTajQfb5f161MWN8PImf5kjFRpkpHbmZkWcsqzT9KFBymdd5Jkfi8E/R3UnM44IF4iDNWRLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=h/RE4pnG; arc=fail smtp.client-ip=40.93.198.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="h/RE4pnG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LG7sbvIzTIr1BOq3g3zXH65A7533A3hTEubbtjsFOSKINFWydW233W+A1N21CHmKpe30F6QG2sJUNAuXRkHRLlO6bHcgRwmMU10QA2ppPZWo2i49m5awiHd8i1mlcMZsFQtdiHVyFJM8TgtmDdvddJnpInNrqvj7ZvT5ayQuysEdIYe+Abyy4FBayF2/s7/O7OryUa0kcecrpmOTnN9Hkou4vyvflsrc036bgxH4l+jFSYp2Miemc31XEbUaGCfaj2YRrUN+utIbmvZlOHYxyEoK1VcMrOGZ5o8k841bN6vk9CzBkJzXvdCZcVdDn7zDxYs1gPKGOmVU947is5ntiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d8sKDDfqhX0VFAITI+x4NbusmqUD10ZNAfW0BKTdEY=;
 b=ayBk0mmQ4WP1fjtmYW86xi4yX320CzNN4tzAZYTJSbDa94si0AwryKnNjVwGeIeg/6QSexF4aKdoipYmfBKmtLbuBdy+2vINbx5XsQwoflu7eZs9fHkb9aN3RLNRJW1JGCg4ZrsUzrVKu4cxL+AmFxlZtM8DoU5jiQKVN3T+J1FK7/XbEwnEWsjsrjiwWlINCzFwqHYOBR1pcLPEFfDCkIKYIiYsjKNqBpACqEia5T/I/MDFLcu9UhxqtPSBqB5Xb5iKWe+ow812/a0X/H5LeLVwvcGP2g8QKA+qdsVWq/QXs8luII3WgF3gg/jPeMcWvvPr7s9UPRg1Efeqx0IpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d8sKDDfqhX0VFAITI+x4NbusmqUD10ZNAfW0BKTdEY=;
 b=h/RE4pnGt6VSyeK7urkPfe7b2eUriA60LHtFCPAouWNom3fHRT0ysqqgwAUrLdNjiWgGKWy1cR54xNrDr39Zkl3QNbEb1XFL7TsORrxAZbKOMc7WwMZNN4PFRbj/wufo8sS162DpDVLTteiN10HFzDpZBeouia4Z7GWeDOHGlz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 PH0PR01MB6501.prod.exchangelabs.com (2603:10b6:510:15::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Thu, 5 Sep 2024 22:28:44 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 22:28:44 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V7 3/4] Add map pgoff to python dictionary based on MAPPING_TYPE
Date: Thu,  5 Sep 2024 16:28:26 -0600
Message-Id: <e0300a677bc54d976bf627b2349aa8824e872928.1725573309.git.scclevenger@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85eb8080-3692-48df-c120-08dccdfa19e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cz3XV9IzWnfxxEstKqCwfgj+75MToBdLfYv/o1CzG4RGufxSHb5ZC9gaPIWk?=
 =?us-ascii?Q?uYpzDPv6t0PiO1cSRR8Q5pRl9NOR1+uYNCQ8sa8X9JCsVF7c14gjppLjmUJZ?=
 =?us-ascii?Q?0Qn32WJxdC1ouFHw0xyNJ9oPzrdsrtwPs6t2KL9LvYZg4QXPSrq+mNXM+OEu?=
 =?us-ascii?Q?A2mKP1W4Pa7Ul/NM/ETpzBjN5+dlNBe+bhtOuEQhWqkw+wnZu8YgHTRI3VWc?=
 =?us-ascii?Q?Tj9SHeipgdR4LZ2/qDQNhYRUOEU6Y9si0oloyxmJrjtMTxUayopcFtvbjtY+?=
 =?us-ascii?Q?tpC46jw2nKAi04jjf+htQ0+nqTGLmaNDblaY/HKCFKkufw6eyHxlN9IPltGE?=
 =?us-ascii?Q?e/MaqI9L/NVcyha2XozttykEgKFnMITHgM4rDkEYqmJxBsW5SLZYRkzh3omv?=
 =?us-ascii?Q?8K5tV5eKiQojsbCiH8prP2hTKTyv2q1l3tMw+4Bd0Use2ernPq6mnHeW/STH?=
 =?us-ascii?Q?hG5FY/SOBQe0VVA5EMMESGSLKzTOVcaVPTJFEVbIaDIPaLIsbywOeAMWy1Zo?=
 =?us-ascii?Q?Gw/5mMkTnDSwrnKxrc8xSsvhUDrSMK6auP3w9rzVo8bnaiF68Pebh2k+rrdj?=
 =?us-ascii?Q?2oJ89YneZLf854PMLqooNVXjtM3xxAafweAKhoiKep7W5fZQFUpjvaLOx83z?=
 =?us-ascii?Q?cxONgu6rXO6ifXh0Irzfc4mMf2xIB2gzkk7HJDWl7HjLrTQ7HtA9cqq7zXiG?=
 =?us-ascii?Q?FubQM8eMQK8pkNFUqw9n3rUpkokYu9gcye4T84j7Y3fXuOUKXIy/hDx/aEWH?=
 =?us-ascii?Q?GBg3ulBu5Sgpdu3yj0yWS7TOKN0wAfC1wubWZvZinD+BDqayHwJ2n95o/40V?=
 =?us-ascii?Q?yUfHz6/qXNv2AZRnoLoB/yiW97MgCJ4vdCaAMK1n19XL0kk9GJRf/D8DD1lA?=
 =?us-ascii?Q?CMxjzmxYvUMlHrpNFYeJagM2hS6XnF2q/dSUqzKkn1nic6B6Kg6dpCA6uxBv?=
 =?us-ascii?Q?pOczsIQ2Ifl+okw9apEbjxD+4lJ7pkmOFgA3SmlQ8hW+PF1o2x7jUcS7Ppfj?=
 =?us-ascii?Q?XVtlIRmB3Q+6YAT+m3+jXJUijcMUGj5064Ws6vLefshZFHAGYtASRHVNiHMG?=
 =?us-ascii?Q?fb1DBqqsjBUM87B9WueitMRS9tZMq1AMxyte1f1OE/tUsyuy64PdBXQy+gtw?=
 =?us-ascii?Q?K4BC8aivcOUN+KmJS4C93uOycdO2AYtDxsQ8FjkNjIqc/wcw9no+KxcmF3XV?=
 =?us-ascii?Q?6WyJfRbxzLBPIZVezRYLurbM0agpXBCBJyDNE0ba3T0GsiAgtgsPIr/ZH+7x?=
 =?us-ascii?Q?N9n8Vmq7ndNRafbB6Ji5B+O/1W3evczjRBQGC8gS9LaLhiEBckBehL9NYss2?=
 =?us-ascii?Q?A82Hbe3To1w9j4ugVCLr0gFfCY0hDIVhyVAzc7BUYbh9mCh+A0+mClepqv8S?=
 =?us-ascii?Q?1AWyD4qNszxu61At3sWSaXfSHPgm7UfQUiy+CLqDFWd8H5r8VA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?35C9syKdldV/DHjXPydZZenVK8mw8hRf7lXuUcL8BA9KRWhPokcvYgVEL1WH?=
 =?us-ascii?Q?QXBDIfJinerZIfse8U+NDdgatoe6MQ0A///9J/hDwvtl7Bk525VukMM7tF0/?=
 =?us-ascii?Q?fqQvzRLrXOktQnH1EjAY8Ref8jo4xJwsmzYFqhaaezyE0JJf4DCVxylQMpof?=
 =?us-ascii?Q?6zFNSY75jdhDTk5jPqwsXq0hi481saRMqey8Ozd8CInxFJfdYLA0ZwjBBWU3?=
 =?us-ascii?Q?OJa8CZF7h8y+suLQIotM+GpAs8XjK/IYJHbogdzbUiLzkOKrdN/sAEyVLFSG?=
 =?us-ascii?Q?Gmy2q+1moCIRSLu9/W/hmqfu30fRG8rlr0WmBZ8G2ehCnxmSeofsoc+FqTMY?=
 =?us-ascii?Q?G+9bBWXFauCuGCYrel/t3QTEnM/Ocf4Gu3DBxkd0CbkpPdUud557YMklyaAP?=
 =?us-ascii?Q?I1NuVqjxoQQtco2VKhrcAvBDrj9iO9z/FRAawccWyuVMT/NGg7lUuEj+cSwT?=
 =?us-ascii?Q?OzBCyFUcTKW+WXaB0r9hAenuaO+2yexFO+htfhxXLj6gO4+SqoYuVBNWAZHl?=
 =?us-ascii?Q?8Qnz/JvfxYNbVaKBi+8e89coOiSWGofLnk6yip528arb2fkayWIZNVqiDVwP?=
 =?us-ascii?Q?Hiybq4n4OpAE81MJ5sFTe0iUWQVBgdBPznzqFXWAmpup3hh2CVFwGq715jCc?=
 =?us-ascii?Q?x3h57pSPaoCcgCnJYnaaz4J5MRN6XsHZ+r+hJvgn/O4PiL0cMq2r8kdziUv7?=
 =?us-ascii?Q?ZxfwOf9+r83IRDMK/eijP/1hOBdW8fLxBD+FXetiIzMcu6Xalui3ejea8I1R?=
 =?us-ascii?Q?hN4CaJK4vB6Avqe5WU0NvE1ZlCLC78wU4kCptHs+xSJyNsLck40U5ICfY1/q?=
 =?us-ascii?Q?Q8Vie9NJRAS6O/tsoTVdTj4/5wPsnKJM4WHxB0ZJIWgtSJMOciUOp9zSar1X?=
 =?us-ascii?Q?9epsKmTope5BNFR2EljJYuQOSfTTAgodHTtZ3S0v0Nb/vmeQoFcwhdge9bLC?=
 =?us-ascii?Q?ulbaEHeZ01ZuB+xnIxnwNrWwooTMMdMbughYpsp57ANTppKKyow96ASrxkIm?=
 =?us-ascii?Q?8mUYfz/Kr+09bZkaa+FWWrvYabxOau65Gof03htvt3UZniwc/LuAGsI4Rkjt?=
 =?us-ascii?Q?naS+uMTiBnIXBKxxGAp2TjvcylipQermEspsvwfRzGL3L0clOMgUuRiXSDxe?=
 =?us-ascii?Q?TusU1ZuRnHwCsjBX8PaUPYAPANqBmDuvYuoS7B1yKzkzfiEvcd2LAh8bW+kI?=
 =?us-ascii?Q?Ns5bCJ2RnSHqW9P9oH8ApsnEHB4cN9LdxS360HrrF/7AXOIS4KsvfTPiY2/L?=
 =?us-ascii?Q?v7j89lnNqTAFqop/QhrjPTZ2xn4wHKtBzsgYbKs74FcBUa+G3pV7jcOdyDQp?=
 =?us-ascii?Q?4UlYc1AtpmHCj+0Ziek3eKVusywK6qu5TBz3q7aCL79EswS6OnH7tBE/U9ie?=
 =?us-ascii?Q?YHfNn7rdgn5DJ3rexKUkWkpIWLtQ7nuXXzJABB8w+zonLIIML/T22OA+auxg?=
 =?us-ascii?Q?3MmNWvLDHebhne2xastjDOpdLXekSAtBTodlR94ioFkrmTR4AOJg15btqNq/?=
 =?us-ascii?Q?OK3NuCvauJE1ba6lI02Vg+wLqWbTWA+jlLg1+QXGAViEIjDe76CV2oSNvrZM?=
 =?us-ascii?Q?9P7D/EIZtdtSJwUHuXCfMbOwoS+JdTE0N7oVjNaSSPwJ4BRClWk6TdOeXMIV?=
 =?us-ascii?Q?L9px51zxYH9i8/9QYJ76SiDPofYgnm3fqHon5WIFQ1Xo?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85eb8080-3692-48df-c120-08dccdfa19e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 22:28:44.0464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qA3htBzPdjUBYGeed3mXYvp8lCoo6rYg4wBHbQQ3mICgIt1Yziuo+tlMvHbgbid0mUssQC6jwr7JQkJ04oivwYYisfuylxXrJYjykfKa7mnSsIGYTB9BdKxJl9vSDN/o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6501

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

